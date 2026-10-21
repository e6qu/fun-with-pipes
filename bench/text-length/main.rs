#[inline]
fn characters(value: i64) -> i64 {
    let mut magnitude = value.unsigned_abs();
    let mut count = 1;
    if magnitude >= 10_000_000_000_000_000 {
        magnitude /= 10_000_000_000_000_000;
        count += 16;
    }
    if magnitude >= 100_000_000 {
        magnitude /= 100_000_000;
        count += 8;
    }
    if magnitude >= 10_000 {
        magnitude /= 10_000;
        count += 4;
    }
    if magnitude >= 100 {
        magnitude /= 100;
        count += 2;
    }
    if magnitude >= 10 {
        count += 1;
    }
    count + i64::from(value < 0)
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
