// Diagnostic global allocator, active only around parsing and tree cleanup.
// Events describe successful allocation API transitions, not allocator internals.
// The ordinary timed peer never contains this observer.
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
#[cfg(parser_storage_omit_release)]
static STORAGE_OMITTED: AtomicBool = AtomicBool::new(false);

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
            parser_storage_event(0, layout.size());
        }
        pointer
    }

    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        let pointer = System.alloc_zeroed(layout);
        if STORAGE_ACTIVE.load(Ordering::SeqCst) && !pointer.is_null() {
            parser_storage_event(0, layout.size());
        }
        pointer
    }

    unsafe fn realloc(&self, pointer: *mut u8, layout: Layout, size: usize) -> *mut u8 {
        let next = System.realloc(pointer, layout, size);
        if STORAGE_ACTIVE.load(Ordering::SeqCst) && !next.is_null() {
            parser_storage_event(layout.size(), size);
        }
        next
    }

    unsafe fn dealloc(&self, pointer: *mut u8, layout: Layout) {
        if STORAGE_ACTIVE.load(Ordering::SeqCst) {
            #[cfg(parser_storage_omit_release)]
            if !STORAGE_OMITTED.swap(true, Ordering::SeqCst) {
                return;
            }
            parser_storage_event(layout.size(), 0);
        }
        System.dealloc(pointer, layout);
    }
}

fn parser_storage_begin() {
    assert!(!STORAGE_ACTIVE.load(Ordering::SeqCst));
    assert_eq!(STORAGE_LIVE.load(Ordering::SeqCst), 0);
    for counter in [&STORAGE_PEAK, &STORAGE_REQUESTS, &STORAGE_BYTES, &STORAGE_COUNT] {
        counter.store(0, Ordering::SeqCst);
    }
    STORAGE_ACTIVE.store(true, Ordering::SeqCst);
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
