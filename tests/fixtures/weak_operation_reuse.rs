//! Weak retains the Rc allocation; its address must not belong to a new target.
use std::env;
use std::process;
use std::rc::Rc;
use weak_operation::{downgrade, lookup, make, release_owner, release_weak};

fn fail() -> ! { eprintln!("weak reuse check failed"); process::exit(79); }
fn main() {
    if env::args().count() != 1 { eprintln!("expected no arguments"); process::exit(2); }
    let (mut reused, mut expired, mut replacement_live) = (0_u32, 0_u32, 0_u32);
    for _ in 0..1024 {
        let owner = make(1);
        let address = Rc::as_ptr(&owner) as usize;
        let weak = downgrade(&owner);
        if !lookup(&weak) { fail(); }
        release_owner(owner);
        if lookup(&weak) { fail(); }
        let replacement = make(1);
        if Rc::as_ptr(&replacement) as usize == address { reused += 1; }
        let revived = lookup(&weak);
        if revived { fail(); }
        expired += 1;
        let current = downgrade(&replacement);
        if !lookup(&current) { fail(); }
        replacement_live += 1;
        release_owner(replacement);
        if lookup(&current) { fail(); }
        release_weak(current);
        release_weak(weak);
    }
    if reused != 0 { fail(); }
    println!("{{\"rounds\":1024,\"reused\":{reused},\"expired\":{expired},\"replacementLive\":{replacement_live}}}");
}
