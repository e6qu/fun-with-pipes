use std::collections::BTreeMap;
fn key(i: i64) -> i64 {
    i * 7919 % 1_000_003
}
fn main() {
    let table: BTreeMap<i64, i64> = (0..500_000).map(|i| (key(i), i)).collect();
    println!("{}", table.len());
    let sum: i64 = (0..2_000_000).map(|i| *table.get(&key(i)).unwrap_or(&0)).sum();
    println!("{}", sum);
}
