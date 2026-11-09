//! Serial Rc/Weak semantics; this is not an allocator or ARC-operation observer.
use std::cell::Cell;
use std::env;
use std::process;
use std::rc::{Rc, Weak};

struct Counts {
    calls: Cell<usize>,
    destroyed: Cell<usize>,
}

struct Target<'a> {
    identity: usize,
    counts: &'a Counts,
}

impl Drop for Target<'_> {
    fn drop(&mut self) {
        self.counts.destroyed.set(self.counts.destroyed.get() + 1);
    }
}

fn dispatch<'a>(
    weak: &Weak<Target<'a>>,
    cancelled: &Cell<bool>,
    outside: &mut Option<Rc<Target<'a>>>,
    counts: &Counts,
) -> bool {
    if cancelled.get() {
        return false;
    }
    let Some(active) = weak.upgrade() else {
        return false;
    };
    counts.calls.set(counts.calls.get() + 1);
    assert_eq!(active.identity, 7);
    cancelled.set(true);
    drop(outside.take());
    assert_eq!(counts.destroyed.get(), 0);
    assert!(!dispatch(weak, cancelled, outside, counts));
    let nested = weak.upgrade().expect("active owner must survive cancellation");
    assert_eq!(nested.identity, 7);
    drop(nested);
    assert_eq!(counts.destroyed.get(), 0);
    drop(active);
    true
}

fn main() {
    if env::args_os().len() != 1 {
        eprintln!("expected no arguments");
        process::exit(2);
    }
    let counts = Counts { calls: Cell::new(0), destroyed: Cell::new(0) };
    assert!(Weak::<Target<'_>>::new().upgrade().is_none());
    let mut owner = Some(Rc::new(Target { identity: 7, counts: &counts }));
    let weak = Rc::downgrade(owner.as_ref().unwrap());
    let cancelled = Cell::new(true);
    assert!(!dispatch(&weak, &cancelled, &mut owner, &counts));
    assert_eq!((counts.calls.get(), counts.destroyed.get()), (0, 0));
    cancelled.set(false);
    assert!(dispatch(&weak, &cancelled, &mut owner, &counts));
    assert!(owner.is_none());
    assert_eq!((counts.calls.get(), counts.destroyed.get()), (1, 1));
    assert!(!dispatch(&weak, &cancelled, &mut owner, &counts));
    cancelled.set(false);
    assert!(!dispatch(&weak, &cancelled, &mut owner, &counts));
    for identity in 0..64 {
        let replacement = Rc::new(Target { identity, counts: &counts });
        assert!(weak.upgrade().is_none());
        drop(replacement);
    }
    assert_eq!(counts.destroyed.get(), 65);
    drop(weak);
    println!("calls=1 destroyed=65 expired=1 cancelled=1");
}
