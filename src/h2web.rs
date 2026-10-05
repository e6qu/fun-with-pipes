//! HTTP/2 for the HTTP server and client of lib/http.fwp, on the HTTP/2
//! connections of gRPC (this is a child module of grpc.rs and shares its
//! framing, HPACK, flow control and reader and writer tasks), plus the
//! primitives of HTTP compression (`gzip.*`, `deflate.*`) and of
//! WebSocket frames (`ws.*`). runtime/fwp_rt_http2.c is the C runtime's
//! side, with the same behavior.
//!
//! A server connection (`http2.serve`) runs in the task of the HTTP/1.1
//! connection that turned out to be HTTP/2 (it started with the
//! connection preface); it reads frames itself (with the server's idle
//! timeout, and a graceful GOAWAY on shutdown or after the requests per
//! connection) and starts a task per stream that runs an fwp function of
//! lib/http.fwp, which reads the request and writes the response with the
//! `http2.*` primitives below. A client connection (`http2.send`) is
//! pooled per origin, with gRPC's reader and writer tasks.

use std::cell::Cell;

use super::*;
use crate::sched::Baton;

/// Streams open at once on a server connection
/// (SETTINGS_MAX_CONCURRENT_STREAMS); more are refused.
const MAX_STREAMS: usize = 128;

/// What a server connection serves.
pub(crate) struct Web {
    /// The fwp function run for every stream (`H2Stream -> ()`).
    handler: Value,
    max_header: usize,
    max_requests: u64,
    served: Cell<u64>,
    /// GOAWAY was sent: new streams are refused.
    draining: Cell<bool>,
}

fn io_fail(kind: &str, msg: &str) -> Ctl {
    Ctl::Fail(
        Value::tuple(vec![Value::str(kind), Value::str(msg)]),
        MT::Con("std::IoError".into(), vec![]),
    )
}

fn rst(c: &mut Conn, sid: u32, code: u32) {
    c.out
        .extend(h2::frame(h2::RST_STREAM, 0, sid, &code.to_be_bytes()));
}

fn goaway_graceful(c: &mut Conn) {
    let mut p = c.last_stream.to_be_bytes().to_vec();
    p.extend_from_slice(&0u32.to_be_bytes());
    c.out.extend(h2::frame(h2::GOAWAY, 0, 0, &p));
}

/// A request's header block arrived on a server connection.
pub(super) fn new_stream(
    c: &mut Conn,
    w: &Rc<Web>,
    sid: u32,
    hs: Vec<(String, String)>,
    end: bool,
    acts: &mut Acts,
) {
    if sid.is_multiple_of(2) || sid <= c.last_stream {
        return;
    }
    c.last_stream = sid;
    if w.draining.get() || c.streams.len() >= MAX_STREAMS {
        return rst(c, sid, 7); // REFUSED_STREAM
    }
    let size: usize = hs.iter().map(|(k, v)| k.len() + v.len() + 4).sum();
    if size > w.max_header {
        let b = hpack::encode(&[(":status", "431")]);
        let max = c.peer.max_frame;
        c.out.extend(h2::header_frames(sid, &b, true, max));
        if !end {
            rst(c, sid, 0);
        }
        return;
    }
    let method = header(&hs, ":method").unwrap_or("");
    if method.is_empty() || header(&hs, ":path").unwrap_or("").is_empty() {
        return rst(c, sid, 1); // PROTOCOL_ERROR
    }
    w.served.set(w.served.get() + 1);
    if w.served.get() >= w.max_requests {
        w.draining.set(true);
        goaway_graceful(c);
    }
    let s = Rc::new(RefCell::new(Stream {
        id: sid,
        headers: hs,
        got_headers: true,
        remote_end: end,
        window: c.peer.init_window,
        raw: true,
        ..Default::default()
    }));
    c.streams.insert(sid, s.clone());
    acts.new_streams.push(s);
}

/// Start the task of a stream.
fn start(it: &mut Interp, c: &ConnRef, s: StreamRef, w: &Rc<Web>) {
    let call = wrap(Native::Grpc(Obj::Call(Rc::new(Call {
        conn: c.clone(),
        stream: s.clone(),
        server: true,
        deadline: None,
    }))));
    let job = Baton((c.clone(), s.clone(), w.handler.clone(), call));
    let t = it.spawn_rust(
        Box::new(move |it| {
            let job = job;
            let Baton((c, s, h, call)) = job;
            match it.apply(h, vec![call]) {
                Ok(_) | Err(Ctl::Cancelled) => {}
                Err(Ctl::Exit(code)) => {
                    let _ = it.out.flush();
                    std::process::exit(code);
                }
                Err(e) => {
                    let _ = it.out.flush();
                    let code = crate::interp::report(&Err(e), it.prog);
                    std::process::exit(code);
                }
            }
            end_stream(it, &c, &s);
        }),
        None,
        false,
    );
    s.borrow_mut().task = Some(t);
}

/// A stream's task finished: reset what it left open and forget it.
fn end_stream(it: &mut Interp, c: &ConnRef, s: &StreamRef) {
    let mut cb = c.borrow_mut();
    let sb = s.borrow();
    if cb.dead.is_none() && cb.streams.remove(&sb.id).is_some() {
        if !sb.local_end {
            rst(&mut cb, sb.id, 2); // INTERNAL_ERROR
        } else if !sb.remote_end {
            rst(&mut cb, sb.id, 0); // NO_ERROR: the request body is not needed
        }
    }
    drop(cb);
    drop(sb);
    it.world.event();
}

fn take_conn(v: &Value) -> R<(Option<TcpStream>, Option<tls::Session>)> {
    match native(v)? {
        Native::Conn(c, t) => Ok((c.borrow_mut().take(), t.borrow_mut().take())),
        _ => Err(Ctl::Trap("internal: not a connection".into())),
    }
}

fn duration(v: &Value) -> Duration {
    let n = match v {
        Value::Record(fs) => fs[0].as_i128().unwrap_or(0),
        _ => 0,
    };
    Duration::from_nanos(n.clamp(0, u64::MAX as i128) as u64)
}

fn int(v: &Value) -> i64 {
    v.as_i128().unwrap_or(0) as i64
}

fn bytes(v: &Value) -> Rc<[u8]> {
    bytes_of(v)
}

fn shutdown_requested(it: &mut Interp) -> bool {
    match it.prim_conc("signal.shutdown-requested", &mut [Value::unit()]) {
        Some(Ok(v)) => v.as_bool(),
        _ => false,
    }
}

/// `http2.serve`: serve an HTTP/2 connection until it closes, its idle
/// timeout passes, or (after a GOAWAY) its last stream ended.
fn serve(it: &mut Interp, a: &mut [Value]) -> R<Value> {
    let (sock, session) = take_conn(&a[0])?;
    let Some(sock) = sock else {
        return Ok(Value::unit());
    };
    let initial = bytes(&a[1]);
    let limits = match &a[2] {
        Value::Record(fs) => fs.clone(),
        _ => return Err(Ctl::Trap("internal: limits".into())),
    };
    let idle = duration(&limits[2]);
    let fd = sock.as_raw_fd();
    let peer = sock.peer_addr().map(|a| a.to_string()).unwrap_or_default();
    let mut conn = Conn::new(sock, peer, None);
    conn.out.clear();
    conn.out.extend(h2::our_settings());
    // SETTINGS_MAX_CONCURRENT_STREAMS
    let mut st = vec![0, 3];
    st.extend_from_slice(&(MAX_STREAMS as u32).to_be_bytes());
    conn.out.extend(h2::frame(h2::SETTINGS, 0, 0, &st));
    conn.preface = false;
    conn.tls = session;
    let w = Rc::new(Web {
        handler: a[3].clone(),
        max_header: int(&limits[0]).max(0) as usize,
        max_requests: int(&limits[1]).max(1) as u64,
        served: Cell::new(0),
        draining: Cell::new(false),
    });
    conn.web = Some(w.clone());
    let c = Rc::new(RefCell::new(conn));
    let wc = Baton(c.clone());
    it.spawn_rust(
        Box::new(move |it| {
            let wc = wc;
            writer(it, wc.0)
        }),
        None,
        false,
    );
    let mut last = Instant::now();
    let mut buf = vec![0u8; 65536];
    let mut input: Option<Vec<u8>> = Some(initial.to_vec());
    let why = loop {
        let got = match input.take() {
            Some(b) => Some(b),
            None => {
                if c.borrow().dead.is_some() {
                    break String::new();
                }
                if let Err(e) = it.check_cancel() {
                    conn_dead(it, &c, "cancelled");
                    return Err(e);
                }
                if !w.draining.get() && shutdown_requested(it) {
                    w.draining.set(true);
                    goaway_graceful(&mut c.borrow_mut());
                    it.world.event();
                }
                let idle_now = c.borrow().streams.is_empty();
                if idle_now && w.draining.get() {
                    break "draining".into();
                }
                if idle_now && last.elapsed() >= idle {
                    w.draining.set(true);
                    goaway_graceful(&mut c.borrow_mut());
                    break "idle".into();
                }
                if !idle_now {
                    last = Instant::now();
                }
                let r = match conn_read(&mut c.borrow_mut(), &mut buf) {
                    Some(r) => r,
                    None => break String::new(),
                };
                match r {
                    Io::Done(0) => break "closed".into(),
                    Io::Done(n) => Some(buf[..n].to_vec()),
                    Io::Wait(wr) => {
                        it.world.blocking(|| poll_fd(fd, wr, 100));
                        None
                    }
                    Io::Err(e) if e.kind() == std::io::ErrorKind::Interrupted => None,
                    r => break io_text(&r),
                }
            }
        };
        let Some(b) = got else { continue };
        last = Instant::now();
        let acts = process_input(&mut c.borrow_mut(), &b);
        for t in acts.cancel {
            t.cancel();
        }
        for s in acts.new_streams {
            start(it, &c, s, &w);
        }
        it.world.event();
        if let Some(why) = acts.dead {
            break why;
        }
    };
    flush_now(it, &c);
    let why = if why.is_empty() {
        "connection closed".to_string()
    } else {
        why
    };
    conn_dead(it, &c, &why);
    it.join_children();
    Ok(Value::unit())
}

fn the_stream(v: &Value) -> R<(ConnRef, StreamRef)> {
    let call = the_call(v)?;
    Ok((call.conn.clone(), call.stream.clone()))
}

/// Header names an HTTP/2 message may not carry.
fn connection_specific(k: &str) -> bool {
    matches!(
        k,
        "connection" | "keep-alive" | "proxy-connection" | "transfer-encoding" | "upgrade"
    )
}

/// `http2.request`: (method, path, headers, remote address, the subject
/// of the client's certificate). `:authority` becomes `host`.
fn request(a: &[Value]) -> R<Value> {
    let (c, s) = the_stream(&a[0])?;
    let sb = s.borrow();
    let cb = c.borrow();
    let mut hs = Vec::new();
    if header(&sb.headers, "host").is_none() {
        if let Some(h) = header(&sb.headers, ":authority") {
            hs.push(Value::tuple(vec![Value::str("host"), Value::str(h)]));
        }
    }
    for (k, v) in &sb.headers {
        if !k.starts_with(':') {
            hs.push(Value::tuple(vec![Value::str(k), Value::str(v)]));
        }
    }
    let peer = cb.tls.as_ref().and_then(|t| t.peer_subject());
    Ok(Value::tuple(vec![
        Value::str(header(&sb.headers, ":method").unwrap_or("")),
        Value::str(header(&sb.headers, ":path").unwrap_or("")),
        Value::list(hs),
        Value::str(&cb.authority),
        opt(peer.map(|p| Value::str(&p))),
    ]))
}

/// `http2.body max timeout stream`: the whole request body; `Err 413` when
/// it is larger than `max`, `Err 408` when it did not arrive in time, and
/// `Err 0` when the stream or connection is gone.
fn body(it: &mut Interp, a: &[Value]) -> R<Value> {
    let max = int(&a[0]).max(0) as usize;
    let until = Instant::now().checked_add(duration(&a[1]));
    let (c, s) = the_stream(&a[2])?;
    let err = |code: i64| Value::data(1, vec![Value::I64(code)]);
    loop {
        {
            let sb = s.borrow();
            if sb.data.len() > max {
                return Ok(err(413));
            }
            if sb.remote_end {
                return Ok(Value::data(0, vec![Value::Bytes(Rc::from(&sb.data[..]))]));
            }
            if sb.reset.is_some() || c.borrow().dead.is_some() {
                return Ok(err(0));
            }
        }
        it.check_cancel()?;
        if until.is_some_and(|u| Instant::now() >= u) {
            return Ok(err(408));
        }
        let wake = earliest(until, it.task.deadline());
        it.world.park(wake);
    }
}

/// `http2.respond status headers body end stream`: the response headers,
/// then the body (if any), ending the stream with `end`; `False` when the
/// stream is gone.
fn respond(it: &mut Interp, a: &[Value]) -> R<Value> {
    let status = int(&a[0]).to_string();
    let body = bytes(&a[2]);
    let end = a[3].as_bool();
    let (c, s) = the_stream(&a[4])?;
    let pairs: Vec<(String, String)> = a[1]
        .list_items()
        .iter()
        .filter_map(|h| match h {
            Value::Record(fs) => Some((
                fs[0].as_str().to_ascii_lowercase(),
                fs[1].as_str().to_string(),
            )),
            _ => None,
        })
        .filter(|(k, _)| !connection_specific(k) && !k.starts_with(':'))
        .collect();
    {
        let mut cb = c.borrow_mut();
        let mut sb = s.borrow_mut();
        if cb.dead.is_some() || sb.reset.is_some() || sb.sent_headers {
            return Ok(Value::bool(false));
        }
        sb.sent_headers = true;
        let mut hs: Vec<(&str, &str)> = vec![(":status", &status)];
        for (k, v) in &pairs {
            hs.push((k, v));
        }
        let b = hpack::encode(&hs);
        let max = cb.peer.max_frame;
        let only = body.is_empty() && end;
        cb.out.extend(h2::header_frames(sb.id, &b, only, max));
        if only {
            sb.local_end = true;
        }
    }
    it.world.event();
    if body.is_empty() && end {
        return Ok(Value::bool(true));
    }
    if body.is_empty() {
        return Ok(Value::bool(true));
    }
    Ok(Value::bool(send_data(it, &c, &s, &body, end)?))
}

/// `http2.data bytes end stream`: a chunk of a streamed body.
fn data(it: &mut Interp, a: &[Value]) -> R<Value> {
    let d = bytes(&a[0]);
    let end = a[1].as_bool();
    let (c, s) = the_stream(&a[2])?;
    if d.is_empty() && !end {
        return Ok(Value::bool(
            s.borrow().reset.is_none() && c.borrow().dead.is_none(),
        ));
    }
    Ok(Value::bool(send_data(it, &c, &s, &d, end)?))
}

fn pool_key(k: &str) -> String {
    format!("http2\u{0}{}", k)
}

fn pooled(it: &Interp, key: &str) -> Option<ConnRef> {
    let sh = it.world.grpc.lock().unwrap();
    sh.0.pool.get(&pool_key(key)).cloned().filter(|c| {
        let cb = c.borrow();
        cb.dead.is_none() && !cb.goaway && cb.next_stream < 0x7fff_0000
    })
}

/// A client connection made of a connected `Conn`, pooled under `key`.
fn adopt(it: &mut Interp, key: &str, v: &Value) -> R<ConnRef> {
    let (sock, session) = take_conn(v)?;
    let Some(sock) = sock else {
        return Err(io_fail("closed", "connection is closed"));
    };
    let mut conn = Conn::new(sock, key.to_string(), None);
    conn.tls = session;
    let c = Rc::new(RefCell::new(conn));
    let (r, w) = (Baton(c.clone()), Baton(c.clone()));
    it.spawn_rust(Box::new(move |it| reader(it, r.0)), None, true);
    it.spawn_rust(Box::new(move |it| writer(it, w.0)), None, true);
    it.world
        .grpc
        .lock()
        .unwrap()
        .0
        .pool
        .insert(pool_key(key), c.clone());
    Ok(c)
}

/// `http2.send key conn (method, scheme, authority, path, headers, body)`:
/// a request on the pooled connection of `key` (made of `conn` when given)
/// and its whole response: (status, headers, body).
fn send(it: &mut Interp, a: &[Value]) -> R<Value> {
    it.check_cancel()?;
    let key = a[0].as_str().to_string();
    let c = match &a[1] {
        Value::Data(1, fs) => adopt(it, &key, &fs[0])?,
        _ => match pooled(it, &key) {
            Some(c) => c,
            None => return Err(io_fail("http2", "no connection")),
        },
    };
    let Value::Record(r) = &a[2] else {
        return Err(Ctl::Trap("internal: request".into()));
    };
    let body = bytes(&r[5]);
    let user: Vec<(String, String)> = r[4]
        .list_items()
        .iter()
        .filter_map(|h| match h {
            Value::Record(fs) => Some((
                fs[0].as_str().to_ascii_lowercase(),
                fs[1].as_str().to_string(),
            )),
            _ => None,
        })
        .filter(|(k, _)| !connection_specific(k) && k != "host" && !k.starts_with(':'))
        .collect();
    let s = {
        let mut cb = c.borrow_mut();
        if let Some(d) = &cb.dead {
            return Err(io_fail("http2", d));
        }
        let id = cb.next_stream;
        cb.next_stream += 2;
        let mut hs: Vec<(&str, &str)> = vec![
            (":method", r[0].as_str()),
            (":scheme", r[1].as_str()),
            (":authority", r[2].as_str()),
            (":path", r[3].as_str()),
        ];
        for (k, v) in &user {
            hs.push((k, v));
        }
        let block = hpack::encode(&hs);
        let max = cb.peer.max_frame;
        cb.out
            .extend(h2::header_frames(id, &block, body.is_empty(), max));
        let s = Rc::new(RefCell::new(Stream {
            id,
            window: cb.peer.init_window,
            raw: true,
            local_end: body.is_empty(),
            ..Default::default()
        }));
        cb.streams.insert(id, s.clone());
        s
    };
    it.world.event();
    if !body.is_empty() {
        if let Err(e) = send_data(it, &c, &s, &body, true) {
            reset_stream(it, &c, &s, 8);
            return Err(e);
        }
    }
    loop {
        {
            let sb = s.borrow();
            if sb.remote_end {
                let status = header(&sb.headers, ":status")
                    .and_then(|v| v.parse::<i64>().ok())
                    .unwrap_or(0);
                let hs: Vec<Value> = sb
                    .headers
                    .iter()
                    .chain(&sb.trailers)
                    .filter(|(k, _)| !k.starts_with(':'))
                    .map(|(k, v)| Value::tuple(vec![Value::str(k), Value::str(v)]))
                    .collect();
                let out = Value::tuple(vec![
                    Value::I64(status),
                    Value::list(hs),
                    Value::Bytes(Rc::from(&sb.data[..])),
                ]);
                let id = sb.id;
                drop(sb);
                c.borrow_mut().streams.remove(&id);
                return Ok(out);
            }
            if let Some(r) = &sb.reset {
                return Err(io_fail("http2", r));
            }
        }
        if let Err(e) = it.check_cancel() {
            reset_stream(it, &c, &s, 8); // CANCEL
            return Err(e);
        }
        let until = it.task.deadline();
        it.world.park(until);
    }
}

// =============================================================== compression

/// Adler-32 (RFC 1950).
fn adler32(d: &[u8]) -> u32 {
    let (mut a, mut b) = (1u32, 0u32);
    for chunk in d.chunks(5552) {
        for &x in chunk {
            a += x as u32;
            b += a;
        }
        a %= 65521;
        b %= 65521;
    }
    b << 16 | a
}

/// The zlib format (RFC 1950) of HTTP's `deflate` content coding.
pub fn zlib(d: &[u8]) -> Vec<u8> {
    let mut out = vec![0x78, 0x01];
    out.extend(crate::gzip::deflate(d));
    out.extend_from_slice(&adler32(d).to_be_bytes());
    out
}

/// Decode `deflate` content: the zlib format, or raw DEFLATE (which some
/// servers send instead).
pub fn unzlib(d: &[u8], max: usize) -> Result<Vec<u8>, String> {
    let wrapped =
        d.len() >= 2 && d[0] & 0x0f == 8 && (u16::from(d[0]) << 8 | u16::from(d[1])) % 31 == 0;
    if !wrapped {
        return crate::gzip::inflate(d, max).map(|r| r.0);
    }
    if d[1] & 0x20 != 0 {
        return Err("a preset dictionary is not supported".into());
    }
    let (out, used) = crate::gzip::inflate(&d[2..], max)?;
    let t = 2 + used;
    if t + 4 > d.len() {
        return Err("truncated zlib data".into());
    }
    if u32::from_be_bytes([d[t], d[t + 1], d[t + 2], d[t + 3]]) != adler32(&out) {
        return Err("zlib checksum mismatch".into());
    }
    Ok(out)
}

fn result_bytes(r: Result<Vec<u8>, String>) -> Value {
    match r {
        Ok(b) => Value::data(0, vec![Value::Bytes(Rc::from(b))]),
        Err(e) => Value::data(1, vec![Value::str(&e)]),
    }
}

// ================================================================ WebSocket

/// SHA-1 (FIPS 180-4), for `Sec-WebSocket-Accept`.
pub fn sha1(data: &[u8]) -> [u8; 20] {
    let mut h: [u32; 5] = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0];
    let mut m = data.to_vec();
    m.push(0x80);
    while m.len() % 64 != 56 {
        m.push(0);
    }
    m.extend_from_slice(&((data.len() as u64) * 8).to_be_bytes());
    for block in m.chunks(64) {
        let mut w = [0u32; 80];
        for i in 0..16 {
            w[i] = u32::from_be_bytes([
                block[4 * i],
                block[4 * i + 1],
                block[4 * i + 2],
                block[4 * i + 3],
            ]);
        }
        for i in 16..80 {
            w[i] = (w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16]).rotate_left(1);
        }
        let [mut a, mut b, mut c, mut d, mut e] = h;
        for (i, wi) in w.iter().enumerate() {
            let (f, k) = match i {
                0..=19 => ((b & c) | (!b & d), 0x5A827999),
                20..=39 => (b ^ c ^ d, 0x6ED9EBA1),
                40..=59 => ((b & c) | (b & d) | (c & d), 0x8F1BBCDC),
                _ => (b ^ c ^ d, 0xCA62C1D6),
            };
            let t = a
                .rotate_left(5)
                .wrapping_add(f)
                .wrapping_add(e)
                .wrapping_add(k)
                .wrapping_add(*wi);
            e = d;
            d = c;
            c = b.rotate_left(30);
            b = a;
            a = t;
        }
        for (x, y) in h.iter_mut().zip([a, b, c, d, e]) {
            *x = x.wrapping_add(y);
        }
    }
    let mut out = [0u8; 20];
    for (i, x) in h.iter().enumerate() {
        out[4 * i..4 * i + 4].copy_from_slice(&x.to_be_bytes());
    }
    out
}

pub fn base64(d: &[u8]) -> String {
    const A: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    let mut out = String::new();
    for c in d.chunks(3) {
        let n = (c[0] as u32) << 16
            | (*c.get(1).unwrap_or(&0) as u32) << 8
            | *c.get(2).unwrap_or(&0) as u32;
        for k in 0..4 {
            if k <= c.len() {
                out.push(A[(n >> (18 - 6 * k) & 63) as usize] as char);
            } else {
                out.push('=');
            }
        }
    }
    out
}

/// `Sec-WebSocket-Accept` for a `Sec-WebSocket-Key`.
pub fn ws_accept(key: &str) -> String {
    let mut k = key.trim().as_bytes().to_vec();
    k.extend_from_slice(b"258EAFA5-E914-47DA-95CA-C5AB0DC85B11");
    base64(&sha1(&k))
}

thread_local! {
    static MASK_STATE: Cell<u64> = const { Cell::new(0) };
}

#[cfg(not(target_family = "wasm"))]
fn pid() -> u32 {
    std::process::id()
}

#[cfg(target_family = "wasm")]
fn pid() -> u32 {
    0
}

/// A masking key: unpredictable enough for RFC 6455's purpose (keeping
/// intermediaries from caching attacker-chosen bytes).
fn mask_key() -> [u8; 4] {
    MASK_STATE.with(|s| {
        let mut x = s.get();
        if x == 0 {
            let t = std::time::SystemTime::now()
                .duration_since(std::time::UNIX_EPOCH)
                .map(|d| d.as_nanos() as u64)
                .unwrap_or(1);
            x = t ^ (pid() as u64) << 32 | 1;
        }
        x ^= x << 13;
        x ^= x >> 7;
        x ^= x << 17;
        s.set(x);
        (x as u32).to_be_bytes()
    })
}

/// A complete (FIN) frame; masked with a fresh key for clients. An
/// opcode plus 64 sets RSV1 (a compressed message, RFC 7692).
pub fn ws_frame(mask: bool, opcode: u8, payload: &[u8]) -> Vec<u8> {
    let n = payload.len();
    let mut out = Vec::with_capacity(n + 14);
    out.push(0x80 | (opcode & 0x4f));
    let mb = if mask { 0x80 } else { 0 };
    if n < 126 {
        out.push(mb | n as u8);
    } else if n < 65536 {
        out.push(mb | 126);
        out.extend_from_slice(&(n as u16).to_be_bytes());
    } else {
        out.push(mb | 127);
        out.extend_from_slice(&(n as u64).to_be_bytes());
    }
    if mask {
        let k = mask_key();
        out.extend_from_slice(&k);
        out.extend(payload.iter().enumerate().map(|(i, b)| b ^ k[i & 3]));
    } else {
        out.extend_from_slice(payload);
    }
    out
}

/// The first frame of `buf`: (bytes it took, FIN, opcode, masked, the
/// payload unmasked); 0 bytes when more are needed, and the negated close
/// code of a malformed frame (1002) or one larger than `max` (1009). The
/// opcode of a frame with RSV1 set (compressed) is 64 more.
pub fn ws_parse(max: usize, buf: &[u8]) -> (i64, bool, i64, bool, Vec<u8>) {
    let none = |k: i64| (k, false, 0, false, Vec::new());
    if buf.len() < 2 {
        return none(0);
    }
    let (b0, b1) = (buf[0], buf[1]);
    let op = b0 & 0x0f;
    if b0 & 0x30 != 0 || !matches!(op, 0 | 1 | 2 | 8 | 9 | 10) {
        return none(-1002);
    }
    let control = op >= 8;
    if control && (b0 & 0x80 == 0 || b1 & 0x7f > 125) {
        return none(-1002);
    }
    let masked = b1 & 0x80 != 0;
    let mut at = 2;
    let mut n = (b1 & 0x7f) as u64;
    if n == 126 {
        if buf.len() < 4 {
            return none(0);
        }
        n = u16::from_be_bytes([buf[2], buf[3]]) as u64;
        at = 4;
    } else if n == 127 {
        if buf.len() < 10 {
            return none(0);
        }
        let mut b = [0u8; 8];
        b.copy_from_slice(&buf[2..10]);
        n = u64::from_be_bytes(b);
        if n >> 63 != 0 {
            return none(-1002);
        }
        at = 10;
    }
    if n > max as u64 {
        return none(-1009);
    }
    let k = if masked {
        if buf.len() < at + 4 {
            return none(0);
        }
        at += 4;
        [buf[at - 4], buf[at - 3], buf[at - 2], buf[at - 1]]
    } else {
        [0; 4]
    };
    let n = n as usize;
    if buf.len() < at + n {
        return none(0);
    }
    let p = &buf[at..at + n];
    let payload = if masked {
        p.iter().enumerate().map(|(i, b)| b ^ k[i & 3]).collect()
    } else {
        p.to_vec()
    };
    let op = op | (b0 & 0x40);
    ((at + n) as i64, b0 & 0x80 != 0, op as i64, masked, payload)
}

/// A message compressed for permessage-deflate (RFC 7692) without
/// context takeover: a block flushed to a byte, without the flush's
/// final `00 00 ff ff`.
pub fn ws_deflate(data: &[u8]) -> Vec<u8> {
    let mut z = crate::gzip::gzip_chunk(data);
    z.truncate(z.len() - 4);
    z
}

/// A permessage-deflate message decompressed, up to `max` bytes: 0 and
/// the data, or the close code of a failure (1009: too large; 1007).
pub fn ws_inflate(max: usize, data: &[u8]) -> (i64, Vec<u8>) {
    // the flush the sender left out, then an empty last block
    let mut d = data.to_vec();
    d.extend_from_slice(&[0, 0, 0xff, 0xff, 0x03, 0x00]);
    match crate::gzip::inflate(&d, max) {
        Ok((out, _)) => (0, out),
        Err(e) if e.contains("too large") => (1009, Vec::new()),
        Err(_) => (1007, Vec::new()),
    }
}

/// A close frame's payload: the code and the reason (a code of 1005,
/// 1006 or 1015 is never sent: an empty payload).
pub fn ws_close_payload(code: i64, reason: &str) -> Vec<u8> {
    if !(1000..=4999).contains(&code) || matches!(code, 1005 | 1006 | 1015) {
        return Vec::new();
    }
    let mut out = (code as u16).to_be_bytes().to_vec();
    let mut r = reason;
    while r.len() > 123 {
        let mut k = 123;
        while !r.is_char_boundary(k) {
            k -= 1;
        }
        r = &r[..k];
    }
    out.extend_from_slice(r.as_bytes());
    out
}

/// A close frame's (code, reason): 1005 without a code, and -1 for a
/// payload that is not valid (one byte, a code that may not be sent, a
/// reason that is not UTF-8).
pub fn ws_close_parse(p: &[u8]) -> (i64, String) {
    if p.is_empty() {
        return (1005, String::new());
    }
    if p.len() < 2 {
        return (-1, String::new());
    }
    let code = u16::from_be_bytes([p[0], p[1]]) as i64;
    let valid = matches!(code, 1000..=1003 | 1007..=1014 | 3000..=4999);
    match std::str::from_utf8(&p[2..]) {
        Ok(r) if valid => (code, r.to_string()),
        _ => (-1, String::new()),
    }
}

// =============================================================== primitives

/// The `http2.*`, `zlib.*` and `ws.*` primitives.
pub fn prim(it: &mut Interp, sym: &str, a: &mut [Value]) -> R<Value> {
    let b = |v: &[u8]| Value::Bytes(Rc::from(v));
    match sym {
        "http2.serve" => serve(it, a),
        "http2.request" => request(a),
        "http2.body" => body(it, a),
        "http2.respond" => respond(it, a),
        "http2.data" => data(it, a),
        "http2.send" => send(it, a),
        "http2.pooled" => Ok(Value::bool(pooled(it, a[0].as_str()).is_some())),
        "zlib.gzip" => Ok(b(&crate::gzip::gzip(&bytes(&a[0]))[..])),
        "zlib.gunzip" => Ok(result_bytes(crate::gzip::gunzip(
            &bytes(&a[1]),
            int(&a[0]).max(0) as usize,
        ))),
        "zlib.deflate" => Ok(b(&zlib(&bytes(&a[0]))[..])),
        "zlib.gzip-chunk" => Ok(b(&crate::gzip::gzip_chunk(&bytes(&a[0]))[..])),
        "zlib.crc32" => Ok(Value::I64(
            crate::gzip::crc32_update(int(&a[0]) as u32, &bytes(&a[1])) as i64,
        )),
        "zlib.gzip-end" => Ok(b(&crate::gzip::gzip_end(
            int(&a[0]) as u32,
            int(&a[1]) as u64,
        )[..])),
        "zlib.inflate" => Ok(result_bytes(unzlib(
            &bytes(&a[1]),
            int(&a[0]).max(0) as usize,
        ))),
        "ws.accept" => Ok(Value::str(&ws_accept(a[0].as_str()))),
        "ws.key" => {
            let mut k = Vec::new();
            for _ in 0..4 {
                k.extend_from_slice(&mask_key());
            }
            Ok(Value::str(&base64(&k)))
        }
        "ws.frame" => Ok(b(&ws_frame(
            a[0].as_bool(),
            int(&a[1]) as u8,
            &bytes(&a[2]),
        )[..])),
        "ws.parse" => {
            let buf = bytes(&a[2]);
            let at = (int(&a[1]).max(0) as usize).min(buf.len());
            let (k, fin, op, masked, p) = ws_parse(int(&a[0]).max(0) as usize, &buf[at..]);
            Ok(Value::tuple(vec![
                Value::I64(k),
                Value::bool(fin),
                Value::I64(op),
                Value::bool(masked),
                b(&p[..]),
            ]))
        }
        "ws.close-payload" => Ok(b(&ws_close_payload(int(&a[0]), a[1].as_str())[..])),
        "ws.deflate" => Ok(b(&ws_deflate(&bytes(&a[0]))[..])),
        "ws.inflate" => {
            let (c, d) = ws_inflate(int(&a[0]).max(0) as usize, &bytes(&a[1]));
            Ok(Value::tuple(vec![Value::I64(c), b(&d[..])]))
        }
        "ws.close-parse" => {
            let (c, r) = ws_close_parse(&bytes(&a[0]));
            Ok(Value::tuple(vec![Value::I64(c), Value::str(&r)]))
        }
        _ => Err(Ctl::Trap(format!("primitive `{}` is not implemented", sym))),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn websocket_messages_deflate_and_inflate() {
        for m in [&b""[..], b"a", &b"abc".repeat(5000)] {
            let z = ws_deflate(m);
            assert!(!z.ends_with(&[0, 0, 0xff, 0xff]));
            assert_eq!(ws_inflate(1 << 20, &z), (0, m.to_vec()));
        }
        assert_eq!(ws_inflate(100, &ws_deflate(&[1; 101])).0, 1009);
        assert_eq!(ws_inflate(100, &[0xff, 0xff]).0, 1007);
    }

    #[test]
    fn sha1_and_accept() {
        let h = sha1(b"abc");
        assert_eq!(base64(&h), "qZk+NkcGgWq6PiVxeFDCbJzQ2J0=");
        // RFC 6455, section 1.3
        assert_eq!(
            ws_accept("dGhlIHNhbXBsZSBub25jZQ=="),
            "s3pPLMBiTxaQ9kYGzzhZRbK+xOo="
        );
        assert_eq!(base64(b"ab"), "YWI=");
    }

    #[test]
    fn frames_round_trip() {
        for n in [0usize, 5, 125, 126, 65535, 65536] {
            let p: Vec<u8> = (0..n).map(|i| i as u8).collect();
            for mask in [false, true] {
                let f = ws_frame(mask, 2, &p);
                let (k, fin, op, m, q) = ws_parse(1 << 20, &f);
                assert_eq!((k as usize, fin, op, m), (f.len(), true, 2, mask));
                assert_eq!(q, p);
                assert_eq!(ws_parse(1 << 20, &f[..f.len() - 1]).0, 0);
            }
        }
        assert_eq!(ws_parse(10, &ws_frame(false, 1, &[0; 11])).0, -1009);
    }

    #[test]
    fn zlib_round_trip() {
        let d = b"hello hello hello hello".repeat(10);
        assert_eq!(unzlib(&zlib(&d), 1 << 20).unwrap(), d);
        assert_eq!(unzlib(&crate::gzip::deflate(&d), 1 << 20).unwrap(), d);
    }
}
