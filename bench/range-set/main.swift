// Ordered distinct keys; unsigned LEB128 length, then little-endian keys.
let keys = Array(UInt64(0)..<1_000_000)
var hash: UInt64 = 0xcbf29ce484222325
var count = UInt64(keys.count)
repeat {
    let byte = count & 0x7f
    count >>= 7
    hash = (hash ^ (byte | (count != 0 ? 0x80 : 0))) &* 0x100000001b3
} while count != 0
for key in keys {
    for shift in stride(from: 0, to: 64, by: 8) {
        hash = (hash ^ ((key >> shift) & 0xff)) &* 0x100000001b3
    }
}
print(hash)
