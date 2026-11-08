// The runner prepends COUNT, UPDATES, REPEATS and EXPECTED and selects one cfg.
use std::hint::black_box;
use std::time::Instant;

#[cfg(workload = "loop")]
fn measure(mut i: i64) -> i64 {
    let mut total = 0i64;
    while i != 0 {
        let next = i.checked_sub(1).expect("subtraction overflow");
        let product = i.checked_mul(3).expect("multiplication overflow");
        total = total.checked_add(product % 7).expect("addition overflow");
        i = next;
    }
    total
}
#[cfg(workload = "array")]
fn measure(input: Vec<f64>) -> f64 {
    let mapped: Vec<f64> = input.iter().map(|value| value * 3.0 + 1.0).collect();
    drop(input);
    let mut total = -0.0;
    for value in &mapped {
        total = value + total;
    }
    total
}
#[cfg(workload = "descent")]
fn measure(mut input: Vec<f64>) -> Vec<f64> {
    if UPDATES == 0 {
        return input;
    }
    let count = input.len();
    let mut next = vec![0.0; count];
    for _ in 0..UPDATES {
        for i in 0..count {
            let previous = if i == 0 {
                0.0
            } else {
                200.0 * (input[i] - input[i - 1] * input[i - 1])
            };
            let following = if i + 1 == count {
                0.0
            } else {
                -400.0 * input[i] * (input[i + 1] - input[i] * input[i]) - 2.0 * (1.0 - input[i])
            };
            next[i] = input[i] - 0.001 * (previous + following);
        }
        std::mem::swap(&mut input, &mut next);
    }
    input
}
fn main() {
    let (mut setup, mut work, mut release, mut checksum) = (0u128, 0u128, 0u128, 0u64);
    let total_start = Instant::now();
    for round in 0..REPEATS {
        let start = Instant::now();
        #[cfg(workload = "loop")]
        let input = black_box(COUNT as i64);
        #[cfg(workload = "array")]
        let input = black_box(vec![2.0; COUNT]);
        #[cfg(workload = "descent")]
        let input = black_box(
            (0..COUNT)
                .map(|i| if i % 2 == 0 { -1.2 } else { 1.0 })
                .collect(),
        );
        setup += start.elapsed().as_nanos();
        let start = Instant::now();
        let result = black_box(measure(input));
        work += start.elapsed().as_nanos();
        #[cfg(workload = "loop")]
        let values = [result as u64];
        #[cfg(workload = "array")]
        let values = [result.to_bits()];
        #[cfg(any(workload = "loop", workload = "array"))]
        for (value, expected) in values.iter().zip(EXPECTED) {
            assert_eq!(value, expected);
            checksum ^= value.wrapping_add(round as u64);
        }
        #[cfg(workload = "descent")]
        {
            assert_eq!(result.len(), EXPECTED.len());
            for (value, expected) in result.iter().zip(EXPECTED) {
                assert_eq!(value.to_bits(), *expected);
                checksum ^= value.to_bits().wrapping_add(round as u64);
            }
        }
        let start = Instant::now();
        #[cfg(workload = "descent")]
        drop(result);
        release += start.elapsed().as_nanos();
    }
    let total = total_start.elapsed().as_nanos();
    println!("{{\"constructionNs\":{setup},\"computationNs\":{work},\"releaseNs\":{release},\"loopNs\":{total},\"checksum\":{checksum}}}");
}
