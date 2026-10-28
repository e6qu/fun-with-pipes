//! C code generation from the monomorphic IR. The output is a single C
//! translation unit containing the runtime and the program; it is compiled
//! with the system C compiler into a self-contained native executable.

use std::collections::{HashMap, HashSet};
use std::fmt::Write;
use std::io::Read;
#[cfg(unix)]
use std::os::unix::fs::DirBuilderExt;
#[cfg(unix)]
use std::os::unix::process::ExitStatusExt;

use crate::ffi::{self, CType};
use crate::ir::*;
use crate::ownership::ResultOwnership;
use crate::value::Value;

mod regions;
mod scalar_text;
mod sort_keys;
mod string_map;
#[path = "cgen_wide.rs"]
mod wide;

const RUNTIME: &[&str] = &[
    include_str!("../runtime/fwp_rt.c"),
    include_str!("../runtime/fwp_rt_windows.c"),
    include_str!("../runtime/fwp_rt_heap.c"),
    include_str!("../runtime/fwp_rt_ops.c"),
    include_str!("../runtime/fwp_rt_num.c"),
    include_str!("../runtime/fwp_rt_prims.c"),
    include_str!("../runtime/fwp_rt_socket.c"),
    include_str!("../runtime/fwp_rt_context_win.c"),
    include_str!("../runtime/fwp_rt_task.c"),
    include_str!("../runtime/fwp_rt_callback.c"),
    include_str!("../runtime/fwp_rt_sys.c"),
    include_str!("../runtime/fwp_rt_sys_windows.c"),
    include_str!("../runtime/fwp_rt_decode.c"),
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
/// (or, with `None`, a growing counted heap).
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

fn native_runtime_links() -> &'static [&'static str] {
    if cfg!(windows) && native_options().cross.is_none() {
        &["-lm", "-lws2_32", "-lshell32"]
    } else {
        &["-lm", "-lpthread"]
    }
}

pub fn shared_library_extension() -> &'static str {
    if native_is_macos() {
        "dylib"
    } else if native_options().cross.is_none() && cfg!(windows) {
        "dll"
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
            if !cfg!(windows) {
                c.arg(format!("-Wl,-rpath,{}", prefix.join("lib").display()));
            }
        }
    }
    c
}

/// The archiver for static libraries: `AR`, or for a cross target
/// `<triple>-ar` (else `llvm-ar`), or `ar`.
pub(crate) fn archiver() -> String {
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

pub(crate) fn native_options() -> NativeOptions {
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
fn tls_links(c_source: &str) -> Vec<std::ffi::OsString> {
    if !c_source.contains(TLS_MARK) {
        return Vec::new();
    }
    if cfg!(windows) && native_options().cross.is_none() {
        if let Some(prefix) = std::env::var_os("FWP_OPENSSL_DIR") {
            // Windows OpenSSL's documented import libraries use COFF, which
            // LLVM-MinGW can link directly; PE has no ELF/Mach-O rpath.
            let lib = std::path::PathBuf::from(prefix).join("lib");
            return ["libssl.lib", "libcrypto.lib"]
                .map(|name| lib.join(name).into_os_string())
                .into();
        }
    }
    vec!["-lssl".into(), "-lcrypto".into()]
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
    result_drop: String,
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
            "{{{}, {}, {}, {}, {}, {}_p, {}, {}, {}, {}, {}, {}, fwp_pb_schema, {}, {}, {}, {}}}",
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
            self.result_drop,
        );
        (def, init)
    }
}

/// A client stub: its function and its RPC.
struct RemoteSpec {
    id: FuncId,
    remote: RemoteFn,
    rpc: RpcSpec,
    input_drop: String,
}

struct Gen<'p> {
    resource_captures: bool,
    weak_channels: bool,
    prog: &'p Program,
    uncounted: &'p Program,
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
    borrowed_globals: std::collections::HashSet<FuncId>,
    /// Function values whose captures are all fixed, capture-free functions.
    static_functions: HashMap<(FuncId, Vec<FuncId>), usize>,
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
    /// Known scalar/string key workers whose results stay in a typed buffer.
    inline_sort_keys: Vec<FuncId>,
    /// The unboxed calling convention of each function that has one.
    abis: Vec<Option<Abi>>,
    wide_workers: Vec<bool>,
    /// Which parameters of each function do not escape (`src/escape.rs`):
    /// a record or variant passed there may live on the caller's stack.
    noesc: Vec<Vec<bool>>,
    /// Functions the runtime calls back directly (`Gen::callback`).
    callbacks: Vec<FuncId>,
    owned_callbacks: Vec<FuncId>,
    owned_fold_callbacks: Vec<FuncId>,
    owned_right_fold_callbacks: Vec<FuncId>,
}

/// Whether `e` is local `x`, under reference count changes.
fn is_local_through_counts(e: &Expr, x: Local) -> bool {
    match e {
        Expr::Local(l) => *l == x,
        Expr::Trace(_, b)
        | Expr::Dup(_, b)
        | Expr::Drop(_, b)
        | Expr::BorrowGlobal(_, _, b)
        | Expr::ResourceRegion { body: b, .. } => is_local_through_counts(b, x),
        _ => false,
    }
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
    for (id, borrowed) in &p.borrowed_parameters {
        let f = &p.funcs[*id];
        let Body::Expr(body) = &f.body else {
            unreachable!("only expression workers borrow arguments")
        };
        crate::rc::ownership_liveness(&p, f, body, &f.locals, borrowed)
            .expect("invalid inferred argument ownership");
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

/// Original resource record holders may retain fields without a heap box.
fn resource_frame_fields_enabled() -> bool {
    std::env::var("FWP_FRAME_FIELDS").map_or(true, |v| v != "0")
}

/// Variants returned as structs (`FWP_VRET=0` when compiling turns it off).
fn variant_returns_enabled() -> bool {
    std::env::var("FWP_VRET").map_or(true, |v| v != "0")
}

impl Gen<'_> {
    fn value_dup(&self, ty: &MT) -> &'static str {
        if matches!(ty, MT::Con(n, _) if n == "std::File") {
            "fwp_file_dup"
        } else if matches!(ty, MT::Con(n, _) if matches!(n.as_str(), "std::UdpSocket" | "std::Conn" | "std::Listener"))
        {
            "fwp_sock_dup"
        } else {
            "fwp_rc_dup"
        }
    }

    fn resource_type(&self, ty: &MT) -> bool {
        crate::resource::contains_resource(&self.prog.shapes, ty)
            || (self.weak_channels && crate::resource::contains_channel(&self.prog.shapes, ty))
            || (self.resource_captures && crate::resource::may_hold_resource(&self.prog.shapes, ty))
    }

    fn live_calls(&self, id: FuncId, e: &Expr) -> HashMap<*const Expr, crate::rc::CallLiveness> {
        if !self.unwind {
            return HashMap::new();
        }
        crate::rc::ownership_liveness(
            self.prog,
            &self.prog.funcs[id],
            e,
            &self.prog.funcs[id].locals,
            self.prog
                .borrowed_parameters
                .get(&id)
                .map_or(&[], Vec::as_slice),
        )
        .expect("invalid ownership before C generation")
    }

    /// A temporary typed owner for values awaiting an allocating operation.
    /// Scalar fields have no scope entry and cannot be mistaken for pointers.
    fn protect_values(&mut self, values: &[(String, MT)], ctx: &str, node: &str) -> String {
        if !self.unwind {
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

    /// Original frame holders may keep variant tags and payloads as structs.
    fn protect_frame_values(
        &mut self,
        values: &[(String, MT)],
        variants: &[(usize, MT)],
        ctx: &str,
        node: &str,
    ) -> (String, usize) {
        if variants.is_empty() {
            let protection = self.protect_values(values, ctx, node);
            let id = self.cleanup_defs.len().saturating_sub(1);
            return (protection, id);
        }
        let mut members = Vec::new();
        let mut initial = Vec::new();
        let mut releases = Vec::new();
        for (i, (value, ty)) in values.iter().enumerate() {
            members.push(format!("V v{i};"));
            initial.push(value.clone());
            let drop = self.value_drop(ty);
            releases.push(format!("{drop}(c->v{i});"));
        }
        for (i, (m, ty)) in variants.iter().enumerate() {
            let k = self.vhelper(ty, *m);
            members.push(format!("fwp_u{m} u{i};"));
            initial.push("{0}".into());
            releases.push(format!("fwp_vdrop{k}(&c->u{i});"));
        }
        // Helpers may generate their own cleanup definitions first.
        let id = self.cleanup_defs.len();
        self.cleanup_defs.push(format!("typedef struct {{ {} }} fwp_owner_ctx{id};\nstatic void fwp_owner_release{id}(void *arg) {{ fwp_owner_ctx{id} *c = arg; {} }}\n", members.join(" "), releases.join(" ")));
        (format!("fwp_owner_ctx{id} {ctx} = {{{}}}; fwp_cleanup {node}; fwp_cleanup_push(&{node}, fwp_owner_release{id}, &{ctx});", initial.join(", ")), id)
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
        for (j, (value, ty)) in counted.iter().enumerate() {
            let duplicate = self.value_dup(ty);
            let _ = write!(out, " {duplicate}({value});");
            if !protect.is_empty() {
                let _ = write!(out, " {ctx}.v{j} = {value};");
            }
        }
        if !protect.is_empty() {
            let _ = write!(out, " fwp_cleanup_pop(&{node});");
        }
        out
    }

    /// A generated allocation starts with one counted owner.
    fn fresh(&self, alloc: String) -> String {
        format!("fwp_rc_fresh({})", alloc)
    }

    /// The C function the runtime calls for function `g` (a primitive's
    /// callback): one that shares its result.
    fn callback(&mut self, g: FuncId) -> String {
        if !self.callbacks.contains(&g) {
            self.callbacks.push(g);
        }
        format!("k{}", g)
    }

    /// The number of fields of a record `e` gives without being built:
    /// a record expression, or a call of a worker returning a struct.
    fn unboxed_value(&self, e: &Expr) -> Option<usize> {
        match e {
            Expr::Call(id, _) => self.abis[*id].as_ref()?.ret,
            Expr::Record(xs) if (1..=MAX_UNBOXED).contains(&xs.len()) => Some(xs.len()),
            Expr::Let(_, _, b)
            | Expr::Trace(_, b)
            | Expr::Dup(_, b)
            | Expr::Drop(_, b)
            | Expr::ResourceRegion { body: b, .. } => self.unboxed_value(b),
            Expr::Match(_, arms) => {
                let n = self.unboxed_value(&arms.first()?.1)?;
                arms.iter()
                    .all(|(_, b)| self.unboxed_value(b) == Some(n))
                    .then_some(n)
            }
            _ => None,
        }
    }

    /// RC preparation names computed record arguments. Track those typed
    /// producers when deciding which nested loop fields can remain unboxed.
    fn local_record_width(
        &self,
        e: &Expr,
        locals: &[MT],
        known: &HashMap<Local, usize>,
    ) -> Option<usize> {
        match e {
            Expr::Local(l) => known.get(l).copied(),
            Expr::Trace(_, b)
            | Expr::Dup(_, b)
            | Expr::Drop(_, b)
            | Expr::BorrowGlobal(_, _, b)
            | Expr::ResourceRegion { body: b, .. } => self.local_record_width(b, locals, known),
            Expr::Let(l, v, b) => {
                let mut known = known.clone();
                if let Some(n) = self
                    .local_record_width(v, locals, &known)
                    .filter(|n| small_record(self.prog, &locals[*l as usize]) == Some(*n))
                {
                    known.insert(*l, n);
                } else {
                    known.remove(l);
                }
                self.local_record_width(b, locals, &known)
            }
            Expr::Match(_, arms) => {
                let n = self.local_record_width(&arms.first()?.1, locals, known)?;
                arms.iter()
                    .all(|(_, b)| self.local_record_width(b, locals, known) == Some(n))
                    .then_some(n)
            }
            _ => self.unboxed_value(e),
        }
    }

    fn loop_field_unboxed(
        &self,
        e: &Expr,
        field: usize,
        n: usize,
        locals: &[MT],
        known: &HashMap<Local, usize>,
    ) -> bool {
        match e {
            Expr::Let(l, v, b) => {
                let mut known = known.clone();
                if let Some(m) = self
                    .local_record_width(v, locals, &known)
                    .filter(|m| small_record(self.prog, &locals[*l as usize]) == Some(*m))
                {
                    known.insert(*l, m);
                } else {
                    known.remove(l);
                }
                self.loop_field_unboxed(b, field, n, locals, &known)
            }
            Expr::Trace(_, b)
            | Expr::Dup(_, b)
            | Expr::Drop(_, b)
            | Expr::BorrowGlobal(_, _, b)
            | Expr::ResourceRegion { body: b, .. } => {
                self.loop_field_unboxed(b, field, n, locals, known)
            }
            Expr::Match(_, arms) => arms
                .iter()
                .all(|(_, b)| self.loop_field_unboxed(b, field, n, locals, known)),
            Expr::Construct(0, xs) => match xs.as_slice() {
                [Expr::Record(fs)] => self.local_record_width(&fs[field], locals, known) == Some(n),
                _ => false,
            },
            Expr::Construct(1, _) => true,
            _ => false,
        }
    }
}

/// Most fields of a record passed or returned as a C struct. The target
/// C ABI determines register classes and caller-provided result storage.
const MAX_UNBOXED: usize = 8;

/// Most record fields returned as a struct without requiring construction on
/// every return path. Already-boxed dynamic call results stay boxed at any width.
/// Wider records use structs only when every return path builds one.
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
    // A dynamic call already returns a boxed record. Forward that owner rather
    // than unpacking it in the worker and allocating an identical closure result.
    let ret = small_record(prog, f.ty.params(f.arity as usize).1).filter(|_| {
        !built_return(
            body,
            &std::collections::HashSet::new(),
            &|e| matches!(e, Expr::Apply(target, _) if !matches!(**target, Expr::Func(_))),
        )
    });
    let numeric = f.locals[..f.arity as usize]
        .iter()
        .any(|t| NativeNumber::of(t).is_some())
        || NativeNumber::of(f.ty.params(f.arity as usize).1).is_some();
    (numeric || ret.is_some() || params.iter().any(Option::is_some)).then_some(Abi {
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

/// Whether every result comes from an expression accepted by `builds`.
/// Typed local bindings retain ownership context without hiding those origins.
/// Caller-provided values have no entry in `known` and remain boxed.
fn built_return(
    e: &Expr,
    known: &std::collections::HashSet<Local>,
    builds: &impl Fn(&Expr) -> bool,
) -> bool {
    match e {
        Expr::Local(l) => known.contains(l),
        Expr::Let(l, value, body) => {
            let mut known = known.clone();
            if built_return(value, &known, builds) {
                known.insert(*l);
            } else {
                known.remove(l);
            }
            built_return(body, &known, builds)
        }
        Expr::Match(_, arms) => arms
            .iter()
            .all(|(_, body)| built_return(body, known, builds)),
        Expr::Trace(_, body)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body)
        | Expr::ResourceRegion { body, .. } => built_return(body, known, builds),
        _ => builds(e),
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
            let ok = built_return(body, &std::collections::HashSet::new(), &|e| match e {
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
            let ok = built_return(body, &std::collections::HashSet::new(), &|e| match e {
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
        Expr::Trace(_, b)
        | Expr::Dup(_, b)
        | Expr::Drop(_, b)
        | Expr::BorrowGlobal(_, _, b)
        | Expr::ResourceRegion { body: b, .. } => variant_uses(b, l, returned),
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

/// Native scalar types are confined to direct workers. Boxed values, runtime
/// callbacks and external interfaces keep their established V representation.
#[derive(Clone, Copy)]
enum NativeNumber {
    Signed(u8),
    Unsigned(u8),
    F32,
    F64,
}

impl NativeNumber {
    fn of(t: &MT) -> Option<Self> {
        if std::env::var("FWP_TYPED_ABI").is_ok_and(|v| v == "0") {
            return None;
        }
        let MT::Con(name, _) = t else { return None };
        match name.as_str() {
            "std::I8" => Some(Self::Signed(8)),
            "std::I16" => Some(Self::Signed(16)),
            "std::I32" => Some(Self::Signed(32)),
            "std::I64" => Some(Self::Signed(64)),
            "std::U8" => Some(Self::Unsigned(8)),
            "std::U16" => Some(Self::Unsigned(16)),
            "std::U32" => Some(Self::Unsigned(32)),
            "std::U64" => Some(Self::Unsigned(64)),
            "std::F32" => Some(Self::F32),
            "std::F64" => Some(Self::F64),
            "std::F16" | "std::BF16" => Some(Self::Unsigned(16)),
            _ => None,
        }
    }

    fn c_type(self) -> String {
        match self {
            Self::Signed(n) => format!("int{n}_t"),
            Self::Unsigned(n) => format!("uint{n}_t"),
            Self::F32 => "float".into(),
            Self::F64 => "double".into(),
        }
    }

    fn decode_word(self, v: &str) -> String {
        match self {
            Self::F32 => format!("fwp_f32({v})"),
            Self::F64 => format!("fwp_f64({v})"),
            _ => format!("({})({v})", self.c_type()),
        }
    }

    fn to_word(self, v: &str) -> String {
        match self {
            Self::F32 => format!("fwp_from_f32({v})"),
            Self::F64 => format!("fwp_from_f64({v})"),
            Self::Signed(_) => format!("(V)(int64_t)({v})"),
            Self::Unsigned(_) => format!("(V)({v})"),
        }
    }
}

// Both dynamic callbacks and direct workers use the same protected numeric
// buffers. `callback` writes keys[i] and, for maps, vals[i]; fields are unboxed.
fn numeric_collection_body(
    count: &str,
    iterator: &str,
    input: &str,
    callback: &str,
    descriptor: &str,
    paired: bool,
) -> String {
    let (lanes, values, value_argument) = if paired {
        (2, "V *vals = keys + n;", "vals")
    } else {
        (1, "", "NULL")
    };
    format!(
        r#"uint64_t count = {count};
    if (count > SIZE_MAX / ({lanes} * sizeof(V))) fwp_trap("map too large");
    V result = FWP_EMPTY_MAP;
    if (count) {{
        size_t n = (size_t)count;
        V *keys = (V *)fwp_mem_alloc({lanes} * n * sizeof(V));
        fwp_cleanup keys_cleanup;
        fwp_scratch_protect(&keys, &keys_cleanup);
        {values}
        {iterator}
        for (size_t i = 0; i < n; i++) {{
            {input}
            {callback}
        }}
        const fwp_map_ops ops = {{NULL, NULL, NULL, NULL, fwp_rc_free_obj, NULL, {lanes}}};
        result = fwp_map_build_typed(keys, {value_argument}, n, &ops, {descriptor});
        fwp_scratch_finish(&keys, &keys_cleanup);
    }}"#
    )
}

impl Abi {
    fn param_numbers(&self, prog: &Program, id: FuncId) -> Vec<Option<NativeNumber>> {
        let f = &prog.funcs[id];
        self.params
            .iter()
            .enumerate()
            .flat_map(|(i, p)| match p {
                Some(_) => record_fields(&prog.shapes, &f.locals[i])
                    .expect("record ABI parameter")
                    .iter()
                    .map(|(_, t)| NativeNumber::of(t))
                    .collect::<Vec<_>>(),
                None => vec![NativeNumber::of(&f.locals[i])],
            })
            .collect()
    }

    fn result_numbers(&self, prog: &Program, id: FuncId) -> Vec<Option<NativeNumber>> {
        let t = prog.funcs[id].ty.params(prog.funcs[id].arity as usize).1;
        record_fields(&prog.shapes, t)
            .expect("record ABI result")
            .iter()
            .map(|(_, t)| NativeNumber::of(t))
            .collect()
    }

    fn args_decode_words(&self, prog: &Program, id: FuncId, words: Vec<String>) -> Vec<String> {
        words
            .into_iter()
            .zip(self.param_numbers(prog, id))
            .map(|(v, n)| n.map_or_else(|| v.clone(), |n| n.decode_word(&v)))
            .collect()
    }

    fn result_words(&self, prog: &Program, id: FuncId, result: &str) -> Vec<String> {
        self.result_numbers(prog, id)
            .into_iter()
            .enumerate()
            .map(|(i, n)| {
                let v = format!("{result}.f{i}");
                n.map_or_else(|| v.clone(), |n| n.to_word(&v))
            })
            .collect()
    }

    fn scalar_result(&self, prog: &Program, id: FuncId) -> Option<NativeNumber> {
        let f = &prog.funcs[id];
        NativeNumber::of(f.ty.params(f.arity as usize).1)
    }

    fn sig(&self, prog: &Program, id: FuncId) -> String {
        let mut names = Vec::new();
        for (i, p) in self.params.iter().enumerate() {
            match p {
                Some(n) => names.extend((0..*n).map(|k| format!("l{i}_{k}"))),
                None => names.push(format!("l{i}")),
            }
        }
        let ps: Vec<_> = names
            .into_iter()
            .zip(self.param_numbers(prog, id))
            .map(|(name, n)| match n {
                Some(n) => format!("{} a{name}", n.c_type()),
                None => format!("V {name}"),
            })
            .collect();
        let ret = match (self.ret, self.vret) {
            (Some(_), _) => format!("fwp_wr{id}"),
            (None, Some(m)) => format!("fwp_u{m}"),
            (None, None) => self
                .scalar_result(prog, id)
                .map_or_else(|| "V".into(), NativeNumber::c_type),
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
        "F16" => "K_F16",
        "BF16" => "K_BF16",
        "F32" => "K_F32",
        "F128" => "K_F128",
        "F64" => "K_F64",
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

/// Emit canonical hashing for inline numbers, their flat collections and
/// records containing those values. The input stays borrowed throughout.
/// Other representations retain their descriptor-based traversal.
fn numeric_hash_body(
    shapes: &Shapes,
    ty: &MT,
    value: &str,
    active: &mut Vec<MT>,
) -> Option<String> {
    let bytes = |ty| match scalar(ty)? {
        Scalar::Signed(bits) | Scalar::Unsigned(bits) => Some(bits / 8),
        Scalar::F32 => Some(4),
        Scalar::F64 => Some(8),
    };
    if let Some(width) = bytes(ty) {
        return Some(format!(
            "hash_state = fwp_hash_le(hash_state, {value}, {width});\n"
        ));
    }
    if active.contains(ty) {
        return None;
    }
    let depth = active.len();
    active.push(ty.clone());
    let v = format!("hash_value{depth}");
    let i = format!("hash_index{depth}");
    let n = format!("hash_length{depth}");
    let result = (|| {
        let fields = match ty {
            MT::Record(fields) => Some(fields),
            _ => match shapes.get(ty) {
                Some(TypeShape::Record(fields)) => Some(fields),
                _ => None,
            },
        };
        if let Some(fields) = fields {
            let mut body = format!("{{ V {v} = {value}; (void){v};\n");
            for (index, (_, field)) in fields.iter().enumerate() {
                body.push_str(&numeric_hash_body(
                    shapes,
                    field,
                    &format!("OBJ({v})->f[{index}]"),
                    active,
                )?);
            }
            body.push_str("}\n");
            return Some(body);
        }
        let MT::Con(name, elements) = ty else {
            return None;
        };
        let widths = elements.iter().map(bytes).collect::<Option<Vec<_>>>()?;
        let mut body = format!("{{ V {v} = {value};\n");
        match (name.as_str(), widths.as_slice()) {
            ("std::Array", [width]) => {
                let bits = width * 8;
                body.push_str(&format!("uint64_t {n} = fwp_array_len({v});\nconst unsigned char *hash_data{depth} = fwp_array_data({v});\nhash_state = fwp_hash_leb128(hash_state, {n});\nfor (uint64_t {i} = 0; {i} < {n}; {i}++) {{\n#if FWP_PACKED_ARRAYS\nuint{bits}_t hash_word{depth};\n#else\nV hash_word{depth};\n#endif\nmemcpy(&hash_word{depth}, hash_data{depth} + {i} * sizeof hash_word{depth}, sizeof hash_word{depth});\nhash_state = fwp_hash_le(hash_state, hash_word{depth}, {width});\n}}\n"));
            }
            ("std::List", [width]) => {
                body.push_str(&format!("hash_state = fwp_hash_leb128(hash_state, fwp_list_len({v}));\nwhile ({v}) {{\nhash_state = fwp_hash_le(hash_state, OBJ({v})->f[0], {width});\n{v} = OBJ({v})->f[1];\n}}\n"));
            }
            ("std::Set", [width]) => {
                body.push_str(&format!("uint64_t {n} = MAP({v})->len;\nhash_state = fwp_hash_leb128(hash_state, {n});\nfor (uint64_t {i} = 0; {i} < {n}; {i}++)\nhash_state = fwp_hash_le(hash_state, MAP({v})->d[{i}], {width});\n"));
            }
            ("std::Map", [key, item]) => {
                body.push_str(&format!("uint64_t {n} = MAP({v})->len;\nhash_state = fwp_hash_leb128(hash_state, {n});\nfor (uint64_t {i} = 0; {i} < {n}; {i}++) {{\nhash_state = fwp_hash_le(hash_state, MAP({v})->d[2 * {i}], {key});\nhash_state = fwp_hash_le(hash_state, MAP({v})->d[2 * {i} + 1], {item});\n}}\n"));
            }
            _ => return None,
        }
        body.push_str("}\n");
        Some(body)
    })();
    active.pop();
    result
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
                Some((_, hi)) if self == Scalar::Unsigned(32) && op == "mul" => {
                    // U32::MAX squared fits U64, but exceeds I64::MAX. Keep
                    // the widening product defined before checking U32's bound.
                    s = format!(
                        "uint64_t r = (uint64_t)l1 * (uint64_t)l0;\n    if (r > {hi}) {ovf}"
                    );
                }
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
        // The preceding overflow check proves this product fits I64. Exposing
        // the expression on that continuation lets the C compiler retain operand
        // range information that it can lose through the builtin's output slot.
        let result = match (self, op) {
            (Scalar::Signed(64), "mul") => "(x * y)",
            _ => "r",
        };
        format!("{s}\n    return (V){result};")
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
        let mut def = self.desc_body(mt, id);
        {
            let drop = self.value_drop(mt);
            let dup = if crate::rc::needs_rc(&self.prog.shapes, mt) {
                self.value_dup(mt)
            } else {
                "NULL"
            };
            let end = def.rfind("};").expect("descriptor initializer");
            def.insert_str(end, &format!(", .dup = {dup}, .drop = {drop}"));
        }
        self.desc_defs[id] = def;
        id
    }

    fn cstr(s: &str) -> String {
        c_string_literal(s.as_bytes())
    }

    /// The drop function of values of type `mt` (counted, see
    /// `rc::needs_rc`): it gives up one reference; on the last one, it
    /// gives up the references the object holds, by their types, and frees
    /// it. Direct self tails and eligible paths through final owned wrapper
    /// fields return to the same loop, so those chains need no deep recursion.
    /// Branching recursive graphs can still require calls. Objects the
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
                self.value_dup(ty)
            } else {
                "NULL"
            }
        };
        let state = duplicate(&fields[0]);
        let result = duplicate(&fields[1]);
        let drop = self.value_drop(step);
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
        } else if !matches!(ty, MT::Con(n, _) if n == "?") {
            format!("fwp_drop{}", self.drop_id(ty))
        } else {
            "fwp_rc_drop".into()
        }
    }

    fn map_ops(&mut self, element: &MT) -> String {
        let drop = self.value_drop(element);
        let list = MT::Con("std::List".into(), vec![element.clone()]);
        let list_drop = self.value_drop(&list);
        format!("{drop}, {list_drop}")
    }

    fn tree_owner_id(&mut self, mt: &MT) -> Result<usize, String> {
        if let Some(id) = self.tree_owners.get(mt) {
            return Ok(*id);
        }
        let id = self.tree_owner_defs.len();
        self.tree_owners.insert(mt.clone(), id);
        self.tree_owner_defs.push(String::new());
        // Native heap objects already have an allocator count slot. WASI
        // objects gain an external entry only when first claimed, so
        // a missing slot there is a fresh owner, not an immortal value.
        let mut body = format!("static void fwp_own_tree{id}(V v) {{\n    for (;;) {{\n        if (v < 4096) return;\n        uint8_t *c = fwp_rc_slot(v);\n#if FWP_NATIVE_HEAP\n        if (!c) return;\n#endif\n        if (c && *c) fwp_trap(\"internal: aliased fresh result tree\");\n        fwp_rc_fresh(v);\n");
        if matches!(mt, MT::Con(n, _) if matches!(n.as_str(), "std::String" | "std::Bytes" | "std::I128" | "std::U128" | "std::F128"))
        {
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
                let name = if !matches!(ft, MT::Con(n, _) if n == "?") {
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

    /// Follow the final counted field through records and variants with one
    /// nonempty constructor. Returning to `root` closes a destruction loop,
    /// e.g. Link -> Option[Link] -> Link, without runtime stack/work storage.
    fn wrapped_drop_path(&self, root: &MT, first: &MT) -> Option<Vec<Vec<MT>>> {
        let mut current = first.clone();
        let mut seen = Vec::new();
        let mut path = Vec::new();
        while &current != root {
            if seen.contains(&current) {
                return None;
            }
            seen.push(current.clone());
            let fields = if let Some(fs) = record_fields(&self.prog.shapes, &current) {
                fs.iter().map(|(_, ty)| ty.clone()).collect::<Vec<_>>()
            } else if let Some(TypeShape::Adt(variants)) = self.prog.shapes.get(&current) {
                let mut populated = variants.iter().filter(|(_, fields)| !fields.is_empty());
                let fields = populated.next()?.1.clone();
                if populated.next().is_some() {
                    return None;
                }
                fields
            } else {
                return None;
            };
            current = fields
                .iter()
                .rfind(|ty| {
                    crate::rc::needs_rc(&self.prog.shapes, ty)
                        && !matches!(ty, MT::Con(name, _) if name == "?")
                })?
                .clone();
            path.push(fields);
        }
        Some(path)
    }

    fn drop_body(&mut self, mt: &MT, id: usize) -> String {
        if let MT::Con(name, args) = mt {
            if name == "std::H2Stream" {
                return format!("static void fwp_drop{id}(V v) {{ g_call_drop(v); }}\n");
            }
            if name == "std::GrpcCell" && args.len() == 1 {
                let element = self.value_drop(&args[0]);
                return format!("static void fwp_drop{id}(V v) {{ g_cell_drop(v, {element}); }}\n");
            }
        }
        if matches!(mt, MT::Con(n, _) if n == "std::File") {
            return format!("static void fwp_drop{id}(V v) {{ fwp_file_drop(v); }}\n");
        }
        if matches!(mt, MT::Con(n, _) if matches!(n.as_str(), "std::UdpSocket" | "std::Conn" | "std::Listener"))
        {
            return format!("static void fwp_drop{id}(V v) {{ fwp_sock_drop(v); }}\n");
        }
        if matches!(mt, MT::Con(n, _) if n == "std::Channel") {
            return format!("static void fwp_drop{id}(V v) {{ fwp_channel_drop(v); }}\n");
        }
        if matches!(mt, MT::Con(n, _) if n == "std::WeakChannel") {
            return format!("static void fwp_drop{id}(V v) {{ fwp_weak_channel_drop(v); }}\n");
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
        if matches!(mt, MT::Con(n, _) if matches!(n.as_str(), "std::String" | "std::Bytes" | "std::I128" | "std::U128" | "std::F128"))
        {
            return format!(
                "{}        fwp_rc_free_obj(v);\n        return;\n    }}\n}}\n",
                head
            );
        }
        let container = matches!(mt, MT::Con(n, _) if crate::rc::is_container(n));
        if container {
            let mut elements = String::new();
            if matches!(mt, MT::Con(name, _) if name == "std::Array") {
                elements.push_str("        if (fwp_array_is_view(v)) { V owner = fwp_array_owner(v); fwp_rc_free_arr(v); v = owner; continue; }\n");
            }
            if let MT::Con(name, types) = mt {
                if name == "std::Array"
                    && types.len() == 1
                    && crate::rc::needs_rc(&self.prog.shapes, &types[0])
                    && !matches!(&types[0], MT::Con(n, _) if n == "std::F128")
                {
                    let child = self.drop_id(&types[0]);
                    elements.push_str(&format!("        for (uint64_t i = 0; i < fwp_array_len(v); i++) fwp_drop{child}(ARR(v)->d[i]);\n"));
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
                            let columns = types.len();
                            let _ =
                                write!(fields, " fwp_drop{child}(MAP(v)->d[{columns} * i + {i}]);");
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
            // Preserve the existing direct self-tail choice. Otherwise a final
            // counted field can return through ordinary wrappers to this type.
            let direct = fs.iter().rposition(|t| t == mt);
            let wrapped = if direct.is_none() {
                fs.iter().rposition(counted).and_then(|index| {
                    self.wrapped_drop_path(mt, &fs[index])
                        .map(|path| (index, path))
                })
            } else {
                None
            };
            let tail = direct.or_else(|| wrapped.as_ref().map(|(index, _)| *index));
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
                    if let Some((_, path)) = &wrapped {
                        for (step, fields) in path.iter().enumerate() {
                            // A shared wrapper owns the rest of this path. Stop
                            // before reading or releasing its children.
                            let _ = writeln!(body, "{ind}    if (!fwp_rc_release_last(v)) return;");
                            let last = fields.iter().rposition(counted).unwrap();
                            for (field, ty) in fields.iter().enumerate() {
                                if field != last && counted(ty) {
                                    let child = self.drop_id(ty);
                                    let _ = writeln!(
                                        body,
                                        "{ind}    fwp_drop{child}(OBJ(v)->f[{field}]);"
                                    );
                                }
                            }
                            let _ = writeln!(body, "{ind}    V next{step} = OBJ(v)->f[{last}];");
                            let _ = writeln!(body, "{ind}    fwp_rc_free_obj(v);");
                            let _ = writeln!(body, "{ind}    v = next{step};");
                        }
                    }
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
        assert!(
            !matches!(self.prog.shapes.get(mt), Some(TypeShape::RegionLink { .. })),
            "region link cannot cross a runtime descriptor boundary"
        );
        let simple = |kind: &str, name: &str| {
            format!(
                "static const fwp_desc d{} = {{{}, {}}};",
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
                        "static const fwp_desc d{} = {{{}, {}, .width = {}}};",
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
                    "std::WeakChannel" => return simple("K_NATIVE", "weak channel"),
                    "std::Listener" => return simple("K_NATIVE", "listener"),
                    "std::H2Stream" => return simple("K_NATIVE", "HTTP/2 stream"),
                    "std::Conn" => return simple("K_NATIVE", "connection"),
                    "std::UdpSocket" => return simple("K_NATIVE", "udp socket"),
                    "std::List" | "std::Array" | "std::Set" => {
                        let e = self.desc_id(&elem(mt, 0));
                        let k = match n.as_str() {
                            "std::List" => "K_LIST",
                            "std::Array" => "K_ARRAY",
                            _ => "K_SET",
                        };
                        return format!(
                            "static const fwp_desc d{} = {{{}, 0, .elem = &d{}}};",
                            id, k, e
                        );
                    }
                    "std::Map" => {
                        let k = self.desc_id(&elem(mt, 0));
                        let v = self.desc_id(&elem(mt, 1));
                        return format!(
                            "static const fwp_desc d{} = {{K_MAP, 0, .elem = &d{}, .elem2 = &d{}}};",
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
                            "static const fwp_desc d{id};\n{vf}\nstatic const char *const d{id}_n[] = {{{names}}};\nstatic const int d{id}_a[] = {{{arity}}};\nstatic const fwp_desc *const *const d{id}_vf[] = {{{vrefs}}};\nstatic const fwp_desc d{id} = {{K_ADT, {name}, {n}, d{id}_n, 0, d{id}_a, d{id}_vf, .width = {flag}}};",
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
            "static const fwp_desc d{id};\nstatic const char *const d{id}_n[] = {{{names}}};\nstatic const fwp_desc *const d{id}_f[] = {{{ds}}};\nstatic const fwp_desc d{id} = {{K_RECORD, {name}, {n}, d{id}_n, d{id}_f, .width = {tuple}}};",
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

    /// A function reference that neither evaluates nor captures runtime data.
    fn bare_function(&self, e: &Expr) -> Option<FuncId> {
        let id = match e {
            Expr::Func(id) => *id,
            Expr::Const(Value::Closure(c)) if c.args.is_empty() => c.func,
            _ => return None,
        };
        // Zero-argument definitions must still evaluate, including effects/traps.
        (self.prog.funcs[id].arity > 0).then_some(id)
    }

    fn static_function(&mut self, function: FuncId, captures: Vec<FuncId>) -> String {
        assert!(!captures.is_empty() && captures.len() < self.prog.funcs[function].arity as usize);
        self.used_closures[function] = true;
        for &capture in &captures {
            assert!(self.prog.funcs[capture].arity > 0);
            self.used_closures[capture] = true;
        }
        let next = self.static_functions.len();
        let id = *self
            .static_functions
            .entry((function, captures))
            .or_insert(next);
        format!("PTR(&fwp_static_function{id})")
    }

    /// C expression for a constant value (complex values are built once at
    /// startup in static storage, without managed heap allocation).
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
            Value::F16(x) => format!("(V)0x{:x}U", x.to_bits()),
            Value::BF16(x) => format!("(V)0x{:x}U", x.to_bits()),
            Value::TInt(x) => format!("(V)(int64_t){}LL", x),
            Value::Trit(x) => format!("(V)(int64_t){}", x),
            Value::Str(s) => self.string_const(s.as_bytes()),
            Value::Bytes(b) => self.string_const(b),
            Value::Data(tag, fs) if fs.is_empty() => format!("(V){}", tag),
            Value::Record(fs) if fs.is_empty() => "(V)0".into(),
            _ => {
                let id = self.consts.len();
                self.consts.push(format!("static V c{};", id));
                let init = self.const_build(v, id);
                let _ = writeln!(self.const_init, "    c{} = {};", id, init);
                format!("c{}", id)
            }
        }
    }

    fn const_build(&mut self, v: &Value, id: usize) -> String {
        match v {
            Value::I128(x) => {
                let (hi, lo) = ((*x as u128 >> 64) as u64, *x as u128 as u64);
                self.consts.push(format!(
                    "static i128 fwp_constant{id} = (i128)(((u128){hi}ULL << 64) | {lo}ULL);"
                ));
                format!("PTR(&fwp_constant{id})")
            }
            Value::U128(x) => {
                let (hi, lo) = ((x >> 64) as u64, *x as u64);
                self.consts.push(format!(
                    "static u128 fwp_constant{id} = ((u128){hi}ULL << 64) | {lo}ULL;"
                ));
                format!("PTR(&fwp_constant{id})")
            }
            Value::F128(x) => {
                self.consts.push(format!(
                    "static float128_t fwp_constant{id} = {{{{{}ULL, {}ULL}}}};",
                    x.to_bits() as u64,
                    (x.to_bits() >> 64) as u64
                ));
                format!("PTR(&fwp_constant{id})")
            }
            Value::Data(_, fs) | Value::Record(fs) => {
                let tag = match v {
                    Value::Data(tag, _) => *tag,
                    _ => 0,
                };
                self.consts.push(format!("static struct {{ uint32_t tag, n; V f[{}]; }} fwp_constant{id} = {{{tag}, {}, {{0}}}};", fs.len(), fs.len()));
                for (i, field) in fs.iter().enumerate() {
                    let value = self.const_expr(field);
                    let _ = writeln!(self.const_init, "    fwp_constant{id}.f[{i}] = {value};");
                }
                format!("PTR(&fwp_constant{id})")
            }
            Value::Array(items) => {
                let parts: Vec<String> = items.iter().map(|f| self.const_expr(f)).collect();
                let kind = match items.first() {
                    Some(Value::I8(_)) => "K_I8",
                    Some(Value::U8(_)) => "K_U8",
                    Some(Value::I16(_)) => "K_I16",
                    Some(Value::U16(_)) => "K_U16",
                    Some(Value::I32(_)) => "K_I32",
                    Some(Value::U32(_)) => "K_U32",
                    Some(Value::I64(_)) => "K_I64",
                    Some(Value::U64(_)) => "K_U64",
                    Some(Value::F32(_)) => "K_F32",
                    Some(Value::F64(_)) => "K_F64",
                    Some(Value::F16(_)) => "K_F16",
                    Some(Value::BF16(_)) => "K_BF16",
                    Some(Value::F128(_)) => "K_F128",
                    _ => "K_OPAQUE",
                };
                let stride = match kind {
                    "K_F128" => "16",
                    "K_I8" | "K_U8" => "(FWP_PACKED_ARRAYS ? 1 : 8)",
                    "K_I16" | "K_U16" | "K_F16" | "K_BF16" => "(FWP_PACKED_ARRAYS ? 2 : 8)",
                    "K_I32" | "K_U32" | "K_F32" => "(FWP_PACKED_ARRAYS ? 4 : 8)",
                    _ => "8",
                };
                let payload = if parts.is_empty() {
                    String::new()
                } else {
                    format!(" unsigned char d[{} * {stride}];", parts.len())
                };
                self.consts.push(format!(
                    "static struct {{ uint64_t len;{payload} }} fwp_constant{id} = {{.len = {}}};",
                    parts.len()
                ));
                if !parts.is_empty() {
                    // The store only reads this descriptor. Reuse it within the
                    // array's block: per-element compound literals remain live
                    // until the initializer returns and can grow its stack frame.
                    let _ = writeln!(
                        self.const_init,
                        "    {{ const fwp_desc element = {{.kind = {kind}}};"
                    );
                    for (i, value) in parts.iter().enumerate() {
                        let _ = writeln!(
                            self.const_init,
                            "    fwp_array_store(PTR(&fwp_constant{id}), {i}, {value}, &element);"
                        );
                    }
                    self.const_init.push_str("    }\n");
                }
                format!("PTR(&fwp_constant{id})")
            }
            Value::Set(values) => {
                let payload = if values.is_empty() {
                    String::new()
                } else {
                    format!(" V d[{}];", values.len())
                };
                self.consts.push(format!(
                    "static struct {{ uint64_t len;{payload} }} fwp_constant{id} = {{.len = {}}};",
                    values.len()
                ));
                for (i, value) in values.iter().enumerate() {
                    let value = self.const_expr(value);
                    let _ = writeln!(self.const_init, "    fwp_constant{id}.d[{i}] = {value};");
                }
                format!("PTR(&fwp_constant{id})")
            }
            Value::Map(m) => {
                let payload = if m.is_empty() {
                    String::new()
                } else {
                    format!(" V d[{}];", m.len() * 2)
                };
                self.consts.push(format!(
                    "static struct {{ uint64_t len;{payload} }} fwp_constant{id} = {{.len = {}}};",
                    m.len()
                ));
                for (i, (key, value)) in m.iter().enumerate() {
                    for (offset, field) in [(2 * i, key), (2 * i + 1, value)] {
                        let value = self.const_expr(field);
                        let _ = writeln!(
                            self.const_init,
                            "    fwp_constant{id}.d[{offset}] = {value};"
                        );
                    }
                }
                format!("PTR(&fwp_constant{id})")
            }
            Value::File(_) | Value::Native(_) => {
                unreachable!("runtime handles were rejected before C generation")
            }
            Value::Closure(c) => {
                if !c.args.is_empty() && c.args.len() < self.prog.funcs[c.func].arity as usize {
                    let captures: Option<Vec<_>> = c
                        .args
                        .iter()
                        .map(|value| match value {
                            Value::Closure(c)
                                if c.args.is_empty() && self.prog.funcs[c.func].arity > 0 =>
                            {
                                Some(c.func)
                            }
                            _ => None,
                        })
                        .collect();
                    if let Some(captures) = captures {
                        return self.static_function(c.func, captures);
                    }
                }
                self.used_closures[c.func] = true;
                let parts: Vec<String> = c.args.iter().map(|f| self.const_expr(f)).collect();
                if parts.is_empty() {
                    format!("PTR(&fc{})", c.func)
                } else {
                    self.consts.push(format!("static struct {{ uint32_t fn, n; V a[{}]; }} fwp_constant{id} = {{{}, {}, {{0}}}};", parts.len(), c.func, parts.len()));
                    for (i, value) in parts.iter().enumerate() {
                        let _ = writeln!(self.const_init, "    fwp_constant{id}.a[{i}] = {value};");
                    }
                    format!("PTR(&fwp_constant{id})")
                }
            }
            // scalars and strings are handled by `const_expr`
            _ => "0".into(),
        }
    }
}

#[derive(Clone)]
enum ResourceSlot {
    Value(String),
    Fields(Vec<Option<String>>),
    Variant(String, usize),
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
    /// Local arrays whose complete lifetime needs direct destruction, not counts.
    unique_arrays: HashSet<Local>,
    known_callbacks: HashMap<Local, (FuncId, usize)>,
    /// Known callbacks used only by specialized generators/folds need captures,
    /// not a closure object. Their owners use the existing stack-child ledger.
    callback_captures: HashMap<Local, Vec<String>>,
    resource_slots: HashMap<Local, ResourceSlot>,
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
    /// The C variable holding the boolean `fwp_rc_unique` result.
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
        Expr::Trace(_, b)
        | Expr::Dup(_, b)
        | Expr::Drop(_, b)
        | Expr::BorrowGlobal(_, _, b)
        | Expr::ResourceRegion { body: b, .. } => allocates(b, n),
    }
}

/// A loop's step function generated with its state in arrays: its results
/// (`Again s` and `Stop r` in tail position) write the next state or the
/// result instead of being allocated.
struct LoopGen {
    unpacked_parameters: bool,
    /// Array inputs passed unchanged through every Again state.
    cached_arrays: Vec<usize>,
    tails: std::collections::HashSet<*const Expr>,
    record: bool,
    /// Per field of a record state: its first slot in the state arrays,
    /// and its number of fields when it is a record kept as its fields.
    slots: Vec<(usize, Option<usize>)>,
}

/// The signature of a higher-order primitive specialized for a function
/// that captures `k` values (`Gen::hofs`).
fn hof_sig(i: usize, sym: &str, k: usize) -> String {
    let mut parameters: Vec<String> = (0..k).map(|j| format!("V c{}", j)).collect();
    let rest = match sym {
        "fold" | "fold-right" => "V z, V xs",
        "zip-with" => "V ys, V xs",
        "loop" => "V s",
        "array.generate" => "V count",
        _ => "V xs",
    };
    parameters.push(rest.into());
    format!("static V fwp_hof{}({})", i, parameters.join(", "))
}

/// Its definition: the runtime's generic loop (runtime/fwp_rt_prims.c),
/// calling the function directly with the captured values first.
fn hof_def(
    i: usize,
    (sym, g, k): &(String, FuncId, usize),
    loop_ops: Option<&str>,
    result_ops: Option<&str>,
    fold_drop: Option<&str>,
    borrowed_step: bool,
) -> String {
    if sym == "array.generate" {
        let element = result_ops.expect("typed generated array element");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(std::iter::once("(V)index".to_string()))
            .collect::<Vec<_>>()
            .join(", ");
        let (prepare, entry) = if borrowed_step {
            (String::new(), format!("fwp_borrowed_array{i}(args)"))
        } else {
            (
                format!("        fwp_args{g}(args, 0, {k});\n"),
                format!("fwp_owned_entry{g}(args)"),
            )
        };
        return format!("{} {{\n    size_t n = fwp_count_arg(count);\n    fwp_array_builder result = {{fwp_array_typed_new(n, {element}), 0, {element}}};\n    fwp_cleanup cleanup; fwp_array_builder_protect(&result, &cleanup);\n    for (size_t index = 0; index < n; index++) {{\n        V args[] = {{{args}}};\n{prepare}        V value = {entry};\n        fwp_array_store_owned(result.value, index, value, {element});\n        result.filled++;\n    }}\n    return fwp_array_builder_finish(&result, &cleanup);\n}}\n", hof_sig(i, sym, *k));
    }
    if sym == "loop" {
        let drop = fold_drop.expect("typed loop state");
        let ops = loop_ops.expect("owned loop operations");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(std::iter::once("s".into()))
            .collect::<Vec<_>>()
            .join(", ");
        return format!("{} {{\n    fwp_value_owner owner = {{s, {drop}}}; fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup);\n    for (;;) {{\n        FWP_TICK();\n        s = owner.value;\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {k});\n        owner.value = 0;\n        V step = fwp_owned_entry{g}(args);\n        int stop = fwp_tag(step) != 0;\n        s = fwp_loop_payload(step, stop, {ops});\n        if (stop) {{ fwp_value_finish(&owner, &cleanup); return s; }}\n        owner.value = s;\n    }}\n}}\n", hof_sig(i, sym, *k));
    }
    if sym == "map" {
        let ops = result_ops.expect("typed map result operations");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(std::iter::once("a[i]".to_string()))
            .collect::<Vec<_>>()
            .join(", ");
        return format!("{} {{\n    size_t n;\n    V *a = fwp_map_items(xs, &n);\n    fwp_map_owner owner = {{a, 0, 0, {ops}}}; fwp_cleanup cleanup;\n    fwp_map_protect(&owner, &cleanup);\n    for (size_t i = 0; i < n; i++) {{\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        a[i] = fwp_owned_entry{g}(args);\n        owner.count++;\n    }}\n    V result = fwp_map_finish_protected(&owner, &cleanup);\n        return result;\n}}\n", hof_sig(i, sym, *k), k + 1);
    }
    if sym == "filter" {
        let ops = result_ops.expect("typed filter result operations");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(std::iter::once("a[i]".to_string()))
            .collect::<Vec<_>>()
            .join(", ");
        return format!("{} {{\n    size_t n, kept = 0;\n    V *a = fwp_map_items(xs, &n);\n    fwp_map_owner owner = {{a, 0, 0, {ops}}}; fwp_cleanup cleanup;\n    fwp_map_protect(&owner, &cleanup);\n    for (size_t i = 0; i < n; i++) {{\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        if (fwp_owned_entry{g}(args) == FWP_TRUE) {{\n            fwp_args{g}(&a[i], {k}, 1);\n            a[kept++] = a[i];\n            owner.count = kept;\n        }}\n    }}\n    V result = fwp_map_finish_protected(&owner, &cleanup);\n        return result;\n}}\n", hof_sig(i, sym, *k), k + 1);
    }
    if matches!(sym.as_str(), "take-while" | "drop-while") {
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
        let body = if sym == "take-while" {
            let ops = result_ops.expect("typed take-while result operations");
            format!("size_t n, kept = 0;\n    V *a = fwp_map_items(xs, &n);\n    fwp_map_owner owner = {{a, 0, 0, {ops}}}; fwp_cleanup cleanup;\n    fwp_map_protect(&owner, &cleanup);\n    while (kept < n) {{\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        if (fwp_owned_entry{g}(args) != FWP_TRUE) break;\n        fwp_args{g}(&a[kept], {k}, 1);\n        kept++;\n        owner.count = kept;\n    }}\n    V result = fwp_map_finish_protected(&owner, &cleanup);\n        return result;", k + 1)
        } else {
            format!("V source = xs;\n    while (xs) {{\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        if (fwp_owned_entry{g}(args) != FWP_TRUE) break;\n        xs = OBJ(xs)->f[1];\n    }}\n    fwp_rc_dup(xs);\n        return xs;", k + 1)
        };
        return format!("{} {{\n    {body}\n}}\n", hof_sig(i, sym, *k));
    }
    if sym == "find" {
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(std::iter::once("element".to_string()))
            .collect::<Vec<_>>()
            .join(", ");
        return format!("{} {{\n    V source = xs, result = FWP_NONE;\n    while (xs) {{\n        V element = OBJ(xs)->f[0];\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        if (fwp_owned_entry{g}(args) == FWP_TRUE) {{\n            fwp_args{g}(&element, {k}, 1);\n            result = fwp_rc_fresh(fwp_some(element));\n            break;\n        }}\n        xs = OBJ(xs)->f[1];\n    }}\n        return result;\n}}\n", hof_sig(i, sym, *k), k + 1);
    }
    if sym == "fold" {
        let drop = fold_drop.expect("typed fold accumulator");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(["z".to_string(), "OBJ(xs)->f[0]".to_string()])
            .collect::<Vec<_>>()
            .join(", ");
        let (prepare, entry) = if borrowed_step {
            (String::new(), format!("fwp_borrowed_fold{i}(args)"))
        } else {
            (
                format!(
                    "        fwp_args{g}(args, 0, {k});\n        fwp_args{g}(args + {}, {}, 1);\n",
                    k + 1,
                    k + 1
                ),
                format!("fwp_owned_entry{g}(args)"),
            )
        };
        return format!("{} {{\n    V source = xs;\n    fwp_value_owner owner = {{z, {drop}}}; fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup);\n    while (xs != 0) {{\n        V args[] = {{{args}}};\n{prepare}        owner.value = 0;\n        z = {entry};\n        owner.value = z;\n        xs = OBJ(xs)->f[1];\n    }}\n        return fwp_value_finish(&owner, &cleanup);\n}}\n", hof_sig(i, sym, *k));
    }
    if sym == "zip-with" {
        let ops = result_ops.expect("typed zip-with result operations");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(["b[i]".to_string(), "a[i]".to_string()])
            .collect::<Vec<_>>()
            .join(", ");
        return format!("{} {{\n    size_t n, m;\n    V *a = fwp_map_items(xs, &n);\n    fwp_map_owner owner = {{a, 0, 0, {ops}}}; fwp_cleanup cleanup;\n    fwp_map_protect(&owner, &cleanup);\n    V *b = fwp_map_items(ys, &m);\n    fwp_cleanup scratch_cleanup; fwp_scratch_protect(&b, &scratch_cleanup);\n    size_t len = n < m ? n : m;\n    for (size_t i = 0; i < len; i++) {{\n        V args[] = {{{args}}};\n        fwp_args{g}(args, 0, {});\n        a[i] = fwp_owned_entry{g}(args);\n        owner.count++;\n    }}\n    fwp_scratch_finish(&b, &scratch_cleanup);\n    V result = fwp_map_finish_protected(&owner, &cleanup);\n            return result;\n}}\n", hof_sig(i, sym, *k), k + 2);
    }
    if sym == "fold-right" {
        let drop = fold_drop.expect("typed right-fold accumulator");
        let args = (0..*k)
            .map(|j| format!("c{j}"))
            .chain(["a[i - 1]".to_string(), "z".to_string()])
            .collect::<Vec<_>>()
            .join(", ");
        let (prepare, entry) = if borrowed_step {
            (String::new(), format!("fwp_borrowed_fold{i}(args)"))
        } else {
            (
                format!("        fwp_args{g}(args, 0, {});\n", k + 1),
                format!("fwp_owned_entry{g}(args)"),
            )
        };
        return format!("{} {{\n    fwp_value_owner owner = {{z, {drop}}}; fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup);\n    size_t n;\n    V *a = fwp_map_items(xs, &n);\n    fwp_cleanup scratch_cleanup; fwp_scratch_protect(&a, &scratch_cleanup);\n    for (size_t i = n; i > 0; i--) {{\n        V args[] = {{{args}}};\n{prepare}        owner.value = 0;\n        z = {entry};\n        owner.value = z;\n    }}\n    fwp_scratch_finish(&a, &scratch_cleanup);\n        return fwp_value_finish(&owner, &cleanup);\n}}\n", hof_sig(i, sym, *k));
    }
    unreachable!("unsupported specialized primitive: {sym}")
}

/// The tail positions of an expression: what it can evaluate to last.
fn tails<'e>(e: &'e Expr, out: &mut Vec<&'e Expr>) {
    match e {
        Expr::Let(_, _, body)
        | Expr::Trace(_, body)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body)
        | Expr::ResourceRegion { body, .. } => tails(body, out),
        Expr::Match(_, arms) => {
            for (_, b) in arms {
                tails(b, out);
            }
        }
        _ => out.push(e),
    }
}

fn tail_calls(e: &Expr) -> std::collections::HashSet<*const Expr> {
    fn gather(e: &Expr, out: &mut Vec<*const Expr>) {
        match e {
            Expr::ResourceRegion { .. } => {}
            Expr::Let(_, _, body)
            | Expr::Trace(_, body)
            | Expr::Dup(_, body)
            | Expr::Drop(_, body)
            | Expr::BorrowGlobal(_, _, body) => gather(body, out),
            Expr::Match(_, arms) => {
                for (_, body) in arms {
                    gather(body, out);
                }
            }
            Expr::Call(..) | Expr::Apply(..) => out.push(e as *const Expr),
            _ => {}
        }
    }
    let mut out = Vec::new();
    gather(e, &mut out);
    out.into_iter().collect()
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
        Expr::Trace(_, b)
        | Expr::Dup(_, b)
        | Expr::Drop(_, b)
        | Expr::BorrowGlobal(_, _, b)
        | Expr::ResourceRegion { body: b, .. } => state_by_fields(b),
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
        Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        } => Expr::ResourceRegion {
            parameters: parameters.clone(),
            bindings: bindings.clone(),
            body: Box::new(again_record(body)?),
        },
        Expr::Record(_) => Expr::Construct(0, vec![e.clone()]),
        Expr::Let(l, v, b) => Expr::Let(*l, v.clone(), Box::new(again_record(b)?)),
        // A preceding action or branch can choose the next record. Keep its
        // scrutinee and bindings in place, and expose each terminal record to
        // the loop instead of boxing the match result before Again.
        Expr::Match(value, arms) => Expr::Match(
            value.clone(),
            arms.iter()
                .map(|(pattern, body)| Some((pattern.clone(), again_record(body)?)))
                .collect::<Option<_>>()?,
        ),
        Expr::Dup(l, b) => Expr::Dup(*l, Box::new(again_record(b)?)),
        Expr::Drop(l, b) => Expr::Drop(*l, Box::new(again_record(b)?)),
        _ => return None,
    })
}

/// Give flat loop state fields their own ownership parameters before RC.
/// This is the same state layout already selected by loop_shape; it avoids
/// retaining a field merely to move it from the old state to the next state.
fn unpack_loop_state(prog: &Program, f: &Func) -> Option<Func> {
    let Body::Expr(body) = &f.body else {
        return None;
    };
    if f.arity != 1 {
        return None;
    }
    let fields = record_fields(&prog.shapes, &f.locals[0])?;
    if fields.is_empty()
        || fields
            .iter()
            .any(|(_, ty)| crate::resource::observable_type(&prog.funcs, &prog.shapes, ty))
    {
        return None;
    }
    let width = u32::try_from(fields.len()).ok()?;
    fn local(l: Local, width: u32) -> Option<Local> {
        (l > 0).then(|| l.checked_add(width - 1)).flatten()
    }
    fn pattern(p: &Pat, width: u32) -> Option<Pat> {
        Some(match p {
            Pat::Bind(l) => Pat::Bind(local(*l, width)?),
            Pat::Construct(tag, ps) => Pat::Construct(
                *tag,
                ps.iter()
                    .map(|p| pattern(p, width))
                    .collect::<Option<_>>()?,
            ),
            Pat::Record(ps) => Pat::Record(
                ps.iter()
                    .map(|p| pattern(p, width))
                    .collect::<Option<_>>()?,
            ),
            Pat::Wild | Pat::Lit(_) => p.clone(),
        })
    }
    fn rewrite(e: &Expr, width: u32) -> Option<Expr> {
        let one = |e: &Expr| rewrite(e, width);
        let many = |es: &[Expr]| es.iter().map(one).collect::<Option<Vec<_>>>();
        Some(match e {
            Expr::Trace(point, body) => Expr::Trace(point.clone(), Box::new(one(body)?)),
            Expr::Field(base, index) if matches!(&**base, Expr::Local(0)) => {
                if *index >= width {
                    return None;
                }
                Expr::Local(*index)
            }
            Expr::Local(l) => Expr::Local(local(*l, width)?),
            Expr::Const(_) | Expr::Func(_) => e.clone(),
            Expr::Call(id, xs) => Expr::Call(*id, many(xs)?),
            Expr::Apply(f, xs) => Expr::Apply(Box::new(one(f)?), many(xs)?),
            Expr::Construct(tag, xs) => Expr::Construct(*tag, many(xs)?),
            Expr::Record(xs) => Expr::Record(many(xs)?),
            Expr::Field(base, index) => Expr::Field(Box::new(one(base)?), *index),
            Expr::SetFields(base, fields) => Expr::SetFields(
                Box::new(one(base)?),
                fields
                    .iter()
                    .map(|(i, e)| Some((*i, one(e)?)))
                    .collect::<Option<_>>()?,
            ),
            Expr::Let(l, value, body) => Expr::Let(
                local(*l, width)?,
                Box::new(one(value)?),
                Box::new(one(body)?),
            ),
            Expr::Match(value, arms) => Expr::Match(
                Box::new(one(value)?),
                arms.iter()
                    .map(|(p, b)| Some((pattern(p, width)?, one(b)?)))
                    .collect::<Option<_>>()?,
            ),
            // Original resource frames retain their established representation.
            // This transformation runs on the source IR, before reference counts.
            Expr::ResourceRegion { .. }
            | Expr::Dup(..)
            | Expr::Drop(..)
            | Expr::BorrowGlobal(..) => return None,
        })
    }
    let body = rewrite(body, width)?;
    let result = f.ty.params(1).1.clone();
    let params: Vec<MT> = fields.iter().map(|(_, ty)| ty.clone()).collect();
    let ty = params
        .iter()
        .rev()
        .fold(result, |ret, p| MT::Fun(Box::new(p.clone()), Box::new(ret)));
    let mut locals = params;
    locals.extend(f.locals.iter().skip(1).cloned());
    Some(Func {
        name: f.name.clone(),
        arity: width,
        locals,
        ty,
        body: Body::Expr(body),
    })
}

/// An unchanged array owner keeps its data address valid throughout the loop.
/// Restrict this direct word load to F64; packed narrower and boxed wider
/// elements keep their existing representation-specific access paths.
fn invariant_f64_arrays(prog: &Program, e: &Expr, locals: &[MT], arity: usize) -> Vec<usize> {
    fn reads(prog: &Program, e: &Expr, local: Local) -> bool {
        match e {
            Expr::Call(id, args) => {
                (matches!(&prog.funcs[*id].body, Body::Prim(s) if s == "array.get")
                    && args.len() == 2
                    && matches!(args[1], Expr::Local(l) if l == local))
                    || args.iter().any(|e| reads(prog, e, local))
            }
            Expr::Apply(f, args) => {
                reads(prog, f, local) || args.iter().any(|e| reads(prog, e, local))
            }
            Expr::Record(xs) | Expr::Construct(_, xs) => xs.iter().any(|e| reads(prog, e, local)),
            Expr::Field(e, _)
            | Expr::Trace(_, e)
            | Expr::Dup(_, e)
            | Expr::Drop(_, e)
            | Expr::BorrowGlobal(_, _, e)
            | Expr::ResourceRegion { body: e, .. } => reads(prog, e, local),
            Expr::SetFields(e, fields) => {
                reads(prog, e, local) || fields.iter().any(|(_, e)| reads(prog, e, local))
            }
            Expr::Let(_, value, body) => reads(prog, value, local) || reads(prog, body, local),
            Expr::Match(value, arms) => {
                reads(prog, value, local) || arms.iter().any(|(_, e)| reads(prog, e, local))
            }
            Expr::Const(_) | Expr::Local(_) | Expr::Func(_) => false,
        }
    }
    let mut endings = Vec::new();
    tails(e, &mut endings);
    let again: Vec<_> = endings
        .into_iter()
        .filter_map(|e| match e {
            Expr::Construct(0, xs) => Some(xs),
            _ => None,
        })
        .collect();
    if again.is_empty() {
        return Vec::new();
    }
    (0..arity).filter(|&index| {
        matches!(&locals[index], MT::Con(name, args) if name == "std::Array"
            && matches!(args.as_slice(), [MT::Con(element, args)] if element == "std::F64" && args.is_empty()))
            && again.iter().all(|xs| matches!(xs.as_slice(), [Expr::Record(fields)]
                if matches!(fields.get(index), Some(Expr::Local(l)) if *l as usize == index)))
            && reads(prog, e, index as Local)
    }).collect()
}

fn loop_state_expr(e: &Expr) -> Expr {
    match e {
        Expr::Construct(0, xs) if xs.len() == 1 => {
            again_record(&xs[0]).unwrap_or_else(|| e.clone())
        }
        Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        } => Expr::ResourceRegion {
            parameters: parameters.clone(),
            bindings: bindings.clone(),
            body: Box::new(loop_state_expr(body)),
        },
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

    /// Prepare every next parameter before overwriting any current parameter.
    /// Count insertion already transfers/drops the language owners; retire reuse
    /// tokens before jumping so no cleanup node survives into another iteration.
    fn self_jump(&mut self, id: FuncId, args: &[Expr], tail: bool) -> bool {
        if id != self.me || !tail || !self.g.uncounted.self_tail.contains(&id) {
            return false;
        }
        let abi = self.g.abis[id].clone();
        let mut next = Vec::new();
        for (i, arg) in args.iter().enumerate() {
            if let Some(n) = abi.as_ref().and_then(|a| a.params[i]) {
                let fields = self.expr_fields(arg, n);
                for (k, field) in fields.into_iter().enumerate() {
                    let value = self.bind(field);
                    next.push((format!("l{i}_{k}"), value));
                }
            } else {
                let value = self.expr(arg);
                let value = self.bind(value);
                next.push((format!("l{i}"), value));
            }
        }
        self.tail_tokens(true);
        for (parameter, value) in next {
            self.line(&format!("{parameter} = {value};"));
        }
        self.line("goto fwp_self_again;");
        true
    }

    /// The arguments of a direct call of a function's worker, in
    /// evaluation order: a record passed field by field is not built.
    fn worker_args(&mut self, g: FuncId, abi: &Abi, args: &[Expr]) -> Vec<String> {
        let mut out = Vec::new();
        for (j, (a, p)) in args.iter().zip(&abi.params).enumerate() {
            match p {
                Some(n) if !crate::rc::consumes_arg(self.g.prog, g, j) => {
                    if self.unboxed(a) == Some(*n) {
                        out.extend(self.expr_fields(a, *n));
                    } else {
                        let value = self.expr(a);
                        let value = self.bind(value);
                        out.extend((0..*n).map(|k| format!("OBJ({value})->f[{k}]")));
                    }
                }
                Some(n) => out.extend(self.expr_fields(a, *n)),
                None => out.push(self.arg(g, j, a)),
            }
        }
        abi.args_decode_words(self.g.prog, g, out)
    }

    /// In a loop's step, a field of the state kept as its own fields: its
    /// first slot and its number of fields.
    fn state_field(&self, e: &Expr) -> Option<(usize, usize)> {
        let lg = self
            .in_loop
            .as_ref()
            .filter(|lg| lg.record && !lg.unpacked_parameters)?;
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
        fn fields(fg: &FnGen<'_, '_>, e: &Expr, known: &HashMap<Local, usize>) -> Option<usize> {
            if let Some((_, n)) = fg.state_field(e) {
                return Some(n);
            }
            match e {
                Expr::Trace(_, body)
                | Expr::Dup(_, body)
                | Expr::Drop(_, body)
                | Expr::BorrowGlobal(_, _, body)
                | Expr::ResourceRegion { body, .. } => fields(fg, body, known),
                Expr::Local(l) => known
                    .get(l)
                    .copied()
                    .or_else(|| fg.fields.get(l).map(Vec::len)),
                Expr::Let(l, value, body) => {
                    let mut known = known.clone();
                    if let Some(n) = fields(fg, value, &known) {
                        known.insert(*l, n);
                    } else {
                        known.remove(l);
                    }
                    fields(fg, body, &known)
                }
                Expr::Call(id, _) => fg.g.abis[*id].as_ref()?.ret,
                Expr::Record(xs) if (1..=MAX_UNBOXED).contains(&xs.len()) => Some(xs.len()),
                Expr::Match(_, arms) => {
                    let n = fields(fg, &arms.first()?.1, known)?;
                    arms.iter()
                        .all(|(_, body)| fields(fg, body, known) == Some(n))
                        .then_some(n)
                }
                _ => None,
            }
        }
        fields(self, e, &HashMap::new())
    }

    /// The `n` fields of the record `e`, as C expressions, building it
    /// only when it comes from elsewhere.
    fn expr_fields(&mut self, e: &Expr, n: usize) -> Vec<String> {
        if let Expr::Call(id, args) = e {
            if self.self_jump(*id, args, self.tail_calls.contains(&(e as *const Expr))) {
                return vec!["0".into(); n]; // Unreachable after the jump.
            }
        }
        if let Some((off, m)) = self.state_field(e).filter(|(_, m)| *m == n) {
            return (off..off + m).map(|k| format!("st[{}]", k)).collect();
        }
        match e {
            Expr::BorrowGlobal(local, global, body) => {
                self.bind_global(e, *local, *global);
                self.expr_fields(body, n)
            }
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
                self.line(&format!("fwp_wr{id} {t} = w{id}({});", xs.join(", ")));

                self.end_call(node);
                self.stack_args_finish(outer);
                abi.result_words(self.g.prog, *id, &t)
            }
            Expr::Let(x, v, b)
                if !self.resource_slots.contains_key(x)
                    && self.field_uses(b, *x, n, true)
                    && self.unboxed(v) == Some(n) =>
            {
                let fs = self.expr_fields(v, n);
                let names: Vec<String> = fs.into_iter().map(|f| self.bind(f)).collect();
                self.fields.insert(*x, names);
                self.expr_fields(b, n)
            }
            Expr::Let(l, v, b) => {
                let b = self.bind_local(*l, v, b);
                self.expr_fields(b, n)
            }
            Expr::Drop(l, b) if !self.fields.contains_key(l) => match self.reuse_token(*l, b) {
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
            },
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } => {
                let frame =
                    self.begin_resource_region(e as *const Expr, parameters, bindings, body);
                let values = self.expr_fields(body, n);
                let result = values.into_iter().map(|v| self.bind(v)).collect();
                self.end_resource_region(frame);
                result
            }
            Expr::Trace(_, body) => self.expr_fields(body, n),
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
                    let (known, body) = self.arm_start(scrut, pat, &before, body);
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
                {
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
                    // A last owner can give its fields to the worker without
                    // creating temporary aliases. Stack records have distinct
                    // child owners and must keep their existing conversion.
                    let moved = (tys.is_some() && self.stack_alias(e).is_none()).then(|| {
                        let moved = self.fresh();
                        self.line(&format!(
                            "int {moved} = fwp_rc_last({t}); /* move boxed fields */"
                        ));
                        self.line(&format!("if (!{moved}) {{"));
                        self.indent += 1;
                        moved
                    });
                    self.line(&retained);
                    if moved.is_some() {
                        self.indent -= 1;
                        self.line("}");
                    }
                    self.end_call(original);
                    let d = ty
                        .and_then(|t| self.typed_drop(&t))
                        .unwrap_or_else(|| "fwp_rc_drop".into());
                    if let Some(children) = self.stack_alias(e) {
                        self.stack_children_count(children, false);
                    } else if let Some(moved) = moved {
                        self.line(&format!(
                            "if ({moved}) fwp_rc_free_obj({t}); else {d}({t});"
                        ));
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

    fn lookup_value_type(&self, id: FuncId) -> Option<MT> {
        let function = &self.g.prog.funcs[id];
        if function.arity != 2 {
            return None;
        }
        match (&function.body, &function.locals[1]) {
            (Body::Prim(symbol), MT::Con(name, fields))
                if symbol == "array.get"
                    && name == "std::Array"
                    && fields.len() == 1
                    && scalar(&fields[0]).is_some() =>
            {
                Some(fields[0].clone())
            }
            (Body::Prim(symbol), MT::Con(name, fields))
                if symbol == "map.get" && name == "std::Map" && fields.len() == 2 =>
            {
                Some(fields[1].clone())
            }
            _ => None,
        }
    }

    /// A matched Option can expose a counted handle's payload as direct fields.
    /// Channels transfer the queued owner; task awaits duplicate the shared result.
    fn owned_option_type(&self, id: FuncId) -> Option<MT> {
        let function = &self.g.prog.funcs[id];
        let Body::Prim(symbol) = &function.body else {
            return None;
        };
        let (owner, container) = match symbol.as_str() {
            "channel.recv" if function.arity == 1 => (0, "std::Channel"),
            "channel.recv-for" if function.arity == 2 => (1, "std::Channel"),
            "task.await" if function.arity == 1 => (0, "std::Task"),
            _ => return None,
        };
        let MT::Con(result_name, result_fields) = self.ret_type(id) else {
            return None;
        };
        if result_name != "std::Option" || result_fields.len() != 1 {
            return None;
        }
        match &function.locals[owner] {
            MT::Con(name, fields)
                if name == container
                    && fields.len() == 1
                    && crate::ir::same_type(&self.g.prog.shapes, &fields[0], &result_fields[0]) =>
            {
                Some(fields[0].clone())
            }
            _ => None,
        }
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
                Expr::Drop(_, b) | Expr::Dup(_, b) | Expr::BorrowGlobal(_, _, b) => {
                    produces(fg, b, m, known)
                }
                Expr::Match(_, arms) => {
                    let mut fields = false;
                    for (_, b) in arms {
                        fields |= produces(fg, b, m, known)?;
                    }
                    Some(fields)
                }
                Expr::Construct(_, xs) => Some(!xs.is_empty()),
                Expr::Call(id, args)
                    if m == 1 && args.len() == 2 && fg.lookup_value_type(*id).is_some() =>
                {
                    Some(true)
                }
                Expr::Call(id, args)
                    if m == 1
                        && args.len() == fg.g.prog.funcs[*id].arity as usize
                        && fg.owned_option_type(*id).is_some() =>
                {
                    Some(true)
                }
                Expr::Call(id, _) if fg.g.abis[*id].as_ref().and_then(|a| a.vret) == Some(m) => {
                    Some(true)
                }
                Expr::Local(l) => known.get(l).copied(),
                _ => None,
            }
        }
        (produces(self, e, m, &HashMap::new())? && !matches!(e, Expr::Construct(..))).then_some(m)
    }

    /// Load a checked element, borrowing a proved loop-invariant data pointer
    /// when available. The original array remains the counted owner.
    fn load_array(
        &mut self,
        array: &Expr,
        values: &[String],
        found: &str,
        descriptor: &str,
    ) -> String {
        let cached = match array {
            Expr::Local(local) => self
                .in_loop
                .as_ref()
                .filter(|lg| lg.cached_arrays.contains(&(*local as usize)))
                .map(|_| *local),
            _ => None,
        };
        if let Some(local) = cached {
            let value = self.fresh();
            self.line(&format!("V {value} = 0; if ({found}) __builtin_memcpy(&{value}, array_data_{local} + (size_t){} * sizeof(V), sizeof(V));", values[0]));
            value
        } else {
            self.bind(format!(
                "{found} ? fwp_array_load({}, (size_t){}, {descriptor}) : 0",
                values[1], values[0]
            ))
        }
    }

    /// The tag and fields (C expressions) of `e`, a variant of type `ty`
    /// returned as a struct `fwp_u<m>`, without building it. The fields
    /// hold the references the value would.
    fn expr_variant(&mut self, e: &Expr, m: usize, ty: &MT) -> (String, Vec<String>) {
        if let Expr::Call(id, args) = e {
            if self.self_jump(*id, args, self.tail_calls.contains(&(e as *const Expr))) {
                return ("0".into(), vec!["0".into(); m]);
            }
        }
        let parts = |u: &str| -> (String, Vec<String>) {
            (
                format!("{}.tag", u),
                (0..m).map(|k| format!("{}.f[{}]", u, k)).collect(),
            )
        };
        match e {
            Expr::BorrowGlobal(local, global, body) => {
                self.bind_global(e, *local, *global);
                self.expr_variant(body, m, ty)
            }
            Expr::Construct(tag, xs) => {
                let mut fs = self.args(xs);
                fs.resize(m, "0".into());
                (format!("(V){}", tag), fs)
            }
            Expr::Local(l) if self.vlocals.contains_key(l) => {
                let u = self.vlocals[l].0.clone();
                parts(&u)
            }
            Expr::Call(id, args)
                if m == 1 && args.len() == 2 && self.lookup_value_type(*id).is_some() =>
            {
                let element = self.lookup_value_type(*id).unwrap();
                let values = self.args(args);
                let map_lookup = matches!(&self.g.prog.funcs[*id].body, Body::Prim(symbol) if symbol == "map.get");
                // A bounds-checked scalar array read cannot allocate or unwind.
                // Map comparisons and counted result duplication still can.
                let pending = if map_lookup {
                    self.begin_call(e as *const Expr)
                } else {
                    None
                };
                let (tag, value) = if map_lookup {
                    let key = self.g.prog.funcs[*id].locals[0].clone();
                    let descriptor = self.g.desc(&key);
                    let found = self.fresh();
                    let at = self.fresh();
                    self.line(&format!("int {found}; uint64_t {at} = fwp_map_find({}, {}, {descriptor}, &{found}, 2);", values[1], values[0]));
                    let value =
                        self.bind(format!("{found} ? MAP({})->d[2 * {at} + 1] : 0", values[1]));
                    (found, value)
                } else {
                    let descriptor = self.g.desc(&element);
                    let tag = self.bind(format!(
                        "(V)((int64_t){index} >= 0 && (uint64_t){index} < fwp_array_len({array}))",
                        index = values[0],
                        array = values[1]
                    ));
                    let value = self.load_array(&args[1], &values, &tag, &descriptor);
                    (tag, value)
                };
                if crate::rc::needs_rc(&self.g.prog.shapes, &element) {
                    let duplicate = self.g.value_dup(&element);
                    self.line(&format!("if ({tag}) {duplicate}({value});"));
                }

                self.end_call(pending);
                (tag, vec![value])
            }
            Expr::Call(id, args)
                if m == 1
                    && args.len() == self.g.prog.funcs[*id].arity as usize
                    && self.owned_option_type(*id).is_some() =>
            {
                let element = self.owned_option_type(*id).unwrap();
                let values = self.args(args);
                let pending = self.begin_call(e as *const Expr);
                let duplicate = if crate::rc::needs_rc(&self.g.prog.shapes, &element) {
                    self.g.value_dup(&element)
                } else {
                    "NULL"
                };
                let result = self.fresh();
                if matches!(&self.g.prog.funcs[*id].body, Body::Prim(symbol) if symbol == "task.await")
                {
                    self.line(&format!(
                        "fwp_option_result {result} = fwp_task_await_fields({}, {duplicate});",
                        values[0]
                    ));
                } else {
                    let (channel, deadline) = if values.len() == 2 {
                        (&values[1], format!("fwp_after({})", values[0]))
                    } else {
                        (&values[0], "0".into())
                    };
                    self.line(&format!("fwp_option_result {result} = fwp_chan_recv_owned({channel}, {deadline}, {duplicate}, FWP_CHANNEL_RESULT_FIELDS);"));
                }

                self.end_call(pending);
                (format!("{result}.tag"), vec![format!("{result}.value")])
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
                if self.resource_slots.contains_key(l) {
                    let b = self.bind_local(*l, v, b);
                    return self.expr_variant(b, m, ty);
                }
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
                let constructed = matches!(&**v, Expr::Construct(..))
                    && small_variant(self.g.prog, &local_ty) == Some(m);
                if (constructed || self.unboxed_variant(v, &local_ty) == Some(m))
                    && variant_uses(b, *l, true)
                {
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
            Expr::Drop(l, b) if !self.fields.contains_key(l) && !self.vlocals.contains_key(l) => {
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
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } => {
                let frame =
                    self.begin_resource_region(e as *const Expr, parameters, bindings, body);
                let (tag, fields) = self.expr_variant(body, m, ty);
                let tag = self.bind(tag);
                let fields = fields.into_iter().map(|v| self.bind(v)).collect();
                self.end_resource_region(frame);
                (tag, fields)
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
                    let (known, body) = self.arm_start(scrut, pat, &before, body);
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
                {
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
        if let Pat::Bind(l) = p {
            // A whole binder aliases the stack aggregate, including its typed
            // child owners. Its Dup must retain them before the scrutinee drops.
            if let Some(children) = self.stack_alias(scrut) {
                self.stack_children.insert(*l, children);
            } else {
                self.stack_children.remove(l);
            }
        }
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
        {
            self.line(&format!("fwp_vdup{}(&{});", k, c));
        }
        self.bind(format!("fwp_vbox{}({})", k, c))
    }

    /// Field reads and complete calls to workers with the matching record ABI
    /// can consume fields directly. Partial/dynamic calls still need a box.
    fn field_uses(&self, e: &Expr, l: Local, n: usize, returned: bool) -> bool {
        let reads = |e: &Expr| self.field_uses(e, l, n, false);
        match e {
            Expr::Trace(_, b)
            | Expr::Dup(_, b)
            | Expr::Drop(_, b)
            | Expr::BorrowGlobal(_, _, b)
            | Expr::ResourceRegion { body: b, .. } => self.field_uses(b, l, n, returned),
            Expr::Local(x) => *x != l || returned,
            Expr::Field(r, _) if matches!(**r, Expr::Local(x) if x == l) => true,
            Expr::Const(_) | Expr::Func(_) => true,
            Expr::Call(id, args) => {
                let abi = self.g.abis[*id]
                    .as_ref()
                    .filter(|a| a.params.len() == args.len());
                args.iter().enumerate().all(|(i, a)| {
                    (is_local_through_counts(a, l) && abi.is_some_and(|a| a.params[i] == Some(n)))
                        || reads(a)
                })
            }
            Expr::Construct(0, args)
                if self
                    .in_loop
                    .as_ref()
                    .is_some_and(|lg| lg.record && lg.tails.contains(&(e as *const Expr))) =>
            {
                let lg = self.in_loop.as_ref().unwrap();
                match args.as_slice() {
                    [Expr::Record(fs)] => fs.iter().enumerate().all(|(i, value)| {
                        (matches!(value, Expr::Local(x) if *x == l) && lg.slots[i].1 == Some(n))
                            || reads(value)
                    }),
                    _ => args.iter().all(reads),
                }
            }
            Expr::Construct(_, args) | Expr::Record(args) => args.iter().all(reads),
            Expr::Apply(f, args) => reads(f) && args.iter().all(reads),
            Expr::Field(r, _) => reads(r),
            Expr::SetFields(r, fs) => reads(r) && fs.iter().all(|(_, e)| reads(e)),
            Expr::Let(x, v, b) if is_local_through_counts(v, l) => {
                *x != l
                    && small_record(self.g.prog, &self.locals[*x as usize]) == Some(n)
                    && self.field_uses(b, l, n, returned)
                    && self.field_uses(b, *x, n, returned)
            }
            Expr::Let(_, v, b) => reads(v) && self.field_uses(b, l, n, returned),
            Expr::Match(s, arms) => {
                reads(s) && arms.iter().all(|(_, b)| self.field_uses(b, l, n, returned))
            }
        }
    }

    /// Only replace a boxed frame holder when its local can stay unboxed.
    /// Otherwise retain the parent once, rather than adding counts per field.
    fn resource_field_binding(&self, e: &Expr, local: Local, n: usize) -> bool {
        let eligible = |e: &Expr| self.resource_field_binding(e, local, n);
        match e {
            Expr::Let(l, value, body) if *l == local => {
                self.unboxed(value) == Some(n) && self.field_uses(body, local, n, false)
            }
            Expr::Let(_, value, body) => eligible(value) || eligible(body),
            Expr::Trace(_, body)
            | Expr::Dup(_, body)
            | Expr::Drop(_, body)
            | Expr::BorrowGlobal(_, _, body)
            | Expr::Field(body, _)
            | Expr::ResourceRegion { body, .. } => eligible(body),
            Expr::Match(value, arms) => {
                eligible(value) || arms.iter().any(|(_, body)| eligible(body))
            }
            Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
                args.iter().any(eligible)
            }
            Expr::Apply(value, args) => eligible(value) || args.iter().any(eligible),
            Expr::SetFields(value, fields) => {
                eligible(value) || fields.iter().any(|(_, value)| eligible(value))
            }
            Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => false,
        }
    }

    // Original frame holders can own a direct constructor's tag and fields.
    // The general variant heuristic prefers other representations for these.
    fn resource_variant_value(&self, e: &Expr, ty: &MT) -> Option<usize> {
        if variant_returns_enabled() && matches!(e, Expr::Construct(_, xs) if !xs.is_empty()) {
            small_variant(self.g.prog, ty)
        } else {
            self.unboxed_variant(e, ty)
        }
    }

    fn resource_variant_binding(&self, e: &Expr, local: Local, ty: &MT) -> Option<usize> {
        if let Expr::Let(l, value, body) = e {
            if *l == local {
                return only_matched(body, local)
                    .then(|| self.resource_variant_value(value, ty))
                    .flatten();
            }
        }
        let mut found = None;
        // The same traversal used by field eligibility, without assuming a tag.
        fn visit(fg: &FnGen<'_, '_>, e: &Expr, l: Local, ty: &MT, found: &mut Option<usize>) {
            if found.is_some() {
                return;
            }
            match e {
                Expr::Let(x, value, body) if *x == l => {
                    if only_matched(body, l) {
                        *found = fg.resource_variant_value(value, ty);
                    }
                }
                Expr::Let(_, value, body) => {
                    visit(fg, value, l, ty, found);
                    visit(fg, body, l, ty, found);
                }
                Expr::Trace(_, body)
                | Expr::Dup(_, body)
                | Expr::Drop(_, body)
                | Expr::BorrowGlobal(_, _, body)
                | Expr::Field(body, _)
                | Expr::ResourceRegion { body, .. } => visit(fg, body, l, ty, found),
                Expr::Match(value, arms) => {
                    visit(fg, value, l, ty, found);
                    for (_, body) in arms {
                        visit(fg, body, l, ty, found);
                    }
                }
                Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
                    for arg in args {
                        visit(fg, arg, l, ty, found);
                    }
                }
                Expr::Apply(value, args) => {
                    visit(fg, value, l, ty, found);
                    for arg in args {
                        visit(fg, arg, l, ty, found);
                    }
                }
                Expr::SetFields(value, fields) => {
                    visit(fg, value, l, ty, found);
                    for (_, value) in fields {
                        visit(fg, value, l, ty, found);
                    }
                }
                Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
            }
        }
        visit(self, e, local, ty, &mut found);
        found
    }

    /// Original frame references are independent of ordinary last-use owners.
    fn begin_resource_region(
        &mut self,
        key: *const Expr,
        parameters: &[Local],
        bindings: &[Local],
        body: &Expr,
    ) -> (HashMap<Local, ResourceSlot>, String, String, usize) {
        let saved = self.resource_slots.clone();
        let mut entries = Vec::new();
        let mut initial = Vec::new();
        let mut variants = Vec::new();
        for &l in parameters {
            let ty = self.locals[l as usize].clone();
            let parts: Vec<(String, MT)> = if let Some(fs) = self.fields.get(&l) {
                fs.iter()
                    .cloned()
                    .zip(
                        record_fields(&self.g.prog.shapes, &ty)
                            .unwrap()
                            .iter()
                            .map(|(_, t)| t.clone()),
                    )
                    .collect()
            } else if let Some(lg) = self
                .in_loop
                .as_ref()
                .filter(|lg| lg.record && !lg.unpacked_parameters && l == 0)
            {
                let mut parts = Vec::new();
                for ((off, width), (_, t)) in lg
                    .slots
                    .iter()
                    .zip(record_fields(&self.g.prog.shapes, &ty).unwrap())
                {
                    if width.is_some() {
                        for (i, (_, ft)) in record_fields(&self.g.prog.shapes, t)
                            .unwrap()
                            .iter()
                            .enumerate()
                        {
                            parts.push((format!("st[{}]", off + i), ft.clone()));
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
                if crate::rc::needs_rc(&self.g.prog.shapes, &ty) {
                    initial.push((entries.len(), value));
                    entries.push(("0".into(), ty));
                }
            }
        }
        let ctx = self.fresh();
        let node = self.fresh();
        for &l in bindings {
            let ty = self.locals[l as usize].clone();
            let holder = if let Some(m) = resource_frame_fields_enabled()
                .then(|| self.resource_variant_binding(body, l, &ty))
                .flatten()
            {
                let index = variants.len();
                variants.push((m, ty.clone()));
                ResourceSlot::Variant(format!("{ctx}.u{index}"), m)
            } else if let Some(fields) = record_fields(&self.g.prog.shapes, &ty).filter(|fields| {
                resource_frame_fields_enabled()
                    && (1..=MAX_UNBOXED).contains(&fields.len())
                    && self.resource_field_binding(body, l, fields.len())
            }) {
                ResourceSlot::Fields(
                    fields
                        .iter()
                        .map(|(_, field)| {
                            if crate::rc::needs_rc(&self.g.prog.shapes, field) {
                                let slot = entries.len();
                                entries.push(("0".into(), field.clone()));
                                Some(format!("{ctx}.v{slot}"))
                            } else {
                                None
                            }
                        })
                        .collect(),
                )
            } else {
                let slot = entries.len();
                entries.push(("0".into(), ty));
                ResourceSlot::Value(format!("{ctx}.v{slot}"))
            };
            self.resource_slots.insert(l, holder);
        }
        let original = self.begin_call(key);
        let (protection, id) = self
            .g
            .protect_frame_values(&entries, &variants, &ctx, &node);
        assert!(!protection.is_empty(), "empty original resource region");
        self.line(&protection);
        // Incoming owners stay protected while retaining frame references.
        for (slot, value) in initial {
            let dup = self.g.value_dup(&entries[slot].1);
            self.line(&format!("{dup}({value}); {ctx}.v{slot} = {value};"));
        }
        // Pop the input scope below the frame scope in LIFO order, then re-arm
        // the initialized frame. Retaining is complete; no operation can trap.
        self.line(&format!("fwp_cleanup_pop(&{node});"));
        self.end_call(original);
        self.line(&format!(
            "fwp_cleanup_push(&{node}, fwp_owner_release{id}, &{ctx});"
        ));
        (saved, ctx, node, id)
    }

    fn end_resource_region(
        &mut self,
        frame: (HashMap<Local, ResourceSlot>, String, String, usize),
    ) {
        let (saved, ctx, node, id) = frame;
        self.line(&format!("/* original resource frame */ fwp_cleanup_pop(&{node}); fwp_owner_release{id}(&{ctx});"));
        self.resource_slots = saved;
    }

    fn anchor_resource_binding(&mut self, l: Local, owned: bool) {
        let Some(slot) = self.resource_slots.get(&l).cloned() else {
            return;
        };
        let ty = self.locals[l as usize].clone();
        let original = if owned {
            self.begin_owners(&[(l, 1)])
        } else {
            None
        };
        match slot {
            ResourceSlot::Variant(slot, m) => {
                let value = self.vlocals.get(&l).unwrap().0.clone();
                let k = self.g.vhelper(&ty, m);
                self.line(&format!("/* original resource variant */ fwp_vdup{k}(&{value}); fwp_vdrop{k}(&{slot}); {slot} = {value};"));
            }
            ResourceSlot::Value(slot) => {
                let dup = self.g.value_dup(&ty);
                let drop = self.g.value_drop(&ty);
                self.line(&format!("{dup}(l{l}); {drop}({slot}); {slot} = l{l};"));
            }
            ResourceSlot::Fields(slots) => {
                let fields = record_fields(&self.g.prog.shapes, &ty).unwrap().to_vec();
                let values = self.fields.get(&l).cloned().unwrap_or_else(|| {
                    (0..fields.len())
                        .map(|i| format!("OBJ(l{l})->f[{i}]"))
                        .collect()
                });
                for ((slot, value), (_, ty)) in slots.into_iter().zip(values).zip(fields) {
                    if let Some(slot) = slot {
                        let dup = self.g.value_dup(&ty);
                        let drop = self.g.value_drop(&ty);
                        self.line(&format!(
                            "/* original resource field */ {dup}({value}); {drop}({slot}); {slot} = {value};"
                        ));
                    }
                }
            }
        }
        self.end_call(original);
    }

    fn bind_unique_array(&mut self, local: Local, value: &Expr, body: &Expr) -> bool {
        if self.in_loop.is_some()
            || self.locals[local as usize]
                != MT::Con("std::Array".into(), vec![MT::con("std::I64")])
        {
            return false;
        }
        let Expr::Call(id, arguments) = value else {
            return false;
        };
        if !matches!(&self.g.prog.funcs[*id].body, Body::Prim(symbol) if symbol == "array.generate")
        {
            return false;
        }
        let [count, Expr::Func(callback)] = arguments.as_slice() else {
            return false;
        };
        if !self.array_callback(*callback, 0)
            || !crate::rc::unique::local_lifetime(self.g.prog, &self.g.noesc, body, local)
        {
            return false;
        }
        let count = self.expr(count);
        let count = self.bind(count);
        let pending = self.begin_call(value as *const Expr);
        let array = self.bind(format!("fwp_unique_i64_array_new({count})"));
        let cleanup = self.fresh();
        if self.g.unwind {
            self.line(&format!("fwp_cleanup {cleanup}; fwp_cleanup_push(&{cleanup}, fwp_unique_array_cleanup, &{array});"));
        }
        let index = self.fresh();
        self.g.used_closures[*callback] = true;
        self.line("/* proved unique I64 array: no reference-count metadata */");
        self.line(&format!(
            "for (size_t {index} = 0; {index} < ARR({array})->len; {index}++) {{"
        ));
        self.indent += 1;
        self.line(&format!(
            "ARR({array})->d[{index}] = fwp_owned_entry{callback}((V[]){{(V){index}}});"
        ));
        self.indent -= 1;
        self.line("}");
        if self.g.unwind {
            self.line(&format!("fwp_cleanup_pop(&{cleanup});"));
        }
        self.line(&format!("l{local} = {array};"));
        self.end_call(pending);
        self.unique_arrays.insert(local);
        true
    }

    fn bind_local<'e>(&mut self, l: Local, v: &Expr, body: &'e Expr) -> &'e Expr {
        if self.resource_slots.contains_key(&l) {
            if let Some(ResourceSlot::Variant(_, m)) = self.resource_slots.get(&l).cloned() {
                let ty = self.locals[l as usize].clone();
                let (tag, fields) = self.expr_variant(v, m, &ty);
                let u = self.fresh();
                self.line(&format!(
                    "fwp_u{m} {u} = {{{tag}, {{{}}}}};",
                    fields.join(", ")
                ));
                self.vlocals.insert(l, (u, m, ty));
                self.anchor_resource_binding(l, !matches!(v, Expr::Field(..)));
                return body;
            }
            if let Some(ResourceSlot::Fields(slots)) = self.resource_slots.get(&l) {
                let n = slots.len();
                if self.unboxed(v) == Some(n) && self.field_uses(body, l, n, false) {
                    let values = self.expr_fields(v, n);
                    let names = values.into_iter().map(|value| self.bind(value)).collect();
                    self.fields.insert(l, names);
                    self.anchor_resource_binding(l, !matches!(v, Expr::Field(..)));
                    return body;
                }
            }
            let value = self.expr(v);
            self.line(&format!("l{l} = {value};"));
            self.anchor_resource_binding(l, !matches!(v, Expr::Field(..)));
            return body;
        }
        if self.bind_unique_array(l, v, body) {
            return body;
        }
        if let Some((g, n)) = self.callback_origin(v) {
            self.known_callbacks.insert(l, (g, n));
        } else {
            self.known_callbacks.remove(&l);
        }
        // The RC pass describes a projection as retaining the selected field
        // and then releasing the record. When the record is already separate
        // owned fields, transfer that field and release only its siblings.
        // Original resource frames retain their existing lifetime accounting.
        {
            if let (Expr::Field(base, index), Expr::Dup(selected, after_dup)) = (v, body) {
                if let (Expr::Local(parent), Expr::Drop(dropped, rest)) = (&**base, &**after_dup) {
                    if *selected == l
                        && parent == dropped
                        && !self.resource_slots.contains_key(parent)
                    {
                        if let Some(values) = self.fields.get(parent).cloned() {
                            let types =
                                record_fields(&self.g.prog.shapes, &self.locals[*parent as usize])
                                    .expect("flattened record fields have known types")
                                    .to_vec();
                            self.line(&format!(
                                "/* move owned field */ l{l} = {};",
                                values[*index as usize]
                            ));
                            for (i, (value, (_, ty))) in values.iter().zip(&types).enumerate() {
                                if i != *index as usize {
                                    if let Some(drop) = self.typed_drop(ty) {
                                        self.line(&format!("{drop}({value});"));
                                    }
                                }
                            }
                            return rest;
                        }
                        // A stack record with one numeric-array owner can move
                        // that owner as well. Arrays have heap handles; unlike
                        // nested stack aggregates, their child list contains
                        // exactly the reference being projected. Scalar siblings
                        // have no cleanup, and the RC pattern consumes the record.
                        if let Some(children) = self.stack_children.get(parent).cloned() {
                            let fields =
                                record_fields(&self.g.prog.shapes, &self.locals[*parent as usize]);
                            if let (Some(fields), [(value, ty)]) = (fields, children.as_slice()) {
                                let numeric_array = matches!(ty, MT::Con(name, elements)
                                    if name == "std::Array" && elements.len() == 1
                                        && scalar(&elements[0]).is_some());
                                if numeric_array
                                    && fields[*index as usize].1 == *ty
                                    && fields.iter().enumerate().all(|(i, (_, field))| {
                                        crate::rc::needs_rc(&self.g.prog.shapes, field)
                                            == (i == *index as usize)
                                    })
                                {
                                    self.line(&format!(
                                        "/* move stack array owner */ l{l} = {value};"
                                    ));
                                    return rest;
                                }
                            }
                        }
                        // A boxed record with just one counted field can give
                        // that field to its last owner without a temporary
                        // retain/drop pair. Scalar siblings have no destructor.
                        // Keep stack aliases, resource frames and prospective
                        // storage reuse on their existing paths.
                        let ty = self.locals[*parent as usize].clone();
                        if !self.stack_children.contains_key(parent)
                            && !self.vlocals.contains_key(parent)
                            && !(*parent == 0
                                && self.in_loop.as_ref().is_some_and(|state| {
                                    state.record && !state.unpacked_parameters
                                }))
                        {
                            if let Some(types) = record_fields(&self.g.prog.shapes, &ty) {
                                if types.iter().enumerate().all(|(i, (_, field))| {
                                    crate::rc::needs_rc(&self.g.prog.shapes, field)
                                        == (i == *index as usize)
                                }) && !matches!(&types[*index as usize].1, MT::Con(n, _) if n == "?")
                                    && !allocates(rest, types.len())
                                {
                                    self.line(&format!("l{l} = OBJ(l{parent})->f[{index}];"));
                                    self.line(&format!("if (fwp_rc_last(l{parent})) {{ /* move sole boxed owner */"));
                                    self.line(&format!("    fwp_rc_free_obj(l{parent});"));
                                    self.line("} else {");
                                    self.indent += 1;
                                    self.count(body, l);
                                    self.count(after_dup, *parent);
                                    self.indent -= 1;
                                    self.line("}");
                                    return rest;
                                }
                            }
                        }
                    }
                }
            }
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
            if (!matches!(v, Expr::Record(_)) || self.in_loop.is_some())
                && self.field_uses(body, l, n, false)
            {
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
                if x == *d && !self.fields.contains_key(&x) && !self.stack_children.contains_key(&x)
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
            && crate::escape::stack_enabled()
            && !crate::escape::escapes(body, l, &self.g.noesc, Some(self.me))
        {
            let types = self.stack_types(v, &self.locals[l as usize]);
            if let Expr::Apply(function, captures) = v {
                if let Expr::Func(id) = **function {
                    if self.only_direct_callback_uses(body, l, id, captures.len()) {
                        // Evaluate and save captures at the original binding,
                        // before any later count expression or side effect.
                        let outer = std::mem::take(&mut self.stack_args);
                        let values = self.args(captures);
                        let values: Vec<_> = values.into_iter().map(|v| self.bind(v)).collect();
                        self.stack_arg_children(&values, types.as_ref().unwrap());
                        let children = std::mem::replace(&mut self.stack_args, outer);
                        self.stack_children.insert(l, children);
                        self.callback_captures.insert(l, values);
                        self.line("/* direct callback captures without a closure */");
                        return body;
                    }
                }
            }
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
        if self.state_field(v).is_some() {
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
        if crate::rc::borrows_record_argument(self.g.prog, g, j, a) {
            // RC lowering keeps every field owner alive through this call.
            // The stack view owns no child reference and needs no child drop.
            return self.stack_object(a, None);
        }
        if let Some(children) = self.stack_alias(a) {
            let value = self.expr(a);
            if crate::rc::consumes_arg(self.g.prog, g, j) {
                self.stack_args.extend(children);
            }
            return value;
        }
        if self.stackable(a)
            && g != self.me
            && crate::escape::stack_enabled()
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

    /// Whether `v` builds an object that can live on the stack: a record
    /// or variant with fields, or a closure (a known function applied to
    /// fewer arguments than it takes).
    fn stackable(&self, v: &Expr) -> bool {
        // An object in this frame must not become next-iteration state. Direct
        // record/variant fields are still selected independently of stack boxes.
        if self.g.uncounted.self_tail.contains(&self.me) {
            return false;
        }
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
            Expr::Trace(_, b)
            | Expr::Dup(_, b)
            | Expr::Drop(_, b)
            | Expr::Let(_, _, b)
            | Expr::BorrowGlobal(_, _, b) => self.stack_alias(b),
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
        {
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
            self.line("/* stack argument child */");
            let release = self.typed_drop(&ty).unwrap_or_else(|| "fwp_rc_drop".into());
            self.line(&format!("{release}({value});"));
        }
    }

    /// Values handed to the runtime become shared (it may keep them).
    fn share<'s>(&mut self, vs: impl IntoIterator<Item = &'s String>) {
        {
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
    fn arm_start<'e>(
        &mut self,
        scrut: &Expr,
        pat: &Pat,
        before: &[bool],
        body: &'e Expr,
    ) -> (Option<Local>, &'e Expr) {
        for (t, u) in self.tokens.iter_mut().zip(before) {
            t.used = *u;
        }
        let known = match (scrut, pat) {
            (Expr::Local(x), Pat::Construct(tag, _)) => {
                self.known_tag.insert(*x, *tag);
                Some(*x)
            }
            _ => None,
        };
        // An unboxed variant already owns its single payload. When the RC
        // sequence retains that field and immediately drops the variant,
        // transfer its owner instead. No operation or other child intervenes.
        // Keep the original nodes: later unwind plans use their addresses.
        let (Expr::Local(parent), Pat::Construct(_, fields), Expr::Dup(kept, after_dup)) =
            (scrut, pat, body)
        else {
            return (known, body);
        };
        let [Pat::Bind(field)] = fields.as_slice() else {
            return (known, body);
        };
        if kept == field
            && parent != field
            && self.vlocals.contains_key(parent)
            && !self.resource_slots.contains_key(parent)
            && !self.resource_slots.contains_key(field)
        {
            if let Expr::Drop(dropped, rest) = &**after_dup {
                if dropped == parent {
                    self.line("/* move matched variant payload */");
                    return (known, rest);
                }
            }
        }
        (known, body)
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
        let virtual_state = self
            .in_loop
            .as_ref()
            .is_some_and(|lg| lg.record && !lg.unpacked_parameters)
            && x == 0;
        if self.fields.contains_key(&x)
            || self.vlocals.contains_key(&x)
            || self.stack_children.contains_key(&x)
            || self.unique_arrays.contains(&x)
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
            let release = "fwp_rc_cleanup_cell";
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

    /// End the lexical lifetime even on a branch that never used the cell.
    fn finish_token(&mut self) {
        let token = self.tokens.pop().expect("missing reuse token");
        if let Some((node, active)) = token.cleanup {
            self.line(&format!("if ({active}) fwp_cleanup_pop(&{node});"));
        }
        let release = "fwp_rc_cleanup_cell";
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
            let release = "fwp_rc_cleanup_cell";
            self.line(&format!("{release}(&{var});"));
        }
    }

    /// Rebuild a record or variant in its unique, correctly sized token cell;
    /// otherwise allocate it and release the unused token.
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
        self.line(&format!("if ({} == 1) {{", u));
        self.line(&format!("    OBJ({})->tag = {};", tok, tag));
        for (k, x) in xs.iter().enumerate() {
            self.line(&format!("    OBJ({})->f[{}] = {};", tok, k, x));
        }
        self.line(&format!("    {} = {};", r, tok));
        self.line(&format!("    {tok} = 0;"));
        self.line("} else {");
        let fresh = self.construct_alloc(key, args, xs, alloc);
        self.line(&format!("    {} = {};", r, fresh));
        let release = "fwp_rc_cleanup_cell";
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
        let cell = if self.g.unwind {
            let node = self.fresh();
            self.line(&format!(
                "fwp_cleanup {node}; fwp_cleanup_push(&{node}, fwp_rc_cleanup_cell, &{t});"
            ));
            Some(node)
        } else {
            None
        };
        {
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
        if self.unique_arrays.contains(&l) {
            assert!(
                matches!(e, Expr::Drop(..)),
                "unique array gained another owner"
            );
            self.line(&format!("fwp_mem_free((void *)(uintptr_t)l{l});"));
            return;
        }
        if let Some(children) = self.stack_children.get(&l).cloned() {
            self.stack_children_count(children, matches!(e, Expr::Dup(..)));
            return;
        }
        if let Some((u, m, t)) = self.vlocals.get(&l).cloned() {
            {
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
            self.g.value_dup(&self.locals[l as usize])
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
        } else if let Some(lg) = self
            .in_loop
            .as_ref()
            .filter(|lg| lg.record && !lg.unpacked_parameters && l == 0)
        {
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
        if !self.g.unwind {
            return None;
        }
        let mut members = Vec::new();
        let mut values = Vec::new();
        let mut releases = Vec::new();
        for &(l, count) in owners {
            if self.unique_arrays.contains(&l) {
                assert_eq!(count, 1, "unique array gained another cleanup owner");
                let field = format!("v{}", members.len());
                members.push(format!("V {field};"));
                values.push(format!("l{l}"));
                releases.push(format!("fwp_mem_free((void *)(uintptr_t)c->{field});"));
                continue;
            }
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
            } else if let Some(lg) = self
                .in_loop
                .as_ref()
                .filter(|lg| lg.record && !lg.unpacked_parameters && l == 0)
            {
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

    fn entry_tick(&mut self, arity: u32, borrowed_parameters: &[Local]) {
        if !self.g.ticks {
            return;
        }
        let owners: Vec<_> = (0..arity)
            .filter(|l| {
                !borrowed_parameters.contains(l)
                    && crate::rc::needs_rc(&self.g.prog.shapes, &self.locals[*l as usize])
            })
            .map(|l| (l, 1))
            .collect();
        let node = self.begin_owners(&owners);
        self.line("FWP_TICK();");
        self.end_call(node);
    }

    // Shared by boxed, record-field and variant-field result generation so a
    // borrowed cache does not force an otherwise direct result onto the heap.
    fn bind_global(&mut self, e: &Expr, local: Local, global: FuncId) {
        self.g.borrowed_globals.insert(global);
        let value = self.bind_call(e as *const Expr, format!("fwp_caf_borrow{global}()"));
        self.line(&format!("l{local} = {value};"));
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
        if matches!(t, MT::Con(n, _) if n == "?") {
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
            Expr::Trace(_, b)
            | Expr::Dup(_, b)
            | Expr::Drop(_, b)
            | Expr::BorrowGlobal(_, _, b)
            | Expr::ResourceRegion { body: b, .. } => self.callback_origin(b),
            _ => None,
        }
    }

    /// Match the exact callback convention implemented by owned_hof below.
    fn array_callback(&self, id: FuncId, captures: usize) -> bool {
        let function = &self.g.prog.funcs[id];
        function.arity as usize == captures + 1
            && scalar(function.ty.params(captures + 1).1).is_some()
            && (captures == 0
                || function.locals[..captures]
                    .iter()
                    .any(|ty| crate::rc::needs_rc(&self.g.prog.shapes, ty)))
    }

    /// Every value read must be a generator/fold's known callback argument.
    /// Escapes, aliases, dynamic calls and resource frames retain closure storage.
    fn only_direct_callback_uses(
        &self,
        e: &Expr,
        local: Local,
        function: FuncId,
        captures: usize,
    ) -> bool {
        let allowed = |e| self.only_direct_callback_uses(e, local, function, captures);
        match e {
            Expr::Local(l) => *l != local,
            Expr::Const(_) | Expr::Func(_) => true,
            Expr::Call(id, args) => {
                if let [count, Expr::Local(callback)] = args.as_slice() {
                    if *callback == local
                        && self.array_callback(function, captures)
                        && matches!(&self.g.prog.funcs[*id].body, Body::Prim(s) if s == "array.generate")
                    {
                        return allowed(count);
                    }
                }
                if let [Expr::Local(callback), initial, input] = args.as_slice() {
                    if *callback == local
                        && self.g.prog.funcs[function].arity as usize == captures + 2
                        && matches!(&self.g.prog.funcs[*id].body, Body::Prim(s) if matches!(s.as_str(), "fold" | "fold-right"))
                    {
                        return allowed(initial) && allowed(input);
                    }
                }
                args.iter().all(allowed)
            }
            Expr::Apply(f, args) => allowed(f) && args.iter().all(allowed),
            Expr::Record(args) | Expr::Construct(_, args) => args.iter().all(allowed),
            Expr::Field(value, _) => allowed(value),
            Expr::SetFields(value, fields) => {
                allowed(value) && fields.iter().all(|(_, e)| allowed(e))
            }
            Expr::Let(_, value, body) => allowed(value) && allowed(body),
            Expr::Match(value, arms) => allowed(value) && arms.iter().all(|(_, e)| allowed(e)),
            Expr::Trace(_, body)
            | Expr::Dup(_, body)
            | Expr::Drop(_, body)
            | Expr::BorrowGlobal(_, _, body) => allowed(body),
            Expr::ResourceRegion { .. } => false,
        }
    }

    fn owned_hof(&mut self, id: FuncId, args: &[Expr]) -> Option<String> {
        if let Some(call) = self.inline_sort_keys(id, args) {
            return Some(call);
        }
        if matches!(&self.g.prog.funcs[id].body, Body::Prim(s) if s == "array.generate") {
            let [count, callback] = args else { return None };
            let (g, captures) = self.callback_origin(callback)?;
            if !self.array_callback(g, captures) {
                return None;
            }
            if !matches!(callback, Expr::Func(_) | Expr::Local(_) | Expr::Apply(_, _)) {
                return None;
            }
            // array.generate evaluates its count before the callback. Bind it
            // before evaluating capture expressions, preserving effects/traps.
            let count_value = self.expr(count);
            let count_value = self.bind(count_value);
            let mut values = match callback {
                Expr::Func(_) => Vec::new(),
                Expr::Local(l) => match self.callback_captures.get(l) {
                    Some(values) => values.clone(),
                    None => (0..captures)
                        .map(|j| format!("CLO(l{l})->a[{j}]"))
                        .collect(),
                },
                Expr::Apply(_, values) => self.args(values),
                _ => unreachable!(),
            };
            let key = ("array.generate".to_string(), g, captures);
            let i = match self.g.hofs.iter().position(|h| *h == key) {
                Some(i) => i,
                None => {
                    self.g.hofs.push(key);
                    self.g.hofs.len() - 1
                }
            };
            values.push(count_value);
            return Some(format!("fwp_hof{i}({})", values.join(", ")));
        }
        if matches!(&self.g.prog.funcs[id].body, Body::Prim(s) if s == "list._map-strings") {
            let [Expr::Func(callback), source] = args else {
                return None;
            };
            let callback = *callback;
            self.g.used_closures[callback] = true;
            let xs = self.expr(source);
            let ops = self.g.map_ops(&MT::con("std::String"));
            return Some(format!(
                "fwp_k_map_strings_owned(fwp_owned_entry{callback}, {xs}, {ops})"
            ));
        }
        let sym = match &self.g.prog.funcs[id].body {
            Body::Prim(s)
                if matches!(
                    s.as_str(),
                    "map"
                        | "array._map-list"
                        | "map._map-list"
                        | "map._map-range"
                        | "set._map-list"
                        | "set._map-range"
                        | "filter"
                        | "fold"
                        | "fold-right"
                        | "zip-with"
                        | "take-while"
                        | "drop-while"
                        | "find"
                        | "loop"
                        | "modify"
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
        if n == 0 || !matches!(sym.as_str(), "fold" | "fold-right") {
            self.g.used_closures[g] = true;
        }
        if matches!(
            sym.as_str(),
            "map._map-list" | "map._map-range" | "set._map-list" | "set._map-range"
        ) {
            let paired = sym.starts_with("map.");
            // Expression workers own their arguments and return the two
            // numeric fields directly. Primitive entry cleanup must not be
            // bypassed, and flattened record parameters need a separate proof.
            // Sets use the existing owned entry, including primitive cleanup.
            let abi = if paired {
                if !matches!(self.g.prog.funcs[g].body, Body::Expr(_)) {
                    return None;
                }
                Some(
                    self.g.abis[g]
                        .as_ref()
                        .filter(|abi| abi.ret == Some(2) && abi.params.iter().all(Option::is_none))?
                        .clone(),
                )
            } else {
                None
            };
            let result_type = self.g.prog.funcs[id].ty.params(args.len()).1.clone();
            let MT::Con(name, fields) = result_type else {
                return None;
            };
            if name != if paired { "std::Map" } else { "std::Set" }
                || fields.len() != if paired { 2 } else { 1 }
                || fields.iter().any(|t| scalar(t).is_none())
            {
                return None;
            }
            let descriptor = self.g.desc(&fields[0]);
            let captures = match &args[0] {
                Expr::Func(_) => Vec::new(),
                Expr::Local(l) => (0..n).map(|j| format!("CLO(l{l})->a[{j}]")).collect(),
                Expr::Apply(_, captures) => self.args(captures),
                _ => return None,
            };
            let source = self.args(&args[1..]);
            let (count, iterator, input) = if sym.ends_with("-range") {
                (
                    format!(
                        "(int64_t){} <= (int64_t){} ? 0 : (uint64_t){} - (uint64_t){}",
                        source[1], source[0], source[1], source[0]
                    ),
                    String::new(),
                    format!("V input = (uint64_t){} + (uint64_t)i;", source[0]),
                )
            } else {
                (
                    format!("fwp_list_len({})", source[0]),
                    format!("V xs = {};", source[0]),
                    "V input = OBJ(xs)->f[0]; xs = OBJ(xs)->f[1];".into(),
                )
            };
            let words = captures
                .iter()
                .cloned()
                .chain(["input".into()])
                .collect::<Vec<_>>();
            let prepare = format!(
                "V arguments[] = {{{}}}; fwp_args{g}(arguments, 0, {});",
                words.join(", "),
                words.len()
            );
            let (marker, callback) = if let Some(abi) = abi {
                let arguments = abi.args_decode_words(
                    self.g.prog,
                    g,
                    (0..words.len())
                        .map(|j| format!("arguments[{j}]"))
                        .collect(),
                );
                let values = abi.result_words(self.g.prog, g, "pair");
                ("numeric map: direct callback fields", format!("{prepare}\n            fwp_wr{g} pair = w{g}({});\n            keys[i] = {}; vals[i] = {};", arguments.join(", "), values[0], values[1]))
            } else {
                (
                    "numeric set: direct callback",
                    format!("{prepare}\n            keys[i] = fwp_owned_entry{g}(arguments);"),
                )
            };
            let result = self.fresh();
            self.line(&format!("V {result};\n{{ /* {marker} */"));
            self.line(&numeric_collection_body(
                &count,
                &iterator,
                &input,
                &callback,
                &descriptor,
                paired,
            ));
            self.line(&format!("{result} = result;\n}}"));
            return Some(result);
        }
        if sym == "array._map-list" {
            let result_type = self.g.prog.funcs[g].ty.params(n + 1).1.clone();
            scalar(&result_type)?;
            let descriptor = self.g.desc(&result_type);
            let captures = match &args[0] {
                Expr::Func(_) => Vec::new(),
                Expr::Local(l) => (0..n).map(|j| format!("CLO(l{l})->a[{j}]")).collect(),
                Expr::Apply(_, captures) => self.args(captures),
                _ => return None,
            };
            let xs = self.expr(&args[1]);
            let count = self.fresh();
            let items = self.fresh();
            let cleanup = self.fresh();
            let index = self.fresh();
            let arguments = self.fresh();
            let values = captures
                .iter()
                .cloned()
                .chain([format!("{items}[{index}]")])
                .collect::<Vec<_>>()
                .join(", ");
            self.line("/* numeric mapped array: direct callback */");
            self.line(&format!(
                "size_t {count}; V *{items} = fwp_map_items({xs}, &{count});"
            ));
            self.line(&format!(
                "fwp_cleanup {cleanup}; fwp_scratch_protect(&{items}, &{cleanup});"
            ));
            self.line(&format!(
                "for (size_t {index} = 0; {index} < {count}; {index}++) {{"
            ));
            self.line(&format!("    V {arguments}[] = {{{values}}};"));
            self.line(&format!("    fwp_args{g}({arguments}, 0, {});", n + 1));
            self.line(&format!(
                "    {items}[{index}] = fwp_owned_entry{g}({arguments});"
            ));
            self.line("}");
            let result = self.bind(format!("fwp_array_typed_new({count}, {descriptor})"));
            self.line(&format!("for (size_t {index} = 0; {index} < {count}; {index}++) fwp_array_store({result}, {index}, {items}[{index}], {descriptor});"));
            self.line(&format!("fwp_scratch_finish(&{items}, &{cleanup});"));
            return Some(result);
        }
        if sym == "modify" {
            let mut values = match &args[0] {
                Expr::Func(_) => Vec::new(),
                Expr::Local(l) => (0..n).map(|j| format!("CLO(l{l})->a[{j}]")).collect(),
                Expr::Apply(_, captures) => self.args(captures),
                _ => return None,
            };
            values.push("fwp_p_get()".into());
            let arguments = self.fresh();
            self.line(&format!("V {arguments}[] = {{{}}};", values.join(", ")));
            self.line(&format!("fwp_args{g}({arguments}, 0, {});", n + 1));
            let value = self.bind(format!("fwp_owned_entry{g}({arguments})"));
            let state = self.g.prog.funcs[g].ty.params(n + 1).1.clone();
            let duplicate = if crate::rc::needs_rc(&self.g.prog.shapes, &state) {
                self.g.value_dup(&state)
            } else {
                "NULL"
            };
            let drop = self.g.value_drop(&state);
            return Some(format!(
                "fwp_state_modify_result({value}, {duplicate}, {drop})"
            ));
        }
        if sym == "loop" && n == 0 {
            if let Some(Some(width)) = loop_shape(&self.g.prog.funcs[g]) {
                let flat = record_fields(&self.g.prog.shapes, &self.g.prog.funcs[g].locals[0])
                    .is_some_and(|fields| {
                        fields
                            .iter()
                            .all(|(_, ty)| record_fields(&self.g.prog.shapes, ty).is_none())
                    });
                if flat && self.unboxed(&args[1]) == Some(width) {
                    if !self.g.loops.iter().any(|(step, _)| *step == g) {
                        self.g.loops.push((g, Some(width)));
                    }
                    let fields = self.expr_fields(&args[1], width);
                    return Some(format!("fwp_loop_fields{g}({})", fields.join(", ")));
                }
            }
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
            Expr::Local(l) => match self.callback_captures.get(l) {
                Some(values) => values.clone(),
                None => (0..n).map(|j| format!("CLO(l{l})->a[{j}]")).collect(),
            },
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
        if self.self_jump(id, args, tail) {
            return "0".into();
        }
        if let Some(call) = self.owned_hof(id, args) {
            self.tail_tokens(tail);
            let result = self.bind_call(key, call);
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
                    self.line(&format!("fwp_wr{id} {t} = w{id}({});", xs.join(", ")));

                    self.end_call(node);
                    // a record compiled code owns, like any it builds
                    let values = abi.result_words(self.g.prog, id, &t);
                    let r = format!("fwp_record({}, {})", n, Self::array(&values));
                    let ty = self.ret_type(id);
                    let fields: Vec<_> = record_fields(&self.g.prog.shapes, &ty)
                        .expect("record ABI result")
                        .iter()
                        .enumerate()
                        .map(|(i, (_, ty))| (values[i].clone(), ty.clone()))
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
                    None => {
                        let call = format!("w{}({})", id, xs.join(", "));
                        let value = abi
                            .scalar_result(self.g.prog, id)
                            .map_or_else(|| call.clone(), |n| n.to_word(&call));
                        self.bind_call(key, value)
                    }
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
            let f = &self.g.prog.funcs[id];
            let (params, result_type) = f.ty.params(f.arity as usize);
            // These concrete primitive bodies only emit scalar arithmetic:
            // no allocation, language trap, callback or cancellation point.
            // Argument evaluation has already retained its own unwind scopes.
            let scalar_arithmetic = matches!(
                (&f.body, f.arity),
                (Body::Prim(sym), 2) if matches!(sym.as_str(), "prim.add" | "prim.sub" | "prim.mul")
            ) || matches!((&f.body, f.arity), (Body::Prim(sym), 1) if sym == "prim.neg");
            let scalar_wrapping = matches!(
                (&f.body, f.arity),
                (Body::Prim(sym), 2) if matches!(sym.as_str(), "wrapping.add" | "wrapping.sub" | "wrapping.mul")
            );
            // Wide integers can allocate their boxed result; checked integer
            // arithmetic can trap. Neither qualifies for this exemption.
            let cannot_unwind = ((scalar_arithmetic
                && matches!(scalar(result_type), Some(Scalar::F32 | Scalar::F64)))
                || (scalar_wrapping
                    && matches!(
                        scalar(result_type),
                        Some(Scalar::Signed(_) | Scalar::Unsigned(_))
                    )))
                && params.iter().all(|ty| *ty == result_type);
            let call = format!("f{}({})", id, xs.join(", "));
            if cannot_unwind {
                self.bind(call)
            } else {
                self.bind_call(key, call)
            }
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
            let virtual_record = record && !lg.unpacked_parameters;
            match e {
                Expr::Field(r, k) if virtual_record && self.state_field(r).is_some() => {
                    let (off, _) = self.state_field(r).unwrap();
                    return format!("st[{}]", off + *k as usize);
                }
                Expr::Field(r, i) if virtual_record && matches!(**r, Expr::Local(0)) => {
                    let (off, w) = lg.slots[*i as usize];
                    return match w {
                        None => format!("st[{}]", off),
                        // the record itself: built again from its fields
                        Some(m) => {
                            let fs: Vec<String> =
                                (off..off + m).map(|k| format!("st[{}]", k)).collect();
                            let original = self.begin_call(e as *const Expr);
                            let values = {
                                let state_fields =
                                    record_fields(&self.g.prog.shapes, &self.locals[0]).unwrap();
                                let inner = &state_fields[*i as usize].1;
                                let values = record_fields(&self.g.prog.shapes, inner)
                                    .unwrap()
                                    .iter()
                                    .enumerate()
                                    .map(|(j, (_, ty))| (fs[j].clone(), ty.clone()))
                                    .collect::<Vec<_>>();
                                let ctx = self.fresh();
                                let node = self.fresh();
                                let retain = self.g.duplicate_values(&values, &ctx, &node);
                                self.line(&retain);
                                values
                            };
                            let pending = self.begin_values(&values);
                            let r = format!("fwp_record({}, {})", m, Self::array(&fs));
                            let result = self.bind(self.g.fresh(r));
                            self.end_call(pending);
                            self.end_call(original);
                            result
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
            Expr::Drop(l, b) => match self.reuse_token(*l, b) {
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
            Expr::Trace(_, body) => self.expr(body),
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } => {
                let frame =
                    self.begin_resource_region(e as *const Expr, parameters, bindings, body);
                let value = self.expr(body);
                let result = self.bind(value);
                self.end_resource_region(frame);
                result
            }
            Expr::Dup(l, b) => {
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
            Expr::BorrowGlobal(local, global, body) => {
                self.bind_global(e, *local, *global);
                self.expr(body)
            }
            Expr::Call(id, args) => self.call_expr(
                *id,
                args,
                self.tail_calls.contains(&(e as *const Expr)),
                e as *const Expr,
            ),
            Expr::Apply(f, args) => {
                if let Some(function) = self.g.bare_function(f) {
                    if !args.is_empty() && args.len() < self.g.prog.funcs[function].arity as usize {
                        let captures: Option<Vec<_>> =
                            args.iter().map(|arg| self.g.bare_function(arg)).collect();
                        if let Some(captures) = captures {
                            // No supplied expression evaluates or owns runtime data.
                            return self.g.static_function(function, captures);
                        }
                    }
                }
                let children = self.stack_alias(f);
                let fv = self.expr(f);
                let xs = self.args(args);

                let apply = { "fwp_apply_owned" };
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
                // Keep the original IR nodes: loop tails and cleanup liveness
                // are keyed by their addresses. Lookup variants are emitted as
                // tag/payload locals by bind_local, without cloning match arms.
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
                    let (known, body) = self.arm_start(scrut, pat, &before, body);
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
        if args.len() != 2 {
            return None;
        }
        let array_element = match (&f.body, &f.locals[1]) {
            (Body::Prim(s), MT::Con(n, elements))
                if s == "array.get"
                    && n == "std::Array"
                    && elements.len() == 1
                    && scalar(&elements[0]).is_some() =>
            {
                Some(elements[0].clone())
            }
            _ => None,
        };
        if array_element.is_none() && !matches!(&f.body, Body::Prim(s) if s == "map.get") {
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
        let descriptor = array_element
            .clone()
            .unwrap_or_else(|| f.ty.params(2).0[0].clone());
        let kd = self.g.desc(&descriptor);
        let mut e = scrut;
        while let Expr::Let(l, v, b) = e {
            let x = self.expr(v);
            self.line(&format!("l{} = {};", l, x));
            e = b;
        }
        let xs = self.args(args);
        let (found, at) = (self.fresh(), self.fresh());
        let v = if array_element.is_some() {
            self.line(&format!("int {found} = (int64_t){index} >= 0 && (uint64_t){index} < fwp_array_len({array});", index=xs[0], array=xs[1]));
            self.load_array(&args[1], &xs, &found, &kd)
        } else {
            self.line(&format!(
                "int {found}; uint64_t {at} = fwp_map_find({}, {}, {kd}, &{found}, 2);",
                xs[1], xs[0]
            ));
            self.bind(format!("{found} ? MAP({})->d[2 * {at} + 1] : 0", xs[1]))
        };
        let value_type = array_element.or_else(|| match &f.locals[1] {
            MT::Con(name, fields) if name == "std::Map" && fields.len() == 2 => {
                Some(fields[1].clone())
            }
            _ => None,
        });
        let owned_value = value_type
            .as_ref()
            .is_some_and(|ty| crate::rc::needs_rc(&self.g.prog.shapes, ty));
        if owned_value {
            let dup = self.g.value_dup(value_type.as_ref().unwrap());
            self.line(&format!("if ({found}) {dup}({v});"));
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
            Pat::Bind(l) => {
                if let Some(ResourceSlot::Variant(_, m)) = self.resource_slots.get(l).cloned() {
                    // A binder can be a let in another arm. Initialize this
                    // path's borrowed payload rather than using that arm's C local.
                    let ty = self.locals[*l as usize].clone();
                    let u = self.fresh();
                    self.line(&format!("fwp_u{m} {u} = fwp_vunbox{m}({v});"));
                    self.vlocals.insert(*l, (u, m, ty));
                } else if let Some(ResourceSlot::Fields(slots)) = self.resource_slots.get(l) {
                    // Pattern fields borrow this path's scrutinee, just as the
                    // let path's fields borrow its own freshly bound locals.
                    let n = slots.len();
                    let fields = (0..n)
                        .map(|i| self.bind(format!("OBJ({v})->f[{i}]")))
                        .collect();
                    self.fields.insert(*l, fields);
                } else {
                    self.line(&format!("l{} = {};", l, v));
                }
                self.anchor_resource_binding(*l, false);
            }
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
                    Value::F16(x) => format!("fwp_f128_compare(f16_to_f128((float16_t){{(uint16_t){v}}}), f16_to_f128((float16_t){{{}U}})) == 0", x.to_bits()),
                    Value::BF16(x) => format!("fwp_f128_compare(fwp_bf16_to_f128((uint16_t){v}), fwp_bf16_to_f128({}U)) == 0", x.to_bits()),
                    Value::F128(x) => format!("fwp_f128_compare(fwp_f128({v}), (float128_t){{{{{}ULL, {}ULL}}}}) == 0", x.to_bits() as u64, (x.to_bits() >> 64) as u64),
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
        if sym == "grpc._force" {
            let cell_drop = self.value_drop(&p(0));
            return Ok(format!("return fwp_p_grpc_force(l0, {cell_drop});"));
        }
        if sym == "array.length" {
            return Ok("return (V)(int64_t)fwp_array_len(l0);".into());
        }
        if sym == "simd._splat-dot-f64" {
            if result != MT::con("std::F64")
                || params
                    != [
                        MT::con("std::U64"),
                        MT::con("std::F64"),
                        MT::con("std::F64"),
                    ]
            {
                return Err("direct splat dot requires a lane count and two F64 values".into());
            }
            return Ok("return fwp_p_simd_splat_dot_f64(l0, l2, l1);".into());
        }
        if sym == "simd._dot-f64" {
            if result != MT::con("std::F64")
                || params.len() != 2
                || params.iter().any(|t| vec_shape(t).1 != MT::con("std::F64"))
            {
                return Err("direct lane dot requires F64 vectors and result".into());
            }
            return Ok("return fwp_p_simd_dot_f64(l1, l0);".into());
        }
        if matches!(
            sym,
            "url.decode"
                | "form.decode"
                | "url.split"
                | "http.parse-request-head"
                | "http.parse-response-head"
        ) {
            let descriptor = self.desc(&result);
            let call = match sym {
                "url.decode" => format!("fwp_p_url_decode(l0, 0, {descriptor})"),
                "form.decode" => format!("fwp_p_url_decode(l0, 1, {descriptor})"),
                "url.split" => format!("fwp_p_url_split(l0, {descriptor})"),
                "http.parse-request-head" => format!("fwp_p_parse_request_head(l0, {descriptor})"),
                "http.parse-response-head" => {
                    format!("fwp_p_parse_response_head(l0, {descriptor})")
                }
                _ => unreachable!(),
            };
            return Ok(format!("return {call};"));
        }
        if matches!(
            sym,
            "zlib.gunzip" | "zlib.inflate" | "ws.parse" | "ws.close-parse" | "ws.inflate"
        ) {
            let descriptor = self.desc(&result);
            let call = match sym {
                "zlib.gunzip" => format!("fwp_p_zlib_gunzip(l0, l1, {descriptor})"),
                "zlib.inflate" => format!("fwp_p_zlib_inflate(l0, l1, {descriptor})"),
                "ws.parse" => format!("fwp_p_ws_parse(l0, l1, l2, {descriptor})"),
                "ws.close-parse" => format!("fwp_p_ws_close_parse(l0, {descriptor})"),
                "ws.inflate" => format!("fwp_p_ws_inflate(l0, l1, {descriptor})"),
                _ => unreachable!(),
            };
            return Ok(format!("return {call};"));
        }
        if matches!(sym, "http2.request" | "http2.body") {
            let descriptor = self.desc(&result);
            let call = if sym == "http2.request" {
                format!("fwp_p_http2_request(l0, {descriptor})")
            } else {
                format!("fwp_p_http2_body(l0, l1, l2, {descriptor})")
            };
            return Ok(format!("return {call};"));
        }
        if sym == "grpc.with-response-metadata" {
            let descriptor = self.desc(&result);
            return Ok(format!(
                "return fwp_p_grpc_with_response_metadata(l0, {descriptor});"
            ));
        }
        if matches!(sym, "grpc.metadata" | "grpc.peer-subject") {
            let descriptor = self.desc(&result);
            let function = if sym == "grpc.metadata" {
                "fwp_p_grpc_metadata"
            } else {
                "fwp_p_grpc_peer_subject"
            };
            return Ok(format!("return {function}({descriptor});"));
        }
        if sym == "metrics.snapshot" {
            let descriptor = self.desc(&result);
            return Ok(format!("return fwp_p_metrics_snapshot({descriptor});"));
        }
        if matches!(sym, "array._range" | "set._range") {
            let (container, helper) = if sym == "array._range" {
                ("std::Array", "fwp_p_array_range")
            } else {
                ("std::Set", "fwp_p_set_range")
            };
            let MT::Con(name, elements) = &result else {
                return Err("direct range result has no element type".into());
            };
            if name != container
                || elements.len() != 1
                || !matches!(
                    scalar(&elements[0]),
                    Some(Scalar::Signed(_)) | Some(Scalar::Unsigned(_))
                )
            {
                return Err("direct range requires an inline integer result".into());
            }
            let descriptor = self.desc(&elements[0]);
            return Ok(format!("return {helper}(l0, l1, {descriptor});"));
        }
        if matches!(
            sym,
            "map._map-list" | "set._map-list" | "map._map-range" | "set._map-range"
        ) {
            let MT::Con(name, fields) = &result else {
                return Err("numeric collection construction has no field types".into());
            };
            let paired = match (name.as_str(), fields.len()) {
                ("std::Map", 2) => true,
                ("std::Set", 1) => false,
                _ => return Err("numeric collection construction requires Map or Set".into()),
            };
            if fields.iter().any(|field| scalar(field).is_none()) {
                return Err("numeric collection construction requires inline fields".into());
            }
            let descriptor = self.desc(&fields[0]);
            let ranged = sym.ends_with("-range");
            let count = if ranged {
                "(int64_t)l2 <= (int64_t)l1 ? 0 : (uint64_t)l2 - (uint64_t)l1"
            } else {
                "fwp_list_len(l1)"
            };
            let iterator = if ranged { "" } else { "V xs = l1;" };
            let input = if ranged {
                "V input = (uint64_t)l1 + (uint64_t)i;"
            } else {
                "V input = OBJ(xs)->f[0]; xs = OBJ(xs)->f[1];"
            };
            let store = if paired {
                "keys[i] = OBJ(value)->f[0]; vals[i] = OBJ(value)->f[1]; fwp_rc_free_obj(value);"
            } else {
                "keys[i] = value;"
            };
            let callback = format!("V value = fwp_apply_borrowed(l0, 1, &input);\n        {store}");
            let body =
                numeric_collection_body(count, iterator, input, &callback, &descriptor, paired);
            return Ok(format!("{body}\n        return result;"));
        }

        if sym == "list._map-strings" {
            let ops = self.map_ops(&MT::con("std::String"));
            return Ok(format!("return fwp_p_map_strings_owned(l0, l1, {ops});"));
        }
        if sym == "array._map-list" {
            let MT::Con(name, elements) = &result else {
                return Err("numeric mapped array result has no element type".into());
            };
            if name != "std::Array" || elements.len() != 1 || scalar(&elements[0]).is_none() {
                return Err("mapped array construction requires an inline numeric result".into());
            }
            let descriptor = self.desc(&elements[0]);
            return Ok(format!(
                "return fwp_p_array_map_list(l0, l1, {descriptor});"
            ));
        }
        if matches!(sym, "ad.tape-owned" | "ad.push-owned") {
            let MT::Record(fields) = &params[0] else {
                return Err(format!("{sym} requires a scalar operation tuple"));
            };
            let index = usize::from(sym == "ad.push-owned");
            let descriptor = self.desc(&fields[index].1);
            return Ok(if sym == "ad.tape-owned" {
                format!("return fwp_p_ad_tape_owned(l0, l1, {descriptor});")
            } else {
                format!("return fwp_p_ad_push_owned(l0, {descriptor});")
            });
        }
        if sym == "ad.backward-owned" {
            let descriptor = self.desc(&result);
            return Ok(format!(
                "return fwp_p_ad_backward_owned(l0, l1, l2, {descriptor});"
            ));
        }
        if matches!(
            sym,
            "array.from-list"
                | "array.to-list"
                | "array.get"
                | "array.set"
                | "array.push"
                | "array.make"
                | "array.generate"
                | "array.map"
                | "array.fold"
                | "array.slice"
                | "array.append"
                | "array.sort"
        ) {
            let array = if matches!(
                sym,
                "array.from-list" | "array.make" | "array.generate" | "array.map"
            ) {
                &result
            } else {
                params.last().expect("array primitive input")
            };
            let MT::Con(_, types) = array else {
                return Err(format!("array primitive `{sym}` has no element type"));
            };
            let element = types
                .first()
                .ok_or_else(|| format!("array primitive `{sym}` has no element type"))?;
            let mut args: Vec<_> = (0..func.arity).map(|i| format!("l{i}")).collect();
            args.push(self.desc(element));
            if sym == "array.map" {
                let MT::Con(_, input) = &params[1] else {
                    return Err("array.map input has no element type".into());
                };
                args.push(self.desc(&input[0]));
            }
            return Ok(format!(
                "return fwp_p_{}_with_elem({});",
                sym.replace(['.', '-'], "_"),
                args.join(", ")
            ));
        }
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
            "mem.alloc" => "uint64_t count = (int64_t)l0 > 0 ? (uint64_t)l0 : 1;\n    if (count > SIZE_MAX) fwp_trap(\"raw allocation too large\");\n    size_t n = (size_t)count;\n    void *p = calloc(n, 1);\n    if (!p) fwp_trap(\"out of memory\");\n    return (V)(uintptr_t)p;".into(),
            "mem.free" => "free((void *)(uintptr_t)l0);\n    return FWP_UNIT;".into(),
            "mem.string" => "size_t n = STR(l0)->len;\n    if (n == SIZE_MAX) fwp_trap(\"raw allocation too large\");\n    char *p = (char *)calloc(n + 1, 1);\n    if (!p) fwp_trap(\"out of memory\");\n    memcpy(p, STR(l0)->d, n);\n    return (V)(uintptr_t)p;".into(),
            "ptr.cast" | "ptr.address" => "return l0;".into(),
            "ptr.at" => {
                let element = elem(&p(1), 0);
                let storage = match num_kind(&element).map(|(kind, _, _)| kind) {
                    Some("K_I128") => "i128".into(),
                    Some("K_U128") => "u128".into(),
                    _ => crate::ffi::c_name(&crate::ffi::classify_scalar(&element)),
                };
                format!(
                    "return (V)((uintptr_t)l1 + (uintptr_t)l0 * sizeof({}));",
                    storage
                )
            }
            "ptr.read" => match num_kind(&result).map(|(kind, _, _)| kind) {
                Some("K_I128") => "i128 x;\n    memcpy(&x, (void *)(uintptr_t)l0, sizeof x);\n    return fwp_box_i128(x);".into(),
                Some("K_U128") => "u128 x;\n    memcpy(&x, (void *)(uintptr_t)l0, sizeof x);\n    return fwp_box_u128(x);".into(),
                _ => {
                let t = crate::ffi::classify_scalar(&result);
                format!(
                    "{} x;\n    memcpy(&x, (void *)(uintptr_t)l0, sizeof x);\n    return {};",
                    crate::ffi::c_name(&t),
                    ffi_from_c(&t, "x")
                )
                }
            },
            "ptr.write" => match num_kind(&p(0)).map(|(kind, _, _)| kind) {
                Some("K_I128") => "i128 x = fwp_i128(l0);\n    memcpy((void *)(uintptr_t)l1, &x, sizeof x);\n    return FWP_UNIT;".into(),
                Some("K_U128") => "u128 x = fwp_u128(l0);\n    memcpy((void *)(uintptr_t)l1, &x, sizeof x);\n    return FWP_UNIT;".into(),
                _ => {
                let t = crate::ffi::classify_scalar(&p(0));
                format!(
                    "{} x = {};\n    memcpy((void *)(uintptr_t)l1, &x, sizeof x);\n    return FWP_UNIT;",
                    crate::ffi::c_name(&t),
                    ffi_to_c(&t, "l0")
                )
                }
            },
            "ptr.read-string" => "if (!l0) fwp_trap(\"reading a string at a null pointer\");\n    return fwp_c_string((const char *)(uintptr_t)l0);".into(),
            "trit.from-sign" => {
                "return (V)(int64_t)(((int64_t)l0 > 0) - ((int64_t)l0 < 0));".into()
            }
            "trit.to-int" | "tint.to-int" => "return l0;".into(),
            "tint.of-int" => format!("return fwp_p_tint_of_int(l0, {});", nk(&elem(&result, 0)).2),
            "tint.trits" => {
                let drop_list = self.value_drop(&result);
                format!("return fwp_p_tint_trits(l0, {}, {drop_list});", nk(&p(0)).2)
            },
            "tint.from-trits" => format!(
                "return fwp_p_tint_from_trits(l0, {});",
                nk(&elem(&result, 0)).2
            ),
            "trits.pack" => "return fwp_p_trits_pack(l0);".into(),
            "trits.unpack" => {
                let drop_list = self.value_drop(&result);
                format!("return fwp_p_trits_unpack(l0, l1, {drop_list});")
            },
            "env.vars" => {
                let drop_pair = self.value_drop(&elem(&result, 0));
                let drop_list = self.value_drop(&result);
                format!("return fwp_p_env_vars({drop_pair}, {drop_list});")
            }
            "dir.list" => {
                let error = self.desc(&MT::con("std::IoError"));
                let drop_list = self.value_drop(&result);
                format!("return fwp_p_dir_list(l0, {error}, {drop_list});")
            }
            "lines" | "read-lines" | "args" => {
                let drop_list = self.value_drop(&result);
                let call = match sym {
                    "lines" => format!("fwp_p_lines(l0, {drop_list})"),
                    "read-lines" => format!("fwp_p_read_lines({drop_list})"),
                    _ => format!("fwp_p_args({drop_list})"),
                };
                format!("return {call};")
            }
            "simd.splat" => format!("return fwp_p_simd_splat(l0, {}, {});", vec_shape(&result).0, self.desc(&vec_shape(&result).1)),
            "simd.from-array" => {
                let vector = elem(&result, 0);
                let lanes = vec_shape(&vector).0;
                let array_drop = self.value_drop(&p(0));
                let vector_drop = self.value_drop(&vector);
                format!("return fwp_p_simd_from_array(l0, {lanes}, {array_drop}, {vector_drop});")
            }
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
                    "return fwp_p_simd_op({}, {}, l1, l0, {}, {}, {});",
                    k,
                    op,
                    Self::cstr(&name),
                    w,
                    self.desc(&vec_shape(&p(0)).1)
                )
            }
            "simd.sum" => format!(
                "return fwp_p_simd_sum({}, l0, {}, {}, {});",
                rk,
                Self::cstr(&rname),
                rw,
                self.desc(&vec_shape(&p(0)).1)
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
                format!("return fwp_float_convert({}, {}, l0);", ks, rk)
            }
            "sqrt" | "exp" | "ln" | "sin" | "cos" | "tan" | "floor" | "ceil" | "round" | "asin" | "acos" | "atan" | "sinh" | "cosh" | "tanh" | "asinh" | "acosh" | "atanh" | "log2" | "log10" | "log1p" | "exp2" | "expm1" => {
                format!("return fwp_fmath({}, FM_{}, l0);", rk, sym.to_uppercase())
            }
            "atan2" | "hypot" => format!("return fwp_{sym}({rk}, l1, l0);"),
            "pow" => format!(
                "return fwp_pow({rk}, l1, l0);",
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
            "hash" => {
                let body = if std::env::var("FWP_TYPED_HASH").map_or(true, |v| v != "0") {
                    numeric_hash_body(&self.prog.shapes, &p(0), "l0", &mut Vec::new())
                } else {
                    None
                };
                match body {
                    Some(body) => format!("/* numeric hash without type dispatch */\nuint64_t hash_state = 0xcbf29ce484222325ULL;\n{body}return hash_state;"),
                    None => format!("return fwp_hash(l0, {});", self.desc(&p(0))),
                }
            }
            "not" => "return l0 == FWP_TRUE ? FWP_FALSE : FWP_TRUE;".into(),
            "and" => "return (l0 == FWP_TRUE && l1 == FWP_TRUE) ? FWP_TRUE : FWP_FALSE;".into(),
            "or" => "return (l0 == FWP_TRUE || l1 == FWP_TRUE) ? FWP_TRUE : FWP_FALSE;".into(),
            "print._integer" => format!(
                "return fwp_print_integer(l0, {});",
                u8::from(int64_kind(&p(0)).expect("integer output requires an inline integer"))
            ),
            "string._integer-length" => match int64_kind(&p(0)) {
                Some(true) => "return (V)fwp_i64_chars((int64_t)l0);".into(),
                Some(false) => "return (V)fwp_u64_chars((uint64_t)l0);".into(),
                None => unreachable!("integer length requires a proved inline integer"),
            },
            "show" => match int64_kind(&p(0)) {
                Some(true) => "return fwp_show_i64(l0);".into(),
                Some(false) => "return fwp_show_u64(l0);".into(),
                None => format!("return fwp_show(l0, {});", self.desc(&p(0))),
            },
            "array._show-list" => {
                let MT::Con(name, elements) = p(0) else {
                    unreachable!("array list display requires an array");
                };
                assert!(name == "std::Array" && elements.len() == 1);
                format!("return fwp_show_array_list(l0, {});", self.desc(&elements[0]))
            }
            "json.write" => format!("return fwp_p_json_write(l0, {});", self.desc(&p(0))),
            "csv.parse-with" => {
                let MT::Con(_, fields) = &result else {
                    return Err("parsed CSV has no row type".into());
                };
                let rows_drop = self.value_drop(&result);
                let row_drop = self.value_drop(&fields[0]);
                let field_drop = self.value_drop(&MT::con("std::String"));
                format!("return fwp_p_csv_parse_with(l0, l1, {row_drop}, {rows_drop}, {field_drop});")
            }
            "json.read" | "json.parse" => format!(
                "return fwp_p_json_{}(l0, {});",
                if sym == "json.read" { "read" } else { "parse" },
                self.desc(&result)
            ),
            "format" => format!("return fwp_p_format(l0, l1, {});", self.desc(&p(1))),
            "fail" => {
                let retain = if crate::rc::needs_rc(&self.prog.shapes, &p(0)) {
                    format!("{}(l0); ", self.value_dup(&p(0)))
                } else { String::new() };
                format!("{retain}fwp_fail(l0, {}); return 0;", self.desc(&p(0)))
            },
            "loop" => {
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
                {
                    // Keys own callback results, including aliases. Scalars must
                    // never be interpreted as pointers by a generic release.
                    let drop = if crate::rc::needs_rc(&self.prog.shapes, &key) {
                        if !matches!(&key, MT::Con(n, _) if n == "?") {
                            format!("fwp_drop{}", self.drop_id(&key))
                        } else {
                            "fwp_rc_drop".into()
                        }
                    } else {
                        "NULL".into()
                    };
                    format!("return fwp_p_sort_by(l0, l1, {descriptor}, {drop});")
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
            "map.insert" => format!("return fwp_p_map_insert(l0, l1, l2, {}, 2);", self.desc(&p(0))),
            "map.get" => format!("return fwp_p_map_get(l0, l1, {});", self.desc(&p(0))),
            "map.remove" | "set.remove" => {
                let columns = if sym == "set.remove" { 1 } else { 2 };
                format!("return fwp_p_map_remove(l0, l1, {}, {columns});", self.desc(&p(0)))
            }
            "map.contains" | "set.contains" => {
                let columns = if sym == "set.contains" { 1 } else { 2 };
                format!("return fwp_p_map_contains(l0, l1, {}, {columns});", self.desc(&p(0)))
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
                    "file.read-all" => format!("return fwp_p_file_read_all_owned(l0, {});", err),
                    "file.write" => format!("return fwp_p_file_write_owned(l0, l1, {});", err),
                    "file.with" => format!("return fwp_p_file_with(l0, l1, {});", err),
                    "file.read" => format!("return fwp_p_file_read(l0, {});", err),
                    _ => format!("return fwp_p_file_write_new(l0, l1, {});", err),
                }
            }
            "env.cwd" => {
                let error = self.desc(&MT::con("std::IoError"));
                format!("return fwp_p_env_cwd({error});")
            }
            "file.info" | "file.remove" | "dir.remove" | "file.rename" | "file.append"
            | "file.read-bytes" | "file.write-bytes" | "dir.create"
            | "dir.create-all" | "process.run-input" | "process.call" => {
                let err = self.desc(&MT::con("std::IoError"));
                let (f, n) = match sym {
                    "file.info" => ("fwp_p_file_info", 1),
                    "file.remove" => ("fwp_p_file_remove", 1),
                    "dir.remove" => ("fwp_p_dir_remove", 1),
                    "file.rename" => ("fwp_p_file_rename", 2),
                    "file.append" => ("fwp_p_file_append", 2),
                    "file.read-bytes" => ("fwp_p_file_read_bytes", 1),
                    "file.write-bytes" => ("fwp_p_file_write_bytes", 2),
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
                        "return fwp_p_csv_decode(l0, {}, 0, {});",
                        self.desc(&result),
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
                    self.desc(&result)
                )
            }
            "cli.parse" | "cli.help" => {
                let Some(o) = crate::cli::Options::of(&p(0), self.prog) else {
                    // as the interpreter: not a record of options
                    return Ok(if sym == "cli.parse" {
                        let msg = format!("`{}` is not a record of options", p(0));
                        format!(
                            "fwp_decode_fields error; fwp_decode_fields_begin(&error, 1, ({})->vfields[1], 1, NULL);\n    error.values[0] = fwp_rc_fresh(fwp_cstr({}));\n    return fwp_decode_variant(&error, 1);",
                            self.desc(&result),
                            c_string_literal(msg.as_bytes())
                        )
                    } else {
                        "return fwp_cstr(\"\");".to_string()
                    });
                };
                let t = self.flag_table(&o, &[]);
                if sym == "cli.parse" {
                    format!(
                        "return fwp_p_cli_parse(l0, l1, {}, {}, {}, {});",
                        t,
                        o.flags.len(),
                        o.nfields,
                        self.desc(&result)
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
                let descriptor = self.desc(&result);
                format!("return fwp_p_http2_send(l0, l1, l2, {err}, {descriptor});")
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
            "udp.recv-from" => {
                let err = self.desc(&MT::con("std::IoError"));
                let tuple = self.desc(&result);
                format!("return fwp_p_udp_recv_from(l0, l1, {err}, {tuple});")
            }
            "dns.resolve" => {
                let err = self.desc(&MT::con("std::IoError"));
                let list = self.desc(&result);
                format!("return fwp_p_dns_resolve(l0, {err}, {list});")
            }
            "tcp.listen" | "tcp.accept" | "tcp.accept-for" | "tcp.connect" | "tcp.read"
            | "tcp.read-for" | "tcp.write" | "tcp.write-for" | "udp.bind" | "udp.send-to" => {
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
                    _ => unreachable!("listed socket primitive"),
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
                    ("map.keys", "fwp_p_map_column(l0, 0, 2)"),
                    ("set.to-list", "fwp_p_map_column(l0, 0, 1)"),
                    ("map.values", "fwp_p_map_column(l0, 1, 2)"),
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
                    ("ad.scope", "fwp_p_ad_scope(l0, l1)"),
                    ("ad.scope2", "fwp_p_ad_scope2(l0, l1, l2)"),
                    ("matrix._valid-f64", "fwp_p_matrix_valid_f64(l0, l1, l2, l3, l4, l5)"),
                    ("matrix._mul-f64", "fwp_p_matrix_mul_f64(l0, l1, l2, l3, l4)"),
                    ("ad.tape", "fwp_p_ad_tape(l0)"),
                    ("ad.push", "fwp_p_ad_push(l0)"),
                    ("ad.backward", "fwp_p_ad_backward(l0, l1, l2)"),
                    ("device.run", "fwp_p_device_run(l0, l1, l2, l3, l4)"),
                    ("device.sum", "fwp_p_device_sum(l0, l1, l2, l3, l4)"),
                    ("syntax.show", "fwp_p_syntax_show(l0)"),
                    ("write", "fwp_p_write(l0)"),
                    ("eprint", "fwp_p_eprint(l0)"),
                    ("ewrite", "fwp_p_ewrite(l0)"),
                    ("term.width", "fwp_p_term_width()"),
                    ("term.read-secret", "fwp_p_term_read_secret()"),
                    ("read-line", "fwp_p_read_line()"),
                    ("read-all", "fwp_read_stdin_all()"),
                    ("exit", "fwp_p_exit(l0)"),
                    ("env.get", "fwp_p_env_get(l0)"),
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
                    ("json.encode", "fwp_p_json_encode(l0)"),
                    ("string.split-once", "fwp_p_split_once(l0, l1)"),
                    ("bytes.find", "fwp_p_bytes_find(l0, l1)"),
                    ("url.encode", "fwp_p_url_encode(l0)"),
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
                    ("channel.downgrade", "fwp_p_channel_downgrade(l0)"),
                    ("channel.upgrade", "fwp_p_channel_upgrade(l0)"),
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
                    ("grpc.with-metadata", "fwp_p_grpc_with_metadata(l0, l1)"),
                    ("grpc.with-deadline", "fwp_p_grpc_with_deadline(l0, l1)"),
                    ("grpc.set-header", "fwp_p_grpc_set_meta(0, l0, l1)"),
                    ("grpc.set-trailer", "fwp_p_grpc_set_meta(1, l0, l1)"),
                    ("grpc.with-gzip", "fwp_p_grpc_with_gzip(l0)"),
                    ("http2.serve", "fwp_p_http2_serve(l0, l1, l2, l3, l4)"),
                    ("http2.respond", "fwp_p_http2_respond(l0, l1, l2, l3, l4)"),
                    ("http2.data", "fwp_p_http2_data(l0, l1, l2)"),
                    ("http2.pooled", "fwp_p_http2_pooled(l0)"),
                    ("zlib.gzip", "fwp_p_zlib_gzip(l0)"),
                    ("zlib.deflate", "fwp_p_zlib_deflate(l0)"),
                    ("zlib.gzip-chunk", "fwp_p_zlib_gzip_chunk(l0)"),
                    ("zlib.crc32", "fwp_p_zlib_crc32(l0, l1)"),
                    ("zlib.gzip-end", "fwp_p_zlib_gzip_end(l0, l1)"),
                    ("ws.accept", "fwp_p_ws_accept(l0)"),
                    ("ws.key", "fwp_p_ws_key()"),
                    ("ws.frame", "fwp_p_ws_frame(l0, l1, l2)"),
                    ("ws.close-payload", "fwp_p_ws_close_payload(l0, l1)"),
                    ("ws.deflate", "fwp_p_ws_deflate(l0)"),
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
        // The transport constructs this iterator by function id, outside the
        // expression emitter that ordinarily records function-value uses.
        if let Some(iterator) = iter_fn {
            self.used_closures[iterator] = true;
        }
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
            result_drop: "NULL".into(),
        })
    }

    /// Known callbacks borrow captures for one invocation. Folds also borrow
    /// the source element while consuming their accumulator; array generation
    /// supplies a scalar index. Lower the actual body with these lifetimes so
    /// escaping values acquire owners at their uses, not at every entry.
    fn borrowed_hof_step(&mut self, i: usize, hof: &(String, FuncId, usize)) -> Option<String> {
        let (sym, id, captures) = hof;
        if !matches!(sym.as_str(), "fold" | "fold-right" | "array.generate") {
            return None;
        }
        let f = self.uncounted.funcs[*id].clone();
        let Body::Expr(body) = &f.body else {
            return None;
        };
        // Resource scopes keep their own close rules; recursive callbacks keep
        // their ordinary entry until that calling convention is also proved.
        fn eligible(e: &Expr, id: FuncId) -> bool {
            match e {
                Expr::Trace(..)
                | Expr::ResourceRegion { .. }
                | Expr::Dup(..)
                | Expr::Drop(..)
                | Expr::BorrowGlobal(..) => false,
                Expr::Func(g) => *g != id,
                Expr::Local(_) | Expr::Const(_) => true,
                Expr::Call(g, xs) => *g != id && xs.iter().all(|e| eligible(e, id)),
                Expr::Record(xs) | Expr::Construct(_, xs) => xs.iter().all(|e| eligible(e, id)),
                Expr::Apply(f, xs) => eligible(f, id) && xs.iter().all(|e| eligible(e, id)),
                Expr::Field(e, _) => eligible(e, id),
                Expr::SetFields(e, xs) => {
                    eligible(e, id) && xs.iter().all(|(_, e)| eligible(e, id))
                }
                Expr::Let(_, a, b) => eligible(a, id) && eligible(b, id),
                Expr::Match(e, arms) => {
                    eligible(e, id) && arms.iter().all(|(_, e)| eligible(e, id))
                }
            }
        }
        let array = sym == "array.generate";
        if !eligible(body, *id) || f.arity as usize != captures + if array { 1 } else { 2 } {
            return None;
        }
        let accumulator = if array {
            None
        } else {
            Some(captures + usize::from(sym == "fold-right"))
        };
        let borrowed: Vec<Local> = (0..f.arity)
            .filter(|l| Some(*l as usize) != accumulator)
            .collect();
        if !borrowed
            .iter()
            .any(|l| crate::rc::needs_rc(&self.prog.shapes, &f.locals[*l as usize]))
            || borrowed
                .iter()
                .any(|l| self.resource_type(&f.locals[*l as usize]))
        {
            return None;
        }
        let (body, locals) = crate::rc::insert_function(self.uncounted, &f, &borrowed)?;
        // This also validates the ownership proof when unwind code is disabled.
        let live_calls = crate::rc::ownership_liveness(self.prog, &f, &body, &locals, &borrowed)
            .expect("invalid borrowed callback ownership");
        let (kind, contract) = if array {
            ("array", "borrowed captures, scalar index")
        } else {
            ("fold", "borrowed captures/elements, owned accumulator")
        };
        let mut out = format!("/* borrowed {kind} callback for f{id}: {contract} */\nstatic V fwp_borrowed_{kind}{i}(V *args) {{\n");
        for l in 0..f.arity {
            let _ = writeln!(out, "    V l{l} = args[{l}];");
        }
        for l in f.arity as usize..locals.len() {
            let _ = writeln!(out, "    V l{l} = 0;");
        }
        let mut fg = FnGen {
            live_calls,
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
            unique_arrays: HashSet::new(),
            known_callbacks: HashMap::new(),
            callback_captures: HashMap::new(),
            resource_slots: HashMap::new(),
            me: *id,
            tail_calls: tail_calls(&body),
        };
        fg.entry_tick(f.arity, &borrowed);
        let value = fg.expr(&body);
        out.push_str(&fg.out);
        let _ = writeln!(out, "    return {value};\n}}\n");
        Some(out)
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
        let mut normalized = loop_state_expr(original);
        let e = &normalized;
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
                .filter(|m| self.loop_field_unboxed(e, j, *m, &f.locals, &HashMap::new()));
            slots.push((n, w));
            n += w.unwrap_or(1);
        }
        let n = if record.is_some() { n } else { 1 };
        let mut body_function = f.clone();
        let mut unpacked_parameters = false;
        if record.is_some() && slots.iter().all(|(_, width)| width.is_none()) {
            if let Some(mut unpacked) =
                unpack_loop_state(self.uncounted, &self.uncounted.funcs[step])
            {
                let (body, locals) = crate::rc::insert_function(self.uncounted, &unpacked, &[])
                    .expect("expression loop step");
                unpacked.locals = locals;
                crate::rc::check(self.prog, &unpacked, &body, &unpacked.locals)
                    .expect("invalid unpacked loop ownership");
                normalized = loop_state_expr(&body);
                body_function = unpacked;
                unpacked_parameters = true;
            }
        }
        let e = &normalized;
        let mut ts = Vec::new();
        tails(e, &mut ts);
        let cached_arrays = if unpacked_parameters {
            invariant_f64_arrays(
                self.prog,
                e,
                &body_function.locals,
                body_function.arity as usize,
            )
        } else {
            Vec::new()
        };
        let data_parameters = cached_arrays
            .iter()
            .map(|i| format!(", const unsigned char *array_data_{i}"))
            .collect::<String>();
        let data_arguments = cached_arrays
            .iter()
            .map(|i| format!(", array_data_{i}"))
            .collect::<String>();
        let data_initializers = cached_arrays
            .iter()
            .map(|i| {
                format!("    const unsigned char *array_data_{i} = fwp_array_data(st[{i}]);\n")
            })
            .collect::<String>();
        let lg = LoopGen {
            unpacked_parameters,
            cached_arrays,
            tails: ts.iter().map(|t| *t as *const Expr).collect(),
            record: record.is_some(),
            slots: slots.clone(),
        };
        let mut out = format!(
            "/* loop of {} : {}, the state in locals */
static inline __attribute__((always_inline)) int fs{}(V *st, V *nx, V *out{data_parameters}) {{
",
            f.name, f.ty, step
        );
        if unpacked_parameters {
            for i in 0..body_function.arity {
                let _ = writeln!(out, "    V l{i} = st[{i}];");
            }
        } else if record.is_none() {
            out.push_str("    V l0 = st[0];\n");
        }
        let first_temporary = if unpacked_parameters {
            body_function.arity
        } else {
            1
        };
        for i in first_temporary..body_function.nlocals() {
            let _ = writeln!(out, "    V l{i} = 0;");
        }
        let live_calls = if self.unwind {
            crate::rc::ownership_liveness(self.prog, &body_function, e, &body_function.locals, &[])
                .expect("invalid loop ownership before C generation")
        } else {
            HashMap::new()
        };
        let mut fg = FnGen {
            live_calls,
            g: self,
            out: String::new(),
            tmp: 0,
            label: 0,
            indent: 1,
            in_loop: Some(lg),
            fields: HashMap::new(),
            locals: body_function.locals.clone(),
            known_tag: HashMap::new(),
            vlocals: HashMap::new(),
            tokens: Vec::new(),
            stack_args: Vec::new(),
            stack_children: HashMap::new(),
            unique_arrays: HashSet::new(),
            known_callbacks: HashMap::new(),
            callback_captures: HashMap::new(),
            resource_slots: HashMap::new(),
            me: step,
            tail_calls: tail_calls(e),
        };
        fg.entry_tick(body_function.arity, &[]);
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
        if record.is_some() {
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
            for (j, (slot, ty)) in counted.iter().enumerate() {
                let dup = self.value_dup(ty);
                let _ = write!(take, " {dup}(st[{slot}]);");
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
        // The outer tick runs before fs takes the state; save only owned
        // typed slots, never scalar address bits or already-consumed old slots.
        let (mut protect, mut save, mut transfer, mut finish) =
            (String::new(), String::new(), String::new(), String::new());
        if self.unwind && self.ticks {
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
{data_initializers}    for (;;) {{
        {save}{tick}
        {transfer}
        int done = fs{id}(st, nx, &out{data_arguments});
        if (done) {{ {finish} return out; }}
        for (int i = 0; i < {n}; i++) st[i] = nx[i];
    }}
}}
",
            id = step,
            n = n,
            load = load,
            take = take,
            tick = tick
        );
        if record.is_some() && slots.iter().all(|(_, width)| width.is_none()) {
            let parameters = (0..n)
                .map(|i| format!("V a{i}"))
                .collect::<Vec<_>>()
                .join(", ");
            let initial = (0..n)
                .map(|i| format!("a{i}"))
                .collect::<Vec<_>>()
                .join(", ");
            let _ = write!(out, "static V fwp_loop_fields{step}({parameters}) {{\n    V st[{n}] = {{{initial}}}, nx[{n}] = {{0}}, out = 0;\n    {protect}\n{data_initializers}    for (;;) {{\n        {save}{tick}\n        {transfer}\n        int done = fs{step}(st, nx, &out{data_arguments});\n        if (done) {{ {finish} return out; }}\n        for (int i = 0; i < {n}; i++) st[i] = nx[i];\n    }}\n}}\n");
        }
        out
    }

    fn func(&mut self, id: FuncId) -> Result<String, String> {
        if self.wide_workers[id] {
            let f = self.uncounted.funcs[id].clone();
            let mut out = wide::worker(self.uncounted, &self.wide_workers, id, self.ticks);
            let params = (0..f.arity)
                .map(|i| format!("V a{i}"))
                .collect::<Vec<_>>()
                .join(", ");
            let _ = writeln!(out, "static V f{id}({params}) {{");
            let (types, result) = f.ty.params(f.arity as usize);
            // Copy native bits before releasing any aliased incoming boxes.
            // Once copied, a trap in the worker has no pending managed owners.
            for (i, ty) in types.iter().enumerate() {
                let k = wide::Shape::of(self.uncounted, ty).unwrap();
                let _ = writeln!(out, "    {} n{i} = {};", k.c(), k.unbox(&format!("a{i}")));
            }
            {
                for (i, ty) in types.iter().enumerate() {
                    if crate::rc::needs_rc(&self.prog.shapes, ty) {
                        let drop = self.value_drop(ty);
                        let _ = writeln!(out, "    {drop}(a{i});");
                    }
                }
            }
            let arguments = (0..f.arity)
                .map(|i| format!("n{i}"))
                .collect::<Vec<_>>()
                .join(", ");
            let k = wide::Shape::of(self.uncounted, result).unwrap();
            let _ = writeln!(out, "    {} value = fwp_wide{id}({arguments});", k.c());
            match k {
                wide::Shape::Scalar(k) => {
                    let value = k.boxed("value");
                    let value = if k.wide() { self.fresh(value) } else { value };
                    let _ = writeln!(out, "    return {value};\n}}");
                }
                wide::Shape::Record(kinds) => {
                    let fields = record_fields(&self.prog.shapes, result).unwrap().to_vec();
                    let empty: Vec<_> = fields
                        .iter()
                        .map(|(_, ty)| ("0".into(), ty.clone()))
                        .collect();
                    let protect = self.protect_values(&empty, "wide_result", "wide_result_cleanup");
                    out.push_str(&protect);
                    let _ = writeln!(out, "    V fields[{}] = {{0}};", fields.len());
                    let mut slot = 0;
                    for (i, (kind, (_, ty))) in kinds.iter().zip(&fields).enumerate() {
                        let value = kind.boxed(&format!("value.f{i}"));
                        let value = if kind.wide() {
                            self.fresh(value)
                        } else {
                            value
                        };
                        let _ = writeln!(out, "    fields[{i}] = {value};");
                        if !protect.is_empty() && crate::rc::needs_rc(&self.prog.shapes, ty) {
                            let _ = writeln!(out, "    wide_result.v{slot} = fields[{i}];");
                            slot += 1;
                        }
                    }
                    let _ = writeln!(
                        out,
                        "    V result = {};",
                        self.fresh(format!("fwp_record({}, fields)", fields.len()))
                    );
                    if !protect.is_empty() {
                        out.push_str("    fwp_cleanup_pop(&wide_result_cleanup);\n");
                    }
                    out.push_str("    return result;\n}\n");
                }
            }
            return Ok(out);
        }
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
        // Unproved external primitives may keep arguments. Remote calls borrow
        // their arguments while encoding/sending; retained input cursors acquire
        // their own typed owners, and output-channel delivery finishes in-call.
        if !matches!(
            f.body,
            Body::Expr(_) | Body::Ctor(_) | Body::RegionCtor(_) | Body::RegionEntry { .. }
        ) {
            let sym = match &f.body {
                Body::Prim(s) => s.as_str(),
                _ => "",
            };
            let scoped_foreign = matches!(f.body, Body::ForeignC { .. })
                && crate::ffi::signature(self.prog, f).is_ok_and(|(params, result)| {
                    params.iter().all(|(_, ty)| crate::ffi::scoped_argument(ty))
                        && crate::ffi::copied_result(&result)
                });
            let borrowed_remote = matches!(f.body, Body::Remote(_));
            for i in 0..f.arity {
                let foreign_borrow = matches!(f.body, Body::ForeignC { .. })
                    && crate::ffi::classify(self.prog, &f.locals[i as usize]).is_ok_and(|ty| {
                        crate::ffi::by_value(&ty)
                            || scoped_foreign && crate::ffi::scoped_argument(&ty)
                    });
                if crate::rc::needs_rc(&self.prog.shapes, &f.locals[i as usize])
                    && !crate::rc::prim_reads_only(sym, i as usize)
                    && !foreign_borrow
                    && !borrowed_remote
                {
                    let _ = writeln!(out, "    fwp_rc_share(l{});", i);
                }
            }
        }
        match &f.body {
            Body::RegionEntry { worker } => {
                // The worker takes the ordinary input owners. No operation
                // between entry and that transfer can suspend or allocate.
                let mut arguments = params
                    .iter()
                    .enumerate()
                    .map(|(i, _)| format!("l{i}"))
                    .collect::<Vec<_>>();
                arguments.push("PTR(&region)".into());
                let _ = writeln!(out,
                    "    fwp_region region = {{0}};\n    fwp_cleanup cleanup;\n    fwp_cleanup_push(&cleanup, fwp_region_release, &region);\n    V result = f{worker}({});\n    fwp_cleanup_pop(&cleanup);\n    fwp_region_release(&region);\n    return result;",
                    arguments.join(", "));
            }
            Body::RegionCtor(tag) => {
                let fields = (0..f.arity - 1)
                    .map(|i| format!("l{i}"))
                    .collect::<Vec<_>>();
                let _ = writeln!(
                    out,
                    "    return fwp_region_data(l{}, {tag}, {}, (V[]){{{}}});",
                    f.arity - 1,
                    fields.len(),
                    fields.join(", ")
                );
            }
            Body::Prim(sym) => {
                let sym = sym.clone();
                let func = f.clone();
                let mut s = self.prim(&func, &sym)?;
                {
                    if let Some(crate::ownership::Callback::Retained(i)) =
                        crate::ownership::primitive(&sym).and_then(|c| c.callback)
                    {
                        let result = func.locals[i].params(1).1;
                        let drop = self.value_drop(result);
                        let dup = if crate::rc::needs_rc(&self.prog.shapes, result) {
                            self.value_dup(result)
                        } else {
                            "NULL"
                        };
                        match sym.as_str() {
                            "task.spawn" => {
                                s = s.replace(
                                    "fwp_p_task_spawn(l0)",
                                    &format!("fwp_p_task_spawn_owned(l0, {drop})"),
                                )
                            }
                            "task.within" => {
                                s = s.replace(
                                    "fwp_p_task_within(l0, l1)",
                                    &format!("fwp_p_task_within_owned(l0, l1, {drop}, {dup})"),
                                )
                            }
                            // The HTTP connection owns the handler; every
                            // invocation returns unit and borrows its handle.
                            "http2.serve" => {}
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
                                    self.value_dup(&elements[0])
                                } else {
                                    "NULL"
                                };
                                match sym.as_str() {
                                    "channel.make" => {
                                        s = s.replace(
                                            "fwp_p_channel_make(l0)",
                                            &format!("fwp_p_channel_make_owned(l0, {drop})"),
                                        )
                                    }
                                    "channel.send" => {
                                        s = s.replace(
                                            "fwp_p_channel_send(l0, l1)",
                                            &format!("fwp_p_channel_send_owned(l0, l1, {drop})"),
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
                                    self.value_dup(element)
                                } else {
                                    "NULL"
                                };
                                s = s.replace(
                                    "fwp_p_task_await(l0)",
                                    &format!("fwp_p_task_await_owned(l0, {dup})"),
                                );
                            }
                            ResultOwnership::OwnedResource if sym == "file.with" => {
                                let ty = func.ty.params(func.arity as usize).1.clone();
                                let pair = MT::Record(vec![
                                    ("0".into(), ty.clone()),
                                    ("1".into(), MT::con("std::File")),
                                ]);
                                let drop = self.value_drop(&pair);
                                let dup = if crate::rc::needs_rc(&self.prog.shapes, &ty) {
                                    self.value_dup(&ty)
                                } else {
                                    "NULL"
                                };
                                let err = self.desc(&MT::con("std::IoError"));
                                s = format!(
                                    "return fwp_p_file_with_owned(l0, l1, {err}, {drop}, {dup});"
                                );
                            }
                            ResultOwnership::OwnedState => {
                                let returned = func.ty.params(func.arity as usize).1.clone();
                                match sym.as_str() {
                                    "get" => {
                                        let dup =
                                            if crate::rc::needs_rc(&self.prog.shapes, &returned) {
                                                self.value_dup(&returned)
                                            } else {
                                                "NULL"
                                            };
                                        s = format!("return fwp_p_get_owned({dup});");
                                    }
                                    "put" => {
                                        let state = &func.locals[0];
                                        let dup = if crate::rc::needs_rc(&self.prog.shapes, state) {
                                            self.value_dup(state)
                                        } else {
                                            "NULL"
                                        };
                                        s = format!("return fwp_p_put_owned(l0, {dup});");
                                    }
                                    "modify" => {
                                        let state = func.locals[0].params(1).1.clone();
                                        let dup = if crate::rc::needs_rc(&self.prog.shapes, &state)
                                        {
                                            self.value_dup(&state)
                                        } else {
                                            "NULL"
                                        };
                                        let drop = self.value_drop(&state);
                                        s = format!(
                                            "return fwp_p_modify_owned(l0, {dup}, {drop});"
                                        );
                                    }
                                    "run-state" => {
                                        let MT::Record(fields) = &returned else {
                                            return Err("run-state has a non-pair result".into());
                                        };
                                        if fields.len() != 2 || fields[1].1 != func.locals[0] {
                                            return Err(
                                                "run-state result lacks its state type".into()
                                            );
                                        }
                                        let state = &func.locals[0];
                                        let dup = if crate::rc::needs_rc(&self.prog.shapes, state) {
                                            self.value_dup(state)
                                        } else {
                                            "NULL"
                                        };
                                        let drop_state = self.value_drop(state);
                                        let drop_result = self.value_drop(&fields[0].1);
                                        s = format!("return fwp_p_run_state_owned(l0, l1, l2, {dup}, {drop_state}, {drop_result});");
                                    }
                                    _ => return Err(format!("unmodeled State contract: {sym}")),
                                }
                            }
                            ResultOwnership::OwnedAttempt => {
                                let MT::Con(_, types) = func.ty.params(func.arity as usize).1
                                else {
                                    return Err("attempt has a non-Result type".into());
                                };
                                if types.len() != 2 {
                                    return Err("attempt Result lacks payload types".into());
                                }
                                let good = self.value_drop(&types[0]);
                                let bad = self.value_drop(&types[1]);
                                s = s.replace(
                                    "fwp_p_attempt(l0, l1)",
                                    &format!("fwp_p_attempt_owned(l0, l1, {good}, {bad})"),
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
                                    "map"
                                        | "filter"
                                        | "take-while"
                                        | "zip-with"
                                        | "scan"
                                        | "iterate"
                                        | "list.ap"
                                        | "list.flat-map"
                                ) {
                                    let result = func.ty.params(func.arity as usize).1;
                                    let MT::Con(name, elements) = &result else {
                                        return Err("list selection has a non-list result".into());
                                    };
                                    if name != "std::List" || elements.len() != 1 {
                                        return Err("list selection has a non-list result".into());
                                    }
                                    let mut ops = self.map_ops(&elements[0]);
                                    let runtime = if sym == "list.flat-map" {
                                        let duplicate =
                                            if crate::rc::needs_rc(&self.prog.shapes, &elements[0])
                                            {
                                                "fwp_rc_dup"
                                            } else {
                                                "NULL"
                                            };
                                        ops = format!("{duplicate}, {ops}");
                                        "flat_map".to_string()
                                    } else {
                                        sym.replace(['-', '.'], "_")
                                    };
                                    let args = (0..func.arity)
                                        .map(|i| format!("l{i}"))
                                        .collect::<Vec<_>>()
                                        .join(", ");
                                    s = s.replace(
                                        &format!("fwp_p_{}({args})", runtime),
                                        &format!("fwp_p_{}_owned({args}, {ops})", runtime),
                                    );
                                }
                                if sym == "range" {
                                    let result = func.ty.params(func.arity as usize).1.clone();
                                    let MT::Con(_, types) = &result else {
                                        return Err("range has no element type".into());
                                    };
                                    let drop_element =
                                        if crate::rc::needs_rc(&self.prog.shapes, &types[0]) {
                                            self.value_drop(&types[0])
                                        } else {
                                            "NULL".into()
                                        };
                                    let drop_list = self.value_drop(&result);
                                    s = s.trim_end_matches(';').trim_end_matches(')').to_string()
                                        + &format!(", {drop_element}, {drop_list});");
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
                            ResultOwnership::CopiedSpine { runtime, .. } => {
                                let result_type = func.ty.params(func.arity as usize).1.clone();
                                let MT::Con(name, elements) = &result_type else {
                                    return Err(format!(
                                        "copied spine `{sym}` has a non-list result"
                                    ));
                                };
                                if name != "std::List" || elements.len() != 1 {
                                    return Err(format!(
                                        "copied spine `{sym}` has a non-list result"
                                    ));
                                }
                                let call = s.replace(
                                    &format!("fwp_p_{runtime}("),
                                    &format!("fwp_p_{runtime}_copied("),
                                );
                                if call == s {
                                    return Err(format!(
                                        "copied spine `{sym}` has no runtime call"
                                    ));
                                }
                                let arguments = call
                                    .strip_prefix("return ")
                                    .and_then(|r| r.strip_suffix(");"))
                                    .ok_or_else(|| {
                                        format!("copied spine `{sym}` has no return expression")
                                    })?;
                                let descriptor = self.desc(&result_type);
                                s = format!(
                                    "V result = {arguments}, {descriptor}); return result;"
                                );
                            }
                            ResultOwnership::MapOperation { .. } => {
                                let map = if matches!(
                                    sym.as_str(),
                                    "map.from-list" | "set.from-list" | "map.map-values"
                                ) {
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
                                        self.value_dup(ty)
                                    } else {
                                        "NULL"
                                    }
                                };
                                let dk = duplicate(key);
                                let dv = duplicate(&value);
                                let drop_key = if crate::rc::needs_rc(&self.prog.shapes, key) {
                                    format!("fwp_drop{}", self.drop_id(key))
                                } else {
                                    "NULL".into()
                                };
                                let drop_value = if crate::rc::needs_rc(&self.prog.shapes, &value) {
                                    format!("fwp_drop{}", self.drop_id(&value))
                                } else {
                                    "NULL".into()
                                };
                                let drop_map = format!("fwp_drop{}", self.drop_id(&map));
                                let result = func.ty.params(func.arity as usize).1.clone();
                                let drop_result = if crate::rc::needs_rc(&self.prog.shapes, &result)
                                {
                                    format!("fwp_drop{}", self.drop_id(&result))
                                } else {
                                    "NULL".into()
                                };
                                let columns = types.len();
                                let ops = format!("&(const fwp_map_ops){{{dk}, {dv}, {drop_key}, {drop_value}, {drop_map}, {drop_result}, {columns}}}");
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
                                        self.value_dup(&ty).into()
                                    } else {
                                        "NULL".into()
                                    });
                                    element = Some(ty);
                                }
                                if matches!(sym.as_str(), "array.set" | "array.push") {
                                    let ty = element.as_ref().unwrap();
                                    args.push(if crate::rc::needs_rc(&self.prog.shapes, ty) {
                                        format!("fwp_drop{}", self.drop_id(ty))
                                    } else {
                                        "NULL".into()
                                    });
                                }
                                if matches!(
                                    sym.as_str(),
                                    "array.set" | "array.push" | "array.sort" | "array.from-list"
                                ) {
                                    let array = &func.locals[func.arity as usize - 1];
                                    args.push(format!("fwp_drop{}", self.drop_id(array)));
                                }
                                if sym == "array.sort" {
                                    args.push(self.desc(element.as_ref().unwrap()));
                                }
                                if sym != "array.sort" {
                                    let ty = if let Some(ty) = element.as_ref() {
                                        ty.clone()
                                    } else {
                                        let array = if matches!(
                                            sym.as_str(),
                                            "array.generate" | "array.map"
                                        ) {
                                            func.ty.params(func.arity as usize).1
                                        } else {
                                            &func.locals[func.arity as usize - 1]
                                        };
                                        let MT::Con(_, types) = array else {
                                            return Err("typed array element missing".into());
                                        };
                                        types[0].clone()
                                    };
                                    args.push(self.desc(&ty));
                                }
                                if sym == "array.map" {
                                    let MT::Con(_, input) = &func.locals[1] else {
                                        return Err("typed array.map input missing".into());
                                    };
                                    args.push(self.desc(&input[0]));
                                }
                                if sym == "array.to-list" {
                                    args.push(
                                        self.value_drop(func.ty.params(func.arity as usize).1),
                                    );
                                }
                                if sym == "array.fold" {
                                    args.push(self.value_drop(&func.locals[1]));
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
                                    "list.transpose" => vec![element(&element(&func.locals[0])?)?],
                                    "repeat" => vec![func.locals[1].clone()],
                                    _ => return Err(format!("unknown structural copy `{sym}`")),
                                };
                                let mut args: Vec<String> =
                                    (0..func.arity).map(|i| format!("l{i}")).collect();
                                args.extend(fields.iter().map(|ty| {
                                    if crate::rc::needs_rc(&self.prog.shapes, ty) {
                                        self.value_dup(ty).into()
                                    } else {
                                        "NULL".into()
                                    }
                                }));
                                if sym == "zip" {
                                    args.extend(fields.iter().map(|ty| self.value_drop(ty)));
                                    let result = func.ty.params(func.arity as usize).1;
                                    args.push(self.value_drop(&element(result)?));
                                    args.push(self.value_drop(result));
                                }
                                if sym == "unzip" {
                                    args.extend(fields.iter().map(|ty| self.value_drop(ty)));
                                    args.extend(fields.iter().map(|ty| {
                                        self.value_drop(&MT::Con(
                                            "std::List".into(),
                                            vec![ty.clone()],
                                        ))
                                    }));
                                }
                                if matches!(sym.as_str(), "repeat" | "chunks") {
                                    args.push(self.value_drop(&fields[0]));
                                    let result = func.ty.params(func.arity as usize).1;
                                    if sym == "chunks" {
                                        args.push(self.value_drop(&element(result)?));
                                    }
                                    args.push(self.value_drop(result));
                                }
                                if sym == "list.transpose" {
                                    args.push(self.value_drop(&fields[0]));
                                    args.push(self.value_drop(&element(&func.locals[0])?));
                                    args.push(self.value_drop(&func.locals[0]));
                                }
                                s = format!(
                                    "return fwp_p_{}_owned({});",
                                    sym.replace('.', "_"),
                                    args.join(", ")
                                );
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
                                            let dup = self.value_dup(ty);
                                            let _ = write!(body, " {dup}(OBJ(result)->f[{i}]);");
                                        }
                                    }
                                    body.push_str(" break;");
                                }
                                body.push_str(" } } return result;");
                                s = body;
                            }
                            ResultOwnership::Numeric | ResultOwnership::SelectedArgument => {
                                let ty = func.ty.params(func.arity as usize).1.clone();
                                if crate::rc::needs_rc(&self.prog.shapes, &ty) {
                                    let (prefix, returned) =
                                        s.rsplit_once("return ").ok_or_else(|| {
                                            format!("numeric primitive `{sym}` has no return")
                                        })?;
                                    let value = returned.strip_suffix(';').ok_or_else(|| {
                                        format!("numeric primitive `{sym}` has no result")
                                    })?;
                                    if contract.result == ResultOwnership::SelectedArgument {
                                        s = format!("{prefix}V result = {value}; fwp_rc_dup(result); return result;");
                                    } else if sym == "abs" {
                                        s = format!("{prefix}V result = {value}; if (result == l0) fwp_rc_dup(result); else fwp_rc_fresh(result); return result;");
                                    } else {
                                        let owner = self.tree_owner_id(&ty)?;
                                        s = format!("{prefix}V result = {value}; fwp_own_tree{owner}(result); return result;");
                                    }
                                }
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
                                let (prefix, returned) =
                                    s.rsplit_once("return ").ok_or_else(|| {
                                        format!("fresh primitive `{sym}` has no return expression")
                                    })?;
                                let r = returned.strip_suffix(';').ok_or_else(|| {
                                    format!("fresh primitive `{sym}` has no return expression")
                                })?;
                                s = format!("{prefix}return fwp_rc_fresh({r});");
                            }
                            ResultOwnership::AliasArgument { argument } => {
                                if crate::rc::needs_rc(&self.prog.shapes, &func.locals[argument]) {
                                    let dup = self.value_dup(&func.locals[argument]);
                                    s = format!("{dup}(l{argument}); {s}");
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
                            ResultOwnership::OwnedLeaf { argument } => {
                                let r = s
                                    .strip_prefix("return ")
                                    .and_then(|r| r.strip_suffix(';'))
                                    .ok_or_else(|| {
                                        format!(
                                            "owned leaf primitive `{sym}` has no return expression"
                                        )
                                    })?;
                                let drop = self.value_drop(&func.locals[argument]);
                                s = format!("fwp_value_owner owner = {{l{argument}, {drop}}}; fwp_cleanup cleanup; fwp_value_protect(&owner, &cleanup); V result = {r}; if (result == l{argument}) return fwp_value_finish(&owner, &cleanup); fwp_rc_fresh(result); fwp_value_release(&owner); fwp_value_finish(&owner, &cleanup); return result;");
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
                let input_type = f.locals.first().cloned();
                let rpc = self.rpc_spec(
                    &format!("{}.{}", remote.module, remote.method),
                    remote.path.clone(),
                    id,
                    0,
                    remote.error.as_ref(),
                    &remote.method,
                    remote.iter_fn,
                )?;
                let input_drop = if rpc.input != 0 {
                    self.value_drop(input_type.as_ref().expect("streamed input argument"))
                } else {
                    "NULL".into()
                };
                self.remotes.push(RemoteSpec {
                    id,
                    remote,
                    rpc,
                    input_drop,
                });
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
                out.push_str(&self.boxed_body(id, &e));
            }
        }
        out.push_str("}\n");
        Ok(out)
    }

    /// Emit the ownership-lowered body with ordinary boxed parameters.
    /// Scalar projections use this at their function-value entry so unused
    /// fields never acquire temporary owners just to enter the direct worker.
    fn boxed_body(&mut self, id: FuncId, e: &Expr) -> String {
        let locals = self.prog.funcs[id].locals.clone();
        let mut fg = FnGen {
            live_calls: self.live_calls(id, e),
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
            unique_arrays: HashSet::new(),
            known_callbacks: HashMap::new(),
            callback_captures: HashMap::new(),
            resource_slots: HashMap::new(),
            me: id,
            tail_calls: tail_calls(e),
        };
        if fg.g.uncounted.self_tail.contains(&id) {
            fg.line("fwp_self_again:;");
        }
        let borrowed =
            fg.g.prog
                .borrowed_parameters
                .get(&id)
                .cloned()
                .unwrap_or_default();
        fg.entry_tick(fg.g.prog.funcs[fg.me].arity, &borrowed);
        let r = fg.expr(e);
        let _ = writeln!(fg.out, "    return {};", r);
        fg.out
    }

    /// A function with an unboxed calling convention: its worker, and the
    /// function itself, which unpacks its record parameters and boxes its
    /// record result.
    fn worker(&mut self, id: FuncId, abi: &Abi, e: &Expr) -> String {
        let f = &self.prog.funcs[id];
        let mut out = format!(
            "/* {} : {} */\n{} {{\n",
            f.name,
            f.ty,
            abi.sig(self.prog, id)
        );
        if let Some(parameters) = self.prog.borrowed_parameters.get(&id) {
            let parameters = parameters
                .iter()
                .map(Local::to_string)
                .collect::<Vec<_>>()
                .join(", ");
            let _ = writeln!(out, "    /* caller-owned parameters: {parameters} */");
        }
        let mut names = Vec::new();
        for (i, p) in abi.params.iter().enumerate() {
            match p {
                Some(n) => names.extend((0..*n).map(|k| format!("l{i}_{k}"))),
                None => names.push(format!("l{i}")),
            }
        }
        for (name, n) in names.into_iter().zip(abi.param_numbers(self.prog, id)) {
            if let Some(n) = n {
                let _ = writeln!(out, "    V {name} = {};", n.to_word(&format!("a{name}")));
            }
        }
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
            unique_arrays: HashSet::new(),
            known_callbacks: HashMap::new(),
            callback_captures: HashMap::new(),
            resource_slots: HashMap::new(),
            me: id,
            tail_calls: tail_calls(e),
        };
        if fg.g.uncounted.self_tail.contains(&id) {
            fg.line("fwp_self_again:;");
        }
        let borrowed =
            fg.g.prog
                .borrowed_parameters
                .get(&id)
                .cloned()
                .unwrap_or_default();
        fg.entry_tick(fg.g.prog.funcs[fg.me].arity, &borrowed);
        let ret = match (abi.ret, abi.vret) {
            (Some(n), _) => {
                let fs = fg.expr_fields(e, n);
                let values: Vec<_> = fs
                    .into_iter()
                    .zip(abi.result_numbers(fg.g.prog, id))
                    .map(|(v, n)| n.map_or_else(|| v.clone(), |n| n.decode_word(&v)))
                    .collect();
                format!("(fwp_wr{id}){{{}}}", values.join(", "))
            }
            (None, Some(m)) => {
                let ty = fg.ret_type(id);
                let (tag, fs) = fg.expr_variant(e, m, &ty);
                format!("(fwp_u{}){{{}, {{{}}}}}", m, tag, fs.join(", "))
            }
            (None, None) => {
                let v = fg.expr(e);
                abi.scalar_result(fg.g.prog, id)
                    .map_or_else(|| v.clone(), |n| n.decode_word(&v))
            }
        };
        out.push_str(&fg.out);
        let _ = writeln!(out, "    return {};\n}}", ret);
        // the function as a value: unpack, call, box
        let params: Vec<String> = (0..f.arity).map(|i| format!("V l{}", i)).collect();
        // A pure scalar projection needs no owners for the other fields.
        // Keep its direct worker for already-separated arguments, but read a
        // boxed argument in place. The ordinary body preserves entry ticks and
        // consumes the box after reading, without moving any destruction across
        // user code. Resource frames and borrowed worker contracts stay separate.
        let scalar_projection = f.arity == 1
            && abi.params[0].is_some()
            && crate::rc::consumes_arg(self.prog, id, 0)
            && !crate::rc::needs_rc(&self.prog.shapes, f.ty.params(1).1)
            && !self.resource_type(&f.locals[0])
            && record_fields(&self.prog.shapes, &f.locals[0]).is_some_and(|fields| {
                fields
                    .iter()
                    .any(|(_, ty)| crate::rc::needs_rc(&self.prog.shapes, ty))
            })
            && matches!(&self.uncounted.funcs[id].body,
                Body::Expr(Expr::Field(base, _)) if matches!(&**base, Expr::Local(0)));
        if scalar_projection {
            let _ = writeln!(out, "static V f{id}({}) {{", params.join(", "));
            for i in f.arity..f.nlocals() {
                let _ = writeln!(out, "    V l{i} = 0;");
            }
            out.push_str(&self.boxed_body(id, e));
            out.push_str("}\n");
            return out;
        }
        let moving_records: Vec<_> = abi
            .params
            .iter()
            .enumerate()
            .map(|(i, p)| {
                p.is_some()
                    && crate::rc::consumes_arg(self.prog, id, i)
                    && !self.resource_type(&f.locals[i])
                    && record_fields(&self.prog.shapes, &f.locals[i]).is_some_and(|fields| {
                        fields
                            .iter()
                            .any(|(_, ty)| crate::rc::needs_rc(&self.prog.shapes, ty))
                    })
            })
            .collect();
        let mut args = Vec::new();
        let mut snapshots = String::new();
        for (i, p) in abi.params.iter().enumerate() {
            match p {
                Some(n) => {
                    for k in 0..*n {
                        let field = format!("OBJ(l{i})->f[{k}]");
                        if moving_records[i] {
                            let _ = write!(snapshots, "V field{i}_{k} = {field}; ");
                            args.push(format!("field{i}_{k}"));
                        } else {
                            args.push(field);
                        }
                    }
                }
                None => args.push(format!("l{}", i)),
            }
        }
        let args = abi.args_decode_words(self.prog, id, args);
        let call = format!("w{}({})", id, args.join(", "));
        // A unique record transfers its fields; shared records duplicate them.
        // Keep the original boxes owned through the call, clearing only fields
        // that moved. Protect each prepared field until worker entry, including
        // when preparing a later shared argument fails.
        let (mut pre, mut post) = (String::new(), String::new());
        {
            let counted_fields: Vec<_> = abi
                .params
                .iter()
                .enumerate()
                .filter(|(i, p)| p.is_some() && crate::rc::consumes_arg(self.prog, id, *i))
                .flat_map(|(i, _)| {
                    record_fields(&self.prog.shapes, &f.locals[i])
                        .unwrap_or_default()
                        .iter()
                        .enumerate()
                        .filter(|(_, (_, ty))| crate::rc::needs_rc(&self.prog.shapes, ty))
                        .map(move |(j, (_, ty))| (i, j, ty.clone()))
                })
                .collect();
            let has_boxed = abi.params.iter().any(Option::is_some);
            let has_borrowed = self.prog.borrowed_parameters.contains_key(&id);
            let originals: Vec<_> = if has_boxed || has_borrowed {
                f.ty.params(f.arity as usize)
                    .0
                    .into_iter()
                    .enumerate()
                    .map(|(i, ty)| (i, format!("l{i}"), ty.clone()))
                    .collect()
            } else {
                Vec::new()
            };
            let owned_values = originals
                .iter()
                .map(|(_, value, ty)| (value.clone(), ty.clone()))
                .collect::<Vec<_>>();
            let protection = self.protect_values(&owned_values, "owned", "cleanup");
            pre.push_str(&protection);
            pre.push_str(&snapshots);
            if !protection.is_empty() {
                post.push_str("fwp_cleanup_pop(&cleanup); ");
            }
            let empty_fields: Vec<_> = counted_fields
                .iter()
                .map(|(_, _, ty)| ("0".into(), ty.clone()))
                .collect();
            let preparing = self.protect_values(&empty_fields, "prepared", "preparation_cleanup");
            pre.push_str(&preparing);
            for (i, moving) in moving_records.iter().enumerate() {
                if *moving {
                    let _ = write!(pre, "int move{i} = fwp_rc_last(l{i}); ");
                }
            }
            for (j, (parent, field, ty)) in counted_fields.iter().enumerate() {
                let dup = self.value_dup(ty);
                let value = if moving_records[*parent] {
                    let value = format!("field{parent}_{field}");
                    let _ = write!(pre, "if (move{parent}) {{ OBJ(l{parent})->f[{field}] = 0; }} else {{ {dup}({value}); }} ");
                    value
                } else {
                    let value = format!("OBJ(l{parent})->f[{field}]");
                    let _ = write!(pre, " {dup}({value}); ");
                    value
                };
                if !preparing.is_empty() {
                    let _ = write!(pre, "prepared.v{j} = {value}; ");
                }
            }
            if !preparing.is_empty() {
                pre.push_str("fwp_cleanup_pop(&preparation_cleanup); ");
            }
            if !protection.is_empty() {
                let mut slot = 0;
                for (i, _, ty) in &originals {
                    if !crate::rc::needs_rc(&self.prog.shapes, ty) {
                        continue;
                    }
                    if abi.params[*i].is_none() && crate::rc::consumes_arg(self.prog, id, *i) {
                        let _ = write!(pre, "owned.v{slot} = 0; ");
                    }
                    slot += 1;
                }
            }
            for (i, p) in abi.params.iter().enumerate() {
                let borrowed = !crate::rc::consumes_arg(self.prog, id, i);
                if p.is_some() || borrowed {
                    let ty = self.prog.funcs[id].locals[i].clone();
                    let drop = self.value_drop(&ty);
                    let _ = write!(post, "{drop}(l{i}); ");
                }
            }
        }
        let body = match (abi.ret, abi.vret) {
            (Some(n), _) => {
                let ty = f.ty.params(f.arity as usize).1.clone();
                let values = abi.result_words(self.prog, id, "r");
                let fields: Vec<_> = record_fields(&self.prog.shapes, &ty)
                    .expect("record ABI result")
                    .iter()
                    .enumerate()
                    .map(|(i, (_, ty))| (values[i].clone(), ty.clone()))
                    .collect();
                let protect = self.protect_values(&fields, "pending_result", "boxing_cleanup");
                let finish = if protect.is_empty() {
                    ""
                } else {
                    "fwp_cleanup_pop(&boxing_cleanup);"
                };
                format!("{pre}fwp_wr{id} r = {call}; {post}{protect} V result = {}; {finish}return result;",
                    self.fresh(format!("fwp_record({n}, {})", FnGen::array(&values))))
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
            (None, None) => {
                let value = abi
                    .scalar_result(self.prog, id)
                    .map_or_else(|| call.clone(), |n| n.to_word(&call));
                format!("{pre}V r = {value}; {post}return r;")
            }
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
    match t {
        CType::Int { .. } => format!("({})(int64_t)({})", crate::ffi::c_name(t), v),
        CType::F32 => format!("fwp_f32({})", v),
        CType::F64 => format!("fwp_f64({})", v),
        CType::F16 | CType::BF16 => format!("(uint16_t)({v})"),
        CType::F128 => format!("fwp_to_c_quad({v})"),
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
    match t {
        CType::Int { signed: true, .. } => format!("(V)(int64_t)({})", e),
        CType::Int { signed: false, .. } => format!("(V)({})", e),
        CType::F32 => format!("fwp_from_f32({})", e),
        CType::F64 => format!("fwp_from_f64({})", e),
        CType::F16 | CType::BF16 => format!("(V)({e})"),
        CType::F128 => format!("fwp_from_c_quad({e})"),
        CType::Bool => format!("(({}) ? FWP_TRUE : FWP_FALSE)", e),
        CType::Str => format!("fwp_c_string({})", e),
        CType::Ptr | CType::Bytes | CType::Callback { .. } => format!("(V)(uintptr_t)({})", e),
        CType::OptPtr => format!("fwp_c_optptr({})", e),
        CType::Struct { name, .. } => format!("fwp_s2v_{}({})", name, e),
        CType::Void => "FWP_UNIT".into(),
    }
}

impl Gen<'_> {
    /// Copy a C export argument into owned language storage. Ordinary foreign
    /// calls keep their existing converters and borrowing convention.
    fn library_arg(
        &mut self,
        out: &mut String,
        name: &str,
        c: &crate::ffi::CType,
        ty: &MT,
        value: &str,
    ) {
        if let CType::Struct { fields, .. } = c {
            let types = record_fields(&self.prog.shapes, ty)
                .expect("exported C record shape")
                .to_vec();
            let ctx = format!("{name}_fields_owner");
            let node = format!("{name}_fields_cleanup");
            let empty: Vec<_> = fields
                .iter()
                .map(|(_, i, _)| ("0".into(), types[*i].1.clone()))
                .collect();
            let protect = self.protect_values(&empty, &ctx, &node);
            let _ = writeln!(
                out,
                "    V {name}_fields[{}] = {{0}};\n    {protect}",
                fields.len()
            );
            let mut slot = 0;
            for (field, index, ft) in fields {
                let converted = ffi_from_c(ft, &format!("{value}.{field}"));
                let converted = if matches!(ft, CType::Str | CType::OptPtr | CType::F128) {
                    self.fresh(converted)
                } else {
                    converted
                };
                let _ = writeln!(out, "    {name}_fields[{index}] = {converted};");
                if !protect.is_empty() && crate::rc::needs_rc(&self.prog.shapes, &types[*index].1) {
                    let _ = writeln!(out, "    {ctx}.v{slot} = {name}_fields[{index}];");
                    slot += 1;
                }
            }
            let _ = writeln!(
                out,
                "    V {name} = {};",
                self.fresh(format!("fwp_record({}, {name}_fields)", fields.len()))
            );
            if !protect.is_empty() {
                let _ = writeln!(out, "    fwp_cleanup_pop(&{node});");
            }
        } else {
            let converted = ffi_from_c(c, value);
            let converted = if matches!(c, CType::Str | CType::OptPtr | CType::F128) {
                self.fresh(converted)
            } else {
                converted
            };
            let _ = writeln!(out, "    V {name} = {converted};");
        }
    }

    /// Struct definitions and converters for the structs among `types`.
    fn ffi_structs(&mut self, types: &[crate::ffi::CType]) {
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
                let owned = ffi::scoped_callback(c);
                let decl: Vec<String> = cps
                    .iter()
                    .enumerate()
                    .map(|(j, p)| format!("{} a{j}", ffi::c_name(p)))
                    .collect();
                let mut trampoline = format!(
                    "static {} fwp_cb_{id}_{k}({}) {{\n",
                    ffi::c_name(cr),
                    if decl.is_empty() {
                        "void".into()
                    } else {
                        decl.join(", ")
                    }
                );
                // Prepare callback arguments in declaration order. Copied quad
                // boxes own their bits; partial preparation must unwind them.
                let mut mts = Vec::new();
                let mut cur = &pmts[*i];
                while let MT::Fun(a, b) = cur {
                    mts.push((**a).clone());
                    cur = b;
                }
                let empty: Vec<_> = mts.iter().map(|t| ("0".into(), t.clone())).collect();
                let protection = if owned {
                    self.protect_values(&empty, "inputs", "inputs_cleanup")
                } else {
                    String::new()
                };
                trampoline.push_str(&protection);
                let mut cargs = Vec::new();
                let (mut j, mut slot) = (0, 0);
                for (argument, ty) in mts.iter().enumerate() {
                    let name = format!("input{argument}");
                    let ct = ffi::classify(self.prog, ty)?;
                    if ct == CType::Void {
                        let _ = writeln!(trampoline, "    V {name} = FWP_UNIT;");
                    } else {
                        if owned {
                            self.library_arg(&mut trampoline, &name, &cps[j], ty, &format!("a{j}"));
                        } else {
                            let _ = writeln!(
                                trampoline,
                                "    V {name} = {};",
                                ffi_from_c(&cps[j], &format!("a{j}"))
                            );
                        }
                        j += 1;
                    }
                    if !protection.is_empty() && crate::rc::needs_rc(&self.prog.shapes, ty) {
                        let _ = writeln!(trampoline, "    inputs.v{slot} = {name};");
                        slot += 1;
                    }
                    cargs.push(name);
                }
                let _ = writeln!(
                    trampoline,
                    "    V a[{}] = {{{}}};",
                    cargs.len().max(1),
                    if cargs.is_empty() {
                        "0".into()
                    } else {
                        cargs.join(", ")
                    }
                );
                if !protection.is_empty() {
                    trampoline.push_str("    fwp_cleanup_pop(&inputs_cleanup);\n");
                }
                let callback = format!("fwp_foreign_callback_get({id}, {k})");
                let application = if owned {
                    format!(
                        "fwp_apply_borrowed_span({callback}, {}, a, 0, {})",
                        cargs.len(),
                        cargs.len()
                    )
                } else {
                    format!("fwp_apply({callback}, {}, a)", cargs.len())
                };
                let _ = writeln!(trampoline, "    V r = {application};");
                if **cr == CType::Void {
                    trampoline.push_str("    (void)r;\n}\n");
                } else {
                    let _ = writeln!(
                        trampoline,
                        "    {} result = {};",
                        ffi::c_name(cr),
                        ffi_to_c(cr, "r")
                    );
                    if owned && crate::rc::needs_rc(&self.prog.shapes, cur) {
                        let drop = self.value_drop(cur);
                        let _ = writeln!(
                            trampoline,
                            "    {drop}(r); /* foreign callback result owner */"
                        );
                    }
                    trampoline.push_str("    return result;\n}\n");
                }
                self.ffi_decls.push_str(&trampoline);
                // Frames follow the active task across suspension. Registered
                // cleanup restores nesting after errors, traps and cancellation.
                let _ = writeln!(body,"    fwp_foreign_callback callback{k} = {{fwp_foreign_callbacks, {id}, {k}, l{i}}};\n    fwp_foreign_callbacks = &callback{k};\n    fwp_cleanup callback_cleanup{k};\n    fwp_cleanup_push(&callback_cleanup{k}, fwp_foreign_callback_release, &callback{k});");
                restore.push(format!("    fwp_cleanup_pop(&callback_cleanup{k}); fwp_foreign_callback_release(&callback{k});\n"));
                args.push(format!("(void *)fwp_cb_{}_{}", id, k));
            } else {
                args.push(ffi_to_c(c, &format!("l{}", i)));
            }
        }
        let call = format!("{}({})", cname, args.join(", "));
        let restore = restore.into_iter().rev().collect::<String>();
        let result_type = f.ty.params(f.arity as usize).1;
        if ffi::copied_result(&ret) && crate::rc::needs_rc(&self.prog.shapes, result_type) {
            let _ = write!(
                body,
                "    {} c_result = {call};\n{restore}",
                ffi::c_name(&ret)
            );
            self.library_arg(&mut body, "result", &ret, result_type, "c_result");
            body.push_str("    return result;\n");
            return Ok(body);
        }
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
    Library(&'a [String]),
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

fn library_result_needs_release(result: &crate::ffi::CType) -> bool {
    match result {
        CType::Str => true,
        CType::Struct { fields, .. } => fields.iter().any(|(_, _, ty)| *ty == CType::Str),
        _ => false,
    }
}

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
        if params.iter().any(|(_, c)| *c == crate::ffi::CType::Bytes) {
            return Err(format!(
                "exported function `{name}`: `Bytes` parameters have no length in the C export ABI"
            ));
        }
        out.push((c_export_name(name), *fid, params, ret));
    }
    let mut names = std::collections::HashSet::new();
    for (name, _, _, _) in &out {
        if !names.insert(name.clone()) {
            return Err(format!("exported functions have the same C name `{name}`"));
        }
    }
    for (name, _, _, result) in &out {
        if library_result_needs_release(result) {
            let release = format!("fwp_release_{name}");
            if !names.insert(release.clone()) {
                return Err(format!(
                    "exported function conflicts with generated result release `{release}`"
                ));
            }
        }
    }
    Ok(out)
}

/// A C library of the exported functions: its source and its header.
pub fn generate_library(
    prog: &Program,
    lib_name: &str,
    callbacks: &[String],
) -> Result<(String, String), String> {
    let sigs = export_sigs(prog)?;
    if sigs.is_empty() {
        return Err("the library exports no functions (mark them with `export`)".into());
    }
    let mut public_names = std::collections::HashSet::new();
    for (name, _, _, result) in &sigs {
        public_names.insert(name.clone());
        if library_result_needs_release(result) {
            public_names.insert(format!("fwp_release_{name}"));
        }
    }
    for callback in callbacks {
        let (_, fid, _, _) = sigs
            .iter()
            .find(|(name, _, _, _)| name == callback)
            .ok_or_else(|| format!("unknown C callback export `{callback}`"))?;
        if prog.funcs[*fid].arity == 0 {
            return Err(format!("C callback export `{callback}` needs a final argument; constants cannot be registered"));
        }
        for operation in ["register", "invoke", "close", "release_callback"] {
            let generated = format!("fwp_{operation}_{callback}");
            if !public_names.insert(generated.clone()) {
                return Err(format!(
                    "duplicate or conflicting C callback symbol `{generated}`"
                ));
            }
        }
    }
    let src = generate_mode(prog, Mode::Library(callbacks))?;
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
    h.push_str("/* Inputs are copied for each call; keep input strings valid until return.\n * Raw pointer bits are copied without owning or freeing their pointees.\n * Their validity, synchronization and cleanup remain the caller's responsibility.\n * Each result containing strings owns those strings. Release the complete,\n * unchanged result exactly once with its matching fwp_release_FUNCTION.\n * Do not use free(), modify string bytes, or release copied result aliases.\n * No result may be used after release. Serialize calls (including releases),\n * release all owned results and finish all calls before unloading the library. */\n\n");
    let mut all = Vec::new();
    for (_, _, ps, r) in &sigs {
        all.extend(ps.iter().map(|(_, c)| c.clone()));
        all.push(r.clone());
    }
    let mut seen = Vec::new();
    crate::ffi::struct_defs(&all, &mut h, &mut seen);
    for n in seen.iter().filter(|n| n.as_str() != "@binary128") {
        let _ = writeln!(h, "typedef struct fwp_c_{n} {n};", n = n);
    }
    if !seen.is_empty() {
        h.push('\n');
    }
    if !callbacks.is_empty() {
        h.push_str("/* Retained callbacks: all calls into this library, including result releases,\n * must run on the OS thread of its first call. register copies leading inputs;\n * invoke supplies the final input and returns 1 after writing the result, or 0\n * when closed (the result slot is untouched). close is idempotent and prevents\n * new calls. release_callback consumes the one host owner and also closes;\n * active calls keep captures alive until return/unwind. Do not use a released\n * registration again. Stop host delivery before release. Release all registrations\n * and owned results before unloading. Captured raw pointees remain host-owned.\n * Unhandled errors/traps retain the ordinary export policy; invoke is not an\n * error handler. Owned invoke results use fwp_release_NAME, as ordinary results do. */\n\n");
    }
    for (cname, fid, ps, r) in &sigs {
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
        if callbacks.contains(cname) {
            let last = prog.funcs[*fid].arity as usize - 1;
            let captures = ps
                .iter()
                .filter(|(i, _)| *i < last)
                .map(|(_, c)| crate::ffi::c_name(c))
                .collect::<Vec<_>>();
            let mut invoke = vec![format!("struct fwp_callback_{cname} *")];
            if let Some((_, c)) = ps.iter().find(|(i, _)| *i == last) {
                invoke.push(crate::ffi::c_name(c));
            }
            if *r != CType::Void {
                invoke.push(format!("{} *", crate::ffi::c_name(r)));
            }
            let _ = writeln!(h, "struct fwp_callback_{cname};\nstruct fwp_callback_{cname} *fwp_register_{cname}({});\nint fwp_invoke_{cname}({});\nvoid fwp_close_{cname}(struct fwp_callback_{cname} *);\nvoid fwp_release_callback_{cname}(struct fwp_callback_{cname} *);", if captures.is_empty() { "void".into() } else { captures.join(", ") }, invoke.join(", "));
        }
        if library_result_needs_release(r) {
            let _ = writeln!(
                h,
                "void fwp_release_{cname}({} result);",
                crate::ffi::c_name(r)
            );
        }
    }
    h.push_str("\n#ifdef __cplusplus\n}\n#endif\n\n#endif\n");
    Ok((src, h))
}

impl Gen<'_> {
    fn library_registration(&mut self, cname: &str, fid: FuncId, ps: &[(usize, CType)]) -> String {
        let prog = self.prog;
        let f = &prog.funcs[fid];
        let captures = f.arity as usize - 1;
        let types = f.ty.params(f.arity as usize).0;
        let attribute = "#ifdef _WIN32\n__declspec(dllexport)\n#endif\n";
        let mut out = format!("struct fwp_callback_{cname};\nstatic void fwp_callback_drop_{cname}(fwp_callback_context *context) {{\n");
        for (i, ty) in types.iter().take(captures).enumerate() {
            if crate::rc::needs_rc(&prog.shapes, ty) {
                let drop = self.value_drop(ty);
                let _ = writeln!(out, "    V capture{i} = context->captures[{i}]; context->captures[{i}] = 0; {drop}(capture{i});");
            }
        }
        out.push_str("    (void)context;\n}\n");
        let decl = ps
            .iter()
            .filter(|(i, _)| *i < captures)
            .map(|(i, c)| format!("{} a{i}", crate::ffi::c_name(c)))
            .collect::<Vec<_>>();
        let _ = writeln!(out, "{attribute}struct fwp_callback_{cname} *fwp_register_{cname}({}) {{\n    fwp_lib_init();\n    fwp_callback_context *context = fwp_callback_create({captures}, fwp_callback_drop_{cname});\n    fwp_cleanup registration_cleanup;\n    fwp_cleanup_push(&registration_cleanup, fwp_callback_release, context);", if decl.is_empty() { "void".into() } else { decl.join(", ") });
        for (i, ty) in types.iter().take(captures).enumerate() {
            if let Some((_, c)) = ps.iter().find(|(j, _)| *j == i) {
                self.library_arg(&mut out, &format!("capture{i}"), c, ty, &format!("a{i}"));
                let _ = writeln!(out, "    context->captures[{i}] = capture{i};");
            } else {
                let _ = writeln!(out, "    context->captures[{i}] = FWP_UNIT;");
            }
        }
        let _ = writeln!(out, "    fwp_cleanup_pop(&registration_cleanup);\n    return (struct fwp_callback_{cname} *)context;\n}}\n{attribute}void fwp_close_{cname}(struct fwp_callback_{cname} *registration) {{\n    fwp_callback_close((fwp_callback_context *)registration);\n}}\n{attribute}void fwp_release_callback_{cname}(struct fwp_callback_{cname} *registration) {{\n    fwp_callback_release(registration);\n}}\n");
        out
    }

    /// Direct C exports and retained invocations share input/result ownership.
    fn library_entry(
        &mut self,
        cname: &str,
        fid: FuncId,
        ps: &[(usize, CType)],
        result: &CType,
        callback: bool,
    ) -> String {
        let prog = self.prog;
        let r = result.clone();
        let export_attribute = "#ifdef _WIN32\n__declspec(dllexport)\n#endif\n";
        let mut out = String::new();
        let f = &prog.funcs[fid];
        let args: Vec<String> = (0..f.arity as usize)
            .map(|i| format!("input_arg{i}"))
            .collect();
        let call = if f.arity == 0 {
            format!("caf{}()", fid)
        } else {
            format!("f{}({})", fid, args.join(", "))
        };
        let mut decl: Vec<String> = ps
            .iter()
            .filter(|(i, _)| !callback || *i == f.arity as usize - 1)
            .map(|(i, c)| format!("{} a{i}", crate::ffi::c_name(c)))
            .collect();
        if callback {
            decl.insert(0, format!("struct fwp_callback_{cname} *registration"));
            if r != CType::Void {
                decl.push(format!("{} *result_out", crate::ffi::c_name(&r)));
            }
            let _ = writeln!(out, "{export_attribute}int fwp_invoke_{cname}({}) {{\n    fwp_lib_init();\n    fwp_callback_context *context = (fwp_callback_context *)registration;\n    if (!fwp_callback_enter(context)) return 0;\n    fwp_cleanup callback_cleanup;\n    fwp_cleanup_push(&callback_cleanup, fwp_callback_leave, context);", decl.join(", "));
            if r != CType::Void {
                out.push_str(
                    "    if (!result_out) fwp_trap(\"callback result pointer is null\");\n",
                );
            }
        } else {
            let _ = writeln!(
                out,
                "{export_attribute}{} {cname}({}) {{\n    fwp_lib_init();",
                crate::ffi::c_name(&r),
                if decl.is_empty() {
                    "void".into()
                } else {
                    decl.join(", ")
                }
            );
        }
        let finish_callback = if callback {
            "    fwp_cleanup_pop(&callback_cleanup); fwp_callback_leave(context);\n"
        } else {
            ""
        };
        let return_result = if callback {
            format!("    *result_out = converted;\n{finish_callback}    return 1;\n}}\n\n")
        } else {
            "    return converted;\n}\n\n".into()
        };
        let types = f.ty.params(f.arity as usize).0;
        let empty: Vec<_> = types.iter().map(|ty| ("0".into(), (*ty).clone())).collect();
        let protection = self.protect_values(&empty, "inputs_owner", "inputs_cleanup");
        let _ = writeln!(out, "    {protection}");
        let mut slot = 0;
        let mut consumed_slots = Vec::new();
        for (i, ty) in types.iter().enumerate() {
            let captured = callback && i + 1 < f.arity as usize;
            let consumes = crate::rc::consumes_arg(prog, fid, i);
            if captured {
                if consumes && crate::rc::needs_rc(&prog.shapes, ty) {
                    let duplicate = self.value_dup(ty);
                    let _ = writeln!(out, "    {duplicate}(context->captures[{i}]);");
                }
                let _ = writeln!(out, "    V {} = context->captures[{i}];", args[i]);
            } else if let Some((_, c)) = ps.iter().find(|(j, _)| *j == i) {
                self.library_arg(&mut out, &args[i], c, ty, &format!("a{i}"));
            } else {
                let _ = writeln!(out, "    V {} = FWP_UNIT;", args[i]);
            }
            if !protection.is_empty() && crate::rc::needs_rc(&prog.shapes, ty) {
                if !captured || consumes {
                    let _ = writeln!(out, "    inputs_owner.v{slot} = {};", args[i]);
                }
                if crate::rc::consumes_arg(prog, fid, i) {
                    consumed_slots.push(slot);
                }
                slot += 1;
            }
        }
        for slot in consumed_slots {
            let _ = writeln!(out, "    inputs_owner.v{slot} = 0;");
        }
        let finish_inputs = if protection.is_empty() {
            ""
        } else {
            "    fwp_cleanup_pop(&inputs_cleanup); inputs_cleanup.release(inputs_cleanup.arg);\n"
        };
        let direct = self.abis[fid]
            .as_ref()
            .filter(|abi| {
                matches!(r, crate::ffi::CType::Struct { .. })
                    && abi.ret.is_some()
                    && abi.params.iter().all(Option::is_none)
            })
            .cloned();
        if r == crate::ffi::CType::Void {
            let _ = writeln!(
                out,
                "    (void){call};\n{finish_inputs}{finish_callback}{}\n}}\n",
                if callback { "    return 1;" } else { "" }
            );
        } else if let Some(abi) = direct {
            // The worker already returns fields. Transfer those owners
            // directly into the C result rather than boxing then unpacking.
            let args = abi.args_decode_words(prog, fid, args.clone());
            let _ = writeln!(
                out,
                "    fwp_wr{fid} result = w{fid}({});\n{finish_inputs}",
                args.join(", ")
            );
            let values = abi.result_words(prog, fid, "result");
            let result_ty = f.ty.params(f.arity as usize).1;
            let fields = record_fields(&prog.shapes, result_ty).expect("record export result");
            let owners = fields
                .iter()
                .enumerate()
                .map(|(i, (_, ty))| (values[i].clone(), ty.clone()))
                .collect::<Vec<_>>();
            let protect = self.protect_values(&owners, "result_fields", "result_cleanup");
            let _ = writeln!(
                out,
                "    {protect}\n    {} converted;",
                crate::ffi::c_name(&r)
            );
            let crate::ffi::CType::Struct {
                fields: c_fields, ..
            } = &r
            else {
                unreachable!()
            };
            for (name, index, ty) in c_fields {
                let _ = writeln!(
                    out,
                    "    converted.{name} = {};",
                    ffi_to_c(ty, &values[*index])
                );
            }
            if !protect.is_empty() {
                out.push_str("    fwp_cleanup_pop(&result_cleanup);\n");
            }
            out.push_str("    /* move C result fields */\n");
            {
                for (_, index, ty) in c_fields {
                    let (_, field_ty) = &fields[*index];
                    if *ty != crate::ffi::CType::Str && crate::rc::needs_rc(&prog.shapes, field_ty)
                    {
                        let drop = self.value_drop(field_ty);
                        let _ = writeln!(out, "    {drop}({});", values[*index]);
                    }
                }
            }
            out.push_str(&return_result);
        } else {
            // Evaluate once and protect the full result until every C
            // string conversion succeeds. Then transfer string owners to
            // the host, which releases them through the matching export.
            let result_ty = f.ty.params(f.arity as usize).1.clone();
            let drop = { self.value_drop(&result_ty) };
            let _ = writeln!(out,
                    "    V result = {call};\n{finish_inputs}    fwp_value_owner owner = {{result, {drop}}}; fwp_cleanup cleanup;\n    fwp_value_protect(&owner, &cleanup);\n    {} converted = {};",
                    crate::ffi::c_name(&r), ffi_to_c(&r, "result"));
            {
                match &r {
                    crate::ffi::CType::Str => {
                        // The result already owns its string: no copy or
                        // retain is needed to give that owner to C.
                    }
                    crate::ffi::CType::Struct { fields, .. } => {
                        let strings: Vec<_> = fields
                            .iter()
                            .filter(|(_, _, ty)| *ty == crate::ffi::CType::Str)
                            .collect();
                        if !strings.is_empty() {
                            out.push_str(
                                "    if (fwp_rc_last(result)) { /* move C result strings */\n",
                            );
                            for (_, index, _) in &strings {
                                let _ = writeln!(out, "        OBJ(result)->f[{index}] = 0;");
                            }
                            out.push_str("    } else {\n");
                            let values = strings
                                .iter()
                                .map(|(_, index, _)| {
                                    (format!("OBJ(result)->f[{index}]"), MT::con("std::String"))
                                })
                                .collect::<Vec<_>>();
                            let retained = self.duplicate_values(
                                &values,
                                "result_strings",
                                "result_strings_cleanup",
                            );
                            let _ = writeln!(out, "        {retained}\n    }}");
                        }
                    }
                    _ => {}
                }
            }
            out.push_str("    (void)fwp_value_finish(&owner, &cleanup);\n");
            if r != crate::ffi::CType::Str {
                out.push_str("    owner.value = result; fwp_value_release(&owner);\n");
            }
            out.push_str(&return_result);
        }
        out
    }
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
fn live_functions(prog: &Program, extra: &[FuncId]) -> Result<Vec<bool>, String> {
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
    crate::ir::reachable_functions(prog, &work)
}

fn generate_mode(prog: &Program, mode: Mode) -> Result<String, String> {
    crate::ir::check_locals(prog)?;
    // Fuse before ownership lowering separates temporary strings from their
    // consumers. Printing's comparison switch does not disable length fusion.
    let direct_output = !std::env::var("FWP_DIRECT_INTEGER_PRINT").is_ok_and(|v| v == "0");
    let scalar_text = scalar_text::lower(prog, direct_output);
    let string_maps = string_map::lower(&scalar_text);
    let region_program = regions::lower(&string_maps);
    let prog = region_program.as_ref();
    crate::ir::check_locals(prog)?;
    let weak_channels = crate::resource::uses_weak_channels(&prog.funcs, &prog.shapes);
    let tests = matches!(mode, Mode::Tests);
    let main = prog.main.unwrap_or(0);
    let roots: Vec<_> = match &mode {
        Mode::Exec(commands, _) => commands.iter().map(|c| c.fid).collect(),
        _ => Vec::new(),
    };
    let live = live_functions(prog, &roots)?;
    // the calling conventions follow the bodies as they are; with counted
    // references, the code is generated from the counted bodies
    let mut abis: Vec<Option<Abi>> = prog.funcs.iter().map(|f| abi_of(prog, f)).collect();
    wide_record_returns(prog, &mut abis);
    if variant_returns_enabled() {
        variant_returns(prog, &mut abis);
    }
    let wide_workers = wide::select(prog);
    for (id, enabled) in wide_workers.iter().enumerate() {
        if *enabled {
            abis[id] = None;
        }
    }
    let resources = prog.funcs.iter().any(|f| {
        f.locals
            .iter()
            .any(|t| crate::resource::contains_resource(&prog.shapes, t))
    });
    let mut borrowing = prog.clone();
    let owned_entries: Vec<_> = abis
        .iter()
        .enumerate()
        .map(|(id, abi)| abi.is_none() || roots.contains(&id))
        .collect();
    borrowing.borrowed_parameters = crate::rc::borrows::infer(prog, &owned_entries, &live);
    let uncounted = &borrowing;
    let counted = counted_program(uncounted);
    let prog = &counted;
    // Ownership lowering introduces temporaries. Check their concrete types
    // as well as source locals before claiming a tracing-free ownership graph.
    let entries = match &mode {
        Mode::Tests => prog.tests.iter().map(|(_, id)| *id).collect(),
        Mode::Exec(commands, _) => commands.iter().map(|c| c.fid).collect(),
        Mode::Service => prog
            .service
            .as_ref()
            .ok_or("no service to serve")?
            .methods
            .iter()
            .map(|m| m.func)
            .collect(),
        Mode::Library(_) => {
            let signatures = export_sigs(prog)?;
            for (name, _, params, result) in &signatures {
                if !params.iter().all(|(_, ty)| crate::ffi::copied_result(ty))
                    || !crate::ffi::copied_result(result)
                {
                    return Err(format!(
                        "ownership: exported function `{name}` requires copied C inputs and scalar, manual-pointer or owned-string results; callbacks have no retained host lifetime"
                    ));
                }
            }
            signatures.iter().map(|(_, fid, _, _)| *fid).collect()
        }
        _ => vec![main],
    };
    let entry_channels = if matches!(&mode, Mode::Service) {
        crate::arc::EntryChannels::GrpcResponses
    } else {
        crate::arc::EntryChannels::Unknown
    };
    crate::arc::check(prog, &entries, entry_channels)?;
    let mut g = Gen {
        resource_captures: crate::resource::has_observable_captures(&prog.funcs, &prog.shapes),
        weak_channels,
        prog,
        uncounted,
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
        borrowed_globals: std::collections::HashSet::new(),
        static_functions: HashMap::new(),
        ffi_decls: String::new(),
        ffi_structs: Vec::new(),
        pb: crate::protobuf::Schema::default(),
        remotes: Vec::new(),
        cli_defs: String::new(),
        cli_flags: HashMap::new(),
        ticks: uses_async(prog) || uses_services(prog),
        unwind: resources
            || prog
                .funcs
                .iter()
                .any(|f| matches!(f.body, Body::RegionEntry { .. }))
            || uses_async(prog)
            || uses_services(prog)
            || tests
            || matches!(mode, Mode::Library(_) | Mode::Service | Mode::Exec(..))
            || prog.funcs.iter().any(|f| {
                matches!(&f.body, Body::Prim(s) if s == "attempt" || s == "run-state")
                    || matches!(&f.body, Body::ForeignC { .. })
                        && f.locals.iter().any(|t| matches!(t, MT::Fun(..)))
            }),
        loops: Vec::new(),
        hofs: Vec::new(),
        inline_sort_keys: Vec::new(),
        abis,
        wide_workers,
        noesc: crate::escape::params(prog),
        callbacks: Vec::new(),
        owned_callbacks: Vec::new(),
        owned_fold_callbacks: Vec::new(),
        owned_right_fold_callbacks: Vec::new(),
    };
    if let Mode::Exec(cmds, _) = &mode {
        for command in cmds {
            if prog.funcs[command.fid].arity > 0 {
                g.used_closures[command.fid] = true;
            }
        }
    }
    let mut bodies = String::new();
    for id in (0..prog.funcs.len()).filter(|&id| live[id]) {
        bodies.push_str(&g.func(id)?);
        bodies.push('\n');
    }
    let mut i = 0;
    while i < g.hofs.len() {
        let hof = g.hofs[i].clone();
        let borrowed_step = g.borrowed_hof_step(i, &hof);
        if matches!(hof.0.as_str(), "array.generate" | "fold" | "fold-right")
            && borrowed_step.is_none()
        {
            // The ordinary loop calls the owned entry. A borrowed loop calls
            // its specialized body directly and needs no generic adapter.
            g.used_closures[hof.1] = true;
        }
        if let Some(body) = &borrowed_step {
            bodies.push_str(body);
        }
        let loop_ops = if hof.0 == "loop" {
            let step = prog.funcs[hof.1]
                .ty
                .params(prog.funcs[hof.1].arity as usize)
                .1
                .clone();
            Some(g.loop_ops(&step)?)
        } else {
            None
        };
        let result_ops = if hof.0 == "array.generate" {
            let ty = prog.funcs[hof.1].ty.params(hof.2 + 1).1.clone();
            Some(g.desc(&ty))
        } else if matches!(hof.0.as_str(), "map" | "filter" | "take-while" | "zip-with") {
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
        let fold_drop = if matches!(hof.0.as_str(), "fold" | "fold-right" | "loop") {
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
            loop_ops.as_deref(),
            result_ops.as_deref(),
            fold_drop.as_deref(),
            borrowed_step.is_some(),
        ));
        bodies.push('\n');
        i += 1;
    }
    // the specialized loops, which may use others
    let mut li = 0;
    while li < g.loops.len() {
        let (step, record) = g.loops[li];
        bodies.push_str(&g.loop_def(step, record));
        bodies.push('\n');
        li += 1;
    }
    for callback in g.inline_sort_keys.clone() {
        bodies.push_str(&g.inline_sort_keys_def(callback));
    }
    let mut lib_defs = String::new();
    if let Mode::Library(callbacks) = mode {
        // Windows automatic exports omit names also present in import
        // libraries (for example CRT `norm`). Export the language interface
        // explicitly, including its ownership release functions.
        let export_attribute = "#ifdef _WIN32\n__declspec(dllexport)\n#endif\n";
        // Register exit cleanup before runtime dependencies can be loaded.
        // Darwin terminates dlopened images before archive destructors. The
        // guarded finish also runs at dynamic unload; repeated calls are safe.
        lib_defs.push_str(
            "static int fwp_lib_ready = 0;\n#if FWP_NATIVE_HEAP\nstatic void fwp_lib_finish(void);\n#endif\n\nstatic void fwp_lib_init(void) {\n    if (fwp_lib_ready) {\n#ifdef FWP_RETAINED_CALLBACKS\n        fwp_callback_check_thread();\n#endif\n        return;\n    }\n#ifdef FWP_RETAINED_CALLBACKS\n    fwp_callback_runtime_init();\n#endif\n#if FWP_NATIVE_HEAP\n    if (atexit(fwp_lib_finish)) fwp_trap(\"cannot register library cleanup\");\n    fwp_closure_drop_init();\n#endif\n    fwp_lib_ready = 1;\n    fwp_fns = fwp_fn_table;\n    fwp_prog_out = stdout;\n    fwp_start_time = fwp_now_ns();\n    fwp_seed_rng();\n    fwp_init_consts();\n}\n\n",
        );
        for (cname, fid, ps, r) in export_sigs(prog)? {
            let mut all: Vec<crate::ffi::CType> = ps.iter().map(|(_, c)| c.clone()).collect();
            all.push(r.clone());
            g.ffi_structs(&all);
            lib_defs.push_str(&g.library_entry(&cname, fid, &ps, &r, false));
            if callbacks.contains(&cname) {
                lib_defs.push_str(&g.library_registration(&cname, fid, &ps));
                lib_defs.push_str(&g.library_entry(&cname, fid, &ps, &r, true));
            }
            if library_result_needs_release(&r) {
                let _ = writeln!(
                    lib_defs,
                    "{export_attribute}void fwp_release_{cname}({} result) {{\n#ifdef FWP_RETAINED_CALLBACKS\n    fwp_callback_check_thread();\n#endif",
                    crate::ffi::c_name(&r)
                );
                {
                    let drop = g.value_drop(&MT::con("std::String"));
                    let values = match &r {
                        crate::ffi::CType::Str => vec!["result".into()],
                        crate::ffi::CType::Struct { fields, .. } => fields
                            .iter()
                            .filter(|(_, _, ty)| *ty == crate::ffi::CType::Str)
                            .map(|(name, _, _)| format!("result.{name}"))
                            .collect(),
                        _ => unreachable!(),
                    };
                    for value in values {
                        let _ =
                            writeln!(lib_defs, "    {drop}(PTR({value} - offsetof(fwp_str, d)));");
                    }
                }
                lib_defs.push_str("}\n\n");
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
            let result_desc = g.desc(prog.funcs[fid].ty.params(n).1);
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
    {name}, {export}, {usage}, {help}, {arity}, exec_params{i}, exec_param_names{i},
    {has_opts}, {fallback}, {nflags}, {nfields}, {flags}, exec_pos{i}, {npos}, {nreq}, {variadic}, {unit_last},
    {outcome}, {ro}, {rs}, {err}, {ropt}, {rlist}, {od}, exec_out_header{i}, sizeof exec_out_header{i}, {llist}, {idd},
    {itype}, exec_in_fp{i}, exec_caf{i}, {callable}, {result_desc}}};
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
                arity = n,
                callable = if n == 0 {
                    "0".into()
                } else {
                    format!("&fc{fid}")
                },
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
            // Service dispatch uses the table in both ownership modes.
            if prog.funcs[m.func].arity > 0 {
                g.used_closures[m.func] = true;
            }
            {
                let function = &prog.funcs[m.func];
                let result = function.ty.params(function.arity as usize).1.clone();
                spec.result_drop = g.value_drop(&result);
            }
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
                "{def}\nstatic const fwp_remote rs{id} = {{{what}, {env}, {addr}, {init}, {input_drop}}};",
                id = r.id,
                what =
                    c_string_literal(format!("{}.{}", r.remote.module, r.remote.method).as_bytes()),
                env = c_string_literal(crate::protobuf::env_var(&r.remote.module).as_bytes()),
                addr = c_string_literal(r.remote.default_addr.as_bytes()),
                input_drop = r.input_drop,
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
    {
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
                let dup = g.value_dup(ty);
                let _ = writeln!(
                    arguments,
                    "    if (start <= {j} && {j} - start < n) {{ {dup}(a[{j} - start]);{tracked} }}"
                );
                let drop = g.value_drop(ty);
                if g.unwind {
                    let _ = writeln!(caps, "    if (CLO(v)->n > {j}) {drop}(CLO(v)->a[{j}]);");
                } else {
                    let _ = writeln!(caps, "    if (CLO(v)->n > {j}) {{ if (duplicate) {dup}(CLO(v)->a[{j}]); else {drop}(CLO(v)->a[{j}]); }}");
                }
                if !matches!(f.body, Body::Expr(_) | Body::Ctor(_)) {
                    let consumed =
                        matches!(&f.body, Body::Prim(sym) if crate::rc::prim_consumes(sym, j));
                    if !consumed {
                        let _ = writeln!(cleanup, "    {drop}(a[{j}]);");
                    }
                }
            }
            for (j, ty) in f.ty.params(usize::MAX).0.iter().enumerate() {
                if !crate::rc::needs_rc(&prog.shapes, ty) {
                    continue;
                }
                let drop = g.value_drop(ty);
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
            let release = "fwp_rc_free_obj(v);";
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
        if crate::rc::needs_rc(&prog.shapes, &f.ty) {
            let drop = g.value_drop(&f.ty);
            // Initialization may yield and reenter. Replacing a result cached
            // during evaluation releases that cache owner, preserving callers.
            if g.borrowed_globals.contains(&id) {
                // Both ownership entries share first-use initialization. Keep
                // its construction/unwind storage out of repeated reads.
                let _ = writeln!(caf_defs,
                    "static int fwp_caf_state{id}; static V fwp_caf_value{id};\nstatic __attribute__((noinline)) V fwp_caf_init{id}(void) {{ V next = f{id}(); V previous = fwp_caf_state{id} ? fwp_caf_value{id} : 0; fwp_caf_value{id} = next; fwp_caf_state{id} = 1; {drop}(previous); return fwp_caf_value{id}; }}\nstatic V caf{id}(void) {{ V value = fwp_caf_state{id} ? fwp_caf_value{id} : fwp_caf_init{id}(); fwp_rc_dup(value); return value; }}\nstatic inline V fwp_caf_borrow{id}(void) {{ return fwp_caf_state{id} ? fwp_caf_value{id} : fwp_caf_init{id}(); }}");
            } else {
                let _ = writeln!(caf_defs,
                    "static int fwp_caf_state{id}; static V fwp_caf_value{id};\nstatic V caf{id}(void) {{ if (!fwp_caf_state{id}) {{ V next = f{id}(); V previous = fwp_caf_state{id} ? fwp_caf_value{id} : 0; fwp_caf_value{id} = next; fwp_caf_state{id} = 1; {drop}(previous); }} fwp_rc_dup(fwp_caf_value{id}); return fwp_caf_value{id}; }}");
            }
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
    let main_drop = if crate::rc::needs_rc(&prog.shapes, &main_ty) {
        format!("{}(r);", g.value_drop(&main_ty))
    } else {
        String::new()
    };
    let mut out = String::new();
    out.push_str("/* Generated by fwp. */\n");
    // Exact-format headers can include CRT headers before the runtime does.
    // Select the same API contract before any such header chooses a default.
    out.push_str(
        "#if defined(_WIN32) && !defined(_WIN32_WINNT)\n#define _WIN32_WINNT 0x0a00\n#endif\n",
    );
    fn exact_type(t: &MT) -> bool {
        match t {
            MT::Con(n, a) => {
                matches!(n.as_str(), "std::F16" | "std::BF16" | "std::F128")
                    || a.iter().any(exact_type)
            }
            MT::Record(fields) => fields.iter().any(|(_, t)| exact_type(t)),
            MT::Fun(a, b) => exact_type(a) || exact_type(b),
            MT::Nat(_) => false,
        }
    }
    let exact = g.descs.keys().any(exact_type)
        || prog
            .funcs
            .iter()
            .enumerate()
            .any(|(i, f)| live[i] && (exact_type(&f.ty) || f.locals.iter().any(exact_type)));
    if exact {
        out.push_str("#ifndef _GNU_SOURCE\n#define _GNU_SOURCE\n#endif\n");
        out.push_str(crate::float_codegen::MARK);
        let _ = writeln!(
            out,
            "/* Exact float core {}. Link the emitted .float.c and .float.cpp companions. */",
            crate::float_codegen::source_stamp()
        );
        out.push_str(crate::softfloat::C_HEADER);
        out.push('\n');
    }

    if weak_channels {
        out.push_str("#define FWP_WEAK_CHANNELS 1\n");
    }
    if tests {
        out.push_str("#define FWP_TESTS 1\n");
    }
    if matches!(&mode, Mode::Library(callbacks) if !callbacks.is_empty()) {
        out.push_str("#define FWP_RETAINED_CALLBACKS 1\n");
    }
    if matches!(mode, Mode::Library(_)) {
        out.push_str("#define FWP_LIBRARY 1\n");
    }
    let _ = writeln!(out, "#define FWP_UNWIND {}", u8::from(g.unwind));
    let _ = writeln!(out, "#define FWP_TASK_TICKS {}", u8::from(g.ticks));
    let packed = std::env::var("FWP_PACKED_ARRAYS").map_or(true, |v| v != "0");
    let _ = writeln!(out, "#define FWP_PACKED_ARRAYS {}", u8::from(packed));
    let web = uses_web(prog);
    let tls = uses_services || web || uses_tls(prog);
    if uses_services || web {
        out.push_str("#define FWP_GCTX_OWNERS 1\n");
    }
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
        // malloc and the static region, before the allocator uses them
        if i == 0 && stat.is_some() {
            out.push_str(STATIC_RUNTIME);
            out.push('\n');
        }
    }
    if prog
        .funcs
        .iter()
        .any(|f| matches!(f.body, Body::RegionEntry { .. }))
    {
        out.push_str(include_str!("../runtime/fwp_rt_region.c"));
        out.push('\n');
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
    // Descriptor-driven reconstruction uses the same typed drops as IR owners.
    for i in 0..g.drop_defs.len() {
        let _ = writeln!(out, "static void fwp_drop{}(V v);", i);
    }
    // tentative declarations, so descriptors can refer to each other
    for i in 0..g.desc_defs.len() {
        let _ = writeln!(out, "static const fwp_desc d{};", i);
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
    // C aggregate worker results; the target ABI chooses their register classes.
    for n in 1..=MAX_UNBOXED {
        let _ = writeln!(out, "typedef struct {{ V f[{}]; }} fwp_r{};", n, n);
    }
    for (id, abi) in g.abis.iter().enumerate() {
        if let Some(abi) = abi.as_ref().filter(|a| live[id] && a.ret.is_some()) {
            let fields: Vec<_> = abi
                .result_numbers(prog, id)
                .into_iter()
                .enumerate()
                .map(|(i, n)| {
                    format!(
                        "{} f{i};",
                        n.map_or_else(|| "V".into(), NativeNumber::c_type)
                    )
                })
                .collect();
            let _ = writeln!(out, "typedef struct {{ {} }} fwp_wr{id};", fields.join(" "));
        }
    }
    for (id, abi) in g.abis.iter().enumerate() {
        if let Some(abi) = abi.as_ref().filter(|_| live[id]) {
            let _ = writeln!(out, "{};", abi.sig(prog, id));
        }
    }
    out.push_str(&wide::declarations(g.uncounted, &g.wide_workers));
    for (id, enabled) in g.wide_workers.iter().enumerate() {
        if *enabled && live[id] {
            let _ = writeln!(out, "{};", wide::signature(g.uncounted, id));
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
        if let Some(fields) = record_fields(&prog.shapes, &prog.funcs[*step].locals[0]) {
            if fields
                .iter()
                .all(|(_, ty)| record_fields(&prog.shapes, ty).is_none())
            {
                let parameters = (0..fields.len())
                    .map(|i| format!("V a{i}"))
                    .collect::<Vec<_>>()
                    .join(", ");
                let _ = writeln!(out, "static V fwp_loop_fields{step}({parameters});");
            }
        }
    }
    {
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
    for callback in &g.inline_sort_keys {
        let _ = writeln!(out, "static V fwp_sort_keys{callback}(V xs);");
    }
    // Constant applicative forms retain their typed cached owners.
    out.push_str(&caf_defs);
    // Only runtime function values and external dispatch need generic entries.
    // Keep table positions and names for every id, without retaining adapters
    // (and their otherwise unused bodies) for exclusively direct calls.
    for (id, f) in prog.funcs.iter().enumerate().filter(|(id, _)| live[*id]) {
        if f.arity > 0 && g.used_closures[id] {
            let args: Vec<String> = (0..f.arity).map(|i| format!("a[{}]", i)).collect();
            let mut share_args = String::new();
            {
                for (j, ty) in f.ty.params(f.arity as usize).0.iter().enumerate() {
                    if crate::rc::needs_rc(&prog.shapes, ty) {
                        let _ = write!(share_args, "fwp_rc_share(a[{j}]); ");
                    }
                }
            }
            let _ = writeln!(
                out,
                "static V e{}(V *a) {{ {}return fwp_rc_shared(f{}({})); }}",
                id,
                share_args,
                id,
                args.join(", ")
            );
        }
    }
    out.push_str(&owned_defs);
    out.push_str("static const fwp_fninfo fwp_fn_table[] = {\n");
    for (id, f) in prog.funcs.iter().enumerate() {
        let entry = if f.arity > 0 && live[id] && g.used_closures[id] {
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
            if live[id] && g.used_closures[id] && f.arity > 0 {
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
    // Use the actual closure type, including its flexible capture array. Fill
    // addresses during existing constant initialization: wasm32 cannot relocate
    // a 32-bit pointer widened into a static 64-bit V initializer. This single
    // representation works on all targets and allocates no runtime heap storage.
    let mut static_functions: Vec<_> = g.static_functions.iter().collect();
    static_functions.sort_by_key(|(_, id)| **id);
    let mut static_function_init = String::new();
    for ((function, captures), id) in static_functions {
        let zeroes = vec!["0"; captures.len()].join(", ");
        let _ = writeln!(
            out,
            "static fwp_clo fwp_static_function{id} = {{{function}, {}, {{{zeroes}}}}};",
            captures.len()
        );
        for (index, capture) in captures.iter().enumerate() {
            let _ = writeln!(
                static_function_init,
                "    fwp_static_function{id}.a[{index}] = PTR(&fc{capture});"
            );
        }
    }
    g.const_init.insert_str(0, &static_function_init);
    out.push('\n');
    if !g.ffi_decls.is_empty() {
        out.push_str(crate::ffi::PREAMBLE);
        out.push_str(&g.ffi_decls);
    }
    out.push_str(&remote_defs);
    out.push_str(&g.cli_defs);
    out.push_str(&bodies);
    if let Mode::Library(_) = mode {
        let _ = write!(
            out,
            "static void fwp_init_consts(void) {{\n{}}}\n\n{}\n#if FWP_NATIVE_HEAP\nstatic void __attribute__((destructor)) fwp_lib_finish(void) {{\n    if (!fwp_lib_ready) return;\n#ifdef FWP_RETAINED_CALLBACKS\n    fwp_callback_runtime_finish();\n#endif\n    fwp_lib_ready = 0;\n#ifdef FWP_GCTX_OWNERS\n    g_connections_finish();\n#endif\n    fwp_library_tasks_finish();\n    fwp_caf_finish();\n    /* Ownership observation point: before runtime teardown. */\n    fwp_tape_finish();\n    fwp_heap_finish();\n#ifdef FWP_GCTX_OWNERS\n    g_environment_finish();\n#endif\n#ifdef FWP_TLS\n    fwp_tls_clients_finish();\n#endif\n    fwp_closure_drop_finish();\n    fwp_sockets_finish();\n}}\n#endif\n",
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
        let mut r = String::from("    volatile int pass = 0, fail = 0;\n");
        for (name, id) in &prog.tests {
            let _ = write!(
                r,
                r#"    {{
        fwp_test_active = 1; fwp_test_failure = 0;
        fwp_test_cleanup = fwp_cleanups; fwp_test_handler = fwp_handlers;
        fwp_test_state_depth = fwp_state_len;
        if (setjmp(fwp_test_jump) == 0) {{
        fwp_handler h; h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups; fwp_handlers = &h;
        fwp_budget = 0;
        if (setjmp(h.jb) == 0) {{
            V v = caf{id}();
            fwp_handlers = h.prev;
            fwp_tasks_finish();
            if (v == FWP_TRUE) {{ pass++; printf("test %s ... ok\n", {name}); }}
            else {{ fail++; printf("test %s ... FAILED\n", {name}); }}
        }} else {{
            fwp_handlers = h.prev; fwp_state_restore(h.state_depth); fail++;
            fwp_value_owner error = {{h.value, h.desc->drop}};
            fwp_cleanup error_cleanup; fwp_cleanup_push(&error_cleanup, fwp_value_release, &error);
            fwp_tasks_abort();
            fwp_buf b = {{0}};
            fwp_cleanup buffer_cleanup; fwp_cleanup_push(&buffer_cleanup, fwp_buf_release, &b);
            fwp_write(&b, h.value, h.desc, 1);
            printf("test %s ... FAILED (error: %s)\n", {name}, b.d ? b.d : "");
            fwp_cleanup_pop(&buffer_cleanup); fwp_buf_release(&b);
            fwp_cleanup_pop(&error_cleanup); fwp_value_release(&error);
        }}
        }} else {{
            fwp_handlers = fwp_test_handler;
            fwp_state_restore(fwp_test_state_depth);
            fail++;
            if (fwp_test_failure == 1)
                printf("test %s ... FAILED (trap: %s)\n", {name}, fwp_test_message);
            else if (fwp_test_failure == 2)
                printf("test %s ... FAILED (exit %d)\n", {name}, fwp_test_exit_code);
            else printf("test %s ... FAILED (cancelled)\n", {name});
            free(fwp_test_message); fwp_test_message = NULL;
        }}
        fwp_tasks_finish();
        fwp_test_active = 0;
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
    fwp_heap_start();
    fwp_stack_guard_init(fwp_main_stack);
#if defined(_WIN32) && defined(FWP_STATIC_MEMORY)
    fwp_static_touch_stack();
    fwp_tasks_init();
#endif
    fwp_init_consts();
{run}
    fwp_caf_finish();
#ifndef FWP_FIBERS
#ifdef FWP_GCTX_OWNERS
    g_connections_finish();
#endif
    fwp_native_tasks_finish();
#endif
    /* Ownership observation point: before runtime teardown. */
#ifdef FWP_FIBERS
    fwp_fiber_tasks_finish();
#endif
    fflush(stdout);
    return 0;
}}

#ifdef _WIN32
static DWORD WINAPI fwp_windows_main_thread(void *argument) {{
    fwp_main_thread(argument);
    return 0;
}}
#endif

int main(int argc, char **argv) {{
#ifdef _WIN32
    argv = fwp_win_arguments(&argc);
    if (_setmode(_fileno(stdin), _O_BINARY) < 0 || _setmode(_fileno(stdout), _O_BINARY) < 0 ||
        _setmode(_fileno(stderr), _O_BINARY) < 0)
        fwp_trap("cannot configure binary standard streams");
#endif
    fwp_fns = fwp_fn_table;
    fwp_prog_out = stdout;
    fwp_argc = argc;
    fwp_argv = argv;
    fwp_start_time = fwp_now_ns();
    fwp_seed_rng();
    setvbuf(stdout, 0, _IOFBF, 1 << 16);
#ifdef __wasi__
    fwp_main_thread(0);
#elif defined(_WIN32)
#ifdef FWP_STATIC_MEMORY
    fwp_static_init();
    fwp_main_stack = FWP_STATIC_STACK;
    DWORD stack_flags = 0; /* commit the configured main stack at startup */
#else
    DWORD stack_flags = STACK_SIZE_PARAM_IS_A_RESERVATION;
#endif
    HANDLE thread = CreateThread(NULL, fwp_main_stack, fwp_windows_main_thread, NULL,
                                 stack_flags, NULL);
    if (!thread) fwp_trap("cannot create main runtime thread");
    if (WaitForSingleObject(thread, INFINITE) != WAIT_OBJECT_0) abort();
    CloseHandle(thread);
    free(argv);
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

/// A private temporary directory (mode 0700 on Unix), created atomically
/// so an existing directory and its files are never reused,
/// removed with its contents when dropped.
pub struct TempDir {
    path: std::path::PathBuf,
}

impl TempDir {
    pub fn new(prefix: &str) -> Result<TempDir, String> {
        Self::in_parent(&std::env::temp_dir(), prefix)
    }

    pub(crate) fn in_parent(base: &std::path::Path, prefix: &str) -> Result<TempDir, String> {
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
/// the process id and the attempt number). Exclusive creation checks collisions.
fn random_suffix(attempt: u32) -> String {
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

/// Expand linked C/assembly sources with the same preprocessing options as the
/// native build. Cache lookups must observe included header edits and errors too.
pub(crate) fn preprocess_linked_sources(
    inputs: &[String],
    c_source: &str,
    opt: &str,
) -> Result<Vec<u8>, String> {
    let cc = c_compiler()?;
    let mut command = cc_command(&cc);
    command
        .arg(opt)
        .args(parallel_codegen(&cc.0, opt, c_source))
        // Keep line markers: they distinguish includes and translation units.
        .args(["-std=gnu11", "-ffp-contract=off", "-w", "-E"])
        .args(inputs);
    let output = command
        .output()
        .map_err(|e| format!("cannot preprocess linked sources: {e}"))?;
    if !output.status.success() {
        return Err(compiler_failure(
            "cannot preprocess linked sources",
            &output,
        ));
    }
    Ok(output.stdout)
}

/// Preserve failed compiler output and termination details for native and FFI builds.
pub(crate) fn compiler_failure(context: &str, output: &std::process::Output) -> String {
    let stdout = String::from_utf8_lossy(&output.stdout);
    let stderr = String::from_utf8_lossy(&output.stderr);
    let mut message = format!("{context}:\n{stdout}{stderr}");
    if !message.ends_with('\n') {
        message.push('\n');
    }
    write!(message, "compiler status: {}", output.status).unwrap();
    #[cfg(unix)]
    {
        write!(
            message,
            " (signal={:?}, core_dumped={})",
            output.status.signal(),
            output.status.core_dumped()
        )
        .unwrap();
    }
    message
}

fn run_cc(cmd: &mut std::process::Command, cc: &str) -> Result<(), String> {
    let res = cmd
        .output()
        .map_err(|e| format!("cannot run C compiler `{}`: {}", cc, e))?;
    if !res.status.success() {
        let err = String::from_utf8_lossy(&res.stderr);
        // a program that uses TLS needs OpenSSL's headers and libraries
        let stdout = String::from_utf8_lossy(&res.stdout);
        let tls = err.contains("openssl/")
            || err.contains("-lssl")
            || stdout.contains("openssl/")
            || stdout.contains("-lssl");
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
            _ if tls && cfg!(windows) => "\nthe program uses TLS, which needs native OpenSSL 3 headers and DLLs (Windows: set FWP_OPENSSL_DIR to the installation prefix and add its bin directory to PATH; see docs/tls.md)".to_string(),
            _ if tls && native_is_macos() => "\nthe program uses TLS, which needs OpenSSL 3's headers and libraries (macOS: brew install openssl@3; set FWP_OPENSSL_DIR to brew --prefix openssl@3; see docs/tls.md)".to_string(),
            _ if tls => "\nthe program uses TLS, which needs OpenSSL 3's headers and libraries (Debian and Ubuntu: libssl-dev; see docs/tls.md)".to_string(),
            _ => String::new(),
        };
        return Err(format!(
            "{}{}",
            compiler_failure("C compiler failed", &res),
            hint
        ));
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
/// link-time optimization splits it into partitions for parallel compilation.
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
    let floats = crate::float_codegen::link_archives(c_source, &cc, opt, false, dir.path())?;
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
                .args(&floats)
                .args(crate::ffi::links())
                .args(tls_links(c_source))
                .args(native_runtime_links()),
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
    let floats = crate::float_codegen::link_archives(c_source, &cc, opt, false, dir.path())?;
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
                let mut members = vec![obj.clone()];
                for archive in &floats {
                    run_cc(
                        std::process::Command::new(&ar)
                            .current_dir(dir.path())
                            .arg("x")
                            .arg(archive),
                        &ar,
                    )?;
                    members.push(dir.join("float.c.o"));
                    members.push(dir.join("float.cpp.o"));
                }
                run_cc(
                    std::process::Command::new(&ar)
                        .arg("rcs")
                        .arg(output)
                        .args(&members),
                    &ar,
                )
            }
            LibKind::Shared => run_cc(
                cc_command(&cc)
                    .arg(shared_library_flag())
                    .arg("-o")
                    .arg(output)
                    .arg(&obj)
                    .args(&floats)
                    .args(crate::ffi::links())
                    .args(tls_links(c_source))
                    .args(native_runtime_links()),
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
        let float_cc = (cc.clone(), vec!["--target=wasm32-wasi".into()]);
        let floats =
            crate::float_codegen::link_archives(c_source, &float_cc, opt, true, dir.path())?;
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
                    .args(&floats)
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
        let floats = crate::float_codegen::link_archives(c_source, &cc, opt, false, dir.path())?;
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
                            .args(&floats)
                            .args(crate::ffi::links())
                            .args(tls_links(c_source))
                            .args(native_runtime_links()),
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
                    .args(&floats)
                    .args(crate::ffi::links())
                    .args(tls_links(c_source))
                    .args(native_runtime_links()),
                &cc.0,
            ),
        }
    };
    let _ = std::fs::remove_file(&c_path);
    result
}
