// Diagnostic global allocator, active only around parsing and tree cleanup.
// Events describe successful allocation API transitions, not allocator internals.
// This fixture is single-threaded. The ordinary timed peer has no observer.
use std::alloc::{GlobalAlloc, Layout, System};
use std::sync::atomic::{AtomicBool, AtomicUsize, Ordering};

struct ParserStorage;
#[global_allocator]
static PARSER_STORAGE: ParserStorage = ParserStorage;
static STORAGE_ACTIVE: AtomicBool = AtomicBool::new(false);
static STORAGE_LIVE: AtomicUsize = AtomicUsize::new(0);
static STORAGE_PEAK: AtomicUsize = AtomicUsize::new(0);
static STORAGE_REQUESTS: AtomicUsize = AtomicUsize::new(0);
static STORAGE_BYTES: AtomicUsize = AtomicUsize::new(0);
static STORAGE_COUNT: AtomicUsize = AtomicUsize::new(0);
static STORAGE_BEFORE: [AtomicUsize; 64] = [const { AtomicUsize::new(0) }; 64];
static STORAGE_AFTER: [AtomicUsize; 64] = [const { AtomicUsize::new(0) }; 64];
static STORAGE_POINTERS: [AtomicUsize; 64] = [const { AtomicUsize::new(0) }; 64];
static STORAGE_SIZES: [AtomicUsize; 64] = [const { AtomicUsize::new(0) }; 64];
#[cfg(parser_storage_omit_release)]
static STORAGE_OMITTED: AtomicBool = AtomicBool::new(false);

// Error unwinding can destroy values allocated before this observer started.
// Identify measured allocations; size alone cannot establish their ownership.
fn parser_storage_slot(pointer: *mut u8) -> Option<usize> {
    STORAGE_POINTERS
        .iter()
        .position(|slot| slot.load(Ordering::SeqCst) == pointer as usize)
}

fn parser_storage_acquired(pointer: *mut u8, size: usize) {
    let Some(slot) = parser_storage_slot(std::ptr::null_mut()) else {
        std::process::abort();
    };
    STORAGE_POINTERS[slot].store(pointer as usize, Ordering::SeqCst);
    STORAGE_SIZES[slot].store(size, Ordering::SeqCst);
    parser_storage_event(0, size);
}

fn parser_storage_event(before: usize, after: usize) {
    let index = STORAGE_COUNT.fetch_add(1, Ordering::SeqCst);
    let previous = STORAGE_LIVE.load(Ordering::SeqCst);
    if index >= 64 || previous < before {
        std::process::abort();
    }
    STORAGE_BEFORE[index].store(before, Ordering::SeqCst);
    STORAGE_AFTER[index].store(after, Ordering::SeqCst);
    let live = previous - before + after;
    STORAGE_LIVE.store(live, Ordering::SeqCst);
    STORAGE_PEAK.fetch_max(live, Ordering::SeqCst);
    if after > 0 {
        STORAGE_REQUESTS.fetch_add(1, Ordering::SeqCst);
        STORAGE_BYTES.fetch_add(after, Ordering::SeqCst);
    }
}

unsafe impl GlobalAlloc for ParserStorage {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        let pointer = System.alloc(layout);
        if STORAGE_ACTIVE.load(Ordering::SeqCst) && !pointer.is_null() {
            parser_storage_acquired(pointer, layout.size());
        }
        pointer
    }

    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        let pointer = System.alloc_zeroed(layout);
        if STORAGE_ACTIVE.load(Ordering::SeqCst) && !pointer.is_null() {
            parser_storage_acquired(pointer, layout.size());
        }
        pointer
    }

    unsafe fn realloc(&self, pointer: *mut u8, layout: Layout, size: usize) -> *mut u8 {
        let slot = parser_storage_slot(pointer);
        let next = System.realloc(pointer, layout, size);
        if !next.is_null() {
            if let Some(slot) = slot {
                if STORAGE_SIZES[slot].load(Ordering::SeqCst) != layout.size() {
                    std::process::abort();
                }
                STORAGE_POINTERS[slot].store(next as usize, Ordering::SeqCst);
                STORAGE_SIZES[slot].store(size, Ordering::SeqCst);
                parser_storage_event(layout.size(), size);
            }
        }
        next
    }

    unsafe fn dealloc(&self, pointer: *mut u8, layout: Layout) {
        if let Some(slot) = parser_storage_slot(pointer) {
            if STORAGE_SIZES[slot].load(Ordering::SeqCst) != layout.size() {
                std::process::abort();
            }
            #[cfg(parser_storage_omit_release)]
            if !STORAGE_OMITTED.swap(true, Ordering::SeqCst) {
                return;
            }
            parser_storage_event(layout.size(), 0);
            STORAGE_POINTERS[slot].store(0, Ordering::SeqCst);
            STORAGE_SIZES[slot].store(0, Ordering::SeqCst);
        }
        System.dealloc(pointer, layout);
    }
}

struct ParserStorageScope;

impl Drop for ParserStorageScope {
    fn drop(&mut self) {
        // A failing parser must stop observing before outer input/argument
        // cleanup. A partially unwound profile is never a successful sample.
        STORAGE_ACTIVE.store(false, Ordering::SeqCst);
    }
}

fn parser_storage_begin() -> ParserStorageScope {
    assert!(!STORAGE_ACTIVE.load(Ordering::SeqCst));
    assert_eq!(STORAGE_LIVE.load(Ordering::SeqCst), 0);
    assert!(STORAGE_POINTERS.iter().all(|slot| slot.load(Ordering::SeqCst) == 0));
    for counter in [&STORAGE_PEAK, &STORAGE_REQUESTS, &STORAGE_BYTES, &STORAGE_COUNT] {
        counter.store(0, Ordering::SeqCst);
    }
    STORAGE_ACTIVE.store(true, Ordering::SeqCst);
    ParserStorageScope
}

fn parser_storage_finish() {
    assert!(STORAGE_ACTIVE.swap(false, Ordering::SeqCst));
    let live = STORAGE_LIVE.load(Ordering::SeqCst);
    eprint!("{{\"requests\":{},\"requestedBytes\":{},\"peakLiveBytes\":{},\"finalLiveBytes\":{},\"events\":[",
        STORAGE_REQUESTS.load(Ordering::SeqCst), STORAGE_BYTES.load(Ordering::SeqCst),
        STORAGE_PEAK.load(Ordering::SeqCst), live);
    for index in 0..STORAGE_COUNT.load(Ordering::SeqCst) {
        eprint!("{}[{},{}]", if index == 0 { "" } else { "," },
            STORAGE_BEFORE[index].load(Ordering::SeqCst), STORAGE_AFTER[index].load(Ordering::SeqCst));
    }
    eprintln!("]}}");
    if live != 0 {
        std::process::exit(78);
    }
}
