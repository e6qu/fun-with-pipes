use std::env;
use std::process;
use std::rc::{Rc, Weak};
use weak_operation::{downgrade, lookup, make, release_owner, release_weak, Target};

extern "C" { fn callable_phase_clock() -> u64; }
fn fail(text: &str, status: i32) -> ! { eprintln!("{text}"); process::exit(status); }
fn number(text: &str) -> i64 {
    if text.is_empty() || !text.bytes().all(|byte| byte.is_ascii_digit()) { fail("invalid integer", 2); }
    text.parse().unwrap_or_else(|_| fail("invalid integer", 2))
}
fn main() {
    let args: Vec<_> = env::args().collect();
    if args.len() != 4 { fail("expected population lookups batches", 2); }
    let population = number(&args[1]);
    let lookups = number(&args[2]);
    let batches = number(&args[3]);
    if ![1, 64, 4096].contains(&population) || ![1, 16, 64].contains(&lookups)
        || ![1, 16, 64, 256, 1024].contains(&batches) { fail("invalid experiment arguments", 2); }
    let mut owners: Vec<Rc<Target>> = Vec::with_capacity(population as usize);
    let mut weak: Vec<Weak<Target>> = Vec::with_capacity(population as usize);
    let (mut live, mut expired) = (0_i64, 0_i64);
    let mut times = [0_u64; 6];
    for _ in 0..batches {
        let mut t = [0_u64; 7];
        t[0] = unsafe { callable_phase_clock() };
        for _ in 0..population { owners.push(make(1)); }
        t[1] = unsafe { callable_phase_clock() };
        for owner in &owners { weak.push(downgrade(owner)); }
        t[2] = unsafe { callable_phase_clock() };
        for _ in 0..lookups { for value in &weak { live += i64::from(lookup(value)); } }
        t[3] = unsafe { callable_phase_clock() };
        for owner in owners.drain(..) { release_owner(owner); }
        t[4] = unsafe { callable_phase_clock() };
        for _ in 0..lookups { for value in &weak { expired += i64::from(lookup(value)); } }
        t[5] = unsafe { callable_phase_clock() };
        for value in weak.drain(..) { release_weak(value); }
        t[6] = unsafe { callable_phase_clock() };
        for phase in 0..6 {
            if t[phase + 1] < t[phase] { fail("clock moved backwards", 77); }
            times[phase] += t[phase + 1] - t[phase];
        }
    }
    drop(owners); drop(weak);
    if live != population * lookups * batches || expired != 0 { fail("incorrect result", 4); }
    println!("{{\"live\":{live},\"expired\":{expired},\"targetCreation\":{},\"weakCreation\":{},\"liveLookup\":{},\"ownerRelease\":{},\"expiredLookup\":{},\"weakRelease\":{}}}",
             times[0], times[1], times[2], times[3], times[4], times[5]);
}
