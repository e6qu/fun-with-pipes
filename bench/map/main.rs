fn key(i: i64) -> i64 {
    i * 7919 % 1_000_003
}
fn main() {
    // Match C and fwp: contiguous sorted pairs with bisection lookups.
    let mut table: Vec<(i64, i64)> = (0..500_000).map(|i| (key(i), i)).collect();
    table.sort_unstable_by_key(|&(k, _)| k);
    println!("{}", table.len());
    let sum: i64 = (0..2_000_000)
        .map(|i| {
            let k = key(i);
            let (mut lo, mut hi) = (0, table.len());
            while lo < hi {
                let mid = (lo + hi) / 2;
                if table[mid].0 < k {
                    lo = mid + 1;
                } else {
                    hi = mid;
                }
            }
            if lo < table.len() && table[lo].0 == k {
                table[lo].1
            } else {
                0
            }
        })
        .sum();
    println!("{}", sum);
}
