// Sorted contiguous pairs and bisection, matching the other peers' data model.
func key(_ i: Int64) -> Int64 { (i * 7919) % 1_000_003 }
var table = (Int64(0)..<500_000).map { (key($0), $0) }
table.sort { $0.0 < $1.0 }
print(table.count)
var sum: Int64 = 0
for i in Int64(0)..<2_000_000 {
    let k = key(i)
    var lo = 0
    var hi = table.count
    while lo < hi {
        let mid = (lo + hi) / 2
        if table[mid].0 < k { lo = mid + 1 } else { hi = mid }
    }
    if lo < table.count && table[lo].0 == k { sum += table[lo].1 }
}
print(sum)
