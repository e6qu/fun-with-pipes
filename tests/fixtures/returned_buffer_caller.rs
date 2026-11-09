use std::env;
use std::process;
use returned_buffer::{make, release, scan};
#[cfg(buffer_shared)]
use returned_buffer::alias;

fn fail(text: &str, status: i32) -> ! { eprintln!("{text}"); process::exit(status); }
fn number(text: &str) -> i64 {
    let digits = text.strip_prefix('-').unwrap_or(text);
    if digits.is_empty() || !digits.bytes().all(|byte| byte.is_ascii_digit()) {
        fail("invalid integer", 2);
    }
    text.parse().unwrap_or_else(|_| fail("invalid integer", 2))
}

fn main() {
    let args: Vec<_> = env::args().collect();
    if args.len() != 3 { fail("expected length repeats", 2); }
    let length = number(&args[1]);
    let repeats = number(&args[2]);
    if length > 262144 { fail("length exceeds experiment bound", 2); }
    if !(1..=64).contains(&repeats) { fail("repeats outside experiment bound", 2); }
    let size = length.max(0);
    let expected = size * (size - 1) / 2;
    let mut checksum = 0_i64;
    for _ in 0..repeats {
        let first = make(length);
        #[cfg(buffer_shared)]
        let second = alias(&first);
        let value = scan(&first);
        if value != expected { fail("incorrect result", 4); }
        checksum += value;
        release(first);
        #[cfg(buffer_shared)]
        {
            let value = scan(&second);
            if value != expected { fail("incorrect result", 4); }
            checksum += value;
            release(second);
        }
    }
    println!("{checksum}");
}
