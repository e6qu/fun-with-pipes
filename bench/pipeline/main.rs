fn main() {
    let total: i64 = (0..20)
        .map(|_| {
            let xs: Vec<i64> = (0..1_000_000i64).map(|x| x * 3).collect();
            let ys: Vec<i64> = xs.into_iter().filter(|x| x % 2 == 0).collect();
            ys.iter().sum::<i64>()
        })
        .sum();
    println!("{}", total);
}
