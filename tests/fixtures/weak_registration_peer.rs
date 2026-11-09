//! Serial Rc/Weak semantics; this is not an allocator or ARC-operation observer.
use std::cell::Cell;
use std::env;
use std::process;
use std::rc::{Rc, Weak};

struct Counts {
    calls: Cell<usize>,
    destroyed: Cell<usize>,
    disposed: Cell<usize>,
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
    let counts = Counts { calls: Cell::new(0), destroyed: Cell::new(0), disposed: Cell::new(0) };
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
    let mut owner = Some(Rc::new(Target { identity: 9, counts: &counts }));
    let weak = Rc::downgrade(owner.as_ref().unwrap());
    assert_eq!(dispatch_error(&weak, &mut owner, &counts), Err(CallbackError));
    assert!(owner.is_none());
    assert_eq!((counts.calls.get(), counts.destroyed.get()), (2, 66));
    assert!(weak.upgrade().is_none());
    assert_eq!(dispatch_error(&weak, &mut owner, &counts), Ok(false));
    assert_eq!(counts.calls.get(), 2);
    drop(weak);
    queued_checks();
    println!("calls=2 destroyed=66 expired=1 cancelled=1 error=1 queue=1");
}

#[derive(Debug, PartialEq)]
struct CallbackError;

fn callback_error(
    acquired: &Target<'_>,
    outside: &mut Option<Rc<Target<'_>>>,
    counts: &Counts,
) -> Result<(), CallbackError> {
    assert_eq!(acquired.identity, 9);
    counts.calls.set(counts.calls.get() + 1);
    drop(outside.take());
    assert_eq!(counts.destroyed.get(), 65);
    assert_eq!(acquired.identity, 9);
    Err(CallbackError)
}

fn dispatch_error<'a>(
    weak: &Weak<Target<'a>>,
    outside: &mut Option<Rc<Target<'a>>>,
    counts: &Counts,
) -> Result<bool, CallbackError> {
    let Some(acquired) = weak.upgrade() else { return Ok(false) };
    // Propagating the callback error must drop this acquired Rc automatically.
    callback_error(&acquired, outside, counts)?;
    Ok(true)
}

struct Payload<'a> {
    value: usize,
    counts: &'a Counts,
}

impl Drop for Payload<'_> {
    fn drop(&mut self) {
        assert_eq!(self.value, 11);
        self.counts.disposed.set(self.counts.disposed.get() + 1);
    }
}

struct Pending<'a> {
    target: Weak<Target<'a>>,
    payload: Payload<'a>,
}

fn queued_dispatch<'a>(
    entry: Pending<'a>,
    outside: &mut Option<Rc<Target<'a>>>,
    counts: &Counts,
) -> Result<(), CallbackError> {
    let Some(held) = entry.target.upgrade() else { return Ok(()) };
    counts.calls.set(counts.calls.get() + 1);
    assert_eq!((held.identity, entry.payload.value), (17, 11));
    drop(outside.take());
    assert_eq!((counts.destroyed.get(), held.identity), (0, 17));
    Err(CallbackError)
}

fn drain_queue<'a>(
    queue: Vec<Pending<'a>>,
    outside: &mut Option<Rc<Target<'a>>>,
    counts: &Counts,
) -> Result<(), CallbackError> {
    // On error, dropping IntoIter also drops every unprocessed entry.
    for entry in queue { queued_dispatch(entry, outside, counts)?; }
    Ok(())
}

fn queued_checks() {
    for cancelled in [true, false] {
        let counts = Counts { calls: Cell::new(0), destroyed: Cell::new(0), disposed: Cell::new(0) };
        let mut owner = Some(Rc::new(Target { identity: 17, counts: &counts }));
        let mut queue: Vec<_> = (0..2).map(|_| Pending {
            target: Rc::downgrade(owner.as_ref().unwrap()),
            payload: Payload { value: 11, counts: &counts },
        }).collect();
        if cancelled {
            drop(queue.remove(0));
            assert_eq!((counts.disposed.get(), counts.destroyed.get()), (1, 0));
            drop(owner.take());
            assert_eq!(counts.destroyed.get(), 1);
            assert_eq!(drain_queue(queue, &mut owner, &counts), Ok(()));
            assert_eq!(counts.calls.get(), 0);
        } else {
            assert_eq!(drain_queue(queue, &mut owner, &counts), Err(CallbackError));
            assert_eq!(counts.calls.get(), 1);
        }
        assert!(owner.is_none());
        assert_eq!((counts.destroyed.get(), counts.disposed.get()), (1, 2));
    }
}
