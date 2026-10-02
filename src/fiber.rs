//! Fibers for the WebAssembly build of fwp, which has no threads: each task
//! of the interpreter runs on a fiber, a stack that the JavaScript host
//! suspends and resumes with JavaScript Promise Integration (JSPI). The
//! host's side is web/fibers.js, which describes the interface; this module
//! exports `fwp_fiber_hooks`, `fwp_fiber_stack` and `fwp_fiber_entry`
//! (`.cargo/config.toml` exports them, with the stack pointer and the
//! function table). Which fiber runs next is decided by the scheduler in
//! `sched.rs`; this module only switches.
//!
//! The engine keeps most of a fiber's stack itself, but Rust also keeps
//! part of it in linear memory (the "shadow stack", below the stack
//! pointer), and the interpreter's frames there are large. Fiber 0, which
//! runs `_start`, has the main stack. The other fibers take turns on one
//! shared stack region: a fiber that suspends copies the part it uses out
//! (usually a few kilobytes), and copies it back in when it resumes. So a
//! task may recurse as deeply as the region allows, and thousands of
//! waiting tasks cost only what they use. Nothing outside a task refers to
//! its stack (tasks share values on the heap), which the copying needs.
//!
//! Without the host's hooks (another WASI runtime, or an engine without
//! JSPI) there are no fibers: [`available`] is false, and only waiting for
//! timers works, by sleeping.

use std::cell::{Cell, RefCell};

/// Table slots of the host's hooks (0: none), written by web/fibers.js.
#[repr(C)]
pub struct Hooks {
    switch: u32,
    idle: u32,
    sp: u32,
}

static mut HOOKS: Hooks = Hooks {
    switch: 0,
    idle: 0,
    sp: 0,
};

/// The size of the stack region shared by the fibers of tasks.
const REGION: usize = 32 << 20;
/// What the interpreter leaves unused at the end of the region: calls that
/// would need it trap with "stack overflow".
const RESERVE: usize = 256 << 10;

type Job = Box<dyn FnOnce() -> usize>;

#[derive(Default)]
struct Fiber {
    /// What the fiber runs (until it starts): returns the fiber to resume.
    job: Option<Job>,
    /// While suspended: the stack pointer, and the region's contents from
    /// there to its top.
    sp: usize,
    saved: Vec<u8>,
    /// The interpreter's stack limit, while the fiber is switched out.
    limit: usize,
}

thread_local! {
    /// Fibers by number; fiber 0 runs `_start` on the main stack.
    static FIBERS: RefCell<Vec<Option<Fiber>>> = RefCell::new(vec![Some(Fiber::default())]);
    static CURRENT: Cell<usize> = const { Cell::new(0) };
    /// The stack region of tasks (allocated with the first one).
    static REGION_MEM: RefCell<Vec<u8>> = const { RefCell::new(Vec::new()) };
}

fn hooks() -> (u32, u32, u32) {
    // SAFETY: one thread; the host writes the hooks before `_start`.
    unsafe {
        let h = &*std::ptr::addr_of!(HOOKS);
        (h.switch, h.idle, h.sp)
    }
}

/// Whether the host switches fibers (so tasks can run).
pub fn available() -> bool {
    let (switch, _, sp) = hooks();
    switch != 0 && sp != 0
}

/// The running fiber.
pub fn current() -> usize {
    CURRENT.with(|c| c.get())
}

/// The bottom and the top of the shared stack region.
fn region() -> (usize, usize) {
    REGION_MEM.with(|r| {
        let mut r = r.borrow_mut();
        if r.is_empty() {
            *r = vec![0; REGION];
        }
        let lo = r.as_ptr() as usize;
        (lo, (lo + r.len()) & !15)
    })
}

/// A new fiber that runs `job` when it is first switched to; `job` returns
/// the fiber to resume when it finished.
pub fn spawn(job: Job) -> usize {
    region();
    FIBERS.with(|f| {
        let mut f = f.borrow_mut();
        let fiber = Fiber {
            job: Some(job),
            ..Fiber::default()
        };
        match (1..f.len()).find(|&i| f[i].is_none()) {
            Some(i) => {
                f[i] = Some(fiber);
                i
            }
            None => {
                f.push(Some(fiber));
                f.len() - 1
            }
        }
    })
}

fn stack_pointer() -> usize {
    let sp: extern "C" fn() -> i32 =
        // SAFETY: the slot holds web/fibers.js's `sp`, of this type
        unsafe { std::mem::transmute(hooks().2 as usize) };
    sp() as u32 as usize
}

/// Suspend the running fiber and resume (or start) `to`; returns when a
/// fiber switches back to this one.
pub fn switch_to(to: usize) {
    let me = current();
    if to == me {
        return;
    }
    let limit = crate::interp::stack_limit();
    // the part of the shared region this fiber uses, from the stack
    // pointer of this frame (the hook below does not move it)
    let sp = if me == 0 { 0 } else { stack_pointer() };
    FIBERS.with(|f| {
        let mut f = f.borrow_mut();
        let fb = f[me].as_mut().expect("fiber");
        fb.limit = limit;
        fb.sp = sp;
        fb.saved.clear();
        if sp != 0 {
            let top = region().1;
            // SAFETY: [sp, top) lies in the region, which this fiber uses
            let used = unsafe { std::slice::from_raw_parts(sp as *const u8, top - sp) };
            fb.saved.extend_from_slice(used);
        }
    });
    CURRENT.with(|c| c.set(to));
    let switch: extern "C" fn(i32) -> i32 =
        // SAFETY: the slot holds web/fibers.js's `switch`, of this type
        unsafe { std::mem::transmute(hooks().0 as usize) };
    switch(to as i32);
    // Nothing of this frame may be used until `resumed` restored it: the
    // fiber's number is taken from CURRENT, which the switch to it set.
    resumed();
}

/// Back in the current fiber: put its part of the shared region back
/// (above the stack pointer, where this function's own frame is not).
#[inline(never)]
fn resumed() {
    let me = current();
    let limit = FIBERS.with(|f| {
        let mut f = f.borrow_mut();
        let fb = f[me].as_mut().expect("fiber");
        if fb.sp != 0 {
            // SAFETY: the bytes go back where they were copied from
            unsafe {
                std::ptr::copy_nonoverlapping(fb.saved.as_ptr(), fb.sp as *mut u8, fb.saved.len());
            }
        }
        fb.saved = Vec::new();
        fb.limit
    });
    crate::interp::set_raw_stack_limit(limit);
}

/// Wait `ms` milliseconds with the whole program (every task waits for a
/// timer): the host's timer, so that a browser does not busy-wait.
pub fn idle(ms: f64) {
    let idle = hooks().1;
    if idle == 0 {
        std::thread::sleep(std::time::Duration::from_secs_f64(ms.max(0.0) / 1000.0));
        return;
    }
    let idle: extern "C" fn(f64) -> i32 =
        // SAFETY: the slot holds web/fibers.js's `idle`, of this type
        unsafe { std::mem::transmute(idle as usize) };
    idle(ms);
}

/// For the host: where it writes the hooks.
#[no_mangle]
pub extern "C" fn fwp_fiber_hooks() -> *mut Hooks {
    std::ptr::addr_of_mut!(HOOKS)
}

/// For the host: the initial stack pointer of a fiber (the top of the
/// shared region).
#[no_mangle]
pub extern "C" fn fwp_fiber_stack(_id: i32) -> u32 {
    region().1 as u32
}

/// For the host: run fiber `id` (on the shared region); the fiber to
/// resume next, which restores its own state when it resumes.
#[no_mangle]
pub extern "C" fn fwp_fiber_entry(id: i32) -> i32 {
    let id = id as usize;
    CURRENT.with(|c| c.set(id));
    crate::interp::set_raw_stack_limit(region().0 + RESERVE);
    let job = FIBERS.with(|f| f.borrow_mut()[id].as_mut().and_then(|fb| fb.job.take()));
    let next = job.map_or(0, |j| j());
    FIBERS.with(|f| f.borrow_mut()[id] = None);
    CURRENT.with(|c| c.set(next));
    next as i32
}

/// Keeps the exports linked into the executable (they are called only by
/// the host).
pub fn keep() {
    std::hint::black_box((
        fwp_fiber_hooks as *const (),
        fwp_fiber_stack as *const (),
        fwp_fiber_entry as *const (),
    ));
}
