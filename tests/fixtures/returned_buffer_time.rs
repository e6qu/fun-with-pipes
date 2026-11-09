use std::env;
use std::process;
use returned_buffer::{make, release, scan, Buffer};
#[cfg(buffer_shared)]
use returned_buffer::alias;

extern "C" { fn callable_phase_clock() -> u64; }

fn fail(text: &str, status: i32) -> ! { eprintln!("{text}"); process::exit(status); }
fn number(text: &str) -> i64 {
    let digits = text.strip_prefix('-').unwrap_or(text);
    if digits.is_empty() || !digits.bytes().all(|byte| byte.is_ascii_digit()) { fail("invalid integer", 2); }
    text.parse().unwrap_or_else(|_| fail("invalid integer", 2))
}

fn main() {
    let args: Vec<_> = env::args().collect();
    if args.len() != 4 { fail("expected length population batches", 2); }
    let length = number(&args[1]);
    let population = number(&args[2]);
    let batches = number(&args[3]);
    let required = match length { 0 | 16 => 4096, 4096 => 256, 262144 => 4, _ => -1 };
    if required == -1 || population != required || ![16, 64, 256, 1024].contains(&batches) {
        fail("invalid experiment arguments", 2);
    }
    // Slot capacity is allocated once, outside every measured batch.
    let mut first: Vec<Buffer> = Vec::with_capacity(population as usize);
    #[cfg(buffer_shared)]
    let mut second: Vec<Buffer> = Vec::with_capacity(population as usize);
    let mut checksum: i64 = 0;
    let (mut construction, mut reading, mut releasing) = (0_u64, 0_u64, 0_u64);
    for _ in 0..batches {
        let t0 = unsafe { callable_phase_clock() };
        for _ in 0..population {
            let value = make(length);
            #[cfg(buffer_shared)]
            second.push(alias(&value));
            first.push(value);
        }
        let t1 = unsafe { callable_phase_clock() };
        for value in &first { checksum += scan(value); }
        let t2 = unsafe { callable_phase_clock() };
        for value in first.drain(..) { release(value); }
        let t3 = unsafe { callable_phase_clock() };
        #[cfg(buffer_shared)]
        {
            for value in &second { checksum += scan(value); }
            let t4 = unsafe { callable_phase_clock() };
            for value in second.drain(..) { release(value); }
            let t5 = unsafe { callable_phase_clock() };
            if t4 < t3 || t5 < t4 { fail("clock moved backwards", 77); }
            reading += t4 - t3;
            releasing += t5 - t4;
        }
        if t1 < t0 || t2 < t1 || t3 < t2 { fail("clock moved backwards", 77); }
        construction += t1 - t0;
        reading += t2 - t1;
        releasing += t3 - t2;
    }
    drop(first);
    #[cfg(buffer_shared)]
    drop(second);
    let expected = length * (length - 1) / 2 * population * batches
        * if cfg!(buffer_shared) { 2 } else { 1 };
    if checksum != expected { fail("incorrect result", 4); }
    println!("{{\"checksum\":{checksum},\"construction\":{construction},\"reading\":{reading},\"release\":{releasing}}}");
}
