// The same checked recurrence as the C/Rust/fwp peers.
func fib(_ n: Int64) -> Int64 {
    if n == 0 || n == 1 { return n }
    let left = fib(n - 1)
    let right = fib(n - 2)
    return left + right
}
print(fib(35))
