fn fib(n: i64) -> i64 {
    if n == 0 || n == 1 {
        n
    } else {
        let left = fib(n.checked_sub(1).expect("subtraction overflow"));
        let right = fib(n.checked_sub(2).expect("subtraction overflow"));
        left.checked_add(right).expect("addition overflow")
    }
}

fn main() {
    println!("{}", fib(35));
}
