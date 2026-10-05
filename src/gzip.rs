//! gzip (RFC 1952) over DEFLATE (RFC 1951), written from scratch for gRPC
//! message compression (`grpc-encoding: gzip`, docs/grpc.md). Decoding is
//! complete (stored, fixed and dynamic Huffman blocks); encoding uses
//! fixed Huffman codes with a greedy LZ77 search over a hash of three
//! bytes, which is simple and still compresses repetitive messages well.
//! runtime/fwp_rt_grpc.c has the same algorithm in C.

/// The most bytes a message may decompress to (a guard against
/// decompression bombs).
pub const MAX_OUTPUT: usize = 64 << 20;

// ------------------------------------------------------------------ CRC-32

fn crc_table() -> &'static [u32; 256] {
    static T: std::sync::OnceLock<[u32; 256]> = std::sync::OnceLock::new();
    T.get_or_init(|| {
        let mut t = [0u32; 256];
        for (i, e) in t.iter_mut().enumerate() {
            let mut c = i as u32;
            for _ in 0..8 {
                c = if c & 1 != 0 {
                    0xedb8_8320 ^ (c >> 1)
                } else {
                    c >> 1
                };
            }
            *e = c;
        }
        t
    })
}

pub fn crc32(data: &[u8]) -> u32 {
    crc32_update(0, data)
}

/// The CRC of data that continues data whose CRC is `crc`.
pub fn crc32_update(crc: u32, data: &[u8]) -> u32 {
    let t = crc_table();
    let mut c = !crc;
    for &b in data {
        c = t[((c ^ b as u32) & 0xff) as usize] ^ (c >> 8);
    }
    !c
}

// ------------------------------------------------------------------ tables

const LEN_BASE: [u16; 29] = [
    3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131,
    163, 195, 227, 258,
];
const LEN_EXTRA: [u8; 29] = [
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0,
];
const DIST_BASE: [u16; 30] = [
    1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537,
    2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577,
];
const DIST_EXTRA: [u8; 30] = [
    0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13,
    13,
];
const CL_ORDER: [usize; 19] = [
    16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15,
];

// ---------------------------------------------------------------- inflate

struct Bits<'a> {
    d: &'a [u8],
    pos: usize,
    bit: u32,
    nbits: u32,
}

impl Bits<'_> {
    fn need(&mut self, n: u32) -> Result<(), String> {
        while self.nbits < n {
            let b = *self.d.get(self.pos).ok_or("truncated compressed data")?;
            self.pos += 1;
            self.bit |= (b as u32) << self.nbits;
            self.nbits += 8;
        }
        Ok(())
    }

    fn bits(&mut self, n: u32) -> Result<u32, String> {
        if n == 0 {
            return Ok(0);
        }
        self.need(n)?;
        let v = self.bit & ((1u32 << n) - 1);
        self.bit >>= n;
        self.nbits -= n;
        Ok(v)
    }
}

/// A canonical Huffman code: the count of codes of each length, and the
/// symbols in code order.
struct Huff {
    count: [u16; 16],
    symbol: Vec<u16>,
}

impl Huff {
    fn new(lengths: &[u8]) -> Result<Huff, String> {
        let mut count = [0u16; 16];
        for &l in lengths {
            count[l as usize] += 1;
        }
        count[0] = 0;
        let mut left: i32 = 1;
        for &c in &count[1..] {
            left = left * 2 - c as i32;
            if left < 0 {
                return Err("bad Huffman code".into());
            }
        }
        let mut offs = [0u16; 16];
        for i in 1..15 {
            offs[i + 1] = offs[i] + count[i];
        }
        let mut symbol = vec![0u16; lengths.len()];
        for (s, &l) in lengths.iter().enumerate() {
            if l != 0 {
                symbol[offs[l as usize] as usize] = s as u16;
                offs[l as usize] += 1;
            }
        }
        Ok(Huff { count, symbol })
    }

    fn decode(&self, b: &mut Bits) -> Result<u16, String> {
        let (mut code, mut first, mut index) = (0i32, 0i32, 0i32);
        for len in 1..16 {
            code |= b.bits(1)? as i32;
            let count = self.count[len] as i32;
            if code - count < first {
                return Ok(self.symbol[(index + (code - first)) as usize]);
            }
            index += count;
            first += count;
            first <<= 1;
            code <<= 1;
        }
        Err("bad Huffman code".into())
    }
}

fn fixed() -> (Huff, Huff) {
    let mut l = [0u8; 288];
    for (i, x) in l.iter_mut().enumerate() {
        *x = match i {
            0..=143 => 8,
            144..=255 => 9,
            256..=279 => 7,
            _ => 8,
        };
    }
    (Huff::new(&l).unwrap(), Huff::new(&[5u8; 30]).unwrap())
}

fn codes(
    b: &mut Bits,
    out: &mut Vec<u8>,
    lit: &Huff,
    dist: &Huff,
    max: usize,
) -> Result<(), String> {
    loop {
        let sym = lit.decode(b)?;
        match sym {
            0..=255 => {
                if out.len() >= max {
                    return Err("decompressed message too large".into());
                }
                out.push(sym as u8);
            }
            256 => return Ok(()),
            257..=285 => {
                let i = (sym - 257) as usize;
                let len = LEN_BASE[i] as usize + b.bits(LEN_EXTRA[i] as u32)? as usize;
                let d = dist.decode(b)? as usize;
                if d >= 30 {
                    return Err("bad distance".into());
                }
                let dist = DIST_BASE[d] as usize + b.bits(DIST_EXTRA[d] as u32)? as usize;
                if dist > out.len() {
                    return Err("distance too far back".into());
                }
                if out.len() + len > max {
                    return Err("decompressed message too large".into());
                }
                let start = out.len() - dist;
                for k in 0..len {
                    out.push(out[start + k]);
                }
            }
            _ => return Err("bad length code".into()),
        }
    }
}

/// Decompress raw DEFLATE data; also returns how many bytes it took.
pub fn inflate(data: &[u8], max: usize) -> Result<(Vec<u8>, usize), String> {
    let mut b = Bits {
        d: data,
        pos: 0,
        bit: 0,
        nbits: 0,
    };
    let mut out = Vec::new();
    loop {
        let last = b.bits(1)?;
        match b.bits(2)? {
            0 => {
                // stored: from the next byte
                b.bit = 0;
                b.nbits = 0;
                let p = b.pos;
                if p + 4 > data.len() {
                    return Err("truncated compressed data".into());
                }
                let len = u16::from_le_bytes([data[p], data[p + 1]]) as usize;
                let nlen = u16::from_le_bytes([data[p + 2], data[p + 3]]) as usize;
                if len != !nlen & 0xffff {
                    return Err("bad stored block".into());
                }
                if p + 4 + len > data.len() {
                    return Err("truncated compressed data".into());
                }
                if out.len() + len > max {
                    return Err("decompressed message too large".into());
                }
                out.extend_from_slice(&data[p + 4..p + 4 + len]);
                b.pos = p + 4 + len;
            }
            1 => {
                let (l, d) = fixed();
                codes(&mut b, &mut out, &l, &d, max)?;
            }
            2 => {
                let nlen = b.bits(5)? as usize + 257;
                let ndist = b.bits(5)? as usize + 1;
                let ncode = b.bits(4)? as usize + 4;
                if nlen > 286 || ndist > 30 {
                    return Err("bad block header".into());
                }
                let mut cl = [0u8; 19];
                for &i in &CL_ORDER[..ncode] {
                    cl[i] = b.bits(3)? as u8;
                }
                let clh = Huff::new(&cl)?;
                let mut lengths = vec![0u8; nlen + ndist];
                let mut i = 0;
                while i < nlen + ndist {
                    let sym = clh.decode(&mut b)?;
                    let (val, rep) = match sym {
                        0..=15 => (sym as u8, 1),
                        16 => {
                            if i == 0 {
                                return Err("bad code lengths".into());
                            }
                            (lengths[i - 1], 3 + b.bits(2)? as usize)
                        }
                        17 => (0, 3 + b.bits(3)? as usize),
                        _ => (0, 11 + b.bits(7)? as usize),
                    };
                    if i + rep > nlen + ndist {
                        return Err("bad code lengths".into());
                    }
                    for _ in 0..rep {
                        lengths[i] = val;
                        i += 1;
                    }
                }
                if lengths[256] == 0 {
                    return Err("no end-of-block code".into());
                }
                let l = Huff::new(&lengths[..nlen])?;
                let d = Huff::new(&lengths[nlen..])?;
                codes(&mut b, &mut out, &l, &d, max)?;
            }
            _ => return Err("bad block type".into()),
        }
        if last == 1 {
            return Ok((out, b.pos));
        }
    }
}

/// Decompress gzip data (one member), checking its CRC and length.
pub fn gunzip(data: &[u8], max: usize) -> Result<Vec<u8>, String> {
    if data.len() < 18 || data[0] != 0x1f || data[1] != 0x8b || data[2] != 8 {
        return Err("not gzip data".into());
    }
    let flags = data[3];
    let mut p = 10;
    let at = |p: usize| data.get(p).copied().ok_or("truncated gzip header");
    if flags & 4 != 0 {
        let n = at(p)? as usize | (at(p + 1)? as usize) << 8;
        p += 2 + n;
    }
    for f in [8u8, 16] {
        if flags & f != 0 {
            while at(p)? != 0 {
                p += 1;
            }
            p += 1;
        }
    }
    if flags & 2 != 0 {
        p += 2;
    }
    if p > data.len() {
        return Err("truncated gzip header".into());
    }
    let (out, n) = inflate(&data[p..], max)?;
    let t = p + n;
    if t + 8 > data.len() {
        return Err("truncated gzip data".into());
    }
    let crc = u32::from_le_bytes([data[t], data[t + 1], data[t + 2], data[t + 3]]);
    let size = u32::from_le_bytes([data[t + 4], data[t + 5], data[t + 6], data[t + 7]]);
    if crc != crc32(&out) || size != out.len() as u32 {
        return Err("gzip checksum mismatch".into());
    }
    Ok(out)
}

// ---------------------------------------------------------------- deflate

struct Out {
    d: Vec<u8>,
    bit: u32,
    nbits: u32,
}

impl Out {
    fn put(&mut self, v: u32, n: u32) {
        self.bit |= v << self.nbits;
        self.nbits += n;
        while self.nbits >= 8 {
            self.d.push(self.bit as u8);
            self.bit >>= 8;
            self.nbits -= 8;
        }
    }

    /// A Huffman code, most significant bit first.
    fn code(&mut self, code: u32, len: u32) {
        let mut r = 0;
        for i in 0..len {
            r |= ((code >> i) & 1) << (len - 1 - i);
        }
        self.put(r, len);
    }

    fn lit(&mut self, s: u32) {
        match s {
            0..=143 => self.code(0x30 + s, 8),
            144..=255 => self.code(0x190 + s - 144, 9),
            256..=279 => self.code(s - 256, 7),
            _ => self.code(0xc0 + s - 280, 8),
        }
    }
}

/// Compress with one fixed-Huffman block (raw DEFLATE).
pub fn deflate(data: &[u8]) -> Vec<u8> {
    let mut o = Out {
        d: Vec::with_capacity(data.len() / 2 + 16),
        bit: 0,
        nbits: 0,
    };
    o.put(1, 1); // the last block
    block(&mut o, data);
    if o.nbits > 0 {
        o.d.push(o.bit as u8);
    }
    o.d
}

/// One chunk of a gzip stream: a fixed-Huffman block that is not the
/// last, then an empty stored block, which ends on a byte (a sync flush:
/// the receiver can decode everything so far). Chunks follow
/// [`GZIP_HEADER`] and end with [`gzip_end`].
pub fn gzip_chunk(data: &[u8]) -> Vec<u8> {
    let mut o = Out {
        d: Vec::with_capacity(data.len() / 2 + 16),
        bit: 0,
        nbits: 0,
    };
    o.put(0, 1);
    block(&mut o, data);
    o.put(0, 3); // a stored block, not the last
    if o.nbits > 0 {
        o.d.push(o.bit as u8);
    }
    o.d.extend_from_slice(&[0, 0, 0xff, 0xff]);
    o.d
}

/// A gzip header: no name, no time, an unknown system.
pub const GZIP_HEADER: [u8; 10] = [0x1f, 0x8b, 8, 0, 0, 0, 0, 0, 0, 255];

/// The end of a gzip stream of chunks: an empty last block, then the CRC
/// and length of all the data.
pub fn gzip_end(crc: u32, len: u64) -> Vec<u8> {
    let mut out = vec![0x03, 0x00];
    out.extend_from_slice(&crc.to_le_bytes());
    out.extend_from_slice(&(len as u32).to_le_bytes());
    out
}

/// The rest of a fixed-Huffman block after its first bit: its type, the
/// data (a greedy LZ77 search within the block) and the end of block.
fn block(o: &mut Out, data: &[u8]) {
    const WINDOW: usize = 32768;
    const HASH: usize = 1 << 15;
    o.put(1, 2); // fixed Huffman codes
    let mut head = vec![usize::MAX; HASH];
    let hash = |i: usize| -> usize {
        ((data[i] as usize) << 10 ^ (data[i + 1] as usize) << 5 ^ data[i + 2] as usize) & (HASH - 1)
    };
    let mut i = 0;
    while i < data.len() {
        let mut len = 0;
        let mut dist = 0;
        if i + 3 <= data.len() {
            let h = hash(i);
            let cand = head[h];
            head[h] = i;
            if cand != usize::MAX && i - cand <= WINDOW {
                let max = (data.len() - i).min(258);
                let mut l = 0;
                while l < max && data[cand + l] == data[i + l] {
                    l += 1;
                }
                if l >= 3 {
                    len = l;
                    dist = i - cand;
                }
            }
        }
        if len == 0 {
            o.lit(data[i] as u32);
            i += 1;
            continue;
        }
        let li = LEN_BASE.iter().rposition(|&b| b as usize <= len).unwrap();
        o.lit(257 + li as u32);
        o.put((len - LEN_BASE[li] as usize) as u32, LEN_EXTRA[li] as u32);
        let di = DIST_BASE.iter().rposition(|&b| b as usize <= dist).unwrap();
        o.code(di as u32, 5);
        o.put(
            (dist - DIST_BASE[di] as usize) as u32,
            DIST_EXTRA[di] as u32,
        );
        // the positions inside the match are hashed too
        for k in i + 1..(i + len).min(data.len().saturating_sub(2)) {
            head[hash(k)] = k;
        }
        i += len;
    }
    o.lit(256);
}

/// gzip data: a minimal header, the DEFLATE data, the CRC and the length.
pub fn gzip(data: &[u8]) -> Vec<u8> {
    let mut out = GZIP_HEADER.to_vec();
    out.extend(deflate(data));
    out.extend_from_slice(&crc32(data).to_le_bytes());
    out.extend_from_slice(&(data.len() as u32).to_le_bytes());
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    fn samples() -> Vec<Vec<u8>> {
        let mut v = vec![
            vec![],
            b"a".to_vec(),
            b"hello, hello, hello, hello!".to_vec(),
            (0..5000u32).map(|i| (i % 7) as u8).collect(),
            (0..70000u32)
                .map(|i| (i.wrapping_mul(2654435761) >> 13) as u8)
                .collect(),
        ];
        v.push(b"abc".repeat(40000));
        v
    }

    #[test]
    fn round_trip() {
        for s in samples() {
            let z = gzip(&s);
            assert_eq!(gunzip(&z, MAX_OUTPUT).unwrap(), s);
        }
        assert!(gzip(&b"abc".repeat(10000)).len() < 1000);
    }

    #[test]
    fn chunks_make_one_stream() {
        let chunks: Vec<&[u8]> = vec![b"hello, ", b"", b"hello, hello", &[7; 3000], b"!"];
        let mut z = GZIP_HEADER.to_vec();
        let (mut crc, mut len) = (0, 0);
        for c in &chunks {
            let part = gzip_chunk(c);
            // each chunk ends with a sync flush
            assert!(part.ends_with(&[0, 0, 0xff, 0xff]));
            z.extend(part);
            crc = crc32_update(crc, c);
            len += c.len() as u64;
        }
        z.extend(gzip_end(crc, len));
        assert_eq!(gunzip(&z, MAX_OUTPUT).unwrap(), chunks.concat());
    }

    #[test]
    fn reads_other_encoders() {
        // Python's `gzip.compress(data, 9, mtime=0)`: dynamic Huffman codes
        let z: [u8; 179] = [
            0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x03, 0x9d, 0xd5, 0x5b, 0x16,
            0xc1, 0x50, 0x0c, 0x46, 0xe1, 0x77, 0xa3, 0xc8, 0x10, 0xe4, 0x0f, 0x2d, 0x66, 0xe3,
            0x72, 0x68, 0x39, 0x7a, 0x68, 0xd5, 0x6d, 0xf4, 0x16, 0x33, 0xb0, 0x9f, 0xb3, 0xf6,
            0x53, 0xbe, 0x95, 0xe4, 0xb6, 0x4b, 0x36, 0x5d, 0xd9, 0xad, 0x49, 0x76, 0x1d, 0xdb,
            0xed, 0xc9, 0x36, 0x7d, 0x79, 0x74, 0xb6, 0x2f, 0x4f, 0x3b, 0x8e, 0xe7, 0xcb, 0x60,
            0xe5, 0x9e, 0xfa, 0xdf, 0x38, 0xaf, 0xdf, 0x2f, 0xdb, 0x95, 0xc3, 0x24, 0x7f, 0x1b,
            0x07, 0x8d, 0x40, 0x13, 0xa0, 0x99, 0x81, 0x66, 0x0e, 0x9a, 0x0a, 0x34, 0x35, 0x68,
            0x16, 0xa0, 0x59, 0x92, 0x9d, 0x22, 0x08, 0x44, 0x82, 0x13, 0x0a, 0x4e, 0x2c, 0x38,
            0xc1, 0xe0, 0x44, 0x83, 0x13, 0x0e, 0x4e, 0x3c, 0x38, 0x01, 0xe1, 0x44, 0x84, 0x88,
            0x08, 0xa1, 0xdb, 0x40, 0x44, 0x88, 0x88, 0x10, 0x11, 0x21, 0x22, 0x42, 0x44, 0x84,
            0x88, 0x08, 0x11, 0x11, 0x22, 0x22, 0x82, 0x88, 0x08, 0x22, 0x22, 0xd0, 0xbb, 0x20,
            0x22, 0x82, 0x88, 0x08, 0x22, 0x22, 0x88, 0x88, 0x20, 0x22, 0x82, 0x88, 0x88, 0x3f,
            0x45, 0x7c, 0x00, 0x64, 0x58, 0x7b, 0x18, 0x3e, 0x08, 0x00, 0x00,
        ];
        let data: Vec<u8> = (0..40)
            .flat_map(|i| {
                format!("line {}: the quick brown fox jumps over the lazy dog\n", i).into_bytes()
            })
            .collect();
        assert_eq!(gunzip(&z, MAX_OUTPUT).unwrap(), data);
        // stored blocks
        let mut stored = vec![0x1f, 0x8b, 8, 0, 0, 0, 0, 0, 0, 255, 1, 3, 0, 0xfc, 0xff];
        stored.extend_from_slice(b"abc");
        stored.extend_from_slice(&crc32(b"abc").to_le_bytes());
        stored.extend_from_slice(&3u32.to_le_bytes());
        assert_eq!(gunzip(&stored, MAX_OUTPUT).unwrap(), b"abc");
    }

    #[test]
    fn rejects_bad_data() {
        let mut z = gzip(b"hello, world");
        let n = z.len();
        z[n - 5] ^= 1;
        assert!(gunzip(&z, MAX_OUTPUT).is_err());
        assert!(gunzip(&gzip(&[0u8; 1000]), 100).is_err());
        assert!(gunzip(b"nonsense, not gzip at all", MAX_OUTPUT).is_err());
    }

    /// Another gzip reader (Python's, when it is installed) reads ours.
    #[test]
    fn others_read_ours() {
        use std::io::Write;
        for s in samples() {
            let Ok(mut p) = std::process::Command::new("python3")
                .args(["-c", "import gzip, sys; sys.stdout.buffer.write(gzip.decompress(sys.stdin.buffer.read()))"])
                .stdin(std::process::Stdio::piped())
                .stdout(std::process::Stdio::piped())
                .spawn()
            else {
                return;
            };
            p.stdin.take().unwrap().write_all(&gzip(&s)).unwrap();
            let o = p.wait_with_output().unwrap();
            assert!(o.status.success());
            assert_eq!(o.stdout, s);
        }
    }

    #[test]
    fn crc() {
        assert_eq!(crc32(b"123456789"), 0xcbf4_3926);
    }
}
