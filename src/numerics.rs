//! Reverse-mode autodiff tapes and device kernels for the interpreter
//! (`ad.*` and `device.*` primitives of lib/autodiff.fwp and
//! lib/tensor.fwp). runtime/fwp_rt_kernel.c implements the same
//! primitives with the same operation order, so results agree bit for bit.
//!
//! Tapes: a reverse-mode value refers to its node as `(tape id << 32) |
//! index`; constants use -1. A tape id is `(generation << 16) | (slot +
//! 1)`, so a value that outlives its tape is detected.
//!
//! Kernels: a fused elementwise expression in postfix form (see `op`),
//! evaluated 256 elements at a time; reductions sum blocks of 4096
//! elements from the left, then the block sums from the left, whatever
//! the number of threads.

use std::rc::Rc;
use std::sync::Mutex;

use crate::interp::{Ctl, R};
use crate::value::Value;

fn trap<T>(msg: impl Into<String>) -> R<T> {
    Err(Ctl::Trap(msg.into()))
}

fn int(v: &Value) -> i64 {
    v.as_i128().unwrap_or(0) as i64
}

fn f64s(v: &Value) -> Vec<f64> {
    match v {
        Value::Array(a) => a.iter().map(|x| x.as_f64().unwrap_or(0.0)).collect(),
        _ => Vec::new(),
    }
}

fn ints(v: &Value) -> Vec<i64> {
    match v {
        Value::Array(a) => a.iter().map(int).collect(),
        _ => Vec::new(),
    }
}

fn f64_array(xs: &[f64]) -> Value {
    Value::Array(Rc::new(xs.iter().map(|x| Value::F64(*x)).collect()))
}

// ------------------------------------------------------------------ tapes

#[derive(Default)]
struct Tape {
    gen: u32,
    live: bool,
    leaves: usize,
    pa: Vec<i32>,
    pb: Vec<i32>,
    da: Vec<f64>,
    db: Vec<f64>,
}

static TAPES: Mutex<Vec<Tape>> = Mutex::new(Vec::new());

const USED_OUTSIDE: &str =
    "autodiff: a reverse-mode value was used after the grad that made it returned";
const MIXED: &str = "autodiff: values of two different grad computations were combined (nested reverse mode is not supported)";

/// The slot of a live tape id.
fn slot_of(tapes: &[Tape], id: i64) -> R<usize> {
    let slot = (id & 0xffff) - 1;
    let gen = (id >> 16) as u32;
    if slot < 0 || slot as usize >= tapes.len() {
        return trap(USED_OUTSIDE);
    }
    let t = &tapes[slot as usize];
    if !t.live || t.gen != gen {
        return trap(USED_OUTSIDE);
    }
    Ok(slot as usize)
}

/// `ad.tape n`: a new tape whose first n nodes are the inputs.
fn tape_new(n: i64) -> R<i64> {
    if !(0..=i32::MAX as i64).contains(&n) {
        return trap("autodiff: too many inputs");
    }
    let mut tapes = TAPES.lock().unwrap();
    let slot = match tapes.iter().position(|t| !t.live) {
        Some(s) => s,
        None => {
            if tapes.len() >= 0xffff {
                return trap("autodiff: too many grad computations at once");
            }
            tapes.push(Tape::default());
            tapes.len() - 1
        }
    };
    let t = &mut tapes[slot];
    t.gen = t.gen % 32767 + 1;
    t.live = true;
    t.leaves = n as usize;
    t.pa = vec![-1; n as usize];
    t.pb = vec![-1; n as usize];
    t.da = vec![0.0; n as usize];
    t.db = vec![0.0; n as usize];
    let id = ((t.gen as i64) << 16) | (slot as i64 + 1);
    Ok(id << 32)
}

/// `ad.push (a, da, b, db)`: a node with the parents a and b (-1: none)
/// and the partial derivatives da and db.
fn push(ra: i64, da: f64, rb: i64, db: f64) -> R<i64> {
    if ra < 0 && rb < 0 {
        return Ok(-1);
    }
    if ra >= 0 && rb >= 0 && (ra >> 32) != (rb >> 32) {
        return trap(MIXED);
    }
    let (ra, da, rb, db) = if ra < 0 {
        (rb, db, -1, 0.0)
    } else {
        (ra, da, rb, db)
    };
    let id = ra >> 32;
    let mut tapes = TAPES.lock().unwrap();
    let slot = slot_of(&tapes, id)?;
    let t = &mut tapes[slot];
    let idx = t.pa.len();
    if idx >= i32::MAX as usize {
        return trap("autodiff: the tape is full");
    }
    t.pa.push((ra & 0xffff_ffff) as i32);
    t.da.push(da);
    t.pb.push(if rb < 0 {
        -1
    } else {
        (rb & 0xffff_ffff) as i32
    });
    t.db.push(db);
    Ok((id << 32) | idx as i64)
}

/// `ad.backward base outputs seeds`: the adjoints of the inputs; frees
/// the tape.
fn backward(base: i64, outs: &[i64], seeds: &[f64]) -> R<Vec<f64>> {
    let id = base >> 32;
    let mut tapes = TAPES.lock().unwrap();
    let slot = slot_of(&tapes, id)?;
    let t = std::mem::take(&mut tapes[slot]);
    tapes[slot].gen = t.gen;
    drop(tapes);
    let mut adj = vec![0.0f64; t.pa.len()];
    for (o, s) in outs.iter().zip(seeds.iter()) {
        if *o < 0 {
            continue;
        }
        if (*o >> 32) != id {
            return trap(MIXED);
        }
        adj[(*o & 0xffff_ffff) as usize] += *s;
    }
    for i in (t.leaves..t.pa.len()).rev() {
        let a = adj[i];
        if a == 0.0 {
            continue;
        }
        if t.pa[i] >= 0 {
            adj[t.pa[i] as usize] += a * t.da[i];
        }
        if t.pb[i] >= 0 {
            adj[t.pb[i] as usize] += a * t.db[i];
        }
    }
    adj.truncate(t.leaves);
    Ok(adj)
}

// ---------------------------------------------------------------- kernels

const OP_LEAF: i64 = 0;
const OP_CONST: i64 = 1;
const OP_ADD: i64 = 2;
const OP_SUB: i64 = 3;
const OP_MUL: i64 = 4;
const OP_DIV: i64 = 5;
const OP_NEG: i64 = 6;
const OP_SQRT: i64 = 7;
const OP_EXP: i64 = 8;
const OP_LN: i64 = 9;
const OP_SIN: i64 = 10;
const OP_COS: i64 = 11;
const OP_TAN: i64 = 12;
const OP_ABS: i64 = 13;

/// Elements evaluated together.
const CHUNK: usize = 256;
/// Elements of a block of a reduction.
const RBLOCK: usize = 4096;

struct Kernel<'a> {
    code: &'a [i64],
    consts: &'a [f64],
    inputs: &'a [Vec<f64>],
    depth: usize,
}

/// Check a kernel: its stack depth, and that it uses the inputs and
/// constants it is given.
fn check(code: &[i64], nconsts: usize, inputs: &[Vec<f64>], n: usize) -> R<usize> {
    let bad = || trap("device: malformed kernel");
    let (mut sp, mut depth, mut leaves, mut consts) = (0usize, 0usize, 0usize, 0usize);
    for &op in code {
        match op {
            OP_LEAF | OP_CONST => {
                if op == OP_LEAF {
                    leaves += 1;
                } else {
                    consts += 1;
                }
                sp += 1;
                depth = depth.max(sp);
            }
            OP_ADD..=OP_DIV => {
                if sp < 2 {
                    return bad();
                }
                sp -= 1;
            }
            OP_NEG..=OP_ABS => {
                if sp < 1 {
                    return bad();
                }
            }
            _ => return bad(),
        }
    }
    if sp != 1 || leaves != inputs.len() || consts != nconsts {
        return bad();
    }
    for (k, x) in inputs.iter().enumerate() {
        if x.len() != n {
            return trap(format!(
                "device: input {} has {} elements, the kernel {}",
                k,
                x.len(),
                n
            ));
        }
    }
    Ok(depth)
}

impl Kernel<'_> {
    /// Elements start..start+out.len() into out (at most CHUNK).
    fn eval(&self, start: usize, out: &mut [f64], stack: &mut [f64]) {
        let len = out.len();
        let (mut sp, mut li, mut ci) = (0usize, 0usize, 0usize);
        for &op in self.code {
            match op {
                OP_LEAF => {
                    stack[sp * CHUNK..sp * CHUNK + len]
                        .copy_from_slice(&self.inputs[li][start..start + len]);
                    li += 1;
                    sp += 1;
                }
                OP_CONST => {
                    let c = self.consts[ci];
                    stack[sp * CHUNK..sp * CHUNK + len].fill(c);
                    ci += 1;
                    sp += 1;
                }
                OP_ADD..=OP_DIV => {
                    let (lo, hi) = stack.split_at_mut((sp - 1) * CHUNK);
                    let x = &mut lo[(sp - 2) * CHUNK..(sp - 2) * CHUNK + len];
                    let y = &hi[..len];
                    match op {
                        OP_ADD => x.iter_mut().zip(y).for_each(|(a, b)| *a += *b),
                        OP_SUB => x.iter_mut().zip(y).for_each(|(a, b)| *a -= *b),
                        OP_MUL => x.iter_mut().zip(y).for_each(|(a, b)| *a *= *b),
                        _ => x.iter_mut().zip(y).for_each(|(a, b)| *a /= *b),
                    }
                    sp -= 1;
                }
                _ => {
                    let x = &mut stack[(sp - 1) * CHUNK..(sp - 1) * CHUNK + len];
                    let f: fn(f64) -> f64 = match op {
                        OP_NEG => |a| -a,
                        OP_SQRT => f64::sqrt,
                        OP_EXP => f64::exp,
                        OP_LN => f64::ln,
                        OP_SIN => f64::sin,
                        OP_COS => f64::cos,
                        OP_TAN => f64::tan,
                        _ => f64::abs,
                    };
                    x.iter_mut().for_each(|a| *a = f(*a));
                }
            }
        }
        out.copy_from_slice(&stack[..len]);
    }

    fn stack(&self) -> Vec<f64> {
        vec![0.0; self.depth.max(1) * CHUNK]
    }

    /// Elements start..start+out.len().
    fn run_range(&self, start: usize, out: &mut [f64]) {
        let mut stack = self.stack();
        let mut i = 0;
        while i < out.len() {
            let len = CHUNK.min(out.len() - i);
            self.eval(start + i, &mut out[i..i + len], &mut stack);
            i += len;
        }
    }

    /// The sums of blocks b0..b0+sums.len() of n elements.
    fn sum_blocks(&self, n: usize, b0: usize, sums: &mut [f64]) {
        let mut stack = self.stack();
        let mut buf = [0.0f64; CHUNK];
        for (k, s) in sums.iter_mut().enumerate() {
            let start = (b0 + k) * RBLOCK;
            let end = n.min(start + RBLOCK);
            let mut acc = 0.0f64;
            let mut i = start;
            while i < end {
                let len = CHUNK.min(end - i);
                self.eval(i, &mut buf[..len], &mut stack);
                for x in &buf[..len] {
                    acc += *x;
                }
                i += len;
            }
            *s = acc;
        }
    }
}

/// Split `units` units into `threads` contiguous ranges, as the C
/// runtime does.
fn ranges(units: usize, threads: usize) -> Vec<(usize, usize)> {
    let t = threads.clamp(1, 256).min(units.max(1));
    (0..t)
        .map(|i| (i * units / t, (i + 1) * units / t))
        .collect()
}

fn run(threads: usize, n: usize, k: &Kernel) -> Vec<f64> {
    let mut out = vec![0.0f64; n];
    let chunks = n.div_ceil(CHUNK);
    let parts = ranges(chunks, threads);
    if parts.len() <= 1 || cfg!(target_family = "wasm") {
        k.run_range(0, &mut out);
        return out;
    }
    std::thread::scope(|s| {
        let mut rest: &mut [f64] = &mut out;
        let mut done = 0;
        for (lo, hi) in parts {
            let end = n.min(hi * CHUNK);
            let (mine, tail) = rest.split_at_mut(end - done);
            let start = lo * CHUNK;
            s.spawn(move || k.run_range(start, mine));
            rest = tail;
            done = end;
        }
    });
    out
}

fn sum(threads: usize, n: usize, k: &Kernel) -> f64 {
    let blocks = n.div_ceil(RBLOCK);
    let mut sums = vec![0.0f64; blocks];
    let parts = ranges(blocks, threads);
    if parts.len() <= 1 || cfg!(target_family = "wasm") {
        k.sum_blocks(n, 0, &mut sums);
    } else {
        std::thread::scope(|s| {
            let mut rest: &mut [f64] = &mut sums;
            for (lo, hi) in parts {
                let (mine, tail) = rest.split_at_mut(hi - lo);
                s.spawn(move || k.sum_blocks(n, lo, mine));
                rest = tail;
            }
        });
    }
    let mut total = 0.0f64;
    for s in sums {
        total += s;
    }
    total
}

// ------------------------------------------------------------------ OpenCL

#[cfg(not(target_family = "wasm"))]
mod opencl {
    use std::ffi::{c_char, c_int, c_void, CString};
    use std::sync::OnceLock;

    type Ptr = *mut c_void;

    extern "C" {
        fn dlopen(path: *const c_char, flags: c_int) -> *mut c_void;
        fn dlsym(handle: *mut c_void, symbol: *const c_char) -> *mut c_void;
    }

    #[allow(clippy::type_complexity)]
    struct Cl {
        get_platforms: unsafe extern "C" fn(u32, *mut Ptr, *mut u32) -> i32,
        get_devices: unsafe extern "C" fn(Ptr, u64, u32, *mut Ptr, *mut u32) -> i32,
        device_info: unsafe extern "C" fn(Ptr, u32, usize, *mut c_void, *mut usize) -> i32,
        create_context: unsafe extern "C" fn(
            *const isize,
            u32,
            *const Ptr,
            Option<unsafe extern "C" fn()>,
            Ptr,
            *mut i32,
        ) -> Ptr,
        create_queue: unsafe extern "C" fn(Ptr, Ptr, u64, *mut i32) -> Ptr,
        program_with_source:
            unsafe extern "C" fn(Ptr, u32, *const *const c_char, *const usize, *mut i32) -> Ptr,
        build_program: unsafe extern "C" fn(
            Ptr,
            u32,
            *const Ptr,
            *const c_char,
            Option<unsafe extern "C" fn()>,
            Ptr,
        ) -> i32,
        build_info: unsafe extern "C" fn(Ptr, Ptr, u32, usize, *mut c_void, *mut usize) -> i32,
        create_kernel: unsafe extern "C" fn(Ptr, *const c_char, *mut i32) -> Ptr,
        create_buffer: unsafe extern "C" fn(Ptr, u64, usize, *mut c_void, *mut i32) -> Ptr,
        set_arg: unsafe extern "C" fn(Ptr, u32, usize, *const c_void) -> i32,
        enqueue: unsafe extern "C" fn(
            Ptr,
            Ptr,
            u32,
            *const usize,
            *const usize,
            *const usize,
            u32,
            *const Ptr,
            *mut Ptr,
        ) -> i32,
        read_buffer: unsafe extern "C" fn(
            Ptr,
            Ptr,
            u32,
            usize,
            usize,
            *mut c_void,
            u32,
            *const Ptr,
            *mut Ptr,
        ) -> i32,
        finish: unsafe extern "C" fn(Ptr) -> i32,
        release_mem: unsafe extern "C" fn(Ptr) -> i32,
        release_kernel: unsafe extern "C" fn(Ptr) -> i32,
        release_program: unsafe extern "C" fn(Ptr) -> i32,
        release_queue: unsafe extern "C" fn(Ptr) -> i32,
        release_context: unsafe extern "C" fn(Ptr) -> i32,
    }

    /// The OpenCL library, the device chosen and its context and queue.
    struct Gpu {
        cl: Cl,
        device: Ptr,
        context: Ptr,
        queue: Ptr,
    }

    unsafe impl Send for Gpu {}
    unsafe impl Sync for Gpu {}

    static GPU: OnceLock<Result<Gpu, String>> = OnceLock::new();

    const CL_DEVICE_TYPE_GPU: u64 = 1 << 2;
    const CL_DEVICE_TYPE_ALL: u64 = 0xffff_ffff;
    const CL_DEVICE_EXTENSIONS: u32 = 0x1030;
    const CL_PROGRAM_BUILD_LOG: u32 = 0x1183;
    const CL_MEM_WRITE_ONLY: u64 = 1 << 1;
    const CL_MEM_READ_ONLY: u64 = 1 << 2;
    const CL_MEM_COPY_HOST_PTR: u64 = 1 << 5;

    fn library_names() -> Vec<String> {
        match std::env::var("FWP_OPENCL_LIB") {
            Ok(p) if !p.is_empty() => vec![p],
            _ if cfg!(target_os = "macos") => {
                vec!["/System/Library/Frameworks/OpenCL.framework/OpenCL".into()]
            }
            _ => vec!["libOpenCL.so.1".into(), "libOpenCL.so".into()],
        }
    }

    fn load() -> Result<Gpu, String> {
        let names = library_names();
        let handle = names
            .iter()
            .find_map(|n| {
                let c = CString::new(n.as_str()).ok()?;
                let h = unsafe { dlopen(c.as_ptr(), 2) };
                (!h.is_null()).then_some(h)
            })
            .ok_or_else(|| {
                format!(
                    "no OpenCL device: the OpenCL library ({}) could not be loaded",
                    names.join(", ")
                )
            })?;
        fn get<F: Copy>(h: Ptr, name: &str) -> Result<F, String> {
            assert_eq!(std::mem::size_of::<F>(), std::mem::size_of::<Ptr>());
            let c = CString::new(name).unwrap();
            let p = unsafe { dlsym(h, c.as_ptr()) };
            if p.is_null() {
                Err(format!(
                    "no OpenCL device: the OpenCL library has no `{}`",
                    name
                ))
            } else {
                Ok(unsafe { std::mem::transmute_copy::<Ptr, F>(&p) })
            }
        }
        let cl = Cl {
            get_platforms: get(handle, "clGetPlatformIDs")?,
            get_devices: get(handle, "clGetDeviceIDs")?,
            device_info: get(handle, "clGetDeviceInfo")?,
            create_context: get(handle, "clCreateContext")?,
            create_queue: get(handle, "clCreateCommandQueue")?,
            program_with_source: get(handle, "clCreateProgramWithSource")?,
            build_program: get(handle, "clBuildProgram")?,
            build_info: get(handle, "clGetProgramBuildInfo")?,
            create_kernel: get(handle, "clCreateKernel")?,
            create_buffer: get(handle, "clCreateBuffer")?,
            set_arg: get(handle, "clSetKernelArg")?,
            enqueue: get(handle, "clEnqueueNDRangeKernel")?,
            read_buffer: get(handle, "clEnqueueReadBuffer")?,
            finish: get(handle, "clFinish")?,
            release_mem: get(handle, "clReleaseMemObject")?,
            release_kernel: get(handle, "clReleaseKernel")?,
            release_program: get(handle, "clReleaseProgram")?,
            release_queue: get(handle, "clReleaseCommandQueue")?,
            release_context: get(handle, "clReleaseContext")?,
        };
        let device = unsafe { pick_device(&cl) }?;
        let mut err = 0i32;
        let context = unsafe {
            (cl.create_context)(
                std::ptr::null(),
                1,
                &device,
                None,
                std::ptr::null_mut(),
                &mut err,
            )
        };
        if context.is_null() || err != 0 {
            return Err(format!(
                "no OpenCL device: clCreateContext failed ({})",
                err
            ));
        }
        let queue = unsafe { (cl.create_queue)(context, device, 0, &mut err) };
        if queue.is_null() || err != 0 {
            return Err(format!(
                "no OpenCL device: clCreateCommandQueue failed ({})",
                err
            ));
        }
        Ok(Gpu {
            cl,
            device,
            context,
            queue,
        })
    }

    /// The first GPU with double precision, or else the first device of
    /// any type with it.
    unsafe fn pick_device(cl: &Cl) -> Result<Ptr, String> {
        let mut np = 0u32;
        if (cl.get_platforms)(0, std::ptr::null_mut(), &mut np) != 0 || np == 0 {
            return Err("no OpenCL device: there is no OpenCL platform".into());
        }
        let mut platforms = vec![std::ptr::null_mut(); np as usize];
        (cl.get_platforms)(np, platforms.as_mut_ptr(), &mut np);
        for ty in [CL_DEVICE_TYPE_GPU, CL_DEVICE_TYPE_ALL] {
            for p in &platforms {
                let mut nd = 0u32;
                if (cl.get_devices)(*p, ty, 0, std::ptr::null_mut(), &mut nd) != 0 || nd == 0 {
                    continue;
                }
                let mut devs = vec![std::ptr::null_mut(); nd as usize];
                (cl.get_devices)(*p, ty, nd, devs.as_mut_ptr(), &mut nd);
                for d in devs {
                    let mut buf = vec![0u8; 8192];
                    let mut len = 0usize;
                    if (cl.device_info)(
                        d,
                        CL_DEVICE_EXTENSIONS,
                        buf.len(),
                        buf.as_mut_ptr() as *mut c_void,
                        &mut len,
                    ) == 0
                        && String::from_utf8_lossy(&buf[..len.min(buf.len())])
                            .contains("cl_khr_fp64")
                    {
                        return Ok(d);
                    }
                }
            }
        }
        Err("no OpenCL device: no OpenCL device supports double precision (cl_khr_fp64)".into())
    }

    fn gpu() -> Result<&'static Gpu, String> {
        GPU.get_or_init(load).as_ref().map_err(|e| e.clone())
    }

    pub fn available() -> bool {
        gpu().is_ok()
    }

    /// Run the kernel `fwp_kernel(out, k, n, x0, x1, ...)` of `src` over n
    /// elements.
    pub fn run(
        src: &str,
        n: usize,
        consts: &[f64],
        inputs: &[Vec<f64>],
    ) -> Result<Vec<f64>, String> {
        let g = gpu()?;
        let cl = &g.cl;
        if n == 0 {
            return Ok(Vec::new());
        }
        unsafe {
            let mut err = 0i32;
            let csrc = CString::new(src).map_err(|e| e.to_string())?;
            let p = csrc.as_ptr();
            let prog = (cl.program_with_source)(g.context, 1, &p, std::ptr::null(), &mut err);
            if prog.is_null() || err != 0 {
                return Err(format!(
                    "OpenCL: clCreateProgramWithSource failed ({})",
                    err
                ));
            }
            let mut mems: Vec<Ptr> = Vec::new();
            let mut kernel: Ptr = std::ptr::null_mut();
            let res = (|| -> Result<Vec<f64>, String> {
                let opts = CString::new("-cl-fp32-correctly-rounded-divide-sqrt").unwrap();
                if (cl.build_program)(
                    prog,
                    1,
                    &g.device,
                    opts.as_ptr(),
                    None,
                    std::ptr::null_mut(),
                ) != 0
                {
                    let mut log = vec![0u8; 16384];
                    let mut len = 0usize;
                    (cl.build_info)(
                        prog,
                        g.device,
                        CL_PROGRAM_BUILD_LOG,
                        log.len(),
                        log.as_mut_ptr() as *mut c_void,
                        &mut len,
                    );
                    let log = String::from_utf8_lossy(&log[..len.min(log.len())]);
                    return Err(format!(
                        "OpenCL: building the kernel failed:\n{}",
                        log.trim_end_matches('\0')
                    ));
                }
                let name = CString::new("fwp_kernel").unwrap();
                kernel = (cl.create_kernel)(prog, name.as_ptr(), &mut err);
                if kernel.is_null() || err != 0 {
                    return Err(format!("OpenCL: clCreateKernel failed ({})", err));
                }
                let mut buffer =
                    |flags: u64, data: Option<&[f64]>, len: usize| -> Result<Ptr, String> {
                        let size = len.max(1) * 8;
                        let host = match data {
                            Some(d) if !d.is_empty() => d.as_ptr() as *mut c_void,
                            _ => std::ptr::null_mut(),
                        };
                        let flags = if host.is_null() {
                            flags
                        } else {
                            flags | CL_MEM_COPY_HOST_PTR
                        };
                        let m = (cl.create_buffer)(g.context, flags, size, host, &mut err);
                        if m.is_null() || err != 0 {
                            return Err(format!("OpenCL: clCreateBuffer failed ({})", err));
                        }
                        mems.push(m);
                        Ok(m)
                    };
                let out = buffer(CL_MEM_WRITE_ONLY, None, n)?;
                let k = buffer(CL_MEM_READ_ONLY, Some(consts), consts.len())?;
                let mut ins = Vec::new();
                for x in inputs {
                    ins.push(buffer(CL_MEM_READ_ONLY, Some(x), x.len())?);
                }
                let nn = n as i64;
                let ptr = std::mem::size_of::<Ptr>();
                let mut st = (cl.set_arg)(kernel, 0, ptr, &out as *const Ptr as *const c_void);
                st |= (cl.set_arg)(kernel, 1, ptr, &k as *const Ptr as *const c_void);
                st |= (cl.set_arg)(kernel, 2, 8, &nn as *const i64 as *const c_void);
                for (i, m) in ins.iter().enumerate() {
                    st |= (cl.set_arg)(kernel, 3 + i as u32, ptr, m as *const Ptr as *const c_void);
                }
                if st != 0 {
                    return Err("OpenCL: clSetKernelArg failed".into());
                }
                let global = n;
                let st = (cl.enqueue)(
                    g.queue,
                    kernel,
                    1,
                    std::ptr::null(),
                    &global,
                    std::ptr::null(),
                    0,
                    std::ptr::null(),
                    std::ptr::null_mut(),
                );
                if st != 0 {
                    return Err(format!("OpenCL: clEnqueueNDRangeKernel failed ({})", st));
                }
                let mut result = vec![0.0f64; n];
                let st = (cl.read_buffer)(
                    g.queue,
                    out,
                    1,
                    0,
                    n * 8,
                    result.as_mut_ptr() as *mut c_void,
                    0,
                    std::ptr::null(),
                    std::ptr::null_mut(),
                );
                (cl.finish)(g.queue);
                if st != 0 {
                    return Err(format!("OpenCL: clEnqueueReadBuffer failed ({})", st));
                }
                Ok(result)
            })();
            for m in mems {
                (cl.release_mem)(m);
            }
            if !kernel.is_null() {
                (cl.release_kernel)(kernel);
            }
            (cl.release_program)(prog);
            let _ = (cl.release_queue, cl.release_context);
            res
        }
    }
}

#[cfg(target_family = "wasm")]
mod opencl {
    const NONE: &str = "no OpenCL device: OpenCL is not available in the WebAssembly build of fwp";

    pub fn available() -> bool {
        false
    }

    pub fn run(_: &str, _: usize, _: &[f64], _: &[Vec<f64>]) -> Result<Vec<f64>, String> {
        Err(NONE.into())
    }
}

// -------------------------------------------------------------- primitives

fn inputs(v: &Value) -> Vec<Vec<f64>> {
    v.list_items().iter().map(f64s).collect()
}

/// The `ad.*` and `device.*` primitives; `None` for other symbols.
pub fn prim(sym: &str, a: &[Value]) -> Option<R<Value>> {
    let r = (|| -> R<Option<Value>> {
        Ok(Some(match sym {
            "ad.tape" => Value::I64(tape_new(int(&a[0]))?),
            "ad.push" => {
                let f = match &a[0] {
                    Value::Record(f) => f.clone(),
                    _ => return trap("ad.push: expected a tuple"),
                };
                let fl = |v: &Value| v.as_f64().unwrap_or(0.0);
                Value::I64(push(int(&f[0]), fl(&f[1]), int(&f[2]), fl(&f[3]))?)
            }
            "ad.backward" => f64_array(&backward(int(&a[0]), &ints(&a[1]), &f64s(&a[2]))?),
            "device.run" | "device.sum" => {
                let threads = int(&a[0]).clamp(1, 256) as usize;
                let n = int(&a[1]).max(0) as usize;
                let code = ints(&a[2]);
                let consts = f64s(&a[3]);
                let ins = inputs(&a[4]);
                let depth = check(&code, consts.len(), &ins, n)?;
                let k = Kernel {
                    code: &code,
                    consts: &consts,
                    inputs: &ins,
                    depth,
                };
                if sym == "device.run" {
                    f64_array(&run(threads, n, &k))
                } else {
                    Value::F64(sum(threads, n, &k))
                }
            }
            "device.gpu-available" => Value::bool(opencl::available()),
            "device.gpu-run" => {
                let n = int(&a[1]).max(0) as usize;
                let ins = inputs(&a[3]);
                match opencl::run(a[0].as_str(), n, &f64s(&a[2]), &ins) {
                    Ok(v) => Value::data(0, vec![f64_array(&v)]),
                    Err(e) => Value::data(1, vec![Value::str(&e)]),
                }
            }
            _ => return Ok(None),
        }))
    })();
    match r {
        Ok(Some(v)) => Some(Ok(v)),
        Ok(None) => None,
        Err(e) => Some(Err(e)),
    }
}
