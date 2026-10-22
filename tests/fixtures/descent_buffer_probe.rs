// Untimed observation of the numerical vectors. Capture is enabled only while
// constructing them; their releases remain tracked throughout the workload.
struct InputObserver;
#[global_allocator]
static INPUT_OBSERVER: InputObserver = InputObserver;
static INPUT_CAPTURE: AtomicBool = AtomicBool::new(false);
static INPUT_ADDRESSES: [AtomicUsize; 2] = [AtomicUsize::new(0), AtomicUsize::new(0)];
static INPUT_SIZES: [AtomicUsize; 2] = [AtomicUsize::new(0), AtomicUsize::new(0)];
static INPUT_REQUESTS: AtomicUsize = AtomicUsize::new(0);
static INPUT_REQUESTED_BYTES: AtomicUsize = AtomicUsize::new(0);
static INPUT_LIVE_BYTES: AtomicUsize = AtomicUsize::new(0);
static INPUT_PEAK_BYTES: AtomicUsize = AtomicUsize::new(0);

fn input_allocated(value: *mut u8, bytes: usize) {
    if value.is_null() || !INPUT_CAPTURE.load(Ordering::Relaxed) {
        return;
    }
    for i in 0..2 {
        if INPUT_ADDRESSES[i]
            .compare_exchange(0, value as usize, Ordering::Relaxed, Ordering::Relaxed)
            .is_ok()
        {
            INPUT_SIZES[i].store(bytes, Ordering::Relaxed);
            INPUT_REQUESTS.fetch_add(1, Ordering::Relaxed);
            INPUT_REQUESTED_BYTES.fetch_add(bytes, Ordering::Relaxed);
            let live = INPUT_LIVE_BYTES.fetch_add(bytes, Ordering::Relaxed) + bytes;
            INPUT_PEAK_BYTES.fetch_max(live, Ordering::Relaxed);
            return;
        }
    }
    std::process::exit(227);
}

unsafe impl GlobalAlloc for InputObserver {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        let value = unsafe { System.alloc(layout) };
        input_allocated(value, layout.size());
        value
    }
    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        let value = unsafe { System.alloc_zeroed(layout) };
        input_allocated(value, layout.size());
        value
    }
    unsafe fn dealloc(&self, value: *mut u8, layout: Layout) {
        for i in 0..2 {
            if INPUT_ADDRESSES[i].load(Ordering::Relaxed) == value as usize {
                if INPUT_SIZES[i].load(Ordering::Relaxed) != layout.size() {
                    std::process::exit(227);
                }
                INPUT_ADDRESSES[i].store(0, Ordering::Relaxed);
                INPUT_SIZES[i].store(0, Ordering::Relaxed);
                INPUT_LIVE_BYTES.fetch_sub(layout.size(), Ordering::Relaxed);
                break;
            }
        }
        unsafe { System.dealloc(value, layout) };
    }
    unsafe fn realloc(&self, value: *mut u8, layout: Layout, bytes: usize) -> *mut u8 {
        // These fixed-size vector inputs never grow. A changed workload must
        // update the experiment explicitly, rather than silently losing owners.
        if INPUT_CAPTURE.load(Ordering::Relaxed)
            || INPUT_ADDRESSES
                .iter()
                .any(|p| p.load(Ordering::Relaxed) == value as usize)
        {
            std::process::exit(227);
        }
        unsafe { System.realloc(value, layout, bytes) }
    }
}

fn observe_inputs(solve: usize) {
    let requests = INPUT_REQUESTS.load(Ordering::Relaxed);
    let bytes = INPUT_REQUESTED_BYTES.load(Ordering::Relaxed);
    let live = INPUT_LIVE_BYTES.load(Ordering::Relaxed);
    let peak = INPUT_PEAK_BYTES.load(Ordering::Relaxed);
    eprintln!("{{\"solve\":{solve},\"inputRequests\":{requests},\"inputRequestedBytes\":{bytes},\"inputLiveBytes\":{live},\"inputPeakBytes\":{peak}}}");
    let peak_limit = 2 * DIMENSIONS * std::mem::size_of::<f64>();
    if live != 0 || requests != 2 * solve || bytes != solve * peak_limit || peak != peak_limit {
        std::process::exit(226);
    }
}
