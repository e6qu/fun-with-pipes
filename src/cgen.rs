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
    include_str!("../runtime/fwp_rt_pb.c"),
];

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

    fn expr(&mut self, e: &Expr) -> String {
        match e {
            Expr::Local(i) => format!("l{}", i),
            Expr::Const(v) => self.g.const_expr(v),
            Expr::Func(id) => {
                if self.g.prog.funcs[*id].arity == 0 {
                    self.bind(format!("caf{}()", id))
                } else {
                    self.g.used_closures[*id] = true;
                    format!("PTR(&fc{})", id)
                }
            }
            Expr::Call(id, args) => {
                let xs = self.args(args);
                if self.g.prog.funcs[*id].arity == 0 {
                    self.bind(format!("caf{}()", id))
                } else {
                    self.bind(format!("f{}({})", id, xs.join(", ")))
                }
            }
            Expr::Apply(f, args) => {
                let fv = self.expr(f);
                let xs = self.args(args);
                self.bind(format!(
                    "fwp_apply({}, {}, {})",
                    fv,
                    xs.len(),
                    Self::array(&xs)
                ))
            }
            Expr::Construct(tag, args) => {
                if args.is_empty() {
                    return format!("(V){}", tag);
                }
                let xs = self.args(args);
                self.bind(format!(
                    "fwp_data({}, {}, {})",
                    tag,
                    xs.len(),
                    Self::array(&xs)
                ))
            }
            Expr::Record(args) => {
                if args.is_empty() {
                    return "(V)0".into();
                }
                let xs = self.args(args);
                self.bind(format!("fwp_record({}, {})", xs.len(), Self::array(&xs)))
            }
            Expr::Field(r, i) => {
                let rv = self.expr(r);
                self.bind(format!("OBJ({})->f[{}]", rv, i))
            }
            Expr::SetFields(r, sets) => {
                let rv = self.expr(r);
                let t = self.bind(format!("fwp_data(0, OBJ({rv})->n, OBJ({rv})->f)", rv = rv));
                for (i, x) in sets {
                    let xv = self.expr(x);
                    self.line(&format!("OBJ({})->f[{}] = {};", t, i, xv));
                }
                t
            }
            Expr::Let(l, v, body) => {
                let x = self.expr(v);
                self.line(&format!("l{} = {};", l, x));
                self.expr(body)
            }
            Expr::Match(scrut, arms) => {
                let sv = self.expr(scrut);
                let s = self.bind(sv);
                let r = self.fresh();
                self.line(&format!("V {};", r));
                self.label += 1;
                let done = format!("done{}", self.label);
                for (pat, body) in arms {
                    self.label += 1;
                    let next = format!("next{}", self.label);
                    self.line("{");
                    self.indent += 1;
                    self.pattern(pat, &s, &next);
                    let bv = self.expr(body);
                    self.line(&format!("{} = {};", r, bv));
                    self.line(&format!("goto {};", done));
                    self.indent -= 1;
                    self.line("}");
                    self.line(&format!("{}:;", next));
                }
                self.line("fwp_trap(\"internal: no match arm applies\");");
                self.line(&format!("{}:;", done));
                r
            }
        }
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
        let s = match sym {
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
            "show" => format!("return fwp_show(l0, {});", self.desc(&p(0))),
            "json.write" => format!("return fwp_p_json_write(l0, {});", self.desc(&p(0))),
            "json.read" => format!(
                "return fwp_p_json_read(l0, {});",
                self.desc(&elem(&result, 0))
            ),
            "format" => format!("return fwp_p_format(l0, l1, {});", self.desc(&p(1))),
            "fail" => format!("fwp_fail(l0, {}); return 0;", self.desc(&p(0))),
            "sort" => format!("return fwp_p_sort(l0, {});", self.desc(&elem(&p(0), 0))),
            "sort-by" => {
                let key = match p(0) {
                    MT::Fun(_, k) => *k,
                    _ => MT::unit(),
                };
                format!("return fwp_p_sort_by(l0, l1, {});", self.desc(&key))
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
            "pb.cast" => {
                let name = match &result {
                    MT::Con(n, _) => n.trim_start_matches("std::").to_string(),
                    _ => String::new(),
                };
                let e = match name.as_str() {
                    "I8" => "(V)(int64_t)(int8_t)l0",
                    "I16" => "(V)(int64_t)(int16_t)l0",
                    "I32" => "(V)(int64_t)(int32_t)l0",
                    "U8" => "(V)(uint8_t)l0",
                    "U16" => "(V)(uint16_t)l0",
                    "U32" => "(V)(uint32_t)l0",
                    _ => "l0",
                };
                format!("return {};", e)
            }
            "grpc.open"
            | "grpc.send"
            | "grpc.recv"
            | "grpc.serve"
            | "grpc._serve-tls"
            | "grpc.unary"
            | "grpc.server-streaming"
            | "grpc.client-streaming"
            | "grpc.bidi-streaming"
            | "grpc.unary-handler"
            | "grpc.server-streaming-handler"
            | "grpc._client-streaming-handler"
            | "grpc._bidi-streaming-handler" => {
                let gerr = self.desc(&crate::rpc::grpc_error_type());
                let typed = |kind: u8, n: u32| {
                    let args: Vec<String> = (0..n).map(|i| format!("l{}", i)).collect();
                    format!(
                        "return fwp_p_grpc_typed({}, {}, (V[]){{{}}}, {});",
                        kind,
                        n,
                        args.join(", "),
                        gerr
                    )
                };
                match sym {
                    "grpc.unary" => typed(0, 5),
                    "grpc.server-streaming" => typed(1, 6),
                    "grpc.client-streaming" => typed(2, 5),
                    "grpc.bidi-streaming" => typed(3, 6),
                    "grpc.unary-handler" => typed(4, 4),
                    "grpc.server-streaming-handler" => typed(5, 4),
                    "grpc._client-streaming-handler" => typed(6, 5),
                    "grpc._bidi-streaming-handler" => typed(7, 5),
                    "grpc.open" => format!("return fwp_p_grpc_open(l0, l1, {});", gerr),
                    "grpc.send" => format!("return fwp_p_grpc_send(l0, l1, {});", gerr),
                    "grpc.recv" => format!("return fwp_p_grpc_recv(l0, {});", gerr),
                    "grpc._serve-tls" => format!(
                        "return fwp_p_grpc_serve_tls(l0, l1, l2, l3, l4, {}, {});",
                        self.desc(&MT::con("std::IoError")),
                        gerr
                    ),
                    _ => format!(
                        "return fwp_p_grpc_serve(l0, l1, {}, {});",
                        self.desc(&MT::con("std::IoError")),
                        gerr
                    ),
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
                    ("grpc.close-send", "fwp_p_grpc_close_send(l0)"),
                    ("grpc.cancel", "fwp_p_grpc_cancel(l0)"),
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
                    ("grpc.response-metadata", "fwp_p_grpc_response_metadata(l0)"),
                    ("grpc.with-gzip", "fwp_p_grpc_with_gzip(l0)"),
                    ("grpc._force", "fwp_p_grpc_force(l0)"),
                    ("http2.serve", "fwp_p_http2_serve(l0, l1, l2, l3)"),
                    ("http2.request", "fwp_p_http2_request(l0)"),
                    ("http2.body", "fwp_p_http2_body(l0, l1, l2)"),
                    ("http2.respond", "fwp_p_http2_respond(l0, l1, l2, l3, l4)"),
                    ("http2.data", "fwp_p_http2_data(l0, l1, l2)"),
                    ("http2.pooled", "fwp_p_http2_pooled(l0)"),
                    ("zlib.gzip", "fwp_p_zlib_gzip(l0)"),
                    ("zlib.gunzip", "fwp_p_zlib_gunzip(l0, l1)"),
                    ("zlib.deflate", "fwp_p_zlib_deflate(l0)"),
                    ("zlib.inflate", "fwp_p_zlib_inflate(l0, l1)"),
                    ("ws.accept", "fwp_p_ws_accept(l0)"),
                    ("ws.key", "fwp_p_ws_key()"),
                    ("ws.frame", "fwp_p_ws_frame(l0, l1, l2)"),
                    ("ws.parse", "fwp_p_ws_parse(l0, l1, l2)"),
                    ("ws.close-payload", "fwp_p_ws_close_payload(l0, l1)"),
                    ("ws.close-parse", "fwp_p_ws_close_parse(l0)"),
                    ("pb.parse", "fwp_p_pb_parse(l0)"),
                    ("pb.write", "fwp_p_pb_write(l0)"),
                    ("pb.zigzag", "fwp_p_pb_zigzag(l0)"),
                    ("pb.unzigzag", "fwp_p_pb_unzigzag(l0)"),
                    ("pb.f64-bits", "l0"),
                    ("pb.f64-from-bits", "l0"),
                    ("pb.f32-bits", "fwp_p_pb_f32_bits(l0)"),
                    ("pb.f32-from-bits", "fwp_p_pb_f32_from_bits(l0)"),
                    ("pb.unpack", "fwp_p_pb_unpack(l0, l1)"),
                    ("pb.pack", "fwp_p_pb_pack(l0, l1)"),
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
        for i in f.arity..f.nlocals {
            let _ = writeln!(out, "    V l{} = 0;", i);
        }
        match &f.body {
            Body::Prim(sym) => {
                let sym = sym.clone();
                let func = f.clone();
                let s = self.prim(&func, &sym)?;
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
                    let _ = writeln!(
                        out,
                        "    return fwp_data({}, {}, (V[]){{{}}});",
                        tag,
                        args.len(),
                        args.join(", ")
                    );
                }
            }
            Body::Expr(e) => {
                let e = e.clone();
                if self.ticks {
                    out.push_str("    FWP_TICK();\n");
                }
                let mut fg = FnGen {
                    g: self,
                    out: String::new(),
                    tmp: 0,
                    label: 0,
                    indent: 1,
                };
                let r = fg.expr(&e);
                let body = fg.out;
                out.push_str(&body);
                let _ = writeln!(out, "    return {};", r);
            }
        }
        out.push_str("}\n");
        Ok(out)
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
/// function is a command (`fwp build --cli`).
pub fn generate_cli(prog: &Program, name: &str) -> Result<String, String> {
    let cmds = crate::cli::commands(prog, Some(name))?;
    if cmds.is_empty() {
        return Err("the program exports no functions (mark them with `export`)".into());
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

fn generate_mode(prog: &Program, mode: Mode) -> Result<String, String> {
    let tests = matches!(mode, Mode::Tests);
    let main = prog.main.unwrap_or(0);
    let mut g = Gen {
        prog,
        descs: HashMap::new(),
        desc_defs: Vec::new(),
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
    };
    let mut bodies = String::new();
    for id in 0..prog.funcs.len() {
        bodies.push_str(&g.func(id)?);
        bodies.push('\n');
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

    let mut out = String::new();
    out.push_str("/* Generated by fwp. */\n");
    let web = uses_web(prog);
    let tls = uses_services || web || uses_tls(prog);
    if tls {
        out.push_str(TLS_MARK);
    }
    if uses_async(prog) {
        out.push_str(ASYNC_MARK);
    }
    for part in RUNTIME {
        out.push_str(part);
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
    // tentative declarations, so descriptors can refer to each other
    for i in 0..g.desc_defs.len() {
        let _ = writeln!(out, "static fwp_desc d{};", i);
    }
    for d in &g.desc_defs {
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
    // prototypes
    for (id, f) in prog.funcs.iter().enumerate() {
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
    // constant applicative forms
    for (id, f) in prog.funcs.iter().enumerate() {
        if f.arity == 0 {
            let _ = writeln!(
                out,
                "static V caf{id}(void) {{ static int st = 0; static V v; if (st == 0) {{ v = f{id}(); st = 1; }} return v; }}",
                id = id
            );
        }
    }
    // entries and the function table
    for (id, f) in prog.funcs.iter().enumerate() {
        if f.arity > 0 {
            let args: Vec<String> = (0..f.arity).map(|i| format!("a[{}]", i)).collect();
            let _ = writeln!(
                out,
                "static V e{}(V *a) {{ return f{}({}); }}",
                id,
                id,
                args.join(", ")
            );
        }
    }
    out.push_str("static const fwp_fninfo fwp_fn_table[] = {\n");
    for (id, f) in prog.funcs.iter().enumerate() {
        let entry = if f.arity > 0 {
            format!("e{}", id)
        } else {
            "0".into()
        };
        let _ = writeln!(
            out,
            "    {{{}, {}, {}}},",
            f.arity,
            entry,
            c_string_literal(f.name.as_bytes())
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
        fwp_handler h; h.prev = fwp_handlers; h.state_depth = fwp_state_len; fwp_handlers = &h;
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
            "    V r = caf{}();\n    fwp_tasks_finish();\n    (void){};\n    fwp_exit_code = {};",
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
    pthread_attr_setstacksize(&attr, fwp_main_stack);
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
        let hint = if err.contains("openssl/ssl.h") || err.contains("-lssl") {
            "\nthe program uses TLS, which needs OpenSSL 3's headers and libraries (Debian and Ubuntu: libssl-dev; see docs/tls.md)"
        } else {
            ""
        };
        return Err(format!("C compiler failed:\n{}{}", err, hint));
    }
    Ok(())
}

/// CPU variants of a fat binary for the host architecture: name, compiler
/// flags, and the C condition (in terms of `__builtin_cpu_supports`) under
/// which the variant may run. The first is the baseline.
fn fat_variants() -> Vec<(&'static str, &'static str, &'static str)> {
    match std::env::consts::ARCH {
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
    let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
    let variants = fat_variants();
    let mut objs = Vec::new();
    let mut result = Ok(());
    for (i, (_, flags, _)) in variants.iter().enumerate() {
        let obj = dir.join(format!("fat-{}.o", i));
        let mut cmd = std::process::Command::new(&cc);
        cmd.args([opt, "-std=gnu11", "-ffp-contract=off", "-w", "-c"])
            .arg(format!("-Dmain=fwp_variant_{}", i));
        if !flags.is_empty() {
            cmd.arg(flags);
        }
        cmd.arg("-o").arg(&obj).arg(&c_path);
        result = run_cc(&mut cmd, &cc);
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
            std::process::Command::new(&cc)
                .arg(opt)
                .arg("-o")
                .arg(output)
                .arg(&dpath)
                .args(&objs)
                .args(crate::ffi::links())
                .args(tls_links(c_source))
                .args(["-lm", "-lpthread"]),
            &cc,
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
    let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
    let mut result = run_cc(
        std::process::Command::new(&cc)
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
        &cc,
    );
    if result.is_ok() {
        result = match kind {
            LibKind::Static => {
                let _ = std::fs::remove_file(output);
                let ar = std::env::var("AR").unwrap_or_else(|_| "ar".into());
                run_cc(
                    std::process::Command::new(&ar)
                        .arg("rcs")
                        .arg(output)
                        .arg(&obj),
                    &ar,
                )
            }
            LibKind::Shared => run_cc(
                std::process::Command::new(&cc)
                    .arg("-shared")
                    .arg("-o")
                    .arg(output)
                    .arg(&obj)
                    .args(crate::ffi::links())
                    .args(tls_links(c_source))
                    .args(["-lm", "-lpthread"]),
                &cc,
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
        let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
        run_cc(
            std::process::Command::new(&cc)
                .arg(opt)
                .arg("-std=gnu11")
                // no fused multiply-add: results must match the interpreter exactly
                .arg("-ffp-contract=off")
                .arg("-w")
                .arg("-o")
                .arg(output)
                .arg(&c_path)
                .args(crate::ffi::links())
                .args(tls_links(c_source))
                .arg("-lm")
                .arg("-lpthread"),
            &cc,
        )
    };
    let _ = std::fs::remove_file(&c_path);
    result
}
