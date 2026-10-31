var total: Int64 = 0
for i in Int64(0)..<2_000_000 {
    let product = i * 3
    // All characters are ASCII; byte length matches the fwp/C/Rust result.
    let text = "#\(i)\(product)"
    total += Int64(text.utf8.count)
}
print(total)
