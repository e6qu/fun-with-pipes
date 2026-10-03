fn main() {
    let (mut i, mut acc): (i64, i64) = (100_000_000, 0);
    while i != 0 {
        acc += i * 3 % 7;
        i -= 1;
    }
    println!("{}", acc);
}
