fn characters(value: i64) -> i64 {
    let mut magnitude = value.unsigned_abs();
    let mut count = 1 + i64::from(value < 0);
    while magnitude >= 10 {
        magnitude /= 10;
        count += 1;
    }
    count
}

fn main() {
    let mut total = 0i64;
    for i in 0..2_000_000i64 {
        let product = i.checked_mul(3).expect("multiplication overflow");
        let digits = characters(i)
            .checked_add(characters(product))
            .expect("length overflow");
        let line = digits.checked_add(1).expect("length overflow");
        total = total.checked_add(line).expect("sum overflow");
    }
    println!("{total}");
}
