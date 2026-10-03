//! gRPC for the interpreter (docs/grpc.md): HTTP/2 connections and streams
//! on the task scheduler, the client stubs of split builds, servers of
//! exported functions (`fwp serve`, `--grpc`) and of `GrpcRoute`s
//! (`grpc.serve`), streaming, deadlines, metadata, health checking and
//! server reflection, and the `grpc.*` and `pb.*` primitives. The C runtime
//! implements the same in `runtime/fwp_rt_grpc.c`.
//!
//! Every connection has a reader task and a writer task. The reader parses
//! frames, updates the streams and wakes the tasks waiting on them; on a
//! server it starts a task per call. Writers of frames append to the
//! connection's output buffer, which the writer task sends. A call waits
//! only in its own task: other tasks run meanwhile, many calls share a
//! connection, and a server runs its calls concurrently.
//!
//! Tasks of the interpreter take turns holding a baton (`sched.rs`), so the
//! shared state here (`Rc<RefCell<..>>`) is only touched by the holder.
//! No borrow is held across a point where the baton may be handed on.

use std::cell::RefCell;
use std::collections::{BTreeMap, HashMap, VecDeque};
use std::io::{Read, Write};
use std::net::{TcpListener, TcpStream};
use std::os::fd::AsRawFd;
use std::rc::Rc;
use std::sync::Arc;
use std::time::{Duration, Instant};

use crate::h2::{self, hpack, Frame, Peer};
use crate::interp::{Ctl, Interp, R};
use crate::ir::{FuncId, Program, RemoteFn, MT};
use crate::proto::{self, Reader};
use crate::protobuf::{MethodSchema, NodeId, Schema};
use crate::rpc::{self, Input, Output, Shape};
use crate::sched::{native, opt, poll_fd, wrap, ChanState, Native, TaskShared};
use crate::tls::{self, Io};
use crate::value::{Closure, Value};

pub use h2::{
    CANCELLED, DEADLINE_EXCEEDED, FAILED_PRECONDITION, INTERNAL, INVALID_ARGUMENT, NOT_FOUND, OK,
    UNAVAILABLE, UNIMPLEMENTED, UNKNOWN,
};

/// Frames waiting in a connection's output beyond which senders of data
/// wait for the writer.
const OUT_LIMIT: usize = 1 << 20;

const REFLECTION_V1: &str = "/grpc.reflection.v1.ServerReflection/ServerReflectionInfo";
const REFLECTION_V1ALPHA: &str = "/grpc.reflection.v1alpha.ServerReflection/ServerReflectionInfo";
const HEALTH_CHECK: &str = "/grpc.health.v1.Health/Check";
const HEALTH_WATCH: &str = "/grpc.health.v1.Health/Watch";

/// Request headers that are not metadata.
const NOT_METADATA: &[&str] = &[
    "content-type",
    "te",
    "grpc-timeout",
    "grpc-encoding",
    "grpc-accept-encoding",
    "fwp-fingerprint",
];

// ================================================================= state

/// A gRPC status.
#[derive(Clone, Debug)]
pub struct Status {
    pub code: u32,
    pub message: String,
}

impl Status {
    fn new(code: u32, message: impl Into<String>) -> Status {
        Status {
            code,
            message: message.into(),
        }
    }
}

/// Program-wide state: client connections by address.
#[derive(Default)]
pub struct Shared {
    pool: HashMap<String, ConnRef>,
}

/// The gRPC context of a task, inherited by the tasks it starts.
#[derive(Clone, Default)]
pub struct TaskCtx {
    /// Metadata added to the calls made (`grpc.with-metadata`).
    metadata: Rc<Vec<(String, String)>>,
    /// The deadline of the calls made (`grpc.with-deadline`).
    deadline: Option<Instant>,
    /// The call this task serves.
    serving: Option<Rc<Serving>>,
    /// How the calls made connect over TLS (`grpc.with-tls`).
    tls: Option<Rc<ClientTls>>,
    /// The response metadata of the calls made, collected
    /// (`grpc.with-response-metadata`).
    capture: Option<Captured>,
    /// The calls made compress their requests (`grpc.with-gzip`).
    gzip: bool,
}

/// Response metadata collected by `grpc.with-response-metadata`.
type Captured = Rc<RefCell<Vec<(String, String)>>>;

/// Response headers and trailers that are not metadata.
const NOT_RESPONSE_METADATA: &[&str] = &[
    "content-type",
    "grpc-status",
    "grpc-message",
    "grpc-encoding",
    "grpc-accept-encoding",
];

/// The metadata of a response: its headers and trailers but the
/// pseudo-headers and those of the protocol.
fn response_metadata(s: &Stream) -> Vec<(String, String)> {
    s.headers
        .iter()
        .chain(&s.trailers)
        .filter(|(k, _)| !k.starts_with(':') && !NOT_RESPONSE_METADATA.contains(&k.as_str()))
        .cloned()
        .collect()
}

/// A metadata pair as a header: a lower-case name, a value without line
/// breaks; `None` for names that cannot be metadata.
fn metadata_pair(k: &str, v: &str) -> Option<(String, String)> {
    let k = k.to_ascii_lowercase();
    if k.is_empty() || k.starts_with(':') {
        return None;
    }
    Some((k, v.replace(['\r', '\n'], " ")))
}

/// The TLS options of a client's calls: a CA file ("" for the system's),
/// no verification, the server name ("" for the host), a client
/// certificate and key ("" for none).
#[derive(Clone, Debug, Default, PartialEq)]
pub struct ClientTls {
    ca: String,
    insecure: bool,
    name: String,
    cert: String,
    key: String,
}

impl ClientTls {
    /// The options of `FWP_SERVICE_<M>_CA`, `_INSECURE`, `_SERVER_NAME`,
    /// `_CERT` and `_KEY` for the clients of a service, if any is set.
    pub fn from_env(var: &str) -> Option<ClientTls> {
        let get = |k: &str| {
            std::env::var(format!("{}_{}", var, k))
                .ok()
                .filter(|v| !v.is_empty())
        };
        let t = ClientTls {
            ca: get("CA").unwrap_or_default(),
            insecure: get("INSECURE").is_some_and(|v| v != "0" && v != "false"),
            name: get("SERVER_NAME").unwrap_or_default(),
            cert: get("CERT").unwrap_or_default(),
            key: get("KEY").unwrap_or_default(),
        };
        (t != ClientTls::default()).then_some(t)
    }

    /// The key of connections with these options in the pool.
    fn pool_key(this: &Option<Rc<ClientTls>>, addr: &str) -> String {
        match this {
            None => addr.to_string(),
            Some(t) => format!(
                "{}\u{0}{}\u{0}{}\u{0}{}\u{0}{}\u{0}{}",
                addr, t.ca, t.insecure, t.name, t.cert, t.key
            ),
        }
    }
}

/// The call a server task is running.
pub struct Serving {
    headers: Vec<(String, String)>,
    /// The subject of the client's certificate (mutual TLS).
    peer: Option<String>,
    /// The call's stream (for its response metadata).
    stream: StreamRef,
    task: Arc<TaskShared>,
    /// The status to answer with when the task is cancelled for a bad
    /// request message.
    status: RefCell<Option<Status>>,
}

type ConnRef = Rc<RefCell<Conn>>;
type StreamRef = Rc<RefCell<Stream>>;

struct Conn {
    sock: Option<TcpStream>,
    /// The TLS session of a TLS connection.
    tls: Option<tls::Session>,
    fd: i32,
    /// What the server serves (`None` for a client connection).
    server: Option<Rc<Server>>,
    authority: String,
    dec: hpack::Decoder,
    peer: Peer,
    conn_window: i64,
    streams: BTreeMap<u32, StreamRef>,
    out: Vec<u8>,
    inbuf: Vec<u8>,
    next_stream: u32,
    last_stream: u32,
    /// A header block awaiting CONTINUATION: stream, bytes, END_STREAM.
    cont: Option<(u32, Vec<u8>, bool)>,
    preface: bool,
    dead: Option<String>,
    goaway: bool,
    /// What an HTTP server connection serves (`http.serve` over HTTP/2,
    /// web.rs below); `None` otherwise.
    web: Option<Rc<web::Web>>,
}

#[derive(Default)]
struct Stream {
    id: u32,
    headers: Vec<(String, String)>,
    trailers: Vec<(String, String)>,
    got_headers: bool,
    got_data: bool,
    data: Vec<u8>,
    msgs: VecDeque<Vec<u8>>,
    remote_end: bool,
    reset: Option<String>,
    /// The request certainly was not processed (a stale connection).
    retry: bool,
    window: i64,
    sent_headers: bool,
    local_end: bool,
    /// A server's response metadata: headers sent with the first message,
    /// and trailers sent with the status (`grpc.set-header`,
    /// `grpc.set-trailer`).
    out_headers: Vec<(String, String)>,
    out_trailers: Vec<(String, String)>,
    /// Messages sent are compressed with gzip.
    gzip: bool,
    bad: Option<String>,
    /// The task serving the call.
    task: Option<Arc<TaskShared>>,
    /// An HTTP stream: its data is a body, not gRPC messages.
    raw: bool,
}

impl Conn {
    fn new(sock: TcpStream, authority: String, server: Option<Rc<Server>>) -> Conn {
        let fd = sock.as_raw_fd();
        let client = server.is_none();
        let mut out = Vec::new();
        if client {
            out.extend_from_slice(h2::PREFACE);
        }
        out.extend(h2::our_settings());
        Conn {
            sock: Some(sock),
            tls: None,
            fd,
            server,
            authority,
            dec: hpack::Decoder::default(),
            peer: Peer::new(),
            conn_window: 65535,
            streams: BTreeMap::new(),
            out,
            inbuf: Vec::new(),
            next_stream: 1,
            last_stream: 0,
            cont: None,
            preface: client,
            dead: None,
            goaway: false,
            web: None,
        }
    }
}

fn header<'a>(hs: &'a [(String, String)], name: &str) -> Option<&'a str> {
    hs.iter()
        .rev()
        .find(|(k, _)| k == name)
        .map(|(_, v)| v.as_str())
}

fn earliest(a: Option<Instant>, b: Option<Instant>) -> Option<Instant> {
    match (a, b) {
        (Some(x), Some(y)) => Some(x.min(y)),
        (x, None) => x,
        (None, y) => y,
    }
}

// ============================================================ connections

/// What reading produced for the reader task to act on.
#[derive(Default)]
struct Acts {
    new_streams: Vec<StreamRef>,
    cancel: Vec<Arc<TaskShared>>,
    dead: Option<String>,
}

fn goaway(c: &mut Conn, code: u32, why: &str, acts: &mut Acts) {
    let mut p = c.last_stream.to_be_bytes().to_vec();
    p.extend_from_slice(&code.to_be_bytes());
    c.out.extend(h2::frame(h2::GOAWAY, 0, 0, &p));
    acts.dead = Some(why.to_string());
}

/// Split complete gRPC messages off a stream's data.
fn split_messages(s: &mut Stream) {
    while s.data.len() >= 5 {
        let n = u32::from_be_bytes([s.data[1], s.data[2], s.data[3], s.data[4]]) as usize;
        if s.data.len() < 5 + n {
            break;
        }
        if s.data[0] != 0 {
            // compressed with the stream's `grpc-encoding`
            if header(&s.headers, "grpc-encoding") != Some("gzip") {
                s.bad = Some(match header(&s.headers, "grpc-encoding") {
                    Some(e) => format!("unsupported grpc-encoding `{}`", e),
                    None => "a compressed message without grpc-encoding".into(),
                });
                s.data.clear();
                return;
            }
            match crate::gzip::gunzip(&s.data[5..5 + n], crate::gzip::MAX_OUTPUT) {
                Ok(m) => s.msgs.push_back(m),
                Err(e) => {
                    s.bad = Some(format!("bad compressed message: {}", e));
                    s.data.clear();
                    return;
                }
            }
            s.data.drain(..5 + n);
            continue;
        }
        s.msgs.push_back(s.data[5..5 + n].to_vec());
        s.data.drain(..5 + n);
    }
}

fn header_block(c: &mut Conn, sid: u32, block: Vec<u8>, end: bool, acts: &mut Acts) {
    let hs = match c.dec.decode(&block) {
        Ok(h) => h,
        Err(_) => return goaway(c, 9, "bad header block", acts), // COMPRESSION_ERROR
    };
    if let Some(s) = c.streams.get(&sid).cloned() {
        let mut s = s.borrow_mut();
        if c.server.is_none() {
            if !s.got_headers {
                s.headers = hs;
                s.got_headers = true;
            } else {
                s.trailers = hs;
            }
        }
        if end {
            s.remote_end = true;
        }
        return;
    }
    if let Some(w) = c.web.clone() {
        return web::new_stream(c, &w, sid, hs, end, acts);
    }
    if c.server.is_none() || sid.is_multiple_of(2) || sid <= c.last_stream {
        return;
    }
    c.last_stream = sid;
    let method = header(&hs, ":method").unwrap_or("");
    let ct = header(&hs, "content-type").unwrap_or("");
    if method != "POST" || !ct.starts_with("application/grpc") {
        let b = hpack::encode(&[(":status", "415")]);
        let max = c.peer.max_frame;
        c.out.extend(h2::header_frames(sid, &b, true, max));
        return;
    }
    let s = Rc::new(RefCell::new(Stream {
        id: sid,
        headers: hs,
        remote_end: end,
        window: c.peer.init_window,
        ..Default::default()
    }));
    c.streams.insert(sid, s.clone());
    acts.new_streams.push(s);
}

fn on_frame(c: &mut Conn, f: Frame, acts: &mut Acts) {
    if let Some((sid, _, _)) = &c.cont {
        if f.ty != h2::CONTINUATION || f.stream != *sid {
            return goaway(c, 1, "protocol error", acts);
        }
    }
    match f.ty {
        h2::HEADERS => match h2::unpad(&f) {
            Ok(p) => {
                let end = f.flags & h2::END_STREAM != 0;
                if f.flags & h2::END_HEADERS != 0 {
                    header_block(c, f.stream, p.to_vec(), end, acts);
                } else {
                    c.cont = Some((f.stream, p.to_vec(), end));
                }
            }
            Err(_) => goaway(c, 1, "protocol error", acts),
        },
        h2::CONTINUATION => {
            let Some((sid, mut b, end)) = c.cont.take() else {
                return goaway(c, 1, "protocol error", acts);
            };
            b.extend_from_slice(&f.payload);
            if f.flags & h2::END_HEADERS != 0 {
                header_block(c, sid, b, end, acts);
            } else {
                c.cont = Some((sid, b, end));
            }
        }
        h2::DATA => {
            let Ok(p) = h2::unpad(&f) else {
                return goaway(c, 1, "protocol error", acts);
            };
            let end = f.flags & h2::END_STREAM != 0;
            let n = f.payload.len() as u32;
            if n > 0 {
                c.out
                    .extend(h2::frame(h2::WINDOW_UPDATE, 0, 0, &n.to_be_bytes()));
            }
            if let Some(s) = c.streams.get(&f.stream).cloned() {
                let mut s = s.borrow_mut();
                if n > 0 && !end {
                    c.out
                        .extend(h2::frame(h2::WINDOW_UPDATE, 0, f.stream, &n.to_be_bytes()));
                }
                s.got_data = true;
                s.data.extend_from_slice(p);
                if !s.raw {
                    split_messages(&mut s);
                }
                if end {
                    s.remote_end = true;
                    if !s.raw && !s.data.is_empty() && s.bad.is_none() {
                        s.bad = Some("truncated gRPC message".into());
                    }
                }
            }
        }
        h2::RST_STREAM => {
            if let Some(s) = c.streams.remove(&f.stream) {
                let code = f.payload.get(3).copied().unwrap_or(0);
                let mut s = s.borrow_mut();
                s.reset = Some(if c.server.is_some() {
                    "cancelled by the client".to_string()
                } else {
                    format!("stream reset by {} (code {})", c.authority, code)
                });
                s.retry = code == 7 && !s.got_headers && !s.got_data; // REFUSED_STREAM
                if let Some(t) = s.task.take() {
                    acts.cancel.push(t);
                }
            }
        }
        h2::SETTINGS if f.stream == 0 => {
            if f.flags & h2::ACK != 0 {
                return;
            }
            match c.peer.apply(&f.payload) {
                Ok(delta) => {
                    for s in c.streams.values() {
                        s.borrow_mut().window += delta;
                    }
                    c.out.extend(h2::frame(h2::SETTINGS, h2::ACK, 0, &[]));
                }
                Err(_) => goaway(c, 1, "bad SETTINGS frame", acts),
            }
        }
        h2::PING if f.flags & h2::ACK == 0 => {
            c.out.extend(h2::frame(h2::PING, h2::ACK, 0, &f.payload));
        }
        h2::WINDOW_UPDATE if f.payload.len() == 4 => {
            let inc = (u32::from_be_bytes([f.payload[0], f.payload[1], f.payload[2], f.payload[3]])
                & 0x7fff_ffff) as i64;
            if f.stream == 0 {
                c.conn_window += inc;
            } else if let Some(s) = c.streams.get(&f.stream) {
                s.borrow_mut().window += inc;
            }
        }
        h2::GOAWAY if f.payload.len() >= 8 => {
            c.goaway = true;
            if c.server.is_none() && c.web.is_none() {
                let last =
                    u32::from_be_bytes([f.payload[0], f.payload[1], f.payload[2], f.payload[3]])
                        & 0x7fff_ffff;
                let gone: Vec<u32> = c.streams.range(last + 1..).map(|(k, _)| *k).collect();
                for id in gone {
                    if let Some(s) = c.streams.remove(&id) {
                        let mut s = s.borrow_mut();
                        s.reset = Some(format!("{} is shutting down", c.authority));
                        s.retry = !s.got_headers && !s.got_data;
                    }
                }
            }
        }
        _ => {}
    }
}

/// Parse what was read from a connection.
fn process_input(c: &mut Conn, bytes: &[u8]) -> Acts {
    let mut acts = Acts::default();
    c.inbuf.extend_from_slice(bytes);
    if !c.preface {
        let n = h2::PREFACE.len();
        if c.inbuf.len() < n {
            if !h2::PREFACE.starts_with(&c.inbuf) {
                acts.dead = Some("not an HTTP/2 connection".into());
            }
            return acts;
        }
        if &c.inbuf[..n] != h2::PREFACE {
            acts.dead = Some("not an HTTP/2 connection".into());
            return acts;
        }
        c.inbuf.drain(..n);
        c.preface = true;
    }
    let mut at = 0;
    loop {
        match h2::parse_frame(&c.inbuf[at..]) {
            Ok(Some((f, n))) => {
                at += n;
                on_frame(c, f, &mut acts);
                if acts.dead.is_some() {
                    break;
                }
            }
            Ok(None) => break,
            Err(_) => {
                goaway(c, 6, "frame too large", &mut acts); // FRAME_SIZE_ERROR
                break;
            }
        }
    }
    c.inbuf.drain(..at);
    acts
}

/// The connection is gone: fail its streams and cancel their calls.
fn conn_dead(it: &mut Interp, c: &ConnRef, why: &str) {
    let streams = {
        let mut cb = c.borrow_mut();
        if cb.dead.is_some() {
            return;
        }
        cb.dead = Some(why.to_string());
        cb.tls.take();
        if let Some(s) = cb.sock.take() {
            let _ = s.shutdown(std::net::Shutdown::Both);
        }
        std::mem::take(&mut cb.streams)
    };
    for s in streams.values() {
        let mut s = s.borrow_mut();
        if s.reset.is_none() {
            s.reset = Some(why.to_string());
            s.retry = !s.got_headers && !s.got_data;
        }
        if let Some(t) = s.task.take() {
            t.cancel();
        }
    }
    let shared = &it.world.grpc;
    let mut sh = shared.lock().unwrap();
    sh.0.pool.retain(|_, v| !Rc::ptr_eq(v, c));
    drop(sh);
    it.world.event();
}

/// A plain socket's read or write as a TLS session's would be.
fn plain_io(r: std::io::Result<usize>, write: bool) -> Io {
    match r {
        Ok(k) => Io::Done(k),
        Err(e) if e.kind() == std::io::ErrorKind::WouldBlock => Io::Wait(write),
        Err(e) => Io::Err(e),
    }
}

/// Read from a connection, through its TLS session if it has one; `None`
/// once it is closed.
fn conn_read(cb: &mut Conn, buf: &mut [u8]) -> Option<Io> {
    if let Some(t) = cb.tls.as_mut() {
        return Some(t.read(buf));
    }
    cb.sock.as_ref().map(|s| plain_io((&*s).read(buf), false))
}

/// Write to a connection, through its TLS session if it has one.
fn conn_write(cb: &mut Conn, data: &[u8]) -> Option<Io> {
    if let Some(t) = cb.tls.as_mut() {
        return Some(t.write(data));
    }
    cb.sock.as_ref().map(|s| plain_io((&*s).write(data), true))
}

/// The message of a failed read or write.
fn io_text(r: &Io) -> String {
    match r {
        Io::Err(e) => h2::io_msg(e),
        Io::Fail(m) => m.clone(),
        _ => String::new(),
    }
}

/// How long a client may take over the TLS handshake.
const HANDSHAKE: Duration = Duration::from_secs(10);

/// Finish a TLS handshake, waiting in the task; the failure otherwise.
fn finish_handshake(
    it: &mut Interp,
    c: &ConnRef,
    timeout: Option<Instant>,
) -> R<Result<(), String>> {
    let fd = c.borrow().fd;
    loop {
        let r = match c.borrow_mut().tls.as_mut() {
            Some(t) => t.handshake(),
            None => return Ok(Ok(())),
        };
        match r {
            Io::Done(_) => return Ok(Ok(())),
            Io::Wait(w) => {
                if !it.wait_fd(fd, w, timeout)? {
                    return Ok(Err("TLS handshake timed out".into()));
                }
            }
            r => return Ok(Err(io_text(&r))),
        }
    }
}

/// The reader task of a connection.
fn reader(it: &mut Interp, c: ConnRef) {
    let fd = c.borrow().fd;
    let mut buf = vec![0u8; 65536];
    loop {
        if c.borrow().dead.is_some() {
            return;
        }
        let r = match conn_read(&mut c.borrow_mut(), &mut buf) {
            Some(r) => r,
            None => return,
        };
        match r {
            Io::Done(0) => {
                let why = format!("connection to {} closed", c.borrow().authority);
                return conn_dead(it, &c, &why);
            }
            Io::Done(n) => {
                let acts = process_input(&mut c.borrow_mut(), &buf[..n]);
                for t in acts.cancel {
                    t.cancel();
                }
                let server = c.borrow().server.clone();
                if let Some(server) = server {
                    for s in acts.new_streams {
                        start_call(it, &c, s, server.clone());
                    }
                }
                it.world.event();
                if let Some(why) = acts.dead {
                    // let the writer send the GOAWAY first
                    flush_now(it, &c);
                    return conn_dead(it, &c, &why);
                }
            }
            Io::Wait(w) => {
                it.world.blocking(|| poll_fd(fd, w, 1000));
            }
            Io::Err(e) if e.kind() == std::io::ErrorKind::Interrupted => {}
            r => {
                let why = format!("cannot read from {}: {}", c.borrow().authority, io_text(&r));
                return conn_dead(it, &c, &why);
            }
        }
    }
}

/// Write the output buffer now (a connection about to close).
fn flush_now(it: &mut Interp, c: &ConnRef) {
    for _ in 0..100 {
        let r = {
            let mut cb = c.borrow_mut();
            if cb.out.is_empty() {
                return;
            }
            let out = std::mem::take(&mut cb.out);
            let r = match conn_write(&mut cb, &out) {
                Some(r) => r,
                None => return,
            };
            cb.out = out;
            if let Io::Done(n) = &r {
                cb.out.drain(..*n);
            }
            r
        };
        match r {
            Io::Done(_) => {}
            Io::Wait(w) => {
                let fd = c.borrow().fd;
                it.world.blocking(|| poll_fd(fd, w, 10));
            }
            _ => return,
        }
    }
}

/// The writer task of a connection.
fn writer(it: &mut Interp, c: ConnRef) {
    let fd = c.borrow().fd;
    loop {
        let r = {
            let mut cb = c.borrow_mut();
            if cb.dead.is_some() {
                return;
            }
            if cb.out.is_empty() {
                None
            } else {
                let out = std::mem::take(&mut cb.out);
                let r = match conn_write(&mut cb, &out) {
                    Some(r) => r,
                    None => return,
                };
                cb.out = out;
                if let Io::Done(n) = &r {
                    cb.out.drain(..*n);
                }
                Some(r)
            }
        };
        match r {
            None => it.world.park(None),
            Some(Io::Done(0)) => {
                let why = format!("connection to {} closed", c.borrow().authority);
                return conn_dead(it, &c, &why);
            }
            Some(Io::Done(_)) => it.world.event(),
            Some(Io::Wait(w)) => {
                it.world.blocking(|| poll_fd(fd, w, 1000));
            }
            Some(Io::Err(e)) if e.kind() == std::io::ErrorKind::Interrupted => {}
            Some(r) => {
                let why = format!("cannot send to {}: {}", c.borrow().authority, io_text(&r));
                return conn_dead(it, &c, &why);
            }
        }
    }
}

/// Send `RST_STREAM` and forget the stream.
fn reset_stream(it: &mut Interp, c: &ConnRef, s: &StreamRef, code: u32) {
    let id = {
        let mut sb = s.borrow_mut();
        if sb.reset.is_none() {
            sb.reset = Some("cancelled".into());
        }
        sb.id
    };
    let mut cb = c.borrow_mut();
    if cb.dead.is_some() || cb.streams.remove(&id).is_none() {
        return;
    }
    cb.out
        .extend(h2::frame(h2::RST_STREAM, 0, id, &code.to_be_bytes()));
    drop(cb);
    it.world.event();
}

/// Send `data` on a stream within the flow-control windows; `false` when
/// the stream is closed. Waiting for a window can be cancelled.
fn send_data(it: &mut Interp, c: &ConnRef, s: &StreamRef, data: &[u8], end: bool) -> R<bool> {
    let mut off = 0;
    loop {
        {
            let mut cb = c.borrow_mut();
            let mut sb = s.borrow_mut();
            if cb.dead.is_some() || sb.reset.is_some() || sb.local_end {
                return Ok(false);
            }
            let max = cb.peer.max_frame as i64;
            loop {
                let rem = data.len() - off;
                if rem == 0 {
                    if end {
                        cb.out
                            .extend(h2::frame(h2::DATA, h2::END_STREAM, sb.id, &[]));
                        sb.local_end = true;
                    }
                    drop(cb);
                    drop(sb);
                    it.world.event();
                    return Ok(true);
                }
                let avail = cb.conn_window.min(sb.window).min(max);
                if avail <= 0 || cb.out.len() >= OUT_LIMIT {
                    break;
                }
                let k = (avail as usize).min(rem);
                let last = k == rem && end;
                let flags = if last { h2::END_STREAM } else { 0 };
                let fr = h2::frame(h2::DATA, flags, sb.id, &data[off..off + k]);
                cb.out.extend(fr);
                cb.conn_window -= k as i64;
                sb.window -= k as i64;
                off += k;
                if last {
                    sb.local_end = true;
                    drop(cb);
                    drop(sb);
                    it.world.event();
                    return Ok(true);
                }
            }
        }
        it.world.event();
        it.check_cancel()?;
        let until = it.task.deadline();
        it.world.park(until);
    }
}

/// Send one message; a server sends its response headers first.
fn send_msg(it: &mut Interp, c: &ConnRef, s: &StreamRef, msg: &[u8], end: bool) -> R<bool> {
    {
        let mut cb = c.borrow_mut();
        let mut sb = s.borrow_mut();
        if cb.server.is_some() && !sb.sent_headers && cb.dead.is_none() && sb.reset.is_none() {
            sb.sent_headers = true;
            let mut hs: Vec<(&str, &str)> = vec![
                (":status", "200"),
                ("content-type", "application/grpc"),
                ("grpc-accept-encoding", "gzip"),
            ];
            if sb.gzip {
                hs.push(("grpc-encoding", "gzip"));
            }
            for (k, v) in &sb.out_headers {
                hs.push((k, v));
            }
            let b = hpack::encode(&hs);
            let max = cb.peer.max_frame;
            cb.out.extend(h2::header_frames(sb.id, &b, false, max));
        }
    }
    let gzip = s.borrow().gzip;
    let frame = if gzip && msg.len() >= GZIP_MIN {
        let z = crate::gzip::gzip(msg);
        let mut f = vec![1];
        f.extend_from_slice(&(z.len() as u32).to_be_bytes());
        f.extend(z);
        f
    } else {
        h2::grpc_frame(msg)
    };
    send_data(it, c, s, &frame, end)
}

/// Messages shorter than this are sent uncompressed (their flag says so).
const GZIP_MIN: usize = 64;

/// What a wait for the next message found.
enum Got {
    Msg(Vec<u8>),
    /// The end of the stream with a status (servers see `OK`).
    End(Status),
    /// The connection or stream failed; `true` when the request was
    /// certainly not processed.
    Lost(String, bool),
}

fn status_of(authority: &str, s: &Stream) -> Status {
    if let Some(st) = header(&s.headers, ":status") {
        if st != "200" {
            return Status::new(
                UNAVAILABLE,
                format!("HTTP status {} from {}", st, authority),
            );
        }
    }
    let hs = if s.trailers.is_empty() {
        &s.headers
    } else {
        &s.trailers
    };
    match header(hs, "grpc-status") {
        Some(v) => Status::new(
            v.trim().parse().unwrap_or(UNKNOWN),
            header(hs, "grpc-message")
                .map(h2::pct_decode)
                .unwrap_or_default(),
        ),
        None => Status::new(INTERNAL, format!("no grpc-status from {}", authority)),
    }
}

/// The server ended a call for its deadline, which the task's deadline
/// set (it sends the time left, rounded down): the task is cancelled when
/// its deadline passes, in a moment.
fn deadline_passed(it: &mut Interp, call: Option<Instant>) -> R<()> {
    let Some(td) = it.task.deadline() else {
        return Ok(());
    };
    if call.is_some_and(|d| d < td)
        || td.saturating_duration_since(Instant::now()) > Duration::from_secs(1)
    {
        return Ok(());
    }
    while Instant::now() < td {
        it.check_cancel()?;
        it.world.park(Some(td));
    }
    it.check_cancel()
}

/// Wait for the next message of a stream. Cancellation of the task resets
/// the stream; `deadline` (a call's) ends it with `DEADLINE_EXCEEDED`.
fn recv(it: &mut Interp, c: &ConnRef, s: &StreamRef, deadline: Option<Instant>) -> R<Got> {
    loop {
        {
            let mut sb = s.borrow_mut();
            if let Some(m) = sb.msgs.pop_front() {
                return Ok(Got::Msg(m));
            }
            if let Some(b) = &sb.bad {
                return Ok(Got::Lost(b.clone(), false));
            }
            if sb.remote_end {
                let cb = c.borrow();
                if cb.server.is_some() {
                    return Ok(Got::End(Status::new(OK, "")));
                }
                if let Some(cap) = &it.grpc.capture {
                    cap.borrow_mut().extend(response_metadata(&sb));
                }
                let st = status_of(&cb.authority, &sb);
                drop(cb);
                let id = sb.id;
                drop(sb);
                c.borrow_mut().streams.remove(&id);
                if st.code == DEADLINE_EXCEEDED {
                    deadline_passed(it, deadline)?;
                }
                return Ok(Got::End(st));
            }
            if let Some(r) = &sb.reset {
                return Ok(Got::Lost(r.clone(), sb.retry));
            }
        }
        if let Err(e) = it.check_cancel() {
            if c.borrow().server.is_none() {
                reset_stream(it, c, s, 8); // CANCEL
            }
            return Err(e);
        }
        if let Some(d) = deadline {
            if Instant::now() >= d {
                reset_stream(it, c, s, 8);
                return Ok(Got::End(Status::new(
                    DEADLINE_EXCEEDED,
                    "deadline exceeded",
                )));
            }
        }
        let until = earliest(deadline, it.task.deadline());
        it.world.park(until);
    }
}

// ================================================================= client

fn connect(it: &mut Interp, given: &str, key: &str) -> R<Result<ConnRef, String>> {
    it.check_cancel()?;
    let opts = it.grpc.tls.clone().unwrap_or_default();
    let (secure, addr) = tls::grpc_addr(given);
    let a = addr.to_string();
    let r = it.world.blocking(move || TcpStream::connect(&a));
    let sock = match r {
        Ok(s) => s,
        Err(e) => {
            return Ok(Err(format!(
                "cannot connect to {}: {}",
                addr,
                h2::io_msg(&e)
            )))
        }
    };
    let _ = sock.set_nodelay(true);
    if let Err(e) = sock.set_nonblocking(true) {
        return Ok(Err(format!("cannot connect to {}: {}", addr, e)));
    }
    let session = if secure {
        // verified with the system's CA certificates (SSL_CERT_FILE,
        // SSL_CERT_DIR), offering h2
        match tls::Session::client(
            sock.as_raw_fd(),
            &tls::ClientOpts {
                ca: &opts.ca,
                verify: !opts.insecure,
                name: if opts.name.is_empty() {
                    tls::host_of(addr)
                } else {
                    &opts.name
                },
                alpn: &["h2".to_string()],
                cert: &opts.cert,
                key: &opts.key,
            },
        ) {
            Ok(s) => Some(s),
            Err(e) => return Ok(Err(format!("cannot connect to {}: {}", addr, e))),
        }
    } else {
        None
    };
    let c = Rc::new(RefCell::new(Conn::new(sock, given.to_string(), None)));
    c.borrow_mut().tls = session;
    if let Err(e) = finish_handshake(it, &c, None)? {
        return Ok(Err(format!("cannot connect to {}: {}", addr, e)));
    }
    let (r, w) = (c.clone(), c.clone());
    let r = crate::sched::Baton(r);
    let w = crate::sched::Baton(w);
    it.spawn_rust(Box::new(move |it| reader(it, r.0)), None, true);
    it.spawn_rust(Box::new(move |it| writer(it, w.0)), None, true);
    it.world
        .grpc
        .lock()
        .unwrap()
        .0
        .pool
        .insert(key.to_string(), c.clone());
    Ok(Ok(c))
}

/// The deadline of a call made now: the task's, or the call context's.
fn call_deadline(it: &Interp) -> Option<Instant> {
    earliest(it.grpc.deadline, it.task.deadline())
}

/// Start a call: a stream with its request headers sent. `Err` is a
/// transport failure; the flag says whether the connection was reused.
fn open_call(
    it: &mut Interp,
    addr: &str,
    path: &str,
    extra: &[(&str, &str)],
) -> R<Result<(ConnRef, StreamRef, bool), String>> {
    it.check_cancel()?;
    let key = ClientTls::pool_key(&it.grpc.tls, addr);
    let pooled = {
        let sh = it.world.grpc.lock().unwrap();
        sh.0.pool.get(&key).cloned()
    };
    let pooled = pooled.filter(|c| {
        let cb = c.borrow();
        cb.dead.is_none() && !cb.goaway && cb.next_stream < 0x7fff_0000
    });
    let reused = pooled.is_some();
    let c = match pooled {
        Some(c) => c,
        None => match connect(it, addr, &key)? {
            Ok(c) => c,
            Err(e) => return Ok(Err(e)),
        },
    };
    let timeout =
        call_deadline(it).map(|d| rpc::timeout_header(d.saturating_duration_since(Instant::now())));
    let md = it.grpc.metadata.clone();
    let gzip = it.grpc.gzip;
    let s = {
        let mut cb = c.borrow_mut();
        let id = cb.next_stream;
        cb.next_stream += 2;
        let authority = tls::grpc_addr(&cb.authority).1.to_string();
        let scheme = if cb.tls.is_some() { "https" } else { "http" };
        let mut hs: Vec<(&str, &str)> = vec![
            (":method", "POST"),
            (":scheme", scheme),
            (":path", path),
            (":authority", &authority),
            ("content-type", "application/grpc"),
            ("te", "trailers"),
            ("grpc-accept-encoding", "gzip"),
        ];
        if gzip {
            hs.push(("grpc-encoding", "gzip"));
        }
        if let Some(t) = &timeout {
            hs.push(("grpc-timeout", t));
        }
        hs.extend_from_slice(extra);
        for (k, v) in md.iter() {
            hs.push((k, v));
        }
        let block = hpack::encode(&hs);
        let max = cb.peer.max_frame;
        cb.out.extend(h2::header_frames(id, &block, false, max));
        let s = Rc::new(RefCell::new(Stream {
            id,
            window: cb.peer.init_window,
            gzip,
            ..Default::default()
        }));
        cb.streams.insert(id, s.clone());
        s
    };
    it.world.event();
    Ok(Ok((c, s, reused)))
}

/// Why a client call failed.
enum Failure {
    Status(Status),
    Transport(String),
}

type Cached = Rc<(Rc<Schema>, MethodSchema, String)>;

thread_local! {
    static STUBS: RefCell<HashMap<(usize, FuncId), Cached>> = RefCell::new(HashMap::new());
}

fn stub(prog: &Program, id: FuncId, r: &RemoteFn, shape: &Shape) -> R<Cached> {
    let key = (prog as *const Program as usize, id);
    if let Some(c) = STUBS.with(|s| s.borrow().get(&key).cloned()) {
        return Ok(c);
    }
    let f = &prog.funcs[id];
    let mut s = Schema::default();
    let ms =
        rpc::method_schema(&mut s, prog, &r.method, shape, r.error.as_ref()).map_err(Ctl::Trap)?;
    let fp = crate::protobuf::fingerprint(prog, &f.ty, r.error.as_ref());
    let c = Rc::new((Rc::new(s), ms, fp));
    STUBS.with(|s| s.borrow_mut().insert(key, c.clone()));
    Ok(c)
}

pub fn grpc_error(code: u32, message: &str) -> Ctl {
    Ctl::Fail(
        Value::tuple(vec![Value::I64(code as i64), Value::str(message)]),
        rpc::grpc_error_type(),
    )
}

/// A status from a `GrpcError` value; codes outside 1..16 are `UNKNOWN`.
fn status_of_error(e: &Value) -> Status {
    let (code, msg) = match e {
        Value::Record(fs) if fs.len() == 2 => {
            (fs[0].as_i128().unwrap_or(2), fs[1].as_str().to_string())
        }
        _ => (2, String::new()),
    };
    let code = if (1..=16).contains(&code) {
        code as u32
    } else {
        UNKNOWN
    };
    Status::new(code, msg)
}

/// The failure of a client stub, as the caller sees it.
fn stub_failure(shape: &Shape, what: &str, addr: &str, f: Failure) -> Ctl {
    match f {
        Failure::Status(st) if st.code == INTERNAL && st.message.starts_with("trap: ") => {
            Ctl::Trap(st.message["trap: ".len()..].to_string())
        }
        Failure::Status(st) if shape.status_errors => grpc_error(st.code, &st.message),
        Failure::Transport(m) if m.starts_with("trap: ") => {
            Ctl::Trap(m["trap: ".len()..].to_string())
        }
        Failure::Transport(m) if shape.status_errors => grpc_error(UNAVAILABLE, &m),
        Failure::Status(st) => Ctl::Trap(format!(
            "service call {} ({}) failed: gRPC status {}: {}",
            what, addr, st.code, st.message
        )),
        Failure::Transport(m) => {
            Ctl::Trap(format!("service call {} ({}) failed: {}", what, addr, m))
        }
    }
}

/// How messages of a stream are decoded.
#[derive(Clone)]
pub enum Decoder {
    /// With the schema of a served function: `node` is the request or
    /// response message, whose first field holds the value (after the
    /// `oneof` tag when `error` is set).
    Native {
        schema: Rc<Schema>,
        node: NodeId,
        ty: MT,
        error: Option<MT>,
    },
    /// An fwp function `Bytes -> a ! {Error[GrpcError]}`.
    Fwp(Value),
}

/// How messages are encoded for a stream.
#[derive(Clone)]
pub enum Encoder {
    Native {
        schema: Rc<Schema>,
        node: NodeId,
        ty: MT,
        error_tag: bool,
    },
    Fwp(Value),
}

/// A decoded message: its value, or the error it carries and its type.
type Decoded = Result<Value, (Value, MT)>;

/// The decoded value of a message: the value, or the error it carries.
fn decode_msg(it: &mut Interp, dec: &Decoder, msg: &[u8]) -> R<Result<Decoded, String>> {
    match dec {
        Decoder::Native {
            schema,
            node,
            ty,
            error,
        } => {
            let prog = it.prog;
            // the details of malformed messages differ between the
            // backends: a message names none
            let bad = || Ok(Err("malformed message".to_string()));
            let canon = match schema.decode(*node, msg) {
                Ok(c) => c,
                Err(_) => return bad(),
            };
            let mut rd = Reader::new(&canon);
            if let Some(et) = error {
                match rd.leb128() {
                    Ok(1) => {
                        return match proto::decode(&mut rd, et, prog) {
                            Ok(e) => Ok(Ok(Err((e, et.clone())))),
                            Err(_) => bad(),
                        }
                    }
                    Ok(_) => {}
                    Err(_) => return bad(),
                }
            }
            match proto::decode(&mut rd, ty, prog) {
                Ok(v) => Ok(Ok(Ok(v))),
                Err(_) => bad(),
            }
        }
        Decoder::Fwp(f) => {
            let b = Value::Bytes(Rc::from(msg));
            match it.apply(f.clone(), vec![b]) {
                Ok(v) => Ok(Ok(Ok(v))),
                Err(Ctl::Fail(e, _)) => Ok(Err(status_of_error(&e).message)),
                Err(e) => Err(e),
            }
        }
    }
}

fn encode_msg(it: &mut Interp, enc: &Encoder, v: &Value) -> R<Vec<u8>> {
    match enc {
        Encoder::Native {
            schema,
            node,
            ty,
            error_tag,
        } => {
            let mut canon = Vec::new();
            if *error_tag {
                canon.push(0);
            }
            proto::encode(&mut canon, v, ty, it.prog);
            schema
                .encode(*node, &canon)
                .map_err(|e| Ctl::Trap(format!("cannot encode a message: {}", e)))
        }
        Encoder::Fwp(f) => match &it.apply(f.clone(), vec![v.clone()])? {
            Value::Bytes(b) => Ok(b.to_vec()),
            _ => Err(Ctl::Trap(
                "internal: an encoder did not return bytes".into(),
            )),
        },
    }
}

/// A task that sends the requests of a bidirectional call while its
/// caller receives the responses: the elements of `iter`, encoded, then
/// the end of the stream. A failure (a trap while forcing or encoding)
/// resets the stream and is kept for the caller.
struct Sender {
    task: Arc<TaskShared>,
    failed: Rc<RefCell<Option<Ctl>>>,
}

fn spawn_sender(it: &mut Interp, c: &ConnRef, s: &StreamRef, iter: Value, enc: Encoder) -> Sender {
    let failed = Rc::new(RefCell::new(None));
    let job = crate::sched::Baton((c.clone(), s.clone(), iter, enc, failed.clone()));
    let task = it.spawn_rust(
        Box::new(move |it| {
            let job = job;
            let crate::sched::Baton((c, s, mut cur, enc, failed)) = job;
            let r = (|| -> R<()> {
                loop {
                    if s.borrow().remote_end {
                        return Ok(());
                    }
                    let Some((x, rest)) = iter_next(it, cur)? else {
                        break;
                    };
                    let msg = encode_msg(it, &enc, &x)?;
                    if !send_msg(it, &c, &s, &msg, false)? {
                        return Ok(());
                    }
                    cur = rest;
                }
                send_data(it, &c, &s, &[], true)?;
                Ok(())
            })();
            if let Err(e) = r {
                if !matches!(e, Ctl::Cancelled) {
                    if let Ctl::Trap(m) = &e {
                        let mut sb = s.borrow_mut();
                        if sb.reset.is_none() {
                            sb.reset = Some(format!("trap: {}", m));
                        }
                    }
                    *failed.borrow_mut() = Some(e);
                    reset_stream(it, &c, &s, 8);
                }
            }
        }),
        None,
        true,
    );
    Sender { task, failed }
}

impl Sender {
    /// Stop sending (the call is over), and the sender's failure, if any.
    fn finish(self, it: &mut Interp) -> Option<Ctl> {
        self.task.cancel();
        it.world.event();
        self.failed.borrow_mut().take()
    }
}

/// The values of an `Iterator`, forced one at a time.
fn iter_next(it: &mut Interp, v: Value) -> R<Option<(Value, Value)>> {
    match &v {
        Value::Data(1, fs) if fs.len() == 2 => {
            let rest = it.apply(fs[1].clone(), vec![Value::unit()])?;
            Ok(Some((fs[0].clone(), rest)))
        }
        _ => Ok(None),
    }
}

/// A call to a function served by another process (a split build).
pub fn call_remote(it: &mut Interp, id: FuncId, r: &RemoteFn, args: Vec<Value>) -> R<Value> {
    let prog = it.prog;
    let f = &prog.funcs[id];
    let shape = rpc::shape(&f.ty, f.arity as usize, r.error.as_ref());
    let what = format!("{}.{}", r.module, r.method);
    let addr = crate::services::address(&r.module, &r.default_addr);
    // the TLS options of the service's environment variables, unless the
    // task gives its own
    let saved_tls = it.grpc.tls.clone();
    if saved_tls.is_none() {
        it.grpc.tls = ClientTls::from_env(&crate::protobuf::env_var(&r.module)).map(Rc::new);
    }
    let r = call_remote_at(it, id, r, args, &shape, &what, &addr);
    it.grpc.tls = saved_tls;
    r
}

#[allow(clippy::too_many_arguments)]
fn call_remote_at(
    it: &mut Interp,
    id: FuncId,
    r: &RemoteFn,
    args: Vec<Value>,
    shape: &Shape,
    what: &str,
    addr: &str,
) -> R<Value> {
    let prog = it.prog;
    let c = stub(prog, id, r, shape)?;
    let (schema, ms, fp) = (&c.0, c.1, &c.2);
    let (what, addr) = (what.to_string(), addr.to_string());
    let path = r.path.clone();
    let fail = |f: Failure| stub_failure(shape, &what, &addr, f);
    let deadline = it.grpc.deadline;
    let req_types = shape.request_params();
    let encode_req = |it: &mut Interp, vals: &[Value]| -> R<Vec<u8>> {
        let mut canon = Vec::new();
        for (a, t) in vals.iter().zip(&req_types) {
            proto::encode(&mut canon, a, t, it.prog);
        }
        schema
            .encode(ms.request, &canon)
            .map_err(|e| Ctl::Trap(format!("cannot encode the arguments of {}: {}", what, e)))
    };
    let msg_error = shape.message_error(r.error.as_ref()).cloned();
    let dec = Decoder::Native {
        schema: schema.clone(),
        node: ms.response,
        ty: shape.response_type().clone(),
        error: msg_error.clone(),
    };
    // the request; a unary call is retried once on a fresh connection when
    // a pooled one turns out to be closed before the server saw it
    let mut attempt = 0;
    // the requests of a bidirectional call are sent as responses arrive
    let mut sender: Option<Sender> = None;
    let (conn, stream, first) = loop {
        let (conn, stream, reused) = match open_call(it, &addr, &path, &[("fwp-fingerprint", fp)])?
        {
            Ok(x) => x,
            Err(e) => return Err(fail(Failure::Transport(e))),
        };
        let r = (|| -> R<Option<Got>> {
            match &shape.input {
                Input::Args(_) => {
                    let req = encode_req(it, &args[..req_types.len()])?;
                    send_msg(it, &conn, &stream, &req, true)?;
                }
                Input::Stream(t) if !matches!(shape.output, Output::Value(_)) => {
                    let enc = Encoder::Native {
                        schema: schema.clone(),
                        node: ms.request,
                        ty: t.clone(),
                        error_tag: false,
                    };
                    sender = Some(spawn_sender(it, &conn, &stream, args[0].clone(), enc));
                }
                Input::Stream(_) => {
                    let mut cur = args[0].clone();
                    while let Some((x, rest)) = iter_next(it, cur)? {
                        let req = encode_req(it, &[x])?;
                        if !send_msg(it, &conn, &stream, &req, false)? {
                            break;
                        }
                        cur = rest;
                    }
                    send_data(it, &conn, &stream, &[], true)?;
                }
            }
            if matches!(shape.output, Output::Value(_)) {
                return Ok(Some(recv(it, &conn, &stream, deadline)?));
            }
            Ok(None)
        })();
        let first = match r {
            Ok(g) => g,
            Err(e) => {
                reset_stream(it, &conn, &stream, 8);
                return Err(e);
            }
        };
        if let Some(Got::Lost(_, true)) = &first {
            if reused && attempt == 0 && matches!(shape.input, Input::Args(_)) {
                attempt += 1;
                continue;
            }
        }
        break (conn, stream, first);
    };
    let bad = |e: String| Ctl::Trap(format!("bad response from {} ({}): {}", what, addr, e));
    let decode =
        |it: &mut Interp, msg: &[u8]| -> R<Decoded> { decode_msg(it, &dec, msg)?.map_err(bad) };
    match &shape.output {
        Output::Value(_) => {
            let msg = match first.unwrap() {
                Got::Msg(m) => m,
                Got::End(st) if st.code != OK => return Err(fail(Failure::Status(st))),
                Got::End(_) => return Err(bad("missing response message".into())),
                Got::Lost(m, _) => return Err(fail(Failure::Transport(m))),
            };
            let v = decode(it, &msg)?;
            // the status
            match recv(it, &conn, &stream, deadline)? {
                Got::End(st) if st.code == OK => {}
                Got::End(st) => return Err(fail(Failure::Status(st))),
                Got::Msg(_) => {
                    reset_stream(it, &conn, &stream, 8);
                    return Err(bad("more than one response message".into()));
                }
                Got::Lost(m, _) => return Err(fail(Failure::Transport(m))),
            }
            match v {
                Ok(v) => Ok(v),
                Err((e, t)) => Err(Ctl::Fail(e, t)),
            }
        }
        Output::Chan(_) => {
            let ch = args.last().cloned().unwrap_or_else(Value::unit);
            let r = (|| -> R<Value> {
                loop {
                    match recv(it, &conn, &stream, deadline)? {
                        Got::Msg(m) => match decode(it, &m)? {
                            Ok(v) => {
                                if let Some(Err(e)) =
                                    it.prim_conc("channel.send", &mut [ch.clone(), v])
                                {
                                    reset_stream(it, &conn, &stream, 8);
                                    return Err(e);
                                }
                            }
                            Err((e, t)) => {
                                reset_stream(it, &conn, &stream, 8);
                                return Err(Ctl::Fail(e, t));
                            }
                        },
                        Got::End(st) if st.code == OK => return Ok(Value::unit()),
                        Got::End(st) => return Err(fail(Failure::Status(st))),
                        Got::Lost(m, _) => return Err(fail(Failure::Transport(m))),
                    }
                }
            })();
            if let Some(e) = sender.take().and_then(|s| s.finish(it)) {
                return Err(e);
            }
            r
        }
        Output::Iter(_) => {
            // the first element now, so that a failure before it is raised
            // in the caller; later failures trap
            let inc = Rc::new(Incoming {
                conn,
                stream,
                server: false,
                dec: dec.clone(),
                what: format!("{} ({})", what, addr),
                deadline,
                results: shape.results.is_some(),
            });
            let cell = Rc::new(StreamCell {
                src: inc,
                memo: RefCell::new(None),
            });
            match force_cell(it, &cell, true) {
                Ok(_) => {}
                Err(CellErr::Ctl(e)) => return Err(e),
                Err(CellErr::Failed(f)) => return Err(fail(f)),
            }
            let iter_fn = r
                .iter_fn
                .ok_or_else(|| Ctl::Trap("internal: no iterator function".into()))?;
            it.call(iter_fn, vec![wrap(Native::Grpc(Obj::Cell(cell)))])
        }
    }
}

// =============================================================== streams

/// A gRPC runtime object behind `GrpcStream` and `GrpcCell`.
pub enum Obj {
    Call(Rc<Call>),
    Cell(Rc<StreamCell>),
}

impl std::fmt::Debug for Obj {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.write_str("<grpc>")
    }
}

/// A call as an fwp value (`GrpcStream`): the client or the server side.
pub struct Call {
    conn: ConnRef,
    stream: StreamRef,
    server: bool,
    deadline: Option<Instant>,
}

/// The source of a received stream.
pub struct Incoming {
    conn: ConnRef,
    stream: StreamRef,
    server: bool,
    dec: Decoder,
    /// The call, for messages (client side).
    what: String,
    deadline: Option<Instant>,
    /// Elements are `Result[R, GrpcError]`: a failure ends the stream
    /// with an `Err` (client side).
    results: bool,
}

/// A position in a received stream; forcing it receives the message
/// there (once).
pub struct StreamCell {
    src: Rc<Incoming>,
    memo: RefCell<Option<Value>>,
}

enum CellErr {
    Ctl(Ctl),
    Failed(Failure),
}

impl From<Ctl> for CellErr {
    fn from(c: Ctl) -> Self {
        CellErr::Ctl(c)
    }
}

/// Fail the call being served with a status: the serving task is
/// cancelled and answers with it.
fn fail_call(it: &mut Interp, st: Status) -> Ctl {
    if let Some(sv) = it.grpc.serving.clone() {
        *sv.status.borrow_mut() = Some(st);
        sv.task.cancel();
        it.world.event();
        return Ctl::Cancelled;
    }
    Ctl::Trap(st.message)
}

/// `Option[(a, GrpcCell[a])]`: the next element of a received stream.
/// With `first`, failures are returned instead of trapping.
fn force_cell(it: &mut Interp, cell: &Rc<StreamCell>, first: bool) -> Result<Value, CellErr> {
    if let Some(v) = cell.memo.borrow().clone() {
        return Ok(v);
    }
    let src = cell.src.clone();
    let got = recv(it, &src.conn, &src.stream, src.deadline)?;
    if src.results {
        // an `Err` element, then the end
        let err = |code: u32, msg: &str| {
            let last = Rc::new(StreamCell {
                src: src.clone(),
                memo: RefCell::new(Some(opt(None))),
            });
            let e = Value::data(
                1,
                vec![Value::tuple(vec![Value::I64(code as i64), Value::str(msg)])],
            );
            opt(Some(Value::tuple(vec![
                e,
                wrap(Native::Grpc(Obj::Cell(last))),
            ])))
        };
        let v = match got {
            Got::Msg(m) => match decode_msg(it, &src.dec, &m)? {
                Ok(Ok(x)) => {
                    let next = Rc::new(StreamCell {
                        src: src.clone(),
                        memo: RefCell::new(None),
                    });
                    opt(Some(Value::tuple(vec![
                        Value::data(0, vec![x]),
                        wrap(Native::Grpc(Obj::Cell(next))),
                    ])))
                }
                Ok(Err(_)) => err(INTERNAL, "unexpected error in a response"),
                Err(e) => err(INTERNAL, &format!("bad response from {}: {}", src.what, e)),
            },
            Got::End(st) if st.code == OK => opt(None),
            Got::End(st) => err(st.code, &st.message),
            Got::Lost(m, _) => err(UNAVAILABLE, &m),
        };
        *cell.memo.borrow_mut() = Some(v.clone());
        return Ok(v);
    }
    let failed = |f: Failure| -> CellErr {
        if src.server {
            return CellErr::Ctl(Ctl::Cancelled);
        }
        if first {
            return CellErr::Failed(f);
        }
        CellErr::Ctl(match f {
            Failure::Status(st) if st.code == INTERNAL && st.message.starts_with("trap: ") => {
                Ctl::Trap(st.message["trap: ".len()..].to_string())
            }
            Failure::Status(st) => Ctl::Trap(format!(
                "service call {} failed: gRPC status {}: {}",
                src.what, st.code, st.message
            )),
            Failure::Transport(m) => Ctl::Trap(format!("service call {} failed: {}", src.what, m)),
        })
    };
    let v = match got {
        Got::Msg(m) => match decode_msg(it, &src.dec, &m)? {
            Ok(Ok(x)) => {
                let next = Rc::new(StreamCell {
                    src: src.clone(),
                    memo: RefCell::new(None),
                });
                opt(Some(Value::tuple(vec![
                    x,
                    wrap(Native::Grpc(Obj::Cell(next))),
                ])))
            }
            Ok(Err((e, t))) => {
                if first {
                    return Err(CellErr::Ctl(Ctl::Fail(e, t)));
                }
                let shown = crate::value::display(&e, &t, it.prog, true);
                return Err(CellErr::Ctl(Ctl::Trap(format!(
                    "service call {} failed: error: {}",
                    src.what, shown
                ))));
            }
            Err(e) => {
                if src.server {
                    return Err(CellErr::Ctl(fail_call(
                        it,
                        Status::new(INVALID_ARGUMENT, e),
                    )));
                }
                return Err(CellErr::Ctl(Ctl::Trap(format!(
                    "bad response from {}: {}",
                    src.what, e
                ))));
            }
        },
        Got::End(st) if st.code == OK => opt(None),
        Got::End(st) => return Err(failed(Failure::Status(st))),
        Got::Lost(m, _) => {
            if src.server {
                if let Some(b) = src.stream.borrow().bad.clone() {
                    return Err(CellErr::Ctl(fail_call(
                        it,
                        Status::new(INVALID_ARGUMENT, b),
                    )));
                }
            }
            return Err(failed(Failure::Transport(m)));
        }
    };
    *cell.memo.borrow_mut() = Some(v.clone());
    Ok(v)
}

/// A channel's values sent as messages of a stream.
pub struct Sink {
    conn: ConnRef,
    stream: StreamRef,
    enc: Encoder,
}

/// `channel.send` on a sink: `false` when the stream is closed.
pub fn sink_send(it: &mut Interp, s: &Rc<Sink>, x: Value) -> R<bool> {
    let msg = encode_msg(it, &s.enc, &x)?;
    send_msg(it, &s.conn, &s.stream, &msg, false)
}

fn sink_value(conn: &ConnRef, stream: &StreamRef, enc: Encoder) -> Value {
    wrap(Native::Chan(RefCell::new(ChanState::sink(Sink {
        conn: conn.clone(),
        stream: stream.clone(),
        enc,
    }))))
}

// ================================================================= server

/// How a path is served.
enum Route {
    Method(Rc<Method>),
    /// An fwp function `GrpcStream -> ()`.
    Fwp(Value),
    HealthCheck,
    HealthWatch,
    Reflection,
}

/// An exported function served over gRPC.
struct Method {
    name: String,
    func: FuncId,
    shape: Shape,
    error: Option<MT>,
    schema: Rc<Schema>,
    ms: MethodSchema,
    fingerprint: String,
    iter_fn: Option<FuncId>,
}

pub struct Server {
    routes: HashMap<String, Route>,
    /// For log messages: the module served.
    module: String,
    /// Full names of the services, for health checks.
    services: Vec<String>,
    reflection: Option<rpc::Reflection>,
}

/// The server of a program's service.
fn compiled_server(prog: &Program) -> Result<Server, String> {
    crate::services::check_service(prog)?;
    let svc = prog.service.as_ref().ok_or("no service to serve")?;
    let mut schema = Schema::default();
    let mut methods = Vec::new();
    for m in &svc.methods {
        let f = &prog.funcs[m.func];
        let shape = rpc::shape(&f.ty, f.arity as usize, m.error.as_ref());
        let method = rpc::Path::parse(&m.path)
            .map(|p| p.method)
            .unwrap_or_default();
        let ms = rpc::method_schema(&mut schema, prog, &method, &shape, m.error.as_ref())?;
        methods.push((m, shape, ms));
    }
    let schema = Rc::new(schema);
    let mut routes = HashMap::new();
    let mut services = Vec::new();
    for (m, shape, ms) in methods {
        if let Some(p) = rpc::Path::parse(&m.path) {
            if !services.contains(&p.full_service()) {
                services.push(p.full_service());
            }
        }
        routes.insert(
            m.path.clone(),
            Route::Method(Rc::new(Method {
                name: m.name.clone(),
                func: m.func,
                fingerprint: svc.fingerprint(prog, m),
                shape,
                error: m.error.clone(),
                schema: schema.clone(),
                ms,
                iter_fn: m.iter_fn,
            })),
        );
    }
    let reflection = rpc::reflection(prog)?;
    routes.insert(REFLECTION_V1.into(), Route::Reflection);
    routes.insert(REFLECTION_V1ALPHA.into(), Route::Reflection);
    routes.insert(HEALTH_CHECK.into(), Route::HealthCheck);
    routes.insert(HEALTH_WATCH.into(), Route::HealthWatch);
    Ok(Server {
        routes,
        module: svc.module.clone(),
        services,
        reflection: Some(reflection),
    })
}

/// Start the task serving a call.
fn start_call(it: &mut Interp, c: &ConnRef, s: StreamRef, server: Rc<Server>) {
    let deadline = header(&s.borrow().headers, "grpc-timeout")
        .and_then(rpc::parse_timeout)
        .map(|ns| {
            let now = Instant::now();
            now.checked_add(Duration::from_nanos(ns))
                .unwrap_or(now + Duration::from_secs(100 * 365 * 86400))
        });
    let job = crate::sched::Baton((c.clone(), s.clone(), server));
    let t = it.spawn_rust(
        Box::new(move |it| {
            let job = job;
            let crate::sched::Baton((c, s, server)) = job;
            handle(it, c, s, server)
        }),
        deadline,
        false,
    );
    s.borrow_mut().task = Some(t);
}

fn route_name(server: &Server, path: &str) -> String {
    match server.routes.get(path) {
        Some(Route::Method(m)) => format!("{}.{}", server.module, m.name),
        _ => path.trim_start_matches('/').to_string(),
    }
}

/// The task serving one call.
fn handle(it: &mut Interp, c: ConnRef, s: StreamRef, server: Rc<Server>) {
    let headers = s.borrow().headers.clone();
    let path = header(&headers, ":path").unwrap_or("").to_string();
    let peer = c.borrow().tls.as_ref().and_then(|t| t.peer_subject());
    let serving = Rc::new(Serving {
        headers: headers.clone(),
        peer,
        stream: s.clone(),
        task: it.task.clone(),
        status: RefCell::new(None),
    });
    it.grpc = TaskCtx {
        metadata: Rc::new(Vec::new()),
        deadline: None,
        serving: Some(serving.clone()),
        tls: None,
        capture: None,
        gzip: false,
    };
    // responses are compressed like the requests
    {
        let mut sb = s.borrow_mut();
        sb.gzip = header(&sb.headers, "grpc-encoding") == Some("gzip");
    }
    let what = route_name(&server, &path);
    // calls of the program's functions (not of reflection and health
    // checking) are logged when they are cancelled
    let logged = matches!(
        server.routes.get(&path),
        Some(Route::Method(_)) | Some(Route::Fwp(_))
    );
    let r = match server.routes.get(&path) {
        None => Ok(Err(Status::new(
            UNIMPLEMENTED,
            format!("unknown method {}", path),
        ))),
        Some(Route::Method(m)) => run_method(it, &c, &s, m, &headers, &what),
        Some(Route::Fwp(h)) => run_fwp(it, &c, &s, h.clone(), &what),
        Some(Route::HealthCheck) | Some(Route::HealthWatch) => {
            health(it, &c, &s, &server, path == HEALTH_WATCH)
        }
        Some(Route::Reflection) => reflect(it, &c, &s, &server),
    };
    let _ = it.out.flush();
    let status = match r {
        Ok(Ok(())) => None,
        Ok(Err(st)) => Some(st),
        Err(Ctl::Cancelled) => {
            let over = serving.status.borrow_mut().take();
            if let Some(st) = over {
                Some(st)
            } else if s.borrow().reset.is_some() || c.borrow().dead.is_some() {
                if logged {
                    eprintln!("fwp: call cancelled by the client (in {})", what);
                }
                None
            } else if it.task.deadline().is_some_and(|d| Instant::now() >= d) {
                if logged {
                    eprintln!("fwp: deadline exceeded (in {})", what);
                }
                Some(Status::new(DEADLINE_EXCEEDED, "deadline exceeded"))
            } else {
                Some(Status::new(CANCELLED, "cancelled"))
            }
        }
        Err(Ctl::Trap(msg)) => {
            eprintln!("fwp: trap: {} (in {})", msg, what);
            Some(Status::new(INTERNAL, format!("trap: {}", msg)))
        }
        Err(Ctl::Exit(code)) => {
            let _ = it.out.flush();
            std::process::exit(code);
        }
        Err(Ctl::Fail(e, t)) => {
            let shown = crate::value::display(&e, &t, it.prog, true);
            Some(Status::new(INTERNAL, format!("error: {}", shown)))
        }
    };
    finish(it, &c, &s, status);
}

/// End a served call with its status.
fn finish(it: &mut Interp, c: &ConnRef, s: &StreamRef, status: Option<Status>) {
    let mut cb = c.borrow_mut();
    let mut sb = s.borrow_mut();
    if cb.dead.is_some() || sb.reset.is_some() || sb.local_end {
        cb.streams.remove(&sb.id);
        return;
    }
    let (code, msg) = match &status {
        Some(st) => (st.code.to_string(), Some(h2::pct_encode(&st.message))),
        None => ("0".to_string(), None),
    };
    let mut hs: Vec<(&str, &str)> = Vec::new();
    let extra: Vec<(String, String)> = if sb.sent_headers {
        sb.out_trailers.clone()
    } else {
        sb.out_headers
            .iter()
            .chain(&sb.out_trailers)
            .cloned()
            .collect()
    };
    if !sb.sent_headers {
        hs.push((":status", "200"));
        hs.push(("content-type", "application/grpc"));
    }
    hs.push(("grpc-status", &code));
    if let Some(m) = &msg {
        hs.push(("grpc-message", m));
    }
    for (k, v) in &extra {
        hs.push((k, v));
    }
    let b = hpack::encode(&hs);
    let max = cb.peer.max_frame;
    cb.out.extend(h2::header_frames(sb.id, &b, true, max));
    sb.local_end = true;
    if !sb.remote_end {
        cb.out
            .extend(h2::frame(h2::RST_STREAM, 0, sb.id, &0u32.to_be_bytes()));
    }
    cb.streams.remove(&sb.id);
    drop(cb);
    drop(sb);
    it.world.event();
}

/// Receive the single request message of a call.
fn recv_one(it: &mut Interp, c: &ConnRef, s: &StreamRef) -> R<Result<Vec<u8>, Status>> {
    let m = match recv(it, c, s, None)? {
        Got::Msg(m) => m,
        Got::End(_) => {
            return Ok(Err(Status::new(
                INVALID_ARGUMENT,
                "missing request message",
            )))
        }
        Got::Lost(m, _) => {
            if s.borrow().bad.is_some() {
                return Ok(Err(Status::new(INVALID_ARGUMENT, m)));
            }
            return Err(Ctl::Cancelled);
        }
    };
    match recv(it, c, s, None)? {
        Got::End(_) => Ok(Ok(m)),
        Got::Msg(_) => Ok(Err(Status::new(
            INVALID_ARGUMENT,
            "expected one request message",
        ))),
        Got::Lost(m, _) => {
            if s.borrow().bad.is_some() {
                return Ok(Err(Status::new(INVALID_ARGUMENT, m)));
            }
            Err(Ctl::Cancelled)
        }
    }
}

/// The outcome of running a served function, as a status.
fn outcome(
    it: &mut Interp,
    r: R<Value>,
    error: Option<&MT>,
    what: &str,
) -> R<Result<Value, Result<Value, Status>>> {
    match r {
        Ok(v) => {
            it.join_children();
            Ok(Ok(v))
        }
        Err(Ctl::Fail(e, t)) => {
            it.cancel_children();
            if t == rpc::grpc_error_type() {
                return Ok(Err(Err(status_of_error(&e))));
            }
            if error.is_some() {
                return Ok(Err(Ok(e)));
            }
            let shown = crate::value::display(&e, &t, it.prog, true);
            Ok(Err(Err(Status::new(INTERNAL, format!("error: {}", shown)))))
        }
        Err(Ctl::Trap(msg)) => {
            it.cancel_children();
            let _ = it.out.flush();
            eprintln!("fwp: trap: {} (in {})", msg, what);
            Ok(Err(Err(Status::new(INTERNAL, format!("trap: {}", msg)))))
        }
        Err(Ctl::Exit(code)) => {
            let _ = it.out.flush();
            std::process::exit(code);
        }
        Err(Ctl::Cancelled) => {
            it.cancel_children();
            Err(Ctl::Cancelled)
        }
    }
}

fn run_method(
    it: &mut Interp,
    c: &ConnRef,
    s: &StreamRef,
    m: &Rc<Method>,
    headers: &[(String, String)],
    what: &str,
) -> R<Result<(), Status>> {
    if let Some(fp) = header(headers, "fwp-fingerprint") {
        if fp != m.fingerprint {
            return Ok(Err(Status::new(
                FAILED_PRECONDITION,
                format!(
                    "interface mismatch: the caller of {} was built against a different version of it",
                    what
                ),
            )));
        }
    }
    let prog = it.prog;
    let mut args = Vec::new();
    match &m.shape.input {
        Input::Args(ps) => {
            let msg = match recv_one(it, c, s)? {
                Ok(m) => m,
                Err(st) => return Ok(Err(st)),
            };
            let canon = match m.schema.decode(m.ms.request, &msg) {
                Ok(x) => x,
                Err(_) => {
                    return Ok(Err(Status::new(
                        INVALID_ARGUMENT,
                        "malformed request message",
                    )))
                }
            };
            let mut rd = Reader::new(&canon);
            for t in ps {
                match proto::decode(&mut rd, t, prog) {
                    Ok(v) => args.push(v),
                    Err(_) => {
                        return Ok(Err(Status::new(
                            INVALID_ARGUMENT,
                            "malformed request message",
                        )))
                    }
                }
            }
        }
        Input::Stream(t) => {
            let inc = Rc::new(Incoming {
                conn: c.clone(),
                stream: s.clone(),
                server: true,
                dec: Decoder::Native {
                    schema: m.schema.clone(),
                    node: m.ms.request,
                    ty: t.clone(),
                    error: None,
                },
                what: what.to_string(),
                deadline: None,
                results: false,
            });
            let cell = Rc::new(StreamCell {
                src: inc,
                memo: RefCell::new(None),
            });
            let f = m
                .iter_fn
                .ok_or_else(|| Ctl::Trap("internal: no iterator function".into()))?;
            args.push(it.call(f, vec![wrap(Native::Grpc(Obj::Cell(cell)))])?);
        }
    }
    let msg_error = m.shape.message_error(m.error.as_ref()).cloned();
    let enc = Encoder::Native {
        schema: m.schema.clone(),
        node: m.ms.response,
        ty: m.shape.response_type().clone(),
        error_tag: msg_error.is_some(),
    };
    if let Output::Chan(_) = &m.shape.output {
        args.push(sink_value(c, s, enc.clone()));
    }
    let fv = Value::Closure(Rc::new(Closure {
        func: m.func,
        args: vec![],
    }));
    let r = it.apply(fv, args);
    let v = match outcome(it, r, m.error.as_ref(), what)? {
        Ok(v) => v,
        Err(Err(st)) => return Ok(Err(st)),
        Err(Ok(e)) => {
            // the function's error, in the response's `oneof`
            let mut canon = vec![1];
            proto::encode(&mut canon, &e, msg_error.as_ref().unwrap(), prog);
            let msg = m
                .schema
                .encode(m.ms.response, &canon)
                .map_err(|e| Ctl::Trap(format!("cannot encode a message: {}", e)))?;
            send_msg(it, c, s, &msg, false)?;
            return Ok(Ok(()));
        }
    };
    match &m.shape.output {
        Output::Value(_) => {
            let msg = encode_msg(it, &enc, &v)?;
            send_msg(it, c, s, &msg, false)?;
        }
        Output::Iter(_) => {
            let mut cur = v;
            loop {
                let next = match iter_next(it, cur) {
                    Ok(n) => n,
                    Err(e) => {
                        return match outcome(it, Err(e), None, what)? {
                            Err(Err(st)) => Ok(Err(st)),
                            _ => Ok(Ok(())),
                        }
                    }
                };
                let Some((x, rest)) = next else {
                    break;
                };
                // a stream of results ends at an `Err`, with its status
                let x = match (&m.shape.results, &x) {
                    (Some(_), Value::Data(1, e)) => {
                        return Ok(Err(status_of_error(&e[0])));
                    }
                    (Some(_), Value::Data(0, v)) => v[0].clone(),
                    _ => x,
                };
                let msg = encode_msg(it, &enc, &x)?;
                if !send_msg(it, c, s, &msg, false)? {
                    it.check_cancel()?;
                    break;
                }
                cur = rest;
            }
        }
        Output::Chan(_) => {}
    }
    Ok(Ok(()))
}

fn call_value(c: &ConnRef, s: &StreamRef, server: bool, deadline: Option<Instant>) -> Value {
    wrap(Native::Grpc(Obj::Call(Rc::new(Call {
        conn: c.clone(),
        stream: s.clone(),
        server,
        deadline,
    }))))
}

fn run_fwp(
    it: &mut Interp,
    c: &ConnRef,
    s: &StreamRef,
    h: Value,
    what: &str,
) -> R<Result<(), Status>> {
    let call = call_value(c, s, true, None);
    let r = it.apply(h, vec![call]);
    match outcome(it, r, None, what)? {
        Ok(_) => Ok(Ok(())),
        Err(Err(st)) => Ok(Err(st)),
        Err(Ok(_)) => Ok(Ok(())),
    }
}

// ------------------------------------------------------- protobuf helpers

/// A field of a protobuf message: number, wire type, integer value and
/// bytes.
type PbField<'a> = (u32, u8, u64, &'a [u8]);

/// The fields of a message; `None` when it is malformed.
fn pb_fields(b: &[u8]) -> Option<Vec<PbField<'_>>> {
    let mut out = Vec::new();
    let mut i = 0;
    let varint = |i: &mut usize| -> Option<u64> {
        let mut x = 0u64;
        for k in 0..10 {
            let c = *b.get(*i)?;
            *i += 1;
            x |= ((c & 0x7f) as u64) << (7 * k);
            if c & 0x80 == 0 {
                return Some(x);
            }
        }
        None
    };
    while i < b.len() {
        let key = varint(&mut i)?;
        let num = (key >> 3) as u32;
        let wire = (key & 7) as u8;
        if num == 0 {
            return None;
        }
        match wire {
            0 => {
                let v = varint(&mut i)?;
                out.push((num, 0, v, &b[0..0]));
            }
            1 | 5 => {
                let n = if wire == 1 { 8 } else { 4 };
                let s = b.get(i..i + n)?;
                let mut v = 0u64;
                for (k, c) in s.iter().enumerate() {
                    v |= (*c as u64) << (8 * k);
                }
                i += n;
                out.push((num, wire, v, &b[0..0]));
            }
            2 => {
                let n = varint(&mut i)? as usize;
                let s = b.get(i..i.checked_add(n)?)?;
                i += n;
                out.push((num, 2, n as u64, s));
            }
            _ => return None,
        }
    }
    Some(out)
}

fn put_key(out: &mut Vec<u8>, num: u32, wire: u8) {
    crate::protobuf::varint(out, ((num as u64) << 3) | wire as u64);
}

fn put_bytes(out: &mut Vec<u8>, num: u32, b: &[u8]) {
    put_key(out, num, 2);
    crate::protobuf::varint(out, b.len() as u64);
    out.extend_from_slice(b);
}

// ------------------------------------------------- health and reflection

fn health(
    it: &mut Interp,
    c: &ConnRef,
    s: &StreamRef,
    server: &Server,
    watch: bool,
) -> R<Result<(), Status>> {
    let msg = match recv_one(it, c, s)? {
        Ok(m) => m,
        Err(st) => return Ok(Err(st)),
    };
    let name = pb_fields(&msg)
        .and_then(|fs| {
            fs.iter()
                .rev()
                .find(|f| f.0 == 1 && f.1 == 2)
                .map(|f| f.3.to_vec())
        })
        .unwrap_or_default();
    let name = String::from_utf8_lossy(&name).to_string();
    if !name.is_empty() && !server.services.contains(&name) {
        if !watch {
            return Ok(Err(Status::new(
                NOT_FOUND,
                format!("unknown service {}", name),
            )));
        }
        send_msg(it, c, s, &[0x08, 0x03], false)?; // SERVICE_UNKNOWN
    } else {
        send_msg(it, c, s, &[0x08, 0x01], false)?; // SERVING
    }
    if watch {
        loop {
            it.check_cancel()?;
            it.world.park(None);
        }
    }
    Ok(Ok(()))
}

fn reflect(it: &mut Interp, c: &ConnRef, s: &StreamRef, server: &Server) -> R<Result<(), Status>> {
    let refl = server.reflection.clone().unwrap_or_default();
    loop {
        let msg = match recv(it, c, s, None)? {
            Got::Msg(m) => m,
            Got::End(_) => return Ok(Ok(())),
            Got::Lost(m, _) => return Ok(Err(Status::new(INVALID_ARGUMENT, m))),
        };
        let resp = reflection_response(&refl, &msg);
        send_msg(it, c, s, &resp, false)?;
    }
}

/// The answer to a `ServerReflectionRequest`.
pub fn reflection_response(refl: &rpc::Reflection, req: &[u8]) -> Vec<u8> {
    let fields = pb_fields(req).unwrap_or_default();
    let mut out = Vec::new();
    let text = |f: &PbField| String::from_utf8_lossy(f.3).to_string();
    if let Some(h) = fields.iter().find(|f| f.0 == 1 && f.1 == 2) {
        put_bytes(&mut out, 1, h.3);
    }
    put_bytes(&mut out, 2, req);
    let error = |out: &mut Vec<u8>, code: u64, msg: &str| {
        let mut e = Vec::new();
        put_key(&mut e, 1, 0);
        crate::protobuf::varint(&mut e, code);
        put_bytes(&mut e, 2, msg.as_bytes());
        put_bytes(out, 7, &e);
    };
    let file = |out: &mut Vec<u8>| {
        let mut f = Vec::new();
        put_bytes(&mut f, 1, &refl.descriptor);
        put_bytes(out, 4, &f);
    };
    let known = |sym: &str| {
        refl.services
            .iter()
            .any(|s| sym == s || sym.starts_with(&format!("{}.", s)))
            || (!refl.package.is_empty() && sym.starts_with(&format!("{}.", refl.package)))
    };
    let health = |out: &mut Vec<u8>| {
        let mut f = Vec::new();
        put_bytes(&mut f, 1, &rpc::health_descriptor());
        put_bytes(out, 4, &f);
    };
    let req_field = fields.iter().find(|f| (3..=7).contains(&f.0) && f.1 == 2);
    match req_field {
        Some(f) if f.0 == 7 => {
            let mut l = Vec::new();
            for s in refl
                .services
                .iter()
                .map(|s| s.as_str())
                .chain(["grpc.health.v1.Health"])
            {
                let mut sr = Vec::new();
                put_bytes(&mut sr, 1, s.as_bytes());
                put_bytes(&mut l, 1, &sr);
            }
            put_bytes(&mut out, 6, &l);
        }
        Some(f) if f.0 == 3 => {
            if text(f) == rpc::HEALTH_FILE {
                health(&mut out);
            } else if text(f) == refl.file {
                file(&mut out);
            } else {
                error(
                    &mut out,
                    NOT_FOUND as u64,
                    &format!("unknown file {}", text(f)),
                );
            }
        }
        Some(f) if f.0 == 4 => {
            if text(f).starts_with("grpc.health.v1.") {
                health(&mut out);
            } else if known(&text(f)) {
                file(&mut out);
            } else {
                error(
                    &mut out,
                    NOT_FOUND as u64,
                    &format!("unknown symbol {}", text(f)),
                );
            }
        }
        Some(f) if f.0 == 6 => {
            let mut e = Vec::new();
            put_bytes(&mut e, 1, f.3);
            put_bytes(&mut out, 5, &e);
        }
        Some(f) => error(
            &mut out,
            NOT_FOUND as u64,
            &format!("no extension {}", text(f)),
        ),
        None => error(
            &mut out,
            INVALID_ARGUMENT as u64,
            "unsupported reflection request",
        ),
    }
    out
}

// ================================================================= serving

fn bind(addr: &str) -> Result<TcpListener, String> {
    let l = TcpListener::bind(addr)
        .map_err(|e| format!("cannot listen on {}: {}", addr, h2::io_msg(&e)))?;
    l.set_nonblocking(true)
        .map_err(|e| format!("cannot listen on {}: {}", addr, e))?;
    Ok(l)
}

/// Accept connections and serve them, until the task is cancelled.
fn accept_loop(
    it: &mut Interp,
    l: TcpListener,
    server: Rc<Server>,
    ctx: Option<Rc<tls::Ctx>>,
) -> R<()> {
    let fd = l.as_raw_fd();
    loop {
        match l.accept() {
            Ok((sock, peer)) => {
                let _ = sock.set_nodelay(true);
                if sock.set_nonblocking(true).is_err() {
                    continue;
                }
                let session = match &ctx {
                    Some(ctx) => match tls::Session::server(ctx, sock.as_raw_fd()) {
                        Ok(s) => Some(s),
                        Err(_) => continue,
                    },
                    None => None,
                };
                let c = Rc::new(RefCell::new(Conn::new(
                    sock,
                    peer.to_string(),
                    Some(server.clone()),
                )));
                c.borrow_mut().tls = session;
                let job = crate::sched::Baton(c);
                it.spawn_rust(
                    Box::new(move |it| {
                        let job = job;
                        serve_conn(it, job.0)
                    }),
                    None,
                    false,
                );
            }
            Err(e) if e.kind() == std::io::ErrorKind::WouldBlock => {
                it.check_cancel()?;
                it.world.blocking(|| poll_fd(fd, false, 100));
            }
            Err(e) if e.kind() == std::io::ErrorKind::Interrupted => {}
            Err(_) => {
                // out of descriptors: let connections close
                it.check_cancel()?;
                it.world
                    .blocking(|| std::thread::sleep(Duration::from_millis(50)));
            }
        }
    }
}

fn serve_conn(it: &mut Interp, c: ConnRef) {
    // a TLS connection's handshake, in this task
    let deadline = Instant::now() + HANDSHAKE;
    match finish_handshake(it, &c, Some(deadline)) {
        Ok(Ok(())) => {}
        Ok(Err(e)) => return conn_dead(it, &c, &e),
        Err(_) => return conn_dead(it, &c, "cancelled"),
    }
    let w = crate::sched::Baton(c.clone());
    it.spawn_rust(
        Box::new(move |it| {
            let w = w;
            writer(it, w.0)
        }),
        None,
        false,
    );
    it.world.event();
    reader(it, c.clone());
    let why = format!("connection to {} closed", c.borrow().authority);
    conn_dead(it, &c, &why);
}

/// A server's TLS context (offering h2), from its certificate and key
/// (and the CA of the client certificates it requires).
fn server_tls(files: Option<tls::ServerFiles>) -> Result<Option<Rc<tls::Ctx>>, String> {
    match files {
        Some(f) => tls::server_ctx(&f.cert, &f.key, &["h2".to_string()], &f.client_ca)
            .map(|c| Some(Rc::new(c))),
        None => Ok(None),
    }
}

/// Serve the program's service with the interpreter (`fwp serve`), over
/// TLS with a certificate and key.
pub fn serve(prog: &Program, listen: Option<String>, tls: Option<tls::ServerFiles>) -> i32 {
    let server = match compiled_server(prog) {
        Ok(s) => Rc::new(s),
        Err(e) => {
            eprintln!("fwp serve: {}", e);
            return 2;
        }
    };
    let ctx = match server_tls(tls) {
        Ok(c) => c,
        Err(e) => {
            eprintln!("fwp serve: {}", e);
            return 1;
        }
    };
    let given = crate::services::listen_address(prog, listen);
    // `tls://host:port` (as clients are given it) is host:port, with TLS
    let (secure, addr) = tls::grpc_addr(&given);
    let addr = addr.to_string();
    if secure && ctx.is_none() {
        eprintln!(
            "fwp serve: {} needs a certificate and key (--tls-cert and --tls-key, or FWP_TLS_CERT and FWP_TLS_KEY)",
            given
        );
        return 1;
    }
    let l = match bind(&addr) {
        Ok(l) => l,
        Err(e) => {
            eprintln!("fwp serve: {}", e);
            return 1;
        }
    };
    let local = l.local_addr().map(|a| a.to_string()).unwrap_or(addr);
    let scheme = if ctx.is_some() { "tls://" } else { "" };
    eprintln!(
        "fwp: service {} listening on {}{}",
        server.module, scheme, local
    );
    let stdout = std::io::stdout();
    let mut it = Interp::new(prog, Box::new(std::io::LineWriter::new(stdout)));
    match accept_loop(&mut it, l, server, ctx) {
        Ok(()) => 0,
        Err(_) => 1,
    }
}

// ============================================================= primitives

fn pairs_value(md: &[(String, String)]) -> Value {
    Value::list(
        md.iter()
            .map(|(k, v)| Value::tuple(vec![Value::str(k), Value::str(v)]))
            .collect(),
    )
}

fn bytes_of(v: &Value) -> Rc<[u8]> {
    match v {
        Value::Bytes(b) => b.clone(),
        Value::Str(s) => Rc::from(s.as_bytes()),
        _ => Rc::from(&[][..]),
    }
}

fn the_call(v: &Value) -> R<Rc<Call>> {
    match native(v)? {
        Native::Grpc(Obj::Call(c)) => Ok(c.clone()),
        _ => Err(Ctl::Trap("internal: not a gRPC stream".into())),
    }
}

/// The field `name` of a record value of nominal type `ty`.
fn field(prog: &Program, v: &Value, ty: &str, name: &str) -> Value {
    let i = match prog.shapes.get(&MT::con(ty)) {
        Some(crate::ir::TypeShape::Record(fs)) => fs.iter().position(|(l, _)| l == name),
        _ => None,
    };
    match (v, i) {
        (Value::Record(fs), Some(i)) => fs[i].clone(),
        _ => Value::unit(),
    }
}

fn u64_of(v: &Value) -> u64 {
    match v {
        Value::U64(x) => *x,
        other => other.as_i128().unwrap_or(0) as u64,
    }
}

/// The `grpc.*` and `pb.*` primitives.
pub fn prim(it: &mut Interp, id: FuncId, sym: &str, a: &mut [Value]) -> R<Value> {
    let _ = id;
    match sym {
        // ----- protobuf wire format
        "pb.parse" => {
            let b = bytes_of(&a[0]);
            Ok(opt(pb_fields(&b).map(|fs| {
                Value::list(
                    fs.iter()
                        .map(|(num, wire, bits, data)| {
                            Value::tuple(vec![
                                Value::U64(*bits),
                                Value::Bytes(Rc::from(*data)),
                                Value::I64(*num as i64),
                                Value::I64(*wire as i64),
                            ])
                        })
                        .collect(),
                )
            })))
        }
        "pb.write" => {
            let mut out = Vec::new();
            for f in a[0].list_items() {
                let Value::Record(fs) = &f else { continue };
                let bits = u64_of(&fs[0]);
                let data = bytes_of(&fs[1]);
                let num = fs[2].as_i128().unwrap_or(0) as u32;
                let wire = fs[3].as_i128().unwrap_or(0) as u8;
                put_key(&mut out, num, wire);
                match wire {
                    0 => crate::protobuf::varint(&mut out, bits),
                    1 => out.extend_from_slice(&bits.to_le_bytes()),
                    5 => out.extend_from_slice(&(bits as u32).to_le_bytes()),
                    _ => {
                        crate::protobuf::varint(&mut out, data.len() as u64);
                        out.extend_from_slice(&data);
                    }
                }
            }
            Ok(Value::Bytes(Rc::from(out)))
        }
        "pb.cast" => {
            let f = &it.prog.funcs[id];
            let (_, result) = f.ty.params(1);
            let x = match &a[0] {
                Value::U64(x) => *x as i128,
                v => v.as_i128().unwrap_or(0),
            };
            let name = match result {
                MT::Con(n, _) => n.trim_start_matches("std::"),
                _ => "",
            };
            Ok(match name {
                "I8" => Value::I8(x as i8),
                "I16" => Value::I16(x as i16),
                "I32" => Value::I32(x as i32),
                "U8" => Value::U8(x as u8),
                "U16" => Value::U16(x as u16),
                "U32" => Value::U32(x as u32),
                "U64" | "USize" => Value::U64(x as u64),
                "I128" => Value::I128(x),
                "U128" => Value::U128(x as u128),
                _ => Value::I64(x as i64),
            })
        }
        "pb.zigzag" => {
            let n = a[0].as_i128().unwrap_or(0) as i64;
            Ok(Value::U64(((n << 1) ^ (n >> 63)) as u64))
        }
        "pb.unzigzag" => {
            let n = u64_of(&a[0]);
            Ok(Value::I64(((n >> 1) as i64) ^ -((n & 1) as i64)))
        }
        "pb.f64-bits" => Ok(Value::U64(a[0].as_f64().unwrap_or(0.0).to_bits())),
        "pb.f64-from-bits" => Ok(Value::F64(f64::from_bits(u64_of(&a[0])))),
        "pb.f32-bits" => Ok(Value::U64(match &a[0] {
            Value::F32(x) => x.to_bits() as u64,
            other => (other.as_f64().unwrap_or(0.0) as f32).to_bits() as u64,
        })),
        "pb.f32-from-bits" => Ok(Value::F32(f32::from_bits(u64_of(&a[0]) as u32))),
        "pb.unpack" => {
            let wire = a[0].as_i128().unwrap_or(0);
            let b = bytes_of(&a[1]);
            let mut out = Vec::new();
            let mut i = 0;
            let ok = loop {
                if i >= b.len() {
                    break true;
                }
                match wire {
                    1 | 5 => {
                        let n = if wire == 1 { 8 } else { 4 };
                        let Some(s) = b.get(i..i + n) else {
                            break false;
                        };
                        let mut v = 0u64;
                        for (k, c) in s.iter().enumerate() {
                            v |= (*c as u64) << (8 * k);
                        }
                        out.push(Value::U64(v));
                        i += n;
                    }
                    _ => {
                        let mut x = 0u64;
                        let mut done = false;
                        for k in 0..10 {
                            let Some(c) = b.get(i) else { break };
                            i += 1;
                            x |= ((c & 0x7f) as u64) << (7 * k);
                            if c & 0x80 == 0 {
                                done = true;
                                break;
                            }
                        }
                        if !done {
                            break false;
                        }
                        out.push(Value::U64(x));
                    }
                }
            };
            Ok(opt(ok.then(|| Value::list(out))))
        }
        "pb.pack" => {
            let wire = a[0].as_i128().unwrap_or(0);
            let mut out = Vec::new();
            for v in a[1].list_items() {
                let x = u64_of(&v);
                match wire {
                    1 => out.extend_from_slice(&x.to_le_bytes()),
                    5 => out.extend_from_slice(&(x as u32).to_le_bytes()),
                    _ => crate::protobuf::varint(&mut out, x),
                }
            }
            Ok(Value::Bytes(Rc::from(out)))
        }
        // ----- typed calls and handlers
        "grpc.unary"
        | "grpc.server-streaming"
        | "grpc.client-streaming"
        | "grpc.bidi-streaming" => typed_call(it, sym, a),
        "grpc.unary-handler"
        | "grpc.server-streaming-handler"
        | "grpc._client-streaming-handler"
        | "grpc._bidi-streaming-handler" => typed_handler(it, sym, a),
        // ----- calls
        "grpc.open" => {
            let addr = a[0].as_str().to_string();
            let path = a[1].as_str().to_string();
            let deadline = it.grpc.deadline;
            match open_call(it, &addr, &path, &[])? {
                Ok((c, s, _)) => Ok(call_value(&c, &s, false, deadline)),
                Err(e) => Err(grpc_error(UNAVAILABLE, &e)),
            }
        }
        "grpc.send" => {
            let b = bytes_of(&a[0]);
            let call = the_call(&a[1])?;
            if call.server {
                send_msg(it, &call.conn, &call.stream, &b, false)?;
                it.check_cancel()?;
                return Ok(Value::unit());
            }
            if send_msg(it, &call.conn, &call.stream, &b, false)? {
                return Ok(Value::unit());
            }
            Err(closed_error(it, &call)?)
        }
        "grpc.close-send" => {
            let call = the_call(&a[0])?;
            if !call.server {
                send_data(it, &call.conn, &call.stream, &[], true)?;
            }
            Ok(Value::unit())
        }
        "grpc.recv" => {
            let call = the_call(&a[0])?;
            match recv(it, &call.conn, &call.stream, call.deadline)? {
                Got::Msg(m) => Ok(opt(Some(Value::Bytes(Rc::from(m))))),
                Got::End(st) if st.code == OK => Ok(opt(None)),
                Got::End(st) => Err(grpc_error(st.code, &st.message)),
                Got::Lost(m, _) => {
                    if call.server {
                        if s_bad(&call) {
                            return Err(fail_call(it, Status::new(INVALID_ARGUMENT, m)));
                        }
                        return Err(Ctl::Cancelled);
                    }
                    Err(grpc_error(UNAVAILABLE, &m))
                }
            }
        }
        "grpc.cancel" => {
            let call = the_call(&a[0])?;
            if !call.server {
                reset_stream(it, &call.conn, &call.stream, 8);
            }
            Ok(Value::unit())
        }
        // ----- context
        "grpc.metadata" => {
            let hs = it
                .grpc
                .serving
                .as_ref()
                .map(|s| s.headers.clone())
                .unwrap_or_default();
            Ok(Value::list(
                hs.iter()
                    .filter(|(k, _)| !k.starts_with(':') && !NOT_METADATA.contains(&k.as_str()))
                    .map(|(k, v)| Value::tuple(vec![Value::str(k), Value::str(v)]))
                    .collect(),
            ))
        }
        "grpc.with-metadata" => {
            let mut md = (*it.grpc.metadata).clone();
            for p in a[0].list_items() {
                if let Value::Record(kv) = &p {
                    let k = kv[0].as_str().to_ascii_lowercase();
                    let v = kv[1].as_str().replace(['\r', '\n'], " ");
                    if !k.is_empty() && !k.starts_with(':') {
                        md.push((k, v));
                    }
                }
            }
            let saved = std::mem::replace(&mut it.grpc.metadata, Rc::new(md));
            let r = it.apply(a[1].clone(), vec![Value::unit()]);
            it.grpc.metadata = saved;
            r
        }
        "grpc.peer-subject" => Ok(opt(it
            .grpc
            .serving
            .as_ref()
            .and_then(|s| s.peer.clone())
            .map(|p| Value::str(&p)))),
        "grpc.set-header" | "grpc.set-trailer" => {
            if let (Some(sv), Some(p)) = (
                it.grpc.serving.clone(),
                metadata_pair(a[0].as_str(), a[1].as_str()),
            ) {
                let mut sb = sv.stream.borrow_mut();
                if sym == "grpc.set-header" {
                    sb.out_headers.push(p);
                } else {
                    sb.out_trailers.push(p);
                }
            }
            Ok(Value::unit())
        }
        "grpc.with-gzip" => {
            let saved = std::mem::replace(&mut it.grpc.gzip, true);
            let r = it.apply(a[0].clone(), vec![Value::unit()]);
            it.grpc.gzip = saved;
            r
        }
        "grpc.with-response-metadata" => {
            let cap = Rc::new(RefCell::new(Vec::new()));
            let saved = it.grpc.capture.replace(cap.clone());
            let r = it.apply(a[0].clone(), vec![Value::unit()]);
            it.grpc.capture = saved;
            let v = r?;
            let md = cap.borrow().clone();
            if let Some(outer) = &it.grpc.capture {
                outer.borrow_mut().extend(md.iter().cloned());
            }
            Ok(Value::tuple(vec![v, pairs_value(&md)]))
        }
        "grpc.response-metadata" => {
            let call = the_call(&a[0])?;
            let md = response_metadata(&call.stream.borrow());
            Ok(pairs_value(&md))
        }
        "grpc.with-tls" => {
            // TlsOptions: alpn, ca-file, cert-file, insecure, key-file,
            // server-name
            let o = &a[0];
            let text = |name: &str| match field(it.prog, o, "std::TlsOptions", name) {
                Value::Data(1, ref fs) if !fs.is_empty() => fs[0].as_str().to_string(),
                _ => String::new(),
            };
            let t = ClientTls {
                ca: text("ca-file"),
                insecure: field(it.prog, o, "std::TlsOptions", "insecure").as_bool(),
                name: text("server-name"),
                cert: text("cert-file"),
                key: text("key-file"),
            };
            let saved = it.grpc.tls.replace(Rc::new(t));
            let r = it.apply(a[1].clone(), vec![Value::unit()]);
            it.grpc.tls = saved;
            r
        }
        "grpc.with-deadline" => {
            let nanos = match &a[0] {
                Value::Record(fs) => fs[0].as_i128().unwrap_or(0).max(0) as u64,
                _ => 0,
            };
            let now = Instant::now();
            let d = now
                .checked_add(Duration::from_nanos(nanos))
                .unwrap_or(now + Duration::from_secs(100 * 365 * 86400));
            let saved = it.grpc.deadline;
            it.grpc.deadline = earliest(saved, Some(d));
            let r = it.apply(a[1].clone(), vec![Value::unit()]);
            it.grpc.deadline = saved;
            r
        }
        // ----- serving
        "grpc._serve" | "grpc._serve-tls" => {
            // certificate and key first for TLS
            let (files, a) = if sym == "grpc._serve-tls" {
                (
                    Some(tls::ServerFiles {
                        cert: a[0].as_str().to_string(),
                        key: a[1].as_str().to_string(),
                        client_ca: a[2].as_str().to_string(),
                    }),
                    &a[3..],
                )
            } else {
                (None, &a[..])
            };
            let ctx = server_tls(files).map_err(|e| {
                Ctl::Fail(
                    Value::tuple(vec![Value::str("tls"), Value::str(&e)]),
                    MT::con("std::IoError"),
                )
            })?;
            let addr = a[0].as_str().to_string();
            let mut routes = HashMap::new();
            for r in a[1].list_items() {
                let path = field(it.prog, &r, "std::GrpcRoute", "path");
                let h = field(it.prog, &r, "std::GrpcRoute", "handler");
                routes.insert(path.as_str().to_string(), Route::Fwp(h));
            }
            let mut services = Vec::new();
            for p in routes.keys() {
                if let Some(p) = rpc::Path::parse(p) {
                    if !services.contains(&p.full_service()) {
                        services.push(p.full_service());
                    }
                }
            }
            routes.insert(HEALTH_CHECK.into(), Route::HealthCheck);
            routes.insert(HEALTH_WATCH.into(), Route::HealthWatch);
            let server = Rc::new(Server {
                routes,
                module: String::new(),
                services,
                reflection: None,
            });
            let l = bind(&addr).map_err(|e| {
                Ctl::Fail(
                    Value::tuple(vec![Value::str("listen"), Value::str(&e)]),
                    MT::con("std::IoError"),
                )
            })?;
            let local = l.local_addr().map(|a| a.to_string()).unwrap_or(addr);
            let _ = it.out.flush();
            let scheme = if ctx.is_some() { "tls://" } else { "" };
            eprintln!("fwp: gRPC server listening on {}{}", scheme, local);
            accept_loop(it, l, server, ctx)?;
            Ok(Value::unit())
        }
        "grpc._force" => {
            let cell = match native(&a[0])? {
                Native::Grpc(Obj::Cell(c)) => c.clone(),
                _ => return Err(Ctl::Trap("internal: not a gRPC stream".into())),
            };
            match force_cell(it, &cell, false) {
                Ok(v) => Ok(v),
                Err(CellErr::Ctl(e)) => Err(e),
                Err(CellErr::Failed(Failure::Status(st))) => Err(Ctl::Trap(st.message)),
                Err(CellErr::Failed(Failure::Transport(m))) => Err(Ctl::Trap(m)),
            }
        }
        _ => Err(Ctl::Trap(format!("primitive `{}` is not implemented", sym))),
    }
}

fn apply_bytes(it: &mut Interp, f: &Value, x: Value) -> R<Vec<u8>> {
    match &it.apply(f.clone(), vec![x])? {
        Value::Bytes(b) => Ok(b.to_vec()),
        _ => Err(Ctl::Trap(
            "internal: an encoder did not return bytes".into(),
        )),
    }
}

/// A received message as a `GrpcError` failure.
fn got_error(g: Got) -> Ctl {
    match g {
        Got::End(st) if st.code == OK => grpc_error(INTERNAL, "missing response message"),
        Got::End(st) => grpc_error(st.code, &st.message),
        Got::Lost(m, _) => grpc_error(UNAVAILABLE, &m),
        Got::Msg(_) => grpc_error(INTERNAL, "more than one response message"),
    }
}

/// `grpc.unary`, `grpc.server-streaming`, `grpc.client-streaming` and
/// `grpc.bidi-streaming`.
fn typed_call(it: &mut Interp, sym: &str, a: &mut [Value]) -> R<Value> {
    let (enc, dec) = (a[0].clone(), a[1].clone());
    let path = a[2].as_str().to_string();
    let addr = a[3].as_str().to_string();
    let deadline = it.grpc.deadline;
    let (c, s) = match open_call(it, &addr, &path, &[])? {
        Ok((c, s, _)) => (c, s),
        Err(e) => return Err(grpc_error(UNAVAILABLE, &e)),
    };
    if sym == "grpc.bidi-streaming" {
        // requests are sent as responses arrive
        let sender = spawn_sender(it, &c, &s, a[4].clone(), Encoder::Fwp(enc.clone()));
        let ch = a[5].clone();
        let r = (|| -> R<Value> {
            loop {
                match recv(it, &c, &s, deadline)? {
                    Got::Msg(m) => {
                        let v = it.apply(dec.clone(), vec![Value::Bytes(Rc::from(m))])?;
                        if let Some(r) = it.prim_conc("channel.send", &mut [ch.clone(), v]) {
                            r?;
                        }
                    }
                    Got::End(st) if st.code == OK => return Ok(Value::unit()),
                    g => return Err(got_error(g)),
                }
            }
        })();
        if let Some(e) = sender.finish(it) {
            return Err(e);
        }
        if r.is_err() {
            reset_stream(it, &c, &s, 8);
        }
        return r;
    }
    let r = (|| -> R<Value> {
        let streaming_in = sym == "grpc.client-streaming";
        if streaming_in {
            let mut cur = a[4].clone();
            while let Some((x, rest)) = iter_next(it, cur)? {
                let b = apply_bytes(it, &enc, x)?;
                if !send_msg(it, &c, &s, &b, false)? {
                    let call = Call {
                        conn: c.clone(),
                        stream: s.clone(),
                        server: false,
                        deadline,
                    };
                    return Err(closed_error(it, &call)?);
                }
                cur = rest;
            }
            send_data(it, &c, &s, &[], true)?;
        } else {
            let b = apply_bytes(it, &enc, a[4].clone())?;
            send_msg(it, &c, &s, &b, true)?;
        }
        if sym == "grpc.unary" || sym == "grpc.client-streaming" {
            let msg = match recv(it, &c, &s, deadline)? {
                Got::Msg(m) => m,
                g => return Err(got_error(g)),
            };
            match recv(it, &c, &s, deadline)? {
                Got::End(st) if st.code == OK => {}
                g => return Err(got_error(g)),
            }
            return it.apply(dec.clone(), vec![Value::Bytes(Rc::from(msg))]);
        }
        let ch = a[5].clone();
        loop {
            match recv(it, &c, &s, deadline)? {
                Got::Msg(m) => {
                    let v = it.apply(dec.clone(), vec![Value::Bytes(Rc::from(m))])?;
                    if let Some(r) = it.prim_conc("channel.send", &mut [ch.clone(), v]) {
                        r?;
                    }
                }
                Got::End(st) if st.code == OK => return Ok(Value::unit()),
                g => return Err(got_error(g)),
            }
        }
    })();
    if r.is_err() {
        reset_stream(it, &c, &s, 8);
    }
    r
}

/// The handlers of `grpc.serve` routes made from a decoder, an encoder and
/// a function.
fn typed_handler(it: &mut Interp, sym: &str, a: &mut [Value]) -> R<Value> {
    let a: Vec<Value> = if sym.starts_with("grpc._") {
        a.to_vec()
    } else {
        let mut v = vec![Value::unit()];
        v.extend(a.iter().cloned());
        v
    };
    let (iter_fn, dec, enc, f) = (&a[0], &a[1], &a[2], &a[3]);
    let call = the_call(&a[4])?;
    let (c, s) = (call.conn.clone(), call.stream.clone());
    let streaming_in = sym.starts_with("grpc._");
    let arg = if streaming_in {
        let inc = Rc::new(Incoming {
            conn: c.clone(),
            stream: s.clone(),
            server: true,
            dec: Decoder::Fwp(dec.clone()),
            what: String::new(),
            deadline: None,
            results: false,
        });
        let cell = wrap(Native::Grpc(Obj::Cell(Rc::new(StreamCell {
            src: inc,
            memo: RefCell::new(None),
        }))));
        it.apply(iter_fn.clone(), vec![cell])?
    } else {
        let m = match recv_one(it, &c, &s)? {
            Ok(m) => m,
            Err(st) => return Err(grpc_error(st.code, &st.message)),
        };
        match it.apply(dec.clone(), vec![Value::Bytes(Rc::from(m))]) {
            Ok(v) => v,
            Err(Ctl::Fail(e, _)) => {
                return Err(grpc_error(INVALID_ARGUMENT, &status_of_error(&e).message))
            }
            Err(e) => return Err(e),
        }
    };
    let chan_out = sym == "grpc.server-streaming-handler" || sym == "grpc._bidi-streaming-handler";
    if chan_out {
        let ch = sink_value(&c, &s, Encoder::Fwp(enc.clone()));
        it.apply(f.clone(), vec![arg, ch])?;
    } else {
        let v = it.apply(f.clone(), vec![arg])?;
        let b = apply_bytes(it, enc, v)?;
        send_msg(it, &c, &s, &b, false)?;
        it.check_cancel()?;
    }
    Ok(Value::unit())
}

fn s_bad(call: &Call) -> bool {
    call.stream.borrow().bad.is_some()
}

/// Sending on a client stream failed: the status the server ended it
/// with, or `UNAVAILABLE`.
fn closed_error(it: &mut Interp, call: &Call) -> R<Ctl> {
    match recv(it, &call.conn, &call.stream, call.deadline)? {
        Got::End(st) if st.code != OK => Ok(grpc_error(st.code, &st.message)),
        Got::Lost(m, _) => Ok(grpc_error(UNAVAILABLE, &m)),
        _ => Ok(grpc_error(UNAVAILABLE, "the stream is closed")),
    }
}

// HTTP/2 for `http.serve` and `http.send` (lib/http.fwp), on the
// connections above.
#[path = "h2web.rs"]
pub(crate) mod web;
