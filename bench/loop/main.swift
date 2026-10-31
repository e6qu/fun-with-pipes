var i: Int64 = 100_000_000
var sum: Int64 = 0
while i != 0 {
    let next = i - 1
    let product = i * 3
    sum = sum + product % 7
    i = next
}
print(sum)
