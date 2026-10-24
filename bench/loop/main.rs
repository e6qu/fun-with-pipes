fn main() {
    let (mut i, mut acc): (i64, i64) = (100_000_000, 0);
    while i != 0 {
        let next = i.checked_sub(1).expect("subtraction overflow");
        let product = i.checked_mul(3).expect("multiplication overflow");
        acc = acc.checked_add(product % 7).expect("addition overflow");
        i = next;
    }
    println!("{}", acc);
}
