//! Structured concurrency, networking and metrics for the interpreter.
//!
//! Every task runs on its own OS thread, but the threads of a program take
//! turns holding a fair baton: only the holder evaluates, so values (which
//! use `Rc`) are never touched concurrently. A task hands the baton on
//! whenever it blocks on a timer, a channel, another task or a socket.
//!
//! The WebAssembly build has no threads: there each task runs on a fiber
//! (`fiber.rs`), and handing the baton on is switching to the next ready
//! fiber, in the same order.
//!
//! Tasks form a tree. A task finishes only after its children finished;
//! cancelling a task cancels its subtree. Cancellation is observed at
//! suspension points and unwinds the task (`Ctl::Cancelled`), which
//! `attempt` does not catch.

use std::cell::RefCell;
use std::collections::{BTreeMap, VecDeque};
use std::io::{Read, Write};
use std::net::{TcpListener, TcpStream, ToSocketAddrs, UdpSocket};
use std::os::fd::AsRawFd;
use std::rc::Rc;
use std::sync::atomic::{AtomicBool, Ordering as AO};
#[cfg(not(target_family = "wasm"))]
use std::sync::Condvar;
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

use crate::interp::{Ctl, Interp, R};
use crate::ir::MT;
use crate::tls::Io;
use crate::value::Value;

/// Contents only accessed by the thread holding the baton.
pub struct Baton<T>(pub T);
unsafe impl<T> Send for Baton<T> {}
unsafe impl<T> Sync for Baton<T> {}

#[cfg(not(target_family = "wasm"))]
struct Turns {
    next: u64,
    serving: u64,
    events: u64,
}

/// The fibers of one program (WebAssembly): those ready to run, in order,
/// and those parked until an event or an instant.
#[cfg(target_family = "wasm")]
#[derive(Default)]
struct Fibers {
    ready: VecDeque<usize>,
    parked: Vec<(usize, Option<Instant>)>,
}

/// The threads of one program.
pub struct World {
    #[cfg(not(target_family = "wasm"))]
    turn: Mutex<Turns>,
    #[cfg(not(target_family = "wasm"))]
    turn_cv: Condvar,
    #[cfg(not(target_family = "wasm"))]
    event_cv: Condvar,
    #[cfg(target_family = "wasm")]
    fibers: Mutex<Fibers>,
    metrics: Mutex<BTreeMap<String, (&'static str, f64)>>,
    /// gRPC client connections, shared by the program's tasks.
    pub(crate) grpc: Mutex<Baton<crate::grpc::Shared>>,
}

impl World {
    pub fn new() -> Arc<World> {
        Arc::new(World {
            #[cfg(not(target_family = "wasm"))]
            turn: Mutex::new(Turns {
                next: 1,
                serving: 0,
                events: 0,
            }),
            #[cfg(not(target_family = "wasm"))]
            turn_cv: Condvar::new(),
            #[cfg(not(target_family = "wasm"))]
            event_cv: Condvar::new(),
            #[cfg(target_family = "wasm")]
            fibers: Mutex::new(Fibers::default()),
            metrics: Mutex::new(BTreeMap::new()),
            grpc: Mutex::new(Baton(Default::default())),
        })
    }

    #[cfg(not(target_family = "wasm"))]
    fn acquire(&self) {
        let mut t = self.turn.lock().unwrap();
        let me = t.next;
        t.next += 1;
        while t.serving != me {
            t = self.turn_cv.wait(t).unwrap();
        }
    }

    #[cfg(not(target_family = "wasm"))]
    fn release(&self) {
        let mut t = self.turn.lock().unwrap();
        t.serving += 1;
        self.turn_cv.notify_all();
    }

    /// Shared state changed: wake parked tasks so they re-check.
    #[cfg(not(target_family = "wasm"))]
    pub(crate) fn event(&self) {
        let mut t = self.turn.lock().unwrap();
        t.events += 1;
        self.event_cv.notify_all();
    }

    /// Hand the baton on until an event happens or `until` passes.
    #[cfg(not(target_family = "wasm"))]
    pub(crate) fn park(&self, until: Option<Instant>) {
        let mut t = self.turn.lock().unwrap();
        let seen = t.events;
        t.serving += 1;
        self.turn_cv.notify_all();
        while t.events == seen {
            match until {
                Some(u) => {
                    let now = Instant::now();
                    if now >= u {
                        break;
                    }
                    t = self.event_cv.wait_timeout(t, u - now).unwrap().0;
                }
                None => t = self.event_cv.wait(t).unwrap(),
            }
        }
        let me = t.next;
        t.next += 1;
        while t.serving != me {
            t = self.turn_cv.wait(t).unwrap();
        }
    }

    /// Run `f` (which must not touch values) without the baton.
    #[cfg(not(target_family = "wasm"))]
    pub(crate) fn blocking<T>(&self, f: impl FnOnce() -> T) -> T {
        self.release();
        let r = f();
        self.acquire();
        r
    }

    /// Shared state changed: parked fibers become ready, to re-check.
    #[cfg(target_family = "wasm")]
    pub(crate) fn event(&self) {
        let mut f = self.fibers.lock().unwrap();
        let parked = std::mem::take(&mut f.parked);
        f.ready.extend(parked.into_iter().map(|(id, _)| id));
    }

    /// Switch to the next fiber until an event happens or `until` passes.
    #[cfg(target_family = "wasm")]
    pub(crate) fn park(&self, until: Option<Instant>) {
        let me = crate::fiber::current();
        self.fibers.lock().unwrap().parked.push((me, until));
        let next = self.next_fiber();
        crate::fiber::switch_to(next);
    }

    /// A fiber ready to run, after waiting for the earliest timer if none
    /// is. When every fiber waits for an event, none can happen (there are
    /// no sockets): a deadlock, which traps as in native programs.
    #[cfg(target_family = "wasm")]
    fn next_fiber(&self) -> usize {
        loop {
            let wait = {
                let mut f = self.fibers.lock().unwrap();
                if let Some(id) = f.ready.pop_front() {
                    return id;
                }
                let now = Instant::now();
                match f.parked.iter().filter_map(|p| p.1).min() {
                    None => {
                        drop(f);
                        let _ = std::io::stdout().flush();
                        eprintln!("fwp: trap: deadlock: every task is waiting");
                        std::process::exit(101);
                    }
                    Some(t) if t <= now => {
                        let parked = std::mem::take(&mut f.parked);
                        let (due, rest): (Vec<_>, Vec<_>) = parked
                            .into_iter()
                            .partition(|p| p.1.is_some_and(|u| u <= now));
                        f.parked = rest;
                        f.ready.extend(due.into_iter().map(|(id, _)| id));
                        continue;
                    }
                    Some(t) => t - now,
                }
            };
            crate::fiber::idle(wait.as_secs_f64() * 1000.0);
        }
    }

    /// Run `f` (WebAssembly has no sockets to wait for).
    #[cfg(target_family = "wasm")]
    pub(crate) fn blocking<T>(&self, f: impl FnOnce() -> T) -> T {
        f()
    }
}

pub struct TaskShared {
    cancelled: AtomicBool,
    deadline: Mutex<Option<Instant>>,
    st: Mutex<Baton<TaskState>>,
}

#[derive(Default)]
struct TaskState {
    done: bool,
    result: Option<Value>,
    children: Vec<Arc<TaskShared>>,
}

impl TaskShared {
    pub fn new() -> Arc<TaskShared> {
        Arc::new(TaskShared {
            cancelled: AtomicBool::new(false),
            deadline: Mutex::new(None),
            st: Mutex::new(Baton(TaskState::default())),
        })
    }

    pub(crate) fn cancel(&self) {
        self.cancelled.store(true, AO::SeqCst);
        let children: Vec<Arc<TaskShared>> = self.st.lock().unwrap().0.children.clone();
        for c in children {
            c.cancel();
        }
    }

    pub(crate) fn deadline(&self) -> Option<Instant> {
        *self.deadline.lock().unwrap()
    }

    pub(crate) fn done(&self) -> bool {
        self.st.lock().unwrap().0.done
    }
}

enum TaskBody {
    Thunk(Value),
    Rust(Box<dyn for<'x> FnOnce(&mut Interp<'x>)>),
}

pub struct ChanState {
    buf: VecDeque<Value>,
    cap: usize,
    closed: bool,
    /// A channel whose values go to a gRPC stream (a served function's
    /// `Channel[T]` parameter).
    pub(crate) sink: Option<Rc<crate::grpc::Sink>>,
}

impl ChanState {
    pub(crate) fn sink(s: crate::grpc::Sink) -> ChanState {
        ChanState {
            buf: VecDeque::new(),
            cap: 1,
            closed: false,
            sink: Some(Rc::new(s)),
        }
    }
}

/// Runtime objects behind opaque builtin types.
pub enum Native {
    Task(Arc<TaskShared>),
    Chan(RefCell<ChanState>),
    /// A listener, with the TLS context of its connections (`tls.listen`).
    Listener(RefCell<Option<TcpListener>>, Option<Rc<crate::tls::Ctx>>),
    /// A connection, with its TLS session if it has one: reads and writes
    /// go through the session.
    Conn(
        RefCell<Option<TcpStream>>,
        RefCell<Option<crate::tls::Session>>,
    ),
    Udp(RefCell<Option<UdpSocket>>),
    /// A gRPC call or a position in a received stream.
    Grpc(crate::grpc::Obj),
}

impl std::fmt::Debug for Native {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.write_str(self.describe())
    }
}

impl Native {
    pub fn describe(&self) -> &'static str {
        match self {
            Native::Task(_) => "<task>",
            Native::Chan(_) => "<channel>",
            Native::Listener(..) => "<listener>",
            Native::Conn(..) => "<connection>",
            Native::Udp(_) => "<udp socket>",
            Native::Grpc(_) => "<grpc stream>",
        }
    }
}

/// Process-wide: a shutdown signal (SIGINT/SIGTERM) arrived, or the
/// program requested a graceful shutdown.
static SHUTDOWN: AtomicBool = AtomicBool::new(false);
#[cfg(not(target_family = "wasm"))]
static SIGNALS: std::sync::Once = std::sync::Once::new();

#[cfg(not(target_family = "wasm"))]
extern "C" fn on_signal(_: i32) {
    SHUTDOWN.store(true, AO::SeqCst);
}

#[repr(C)]
struct PollFd {
    fd: i32,
    events: i16,
    revents: i16,
}

#[cfg(target_os = "linux")]
type NFds = std::ffi::c_ulong;
#[cfg(not(target_os = "linux"))]
type NFds = std::ffi::c_uint;

extern "C" {
    fn poll(fds: *mut PollFd, n: NFds, timeout: i32) -> i32;
    #[cfg(not(target_family = "wasm"))]
    fn signal(sig: i32, handler: extern "C" fn(i32)) -> usize;
}

const POLLIN: i16 = 1;
const POLLOUT: i16 = 4;

pub(crate) fn poll_fd(fd: i32, write: bool, ms: i32) -> bool {
    let mut p = PollFd {
        fd,
        events: if write { POLLOUT } else { POLLIN },
        revents: 0,
    };
    unsafe { poll(&mut p, 1, ms) > 0 }
}

/// Output shared with the root task's writer.
struct Forward<'p>(*mut (dyn Write + 'p));

impl Write for Forward<'_> {
    fn write(&mut self, buf: &[u8]) -> std::io::Result<usize> {
        unsafe { (*self.0).write(buf) }
    }
    fn flush(&mut self) -> std::io::Result<()> {
        unsafe { (*self.0).flush() }
    }
}

fn duration_of(v: &Value) -> Duration {
    let nanos = match v {
        Value::Record(fs) => fs[0].as_i128().unwrap_or(0),
        _ => 0,
    };
    Duration::from_nanos(nanos.max(0) as u64)
}

/// The instant a duration from now; durations too long to represent
/// saturate (to about a century) instead of overflowing.
fn after(d: &Value) -> Instant {
    let now = Instant::now();
    now.checked_add(duration_of(d))
        .or_else(|| now.checked_add(Duration::from_secs(100 * 365 * 86400)))
        .unwrap_or(now)
}

fn earliest(a: Option<Instant>, b: Option<Instant>) -> Option<Instant> {
    match (a, b) {
        (Some(x), Some(y)) => Some(x.min(y)),
        (x, None) => x,
        (None, y) => y,
    }
}

/// Reject what the native runtime rejects: an empty host, or a port that
/// is not a decimal number up to 65535 (Rust alone would accept `+80`,
/// and look up an empty host).
fn check_addr(addr: &str) -> Result<(), String> {
    let ok = match addr.rsplit_once(':') {
        Some((host, port)) => {
            !host.is_empty()
                && host != "[]"
                && !port.is_empty()
                && port.len() <= 5
                && port.bytes().all(|c| c.is_ascii_digit())
                && port.parse::<u32>().is_ok_and(|p| p <= 65535)
        }
        None => false,
    };
    if ok {
        Ok(())
    } else {
        Err(format!("{}: invalid socket address", addr))
    }
}

/// A plain socket's read or write as a TLS session's would be.
fn plain_io(r: std::io::Result<usize>, write: bool) -> Io {
    match r {
        Ok(k) => Io::Done(k),
        Err(e) if e.kind() == std::io::ErrorKind::WouldBlock => Io::Wait(write),
        Err(e) => Io::Err(e),
    }
}

pub(crate) fn native(v: &Value) -> R<&Native> {
    match v {
        Value::Native(n) => Ok(n),
        _ => Err(Ctl::Trap("internal: not a runtime object".into())),
    }
}

pub(crate) fn opt(v: Option<Value>) -> Value {
    match v {
        Some(x) => Value::data(1, vec![x]),
        None => Value::data(0, vec![]),
    }
}

pub(crate) fn wrap(n: Native) -> Value {
    Value::Native(Rc::new(n))
}

/// Run a task's body with the baton, wait for its children and record its
/// result; a failure that is not a cancellation ends the process.
fn run_task(mut it: Interp<'static>, body: TaskBody, world: &World) {
    let result = match body {
        TaskBody::Thunk(thunk) => match it.apply(thunk, vec![Value::unit()]) {
            Ok(v) => Some(v),
            Err(Ctl::Cancelled) => None,
            Err(e) => {
                let _ = it.out.flush();
                let code = crate::interp::report(&Err(e), it.prog);
                std::process::exit(code);
            }
        },
        TaskBody::Rust(f) => {
            f(&mut it);
            None
        }
    };
    it.join_children();
    let task = it.task.clone();
    drop(it);
    {
        let mut st = task.st.lock().unwrap();
        st.0.done = true;
        st.0.result = result;
    }
    drop(task);
    world.event();
}

impl<'p> Interp<'p> {
    /// Cancel the current task if its deadline passed; unwind if cancelled.
    pub(crate) fn check_cancel(&self) -> R<()> {
        if let Some(d) = self.task.deadline() {
            if Instant::now() >= d && !self.task.cancelled.load(AO::SeqCst) {
                self.task.cancel();
                self.world.event();
            }
        }
        if self.task.cancelled.load(AO::SeqCst) {
            return Err(Ctl::Cancelled);
        }
        Ok(())
    }

    /// Wait until `ready` produces a value; `None` when `timeout` passes.
    fn block_on(
        &mut self,
        timeout: Option<Instant>,
        mut ready: impl FnMut(&mut Self) -> R<Option<Value>>,
    ) -> R<Option<Value>> {
        loop {
            if let Some(v) = ready(self)? {
                return Ok(Some(v));
            }
            self.check_cancel()?;
            if let Some(t) = timeout {
                if Instant::now() >= t {
                    return Ok(None);
                }
            }
            let until = earliest(timeout, self.task.deadline());
            self.world.park(until);
        }
    }

    /// Wait until a socket is ready, or for one short slice (so that
    /// cancellation is noticed promptly); `false` when `timeout` passed.
    /// Callers retry their operation either way, and so also notice a
    /// socket that another task closed meanwhile (whose descriptor number
    /// may already belong to a new socket).
    pub(crate) fn wait_fd(&mut self, fd: i32, write: bool, timeout: Option<Instant>) -> R<bool> {
        self.check_cancel()?;
        let now = Instant::now();
        if let Some(t) = timeout {
            if now >= t {
                return Ok(false);
            }
        }
        let mut slice = Duration::from_millis(50);
        if let Some(u) = earliest(timeout, self.task.deadline()) {
            slice = slice.min(u.saturating_duration_since(now));
        }
        let ms = slice.as_millis().max(1) as i32;
        self.world.blocking(|| poll_fd(fd, write, ms));
        Ok(true)
    }

    /// Wait for all children of the current task. Cancellation of this task
    /// (or its deadline) cancels them; waiting continues until they unwound.
    pub fn join_children(&mut self) {
        loop {
            let pending = {
                let mut st = self.task.st.lock().unwrap();
                st.0.children.retain(|c| !c.done());
                !st.0.children.is_empty()
            };
            if !pending {
                return;
            }
            let until = self.deadline_or_cancel();
            self.world.park(until);
        }
    }

    /// Cancel the task when its deadline passed; the instant to wake at
    /// for the deadline otherwise.
    fn deadline_or_cancel(&self) -> Option<Instant> {
        if self.task.cancelled.load(AO::SeqCst) {
            return None;
        }
        let d = self.task.deadline()?;
        if Instant::now() >= d {
            self.task.cancel();
            self.world.event();
            return None;
        }
        Some(d)
    }

    /// Cancel every child of the current task and wait for them.
    pub fn cancel_children(&mut self) {
        let children = self.task.st.lock().unwrap().0.children.clone();
        for c in children {
            c.cancel();
        }
        self.world.event();
        self.join_children();
    }

    fn spawn(&mut self, thunk: Value, deadline: Option<Instant>) -> Arc<TaskShared> {
        self.spawn_body(TaskBody::Thunk(thunk), deadline, false)
    }

    /// Start a task running Rust code (gRPC connections and calls). A
    /// detached task is not a child of the current one: nothing waits for
    /// it or cancels it.
    pub(crate) fn spawn_rust(
        &mut self,
        body: Box<dyn for<'x> FnOnce(&mut Interp<'x>)>,
        deadline: Option<Instant>,
        detached: bool,
    ) -> Arc<TaskShared> {
        self.spawn_body(TaskBody::Rust(body), deadline, detached)
    }

    fn spawn_body(
        &mut self,
        body: TaskBody,
        deadline: Option<Instant>,
        detached: bool,
    ) -> Arc<TaskShared> {
        #[cfg(target_family = "wasm")]
        if !crate::fiber::available() {
            // No fibers: `fwp run` rejects programs with tasks before they
            // start (`driver::wasm_host_unsupported`); this is the last
            // line of defense (a task started by `comptime` code).
            let _ = self.out.flush();
            eprintln!("fwp: trap: {}", crate::driver::WASM_NO_TASKS);
            std::process::exit(101);
        }
        let task = TaskShared::new();
        *task.deadline.lock().unwrap() = deadline;
        if !detached {
            if self.task.cancelled.load(AO::SeqCst) {
                task.cancelled.store(true, AO::SeqCst);
            }
            {
                let mut st = self.task.st.lock().unwrap();
                st.0.children.retain(|c| !c.done());
                st.0.children.push(task.clone());
            }
            if let Some(frame) = self.scopes.last_mut() {
                frame.push(task.clone());
            }
        }
        let child = Interp {
            prog: self.prog,
            cafs: self.cafs.clone(),
            state: Vec::new(),
            rng: self.rng ^ (Arc::as_ptr(&task) as u64).rotate_left(17),
            out: Box::new(Forward(self.root_out)),
            args: self.args.clone(),
            world: self.world.clone(),
            task: task.clone(),
            root_out: self.root_out,
            scopes: Vec::new(),
            ffi: self.ffi.clone(),
            grpc: self.grpc.clone(),
        };
        // The baton guarantees exclusive access; the parent outlives its
        // children because every task joins its children before finishing.
        let child: Interp<'static> = unsafe { std::mem::transmute(child) };
        let job = Baton((child, body));
        let world = self.world.clone();
        #[cfg(target_family = "wasm")]
        {
            let id = crate::fiber::spawn(Box::new(move || {
                let Baton((it, body)) = job;
                run_task(it, body, &world);
                world.next_fiber()
            }));
            self.world.fibers.lock().unwrap().ready.push_back(id);
        }
        #[cfg(not(target_family = "wasm"))]
        {
            let started = std::thread::Builder::new()
                .stack_size(256 << 20)
                .spawn(move || {
                    crate::interp::set_stack_limit(256 << 20);
                    let job = job;
                    let Baton((it, body)) = job;
                    world.acquire();
                    run_task(it, body, &world);
                    world.release();
                });
            if started.is_err() {
                // Out of threads: report like a trap.
                eprintln!("fwp: trap: cannot start a task thread");
                std::process::exit(101);
            }
        }
        task
    }

    fn io_err(&self, kind: &str, msg: impl std::fmt::Display) -> Ctl {
        let mt = MT::Con("std::IoError".into(), vec![]);
        Ctl::Fail(
            Value::tuple(vec![Value::str(kind), Value::str(&msg.to_string())]),
            mt,
        )
    }

    fn conn<'a>(&self, v: &'a Value) -> R<&'a RefCell<Option<TcpStream>>> {
        Ok(self.conn_tls(v)?.0)
    }

    /// A connection and its TLS session.
    #[allow(clippy::type_complexity)]
    fn conn_tls<'a>(
        &self,
        v: &'a Value,
    ) -> R<(
        &'a RefCell<Option<TcpStream>>,
        &'a RefCell<Option<crate::tls::Session>>,
    )> {
        match native(v)? {
            Native::Conn(c, t) => Ok((c, t)),
            _ => Err(Ctl::Trap("internal: not a connection".into())),
        }
    }

    /// Read from a connection, through its TLS session if it has one.
    fn sock_read(&self, c: &Value, buf: &mut [u8]) -> R<Io> {
        let (st, tl) = self.conn_tls(c)?;
        if let Some(s) = tl.borrow_mut().as_mut() {
            return Ok(s.read(buf));
        }
        match st.borrow_mut().as_mut() {
            Some(s) => Ok(plain_io(s.read(buf), false)),
            None => Err(self.io_err("closed", "connection is closed")),
        }
    }

    /// Write to a connection, through its TLS session if it has one.
    fn sock_write(&self, c: &Value, data: &[u8]) -> R<Io> {
        let (st, tl) = self.conn_tls(c)?;
        if let Some(s) = tl.borrow_mut().as_mut() {
            return Ok(s.write(data));
        }
        match st.borrow_mut().as_mut() {
            Some(s) => Ok(match s.write(data) {
                Ok(0) => Io::Err(std::io::Error::other("connection closed by peer")),
                r => plain_io(r, true),
            }),
            None => Err(self.io_err("closed", "connection is closed")),
        }
    }

    /// Finish a connection's TLS handshake (nothing for plain connections
    /// and finished handshakes).
    fn tls_handshake(&mut self, c: &Value, timeout: Option<Instant>, what: &str) -> R<bool> {
        loop {
            let fd = self.conn_fd(c)?;
            let r = match self.conn_tls(c)?.1.borrow_mut().as_mut() {
                Some(s) if !s.handshaken() => s.handshake(),
                _ => return Ok(true),
            };
            match r {
                Io::Done(_) => return Ok(true),
                Io::Wait(w) => {
                    if !self.wait_fd(fd, w, timeout)? {
                        return Ok(false);
                    }
                }
                Io::Err(e) => return Err(self.io_err("tls", format!("{}{}", what, e))),
                Io::Fail(m) => return Err(self.io_err("tls", format!("{}{}", what, m))),
            }
        }
    }

    fn conn_fd(&self, v: &Value) -> R<i32> {
        match self.conn(v)?.borrow().as_ref() {
            Some(s) => Ok(s.as_raw_fd()),
            None => Err(self.io_err("closed", "connection is closed")),
        }
    }

    /// Read up to `n` bytes; `None` when `timeout` passes first.
    fn tcp_read(&mut self, n: usize, c: &Value, timeout: Option<Instant>) -> R<Option<Value>> {
        let mut buf = vec![0u8; n.max(1)];
        loop {
            let fd = self.conn_fd(c)?;
            match self.sock_read(c, &mut buf)? {
                Io::Done(k) => return Ok(Some(Value::Bytes(Rc::from(&buf[..k])))),
                Io::Wait(w) => {
                    if !self.wait_fd(fd, w, timeout)? {
                        return Ok(None);
                    }
                }
                Io::Err(e) if e.kind() == std::io::ErrorKind::Interrupted => {}
                Io::Err(e) => return Err(self.io_err("read", e)),
                Io::Fail(m) => return Err(self.io_err("tls", m)),
            }
        }
    }

    /// Write all of `data`; a "timeout" error when `timeout` passes first.
    fn tcp_write(&mut self, data: &[u8], c: &Value, timeout: Option<Instant>) -> R<()> {
        let mut off = 0;
        while off < data.len() {
            let fd = self.conn_fd(c)?;
            match self.sock_write(c, &data[off..])? {
                Io::Done(k) => off += k,
                Io::Wait(w) => {
                    if !self.wait_fd(fd, w, timeout)? {
                        return Err(self.io_err("timeout", "write timed out"));
                    }
                }
                Io::Err(e) if e.kind() == std::io::ErrorKind::Interrupted => {}
                Io::Err(e) => return Err(self.io_err("write", e)),
                Io::Fail(m) => return Err(self.io_err("tls", m)),
            }
        }
        Ok(())
    }

    fn accept(&mut self, l: &Value, timeout: Option<Instant>) -> R<Option<Value>> {
        let Native::Listener(cell, ctx) = native(l)? else {
            return Err(Ctl::Trap("internal: not a listener".into()));
        };
        loop {
            let (fd, r) = match cell.borrow().as_ref() {
                Some(l) => (l.as_raw_fd(), l.accept()),
                None => return Err(self.io_err("closed", "listener is closed")),
            };
            match r {
                Ok((s, _)) => {
                    let _ = s.set_nonblocking(true);
                    let _ = s.set_nodelay(true);
                    // a TLS connection's handshake happens on its first
                    // read or write, in the task that serves it
                    let session = match ctx {
                        Some(ctx) => Some(
                            crate::tls::Session::server(ctx, s.as_raw_fd())
                                .map_err(|e| self.io_err("tls", e))?,
                        ),
                        None => None,
                    };
                    return Ok(Some(wrap(Native::Conn(
                        RefCell::new(Some(s)),
                        RefCell::new(session),
                    ))));
                }
                Err(e) if e.kind() == std::io::ErrorKind::WouldBlock => {
                    if !self.wait_fd(fd, false, timeout)? {
                        return Ok(None);
                    }
                }
                Err(e) if e.kind() == std::io::ErrorKind::Interrupted => {}
                Err(e) => return Err(self.io_err("accept", e)),
            }
        }
    }

    fn udp<'a>(&self, v: &'a Value) -> R<&'a RefCell<Option<UdpSocket>>> {
        match native(v)? {
            Native::Udp(c) => Ok(c),
            _ => Err(Ctl::Trap("internal: not a UDP socket".into())),
        }
    }

    /// Primitives of `task`, `channel`, `tcp`, `udp`, `dns`, `signal` and
    /// `metrics`. `None` if `sym` is not one of them.
    pub(crate) fn prim_conc(&mut self, sym: &str, a: &mut [Value]) -> Option<R<Value>> {
        let now = Instant::now;
        // `Ok(None)`: not one of these primitives
        let r = (|| -> R<Option<Value>> {
            Ok(Some(match sym {
                // ----- tasks
                "task.spawn" => {
                    let t = self.spawn(a[0].clone(), None);
                    wrap(Native::Task(t))
                }
                "task.within" => {
                    let d = after(&a[0]);
                    let t = self.spawn(a[1].clone(), Some(d));
                    self.await_task(&t)?
                }
                "task.await" => {
                    let Native::Task(t) = native(&a[0])? else {
                        return Err(Ctl::Trap("internal: not a task".into()));
                    };
                    let t = t.clone();
                    self.await_task(&t)?
                }
                "task.cancel" => {
                    if let Native::Task(t) = native(&a[0])? {
                        t.cancel();
                    }
                    self.world.event();
                    Value::unit()
                }
                "task.sleep" => {
                    let until = after(&a[0]);
                    self.block_on(Some(until), |_| Ok(None))?;
                    Value::unit()
                }
                "task.yield" => {
                    self.check_cancel()?;
                    self.world.park(Some(now()));
                    self.check_cancel()?;
                    Value::unit()
                }
                "task.deadline" => {
                    let d = after(&a[0]);
                    let mut cur = self.task.deadline.lock().unwrap();
                    *cur = earliest(*cur, Some(d));
                    a[1].clone()
                }
                "task.cancelled" => {
                    if let Some(d) = self.task.deadline() {
                        if now() >= d && !self.task.cancelled.load(AO::SeqCst) {
                            self.task.cancel();
                            self.world.event();
                        }
                    }
                    Value::bool(self.task.cancelled.load(AO::SeqCst))
                }
                "task.scope" => {
                    self.scopes.push(Vec::new());
                    let r = self.apply(a[0].clone(), vec![Value::unit()]);
                    let frame = self.scopes.pop().unwrap_or_default();
                    if r.is_err() {
                        for t in &frame {
                            t.cancel();
                        }
                        self.world.event();
                    }
                    // Wait for the scope's tasks (they may outlive a
                    // cancellation of this task only until they unwind).
                    loop {
                        if frame.iter().all(|t| t.done()) {
                            break;
                        }
                        let until = self.deadline_or_cancel();
                        self.world.park(until);
                    }
                    r?
                }
                // ----- channels
                "channel.make" => {
                    let cap = a[0].as_i128().unwrap_or(1).max(1) as usize;
                    wrap(Native::Chan(RefCell::new(ChanState {
                        buf: VecDeque::new(),
                        cap,
                        closed: false,
                        sink: None,
                    })))
                }
                "channel.send" => {
                    let ch = a[0].clone();
                    let x = a[1].clone();
                    if let Native::Chan(c) = native(&ch)? {
                        let sink = c.borrow().sink.clone();
                        if let Some(s) = sink {
                            let closed = c.borrow().closed;
                            return Ok(Some(Value::bool(
                                !closed && crate::grpc::sink_send(self, &s, x)?,
                            )));
                        }
                    }
                    let r = self.block_on(None, |it| {
                        let Native::Chan(c) = native(&ch)? else {
                            return Err(Ctl::Trap("internal: not a channel".into()));
                        };
                        let mut c = c.borrow_mut();
                        if c.closed {
                            return Ok(Some(Value::bool(false)));
                        }
                        if c.buf.len() < c.cap {
                            c.buf.push_back(x.clone());
                            it.world.event();
                            return Ok(Some(Value::bool(true)));
                        }
                        Ok(None)
                    })?;
                    r.unwrap_or_else(|| Value::bool(false))
                }
                "channel.recv" | "channel.recv-for" => {
                    let (ch, timeout) = if sym == "channel.recv" {
                        (a[0].clone(), None)
                    } else {
                        (a[1].clone(), Some(after(&a[0])))
                    };
                    let r = self.block_on(timeout, |it| {
                        let Native::Chan(c) = native(&ch)? else {
                            return Err(Ctl::Trap("internal: not a channel".into()));
                        };
                        let mut c = c.borrow_mut();
                        if let Some(x) = c.buf.pop_front() {
                            it.world.event();
                            return Ok(Some(opt(Some(x))));
                        }
                        if c.closed || c.sink.is_some() {
                            return Ok(Some(opt(None)));
                        }
                        Ok(None)
                    })?;
                    r.unwrap_or_else(|| opt(None))
                }
                "channel.close" => {
                    if let Native::Chan(c) = native(&a[0])? {
                        c.borrow_mut().closed = true;
                    }
                    self.world.event();
                    Value::unit()
                }
                // ----- TCP
                "tcp.listen" => {
                    let addr = a[0].as_str().to_string();
                    check_addr(&addr).map_err(|e| self.io_err("listen", e))?;
                    let l = TcpListener::bind(&addr)
                        .map_err(|e| self.io_err("listen", format!("{}: {}", addr, e)))?;
                    l.set_nonblocking(true)
                        .map_err(|e| self.io_err("listen", e))?;
                    wrap(Native::Listener(RefCell::new(Some(l)), None))
                }
                "tcp.local-addr" => {
                    let Native::Listener(l, _) = native(&a[0])? else {
                        return Err(Ctl::Trap("internal: not a listener".into()));
                    };
                    let s = l
                        .borrow()
                        .as_ref()
                        .and_then(|l| l.local_addr().ok())
                        .map(|a| a.to_string())
                        .unwrap_or_default();
                    Value::str(&s)
                }
                "tcp.accept" => {
                    let l = a[0].clone();
                    self.accept(&l, None)?.unwrap_or_else(Value::unit)
                }
                "tcp.accept-for" => {
                    let l = a[1].clone();
                    let t = after(&a[0]);
                    opt(self.accept(&l, Some(t))?)
                }
                "tcp.stop" => {
                    if let Native::Listener(l, _) = native(&a[0])? {
                        l.borrow_mut().take();
                    }
                    Value::unit()
                }
                "tcp.connect" => {
                    let addr = a[0].as_str().to_string();
                    check_addr(&addr).map_err(|e| self.io_err("connect", e))?;
                    self.check_cancel()?;
                    let r = self.world.blocking(|| TcpStream::connect(&addr));
                    let s = r.map_err(|e| self.io_err("connect", format!("{}: {}", addr, e)))?;
                    let _ = s.set_nonblocking(true);
                    let _ = s.set_nodelay(true);
                    wrap(Native::Conn(RefCell::new(Some(s)), RefCell::new(None)))
                }
                "tcp.read" => {
                    let n = a[0].as_i128().unwrap_or(0).max(1) as usize;
                    let c = a[1].clone();
                    self.tcp_read(n, &c, None)?.unwrap_or_else(Value::unit)
                }
                "tcp.read-for" => {
                    let t = after(&a[0]);
                    let n = a[1].as_i128().unwrap_or(0).max(1) as usize;
                    let c = a[2].clone();
                    opt(self.tcp_read(n, &c, Some(t))?)
                }
                "tcp.write" | "tcp.write-for" => {
                    let (timeout, a) = if sym == "tcp.write" {
                        (None, &a[..])
                    } else {
                        (Some(after(&a[0])), &a[1..])
                    };
                    let data = match &a[0] {
                        Value::Bytes(b) => b.clone(),
                        Value::Str(s) => Rc::from(s.as_bytes()),
                        _ => Rc::from(&[][..]),
                    };
                    let c = a[1].clone();
                    self.tcp_write(&data, &c, timeout)?;
                    Value::unit()
                }
                "tcp.close" => {
                    if let Some(mut t) = self.conn_tls(&a[0])?.1.borrow_mut().take() {
                        t.shutdown();
                    }
                    if let Some(s) = self.conn(&a[0])?.borrow_mut().take() {
                        let _ = s.shutdown(std::net::Shutdown::Both);
                    }
                    Value::unit()
                }
                "tcp.peer-addr" => {
                    let s = self
                        .conn(&a[0])?
                        .borrow()
                        .as_ref()
                        .and_then(|s| s.peer_addr().ok())
                        .map(|a| a.to_string())
                        .unwrap_or_default();
                    Value::str(&s)
                }
                // ----- TLS
                "tls._connect" => {
                    // CA file, insecure, server name, protocols, client
                    // certificate and key, address
                    let addr = a[6].as_str().to_string();
                    check_addr(&addr).map_err(|e| self.io_err("connect", e))?;
                    crate::tls::check().map_err(|e| self.io_err("tls", e))?;
                    self.check_cancel()?;
                    let r = self.world.blocking(|| TcpStream::connect(&addr));
                    let s = r.map_err(|e| self.io_err("connect", format!("{}: {}", addr, e)))?;
                    let _ = s.set_nonblocking(true);
                    let _ = s.set_nodelay(true);
                    let alpn: Vec<String> = a[3]
                        .list_items()
                        .iter()
                        .map(|v| v.as_str().to_string())
                        .collect();
                    let name = match a[2].as_str() {
                        "" => crate::tls::host_of(&addr).to_string(),
                        n => n.to_string(),
                    };
                    let session = crate::tls::Session::client(
                        s.as_raw_fd(),
                        &crate::tls::ClientOpts {
                            ca: a[0].as_str(),
                            verify: !a[1].as_bool(),
                            name: &name,
                            alpn: &alpn,
                            cert: a[4].as_str(),
                            key: a[5].as_str(),
                        },
                    )
                    .map_err(|e| self.io_err("tls", format!("{}: {}", addr, e)))?;
                    let c = wrap(Native::Conn(
                        RefCell::new(Some(s)),
                        RefCell::new(Some(session)),
                    ));
                    self.tls_handshake(&c, None, &format!("{}: ", addr))?;
                    c
                }
                "tls._listen" => {
                    // certificate, key, protocols, client CA, address
                    let alpn: Vec<String> = a[2]
                        .list_items()
                        .iter()
                        .map(|v| v.as_str().to_string())
                        .collect();
                    let ctx =
                        crate::tls::server_ctx(a[0].as_str(), a[1].as_str(), &alpn, a[3].as_str())
                            .map_err(|e| self.io_err("tls", e))?;
                    let addr = a[4].as_str().to_string();
                    check_addr(&addr).map_err(|e| self.io_err("listen", e))?;
                    let l = TcpListener::bind(&addr)
                        .map_err(|e| self.io_err("listen", format!("{}: {}", addr, e)))?;
                    l.set_nonblocking(true)
                        .map_err(|e| self.io_err("listen", e))?;
                    wrap(Native::Listener(RefCell::new(Some(l)), Some(Rc::new(ctx))))
                }
                "tls.handshake" => {
                    let c = a[0].clone();
                    self.tls_handshake(&c, None, "")?;
                    Value::unit()
                }
                "tls.alpn" => {
                    let s = match self.conn_tls(&a[0])?.1.borrow().as_ref() {
                        Some(s) => s.alpn(),
                        None => String::new(),
                    };
                    Value::str(&s)
                }
                "tls.secure" => Value::bool(self.conn_tls(&a[0])?.1.borrow().is_some()),
                "tls.peer-subject" => {
                    let s = match self.conn_tls(&a[0])?.1.borrow().as_ref() {
                        Some(s) => s.peer_subject(),
                        None => None,
                    };
                    opt(s.map(|s| Value::str(&s)))
                }
                "tls.available" => Value::bool(crate::tls::available()),
                // ----- UDP
                "udp.bind" => {
                    let addr = a[0].as_str().to_string();
                    check_addr(&addr).map_err(|e| self.io_err("bind", e))?;
                    let s = UdpSocket::bind(&addr)
                        .map_err(|e| self.io_err("bind", format!("{}: {}", addr, e)))?;
                    s.set_nonblocking(true)
                        .map_err(|e| self.io_err("bind", e))?;
                    wrap(Native::Udp(RefCell::new(Some(s))))
                }
                "udp.local-addr" => {
                    let s = self
                        .udp(&a[0])?
                        .borrow()
                        .as_ref()
                        .and_then(|s| s.local_addr().ok())
                        .map(|a| a.to_string())
                        .unwrap_or_default();
                    Value::str(&s)
                }
                "udp.send-to" => {
                    let addr = a[0].as_str().to_string();
                    check_addr(&addr).map_err(|e| self.io_err("send", e))?;
                    let data = match &a[1] {
                        Value::Bytes(b) => b.clone(),
                        _ => Rc::from(&[][..]),
                    };
                    let sock = a[2].clone();
                    loop {
                        let cell = self.udp(&sock)?;
                        let (fd, r) = match cell.borrow().as_ref() {
                            Some(s) => (s.as_raw_fd(), s.send_to(&data, &addr)),
                            None => return Err(self.io_err("closed", "socket is closed")),
                        };
                        match r {
                            Ok(_) => break,
                            Err(e) if e.kind() == std::io::ErrorKind::WouldBlock => {
                                self.wait_fd(fd, true, None)?;
                            }
                            Err(e) => return Err(self.io_err("send", format!("{}: {}", addr, e))),
                        }
                    }
                    Value::unit()
                }
                "udp.recv-from" => {
                    let n = a[0].as_i128().unwrap_or(0).max(1) as usize;
                    let sock = a[1].clone();
                    let mut buf = vec![0u8; n];
                    loop {
                        let cell = self.udp(&sock)?;
                        let (fd, r) = match cell.borrow().as_ref() {
                            Some(s) => (s.as_raw_fd(), s.recv_from(&mut buf)),
                            None => return Err(self.io_err("closed", "socket is closed")),
                        };
                        match r {
                            Ok((k, from)) => {
                                break Value::tuple(vec![
                                    Value::Bytes(Rc::from(&buf[..k])),
                                    Value::str(&from.to_string()),
                                ])
                            }
                            Err(e) if e.kind() == std::io::ErrorKind::WouldBlock => {
                                self.wait_fd(fd, false, None)?;
                            }
                            Err(e) => return Err(self.io_err("receive", e)),
                        }
                    }
                }
                "udp.close" => {
                    self.udp(&a[0])?.borrow_mut().take();
                    Value::unit()
                }
                // ----- DNS
                "dns.resolve" => {
                    let host = a[0].as_str().to_string();
                    self.check_cancel()?;
                    let r = self.world.blocking(|| {
                        (host.as_str(), 0)
                            .to_socket_addrs()
                            .map(|i| i.collect::<Vec<_>>())
                    });
                    let addrs =
                        r.map_err(|e| self.io_err("resolve", format!("{}: {}", host, e)))?;
                    let mut seen: Vec<String> = Vec::new();
                    for x in addrs {
                        let ip = x.ip().to_string();
                        if !seen.contains(&ip) {
                            seen.push(ip);
                        }
                    }
                    Value::list(seen.iter().map(|s| Value::str(s)).collect())
                }
                // ----- signals
                "signal.shutdown-requested" => {
                    // WebAssembly has no signals: only a requested shutdown
                    #[cfg(not(target_family = "wasm"))]
                    SIGNALS.call_once(|| unsafe {
                        signal(2, on_signal);
                        signal(15, on_signal);
                    });
                    Value::bool(SHUTDOWN.load(AO::SeqCst))
                }
                "signal.request-shutdown" => {
                    SHUTDOWN.store(true, AO::SeqCst);
                    Value::unit()
                }
                // ----- metrics
                "metrics.add" | "metrics.set" | "metrics.observe" => {
                    let name = a[0].as_str().to_string();
                    let x = a[1].as_f64().unwrap_or(0.0);
                    let mut m = self.world.metrics.lock().unwrap();
                    match sym {
                        "metrics.add" => m.entry(name).or_insert(("counter", 0.0)).1 += x,
                        "metrics.set" => {
                            m.insert(name, ("gauge", x));
                        }
                        _ => {
                            m.entry(format!("{}_count", name))
                                .or_insert(("summary", 0.0))
                                .1 += 1.0;
                            m.entry(format!("{}_sum", name))
                                .or_insert(("summary", 0.0))
                                .1 += x;
                        }
                    }
                    Value::unit()
                }
                "metrics.snapshot" => {
                    let m = self.world.metrics.lock().unwrap();
                    Value::list(
                        m.iter()
                            .map(|(k, (kind, x))| {
                                Value::tuple(vec![Value::str(k), Value::str(kind), Value::F64(*x)])
                            })
                            .collect(),
                    )
                }
                _ => return Ok(None),
            }))
        })();
        r.transpose()
    }

    fn await_task(&mut self, t: &Arc<TaskShared>) -> R<Value> {
        let t = t.clone();
        let r = self.block_on(None, |_| {
            let st = t.st.lock().unwrap();
            if st.0.done {
                return Ok(Some(opt(st.0.result.clone())));
            }
            Ok(None)
        })?;
        Ok(r.unwrap_or_else(|| opt(None)))
    }
}
