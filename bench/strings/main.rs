fn main() {
    let total: usize = (0..2_000_000i64)
        .map(|i| format!("#{}{}", i, i * 3).len())
        .sum();
    println!("{}", total);
}
