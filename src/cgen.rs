//! C code generation from the monomorphic IR. The output is a single C
//! translation unit containing the runtime and the program; it is compiled
//! with the system C compiler into a self-contained native executable.

use std::collections::HashMap;
use std::fmt::Write;

use crate::ir::*;
use crate::value::Value;

const RUNTIME: &[&str] = &[
    include_str!("../runtime/fwp_rt.c"),
    include_str!("../runtime/fwp_rt_gc.c"),
    include_str!("../runtime/fwp_rt_ops.c"),
    include_str!("../runtime/fwp_rt_num.c"),
    include_str!("../runtime/fwp_rt_prims.c"),
    include_str!("../runtime/fwp_rt_task.c"),
    include_str!("../runtime/fwp_rt_sys.c"),
    include_str!("../runtime/fwp_rt_json.c"),
    include_str!("../runtime/fwp_rt_web.c"),
    include_str!("../runtime/fwp_rt_pipe.c"),
    include_str!("../runtime/fwp_rt_exec.c"),
    include_str!("../runtime/fwp_rt_kernel.c"),
];

/// Static memory (`fwp build --memory static`): the sizes of what is mapped
/// at startup, in bytes (stacks per task).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct StaticMemory {
    pub heap: u64,
    pub pool: u64,
    pub stack: u64,
    pub tasks: u64,
    pub task_stack: u64,
    pub threads: u64,
}

impl Default for StaticMemory {
    fn default() -> StaticMemory {
        StaticMemory {
            heap: 64 << 20,
            pool: 32 << 20,
            stack: 16 << 20,
            tasks: 64,
            task_stack: 1 << 20,
            threads: 8,
        }
    }
}

static STATIC_MEMORY: std::sync::Mutex<Option<StaticMemory>> = std::sync::Mutex::new(None);

/// Build the native executables generated from now on with static memory
/// (or, with `None`, the collector's growing heap).
pub fn set_static_memory(m: Option<StaticMemory>) {
    *STATIC_MEMORY.lock().unwrap() = m;
}

/// Options of native executables beyond the C source: linked statically
/// (`fwp build --static`), and the phase of a profile-guided build.
#[derive(Clone, Debug, Default)]
pub struct NativeOptions {
    pub static_link: bool,
    pub pgo: Option<(Pgo, std::path::PathBuf)>,
    /// Another system to build for (`fwp build --target`), as a GNU
    /// triple such as `aarch64-linux-gnu`.
    pub cross: Option<String>,
}

/// The 64-bit little-endian architectures the runtime is written for.
const CROSS_ARCHES: &[&str] = &["x86_64", "aarch64", "riscv64", "powerpc64le", "loongarch64"];

/// A cross target given as `<arch>-linux`, `<arch>-linux-gnu` or Rust's
/// `<arch>-unknown-linux-gnu`, as the GNU triple of its C toolchain; or
/// `<arch>-linux-musl` (x86-64 and AArch64, where the runtime switches
/// tasks itself, as musl has no `makecontext`).
pub fn parse_cross(t: &str) -> Result<String, String> {
    let parts: Vec<&str> = t.split('-').collect();
    let (arch, rest) = match parts.as_slice() {
        [a, rest @ ..] => (*a, rest),
        _ => return Err(format!("unknown target `{}`", t)),
    };
    let arch = match arch {
        "arm64" => "aarch64",
        "amd64" => "x86_64",
        "ppc64le" => "powerpc64le",
        a => a,
    };
    let rest: Vec<&str> = rest
        .iter()
        .copied()
        .filter(|p| *p != "unknown" && *p != "pc")
        .collect();
    if rest.as_slice() == ["linux", "musl"] {
        if !matches!(arch, "x86_64" | "aarch64") {
            return Err(format!(
                "cannot build for `{}`: with musl, the runtime switches tasks itself, \
                 which it does on x86_64 and aarch64",
                t
            ));
        }
        return Ok(format!("{}-linux-musl", arch));
    }
    let os_ok = matches!(rest.as_slice(), ["linux"] | ["linux", "gnu"]);
    if !os_ok {
        let what = if rest.first().is_some_and(|o| *o == "linux") {
            "the runtime needs glibc or musl"
        } else {
            "cross targets must name Linux; on macOS use --target native"
        };
        return Err(format!("cannot build for `{}`: {}", t, what));
    }
    if !CROSS_ARCHES.contains(&arch) {
        return Err(format!(
            "cannot build for `{}`: the runtime needs a 64-bit little-endian architecture ({})",
            t,
            CROSS_ARCHES.join(", ")
        ));
    }
    Ok(format!("{}-linux-gnu", arch))
}

/// The architecture native code is built for: the cross target's, or the
/// host's.
fn target_arch() -> String {
    match native_options().cross {
        Some(t) => t.split('-').next().unwrap_or_default().to_string(),
        None => std::env::consts::ARCH.to_string(),
    }
}

/// Cross targets currently name Linux systems; otherwise use the host.
pub fn native_is_macos() -> bool {
    native_options().cross.is_none() && cfg!(target_os = "macos")
}

pub fn shared_library_extension() -> &'static str {
    if native_is_macos() {
        "dylib"
    } else {
        "so"
    }
}

pub fn shared_library_flag() -> &'static str {
    if native_is_macos() {
        "-dynamiclib"
    } else {
        "-shared"
    }
}

/// Whether `prog` is a program on `PATH`.
fn on_path(prog: &str) -> bool {
    std::env::var_os("PATH")
        .is_some_and(|p| std::env::split_paths(&p).any(|d| d.join(prog).is_file()))
}

/// The C compiler for native code, with the arguments that come first: `CC`
/// (or `cc`) for the host; for a cross target, `FWP_CC_<triple>` (with
/// `_` for `-`, and arguments after spaces), else the first found of
/// `<triple>-gcc`, `clang --target=<triple>` (with the target's sysroot
/// in `/usr/<triple>`), `musl-gcc` (musl for the host's architecture) and
/// `zig cc -target <triple>`.
pub fn c_compiler() -> Result<(String, Vec<String>), String> {
    let Some(t) = native_options().cross else {
        return Ok((crate::aot::cc(), vec![]));
    };
    let var = format!("FWP_CC_{}", t.replace('-', "_"));
    if let Ok(v) = std::env::var(&var) {
        let mut w = v.split_whitespace().map(String::from);
        if let Some(cc) = w.next() {
            return Ok((cc, w.collect()));
        }
    }
    let gcc = format!("{}-gcc", t);
    if on_path(&gcc) {
        return Ok((gcc, vec![]));
    }
    if on_path("clang") && std::path::Path::new("/usr").join(&t).is_dir() {
        return Ok(("clang".into(), vec![format!("--target={}", t)]));
    }
    let arch = t.split('-').next().unwrap_or_default();
    let musl = t.ends_with("-musl");
    if musl && arch == std::env::consts::ARCH && on_path("musl-gcc") {
        return Ok(("musl-gcc".into(), vec![]));
    }
    if on_path("zig") {
        return Ok(("zig".into(), vec!["cc".into(), "-target".into(), t.clone()]));
    }
    if musl {
        return Err(format!(
            "no C compiler for `{t}`: install musl-gcc (Debian and Ubuntu: musl-tools) \
             for the host's architecture, a `{t}-gcc`, or zig, or name one with {var}"
        ));
    }
    Err(format!(
        "no C compiler for `{t}`: install one (Debian and Ubuntu: gcc-{deb}-linux-gnu), \
         or zig, or name one with {var}",
        deb = arch.replace('_', "-"),
    ))
}

/// A command running the C compiler.
fn cc_command(cc: &(String, Vec<String>)) -> std::process::Command {
    let mut c = std::process::Command::new(&cc.0);
    c.args(&cc.1);
    // Apply one explicit OpenSSL prefix to headers, linking and loading.
    // Do not let a host prefix contaminate Linux cross builds.
    if native_options().cross.is_none() {
        if let Some(prefix) = std::env::var_os("FWP_OPENSSL_DIR") {
            let prefix = std::path::PathBuf::from(prefix);
            c.arg("-I").arg(prefix.join("include"));
            c.arg("-L").arg(prefix.join("lib"));
            c.arg(format!("-Wl,-rpath,{}", prefix.join("lib").display()));
        }
    }
    c
}

/// The archiver for static libraries: `AR`, or for a cross target
/// `<triple>-ar` (else `llvm-ar`), or `ar`.
fn archiver() -> String {
    if let Ok(a) = std::env::var("AR") {
        return a;
    }
    if let Some(t) = native_options().cross {
        let ar = format!("{}-ar", t);
        if on_path(&ar) {
            return ar;
        }
        if on_path("llvm-ar") {
            return "llvm-ar".into();
        }
    }
    "ar".into()
}

/// The two compiles of `fwp build --pgo`: instrumented, then using the
/// profile its training run wrote to the directory.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Pgo {
    Generate,
    Use,
}

static NATIVE_OPTIONS: std::sync::Mutex<Option<NativeOptions>> = std::sync::Mutex::new(None);

pub fn set_native_options(o: NativeOptions) {
    *NATIVE_OPTIONS.lock().unwrap() = Some(o);
}

fn native_options() -> NativeOptions {
    NATIVE_OPTIONS.lock().unwrap().clone().unwrap_or_default()
}

pub fn static_memory() -> Option<StaticMemory> {
    *STATIC_MEMORY.lock().unwrap()
}

/// A size such as `64M`, `512K`, `1G` or a number of bytes.
pub fn parse_size(s: &str) -> Option<u64> {
    let (n, mul) = match s.chars().last()? {
        'K' | 'k' => (&s[..s.len() - 1], 1u64 << 10),
        'M' | 'm' => (&s[..s.len() - 1], 1 << 20),
        'G' | 'g' => (&s[..s.len() - 1], 1 << 30),
        _ => (s, 1),
    };
    n.parse::<u64>().ok()?.checked_mul(mul)
}

const STATIC_RUNTIME: &str = include_str!("../runtime/fwp_rt_static.c");

/// The TLS runtime, embedded only in programs that use TLS (and linked
/// with OpenSSL); `FWP_TLS` is defined for the other parts then.
const TLS_RUNTIME: &str = include_str!("../runtime/fwp_rt_tls.c");

/// The line that marks generated C that uses TLS (and must be linked with
/// `-lssl -lcrypto`).
const TLS_MARK: &str = "#define FWP_TLS 1\n";

/// The line that marks generated C that uses tasks or channels: compiled
/// for WebAssembly, it exports the fiber interface of web/fibers.js.
const ASYNC_MARK: &str = "#define FWP_ASYNC 1\n";

/// Linker arguments for WebAssembly: the fiber interface needs the stack
/// pointer and a growable function table (web/fibers.js).
fn wasm_links(c_source: &str) -> &'static [&'static str] {
    if c_source.contains(ASYNC_MARK) {
        &[
            "-Wl,--export=__stack_pointer",
            "-Wl,--export-table",
            "-Wl,--growable-table",
        ]
    } else {
        &[]
    }
}

/// Libraries to link generated C with.
fn tls_links(c_source: &str) -> &'static [&'static str] {
    if c_source.contains(TLS_MARK) {
        &["-lssl", "-lcrypto"]
    } else {
        &[]
    }
}

/// Runtime parts embedded only in programs that call or serve services.
const SERVICES_RUNTIME: &[&str] = &[
    include_str!("../runtime/fwp_rt_h2.c"),
    include_str!("../runtime/fwp_rt_grpc.c"),
    include_str!("../runtime/fwp_rt_http2.c"),
];

/// A function's RPC (`fwp_rpc` in runtime/fwp_rt_grpc.c): its messages
/// and the C expressions of its descriptors.
struct RpcSpec {
    name: String,
    path: String,
    fingerprint: String,
    func: FuncId,
    req: Vec<String>,
    resp: String,
    error: Option<String>,
    input: u8,
    output: u8,
    status_errors: bool,
    iter_fn: Option<FuncId>,
    schema: crate::protobuf::MethodSchema,
    grpc_error: String,
}

impl RpcSpec {
    /// The definition of its request descriptors (`<prefix>_p`) and the
    /// struct initializer.
    fn c(&self, prefix: &str, offs: &[usize]) -> (String, String) {
        let def = format!(
            "static const fwp_desc *const {}_p[] = {{{}}};",
            prefix,
            if self.req.is_empty() {
                "0".to_string()
            } else {
                self.req.join(", ")
            }
        );
        let init = format!(
            "{{{}, {}, {}, {}, {}, {}_p, {}, {}, {}, {}, {}, {}, fwp_pb_schema, {}, {}, {}}}",
            c_string_literal(self.name.as_bytes()),
            c_string_literal(self.path.as_bytes()),
            c_string_literal(self.fingerprint.as_bytes()),
            self.func,
            self.req.len(),
            prefix,
            self.resp,
            self.error.clone().unwrap_or_else(|| "0".into()),
            self.input,
            self.output,
            self.status_errors as u8,
            self.iter_fn.map(|f| f as i64).unwrap_or(-1),
            offs[self.schema.request],
            offs[self.schema.response],
            self.grpc_error,
        );
        (def, init)
    }
}

/// A client stub: its function and its RPC.
struct RemoteSpec {
    id: FuncId,
    remote: RemoteFn,
    rpc: RpcSpec,
}

struct Gen<'p> {
    prog: &'p Program,
    descs: HashMap<MT, usize>,
    desc_defs: Vec<String>,
    /// Drop functions by type (`Gen::drop_id`): a reference given up, and
    /// on the last one the object freed with what it holds.
    drops: HashMap<MT, usize>,
    drop_defs: Vec<String>,
    cleanup_defs: Vec<String>,
    /// Type-directed ownership of fresh runtime result trees.
    tree_owners: HashMap<MT, usize>,
    tree_owner_defs: Vec<String>,
    /// Per variant type returned as a struct: its helpers (`vhelper`).
    vhelpers: HashMap<MT, usize>,
    vhelper_defs: Vec<String>,
    vhelper_decls: Vec<String>,
    strings: HashMap<Vec<u8>, usize>,
    string_defs: Vec<String>,
    consts: Vec<String>,
    const_init: String,
    used_closures: Vec<bool>,
    /// Declarations for foreign C functions: structs, prototypes,
    /// converters and callback trampolines.
    ffi_decls: String,
    ffi_structs: Vec<String>,
    /// The protobuf schema of the services this program calls or serves.
    pb: crate::protobuf::Schema,
    remotes: Vec<RemoteSpec>,
    /// Flag tables of options records (`cli.parse`, executables).
    cli_defs: String,
    cli_flags: HashMap<MT, usize>,
    /// Whether functions are safe points for preemption (programs with
    /// tasks): their entries spend the running task's budget.
    ticks: bool,
    /// The runtime may return through an Error handler or task cancellation.
    unwind: bool,
    /// Step functions of `loop`s compiled to C loops with their state in
    /// locals (`loop_shape`), with whether the state is a record kept
    /// field by field.
    loops: Vec<(FuncId, Option<usize>)>,
    /// Higher-order primitives specialized for a function of the captured
    /// locals and the elements (`opt::specialize_hofs`): the primitive and
    /// the function, and how many locals it captures.
    hofs: Vec<(String, FuncId, usize)>,
    /// The unboxed calling convention of each function that has one.
    abis: Vec<Option<Abi>>,
    /// Which parameters of each function do not escape (`src/escape.rs`):
    /// a record or variant passed there may live on the caller's stack.
    noesc: Vec<Vec<bool>>,
    /// Counted references, to update unique records in place
    /// (`FWP_REUSE=1`, see `fwp_rc_*` in runtime/fwp_rt_gc.c).
    reuse: bool,
    /// Functions the runtime calls back directly (`Gen::callback`).
    callbacks: Vec<FuncId>,
    owned_callbacks: Vec<FuncId>,
    owned_fold_callbacks: Vec<FuncId>,
    owned_right_fold_callbacks: Vec<FuncId>,
}

/// `e` without the reference count changes of local `x`, if it does
/// not use `x` otherwise.
fn without_counts(e: &Expr, x: Local) -> Option<Expr> {
    let go = |e: &Expr| without_counts(e, x);
    let all = |es: &[Expr]| es.iter().map(go).collect::<Option<Vec<Expr>>>();
    Some(match e {
        Expr::Dup(l, b) | Expr::Drop(l, b) if *l == x => go(b)?,
        Expr::Dup(l, b) => Expr::Dup(*l, Box::new(go(b)?)),
        Expr::Drop(l, b) => Expr::Drop(*l, Box::new(go(b)?)),
        Expr::Local(l) if *l == x => return None,
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => e.clone(),
        Expr::Call(f, a) => Expr::Call(*f, all(a)?),
        Expr::Construct(t, a) => Expr::Construct(*t, all(a)?),
        Expr::Record(a) => Expr::Record(all(a)?),
        Expr::Apply(f, a) => Expr::Apply(Box::new(go(f)?), all(a)?),
        Expr::Field(r, i) => Expr::Field(Box::new(go(r)?), *i),
        Expr::SetFields(r, sets) => Expr::SetFields(
            Box::new(go(r)?),
            sets.iter()
                .map(|(i, v)| go(v).map(|v| (*i, v)))
                .collect::<Option<Vec<_>>>()?,
        ),
        Expr::Let(l, v, b) => Expr::Let(*l, Box::new(go(v)?), Box::new(go(b)?)),
        Expr::Match(s, arms) => Expr::Match(
            Box::new(go(s)?),
            arms.iter()
                .map(|(p, b)| go(b).map(|b| (p.clone(), b)))
                .collect::<Option<Vec<_>>>()?,
        ),
    })
}

/// Whether `e` is local `x`, under reference count changes.
fn is_local_through_counts(e: &Expr, x: Local) -> bool {
    match e {
        Expr::Local(l) => *l == x,
        Expr::Dup(_, b) | Expr::Drop(_, b) => is_local_through_counts(b, x),
        _ => false,
    }
}

/// A value the runtime keeps: shared when references are counted.
fn shared(reuse: bool, v: String) -> String {
    if reuse {
        format!("fwp_rc_shared({})", v)
    } else {
        v
    }
}

/// Whether to count references and reuse unique records in place: by
/// default, unless `FWP_REUSE=0` when compiling.
fn reuse_enabled() -> bool {
    std::env::var("FWP_REUSE").map_or(true, |v| v != "0")
}

/// `prog` with its function bodies' references counted (`src/rc.rs`).
fn counted_program(prog: &Program) -> Program {
    let mut p = prog.clone();
    for (f, rc) in p.funcs.iter_mut().zip(crate::rc::insert(prog)) {
        if let Some((body, locals)) = rc {
            f.body = Body::Expr(body);
            f.locals = locals;
        }
    }
    p
}

/// Whether `e` builds an aggregate or a known closure at its end, after
/// the locals it binds. Hoist those bindings before choosing stack storage.
fn ends_in_object(e: &Expr) -> bool {
    match e {
        Expr::Let(_, _, b) => ends_in_object(b),
        Expr::Record(xs) | Expr::Construct(_, xs) => !xs.is_empty(),
        Expr::Apply(f, _) if matches!(**f, Expr::Func(_)) => true,
        _ => false,
    }
}

/// Whether objects are freed when their last counted reference goes
/// (`FWP_FREE=0` when compiling leaves them to the collector).
fn free_enabled() -> bool {
    std::env::var("FWP_FREE").map_or(true, |v| v != "0")
}

/// Whether records and variants that do not escape live on the stack
/// (`FWP_STACK=0` turns it off, to compare).
fn stack_enabled() -> bool {
    std::env::var("FWP_STACK").map_or(true, |v| v != "0")
}

/// Variants returned as structs (`FWP_VRET=0` when compiling turns it off).
fn variant_returns_enabled() -> bool {
    std::env::var("FWP_VRET").map_or(true, |v| v != "0")
}

impl Gen<'_> {
    fn live_calls(&self, id: FuncId, e: &Expr) -> HashMap<*const Expr, crate::rc::CallLiveness> {
        if !self.reuse || !self.unwind {
            return HashMap::new();
        }
        crate::rc::ownership_liveness(
            self.prog,
            &self.prog.funcs[id],
            e,
            &self.prog.funcs[id].locals,
        )
        .expect("invalid ownership before C generation")
    }

    /// A temporary typed owner for values awaiting an allocating operation.
    /// Scalar fields have no scope entry and cannot be mistaken for pointers.
    fn protect_values(&mut self, values: &[(String, MT)], ctx: &str, node: &str) -> String {
        if !self.reuse || !self.unwind {
            return String::new();
        }
        let mut members = Vec::new();
        let mut initial = Vec::new();
        let mut releases = Vec::new();
        for (value, ty) in values {
            if !crate::rc::needs_rc(&self.prog.shapes, ty) {
                continue;
            }
            let j = members.len();
            members.push(format!("V v{j};"));
            initial.push(value.clone());
            let drop = self.value_drop(ty);
            releases.push(format!("{drop}(c->v{j});"));
        }
        if members.is_empty() {
            return String::new();
        }
        let id = self.cleanup_defs.len();
        self.cleanup_defs.push(format!("typedef struct {{ {} }} fwp_owner_ctx{id};\nstatic void fwp_owner_release{id}(void *arg) {{ fwp_owner_ctx{id} *c = arg; {} }}\n", members.join(" "), releases.join(" ")));
        format!("fwp_owner_ctx{id} {ctx} = {{{}}}; fwp_cleanup {node}; fwp_cleanup_push(&{node}, fwp_owner_release{id}, &{ctx});", initial.join(", "))
    }

    /// Retain typed fields in order, owning only successfully completed extras.
    fn duplicate_values(&mut self, values: &[(String, MT)], ctx: &str, node: &str) -> String {
        let counted: Vec<_> = values
            .iter()
            .filter(|(_, ty)| crate::rc::needs_rc(&self.prog.shapes, ty))
            .cloned()
            .collect();
        let empty: Vec<_> = counted
            .iter()
            .map(|(_, ty)| ("0".into(), ty.clone()))
            .collect();
        let protect = if counted.len() > 1 {
            self.protect_values(&empty, ctx, node)
        } else {
            String::new()
        };
        let mut out = protect.clone();
        for (j, (value, _)) in counted.iter().enumerate() {
            let _ = write!(out, " fwp_rc_dup({value});");
            if !protect.is_empty() {
                let _ = write!(out, " {ctx}.v{j} = {value};");
            }
        }
        if !protect.is_empty() {
            let _ = write!(out, " fwp_cleanup_pop(&{node});");
        }
        out
    }

    /// An allocation of compiled code: unique when references are counted.
    fn fresh(&self, alloc: String) -> String {
        if self.reuse {
            format!("fwp_rc_fresh({})", alloc)
        } else {
            alloc
        }
    }

    /// The C function the runtime calls for function `g` (a primitive's
    /// callback): one that shares its result when references are counted.
    fn callback(&mut self, g: FuncId) -> String {
        if self.reuse {
            if !self.callbacks.contains(&g) {
                self.callbacks.push(g);
            }
            format!("k{}", g)
        } else {
            format!("f{}", g)
        }
    }

    /// The number of fields of a record `e` gives without being built:
    /// a record expression, or a call of a worker returning a struct.
    fn unboxed_value(&self, e: &Expr) -> Option<usize> {
        match e {
            Expr::Call(id, _) => self.abis[*id].as_ref()?.ret,
            Expr::Record(xs) if (1..=MAX_UNBOXED).contains(&xs.len()) => Some(xs.len()),
            Expr::Let(_, _, b) | Expr::Dup(_, b) | Expr::Drop(_, b) => self.unboxed_value(b),
            Expr::Match(_, arms) => {
                let n = self.unboxed_value(&arms.first()?.1)?;
                arms.iter()
                    .all(|(_, b)| self.unboxed_value(b) == Some(n))
                    .then_some(n)
            }
            _ => None,
        }
    }
}

/// Most fields of a record passed or returned as a C struct (two words
/// come back in registers, more in the caller's frame, which the C ABI
/// provides).
const MAX_UNBOXED: usize = 8;

/// Most fields of a record returned as a struct whatever its tails: a
/// wider one only when every tail builds it, so that a record a function
/// passes on is not read into a struct and built again.
const MAX_ANY_RET: usize = 4;

/// How a function's worker (`w<id>`) takes and returns records, for
/// direct calls: a parameter read only field by field comes as its
/// fields, and a record result comes back as a C struct (`fwp_r<n>`),
/// so neither is allocated. The function itself (`f<id>`, for closures
/// and primitives) wraps the worker.
#[derive(Clone, Debug)]
struct Abi {
    /// Per parameter: its number of fields when it is passed field by field.
    params: Vec<Option<usize>>,
    /// The number of fields of a result returned as a struct.
    ret: Option<usize>,
    /// A variant result returned as its tag and fields (`fwp_u<m>`, `m` the
    /// most fields of a constructor): the function builds it on every path,
    /// so a caller that only matches on it never allocates it.
    vret: Option<usize>,
}

/// The number of fields of a record type small enough to unbox.
fn small_record(prog: &Program, t: &MT) -> Option<usize> {
    let n = record_fields(&prog.shapes, t)?.len();
    (1..=MAX_UNBOXED).contains(&n).then_some(n)
}

fn abi_of(prog: &Program, f: &Func) -> Option<Abi> {
    let Body::Expr(body) = &f.body else {
        return None;
    };
    if f.arity == 0 {
        return None;
    }
    let params: Vec<Option<usize>> = (0..f.arity)
        .map(|i| {
            small_record(prog, &f.locals[i as usize]).filter(|_| crate::opt::only_fields(body, i))
        })
        .collect();
    let ret = small_record(prog, f.ty.params(f.arity as usize).1);
    (ret.is_some() || params.iter().any(Option::is_some)).then_some(Abi {
        params,
        ret,
        vret: None,
    })
}

/// The most fields of a constructor of a variant type, when small enough
/// for a struct and not 0 (a variant of constants is a word already). A
/// recursive type (a list, a tree) is left out: its nodes are rebuilt from
/// the cells of the old ones in place, which a struct has not.
fn small_variant(prog: &Program, t: &MT) -> Option<usize> {
    let Some(TypeShape::Adt(vs)) = prog.shapes.get(t) else {
        return None;
    };
    if vs.iter().flat_map(|(_, fs)| fs).any(|ft| mentions(ft, t)) {
        return None;
    }
    let m = vs.iter().map(|(_, fs)| fs.len()).max()?;
    (1..=MAX_UNBOXED).contains(&m).then_some(m)
}

/// Whether type `t` appears in `ft`.
fn mentions(ft: &MT, t: &MT) -> bool {
    ft == t
        || match ft {
            MT::Con(_, args) => args.iter().any(|a| mentions(a, t)),
            MT::Fun(a, b) => mentions(a, t) || mentions(b, t),
            MT::Record(fs) => fs.iter().any(|(_, x)| mentions(x, t)),
            MT::Nat(_) => false,
        }
}

/// Which functions return their variant result as a struct: those whose
/// every tail builds a constructor or calls such a function (a fixed point
/// from all candidates down). A function that may return a value it was
/// given keeps returning it as it is.
fn variant_returns(prog: &Program, abis: &mut [Option<Abi>]) {
    let mut cand: Vec<Option<usize>> = prog
        .funcs
        .iter()
        .enumerate()
        .map(|(id, f)| match &f.body {
            Body::Expr(_) if f.arity > 0 && abis[id].as_ref().is_none_or(|a| a.ret.is_none()) => {
                small_variant(prog, f.ty.params(f.arity as usize).1)
            }
            _ => None,
        })
        .collect();
    loop {
        let mut changed = false;
        for (id, f) in prog.funcs.iter().enumerate() {
            let (Some(m), Body::Expr(body)) = (cand[id], &f.body) else {
                continue;
            };
            let mut ts = Vec::new();
            tails(body, &mut ts);
            let ok = ts.iter().all(|t| match t {
                Expr::Construct(..) => true,
                Expr::Call(g, _) => cand[*g] == Some(m),
                _ => false,
            });
            if !ok {
                cand[id] = None;
                changed = true;
            }
        }
        if !changed {
            break;
        }
    }
    for (id, m) in cand.into_iter().enumerate() {
        if let Some(m) = m {
            let n = prog.funcs[id].arity as usize;
            abis[id]
                .get_or_insert_with(|| Abi {
                    params: vec![None; n],
                    ret: None,
                    vret: None,
                })
                .vret = Some(m);
        }
    }
}

/// Records of more than `MAX_ANY_RET` fields stay returned as structs
/// only by functions whose every tail builds one or calls such a function
/// (a fixed point).
fn wide_record_returns(prog: &Program, abis: &mut [Option<Abi>]) {
    loop {
        let mut changed = false;
        for (id, f) in prog.funcs.iter().enumerate() {
            let Body::Expr(body) = &f.body else {
                continue;
            };
            let Some(n) = abis[id].as_ref().and_then(|a| a.ret) else {
                continue;
            };
            if n <= MAX_ANY_RET {
                continue;
            }
            let mut ts = Vec::new();
            tails(body, &mut ts);
            let ok = ts.iter().all(|t| match t {
                Expr::Record(xs) => xs.len() == n,
                Expr::Call(g, _) => abis[*g].as_ref().and_then(|a| a.ret) == Some(n),
                _ => false,
            });
            if !ok {
                if let Some(a) = abis[id].as_mut() {
                    a.ret = None;
                }
                changed = true;
            }
        }
        if !changed {
            break;
        }
    }
}

/// Whether local `l` is used in `e` only as the scrutinee of matches whose
/// patterns do not bind it whole (and in reference counts).
fn only_matched(e: &Expr, l: Local) -> bool {
    variant_uses(e, l, false)
}

fn variant_uses(e: &Expr, l: Local, returned: bool) -> bool {
    let all = |xs: &[Expr]| xs.iter().all(|x| variant_uses(x, l, false));
    match e {
        Expr::Local(x) => *x != l || returned,
        Expr::Const(_) | Expr::Func(_) => true,
        Expr::Dup(_, b) | Expr::Drop(_, b) => variant_uses(b, l, returned),
        Expr::Call(_, xs) | Expr::Construct(_, xs) | Expr::Record(xs) => all(xs),
        Expr::Apply(f, xs) => variant_uses(f, l, false) && all(xs),
        Expr::Field(r, _) => variant_uses(r, l, false),
        Expr::SetFields(r, s) => {
            variant_uses(r, l, false) && s.iter().all(|(_, x)| variant_uses(x, l, false))
        }
        Expr::Let(alias, v, b) if matches!(**v, Expr::Local(x) if x == l) => {
            variant_uses(b, l, returned) && variant_uses(b, *alias, returned)
        }
        Expr::Let(_, v, b) => variant_uses(v, l, false) && variant_uses(b, l, returned),
        Expr::Match(s, arms) => {
            let scrut = match &**s {
                Expr::Local(x) if *x == l => arms.iter().all(|(p, _)| !matches!(p, Pat::Bind(_))),
                s => variant_uses(s, l, false),
            };
            scrut && arms.iter().all(|(_, b)| variant_uses(b, l, returned))
        }
    }
}

impl Abi {
    fn sig(&self, id: FuncId) -> String {
        let mut ps = Vec::new();
        for (i, p) in self.params.iter().enumerate() {
            match p {
                Some(n) => ps.extend((0..*n).map(|k| format!("V l{}_{}", i, k))),
                None => ps.push(format!("V l{}", i)),
            }
        }
        let ret = match (self.ret, self.vret) {
            (Some(n), _) => format!("fwp_r{}", n),
            (None, Some(m)) => format!("fwp_u{}", m),
            (None, None) => "V".into(),
        };
        format!("static {} w{}({})", ret, id, ps.join(", "))
    }
}

/// Numeric kind, display name and TInt width of a primitive type.
fn num_kind(mt: &MT) -> Option<(&'static str, String, u64)> {
    let MT::Con(n, args) = mt else { return None };
    let short = n.strip_prefix("std::")?;
    let k = match short {
        "I8" => "K_I8",
        "I16" => "K_I16",
        "I32" => "K_I32",
        "I64" | "ISize" => "K_I64",
        "I128" => "K_I128",
        "U8" => "K_U8",
        "U16" => "K_U16",
        "U32" => "K_U32",
        "U64" | "USize" => "K_U64",
        "U128" => "K_U128",
        "F32" | "F16" | "BF16" => "K_F32",
        "F64" | "F128" => "K_F64",
        "TInt" => "K_TINT",
        "Trit" => "K_TRIT",
        _ => return None,
    };
    let w = match args.first() {
        Some(MT::Nat(w)) => *w,
        _ => 0,
    };
    Some((k, short.to_string(), w))
}

/// Lane count and lane type of a `Vec[n, t]`.
fn vec_shape(mt: &MT) -> (u64, MT) {
    match mt {
        MT::Con(_, args) => (
            match args.first() {
                Some(MT::Nat(n)) => *n,
                _ => 0,
            },
            args.get(1).cloned().unwrap_or(MT::unit()),
        ),
        _ => (0, MT::unit()),
    }
}

fn c_string_literal(bytes: &[u8]) -> String {
    let mut s = String::from("\"");
    for &b in bytes {
        match b {
            b'"' => s.push_str("\\\""),
            b'\\' => s.push_str("\\\\"),
            b'\n' => s.push_str("\\n"),
            0x20..=0x7e if b != b'?' => s.push(b as char),
            _ => {
                let _ = write!(s, "\\{:03o}", b);
            }
        }
    }
    s.push('"');
    s
}

fn op_code(sym: &str) -> &'static str {
    match sym.rsplit('.').next().unwrap() {
        "add" => "OP_ADD",
        "sub" => "OP_SUB",
        "mul" => "OP_MUL",
        "div" => "OP_DIV",
        _ => "OP_REM",
    }
}

/// A number type whose operations compile to plain C: fixed-width
/// integers (stored sign- or zero-extended in a `V`) and `F32`/`F64`.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Scalar {
    Signed(u32),
    Unsigned(u32),
    F32,
    F64,
}

fn scalar(mt: &MT) -> Option<Scalar> {
    let MT::Con(n, _) = mt else { return None };
    Some(match n.strip_prefix("std::")? {
        "I8" => Scalar::Signed(8),
        "I16" => Scalar::Signed(16),
        "I32" => Scalar::Signed(32),
        "I64" | "ISize" => Scalar::Signed(64),
        "U8" => Scalar::Unsigned(8),
        "U16" => Scalar::Unsigned(16),
        "U32" => Scalar::Unsigned(32),
        "U64" | "USize" => Scalar::Unsigned(64),
        "F32" => Scalar::F32,
        "F64" => Scalar::F64,
        _ => return None,
    })
}

impl Scalar {
    /// The C type a value of this type is computed in.
    fn c(self) -> &'static str {
        match self {
            Scalar::Signed(_) => "int64_t",
            Scalar::Unsigned(_) => "uint64_t",
            Scalar::F32 => "float",
            Scalar::F64 => "double",
        }
    }

    /// The C expression of a `V` as this type.
    fn get(self, v: &str) -> String {
        match self {
            Scalar::Signed(_) => format!("(int64_t){}", v),
            Scalar::Unsigned(_) => format!("(uint64_t){}", v),
            Scalar::F32 => format!("fwp_f32({})", v),
            Scalar::F64 => format!("fwp_f64({})", v),
        }
    }

    /// The `V` of a C expression of this type.
    fn put(self, x: &str) -> String {
        match self {
            Scalar::Signed(_) | Scalar::Unsigned(_) => format!("(V)({})", x),
            Scalar::F32 => format!("fwp_from_f32({})", x),
            Scalar::F64 => format!("fwp_from_f64({})", x),
        }
    }

    /// The bounds of a narrow integer, as C literals.
    fn bounds(self) -> Option<(String, String)> {
        match self {
            Scalar::Signed(b) if b < 64 => Some((
                format!("{}LL", -(1i64 << (b - 1))),
                format!("{}LL", (1i64 << (b - 1)) - 1),
            )),
            Scalar::Unsigned(b) if b < 64 => Some(("0".into(), format!("{}LL", (1i64 << b) - 1))),
            _ => None,
        }
    }

    /// The body of `subject op argument` (the operands are `l1` and `l0`),
    /// with the interpreter's traps: overflow, division by zero, and
    /// `MIN / -1` and `MIN % -1` for signed integers.
    fn arith(self, sym: &str, name: &str) -> String {
        let op = sym.rsplit('.').next().unwrap();
        let (x, y) = (self.get("l1"), self.get("l0"));
        let ovf = format!("fwp_trap_overflow({});", name);
        if matches!(self, Scalar::F32 | Scalar::F64) {
            let e = match op {
                "add" => format!("{} + {}", x, y),
                "sub" => format!("{} - {}", x, y),
                "mul" => format!("{} * {}", x, y),
                "div" => format!("{} / {}", x, y),
                _ if self == Scalar::F32 => format!("fmodf({}, {})", x, y),
                _ => format!("fmod({}, {})", x, y),
            };
            return format!("return {};", self.put(&e));
        }
        let t = self.c();
        let mut s = format!("{t} x = {x}, y = {y}, r;\n    ", t = t, x = x, y = y);
        match op {
            "div" | "rem" => {
                s.push_str("if (y == 0) fwp_trap(\"division by zero\");\n    ");
                if let Scalar::Signed(b) = self {
                    let min = if b == 64 {
                        "INT64_MIN".to_string()
                    } else {
                        self.bounds().unwrap().0
                    };
                    s.push_str(&format!("if (x == {} && y == -1) {}\n    ", min, ovf));
                }
                s.push_str(if op == "div" {
                    "r = x / y;"
                } else {
                    "r = x % y;"
                });
            }
            _ => match self.bounds() {
                // computed in 64 bits, where it cannot overflow, and checked
                Some((lo, hi)) => {
                    let c = match op {
                        "add" => "+",
                        "sub" => "-",
                        _ => "*",
                    };
                    s = format!(
                        "int64_t r = (int64_t){x} {c} (int64_t){y};\n    if (r < {lo} || r > {hi}) {ovf}",
                        x = "l1",
                        y = "l0",
                        c = c,
                        lo = lo,
                        hi = hi,
                        ovf = ovf
                    );
                }
                None => s.push_str(&format!("if (__builtin_{}_overflow(x, y, &r)) {}", op, ovf)),
            },
        }
        format!("{}\n    return (V)r;", s)
    }
}

fn elem(mt: &MT, i: usize) -> MT {
    match mt {
        MT::Con(_, args) => args.get(i).cloned().unwrap_or(MT::unit()),
        _ => MT::unit(),
    }
}

impl<'p> Gen<'p> {
    // ----- descriptors -----------------------------------------------------------

    /// The C table of an options record's flags (with the defaults of an
    /// executable's command, as text); its name.
    fn flag_table(&mut self, o: &crate::cli::Options, defaults: &[Option<String>]) -> String {
        let key = if defaults.iter().all(Option::is_none) {
            Some(o.record.clone())
        } else {
            None
        };
        if let Some(i) = key.as_ref().and_then(|k| self.cli_flags.get(k)) {
            return format!("fwp_flags{}", i);
        }
        let id = self
            .cli_defs
            .matches("static const fwp_flag fwp_flags")
            .count();
        let lefts = crate::cli::help_lefts(o);
        let mut rows = Vec::new();
        for (k, f) in o.flags.iter().enumerate() {
            let (left, pad) = &lefts[k];
            rows.push(format!(
                "    {{{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}}}",
                c_string_literal(f.name.as_bytes()),
                f.short.map(|c| c as u32).unwrap_or(0),
                f.kind as u8,
                f.index,
                self.desc(&f.value_ty),
                c_string_literal(f.value_ty.to_string().as_bytes()),
                self.desc(&f.field_ty),
                match defaults.get(k).cloned().flatten() {
                    Some(d) => c_string_literal(d.as_bytes()),
                    None => "0".into(),
                },
                c_string_literal(left.as_bytes()),
                c_string_literal(pad.as_bytes()),
                c_string_literal(f.doc.as_bytes()),
                match &f.env {
                    Some(e) => c_string_literal(e.as_bytes()),
                    None => "0".into(),
                },
                match crate::cli::constraint_notes(f) {
                    Some(p) => c_string_literal(p.as_bytes()),
                    None => "0".into(),
                },
                int_list(&f.conflicts),
                int_list(&f.requires),
            ));
        }
        let _ = writeln!(
            self.cli_defs,
            "static const fwp_flag fwp_flags{}[] = {{\n{}\n}};",
            id,
            rows.join(",\n")
        );
        if let Some(k) = key {
            self.cli_flags.insert(k, id);
        }
        format!("fwp_flags{}", id)
    }

    fn desc(&mut self, mt: &MT) -> String {
        format!("&d{}", self.desc_id(mt))
    }

    fn desc_id(&mut self, mt: &MT) -> usize {
        if let Some(i) = self.descs.get(mt) {
            return *i;
        }
        let id = self.desc_defs.len();
        self.descs.insert(mt.clone(), id);
        self.desc_defs.push(String::new());
        let def = self.desc_body(mt, id);
        self.desc_defs[id] = def;
        id
    }

    fn cstr(s: &str) -> String {
        c_string_literal(s.as_bytes())
    }

    /// The drop function of values of type `mt` (counted, see
    /// `rc::needs_rc`): it gives up one reference; on the last one, it
    /// gives up the references the object holds, by their types, and frees
    /// it. A field of the same type (a list's tail) is dropped by the
    /// same loop, so a long list needs no deep recursion. Objects the
    /// runtime shares (count 0) and objects off the heap are left alone.
    fn drop_id(&mut self, mt: &MT) -> usize {
        if let Some(i) = self.drops.get(mt) {
            return *i;
        }
        let id = self.drop_defs.len();
        self.drops.insert(mt.clone(), id);
        self.drop_defs.push(String::new());
        let def = self.drop_body(mt, id);
        self.drop_defs[id] = def;
        id
    }

    /// Select count operations from the monomorphic Step payload types.
    fn loop_ops(&mut self, step: &MT) -> Result<String, String> {
        let MT::Con(name, fields) = step else {
            return Err("loop callback has a non-Step result".into());
        };
        if name != "std::Step" || fields.len() != 2 {
            return Err("loop callback has a non-Step result".into());
        }
        let duplicate = |ty: &MT| {
            if crate::rc::needs_rc(&self.prog.shapes, ty) {
                "fwp_rc_dup"
            } else {
                "NULL"
            }
        };
        let state = duplicate(&fields[0]);
        let result = duplicate(&fields[1]);
        let drop = if free_enabled() {
            format!("fwp_drop{}", self.drop_id(step))
        } else {
            "fwp_rc_drop".into()
        };
        Ok(format!("{state}, {result}, {drop}"))
    }

    fn loop_owned_ops(&mut self, step: &MT) -> Result<String, String> {
        let ops = self.loop_ops(step)?;
        let MT::Con(_, fields) = step else {
            unreachable!()
        };
        let drop = self.value_drop(&fields[0]);
        Ok(format!("{ops}, {drop}"))
    }

    fn value_drop(&mut self, ty: &MT) -> String {
        if !crate::rc::needs_rc(&self.prog.shapes, ty) {
            "NULL".into()
        } else if free_enabled() && !matches!(ty, MT::Con(n, _) if n == "?") {
            format!("fwp_drop{}", self.drop_id(ty))
        } else {
            "fwp_rc_drop".into()
        }
    }

    fn map_ops(&mut self, element: &MT) -> String {
        let drop = if !crate::rc::needs_rc(&self.prog.shapes, element) {
            "NULL".into()
        } else if free_enabled() {
            format!("fwp_drop{}", self.drop_id(element))
        } else {
            "fwp_rc_drop".into()
        };
        let list = MT::Con("std::List".into(), vec![element.clone()]);
        let list_drop = if free_enabled() {
            format!("fwp_drop{}", self.drop_id(&list))
        } else {
            "fwp_rc_drop".into()
        };
        format!("{drop}, {list_drop}")
    }

    fn tree_owner_id(&mut self, mt: &MT) -> Result<usize, String> {
        if let Some(id) = self.tree_owners.get(mt) {
            return Ok(*id);
        }
        let id = self.tree_owner_defs.len();
        self.tree_owners.insert(mt.clone(), id);
        self.tree_owner_defs.push(String::new());
        let mut body = format!("static void fwp_own_tree{id}(V v) {{\n    for (;;) {{\n        uint8_t *c = fwp_rc_slot(v);\n        if (!c) return;\n        if (*c) fwp_trap(\"internal: aliased fresh result tree\");\n        fwp_rc_fresh(v);\n");
        if matches!(mt, MT::Con(n, _) if matches!(n.as_str(), "std::String" | "std::Bytes")) {
            body.push_str("        return;\n    }\n}\n");
            self.tree_owner_defs[id] = body;
            return Ok(id);
        }
        let cases: Vec<(u32, Vec<MT>)> = match (
            record_fields(&self.prog.shapes, mt),
            self.prog.shapes.get(mt),
        ) {
            (Some(fs), _) => vec![(0, fs.iter().map(|(_, t)| t.clone()).collect())],
            (None, Some(TypeShape::Adt(vs))) => vs
                .iter()
                .enumerate()
                .filter(|(_, (_, fs))| !fs.is_empty())
                .map(|(tag, (_, fs))| (tag as u32, fs.clone()))
                .collect(),
            _ => {
                return Err(format!(
                    "fresh tree result has unsupported counted type `{mt}`"
                ))
            }
        };
        body.push_str("        switch (OBJ(v)->tag) {\n");
        for (tag, fields) in cases {
            let _ = writeln!(body, "        case {tag}: {{");
            // A list spine is followed in a loop, not by C recursion.
            let tail = fields.iter().rposition(|t| t == mt);
            for (index, ty) in fields.iter().enumerate() {
                if Some(index) == tail || !crate::rc::needs_rc(&self.prog.shapes, ty) {
                    continue;
                }
                let owner = self.tree_owner_id(ty)?;
                let _ = writeln!(body, "            fwp_own_tree{owner}(OBJ(v)->f[{index}]);");
            }
            if let Some(index) = tail {
                let _ = writeln!(
                    body,
                    "            v = OBJ(v)->f[{index}];\n            continue;"
                );
            } else {
                body.push_str("            return;\n");
            }
            body.push_str("        }\n");
        }
        body.push_str("        default: fwp_trap(\"internal: invalid fresh tree tag\");\n        }\n    }\n}\n");
        self.tree_owner_defs[id] = body;
        Ok(id)
    }

    /// The helpers of a variant type `t` returned as a struct `fwp_u<m>`:
    /// `fwp_vbox<k>` builds the value (taking the struct's references),
    /// `fwp_vdup<k>` and `fwp_vdrop<k>` count the references its fields
    /// hold, by its tag.
    fn vhelper(&mut self, t: &MT, m: usize) -> usize {
        if let Some(k) = self.vhelpers.get(t) {
            return *k;
        }
        let k = self.vhelper_defs.len();
        self.vhelpers.insert(t.clone(), k);
        self.vhelper_defs.push(String::new());
        self.vhelper_decls
            .push(format!("static void fwp_vdrop{k}(fwp_u{m} *u);"));
        let vs = match self.prog.shapes.get(t) {
            Some(TypeShape::Adt(vs)) => vs.clone(),
            _ => Vec::new(),
        };
        let mut boxes = String::new();
        let (mut dups, mut drops) = (String::new(), String::new());
        for (tag, (_, fs)) in vs.iter().enumerate() {
            if fs.is_empty() {
                let _ = writeln!(boxes, "    case {}: return (V){};", tag, tag);
            } else {
                let alloc = self.fresh(format!("fwp_data({}, {}, u.f)", tag, fs.len()));
                let fields: Vec<_> = fs
                    .iter()
                    .enumerate()
                    .map(|(i, ty)| (format!("u.f[{i}]"), ty.clone()))
                    .collect();
                let protect = self.protect_values(&fields, "pending", "boxing_cleanup");
                let finish = if protect.is_empty() {
                    ""
                } else {
                    "fwp_cleanup_pop(&boxing_cleanup);"
                };
                let _ = writeln!(
                    boxes,
                    "    case {tag}: {{ {protect} V result = {alloc}; {finish} return result; }}"
                );
            }
            if !self.reuse {
                continue;
            }
            let fields: Vec<_> = fs
                .iter()
                .enumerate()
                .map(|(i, ty)| (format!("u->f[{i}]"), ty.clone()))
                .collect();
            let d = self.duplicate_values(&fields, "retained", "retaining_cleanup");
            let mut r = String::new();
            for (i, ft) in fs.iter().enumerate() {
                if !crate::rc::needs_rc(&self.prog.shapes, ft) {
                    continue;
                }
                let name = if free_enabled() && !matches!(ft, MT::Con(n, _) if n == "?") {
                    format!("fwp_drop{}", self.drop_id(ft))
                } else {
                    "fwp_rc_drop".into()
                };
                let _ = write!(r, " {}(u->f[{}]);", name, i);
            }
            if !d.is_empty() {
                let _ = writeln!(dups, "    case {}: {{ {} break; }}", tag, d);
                let _ = writeln!(drops, "    case {}:{} break;", tag, r);
            }
        }
        let def = format!(
            "/* {t} */\nstatic V fwp_vbox{k}(fwp_u{m} u) {{\n    switch ((uint32_t)u.tag) {{\n{boxes}    }}\n    return 0;\n}}\n\
             static void fwp_vdup{k}(fwp_u{m} *u) {{\n    (void)u;\n    switch ((uint32_t)u->tag) {{\n{dups}    }}\n}}\n\
             static void fwp_vdrop{k}(fwp_u{m} *u) {{\n    (void)u;\n    switch ((uint32_t)u->tag) {{\n{drops}    }}\n}}\n",
            t = t,
            k = k,
            m = m,
            boxes = boxes,
            dups = dups,
            drops = drops
        );
        self.vhelper_defs[k] = def;
        k
    }

    fn drop_body(&mut self, mt: &MT, id: usize) -> String {
        if matches!(mt, MT::Con(n, _) if n == "std::Channel") {
            return format!("static void fwp_drop{id}(V v) {{ fwp_channel_drop(v); }}\n");
        }
        if matches!(mt, MT::Con(n, _) if n == "std::Task") {
            return format!("static void fwp_drop{id}(V v) {{ fwp_task_drop(v); }}\n");
        }
        if matches!(mt, MT::Fun(..)) {
            return format!("static void fwp_drop{id}(V v) {{ fwp_closure_drop(v); }}\n");
        }
        let head = format!(
            "/* {} */\nstatic void fwp_drop{}(V v) {{\n    for (;;) {{\n        if (!fwp_rc_release_last(v)) return;\n",
            mt.to_string().replace("*/", "* /"),
            id
        );
        if matches!(mt, MT::Con(n, _) if matches!(n.as_str(), "std::String" | "std::Bytes")) {
            return format!(
                "{}        fwp_rc_free_obj(v);\n        return;\n    }}\n}}\n",
                head
            );
        }
        let container = matches!(mt, MT::Con(n, _) if crate::rc::is_container(n));
        if container {
            let mut elements = String::new();
            if let MT::Con(name, types) = mt {
                if name == "std::Array"
                    && types.len() == 1
                    && crate::rc::needs_rc(&self.prog.shapes, &types[0])
                {
                    let child = self.drop_id(&types[0]);
                    elements = format!("        for (uint64_t i = 0; i < ARR(v)->len; i++) fwp_drop{child}(ARR(v)->d[i]);\n");
                }
            }
            if let MT::Con(name, types) = mt {
                if (name == "std::Map" && types.len() == 2)
                    || (name == "std::Set" && types.len() == 1)
                {
                    let mut fields = String::new();
                    for (i, ty) in types.iter().enumerate() {
                        if crate::rc::needs_rc(&self.prog.shapes, ty) {
                            let child = self.drop_id(ty);
                            let _ = write!(fields, " fwp_drop{child}(MAP(v)->d[2 * i + {i}]);");
                        }
                    }
                    if !fields.is_empty() {
                        elements = format!(
                            "        for (uint64_t i = 0; i < MAP(v)->len; i++) {{{fields} }}\n"
                        );
                    }
                }
            }
            return format!(
                "{head}{elements}        fwp_rc_free_arr(v);\n        return;\n    }}\n}}\n"
            );
        }
        let shapes = &self.prog.shapes;
        let counted =
            |t: &MT| crate::rc::needs_rc(shapes, t) && !matches!(t, MT::Con(n, _) if n == "?");
        // the fields of each constructor (a record: one with tag 0)
        let cases: Vec<(u32, Vec<MT>)> = match (record_fields(shapes, mt), shapes.get(mt)) {
            (Some(fs), _) => vec![(0, fs.iter().map(|(_, t)| t.clone()).collect())],
            (None, Some(TypeShape::Adt(vs))) => vs
                .iter()
                .enumerate()
                .filter(|(_, (_, fs))| !fs.is_empty())
                .map(|(tag, (_, fs))| (tag as u32, fs.clone()))
                .collect(),
            _ => Vec::new(),
        };
        let mut body = String::new();
        let one = cases.len() == 1;
        if !one {
            body.push_str("        switch (OBJ(v)->tag) {\n");
        }
        for (tag, fs) in &cases {
            let ind = "        ";
            if !one {
                let _ = writeln!(body, "        case {}: {{", tag);
            }
            // the last field of the same type is followed by the loop
            let tail = fs.iter().rposition(|t| t == mt);
            for (k, t) in fs.iter().enumerate() {
                if Some(k) == tail || !counted(t) {
                    continue;
                }
                let d = self.drop_id(t);
                let _ = writeln!(body, "{}    fwp_drop{}(OBJ(v)->f[{}]);", ind, d, k);
            }
            match tail {
                Some(k) => {
                    let _ = writeln!(body, "{}    V next = OBJ(v)->f[{}];", ind, k);
                    let _ = writeln!(body, "{}    fwp_rc_free_obj(v);", ind);
                    let _ = writeln!(body, "{}    v = next;", ind);
                    let _ = writeln!(body, "{}    continue;", ind);
                }
                None => {
                    let _ = writeln!(body, "{}    fwp_rc_free_obj(v);", ind);
                    let _ = writeln!(body, "{}    return;", ind);
                }
            }
            if !one {
                body.push_str("        }\n");
            }
        }
        if !one {
            body.push_str("        }\n");
        }
        // no fields, or a constructor this type does not have: not freed
        if cases.is_empty() || !one {
            body.push_str("        return;\n");
        }
        format!("{}{}    }}\n}}\n", head, body)
    }

    fn desc_body(&mut self, mt: &MT, id: usize) -> String {
        let simple = |kind: &str, name: &str| {
            format!(
                "static fwp_desc d{} = {{{}, {}}};",
                id,
                kind,
                Self::cstr(name)
            )
        };
        match mt {
            MT::Fun(..) => simple("K_FUN", "function"),
            MT::Nat(_) => simple("K_OPAQUE", "nat"),
            MT::Record(fs) => {
                let tuple =
                    fs.len() > 1 && fs.iter().enumerate().all(|(i, (l, _))| *l == i.to_string());
                self.record_desc(id, None, fs, tuple)
            }
            MT::Con(n, args) => {
                if let Some((k, short, w)) = num_kind(mt) {
                    return format!(
                        "static fwp_desc d{} = {{{}, {}, .width = {}}};",
                        id,
                        k,
                        Self::cstr(&short),
                        w
                    );
                }
                match n.as_str() {
                    "std::String" => return simple("K_STR", "String"),
                    "std::Bytes" => return simple("K_BYTES", "Bytes"),
                    "std::File" => return simple("K_FILE", "File"),
                    "std::Ptr" => return simple("K_U64", "Ptr"),
                    "std::Task" => return simple("K_NATIVE", "task"),
                    "std::Channel" => return simple("K_NATIVE", "channel"),
                    "std::Listener" => return simple("K_NATIVE", "listener"),
                    "std::Conn" => return simple("K_NATIVE", "connection"),
                    "std::UdpSocket" => return simple("K_NATIVE", "udp socket"),
                    "std::List" | "std::Array" | "std::Set" => {
                        let e = self.desc_id(&elem(mt, 0));
                        let k = match n.as_str() {
                            "std::List" => "K_LIST",
                            "std::Array" => "K_ARRAY",
                            _ => "K_SET",
                        };
                        return format!("static fwp_desc d{} = {{{}, 0, .elem = &d{}}};", id, k, e);
                    }
                    "std::Map" => {
                        let k = self.desc_id(&elem(mt, 0));
                        let v = self.desc_id(&elem(mt, 1));
                        return format!(
                            "static fwp_desc d{} = {{K_MAP, 0, .elem = &d{}, .elem2 = &d{}}};",
                            id, k, v
                        );
                    }
                    _ => {}
                }
                let _ = args;
                let short = MT::short_name(n);
                match self.prog.shapes.get(mt).cloned() {
                    Some(TypeShape::Adt(vs)) => {
                        let names: Vec<String> = vs.iter().map(|(n, _)| Self::cstr(n)).collect();
                        let arity: Vec<String> =
                            vs.iter().map(|(_, f)| f.len().to_string()).collect();
                        let mut vf = Vec::new();
                        for (vi, (_, fields)) in vs.iter().enumerate() {
                            let ds: Vec<String> = fields
                                .iter()
                                .map(|f| format!("&d{}", self.desc_id(f)))
                                .collect();
                            vf.push(format!(
                                "static const fwp_desc *const d{}_v{}[] = {{{}}};",
                                id,
                                vi,
                                if ds.is_empty() {
                                    "0".to_string()
                                } else {
                                    ds.join(", ")
                                }
                            ));
                        }
                        let vrefs: Vec<String> =
                            (0..vs.len()).map(|vi| format!("d{}_v{}", id, vi)).collect();
                        // flags for typed JSON (runtime/fwp_rt_json.c)
                        let flag = match n.as_str() {
                            "std::Bool" => 1,
                            "std::Option" => 2,
                            "std::Json" => 3,
                            _ if matches!(
                                crate::jsontype::shape(mt, self.prog),
                                crate::jsontype::Shape::Untagged(..)
                            ) =>
                            {
                                4
                            }
                            _ => 0,
                        };
                        format!(
                            "static fwp_desc d{id};\n{vf}\nstatic const char *const d{id}_n[] = {{{names}}};\nstatic const int d{id}_a[] = {{{arity}}};\nstatic const fwp_desc *const *const d{id}_vf[] = {{{vrefs}}};\nstatic fwp_desc d{id} = {{K_ADT, {name}, {n}, d{id}_n, 0, d{id}_a, d{id}_vf, .width = {flag}}};",
                            id = id,
                            vf = vf.join("\n"),
                            names = names.join(", "),
                            arity = arity.join(", "),
                            vrefs = vrefs.join(", "),
                            name = Self::cstr(&short),
                            n = vs.len(),
                            flag = flag
                        )
                    }
                    Some(TypeShape::Record(fs)) => {
                        let d = self.record_desc(id, Some(&short), &fs, false);
                        // typed JSON (runtime/fwp_rt_json.c): `Duration` is
                        // a string; nominal records are written in
                        // declaration order, with the JSON names that field
                        // comments give
                        let mut pre = String::new();
                        let mut extra = String::new();
                        if n == "std::Duration" {
                            return d.replace(".width = 0}", ".width = 2}");
                        } else {
                            if let crate::jsontype::Shape::Record(_, _, _, json) =
                                crate::jsontype::shape(mt, self.prog)
                            {
                                if json.iter().zip(&fs).any(|(j, (l, _))| j != l) {
                                    let names: Vec<String> =
                                        json.iter().map(|j| Self::cstr(j)).collect();
                                    let _ = writeln!(
                                        pre,
                                        "static const char *const d{}_j[] = {{{}}};",
                                        id,
                                        names.join(", ")
                                    );
                                    let _ = write!(extra, ", .jnames = d{}_j", id);
                                }
                            }
                            if let Some(names) = self.prog.field_order.get(n) {
                                let order: Vec<String> = names
                                    .iter()
                                    .filter_map(|l| fs.iter().position(|(f, _)| f == l))
                                    .map(|i| i.to_string())
                                    .collect();
                                if order.len() == fs.len() && !fs.is_empty() {
                                    let _ = writeln!(
                                        pre,
                                        "static const int d{}_o[] = {{{}}};",
                                        id,
                                        order.join(", ")
                                    );
                                    let _ = write!(extra, ", .order = d{}_o", id);
                                }
                            }
                        }
                        let d = d.replace(".width = 0}", &format!(".width = 0{}}}", extra));
                        format!("{}{}", pre, d)
                    }
                    _ => simple("K_OPAQUE", &short),
                }
            }
        }
    }

    fn record_desc(
        &mut self,
        id: usize,
        name: Option<&str>,
        fs: &[(String, MT)],
        tuple: bool,
    ) -> String {
        let names: Vec<String> = fs.iter().map(|(l, _)| Self::cstr(l)).collect();
        let ds: Vec<String> = fs
            .iter()
            .map(|(_, t)| format!("&d{}", self.desc_id(t)))
            .collect();
        format!(
            "static fwp_desc d{id};\nstatic const char *const d{id}_n[] = {{{names}}};\nstatic const fwp_desc *const d{id}_f[] = {{{ds}}};\nstatic fwp_desc d{id} = {{K_RECORD, {name}, {n}, d{id}_n, d{id}_f, .width = {tuple}}};",
            id = id,
            names = if names.is_empty() { "0".into() } else { names.join(", ") },
            ds = if ds.is_empty() { "0".into() } else { ds.join(", ") },
            name = name.map(Self::cstr).unwrap_or_else(|| "0".into()),
            n = fs.len(),
            tuple = tuple as u8
        )
    }

    // ----- constants -------------------------------------------------------------

    fn string_const(&mut self, bytes: &[u8]) -> String {
        if let Some(i) = self.strings.get(bytes) {
            return format!("PTR(&s{})", i);
        }
        let id = self.string_defs.len();
        self.strings.insert(bytes.to_vec(), id);
        self.string_defs.push(format!(
            "static struct {{ uint64_t len; char d[{}]; }} s{} = {{{}, {}}};",
            bytes.len() + 1,
            id,
            bytes.len(),
            c_string_literal(bytes)
        ));
        format!("PTR(&s{})", id)
    }

    /// C expression for a constant value (complex values are built once at
    /// startup into a global).
    fn const_expr(&mut self, v: &Value) -> String {
        match v {
            Value::I8(x) => format!("(V)(int64_t){}", x),
            Value::I16(x) => format!("(V)(int64_t){}", x),
            Value::I32(x) => format!("(V)(int64_t){}", x),
            Value::I64(x) => {
                if *x == i64::MIN {
                    "(V)INT64_MIN".into()
                } else {
                    format!("(V)(int64_t){}LL", x)
                }
            }
            Value::U8(x) => format!("(V){}", x),
            Value::U16(x) => format!("(V){}", x),
            Value::U32(x) => format!("(V){}U", x),
            Value::U64(x) => format!("(V){}ULL", x),
            Value::F32(x) => format!("(V)0x{:x}U", x.to_bits()),
            Value::F64(x) => format!("(V)0x{:x}ULL", x.to_bits()),
            Value::TInt(x) => format!("(V)(int64_t){}LL", x),
            Value::Trit(x) => format!("(V)(int64_t){}", x),
            Value::Str(s) => self.string_const(s.as_bytes()),
            Value::Bytes(b) => self.string_const(b),
            Value::Data(tag, fs) if fs.is_empty() => format!("(V){}", tag),
            Value::Record(fs) if fs.is_empty() => "(V)0".into(),
            _ => {
                let id = self.consts.len();
                self.consts.push(format!("static V c{};", id));
                let init = self.const_build(v);
                let _ = writeln!(self.const_init, "    c{} = {};", id, init);
                format!("c{}", id)
            }
        }
    }

    fn const_build(&mut self, v: &Value) -> String {
        match v {
            Value::I128(x) => {
                let (hi, lo) = ((*x as u128 >> 64) as u64, *x as u128 as u64);
                format!("fwp_box_i128((i128)(((u128){}ULL << 64) | {}ULL))", hi, lo)
            }
            Value::U128(x) => {
                let (hi, lo) = ((x >> 64) as u64, *x as u64);
                format!("fwp_box_u128(((u128){}ULL << 64) | {}ULL)", hi, lo)
            }
            Value::Data(tag, fs) => {
                let parts: Vec<String> = fs.iter().map(|f| self.const_expr(f)).collect();
                format!(
                    "fwp_data({}, {}, (V[]){{{}}})",
                    tag,
                    fs.len(),
                    parts.join(", ")
                )
            }
            Value::Record(fs) => {
                let parts: Vec<String> = fs.iter().map(|f| self.const_expr(f)).collect();
                format!("fwp_record({}, (V[]){{{}}})", fs.len(), parts.join(", "))
            }
            Value::Array(items) => {
                let parts: Vec<String> = items.iter().map(|f| self.const_expr(f)).collect();
                format!(
                    "fwp_p_array_from_list(fwp_list_from((V[]){{{}}}, {}))",
                    if parts.is_empty() {
                        "0".into()
                    } else {
                        parts.join(", ")
                    },
                    items.len()
                )
            }
            Value::Map(m) => {
                let mut parts = Vec::new();
                for (k, v) in m.iter() {
                    parts.push(self.const_expr(k));
                    parts.push(self.const_expr(v));
                }
                format!(
                    "fwp_map_from_sorted({}, (V[]){{{}}})",
                    m.len(),
                    if parts.is_empty() {
                        "0".into()
                    } else {
                        parts.join(", ")
                    }
                )
            }
            Value::File(_) | Value::Native(_) => "0".into(),
            Value::Closure(c) => {
                self.used_closures[c.func] = true;
                let parts: Vec<String> = c.args.iter().map(|f| self.const_expr(f)).collect();
                if parts.is_empty() {
                    format!("PTR(&fc{})", c.func)
                } else {
                    format!(
                        "fwp_pap({}, {}, (V[]){{{}}})",
                        c.func,
                        parts.len(),
                        parts.join(", ")
                    )
                }
            }
            // scalars and strings are handled by `const_expr`
            _ => "0".into(),
        }
    }
}

/// Per-function code generation state.
struct FnGen<'g, 'p> {
    g: &'g mut Gen<'p>,
    out: String,
    tmp: usize,
    label: usize,
    indent: usize,
    /// Generating the step of a specialized loop (`Gen::loop_def`).
    in_loop: Option<LoopGen>,
    /// Locals kept as their fields (C expressions), read only through them.
    fields: HashMap<Local, Vec<String>>,
    /// The type of each local of the function.
    locals: Vec<MT>,
    /// The constructor a local is known to hold (in the arm of a match on
    /// it).
    known_tag: HashMap<Local, u32>,
    /// Locals holding a variant as a struct (`Abi::vret`), matched only:
    /// the C variable, the struct's size and the variant type.
    vlocals: HashMap<Local, (String, usize, MT)>,
    /// Cells of dropped unique values, which a constructor of the same size
    /// may take (innermost last).
    tokens: Vec<Token>,
    /// Children owned by temporary stack arguments until their call returns.
    stack_args: Vec<(String, MT)>,
    /// Off-heap local owners count their children directly.
    stack_children: HashMap<Local, Vec<(String, MT)>>,
    known_callbacks: HashMap<Local, (FuncId, usize)>,
    /// The function being generated.
    me: FuncId,
    tail_calls: std::collections::HashSet<*const Expr>,
    live_calls: HashMap<*const Expr, crate::rc::CallLiveness>,
}

/// A dropped value's cell, which a constructor of the same size may reuse
/// (`FnGen::reuse_token`).
struct Token {
    /// The C variable holding the cell, or 0 when the value was not unique.
    var: String,
    /// The C variable holding `fwp_rc_unique`'s answer (2: verify instead).
    unique: String,
    /// A cleanup node for the temporarily owned outer cell, if unwind is possible.
    cleanup: Option<(String, String)>,
    arity: usize,
    used: bool,
}

/// Whether `e` builds a record or a variant of `n` fields.
fn allocates(e: &Expr, n: usize) -> bool {
    let any = |xs: &[Expr]| xs.iter().any(|x| allocates(x, n));
    match e {
        Expr::Construct(_, xs) | Expr::Record(xs) => xs.len() == n || any(xs),
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => false,
        Expr::Call(_, xs) => any(xs),
        Expr::Apply(f, xs) => allocates(f, n) || any(xs),
        Expr::Field(r, _) => allocates(r, n),
        Expr::SetFields(r, xs) => allocates(r, n) || xs.iter().any(|(_, x)| allocates(x, n)),
        Expr::Let(_, v, b) => allocates(v, n) || allocates(b, n),
        Expr::Match(s, arms) => allocates(s, n) || arms.iter().any(|(_, b)| allocates(b, n)),
        Expr::Dup(_, b) | Expr::Drop(_, b) => allocates(b, n),
    }
}

/// A loop's step function generated with its state in arrays: its results
/// (`Again s` and `Stop r` in tail position) write the next state or the
/// result instead of being allocated.
struct LoopGen {
    tails: std::collections::HashSet<*const Expr>,
    record: bool,
    /// Per field of a record state: its first slot in the state arrays,
    /// and its number of fields when it is a record kept as its fields.
    slots: Vec<(usize, Option<usize>)>,
}

/// The signature of a higher-order primitive specialized for a function
/// that captures `k` values (`Gen::hofs`).
fn hof_sig(i: usize, sym: &str, k: usize) -> String {
    let caps: Vec<String> = (0..k).map(|j| format!("V c{}", j)).collect();
    let rest = match sym {
        "fold" | "fold-right" => "V z, V xs",
        "zip-with" => "V ys, V xs",
        "loop" => "V s",
        _ => "V xs",
    };
    format!("static V fwp_hof{}({}, {})", i, caps.join(", "), rest)
}

/// Its definition: the runtime's generic loop (runtime/fwp_rt_prims.c),
/// calling the function directly with the captured values first.
fn hof_def(
    i: usize,
    (sym, g, k): &(String, FuncId, usize),
    reuse: bool,
    loop_ops: Option<&str>,
    map_ops: Option<&str>,
    fold_drop: Option<&str>,
) -> String {
    let caps: String = (0..*k).map(|j| format!("c{}, ", j)).collect();
    // with counted references, what the runtime keeps is shared
    let call = |x: &str| shared(reuse, format!("f{}({}{})", g, caps, x));
    if reuse && sym == "loop" {
        let drop = fold_drop.expect("typed loop state");
        let ops = loop_ops.expect("owned loop operations");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(std::iter::once("s".into()))
            .collect::<Vec<_>>()
            .join(", ");
        let fences = (0..*k)
            .map(|j| format!(" FWP_KEEP_ALIVE(c{j});"))
            .collect::<String>();
        return format!("{} {{\n    fwp_value_owner owner = {{s, {drop}}}; fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup);\n    for (;;) {{\n        FWP_TICK();\n        s = owner.value;\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {k});\n        owner.value = 0;\n        V step = fwp_owned_entry{g}(args);\n        int stop = fwp_tag(step) != 0;\n        s = fwp_loop_payload(step, stop, {ops});\n        if (stop) {{{fences} fwp_value_finish(&owner, &cleanup); return s; }}\n        owner.value = s;\n    }}\n}}\n", hof_sig(i, sym, *k));
    }
    if reuse && sym == "map" {
        let ops = map_ops.expect("typed map result operations");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(std::iter::once("a[i]".to_string()))
            .collect::<Vec<_>>()
            .join(", ");
        let fences = (0..*k)
            .map(|j| format!("    FWP_KEEP_ALIVE(c{j});\n"))
            .collect::<String>();
        return format!("{} {{\n    size_t n;\n    V *a = fwp_map_items(xs, &n);\n    fwp_map_owner owner = {{a, 0, 0, {ops}}}; fwp_cleanup cleanup;\n    fwp_map_protect(&owner, &cleanup);\n    for (size_t i = 0; i < n; i++) {{\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        a[i] = fwp_owned_entry{g}(args);\n        owner.count++;\n    }}\n    V result = fwp_map_finish_protected(&owner, &cleanup);\n{fences}    FWP_KEEP_ALIVE(xs);\n    return result;\n}}\n", hof_sig(i, sym, *k), k + 1);
    }
    if reuse && sym == "filter" {
        let ops = map_ops.expect("typed filter result operations");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(std::iter::once("a[i]".to_string()))
            .collect::<Vec<_>>()
            .join(", ");
        let fences = (0..*k)
            .map(|j| format!("    FWP_KEEP_ALIVE(c{j});\n"))
            .collect::<String>();
        return format!("{} {{\n    size_t n, kept = 0;\n    V *a = fwp_map_items(xs, &n);\n    fwp_map_owner owner = {{a, 0, 0, {ops}}}; fwp_cleanup cleanup;\n    fwp_map_protect(&owner, &cleanup);\n    for (size_t i = 0; i < n; i++) {{\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        if (fwp_owned_entry{g}(args) == FWP_TRUE) {{\n            fwp_args{g}(&a[i], {k}, 1);\n            a[kept++] = a[i];\n            owner.count = kept;\n        }}\n    }}\n    V result = fwp_map_finish_protected(&owner, &cleanup);\n{fences}    FWP_KEEP_ALIVE(xs);\n    return result;\n}}\n", hof_sig(i, sym, *k), k + 1);
    }
    if reuse && matches!(sym.as_str(), "take-while" | "drop-while") {
        let element = if sym == "take-while" {
            "a[kept]"
        } else {
            "OBJ(xs)->f[0]"
        };
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(std::iter::once(element.to_string()))
            .collect::<Vec<_>>()
            .join(", ");
        let fences = (0..*k)
            .map(|j| format!("    FWP_KEEP_ALIVE(c{j});\n"))
            .collect::<String>();
        let body = if sym == "take-while" {
            let ops = map_ops.expect("typed take-while result operations");
            format!("size_t n, kept = 0;\n    V *a = fwp_map_items(xs, &n);\n    fwp_map_owner owner = {{a, 0, 0, {ops}}}; fwp_cleanup cleanup;\n    fwp_map_protect(&owner, &cleanup);\n    while (kept < n) {{\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        if (fwp_owned_entry{g}(args) != FWP_TRUE) break;\n        fwp_args{g}(&a[kept], {k}, 1);\n        kept++;\n        owner.count = kept;\n    }}\n    V result = fwp_map_finish_protected(&owner, &cleanup);\n{fences}    FWP_KEEP_ALIVE(xs);\n    return result;", k + 1)
        } else {
            format!("V source = xs;\n    while (xs) {{\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        if (fwp_owned_entry{g}(args) != FWP_TRUE) break;\n        xs = OBJ(xs)->f[1];\n    }}\n    fwp_rc_dup(xs);\n{fences}    FWP_KEEP_ALIVE(source);\n    return xs;", k + 1)
        };
        return format!("{} {{\n    {body}\n}}\n", hof_sig(i, sym, *k));
    }
    if reuse && sym == "find" {
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(std::iter::once("element".to_string()))
            .collect::<Vec<_>>()
            .join(", ");
        let fences = (0..*k)
            .map(|j| format!("    FWP_KEEP_ALIVE(c{j});\n"))
            .collect::<String>();
        return format!("{} {{\n    V source = xs, result = FWP_NONE;\n    while (xs) {{\n        V element = OBJ(xs)->f[0];\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        if (fwp_owned_entry{g}(args) == FWP_TRUE) {{\n            fwp_args{g}(&element, {k}, 1);\n            result = fwp_rc_fresh(fwp_some(element));\n            break;\n        }}\n        xs = OBJ(xs)->f[1];\n    }}\n{fences}    FWP_KEEP_ALIVE(source);\n    return result;\n}}\n", hof_sig(i, sym, *k), k + 1);
    }
    if reuse && sym == "fold" {
        let drop = fold_drop.expect("typed fold accumulator");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(["z".to_string(), "OBJ(xs)->f[0]".to_string()])
            .collect::<Vec<_>>()
            .join(", ");
        let fences = (0..*k)
            .map(|j| format!("    FWP_KEEP_ALIVE(c{j});\n"))
            .collect::<String>();
        return format!("{} {{\n    V source = xs;\n    fwp_value_owner owner = {{z, {drop}}}; fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup);\n    while (xs != 0) {{\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {k});\n        fwp_args{g}(args + {}, {}, 1);\n        owner.value = 0;\n        z = fwp_owned_entry{g}(args);\n        owner.value = z;\n        xs = OBJ(xs)->f[1];\n    }}\n{fences}    FWP_KEEP_ALIVE(source);\n    return fwp_value_finish(&owner, &cleanup);\n}}\n", hof_sig(i, sym, *k), k + 1, k + 1);
    }
    if reuse && sym == "zip-with" {
        let ops = map_ops.expect("typed zip-with result operations");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(["b[i]".to_string(), "a[i]".to_string()])
            .collect::<Vec<_>>()
            .join(", ");
        let fences = (0..*k)
            .map(|j| format!("    FWP_KEEP_ALIVE(c{j});\n"))
            .collect::<String>();
        return format!("{} {{\n    size_t n, m;\n    V *a = fwp_map_items(xs, &n);\n    fwp_map_owner owner = {{a, 0, 0, {ops}}}; fwp_cleanup cleanup;\n    fwp_map_protect(&owner, &cleanup);\n    V *b = fwp_map_items(ys, &m);\n    fwp_cleanup scratch_cleanup; fwp_scratch_protect(&b, &scratch_cleanup);\n    size_t len = n < m ? n : m;\n    for (size_t i = 0; i < len; i++) {{\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        a[i] = fwp_owned_entry{g}(args);\n        owner.count++;\n    }}\n    fwp_scratch_finish(&b, &scratch_cleanup);\n    V result = fwp_map_finish_protected(&owner, &cleanup);\n{fences}    FWP_KEEP_ALIVE(xs);\n    FWP_KEEP_ALIVE(ys);\n    return result;\n}}\n", hof_sig(i, sym, *k), k + 2);
    }
    if reuse && sym == "fold-right" {
        let drop = fold_drop.expect("typed right-fold accumulator");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(["a[i - 1]".to_string(), "z".to_string()])
            .collect::<Vec<_>>()
            .join(", ");
        let fences = (0..*k)
            .map(|j| format!("    FWP_KEEP_ALIVE(c{j});\n"))
            .collect::<String>();
        return format!("{} {{\n    fwp_value_owner owner = {{z, {drop}}}; fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup);\n    size_t n;\n    V *a = fwp_map_items(xs, &n);\n    fwp_cleanup scratch_cleanup; fwp_scratch_protect(&a, &scratch_cleanup);\n    for (size_t i = n; i > 0; i--) {{\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        owner.value = 0;\n        z = fwp_owned_entry{g}(args);\n        owner.value = z;\n    }}\n    fwp_scratch_finish(&a, &scratch_cleanup);\n{fences}    FWP_KEEP_ALIVE(xs);\n    return fwp_value_finish(&owner, &cleanup);\n}}\n", hof_sig(i, sym, *k), k + 1);
    }
    let body = match sym.as_str() {
        "map" => format!(
            "size_t n;\n    V *a = fwp_list_items(xs, &n);\n    for (size_t i = 0; i < n; i++) a[i] = {};\n    return fwp_list_from(a, n);",
            call("a[i]")
        ),
        "filter" => format!(
            "size_t n, k = 0;\n    V *a = fwp_list_items(xs, &n);\n    for (size_t i = 0; i < n; i++)\n        if ({} == FWP_TRUE) a[k++] = a[i];\n    return fwp_list_from(a, k);",
            call("a[i]")
        ),
        "fold" => format!(
            "while (xs != 0) {{ z = {}; xs = OBJ(xs)->f[1]; }}\n    return z;",
            call("z, OBJ(xs)->f[0]")
        ),
        "fold-right" => format!(
            "size_t n;\n    V *a = fwp_list_items(xs, &n);\n    for (size_t i = n; i > 0; i--) z = {};\n    return z;",
            call("a[i - 1], z")
        ),
        "take-while" => format!(
            "size_t n, k = 0;\n    V *a = fwp_list_items(xs, &n);\n    while (k < n && {} == FWP_TRUE) k++;\n    return fwp_list_from(a, k);",
            call("a[k]")
        ),
        "drop-while" => format!(
            "while (xs != 0 && {} == FWP_TRUE) xs = OBJ(xs)->f[1];\n    return xs;",
            call("OBJ(xs)->f[0]")
        ),
        "loop" => format!(
            "for (;;) {{\n        FWP_TICK();\n        V r = {};\n        if (fwp_tag(r) != 0) return OBJ(r)->f[0];\n        s = OBJ(r)->f[0];\n    }}",
            call("s")
        ),
        _ => format!(
            "size_t n, m;\n    V *a = fwp_list_items(xs, &n);\n    V *b = fwp_list_items(ys, &m);\n    size_t k = n < m ? n : m;\n    for (size_t i = 0; i < k; i++) a[i] = {};\n    return fwp_list_from(a, k);",
            call("b[i], a[i]")
        ),
    };
    format!(
        "/* {} of a function capturing {} values */\n{} {{\n    {}\n}}\n",
        sym,
        k,
        hof_sig(i, sym, *k),
        body
    )
}

/// The tail positions of an expression: what it can evaluate to last.
fn tails<'e>(e: &'e Expr, out: &mut Vec<&'e Expr>) {
    match e {
        Expr::Let(_, _, body) | Expr::Dup(_, body) | Expr::Drop(_, body) => tails(body, out),
        Expr::Match(_, arms) => {
            for (_, b) in arms {
                tails(b, out);
            }
        }
        _ => out.push(e),
    }
}

fn tail_calls(e: &Expr) -> std::collections::HashSet<*const Expr> {
    let mut out = Vec::new();
    tails(e, &mut out);
    out.into_iter()
        .filter(|e| matches!(e, Expr::Call(..) | Expr::Apply(..)))
        .map(|e| e as *const Expr)
        .collect()
}

/// Integer types of at most 64 bits, which a `V` holds sign-extended
/// (`Some(true)`) or zero-extended (`Some(false)`).
fn int64_kind(t: &MT) -> Option<bool> {
    let MT::Con(n, a) = t else { return None };
    if !a.is_empty() {
        return None;
    }
    match n.trim_start_matches("std::") {
        "I8" | "I16" | "I32" | "I64" | "ISize" => Some(true),
        "U8" | "U16" | "U32" | "U64" | "USize" => Some(false),
        _ => None,
    }
}

/// Whether local 0 is used only as `Field(Local(0), _)`.
fn state_by_fields(e: &Expr) -> bool {
    match e {
        // the state's own references: no object when it is kept by fields
        Expr::Dup(_, b) | Expr::Drop(_, b) => state_by_fields(b),
        Expr::Local(0) => false,
        Expr::Field(r, _) if matches!(**r, Expr::Local(0)) => true,
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => true,
        Expr::Call(_, xs) | Expr::Construct(_, xs) | Expr::Record(xs) => {
            xs.iter().all(state_by_fields)
        }
        Expr::Apply(f, xs) => state_by_fields(f) && xs.iter().all(state_by_fields),
        Expr::Field(r, _) => state_by_fields(r),
        Expr::SetFields(r, sets) => {
            state_by_fields(r) && sets.iter().all(|(_, x)| state_by_fields(x))
        }
        Expr::Let(_, v, b) => state_by_fields(v) && state_by_fields(b),
        Expr::Match(s, arms) => state_by_fields(s) && arms.iter().all(|(_, b)| state_by_fields(b)),
    }
}

// RC names an owned state argument after preparing its fields. Move only
// that immediately consumed record's terminal Again through its preparation
// spine, preserving the evaluation and release order of every field.
fn again_record(e: &Expr) -> Option<Expr> {
    Some(match e {
        Expr::Record(_) => Expr::Construct(0, vec![e.clone()]),
        Expr::Let(l, v, b) => Expr::Let(*l, v.clone(), Box::new(again_record(b)?)),
        Expr::Dup(l, b) => Expr::Dup(*l, Box::new(again_record(b)?)),
        Expr::Drop(l, b) => Expr::Drop(*l, Box::new(again_record(b)?)),
        _ => return None,
    })
}

fn loop_state_expr(e: &Expr) -> Expr {
    match e {
        Expr::Construct(0, xs) if xs.len() == 1 => {
            again_record(&xs[0]).unwrap_or_else(|| e.clone())
        }
        Expr::Let(l, v, b) => {
            if let Expr::Construct(0, xs) = &**b {
                if xs.len() == 1 && matches!(xs[0], Expr::Local(k) if k == *l) {
                    if let Some(prepared) = again_record(v) {
                        return prepared;
                    }
                }
            }
            Expr::Let(*l, v.clone(), Box::new(loop_state_expr(b)))
        }
        Expr::Dup(l, b) => Expr::Dup(*l, Box::new(loop_state_expr(b))),
        Expr::Drop(l, b) => Expr::Drop(*l, Box::new(loop_state_expr(b))),
        Expr::Match(s, arms) => Expr::Match(
            s.clone(),
            arms.iter()
                .map(|(p, b)| (p.clone(), loop_state_expr(b)))
                .collect(),
        ),
        _ => e.clone(),
    }
}

/// How a `loop` with this step function can run in C: `None` if it
/// cannot (it is not a known one-argument function whose every result is
/// a literal `Again x` or `Stop x`); `Some(Some(n))` when the state is a
/// record of n fields that the step reads only field by field and always
/// rebuilds, so it lives in n locals; `Some(None)` when the state stays
/// one value. Either way, no `Step` is allocated.
fn loop_shape(f: &Func) -> Option<Option<usize>> {
    let Body::Expr(e) = &f.body else { return None };
    if f.arity != 1 {
        return None;
    }
    let e = loop_state_expr(e);
    let mut ts = Vec::new();
    tails(&e, &mut ts);
    let mut fields = None;
    let mut all_records = true;
    for t in &ts {
        match t {
            Expr::Construct(0, xs) if xs.len() == 1 => match &xs[0] {
                Expr::Record(fs) if !fs.is_empty() && fields.is_none_or(|n| n == fs.len()) => {
                    fields = Some(fs.len())
                }
                _ => all_records = false,
            },
            Expr::Construct(1, xs) if xs.len() == 1 => {}
            _ => return None,
        }
    }
    if all_records && fields.is_some() && state_by_fields(&e) {
        Some(fields)
    } else {
        Some(None)
    }
}

impl<'g, 'p> FnGen<'g, 'p> {
    fn line(&mut self, s: &str) {
        for _ in 0..self.indent {
            self.out.push_str("    ");
        }
        self.out.push_str(s);
        self.out.push('\n');
    }

    fn fresh(&mut self) -> String {
        self.tmp += 1;
        format!("t{}", self.tmp)
    }

    fn bind(&mut self, rhs: String) -> String {
        let t = self.fresh();
        self.line(&format!("V {} = {};", t, rhs));
        t
    }

    fn args(&mut self, args: &[Expr]) -> Vec<String> {
        args.iter().map(|a| self.expr(a)).collect()
    }

    fn array(xs: &[String]) -> String {
        format!("(V[]){{{}}}", xs.join(", "))
    }

    /// The arguments of a direct call of a function's worker, in
    /// evaluation order: a record passed field by field is not built.
    fn worker_args(&mut self, g: FuncId, abi: &Abi, args: &[Expr]) -> Vec<String> {
        let mut out = Vec::new();
        for (j, (a, p)) in args.iter().zip(&abi.params).enumerate() {
            match p {
                Some(n) => out.extend(self.expr_fields(a, *n)),
                None => out.push(self.arg(g, j, a)),
            }
        }
        out
    }

    /// In a loop's step, a field of the state kept as its own fields: its
    /// first slot and its number of fields.
    fn state_field(&self, e: &Expr) -> Option<(usize, usize)> {
        let lg = self.in_loop.as_ref().filter(|lg| lg.record)?;
        match e {
            Expr::Field(r, i) if matches!(**r, Expr::Local(0)) => match lg.slots[*i as usize] {
                (off, Some(m)) => Some((off, m)),
                _ => None,
            },
            _ => None,
        }
    }

    /// The number of fields of a record `e` can give without building it.
    fn unboxed(&self, e: &Expr) -> Option<usize> {
        if let Some((_, m)) = self.state_field(e) {
            return Some(m);
        }
        match e {
            Expr::Dup(_, b) | Expr::Drop(_, b) => self.unboxed(b),
            Expr::Local(l) if self.fields.contains_key(l) => Some(self.fields[l].len()),
            // `let x = v in x` (with its reference counts)
            Expr::Let(x, v, b) if is_local_through_counts(b, *x) => self.unboxed(v),
            Expr::Call(id, _) => self.g.abis[*id].as_ref()?.ret,
            Expr::Record(xs) if (1..=MAX_UNBOXED).contains(&xs.len()) => Some(xs.len()),
            Expr::Let(_, _, b) => self.unboxed(b),
            Expr::Match(_, arms) => {
                let n = self.unboxed(&arms.first()?.1)?;
                arms.iter()
                    .all(|(_, b)| self.unboxed(b) == Some(n))
                    .then_some(n)
            }
            _ => None,
        }
    }

    /// The `n` fields of the record `e`, as C expressions, building it
    /// only when it comes from elsewhere.
    fn expr_fields(&mut self, e: &Expr, n: usize) -> Vec<String> {
        if let Some((off, m)) = self.state_field(e).filter(|(_, m)| *m == n) {
            return (off..off + m).map(|k| format!("st[{}]", k)).collect();
        }
        match e {
            Expr::Local(l) if self.fields.get(l).is_some_and(|fs| fs.len() == n) => {
                self.fields[l].clone()
            }
            Expr::Record(xs) if xs.len() == n => self.args(xs),
            Expr::Call(id, args) if self.g.abis[*id].as_ref().and_then(|a| a.ret) == Some(n) => {
                let abi = self.g.abis[*id].clone().unwrap();
                let outer = std::mem::take(&mut self.stack_args);
                let xs = self.worker_args(*id, &abi, args);
                self.tail_tokens(self.tail_calls.contains(&(e as *const Expr)));
                let t = self.fresh();
                let node = self.begin_call(e as *const Expr);
                self.line(&format!("fwp_r{} {} = w{}({});", n, t, id, xs.join(", ")));
                self.end_call(node);
                self.stack_args_finish(outer);
                (0..n).map(|k| format!("{}.f[{}]", t, k)).collect()
            }
            Expr::Let(x, v, b) if is_local_through_counts(b, *x) && self.unboxed(v) == Some(n) => {
                let fs = self.expr_fields(v, n);
                let names: Vec<String> = fs.into_iter().map(|f| self.bind(f)).collect();
                self.fields.insert(*x, names);
                self.expr_fields(b, n)
            }
            Expr::Let(l, v, b) => {
                let b = self.bind_local(*l, v, b);
                self.expr_fields(b, n)
            }
            Expr::Drop(l, b) if self.g.reuse && !self.fields.contains_key(l) => {
                match self.reuse_token(*l, b) {
                    Some(t) => {
                        self.tokens.push(t);
                        let r = self.expr_fields(b, n);
                        self.finish_token();
                        r
                    }
                    None => {
                        self.count(e, *l);
                        self.expr_fields(b, n)
                    }
                }
            }
            Expr::Dup(l, b) | Expr::Drop(l, b) => {
                self.count(e, *l);
                self.expr_fields(b, n)
            }
            Expr::Match(scrut, arms) if self.unboxed(e) == Some(n) => {
                let s = self.scrutinee(scrut);
                let rs: Vec<String> = (0..n).map(|_| self.fresh()).collect();
                for r in &rs {
                    self.line(&format!("V {};", r));
                }
                self.label += 1;
                let done = format!("done{}", self.label);
                let before = self.arms_start();
                let mut after = before.clone();
                for (pat, body) in arms {
                    self.label += 1;
                    let next = format!("next{}", self.label);
                    self.line("{");
                    self.indent += 1;
                    self.match_pattern(scrut, pat, &s, &next);
                    let known = self.arm_start(scrut, pat, &before);
                    let fs = self.expr_fields(body, n);
                    self.arm_end(known, &mut after);
                    for (r, f) in rs.iter().zip(fs) {
                        self.line(&format!("{} = {};", r, f));
                    }
                    self.line(&format!("goto {};", done));
                    self.indent -= 1;
                    self.line("}");
                    self.line(&format!("{}:;", next));
                }
                self.line("fwp_trap(\"internal: no match arm applies\");");
                self.line(&format!("{}:;", done));
                self.arms_end(&after);
                rs
            }
            _ => {
                let v = self.expr(e);
                let t = self.bind(v);
                let mut fs: Vec<String> = (0..n).map(|k| format!("OBJ({})->f[{}]", t, k)).collect();
                if self.g.reuse {
                    // read before the record may be freed
                    fs = fs.into_iter().map(|f| self.bind(f)).collect();
                    // the reference to the record becomes one to each field
                    // (their owner gives each up on its own)
                    let ty = {
                        let funcs = &self.g.prog.funcs;
                        let func = |id: FuncId| &funcs[id].ty;
                        crate::ir::type_of(&func, &self.g.prog.shapes, &self.locals, e)
                    };
                    let remaining = self.begin_call(e as *const Expr);
                    let original_values = self.stack_alias(e).unwrap_or_else(|| {
                        vec![(t.clone(), ty.clone().unwrap_or_else(|| MT::con("?")))]
                    });
                    let original = self.begin_values(&original_values);
                    let tys: Option<Vec<MT>> = ty.as_ref().and_then(|t| {
                        record_fields(&self.g.prog.shapes, t)
                            .map(|fs| fs.iter().map(|(_, t)| t.clone()).collect())
                    });
                    let values: Vec<_> = fs
                        .iter()
                        .enumerate()
                        .map(|(k, value)| {
                            let ty = tys
                                .as_ref()
                                .and_then(|ts| ts.get(k))
                                .cloned()
                                .unwrap_or_else(|| MT::con("?"));
                            (value.clone(), ty)
                        })
                        .collect();
                    let ctx = self.fresh();
                    let node = self.fresh();
                    let retained = self.g.duplicate_values(&values, &ctx, &node);
                    self.line(&retained);
                    self.end_call(original);
                    let d = ty
                        .and_then(|t| self.typed_drop(&t))
                        .unwrap_or_else(|| "fwp_rc_drop".into());
                    if let Some(children) = self.stack_alias(e) {
                        self.stack_children_count(children, false);
                    } else {
                        self.line(&format!("{}({});", d, t));
                    }
                    self.end_call(remaining);
                }
                fs
            }
        }
    }

    /// The result type of function `id`.
    fn ret_type(&self, id: FuncId) -> MT {
        let f = &self.g.prog.funcs[id];
        f.ty.params(f.arity as usize).1.clone()
    }

    /// The size of the struct a variant `e` of type `ty` gives without
    /// being built: every tail of `e` builds a constructor or calls a
    /// worker returning one (`Abi::vret`), and at least one is not a
    /// constructor applied to nothing.
    fn unboxed_variant(&self, e: &Expr, ty: &MT) -> Option<usize> {
        if !variant_returns_enabled() {
            return None;
        }
        let m = small_variant(self.g.prog, ty)?;
        fn produces(
            fg: &FnGen<'_, '_>,
            e: &Expr,
            m: usize,
            known: &HashMap<Local, bool>,
        ) -> Option<bool> {
            match e {
                Expr::Let(l, v, b) => {
                    let mut known = known.clone();
                    if let Some(fields) = produces(fg, v, m, &known) {
                        known.insert(*l, fields);
                    }
                    produces(fg, b, m, &known)
                }
                Expr::Drop(_, b) | Expr::Dup(_, b) => produces(fg, b, m, known),
                Expr::Match(_, arms) => {
                    let mut fields = false;
                    for (_, b) in arms {
                        fields |= produces(fg, b, m, known)?;
                    }
                    Some(fields)
                }
                Expr::Construct(_, xs) => Some(!xs.is_empty()),
                Expr::Call(id, _) if fg.g.abis[*id].as_ref().and_then(|a| a.vret) == Some(m) => {
                    Some(true)
                }
                Expr::Local(l) => known.get(l).copied(),
                _ => None,
            }
        }
        (produces(self, e, m, &HashMap::new())? && !matches!(e, Expr::Construct(..))).then_some(m)
    }

    /// The tag and fields (C expressions) of `e`, a variant of type `ty`
    /// returned as a struct `fwp_u<m>`, without building it. The fields
    /// hold the references the value would.
    fn expr_variant(&mut self, e: &Expr, m: usize, ty: &MT) -> (String, Vec<String>) {
        let parts = |u: &str| -> (String, Vec<String>) {
            (
                format!("{}.tag", u),
                (0..m).map(|k| format!("{}.f[{}]", u, k)).collect(),
            )
        };
        match e {
            Expr::Construct(tag, xs) => {
                let mut fs = self.args(xs);
                fs.resize(m, "0".into());
                (format!("(V){}", tag), fs)
            }
            Expr::Local(l) if self.vlocals.contains_key(l) => {
                let u = self.vlocals[l].0.clone();
                parts(&u)
            }
            Expr::Call(id, args) if self.g.abis[*id].as_ref().and_then(|a| a.vret) == Some(m) => {
                let abi = self.g.abis[*id].clone().unwrap();
                let outer = std::mem::take(&mut self.stack_args);
                let xs = self.worker_args(*id, &abi, args);
                self.tail_tokens(self.tail_calls.contains(&(e as *const Expr)));
                let t = self.fresh();
                let node = self.begin_call(e as *const Expr);
                self.line(&format!("fwp_u{} {} = w{}({});", m, t, id, xs.join(", ")));
                self.end_call(node);
                self.stack_args_finish(outer);
                parts(&t)
            }
            Expr::Let(l, v, b) => {
                // A returned alias transfers the existing field owners. Boxing
                // it would retain an extra set whose original has been consumed.
                if variant_uses(b, *l, true) {
                    if let Expr::Local(source) = &**v {
                        if let Some(value) = self.vlocals.get(source).cloned() {
                            self.vlocals.insert(*l, value);
                            return self.expr_variant(b, m, ty);
                        }
                    }
                }
                let local_ty = self.locals[*l as usize].clone();
                if self.unboxed_variant(v, &local_ty) == Some(m) && variant_uses(b, *l, true) {
                    let (tag, fields) = self.expr_variant(v, m, &local_ty);
                    let u = self.fresh();
                    self.line(&format!(
                        "fwp_u{m} {u} = {{{tag}, {{{}}}}};",
                        fields.join(", ")
                    ));
                    self.vlocals.insert(*l, (u, m, local_ty));
                    self.expr_variant(b, m, ty)
                } else {
                    let b = self.bind_local(*l, v, b);
                    self.expr_variant(b, m, ty)
                }
            }
            Expr::Drop(l, b)
                if self.g.reuse
                    && !self.fields.contains_key(l)
                    && !self.vlocals.contains_key(l) =>
            {
                match self.reuse_token(*l, b) {
                    Some(t) => {
                        self.tokens.push(t);
                        let r = self.expr_variant(b, m, ty);
                        self.finish_token();
                        r
                    }
                    None => {
                        self.count(e, *l);
                        self.expr_variant(b, m, ty)
                    }
                }
            }
            Expr::Dup(l, b) | Expr::Drop(l, b) => {
                self.count(e, *l);
                self.expr_variant(b, m, ty)
            }
            Expr::Match(scrut, arms) => {
                let s = self.scrutinee(scrut);
                let u = self.fresh();
                self.line(&format!("fwp_u{} {};", m, u));
                self.label += 1;
                let done = format!("done{}", self.label);
                let before = self.arms_start();
                let mut after = before.clone();
                for (pat, body) in arms {
                    self.label += 1;
                    let next = format!("next{}", self.label);
                    self.line("{");
                    self.indent += 1;
                    self.match_pattern(scrut, pat, &s, &next);
                    let known = self.arm_start(scrut, pat, &before);
                    let (tag, fs) = self.expr_variant(body, m, ty);
                    self.arm_end(known, &mut after);
                    self.line(&format!("{}.tag = {};", u, tag));
                    for (k, f) in fs.iter().enumerate() {
                        self.line(&format!("{}.f[{}] = {};", u, k, f));
                    }
                    self.line(&format!("goto {};", done));
                    self.indent -= 1;
                    self.line("}");
                    self.line(&format!("{}:;", next));
                }
                self.line("fwp_trap(\"internal: no match arm applies\");");
                self.line(&format!("{}:;", done));
                self.arms_end(&after);
                parts(&u)
            }
            _ => {
                // a value: read into a struct, whose fields take over the
                // reference to it
                let v = self.expr(e);
                let t = self.bind(v);
                let remaining = self.begin_call(e as *const Expr);
                let original_values = self
                    .stack_alias(e)
                    .unwrap_or_else(|| vec![(t.clone(), ty.clone())]);
                let original = self.begin_values(&original_values);
                let u = self.fresh();
                self.line(&format!("fwp_u{} {} = fwp_vunbox{}({});", m, u, m, t));
                if self.g.reuse {
                    let k = self.g.vhelper(ty, m);
                    self.line(&format!("fwp_vdup{}(&{});", k, u));
                    self.end_call(original);
                    let d = self.typed_drop(ty).unwrap_or_else(|| "fwp_rc_drop".into());
                    if let Some(children) = self.stack_alias(e) {
                        self.stack_children_count(children, false);
                    } else {
                        self.line(&format!("{}({});", d, t));
                    }
                }
                self.end_call(remaining);
                parts(&u)
            }
        }
    }

    /// The C variable a match tests: the struct of a local kept as one, or
    /// the value of `scrut`.
    fn scrutinee(&mut self, scrut: &Expr) -> String {
        if let Expr::Local(l) = scrut {
            if let Some((u, _, _)) = self.vlocals.get(l) {
                return u.clone();
            }
        }
        let sv = self.expr(scrut);
        self.bind(sv)
    }

    /// `pattern`, on the scrutinee `s` that `scrutinee` gave.
    fn match_pattern(&mut self, scrut: &Expr, p: &Pat, s: &str, fail: &str) {
        if let Expr::Local(l) = scrut {
            if let Some((u, m, t)) = self.vlocals.get(l).cloned() {
                match p {
                    Pat::Construct(tag, ps) => {
                        self.line(&format!(
                            "if ((uint32_t){}.tag != {}) goto {};",
                            u, tag, fail
                        ));
                        for (i, sp) in ps.iter().enumerate() {
                            if !matches!(sp, Pat::Wild) {
                                let fv = format!("{}.f[{}]", u, i);
                                self.pattern(sp, &fv, fail);
                            }
                        }
                    }
                    Pat::Wild => {}
                    // (not kept as a struct when bound whole; built here)
                    _ => {
                        let v = self.vlocal_value(&u, m, &t);
                        self.pattern(p, &v, fail);
                    }
                }
                return;
            }
        }
        self.pattern(p, s, fail);
    }

    /// A variant kept as a struct, built as a value of its own (with its
    /// own references to the fields).
    fn vlocal_value(&mut self, u: &str, m: usize, t: &MT) -> String {
        let k = self.g.vhelper(t, m);
        let c = self.fresh();
        self.line(&format!("fwp_u{} {} = {};", m, c, u));
        if self.g.reuse {
            self.line(&format!("fwp_vdup{}(&{});", k, c));
        }
        self.bind(format!("fwp_vbox{}({})", k, c))
    }

    /// `l = v` before `body`: a record that `body` reads only through its
    /// fields and that `v` gives unboxed is kept as its fields. Returns the
    /// rest of `body` to generate (a copy that reuses its original takes
    /// the original's `Drop`).
    fn bind_local<'e>(&mut self, l: Local, v: &Expr, body: &'e Expr) -> &'e Expr {
        if let Some((g, n)) = self.callback_origin(v) {
            self.known_callbacks.insert(l, (g, n));
        } else {
            self.known_callbacks.remove(&l);
        }
        // Moving a variant through a named ownership temporary need not box
        // it when all uses of the destination remain matches/count operations.
        if let Expr::Local(source) = v {
            if only_matched(body, l) {
                if let Some(value) = self.vlocals.get(source).cloned() {
                    self.vlocals.insert(l, value);
                    return body;
                }
            }
        }
        // a variant built or returned as a struct on every path, only
        // matched: kept as one
        if let Some(m) = self.unboxed_variant(v, &self.locals[l as usize].clone()) {
            if only_matched(body, l) {
                let t = self.locals[l as usize].clone();
                let (tag, fs) = self.expr_variant(v, m, &t);
                let u = self.fresh();
                self.line(&format!(
                    "fwp_u{} {} = {{{}, {{{}}}}};",
                    m,
                    u,
                    tag,
                    fs.join(", ")
                ));
                self.vlocals.insert(l, (u, m, t));
                return body;
            }
        }
        if let Some(n) = self.unboxed(v) {
            if !matches!(v, Expr::Record(_)) && crate::opt::only_fields(body, l) {
                let fs = self.expr_fields(v, n);
                let names: Vec<String> = fs.into_iter().map(|f| self.bind(f)).collect();
                self.fields.insert(l, names);
                return body;
            }
        }
        // `l = {x with ...}` where `x` dies right after: written in place
        // when it is unique
        if let (Expr::SetFields(r, sets), Expr::Drop(d, rest)) = (v, body) {
            if let Expr::Local(x) = **r {
                if self.g.reuse
                    && x == *d
                    && !self.fields.contains_key(&x)
                    && !self.stack_children.contains_key(&x)
                {
                    let xs: Vec<(u32, String)> =
                        sets.iter().map(|(i, e)| (*i, self.expr(e))).collect();
                    let u = self.fresh();
                    self.line(&format!("int {} = fwp_rc_unique(l{});", u, x));
                    self.line(&format!("if ({} == 1) {{", u));
                    let original_ty = self.locals[x as usize].clone();
                    let original_fields = record_fields(&self.g.prog.shapes, &original_ty)
                        .unwrap()
                        .to_vec();
                    for (i, xv) in &xs {
                        if let Some(drop) = self.typed_drop(&original_fields[*i as usize].1) {
                            self.line(&format!("{drop}(OBJ(l{x})->f[{i}]);"));
                        }
                        self.line(&format!("    OBJ(l{})->f[{}] = {};", x, i, xv));
                    }
                    self.line(&format!("    l{} = l{};", l, x));
                    self.line("} else {");
                    let copy = self.record_update(v, r, &format!("l{x}"), sets, &xs);
                    self.line(&format!("l{l} = {copy};"));
                    let t = self.locals[x as usize].clone();
                    let d = self.typed_drop(&t).unwrap_or_else(|| "fwp_rc_drop".into());
                    self.line(&format!("{d}(l{x});"));
                    self.line("}");
                    return rest;
                }
            }
        }
        // `l = (y = a; ... aggregate/closure ..)`: evaluate y first, then
        // choose the lifetime of l without hiding its final allocation.
        if let Expr::Let(y, a, rest) = v {
            if ends_in_object(rest) {
                let rest = self.bind_local(*y, a, rest);
                return self.bind_local(l, rest, body);
            }
        }
        // a record, variant or closure that does not outlive `body`: on
        // the stack
        if self.stackable(v)
            && stack_enabled()
            && !crate::escape::escapes(body, l, &self.g.noesc, Some(self.me))
        {
            let types = self.stack_types(v, &self.locals[l as usize]);
            let outer = std::mem::take(&mut self.stack_args);
            let x = self.stack_object(v, types.clone());
            let children = std::mem::replace(&mut self.stack_args, outer);
            if types.is_some() {
                self.stack_children.insert(l, children);
            }
            self.line(&format!("l{} = {};", l, x));
            return body;
        }
        let x = self.expr(v);
        if let Some(children) = self.stack_alias(v) {
            self.stack_children.insert(l, children);
        }
        self.line(&format!("l{} = {};", l, x));
        // RC's field read duplicates a borrowed existing record. A flattened
        // state field was instead just rebuilt with owned children and a fresh
        // outer reference; that reference already fulfils this initial Dup.
        if self.g.reuse && self.state_field(v).is_some() {
            if let Expr::Dup(duplicate, rest) = body {
                if *duplicate == l {
                    return rest;
                }
            }
        }
        body
    }

    /// An argument of a call of `g` at parameter `j`: a record or variant
    /// built for a parameter that does not escape is built on the stack.
    fn arg(&mut self, g: FuncId, j: usize, a: &Expr) -> String {
        if let Some(children) = self.stack_alias(a) {
            let value = self.expr(a);
            if crate::rc::consumes_arg(&self.g.prog.funcs, g, j) {
                self.stack_args.extend(children);
            }
            return value;
        }
        if self.stackable(a)
            && g != self.me
            && stack_enabled()
            && self.g.noesc[g].get(j).copied().unwrap_or(false)
        {
            let ty = self.g.prog.funcs[g].ty.params(j + 1).0[j].clone();
            let types = self.stack_types(a, &ty);
            if let Some(types) = types {
                return self.stack_object(a, Some(types));
            }
        }
        self.expr(a)
    }

    /// A borrowed pointer stays a conservative root through the call.
    /// Inlining can otherwise replace its later drop with metadata access
    /// and discard the allocation's address before an allocating primitive.
    fn keep_borrowed_args(&mut self, id: FuncId, args: &[String]) {
        let f = &self.g.prog.funcs[id];
        let Body::Prim(symbol) = &f.body else { return };
        let Some(contract) = crate::ownership::primitive(symbol) else {
            return;
        };
        let roots: Vec<String> =
            f.ty.params(args.len())
                .0
                .iter()
                .enumerate()
                .filter(|(i, t)| {
                    contract.argument(*i) == crate::ownership::Argument::Borrow
                        && crate::rc::needs_rc(&self.g.prog.shapes, t)
                })
                .map(|(i, _)| args[i].clone())
                .collect();
        for root in roots {
            self.line(&format!("FWP_KEEP_ALIVE({root});"));
        }
    }

    /// Whether `v` builds an object that can live on the stack: a record
    /// or variant with fields, or a closure (a known function applied to
    /// fewer arguments than it takes).
    fn stackable(&self, v: &Expr) -> bool {
        match v {
            Expr::Record(xs) | Expr::Construct(_, xs) => !xs.is_empty(),
            Expr::Apply(f, xs) => match **f {
                Expr::Func(g) => !xs.is_empty() && xs.len() < self.g.prog.funcs[g].arity as usize,
                _ => false,
            },
            _ => false,
        }
    }

    /// Concrete field/capture types for ownership of a stack object.
    fn stack_types(&self, a: &Expr, ty: &MT) -> Option<Vec<MT>> {
        match a {
            Expr::Apply(f, captures) => {
                let Expr::Func(id) = **f else { unreachable!() };
                Some(
                    self.g.prog.funcs[id]
                        .ty
                        .params(captures.len())
                        .0
                        .into_iter()
                        .cloned()
                        .collect(),
                )
            }
            Expr::Record(_) => record_fields(&self.g.prog.shapes, ty)
                .map(|fields| fields.iter().map(|(_, t)| t.clone()).collect()),
            Expr::Construct(tag, _) => match self.g.prog.shapes.get(ty) {
                Some(TypeShape::Adt(variants)) => variants
                    .get(*tag as usize)
                    .map(|(_, fields)| fields.clone()),
                Some(TypeShape::Record(fields)) => {
                    Some(fields.iter().map(|(_, t)| t.clone()).collect())
                }
                _ => None,
            },
            _ => None,
        }
    }

    fn stack_alias(&self, e: &Expr) -> Option<Vec<(String, MT)>> {
        match e {
            Expr::Local(l) => self.stack_children.get(l).cloned(),
            Expr::Dup(_, b) | Expr::Drop(_, b) | Expr::Let(_, _, b) => self.stack_alias(b),
            _ => None,
        }
    }

    /// Build the existing record/closure layout in the C frame. The owning
    /// frame tracks children; off-heap pointers keep no runtime count slot.
    fn stack_object(&mut self, v: &Expr, owned_children: Option<Vec<MT>>) -> String {
        let (tag, args) = match v {
            Expr::Record(args) => (0, args),
            Expr::Construct(tag, args) => (*tag, args),
            // a closure (`fwp_clo`, the same layout): the function and
            // what it captured, which the runtime may keep
            Expr::Apply(f, args) => {
                let Expr::Func(g) = **f else { unreachable!() };
                self.g.used_closures[g] = true;
                let xs = self.args(args);
                if let Some(types) = owned_children {
                    self.stack_arg_children(&xs, &types);
                } else {
                    self.share(&xs);
                }
                let s = self.fresh();
                self.line(&format!(
                    "struct {{ uint32_t fn; uint32_t n; V a[{n}]; }} {s} = {{{g}, {n}, {{{xs}}}}};",
                    n = xs.len(),
                    s = s,
                    g = g,
                    xs = xs.join(", ")
                ));
                return self.bind(format!("PTR(&{})", s));
            }
            _ => unreachable!(),
        };
        let xs = self.args(args);
        if let Some(types) = owned_children {
            self.stack_arg_children(&xs, &types);
        }
        let s = self.fresh();
        self.line(&format!(
            "struct {{ uint32_t tag; uint32_t n; V f[{n}]; }} {s} = {{{tag}, {n}, {{{xs}}}}};",
            n = xs.len(),
            s = s,
            tag = tag,
            xs = xs.join(", ")
        ));
        self.bind(format!("PTR(&{})", s))
    }

    fn stack_arg_children(&mut self, values: &[String], types: &[MT]) {
        assert_eq!(values.len(), types.len());
        if self.g.reuse {
            self.stack_args.extend(
                values
                    .iter()
                    .zip(types)
                    .filter(|(_, ty)| crate::rc::needs_rc(&self.g.prog.shapes, ty))
                    .map(|(value, ty)| (value.clone(), ty.clone())),
            );
        }
    }

    fn stack_args_finish(&mut self, outer: Vec<(String, MT)>) {
        let children = std::mem::replace(&mut self.stack_args, outer);
        self.stack_children_count(children, false);
    }

    fn stack_children_count(&mut self, children: Vec<(String, MT)>, duplicate: bool) {
        if duplicate {
            let ctx = self.fresh();
            let node = self.fresh();
            let retained = self.g.duplicate_values(&children, &ctx, &node);
            self.line(&retained);
            return;
        }
        for (value, ty) in children {
            self.line(&format!(
                "/* stack argument child */ FWP_KEEP_ALIVE({value});"
            ));
            let release = self.typed_drop(&ty).unwrap_or_else(|| "fwp_rc_drop".into());
            self.line(&format!("{release}({value});"));
        }
    }

    /// Values handed to the runtime become shared (it may keep them).
    fn share<'s>(&mut self, vs: impl IntoIterator<Item = &'s String>) {
        if self.g.reuse {
            for v in vs {
                self.line(&format!("fwp_rc_share({});", v));
            }
        }
    }

    /// Which reuse tokens are taken, before a match's arms.
    fn arms_start(&self) -> Vec<bool> {
        self.tokens.iter().map(|t| t.used).collect()
    }

    /// An arm starts: every token is as before the match, and a pattern
    /// with a constructor tells which one the scrutinee holds.
    fn arm_start(&mut self, scrut: &Expr, pat: &Pat, before: &[bool]) -> Option<Local> {
        for (t, u) in self.tokens.iter_mut().zip(before) {
            t.used = *u;
        }
        match (scrut, pat) {
            (Expr::Local(x), Pat::Construct(tag, _)) => {
                self.known_tag.insert(*x, *tag);
                Some(*x)
            }
            _ => None,
        }
    }

    fn arm_end(&mut self, known: Option<Local>, after: &mut [bool]) {
        if let Some(x) = known {
            self.known_tag.remove(&x);
        }
        for (t, a) in self.tokens.iter().zip(after.iter_mut()) {
            *a |= t.used;
        }
    }

    /// After a match: a token one of its arms took is taken.
    fn arms_end(&mut self, after: &[bool]) {
        for (t, a) in self.tokens.iter_mut().zip(after) {
            t.used = *a;
        }
    }

    /// `Drop(x)` before `body`, where `x`'s cell could be reused by a
    /// constructor of the same size in `body`: when `x` is unique, its
    /// fields give up the references it held (the cell is dead) and the
    /// cell becomes a token; otherwise it is an ordinary drop.
    fn reuse_token(&mut self, x: Local, body: &Expr) -> Option<Token> {
        let virtual_state = self.in_loop.as_ref().is_some_and(|lg| lg.record) && x == 0;
        if self.fields.contains_key(&x)
            || self.vlocals.contains_key(&x)
            || self.stack_children.contains_key(&x)
            || virtual_state
        {
            return None;
        }
        let shapes = &self.g.prog.shapes;
        let t = &self.locals[x as usize];
        let tys: Vec<MT> = match (
            record_fields(shapes, t),
            shapes.get(t),
            self.known_tag.get(&x),
        ) {
            (Some(fs), _, _) => fs.iter().map(|(_, t)| t.clone()).collect(),
            (None, Some(TypeShape::Adt(vs)), Some(tag)) => vs.get(*tag as usize)?.1.clone(),
            _ => return None,
        };
        if tys.is_empty() || tys.len() > 255 || !allocates(body, tys.len()) {
            return None;
        }
        let (u, tok) = (self.fresh(), self.fresh());
        self.line(&format!("int {} = fwp_rc_unique(l{});", u, x));
        self.line(&format!("V {} = 0;", tok));
        self.line(&format!("if ({}) {{", u));
        self.line(&format!("    {} = l{};", tok, x));
        let counted: Vec<(usize, MT)> = tys
            .iter()
            .enumerate()
            .filter(|(_, ft)| crate::rc::needs_rc(&self.g.prog.shapes, ft))
            .map(|(k, ft)| (k, ft.clone()))
            .collect();
        for (k, ft) in counted {
            let d = self.typed_drop(&ft).unwrap_or_else(|| "fwp_rc_drop".into());
            self.line(&format!("    {}(OBJ(l{})->f[{}]);", d, x, k));
        }
        let t = self.locals[x as usize].clone();
        let d = self.typed_drop(&t).unwrap_or_else(|| "fwp_rc_drop".into());
        // The token no longer owns any fields, including scalar words that
        // could look like reused young addresses to conservative tracing.
        self.line(&format!(
            "    memset(OBJ(l{x})->f, 0, {} * sizeof(V));",
            tys.len()
        ));
        self.line(&format!("}} else {}(l{});", d, x));
        let cleanup = if self.g.unwind {
            let node = self.fresh();
            let active = self.fresh();
            self.line(&format!("fwp_cleanup {node}; int {active} = 1;"));
            let release = self.token_release();
            self.line(&format!("fwp_cleanup_push(&{node}, {release}, &{tok});"));
            Some((node, active))
        } else {
            None
        };
        Some(Token {
            var: tok,
            unique: u,
            cleanup,
            arity: tys.len(),
            used: false,
        })
    }

    fn token_release(&self) -> &'static str {
        if free_enabled() {
            "fwp_rc_cleanup_cell"
        } else {
            "fwp_rc_cleanup_count"
        }
    }

    /// End the lexical lifetime even on a branch that never used the cell.
    fn finish_token(&mut self) {
        let token = self.tokens.pop().expect("missing reuse token");
        if let Some((node, active)) = token.cleanup {
            self.line(&format!("if ({active}) fwp_cleanup_pop(&{node});"));
        }
        let release = self.token_release();
        self.line(&format!("{release}(&{});", token.var));
    }

    /// Tail calls no longer need any unused token. Unlink in LIFO order
    /// before entering the callee, so cleanup does not prevent tail transfer.
    fn tail_tokens(&mut self, tail: bool) {
        if !tail {
            return;
        }
        let tokens: Vec<_> = self
            .tokens
            .iter()
            .rev()
            .map(|t| (t.var.clone(), t.cleanup.clone()))
            .collect();
        for (var, cleanup) in tokens {
            if let Some((node, active)) = cleanup {
                self.line(&format!(
                    "if ({active}) {{ fwp_cleanup_pop(&{node}); {active} = 0; }}"
                ));
            }
            let release = self.token_release();
            self.line(&format!("{release}(&{var});"));
        }
    }

    /// A record or variant of fields `xs`: in a token's cell when one of
    /// that size is free and still young (a cell that became old may not
    /// point to young values), else allocated by `alloc`.
    fn alloc(
        &mut self,
        key: *const Expr,
        args: &[Expr],
        tag: u32,
        xs: &[String],
        alloc: String,
    ) -> String {
        let Some(i) = self
            .tokens
            .iter()
            .rposition(|t| !t.used && t.arity == xs.len())
        else {
            return self.construct_alloc(key, args, xs, alloc);
        };
        self.tokens[i].used = true;
        let (tok, u) = (self.tokens[i].var.clone(), self.tokens[i].unique.clone());
        let r = self.fresh();
        self.line(&format!("V {};", r));
        self.line(&format!("if ({} == 1 && fwp_rc_young({})) {{", u, tok));
        self.line(&format!("    OBJ({})->tag = {};", tok, tag));
        for (k, x) in xs.iter().enumerate() {
            self.line(&format!("    OBJ({})->f[{}] = {};", tok, k, x));
        }
        self.line(&format!("    {} = {};", r, tok));
        self.line(&format!("    {tok} = 0;"));
        self.line("} else {");
        let fresh = self.construct_alloc(key, args, xs, alloc);
        self.line(&format!("    {} = {};", r, fresh));
        let release = self.token_release();
        self.line(&format!("    {release}(&{tok});"));
        self.line("}");
        r
    }

    fn construct_alloc(
        &mut self,
        key: *const Expr,
        args: &[Expr],
        xs: &[String],
        alloc: String,
    ) -> String {
        let remaining = self.begin_call(key);
        let values: Vec<_> = args
            .iter()
            .zip(xs)
            .filter_map(|(arg, value)| {
                // Constant graphs and static functions have no consumed count.
                if matches!(arg, Expr::Const(_) | Expr::Func(_)) {
                    return None;
                }
                let ty = type_of(
                    &|id| &self.g.prog.funcs[id].ty,
                    &self.g.prog.shapes,
                    &self.locals,
                    arg,
                )
                .unwrap_or_else(|| MT::con("?"));
                Some((value.clone(), ty))
            })
            .collect();
        let pending = self.begin_values(&values);
        let result = self.bind(self.g.fresh(alloc));
        self.end_call(pending);
        self.end_call(remaining);
        result
    }

    /// A copied record borrows its original and consumes only replacement fields.
    /// Keep the outer cell separate until its retained children are complete.
    fn record_update(
        &mut self,
        e: &Expr,
        base: &Expr,
        rv: &str,
        sets: &[(u32, Expr)],
        xs: &[(u32, String)],
    ) -> String {
        let ty = type_of(
            &|id| &self.g.prog.funcs[id].ty,
            &self.g.prog.shapes,
            &self.locals,
            base,
        )
        .expect("record update base must have a concrete type");
        let fields = record_fields(&self.g.prog.shapes, &ty)
            .expect("record update base must be a record")
            .to_vec();
        let remaining = self.begin_call(e as *const Expr);
        let replacements: Vec<_> = xs
            .iter()
            .map(|(i, value)| (value.clone(), fields[*i as usize].1.clone()))
            .collect();
        let pending = self.begin_values(&replacements);
        let copy = format!("fwp_data(0, OBJ({rv})->n, OBJ({rv})->f)");
        let t = self.bind(self.g.fresh(copy));
        let cell = if self.g.reuse && self.g.unwind {
            let node = self.fresh();
            self.line(&format!(
                "fwp_cleanup {node}; fwp_cleanup_push(&{node}, fwp_rc_cleanup_cell, &{t});"
            ));
            Some(node)
        } else {
            None
        };
        if self.g.reuse {
            let kept: Vec<_> = fields
                .iter()
                .enumerate()
                .filter(|(i, _)| !sets.iter().any(|(j, _)| *j as usize == *i))
                .map(|(i, (_, ty))| (format!("OBJ({t})->f[{i}]"), ty.clone()))
                .collect();
            let ctx = self.fresh();
            let node = self.fresh();
            let retain = self.g.duplicate_values(&kept, &ctx, &node);
            self.line(&retain);
        }
        for (i, value) in xs {
            self.line(&format!("OBJ({t})->f[{i}] = {value};"));
        }
        self.end_call(cell);
        self.end_call(pending);
        self.end_call(remaining);
        t
    }

    fn begin_values(&mut self, values: &[(String, MT)]) -> Option<String> {
        let ctx = self.fresh();
        let node = self.fresh();
        let protect = self.g.protect_values(values, &ctx, &node);
        if protect.is_empty() {
            return None;
        }
        self.line(&protect);
        Some(node)
    }

    /// The reference count change of a `Dup` or `Drop` of local `l`: none
    /// when the local is kept as its fields (there is no object).
    fn count(&mut self, e: &Expr, l: Local) {
        let node = if matches!(e, Expr::Dup(..)) {
            self.begin_call(e as *const Expr)
        } else {
            None
        };
        self.count_change(e, l);
        self.end_call(node);
    }

    fn count_change(&mut self, e: &Expr, l: Local) {
        if let Some(children) = self.stack_children.get(&l).cloned() {
            self.stack_children_count(children, matches!(e, Expr::Dup(..)));
            return;
        }
        if let Some((u, m, t)) = self.vlocals.get(&l).cloned() {
            if self.g.reuse {
                let k = self.g.vhelper(&t, m);
                let op = if matches!(e, Expr::Dup(..)) {
                    "vdup"
                } else {
                    "vdrop"
                };
                self.line(&format!("fwp_{}{}(&{});", op, k, u));
            }
            return;
        }
        let op = if matches!(e, Expr::Dup(..)) {
            "fwp_rc_dup"
        } else {
            "fwp_rc_drop"
        };
        let shapes = &self.g.prog.shapes;
        let field_tys = |t: &MT| -> Vec<MT> {
            record_fields(shapes, t)
                .map(|fs| fs.iter().map(|(_, t)| t.clone()).collect())
                .unwrap_or_default()
        };
        // a record kept as its fields (no object): its fields' references
        let mut parts: Vec<(String, MT)> = Vec::new();
        if let Some(fs) = self.fields.get(&l) {
            parts = fs
                .iter()
                .cloned()
                .zip(field_tys(&self.locals[l as usize]))
                .collect();
        } else if let Some(lg) = self.in_loop.as_ref().filter(|lg| lg.record && l == 0) {
            for ((off, w), t) in lg.slots.iter().zip(field_tys(&self.locals[0])) {
                match w {
                    Some(_) => {
                        for (k, ft) in field_tys(&t).into_iter().enumerate() {
                            parts.push((format!("st[{}]", off + k), ft));
                        }
                    }
                    None => parts.push((format!("st[{}]", off), t)),
                }
            }
        } else {
            if op == "fwp_rc_drop" {
                if let Some(d) = self.typed_drop(&self.locals[l as usize].clone()) {
                    self.line(&format!("{}(l{});", d, l));
                    return;
                }
            }
            // the last reference to an object holding arrays, maps or sets:
            // they lose the reference it held, so they may become unique
            if op == "fwp_rc_drop" {
                let t = &self.locals[l as usize];
                let tys: Vec<MT> = match (record_fields(shapes, t), shapes.get(t)) {
                    (Some(fs), _) => fs.iter().map(|(_, t)| t.clone()).collect(),
                    (None, Some(TypeShape::Adt(vs))) => match self.known_tag.get(&l) {
                        Some(tag) => vs
                            .get(*tag as usize)
                            .map(|v| v.1.clone())
                            .unwrap_or_default(),
                        None => Vec::new(),
                    },
                    _ => Vec::new(),
                };
                let is_array = |t: &MT| matches!(t, MT::Con(n, _) if crate::rc::is_container(n));
                if tys.iter().any(is_array) {
                    self.line(&format!("if (fwp_rc_last(l{})) {{", l));
                    for (k, ft) in tys.iter().enumerate() {
                        if crate::rc::needs_rc(shapes, ft) {
                            self.line(&format!("    fwp_rc_drop(OBJ(l{})->f[{}]);", l, k));
                        }
                    }
                    self.line("}");
                    return;
                }
            }
            self.line(&format!("{}(l{});", op, l));
            return;
        }
        if matches!(e, Expr::Dup(..)) {
            let ctx = self.fresh();
            let node = self.fresh();
            let retained = self.g.duplicate_values(&parts, &ctx, &node);
            self.line(&retained);
            return;
        }
        for (v, t) in parts {
            if crate::rc::needs_rc(&self.g.prog.shapes, &t) {
                let op = match self.typed_drop(&t) {
                    Some(d) if op == "fwp_rc_drop" => d,
                    _ => op.to_string(),
                };
                self.line(&format!("{}({});", op, v));
            }
        }
    }

    /// Save precisely the caller's remaining references for nonlocal unwind.
    /// Consumed arguments belong to the callee, and borrowed aliases add no owner.
    fn begin_call(&mut self, key: *const Expr) -> Option<String> {
        let owners = self
            .live_calls
            .get(&key)
            .map(|c| c.at_entry.clone())
            .unwrap_or_default();
        self.begin_owners(&owners)
    }

    fn begin_owners(&mut self, owners: &[(Local, u32)]) -> Option<String> {
        if !self.g.unwind || !self.g.reuse {
            return None;
        }
        let mut members = Vec::new();
        let mut values = Vec::new();
        let mut releases = Vec::new();
        for &(l, count) in owners {
            if let Some((u, m, ty)) = self.vlocals.get(&l).cloned() {
                let k = self.g.vhelper(&ty, m);
                let field = format!("v{}", members.len());
                members.push(format!("fwp_u{m} {field};"));
                values.push(u);
                for _ in 0..count {
                    releases.push(format!("fwp_vdrop{k}(&c->{field});"));
                }
                continue;
            }
            let ty = self.locals[l as usize].clone();
            let parts = if let Some(children) = self.stack_children.get(&l) {
                children.clone()
            } else if let Some(fields) = self.fields.get(&l) {
                fields
                    .iter()
                    .cloned()
                    .zip(
                        record_fields(&self.g.prog.shapes, &ty)
                            .unwrap()
                            .iter()
                            .map(|(_, t)| t.clone()),
                    )
                    .collect()
            } else if let Some(lg) = self.in_loop.as_ref().filter(|lg| lg.record && l == 0) {
                let mut parts = Vec::new();
                for ((off, width), (_, t)) in lg
                    .slots
                    .iter()
                    .zip(record_fields(&self.g.prog.shapes, &ty).unwrap())
                {
                    if width.is_some() {
                        for (k, (_, ft)) in record_fields(&self.g.prog.shapes, t)
                            .unwrap()
                            .iter()
                            .enumerate()
                        {
                            parts.push((format!("st[{}]", off + k), ft.clone()));
                        }
                    } else {
                        parts.push((format!("st[{off}]"), t.clone()));
                    }
                }
                parts
            } else {
                vec![(format!("l{l}"), ty)]
            };
            for (value, ty) in parts {
                if !crate::rc::needs_rc(&self.g.prog.shapes, &ty) {
                    continue;
                }
                let field = format!("v{}", members.len());
                members.push(format!("V {field};"));
                values.push(value);
                let drop = self.typed_drop(&ty).unwrap_or_else(|| "fwp_rc_drop".into());
                for _ in 0..count {
                    releases.push(format!("{drop}(c->{field});"));
                }
            }
        }
        // Unmanaged stack arguments cannot transfer their original child
        // references to a boxed callee drop. The caller releases those after
        // return, so preserve that same responsibility during nonlocal unwind.
        for (value, ty) in self.stack_args.clone() {
            let field = format!("v{}", members.len());
            members.push(format!("V {field};"));
            values.push(value);
            let drop = self.typed_drop(&ty).unwrap_or_else(|| "fwp_rc_drop".into());
            releases.push(format!("{drop}(c->{field});"));
        }
        if members.is_empty() {
            return None;
        }
        let id = self.g.cleanup_defs.len();
        self.g.cleanup_defs.push(format!(
            "typedef struct {{ {} }} fwp_owner_ctx{id};\nstatic void fwp_owner_release{id}(void *arg) {{ fwp_owner_ctx{id} *c = arg; {} }}\n",
            members.join(" "), releases.join(" ")));
        let ctx = self.fresh();
        let node = self.fresh();
        self.line(&format!(
            "fwp_owner_ctx{id} {ctx} = {{{}}};",
            values.join(", ")
        ));
        self.line(&format!("fwp_cleanup {node};"));
        self.line(&format!(
            "fwp_cleanup_push(&{node}, fwp_owner_release{id}, &{ctx});"
        ));
        Some(node)
    }

    fn end_call(&mut self, node: Option<String>) {
        if let Some(node) = node {
            self.line(&format!("fwp_cleanup_pop(&{node});"));
        }
    }

    fn entry_tick(&mut self) {
        if !self.g.ticks {
            return;
        }
        let owners: Vec<_> = (0..self.g.prog.funcs[self.me].arity)
            .filter(|l| crate::rc::needs_rc(&self.g.prog.shapes, &self.locals[*l as usize]))
            .map(|l| (l, 1))
            .collect();
        let node = self.begin_owners(&owners);
        self.line("FWP_TICK();");
        self.end_call(node);
    }

    fn bind_call(&mut self, key: *const Expr, call: String) -> String {
        let node = self.begin_call(key);
        let result = self.bind(call);
        self.end_call(node);
        result
    }

    /// The drop function of a counted type (`Gen::drop_id`), when objects
    /// are freed by their counts.
    fn typed_drop(&mut self, t: &MT) -> Option<String> {
        if !self.g.reuse || !free_enabled() || matches!(t, MT::Con(n, _) if n == "?") {
            return None;
        }
        if !crate::rc::needs_rc(&self.g.prog.shapes, t) {
            return None;
        }
        Some(format!("fwp_drop{}", self.g.drop_id(t)))
    }

    /// `string.length` of a `concat` or of an integer's `show`: the sum of
    /// the parts' lengths, or the count of the digits, without building
    /// the string. The parts are evaluated in the same order.
    fn length_without_string(&mut self, id: FuncId, args: &[Expr]) -> Option<String> {
        let sym = |g: &Gen, f: FuncId| match &g.prog.funcs[f].body {
            Body::Prim(s) => Some(s.clone()),
            _ => None,
        };
        if sym(self.g, id).as_deref() != Some("string.length") || args.len() != 1 {
            return None;
        }
        let Expr::Call(inner, a) = &args[0] else {
            return None;
        };
        let s = sym(self.g, *inner)?;
        let ok = match s.as_str() {
            "concat" => a.len() == 2,
            "show" => int64_kind(&self.g.prog.funcs[*inner].ty.params(1).0[0].clone()).is_some(),
            _ => false,
        };
        ok.then(|| self.string_length(&args[0]))
    }

    /// The length in characters of the string `e` evaluates to, as a C
    /// expression.
    fn string_length(&mut self, e: &Expr) -> String {
        if let Expr::Call(id, a) = e {
            if let Body::Prim(s) = &self.g.prog.funcs[*id].body {
                match s.as_str() {
                    "concat" if a.len() == 2 => {
                        let x = self.string_length(&a[0]);
                        let x = self.bind(format!("(V)(int64_t)({})", x));
                        let y = self.string_length(&a[1]);
                        return format!("(int64_t){} + {}", x, y);
                    }
                    "show" if a.len() == 1 => {
                        let t = self.g.prog.funcs[*id].ty.params(1).0[0].clone();
                        if let Some(signed) = int64_kind(&t) {
                            let v = self.expr(&a[0]);
                            return if signed {
                                format!("fwp_i64_chars((int64_t){})", v)
                            } else {
                                format!("fwp_u64_chars((uint64_t){})", v)
                            };
                        }
                    }
                    _ => {}
                }
            }
        }
        let v = self.expr(e);
        format!("(int64_t)fwp_utf8_count(STR({})->d, STR({})->len)", v, v)
    }

    fn callback_origin(&self, e: &Expr) -> Option<(FuncId, usize)> {
        match e {
            Expr::Func(g) => Some((*g, 0)),
            Expr::Apply(f, xs) if matches!(**f, Expr::Func(_)) => {
                let Expr::Func(g) = **f else { unreachable!() };
                Some((g, xs.len()))
            }
            Expr::Local(l) => self.known_callbacks.get(l).copied(),
            Expr::Dup(_, b) | Expr::Drop(_, b) => self.callback_origin(b),
            _ => None,
        }
    }

    fn owned_hof(&mut self, id: FuncId, args: &[Expr]) -> Option<String> {
        if !self.g.reuse {
            return None;
        }
        let sym = match &self.g.prog.funcs[id].body {
            Body::Prim(s)
                if matches!(
                    s.as_str(),
                    "map"
                        | "filter"
                        | "fold"
                        | "fold-right"
                        | "zip-with"
                        | "take-while"
                        | "drop-while"
                        | "find"
                        | "loop"
                ) =>
            {
                s.clone()
            }
            _ => return None,
        };
        if !matches!(
            args.first()?,
            Expr::Func(_) | Expr::Local(_) | Expr::Apply(_, _)
        ) {
            return None;
        }
        let (g, n) = self.callback_origin(args.first()?)?;
        if self.g.prog.funcs[g].arity as usize
            != n + if matches!(sym.as_str(), "fold" | "fold-right" | "zip-with") {
                2
            } else {
                1
            }
        {
            return None;
        }
        self.g.used_closures[g] = true;
        if sym == "loop" && n == 0 {
            let s = self.expr(&args[1]);
            if let Some(shape) = loop_shape(&self.g.prog.funcs[g]) {
                if !self.g.loops.iter().any(|(step, _)| *step == g) {
                    self.g.loops.push((g, shape));
                }
                return Some(format!("fwp_loop{g}({s})"));
            }
            let step = self.g.prog.funcs[g].ty.params(1).1.clone();
            let ops = self.g.loop_owned_ops(&step).expect("typed loop Step");
            return Some(format!("fwp_k_loop_owned(fwp_owned_entry{g}, {s}, {ops})"));
        }
        if n == 0 {
            if sym == "fold-right" {
                if !self.g.owned_right_fold_callbacks.contains(&g) {
                    self.g.owned_right_fold_callbacks.push(g);
                }
                let z = self.expr(&args[1]);
                let xs = self.expr(&args[2]);
                let ty = self.g.prog.funcs[g].ty.params(2).1.clone();
                let drop = self.g.value_drop(&ty);
                return Some(format!(
                    "fwp_k_fold_right_owned(fwp_owned_right_fold_k{g}, {z}, {xs}, {drop})"
                ));
            }
            if sym == "fold" {
                if !self.g.owned_fold_callbacks.contains(&g) {
                    self.g.owned_fold_callbacks.push(g);
                }
                let z = self.expr(&args[1]);
                let xs = self.expr(&args[2]);
                return Some(format!("fwp_k_fold_owned(fwp_owned_fold_k{g}, {z}, {xs})"));
            }
            if !self.g.owned_callbacks.contains(&g) {
                self.g.owned_callbacks.push(g);
            }
            if sym == "zip-with" {
                let ys = self.expr(&args[1]);
                let xs = self.expr(&args[2]);
                let result = self.g.prog.funcs[g].ty.params(2).1.clone();
                let ops = self.g.map_ops(&result);
                return Some(format!(
                    "fwp_k_zip_with_owned(fwp_owned_k{g}, {ys}, {xs}, {ops})"
                ));
            }
            let xs = self.expr(&args[1]);
            return Some(if sym == "map" {
                let result = self.g.prog.funcs[g].ty.params(1).1.clone();
                let ops = self.g.map_ops(&result);
                format!("fwp_k_map_owned(fwp_owned_k{g}, {xs}, {ops})")
            } else if sym == "drop-while" {
                format!("fwp_k_drop_while_owned(fwp_owned_k{g}, {xs})")
            } else {
                let runtime = match sym.as_str() {
                    "filter" => "filter",
                    "find" => "find",
                    _ => "take_while",
                };
                if matches!(sym.as_str(), "filter" | "take-while") {
                    let element = self.g.prog.funcs[g].ty.params(1).0[0].clone();
                    let ops = self.g.map_ops(&element);
                    format!("fwp_k_{runtime}_owned(fwp_owned_k{g}, fwp_args{g}, {xs}, {ops})")
                } else {
                    format!("fwp_k_{runtime}_owned(fwp_owned_k{g}, fwp_args{g}, {xs})")
                }
            });
        }
        let mut caps = match &args[0] {
            Expr::Local(l) => (0..n)
                .map(|j| format!("CLO(l{l})->a[{j}]"))
                .collect::<Vec<_>>(),
            Expr::Apply(_, caps) => self.args(caps),
            _ => return None,
        };
        let key = (sym, g, n);
        let i = match self.g.hofs.iter().position(|h| *h == key) {
            Some(i) => i,
            None => {
                self.g.hofs.push(key);
                self.g.hofs.len() - 1
            }
        };
        for arg in &args[1..] {
            caps.push(self.expr(arg));
        }
        Some(format!("fwp_hof{i}({})", caps.join(", ")))
    }

    /// A call of a higher-order primitive whose function argument is a
    /// known function, with nothing captured, of the arity the primitive
    /// applies it at: the runtime's `fwp_k_*` variant, which calls it
    /// directly.
    fn known_hof(&mut self, id: FuncId, args: &[Expr]) -> Option<String> {
        let Body::Prim(sym) = &self.g.prog.funcs[id].body else {
            return None;
        };
        if sym == "loop" {
            if let Some(Expr::Func(g)) = args.first() {
                let g = *g;
                if let Some(shape) = loop_shape(&self.g.prog.funcs[g]) {
                    if !self.g.loops.iter().any(|(s, _)| *s == g) {
                        self.g.loops.push((g, shape));
                    }
                    let s = self.expr(&args[1]);
                    self.share(std::slice::from_ref(&s));
                    return Some(format!("fwp_loop{}({})", g, s));
                }
            }
        }
        let (k, arity) = match sym.as_str() {
            "map" => ("fwp_k_map", 1),
            "filter" => ("fwp_k_filter", 1),
            "fold" => ("fwp_k_fold", 2),
            "fold-right" => ("fwp_k_fold_right", 2),
            "take-while" => ("fwp_k_take_while", 1),
            "drop-while" => ("fwp_k_drop_while", 1),
            "loop" => ("fwp_k_loop", 1),
            "zip-with" => ("fwp_k_zip_with", 2),
            _ => return None,
        };
        // the function and the locals it captures
        let (g, caps): (FuncId, &[Expr]) = match args.first() {
            Some(Expr::Func(g)) => (*g, &[]),
            Some(Expr::Apply(f, caps))
                if matches!(**f, Expr::Func(_))
                    && caps.iter().all(|c| matches!(c, Expr::Local(_))) =>
            {
                let Expr::Func(g) = **f else { unreachable!() };
                (g, &caps[..])
            }
            _ => return None,
        };
        if self.g.prog.funcs[g].arity as usize != arity + caps.len() {
            return None;
        }
        if caps.is_empty() {
            let rest = self.args(&args[1..]);
            self.share(&rest);
            let mut xs = vec![self.g.callback(g)];
            xs.extend(rest);
            return Some(format!("{}({})", k, xs.join(", ")));
        }
        let key = (sym.clone(), g, caps.len());
        let i = match self.g.hofs.iter().position(|h| *h == key) {
            Some(i) => i,
            None => {
                self.g.hofs.push(key);
                self.g.hofs.len() - 1
            }
        };
        let mut xs = self.args(caps);
        xs.extend(self.args(&args[1..]));
        // the specialized loop passes the captured values on every call
        self.share(&xs);
        Some(format!("fwp_hof{}({})", i, xs.join(", ")))
    }

    fn call_expr(&mut self, id: FuncId, args: &[Expr], tail: bool, key: *const Expr) -> String {
        let outer = std::mem::take(&mut self.stack_args);
        let result = self.call_expr_inner(id, args, tail, key);
        self.stack_args_finish(outer);
        result
    }

    fn call_expr_inner(
        &mut self,
        id: FuncId,
        args: &[Expr],
        tail: bool,
        key: *const Expr,
    ) -> String {
        if let Some(call) = self.owned_hof(id, args) {
            self.tail_tokens(tail);
            let result = self.bind_call(key, call);
            // Specialization reads captures directly; preserve the original
            // borrowed closure/list addresses until allocating calls return.
            for arg in args {
                if let Expr::Local(l) = arg {
                    self.line(&format!("FWP_KEEP_ALIVE(l{l});"));
                }
            }
            return result;
        }
        if let Some(call) = self.known_hof(id, args) {
            self.tail_tokens(tail);
            return self.bind_call(key, call);
        }
        if let Some(n) = self.length_without_string(id, args) {
            self.tail_tokens(tail);
            return self.bind(format!("(V)(int64_t)({})", n));
        }
        if let Some(abi) = self.g.abis[id].clone() {
            let xs = self.worker_args(id, &abi, args);
            self.tail_tokens(tail);
            return match abi.ret {
                Some(n) => {
                    let t = self.fresh();
                    let node = self.begin_call(key);
                    self.line(&format!("fwp_r{} {} = w{}({});", n, t, id, xs.join(", ")));
                    self.end_call(node);
                    // a record compiled code owns, like any it builds
                    let r = format!("fwp_record({}, {}.f)", n, t);
                    let ty = self.ret_type(id);
                    let fields: Vec<_> = record_fields(&self.g.prog.shapes, &ty)
                        .expect("record ABI result")
                        .iter()
                        .enumerate()
                        .map(|(i, (_, ty))| (format!("{t}.f[{i}]"), ty.clone()))
                        .collect();
                    let remaining = self.begin_call(key);
                    let pending = self.begin_values(&fields);
                    let result = self.bind(self.g.fresh(r));
                    self.end_call(pending);
                    self.end_call(remaining);
                    result
                }
                None => match abi.vret {
                    // a value the caller needs: built from the struct
                    Some(m) => {
                        let t = self.fresh();
                        let node = self.begin_call(key);
                        self.line(&format!("fwp_u{} {} = w{}({});", m, t, id, xs.join(", ")));
                        self.end_call(node);
                        let ty = self.ret_type(id);
                        let k = self.g.vhelper(&ty, m);
                        let remaining = self.begin_call(key);
                        let result = self.bind(format!("fwp_vbox{}({})", k, t));
                        self.end_call(remaining);
                        result
                    }
                    None => self.bind_call(key, format!("w{}({})", id, xs.join(", "))),
                },
            };
        }
        let xs: Vec<String> = args
            .iter()
            .enumerate()
            .map(|(j, a)| self.arg(id, j, a))
            .collect();
        self.tail_tokens(tail);
        if self.g.prog.funcs[id].arity == 0 {
            self.bind_call(key, format!("caf{}()", id))
        } else {
            let result = self.bind_call(key, format!("f{}({})", id, xs.join(", ")));
            self.keep_borrowed_args(id, &xs);
            result
        }
    }

    fn expr(&mut self, e: &Expr) -> String {
        if let Expr::Local(l) = e {
            if let Some((u, m, t)) = self.vlocals.get(l).cloned() {
                return self.vlocal_value(&u, m, &t);
            }
        }
        if let Some(lg) = &self.in_loop {
            let record = lg.record;
            match e {
                Expr::Field(r, k) if record && self.state_field(r).is_some() => {
                    let (off, _) = self.state_field(r).unwrap();
                    return format!("st[{}]", off + *k as usize);
                }
                Expr::Field(r, i) if record && matches!(**r, Expr::Local(0)) => {
                    let (off, w) = lg.slots[*i as usize];
                    return match w {
                        None => format!("st[{}]", off),
                        // the record itself: built again from its fields
                        Some(m) => {
                            let fs: Vec<String> =
                                (off..off + m).map(|k| format!("st[{}]", k)).collect();
                            if self.g.reuse {
                                let state_fields =
                                    record_fields(&self.g.prog.shapes, &self.locals[0]).unwrap();
                                let inner = &state_fields[*i as usize].1;
                                let counted = record_fields(&self.g.prog.shapes, inner)
                                    .unwrap()
                                    .iter()
                                    .enumerate()
                                    .filter(|(_, (_, ty))| {
                                        crate::rc::needs_rc(&self.g.prog.shapes, ty)
                                    })
                                    .map(|(j, _)| off + j)
                                    .collect::<Vec<_>>();
                                for slot in counted {
                                    self.line(&format!("fwp_rc_dup(st[{slot}]);"));
                                }
                            }
                            let r = format!("fwp_record({}, {})", m, Self::array(&fs));
                            self.bind(self.g.fresh(r))
                        }
                    };
                }
                Expr::Construct(tag, xs) if lg.tails.contains(&(e as *const Expr)) => {
                    if *tag == 1 {
                        let x = self.expr(&xs[0]);
                        self.line(&format!("*out = {};", x));
                        return "(V)1".into();
                    }
                    let parts: Vec<String> = match (&xs[0], record) {
                        (Expr::Record(fs), true) => {
                            let slots = lg.slots.clone();
                            let mut parts = Vec::new();
                            for (f, (_, w)) in fs.iter().zip(slots) {
                                match w {
                                    Some(m) => parts.extend(self.expr_fields(f, m)),
                                    None => parts.push(self.expr(f)),
                                }
                            }
                            parts
                        }
                        _ => vec![self.expr(&xs[0])],
                    };
                    for (i, p) in parts.iter().enumerate() {
                        self.line(&format!("nx[{}] = {};", i, p));
                    }
                    return "(V)0".into();
                }
                _ => {}
            }
        }
        match e {
            Expr::Drop(l, b) if self.g.reuse => match self.reuse_token(*l, b) {
                Some(t) => {
                    self.tokens.push(t);
                    let r = self.expr(b);
                    self.finish_token();
                    r
                }
                None => {
                    self.count(e, *l);
                    self.expr(b)
                }
            },
            Expr::Dup(l, b) | Expr::Drop(l, b) => {
                self.count(e, *l);
                self.expr(b)
            }
            Expr::Local(i) => format!("l{}", i),
            Expr::Const(v) => self.g.const_expr(v),
            Expr::Func(id) => {
                if self.g.prog.funcs[*id].arity == 0 {
                    self.bind_call(e as *const Expr, format!("caf{}()", id))
                } else {
                    self.g.used_closures[*id] = true;
                    format!("PTR(&fc{})", id)
                }
            }
            Expr::Call(id, args) => self.call_expr(
                *id,
                args,
                self.tail_calls.contains(&(e as *const Expr)),
                e as *const Expr,
            ),
            Expr::Apply(f, args) => {
                let children = self.stack_alias(f);
                let fv = self.expr(f);
                let xs = self.args(args);
                if !self.g.reuse {
                    self.share(std::iter::once(&fv).chain(&xs));
                }
                let apply = if self.g.reuse {
                    "fwp_apply_owned"
                } else {
                    "fwp_apply"
                };
                self.tail_tokens(self.tail_calls.contains(&(e as *const Expr)));
                // A consumed off-heap closure leaves its original capture
                // references with this frame until application returns.
                let pending = self.stack_args.len();
                if let Some(children) = &children {
                    self.stack_args.extend(children.iter().cloned());
                }
                let result = self.bind_call(
                    e as *const Expr,
                    format!("{}({}, {}, {})", apply, fv, xs.len(), Self::array(&xs)),
                );
                self.stack_args.truncate(pending);
                if let Some(children) = children {
                    self.stack_children_count(children, false);
                }
                result
            }
            Expr::Construct(tag, args) => {
                if args.is_empty() {
                    return format!("(V){}", tag);
                }
                let xs = self.args(args);
                let alloc = format!("fwp_data({}, {}, {})", tag, xs.len(), Self::array(&xs));
                self.alloc(e as *const Expr, args, *tag, &xs, alloc)
            }
            Expr::Record(args) => {
                if args.is_empty() {
                    return "(V)0".into();
                }
                let xs = self.args(args);
                let alloc = format!("fwp_record({}, {})", xs.len(), Self::array(&xs));
                self.alloc(e as *const Expr, args, 0, &xs, alloc)
            }
            Expr::Field(r, i) => {
                if let Expr::Local(l) = &**r {
                    if let Some(fs) = self.fields.get(l) {
                        return fs[*i as usize].clone();
                    }
                }
                if let (Expr::Call(..), Some(n)) = (&**r, self.unboxed(r)) {
                    let fs = self.expr_fields(r, n);
                    return fs[*i as usize].clone();
                }
                let rv = self.expr(r);
                self.bind(format!("OBJ({})->f[{}]", rv, i))
            }
            Expr::SetFields(r, sets) => {
                let rv = self.expr(r);
                let xs: Vec<(u32, String)> = sets.iter().map(|(i, x)| (*i, self.expr(x))).collect();
                self.record_update(e, r, &rv, sets, &xs)
            }
            Expr::Let(l, v, body) => {
                // `let o = map.get k m in match o ...`, with only o's
                // reference counts in the arms: no `Some` is built
                if let Expr::Match(s, arms) = &**body {
                    if matches!(**s, Expr::Local(x) if x == *l) {
                        let stripped: Option<Vec<(Pat, Expr)>> = arms
                            .iter()
                            .map(|(p, b)| without_counts(b, *l).map(|b| (p.clone(), b)))
                            .collect();
                        if let Some(arms) = stripped {
                            if let Some(r) = self.lookup_match(v, &arms) {
                                return r;
                            }
                        }
                    }
                }
                let body = self.bind_local(*l, v, body);
                self.expr(body)
            }
            Expr::Match(scrut, arms) => {
                if let Some(r) = self.lookup_match(scrut, arms) {
                    return r;
                }
                let s = self.scrutinee(scrut);
                let r = self.fresh();
                self.line(&format!("V {};", r));
                self.label += 1;
                let done = format!("done{}", self.label);
                let before = self.arms_start();
                let mut after = before.clone();
                for (pat, body) in arms {
                    self.label += 1;
                    let next = format!("next{}", self.label);
                    self.line("{");
                    self.indent += 1;
                    self.match_pattern(scrut, pat, &s, &next);
                    let known = self.arm_start(scrut, pat, &before);
                    let bv = self.expr(body);
                    self.arm_end(known, &mut after);
                    self.line(&format!("{} = {};", r, bv));
                    self.line(&format!("goto {};", done));
                    self.indent -= 1;
                    self.line("}");
                    self.line(&format!("{}:;", next));
                }
                self.line("fwp_trap(\"internal: no match arm applies\");");
                self.line(&format!("{}:;", done));
                self.arms_end(&after);
                r
            }
        }
    }

    /// `match` on `map.get k m`: the key is looked up and the arms test
    /// whether it was found, so no `Some` is allocated. Only when every arm
    /// is `Some p`, `None` or `_` (the option itself is never bound).
    fn lookup_match(&mut self, scrut: &Expr, arms: &[(Pat, Expr)]) -> Option<String> {
        // through the `Let`s that compute the arguments
        let mut inner = scrut;
        while let Expr::Let(_, _, b) = inner {
            inner = b;
        }
        let Expr::Call(id, args) = inner else {
            return None;
        };
        let f = &self.g.prog.funcs[*id];
        if !matches!(&f.body, Body::Prim(s) if s == "map.get") || args.len() != 2 {
            return None;
        }
        let shapes = arms.iter().all(|(p, _)| match p {
            Pat::Wild => true,
            Pat::Construct(0, ps) => ps.is_empty(),
            Pat::Construct(1, ps) => ps.len() == 1,
            _ => false,
        });
        if !shapes {
            return None;
        }
        let kd = self.g.desc(&f.ty.params(2).0[0].clone());
        let mut e = scrut;
        while let Expr::Let(l, v, b) = e {
            let x = self.expr(v);
            self.line(&format!("l{} = {};", l, x));
            e = b;
        }
        let xs = self.args(args);
        let (found, at, v) = (self.fresh(), self.fresh(), self.fresh());
        self.line(&format!(
            "int {found}; uint64_t {at} = fwp_map_find({m}, {k}, {kd}, &{found});",
            found = found,
            at = at,
            m = xs[1],
            k = xs[0],
            kd = kd
        ));
        self.line(&format!(
            "V {v} = {found} ? MAP({m})->d[2 * {at} + 1] : 0;",
            v = v,
            found = found,
            m = xs[1],
            at = at
        ));
        let value_type = match &f.locals[1] {
            MT::Con(name, fields) if name == "std::Map" && fields.len() == 2 => {
                Some(fields[1].clone())
            }
            _ => None,
        };
        let owned_value = self.g.reuse
            && value_type
                .as_ref()
                .is_some_and(|ty| crate::rc::needs_rc(&self.g.prog.shapes, ty));
        if owned_value {
            self.line(&format!("if ({found}) fwp_rc_dup({v});"));
        }
        let r = self.fresh();
        self.line(&format!("V {};", r));
        self.label += 1;
        let done = format!("done{}", self.label);
        for (pat, body) in arms {
            self.label += 1;
            let next = format!("next{}", self.label);
            self.line("{");
            self.indent += 1;
            match pat {
                Pat::Construct(0, _) => self.line(&format!("if ({}) goto {};", found, next)),
                Pat::Construct(1, ps) => {
                    self.line(&format!("if (!{}) goto {};", found, next));
                    self.pattern(&ps[0], &v, &next);
                }
                _ => {}
            }
            let bv = self.expr(body);
            self.line(&format!("{} = {};", r, bv));
            self.line(&format!("goto {};", done));
            self.indent -= 1;
            self.line("}");
            self.line(&format!("{}:;", next));
        }
        self.line("fwp_trap(\"internal: no match arm applies\");");
        self.line(&format!("{}:;", done));
        if owned_value {
            self.line(&format!("FWP_KEEP_ALIVE({v});"));
            let drop = self
                .typed_drop(value_type.as_ref().unwrap())
                .unwrap_or_else(|| "fwp_rc_drop".into());
            self.line(&format!("if ({found}) {drop}({v});"));
        }
        Some(r)
    }

    fn pattern(&mut self, p: &Pat, v: &str, fail: &str) {
        match p {
            Pat::Wild => {}
            Pat::Bind(l) => self.line(&format!("l{} = {};", l, v)),
            Pat::Lit(lit) => {
                let cond = match lit {
                    Value::Str(s) => {
                        let c = self.g.string_const(s.as_bytes());
                        format!("fwp_str_eq({}, {})", v, c)
                    }
                    Value::F32(x) => format!("fwp_f32({}) == fwp_f32((V)0x{:x}U)", v, x.to_bits()),
                    Value::F64(x) => {
                        format!("fwp_f64({}) == fwp_f64((V)0x{:x}ULL)", v, x.to_bits())
                    }
                    Value::I128(x) => {
                        let (hi, lo) = ((*x as u128 >> 64) as u64, *x as u128 as u64);
                        format!(
                            "fwp_i128({}) == (i128)(((u128){}ULL << 64) | {}ULL)",
                            v, hi, lo
                        )
                    }
                    Value::U128(x) => {
                        let (hi, lo) = ((*x >> 64) as u64, *x as u64);
                        format!("fwp_u128({}) == (((u128){}ULL << 64) | {}ULL)", v, hi, lo)
                    }
                    other => {
                        let c = self.g.const_expr(other);
                        format!("{} == {}", v, c)
                    }
                };
                self.line(&format!("if (!({})) goto {};", cond, fail));
            }
            Pat::Construct(tag, ps) => {
                self.line(&format!("if (fwp_tag({}) != {}) goto {};", v, tag, fail));
                for (i, sp) in ps.iter().enumerate() {
                    if !matches!(sp, Pat::Wild) {
                        let fv = format!("OBJ({})->f[{}]", v, i);
                        self.pattern(sp, &fv, fail);
                    }
                }
            }
            Pat::Record(ps) => {
                for (i, sp) in ps.iter().enumerate() {
                    if !matches!(sp, Pat::Wild) {
                        let fv = format!("OBJ({})->f[{}]", v, i);
                        self.pattern(sp, &fv, fail);
                    }
                }
            }
        }
    }
}

impl<'p> Gen<'p> {
    /// Body statements for a primitive instance.
    fn prim(&mut self, func: &Func, sym: &str) -> Result<String, String> {
        let (params, result) = func.ty.params(func.arity as usize);
        let params: Vec<MT> = params.into_iter().cloned().collect();
        let result = result.clone();
        let p = |i: usize| params.get(i).cloned().unwrap_or(MT::unit());
        let nk = |mt: &MT| num_kind(mt).unwrap_or(("K_I64", "?".into(), 0));
        let (rk, rname, rw) = nk(&result);
        let sc = scalar(&result);
        let sp = scalar(&p(0));
        let s = match sym {
            "prim.add" | "prim.sub" | "prim.mul" | "prim.div" | "prim.rem" if sc.is_some() => {
                sc.unwrap().arith(sym, &Self::cstr(&rname))
            }
            "prim.neg" if sc.is_some() => match sc.unwrap() {
                Scalar::Signed(_) => {
                    let min = sc.unwrap().bounds().map_or("INT64_MIN".into(), |b| b.0);
                    format!(
                        "if ((int64_t)l0 == {}) fwp_trap_overflow({});\n    return (V)(-(int64_t)l0);",
                        min,
                        Self::cstr(&rname)
                    )
                }
                // 0 - x
                Scalar::Unsigned(_) => format!(
                    "if (l0 != 0) fwp_trap_overflow({});\n    return 0;",
                    Self::cstr(&rname)
                ),
                f => format!("return {};", f.put(&format!("-{}", f.get("l0")))),
            },
            "eq" | "ne" if sp.is_some() => {
                let s = sp.unwrap();
                format!(
                    "return {} {} {} ? FWP_TRUE : FWP_FALSE;",
                    s.get("l1"),
                    if sym == "eq" { "==" } else { "!=" },
                    s.get("l0")
                )
            }
            "lt" | "le" | "gt" | "ge" if sp.is_some() => {
                let s = sp.unwrap();
                let c = match sym {
                    "lt" => "<",
                    "le" => "<=",
                    "gt" => ">",
                    _ => ">=",
                };
                format!(
                    "return {} {} {} ? FWP_TRUE : FWP_FALSE;",
                    s.get("l1"),
                    c,
                    s.get("l0")
                )
            }
            // floats compare in their total order, which stays generic
            "compare" if matches!(sp, Some(Scalar::Signed(_) | Scalar::Unsigned(_))) => {
                let s = sp.unwrap();
                format!(
                    "{t} x = {x}, y = {y};\n    return x < y ? 0 : x == y ? 1 : 2;",
                    t = s.c(),
                    x = s.get("l1"),
                    y = s.get("l0")
                )
            }
            "min" | "max" if matches!(sp, Some(Scalar::Signed(_) | Scalar::Unsigned(_))) => {
                let s = sp.unwrap();
                format!(
                    "return {} {} {} ? l1 : l0;",
                    s.get("l1"),
                    if sym == "min" { "<=" } else { ">=" },
                    s.get("l0")
                )
            }
            "prim.add" | "prim.sub" | "prim.mul" | "prim.div" | "prim.rem" => format!(
                "return fwp_arith({}, {}, l1, l0, {}, {});",
                rk,
                op_code(sym),
                Self::cstr(&rname),
                rw
            ),
            "prim.neg" => format!(
                "return fwp_neg({rk}, l0, {n}, {w});",
                rk = rk,
                n = Self::cstr(&rname),
                w = rw
            ),
            "prim.zero" | "prim.one" => format!(
                "return fwp_from_i128({}, {}, {}, {});",
                rk,
                if sym == "prim.zero" { 0 } else { 1 },
                Self::cstr(&rname),
                rw
            ),
            "prim.from-int" => format!(
                "return fwp_from_i128({}, (i128)(int64_t)l0, {}, {});",
                rk,
                Self::cstr(&rname),
                rw
            ),
            "prim.from-float" => format!("return fwp_float_of({}, fwp_f64(l0));", rk),
            "mem.alloc" => "size_t n = (int64_t)l0 > 0 ? (size_t)(int64_t)l0 : 1;\n    void *p = calloc(n, 1);\n    if (!p) fwp_trap(\"out of memory\");\n    return (V)(uintptr_t)p;".into(),
            "mem.free" => "free((void *)(uintptr_t)l0);\n    return FWP_UNIT;".into(),
            "mem.string" => "size_t n = STR(l0)->len;\n    char *p = (char *)calloc(n + 1, 1);\n    if (!p) fwp_trap(\"out of memory\");\n    memcpy(p, STR(l0)->d, n);\n    return (V)(uintptr_t)p;".into(),
            "ptr.cast" | "ptr.address" => "return l0;".into(),
            "ptr.at" => {
                let t = crate::ffi::classify_scalar(&elem(&p(1), 0));
                format!(
                    "return (V)((int64_t)l1 + (int64_t)l0 * (int64_t)sizeof({}));",
                    crate::ffi::c_name(&t)
                )
            }
            "ptr.read" => {
                let t = crate::ffi::classify_scalar(&result);
                format!(
                    "{} x;\n    memcpy(&x, (void *)(uintptr_t)l0, sizeof x);\n    return {};",
                    crate::ffi::c_name(&t),
                    ffi_from_c(&t, "x")
                )
            }
            "ptr.write" => {
                let t = crate::ffi::classify_scalar(&p(0));
                format!(
                    "{} x = {};\n    memcpy((void *)(uintptr_t)l1, &x, sizeof x);\n    return FWP_UNIT;",
                    crate::ffi::c_name(&t),
                    ffi_to_c(&t, "l0")
                )
            }
            "ptr.read-string" => "if (!l0) fwp_trap(\"reading a string at a null pointer\");\n    return fwp_c_string((const char *)(uintptr_t)l0);".into(),
            "trit.from-sign" => {
                "return (V)(int64_t)(((int64_t)l0 > 0) - ((int64_t)l0 < 0));".into()
            }
            "trit.to-int" | "tint.to-int" => "return l0;".into(),
            "tint.of-int" => format!("return fwp_p_tint_of_int(l0, {});", nk(&elem(&result, 0)).2),
            "tint.trits" => format!("return fwp_p_tint_trits(l0, {});", nk(&p(0)).2),
            "tint.from-trits" => format!(
                "return fwp_p_tint_from_trits(l0, {});",
                nk(&elem(&result, 0)).2
            ),
            "trits.pack" => "return fwp_p_trits_pack(l0);".into(),
            "trits.unpack" => "return fwp_p_trits_unpack(l0, l1);".into(),
            "simd.splat" => format!("return fwp_p_simd_splat(l0, {});", vec_shape(&result).0),
            "simd.from-array" => format!(
                "return fwp_p_simd_from_array(l0, {});",
                vec_shape(&elem(&result, 0)).0
            ),
            "simd.add" | "simd.sub" | "simd.mul" | "simd.div" | "simd.min" | "simd.max" => {
                let (k, name, w) = nk(&vec_shape(&p(0)).1);
                let op = match sym {
                    "simd.add" => "OP_ADD",
                    "simd.sub" => "OP_SUB",
                    "simd.mul" => "OP_MUL",
                    "simd.div" => "OP_DIV",
                    "simd.min" => "5",
                    _ => "6",
                };
                format!(
                    "return fwp_p_simd_op({}, {}, l1, l0, {}, {});",
                    k,
                    op,
                    Self::cstr(&name),
                    w
                )
            }
            "simd.sum" => format!(
                "return fwp_p_simd_sum({}, l0, {}, {});",
                rk,
                Self::cstr(&rname),
                rw
            ),
            "wrapping.add" | "wrapping.sub" | "wrapping.mul" => {
                format!("return fwp_wrapping({}, {}, l1, l0);", rk, op_code(sym))
            }
            "saturating.add" | "saturating.sub" | "saturating.mul" => format!(
                "return fwp_saturating({}, {}, l1, l0, {});",
                rk,
                op_code(sym),
                Self::cstr(&rname)
            ),
            "overflowing.add" | "overflowing.sub" | "overflowing.mul" => {
                let (k, _, _) = nk(&p(0));
                format!("return fwp_overflowing({}, {}, l1, l0);", k, op_code(sym))
            }
            "checked.add" | "checked.sub" | "checked.mul" | "checked.div" => {
                let (k, _, _) = nk(&p(0));
                format!("return fwp_checked({}, {}, l1, l0);", k, op_code(sym))
            }
            "bit.and" | "bit.or" | "bit.xor" => {
                let which = match sym {
                    "bit.and" => 0,
                    "bit.or" => 1,
                    _ => 2,
                };
                format!("return fwp_bitop({}, {}, l1, l0);", rk, which)
            }
            "bit.not" => format!("return fwp_bitnot({}, l0);", rk),
            "bit.shl" | "bit.shr" => format!(
                "return fwp_shift({}, {}, (uint32_t)l0, l1);",
                rk,
                (sym == "bit.shl") as u8
            ),
            "int.convert" => {
                let (ks, _, _) = nk(&p(0));
                let (kt, _, _) = nk(&elem(&result, 0));
                format!("return fwp_int_convert({}, {}, l0);", ks, kt)
            }
            "int.to-float" => {
                let (ks, _, _) = nk(&p(0));
                format!("return fwp_int_to_float({}, {}, l0);", ks, rk)
            }
            "float.to-int" => {
                let (ks, _, _) = nk(&p(0));
                let (kt, _, _) = nk(&elem(&result, 0));
                format!("return fwp_float_to_int({}, {}, l0);", ks, kt)
            }
            "float.convert" => {
                let (ks, _, _) = nk(&p(0));
                format!("return fwp_float_of({}, fwp_as_f64({}, l0));", rk, ks)
            }
            "sqrt" | "exp" | "ln" | "sin" | "cos" | "tan" | "floor" | "ceil" | "round" => {
                format!("return fwp_fmath({}, FM_{}, l0);", rk, sym.to_uppercase())
            }
            "pow" => format!(
                "return fwp_float_of({rk}, pow(fwp_as_f64({rk}, l1), fwp_as_f64({rk}, l0)));",
                rk = rk
            ),
            "abs" => format!("return fwp_abs({}, l0, {});", rk, Self::cstr(&rname)),
            "eq" | "ne" => {
                let d = self.desc(&p(0));
                format!(
                    "return fwp_eq(l1, l0, {}) {} 0 ? FWP_TRUE : FWP_FALSE;",
                    d,
                    if sym == "eq" { "!=" } else { "==" }
                )
            }
            "lt" | "le" | "gt" | "ge" => {
                let d = self.desc(&p(0));
                let cond = match sym {
                    "lt" => "c == -1",
                    "le" => "c == -1 || c == 0",
                    "gt" => "c == 1",
                    _ => "c == 1 || c == 0",
                };
                format!(
                    "int c = fwp_partial_cmp(l1, l0, {}); return ({}) ? FWP_TRUE : FWP_FALSE;",
                    d, cond
                )
            }
            "compare" => {
                let d = self.desc(&p(0));
                format!(
                    "int c = fwp_cmp(l1, l0, {}); return c < 0 ? 0 : c == 0 ? 1 : 2;",
                    d
                )
            }
            "min" | "max" => {
                let d = self.desc(&p(0));
                format!(
                    "return fwp_cmp(l1, l0, {}) {} 0 ? l1 : l0;",
                    d,
                    if sym == "min" { "<=" } else { ">=" }
                )
            }
            "hash" => format!("return fwp_hash(l0, {});", self.desc(&p(0))),
            "not" => "return l0 == FWP_TRUE ? FWP_FALSE : FWP_TRUE;".into(),
            "and" => "return (l0 == FWP_TRUE && l1 == FWP_TRUE) ? FWP_TRUE : FWP_FALSE;".into(),
            "or" => "return (l0 == FWP_TRUE || l1 == FWP_TRUE) ? FWP_TRUE : FWP_FALSE;".into(),
            "show" => match int64_kind(&p(0)) {
                Some(true) => "return fwp_show_i64(l0);".into(),
                Some(false) => "return fwp_show_u64(l0);".into(),
                None => format!("return fwp_show(l0, {});", self.desc(&p(0))),
            },
            "json.write" => format!("return fwp_p_json_write(l0, {});", self.desc(&p(0))),
            "json.read" => format!(
                "return fwp_p_json_read(l0, {});",
                self.desc(&elem(&result, 0))
            ),
            "format" => format!("return fwp_p_format(l0, l1, {});", self.desc(&p(1))),
            "fail" => format!("fwp_fail(l0, {}); return 0;", self.desc(&p(0))),
            "loop" if self.reuse => {
                let step = MT::Con("std::Step".into(), vec![p(1), result.clone()]);
                let ops = self.loop_owned_ops(&step)?;
                format!("return fwp_p_loop(l0, l1, {ops});")
            }
            "sort" => format!("return fwp_p_sort(l0, {});", self.desc(&elem(&p(0), 0))),
            "sort-by" => {
                let key = match p(0) {
                    MT::Fun(_, k) => *k,
                    _ => MT::unit(),
                };
                let descriptor = self.desc(&key);
                if self.reuse {
                    // Keys own callback results, including aliases. Scalars must
                    // never be interpreted as pointers by a generic release.
                    let drop = if crate::rc::needs_rc(&self.prog.shapes, &key) {
                        if free_enabled() && !matches!(&key, MT::Con(n, _) if n == "?") {
                            format!("fwp_drop{}", self.drop_id(&key))
                        } else {
                            "fwp_rc_drop".into()
                        }
                    } else {
                        "NULL".into()
                    };
                    format!("return fwp_p_sort_by(l0, l1, {descriptor}, {drop});")
                } else {
                    format!("return fwp_p_sort_by(l0, l1, {descriptor});")
                }
            }
            "index-of" => format!("return fwp_p_index_of(l0, l1, {});", self.desc(&p(0))),
            "unique" => format!("return fwp_p_unique(l0, {});", self.desc(&elem(&p(0), 0))),
            "array.sort" => format!(
                "return fwp_p_array_sort(l0, {});",
                self.desc(&elem(&p(0), 0))
            ),
            "range" => {
                let (k, _, _) = nk(&p(0));
                format!("return fwp_p_range({}, l0, l1);", k)
            }
            "parse-int" => {
                let (k, _, w) = nk(&elem(&result, 0));
                format!("return fwp_p_parse_int(l0, {}, {});", k, w)
            }
            "parse-float" => {
                let (k, _, _) = nk(&elem(&result, 0));
                format!("return fwp_p_parse_float(l0, {});", k)
            }
            "map.insert" => format!("return fwp_p_map_insert(l0, l1, l2, {});", self.desc(&p(0))),
            "map.get" => format!("return fwp_p_map_get(l0, l1, {});", self.desc(&p(0))),
            "map.remove" | "set.remove" => {
                format!("return fwp_p_map_remove(l0, l1, {});", self.desc(&p(0)))
            }
            "map.contains" | "set.contains" => {
                format!("return fwp_p_map_contains(l0, l1, {});", self.desc(&p(0)))
            }
            "map.from-list" => {
                let kt = match elem(&p(0), 0) {
                    MT::Record(fs) if !fs.is_empty() => fs[0].1.clone(),
                    _ => MT::unit(),
                };
                format!("return fwp_p_map_from_list(l0, {});", self.desc(&kt))
            }
            "map.update" => format!(
                "return fwp_p_map_update(l0, l1, l2, l3, {});",
                self.desc(&p(0))
            ),
            "set.insert" => format!("return fwp_p_set_insert(l0, l1, {});", self.desc(&p(0))),
            "set.from-list" => {
                format!(
                    "return fwp_p_set_from_list(l0, {});",
                    self.desc(&elem(&p(0), 0))
                )
            }
            "set.union" | "set.intersect" | "set.diff" => {
                let op = match sym {
                    "set.union" => 0,
                    "set.intersect" => 1,
                    _ => 2,
                };
                format!(
                    "return fwp_p_set_op(l0, l1, {}, {});",
                    op,
                    self.desc(&elem(&p(0), 0))
                )
            }
            "file.open" | "file.create" | "file.read-all" | "file.write" | "file.with"
            | "file.read" | "file.write-new" => {
                let err = self.desc(&MT::con("std::IoError"));
                match sym {
                    "file.open" => format!("return fwp_p_file_open(l0, 0, {});", err),
                    "file.create" => format!("return fwp_p_file_open(l0, 1, {});", err),
                    "file.read-all" => format!("return fwp_p_file_read_all(l0, {});", err),
                    "file.write" => format!("return fwp_p_file_write(l0, l1, {});", err),
                    "file.with" => format!("return fwp_p_file_with(l0, l1, {});", err),
                    "file.read" => format!("return fwp_p_file_read(l0, {});", err),
                    _ => format!("return fwp_p_file_write_new(l0, l1, {});", err),
                }
            }
            "file.info" | "file.remove" | "dir.remove" | "file.rename" | "file.append"
            | "file.read-bytes" | "file.write-bytes" | "dir.list" | "dir.create"
            | "dir.create-all" | "process.run-input" | "process.call" => {
                let err = self.desc(&MT::con("std::IoError"));
                let (f, n) = match sym {
                    "file.info" => ("fwp_p_file_info", 1),
                    "file.remove" => ("fwp_p_file_remove", 1),
                    "dir.remove" => ("fwp_p_dir_remove", 1),
                    "file.rename" => ("fwp_p_file_rename", 2),
                    "file.append" => ("fwp_p_file_append", 2),
                    "file.read-bytes" => ("fwp_p_file_read", 1),
                    "file.write-bytes" => ("fwp_p_file_write_bytes", 2),
                    "dir.list" => ("fwp_p_dir_list", 1),
                    "dir.create" => ("fwp_p_dir_create", 1),
                    "dir.create-all" => ("fwp_p_dir_create_all", 1),
                    "process.run-input" => ("fwp_p_process_run_input", 2),
                    _ => ("fwp_p_process_call", 1),
                };
                let args: Vec<String> = (0..n).map(|i| format!("l{}", i)).collect();
                format!("return {}({}, {});", f, args.join(", "), err)
            }
            "csv.decode" => {
                // Result[List[t], String]
                let t = elem(&elem(&result, 0), 0);
                let fields = match &t {
                    MT::Record(fs) => fs.clone(),
                    MT::Con(..) => match self.prog.shapes.get(&t) {
                        Some(TypeShape::Record(fs)) => fs.clone(),
                        _ => Vec::new(),
                    },
                    _ => Vec::new(),
                };
                let named = !fields.is_empty()
                    && !fields
                        .iter()
                        .any(|(l, _)| l.starts_with(|c: char| c.is_ascii_digit()));
                if !named {
                    return Ok(format!(
                        "return fwp_p_csv_decode(l0, 0, 0, {});",
                        c_string_literal(t.to_string().as_bytes())
                    ));
                }
                let names: Vec<String> = fields
                    .iter()
                    .map(|(_, ft)| {
                        let shown = crate::cli::option_elem(ft).unwrap_or_else(|| ft.clone());
                        c_string_literal(shown.to_string().as_bytes())
                    })
                    .collect();
                format!(
                    "static const char *const names[] = {{{}}};\n    return fwp_p_csv_decode(l0, {}, names, 0);",
                    names.join(", "),
                    self.desc(&t)
                )
            }
            "cli.parse" | "cli.help" => {
                let Some(o) = crate::cli::Options::of(&p(0), self.prog) else {
                    // as the interpreter: not a record of options
                    return Ok(if sym == "cli.parse" {
                        let msg = format!("`{}` is not a record of options", p(0));
                        format!(
                            "return fwp_data(1, 1, (V[]){{fwp_cstr({})}});",
                            c_string_literal(msg.as_bytes())
                        )
                    } else {
                        "return fwp_cstr(\"\");".to_string()
                    });
                };
                let t = self.flag_table(&o, &[]);
                if sym == "cli.parse" {
                    format!(
                        "return fwp_p_cli_parse(l0, l1, {}, {}, {});",
                        t,
                        o.flags.len(),
                        o.nfields
                    )
                } else {
                    format!("return fwp_p_cli_help(l0, {}, {});", t, o.flags.len())
                }
            }
            "grpc.with-tls" => {
                let idx = |n: &str| match self.prog.shapes.get(&MT::con("std::TlsOptions")) {
                    Some(TypeShape::Record(fs)) => fs.iter().position(|(l, _)| l == n).unwrap_or(0),
                    _ => 0,
                };
                format!(
                    "return fwp_p_grpc_with_tls(l0, l1, {}, {}, {}, {}, {});",
                    idx("ca-file"),
                    idx("insecure"),
                    idx("server-name"),
                    idx("cert-file"),
                    idx("key-file")
                )
            }
            "http2.send" => {
                let err = self.desc(&MT::con("std::IoError"));
                format!("return fwp_p_http2_send(l0, l1, l2, {});", err)
            }
            "tls._connect" | "tls._listen" | "tls.handshake" => {
                let err = self.desc(&MT::con("std::IoError"));
                match sym {
                    "tls._connect" => format!(
                        "return fwp_p_tls_connect(l0, l1, l2, l3, l4, l5, l6, {});",
                        err
                    ),
                    "tls._listen" => {
                        format!("return fwp_p_tls_listen(l0, l1, l2, l3, l4, {});", err)
                    }
                    _ => format!("return fwp_p_tls_handshake(l0, {});", err),
                }
            }
            "tcp.listen" | "tcp.accept" | "tcp.accept-for" | "tcp.connect" | "tcp.read"
            | "tcp.read-for" | "tcp.write" | "tcp.write-for" | "udp.bind" | "udp.send-to" | "udp.recv-from"
            | "dns.resolve" => {
                let err = self.desc(&MT::con("std::IoError"));
                let (f, n) = match sym {
                    "tcp.listen" => ("fwp_p_tcp_listen", 1),
                    "tcp.accept" => ("fwp_p_tcp_accept", 1),
                    "tcp.accept-for" => ("fwp_p_tcp_accept_for", 2),
                    "tcp.connect" => ("fwp_p_tcp_connect", 1),
                    "tcp.read" => ("fwp_p_tcp_read", 2),
                    "tcp.read-for" => ("fwp_p_tcp_read_for", 3),
                    "tcp.write" => ("fwp_p_tcp_write", 2),
                    "tcp.write-for" => ("fwp_p_tcp_write_for", 3),
                    "udp.bind" => ("fwp_p_udp_bind", 1),
                    "udp.send-to" => ("fwp_p_udp_send_to", 3),
                    "udp.recv-from" => ("fwp_p_udp_recv_from", 2),
                    _ => ("fwp_p_dns_resolve", 1),
                };
                let args: Vec<String> = (0..n).map(|i| format!("l{}", i)).collect();
                format!("return {}({}, {});", f, args.join(", "), err)
            }
            _ => {
                let simple: &[(&str, &str)] = &[
                    ("map", "fwp_p_map(l0, l1)"),
                    ("filter", "fwp_p_filter(l0, l1)"),
                    ("fold", "fwp_p_fold(l0, l1, l2)"),
                    ("fold-right", "fwp_p_fold_right(l0, l1, l2)"),
                    ("length", "fwp_p_length(l0)"),
                    ("reverse", "fwp_p_reverse(l0)"),
                    ("append", "fwp_p_append(l0, l1)"),
                    ("flatten", "fwp_p_flatten(l0)"),
                    ("take", "fwp_p_take(l0, l1)"),
                    ("drop", "fwp_p_drop(l0, l1)"),
                    ("take-while", "fwp_p_take_while(l0, l1)"),
                    ("drop-while", "fwp_p_drop_while(l0, l1)"),
                    ("zip", "fwp_p_zip(l0, l1)"),
                    ("zip-with", "fwp_p_zip_with(l0, l1, l2)"),
                    ("unzip", "fwp_p_unzip(l0)"),
                    ("repeat", "fwp_p_repeat(l0, l1)"),
                    ("nth", "fwp_p_nth(l0, l1)"),
                    ("find", "fwp_p_find(l0, l1)"),
                    ("scan", "fwp_p_scan(l0, l1, l2)"),
                    ("chunks", "fwp_p_chunks(l0, l1)"),
                    ("iterate", "fwp_p_iterate(l0, l1, l2)"),
                    ("list.flat-map", "fwp_p_flat_map(l0, l1)"),
                    ("list.ap", "fwp_p_list_ap(l0, l1)"),
                    ("trim", "fwp_p_trim_impl(l0, 1, 1)"),
                    ("trim-start", "fwp_p_trim_impl(l0, 1, 0)"),
                    ("trim-end", "fwp_p_trim_impl(l0, 0, 1)"),
                    ("lower", "fwp_p_case(l0, 0)"),
                    ("upper", "fwp_p_case(l0, 1)"),
                    ("concat", "fwp_p_concat(l0, l1)"),
                    (
                        "string.length",
                        "(V)(int64_t)fwp_utf8_count(STR(l0)->d, STR(l0)->len)",
                    ),
                    ("string.byte-length", "(V)(int64_t)STR(l0)->len"),
                    ("string.chars", "fwp_p_chars(l0)"),
                    ("split", "fwp_p_split(l0, l1)"),
                    ("join", "fwp_p_join(l0, l1)"),
                    ("lines", "fwp_p_lines(l0)"),
                    ("words", "fwp_p_words(l0)"),
                    ("string.contains", "fwp_p_str_contains(l0, l1)"),
                    ("starts-with", "fwp_p_starts_with(l0, l1)"),
                    ("ends-with", "fwp_p_ends_with(l0, l1)"),
                    ("replace", "fwp_p_replace(l0, l1, l2)"),
                    ("string.repeat", "fwp_p_str_repeat(l0, l1)"),
                    ("string.reverse", "fwp_p_str_reverse(l0)"),
                    ("string.slice", "fwp_p_str_slice(l0, l1, l2)"),
                    ("string.find", "fwp_p_str_find(l0, l1)"),
                    ("pad-left", "fwp_p_pad(l0, l1, l2, 1)"),
                    ("pad-right", "fwp_p_pad(l0, l1, l2, 0)"),
                    ("string.codepoints", "fwp_p_codepoints(l0)"),
                    ("string.from-codepoints", "fwp_p_from_codepoints(l0)"),
                    ("string.to-bytes", "l0"),
                    ("string.from-bytes", "fwp_p_from_bytes(l0)"),
                    ("array.from-list", "fwp_p_array_from_list(l0)"),
                    ("array.to-list", "fwp_p_array_to_list(l0)"),
                    ("array.length", "(V)(int64_t)ARR(l0)->len"),
                    ("array.get", "fwp_p_array_get(l0, l1)"),
                    ("array.set", "fwp_p_array_set(l0, l1, l2)"),
                    ("array.push", "fwp_p_array_push(l0, l1)"),
                    ("array.make", "fwp_p_array_make(l0, l1)"),
                    ("array.generate", "fwp_p_array_generate(l0, l1)"),
                    ("array.map", "fwp_p_array_map(l0, l1)"),
                    ("array.fold", "fwp_p_array_fold(l0, l1, l2)"),
                    ("array.slice", "fwp_p_array_slice(l0, l1, l2)"),
                    ("array.append", "fwp_p_array_append(l0, l1)"),
                    ("map.empty", "FWP_EMPTY_MAP"),
                    ("set.empty", "FWP_EMPTY_MAP"),
                    ("map.size", "fwp_p_map_size(l0)"),
                    ("set.size", "fwp_p_map_size(l0)"),
                    ("map.keys", "fwp_p_map_column(l0, 0)"),
                    ("set.to-list", "fwp_p_map_column(l0, 0)"),
                    ("map.values", "fwp_p_map_column(l0, 1)"),
                    ("map.to-list", "fwp_p_map_to_list(l0)"),
                    ("map.map-values", "fwp_p_map_map_values(l0, l1)"),
                    ("bytes.from-list", "fwp_p_bytes_from_list(l0)"),
                    ("bytes.to-list", "fwp_p_bytes_to_list(l0)"),
                    ("bytes.length", "(V)(int64_t)STR(l0)->len"),
                    ("bytes.get", "fwp_p_bytes_get(l0, l1)"),
                    ("bytes.slice", "fwp_p_bytes_slice(l0, l1, l2)"),
                    ("bytes.append", "fwp_p_concat(l0, l1)"),
                    ("print", "fwp_p_print(l0)"),
                    ("linalg.lu-solve", "fwp_p_lu_solve(l0, l1, l2)"),
                    ("linalg.det", "fwp_p_det(l0, l1)"),
                    ("linalg.inverse", "fwp_p_inverse(l0, l1)"),
                    ("linalg.cholesky", "fwp_p_cholesky(l0, l1)"),
                    ("linalg.qr", "fwp_p_qr(l0, l1, l2)"),
                    ("linalg.cg", "fwp_p_cg(l0, l1, l2, l3, l4)"),
                    ("list.transpose", "fwp_p_list_transpose(l0)"),
                    ("ad.tape", "fwp_p_ad_tape(l0)"),
                    ("ad.push", "fwp_p_ad_push(l0)"),
                    ("ad.backward", "fwp_p_ad_backward(l0, l1, l2)"),
                    ("device.run", "fwp_p_device_run(l0, l1, l2, l3, l4)"),
                    ("device.sum", "fwp_p_device_sum(l0, l1, l2, l3, l4)"),
                    ("device.gpu-available", "fwp_p_gpu_available()"),
                    ("device.gpu-run", "fwp_p_gpu_run(l0, l1, l2, l3)"),
                    ("syntax.show", "fwp_p_syntax_show(l0)"),
                    ("write", "fwp_p_write(l0)"),
                    ("eprint", "fwp_p_eprint(l0)"),
                    ("ewrite", "fwp_p_ewrite(l0)"),
                    ("term.width", "fwp_p_term_width()"),
                    ("term.read-secret", "fwp_p_term_read_secret()"),
                    ("csv.parse-with", "fwp_p_csv_parse_with(l0, l1)"),
                    ("read-line", "fwp_p_read_line()"),
                    ("read-all", "fwp_read_stdin_all()"),
                    ("read-lines", "fwp_p_read_lines()"),
                    ("args", "fwp_p_args()"),
                    ("exit", "fwp_p_exit(l0)"),
                    ("env.get", "fwp_p_env_get(l0)"),
                    ("env.vars", "fwp_p_env_vars()"),
                    ("env.cwd", "fwp_p_env_cwd()"),
                    ("term.is-tty", "fwp_p_term_is_tty(l0)"),
                    ("file.exists", "fwp_p_file_exists(l0)"),
                    ("file.is-dir", "fwp_p_file_is_dir(l0)"),
                    ("time.monotonic", "fwp_p_time_monotonic()"),
                    ("time.unix", "fwp_p_time_unix()"),
                    ("random.u64", "fwp_p_random_u64()"),
                    ("random.f64", "fwp_p_random_f64()"),
                    ("attempt", "fwp_p_attempt(l0, l1)"),
                    ("get", "fwp_p_get()"),
                    ("put", "fwp_p_put(l0)"),
                    ("modify", "fwp_p_modify(l0)"),
                    ("run-state", "fwp_p_run_state(l0, l1, l2)"),
                    ("file.close", "fwp_p_file_close(l0)"),
                    ("loop", "fwp_p_loop(l0, l1)"),
                    ("json.parse", "fwp_p_json_parse(l0)"),
                    ("json.encode", "fwp_p_json_encode(l0)"),
                    ("string.split-once", "fwp_p_split_once(l0, l1)"),
                    ("bytes.find", "fwp_p_bytes_find(l0, l1)"),
                    ("url.encode", "fwp_p_url_encode(l0)"),
                    ("url.decode", "fwp_p_url_decode(l0, 0)"),
                    ("form.decode", "fwp_p_url_decode(l0, 1)"),
                    ("url.split", "fwp_p_url_split(l0)"),
                    ("http.parse-request-head", "fwp_p_parse_request_head(l0)"),
                    ("http.parse-response-head", "fwp_p_parse_response_head(l0)"),
                    ("http.field-ok", "fwp_p_field_ok(l0, l1)"),
                    ("http.content-length", "fwp_p_content_length(l0)"),
                    ("prim.trap", "fwp_p_trap(l0)"),
                    ("int.to-hex", "fwp_p_to_hex(l0)"),
                    ("int.parse-hex", "fwp_p_parse_hex(l0)"),
                    ("task.spawn", "fwp_p_task_spawn(l0)"),
                    ("task.await", "fwp_p_task_await(l0)"),
                    ("task.cancel", "fwp_p_task_cancel(l0)"),
                    ("task.within", "fwp_p_task_within(l0, l1)"),
                    ("task.sleep", "fwp_p_task_sleep(l0)"),
                    ("task.yield", "fwp_p_task_yield()"),
                    ("task.deadline", "fwp_p_task_deadline(l0, l1)"),
                    ("task.cancelled", "fwp_p_task_cancelled()"),
                    ("task.scope", "fwp_p_task_scope(l0)"),
                    ("channel.make", "fwp_p_channel_make(l0)"),
                    ("channel.send", "fwp_p_channel_send(l0, l1)"),
                    ("channel.recv", "fwp_p_channel_recv(l0)"),
                    ("channel.recv-for", "fwp_p_channel_recv_for(l0, l1)"),
                    ("channel.close", "fwp_p_channel_close(l0)"),
                    ("tcp.local-addr", "fwp_p_local_addr(l0)"),
                    ("tcp.peer-addr", "fwp_p_peer_addr(l0)"),
                    ("tcp.stop", "fwp_p_tcp_stop(l0)"),
                    ("tcp.close", "fwp_p_sock_close(l0)"),
                    ("udp.local-addr", "fwp_p_local_addr(l0)"),
                    ("udp.close", "fwp_p_sock_close(l0)"),
                    ("tls.alpn", "fwp_p_tls_alpn(l0)"),
                    ("tls.secure", "fwp_p_tls_secure(l0)"),
                    ("tls.peer-subject", "fwp_p_tls_peer_subject(l0)"),
                    ("tls.available", "FWP_TRUE"),
                    ("signal.shutdown-requested", "fwp_p_shutdown_requested()"),
                    ("signal.request-shutdown", "fwp_p_request_shutdown()"),
                    ("metrics.add", "fwp_p_metrics_update(0, l0, l1)"),
                    ("metrics.set", "fwp_p_metrics_update(1, l0, l1)"),
                    ("metrics.observe", "fwp_p_metrics_update(2, l0, l1)"),
                    ("metrics.snapshot", "fwp_p_metrics_snapshot()"),
                    ("grpc.metadata", "fwp_p_grpc_metadata()"),
                    ("grpc.with-metadata", "fwp_p_grpc_with_metadata(l0, l1)"),
                    ("grpc.with-deadline", "fwp_p_grpc_with_deadline(l0, l1)"),
                    ("grpc.peer-subject", "fwp_p_grpc_peer_subject()"),
                    ("grpc.set-header", "fwp_p_grpc_set_meta(0, l0, l1)"),
                    ("grpc.set-trailer", "fwp_p_grpc_set_meta(1, l0, l1)"),
                    (
                        "grpc.with-response-metadata",
                        "fwp_p_grpc_with_response_metadata(l0)",
                    ),
                    ("grpc.with-gzip", "fwp_p_grpc_with_gzip(l0)"),
                    ("grpc._force", "fwp_p_grpc_force(l0)"),
                    ("http2.serve", "fwp_p_http2_serve(l0, l1, l2, l3, l4)"),
                    ("http2.request", "fwp_p_http2_request(l0)"),
                    ("http2.body", "fwp_p_http2_body(l0, l1, l2)"),
                    ("http2.respond", "fwp_p_http2_respond(l0, l1, l2, l3, l4)"),
                    ("http2.data", "fwp_p_http2_data(l0, l1, l2)"),
                    ("http2.pooled", "fwp_p_http2_pooled(l0)"),
                    ("zlib.gzip", "fwp_p_zlib_gzip(l0)"),
                    ("zlib.gunzip", "fwp_p_zlib_gunzip(l0, l1)"),
                    ("zlib.deflate", "fwp_p_zlib_deflate(l0)"),
                    ("zlib.gzip-chunk", "fwp_p_zlib_gzip_chunk(l0)"),
                    ("zlib.crc32", "fwp_p_zlib_crc32(l0, l1)"),
                    ("zlib.gzip-end", "fwp_p_zlib_gzip_end(l0, l1)"),
                    ("zlib.inflate", "fwp_p_zlib_inflate(l0, l1)"),
                    ("ws.accept", "fwp_p_ws_accept(l0)"),
                    ("ws.key", "fwp_p_ws_key()"),
                    ("ws.frame", "fwp_p_ws_frame(l0, l1, l2)"),
                    ("ws.parse", "fwp_p_ws_parse(l0, l1, l2)"),
                    ("ws.close-payload", "fwp_p_ws_close_payload(l0, l1)"),
                    ("ws.close-parse", "fwp_p_ws_close_parse(l0)"),
                    ("ws.deflate", "fwp_p_ws_deflate(l0)"),
                    ("ws.inflate", "fwp_p_ws_inflate(l0, l1)"),
                ];
                match simple.iter().find(|(n, _)| *n == sym) {
                    Some((_, c)) => format!("return {};", c),
                    None => {
                        return Err(format!(
                            "primitive `{}` is not supported by the native backend",
                            sym
                        ))
                    }
                }
            }
        };
        Ok(s)
    }

    /// The RPC of function `of` (served as `func`; `func` is 0 for a
    /// client stub).
    #[allow(clippy::too_many_arguments)]
    fn rpc_spec(
        &mut self,
        name: &str,
        path: String,
        of: FuncId,
        func: FuncId,
        error: Option<&MT>,
        method: &str,
        iter_fn: Option<FuncId>,
    ) -> Result<RpcSpec, String> {
        let f = &self.prog.funcs[of];
        let (ty, arity) = (f.ty.clone(), f.arity as usize);
        let shape = crate::rpc::shape(&ty, arity, error);
        let schema = crate::rpc::method_schema(&mut self.pb, self.prog, method, &shape, error)?;
        let req: Vec<String> = shape
            .request_params()
            .iter()
            .map(|p| self.desc(p))
            .collect();
        let resp = self.desc(shape.response_type());
        let error_desc = shape.message_error(error).map(|e| self.desc(e));
        let grpc_error = self.desc(&crate::rpc::grpc_error_type());
        Ok(RpcSpec {
            name: name.to_string(),
            path,
            fingerprint: crate::protobuf::fingerprint(self.prog, &ty, error),
            func,
            req,
            resp,
            error: error_desc,
            input: shape.client_streaming() as u8,
            output: match shape.output {
                crate::rpc::Output::Value(_) => 0,
                crate::rpc::Output::Iter(_) if shape.results.is_some() => 3,
                crate::rpc::Output::Iter(_) => 1,
                crate::rpc::Output::Chan(_) => 2,
            },
            status_errors: shape.status_errors,
            iter_fn,
            schema,
            grpc_error,
        })
    }

    /// A `loop` whose step is `step`, as a C loop (see `loop_shape`): the
    /// step's body reads the state from `st` and writes the next one to
    /// `nx`, or its result to `out` (and returns 1). Safe points are those
    /// of the generic loop: one per iteration, and the step's own.
    fn loop_def(&mut self, step: FuncId, record: Option<usize>) -> String {
        let f = self.prog.funcs[step].clone();
        let Body::Expr(original) = &f.body else {
            unreachable!()
        };
        let normalized = loop_state_expr(original);
        let e = &normalized;
        let mut ts = Vec::new();
        tails(e, &mut ts);
        // a field of a record state that is itself a small record, and
        // that every `Again` gives unboxed, is kept as its fields
        let field_tys: Vec<MT> = record_fields(&self.prog.shapes, &f.locals[0])
            .map(|fs| fs.iter().map(|(_, t)| t.clone()).collect())
            .unwrap_or_default();
        let mut slots = Vec::new();
        let mut n = 0;
        for j in 0..record.unwrap_or(0) {
            let w = field_tys
                .get(j)
                .and_then(|t| small_record(self.prog, t))
                .filter(|m| {
                    ts.iter().all(|t| match t {
                        Expr::Construct(0, xs) => match &xs[0] {
                            Expr::Record(fs) => self.unboxed_value(&fs[j]) == Some(*m),
                            _ => false,
                        },
                        _ => true,
                    })
                });
            slots.push((n, w));
            n += w.unwrap_or(1);
        }
        let n = if record.is_some() { n } else { 1 };
        let lg = LoopGen {
            tails: ts.iter().map(|t| *t as *const Expr).collect(),
            record: record.is_some(),
            slots: slots.clone(),
        };
        let mut out = format!(
            "/* loop of {} : {}, the state in locals */
static inline __attribute__((always_inline)) int fs{}(V *st, V *nx, V *out) {{
",
            f.name, f.ty, step
        );
        if record.is_none() {
            out.push_str(
                "    V l0 = st[0];
",
            );
        }
        for i in 1..f.nlocals() {
            let _ = writeln!(out, "    V l{} = 0;", i);
        }
        let mut fg = FnGen {
            live_calls: self.live_calls(step, e),
            g: self,
            out: String::new(),
            tmp: 0,
            label: 0,
            indent: 1,
            in_loop: Some(lg),
            fields: HashMap::new(),
            locals: f.locals.clone(),
            known_tag: HashMap::new(),
            vlocals: HashMap::new(),
            tokens: Vec::new(),
            stack_args: Vec::new(),
            stack_children: HashMap::new(),
            known_callbacks: HashMap::new(),
            me: step,
            tail_calls: tail_calls(e),
        };
        fg.entry_tick();
        let r = fg.expr(e);
        out.push_str(&fg.out);
        let _ = writeln!(
            out,
            "    return (int)({});
}}
",
            r
        );
        let load = if record.is_some() {
            let mut ls = Vec::new();
            for (j, (off, w)) in slots.iter().enumerate() {
                match w {
                    Some(m) => ls
                        .extend((0..*m).map(|k| {
                            format!("st[{}] = OBJ(OBJ(s)->f[{}])->f[{}];", off + k, j, k)
                        })),
                    None => ls.push(format!("st[{}] = OBJ(s)->f[{}];", off, j)),
                }
            }
            ls.join(" ")
        } else {
            "st[0] = s;".into()
        };
        let slot_types = if record.is_some() {
            slots
                .iter()
                .enumerate()
                .flat_map(|(j, (off, width))| {
                    let types = match width {
                        Some(_) => record_fields(&self.prog.shapes, &field_tys[j])
                            .unwrap()
                            .iter()
                            .map(|(_, ty)| ty.clone())
                            .collect::<Vec<_>>(),
                        None => vec![field_tys[j].clone()],
                    };
                    types
                        .into_iter()
                        .enumerate()
                        .map(|(k, ty)| (off + k, ty))
                        .collect::<Vec<_>>()
                })
                .collect::<Vec<_>>()
        } else {
            vec![(0, f.locals[0].clone())]
        };
        let mut take = String::new();
        if self.reuse && record.is_some() {
            let original = self.protect_values(
                &[("s".into(), f.locals[0].clone())],
                "input_owner",
                "input_cleanup",
            );
            take.push_str(&original);
            let counted: Vec<_> = slot_types
                .iter()
                .filter(|(_, ty)| crate::rc::needs_rc(&self.prog.shapes, ty))
                .cloned()
                .collect();
            let empty: Vec<_> = counted
                .iter()
                .map(|(_, ty)| ("0".into(), ty.clone()))
                .collect();
            let preparing = self.protect_values(&empty, "prepared", "preparation_cleanup");
            take.push_str(&preparing);
            for (j, (slot, _)) in counted.iter().enumerate() {
                let _ = write!(take, " fwp_rc_dup(st[{slot}]);");
                if !preparing.is_empty() {
                    let _ = write!(take, " prepared.v{j} = st[{slot}];");
                }
            }
            if !preparing.is_empty() {
                take.push_str(" fwp_cleanup_pop(&preparation_cleanup);");
            }
            if !original.is_empty() {
                take.push_str(" fwp_cleanup_pop(&input_cleanup);");
            }
            let drop = self.value_drop(&f.locals[0]);
            let _ = write!(take, " {drop}(s);");
        }
        // Keep possible heap pointers addressable. Inline numeric/Bool fields
        // need no roots and remain eligible for scalar register promotion.
        // Boxed numerics still need roots even when they are not RC types.
        let root_fences = slot_types
            .iter()
            .filter(|(_, ty)| {
                int64_kind(ty).is_none()
                    && !matches!(ty,
                MT::Con(name, args) if args.is_empty() &&
                    matches!(name.trim_start_matches("std::"), "F32" | "F64" | "Bool"))
            })
            .map(|(slot, _)| {
                format!(
                    "        FWP_KEEP_ALIVE(st[{slot}]);\n        FWP_KEEP_ALIVE(nx[{slot}]);\n"
                )
            })
            .collect::<String>();
        // The outer tick runs before fs takes the state; save only owned
        // typed slots, never scalar address bits or already-consumed old slots.
        let (mut protect, mut save, mut transfer, mut finish) =
            (String::new(), String::new(), String::new(), String::new());
        if self.reuse && self.unwind && self.ticks {
            let owned: Vec<_> = slot_types
                .iter()
                .filter(|(_, ty)| crate::rc::needs_rc(&self.prog.shapes, ty))
                .cloned()
                .collect();
            if !owned.is_empty() {
                let id = self.cleanup_defs.len();
                let mut members = Vec::new();
                let mut releases = Vec::new();
                for (j, (slot, ty)) in owned.iter().enumerate() {
                    members.push(format!("V v{j};"));
                    let drop = self.value_drop(ty);
                    releases.push(format!("{drop}(c->v{j});"));
                    let _ = write!(save, "state_owner.v{j} = st[{slot}]; ");
                    let _ = write!(transfer, "state_owner.v{j} = 0; ");
                }
                self.cleanup_defs.push(format!("typedef struct {{ {} }} fwp_owner_ctx{id};\nstatic void fwp_owner_release{id}(void *arg) {{ fwp_owner_ctx{id} *c = arg; {} }}\n", members.join(" "), releases.join(" ")));
                protect = format!("fwp_owner_ctx{id} state_owner = {{0}}; fwp_cleanup state_cleanup; fwp_cleanup_push(&state_cleanup, fwp_owner_release{id}, &state_owner);");
                finish = "fwp_cleanup_pop(&state_cleanup);".into();
            }
        }
        // a safe point per iteration, where a task could be preempted
        let tick = if self.ticks { "FWP_TICK();" } else { "" };
        let _ = write!(
            out,
            "static V fwp_loop{id}(V s) {{
    V st[{n}] = {{0}}, nx[{n}] = {{0}}, out = 0;
    {load}{take}
    {protect}
    for (;;) {{
        {save}{tick}
        {transfer}
        int done = fs{id}(st, nx, &out);
{root_fences}        if (done) {{ {finish} return out; }}
        for (int i = 0; i < {n}; i++) st[i] = nx[i];
    }}
}}
",
            id = step,
            n = n,
            load = load,
            take = take,
            root_fences = root_fences,
            tick = tick
        );
        out
    }

    fn func(&mut self, id: FuncId) -> Result<String, String> {
        let f = &self.prog.funcs[id];
        let params: Vec<String> = (0..f.arity).map(|i| format!("V l{}", i)).collect();
        let sig = format!(
            "static V f{}({})",
            id,
            if params.is_empty() {
                "void".into()
            } else {
                params.join(", ")
            }
        );
        let mut out = format!("/* {} : {} */\n{} {{\n", f.name, f.ty, sig);
        for i in f.arity..f.nlocals() {
            let _ = writeln!(out, "    V l{} = 0;", i);
        }
        // a primitive (a C function, a remote call) may keep what it is
        // given: it is shared
        if self.reuse && !matches!(f.body, Body::Expr(_) | Body::Ctor(_)) {
            let sym = match &f.body {
                Body::Prim(s) => s.as_str(),
                _ => "",
            };
            for i in 0..f.arity {
                if crate::rc::needs_rc(&self.prog.shapes, &f.locals[i as usize])
                    && !crate::rc::prim_reads_only(sym, i as usize)
                {
                    let _ = writeln!(out, "    fwp_rc_share(l{});", i);
                }
            }
        }
        match &f.body {
            Body::Prim(sym) => {
                let sym = sym.clone();
                let func = f.clone();
                let mut s = self.prim(&func, &sym)?;
                if self.reuse {
                    if let Some(crate::ownership::Callback::Retained(i)) =
                        crate::ownership::primitive(&sym).and_then(|c| c.callback)
                    {
                        let result = func.locals[i].params(1).1;
                        let drop = self.value_drop(result);
                        let dup = if crate::rc::needs_rc(&self.prog.shapes, result) {
                            "fwp_rc_dup"
                        } else {
                            "NULL"
                        };
                        match sym.as_str() {
                            "task.spawn" => {
                                s = s.replace(
                                    "fwp_p_task_spawn(l0)",
                                    &format!("fwp_p_task_spawn_retained(l0, {drop})"),
                                )
                            }
                            "task.within" => {
                                s = s.replace(
                                    "fwp_p_task_within(l0, l1)",
                                    &format!("fwp_p_task_within_retained(l0, l1, {drop}, {dup})"),
                                )
                            }
                            _ => unreachable!("unmodeled retained callback: {sym}"),
                        }
                    }
                    // with counted references: arrays written in place, and
                    // new ones owned by compiled code
                    if let Some(crate::ownership::Contract {
                        result:
                            crate::ownership::ResultOwnership::OwnedContainer { runtime, .. }
                            | crate::ownership::ResultOwnership::OwnedAccumulator { runtime, .. },
                        ..
                    }) = crate::ownership::primitive(&sym)
                    {
                        let borrowed = format!("fwp_p_{}(", runtime);
                        if !s.contains(&borrowed) {
                            return Err(format!(
                                "owning primitive `{}` has no `{}` call",
                                sym, runtime
                            ));
                        }
                        s = s.replacen(&borrowed, &format!("fwp_p_{}_own(", runtime), 1);
                        if sym == "fold-right" {
                            let ty = func.ty.params(func.arity as usize).1.clone();
                            let drop = self.value_drop(&ty);
                            s = s.replace(
                                "fwp_p_fold_right_own(l0, l1, l2)",
                                &format!("fwp_p_fold_right_own(l0, l1, l2, {drop})"),
                            );
                        }
                    } else if let Some(contract) = crate::ownership::primitive(&sym) {
                        use crate::ownership::ResultOwnership;
                        match contract.result {
                            ResultOwnership::ChannelOperation => {
                                let ty = if sym == "channel.make" {
                                    func.ty.params(func.arity as usize).1
                                } else {
                                    &func.locals[usize::from(sym == "channel.recv-for")]
                                };
                                let MT::Con(name, elements) = ty else {
                                    return Err("channel boundary lacks its channel type".into());
                                };
                                if name != "std::Channel" || elements.len() != 1 {
                                    return Err("channel boundary lacks its element type".into());
                                }
                                let drop = self.value_drop(&elements[0]);
                                let dup = if crate::rc::needs_rc(&self.prog.shapes, &elements[0]) {
                                    "fwp_rc_dup"
                                } else {
                                    "NULL"
                                };
                                match sym.as_str() {
                                    "channel.make" => {
                                        s = s.replace(
                                            "fwp_p_channel_make(l0)",
                                            &format!("fwp_p_channel_make_owned(l0, {drop}, {dup})"),
                                        )
                                    }
                                    "channel.send" => {
                                        s = s.replace(
                                            "fwp_p_channel_send(l0, l1)",
                                            &format!("fwp_p_channel_send_owned(l0, l1, {dup})"),
                                        )
                                    }
                                    "channel.recv" => {
                                        s = s.replace(
                                            "fwp_p_channel_recv(l0)",
                                            &format!("fwp_p_channel_recv_owned(l0, {dup})"),
                                        )
                                    }
                                    "channel.recv-for" => {
                                        s = s.replace(
                                            "fwp_p_channel_recv_for(l0, l1)",
                                            &format!("fwp_p_channel_recv_for_owned(l0, l1, {dup})"),
                                        )
                                    }
                                    "channel.close" => {}
                                    _ => unreachable!("unmodeled channel operation: {sym}"),
                                }
                            }
                            ResultOwnership::OwnedTaskOption if sym == "task.await" => {
                                let ty = func.ty.params(func.arity as usize).1;
                                let MT::Con(_, args) = ty else {
                                    return Err("task await result is not an Option".into());
                                };
                                let [element] = args.as_slice() else {
                                    return Err("task await result lacks its element type".into());
                                };
                                let dup = if crate::rc::needs_rc(&self.prog.shapes, element) {
                                    "fwp_rc_dup"
                                } else {
                                    "NULL"
                                };
                                s = s.replace(
                                    "fwp_p_task_await(l0)",
                                    &format!("fwp_p_task_await_owned(l0, {dup})"),
                                );
                            }
                            ResultOwnership::OwnedCallback => {
                                let ty = func.ty.params(func.arity as usize).1;
                                let drop = self.value_drop(ty);
                                s = s.replace(
                                    "fwp_p_task_scope(l0)",
                                    &format!("fwp_p_task_scope_borrowed(l0, {drop})"),
                                );
                            }
                            ResultOwnership::FreshSpine | ResultOwnership::AliasTail { .. } => {
                                if matches!(
                                    sym.as_str(),
                                    "map" | "filter" | "take-while" | "zip-with"
                                ) {
                                    let result = func.ty.params(func.arity as usize).1;
                                    let MT::Con(name, elements) = &result else {
                                        return Err("list selection has a non-list result".into());
                                    };
                                    if name != "std::List" || elements.len() != 1 {
                                        return Err("list selection has a non-list result".into());
                                    }
                                    let ops = self.map_ops(&elements[0]);
                                    let args = (0..func.arity)
                                        .map(|i| format!("l{i}"))
                                        .collect::<Vec<_>>()
                                        .join(", ");
                                    s = s.replace(
                                        &format!("fwp_p_{}({args})", sym.replace('-', "_")),
                                        &format!(
                                            "fwp_p_{}_owned({args}, {ops})",
                                            sym.replace('-', "_")
                                        ),
                                    );
                                }
                                s = s
                                    .replace("fwp_p_range(", "fwp_p_range_owned(")
                                    .replace("fwp_p_scan(", "fwp_p_scan_owned(")
                                    .replace("fwp_p_iterate(", "fwp_p_iterate_owned(")
                                    .replace("fwp_p_filter(", "fwp_p_filter_owned(")
                                    .replace("fwp_p_zip_with(", "fwp_p_zip_with_owned(")
                                    .replace("fwp_p_take_while(", "fwp_p_take_while_owned(")
                                    .replace("fwp_p_drop_while(", "fwp_p_drop_while_owned(")
                                    .replace("fwp_p_drop(", "fwp_p_drop_owned(");
                            }
                            ResultOwnership::CopiedSpine { runtime, tail } => {
                                let result_type = func.ty.params(func.arity as usize).1;
                                let MT::Con(name, elements) = result_type else {
                                    return Err(format!(
                                        "copied spine `{sym}` has a non-list result"
                                    ));
                                };
                                if name != "std::List" || elements.len() != 1 {
                                    return Err(format!(
                                        "copied spine `{sym}` has a non-list result"
                                    ));
                                }
                                let duplicate =
                                    if crate::rc::needs_rc(&self.prog.shapes, &elements[0]) {
                                        "fwp_rc_dup(OBJ(node)->f[0]);"
                                    } else {
                                        ""
                                    };
                                let stop =
                                    tail.map(|i| format!("l{i}")).unwrap_or_else(|| "0".into());
                                let call = s.replace(
                                    &format!("fwp_p_{runtime}("),
                                    &format!("fwp_p_{runtime}_copied("),
                                );
                                if call == s {
                                    return Err(format!(
                                        "copied spine `{sym}` has no runtime call"
                                    ));
                                }
                                let result = call
                                    .strip_prefix("return ")
                                    .and_then(|r| r.strip_suffix(';'))
                                    .ok_or_else(|| {
                                        format!("copied spine `{sym}` has no return expression")
                                    })?;
                                s = format!("V result = {result}; for (V node = result; node != {stop}; node = OBJ(node)->f[1]) {{ fwp_rc_fresh(node); {duplicate} }}");
                                if tail.is_some() {
                                    let _ = write!(s, " fwp_rc_dup({stop});");
                                }
                                s.push_str(" return result;");
                            }
                            ResultOwnership::MapOperation { .. } => {
                                let map =
                                    if matches!(sym.as_str(), "map.from-list" | "set.from-list") {
                                        func.ty.params(func.arity as usize).1.clone()
                                    } else {
                                        func.locals[func.arity as usize - 1].clone()
                                    };
                                let MT::Con(name, types) = &map else {
                                    return Err(format!("typed map `{sym}` has a non-map type"));
                                };
                                let value = if name == "std::Set" && types.len() == 1 {
                                    MT::unit()
                                } else if name == "std::Map" && types.len() == 2 {
                                    types[1].clone()
                                } else {
                                    return Err(format!(
                                        "typed map `{sym}` has unsupported fields"
                                    ));
                                };
                                let key = &types[0];
                                let duplicate = |ty: &MT| {
                                    if crate::rc::needs_rc(&self.prog.shapes, ty) {
                                        "fwp_rc_dup"
                                    } else {
                                        "NULL"
                                    }
                                };
                                let dk = duplicate(key);
                                let dv = duplicate(&value);
                                let drop_key = if free_enabled()
                                    && crate::rc::needs_rc(&self.prog.shapes, key)
                                {
                                    format!("fwp_drop{}", self.drop_id(key))
                                } else {
                                    "NULL".into()
                                };
                                let drop_value = if free_enabled()
                                    && crate::rc::needs_rc(&self.prog.shapes, &value)
                                {
                                    format!("fwp_drop{}", self.drop_id(&value))
                                } else {
                                    "NULL".into()
                                };
                                let drop_map = if free_enabled() {
                                    format!("fwp_drop{}", self.drop_id(&map))
                                } else {
                                    "fwp_rc_drop".into()
                                };
                                let ops = format!("&(const fwp_map_ops){{{dk}, {dv}, {drop_key}, {drop_value}, {drop_map}}}");
                                let mut args: Vec<String> =
                                    (0..func.arity).map(|i| format!("l{i}")).collect();
                                args.push(ops);
                                if matches!(
                                    sym.as_str(),
                                    "map.insert"
                                        | "map.get"
                                        | "map.remove"
                                        | "map.update"
                                        | "map.from-list"
                                        | "set.insert"
                                        | "set.remove"
                                        | "set.from-list"
                                        | "set.union"
                                        | "set.intersect"
                                        | "set.diff"
                                ) {
                                    args.push(self.desc(key));
                                }
                                s = format!(
                                    "return fwp_p_{}_typed({});",
                                    sym.replace(['.', '-'], "_"),
                                    args.join(", ")
                                );
                            }
                            ResultOwnership::ArrayOperation { .. } => {
                                let mut args: Vec<String> =
                                    (0..func.arity).map(|i| format!("l{i}")).collect();
                                let mut element = None;
                                if !matches!(
                                    sym.as_str(),
                                    "array.generate" | "array.map" | "array.fold"
                                ) {
                                    let ty = if sym == "array.make" {
                                        func.locals[1].clone()
                                    } else {
                                        let array = &func.locals[func.arity as usize - 1];
                                        match array {
                                            MT::Con(name, fields)
                                                if (name == "std::Array"
                                                    || name == "std::List")
                                                    && fields.len() == 1 =>
                                            {
                                                fields[0].clone()
                                            }
                                            _ => {
                                                return Err(format!(
                                                    "typed array `{sym}` has an unsupported input"
                                                ))
                                            }
                                        }
                                    };
                                    args.push(if crate::rc::needs_rc(&self.prog.shapes, &ty) {
                                        "fwp_rc_dup".into()
                                    } else {
                                        "NULL".into()
                                    });
                                    element = Some(ty);
                                }
                                if matches!(sym.as_str(), "array.set" | "array.push") {
                                    let ty = element.as_ref().unwrap();
                                    args.push(
                                        if free_enabled()
                                            && crate::rc::needs_rc(&self.prog.shapes, ty)
                                        {
                                            format!("fwp_drop{}", self.drop_id(ty))
                                        } else {
                                            "NULL".into()
                                        },
                                    );
                                    let array = &func.locals[func.arity as usize - 1];
                                    args.push(if free_enabled() {
                                        format!("fwp_drop{}", self.drop_id(array))
                                    } else {
                                        "fwp_rc_drop".into()
                                    });
                                }
                                if sym == "array.sort" {
                                    args.push(self.desc(element.as_ref().unwrap()));
                                }
                                s = format!(
                                    "return fwp_p_{}_typed({});",
                                    sym.replace(['.', '-'], "_"),
                                    args.join(", ")
                                );
                            }
                            ResultOwnership::CopiedStructure => {
                                let element = |ty: &MT| -> Result<MT, String> {
                                    if let MT::Con(name, args) = ty {
                                        if name == "std::List" && args.len() == 1 {
                                            return Ok(args[0].clone());
                                        }
                                    }
                                    Err(format!("structural copy `{sym}` has a non-list input"))
                                };
                                let fields = match sym.as_str() {
                                    "zip" => {
                                        vec![element(&func.locals[1])?, element(&func.locals[0])?]
                                    }
                                    "unzip" => {
                                        let pair = element(&func.locals[0])?;
                                        let fs = record_fields(&self.prog.shapes, &pair)
                                            .ok_or_else(|| {
                                                "unzip has a non-record element".to_string()
                                            })?;
                                        if fs.len() != 2 {
                                            return Err("unzip has a non-pair element".into());
                                        }
                                        fs.iter().map(|(_, ty)| ty.clone()).collect()
                                    }
                                    "chunks" => vec![element(&func.locals[1])?],
                                    "repeat" => vec![func.locals[1].clone()],
                                    _ => return Err(format!("unknown structural copy `{sym}`")),
                                };
                                let mut args: Vec<String> =
                                    (0..func.arity).map(|i| format!("l{i}")).collect();
                                args.extend(fields.iter().map(|ty| {
                                    if crate::rc::needs_rc(&self.prog.shapes, ty) {
                                        "fwp_rc_dup".into()
                                    } else {
                                        "NULL".into()
                                    }
                                }));
                                s = format!("return fwp_p_{sym}_owned({});", args.join(", "));
                            }
                            ResultOwnership::FreshOuter => {
                                if contract.borrows_callback() {
                                    s = s.replace("fwp_p_find(", "fwp_p_find_borrowed(");
                                }
                                let result_type = func.ty.params(func.arity as usize).1;
                                let cases: Vec<(u32, Vec<MT>)> = match (
                                    record_fields(&self.prog.shapes, result_type),
                                    self.prog.shapes.get(result_type),
                                ) {
                                    (Some(fs), _) => {
                                        vec![(0, fs.iter().map(|(_, t)| t.clone()).collect())]
                                    }
                                    (None, Some(TypeShape::Adt(vs))) => vs
                                        .iter()
                                        .enumerate()
                                        .filter(|(_, (_, fs))| !fs.is_empty())
                                        .map(|(tag, (_, fs))| (tag as u32, fs.clone()))
                                        .collect(),
                                    _ => {
                                        return Err(format!(
                                            "fresh outer `{sym}` has an unsupported result"
                                        ))
                                    }
                                };
                                let result = s
                                    .strip_prefix("return ")
                                    .and_then(|r| r.strip_suffix(';'))
                                    .ok_or_else(|| {
                                        format!("fresh outer `{sym}` has no return expression")
                                    })?;
                                let mut body = format!("V result = fwp_rc_fresh({result}); if (result) {{ switch (OBJ(result)->tag) {{");
                                for (tag, fields) in cases {
                                    let _ = write!(body, " case {tag}:");
                                    for (i, ty) in fields.iter().enumerate() {
                                        if crate::rc::needs_rc(&self.prog.shapes, ty) {
                                            let _ =
                                                write!(body, " fwp_rc_dup(OBJ(result)->f[{i}]);");
                                        }
                                    }
                                    body.push_str(" break;");
                                }
                                body.push_str(" } } return result;");
                                s = body;
                            }
                            ResultOwnership::FreshTree => {
                                let result_type = func.ty.params(func.arity as usize).1.clone();
                                let owner = self.tree_owner_id(&result_type)?;
                                let result = s
                                    .strip_prefix("return ")
                                    .and_then(|r| r.strip_suffix(';'))
                                    .ok_or_else(|| {
                                        format!(
                                            "fresh tree primitive `{sym}` has no return expression"
                                        )
                                    })?;
                                s = format!("V result = {result}; fwp_own_tree{owner}(result); return result;");
                            }
                            ResultOwnership::FreshLeaf | ResultOwnership::FreshContainer => {
                                let r = s
                                    .strip_prefix("return ")
                                    .and_then(|r| r.strip_suffix(';'))
                                    .ok_or_else(|| {
                                        format!("fresh primitive `{sym}` has no return expression")
                                    })?;
                                s = format!("return fwp_rc_fresh({r});");
                            }
                            ResultOwnership::AliasArgument { argument } => {
                                if crate::rc::needs_rc(&self.prog.shapes, &func.locals[argument]) {
                                    s = format!("fwp_rc_dup(l{argument}); {s}");
                                }
                            }
                            ResultOwnership::AliasLeaf { argument } => {
                                s = format!("fwp_rc_dup(l{argument}); {s}");
                            }
                            ResultOwnership::FreshOrAliasLeaf { argument } => {
                                let r = s
                                    .strip_prefix("return ")
                                    .and_then(|r| r.strip_suffix(';'))
                                    .ok_or_else(|| {
                                        format!("alias primitive `{sym}` has no return expression")
                                    })?;
                                s = format!("V result = {r}; if (result == l{argument}) fwp_rc_dup(result); else fwp_rc_fresh(result); return result;");
                            }
                            _ => {}
                        }
                    }
                }
                let _ = writeln!(out, "    {}", s);
            }
            Body::ForeignC { symbol, variadic } => {
                let (symbol, variadic, func) = (symbol.clone(), *variadic, f.clone());
                let s = self.foreign_c(id, &func, &symbol, variadic)?;
                out.push_str(&s);
            }
            Body::Remote(r) => {
                let remote = (**r).clone();
                let n = f.arity as usize;
                let rpc = self.rpc_spec(
                    &format!("{}.{}", remote.module, remote.method),
                    remote.path.clone(),
                    id,
                    0,
                    remote.error.as_ref(),
                    &remote.method,
                    remote.iter_fn,
                )?;
                self.remotes.push(RemoteSpec { id, remote, rpc });
                let args: Vec<String> = (0..n).map(|i| format!("l{}", i)).collect();
                let _ = writeln!(
                    out,
                    "    V a[] = {{{}}};\n    return fwp_remote_call(&rs{}, a);",
                    args.join(", "),
                    id
                );
            }
            Body::Ctor(tag) => {
                let args: Vec<String> = (0..f.arity).map(|i| format!("l{}", i)).collect();
                if args.is_empty() {
                    let _ = writeln!(out, "    return (V){};", tag);
                } else {
                    let alloc = format!(
                        "fwp_data({}, {}, (V[]){{{}}})",
                        tag,
                        args.len(),
                        args.join(", ")
                    );
                    let values: Vec<_> = args
                        .iter()
                        .cloned()
                        .zip(f.ty.params(f.arity as usize).0.into_iter().cloned())
                        .collect();
                    let protect = self.protect_values(&values, "pending", "allocation_cleanup");
                    let finish = if protect.is_empty() {
                        ""
                    } else {
                        "fwp_cleanup_pop(&allocation_cleanup);"
                    };
                    let _ = writeln!(
                        out,
                        "    {protect}\n    V result = {}; {finish} return result;",
                        self.fresh(alloc)
                    );
                }
            }
            Body::Expr(e) => {
                let e = e.clone();
                if let Some(abi) = self.abis[id].clone() {
                    return Ok(self.worker(id, &abi, &e));
                }
                let locals = self.prog.funcs[id].locals.clone();
                let mut fg = FnGen {
                    live_calls: self.live_calls(id, &e),
                    g: self,
                    out: String::new(),
                    tmp: 0,
                    label: 0,
                    indent: 1,
                    in_loop: None,
                    fields: HashMap::new(),
                    locals,
                    known_tag: HashMap::new(),
                    vlocals: HashMap::new(),
                    tokens: Vec::new(),
                    stack_args: Vec::new(),
                    stack_children: HashMap::new(),
                    known_callbacks: HashMap::new(),
                    me: id,
                    tail_calls: tail_calls(&e),
                };
                fg.entry_tick();
                let r = fg.expr(&e);
                let body = fg.out;
                out.push_str(&body);
                let _ = writeln!(out, "    return {};", r);
            }
        }
        out.push_str("}\n");
        Ok(out)
    }

    /// A function with an unboxed calling convention: its worker, and the
    /// function itself, which unpacks its record parameters and boxes its
    /// record result.
    fn worker(&mut self, id: FuncId, abi: &Abi, e: &Expr) -> String {
        let f = &self.prog.funcs[id];
        let mut out = format!("/* {} : {} */\n{} {{\n", f.name, f.ty, abi.sig(id));
        for i in f.arity..f.nlocals() {
            let _ = writeln!(out, "    V l{} = 0;", i);
        }
        let mut fields = HashMap::new();
        for (i, p) in abi.params.iter().enumerate() {
            if let Some(n) = p {
                fields.insert(
                    i as Local,
                    (0..*n).map(|k| format!("l{}_{}", i, k)).collect(),
                );
            }
        }
        let mut fg = FnGen {
            live_calls: self.live_calls(id, e),
            g: self,
            out: String::new(),
            tmp: 0,
            label: 0,
            indent: 1,
            in_loop: None,
            fields,
            locals: f.locals.clone(),
            known_tag: HashMap::new(),
            vlocals: HashMap::new(),
            tokens: Vec::new(),
            stack_args: Vec::new(),
            stack_children: HashMap::new(),
            known_callbacks: HashMap::new(),
            me: id,
            tail_calls: tail_calls(e),
        };
        fg.entry_tick();
        let ret = match (abi.ret, abi.vret) {
            (Some(n), _) => {
                let fs = fg.expr_fields(e, n);
                format!("(fwp_r{}){{{{{}}}}}", n, fs.join(", "))
            }
            (None, Some(m)) => {
                let ty = fg.ret_type(id);
                let (tag, fs) = fg.expr_variant(e, m, &ty);
                format!("(fwp_u{}){{{}, {{{}}}}}", m, tag, fs.join(", "))
            }
            (None, None) => fg.expr(e),
        };
        out.push_str(&fg.out);
        let _ = writeln!(out, "    return {};\n}}", ret);
        // the function as a value: unpack, call, box
        let params: Vec<String> = (0..f.arity).map(|i| format!("V l{}", i)).collect();
        let mut args = Vec::new();
        for (i, p) in abi.params.iter().enumerate() {
            match p {
                Some(n) => args.extend((0..*n).map(|k| format!("OBJ(l{})->f[{}]", i, k))),
                None => args.push(format!("l{}", i)),
            }
        }
        let call = format!("w{}({})", id, args.join(", "));
        // The wrapper keeps boxed arguments, while the worker consumes
        // duplicated fields and other arguments. Protect originals before
        // preparation, and each completed duplicate until worker entry.
        let (mut pre, mut post) = (String::new(), String::new());
        if self.reuse {
            let counted_fields: Vec<_> = abi
                .params
                .iter()
                .enumerate()
                .filter(|(_, p)| p.is_some())
                .flat_map(|(i, _)| {
                    record_fields(&self.prog.shapes, &f.locals[i])
                        .unwrap_or_default()
                        .iter()
                        .enumerate()
                        .filter(|(_, (_, ty))| crate::rc::needs_rc(&self.prog.shapes, ty))
                        .map(move |(j, (_, ty))| (format!("OBJ(l{i})->f[{j}]"), ty.clone()))
                })
                .collect();
            let has_boxed = abi.params.iter().any(Option::is_some);
            let originals: Vec<_> = if has_boxed {
                f.ty.params(f.arity as usize)
                    .0
                    .into_iter()
                    .enumerate()
                    .map(|(i, ty)| (format!("l{i}"), ty.clone()))
                    .collect()
            } else {
                Vec::new()
            };
            let protection = self.protect_values(&originals, "owned", "cleanup");
            pre.push_str(&protection);
            if !protection.is_empty() {
                post.push_str("fwp_cleanup_pop(&cleanup); ");
            }
            let empty_fields: Vec<_> = counted_fields
                .iter()
                .map(|(_, ty)| ("0".into(), ty.clone()))
                .collect();
            let preparing = self.protect_values(&empty_fields, "prepared", "preparation_cleanup");
            pre.push_str(&preparing);
            for (j, (value, _)) in counted_fields.iter().enumerate() {
                let _ = write!(pre, " fwp_rc_dup({value}); ");
                if !preparing.is_empty() {
                    let _ = write!(pre, "prepared.v{j} = {value}; ");
                }
            }
            if !preparing.is_empty() {
                pre.push_str("fwp_cleanup_pop(&preparation_cleanup); ");
            }
            if !protection.is_empty() {
                let mut slot = 0;
                for (i, (_, ty)) in originals.iter().enumerate() {
                    if !crate::rc::needs_rc(&self.prog.shapes, ty) {
                        continue;
                    }
                    if abi.params[i].is_none() {
                        let _ = write!(pre, "owned.v{slot} = 0; ");
                    }
                    slot += 1;
                }
            }
            for (i, p) in abi.params.iter().enumerate() {
                if p.is_some() {
                    let ty = self.prog.funcs[id].locals[i].clone();
                    let drop = self.value_drop(&ty);
                    let _ = write!(post, "{drop}(l{i}); ");
                }
            }
        }
        let body = match (abi.ret, abi.vret) {
            (Some(n), _) => {
                let ty = f.ty.params(f.arity as usize).1.clone();
                let fields: Vec<_> = record_fields(&self.prog.shapes, &ty)
                    .expect("record ABI result")
                    .iter()
                    .enumerate()
                    .map(|(i, (_, ty))| (format!("r.f[{i}]"), ty.clone()))
                    .collect();
                let protect = self.protect_values(&fields, "pending_result", "boxing_cleanup");
                let finish = if protect.is_empty() {
                    ""
                } else {
                    "fwp_cleanup_pop(&boxing_cleanup);"
                };
                format!("{pre}fwp_r{n} r = {call}; {post}{protect} V result = {}; {finish}return result;",
                    self.fresh(format!("fwp_record({n}, r.f)")))
            }
            (None, Some(m)) => {
                let f = &self.prog.funcs[id];
                let t = f.ty.params(f.arity as usize).1.clone();
                let k = self.vhelper(&t, m);
                format!(
                    "{}fwp_u{} r = {}; {}return fwp_vbox{}(r);",
                    pre, m, call, post, k
                )
            }
            (None, None) => format!("{}V r = {}; {}return r;", pre, call, post),
        };
        let _ = writeln!(
            out,
            "static V f{}({}) {{ {} }}",
            id,
            params.join(", "),
            body
        );
        out
    }
}

/// A C value from a word.
fn ffi_to_c(t: &crate::ffi::CType, v: &str) -> String {
    use crate::ffi::CType;
    match t {
        CType::Int { .. } => format!("({})(int64_t)({})", crate::ffi::c_name(t), v),
        CType::F32 => format!("fwp_f32({})", v),
        CType::F64 => format!("fwp_f64({})", v),
        CType::Bool => format!("(({}) == FWP_TRUE)", v),
        CType::Str => format!("fwp_c_str_arg({})", v),
        CType::Bytes => format!("((const uint8_t *)STR({})->d)", v),
        CType::Ptr | CType::Callback { .. } => format!("((void *)(uintptr_t)({}))", v),
        CType::OptPtr => format!(
            "(({v}) ? (void *)(uintptr_t)OBJ({v})->f[0] : (void *)0)",
            v = v
        ),
        CType::Struct { name, .. } => format!("fwp_v2s_{}({})", name, v),
        CType::Void => "0".into(),
    }
}

/// A word from a C value.
fn ffi_from_c(t: &crate::ffi::CType, e: &str) -> String {
    use crate::ffi::CType;
    match t {
        CType::Int { signed: true, .. } => format!("(V)(int64_t)({})", e),
        CType::Int { signed: false, .. } => format!("(V)({})", e),
        CType::F32 => format!("fwp_from_f32({})", e),
        CType::F64 => format!("fwp_from_f64({})", e),
        CType::Bool => format!("(({}) ? FWP_TRUE : FWP_FALSE)", e),
        CType::Str => format!("fwp_c_string({})", e),
        CType::Ptr | CType::Bytes | CType::Callback { .. } => format!("(V)(uintptr_t)({})", e),
        CType::OptPtr => format!("fwp_c_optptr({})", e),
        CType::Struct { name, .. } => format!("fwp_s2v_{}({})", name, e),
        CType::Void => "FWP_UNIT".into(),
    }
}

impl Gen<'_> {
    /// Struct definitions and converters for the structs among `types`.
    fn ffi_structs(&mut self, types: &[crate::ffi::CType]) {
        use crate::ffi::CType;
        for t in types {
            match t {
                CType::Struct { name, fields } if !self.ffi_structs.contains(name) => {
                    self.ffi_structs.push(name.clone());
                    let mut d = String::new();
                    crate::ffi::struct_defs(std::slice::from_ref(t), &mut d, &mut Vec::new());
                    let _ = writeln!(
                        d,
                        "static struct fwp_c_{n} fwp_v2s_{n}(V v) {{\n    struct fwp_c_{n} s;",
                        n = name
                    );
                    for (f, idx, ft) in fields {
                        let _ = writeln!(
                            d,
                            "    s.{} = {};",
                            f,
                            ffi_to_c(ft, &format!("OBJ(v)->f[{}]", idx))
                        );
                    }
                    d.push_str("    return s;\n}\n");
                    let _ = writeln!(
                        d,
                        "static V fwp_s2v_{n}(struct fwp_c_{n} s) {{\n    V f[{k}];",
                        n = name,
                        k = fields.len()
                    );
                    for (f, idx, ft) in fields {
                        let _ = writeln!(
                            d,
                            "    f[{}] = {};",
                            idx,
                            ffi_from_c(ft, &format!("s.{}", f))
                        );
                    }
                    let _ = writeln!(d, "    return fwp_record({}, f);\n}}", fields.len());
                    self.ffi_decls.push_str(&d);
                }
                CType::Callback { params, ret } => {
                    let mut inner = params.clone();
                    inner.push((**ret).clone());
                    self.ffi_structs(&inner);
                }
                _ => {}
            }
        }
    }

    /// Body of a foreign C function instance (callbacks are kept in
    /// per-parameter slots, so C code may not call them after returning).
    fn foreign_c(
        &mut self,
        id: FuncId,
        f: &Func,
        symbol: &str,
        variadic: Option<u32>,
    ) -> Result<String, String> {
        use crate::ffi::{self, CType};
        let (params, ret) = ffi::signature(self.prog, f)
            .map_err(|e| format!("foreign function `{}`: {}", symbol, e))?;
        let mut all: Vec<CType> = params.iter().map(|(_, c)| c.clone()).collect();
        all.push(ret.clone());
        self.ffi_structs(&all);
        let ctypes: Vec<CType> = params.iter().map(|(_, c)| c.clone()).collect();
        let cname = format!("fwp_ffi_{}", id);
        self.ffi_decls
            .push_str(&ffi::prototype(&cname, symbol, &ctypes, &ret, variadic));
        let pmts: Vec<MT> =
            f.ty.params(f.arity as usize)
                .0
                .into_iter()
                .cloned()
                .collect();
        let mut body = String::new();
        let mut args = Vec::new();
        let mut restore = Vec::new();
        for (k, (i, c)) in params.iter().enumerate() {
            if let CType::Callback {
                params: cps,
                ret: cr,
            } = c
            {
                // trampoline: C arguments to words, apply the closure
                let _ = writeln!(self.ffi_decls, "static V fwp_cbslot_{}_{};", id, k);
                let decl: Vec<String> = cps
                    .iter()
                    .enumerate()
                    .map(|(j, p)| format!("{} a{}", ffi::c_name(p), j))
                    .collect();
                let _ = writeln!(
                    self.ffi_decls,
                    "static {} fwp_cb_{}_{}({}) {{",
                    ffi::c_name(cr),
                    id,
                    k,
                    if decl.is_empty() {
                        "void".into()
                    } else {
                        decl.join(", ")
                    }
                );
                // the closure's own parameters, unit ones included
                let mut cargs = Vec::new();
                let mut cur = &pmts[*i];
                let mut j = 0;
                while let MT::Fun(a, b) = cur {
                    if ffi::classify(self.prog, a).ok() == Some(CType::Void) {
                        cargs.push("FWP_UNIT".to_string());
                    } else {
                        cargs.push(ffi_from_c(&cps[j], &format!("a{}", j)));
                        j += 1;
                    }
                    cur = b;
                }
                let _ = writeln!(
                    self.ffi_decls,
                    "    V a[{}] = {{{}}};\n    V r = fwp_apply(fwp_cbslot_{}_{}, {}, a);",
                    cargs.len().max(1),
                    if cargs.is_empty() {
                        "0".into()
                    } else {
                        cargs.join(", ")
                    },
                    id,
                    k,
                    cargs.len()
                );
                if **cr == CType::Void {
                    self.ffi_decls.push_str("    (void)r;\n}\n");
                } else {
                    let _ = writeln!(self.ffi_decls, "    return {};\n}}", ffi_to_c(cr, "r"));
                }
                // saved and restored around the call: a callback may call
                // this function again (C calling fwp calling C)
                let _ = writeln!(
                    body,
                    "    V fwp_saved_{k} = fwp_cbslot_{id}_{k};\n    fwp_cbslot_{id}_{k} = l{i};",
                    id = id,
                    k = k,
                    i = i
                );
                restore.push(format!("    fwp_cbslot_{}_{} = fwp_saved_{};\n", id, k, k));
                args.push(format!("(void *)fwp_cb_{}_{}", id, k));
            } else {
                args.push(ffi_to_c(c, &format!("l{}", i)));
            }
        }
        let call = format!("{}({})", cname, args.join(", "));
        let restore = restore.concat();
        if ret == CType::Void {
            let _ = write!(body, "    {};\n{}    return FWP_UNIT;\n", call, restore);
        } else if restore.is_empty() {
            let _ = writeln!(body, "    return {};", ffi_from_c(&ret, &call));
        } else {
            let _ = write!(
                body,
                "    V fwp_r = {};\n{}    return fwp_r;\n",
                ffi_from_c(&ret, &call),
                restore
            );
        }
        Ok(body)
    }
}

/// What the generated executable runs.
enum Mode<'a> {
    Main,
    Tests,
    /// Exported functions as a standalone executable: one function, or
    /// commands of a multi-command program with this name.
    Exec(Vec<crate::cli::Command>, Option<&'a str>),
    /// Exported functions as C functions of a library.
    Library,
    /// A module's exported functions as a gRPC service.
    Service,
}

/// The C name of an exported function.
pub fn c_export_name(name: &str) -> String {
    name.chars()
        .map(|c| if c.is_ascii_alphanumeric() { c } else { '_' })
        .collect()
}

/// C signatures of the exported functions: (name, function, parameters
/// with their positions, result).
type ExportSig = (
    String,
    FuncId,
    Vec<(usize, crate::ffi::CType)>,
    crate::ffi::CType,
);

fn export_sigs(prog: &Program) -> Result<Vec<ExportSig>, String> {
    let mut out = Vec::new();
    for (name, fid) in &prog.exports {
        let (params, ret) = crate::ffi::signature(prog, &prog.funcs[*fid])
            .map_err(|e| format!("exported function `{}`: {}", name, e))?;
        if params
            .iter()
            .any(|(_, c)| matches!(c, crate::ffi::CType::Callback { .. }))
            || matches!(ret, crate::ffi::CType::Callback { .. })
        {
            return Err(format!(
                "exported function `{}`: functions cannot cross the C boundary as values",
                name
            ));
        }
        out.push((c_export_name(name), *fid, params, ret));
    }
    Ok(out)
}

/// A C library of the exported functions: its source and its header.
pub fn generate_library(prog: &Program, lib_name: &str) -> Result<(String, String), String> {
    let sigs = export_sigs(prog)?;
    if sigs.is_empty() {
        return Err("the library exports no functions (mark them with `export`)".into());
    }
    let src = generate_mode(prog, Mode::Library)?;
    let guard: String = lib_name
        .chars()
        .map(|c| {
            if c.is_ascii_alphanumeric() {
                c.to_ascii_uppercase()
            } else {
                '_'
            }
        })
        .collect();
    let mut h = format!(
        "/* {name}: generated by fwp from the exported functions. */\n#ifndef FWP_{g}_H\n#define FWP_{g}_H\n\n#include <stddef.h>\n#include <stdint.h>\n\n#ifdef __cplusplus\nextern \"C\" {{\n#endif\n\n",
        name = lib_name,
        g = guard
    );
    let mut all = Vec::new();
    for (_, _, ps, r) in &sigs {
        all.extend(ps.iter().map(|(_, c)| c.clone()));
        all.push(r.clone());
    }
    let mut seen = Vec::new();
    crate::ffi::struct_defs(&all, &mut h, &mut seen);
    for n in &seen {
        let _ = writeln!(h, "typedef struct fwp_c_{n} {n};", n = n);
    }
    if !seen.is_empty() {
        h.push('\n');
    }
    for (cname, _, ps, r) in &sigs {
        let params: Vec<String> = ps.iter().map(|(_, c)| crate::ffi::c_name(c)).collect();
        let _ = writeln!(
            h,
            "{} {}({});",
            crate::ffi::c_name(r),
            cname,
            if params.is_empty() {
                "void".into()
            } else {
                params.join(", ")
            }
        );
    }
    h.push_str("\n#ifdef __cplusplus\n}\n#endif\n\n#endif\n");
    Ok((src, h))
}

/// Generate the complete C program running `main`.
pub fn generate(prog: &Program) -> Result<String, String> {
    if prog.main.is_none() {
        return Err("no `main` binding to compile".into());
    }
    generate_mode(prog, Mode::Main)
}

/// Generate a C program that runs the program's tests.
pub fn generate_tests(prog: &Program) -> Result<String, String> {
    generate_mode(prog, Mode::Tests)
}

/// Generate the executable of a service: the program's `service` module
/// served over gRPC.
pub fn generate_service(prog: &Program) -> Result<String, String> {
    if prog.service.is_none() {
        return Err("no service to generate".into());
    }
    generate_mode(prog, Mode::Service)
}

/// Generate a standalone executable for an exported function.
pub fn generate_exec(prog: &Program, fid: FuncId, name: &str) -> Result<String, String> {
    let version = crate::cli::version(prog)?;
    let cmd = crate::cli::command(prog, fid, name, None, version)?;
    generate_mode(prog, Mode::Exec(vec![cmd], None))
}

/// Generate a multi-command executable named `name`: every exported
/// function exposed as `cli` is a command (`fwp build --cli`).
pub fn generate_cli(prog: &Program, name: &str) -> Result<String, String> {
    let cmds = crate::cli::commands(prog, Some(name))?;
    if cmds.is_empty() {
        return Err(crate::cli::none_exposed("cli", "a command"));
    }
    generate_mode(prog, Mode::Exec(cmds, Some(name)))
}

/// The start of `main` of a command-line program: its texts.
const CLI_INIT: &str = "    fwp_cli_version = exec_version;\n    for (int i = 0; i < 3; i++) fwp_cli_scripts[i] = exec_scripts[i];\n    fwp_cli_man = exec_man;\n";

/// A list of positions as a C array literal ended by -1, or `0`.
fn int_list(xs: &[usize]) -> String {
    if xs.is_empty() {
        return "0".into();
    }
    let items: Vec<String> = xs.iter().map(|x| x.to_string()).collect();
    format!("(const int[]){{{}, -1}}", items.join(", "))
}

fn bytes_literal(b: &[u8]) -> String {
    let parts: Vec<String> = b.iter().map(|x| x.to_string()).collect();
    format!(
        "{{{}}}",
        if parts.is_empty() {
            "0".into()
        } else {
            parts.join(", ")
        }
    )
}

/// The functions a program can reach from its roots (`main`, tests,
/// exports, functions named by the driver, served methods, and `extra`):
/// after inlining, most instances of small combinators are reached by
/// nothing, and no C is generated for them.
fn live_functions(prog: &Program, extra: &[FuncId]) -> Vec<bool> {
    let mut live = vec![false; prog.funcs.len()];
    let mut work: Vec<FuncId> = extra.to_vec();
    work.extend(prog.main);
    work.extend(prog.tests.iter().map(|(_, f)| *f));
    work.extend(prog.exports.iter().map(|(_, f)| *f));
    work.extend(prog.named.iter().map(|(_, f)| *f));
    if let Some(svc) = &prog.service {
        for m in &svc.methods {
            work.push(m.func);
            work.extend(m.iter_fn);
        }
    }
    // compile-time constants may hold closures
    fn value_refs(v: &crate::value::Value, out: &mut Vec<FuncId>) {
        use crate::value::Value;
        match v {
            Value::Closure(c) => {
                out.push(c.func);
                c.args.iter().for_each(|x| value_refs(x, out));
            }
            Value::Data(_, fs) | Value::Record(fs) => fs.iter().for_each(|x| value_refs(x, out)),
            Value::Array(xs) => xs.iter().for_each(|x| value_refs(x, out)),
            Value::Map(m) => m.iter().for_each(|(k, x)| {
                value_refs(k, out);
                value_refs(x, out);
            }),
            _ => {}
        }
    }
    fn refs(e: &Expr, out: &mut Vec<FuncId>) {
        match e {
            Expr::Dup(_, b) | Expr::Drop(_, b) => refs(b, out),
            Expr::Local(_) => {}
            Expr::Const(v) => value_refs(v, out),
            Expr::Func(f) => out.push(*f),
            Expr::Call(f, a) => {
                out.push(*f);
                a.iter().for_each(|x| refs(x, out));
            }
            Expr::Apply(f, a) => {
                refs(f, out);
                a.iter().for_each(|x| refs(x, out));
            }
            Expr::Construct(_, a) | Expr::Record(a) => a.iter().for_each(|x| refs(x, out)),
            Expr::Field(r, _) => refs(r, out),
            Expr::SetFields(r, s) => {
                refs(r, out);
                s.iter().for_each(|(_, x)| refs(x, out));
            }
            Expr::Let(_, v, b) => {
                refs(v, out);
                refs(b, out);
            }
            Expr::Match(sc, arms) => {
                refs(sc, out);
                arms.iter().for_each(|(_, b)| refs(b, out));
            }
        }
    }
    while let Some(f) = work.pop() {
        if f >= live.len() || live[f] {
            continue;
        }
        live[f] = true;
        match &prog.funcs[f].body {
            Body::Expr(e) => refs(e, &mut work),
            Body::Remote(r) => work.extend(r.iter_fn),
            _ => {}
        }
    }
    live
}

fn generate_mode(prog: &Program, mode: Mode) -> Result<String, String> {
    let tests = matches!(mode, Mode::Tests);
    let main = prog.main.unwrap_or(0);
    // the calling conventions follow the bodies as they are; with counted
    // references, the code is generated from the counted bodies
    let mut abis: Vec<Option<Abi>> = prog.funcs.iter().map(|f| abi_of(prog, f)).collect();
    wide_record_returns(prog, &mut abis);
    if variant_returns_enabled() {
        variant_returns(prog, &mut abis);
    }
    let reuse = reuse_enabled();
    let counted;
    let prog = if reuse {
        counted = counted_program(prog);
        &counted
    } else {
        prog
    };
    let mut g = Gen {
        prog,
        descs: HashMap::new(),
        desc_defs: Vec::new(),
        drops: HashMap::new(),
        drop_defs: Vec::new(),
        cleanup_defs: Vec::new(),
        tree_owners: HashMap::new(),
        tree_owner_defs: Vec::new(),
        vhelpers: HashMap::new(),
        vhelper_defs: Vec::new(),
        vhelper_decls: Vec::new(),
        strings: HashMap::new(),
        string_defs: Vec::new(),
        consts: Vec::new(),
        const_init: String::new(),
        used_closures: vec![false; prog.funcs.len()],
        ffi_decls: String::new(),
        ffi_structs: Vec::new(),
        pb: crate::protobuf::Schema::default(),
        remotes: Vec::new(),
        cli_defs: String::new(),
        cli_flags: HashMap::new(),
        ticks: uses_async(prog) || uses_services(prog),
        unwind: uses_async(prog)
            || uses_services(prog)
            || tests
            || matches!(mode, Mode::Library | Mode::Service | Mode::Exec(..))
            || prog
                .funcs
                .iter()
                .any(|f| matches!(&f.body, Body::Prim(s) if s == "attempt" || s == "run-state")),
        loops: Vec::new(),
        hofs: Vec::new(),
        abis,
        noesc: crate::escape::params(prog),
        reuse,
        callbacks: Vec::new(),
        owned_callbacks: Vec::new(),
        owned_fold_callbacks: Vec::new(),
        owned_right_fold_callbacks: Vec::new(),
    };
    let mut roots = Vec::new();
    if let Mode::Exec(cmds, _) = &mode {
        roots.extend(cmds.iter().map(|c| c.fid));
    }
    let live = live_functions(prog, &roots);
    let mut bodies = String::new();
    for id in (0..prog.funcs.len()).filter(|&id| live[id]) {
        bodies.push_str(&g.func(id)?);
        bodies.push('\n');
    }
    for i in 0..g.hofs.len() {
        let hof = g.hofs[i].clone();
        let loop_ops = if g.reuse && hof.0 == "loop" {
            let step = prog.funcs[hof.1]
                .ty
                .params(prog.funcs[hof.1].arity as usize)
                .1
                .clone();
            Some(g.loop_ops(&step)?)
        } else {
            None
        };
        let map_ops =
            if g.reuse && matches!(hof.0.as_str(), "map" | "filter" | "take-while" | "zip-with") {
                let (params, result) = prog.funcs[hof.1]
                    .ty
                    .params(prog.funcs[hof.1].arity as usize);
                let element = if matches!(hof.0.as_str(), "map" | "zip-with") {
                    result.clone()
                } else {
                    params[hof.2].clone()
                };
                Some(g.map_ops(&element))
            } else {
                None
            };
        let fold_drop = if g.reuse && matches!(hof.0.as_str(), "fold" | "fold-right" | "loop") {
            let ty = prog.funcs[hof.1]
                .ty
                .params(prog.funcs[hof.1].arity as usize)
                .1
                .clone();
            let ty = if hof.0 == "loop" {
                prog.funcs[hof.1]
                    .ty
                    .params(prog.funcs[hof.1].arity as usize)
                    .0[hof.2]
                    .clone()
            } else {
                ty
            };
            Some(g.value_drop(&ty))
        } else {
            None
        };
        bodies.push_str(&hof_def(
            i,
            &hof,
            g.reuse,
            loop_ops.as_deref(),
            map_ops.as_deref(),
            fold_drop.as_deref(),
        ));
        bodies.push('\n');
    }
    // the specialized loops, which may use others
    let mut li = 0;
    while li < g.loops.len() {
        let (step, record) = g.loops[li];
        bodies.push_str(&g.loop_def(step, record));
        bodies.push('\n');
        li += 1;
    }
    let mut lib_defs = String::new();
    if let Mode::Library = mode {
        lib_defs.push_str(
            "static int fwp_lib_ready = 0;\n\nstatic void fwp_lib_init(void) {\n    if (fwp_lib_ready) return;\n    fwp_lib_ready = 1;\n    fwp_fns = fwp_fn_table;\n    fwp_prog_out = stdout;\n    clock_gettime(CLOCK_MONOTONIC, &fwp_start_time);\n    fwp_seed_rng();\n    fwp_init_consts();\n}\n\n",
        );
        for (cname, fid, ps, r) in export_sigs(prog)? {
            let mut all: Vec<crate::ffi::CType> = ps.iter().map(|(_, c)| c.clone()).collect();
            all.push(r.clone());
            g.ffi_structs(&all);
            let decl: Vec<String> = ps
                .iter()
                .map(|(i, c)| format!("{} a{}", crate::ffi::c_name(c), i))
                .collect();
            let f = &prog.funcs[fid];
            let args: Vec<String> = (0..f.arity as usize)
                .map(|i| match ps.iter().find(|(j, _)| *j == i) {
                    Some((_, c)) => ffi_from_c(c, &format!("a{}", i)),
                    None => "FWP_UNIT".into(),
                })
                .collect();
            let call = if f.arity == 0 {
                format!("caf{}()", fid)
            } else {
                format!("f{}({})", fid, args.join(", "))
            };
            let _ = writeln!(
                lib_defs,
                "{} {}({}) {{\n    fwp_lib_init();",
                crate::ffi::c_name(&r),
                cname,
                if decl.is_empty() {
                    "void".into()
                } else {
                    decl.join(", ")
                }
            );
            if r == crate::ffi::CType::Void {
                let _ = writeln!(lib_defs, "    (void){};\n}}\n", call);
            } else {
                let _ = writeln!(lib_defs, "    return {};\n}}\n", ffi_to_c(&r, &call));
            }
        }
    }
    let main_ty = match mode {
        Mode::Main => prog.funcs[main].ty.clone(),
        _ => MT::unit(),
    };
    // exec mode: descriptors and protocol data for the function's interface
    let mut exec_defs = String::new();
    if let Mode::Exec(cmds, program) = &mode {
        for (i, c) in cmds.iter().enumerate() {
            let fid = c.fid;
            let n = c.params.len();
            let params = &c.params;
            // the parameter stdin may give: the last positional one, or
            // the record of a function that also takes it as before
            let range = c.pos_range();
            let last = if c.record_fallback {
                params[0].clone()
            } else if range.is_empty() {
                MT::unit()
            } else {
                params[range.end - 1].clone()
            };
            let in_elem = crate::cli::list_elem(&last).unwrap_or_else(|| last.clone());
            let pd: Vec<String> = params.iter().map(|p| g.desc(p)).collect();
            let pn: Vec<String> = params
                .iter()
                .map(|p| c_string_literal(p.to_string().as_bytes()))
                .collect();
            let out = &c.output;
            let od = g.desc(&out.elem);
            let idd = g.desc(&in_elem);
            let header = crate::proto::header(&out.elem, prog);
            let fp = crate::proto::fingerprint(&crate::proto::canonical_type(&in_elem, prog));
            let (flags, nflags, nfields) = match &c.options {
                Some(o) => (g.flag_table(o, &c.defaults), o.flags.len(), o.nfields),
                None => ("0".to_string(), 0, 0),
            };
            let mut prows = Vec::new();
            for p in &c.positional {
                prows.push(format!(
                    "{{{}, {}, {}, {}, {}}}",
                    g.desc(&p.value_ty),
                    c_string_literal(p.value_ty.to_string().as_bytes()),
                    g.desc(&p.ty),
                    p.kind as u8,
                    match &p.default {
                        Some(d) => c_string_literal(d.as_bytes()),
                        None => "0".into(),
                    }
                ));
            }
            if prows.is_empty() {
                prows.push("{0, 0, 0, 0, 0}".into());
            }
            let (outcome, ro, rs) = match out.outcome {
                Some((o, st)) => (1, o, st),
                None => (0, 0, 0),
            };
            let _ = write!(
                exec_defs,
                r#"
static const fwp_desc *const exec_params{i}[] = {{{pd}}};
static const char *const exec_param_names{i}[] = {{{pn}}};
static const fwp_pos exec_pos{i}[] = {{{prows}}};
static const unsigned char exec_out_header{i}[] = {header};
static const unsigned char exec_in_fp{i}[16] = {fp};
static V exec_caf{i}(void) {{ return {entry}; }}
static const fwp_exec_spec exec_spec{i} = {{
    {name}, {export}, {usage}, {help}, {fid}, {arity}, exec_params{i}, exec_param_names{i},
    {has_opts}, {fallback}, {nflags}, {nfields}, {flags}, exec_pos{i}, {npos}, {nreq}, {variadic}, {unit_last},
    {outcome}, {ro}, {rs}, {err}, {ropt}, {rlist}, {od}, exec_out_header{i}, sizeof exec_out_header{i}, {llist}, {idd},
    {itype}, exec_in_fp{i}, exec_caf{i}}};
"#,
                i = i,
                pd = if pd.is_empty() {
                    "0".into()
                } else {
                    pd.join(", ")
                },
                pn = if pn.is_empty() {
                    "0".into()
                } else {
                    pn.join(", ")
                },
                prows = prows.join(", "),
                header = bytes_literal(&header),
                fp = bytes_literal(&fp),
                entry = if n == 0 {
                    format!("caf{}()", fid)
                } else {
                    "0".into()
                },
                name = c_string_literal(c.name.as_bytes()),
                export = c_string_literal(c.command.as_bytes()),
                usage = c_string_literal(c.usage.as_bytes()),
                help = c_string_literal(c.help.as_bytes()),
                fid = fid,
                arity = n,
                has_opts = c.options.is_some() as u8,
                fallback = c.record_fallback as u8,
                nflags = nflags,
                nfields = nfields,
                flags = flags,
                npos = c.positional.len(),
                nreq = c.nrequired(),
                variadic = c.variadic() as u8,
                unit_last = c.unit_last as u8,
                outcome = outcome,
                ro = ro,
                rs = rs,
                err = match &out.error {
                    Some(e) => g.desc(e),
                    None => "0".into(),
                },
                ropt = out.option as u8,
                rlist = out.list as u8,
                od = od,
                llist = crate::cli::list_elem(&last).is_some() as u8,
                idd = idd,
                itype = c_string_literal(in_elem.to_string().as_bytes()),
            );
        }
        // completion scripts and the man page
        let multi = program.as_deref();
        let mut scripts = Vec::new();
        for sh in crate::cli_gen::SHELLS {
            let text = crate::cli_gen::completions(sh, cmds, multi).unwrap_or_default();
            scripts.push(c_string_literal(text.as_bytes()));
        }
        let _ = writeln!(
            exec_defs,
            "static const char *const exec_scripts[3] = {{{}}};\nstatic const char exec_man[] = {};",
            scripts.join(", "),
            c_string_literal(
                crate::cli_gen::man_page(cmds, multi, &prog.docs.module).as_bytes()
            ),
        );
        let version = crate::cli::version(prog)?;
        let _ = writeln!(
            exec_defs,
            "static const char *const exec_version = {};",
            match &version {
                Some(v) => c_string_literal(v.as_bytes()),
                None => "0".into(),
            }
        );
        if let Some(name) = program {
            let list: Vec<String> = (0..cmds.len())
                .map(|i| format!("&exec_spec{}", i))
                .collect();
            let _ = writeln!(
                exec_defs,
                "static const fwp_exec_spec *const exec_cmds[] = {{{}}};\nstatic const char exec_program_help[] = {};\nstatic const char exec_program_usage[] = {};",
                list.join(", "),
                c_string_literal(crate::cli::program_help(name, cmds, prog).as_bytes()),
                c_string_literal(crate::cli::program_usage(name).as_bytes()),
            );
        }
    }
    // services: the schema, the client stubs and the served methods
    let mut served = Vec::new();
    if let (Mode::Service, Some(svc)) = (&mode, &prog.service) {
        for m in &svc.methods {
            let method = crate::rpc::Path::parse(&m.path)
                .map(|p| p.method)
                .unwrap_or_default();
            let mut spec = g.rpc_spec(
                &m.name,
                m.path.clone(),
                m.func,
                m.func,
                m.error.as_ref(),
                &method,
                m.iter_fn,
            )?;
            spec.fingerprint = svc.fingerprint(prog, m);
            served.push(spec);
        }
    }
    let uses_services = !g.remotes.is_empty()
        || matches!(mode, Mode::Service)
        || prog
            .funcs
            .iter()
            .any(|f| matches!(&f.body, Body::Prim(p) if p.starts_with("grpc.")));
    let mut remote_defs = String::new();
    if uses_services {
        let grpc_error = g.desc(&crate::rpc::grpc_error_type());
        let (flat, offs) = g.pb.flatten();
        let nums: Vec<String> = flat.iter().map(|x| x.to_string()).collect();
        let _ = writeln!(
            remote_defs,
            "static const int fwp_pb_schema[] = {{{}}};",
            if nums.is_empty() {
                "0".into()
            } else {
                nums.join(", ")
            }
        );
        for r in &g.remotes {
            let (def, init) = r.rpc.c(&format!("rs{}", r.id), &offs);
            let _ = writeln!(
                remote_defs,
                "{def}\nstatic const fwp_remote rs{id} = {{{what}, {env}, {addr}, {init}}};",
                id = r.id,
                what =
                    c_string_literal(format!("{}.{}", r.remote.module, r.remote.method).as_bytes()),
                env = c_string_literal(crate::protobuf::env_var(&r.remote.module).as_bytes()),
                addr = c_string_literal(r.remote.default_addr.as_bytes()),
            );
        }
        if let (Mode::Service, Some(svc)) = (&mode, &prog.service) {
            let mut entries = Vec::new();
            for (i, m) in served.iter().enumerate() {
                let (def, init) = m.c(&format!("sm{}", i), &offs);
                let _ = writeln!(remote_defs, "{}", def);
                entries.push(format!("    {}", init));
            }
            let refl = crate::rpc::reflection(prog)?;
            let names: Vec<String> = refl
                .services
                .iter()
                .map(|s| c_string_literal(s.as_bytes()))
                .collect();
            let _ = write!(
                remote_defs,
                "static const fwp_rpc fwp_svc_methods[] = {{\n{}\n}};\nstatic const unsigned char fwp_svc_descriptor[] = {};\nstatic const unsigned char fwp_svc_health[] = {};\nstatic const char *const fwp_svc_services[] = {{{}}};\nstatic const fwp_service fwp_svc = {{{}, {}, {}, {}, fwp_svc_methods, fwp_svc_descriptor, {}, {}, {}, {}, fwp_svc_services, {}, fwp_svc_health, sizeof fwp_svc_health}};\n",
                entries.join(",\n"),
                bytes_literal(&refl.descriptor),
                bytes_literal(&crate::rpc::health_descriptor()),
                if names.is_empty() { "0".to_string() } else { names.join(", ") },
                c_string_literal(svc.module.as_bytes()),
                c_string_literal(crate::protobuf::env_var(&svc.module).as_bytes()),
                c_string_literal(svc.default_addr.as_bytes()),
                served.len(),
                refl.descriptor.len(),
                c_string_literal(refl.file.as_bytes()),
                c_string_literal(refl.package.as_bytes()),
                refl.services.len(),
                grpc_error,
            );
        }
    }
    let main_desc = g.desc(&main_ty);
    // IoError is always available for uncaught IO failures.
    g.desc(&MT::con("std::IoError"));

    let mut owned_defs = String::new();
    if g.reuse {
        let closure_ids: Vec<usize> = (0..prog.funcs.len())
            .filter(|id| live[*id] && g.used_closures[*id] && prog.funcs[*id].arity > 0)
            .collect();
        for id in closure_ids {
            let f = &prog.funcs[id];
            let mut caps = String::new();
            let mut cleanup = String::new();
            let mut argument_drops = String::new();
            let mut arguments = String::from("    (void)a; (void)start; (void)n;\n");
            let params = f.ty.params(f.arity as usize).0;
            let prepare_scope = g.unwind
                && params
                    .iter()
                    .filter(|ty| crate::rc::needs_rc(&prog.shapes, ty))
                    .count()
                    > 1;
            for (j, ty) in params.iter().enumerate() {
                if !crate::rc::needs_rc(&prog.shapes, ty) {
                    continue;
                }
                let tracked = if prepare_scope {
                    format!(" owner.n = {j} - start + 1;")
                } else {
                    String::new()
                };
                let _ = writeln!(
                    arguments,
                    "    if (start <= {j} && {j} - start < n) {{ fwp_rc_dup(a[{j} - start]);{tracked} }}"
                );
                let drop = if free_enabled() && !matches!(ty, MT::Con(n, _) if n == "?") {
                    format!("fwp_drop{}", g.drop_id(ty))
                } else {
                    "fwp_rc_drop".into()
                };
                if free_enabled() {
                    if g.unwind {
                        let _ = writeln!(caps, "    if (CLO(v)->n > {j}) {drop}(CLO(v)->a[{j}]);");
                    } else {
                        let _ = writeln!(caps, "    if (CLO(v)->n > {j}) {{ if (duplicate) fwp_rc_dup(CLO(v)->a[{j}]); else {drop}(CLO(v)->a[{j}]); }}");
                    }
                } else {
                    let _ = writeln!(
                        caps,
                        "    if (duplicate && CLO(v)->n > {j}) fwp_rc_dup(CLO(v)->a[{j}]);"
                    );
                }
                if !matches!(f.body, Body::Expr(_) | Body::Ctor(_)) {
                    let consumed =
                        matches!(&f.body, Body::Prim(sym) if crate::rc::prim_consumes(sym, j));
                    if !consumed {
                        let _ = writeln!(cleanup, "    FWP_KEEP_ALIVE(a[{j}]); {drop}(a[{j}]);");
                    }
                }
            }
            for (j, ty) in f.ty.params(usize::MAX).0.iter().enumerate() {
                if !crate::rc::needs_rc(&prog.shapes, ty) {
                    continue;
                }
                let drop = if free_enabled() && !matches!(ty, MT::Con(n, _) if n == "?") {
                    format!("fwp_drop{}", g.drop_id(ty))
                } else {
                    "fwp_rc_drop".into()
                };
                let _ = writeln!(
                    argument_drops,
                    "    if (start <= {j} && {j} - start < n) {drop}(a[{j} - start]);"
                );
            }
            let pending_drop = if argument_drops.is_empty() {
                "0".into()
            } else {
                let _ = writeln!(owned_defs, "static void fwp_arg_drop{id}(V *a, uint32_t start, uint32_t n) {{\n{argument_drops}}}");
                format!("fwp_arg_drop{id}")
            };
            if prepare_scope {
                // Each successful duplicate is owned until the whole requested
                // span transfers. A later failure must preserve original aliases.
                arguments.insert_str(0, &format!("    fwp_args_owner owner = {{a, {pending_drop}, start, 0}}; fwp_cleanup preparation;\n    fwp_cleanup_push(&preparation, fwp_args_release, &owner);\n"));
                arguments.push_str("    fwp_cleanup_pop(&preparation);\n");
            }
            if g.unwind {
                caps.insert_str(
                    0,
                    &format!(
                        "    if (duplicate) {{ fwp_args{id}(CLO(v)->a, 0, CLO(v)->n); return; }}\n"
                    ),
                );
            }
            let (entry_pre, entry_post) = if g.unwind && !cleanup.is_empty() {
                let _ = writeln!(
                    owned_defs,
                    "static void fwp_entry_release{id}(void *arg) {{ V *a = arg;\n{cleanup}}}"
                );
                (
                    format!("    fwp_cleanup c; fwp_cleanup_push(&c, fwp_entry_release{id}, a);\n"),
                    "    fwp_cleanup_pop(&c);\n".to_string(),
                )
            } else {
                (String::new(), String::new())
            };
            let release = if free_enabled() {
                "fwp_rc_free_obj(v);"
            } else {
                "fwp_rc_drop(v);"
            };
            caps.insert_str(0, "    (void)v; (void)duplicate;\n");
            let args: Vec<String> = (0..f.arity).map(|j| format!("a[{j}]")).collect();
            let _ = writeln!(owned_defs, "static void fwp_caps{id}(V v, int duplicate) {{\n{caps}    if (!duplicate) {{ {release} }}\n}}\nstatic V fwp_owned_entry{id}(V *a) {{\n{entry_pre}    V result = f{id}({});\n{entry_post}{cleanup}    return result;\n}}\nstatic void fwp_args{id}(V *a, uint32_t start, uint32_t n) {{\n{arguments}}}\nstatic const fwp_owned_fninfo fwp_owned_info{id} = {{fwp_owned_entry{id}, fwp_caps{id}, fwp_args{id}, {pending_drop}}};", args.join(", "));
        }
    }
    // Each counted CAF owns its cached result. Calls return a separate owner;
    // scalar caches never send machine words through generic RC operations.
    // Prepare typed drops before emitting the helper definitions.
    let mut caf_defs = String::new();
    let mut caf_finish = String::new();
    for (id, f) in prog
        .funcs
        .iter()
        .enumerate()
        .filter(|(id, f)| live[*id] && f.arity == 0)
    {
        if g.reuse && crate::rc::needs_rc(&prog.shapes, &f.ty) {
            let drop = g.value_drop(&f.ty);
            // Initialization may yield and reenter. Replacing a result cached
            // during evaluation releases that cache owner, preserving callers.
            let _ = writeln!(caf_defs,
                "static int fwp_caf_state{id}; static V fwp_caf_value{id};\nstatic V caf{id}(void) {{ if (!fwp_caf_state{id}) {{ V next = f{id}(); V previous = fwp_caf_state{id} ? fwp_caf_value{id} : 0; fwp_caf_value{id} = next; fwp_caf_state{id} = 1; {drop}(previous); }} fwp_rc_dup(fwp_caf_value{id}); return fwp_caf_value{id}; }}");
            let _ = writeln!(caf_finish,
                "    if (fwp_caf_state{id}) {{ V v = fwp_caf_value{id}; fwp_caf_value{id} = 0; fwp_caf_state{id} = 0; {drop}(v); }}");
        } else {
            let _ = writeln!(caf_defs,
                "static V caf{id}(void) {{ static int st = 0; static V v; if (st == 0) {{ v = f{id}(); st = 1; }} return v; }}");
        }
    }
    let _ = writeln!(
        caf_defs,
        "static void fwp_caf_finish(void) {{\n{caf_finish}}}"
    );
    let main_drop = if g.reuse && crate::rc::needs_rc(&prog.shapes, &main_ty) {
        format!("{}(r);", g.value_drop(&main_ty))
    } else {
        String::new()
    };
    let mut out = String::new();
    out.push_str("/* Generated by fwp. */\n");
    let _ = writeln!(out, "#define FWP_UNWIND {}", u8::from(g.unwind));
    let web = uses_web(prog);
    let tls = uses_services || web || uses_tls(prog);
    if tls {
        out.push_str(TLS_MARK);
    }
    if uses_async(prog) {
        out.push_str(ASYNC_MARK);
    }
    let stat = static_memory();
    if let Some(m) = stat {
        let _ = write!(
            out,
            "#define FWP_STATIC_MEMORY 1\n#define FWP_STATIC_HEAP ((size_t){}ULL)\n#define FWP_STATIC_POOL ((size_t){}ULL)\n#define FWP_STATIC_STACK ((size_t){}ULL)\n#define FWP_STATIC_TASKS {}\n#define FWP_STATIC_TASK_STACK ((size_t){}ULL)\n#define FWP_STATIC_THREADS {}\n",
            m.heap, m.pool, m.stack, m.tasks, m.task_stack, m.threads
        );
    }
    for (i, part) in RUNTIME.iter().enumerate() {
        out.push_str(part);
        out.push('\n');
        // malloc and the static region, before the collector uses them
        if i == 0 && stat.is_some() {
            out.push_str(STATIC_RUNTIME);
            out.push('\n');
        }
    }
    if tls {
        out.push_str(TLS_RUNTIME);
        out.push('\n');
    }
    if uses_services || web {
        for part in SERVICES_RUNTIME {
            out.push_str(part);
            out.push('\n');
        }
    }
    out.push_str("\n/* ---- program ---- */\n\n");
    // variants returned in registers: tag and fields, and a value read
    // into one (no counts change)
    for m in 1..=MAX_UNBOXED {
        let _ = writeln!(
            out,
            "typedef struct {{ V tag; V f[{m}]; }} fwp_u{m};",
            m = m
        );
        let _ = writeln!(
            out,
            "static inline fwp_u{m} fwp_vunbox{m}(V v) {{ fwp_u{m} u = {{0}}; if (v < 4096) {{ u.tag = v; return u; }} \
             u.tag = OBJ(v)->tag; for (uint32_t k = 0; k < OBJ(v)->n && k < {m}; k++) u.f[k] = OBJ(v)->f[k]; return u; }}",
            m = m
        );
    }
    // tentative declarations, so descriptors can refer to each other
    for i in 0..g.desc_defs.len() {
        let _ = writeln!(out, "static fwp_desc d{};", i);
    }
    for d in &g.desc_defs {
        out.push_str(d);
        out.push('\n');
    }
    for i in 0..g.drop_defs.len() {
        let _ = writeln!(out, "static void fwp_drop{}(V v);", i);
    }
    for d in &g.drop_defs {
        out.push_str(d);
        out.push('\n');
    }
    for i in 0..g.tree_owner_defs.len() {
        let _ = writeln!(out, "static void fwp_own_tree{i}(V v);");
    }
    for d in &g.tree_owner_defs {
        out.push_str(d);
        out.push('\n');
    }
    // Boxing helpers use typed cleanup contexts; other cleanup contexts may
    // release unboxed variants. Declare those releases before either body.
    for d in &g.vhelper_decls {
        out.push_str(d);
        out.push('\n');
    }
    for d in &g.cleanup_defs {
        out.push_str(d);
        out.push('\n');
    }
    for d in &g.vhelper_defs {
        out.push_str(d);
        out.push('\n');
    }
    for s in &g.string_defs {
        out.push_str(s);
        out.push('\n');
    }
    for c in &g.consts {
        out.push_str(c);
        out.push('\n');
    }
    // records returned in registers, and the workers that return them
    for n in 1..=MAX_UNBOXED {
        let _ = writeln!(out, "typedef struct {{ V f[{}]; }} fwp_r{};", n, n);
    }
    for (id, abi) in g.abis.iter().enumerate() {
        if let Some(abi) = abi.as_ref().filter(|_| live[id]) {
            let _ = writeln!(out, "{};", abi.sig(id));
        }
    }
    // prototypes
    for (id, f) in prog.funcs.iter().enumerate().filter(|(id, _)| live[*id]) {
        let params: Vec<String> = (0..f.arity).map(|i| format!("V l{}", i)).collect();
        let _ = writeln!(
            out,
            "static V f{}({});",
            id,
            if params.is_empty() {
                "void".into()
            } else {
                params.join(", ")
            }
        );
    }
    for (step, _) in &g.loops {
        let _ = writeln!(out, "static V fwp_loop{}(V s);", step);
    }
    if g.reuse {
        for (id, _) in prog
            .funcs
            .iter()
            .enumerate()
            .filter(|(id, f)| live[*id] && g.used_closures[*id] && f.arity > 0)
        {
            let _ = writeln!(out, "static V fwp_owned_entry{id}(V *a);\nstatic void fwp_args{id}(V *a, uint32_t start, uint32_t n);");
        }
        for &id in &g.owned_callbacks {
            let arity = prog.funcs[id].arity;
            let params = (0..arity)
                .map(|j| format!("V x{j}"))
                .collect::<Vec<_>>()
                .join(", ");
            let values = (0..arity)
                .map(|j| format!("x{j}"))
                .collect::<Vec<_>>()
                .join(", ");
            let _ = writeln!(out, "static V fwp_owned_k{id}({params}) {{ V a[] = {{{values}}}; fwp_args{id}(a, 0, {arity}); return fwp_owned_entry{id}(a); }}");
        }
    }
    for id in g.owned_fold_callbacks.clone() {
        let ty = prog.funcs[id].ty.params(2).0[0].clone();
        let drop = g.value_drop(&ty);
        let _ = writeln!(out, "static V fwp_owned_fold_k{id}(V z, V x) {{ V a[] = {{z, x}}; fwp_value_owner owner = {{z, {drop}}}; fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup); fwp_args{id}(a + 1, 1, 1); fwp_value_finish(&owner, &cleanup); return fwp_owned_entry{id}(a); }}");
    }
    for id in g.owned_right_fold_callbacks.clone() {
        let ty = prog.funcs[id].ty.params(2).0[1].clone();
        let drop = g.value_drop(&ty);
        let _ = writeln!(out, "static V fwp_owned_right_fold_k{id}(V x, V z) {{ V a[] = {{x, z}}; fwp_value_owner owner = {{z, {drop}}}; fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup); fwp_args{id}(a, 0, 1); fwp_value_finish(&owner, &cleanup); return fwp_owned_entry{id}(a); }}");
    }
    // the functions the runtime calls back: their results are shared
    for &cb in &g.callbacks {
        let f = &prog.funcs[cb];
        let params: Vec<String> = (0..f.arity).map(|i| format!("V l{}", i)).collect();
        let args: Vec<String> = (0..f.arity).map(|i| format!("l{}", i)).collect();
        let _ = writeln!(
            out,
            "static V k{}({}) {{ return fwp_rc_shared(f{}({})); }}",
            cb,
            params.join(", "),
            cb,
            args.join(", ")
        );
    }
    for (i, (sym, _, k)) in g.hofs.iter().enumerate() {
        let _ = writeln!(out, "{};", hof_sig(i, sym, *k));
    }
    // Constant applicative forms retain their typed cached owners.
    out.push_str(&caf_defs);
    // entries and the function table (whose entries for functions nothing
    // reaches stay, without code, so function ids keep their positions)
    for (id, f) in prog.funcs.iter().enumerate().filter(|(id, _)| live[*id]) {
        if f.arity > 0 {
            let args: Vec<String> = (0..f.arity).map(|i| format!("a[{}]", i)).collect();
            let mut share_args = String::new();
            if g.reuse {
                for (j, ty) in f.ty.params(f.arity as usize).0.iter().enumerate() {
                    if crate::rc::needs_rc(&prog.shapes, ty) {
                        let _ = write!(share_args, "fwp_rc_share(a[{j}]); ");
                    }
                }
            }
            let _ = writeln!(
                out,
                "static V e{}(V *a) {{ {}return {}; }}",
                id,
                share_args,
                shared(g.reuse, format!("f{}({})", id, args.join(", ")))
            );
        }
    }
    out.push_str(&owned_defs);
    out.push_str("static const fwp_fninfo fwp_fn_table[] = {\n");
    for (id, f) in prog.funcs.iter().enumerate() {
        let entry = if f.arity > 0 && live[id] {
            format!("e{}", id)
        } else {
            "0".into()
        };
        let _ = writeln!(
            out,
            "    {{{}, {}, {}, {}}},",
            f.arity,
            entry,
            c_string_literal(f.name.as_bytes()),
            if g.reuse && live[id] && g.used_closures[id] && f.arity > 0 {
                format!("&fwp_owned_info{id}")
            } else {
                "0".into()
            }
        );
    }
    out.push_str("};\n");
    for (id, used) in g.used_closures.iter().enumerate() {
        if *used {
            let _ = writeln!(out, "static fwp_clo fc{} = {{{}, 0}};", id, id);
        }
    }
    out.push('\n');
    if !g.ffi_decls.is_empty() {
        out.push_str(crate::ffi::PREAMBLE);
        out.push_str(&g.ffi_decls);
    }
    out.push_str(&remote_defs);
    out.push_str(&g.cli_defs);
    out.push_str(&bodies);
    if let Mode::Library = mode {
        let _ = write!(
            out,
            "static void fwp_init_consts(void) {{\n{}}}\n\n{}",
            g.const_init, lib_defs
        );
        return Ok(out);
    }
    let exit_code = matches!(&main_ty, MT::Con(n, _) if n == "std::I32");
    out.push_str(&exec_defs);
    let run = if let Mode::Service = mode {
        "    fwp_exit_code = fwp_serve(&fwp_svc, fwp_argc, fwp_argv);".to_string()
    } else if let Mode::Exec(cmds, program) = &mode {
        match program {
            None => format!("{}    fwp_cli_single = 1;\n    fwp_exit_code = fwp_exec(&exec_spec0, fwp_argc, fwp_argv);", CLI_INIT),
            Some(name) => format!(
                "{}    fwp_exit_code = fwp_exec_program({}, exec_cmds, {}, exec_program_help, exec_program_usage, fwp_argc, fwp_argv);",
                CLI_INIT,
                c_string_literal(name.as_bytes()),
                cmds.len()
            ),
        }
    } else if tests {
        let mut r = String::from("    int pass = 0, fail = 0;\n");
        for (name, id) in &prog.tests {
            let _ = write!(
                r,
                r#"    {{
        fwp_handler h; h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups; fwp_handlers = &h;
        fwp_budget = 0;
        if (setjmp(h.jb) == 0) {{
            V v = caf{id}();
            fwp_handlers = h.prev;
            fwp_tasks_finish();
            if (v == FWP_TRUE) {{ pass++; printf("test %s ... ok\n", {name}); }}
            else {{ fail++; printf("test %s ... FAILED\n", {name}); }}
        }} else {{
            fwp_handlers = h.prev; fwp_state_len = h.state_depth; fail++;
            fwp_tasks_abort();
            fwp_buf b = {{0}}; fwp_write(&b, h.value, h.desc, 1);
            printf("test %s ... FAILED (error: %s)\n", {name}, b.d ? b.d : "");
        }}
    }}
"#,
                id = id,
                name = c_string_literal(name.as_bytes())
            );
        }
        r.push_str("    printf(\"\\n%d passed, %d failed\\n\", pass, fail);\n    fwp_exit_code = fail ? 1 : 0;");
        r
    } else {
        format!(
            "    V r = caf{}();\n    fwp_tasks_finish();\n    {main_drop}\n    (void){};\n    fwp_exit_code = {};",
            main,
            main_desc,
            if exit_code {
                "(int)(int32_t)r"
            } else {
                "((void)r, 0)"
            }
        )
    };
    let _ = write!(
        out,
        r#"
static void fwp_init_consts(void) {{
{init}}}

static int fwp_exit_code = 0;

static size_t fwp_main_stack = (size_t)1 << 30;

static void *fwp_main_thread(void *arg) {{
    (void)arg;
    fwp_gc_start(__builtin_frame_address(0));
    fwp_stack_guard_init(fwp_main_stack);
    fwp_init_consts();
{run}
    fwp_caf_finish();
    fflush(stdout);
    return 0;
}}

int main(int argc, char **argv) {{
    fwp_fns = fwp_fn_table;
    fwp_prog_out = stdout;
    fwp_argc = argc;
    fwp_argv = argv;
    clock_gettime(CLOCK_MONOTONIC, &fwp_start_time);
    fwp_seed_rng();
    setvbuf(stdout, 0, _IOFBF, 1 << 16);
#ifdef __wasi__
    fwp_main_thread(0);
#else
    signal(SIGPIPE, SIG_IGN);
    pthread_attr_t attr;
    pthread_attr_init(&attr);
#ifdef FWP_STATIC_MEMORY
    fwp_static_init();
    fwp_main_stack = FWP_STATIC_STACK;
    pthread_attr_setstack(&attr, fwp_static.main_stack, fwp_main_stack);
#else
    pthread_attr_setstacksize(&attr, fwp_main_stack);
#endif
    pthread_t t;
    if (pthread_create(&t, &attr, fwp_main_thread, 0) != 0) {{
        /* on the process stack instead */
        struct rlimit rl;
        fwp_main_stack = getrlimit(RLIMIT_STACK, &rl) == 0 && rl.rlim_cur != RLIM_INFINITY
                             ? (size_t)rl.rlim_cur
                             : (size_t)8 << 20;
        fwp_main_thread(0);
    }}
    else pthread_join(t, 0);
#endif
    fflush(stdout);
    return fwp_exit_code;
}}
"#,
        init = g.const_init,
        run = run
    );
    Ok(out)
}

/// What `fwp build` produces.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Target {
    /// An executable for the host.
    Native,
    /// A WebAssembly module for WASI runtimes (wasmtime, node:wasi).
    Wasi,
    /// A WebAssembly module plus a JavaScript loader for browsers.
    Browser,
}

impl Target {
    pub fn parse(s: &str) -> Option<Target> {
        match s {
            "native" => Some(Target::Native),
            "wasm32-wasi" | "wasi" => Some(Target::Wasi),
            "wasm32-browser" | "browser" => Some(Target::Browser),
            _ => None,
        }
    }

    pub fn is_wasm(self) -> bool {
        self != Target::Native
    }
}

/// Whether `prog` uses tasks or channels.
pub fn uses_async(prog: &Program) -> bool {
    async_prim(prog).is_some()
}

/// The first task or channel primitive of `prog`.
pub fn async_prim(prog: &Program) -> Option<&str> {
    prog.funcs.iter().find_map(|f| match &f.body {
        Body::Prim(p) if p.starts_with("task.") || p.starts_with("channel.") => Some(p.as_str()),
        _ => None,
    })
}

/// The first primitive of `prog` that performs an effect WebAssembly does
/// not provide (sockets and DNS: `Network`; other programs: `Process`),
/// with that effect. Tasks and channels (`Async`) run as fibers, which
/// the JavaScript host switches (web/fibers.js).
pub fn wasm_missing_effect(prog: &Program) -> Option<(&'static str, &str)> {
    prog.funcs.iter().find_map(|f| {
        let Body::Prim(sym) = &f.body else {
            return None;
        };
        if ["tcp.", "udp.", "dns.", "tls.", "grpc.", "http2."]
            .iter()
            .any(|p| sym.starts_with(p))
        {
            Some(("Network", sym.as_str()))
        } else if sym.starts_with("process.") {
            Some(("Process", sym.as_str()))
        } else {
            None
        }
    })
}

/// Whether `prog` uses TLS directly (services may use it too).
pub fn uses_tls(prog: &Program) -> bool {
    prog.funcs
        .iter()
        .any(|f| matches!(&f.body, Body::Prim(p) if p.starts_with("tls.")))
}

/// Whether `prog` uses HTTP/2, HTTP compression or WebSocket frames
/// (runtime/fwp_rt_http2.c, which needs the services runtime).
pub fn uses_web(prog: &Program) -> bool {
    prog.funcs.iter().any(|f| {
        matches!(&f.body, Body::Prim(p)
            if p.starts_with("http2.") || p.starts_with("zlib.") || p.starts_with("ws."))
    })
}

/// Whether `prog` calls services (gRPC), or is one.
pub fn uses_services(prog: &Program) -> bool {
    prog.service.is_some()
        || prog.funcs.iter().any(|f| match &f.body {
            Body::Remote(_) => true,
            Body::Prim(p) => p.starts_with("grpc."),
            _ => false,
        })
}

/// Effects a target does not provide, by the primitives that perform them.
pub fn check_target(prog: &Program, target: Target) -> Result<(), String> {
    if !target.is_wasm() {
        return Ok(());
    }
    if uses_services(prog) {
        return Err("services (gRPC calls) need the native target".into());
    }
    if let Some((effect, sym)) = wasm_missing_effect(prog) {
        return Err(format!(
            "the WebAssembly target does not provide the `{}` effect (used by `{}`)",
            effect, sym
        ));
    }
    if uses_web(prog) {
        return Err(
            "HTTP compression and WebSocket frames (`gzip.*`, `deflate.*`, `ws.*`) need the native target"
                .into(),
        );
    }
    Ok(())
}

/// A private temporary directory (mode 0700, with an unpredictable name,
/// created fresh so that nobody else can have placed files in it),
/// removed with its contents when dropped.
pub struct TempDir {
    path: std::path::PathBuf,
}

impl TempDir {
    pub fn new(prefix: &str) -> Result<TempDir, String> {
        #[cfg(unix)]
        use std::os::unix::fs::DirBuilderExt;
        let base = std::env::temp_dir();
        let mut last = String::new();
        for attempt in 0..16u32 {
            let path = base.join(format!("{}-{}", prefix, random_suffix(attempt)));
            #[cfg_attr(not(unix), allow(unused_mut))]
            let mut builder = std::fs::DirBuilder::new();
            #[cfg(unix)]
            builder.mode(0o700);
            match builder.create(&path) {
                Ok(()) => return Ok(TempDir { path }),
                Err(e) if e.kind() == std::io::ErrorKind::AlreadyExists => {
                    last = e.to_string();
                }
                Err(e) => {
                    return Err(format!(
                        "cannot create a temporary directory in {}: {}",
                        base.display(),
                        e
                    ))
                }
            }
        }
        Err(format!(
            "cannot create a temporary directory in {}: {}",
            base.display(),
            last
        ))
    }

    pub fn path(&self) -> &std::path::Path {
        &self.path
    }

    pub fn join(&self, name: impl AsRef<std::path::Path>) -> std::path::PathBuf {
        self.path.join(name)
    }
}

impl Drop for TempDir {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.path);
    }
}

/// 128 random bits as hex, from /dev/urandom (falling back to the clock,
/// the process id and the attempt number, which are at least unique).
fn random_suffix(attempt: u32) -> String {
    use std::io::Read;
    let mut b = [0u8; 16];
    let random = std::fs::File::open("/dev/urandom")
        .and_then(|mut f| f.read_exact(&mut b))
        .is_ok();
    if !random {
        let t = std::time::SystemTime::now()
            .duration_since(std::time::UNIX_EPOCH)
            .map(|d| d.as_nanos())
            .unwrap_or(0);
        let x = t ^ ((std::process::id() as u128) << 64) ^ ((attempt as u128) << 96);
        b = x.to_le_bytes();
    }
    b.iter().map(|c| format!("{:02x}", c)).collect()
}

/// Compile C source to an executable with the system C compiler.
pub fn compile_c(c_source: &str, output: &std::path::Path, opt: &str) -> Result<(), String> {
    compile_for(c_source, output, opt, Target::Native)
}

fn run_cc(cmd: &mut std::process::Command, cc: &str) -> Result<(), String> {
    let res = cmd
        .output()
        .map_err(|e| format!("cannot run C compiler `{}`: {}", cc, e))?;
    if !res.status.success() {
        let err = String::from_utf8_lossy(&res.stderr);
        // a program that uses TLS needs OpenSSL's headers and libraries
        let tls = err.contains("openssl/") || err.contains("-lssl");
        let hint = match native_options().cross {
            Some(t) if tls => {
                let deb = match t.split('-').next().unwrap_or_default() {
                    "aarch64" => "arm64",
                    "x86_64" => "amd64",
                    "powerpc64le" => "ppc64el",
                    "loongarch64" => "loong64",
                    a => a,
                }
                .to_string();
                format!("\nthe program uses TLS, which needs OpenSSL 3's headers and libraries for {} (Debian and Ubuntu: libssl-dev:{}; see docs/tls.md)", t, deb)
            }
            _ if tls && native_is_macos() => "\nthe program uses TLS, which needs OpenSSL 3's headers and libraries (macOS: brew install openssl@3; set FWP_OPENSSL_DIR to brew --prefix openssl@3; see docs/tls.md)".to_string(),
            _ if tls => "\nthe program uses TLS, which needs OpenSSL 3's headers and libraries (Debian and Ubuntu: libssl-dev; see docs/tls.md)".to_string(),
            _ => String::new(),
        };
        return Err(format!("C compiler failed:\n{}{}", err, hint));
    }
    Ok(())
}

/// Whether the C compiler is GCC (`cc --version`), asked once per compiler.
pub fn is_gcc(cc: &str) -> bool {
    static SEEN: std::sync::Mutex<Vec<(String, bool)>> = std::sync::Mutex::new(Vec::new());
    let mut seen = SEEN.lock().unwrap();
    if let Some((_, g)) = seen.iter().find(|(c, _)| c == cc) {
        return *g;
    }
    let g = std::process::Command::new(cc)
        .arg("--version")
        .output()
        .is_ok_and(|o| {
            let v = String::from_utf8_lossy(&o.stdout);
            v.contains("Free Software Foundation") || v.contains("gcc")
        });
    seen.push((cc.to_string(), g));
    g
}

/// GCC options that generate the code of a large program in parallel:
/// link-time optimization splits it into partitions, compiled on all the
/// cores (a REST server's 75 000 lines of C take half the time on four).
/// Small programs, `-O0`, other compilers and `FWP_LTO=0` compile as one
/// unit; `FWP_LTO=1` asks for it whatever the size.
fn parallel_codegen(cc: &str, opt: &str, c_source: &str) -> &'static [&'static str] {
    let large = match std::env::var("FWP_LTO").as_deref() {
        Ok("0") => return &[],
        Ok("1") => true,
        _ => c_source.len() > 1_000_000,
    };
    if large && opt != "-O0" && is_gcc(cc) {
        &["-flto=auto", "-flto-partition=balanced"]
    } else {
        &[]
    }
}

/// CPU variants of a fat binary for the host architecture: name, compiler
/// flags, and the C condition (in terms of `__builtin_cpu_supports`) under
/// which the variant may run. The first is the baseline.
fn fat_variants() -> Vec<(&'static str, &'static str, &'static str)> {
    match target_arch().as_str() {
        "x86_64" => vec![
            ("x86-64", "-march=x86-64", "1"),
            // the whole feature level (the compiler may use any of its
            // instructions: LZCNT, MOVBE, F16C, ...), see FWP_CPU_LEVEL
            (
                "x86-64-v2",
                "-march=x86-64-v2",
                "FWP_CPU_LEVEL(\"x86-64-v2\")",
            ),
            (
                "x86-64-v3",
                "-march=x86-64-v3",
                "FWP_CPU_LEVEL(\"x86-64-v3\")",
            ),
        ],
        _ => vec![("baseline", "", "1")],
    }
}

/// `FWP_CPU_LEVEL(level)`: the CPU supports a whole x86-64 feature level.
/// Compilers that know the levels (GCC 12, Clang 16 and later) check every
/// feature of the level, the OS support for AVX state included; older ones
/// check the features they can name.
const FAT_CPU_LEVEL: &str = r#"#if defined(__x86_64__) || defined(__i386__)
#if (defined(__clang__) && __clang_major__ >= 16) || (!defined(__clang__) && defined(__GNUC__) && __GNUC__ >= 12)
#define FWP_CPU_LEVEL(l) __builtin_cpu_supports(l)
#else
#define FWP_CPU_V2 (__builtin_cpu_supports("sse3") && __builtin_cpu_supports("ssse3") && \
                    __builtin_cpu_supports("sse4.1") && __builtin_cpu_supports("sse4.2") && \
                    __builtin_cpu_supports("popcnt"))
#define FWP_CPU_V3 (FWP_CPU_V2 && __builtin_cpu_supports("avx") && __builtin_cpu_supports("avx2") && \
                    __builtin_cpu_supports("bmi") && __builtin_cpu_supports("bmi2") && \
                    __builtin_cpu_supports("fma"))
#define FWP_CPU_LEVEL(l) (!strcmp(l, "x86-64-v3") ? FWP_CPU_V3 : FWP_CPU_V2)
#endif
#endif

"#;

/// Compile a fat executable: the program once per CPU variant, and a
/// dispatcher that runs the best variant the CPU supports. FWP_VARIANT
/// selects a variant by name; FWP_VARIANT_SHOW=1 reports the choice.
pub fn compile_fat(c_source: &str, output: &std::path::Path, opt: &str) -> Result<(), String> {
    let dir = TempDir::new("fwp-build")?;
    let c_path = dir.join("fat-program.c");
    std::fs::write(&c_path, c_source).map_err(|e| e.to_string())?;
    let cc = c_compiler()?;
    let variants = fat_variants();
    let mut objs = Vec::new();
    let mut result = Ok(());
    for (i, (_, flags, _)) in variants.iter().enumerate() {
        let obj = dir.join(format!("fat-{}.o", i));
        let mut cmd = cc_command(&cc);
        cmd.args([opt, "-std=gnu11", "-ffp-contract=off", "-w", "-c"])
            .arg(format!("-Dmain=fwp_variant_{}", i))
            // Each variant embeds its own runtime, including the assembly
            // entry on Darwin and musl; those symbols must not collide.
            .arg(format!("-Dfwp_ctx_swap=fwp_ctx_swap_{}", i));
        if !flags.is_empty() {
            cmd.arg(flags);
        }
        cmd.arg("-o").arg(&obj).arg(&c_path);
        result = run_cc(&mut cmd, &cc.0);
        objs.push(obj);
        if result.is_err() {
            break;
        }
    }
    if result.is_ok() {
        let mut d =
            String::from("#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n\n");
        d.push_str(FAT_CPU_LEVEL);
        for i in 0..variants.len() {
            let _ = writeln!(d, "int fwp_variant_{}(int, char **);", i);
        }
        d.push_str("\nint main(int argc, char **argv) {\n    static const char *names[] = {");
        for (n, _, _) in &variants {
            let _ = write!(d, "\"{}\", ", n);
        }
        d.push_str("};\n    int pick = 0;\n#if defined(__x86_64__) || defined(__i386__)\n    __builtin_cpu_init();\n#endif\n");
        for (i, (_, _, cond)) in variants.iter().enumerate().skip(1) {
            let _ = writeln!(d, "    if ({}) pick = {};", cond, i);
        }
        let _ = write!(
            d,
            "    const char *force = getenv(\"FWP_VARIANT\");\n    if (force)\n        for (int i = 0; i < {n}; i++)\n            if (!strcmp(force, names[i])) pick = i;\n    if (getenv(\"FWP_VARIANT_SHOW\")) fprintf(stderr, \"fwp: variant %s\\n\", names[pick]);\n    switch (pick) {{\n",
            n = variants.len()
        );
        for i in 0..variants.len() {
            let _ = writeln!(d, "    case {}: return fwp_variant_{}(argc, argv);", i, i);
        }
        d.push_str("    }\n    return 0;\n}\n");
        let dpath = dir.join("fat-dispatch.c");
        std::fs::write(&dpath, d).map_err(|e| e.to_string())?;
        result = run_cc(
            cc_command(&cc)
                .arg(opt)
                .arg("-o")
                .arg(output)
                .arg(&dpath)
                .args(&objs)
                .args(crate::ffi::links())
                .args(tls_links(c_source))
                .args(["-lm", "-lpthread"]),
            &cc.0,
        );
        let _ = std::fs::remove_file(&dpath);
    }
    for o in &objs {
        let _ = std::fs::remove_file(o);
    }
    let _ = std::fs::remove_file(&c_path);
    result
}

/// A static (`.a`) or shared (`.so`) library.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum LibKind {
    Static,
    Shared,
}

/// Compile a library and write its header next to it (`libx.a` and
/// `libx.h`).
pub fn compile_library(
    c_source: &str,
    header: &str,
    output: &std::path::Path,
    opt: &str,
    kind: LibKind,
) -> Result<(), String> {
    let dir = TempDir::new("fwp-build")?;
    let c_path = dir.join("library.c");
    let obj = dir.join("library.o");
    std::fs::write(&c_path, c_source).map_err(|e| e.to_string())?;
    std::fs::write(output.with_extension("h"), header).map_err(|e| e.to_string())?;
    let cc = c_compiler()?;
    let mut result = run_cc(
        cc_command(&cc)
            .args([
                opt,
                "-std=gnu11",
                "-ffp-contract=off",
                "-w",
                "-fPIC",
                "-c",
                "-o",
            ])
            .arg(&obj)
            .arg(&c_path),
        &cc.0,
    );
    if result.is_ok() {
        result = match kind {
            LibKind::Static => {
                let _ = std::fs::remove_file(output);
                let ar = archiver();
                run_cc(
                    std::process::Command::new(&ar)
                        .arg("rcs")
                        .arg(output)
                        .arg(&obj),
                    &ar,
                )
            }
            LibKind::Shared => run_cc(
                cc_command(&cc)
                    .arg(shared_library_flag())
                    .arg("-o")
                    .arg(output)
                    .arg(&obj)
                    .args(crate::ffi::links())
                    .args(tls_links(c_source))
                    .args(["-lm", "-lpthread"]),
                &cc.0,
            ),
        };
    }
    let _ = std::fs::remove_file(&obj);
    let _ = std::fs::remove_file(&c_path);
    result
}

/// The JavaScript loader for the browser target: a minimal WASI layer
/// (stdout/stderr to the console or a callback, clocks, random numbers).
/// It includes web/fibers.js, which runs tasks with JavaScript Promise
/// Integration.
pub const BROWSER_LOADER: &str = concat!(
    include_str!("../runtime/wasm/loader.js"),
    "\n",
    include_str!("../web/fibers.js")
);

/// Compile C source for a target.
pub fn compile_for(
    c_source: &str,
    output: &std::path::Path,
    opt: &str,
    target: Target,
) -> Result<(), String> {
    let dir = TempDir::new("fwp-build")?;
    let stem = output
        .file_name()
        .map(|s| s.to_string_lossy().to_string())
        .unwrap_or("out".into());
    let c_path = dir.join(format!("{}.c", stem));
    std::fs::write(&c_path, c_source).map_err(|e| e.to_string())?;
    let result = if target.is_wasm() {
        let cc = std::env::var("FWP_WASM_CC").unwrap_or_else(|_| "clang".into());
        let obj = dir.join(format!("{}.o", stem));
        let lj_src = dir.join("fwp-longjmp.S");
        let lj_obj = dir.join("fwp-longjmp.o");
        let sj_src = dir.join("fwp-sjlj.c");
        let sj_obj = dir.join("fwp-sjlj.o");
        std::fs::write(&lj_src, include_str!("../runtime/wasm/longjmp.S"))
            .map_err(|e| e.to_string())?;
        std::fs::write(&sj_src, include_str!("../runtime/wasm/sjlj.c"))
            .map_err(|e| e.to_string())?;
        let target_flag = "--target=wasm32-wasi";
        let result = run_cc(
            std::process::Command::new(&cc)
                .args([target_flag, opt, "-std=gnu11", "-ffp-contract=off", "-w"])
                .args(["-mllvm", "-wasm-enable-sjlj", "-c", "-o"])
                .arg(&obj)
                .arg(&c_path),
            &cc,
        )
        .and_then(|_| {
            run_cc(
                std::process::Command::new(&cc)
                    .args([target_flag, "-mexception-handling", "-c", "-o"])
                    .arg(&lj_obj)
                    .arg(&lj_src),
                &cc,
            )
        })
        .and_then(|_| {
            run_cc(
                std::process::Command::new(&cc)
                    .args([target_flag, "-O2", "-c", "-o"])
                    .arg(&sj_obj)
                    .arg(&sj_src),
                &cc,
            )
        })
        .and_then(|_| {
            run_cc(
                std::process::Command::new(&cc)
                    .arg(target_flag)
                    .arg("-o")
                    .arg(output)
                    .arg(&obj)
                    .arg(&lj_obj)
                    .arg(&sj_obj)
                    .args(crate::ffi::links())
                    .args(wasm_links(c_source))
                    .args(["-lm", "-Wl,-z,stack-size=33554432"]),
                &cc,
            )
        })
        .and_then(|_| {
            if target == Target::Browser {
                let js = output.with_extension("js");
                let wasm_name = output
                    .file_name()
                    .map(|s| s.to_string_lossy().to_string())
                    .unwrap_or_default();
                std::fs::write(&js, BROWSER_LOADER.replace("__FWP_WASM__", &wasm_name))
                    .map_err(|e| e.to_string())?;
            }
            Ok(())
        });
        let _ = std::fs::remove_file(&obj);
        let _ = std::fs::remove_file(&lj_src);
        let _ = std::fs::remove_file(&lj_obj);
        let _ = std::fs::remove_file(&sj_src);
        let _ = std::fs::remove_file(&sj_obj);
        result
    } else {
        let cc = c_compiler()?;
        let native = native_options();
        let link_static: &[&str] = if native.static_link {
            &["-static"]
        } else {
            &[]
        };
        match &native.pgo {
            // A profile-guided build compiles and links separately, with the
            // source and object at fixed paths in the profile directory: GCC
            // names a profile after its object, so both compiles must agree.
            Some((phase, pdir)) => {
                let src = pdir.join("prog.c");
                let obj = pdir.join("prog.o");
                std::fs::write(&src, c_source).map_err(|e| e.to_string())?;
                let flag = match phase {
                    Pgo::Generate => format!("-fprofile-generate={}", pdir.display()),
                    Pgo::Use => format!("-fprofile-use={}", pdir.display()),
                };
                run_cc(
                    cc_command(&cc)
                        .args([opt, "-std=gnu11", "-ffp-contract=off", "-w"])
                        .args([flag.as_str(), "-Wno-missing-profile", "-c", "-o"])
                        .arg(&obj)
                        .arg(&src),
                    &cc.0,
                )
                .and_then(|_| {
                    run_cc(
                        cc_command(&cc)
                            .arg(&flag)
                            .args(link_static)
                            .arg("-o")
                            .arg(output)
                            .arg(&obj)
                            .args(crate::ffi::links())
                            .args(tls_links(c_source))
                            .args(["-lm", "-lpthread"]),
                        &cc.0,
                    )
                })
            }
            None => run_cc(
                cc_command(&cc)
                    .arg(opt)
                    .args(parallel_codegen(&cc.0, opt, c_source))
                    .arg("-std=gnu11")
                    // no fused multiply-add: results must match the interpreter exactly
                    .arg("-ffp-contract=off")
                    .arg("-w")
                    .args(link_static)
                    .arg("-o")
                    .arg(output)
                    .arg(&c_path)
                    .args(crate::ffi::links())
                    .args(tls_links(c_source))
                    .arg("-lm")
                    .arg("-lpthread"),
                &cc.0,
            ),
        }
    };
    let _ = std::fs::remove_file(&c_path);
    result
}
