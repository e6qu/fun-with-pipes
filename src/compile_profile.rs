//! Opt-in wall-clock observations of the real compiler pipeline.
//!
//! Start a report on the compilation worker. Nested spans retain their parent;
//! exclusive times subtract direct children, rather than counting macro work
//! once in expansion and again in its nested compilation. No runtime code is
//! instrumented and disabled observations do not read the clock.

use std::cell::RefCell;
use std::fs::OpenOptions;
use std::io::Write;
use std::marker::PhantomData;
use std::path::{Path, PathBuf};
use std::rc::Rc;
use std::time::Instant;

use crate::json::Json;

thread_local! {
    static ACTIVE: RefCell<Option<Report>> = const { RefCell::new(None) };
}

struct Event {
    phase: &'static str,
    parent: Option<usize>,
    start_ns: u128,
    end_ns: Option<u128>,
    children_ns: u128,
    counts: Vec<(&'static str, usize)>,
}

struct Report {
    start: Instant,
    events: Vec<Event>,
    stack: Vec<usize>,
}

/// A phase stays on its starting thread, including during error unwinding.
pub(crate) struct Phase {
    id: Option<usize>,
    _thread: PhantomData<Rc<()>>,
}

pub(crate) fn phase(name: &'static str) -> Phase {
    let id = ACTIVE.with_borrow_mut(|active| {
        let report = active.as_mut()?;
        let id = report.events.len();
        report.events.push(Event {
            phase: name,
            parent: report.stack.last().copied(),
            start_ns: report.start.elapsed().as_nanos(),
            end_ns: None,
            children_ns: 0,
            counts: Vec::new(),
        });
        report.stack.push(id);
        Some(id)
    });
    Phase {
        id,
        _thread: PhantomData,
    }
}

impl Phase {
    pub(crate) fn count(&self, name: &'static str, value: usize) {
        if let Some(id) = self.id {
            ACTIVE.with_borrow_mut(|active| {
                let report = active.as_mut().expect("active compiler observation");
                assert!(!report.events[id].counts.iter().any(|(key, _)| *key == name));
                report.events[id].counts.push((name, value));
            });
        }
    }
}

impl Drop for Phase {
    fn drop(&mut self) {
        let Some(id) = self.id else { return };
        ACTIVE.with_borrow_mut(|active| {
            let report = active.as_mut().expect("active compiler observation");
            assert_eq!(report.stack.pop(), Some(id));
            let end = report.start.elapsed().as_nanos();
            let event = &mut report.events[id];
            event.end_ns = Some(end);
            let duration = end - event.start_ns;
            if let Some(parent) = event.parent {
                report.events[parent].children_ns += duration;
            }
        });
    }
}

struct Activation;

impl Drop for Activation {
    fn drop(&mut self) {
        ACTIVE.with_borrow_mut(|active| *active = None);
    }
}

/// Record one worker action. Existing report files are never overwritten.
/// `outputs` names build destinations that must not alias this report.
pub fn record(path: &Path, outputs: &[PathBuf], action: impl FnOnce() -> u8) -> Result<u8, String> {
    if ACTIVE.with_borrow(Option::is_some) {
        return Err("compiler reporting is already active on this worker".into());
    }
    let mut file = OpenOptions::new()
        .write(true)
        .create_new(true)
        .open(path)
        .map_err(|e| format!("cannot create compiler report {}: {e}", path.display()))?;
    let report_path = path.canonicalize().map_err(|e| e.to_string())?;
    if outputs
        .iter()
        .any(|output| output.canonicalize().is_ok_and(|p| p == report_path))
    {
        drop(file);
        std::fs::remove_file(path).map_err(|e| e.to_string())?;
        return Err("compiler report must differ from every build output".into());
    }
    ACTIVE.with_borrow_mut(|active| {
        *active = Some(Report {
            start: Instant::now(),
            events: Vec::new(),
            stack: Vec::new(),
        })
    });
    let activation = Activation;
    let status = action();
    let report = ACTIVE.with_borrow_mut(|active| active.take().unwrap());
    let wall_ns = report.start.elapsed().as_nanos();
    drop(activation);
    assert!(report.stack.is_empty(), "unfinished compiler phase");
    let mut assigned_ns = 0;
    let events = report
        .events
        .into_iter()
        .enumerate()
        .map(|(id, event)| {
            let end = event.end_ns.expect("finished compiler phase");
            let inclusive = end - event.start_ns;
            if event.parent.is_none() {
                assigned_ns += inclusive;
            }
            Json::Obj(vec![
                ("id".into(), Json::Num(id.to_string())),
                ("phase".into(), Json::Str(event.phase.into())),
                (
                    "parent".into(),
                    event
                        .parent
                        .map_or(Json::Null, |p| Json::Num(p.to_string())),
                ),
                ("start_ns".into(), Json::Num(event.start_ns.to_string())),
                ("end_ns".into(), Json::Num(end.to_string())),
                ("inclusive_ns".into(), Json::Num(inclusive.to_string())),
                (
                    "exclusive_ns".into(),
                    Json::Num((inclusive - event.children_ns).to_string()),
                ),
                (
                    "counts".into(),
                    Json::Obj(
                        event
                            .counts
                            .into_iter()
                            .map(|(name, value)| (name.into(), Json::Num(value.to_string())))
                            .collect(),
                    ),
                ),
            ])
        })
        .collect();
    let result = Json::Obj(vec![
        ("format".into(), Json::Str("fwp-compile-profile".into())),
        ("version".into(), Json::Num("1".into())),
        ("status".into(), Json::Num(status.to_string())),
        (
            "scope".into(),
            Json::Str(
                "build action; excludes observer setup, report serialization and process startup"
                    .into(),
            ),
        ),
        ("wall_ns".into(), Json::Num(wall_ns.to_string())),
        (
            "unassigned_ns".into(),
            Json::Num((wall_ns - assigned_ns).to_string()),
        ),
        ("phases".into(), Json::Arr(events)),
    ]);
    writeln!(file, "{result}")
        .map_err(|e| format!("cannot write compiler report {}: {e}", path.display()))?;
    Ok(status)
}
