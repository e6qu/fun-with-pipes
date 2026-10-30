//! A5 peer: Vec owns the buffer, read_buffer borrows it, then Vec is dropped.
//! Black boxes preserve repeated calls, without forcing allocation inside work.
use std::env;
use std::hint::black_box;
use std::mem::size_of;
use std::process;

fn fail(message: &str, status: i32) -> ! {
    eprintln!("{message}");
    process::exit(status);
}

fn number(text: &str) -> i64 {
    let digits = text.strip_prefix('-').unwrap_or(text);
    if digits.is_empty() || !digits.bytes().all(|byte| byte.is_ascii_digit()) {
        fail("invalid integer", 2);
    }
    text.parse().unwrap_or_else(|_| fail("invalid integer", 2))
}

fn add(left: i64, right: i64) -> i64 {
    left.checked_add(right)
        .unwrap_or_else(|| fail("integer overflow", 3))
}

fn read_buffer(values: &[i64]) -> i64 {
    add(values.len() as i64, values.first().copied().unwrap_or(0))
}

fn work(input: i64, callback: bool) -> i64 {
    let length = input.max(0) as usize;
    if length > isize::MAX as usize / size_of::<i64>() {
        fail("array too large", 3);
    }
    let mut values = Vec::new();
    values
        .try_reserve_exact(length)
        .unwrap_or_else(|_| fail("out of memory", 102));
    for index in 0..length {
        values.push(index as i64);
    }
    let result = read_buffer(&values);
    let result = if callback {
        result
    } else {
        add(result, values.len() as i64)
    };
    drop(values);
    result
}

fn main() {
    let args: Vec<_> = env::args().collect();
    if args.len() != 4 {
        fail("expected unique|callback length repeats", 2);
    }
    let callback = match args[1].as_str() {
        "unique" => false,
        "callback" => true,
        _ => fail("invalid entry", 2),
    };
    let length = number(&args[2]);
    let repeats = number(&args[3]);
    if repeats <= 0 {
        fail("repeats must be positive", 2);
    }
    let expected = length.max(0) as u64 * if callback { 1 } else { 2 };
    let mut checksum = 0;
    for _ in 0..repeats {
        let result = black_box(work(black_box(length), callback));
        if result < 0 || result as u64 != expected {
            fail("incorrect result", 4);
        }
        checksum = add(checksum, result);
    }
    println!("{checksum}");
}
