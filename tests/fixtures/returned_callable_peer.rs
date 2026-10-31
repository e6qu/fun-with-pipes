// A Rust core implementation linked to the same C observer as the C/fwp peers.
// No allocator or Rust standard-library startup is required by these scalars.
#![no_std]

use core::panic::PanicInfo;

unsafe extern "C" {
    fn returned_failure(message: *const u8, length: usize, status: i32) -> !;
}

#[repr(C)]
pub struct ReturnedCallable {
    invoke: extern "C" fn(i64, i64) -> i64,
    capture: i64,
}

fn stop(message: &'static [u8], status: i32) -> ! {
    unsafe { returned_failure(message.as_ptr(), message.len(), status) }
}

#[panic_handler]
fn panic(_: &PanicInfo<'_>) -> ! {
    stop(b"unexpected Rust panic\n", 72)
}

extern "C" fn addition(capture: i64, input: i64) -> i64 {
    match capture.checked_add(input) {
        Some(result) => result,
        None => stop(b"addition overflow\n", 70),
    }
}

extern "C" fn composition(capture: i64, input: i64) -> i64 {
    match addition(capture, input).checked_mul(2) {
        Some(result) => result,
        None => stop(b"multiplication overflow\n", 70),
    }
}

#[unsafe(no_mangle)]
pub extern "C" fn returned_make(kind: i32, capture: i64) -> ReturnedCallable {
    let invoke = match kind {
        0 => addition,
        1 => composition,
        _ => stop(b"invalid callable kind\n", 71),
    };
    ReturnedCallable { invoke, capture }
}

#[unsafe(no_mangle)]
pub extern "C" fn returned_direct(kind: i32, capture: i64, input: i64) -> i64 {
    match kind {
        0 => addition(capture, input),
        1 => composition(capture, input),
        _ => stop(b"invalid callable kind\n", 71),
    }
}
