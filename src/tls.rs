//! TLS for the interpreter (docs/tls.md), with the system's OpenSSL 3
//! (`libssl.so.3`), which is loaded when a program first uses TLS: the
//! compiler itself does not link it, so programs without TLS (and fwp
//! where OpenSSL is missing) do not need it. Native programs link the same
//! library; runtime/fwp_rt_tls.c is the C side, and both give the same
//! results and messages.
//!
//! Sessions are non-blocking: an operation that cannot go on says which
//! direction the socket must become ready in (`Io::Wait`), and the caller
//! waits for it the way it waits for a plain socket, so only its task
//! waits. A server session does its handshake on its first read or write.

use std::ffi::{c_char, c_int, c_long, c_void, CStr, CString};
use std::sync::{Mutex, OnceLock};

#[cfg(any(target_os = "linux", target_os = "android"))]
extern "C" {
    #[link_name = "__errno_location"]
    fn errno_ptr() -> *mut c_int;
}
#[cfg(target_vendor = "apple")]
extern "C" {
    #[link_name = "__error"]
    fn errno_ptr() -> *mut c_int;
}

/// Reset `errno`, so that what it holds after an OpenSSL call is that
/// call's.
fn clear_errno() {
    #[cfg(any(target_os = "linux", target_os = "android", target_vendor = "apple"))]
    unsafe {
        *errno_ptr() = 0
    };
}

/// The outcome of a non-blocking operation.
pub enum Io {
    /// Bytes read or written (0: the end of the stream, or a finished
    /// handshake).
    Done(usize),
    /// Try again once the socket is readable (`false`) or writable.
    Wait(bool),
    /// An error of the socket.
    Err(std::io::Error),
    /// A TLS failure, with its message.
    Fail(String),
}

type Ptr = *mut c_void;

/// The functions of libssl and libcrypto that fwp uses.
#[allow(clippy::type_complexity)]
struct Lib {
    tls_client_method: unsafe extern "C" fn() -> Ptr,
    tls_server_method: unsafe extern "C" fn() -> Ptr,
    ctx_new: unsafe extern "C" fn(Ptr) -> Ptr,
    ctx_free: unsafe extern "C" fn(Ptr),
    ctx_set_options: unsafe extern "C" fn(Ptr, u64) -> u64,
    ctx_ctrl: unsafe extern "C" fn(Ptr, c_int, c_long, Ptr) -> c_long,
    ctx_set_default_verify_paths: unsafe extern "C" fn(Ptr) -> c_int,
    ctx_load_verify_locations: unsafe extern "C" fn(Ptr, *const c_char, *const c_char) -> c_int,
    ctx_use_certificate_chain_file: unsafe extern "C" fn(Ptr, *const c_char) -> c_int,
    ctx_use_private_key_file: unsafe extern "C" fn(Ptr, *const c_char, c_int) -> c_int,
    ctx_check_private_key: unsafe extern "C" fn(Ptr) -> c_int,
    ctx_set_verify: unsafe extern "C" fn(Ptr, c_int, Ptr),
    ctx_set_alpn_select_cb: unsafe extern "C" fn(Ptr, AlpnSelect, Ptr),
    ssl_new: unsafe extern "C" fn(Ptr) -> Ptr,
    ssl_free: unsafe extern "C" fn(Ptr),
    ssl_set_fd: unsafe extern "C" fn(Ptr, c_int) -> c_int,
    ssl_set_connect_state: unsafe extern "C" fn(Ptr),
    ssl_set_accept_state: unsafe extern "C" fn(Ptr),
    ssl_do_handshake: unsafe extern "C" fn(Ptr) -> c_int,
    ssl_is_init_finished: unsafe extern "C" fn(Ptr) -> c_int,
    ssl_read: unsafe extern "C" fn(Ptr, *mut c_void, c_int) -> c_int,
    ssl_write: unsafe extern "C" fn(Ptr, *const c_void, c_int) -> c_int,
    ssl_shutdown: unsafe extern "C" fn(Ptr) -> c_int,
    ssl_get_error: unsafe extern "C" fn(Ptr, c_int) -> c_int,
    ssl_ctrl: unsafe extern "C" fn(Ptr, c_int, c_long, Ptr) -> c_long,
    ssl_set1_host: unsafe extern "C" fn(Ptr, *const c_char) -> c_int,
    ssl_set_verify: unsafe extern "C" fn(Ptr, c_int, Ptr),
    ssl_set_alpn_protos: unsafe extern "C" fn(Ptr, *const u8, u32) -> c_int,
    ssl_get0_alpn_selected: unsafe extern "C" fn(Ptr, *mut *const u8, *mut u32),
    ssl_get_verify_result: unsafe extern "C" fn(Ptr) -> c_long,
    x509_verify_cert_error_string: unsafe extern "C" fn(c_long) -> *const c_char,
    err_get_error: unsafe extern "C" fn() -> u64,
    err_reason_error_string: unsafe extern "C" fn(u64) -> *const c_char,
    err_clear_error: unsafe extern "C" fn(),
}

type AlpnSelect = unsafe extern "C" fn(Ptr, *mut *const u8, *mut u8, *const u8, u32, Ptr) -> c_int;

unsafe impl Send for Lib {}
unsafe impl Sync for Lib {}

const SSL_FILETYPE_PEM: c_int = 1;
const SSL_VERIFY_NONE: c_int = 0;
const SSL_VERIFY_PEER: c_int = 1;
const SSL_ERROR_SSL: c_int = 1;
const SSL_ERROR_WANT_READ: c_int = 2;
const SSL_ERROR_WANT_WRITE: c_int = 3;
const SSL_ERROR_SYSCALL: c_int = 5;
const SSL_ERROR_ZERO_RETURN: c_int = 6;
const SSL_CTRL_MODE: c_int = 33;
const SSL_CTRL_SET_TLSEXT_HOSTNAME: c_int = 55;
const SSL_CTRL_SET_MIN_PROTO_VERSION: c_int = 123;
const TLS1_2_VERSION: c_long = 0x0303;
const SSL_MODE_PARTIAL_AND_MOVING: c_long = 0x1 | 0x2;
/// SSL_OP_IGNORE_UNEXPECTED_EOF: a peer that closes without close_notify
/// ends the stream (as most HTTP clients and servers do).
const SSL_OP_IGNORE_UNEXPECTED_EOF: u64 = 1 << 7;
const SSL_TLSEXT_ERR_OK: c_int = 0;
const SSL_TLSEXT_ERR_NOACK: c_int = 3;

#[cfg(not(target_family = "wasm"))]
mod dl {
    use std::ffi::{c_char, c_int, c_void};
    extern "C" {
        pub fn dlopen(path: *const c_char, flags: c_int) -> *mut c_void;
        pub fn dlsym(handle: *mut c_void, symbol: *const c_char) -> *mut c_void;
    }
    pub const RTLD_NOW: c_int = 2;
    pub const RTLD_GLOBAL: c_int = 0x100;
}

#[cfg(not(target_family = "wasm"))]
fn open_lib(names: &[&str]) -> Option<Ptr> {
    names.iter().find_map(|n| {
        let c = CString::new(*n).ok()?;
        let h = unsafe { dl::dlopen(c.as_ptr(), dl::RTLD_NOW | dl::RTLD_GLOBAL) };
        (!h.is_null()).then_some(h)
    })
}

#[cfg(not(target_family = "wasm"))]
fn load() -> Result<Lib, String> {
    let missing = "TLS needs OpenSSL 3 (libssl.so.3), which could not be loaded";
    let crypto = open_lib(&[
        "libcrypto.so.3",
        "libcrypto.so",
        "libcrypto.3.dylib",
        "libcrypto.dylib",
    ])
    .ok_or(missing)?;
    let ssl =
        open_lib(&["libssl.so.3", "libssl.so", "libssl.3.dylib", "libssl.dylib"]).ok_or(missing)?;
    // a function pointer of the type the field it fills has
    fn get<F: Copy>(h: Ptr, name: &str, missing: &str) -> Result<F, String> {
        assert_eq!(std::mem::size_of::<F>(), std::mem::size_of::<Ptr>());
        let c = CString::new(name).unwrap();
        let p = unsafe { dl::dlsym(h, c.as_ptr()) };
        if p.is_null() {
            Err(format!("{} (no `{}` in the OpenSSL found)", missing, name))
        } else {
            Ok(unsafe { std::mem::transmute_copy::<Ptr, F>(&p) })
        }
    }
    macro_rules! f {
        ($h:expr, $name:expr) => {
            get($h, $name, missing)?
        };
    }
    Ok(Lib {
        tls_client_method: f!(ssl, "TLS_client_method"),
        tls_server_method: f!(ssl, "TLS_server_method"),
        ctx_new: f!(ssl, "SSL_CTX_new"),
        ctx_free: f!(ssl, "SSL_CTX_free"),
        ctx_set_options: f!(ssl, "SSL_CTX_set_options"),
        ctx_ctrl: f!(ssl, "SSL_CTX_ctrl"),
        ctx_set_default_verify_paths: f!(ssl, "SSL_CTX_set_default_verify_paths"),
        ctx_load_verify_locations: f!(ssl, "SSL_CTX_load_verify_locations"),
        ctx_use_certificate_chain_file: f!(ssl, "SSL_CTX_use_certificate_chain_file"),
        ctx_use_private_key_file: f!(ssl, "SSL_CTX_use_PrivateKey_file"),
        ctx_check_private_key: f!(ssl, "SSL_CTX_check_private_key"),
        ctx_set_verify: f!(ssl, "SSL_CTX_set_verify"),
        ctx_set_alpn_select_cb: f!(ssl, "SSL_CTX_set_alpn_select_cb"),
        ssl_new: f!(ssl, "SSL_new"),
        ssl_free: f!(ssl, "SSL_free"),
        ssl_set_fd: f!(ssl, "SSL_set_fd"),
        ssl_set_connect_state: f!(ssl, "SSL_set_connect_state"),
        ssl_set_accept_state: f!(ssl, "SSL_set_accept_state"),
        ssl_do_handshake: f!(ssl, "SSL_do_handshake"),
        ssl_is_init_finished: f!(ssl, "SSL_is_init_finished"),
        ssl_read: f!(ssl, "SSL_read"),
        ssl_write: f!(ssl, "SSL_write"),
        ssl_shutdown: f!(ssl, "SSL_shutdown"),
        ssl_get_error: f!(ssl, "SSL_get_error"),
        ssl_ctrl: f!(ssl, "SSL_ctrl"),
        ssl_set1_host: f!(ssl, "SSL_set1_host"),
        ssl_set_verify: f!(ssl, "SSL_set_verify"),
        ssl_set_alpn_protos: f!(ssl, "SSL_set_alpn_protos"),
        ssl_get0_alpn_selected: f!(ssl, "SSL_get0_alpn_selected"),
        ssl_get_verify_result: f!(ssl, "SSL_get_verify_result"),
        x509_verify_cert_error_string: f!(crypto, "X509_verify_cert_error_string"),
        err_get_error: f!(crypto, "ERR_get_error"),
        err_reason_error_string: f!(crypto, "ERR_reason_error_string"),
        err_clear_error: f!(crypto, "ERR_clear_error"),
    })
}

#[cfg(target_family = "wasm")]
fn load() -> Result<Lib, String> {
    Err("TLS is not available in the WebAssembly build of fwp".into())
}

static LIB: OnceLock<Result<Lib, String>> = OnceLock::new();

fn lib() -> Result<&'static Lib, String> {
    LIB.get_or_init(load).as_ref().map_err(|e| e.clone())
}

/// OpenSSL can be loaded, or why not.
pub fn check() -> Result<(), String> {
    lib().map(|_| ())
}

/// Whether OpenSSL can be loaded.
pub fn available() -> bool {
    lib().is_ok()
}

fn cstr(p: *const c_char) -> String {
    if p.is_null() {
        String::new()
    } else {
        unsafe { CStr::from_ptr(p) }.to_string_lossy().into_owned()
    }
}

/// The reason of the last error in OpenSSL's queue (which is emptied).
fn reason(l: &Lib) -> String {
    let mut last = 0;
    loop {
        let e = unsafe { (l.err_get_error)() };
        if e == 0 {
            break;
        }
        last = e;
    }
    let r = cstr(unsafe { (l.err_reason_error_string)(last) });
    if r.is_empty() {
        "unknown error".into()
    } else {
        r
    }
}

/// A readable file, or why it is not (as the C runtime words it).
fn readable(path: &str) -> Result<(), String> {
    std::fs::File::open(path)
        .map(|_| ())
        .map_err(|e| format!("{}: {}", path, crate::h2::io_msg(&e)))
}

/// Protocols in ALPN's wire format (each preceded by its length); names
/// that are empty or longer than 255 bytes are left out.
pub fn alpn_wire(protos: &[String]) -> Vec<u8> {
    let mut w = Vec::new();
    for p in protos {
        if !p.is_empty() && p.len() <= 255 {
            w.push(p.len() as u8);
            w.extend_from_slice(p.as_bytes());
        }
    }
    w
}

/// An `SSL_CTX`.
pub struct Ctx {
    ptr: Ptr,
    /// A server's protocols (ALPN), in its order of preference; the
    /// selection callback reads them.
    alpn: Box<AlpnList>,
}

/// Protocols in ALPN's wire format, at a stable address for OpenSSL.
struct AlpnList(Vec<u8>);

unsafe impl Send for Ctx {}
unsafe impl Sync for Ctx {}

impl Drop for Ctx {
    fn drop(&mut self) {
        if let Ok(l) = lib() {
            unsafe { (l.ctx_free)(self.ptr) };
        }
    }
}

fn new_ctx(l: &Lib, server: bool) -> Result<Ptr, String> {
    let method = unsafe {
        if server {
            (l.tls_server_method)()
        } else {
            (l.tls_client_method)()
        }
    };
    let ctx = unsafe { (l.ctx_new)(method) };
    if ctx.is_null() {
        return Err(format!("cannot create a TLS context: {}", reason(l)));
    }
    unsafe {
        (l.ctx_set_options)(ctx, SSL_OP_IGNORE_UNEXPECTED_EOF);
        (l.ctx_ctrl)(
            ctx,
            SSL_CTRL_MODE,
            SSL_MODE_PARTIAL_AND_MOVING,
            std::ptr::null_mut(),
        );
        (l.ctx_ctrl)(
            ctx,
            SSL_CTRL_SET_MIN_PROTO_VERSION,
            TLS1_2_VERSION,
            std::ptr::null_mut(),
        );
    }
    Ok(ctx)
}

/// The server's choice among the client's protocols: the first of its own
/// that the client offers; none (the handshake goes on) otherwise.
unsafe extern "C" fn alpn_select(
    _ssl: Ptr,
    out: *mut *const u8,
    outlen: *mut u8,
    input: *const u8,
    inlen: u32,
    arg: Ptr,
) -> c_int {
    let ours = &(*(arg as *const AlpnList)).0;
    let theirs = std::slice::from_raw_parts(input, inlen as usize);
    let mut i = 0;
    while i < ours.len() {
        let n = ours[i] as usize;
        let want = &ours[i + 1..i + 1 + n];
        let mut j = 0;
        while j < theirs.len() {
            let m = theirs[j] as usize;
            if j + 1 + m > theirs.len() {
                break;
            }
            if &theirs[j + 1..j + 1 + m] == want {
                *out = input.add(j + 1);
                *outlen = m as u8;
                return SSL_TLSEXT_ERR_OK;
            }
            j += 1 + m;
        }
        i += 1 + n;
    }
    SSL_TLSEXT_ERR_NOACK
}

/// A server context with a certificate chain and its private key (PEM
/// files), offering the protocols `alpn`.
pub fn server_ctx(cert: &str, key: &str, alpn: &[String]) -> Result<Ctx, String> {
    let l = lib()?;
    readable(cert)?;
    readable(key)?;
    unsafe { (l.err_clear_error)() };
    let ptr = new_ctx(l, true)?;
    let ctx = Ctx {
        ptr,
        alpn: Box::new(AlpnList(alpn_wire(alpn))),
    };
    let c = CString::new(cert).map_err(|_| format!("{}: invalid path", cert))?;
    let k = CString::new(key).map_err(|_| format!("{}: invalid path", key))?;
    unsafe {
        if (l.ctx_use_certificate_chain_file)(ptr, c.as_ptr()) != 1 {
            return Err(format!(
                "{}: cannot load the certificate: {}",
                cert,
                reason(l)
            ));
        }
        if (l.ctx_use_private_key_file)(ptr, k.as_ptr(), SSL_FILETYPE_PEM) != 1 {
            return Err(format!(
                "{}: cannot load the private key: {}",
                key,
                reason(l)
            ));
        }
        if (l.ctx_check_private_key)(ptr) != 1 {
            (l.err_clear_error)();
            return Err(format!(
                "{}: the private key does not match the certificate",
                key
            ));
        }
        if !ctx.alpn.0.is_empty() {
            let arg = &*ctx.alpn as *const AlpnList as Ptr;
            (l.ctx_set_alpn_select_cb)(ptr, alpn_select, arg);
        }
    }
    Ok(ctx)
}

/// Client contexts by CA file ("" for the system's) and verification;
/// made once, as loading the system's certificates takes a while.
static CLIENTS: Mutex<Vec<(String, bool, usize)>> = Mutex::new(Vec::new());

fn client_ctx(l: &Lib, ca: &str, verify: bool) -> Result<Ptr, String> {
    let mut cs = CLIENTS.lock().unwrap();
    if let Some((_, _, p)) = cs.iter().find(|(c, v, _)| c == ca && *v == verify) {
        return Ok(*p as Ptr);
    }
    if !ca.is_empty() {
        readable(ca)?;
    }
    let ctx = new_ctx(l, false)?;
    unsafe {
        if verify {
            (l.ctx_set_verify)(ctx, SSL_VERIFY_PEER, std::ptr::null_mut());
            let ok = if ca.is_empty() {
                (l.ctx_set_default_verify_paths)(ctx)
            } else {
                let c = CString::new(ca).map_err(|_| format!("{}: invalid path", ca))?;
                (l.ctx_load_verify_locations)(ctx, c.as_ptr(), std::ptr::null())
            };
            if ok != 1 {
                let r = reason(l);
                (l.ctx_free)(ctx);
                return Err(if ca.is_empty() {
                    format!("cannot load the system's CA certificates: {}", r)
                } else {
                    format!("{}: cannot load CA certificates: {}", ca, r)
                });
            }
        } else {
            (l.ctx_set_verify)(ctx, SSL_VERIFY_NONE, std::ptr::null_mut());
        }
    }
    cs.push((ca.to_string(), verify, ctx as usize));
    Ok(ctx)
}

/// A TLS session over a socket (an `SSL`).
pub struct Session {
    ssl: Ptr,
    /// A server session's context, kept alive with the session (its ALPN
    /// callback reads the context's protocols during the handshake).
    _ctx: Option<std::rc::Rc<Ctx>>,
    /// Writes since a write said to wait: OpenSSL wants the same buffer
    /// again (a moving one is allowed), with at least as many bytes.
    pending: usize,
}

unsafe impl Send for Session {}

impl Drop for Session {
    fn drop(&mut self) {
        if let Ok(l) = lib() {
            unsafe { (l.ssl_free)(self.ssl) };
        }
    }
}

/// Client options: the CA file ("" for the system's certificates, and
/// `SSL_CERT_FILE`/`SSL_CERT_DIR`), whether to verify the server's
/// certificate, the server name (SNI and verification; "" for none) and
/// the protocols to offer.
pub struct ClientOpts<'a> {
    pub ca: &'a str,
    pub verify: bool,
    pub name: &'a str,
    pub alpn: &'a [String],
}

fn is_ip(s: &str) -> bool {
    s.parse::<std::net::IpAddr>().is_ok()
}

impl Session {
    /// A client session on a connected socket; the handshake is still to
    /// be done (`handshake`).
    pub fn client(fd: i32, o: &ClientOpts) -> Result<Session, String> {
        let l = lib()?;
        unsafe { (l.err_clear_error)() };
        let ctx = client_ctx(l, o.ca, o.verify)?;
        let ssl = unsafe { (l.ssl_new)(ctx) };
        if ssl.is_null() {
            return Err(format!("cannot create a TLS session: {}", reason(l)));
        }
        let s = Session {
            ssl,
            _ctx: None,
            pending: 0,
        };
        let name = CString::new(o.name).map_err(|_| "invalid server name".to_string())?;
        unsafe {
            (l.ssl_set_fd)(ssl, fd);
            (l.ssl_set_connect_state)(ssl);
            // SNI only for host names (RFC 6066)
            if !o.name.is_empty() && !is_ip(o.name) {
                (l.ssl_ctrl)(
                    ssl,
                    SSL_CTRL_SET_TLSEXT_HOSTNAME,
                    0,
                    name.as_ptr() as *mut c_void,
                );
            }
            if o.verify && !o.name.is_empty() && (l.ssl_set1_host)(ssl, name.as_ptr()) != 1 {
                return Err(format!("invalid server name `{}`", o.name));
            }
            if !o.verify {
                (l.ssl_set_verify)(ssl, SSL_VERIFY_NONE, std::ptr::null_mut());
            }
            let w = alpn_wire(o.alpn);
            if !w.is_empty() {
                (l.ssl_set_alpn_protos)(ssl, w.as_ptr(), w.len() as u32);
            }
        }
        Ok(s)
    }

    /// A server session on an accepted socket.
    pub fn server(ctx: &std::rc::Rc<Ctx>, fd: i32) -> Result<Session, String> {
        let l = lib()?;
        let ssl = unsafe { (l.ssl_new)(ctx.ptr) };
        if ssl.is_null() {
            return Err(format!("cannot create a TLS session: {}", reason(l)));
        }
        unsafe {
            (l.ssl_set_fd)(ssl, fd);
            (l.ssl_set_accept_state)(ssl);
        }
        Ok(Session {
            ssl,
            _ctx: Some(ctx.clone()),
            pending: 0,
        })
    }

    pub fn handshaken(&self) -> bool {
        lib().is_ok_and(|l| unsafe { (l.ssl_is_init_finished)(self.ssl) } == 1)
    }

    /// What a failed call means; `during` is whether the handshake was
    /// still going on.
    fn outcome(&self, l: &Lib, r: c_int, during: bool) -> Io {
        let errno = std::io::Error::last_os_error().raw_os_error().unwrap_or(0);
        match unsafe { (l.ssl_get_error)(self.ssl, r) } {
            SSL_ERROR_WANT_READ => Io::Wait(false),
            SSL_ERROR_WANT_WRITE => Io::Wait(true),
            SSL_ERROR_ZERO_RETURN if !during => Io::Done(0),
            SSL_ERROR_SYSCALL if !during && errno != 0 => {
                unsafe { (l.err_clear_error)() };
                Io::Err(std::io::Error::from_raw_os_error(errno))
            }
            SSL_ERROR_SYSCALL | SSL_ERROR_ZERO_RETURN => {
                unsafe { (l.err_clear_error)() };
                if !during {
                    return Io::Done(0);
                }
                Io::Fail(if errno != 0 {
                    format!(
                        "TLS handshake failed: {}",
                        crate::h2::io_msg(&std::io::Error::from_raw_os_error(errno))
                    )
                } else {
                    "TLS handshake failed: connection closed".into()
                })
            }
            e => {
                let v = unsafe { (l.ssl_get_verify_result)(self.ssl) };
                if during && v != 0 {
                    unsafe { (l.err_clear_error)() };
                    let why = cstr(unsafe { (l.x509_verify_cert_error_string)(v) });
                    return Io::Fail(format!("certificate verify failed: {}", why));
                }
                let r = if e == SSL_ERROR_SSL {
                    reason(l)
                } else {
                    "unknown error".into()
                };
                Io::Fail(if during {
                    format!("TLS handshake failed: {}", r)
                } else {
                    format!("TLS error: {}", r)
                })
            }
        }
    }

    /// Go on with the handshake; `Done(0)` once it is complete.
    pub fn handshake(&mut self) -> Io {
        let Ok(l) = lib() else {
            return Io::Fail("TLS is not available".into());
        };
        unsafe { (l.err_clear_error)() };
        clear_errno();
        let r = unsafe { (l.ssl_do_handshake)(self.ssl) };
        if r == 1 {
            Io::Done(0)
        } else {
            self.outcome(l, r, true)
        }
    }

    /// Read up to `buf.len()` bytes (`Done(0)`: the end of the stream).
    pub fn read(&mut self, buf: &mut [u8]) -> Io {
        let Ok(l) = lib() else {
            return Io::Fail("TLS is not available".into());
        };
        let during = !self.handshaken();
        unsafe { (l.err_clear_error)() };
        clear_errno();
        let n = buf.len().min(i32::MAX as usize) as c_int;
        let r = unsafe { (l.ssl_read)(self.ssl, buf.as_mut_ptr() as *mut c_void, n) };
        if r > 0 {
            Io::Done(r as usize)
        } else {
            self.outcome(l, r, during)
        }
    }

    /// Write some of `data` (all of it unless it is large).
    pub fn write(&mut self, data: &[u8]) -> Io {
        let Ok(l) = lib() else {
            return Io::Fail("TLS is not available".into());
        };
        if data.is_empty() {
            return Io::Done(0);
        }
        let during = !self.handshaken();
        unsafe { (l.err_clear_error)() };
        clear_errno();
        // a retried write must offer at least what the failed one did
        let n = data
            .len()
            .min((1 << 20).max(self.pending))
            .min(i32::MAX as usize);
        let r = unsafe { (l.ssl_write)(self.ssl, data.as_ptr() as *const c_void, n as c_int) };
        if r > 0 {
            self.pending = 0;
            Io::Done(r as usize)
        } else {
            let o = self.outcome(l, r, during);
            match o {
                Io::Wait(_) => self.pending = n,
                Io::Done(0) => {
                    return Io::Fail(if during {
                        "TLS handshake failed: connection closed".into()
                    } else {
                        "connection closed by peer".into()
                    })
                }
                _ => {}
            }
            o
        }
    }

    /// Send close_notify, without waiting for the peer's.
    pub fn shutdown(&mut self) {
        if let Ok(l) = lib() {
            if self.handshaken() {
                unsafe {
                    (l.ssl_shutdown)(self.ssl);
                    (l.err_clear_error)();
                }
            }
        }
    }

    /// The protocol negotiated with ALPN ("" for none).
    pub fn alpn(&self) -> String {
        let Ok(l) = lib() else {
            return String::new();
        };
        let mut p: *const u8 = std::ptr::null();
        let mut n: u32 = 0;
        unsafe { (l.ssl_get0_alpn_selected)(self.ssl, &mut p, &mut n) };
        if p.is_null() || n == 0 {
            return String::new();
        }
        let b = unsafe { std::slice::from_raw_parts(p, n as usize) };
        String::from_utf8_lossy(b).into_owned()
    }
}

/// The host of "host:port" (without the brackets of an IPv6 address).
pub fn host_of(addr: &str) -> &str {
    let host = addr.rsplit_once(':').map(|(h, _)| h).unwrap_or(addr);
    host.strip_prefix('[')
        .and_then(|h| h.strip_suffix(']'))
        .unwrap_or(host)
}

/// The certificate and key files of a server: `--tls-cert`/`--tls-key`
/// (taken out of `args`), else `FWP_TLS_CERT`/`FWP_TLS_KEY`; both or
/// neither.
pub fn server_files(args: &mut Vec<String>) -> Result<Option<(String, String)>, String> {
    let mut cert = None;
    let mut key = None;
    let mut i = 0;
    while i < args.len() {
        let a = args[i].clone();
        let (slot, value) = if a == "--tls-cert" || a == "--tls-key" {
            if i + 1 >= args.len() {
                return Err(format!("{} needs a file", a));
            }
            let v = args.remove(i + 1);
            (
                if a == "--tls-cert" {
                    &mut cert
                } else {
                    &mut key
                },
                v,
            )
        } else if let Some(v) = a.strip_prefix("--tls-cert=") {
            (&mut cert, v.to_string())
        } else if let Some(v) = a.strip_prefix("--tls-key=") {
            (&mut key, v.to_string())
        } else {
            i += 1;
            continue;
        };
        *slot = Some(value);
        args.remove(i);
    }
    let env = |k: &str| std::env::var(k).ok().filter(|v| !v.is_empty());
    let cert = cert.or_else(|| env("FWP_TLS_CERT"));
    let key = key.or_else(|| env("FWP_TLS_KEY"));
    match (cert, key) {
        (Some(c), Some(k)) => Ok(Some((c, k))),
        (None, None) => Ok(None),
        (Some(_), None) => Err("a TLS certificate needs a key (--tls-key or FWP_TLS_KEY)".into()),
        (None, Some(_)) => Err("a TLS key needs a certificate (--tls-cert or FWP_TLS_CERT)".into()),
    }
}

/// A gRPC address with its transport: `tls://host:port` and
/// `grpcs://host:port` (or `https://`) are TLS, anything else (`host:port`,
/// `http://`, `grpc://`) cleartext h2c. Gives (TLS, host:port).
pub fn grpc_addr(addr: &str) -> (bool, &str) {
    for (p, tls) in [
        ("tls://", true),
        ("grpcs://", true),
        ("https://", true),
        ("grpc://", false),
        ("http://", false),
    ] {
        if let Some(rest) = addr.strip_prefix(p) {
            return (tls, rest.trim_end_matches('/'));
        }
    }
    (false, addr)
}
