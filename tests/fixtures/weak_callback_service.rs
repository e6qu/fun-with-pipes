//! Serial service with ordinary Vec payloads and Rc/Weak receiving targets.
use std::cell::RefCell;
use std::rc::{Rc, Weak};

#[cfg(not(any(service_plain, service_diagnostic)))]
compile_error!("Select service_plain or service_diagnostic explicitly");
#[cfg(all(service_plain, service_diagnostic))]
compile_error!("Select exactly one service observation policy");

struct Target {
    inbox: RefCell<Vec<Vec<i64>>>,
}
struct Pending {
    payload: Vec<i64>,
    target: Weak<Target>,
}
#[derive(Default)]
pub struct Stats {
    pub calls: i64,
    pub cancelled: i64,
    pub expired: i64,
    pub errors: i64,
    pub sent: i64,
    pub received: i64,
    pub sum: i64,
    pub received_sum: i64,
}
fn callback(active: &Target, payload: Vec<i64>, fail: bool, stats: &mut Stats) -> Result<(), ()> {
    stats.calls += 1;
    stats.sum += payload.iter().sum::<i64>();
    active.inbox.borrow_mut().push(payload);
    stats.sent += 1;
    if fail {
        Err(())
    } else {
        Ok(())
    }
}
#[inline(never)]
pub fn service_run(population: usize, mode: usize) -> Stats {
    let mut stats = Stats::default();
    let mut owner = Some(Rc::new(Target {
        inbox: RefCell::new(Vec::with_capacity(population)),
    }));
    let pending: Vec<_> = (0..population)
        .map(|index| Pending {
            payload: (0..16).map(|lane| (index + lane) as i64).collect(),
            target: Rc::downgrade(owner.as_ref().unwrap()),
        })
        .collect();
    if mode == 2 {
        drop(owner.take());
    }
    for (index, entry) in pending.into_iter().enumerate() {
        if mode == 1 && index % 4 == 0 {
            stats.cancelled += 1;
            continue;
        }
        let Some(active) = entry.target.upgrade() else {
            stats.expired += 1;
            continue;
        };
        if callback(
            &active,
            entry.payload,
            mode == 3 && index == population / 2,
            &mut stats,
        )
        .is_err()
        {
            stats.errors += 1;
            break;
        }
    }
    if let Some(target) = owner.take() {
        for payload in target.inbox.borrow_mut().drain(..) {
            stats.received += 1;
            stats.received_sum += payload.iter().sum::<i64>();
        }
        #[cfg(service_diagnostic)]
        {
            assert_eq!(Rc::strong_count(&target), 1);
            assert_eq!(Rc::weak_count(&target), 0);
        }
    }
    stats
}
