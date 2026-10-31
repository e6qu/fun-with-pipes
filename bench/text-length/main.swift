func characters(_ value: Int64) -> Int64 {
    var magnitude = value.magnitude
    var count: Int64 = 1
    if magnitude >= 10_000_000_000_000_000 {
        magnitude /= 10_000_000_000_000_000
        count += 16
    }
    if magnitude >= 100_000_000 { magnitude /= 100_000_000; count += 8 }
    if magnitude >= 10_000 { magnitude /= 10_000; count += 4 }
    if magnitude >= 100 { magnitude /= 100; count += 2 }
    if magnitude >= 10 { count += 1 }
    return count + (value < 0 ? 1 : 0)
}
var total: Int64 = 0
for i in Int64(0)..<2_000_000 {
    let product = i * 3
    let digits = characters(i) + characters(product)
    let line = digits + 1
    total += line
}
print(total)
