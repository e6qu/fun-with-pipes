// Diagnostic allocator only. Ordinary peer binaries do not use this observer.
use std::alloc::{GlobalAlloc, Layout, System};
use std::sync::atomic::{AtomicBool, AtomicUsize, Ordering};

struct BufferAllocator;
#[global_allocator]
static BUFFER_ALLOCATOR: BufferAllocator = BufferAllocator;
static BUFFER_ACTIVE: AtomicBool = AtomicBool::new(false);
static BUFFER_REQUESTS: AtomicUsize = AtomicUsize::new(0);
static BUFFER_BYTES: AtomicUsize = AtomicUsize::new(0);
static BUFFER_LIVE: AtomicUsize = AtomicUsize::new(0);
static BUFFER_PEAK: AtomicUsize = AtomicUsize::new(0);

fn buffer_acquired(size: usize) {
    BUFFER_REQUESTS.fetch_add(1, Ordering::SeqCst);
    BUFFER_BYTES.fetch_add(size, Ordering::SeqCst);
    let live = BUFFER_LIVE.fetch_add(size, Ordering::SeqCst) + size;
    BUFFER_PEAK.fetch_max(live, Ordering::SeqCst);
}

fn buffer_released(size: usize) {
    if BUFFER_LIVE.fetch_sub(size, Ordering::SeqCst) < size {
        process::abort();
    }
}

unsafe impl GlobalAlloc for BufferAllocator {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        let pointer = System.alloc(layout);
        if BUFFER_ACTIVE.load(Ordering::SeqCst) && !pointer.is_null() {
            buffer_acquired(layout.size());
        }
        pointer
    }

    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        let pointer = System.alloc_zeroed(layout);
        if BUFFER_ACTIVE.load(Ordering::SeqCst) && !pointer.is_null() {
            buffer_acquired(layout.size());
        }
        pointer
    }

    unsafe fn dealloc(&self, pointer: *mut u8, layout: Layout) {
        if BUFFER_ACTIVE.load(Ordering::SeqCst) {
            buffer_released(layout.size());
        }
        System.dealloc(pointer, layout);
    }

    unsafe fn realloc(&self, pointer: *mut u8, layout: Layout, size: usize) -> *mut u8 {
        let next = System.realloc(pointer, layout, size);
        if BUFFER_ACTIVE.load(Ordering::SeqCst) && !next.is_null() {
            buffer_released(layout.size());
            buffer_acquired(size);
        }
        next
    }
}
