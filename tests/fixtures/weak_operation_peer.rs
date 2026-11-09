//! Ordinary serial Rc/Weak; the caller compiles as a separate native crate.
use std::rc::{Rc, Weak};

pub struct Target {
    // A nonempty value; no extra Box or separately allocated payload.
    pub identity: i64,
}

#[inline(never)]
pub fn make(input: i64) -> Rc<Target> {
    assert_eq!(input, 1);
    Rc::new(Target { identity: input })
}
#[inline(never)]
pub fn downgrade(owner: &Rc<Target>) -> Weak<Target> { Rc::downgrade(owner) }
#[inline(never)]
pub fn lookup(weak: &Weak<Target>) -> bool { weak.upgrade().is_some() }
#[inline(never)]
pub fn release_owner(owner: Rc<Target>) { drop(owner); }
#[inline(never)]
pub fn release_weak(weak: Weak<Target>) { drop(weak); }
