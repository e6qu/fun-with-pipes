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
use std::{cell::RefCell, collections::BTreeMap};

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
    adj: Vec<f64>,
    owned: bool,
}

struct OwnedTape {
    zero: Value,
    add: Value,
    mul: Value,
    inactive_zero: Value,
    da: Vec<Value>,
    db: Vec<Value>,
}

// Interpreter tasks have independent OS threads. Numeric IDs remain globally
// unique; managed weights stay on the creating task, like its dynamic scopes.
thread_local! {
    static OWNED_TAPES: RefCell<BTreeMap<i64, OwnedTape>> = const { RefCell::new(BTreeMap::new()) };
}

static TAPES: Mutex<Vec<Tape>> = Mutex::new(Vec::new());

const TAPE_WORKSPACE_BUDGET: usize = 512 * 1024;
static TAPE_WORKSPACE: Mutex<Option<Tape>> = Mutex::new(None);

fn workspace_enabled() -> bool {
    std::env::var("FWP_AD_WORKSPACE").as_deref() != Ok("0")
}

impl Tape {
    fn workspace_bytes(&self) -> usize {
        self.pa
            .capacity()
            .saturating_add(self.pb.capacity())
            .saturating_mul(4)
            .saturating_add(
                self.da
                    .capacity()
                    .saturating_add(self.db.capacity())
                    .saturating_add(self.adj.capacity())
                    .saturating_mul(8),
            )
    }
}

fn recycle_workspace(mut tape: Tape) {
    if tape.owned || !workspace_enabled() || tape.workspace_bytes() > TAPE_WORKSPACE_BUDGET {
        return;
    }
    tape.gen = 0;
    tape.live = false;
    tape.leaves = 0;
    tape.pa.clear();
    tape.pb.clear();
    tape.da.clear();
    tape.db.clear();
    tape.adj.clear();
    *TAPE_WORKSPACE.lock().unwrap() = Some(tape);
}

struct TapeOwner(Tape);
impl Drop for TapeOwner {
    fn drop(&mut self) {
        recycle_workspace(std::mem::take(&mut self.0));
    }
}

fn reserve_nodes(tape: &mut Tape, required: usize) {
    let target = required
        .max(tape.pa.capacity().saturating_mul(2).max(64))
        .min(tape_limit());
    macro_rules! grow {
        ($field:ident) => {
            if tape.$field.capacity() < required {
                tape.$field.reserve_exact(target - tape.$field.len());
            }
        };
    }
    grow!(pa);
    grow!(pb);
    if !tape.owned {
        grow!(da);
        grow!(db);
    }
}

thread_local! {
    static TAPE_SCOPES: std::cell::RefCell<Vec<Vec<i64>>> = const {
        std::cell::RefCell::new(Vec::new())
    };
}

struct TapeScope;
impl Drop for TapeScope {
    fn drop(&mut self) {
        let owned = TAPE_SCOPES.with(|scopes| scopes.borrow_mut().pop().unwrap());
        let mut tapes = TAPES.lock().unwrap();
        for base in owned {
            OWNED_TAPES.with(|owners| owners.borrow_mut().remove(&(base >> 32)));
            if let Ok(slot) = slot_of(&tapes, base >> 32) {
                let tape = std::mem::take(&mut tapes[slot]);
                tapes[slot].gen = tape.gen;
                recycle_workspace(tape);
            }
        }
    }
}

/// Run a synchronous callback with exception-safe ownership of its new tapes.
pub(crate) fn with_tape_scope<T>(callback: impl FnOnce() -> R<T>) -> R<T> {
    TAPE_SCOPES.with(|scopes| scopes.borrow_mut().push(Vec::new()));
    let _scope = TapeScope;
    callback()
}

fn forget_scoped_tape(id: i64) {
    TAPE_SCOPES.with(|scopes| {
        for owned in scopes.borrow_mut().iter_mut().rev() {
            if let Some(index) = owned.iter().position(|base| *base >> 32 == id) {
                owned.swap_remove(index);
                break;
            }
        }
    });
}

const USED_OUTSIDE: &str =
    "autodiff: a reverse-mode value was used after the grad that made it returned";
const MIXED: &str = "autodiff: values of two different grad computations were combined";
const REPRESENTATION: &str = "autodiff: tape scalar representation mismatch";

const INVALID_NODE: &str = "autodiff: invalid node index";

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

fn tape_limit() -> usize {
    (isize::MAX as usize / std::mem::size_of::<f64>()).min(i32::MAX as usize)
}

/// `ad.tape n`: a new tape whose first n nodes are the inputs.
fn tape_new(n: i64) -> R<i64> {
    if !(0..=tape_limit() as i64).contains(&n) {
        return trap("autodiff: too many inputs");
    }
    let mut tapes = TAPES.lock().unwrap();
    let slot = match tapes.iter().position(|t| !t.live && t.gen < 32767) {
        Some(s) => s,
        None => {
            if tapes.len() >= 0xffff {
                return trap("autodiff: too many grad computations at once");
            }
            tapes.push(Tape::default());
            tapes.len() - 1
        }
    };
    let gen = tapes[slot].gen + 1;
    let mut workspace = if workspace_enabled() {
        TAPE_WORKSPACE.lock().unwrap().take().unwrap_or_default()
    } else {
        Tape::default()
    };
    reserve_nodes(&mut workspace, n as usize);
    workspace.pa.resize(n as usize, -1);
    workspace.pb.resize(n as usize, -1);
    workspace.da.resize(n as usize, 0.0);
    workspace.db.resize(n as usize, 0.0);
    workspace.gen = gen;
    workspace.live = true;
    workspace.leaves = n as usize;
    tapes[slot] = workspace;
    let t = &tapes[slot];
    let id = ((t.gen as i64) << 16) | (slot as i64 + 1);
    let base = id << 32;
    TAPE_SCOPES.with(|scopes| {
        if let Some(owned) = scopes.borrow_mut().last_mut() {
            owned.push(base);
        }
    });
    Ok(base)
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
    if t.owned {
        return trap(REPRESENTATION);
    }
    let idx = t.pa.len();
    if idx >= tape_limit() {
        return trap("autodiff: the tape is full");
    }
    if (ra & 0xffff_ffff) as usize >= idx || (rb >= 0 && (rb & 0xffff_ffff) as usize >= idx) {
        return trap(INVALID_NODE);
    }
    reserve_nodes(t, idx + 1);
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
    if tapes[slot].owned {
        return trap(REPRESENTATION);
    }
    let t = std::mem::take(&mut tapes[slot]);
    tapes[slot].gen = t.gen;
    drop(tapes);
    forget_scoped_tape(id);
    let mut owner = TapeOwner(t);
    let t = &mut owner.0;
    if t.adj.capacity() < t.pa.len() {
        t.adj.reserve_exact(t.pa.len() - t.adj.len());
    }
    t.adj.resize(t.pa.len(), 0.0);
    t.adj.fill(0.0);
    let adj = &mut t.adj;
    for (o, s) in outs.iter().zip(seeds.iter()) {
        if *o < 0 {
            continue;
        }
        if (*o >> 32) != id {
            return trap(MIXED);
        }
        let node = (*o & 0xffff_ffff) as usize;
        if node >= adj.len() {
            return trap(INVALID_NODE);
        }
        adj[node] += *s;
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
    Ok(adj[..t.leaves].to_vec())
}

pub(crate) fn tape_owned(parameters: &Value, inputs: &Value) -> R<Value> {
    let Value::Record(fields) = parameters else {
        return trap("ad.tape-owned: expected scalar operations");
    };
    if fields.len() != 4 {
        return trap("ad.tape-owned: expected four scalar operations");
    }
    let mut count = 0;
    let mut tail = inputs;
    while let Value::Data(1, fields) = tail {
        if count == tape_limit() {
            return trap("autodiff: too many inputs");
        }
        count += 1;
        tail = &fields[1];
    }
    let base = tape_new(count as i64)?;
    let id = base >> 32;
    let mut tapes = TAPES.lock().unwrap();
    let slot = slot_of(&tapes, id)?;
    let t = &mut tapes[slot];
    t.owned = true;
    t.da = Vec::new();
    t.db = Vec::new();
    t.adj = Vec::new();
    let owner = OwnedTape {
        zero: fields[0].clone(),
        add: fields[1].clone(),
        mul: fields[2].clone(),
        inactive_zero: fields[3].clone(),
        da: vec![fields[0].clone(); t.leaves],
        db: vec![fields[0].clone(); t.leaves],
    };
    OWNED_TAPES.with(|owners| owners.borrow_mut().insert(id, owner));
    Ok(Value::I64(base))
}

pub(crate) fn push_owned(value: &Value) -> R<Value> {
    let Value::Record(fields) = value else {
        return trap("ad.push-owned: expected a tuple");
    };
    if fields.len() != 4 {
        return trap("ad.push-owned: expected four fields");
    }
    let (ra, rb) = (int(&fields[0]), int(&fields[2]));
    if ra < 0 && rb < 0 {
        return Ok(Value::I64(-1));
    }
    if ra >= 0 && rb >= 0 && ra >> 32 != rb >> 32 {
        return trap(MIXED);
    }
    let id = (if ra >= 0 { ra } else { rb }) >> 32;
    let mut tapes = TAPES.lock().unwrap();
    let slot = slot_of(&tapes, id)?;
    let t = &mut tapes[slot];
    if !t.owned {
        return trap(REPRESENTATION);
    }
    let idx = t.pa.len();
    if idx >= tape_limit() {
        return trap("autodiff: the tape is full");
    }
    for parent in [ra, rb] {
        if parent >= 0 && (parent & 0xffff_ffff) as usize >= idx {
            return trap(INVALID_NODE);
        }
    }
    OWNED_TAPES.with(|owners| -> R<()> {
        let mut owners = owners.borrow_mut();
        let Some(owner) = owners.get_mut(&id) else {
            return trap("autodiff: managed tape belongs to another task");
        };
        owner.da.push(fields[1].clone());
        owner.db.push(fields[3].clone());
        Ok(())
    })?;
    reserve_nodes(t, idx + 1);
    t.pa.push(if ra < 0 {
        -1
    } else {
        (ra & 0xffff_ffff) as i32
    });
    t.pb.push(if rb < 0 {
        -1
    } else {
        (rb & 0xffff_ffff) as i32
    });
    Ok(Value::I64((id << 32) | idx as i64))
}

pub(crate) fn backward_owned(
    base: &Value,
    outs: &Value,
    seeds: &Value,
    mut apply: impl FnMut(Value, Vec<Value>) -> R<Value>,
) -> R<Value> {
    let id = int(base) >> 32;
    let mut tapes = TAPES.lock().unwrap();
    let slot = slot_of(&tapes, id)?;
    if !tapes[slot].owned {
        return trap(REPRESENTATION);
    }
    let Some(owner) = OWNED_TAPES.with(|owners| owners.borrow_mut().remove(&id)) else {
        return trap("autodiff: managed tape belongs to another task");
    };
    let t = std::mem::take(&mut tapes[slot]);
    tapes[slot].gen = t.gen;
    drop(tapes);
    forget_scoped_tape(id);
    // Detached Rust owners survive reentrant callbacks and drop on every error.
    let mut adj = vec![owner.zero.clone(); t.pa.len()];
    let outs = outs.list_items();
    let seeds = seeds.list_items();
    if outs.len() != seeds.len() {
        return trap("autodiff: seed count differs from output count");
    }
    for (out, seed) in outs.iter().zip(seeds) {
        let out = int(out);
        if out < 0 {
            continue;
        }
        if out >> 32 != id {
            return trap(MIXED);
        }
        let node = (out & 0xffff_ffff) as usize;
        if node >= adj.len() {
            return trap(INVALID_NODE);
        }
        adj[node] = apply(owner.add.clone(), vec![seed, adj[node].clone()])?;
    }
    for i in (t.leaves..t.pa.len()).rev() {
        let a = adj[i].clone();
        if apply(owner.inactive_zero.clone(), vec![a.clone()])?.as_bool() {
            continue;
        }
        for (parent, weight) in [(t.pa[i], &owner.da[i]), (t.pb[i], &owner.db[i])] {
            if parent < 0 {
                continue;
            }
            let product = apply(owner.mul.clone(), vec![weight.clone(), a.clone()])?;
            adj[parent as usize] = apply(
                owner.add.clone(),
                vec![product, adj[parent as usize].clone()],
            )?;
        }
    }
    adj.truncate(t.leaves);
    Ok(Value::list(adj))
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
fn workspace_fits(depth: usize) -> bool {
    depth <= usize::MAX / CHUNK / std::mem::size_of::<f64>()
}

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
    if !workspace_fits(depth) {
        return trap("device: kernel too large");
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
    use std::ffi::{c_char, c_void, CString};
    use std::sync::OnceLock;

    type Ptr = *mut c_void;

    use crate::dylib::{Library, Scope};

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
        _library: Library,
    }

    /// The OpenCL library, the device chosen and its context and queue.
    struct Gpu {
        cl: Cl,
        device: Ptr,
        context: Ptr,
        queue: Ptr,
    }

    // Construction owns each completed stage before the next fallible call.
    // The successful cache intentionally lives for this interpreter process;
    // failed construction drops these owners before caching its diagnostic.
    impl Drop for Gpu {
        fn drop(&mut self) {
            unsafe {
                if !self.queue.is_null() {
                    (self.cl.finish)(self.queue);
                    (self.cl.release_queue)(self.queue);
                }
                if !self.context.is_null() {
                    (self.cl.release_context)(self.context);
                }
            }
            // Cl releases the library after these entry points are finished.
        }
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
            _ if cfg!(windows) => vec!["OpenCL.dll".into()],
            _ => vec!["libOpenCL.so.1".into(), "libOpenCL.so".into()],
        }
    }

    fn load() -> Result<Gpu, String> {
        let names = library_names();
        let library = names
            .iter()
            .find_map(|n| Library::open(std::path::Path::new(n), Scope::Local).ok())
            .ok_or_else(|| {
                format!(
                    "no OpenCL device: the OpenCL library ({}) could not be loaded",
                    names.join(", ")
                )
            })?;
        fn get<F: Copy>(h: &Library, name: &str) -> Result<F, String> {
            assert_eq!(std::mem::size_of::<F>(), std::mem::size_of::<Ptr>());
            let c = CString::new(name).unwrap();
            let p = unsafe { h.symbol(&c) }?;
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
            get_platforms: get(&library, "clGetPlatformIDs")?,
            get_devices: get(&library, "clGetDeviceIDs")?,
            device_info: get(&library, "clGetDeviceInfo")?,
            create_context: get(&library, "clCreateContext")?,
            create_queue: get(&library, "clCreateCommandQueue")?,
            program_with_source: get(&library, "clCreateProgramWithSource")?,
            build_program: get(&library, "clBuildProgram")?,
            build_info: get(&library, "clGetProgramBuildInfo")?,
            create_kernel: get(&library, "clCreateKernel")?,
            create_buffer: get(&library, "clCreateBuffer")?,
            set_arg: get(&library, "clSetKernelArg")?,
            enqueue: get(&library, "clEnqueueNDRangeKernel")?,
            read_buffer: get(&library, "clEnqueueReadBuffer")?,
            finish: get(&library, "clFinish")?,
            release_mem: get(&library, "clReleaseMemObject")?,
            release_kernel: get(&library, "clReleaseKernel")?,
            release_program: get(&library, "clReleaseProgram")?,
            release_queue: get(&library, "clReleaseCommandQueue")?,
            release_context: get(&library, "clReleaseContext")?,
            _library: library,
        };
        let device = unsafe { pick_device(&cl) }?;
        let mut gpu = Gpu {
            cl,
            device,
            context: std::ptr::null_mut(),
            queue: std::ptr::null_mut(),
        };
        let mut err = 0i32;
        gpu.context = unsafe {
            (gpu.cl.create_context)(
                std::ptr::null(),
                1,
                &device,
                None,
                std::ptr::null_mut(),
                &mut err,
            )
        };
        if gpu.context.is_null() || err != 0 {
            return Err(format!(
                "no OpenCL device: clCreateContext failed ({})",
                err
            ));
        }
        gpu.queue = unsafe { (gpu.cl.create_queue)(gpu.context, device, 0, &mut err) };
        if gpu.queue.is_null() || err != 0 {
            return Err(format!(
                "no OpenCL device: clCreateCommandQueue failed ({})",
                err
            ));
        }
        Ok(gpu)
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
            "matrix._valid-f64" => Value::bool(matrix_product_shape(a).is_some()),
            "matrix._mul-f64" => matrix_product(a)?,
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
                let count = int(&a[1]).max(0) as u64;
                let n = count as usize;
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
                    let limit =
                        (usize::MAX - std::mem::size_of::<u64>()) / std::mem::size_of::<u64>();
                    if count > limit as u64 {
                        return trap("array too large");
                    }
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

// Internal specialization primitives borrow immutable matrix storage.
// A 32-by-32 F64 tile is 8 KiB; three tiles have a 24-KiB payload.
// This fixed candidate is measured on each supported target before acceptance.
const MATRIX_TILE: usize = 32;
type MatrixProduct<'a> = (usize, usize, usize, &'a [Value], &'a [Value]);
fn matrix_product_shape(a: &[Value]) -> Option<MatrixProduct<'_>> {
    let (m, k, br, n) = (
        usize::try_from(int(&a[0])).ok()?,
        usize::try_from(int(&a[1])).ok()?,
        usize::try_from(int(&a[2])).ok()?,
        usize::try_from(int(&a[3])).ok()?,
    );
    if br != k {
        return None;
    }
    let (Value::Array(left), Value::Array(right)) = (&a[4], &a[5]) else {
        return None;
    };
    let limit = (usize::MAX - 8) / 8;
    let (ak, bk, out) = (m.checked_mul(k)?, k.checked_mul(n)?, m.checked_mul(n)?);
    if ak > limit || bk > limit || out > limit || left.len() != ak || right.len() != bk {
        return None;
    }
    Some((m, k, n, left, right))
}
fn matrix_product(a: &[Value]) -> R<Value> {
    // Only the compiler emits this primitive, after validating these fields.
    let (m, k, n) = (
        int(&a[0]) as usize,
        int(&a[1]) as usize,
        int(&a[2]) as usize,
    );
    let (Value::Array(left), Value::Array(right)) = (&a[3], &a[4]) else {
        unreachable!("typed matrix storage");
    };
    let mut result = vec![0.0f64; m * n];
    if n != 0 && k != 0 {
        for ib in (0..m).step_by(MATRIX_TILE) {
            for kb in (0..k).step_by(MATRIX_TILE) {
                for jb in (0..n).step_by(MATRIX_TILE) {
                    for i in ib..(ib + MATRIX_TILE).min(m) {
                        for q in kb..(kb + MATRIX_TILE).min(k) {
                            let x = left[i * k + q].as_f64().unwrap();
                            for j in jb..(jb + MATRIX_TILE).min(n) {
                                let product = x * right[q * n + j].as_f64().unwrap();
                                let prior = result[i * n + j];
                                result[i * n + j] = product + prior;
                            }
                        }
                    }
                }
            }
        }
    }
    Ok(f64_array(&result))
}

#[cfg(test)]
mod tape_validation_tests {
    use super::*;
    static TAPE_TEST_LOCK: Mutex<()> = Mutex::new(());

    fn expect_trap<T>(result: R<T>, expected: &str) {
        match result {
            Err(Ctl::Trap(message)) => assert_eq!(message, expected),
            _ => panic!("expected autodiff trap: {expected}"),
        }
    }

    #[test]
    fn invalid_nodes_preserve_push_state_and_consume_backward_tapes() {
        let _serial = TAPE_TEST_LOCK.lock().unwrap();
        let base = tape_new(2).unwrap();
        let other = tape_new(1).unwrap();
        for invalid in [base + 2, base | 0xffff_ffff] {
            expect_trap(push(invalid, 1.0, -1, 0.0), INVALID_NODE);
            expect_trap(push(base, 1.0, invalid, 1.0), INVALID_NODE);
            expect_trap(push(-1, 0.0, invalid, 1.0), INVALID_NODE);
        }
        // Mixing computations retains precedence over checking node indices.
        expect_trap(push(base + 2, 1.0, other, 1.0), MIXED);
        let node = push(base, 4.0, base + 1, 5.0).unwrap();
        assert_eq!(node, base + 2);
        assert_eq!(
            backward(base, &[node, base + 1], &[2.0, 3.0]).unwrap(),
            [8.0, 13.0]
        );
        expect_trap(push(base, 1.0, -1, 0.0), USED_OUTSIDE);
        expect_trap(backward(other, &[other + 1], &[1.0]), INVALID_NODE);
        expect_trap(backward(other, &[], &[]), USED_OUTSIDE);

        let base = tape_new(1).unwrap();
        let other = tape_new(1).unwrap();
        expect_trap(backward(base, &[other | 0xffff_ffff], &[1.0]), MIXED);
        expect_trap(backward(base, &[], &[]), USED_OUTSIDE);
        assert_eq!(backward(other, &[other], &[3.0]).unwrap(), [3.0]);

        // Zip semantics ignore unpaired outputs and constant sentinels.
        let base = tape_new(0).unwrap();
        assert!(backward(base, &[-1, base | 0xffff_ffff], &[1.0])
            .unwrap()
            .is_empty());
        assert_eq!(push(-1, 1.0, -2, 2.0).unwrap(), -1);

        // Exhaust a generation without resetting its identity to an old token.
        let slot = ((base >> 32) & 0xffff) as usize - 1;
        TAPES.lock().unwrap()[slot].gen = 32766;
        let last = tape_new(0).unwrap();
        assert_eq!((last >> 32) & 0xffff, (base >> 32) & 0xffff);
        assert_eq!(last >> 48, 32767);
        assert!(backward(last, &[], &[]).unwrap().is_empty());
        let next = tape_new(0).unwrap();
        assert_ne!((next >> 32) & 0xffff, (last >> 32) & 0xffff);
        expect_trap(backward(last, &[], &[]), USED_OUTSIDE);
        expect_trap(backward(base, &[], &[]), USED_OUTSIDE);
        assert!(backward(next, &[], &[]).unwrap().is_empty());
    }
    #[test]
    fn scoped_callbacks_release_only_their_live_tapes() {
        let _serial = TAPE_TEST_LOCK.lock().unwrap();
        let mut base = 0;
        with_tape_scope(|| {
            base = tape_new(2)?;
            Ok(())
        })
        .unwrap();
        expect_trap(backward(base, &[], &[]), USED_OUTSIDE);
        expect_trap(
            with_tape_scope(|| {
                base = tape_new(2)?;
                trap::<()>("gradient callback control")
            }),
            "gradient callback control",
        );
        expect_trap(backward(base, &[], &[]), USED_OUTSIDE);
        with_tape_scope(|| {
            let outer = tape_new(1)?;
            let inner = with_tape_scope(|| tape_new(1))?;
            expect_trap(backward(inner, &[], &[]), USED_OUTSIDE);
            assert_eq!(backward(outer, &[outer], &[2.0])?, [2.0]);
            for _ in 0..64 {
                let current = tape_new(1)?;
                TAPE_SCOPES.with(|scopes| assert_eq!(scopes.borrow().last().unwrap().len(), 1));
                backward(current, &[], &[])?;
                TAPE_SCOPES.with(|scopes| assert!(scopes.borrow().last().unwrap().is_empty()));
            }
            Ok(())
        })
        .unwrap();
        TAPE_SCOPES.with(|scopes| assert!(scopes.borrow().is_empty()));
    }
    #[test]
    fn workspace_reuse_clears_adjoint_and_preserves_token_lifetimes() {
        let _serial = TAPE_TEST_LOCK.lock().unwrap();
        if !workspace_enabled() {
            return;
        }
        *TAPE_WORKSPACE.lock().unwrap() = None;
        let first = tape_new(129).unwrap();
        let node = push(first, 4.0, first + 1, 5.0).unwrap();
        assert_eq!(backward(first, &[node], &[2.0]).unwrap()[..2], [8.0, 10.0]);
        let pointers = {
            let pool = TAPE_WORKSPACE.lock().unwrap();
            let t = pool.as_ref().unwrap();
            assert!(t.workspace_bytes() <= TAPE_WORKSPACE_BUDGET);
            (
                t.pa.as_ptr(),
                t.pb.as_ptr(),
                t.da.as_ptr(),
                t.db.as_ptr(),
                t.adj.as_ptr(),
            )
        };
        let second = tape_new(129).unwrap();
        assert_ne!(first, second);
        let slot = ((second >> 32) & 0xffff) as usize - 1;
        {
            let tapes = TAPES.lock().unwrap();
            let t = &tapes[slot];
            assert_eq!(
                (
                    t.pa.as_ptr(),
                    t.pb.as_ptr(),
                    t.da.as_ptr(),
                    t.db.as_ptr(),
                    t.adj.as_ptr()
                ),
                pointers
            );
        }
        assert_eq!(
            backward(second, &[second], &[3.0]).unwrap()[..2],
            [3.0, 0.0]
        );
        expect_trap(backward(first, &[], &[]), USED_OUTSIDE);
        let failed = tape_new(129).unwrap();
        expect_trap(backward(failed, &[failed + 129], &[1.0]), INVALID_NODE);
        assert!(TAPE_WORKSPACE.lock().unwrap().is_some());
        let current = tape_new(129).unwrap();
        assert!(backward(current, &[], &[])
            .unwrap()
            .iter()
            .all(|v| v.to_bits() == 0));
        *TAPE_WORKSPACE.lock().unwrap() = None;
        let large = tape_new(32769).unwrap();
        backward(large, &[], &[]).unwrap();
        assert!(TAPE_WORKSPACE.lock().unwrap().is_none());
    }
}
