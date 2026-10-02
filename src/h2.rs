//! gRPC over HTTP/2 cleartext ("h2c" with prior knowledge), written from
//! scratch: HPACK (RFC 7541), HTTP/2 framing and flow control (RFC 9113),
//! and gRPC unary calls (length-prefixed messages, `grpc-status` and
//! `grpc-message` trailers). The interpreter uses this module; the C
//! runtime has the same implementation in `runtime/fwp_rt_h2.c`.
//!
//! The client sends one call at a time on a pooled connection per address.
//! The server multiplexes any number of connections and streams on one
//! thread: requests on all streams are read as they arrive, each call runs
//! when its request is complete, and responses are sent within the
//! peer's flow-control windows.

use std::collections::{BTreeMap, HashMap, VecDeque};
use std::io::{Read, Write};
use std::net::{TcpListener, TcpStream};
use std::sync::Mutex;

// ======================================================================= HPACK

pub mod hpack {
    use super::*;

    pub const STATIC: [(&str, &str); 61] = [
        (":authority", ""),
        (":method", "GET"),
        (":method", "POST"),
        (":path", "/"),
        (":path", "/index.html"),
        (":scheme", "http"),
        (":scheme", "https"),
        (":status", "200"),
        (":status", "204"),
        (":status", "206"),
        (":status", "304"),
        (":status", "400"),
        (":status", "404"),
        (":status", "500"),
        ("accept-charset", ""),
        ("accept-encoding", "gzip, deflate"),
        ("accept-language", ""),
        ("accept-ranges", ""),
        ("accept", ""),
        ("access-control-allow-origin", ""),
        ("age", ""),
        ("allow", ""),
        ("authorization", ""),
        ("cache-control", ""),
        ("content-disposition", ""),
        ("content-encoding", ""),
        ("content-language", ""),
        ("content-length", ""),
        ("content-location", ""),
        ("content-range", ""),
        ("content-type", ""),
        ("cookie", ""),
        ("date", ""),
        ("etag", ""),
        ("expect", ""),
        ("expires", ""),
        ("from", ""),
        ("host", ""),
        ("if-match", ""),
        ("if-modified-since", ""),
        ("if-none-match", ""),
        ("if-range", ""),
        ("if-unmodified-since", ""),
        ("last-modified", ""),
        ("link", ""),
        ("location", ""),
        ("max-forwards", ""),
        ("proxy-authenticate", ""),
        ("proxy-authorization", ""),
        ("range", ""),
        ("referer", ""),
        ("refresh", ""),
        ("retry-after", ""),
        ("server", ""),
        ("set-cookie", ""),
        ("strict-transport-security", ""),
        ("transfer-encoding", ""),
        ("user-agent", ""),
        ("vary", ""),
        ("via", ""),
        ("www-authenticate", ""),
    ];

    /// A header list decoder with its dynamic table.
    pub struct Decoder {
        /// Entries as raw bytes, newest first (sizes count bytes).
        table: VecDeque<(Vec<u8>, Vec<u8>)>,
        size: usize,
        max: usize,
        /// The largest table size the peer may choose (our
        /// SETTINGS_HEADER_TABLE_SIZE).
        limit: usize,
    }

    impl Default for Decoder {
        fn default() -> Self {
            Decoder::new(4096)
        }
    }

    fn entry_size(e: &(Vec<u8>, Vec<u8>)) -> usize {
        e.0.len() + e.1.len() + 32
    }

    fn text(b: &[u8]) -> String {
        String::from_utf8_lossy(b).into_owned()
    }

    impl Decoder {
        pub fn new(limit: usize) -> Self {
            Decoder {
                table: VecDeque::new(),
                size: 0,
                max: limit,
                limit,
            }
        }

        /// The dynamic table, newest entry first, and its size.
        pub fn dynamic(&self) -> (Vec<(String, String)>, usize) {
            let t = self.table.iter().map(|(n, v)| (text(n), text(v)));
            (t.collect(), self.size)
        }

        fn evict(&mut self) {
            while self.size > self.max {
                let e = self.table.pop_back().unwrap();
                self.size -= entry_size(&e);
            }
        }

        fn insert(&mut self, e: (Vec<u8>, Vec<u8>)) {
            self.size += entry_size(&e);
            self.table.push_front(e);
            self.evict();
        }

        fn get(&self, i: u64) -> Result<(Vec<u8>, Vec<u8>), String> {
            let i = i as usize;
            if i == 0 {
                return Err("hpack: index 0".into());
            }
            if i <= STATIC.len() {
                let (n, v) = STATIC[i - 1];
                return Ok((n.as_bytes().to_vec(), v.as_bytes().to_vec()));
            }
            self.table
                .get(i - STATIC.len() - 1)
                .cloned()
                .ok_or_else(|| format!("hpack: index {} out of range", i))
        }

        /// Decode a complete header block.
        pub fn decode(&mut self, block: &[u8]) -> Result<Vec<(String, String)>, String> {
            let mut r = Cursor { b: block, i: 0 };
            let mut out = Vec::new();
            while r.i < block.len() {
                let b = block[r.i];
                if b & 0x80 != 0 {
                    let i = r.int(7)?;
                    let (n, v) = self.get(i)?;
                    out.push((text(&n), text(&v)));
                } else if b & 0x40 != 0 {
                    let i = r.int(6)?;
                    let name = if i == 0 { r.string()? } else { self.get(i)?.0 };
                    let value = r.string()?;
                    out.push((text(&name), text(&value)));
                    self.insert((name, value));
                } else if b & 0x20 != 0 {
                    let n = r.int(5)? as usize;
                    if n > self.limit {
                        return Err("hpack: table size update above the limit".into());
                    }
                    self.max = n;
                    self.evict();
                } else {
                    // literal without indexing (0000) or never indexed (0001)
                    let i = r.int(4)?;
                    let name = if i == 0 { r.string()? } else { self.get(i)?.0 };
                    let value = r.string()?;
                    out.push((text(&name), text(&value)));
                }
            }
            Ok(out)
        }
    }

    struct Cursor<'a> {
        b: &'a [u8],
        i: usize,
    }

    impl Cursor<'_> {
        fn int(&mut self, prefix: u32) -> Result<u64, String> {
            let mask = (1u64 << prefix) - 1;
            let Some(&first) = self.b.get(self.i) else {
                return Err("hpack: truncated".into());
            };
            self.i += 1;
            let mut x = first as u64 & mask;
            if x < mask {
                return Ok(x);
            }
            let mut shift = 0;
            loop {
                let Some(&b) = self.b.get(self.i) else {
                    return Err("hpack: truncated integer".into());
                };
                self.i += 1;
                if shift > 56 {
                    return Err("hpack: integer overflow".into());
                }
                x += ((b & 0x7f) as u64) << shift;
                shift += 7;
                if b & 0x80 == 0 {
                    return Ok(x);
                }
            }
        }

        fn string(&mut self) -> Result<Vec<u8>, String> {
            let Some(&first) = self.b.get(self.i) else {
                return Err("hpack: truncated".into());
            };
            let huff = first & 0x80 != 0;
            let n = self.int(7)? as usize;
            if self.i + n > self.b.len() {
                return Err("hpack: truncated string".into());
            }
            let raw = &self.b[self.i..self.i + n];
            self.i += n;
            if huff {
                huffman_decode(raw)
            } else {
                Ok(raw.to_vec())
            }
        }
    }

    /// Append an HPACK integer with an `n`-bit prefix; `flags` fills the
    /// high bits of the first byte.
    pub fn put_int(out: &mut Vec<u8>, flags: u8, prefix: u32, mut x: u64) {
        let max = (1u64 << prefix) - 1;
        if x < max {
            out.push(flags | x as u8);
            return;
        }
        out.push(flags | max as u8);
        x -= max;
        while x >= 128 {
            out.push((x % 128) as u8 | 0x80);
            x /= 128;
        }
        out.push(x as u8);
    }

    /// Encode a header list as literals without indexing (new names, no
    /// Huffman coding): valid for every decoder and keeps no state.
    pub fn encode(headers: &[(&str, &str)]) -> Vec<u8> {
        let mut out = Vec::new();
        for (n, v) in headers {
            out.push(0);
            put_int(&mut out, 0, 7, n.len() as u64);
            out.extend_from_slice(n.as_bytes());
            put_int(&mut out, 0, 7, v.len() as u64);
            out.extend_from_slice(v.as_bytes());
        }
        out
    }

    /// The Huffman decoding tree: internal nodes hold child indices,
    /// leaves `-(symbol + 1)`.
    fn tree() -> &'static Vec<[i32; 2]> {
        static TREE: std::sync::OnceLock<Vec<[i32; 2]>> = std::sync::OnceLock::new();
        TREE.get_or_init(|| {
            let mut t: Vec<[i32; 2]> = vec![[0, 0]];
            let mut add = |code: u32, len: u8, sym: i32| {
                let mut n = 0usize;
                for k in (0..len).rev() {
                    let bit = ((code >> k) & 1) as usize;
                    if k == 0 {
                        t[n][bit] = -(sym + 1);
                    } else {
                        if t[n][bit] == 0 {
                            t.push([0, 0]);
                            let id = (t.len() - 1) as i32;
                            t[n][bit] = id;
                        }
                        n = t[n][bit] as usize;
                    }
                }
            };
            for s in 0..256 {
                add(HUFFMAN_CODES[s], HUFFMAN_LENS[s], s as i32);
            }
            add(0x3fffffff, 30, 256);
            t
        })
    }

    pub fn huffman_decode(b: &[u8]) -> Result<Vec<u8>, String> {
        let t = tree();
        let mut out = Vec::new();
        let mut n = 0usize;
        let mut pending = 0; // bits since the last symbol
        let mut ones = true;
        for byte in b {
            for k in (0..8).rev() {
                let bit = ((byte >> k) & 1) as usize;
                pending += 1;
                ones &= bit == 1;
                let next = t[n][bit];
                if next < 0 {
                    let sym = -next - 1;
                    if sym == 256 {
                        return Err("hpack: EOS in Huffman string".into());
                    }
                    out.push(sym as u8);
                    n = 0;
                    pending = 0;
                    ones = true;
                } else if next == 0 {
                    return Err("hpack: bad Huffman code".into());
                } else {
                    n = next as usize;
                }
            }
        }
        if pending > 7 || !ones {
            return Err("hpack: bad Huffman padding".into());
        }
        Ok(out)
    }

    // RFC 7541 Appendix B (EOS, 0x3fffffff in 30 bits, is added above)
    pub const HUFFMAN_CODES: [u32; 256] = [
        0x1ff8, 0x7fffd8, 0xfffffe2, 0xfffffe3, 0xfffffe4, 0xfffffe5, 0xfffffe6, 0xfffffe7,
        0xfffffe8, 0xffffea, 0x3ffffffc, 0xfffffe9, 0xfffffea, 0x3ffffffd, 0xfffffeb, 0xfffffec,
        0xfffffed, 0xfffffee, 0xfffffef, 0xffffff0, 0xffffff1, 0xffffff2, 0x3ffffffe, 0xffffff3,
        0xffffff4, 0xffffff5, 0xffffff6, 0xffffff7, 0xffffff8, 0xffffff9, 0xffffffa, 0xffffffb,
        0x14, 0x3f8, 0x3f9, 0xffa, 0x1ff9, 0x15, 0xf8, 0x7fa, 0x3fa, 0x3fb, 0xf9, 0x7fb, 0xfa,
        0x16, 0x17, 0x18, 0x0, 0x1, 0x2, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x5c, 0xfb,
        0x7ffc, 0x20, 0xffb, 0x3fc, 0x1ffa, 0x21, 0x5d, 0x5e, 0x5f, 0x60, 0x61, 0x62, 0x63, 0x64,
        0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72, 0xfc,
        0x73, 0xfd, 0x1ffb, 0x7fff0, 0x1ffc, 0x3ffc, 0x22, 0x7ffd, 0x3, 0x23, 0x4, 0x24, 0x5, 0x25,
        0x26, 0x27, 0x6, 0x74, 0x75, 0x28, 0x29, 0x2a, 0x7, 0x2b, 0x76, 0x2c, 0x8, 0x9, 0x2d, 0x77,
        0x78, 0x79, 0x7a, 0x7b, 0x7ffe, 0x7fc, 0x3ffd, 0x1ffd, 0xffffffc, 0xfffe6, 0x3fffd2,
        0xfffe7, 0xfffe8, 0x3fffd3, 0x3fffd4, 0x3fffd5, 0x7fffd9, 0x3fffd6, 0x7fffda, 0x7fffdb,
        0x7fffdc, 0x7fffdd, 0x7fffde, 0xffffeb, 0x7fffdf, 0xffffec, 0xffffed, 0x3fffd7, 0x7fffe0,
        0xffffee, 0x7fffe1, 0x7fffe2, 0x7fffe3, 0x7fffe4, 0x1fffdc, 0x3fffd8, 0x7fffe5, 0x3fffd9,
        0x7fffe6, 0x7fffe7, 0xffffef, 0x3fffda, 0x1fffdd, 0xfffe9, 0x3fffdb, 0x3fffdc, 0x7fffe8,
        0x7fffe9, 0x1fffde, 0x7fffea, 0x3fffdd, 0x3fffde, 0xfffff0, 0x1fffdf, 0x3fffdf, 0x7fffeb,
        0x7fffec, 0x1fffe0, 0x1fffe1, 0x3fffe0, 0x1fffe2, 0x7fffed, 0x3fffe1, 0x7fffee, 0x7fffef,
        0xfffea, 0x3fffe2, 0x3fffe3, 0x3fffe4, 0x7ffff0, 0x3fffe5, 0x3fffe6, 0x7ffff1, 0x3ffffe0,
        0x3ffffe1, 0xfffeb, 0x7fff1, 0x3fffe7, 0x7ffff2, 0x3fffe8, 0x1ffffec, 0x3ffffe2, 0x3ffffe3,
        0x3ffffe4, 0x7ffffde, 0x7ffffdf, 0x3ffffe5, 0xfffff1, 0x1ffffed, 0x7fff2, 0x1fffe3,
        0x3ffffe6, 0x7ffffe0, 0x7ffffe1, 0x3ffffe7, 0x7ffffe2, 0xfffff2, 0x1fffe4, 0x1fffe5,
        0x3ffffe8, 0x3ffffe9, 0xffffffd, 0x7ffffe3, 0x7ffffe4, 0x7ffffe5, 0xfffec, 0xfffff3,
        0xfffed, 0x1fffe6, 0x3fffe9, 0x1fffe7, 0x1fffe8, 0x7ffff3, 0x3fffea, 0x3fffeb, 0x1ffffee,
        0x1ffffef, 0xfffff4, 0xfffff5, 0x3ffffea, 0x7ffff4, 0x3ffffeb, 0x7ffffe6, 0x3ffffec,
        0x3ffffed, 0x7ffffe7, 0x7ffffe8, 0x7ffffe9, 0x7ffffea, 0x7ffffeb, 0xffffffe, 0x7ffffec,
        0x7ffffed, 0x7ffffee, 0x7ffffef, 0x7fffff0, 0x3ffffee,
    ];

    pub const HUFFMAN_LENS: [u8; 256] = [
        13, 23, 28, 28, 28, 28, 28, 28, 28, 24, 30, 28, 28, 30, 28, 28, 28, 28, 28, 28, 28, 28, 30,
        28, 28, 28, 28, 28, 28, 28, 28, 28, 6, 10, 10, 12, 13, 6, 8, 11, 10, 10, 8, 11, 8, 6, 6, 6,
        5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 7, 8, 15, 6, 12, 10, 13, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
        7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 7, 8, 13, 19, 13, 14, 6, 15, 5, 6, 5, 6, 5, 6, 6, 6, 5,
        7, 7, 6, 6, 6, 5, 6, 7, 6, 5, 5, 6, 7, 7, 7, 7, 7, 15, 11, 14, 13, 28, 20, 22, 20, 20, 22,
        22, 22, 23, 22, 23, 23, 23, 23, 23, 24, 23, 24, 24, 22, 23, 24, 23, 23, 23, 23, 21, 22, 23,
        22, 23, 23, 24, 22, 21, 20, 22, 22, 23, 23, 21, 23, 22, 22, 24, 21, 22, 23, 23, 21, 21, 22,
        21, 23, 22, 23, 23, 20, 22, 22, 22, 23, 22, 22, 23, 26, 26, 20, 19, 22, 23, 22, 25, 26, 26,
        26, 27, 27, 26, 24, 25, 19, 21, 26, 27, 27, 26, 27, 24, 21, 21, 26, 26, 28, 27, 27, 27, 20,
        24, 20, 21, 22, 21, 21, 23, 22, 22, 25, 25, 24, 24, 26, 23, 26, 27, 26, 26, 27, 27, 27, 27,
        27, 28, 27, 27, 27, 27, 27, 26,
    ];
}

// ===================================================================== framing

pub const DATA: u8 = 0;
pub const HEADERS: u8 = 1;
pub const RST_STREAM: u8 = 3;
pub const SETTINGS: u8 = 4;
pub const PING: u8 = 6;
pub const GOAWAY: u8 = 7;
pub const WINDOW_UPDATE: u8 = 8;
pub const CONTINUATION: u8 = 9;

pub const END_STREAM: u8 = 0x1;
pub const ACK: u8 = 0x1;
pub const END_HEADERS: u8 = 0x4;
pub const PADDED: u8 = 0x8;
pub const PRIORITY: u8 = 0x20;

pub const PREFACE: &[u8] = b"PRI * HTTP/2.0\r\n\r\nSM\r\n\r\n";

/// The stream window we advertise (SETTINGS_INITIAL_WINDOW_SIZE), and the
/// connection window we raise to.
const OUR_WINDOW: u32 = 1 << 30;
/// The largest frame we accept.
const MAX_FRAME: usize = 1 << 24;

pub fn frame(ty: u8, flags: u8, stream: u32, payload: &[u8]) -> Vec<u8> {
    let n = payload.len();
    let mut out = vec![
        (n >> 16) as u8,
        (n >> 8) as u8,
        n as u8,
        ty,
        flags,
        (stream >> 24) as u8 & 0x7f,
        (stream >> 16) as u8,
        (stream >> 8) as u8,
        stream as u8,
    ];
    out.extend_from_slice(payload);
    out
}

#[derive(Debug)]
pub struct Frame {
    pub ty: u8,
    pub flags: u8,
    pub stream: u32,
    pub payload: Vec<u8>,
}

/// Parse a frame from the start of `buf`: the frame and its length, or
/// `None` when more bytes are needed.
pub fn parse_frame(buf: &[u8]) -> Result<Option<(Frame, usize)>, String> {
    if buf.len() < 9 {
        return Ok(None);
    }
    let n = (buf[0] as usize) << 16 | (buf[1] as usize) << 8 | buf[2] as usize;
    if n > MAX_FRAME {
        return Err("frame too large".into());
    }
    if buf.len() < 9 + n {
        return Ok(None);
    }
    let stream = u32::from_be_bytes([buf[5], buf[6], buf[7], buf[8]]) & 0x7fff_ffff;
    Ok(Some((
        Frame {
            ty: buf[3],
            flags: buf[4],
            stream,
            payload: buf[9..9 + n].to_vec(),
        },
        9 + n,
    )))
}

/// The payload of a DATA or HEADERS frame without padding and priority.
fn unpad(f: &Frame) -> Result<&[u8], String> {
    let mut p = &f.payload[..];
    let mut pad = 0;
    if f.flags & PADDED != 0 {
        let Some(&k) = p.first() else {
            return Err("bad padding".into());
        };
        pad = k as usize;
        p = &p[1..];
    }
    if f.ty == HEADERS && f.flags & PRIORITY != 0 {
        if p.len() < 5 {
            return Err("bad priority".into());
        }
        p = &p[5..];
    }
    if pad > p.len() {
        return Err("bad padding".into());
    }
    Ok(&p[..p.len() - pad])
}

/// HEADERS (and CONTINUATION) frames for a header block.
fn header_frames(stream: u32, block: &[u8], end_stream: bool, max: usize) -> Vec<u8> {
    let mut out = Vec::new();
    let mut chunks: Vec<&[u8]> = block.chunks(max.max(1)).collect();
    if chunks.is_empty() {
        chunks.push(&[]);
    }
    let last = chunks.len() - 1;
    for (i, c) in chunks.iter().enumerate() {
        let mut flags = if i == last { END_HEADERS } else { 0 };
        let ty = if i == 0 {
            if end_stream {
                flags |= END_STREAM;
            }
            HEADERS
        } else {
            CONTINUATION
        };
        out.extend(frame(ty, flags, stream, c));
    }
    out
}

fn our_settings() -> Vec<u8> {
    let mut s = Vec::new();
    // SETTINGS_ENABLE_PUSH = 0, SETTINGS_INITIAL_WINDOW_SIZE
    s.extend_from_slice(&[0, 2, 0, 0, 0, 0]);
    s.extend_from_slice(&[0, 4]);
    s.extend_from_slice(&OUR_WINDOW.to_be_bytes());
    let mut out = frame(SETTINGS, 0, 0, &s);
    out.extend(frame(
        WINDOW_UPDATE,
        0,
        0,
        &(OUR_WINDOW - 65535).to_be_bytes(),
    ));
    out
}

/// Peer settings that matter to a sender.
struct Peer {
    max_frame: usize,
    init_window: i64,
}

impl Peer {
    fn new() -> Self {
        Peer {
            max_frame: 16384,
            init_window: 65535,
        }
    }

    /// Apply a SETTINGS payload; returns the change of the initial window.
    fn apply(&mut self, p: &[u8]) -> Result<i64, String> {
        if !p.len().is_multiple_of(6) {
            return Err("bad SETTINGS frame".into());
        }
        let mut delta = 0;
        for s in p.chunks(6) {
            let id = u16::from_be_bytes([s[0], s[1]]);
            let v = u32::from_be_bytes([s[2], s[3], s[4], s[5]]);
            match id {
                4 => {
                    if v > 0x7fff_ffff {
                        return Err("bad initial window size".into());
                    }
                    delta += v as i64 - self.init_window;
                    self.init_window = v as i64;
                }
                5 => {
                    if !(16384..=16_777_215).contains(&v) {
                        return Err("bad max frame size".into());
                    }
                    self.max_frame = v as usize;
                }
                _ => {}
            }
        }
        Ok(delta)
    }
}

// ======================================================================= gRPC

/// gRPC status codes used here.
pub const INVALID_ARGUMENT: u32 = 3;
pub const FAILED_PRECONDITION: u32 = 9;
pub const UNIMPLEMENTED: u32 = 12;
pub const INTERNAL: u32 = 13;
pub const UNAVAILABLE: u32 = 14;

/// A gRPC length-prefixed message (uncompressed).
pub fn grpc_frame(msg: &[u8]) -> Vec<u8> {
    let mut out = vec![0];
    out.extend_from_slice(&(msg.len() as u32).to_be_bytes());
    out.extend_from_slice(msg);
    out
}

/// The single message of a unary call's body.
pub fn grpc_unframe(body: &[u8]) -> Result<&[u8], String> {
    if body.len() < 5 {
        return Err("missing gRPC message".into());
    }
    if body[0] != 0 {
        return Err("compressed gRPC messages are not supported".into());
    }
    let n = u32::from_be_bytes([body[1], body[2], body[3], body[4]]) as usize;
    if body.len() != 5 + n {
        return Err("expected exactly one gRPC message".into());
    }
    Ok(&body[5..])
}

/// `grpc-message` percent-encoding.
pub fn pct_encode(s: &str) -> String {
    let mut out = String::new();
    for b in s.bytes() {
        if (0x20..0x7f).contains(&b) && b != b'%' {
            out.push(b as char);
        } else {
            out.push_str(&format!("%{:02X}", b));
        }
    }
    out
}

pub fn pct_decode(s: &str) -> String {
    let b = s.as_bytes();
    let mut out = Vec::new();
    let mut i = 0;
    while i < b.len() {
        let hex = |c: u8| (c as char).to_digit(16);
        if b[i] == b'%' && i + 2 < b.len() {
            if let (Some(h), Some(l)) = (hex(b[i + 1]), hex(b[i + 2])) {
                out.push((h * 16 + l) as u8);
                i += 3;
                continue;
            }
        }
        out.push(b[i]);
        i += 1;
    }
    String::from_utf8_lossy(&out).into_owned()
}

/// Why a call failed.
#[derive(Debug)]
pub enum CallError {
    /// The connection failed; `retry` when the request certainly was not
    /// processed (a stale pooled connection).
    Transport { message: String, retry: bool },
    /// The server answered with a non-zero `grpc-status`.
    Status(u32, String),
}

impl std::fmt::Display for CallError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            CallError::Transport { message, .. } => write!(f, "{}", message),
            CallError::Status(c, m) => write!(f, "gRPC status {}: {}", c, m),
        }
    }
}

// ===================================================================== client

/// One client connection, used for one call at a time.
pub struct Client {
    sock: TcpStream,
    authority: String,
    dec: hpack::Decoder,
    peer: Peer,
    conn_window: i64,
    next_stream: u32,
    inbuf: Vec<u8>,
    dead: bool,
}

/// An I/O error as C's `strerror` words it (without Rust's "(os error N)").
pub fn io_msg(e: &std::io::Error) -> String {
    let s = e.to_string();
    match s.rfind(" (os error ") {
        Some(i) => s[..i].to_string(),
        None => s,
    }
}

fn transport(message: String, retry: bool) -> CallError {
    CallError::Transport { message, retry }
}

impl Client {
    pub fn connect(addr: &str) -> Result<Client, CallError> {
        let sock = TcpStream::connect(addr)
            .map_err(|e| transport(format!("cannot connect to {}: {}", addr, io_msg(&e)), false))?;
        let _ = sock.set_nodelay(true);
        let mut c = Client {
            sock,
            authority: addr.to_string(),
            dec: hpack::Decoder::default(),
            peer: Peer::new(),
            conn_window: 65535,
            next_stream: 1,
            inbuf: Vec::new(),
            dead: false,
        };
        let mut hello = PREFACE.to_vec();
        hello.extend(our_settings());
        c.send(&hello, false)?;
        Ok(c)
    }

    fn send(&mut self, b: &[u8], retry: bool) -> Result<(), CallError> {
        self.sock.write_all(b).map_err(|e| {
            self.dead = true;
            transport(
                format!("cannot send to {}: {}", self.authority, io_msg(&e)),
                retry,
            )
        })
    }

    /// The next frame from the server.
    fn read_frame(&mut self, retry: bool) -> Result<Frame, CallError> {
        loop {
            match parse_frame(&self.inbuf) {
                Ok(Some((f, n))) => {
                    self.inbuf.drain(..n);
                    return Ok(f);
                }
                Ok(None) => {}
                Err(e) => {
                    self.dead = true;
                    return Err(transport(e, false));
                }
            }
            let mut buf = [0u8; 16384];
            match self.sock.read(&mut buf) {
                Ok(0) => {
                    self.dead = true;
                    return Err(transport(
                        format!("connection to {} closed", self.authority),
                        retry,
                    ));
                }
                Ok(n) => self.inbuf.extend_from_slice(&buf[..n]),
                Err(e) if e.kind() == std::io::ErrorKind::Interrupted => {}
                Err(e) => {
                    self.dead = true;
                    return Err(transport(
                        format!("cannot read from {}: {}", self.authority, io_msg(&e)),
                        retry,
                    ));
                }
            }
        }
    }

    /// Handle a connection-level frame; returns true if it was one.
    fn control(&mut self, f: &Frame, windows: &mut BTreeMap<u32, i64>) -> Result<bool, CallError> {
        match f.ty {
            SETTINGS if f.stream == 0 => {
                if f.flags & ACK == 0 {
                    let delta = self
                        .peer
                        .apply(&f.payload)
                        .map_err(|e| transport(e, false))?;
                    for w in windows.values_mut() {
                        *w += delta;
                    }
                    self.send(&frame(SETTINGS, ACK, 0, &[]), false)?;
                }
                Ok(true)
            }
            PING => {
                if f.flags & ACK == 0 {
                    self.send(&frame(PING, ACK, 0, &f.payload), false)?;
                }
                Ok(true)
            }
            WINDOW_UPDATE if f.payload.len() == 4 => {
                let inc =
                    (u32::from_be_bytes([f.payload[0], f.payload[1], f.payload[2], f.payload[3]])
                        & 0x7fff_ffff) as i64;
                if f.stream == 0 {
                    self.conn_window += inc;
                } else if let Some(w) = windows.get_mut(&f.stream) {
                    *w += inc;
                }
                Ok(true)
            }
            _ => Ok(false),
        }
    }

    /// A unary call on this connection.
    pub fn unary(
        &mut self,
        path: &str,
        extra: &[(&str, &str)],
        msg: &[u8],
    ) -> Result<Vec<u8>, CallError> {
        if self.next_stream > 0x7fff_0000 {
            self.dead = true;
            return Err(transport("connection exhausted".into(), true));
        }
        let id = self.next_stream;
        self.next_stream += 2;
        let mut hs: Vec<(&str, &str)> = vec![
            (":method", "POST"),
            (":scheme", "http"),
            (":path", path),
            (":authority", &self.authority),
            ("content-type", "application/grpc"),
            ("te", "trailers"),
        ];
        hs.extend_from_slice(extra);
        let block = hpack::encode(&hs);
        let hf = header_frames(id, &block, false, self.peer.max_frame);
        self.send(&hf, true)?;
        let body = grpc_frame(msg);
        let mut windows = BTreeMap::new();
        windows.insert(id, self.peer.init_window);
        let mut sent = 0;
        let mut got_any = false;
        while sent < body.len() {
            let avail = self
                .conn_window
                .min(windows[&id])
                .min(self.peer.max_frame as i64);
            if avail <= 0 {
                let f = self.read_frame(!got_any)?;
                if !self.control(&f, &mut windows)? && f.stream == id {
                    got_any = true;
                    if f.ty == RST_STREAM {
                        return Err(transport(
                            format!("stream reset by {}", self.authority),
                            false,
                        ));
                    }
                }
                if f.ty == GOAWAY {
                    self.dead = true;
                }
                continue;
            }
            let n = (avail as usize).min(body.len() - sent);
            let end = if sent + n == body.len() {
                END_STREAM
            } else {
                0
            };
            let fr = frame(DATA, end, id, &body[sent..sent + n]);
            self.send(&fr, !got_any)?;
            sent += n;
            self.conn_window -= n as i64;
            *windows.get_mut(&id).unwrap() -= n as i64;
        }
        // the response
        let mut headers: Vec<(String, String)> = Vec::new();
        let mut data = Vec::new();
        let mut block: Option<Vec<u8>> = None;
        let mut ended = false;
        let mut end_after_block = false;
        while !ended {
            let f = self.read_frame(!got_any)?;
            if self.control(&f, &mut windows)? {
                continue;
            }
            match f.ty {
                GOAWAY if f.payload.len() >= 8 => {
                    self.dead = true;
                    let last = u32::from_be_bytes([
                        f.payload[0],
                        f.payload[1],
                        f.payload[2],
                        f.payload[3],
                    ]) & 0x7fff_ffff;
                    if last < id {
                        return Err(transport(
                            format!("{} is shutting down", self.authority),
                            !got_any,
                        ));
                    }
                }
                HEADERS | CONTINUATION if f.stream == id => {
                    got_any = true;
                    let part = if f.ty == HEADERS {
                        if f.flags & END_STREAM != 0 {
                            end_after_block = true;
                        }
                        unpad(&f).map_err(|e| transport(e, false))?
                    } else {
                        &f.payload[..]
                    };
                    let b = block.get_or_insert_with(Vec::new);
                    b.extend_from_slice(part);
                    if f.flags & END_HEADERS != 0 {
                        let b = block.take().unwrap();
                        let hs = self.dec.decode(&b).map_err(|e| {
                            self.dead = true;
                            transport(e, false)
                        })?;
                        headers.extend(hs);
                        ended = end_after_block;
                    }
                }
                HEADERS | CONTINUATION => {
                    // another stream's header block: decode to keep the
                    // HPACK state in step
                    if f.flags & END_HEADERS != 0 {
                        let p = if f.ty == HEADERS {
                            unpad(&f).map_err(|e| transport(e, false))?.to_vec()
                        } else {
                            f.payload.clone()
                        };
                        let _ = self.dec.decode(&p);
                    }
                }
                DATA if f.stream == id => {
                    got_any = true;
                    let p = unpad(&f).map_err(|e| transport(e, false))?;
                    data.extend_from_slice(p);
                    if !f.payload.is_empty() {
                        let inc = (f.payload.len() as u32).to_be_bytes();
                        self.send(&frame(WINDOW_UPDATE, 0, 0, &inc), false)?;
                    }
                    if f.flags & END_STREAM != 0 {
                        ended = true;
                    }
                }
                RST_STREAM if f.stream == id => {
                    let code = f.payload.get(3).copied().unwrap_or(0);
                    return Err(transport(
                        format!("stream reset by {} (code {})", self.authority, code),
                        code == 7 && !got_any, // REFUSED_STREAM
                    ));
                }
                _ => {}
            }
        }
        let get = |n: &str| {
            headers
                .iter()
                .rev()
                .find(|(k, _)| k == n)
                .map(|(_, v)| v.clone())
        };
        if let Some(s) = get(":status") {
            if s != "200" {
                return Err(CallError::Status(
                    UNAVAILABLE,
                    format!("HTTP status {} from {}", s, self.authority),
                ));
            }
        }
        let status: u32 = match get("grpc-status") {
            Some(s) => s.trim().parse().unwrap_or(2),
            None => {
                return Err(CallError::Status(
                    INTERNAL,
                    format!("no grpc-status from {}", self.authority),
                ))
            }
        };
        if status != 0 {
            let m = get("grpc-message")
                .map(|m| pct_decode(&m))
                .unwrap_or_default();
            return Err(CallError::Status(status, m));
        }
        grpc_unframe(&data)
            .map(|m| m.to_vec())
            .map_err(|e| CallError::Status(INTERNAL, e))
    }
}

/// Idle client connections by address.
static POOL: Mutex<Option<HashMap<String, Vec<Client>>>> = Mutex::new(None);

/// A unary call to `addr`, on a pooled connection when one is available.
pub fn call(
    addr: &str,
    path: &str,
    extra: &[(&str, &str)],
    msg: &[u8],
) -> Result<Vec<u8>, CallError> {
    for attempt in 0..2 {
        let pooled = POOL
            .lock()
            .unwrap()
            .get_or_insert_with(HashMap::new)
            .get_mut(addr)
            .and_then(|v| v.pop());
        let reused = pooled.is_some();
        let mut c = match pooled {
            Some(c) => c,
            None => Client::connect(addr)?,
        };
        let r = c.unary(path, extra, msg);
        if !c.dead {
            POOL.lock()
                .unwrap()
                .get_or_insert_with(HashMap::new)
                .entry(addr.to_string())
                .or_default()
                .push(c);
        }
        match r {
            Err(CallError::Transport { retry: true, .. }) if reused && attempt == 0 => continue,
            r => return r,
        }
    }
    unreachable!()
}

// ===================================================================== server

/// The outcome of a call: a response message, or a gRPC status and message.
pub type Reply = Result<Vec<u8>, (u32, String)>;

/// A call handler: path, request headers and request message.
pub type Handler<'a> = dyn FnMut(&str, &[(String, String)], &[u8]) -> Reply + 'a;

#[derive(Default)]
struct SStream {
    headers: Vec<(String, String)>,
    data: Vec<u8>,
    ended: bool,
    dispatched: bool,
    window: i64,
    pending: Vec<u8>,
    trailers: Option<Vec<u8>>,
}

struct SConn {
    sock: TcpStream,
    inbuf: Vec<u8>,
    outbuf: Vec<u8>,
    preface: bool,
    dec: hpack::Decoder,
    peer: Peer,
    conn_window: i64,
    streams: BTreeMap<u32, SStream>,
    /// A header block awaiting CONTINUATION: stream, bytes, END_STREAM.
    cont: Option<(u32, Vec<u8>, bool)>,
    last_stream: u32,
    closing: bool,
    closed: bool,
}

impl SConn {
    fn new(sock: TcpStream) -> Self {
        SConn {
            sock,
            inbuf: Vec::new(),
            outbuf: our_settings(),
            preface: false,
            dec: hpack::Decoder::default(),
            peer: Peer::new(),
            conn_window: 65535,
            streams: BTreeMap::new(),
            cont: None,
            last_stream: 0,
            closing: false,
            closed: false,
        }
    }

    fn goaway(&mut self, code: u32) {
        let mut p = self.last_stream.to_be_bytes().to_vec();
        p.extend_from_slice(&code.to_be_bytes());
        self.outbuf.extend(frame(GOAWAY, 0, 0, &p));
        self.closing = true;
    }

    fn header_block(&mut self, stream: u32, block: Vec<u8>, end: bool) {
        let hs = match self.dec.decode(&block) {
            Ok(h) => h,
            Err(_) => {
                self.goaway(9); // COMPRESSION_ERROR
                return;
            }
        };
        if let Some(s) = self.streams.get_mut(&stream) {
            // trailers of a request
            if end {
                s.ended = true;
            }
            return;
        }
        if stream.is_multiple_of(2) || stream <= self.last_stream {
            return;
        }
        self.last_stream = stream;
        self.streams.insert(
            stream,
            SStream {
                headers: hs,
                ended: end,
                window: self.peer.init_window,
                ..Default::default()
            },
        );
    }

    fn on_frame(&mut self, f: Frame) {
        if let Some((sid, _, _)) = &self.cont {
            if f.ty != CONTINUATION || f.stream != *sid {
                self.goaway(1);
                return;
            }
        }
        match f.ty {
            HEADERS => match unpad(&f) {
                Ok(p) => {
                    let end = f.flags & END_STREAM != 0;
                    if f.flags & END_HEADERS != 0 {
                        self.header_block(f.stream, p.to_vec(), end);
                    } else {
                        self.cont = Some((f.stream, p.to_vec(), end));
                    }
                }
                Err(_) => self.goaway(1),
            },
            CONTINUATION => {
                let Some((sid, mut b, end)) = self.cont.take() else {
                    self.goaway(1);
                    return;
                };
                b.extend_from_slice(&f.payload);
                if f.flags & END_HEADERS != 0 {
                    self.header_block(sid, b, end);
                } else {
                    self.cont = Some((sid, b, end));
                }
            }
            DATA => {
                let Ok(p) = unpad(&f) else {
                    self.goaway(1);
                    return;
                };
                let end = f.flags & END_STREAM != 0;
                if !f.payload.is_empty() {
                    let inc = (f.payload.len() as u32).to_be_bytes();
                    self.outbuf.extend(frame(WINDOW_UPDATE, 0, 0, &inc));
                }
                if let Some(s) = self.streams.get_mut(&f.stream) {
                    s.data.extend_from_slice(p);
                    if end {
                        s.ended = true;
                    }
                }
            }
            RST_STREAM => {
                self.streams.remove(&f.stream);
            }
            SETTINGS if f.flags & ACK == 0 => match self.peer.apply(&f.payload) {
                Ok(delta) => {
                    for s in self.streams.values_mut() {
                        s.window += delta;
                    }
                    self.outbuf.extend(frame(SETTINGS, ACK, 0, &[]));
                }
                Err(_) => self.goaway(1),
            },
            PING if f.flags & ACK == 0 => {
                self.outbuf.extend(frame(PING, ACK, 0, &f.payload));
            }
            WINDOW_UPDATE if f.payload.len() == 4 => {
                let inc =
                    (u32::from_be_bytes([f.payload[0], f.payload[1], f.payload[2], f.payload[3]])
                        & 0x7fff_ffff) as i64;
                if f.stream == 0 {
                    self.conn_window += inc;
                } else if let Some(s) = self.streams.get_mut(&f.stream) {
                    s.window += inc;
                }
            }
            GOAWAY => self.closing = true,
            _ => {}
        }
    }

    /// Parse the input buffer into frames.
    fn process_input(&mut self) {
        if !self.preface {
            if self.inbuf.len() < PREFACE.len() {
                if !PREFACE.starts_with(&self.inbuf) {
                    self.closed = true;
                }
                return;
            }
            if &self.inbuf[..PREFACE.len()] != PREFACE {
                self.closed = true;
                return;
            }
            self.inbuf.drain(..PREFACE.len());
            self.preface = true;
        }
        loop {
            match parse_frame(&self.inbuf) {
                Ok(Some((f, n))) => {
                    self.inbuf.drain(..n);
                    self.on_frame(f);
                    if self.closing && self.streams.is_empty() {
                        return;
                    }
                }
                Ok(None) => return,
                Err(_) => {
                    self.goaway(6); // FRAME_SIZE_ERROR
                    self.inbuf.clear();
                    return;
                }
            }
        }
    }

    /// Run the calls whose requests are complete.
    fn dispatch(&mut self, handler: &mut Handler) {
        let ready: Vec<u32> = self
            .streams
            .iter()
            .filter(|(_, s)| s.ended && !s.dispatched)
            .map(|(id, _)| *id)
            .collect();
        for id in ready {
            let s = self.streams.get_mut(&id).unwrap();
            s.dispatched = true;
            let get = |n: &str| {
                s.headers
                    .iter()
                    .find(|(k, _)| k == n)
                    .map(|(_, v)| v.as_str())
                    .unwrap_or("")
            };
            let ct = get("content-type").to_string();
            let path = get(":path").to_string();
            let method = get(":method").to_string();
            let max = self.peer.max_frame;
            if method != "POST" || !ct.starts_with("application/grpc") {
                let b = hpack::encode(&[(":status", "415")]);
                self.outbuf.extend(header_frames(id, &b, true, max));
                self.streams.remove(&id);
                continue;
            }
            let reply = match grpc_unframe(&s.data) {
                Ok(m) => handler(&path, &s.headers, m),
                Err(e) => Err((INVALID_ARGUMENT, e)),
            };
            match reply {
                Ok(msg) => {
                    let b =
                        hpack::encode(&[(":status", "200"), ("content-type", "application/grpc")]);
                    self.outbuf.extend(header_frames(id, &b, false, max));
                    s.pending = grpc_frame(&msg);
                    s.trailers = Some(hpack::encode(&[("grpc-status", "0")]));
                }
                Err((code, m)) => {
                    let code = code.to_string();
                    let m = pct_encode(&m);
                    let b = hpack::encode(&[
                        (":status", "200"),
                        ("content-type", "application/grpc"),
                        ("grpc-status", &code),
                        ("grpc-message", &m),
                    ]);
                    self.outbuf.extend(header_frames(id, &b, true, max));
                    self.streams.remove(&id);
                }
            }
        }
    }

    /// Move response data into the output within the flow-control windows.
    fn flush_streams(&mut self) {
        let ids: Vec<u32> = self
            .streams
            .iter()
            .filter(|(_, s)| s.trailers.is_some())
            .map(|(id, _)| *id)
            .collect();
        for id in ids {
            let max = self.peer.max_frame;
            let s = self.streams.get_mut(&id).unwrap();
            while !s.pending.is_empty() {
                let n = (self.conn_window.min(s.window).min(max as i64)).max(0) as usize;
                let n = n.min(s.pending.len());
                if n == 0 {
                    break;
                }
                let chunk: Vec<u8> = s.pending.drain(..n).collect();
                self.outbuf.extend(frame(DATA, 0, id, &chunk));
                self.conn_window -= n as i64;
                s.window -= n as i64;
            }
            if s.pending.is_empty() {
                let t = s.trailers.take().unwrap();
                self.outbuf.extend(header_frames(id, &t, true, max));
                self.streams.remove(&id);
            }
        }
    }

    fn read_some(&mut self) {
        let mut buf = [0u8; 65536];
        loop {
            match self.sock.read(&mut buf) {
                Ok(0) => {
                    self.closed = true;
                    return;
                }
                Ok(n) => self.inbuf.extend_from_slice(&buf[..n]),
                Err(e) if e.kind() == std::io::ErrorKind::WouldBlock => return,
                Err(e) if e.kind() == std::io::ErrorKind::Interrupted => {}
                Err(_) => {
                    self.closed = true;
                    return;
                }
            }
        }
    }

    fn write_some(&mut self) {
        while !self.outbuf.is_empty() {
            match self.sock.write(&self.outbuf) {
                Ok(0) => {
                    self.closed = true;
                    return;
                }
                Ok(n) => {
                    self.outbuf.drain(..n);
                }
                Err(e) if e.kind() == std::io::ErrorKind::WouldBlock => return,
                Err(e) if e.kind() == std::io::ErrorKind::Interrupted => {}
                Err(_) => {
                    self.closed = true;
                    return;
                }
            }
        }
        if self.closing && self.streams.is_empty() {
            self.closed = true;
        }
    }
}

#[repr(C)]
struct PollFd {
    fd: i32,
    events: i16,
    revents: i16,
}

#[cfg(target_os = "linux")]
type NFds = std::ffi::c_ulong;
#[cfg(not(target_os = "linux"))]
type NFds = std::ffi::c_uint;

extern "C" {
    fn poll(fds: *mut PollFd, n: NFds, timeout: i32) -> i32;
}

const POLLIN: i16 = 1;
const POLLOUT: i16 = 4;

/// Serve gRPC calls on `listener` forever. `handler` gets the path, the
/// request headers and the request message.
pub fn serve(listener: TcpListener, handler: &mut Handler) -> std::io::Result<()> {
    use std::os::unix::io::AsRawFd;
    listener.set_nonblocking(true)?;
    let mut conns: Vec<SConn> = Vec::new();
    loop {
        let mut fds = vec![PollFd {
            fd: listener.as_raw_fd(),
            events: POLLIN,
            revents: 0,
        }];
        for c in &conns {
            fds.push(PollFd {
                fd: c.sock.as_raw_fd(),
                events: POLLIN | if c.outbuf.is_empty() { 0 } else { POLLOUT },
                revents: 0,
            });
        }
        let r = unsafe { poll(fds.as_mut_ptr(), fds.len() as NFds, -1) };
        if r < 0 {
            let e = std::io::Error::last_os_error();
            if e.kind() == std::io::ErrorKind::Interrupted {
                continue;
            }
            return Err(e);
        }
        for (i, c) in conns.iter_mut().enumerate() {
            let ev = fds[i + 1].revents;
            if ev == 0 {
                continue;
            }
            if ev & (POLLIN | 0x8 | 0x10) != 0 {
                c.read_some();
                c.process_input();
                c.dispatch(handler);
            }
            c.flush_streams();
            c.write_some();
        }
        conns.retain(|c| !c.closed);
        if fds[0].revents & POLLIN != 0 {
            while let Ok((s, _)) = listener.accept() {
                let _ = s.set_nodelay(true);
                if s.set_nonblocking(true).is_ok() {
                    let mut c = SConn::new(s);
                    c.write_some();
                    conns.push(c);
                }
            }
        }
    }
}
