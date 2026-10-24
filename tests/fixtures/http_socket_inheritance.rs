//! Windows diagnostic: does a compiler-like child keep a dropped socket open?
use std::io::{BufRead, BufReader, Read};
use std::net::{TcpListener, TcpStream};
use std::os::windows::io::AsRawSocket;
use std::process::{Command, Stdio};
use std::time::Duration;

#[link(name = "kernel32")]
extern "system" {
    fn GetHandleInformation(handle: *mut std::ffi::c_void, flags: *mut u32) -> i32;
    fn SetHandleInformation(handle: *mut std::ffi::c_void, mask: u32, flags: u32) -> i32;
}

fn flags(stream: &TcpStream) -> u32 {
    let mut flags = 0;
    assert_ne!(
        unsafe { GetHandleInformation(stream.as_raw_socket() as *mut _, &mut flags) },
        0
    );
    flags
}

fn run_case(mode: &str) {
    let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    let stream = TcpStream::connect(listener.local_addr().unwrap()).unwrap();
    let (mut peer, _) = listener.accept().unwrap();
    peer.set_read_timeout(Some(Duration::from_secs(2))).unwrap();
    let clone = (mode == "clone").then(|| stream.try_clone().unwrap());
    if mode == "forced-inherit" {
        assert_ne!(
            unsafe { SetHandleInformation(stream.as_raw_socket() as *mut _, 1, 1) },
            0
        );
    }
    let original_flags = flags(&stream);
    let clone_flags = clone.as_ref().map(flags);
    let mut child = Command::new(std::env::current_exe().unwrap())
        .arg("--child")
        .stdin(Stdio::null())
        .stdout(Stdio::piped())
        .stderr(Stdio::inherit())
        .spawn()
        .unwrap();
    // The child also has a fixed lifetime if any parent operation fails.
    let mut ready = String::new();
    let startup = BufReader::new(child.stdout.take().unwrap()).read_line(&mut ready);
    drop(clone);
    drop(stream);
    let before_exit = peer.read(&mut [0]);
    let still_running = child.try_wait();
    let _ = child.kill();
    let reaped = child.wait();
    let after_exit = peer.read(&mut [0]);
    assert!(
        startup.is_ok() && ready == "ready\n",
        "{startup:?} {ready:?}"
    );
    assert!(
        matches!(still_running, Ok(None)),
        "child exited during probe: {still_running:?}"
    );
    reaped.unwrap();
    let held_open = match before_exit {
        Ok(0) => false,
        Err(ref e)
            if matches!(
                e.kind(),
                std::io::ErrorKind::TimedOut | std::io::ErrorKind::WouldBlock
            ) =>
        {
            true
        }
        result => panic!("unexpected read: {result:?}"),
    };
    println!("socket-inheritance\t{mode}\toriginal_flags={original_flags}\tclone_flags={clone_flags:?}\theld_until_child_exit={held_open}\tafter_exit={after_exit:?}");
    match after_exit {
        Ok(0) => (),
        Err(error) if error.kind() == std::io::ErrorKind::ConnectionReset => (),
        result => panic!("socket did not close after child exit: {result:?}"),
    }
}

fn main() {
    if std::env::args().nth(1).as_deref() == Some("--child") {
        println!("ready");
        std::thread::sleep(Duration::from_secs(10));
        return;
    }
    assert_eq!(std::env::args().nth(1).as_deref(), Some("--parent"));
    for mode in ["original", "clone", "forced-inherit"] {
        run_case(mode);
    }
}
