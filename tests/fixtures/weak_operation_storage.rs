//! Diagnostic prefixes of the real Rc/Weak lifetime; no replacement allocation.
use std::env;
use std::mem::forget;
use std::process;
use std::rc::{Rc, Weak};
use weak_operation::{downgrade, lookup, make, release_owner, release_weak, Target};

fn fail(text: &str, status: i32) -> ! { eprintln!("{text}"); process::exit(status); }
fn number(text: &str) -> i64 {
    if text.is_empty() || !text.bytes().all(|byte| byte.is_ascii_digit()) { fail("invalid integer", 2); }
    text.parse().unwrap_or_else(|_| fail("invalid integer", 2))
}
fn main() {
    let args: Vec<_> = env::args().collect();
    if args.len() != 3 { fail("expected population stage", 2); }
    let population = number(&args[1]);
    let stage = number(&args[2]);
    if ![64, 4096].contains(&population) || stage > 3 { fail("invalid experiment arguments", 2); }
    let mut owners: Vec<Rc<Target>> = Vec::with_capacity(population as usize);
    let mut weak: Vec<Weak<Target>> = Vec::with_capacity(population as usize);
    let (mut live, mut expired) = (0_i64, 0_i64);
    for _ in 0..population { owners.push(make(1)); }
    if stage >= 1 {
        for owner in &owners { weak.push(downgrade(owner)); }
        for value in &weak { live += i64::from(lookup(value)); }
    }
    for owner in owners.drain(..) {
        if stage >= 2 { release_owner(owner); } else { forget(owner); }
    }
    if stage >= 2 {
        for value in &weak { expired += i64::from(lookup(value)); }
    }
    for value in weak.drain(..) {
        if stage >= 3 { release_weak(value); } else { forget(value); }
    }
    drop(owners); drop(weak);
    if live != (if stage >= 1 { population } else { 0 }) || expired != 0 { fail("incorrect result", 4); }
    println!("{{\"population\":{population},\"stage\":{stage},\"live\":{live},\"expired\":{expired}}}");
}
