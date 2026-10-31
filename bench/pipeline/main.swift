// Eager Array operations, like the existing Rust Vec peer; not a hand-fused loop.
var total: Int64 = 0
for _ in 0..<20 {
    let xs = (Int64(0)..<1_000_000).map { $0 * 3 }
    let ys = xs.filter { $0 % 2 == 0 }
    total += ys.reduce(Int64(0), +)
}
print(total)
