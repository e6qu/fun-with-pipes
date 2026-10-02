//! Services: one program, two deployments.
//!
//! A program built normally calls the exported functions of the modules it
//! imports directly. In a split build (`fwp build --service m`), module `m`
//! becomes a gRPC server of its exported functions, and every call to one
//! of them from another module is compiled to a client stub
//! (`Body::Remote`): it encodes the arguments as a protobuf request,
//! performs a unary call to the address in `FWP_SERVICE_<M>`, and decodes
//! the result (or the `Error` the function raised). The source is the same
//! in both builds; only the monomorphizer's choice of callee differs.
//!
//! This module is the interpreter's side: client stubs and `fwp serve`.
//! The C runtime implements both in `runtime/fwp_rt_grpc.c`.

use std::cell::RefCell;
use std::collections::HashMap;
use std::io::Write;

use crate::h2::{self, CallError};
use crate::interp::{Ctl, Interp, R};
use crate::ir::{FuncId, Program, RemoteFn, MT};
use crate::proto::{self, Reader};
use crate::protobuf::{self, MethodSchema, Schema};
use crate::value::{Closure, Value};

/// The address of a service: `FWP_SERVICE_<MODULE>`, else the default.
pub fn address(module: &str, default: &str) -> String {
    std::env::var(protobuf::env_var(module))
        .ok()
        .filter(|s| !s.is_empty())
        .unwrap_or_else(|| default.to_string())
}

type Cached = std::rc::Rc<(Schema, MethodSchema, String)>;

thread_local! {
    static STUBS: RefCell<HashMap<(usize, FuncId), Cached>> = RefCell::new(HashMap::new());
}

/// The schema, request/response nodes and fingerprint of a function.
fn method_schema(
    prog: &Program,
    name: &str,
    ty: &MT,
    arity: usize,
    error: Option<&MT>,
) -> Result<(Schema, MethodSchema, String), String> {
    let (params, result) = ty.params(arity);
    let params: Vec<MT> = params.into_iter().cloned().collect();
    let mut s = Schema::default();
    let m = s.method(prog, name, &params, result, error)?;
    Ok((s, m, protobuf::fingerprint(prog, ty, error)))
}

fn stub(prog: &Program, id: FuncId, r: &RemoteFn) -> R<Cached> {
    let key = (prog as *const Program as usize, id);
    if let Some(c) = STUBS.with(|s| s.borrow().get(&key).cloned()) {
        return Ok(c);
    }
    let f = &prog.funcs[id];
    let c = method_schema(prog, &r.method, &f.ty, f.arity as usize, r.error.as_ref())
        .map_err(Ctl::Trap)?;
    let c = std::rc::Rc::new(c);
    STUBS.with(|s| s.borrow_mut().insert(key, c.clone()));
    Ok(c)
}

/// A call to a function served by another process.
pub fn call_remote(it: &mut Interp, id: FuncId, r: &RemoteFn, args: Vec<Value>) -> R<Value> {
    let prog = it.prog;
    let f = &prog.funcs[id];
    let (params, result) = f.ty.params(f.arity as usize);
    let c = stub(prog, id, r)?;
    let (schema, ms, fp) = (&c.0, c.1, &c.2);
    let what = format!("{}.{}", r.module, r.method);
    let mut canon = Vec::new();
    for (a, t) in args.iter().zip(&params) {
        proto::encode(&mut canon, a, t, prog);
    }
    let req = schema
        .encode(ms.request, &canon)
        .map_err(|e| Ctl::Trap(format!("cannot encode the arguments of {}: {}", what, e)))?;
    let addr = address(&r.module, &r.default_addr);
    let path = protobuf::path(&r.module, &r.method);
    let resp = match h2::call(&addr, &path, &[("fwp-fingerprint", fp)], &req) {
        Ok(b) => b,
        Err(CallError::Status(h2::INTERNAL, m)) if m.starts_with("trap: ") => {
            return Err(Ctl::Trap(m["trap: ".len()..].to_string()))
        }
        Err(e) => {
            return Err(Ctl::Trap(format!(
                "service call {} ({}) failed: {}",
                what, addr, e
            )))
        }
    };
    let bad = |e: String| Ctl::Trap(format!("bad response from {} ({}): {}", what, addr, e));
    let canon = schema.decode(ms.response, &resp).map_err(bad)?;
    let mut rd = Reader::new(&canon);
    match &r.error {
        Some(et) if rd.leb128().map_err(bad)? == 1 => {
            let e = proto::decode(&mut rd, et, prog).map_err(bad)?;
            Err(Ctl::Fail(e, et.clone()))
        }
        _ => proto::decode(&mut rd, result, prog).map_err(bad),
    }
}

struct Method {
    name: String,
    func: FuncId,
    params: Vec<MT>,
    result: MT,
    error: Option<MT>,
    schema: MethodSchema,
    fingerprint: String,
}

/// The methods of a service program and their shared schema.
fn methods(prog: &Program) -> Result<(Schema, HashMap<String, Method>), String> {
    let svc = prog.service.as_ref().ok_or("no service to serve")?;
    let mut schema = Schema::default();
    let mut out = HashMap::new();
    for (name, fid, error) in &svc.methods {
        let f = &prog.funcs[*fid];
        let (params, result) = f.ty.params(f.arity as usize);
        let params: Vec<MT> = params.into_iter().cloned().collect();
        let ms = schema.method(prog, name, &params, result, error.as_ref())?;
        let path = protobuf::path(&svc.module, name);
        if out.contains_key(&path) {
            return Err(format!(
                "two exported functions of `{}` have the gRPC method name `{}`",
                svc.module,
                protobuf::method_name(name)
            ));
        }
        out.insert(
            path,
            Method {
                name: name.clone(),
                func: *fid,
                result: result.clone(),
                params,
                error: error.clone(),
                schema: ms,
                fingerprint: protobuf::fingerprint(prog, &f.ty, error.as_ref()),
            },
        );
    }
    Ok((schema, out))
}

/// Check that a service's method names are distinct.
pub fn check_service(prog: &Program) -> Result<(), String> {
    methods(prog).map(|_| ())
}

/// The address a service listens on: `--listen`, else
/// `FWP_SERVICE_<MODULE>`, else the build's default.
pub fn listen_address(prog: &Program, listen: Option<String>) -> String {
    let svc = prog.service.as_ref().unwrap();
    listen.unwrap_or_else(|| address(&svc.module, &svc.default_addr))
}

/// Serve the program's service with the interpreter (`fwp serve`).
pub fn serve(prog: &Program, listen: Option<String>) -> i32 {
    let (schema, methods) = match methods(prog) {
        Ok(m) => m,
        Err(e) => {
            eprintln!("fwp serve: {}", e);
            return 2;
        }
    };
    let module = prog.service.as_ref().unwrap().module.clone();
    let addr = listen_address(prog, listen);
    let listener = match std::net::TcpListener::bind(&addr) {
        Ok(l) => l,
        Err(e) => {
            eprintln!("fwp serve: cannot listen on {}: {}", addr, h2::io_msg(&e));
            return 1;
        }
    };
    let local = listener.local_addr().map(|a| a.to_string()).unwrap_or(addr);
    eprintln!("fwp: service {} listening on {}", module, local);
    let stdout = std::io::stdout();
    let mut it = Interp::new(prog, Box::new(std::io::LineWriter::new(stdout)));
    let mut handler = |path: &str, headers: &[(String, String)], msg: &[u8]| -> h2::Reply {
        let Some(m) = methods.get(path) else {
            return Err((h2::UNIMPLEMENTED, format!("unknown method {}", path)));
        };
        if let Some((_, fp)) = headers.iter().find(|(k, _)| k == "fwp-fingerprint") {
            if *fp != m.fingerprint {
                return Err((
                    h2::FAILED_PRECONDITION,
                    format!(
                        "interface mismatch: the caller of {}.{} was built against a different version of it",
                        module, m.name
                    ),
                ));
            }
        }
        let canon = schema
            .decode(m.schema.request, msg)
            .map_err(|e| (h2::INVALID_ARGUMENT, e))?;
        let mut rd = Reader::new(&canon);
        let mut args = Vec::new();
        for t in &m.params {
            args.push(proto::decode(&mut rd, t, prog).map_err(|e| (h2::INVALID_ARGUMENT, e))?);
        }
        let fv = Value::Closure(std::rc::Rc::new(Closure {
            func: m.func,
            args: vec![],
        }));
        let r = it.apply(fv, args);
        if r.is_err() {
            it.cancel_children();
        } else {
            it.join_children();
        }
        let _ = it.out.flush();
        let mut out = Vec::new();
        match r {
            Ok(v) => {
                if m.error.is_some() {
                    out.push(0);
                }
                proto::encode(&mut out, &v, &m.result, prog);
            }
            Err(Ctl::Fail(e, _)) if m.error.is_some() => {
                out.push(1);
                proto::encode(&mut out, &e, m.error.as_ref().unwrap(), prog);
            }
            Err(Ctl::Fail(e, t)) => {
                let shown = crate::value::display(&e, &t, prog, true);
                return Err((h2::INTERNAL, format!("error: {}", shown)));
            }
            Err(Ctl::Trap(msg)) => {
                eprintln!("fwp: trap: {} (in {}.{})", msg, module, m.name);
                return Err((h2::INTERNAL, format!("trap: {}", msg)));
            }
            Err(Ctl::Exit(c)) => {
                let _ = it.out.flush();
                std::process::exit(c);
            }
            Err(Ctl::Cancelled) => return Err((h2::INTERNAL, "cancelled".into())),
        }
        schema
            .encode(m.schema.response, &out)
            .map_err(|e| (h2::INTERNAL, e))
    };
    match h2::serve(listener, &mut handler) {
        Ok(()) => 0,
        Err(e) => {
            eprintln!("fwp serve: {}", e);
            1
        }
    }
}

/// The `.proto` file for the services of a program compiled once per
/// service module (`fwp proto`).
pub fn proto_text(progs: &[Program], source: &str) -> Result<String, String> {
    let mut schema = Schema::default();
    let mut services = Vec::new();
    for prog in progs {
        let svc = prog.service.as_ref().ok_or("no service")?;
        let mut ms = Vec::new();
        for (name, fid, error) in &svc.methods {
            let f = &prog.funcs[*fid];
            let (params, result) = f.ty.params(f.arity as usize);
            let params: Vec<MT> = params.into_iter().cloned().collect();
            ms.push((
                name.clone(),
                schema.method(prog, name, &params, result, error.as_ref())?,
            ));
        }
        check_service(prog)?;
        services.push(protobuf::ServiceText {
            module: svc.module.clone(),
            methods: ms,
        });
    }
    Ok(protobuf::proto_file(&schema, &services, source))
}
