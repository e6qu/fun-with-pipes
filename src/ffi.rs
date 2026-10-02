//! The C ABI of `foreign "C"` functions and of exported library functions:
//! how fwp types map to C types. The C backend calls C functions directly;
//! the interpreter calls them through a generated shim library (built with
//! the system C compiler and loaded with `dlopen`) whose functions take
//! their arguments as 64-bit words.
//!
//! | fwp | C |
//! |---|---|
//! | `I8`..`I64`, `U8`..`U64` | `int8_t`..`uint64_t` |
//! | `F32`, `F64` | `float`, `double` |
//! | `Bool` | `_Bool` |
//! | `()` | `void` (as a result; unit parameters are dropped) |
//! | `String` | `const char *` (NUL-terminated, UTF-8) |
//! | `Bytes` | `const uint8_t *` (parameters only) |
//! | `Ptr[T]` | `void *` |
//! | `Option[Ptr[T]]` | `void *`, `NULL` for `None` |
//! | `repr(C)` record | struct with the fields in declaration order |
//! | function | function pointer (a callback) |

use std::fmt::Write;
use std::sync::Mutex;

use crate::ir::*;

#[derive(Clone, Debug, PartialEq)]
pub enum CType {
    Void,
    /// `bits` 0: pointer-sized (`size_t`, `ptrdiff_t`).
    Int {
        bits: u32,
        signed: bool,
    },
    F32,
    F64,
    Bool,
    Str,
    Bytes,
    Ptr,
    OptPtr,
    /// Struct name and fields in declaration order: (name, index in the
    /// canonical record, type).
    Struct {
        name: String,
        fields: Vec<(String, usize, CType)>,
    },
    Callback {
        params: Vec<CType>,
        ret: Box<CType>,
    },
}

/// Extra inputs for the C compiler and linker (`--link`): `-lname`,
/// `-Ldir`, C sources, objects and archives.
static LINKS: Mutex<Vec<String>> = Mutex::new(Vec::new());

pub fn set_links(links: Vec<String>) {
    *LINKS.lock().unwrap() = links;
}

pub fn links() -> Vec<String> {
    LINKS.lock().unwrap().clone()
}

fn short(name: &str) -> &str {
    name.rsplit("::").next().unwrap_or(name)
}

/// Map a monomorphic type to its C representation.
pub fn classify(prog: &Program, mt: &MT) -> Result<CType, String> {
    match mt {
        MT::Record(fs) if fs.is_empty() => Ok(CType::Void),
        MT::Fun(..) => {
            let mut params = Vec::new();
            let mut cur = mt;
            while let MT::Fun(a, b) = cur {
                let p = classify(prog, a)?;
                if p != CType::Void {
                    params.push(p);
                }
                cur = b;
            }
            for p in &params {
                if matches!(
                    p,
                    CType::Struct { .. } | CType::Callback { .. } | CType::Bytes
                ) {
                    return Err(format!("callbacks cannot take `{}` parameters", mt));
                }
            }
            let ret = classify(prog, cur)?;
            if matches!(ret, CType::Callback { .. } | CType::Bytes) {
                return Err(format!("callbacks cannot return `{}`", cur));
            }
            Ok(CType::Callback {
                params,
                ret: Box::new(ret),
            })
        }
        MT::Con(n, args) => {
            let int = |bits, signed| Ok(CType::Int { bits, signed });
            match n.as_str() {
                "std::I8" => int(8, true),
                "std::I16" => int(16, true),
                "std::I32" => int(32, true),
                "std::I64" => int(64, true),
                "std::ISize" => int(0, true),
                "std::U8" => int(8, false),
                "std::U16" => int(16, false),
                "std::U32" => int(32, false),
                "std::U64" => int(64, false),
                "std::USize" => int(0, false),
                "std::F32" => Ok(CType::F32),
                "std::F64" => Ok(CType::F64),
                "std::Bool" => Ok(CType::Bool),
                "std::String" => Ok(CType::Str),
                "std::Bytes" => Ok(CType::Bytes),
                "std::Ptr" => Ok(CType::Ptr),
                "std::Option" if matches!(args.first(), Some(MT::Con(p, _)) if p == "std::Ptr") => {
                    Ok(CType::OptPtr)
                }
                _ => match prog.repr_c.get(n) {
                    Some(order) => {
                        let Some(TypeShape::Record(canon)) = prog.shapes.get(mt) else {
                            return Err(format!("internal: no shape for `{}`", mt));
                        };
                        let mut fields = Vec::new();
                        for f in order {
                            let idx = canon.iter().position(|(l, _)| l == f).unwrap_or(0);
                            let ft = classify(prog, &canon[idx].1)?;
                            if matches!(
                                ft,
                                CType::Void
                                    | CType::Struct { .. }
                                    | CType::Callback { .. }
                                    | CType::Bytes
                            ) {
                                return Err(format!(
                                    "field `{}` of `repr(C)` record `{}` has a type C structs cannot hold",
                                    f, mt
                                ));
                            }
                            fields.push((f.replace('-', "_"), idx, ft));
                        }
                        Ok(CType::Struct {
                            name: short(n).to_string(),
                            fields,
                        })
                    }
                    None => Err(format!(
                        "`{}` has no C representation (records need `repr(C)`)",
                        mt
                    )),
                },
            }
        }
        _ => Err(format!("`{}` has no C representation", mt)),
    }
}

/// The C type of a numeric type (as used by `ptr.read` and `ptr.write`).
pub fn classify_scalar(mt: &MT) -> CType {
    let int = |bits, signed| CType::Int { bits, signed };
    match mt {
        MT::Con(n, _) => match n.as_str() {
            "std::I8" => int(8, true),
            "std::I16" => int(16, true),
            "std::I32" => int(32, true),
            "std::U8" => int(8, false),
            "std::U16" => int(16, false),
            "std::U32" => int(32, false),
            "std::U64" | "std::USize" => int(64, false),
            "std::F32" => CType::F32,
            "std::F64" => CType::F64,
            _ => int(64, true),
        },
        _ => int(64, true),
    }
}

/// C parameter types (unit parameters dropped) and result type of a
/// function instance.
pub fn signature(prog: &Program, f: &Func) -> Result<(Vec<(usize, CType)>, CType), String> {
    let (ps, r) = f.ty.params(f.arity as usize);
    let mut params = Vec::new();
    for (i, p) in ps.iter().enumerate() {
        let c = classify(prog, p)?;
        if c != CType::Void {
            params.push((i, c));
        }
    }
    let ret = classify(prog, r)?;
    if ret == CType::Bytes {
        return Err("`Bytes` cannot be returned from C (its length is unknown)".into());
    }
    Ok((params, ret))
}

/// The C spelling of a type (callbacks are passed as `void *`).
pub fn c_name(t: &CType) -> String {
    match t {
        CType::Void => "void".into(),
        CType::Int { bits: 0, signed } => if *signed { "ptrdiff_t" } else { "size_t" }.into(),
        CType::Int { bits, signed } => {
            format!("{}int{}_t", if *signed { "" } else { "u" }, bits)
        }
        CType::F32 => "float".into(),
        CType::F64 => "double".into(),
        CType::Bool => "_Bool".into(),
        CType::Str => "const char *".into(),
        CType::Bytes => "const uint8_t *".into(),
        CType::Ptr | CType::OptPtr | CType::Callback { .. } => "void *".into(),
        CType::Struct { name, .. } => format!("struct fwp_c_{}", name),
    }
}

/// Struct definitions for every struct among `types` (once each).
pub fn struct_defs(types: &[CType], out: &mut String, seen: &mut Vec<String>) {
    for t in types {
        match t {
            CType::Struct { name, fields } => {
                if seen.contains(name) {
                    continue;
                }
                seen.push(name.clone());
                let _ = writeln!(out, "struct fwp_c_{} {{", name);
                for (f, _, ft) in fields {
                    let _ = writeln!(out, "    {} {};", c_name(ft), f);
                }
                out.push_str("};\n");
            }
            CType::Callback { params, ret } => {
                struct_defs(params, out, seen);
                struct_defs(std::slice::from_ref(ret), out, seen);
            }
            _ => {}
        }
    }
}

/// A prototype bound to `symbol` under a private C name.
pub fn prototype(
    cname: &str,
    symbol: &str,
    params: &[CType],
    ret: &CType,
    variadic: Option<u32>,
) -> String {
    let mut ps: Vec<String> = params.iter().map(c_name).collect();
    if let Some(n) = variadic {
        ps.truncate(n as usize);
        ps.push("...".into());
    }
    if ps.is_empty() {
        ps.push("void".into());
    }
    format!(
        "extern {} {}({}) __asm__(FWP_SYM(\"{}\"));\n",
        c_name(ret),
        cname,
        ps.join(", "),
        symbol
    )
}

/// Preamble for code that declares foreign functions.
pub const PREAMBLE: &str = "#define FWP_XSTR(x) #x\n#define FWP_STR(x) FWP_XSTR(x)\n#define FWP_SYM(s) FWP_STR(__USER_LABEL_PREFIX__) s\n";

// ----- the interpreter's shim ---------------------------------------------------

/// Convert a 64-bit word to a C value.
fn from_word(t: &CType, w: &str) -> String {
    match t {
        CType::Int { .. } => format!("({})({})", c_name(t), w),
        CType::F32 => format!("fwp_w2f({})", w),
        CType::F64 => format!("fwp_w2d({})", w),
        CType::Bool => format!("(({}) != 0)", w),
        CType::Str | CType::Bytes | CType::Ptr | CType::OptPtr => {
            format!("(({})(uintptr_t)({}))", c_name(t), w)
        }
        CType::Struct { name, .. } => {
            format!("fwp_w2s_{}((const uint64_t *)(uintptr_t)({}))", name, w)
        }
        CType::Callback { .. } => format!("((void *)(uintptr_t)({}))", w),
        CType::Void => "0".into(),
    }
}

/// Convert a C value to a 64-bit word.
fn to_word(t: &CType, e: &str) -> String {
    match t {
        CType::Int { signed: true, .. } => format!("(uint64_t)(int64_t)({})", e),
        CType::Int { signed: false, .. } => format!("(uint64_t)({})", e),
        CType::F32 => format!("fwp_f2w({})", e),
        CType::F64 => format!("fwp_d2w({})", e),
        CType::Bool => format!("(uint64_t)(({}) != 0)", e),
        _ => format!("(uint64_t)(uintptr_t)({})", e),
    }
}

/// Number of result words for a type.
pub fn result_words(t: &CType) -> usize {
    match t {
        CType::Struct { fields, .. } => fields.len().max(1),
        _ => 1,
    }
}

/// Callback slot numbers in the shim: function index and parameter index.
pub fn slot(func: usize, param: usize) -> u32 {
    (func as u32) * 64 + param as u32
}

/// C source of the shim for all foreign C functions of a program. Each
/// becomes `void fwp_shim_<id>(const uint64_t *args, uint64_t *ret)`;
/// struct arguments are pointers to their field words, struct results
/// fill several result words.
pub fn shim_source(prog: &Program) -> Result<String, String> {
    let mut out = String::from("#include <stdint.h>\n#include <stddef.h>\n#include <string.h>\n\n");
    out.push_str(PREAMBLE);
    out.push_str(
        "static float fwp_w2f(uint64_t w) { uint32_t b = (uint32_t)w; float f; memcpy(&f, &b, 4); return f; }
static double fwp_w2d(uint64_t w) { double d; memcpy(&d, &w, 8); return d; }
static uint64_t fwp_f2w(float f) { uint32_t b; memcpy(&b, &f, 4); return b; }
static uint64_t fwp_d2w(double d) { uint64_t w; memcpy(&w, &d, 8); return w; }
static void (*fwp_host)(void *, uint32_t, const uint64_t *, uint64_t *);
static void *fwp_host_ctx;
void fwp_shim_set_host(void *f, void *ctx) {
    fwp_host = (void (*)(void *, uint32_t, const uint64_t *, uint64_t *))f;
    fwp_host_ctx = ctx;
}
",
    );
    let mut seen = Vec::new();
    let mut body = String::new();
    let mut convs = String::new();
    let mut conv_seen: Vec<String> = Vec::new();
    for (id, f) in prog.funcs.iter().enumerate() {
        let Body::ForeignC { symbol, variadic } = &f.body else {
            continue;
        };
        let (params, ret) = signature(prog, f).map_err(|e| format!("`{}`: {}", symbol, e))?;
        let ctypes: Vec<CType> = params.iter().map(|(_, c)| c.clone()).collect();
        let mut all = ctypes.clone();
        all.push(ret.clone());
        struct_defs(&all, &mut out, &mut seen);
        for t in &all {
            if let CType::Struct { name, fields } = t {
                if conv_seen.contains(name) {
                    continue;
                }
                conv_seen.push(name.clone());
                let _ = writeln!(
                    convs,
                    "static struct fwp_c_{n} fwp_w2s_{n}(const uint64_t *w) {{\n    struct fwp_c_{n} s;",
                    n = name
                );
                for (i, (fname, _, ft)) in fields.iter().enumerate() {
                    let _ = writeln!(
                        convs,
                        "    s.{} = {};",
                        fname,
                        from_word(ft, &format!("w[{}]", i))
                    );
                }
                convs.push_str("    return s;\n}\n");
                let _ = writeln!(
                    convs,
                    "static void fwp_s2w_{n}(struct fwp_c_{n} s, uint64_t *w) {{",
                    n = name
                );
                for (i, (fname, _, ft)) in fields.iter().enumerate() {
                    let _ = writeln!(
                        convs,
                        "    w[{}] = {};",
                        i,
                        to_word(ft, &format!("s.{}", fname))
                    );
                }
                convs.push_str("}\n");
            }
        }
        let cname = format!("fwp_ffi_{}", id);
        body.push_str(&prototype(&cname, symbol, &ctypes, &ret, *variadic));
        // callback trampolines
        for (k, c) in ctypes.iter().enumerate() {
            if let CType::Callback {
                params: cps,
                ret: cr,
            } = c
            {
                let decl: Vec<String> = cps
                    .iter()
                    .enumerate()
                    .map(|(j, p)| format!("{} a{}", c_name(p), j))
                    .collect();
                let _ = writeln!(
                    body,
                    "static {} fwp_cb_{}_{}({}) {{",
                    c_name(cr),
                    id,
                    k,
                    if decl.is_empty() {
                        "void".into()
                    } else {
                        decl.join(", ")
                    }
                );
                let _ = writeln!(body, "    uint64_t a[{}];", cps.len().max(1));
                for (j, p) in cps.iter().enumerate() {
                    let _ = writeln!(body, "    a[{}] = {};", j, to_word(p, &format!("a{}", j)));
                }
                let _ = writeln!(body, "    uint64_t r[{}] = {{0}};", result_words(cr));
                let _ = writeln!(body, "    fwp_host(fwp_host_ctx, {}u, a, r);", slot(id, k));
                match &**cr {
                    CType::Void => {}
                    CType::Struct { name, .. } => {
                        let _ = writeln!(body, "    return fwp_w2s_{}(r);", name);
                    }
                    t => {
                        let _ = writeln!(body, "    return {};", from_word(t, "r[0]"));
                    }
                }
                body.push_str("}\n");
            }
        }
        let _ = writeln!(
            body,
            "void fwp_shim_{}(const uint64_t *args, uint64_t *ret) {{",
            id
        );
        let args: Vec<String> = ctypes
            .iter()
            .enumerate()
            .map(|(k, c)| match c {
                CType::Callback { .. } => format!("(void *)fwp_cb_{}_{}", id, k),
                _ => from_word(c, &format!("args[{}]", k)),
            })
            .collect();
        let call = format!("{}({})", cname, args.join(", "));
        match &ret {
            CType::Void => {
                let _ = writeln!(body, "    {};\n    (void)ret;", call);
            }
            CType::Struct { name, .. } => {
                let _ = writeln!(body, "    fwp_s2w_{}({}, ret);", name, call);
            }
            t => {
                let _ = writeln!(body, "    ret[0] = {};", to_word(t, &call));
            }
        }
        body.push_str("}\n");
    }
    out.push_str(&convs);
    out.push_str(&body);
    Ok(out)
}
