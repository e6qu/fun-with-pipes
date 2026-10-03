//! Transports of the binary pipe protocol: after the `PIPE_V1` header, a
//! stream may continue on a Unix domain socket (`UDS_V1`) or on a ring in
//! shared memory (`SHM_V1`) instead of the stdout pipe. The native runtime
//! implements the same (runtime/fwp_rt_pipe.c, which describes the
//! handshake and the ring), so interpreted and native stages switch with
//! each other.
//!
//! A producer listens on the abstract socket named after its stdout pipe;
//! a consumer whose stdin is that pipe and whose header offers `UDS_V1`
//! connects and asks for a transport; the producer answers with a switch
//! frame on stdout at its next frame boundary and writes the rest of the
//! stream (the same bytes) to the transport. Anything that fails leaves the
//! stream on stdio. Linux only; elsewhere everything stays on stdio.

use std::io::{BufRead, Write};

/// A stream continues on stdio, a socket or a ring (the byte of the switch
/// frame).
pub const UDS: u8 = 1;
pub const SHM: u8 = 2;

/// `FWP_TRANSPORT=stdio` turns the transports off.
#[cfg(target_os = "linux")]
fn off() -> bool {
    std::env::var("FWP_TRANSPORT").is_ok_and(|t| t == "stdio")
}

/// `FWP_TRANSPORT_REPORT=1`: say on stderr where the input continues.
#[cfg(target_os = "linux")]
fn report(name: &str) {
    if std::env::var("FWP_TRANSPORT_REPORT").is_ok_and(|r| !r.is_empty() && r != "0") {
        eprintln!("fwp: input continues on {}", name);
    }
}

#[cfg(target_os = "linux")]
mod sys {
    use std::ffi::{c_int, c_long, c_uint, c_void};
    use std::os::fd::{AsRawFd, FromRawFd, RawFd};
    use std::os::linux::net::SocketAddrExt;
    use std::os::unix::fs::{FileTypeExt, MetadataExt};
    use std::os::unix::net::{SocketAddr, UnixListener, UnixStream};
    use std::sync::atomic::{fence, AtomicU32, AtomicU64, Ordering as O};
    use std::time::{Duration, Instant};

    pub const RING_CAP: u64 = 1 << 20;
    pub const RING_DATA: usize = 4096;

    #[repr(C)]
    struct IoVec {
        base: *mut c_void,
        len: usize,
    }

    #[repr(C)]
    struct MsgHdr {
        name: *mut c_void,
        namelen: u32,
        iov: *mut IoVec,
        iovlen: usize,
        control: *mut c_void,
        controllen: usize,
        flags: c_int,
    }

    /// A control message carrying one descriptor (`CMSG_SPACE(4)` bytes).
    #[repr(C)]
    struct CmsgFd {
        len: usize,
        level: c_int,
        ty: c_int,
        fd: c_int,
        pad: c_int,
    }

    const SOL_SOCKET: c_int = 1;
    const SCM_RIGHTS: c_int = 1;
    const SO_PEERCRED: c_int = 17;
    const MSG_NOSIGNAL: c_int = 0x4000;
    const MSG_PEEK: c_int = 2;
    const MSG_DONTWAIT: c_int = 0x40;
    const MSG_CMSG_CLOEXEC: c_int = 0x4000_0000;
    const PROT_RW: c_int = 3;
    const MAP_SHARED: c_int = 1;
    const FUTEX_WAIT: c_int = 0;
    const FUTEX_WAKE: c_int = 1;
    #[cfg(target_arch = "x86_64")]
    const SYS_FUTEX: c_long = 202;
    #[cfg(target_arch = "aarch64")]
    const SYS_FUTEX: c_long = 98;
    #[cfg(not(any(target_arch = "x86_64", target_arch = "aarch64")))]
    const SYS_FUTEX: c_long = -1;

    extern "C" {
        fn recv(fd: c_int, buf: *mut c_void, len: usize, flags: c_int) -> isize;
        fn sendmsg(fd: c_int, msg: *const MsgHdr, flags: c_int) -> isize;
        fn recvmsg(fd: c_int, msg: *mut MsgHdr, flags: c_int) -> isize;
        fn getsockopt(
            fd: c_int,
            level: c_int,
            name: c_int,
            val: *mut c_void,
            len: *mut u32,
        ) -> c_int;
        fn getuid() -> c_uint;
        fn memfd_create(name: *const std::ffi::c_char, flags: c_uint) -> c_int;
        fn mmap(
            addr: *mut c_void,
            len: usize,
            prot: c_int,
            flags: c_int,
            fd: c_int,
            off: i64,
        ) -> *mut c_void;
        fn syscall(n: c_long, ...) -> c_long;
    }

    /// The pipe on descriptor `fd`: its device and inode.
    pub fn pipe_of(fd: RawFd) -> Option<(u64, u64)> {
        let f = std::mem::ManuallyDrop::new(unsafe { std::fs::File::from_raw_fd(fd) });
        let m = f.metadata().ok()?;
        m.file_type().is_fifo().then(|| (m.dev(), m.ino()))
    }

    fn addr(pipe: (u64, u64)) -> std::io::Result<SocketAddr> {
        SocketAddr::from_abstract_name(format!("fwp.pipe.{}.{}", pipe.0, pipe.1).as_bytes())
    }

    pub fn listen(pipe: (u64, u64)) -> Option<UnixListener> {
        let l = UnixListener::bind_addr(&addr(pipe).ok()?).ok()?;
        l.set_nonblocking(true).ok()?;
        Some(l)
    }

    pub fn connect(pipe: (u64, u64)) -> Option<UnixStream> {
        UnixStream::connect_addr(&addr(pipe).ok()?).ok()
    }

    pub fn same_user(s: &UnixStream) -> bool {
        let mut cred = [0u32; 3];
        let mut len = 12u32;
        let r = unsafe {
            getsockopt(
                s.as_raw_fd(),
                SOL_SOCKET,
                SO_PEERCRED,
                cred.as_mut_ptr() as *mut c_void,
                &mut len,
            )
        };
        r == 0 && cred[1] == unsafe { getuid() }
    }

    /// Whether the other end of a socket hung up.
    pub fn gone(s: &UnixStream) -> bool {
        let mut b = [0u8; 1];
        let n = unsafe {
            recv(
                s.as_raw_fd(),
                b.as_mut_ptr() as *mut c_void,
                1,
                MSG_PEEK | MSG_DONTWAIT,
            )
        };
        n == 0
            || (n < 0
                && !matches!(
                    std::io::Error::last_os_error().kind(),
                    std::io::ErrorKind::WouldBlock | std::io::ErrorKind::Interrupted
                ))
    }

    #[repr(C)]
    struct PollFd {
        fd: c_int,
        events: i16,
        revents: i16,
    }

    extern "C" {
        fn poll(fds: *mut PollFd, n: std::ffi::c_ulong, ms: c_int) -> c_int;
    }

    /// Wait until the listener has a connection (true), `ms` pass, or the
    /// reader of stdout is gone.
    pub fn wait_listener(fd: RawFd, ms: c_int) -> bool {
        let mut p = [
            PollFd {
                fd,
                events: 1,
                revents: 0,
            },
            PollFd {
                fd: 1,
                events: 0,
                revents: 0,
            },
        ];
        unsafe { poll(p.as_mut_ptr(), 2, ms) > 0 && p[0].revents & 1 != 0 }
    }

    /// The ring in shared memory; offsets as in runtime/fwp_rt_pipe.c.
    pub struct Ring {
        base: *mut u8,
        cap: u64,
    }

    impl Ring {
        fn u64_at(&self, off: usize) -> &AtomicU64 {
            unsafe { &*(self.base.add(off) as *const AtomicU64) }
        }
        fn u32_at(&self, off: usize) -> &AtomicU32 {
            unsafe { &*(self.base.add(off) as *const AtomicU32) }
        }
        fn head(&self) -> &AtomicU64 {
            self.u64_at(64)
        }
        fn tail(&self) -> &AtomicU64 {
            self.u64_at(128)
        }
        fn data_seq(&self) -> &AtomicU32 {
            self.u32_at(192)
        }
        fn cons_wait(&self) -> &AtomicU32 {
            self.u32_at(196)
        }
        fn space_seq(&self) -> &AtomicU32 {
            self.u32_at(256)
        }
        fn prod_wait(&self) -> &AtomicU32 {
            self.u32_at(260)
        }
        fn closed(&self) -> &AtomicU32 {
            self.u32_at(320)
        }
        fn data(&self) -> *mut u8 {
            unsafe { self.base.add(RING_DATA) }
        }

        /// A new ring, and the descriptor of its memory.
        pub fn create() -> Option<(Ring, std::fs::File)> {
            if SYS_FUTEX < 0 {
                return None;
            }
            let fd = unsafe { memfd_create(c"fwp-ring".as_ptr(), 1) };
            if fd < 0 {
                return None;
            }
            let f = unsafe { std::fs::File::from_raw_fd(fd) };
            let size = RING_DATA + RING_CAP as usize;
            f.set_len(size as u64).ok()?;
            let p = unsafe { mmap(std::ptr::null_mut(), size, PROT_RW, MAP_SHARED, fd, 0) };
            if p as isize == -1 {
                return None;
            }
            let base = p as *mut u8;
            unsafe {
                std::ptr::copy_nonoverlapping(b"FWPS".as_ptr(), base, 4);
                (base.add(4) as *mut u32).write(1);
                (base.add(8) as *mut u64).write(RING_CAP);
            }
            Some((
                Ring {
                    base,
                    cap: RING_CAP,
                },
                f,
            ))
        }

        /// The ring in the memory of a received descriptor.
        pub fn open(f: std::fs::File) -> Option<Ring> {
            if SYS_FUTEX < 0 {
                return None;
            }
            let size = f.metadata().ok()?.len() as usize;
            if size <= RING_DATA {
                return None;
            }
            let p = unsafe {
                mmap(
                    std::ptr::null_mut(),
                    size,
                    PROT_RW,
                    MAP_SHARED,
                    f.as_raw_fd(),
                    0,
                )
            };
            if p as isize == -1 {
                return None;
            }
            let base = p as *mut u8;
            let (magic, version, cap) = unsafe {
                (
                    std::slice::from_raw_parts(base, 4),
                    (base.add(4) as *const u32).read(),
                    (base.add(8) as *const u64).read(),
                )
            };
            if magic != b"FWPS"
                || version != 1
                || cap == 0
                || !cap.is_power_of_two()
                || cap > (size - RING_DATA) as u64
            {
                return None;
            }
            Some(Ring { base, cap })
        }

        fn wake(seq: &AtomicU32, waiting: &AtomicU32) {
            fence(O::SeqCst);
            if waiting.load(O::Relaxed) != 0 {
                seq.fetch_add(1, O::SeqCst);
                unsafe {
                    syscall(
                        SYS_FUTEX,
                        seq.as_ptr(),
                        FUTEX_WAKE as c_long,
                        i32::MAX as c_long,
                        0usize,
                        0usize,
                        0 as c_long,
                    );
                }
            }
        }

        /// Wait until `ready`; false when the peer on `sock` is gone.
        fn wait(
            &self,
            seq: &AtomicU32,
            waiting: &AtomicU32,
            sock: &UnixStream,
            ready: impl Fn(&Ring) -> bool,
        ) -> bool {
            // spin for a while first, as the native runtime does
            if std::thread::available_parallelism().is_ok_and(|n| n.get() > 1) {
                let until = Instant::now() + Duration::from_micros(50);
                let mut i = 0u32;
                loop {
                    if ready(self) {
                        return true;
                    }
                    std::hint::spin_loop();
                    i += 1;
                    if i.is_multiple_of(64) {
                        // let the other side have this processor if it waits
                        std::thread::yield_now();
                        if Instant::now() > until {
                            break;
                        }
                    }
                }
            }
            loop {
                let s = seq.load(O::SeqCst);
                waiting.store(1, O::SeqCst);
                fence(O::SeqCst);
                if ready(self) {
                    waiting.store(0, O::Relaxed);
                    return true;
                }
                let ts = [0i64, 100_000_000];
                let rc = unsafe {
                    syscall(
                        SYS_FUTEX,
                        seq.as_ptr(),
                        FUTEX_WAIT as c_long,
                        s as c_long,
                        ts.as_ptr(),
                        0usize,
                        0 as c_long,
                    )
                };
                waiting.store(0, O::Relaxed);
                if ready(self) {
                    return true;
                }
                let timed_out = rc != 0
                    && std::io::Error::last_os_error().raw_os_error()
                        == Some(110 /* ETIMEDOUT */);
                if timed_out && gone(sock) {
                    return false;
                }
            }
        }

        /// Append bytes, waiting for space; false when the consumer is gone.
        pub fn put(&self, mut buf: &[u8], sock: &UnixStream) -> bool {
            while !buf.is_empty() {
                let head = self.head().load(O::Relaxed);
                let space = self.cap - (head - self.tail().load(O::Acquire));
                if space == 0 {
                    let ok = self.wait(self.space_seq(), self.prod_wait(), sock, |r| {
                        r.cap - (r.head().load(O::Relaxed) - r.tail().load(O::Acquire)) > 0
                    });
                    if !ok {
                        return false;
                    }
                    continue;
                }
                let k = (buf.len() as u64).min(space) as usize;
                let off = (head & (self.cap - 1)) as usize;
                let first = k.min(self.cap as usize - off);
                unsafe {
                    std::ptr::copy_nonoverlapping(buf.as_ptr(), self.data().add(off), first);
                    std::ptr::copy_nonoverlapping(buf.as_ptr().add(first), self.data(), k - first);
                }
                self.head().store(head + k as u64, O::Release);
                Ring::wake(self.data_seq(), self.cons_wait());
                buf = &buf[k..];
            }
            true
        }

        pub fn close(&self) {
            self.closed().store(1, O::Release);
            Ring::wake(self.data_seq(), self.cons_wait());
        }

        /// Up to `buf.len()` bytes; 0 at the end of the stream.
        pub fn get(&self, buf: &mut [u8], sock: &UnixStream) -> usize {
            let tail = self.tail().load(O::Relaxed);
            let mut head = self.head().load(O::Acquire);
            while head == tail {
                if self.closed().load(O::Acquire) != 0 {
                    head = self.head().load(O::Acquire);
                    if head == tail {
                        return 0;
                    }
                    break;
                }
                let ok = self.wait(self.data_seq(), self.cons_wait(), sock, |r| {
                    r.head().load(O::Acquire) != tail || r.closed().load(O::Acquire) != 0
                });
                if !ok {
                    return 0;
                }
                head = self.head().load(O::Acquire);
            }
            let k = ((head - tail) as usize).min(buf.len());
            let off = (tail & (self.cap - 1)) as usize;
            let first = k.min(self.cap as usize - off);
            unsafe {
                std::ptr::copy_nonoverlapping(self.data().add(off), buf.as_mut_ptr(), first);
                std::ptr::copy_nonoverlapping(self.data(), buf.as_mut_ptr().add(first), k - first);
            }
            self.tail().store(tail + k as u64, O::Release);
            Ring::wake(self.space_seq(), self.prod_wait());
            k
        }
    }

    /// Send a descriptor (with one byte) over a socket.
    pub fn send_fd(s: &UnixStream, fd: RawFd) -> bool {
        let mut one = *b"S";
        let mut iov = IoVec {
            base: one.as_mut_ptr() as *mut c_void,
            len: 1,
        };
        let mut c = CmsgFd {
            len: 20,
            level: SOL_SOCKET,
            ty: SCM_RIGHTS,
            fd,
            pad: 0,
        };
        let msg = MsgHdr {
            name: std::ptr::null_mut(),
            namelen: 0,
            iov: &mut iov,
            iovlen: 1,
            control: &mut c as *mut CmsgFd as *mut c_void,
            controllen: std::mem::size_of::<CmsgFd>(),
            flags: 0,
        };
        unsafe { sendmsg(s.as_raw_fd(), &msg, MSG_NOSIGNAL) == 1 }
    }

    /// Receive a descriptor sent with `send_fd`.
    pub fn recv_fd(s: &UnixStream) -> Option<std::fs::File> {
        let mut one = [0u8];
        let mut iov = IoVec {
            base: one.as_mut_ptr() as *mut c_void,
            len: 1,
        };
        let mut c = CmsgFd {
            len: 0,
            level: 0,
            ty: 0,
            fd: -1,
            pad: 0,
        };
        let mut msg = MsgHdr {
            name: std::ptr::null_mut(),
            namelen: 0,
            iov: &mut iov,
            iovlen: 1,
            control: &mut c as *mut CmsgFd as *mut c_void,
            controllen: std::mem::size_of::<CmsgFd>(),
            flags: 0,
        };
        let n = unsafe { recvmsg(s.as_raw_fd(), &mut msg, MSG_CMSG_CLOEXEC) };
        if n != 1 || msg.controllen < 20 || c.level != SOL_SOCKET || c.ty != SCM_RIGHTS || c.fd < 0
        {
            return None;
        }
        Some(unsafe { std::fs::File::from_raw_fd(c.fd) })
    }
}

/// Where a producer's stream goes.
enum Sink {
    Stdio(std::io::BufWriter<std::io::Stdout>),
    #[cfg(target_os = "linux")]
    Uds(std::io::BufWriter<std::os::unix::net::UnixStream>),
    #[cfg(target_os = "linux")]
    Shm(sys::Ring, std::os::unix::net::UnixStream),
}

/// The output of an executable: stdout, until a consumer asks for another
/// transport.
pub struct Out {
    sink: Sink,
    #[cfg(target_os = "linux")]
    listener: Option<(std::os::unix::net::UnixListener, std::time::Instant)>,
    #[cfg(target_os = "linux")]
    next_check: std::time::Instant,
    #[cfg(target_os = "linux")]
    frames: u32,
    gone: bool,
}

impl Out {
    pub fn new() -> Out {
        Out {
            sink: Sink::Stdio(std::io::BufWriter::with_capacity(
                1 << 16,
                std::io::stdout(),
            )),
            #[cfg(target_os = "linux")]
            listener: None,
            #[cfg(target_os = "linux")]
            next_check: std::time::Instant::now(),
            #[cfg(target_os = "linux")]
            frames: 0,
            gone: false,
        }
    }

    /// Before the header of a binary stream: offer the transports when
    /// stdout is a pipe.
    pub fn offer(&mut self) {
        #[cfg(target_os = "linux")]
        if !off() {
            if let Some(l) = sys::pipe_of(1).and_then(sys::listen) {
                let give_up = std::time::Instant::now() + std::time::Duration::from_secs(5);
                self.listener = Some((l, give_up));
            }
        }
    }

    /// After the header: with `FWP_TRANSPORT_WAIT=ms` (which `fwp pipe`
    /// sets, knowing that the consumer is an fwp program too), wait that
    /// long for the consumer to ask, unless it is gone.
    pub fn ready(&mut self) {
        #[cfg(target_os = "linux")]
        {
            use std::os::fd::AsRawFd;
            let Some((l, _)) = &self.listener else {
                return;
            };
            let ms = std::env::var("FWP_TRANSPORT_WAIT")
                .ok()
                .and_then(|w| w.trim().parse::<i64>().ok())
                .unwrap_or(0);
            if ms > 0 && sys::wait_listener(l.as_raw_fd(), ms.min(i32::MAX as i64) as i32) {
                self.next_check = std::time::Instant::now();
                self.poll();
            }
        }
    }

    /// A frame was written.
    pub fn frame_done(&mut self) {
        #[cfg(target_os = "linux")]
        if self.listener.is_some() {
            self.frames = self.frames.wrapping_add(1);
            if self.frames.is_multiple_of(64) {
                self.poll();
            }
        }
    }

    /// At a frame boundary: if a consumer connected, switch to what it
    /// asked for.
    fn poll(&mut self) {
        #[cfg(target_os = "linux")]
        {
            use std::io::Read;
            let Some((l, give_up)) = &self.listener else {
                return;
            };
            let now = std::time::Instant::now();
            if now < self.next_check {
                return;
            }
            self.next_check = now + std::time::Duration::from_millis(1);
            let s = match l.accept() {
                Ok((s, _)) => s,
                Err(_) => {
                    if now > *give_up {
                        self.listener = None;
                    }
                    return;
                }
            };
            self.listener = None;
            let mut hello = [0u8; 5];
            let ok = s.set_nonblocking(false).is_ok()
                && sys::same_user(&s)
                && s.set_read_timeout(Some(std::time::Duration::from_secs(1)))
                    .is_ok()
                && (&s).read_exact(&mut hello).is_ok()
                && &hello[..4] == b"FWPT"
                && (hello[4] == UDS || hello[4] == SHM);
            if !ok {
                return;
            }
            let _ = s.set_read_timeout(None);
            let mut kind = UDS;
            let mut ring = None;
            if hello[4] == SHM {
                if let Some((r, f)) = sys::Ring::create() {
                    use std::os::fd::AsRawFd;
                    if sys::send_fd(&s, f.as_raw_fd()) {
                        kind = SHM;
                        ring = Some(r);
                    }
                }
            }
            if let Sink::Stdio(w) = &mut self.sink {
                let _ = w.write_all(&[2, 1, 0, 0, 0, kind]);
                let _ = w.flush();
            }
            self.sink = match ring {
                Some(r) => Sink::Shm(r, s),
                None => Sink::Uds(std::io::BufWriter::with_capacity(1 << 16, s)),
            };
        }
    }

    /// After the end frame.
    pub fn end(&mut self) {
        #[cfg(target_os = "linux")]
        {
            self.listener = None;
        }
        let _ = self.flush();
        #[cfg(target_os = "linux")]
        {
            match &mut self.sink {
                Sink::Uds(w) => {
                    let _ = w.get_ref().shutdown(std::net::Shutdown::Write);
                }
                Sink::Shm(r, _) => r.close(),
                Sink::Stdio(_) => {}
            }
        }
    }
}

impl Default for Out {
    fn default() -> Self {
        Out::new()
    }
}

impl Write for Out {
    fn write(&mut self, buf: &[u8]) -> std::io::Result<usize> {
        if self.gone {
            return Err(std::io::ErrorKind::BrokenPipe.into());
        }
        match &mut self.sink {
            Sink::Stdio(w) => w.write(buf),
            #[cfg(target_os = "linux")]
            Sink::Uds(w) => w.write(buf),
            #[cfg(target_os = "linux")]
            Sink::Shm(r, s) => {
                if !r.put(buf, s) {
                    self.gone = true;
                    return Err(std::io::ErrorKind::BrokenPipe.into());
                }
                Ok(buf.len())
            }
        }
    }

    fn flush(&mut self) -> std::io::Result<()> {
        let r = match &mut self.sink {
            Sink::Stdio(w) => w.flush(),
            #[cfg(target_os = "linux")]
            Sink::Uds(w) => w.flush(),
            #[cfg(target_os = "linux")]
            Sink::Shm(..) => Ok(()),
        };
        if matches!(self.sink, Sink::Stdio(_)) {
            self.poll();
        }
        r
    }
}

/// A consumer's connection to the producer of its stdin, until the
/// producer switches.
pub struct Pending {
    #[cfg(target_os = "linux")]
    sock: Option<std::os::unix::net::UnixStream>,
}

/// After a header that offers `UDS_V1`: ask the producer of the stdin pipe
/// for a transport.
pub fn ask(capabilities: &[String]) -> Pending {
    #[cfg(target_os = "linux")]
    {
        if !capabilities.iter().any(|c| c == "UDS_V1") {
            return Pending { sock: None };
        }
        // FWP_TRANSPORT=stdio declines (0), so that a waiting producer
        // goes on
        let want = if off() {
            0
        } else if std::env::var("FWP_TRANSPORT").is_ok_and(|t| t == "uds") {
            UDS
        } else {
            SHM
        };
        let sock = sys::pipe_of(0).and_then(sys::connect).filter(|s| {
            let mut w = s;
            w.write_all(&[b'F', b'W', b'P', b'T', want]).is_ok() && want != 0
        });
        Pending { sock }
    }
    #[cfg(not(target_os = "linux"))]
    {
        let _ = capabilities;
        Pending {}
    }
}

/// A switch frame's payload: the input continuing on its transport, or
/// `None` if there is no such transport.
pub fn switch(p: &mut Pending, payload: &[u8]) -> Option<Box<dyn BufRead>> {
    #[cfg(target_os = "linux")]
    {
        let s = p.sock.take()?;
        match payload {
            [UDS] => {
                report("UDS_V1");
                Some(Box::new(std::io::BufReader::with_capacity(1 << 16, s)))
            }
            [SHM] => {
                let ring = sys::Ring::open(sys::recv_fd(&s)?)?;
                report("SHM_V1");
                Some(Box::new(std::io::BufReader::with_capacity(
                    1 << 16,
                    RingReader { ring, sock: s },
                )))
            }
            _ => None,
        }
    }
    #[cfg(not(target_os = "linux"))]
    {
        let _ = (p, payload);
        None
    }
}

#[cfg(target_os = "linux")]
struct RingReader {
    ring: sys::Ring,
    sock: std::os::unix::net::UnixStream,
}

#[cfg(target_os = "linux")]
impl std::io::Read for RingReader {
    fn read(&mut self, buf: &mut [u8]) -> std::io::Result<usize> {
        Ok(self.ring.get(buf, &self.sock))
    }
}
