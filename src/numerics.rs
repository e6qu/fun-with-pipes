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
    // Operation metadata starts at node `leaves`; inputs have no parents.
    pa: Vec<i32>,
    pb: Vec<i32>,
    da: Vec<f64>,
    db: Vec<f64>,
    adj: Vec<f64>,
    owned: bool,
}

struct OwnedTape {
    fiber: u64,
    zero: Value,
    add: Value,
    mul: Value,
    inactive_zero: Value,
    da: Vec<Value>,
    db: Vec<Value>,
}

// Native interpreter tasks have separate threads; WASM tasks share a thread
// and must additionally match their fiber. Numeric IDs remain globally unique.
fn tape_fiber() -> u64 {
    #[cfg(target_family = "wasm")]
    {
        crate::fiber::identity()
    }
    #[cfg(not(target_family = "wasm"))]
    {
        0
    }
}
thread_local! {
    static OWNED_TAPES: RefCell<BTreeMap<i64, OwnedTape>> = const { RefCell::new(BTreeMap::new()) };
}

struct TapeRegistry {
    slots: Vec<Tape>,
    // Every earlier slot is live or permanently generation-exhausted.
    next_slot: usize,
}

impl TapeRegistry {
    fn take(&mut self, slot: usize) -> Tape {
        let tape = std::mem::take(&mut self.slots[slot]);
        self.slots[slot].gen = tape.gen;
        if tape.gen < 32767 {
            self.next_slot = self.next_slot.min(slot);
        }
        tape
    }
}

static TAPES: Mutex<TapeRegistry> = Mutex::new(TapeRegistry {
    slots: Vec::new(),
    next_slot: 0,
});

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
    if tape.owned
        || !workspace_enabled()
        || tape.workspace_bytes() == 0
        || tape.workspace_bytes() > TAPE_WORKSPACE_BUDGET
    {
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
            if let Ok(slot) = slot_of(&tapes.slots, base >> 32) {
                let tape = tapes.take(slot);
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
fn tape_new(n: i64, owned: bool) -> R<i64> {
    if !(0..=tape_limit() as i64).contains(&n) {
        return trap("autodiff: too many inputs");
    }
    let mut tapes = TAPES.lock().unwrap();
    let slot = match tapes
        .slots
        .iter()
        .enumerate()
        .skip(tapes.next_slot)
        .find(|(_, t)| !t.live && t.gen < 32767)
    {
        Some((s, _)) => s,
        None => {
            if tapes.slots.len() >= 0xffff {
                return trap("autodiff: too many grad computations at once");
            }
            tapes.slots.push(Tape::default());
            tapes.slots.len() - 1
        }
    };
    let gen = tapes.slots[slot].gen + 1;
    let mut workspace = if !owned && workspace_enabled() {
        TAPE_WORKSPACE.lock().unwrap().take().unwrap_or_default()
    } else {
        Tape::default()
    };
    workspace.owned = owned;
    workspace.gen = gen;
    workspace.live = true;
    workspace.leaves = n as usize;
    tapes.slots[slot] = workspace;
    tapes.next_slot = slot + 1;
    let t = &tapes.slots[slot];
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
    let slot = slot_of(&tapes.slots, id)?;
    let t = &mut tapes.slots[slot];
    if t.owned {
        return trap(REPRESENTATION);
    }
    let idx = t.leaves + t.pa.len();
    if idx >= tape_limit() {
        return trap("autodiff: the tape is full");
    }
    if (ra & 0xffff_ffff) as usize >= idx || (rb >= 0 && (rb & 0xffff_ffff) as usize >= idx) {
        return trap(INVALID_NODE);
    }
    reserve_nodes(t, t.pa.len() + 1);
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
    let slot = slot_of(&tapes.slots, id)?;
    if tapes.slots[slot].owned {
        return trap(REPRESENTATION);
    }
    let t = tapes.take(slot);
    drop(tapes);
    forget_scoped_tape(id);
    let mut owner = TapeOwner(t);
    let t = &mut owner.0;
    // Parents precede children, so no node after the last seeded output can
    // contribute. Preserve all input adjoints and output validation order.
    let mut active = t.leaves;
    for o in outs.iter().take(seeds.len()) {
        if *o < 0 {
            continue;
        }
        if (*o >> 32) != id {
            return trap(MIXED);
        }
        let node = (*o & 0xffff_ffff) as usize;
        if node >= t.leaves + t.pa.len() {
            return trap(INVALID_NODE);
        }
        active = active.max(node + 1);
    }
    if t.adj.capacity() < active {
        let capacity = active
            .max(t.adj.capacity().saturating_mul(2))
            .min(tape_limit());
        t.adj.reserve_exact(capacity - t.adj.len());
    }
    t.adj.resize(active, 0.0);
    t.adj.fill(0.0);
    let adj = &mut t.adj;
    for (o, s) in outs.iter().zip(seeds.iter()) {
        if *o < 0 {
            continue;
        }
        let node = (*o & 0xffff_ffff) as usize;
        adj[node] += *s;
    }
    for i in (t.leaves..active).rev() {
        let a = adj[i];
        if a == 0.0 {
            continue;
        }
        let op = i - t.leaves;
        if t.pa[op] >= 0 {
            adj[t.pa[op] as usize] += a * t.da[op];
        }
        if t.pb[op] >= 0 {
            adj[t.pb[op] as usize] += a * t.db[op];
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
    let base = tape_new(count as i64, true)?;
    let id = base >> 32;
    let owner = OwnedTape {
        fiber: tape_fiber(),
        zero: fields[0].clone(),
        add: fields[1].clone(),
        mul: fields[2].clone(),
        inactive_zero: fields[3].clone(),
        da: Vec::new(),
        db: Vec::new(),
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
    let slot = slot_of(&tapes.slots, id)?;
    let t = &mut tapes.slots[slot];
    if !t.owned {
        return trap(REPRESENTATION);
    }
    let idx = t.leaves + t.pa.len();
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
        if owner.fiber != tape_fiber() {
            return trap("autodiff: managed tape belongs to another task");
        }
        owner.da.push(fields[1].clone());
        owner.db.push(fields[3].clone());
        Ok(())
    })?;
    reserve_nodes(t, t.pa.len() + 1);
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
    let slot = slot_of(&tapes.slots, id)?;
    if !tapes.slots[slot].owned {
        return trap(REPRESENTATION);
    }
    let Some(owner) = OWNED_TAPES.with(|owners| {
        let mut owners = owners.borrow_mut();
        if owners
            .get(&id)
            .is_some_and(|owner| owner.fiber == tape_fiber())
        {
            owners.remove(&id)
        } else {
            None
        }
    }) else {
        return trap("autodiff: managed tape belongs to another task");
    };
    let t = tapes.take(slot);
    drop(tapes);
    forget_scoped_tape(id);
    // Detached Rust owners survive reentrant callbacks and drop on every error.
    let mut adj = vec![owner.zero.clone(); t.leaves + t.pa.len()];
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
    for i in (t.leaves..t.leaves + t.pa.len()).rev() {
        let a = adj[i].clone();
        if apply(owner.inactive_zero.clone(), vec![a.clone()])?.as_bool() {
            continue;
        }
        let op = i - t.leaves;
        for (parent, weight) in [(t.pa[op], &owner.da[op]), (t.pb[op], &owner.db[op])] {
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

fn check(code: &[i64], nconsts: usize, inputs: &[Vec<f64>], n: u64) -> R<usize> {
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
        if x.len() as u64 != n {
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
            let end = start + RBLOCK.min(n - start);
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
            "ad.tape" => Value::I64(tape_new(int(&a[0]), false)?),
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
                let threads = int(&a[0]);
                if !(1..=256).contains(&threads) {
                    return trap("device: thread count must be between 1 and 256");
                }
                let threads = threads as usize;
                let count = int(&a[1]).max(0) as u64;
                let n = count as usize;
                let code = ints(&a[2]);
                let consts = f64s(&a[3]);
                let ins = inputs(&a[4]);
                let depth = check(&code, consts.len(), &ins, count)?;
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
                    if n as u64 != count {
                        return trap("device: kernel too large");
                    }
                    Value::F64(sum(threads, n, &k))
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
mod kernel_boundary_tests {
    use super::*;

    #[test]
    fn final_reduction_block_does_not_wrap_at_the_address_limit() {
        let kernel = Kernel {
            code: &[OP_CONST],
            consts: &[2.5],
            inputs: &[],
            depth: 1,
        };
        let mut sums = [0.0];
        kernel.sum_blocks(usize::MAX, usize::MAX / RBLOCK, &mut sums);
        assert_eq!(sums[0], (RBLOCK - 1) as f64 * 2.5);
    }
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
    fn registry_cursor_preserves_lowest_slot_reuse_and_failed_backward() {
        let _serial = TAPE_TEST_LOCK.lock().unwrap();
        let slot = |base: i64| ((base >> 32) & 0xffff) as usize - 1;
        with_tape_scope(|| {
            let mut bases = Vec::new();
            for _ in 0..257 {
                let expected = {
                    let tapes = TAPES.lock().unwrap();
                    assert!(tapes.slots[..tapes.next_slot]
                        .iter()
                        .all(|t| t.live || t.gen >= 32767));
                    tapes
                        .slots
                        .iter()
                        .position(|t| !t.live && t.gen < 32767)
                        .unwrap_or(tapes.slots.len())
                };
                let base = tape_new(0, false)?;
                assert_eq!(slot(base), expected);
                assert_eq!(TAPES.lock().unwrap().next_slot, expected + 1);
                bases.push(base);
            }
            backward(bases[200], &[], &[])?;
            backward(bases[4], &[], &[])?;
            let low = tape_new(0, false)?;
            let high = tape_new(0, false)?;
            assert_eq!(slot(low), slot(bases[4]));
            assert_eq!(slot(high), slot(bases[200]));
            assert_eq!(low >> 48, (bases[4] >> 48) + 1);
            expect_trap(backward(low, &[low], &[1.0]), INVALID_NODE);
            expect_trap(backward(low, &[], &[]), USED_OUTSIDE);
            assert_eq!(slot(tape_new(0, false)?), slot(low));
            let parameters = Value::tuple(vec![Value::F64(0.0); 4]);
            let empty = Value::list(vec![]);
            let managed = tape_owned(&parameters, &empty)?;
            let index = slot(int(&managed));
            backward_owned(&managed, &empty, &empty, |_, _| {
                panic!("empty backward must not call scalar operations")
            })?;
            assert_eq!(slot(tape_new(0, false)?), index);
            Ok(())
        })
        .unwrap();
        let tapes = TAPES.lock().unwrap();
        assert!(tapes.slots[..tapes.next_slot]
            .iter()
            .all(|t| t.live || t.gen >= 32767));
        assert_eq!(
            tapes.next_slot,
            tapes
                .slots
                .iter()
                .position(|t| !t.live && t.gen < 32767)
                .unwrap_or(tapes.slots.len())
        );
    }

    #[test]
    fn managed_and_empty_tapes_preserve_the_numeric_workspace() {
        let _serial = TAPE_TEST_LOCK.lock().unwrap();
        *TAPE_WORKSPACE.lock().unwrap() = None;
        let empty = tape_new(0, false).unwrap();
        let warm = tape_new(2, false).unwrap();
        let output = push(warm, 2.0, warm + 1, 3.0).unwrap();
        assert_eq!(backward(warm, &[output], &[1.0]).unwrap(), [2.0, 3.0]);
        let pointer = TAPE_WORKSPACE.lock().unwrap().as_ref().unwrap().pa.as_ptr();
        with_tape_scope(|| {
            // Callbacks are retained but not invoked by creation or scope exit.
            let parameters = Value::tuple(vec![Value::F64(0.0); 4]);
            let inputs = Value::list(vec![Value::F64(1.0)]);
            let base = int(&tape_owned(&parameters, &inputs)?);
            let tapes = TAPES.lock().unwrap();
            let managed = &tapes.slots[slot_of(&tapes.slots, base >> 32)?];
            assert!(managed.owned);
            assert_eq!(managed.workspace_bytes(), 0);
            assert_eq!(
                TAPE_WORKSPACE.lock().unwrap().as_ref().unwrap().pa.as_ptr(),
                pointer
            );
            Ok(())
        })
        .unwrap();
        assert!(backward(empty, &[], &[]).unwrap().is_empty());
        assert_eq!(
            TAPE_WORKSPACE.lock().unwrap().as_ref().unwrap().pa.as_ptr(),
            pointer
        );
        let reused = tape_new(2, false).unwrap();
        assert!(TAPE_WORKSPACE.lock().unwrap().is_none());
        {
            let tapes = TAPES.lock().unwrap();
            assert_eq!(
                tapes.slots[slot_of(&tapes.slots, reused >> 32).unwrap()]
                    .pa
                    .as_ptr(),
                pointer
            );
        }
        assert_eq!(backward(reused, &[reused], &[1.0]).unwrap(), [1.0, 0.0]);
        *TAPE_WORKSPACE.lock().unwrap() = None;
    }

    #[test]
    fn input_nodes_need_no_operation_storage_and_keep_their_indices() {
        let _serial = TAPE_TEST_LOCK.lock().unwrap();
        *TAPE_WORKSPACE.lock().unwrap() = None;
        for leaves in [1, 65, 4096] {
            let base = tape_new(leaves, false).unwrap();
            {
                let tapes = TAPES.lock().unwrap();
                let tape = &tapes.slots[slot_of(&tapes.slots, base >> 32).unwrap()];
                assert_eq!(tape.workspace_bytes(), 0);
                assert!(tape.pa.is_empty() && tape.pb.is_empty());
            }
            let node = push(base, 2.0, base + leaves - 1, 3.0).unwrap();
            assert_eq!(node, base + leaves);
            let last = push(node, 4.0, -1, f64::NAN).unwrap();
            assert_eq!(last, base + leaves + 1);
            {
                let tapes = TAPES.lock().unwrap();
                let tape = &tapes.slots[slot_of(&tapes.slots, base >> 32).unwrap()];
                assert_eq!(tape.pa, [0, leaves as i32]);
                assert_eq!(tape.pb, [leaves as i32 - 1, -1]);
                assert!(tape.workspace_bytes() <= 64 * 24);
            }
            let gradient = backward(base, &[last], &[1.0]).unwrap();
            let mut expected = vec![0.0; leaves as usize];
            expected[0] += 8.0;
            expected[leaves as usize - 1] += 12.0;
            assert_eq!(gradient, expected);
            *TAPE_WORKSPACE.lock().unwrap() = None;
        }
        // The token/byte limit still applies before any storage is requested.
        expect_trap(
            tape_new(tape_limit() as i64 + 1, false),
            "autodiff: too many inputs",
        );
        with_tape_scope(|| {
            let base = tape_new(tape_limit() as i64, false)?;
            expect_trap(push(base, 1.0, -1, 0.0), "autodiff: the tape is full");
            Ok(())
        })
        .unwrap();
        *TAPE_WORKSPACE.lock().unwrap() = None;
    }

    #[test]
    fn backward_ignores_unseeded_suffix_and_preserves_input_and_seed_order() {
        let _serial = TAPE_TEST_LOCK.lock().unwrap();
        *TAPE_WORKSPACE.lock().unwrap() = None;
        let base = tape_new(3, false).unwrap();
        let early = push(base, 2.0, base + 1, 3.0).unwrap();
        let mut tail = early;
        for _ in 0..4096 {
            tail = push(tail, f64::NAN, -1, 0.0).unwrap();
        }
        assert_eq!(
            backward(base, &[early, base, early, -1], &[2.0, 7.0, 1.0, f64::NAN]).unwrap(),
            [13.0, 9.0, 0.0]
        );
        if workspace_enabled() {
            let pool = TAPE_WORKSPACE.lock().unwrap();
            let cached = pool.as_ref().unwrap();
            assert_eq!(cached.adj.capacity(), 4);
            assert!(cached.pa.capacity() >= 4097);
        }
        // Reusing a larger workspace must clear the retained input prefix.
        let base = tape_new(3, false).unwrap();
        let result = backward(base, &[-1], &[f64::NAN]).unwrap();
        assert!(result.iter().all(|value| value.to_bits() == 0));
        if workspace_enabled() {
            let mut previous = 4;
            let mut growths = 0;
            for leaves in 5..=33 {
                let base = tape_new(leaves, false).unwrap();
                assert!(backward(base, &[], &[]).unwrap().iter().all(|v| *v == 0.0));
                let pool = TAPE_WORKSPACE.lock().unwrap();
                let capacity = pool.as_ref().unwrap().adj.capacity();
                assert!(capacity >= leaves as usize && capacity < 2 * leaves as usize);
                growths += usize::from(capacity != previous);
                previous = capacity;
            }
            assert_eq!(growths, 4);
        }
        let base = tape_new(1, false).unwrap();
        assert_eq!(
            backward(base, &[base, base, base], &[1e16, 1.0, -1e16]).unwrap(),
            [0.0]
        );
        let base = tape_new(0, false).unwrap();
        assert!(backward(base, &[], &[]).unwrap().is_empty());
        // Earlier invalid indices keep precedence over later foreign tapes.
        let base = tape_new(1, false).unwrap();
        let other = tape_new(1, false).unwrap();
        expect_trap(
            backward(base, &[base + 1, other], &[1.0, 1.0]),
            INVALID_NODE,
        );
        assert_eq!(backward(other, &[other], &[2.0]).unwrap(), [2.0]);
        *TAPE_WORKSPACE.lock().unwrap() = None;
    }

    #[test]
    fn invalid_nodes_preserve_push_state_and_consume_backward_tapes() {
        let _serial = TAPE_TEST_LOCK.lock().unwrap();
        let base = tape_new(2, false).unwrap();
        let other = tape_new(1, false).unwrap();
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

        let base = tape_new(1, false).unwrap();
        let other = tape_new(1, false).unwrap();
        expect_trap(backward(base, &[other | 0xffff_ffff], &[1.0]), MIXED);
        expect_trap(backward(base, &[], &[]), USED_OUTSIDE);
        assert_eq!(backward(other, &[other], &[3.0]).unwrap(), [3.0]);

        // Zip semantics ignore unpaired outputs and constant sentinels.
        let base = tape_new(0, false).unwrap();
        assert!(backward(base, &[-1, base | 0xffff_ffff], &[1.0])
            .unwrap()
            .is_empty());
        assert_eq!(push(-1, 1.0, -2, 2.0).unwrap(), -1);

        // Exhaust a generation without resetting its identity to an old token.
        let slot = ((base >> 32) & 0xffff) as usize - 1;
        TAPES.lock().unwrap().slots[slot].gen = 32766;
        let last = tape_new(0, false).unwrap();
        assert_eq!((last >> 32) & 0xffff, (base >> 32) & 0xffff);
        assert_eq!(last >> 48, 32767);
        assert!(backward(last, &[], &[]).unwrap().is_empty());
        let next = tape_new(0, false).unwrap();
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
            base = tape_new(2, false)?;
            Ok(())
        })
        .unwrap();
        expect_trap(backward(base, &[], &[]), USED_OUTSIDE);
        expect_trap(
            with_tape_scope(|| {
                base = tape_new(2, false)?;
                trap::<()>("gradient callback control")
            }),
            "gradient callback control",
        );
        expect_trap(backward(base, &[], &[]), USED_OUTSIDE);
        with_tape_scope(|| {
            let outer = tape_new(1, false)?;
            let inner = with_tape_scope(|| tape_new(1, false))?;
            expect_trap(backward(inner, &[], &[]), USED_OUTSIDE);
            assert_eq!(backward(outer, &[outer], &[2.0])?, [2.0]);
            for _ in 0..64 {
                let current = tape_new(1, false)?;
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
        let first = tape_new(129, false).unwrap();
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
        let second = tape_new(129, false).unwrap();
        assert_ne!(first, second);
        let slot = ((second >> 32) & 0xffff) as usize - 1;
        {
            let tapes = TAPES.lock().unwrap();
            let t = &tapes.slots[slot];
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
        let failed = tape_new(129, false).unwrap();
        expect_trap(backward(failed, &[failed + 129], &[1.0]), INVALID_NODE);
        assert!(TAPE_WORKSPACE.lock().unwrap().is_some());
        let current = tape_new(129, false).unwrap();
        assert!(backward(current, &[], &[])
            .unwrap()
            .iter()
            .all(|v| v.to_bits() == 0));
        *TAPE_WORKSPACE.lock().unwrap() = None;
        let large = tape_new((TAPE_WORKSPACE_BUDGET / 8 + 1) as i64, false).unwrap();
        backward(large, &[], &[]).unwrap();
        assert!(TAPE_WORKSPACE.lock().unwrap().is_none());
    }
}
