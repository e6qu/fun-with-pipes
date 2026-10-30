//! A5 peer: Vec owns the buffer, read_buffer borrows it, then Vec is dropped.
//! Black boxes preserve repeated calls, without forcing allocation inside work.
use std::env;
use std::hint::black_box;
use std::mem::size_of;
use std::process;

#[cfg(buffer_entry = "unique")]
const ENTRY: &str = "unique";
#[cfg(buffer_entry = "callback")]
const ENTRY: &str = "callback";
#[cfg(buffer_entry = "scan")]
const ENTRY: &str = "scan";
#[cfg(not(any(
    buffer_entry = "unique",
    buffer_entry = "callback",
    buffer_entry = "scan"
)))]
compile_error!("Select an explicit buffer_entry: unique, callback or scan");

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

fn work(input: i64) -> i64 {
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
    let result = if ENTRY == "scan" {
        let mut total = 0;
        for &value in &values {
            total = add(total, value);
        }
        total
    } else {
        let result = read_buffer(&values);
        if ENTRY == "unique" {
            add(result, values.len() as i64)
        } else {
            result
        }
    };
    drop(values);
    result
}

fn main() {
    let args: Vec<_> = env::args().collect();
    if args.len() != 4 {
        fail("expected entry length repeats", 2);
    }
    if args[1] != ENTRY {
        fail("invalid entry", 2);
    }
    let length = number(&args[2]);
    let repeats = number(&args[3]);
    if repeats <= 0 {
        fail("repeats must be positive", 2);
    }
    let size = length.max(0) as u128;
    let expected = if ENTRY == "scan" {
        if size == 0 {
            0
        } else {
            size * (size - 1) / 2
        }
    } else {
        size * if ENTRY == "unique" { 2 } else { 1 }
    };
    let mut checksum = 0;
    for _ in 0..repeats {
        let result = black_box(work(black_box(length)));
        if result < 0 || result as u128 != expected {
            fail("incorrect result", 4);
        }
        checksum = add(checksum, result);
    }
    println!("{checksum}");
}
