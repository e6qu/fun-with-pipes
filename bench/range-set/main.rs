// Already ordered distinct keys, matching the directly constructed fwp set.
// Hash the unsigned LEB128 length followed by little-endian 64-bit keys.
fn main() {
    const N: u64 = 1_000_000;
    let keys: Vec<u64> = (0..N).collect();
    let mut hash = 0xcbf29ce484222325u64;
    let mut count = keys.len() as u64;
    loop {
        let byte = count & 0x7f;
        count >>= 7;
        hash = (hash ^ (byte | if count != 0 { 0x80 } else { 0 })).wrapping_mul(0x100000001b3);
        if count == 0 {
            break;
        }
    }
    for key in keys {
        for byte in key.to_le_bytes() {
            hash = (hash ^ u64::from(byte)).wrapping_mul(0x100000001b3);
        }
    }
    println!("{hash}");
}
