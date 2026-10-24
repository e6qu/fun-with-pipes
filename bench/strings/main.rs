use std::convert::TryFrom;

fn main() {
    let total = (0..2_000_000i64)
        .map(|i| {
            let product = i.checked_mul(3).expect("multiplication overflow");
            i64::try_from(format!("#{}{}", i, product).len()).expect("length overflow")
        })
        .fold(0i64, |sum, length| {
            sum.checked_add(length).expect("addition overflow")
        });
    println!("{}", total);
}
