fn main() {
    let total = (0..20)
        .map(|_| {
            let xs: Vec<i64> = (0..1_000_000i64)
                .map(|x| x.checked_mul(3).expect("multiplication overflow"))
                .collect();
            let ys: Vec<i64> = xs.into_iter().filter(|x| x % 2 == 0).collect();
            ys.iter().fold(0i64, |sum, x| {
                sum.checked_add(*x).expect("addition overflow")
            })
        })
        .fold(0i64, |total, sum| {
            total.checked_add(sum).expect("addition overflow")
        });
    println!("{}", total);
}
