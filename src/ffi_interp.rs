//! Calling C from the interpreter: the program's foreign C functions are
//! wrapped by a generated shim library (see `ffi::shim_source`), compiled
//! with the system C compiler and loaded with `dlopen`; arguments and
//! results travel as 64-bit words. Callbacks re-enter the interpreter.

use std::collections::HashMap;
use std::ffi::{c_char, c_int, c_void, CStr, CString};
use std::rc::Rc;

use crate::ffi::{self, CType};
use crate::interp::{Ctl, Interp, R};
use crate::ir::*;
use crate::value::Value;

extern "C" {
    fn dlopen(path: *const c_char, flags: c_int) -> *mut c_void;
    fn dlsym(handle: *mut c_void, symbol: *const c_char) -> *mut c_void;
    fn dlerror() -> *const c_char;
}

const RTLD_NOW: c_int = 2;

type ShimFn = unsafe extern "C" fn(*const u64, *mut u64);
/// Sets the context of the current foreign call; returns the previous one.
type SetHostFn = unsafe extern "C" fn(*const c_void, *mut c_void) -> *mut c_void;

pub struct FfiLib {
    shims: HashMap<FuncId, ShimFn>,
    set_host: SetHostFn,
}

fn trap<T>(msg: impl Into<String>) -> R<T> {
    Err(Ctl::Trap(msg.into()))
}

/// Build and load the shim for every foreign C function of a program.
fn load(prog: &Program) -> Result<FfiLib, String> {
    let src = ffi::shim_source(prog)?;
    // removed (with the files in it) when this function returns: the
    // library stays loaded
    let dir = crate::cgen::TempDir::new("fwp-ffi")?;
    let c_path = dir.join("shim.c");
    let so_path = dir.join(format!("shim.{}", crate::cgen::shared_library_extension()));
    std::fs::write(&c_path, src).map_err(|e| e.to_string())?;
    let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
    let out = std::process::Command::new(&cc)
        .args([
            crate::cgen::shared_library_flag(),
            "-fPIC",
            "-O1",
            "-w",
            "-o",
        ])
        .arg(&so_path)
        .arg(&c_path)
        .args(ffi::links())
        .arg("-lm")
        .output()
        .map_err(|e| format!("cannot run C compiler `{}`: {}", cc, e))?;
    let _ = std::fs::remove_file(&c_path);
    if !out.status.success() {
        return Err(format!(
            "building the foreign function shim failed:\n{}",
            String::from_utf8_lossy(&out.stderr)
        ));
    }
    let path = CString::new(so_path.to_string_lossy().as_bytes()).unwrap();
    let handle = unsafe { dlopen(path.as_ptr(), RTLD_NOW) };
    let _ = std::fs::remove_file(&so_path);
    if handle.is_null() {
        let e = unsafe { CStr::from_ptr(dlerror()) }
            .to_string_lossy()
            .into_owned();
        return Err(format!("cannot load the foreign function shim: {}", e));
    }
    let sym = |name: &str| -> Result<*mut c_void, String> {
        let c = CString::new(name).unwrap();
        let p = unsafe { dlsym(handle, c.as_ptr()) };
        if p.is_null() {
            Err(format!("shim symbol `{}` missing", name))
        } else {
            Ok(p)
        }
    };
    let mut shims = HashMap::new();
    for (id, f) in prog.funcs.iter().enumerate() {
        if matches!(f.body, Body::ForeignC { .. }) {
            let p = sym(&format!("fwp_shim_{}", id))?;
            shims.insert(id, unsafe { std::mem::transmute::<*mut c_void, ShimFn>(p) });
        }
    }
    let set_host =
        unsafe { std::mem::transmute::<*mut c_void, SetHostFn>(sym("fwp_shim_set_host")?) };
    Ok(FfiLib { shims, set_host })
}

/// State of one foreign call, reachable from callbacks.
struct CallCtx<'a, 'p> {
    interp: *mut Interp<'p>,
    callbacks: Vec<(u32, Value, MT)>,
    error: Option<Ctl>,
    keep: &'a mut Keep,
}

#[derive(Default)]
struct Keep {
    structs: Vec<Vec<u64>>,
}

fn int_value(mt: &MT, w: u64, bits: u32, signed: bool) -> R<Value> {
    let bits = if bits == 0 { 64 } else { bits };
    let x: i128 = if signed {
        let shift = 64 - bits;
        (((w << shift) as i64) >> shift) as i128
    } else if bits == 64 {
        w as i128
    } else {
        (w & ((1u64 << bits) - 1)) as i128
    };
    crate::interp::from_i128(mt, x)
}

fn field_mts(prog: &Program, mt: &MT) -> Vec<MT> {
    match prog.shapes.get(mt) {
        Some(TypeShape::Record(fs)) => fs.iter().map(|(_, t)| t.clone()).collect(),
        _ => vec![],
    }
}

fn value_of(prog: &Program, t: &CType, mt: &MT, w: &[u64]) -> R<Value> {
    Ok(match t {
        CType::Void => Value::unit(),
        CType::Int { bits, signed } => int_value(mt, w[0], *bits, *signed)?,
        CType::F32 => Value::F32(f32::from_bits(w[0] as u32)),
        CType::F64 => Value::F64(f64::from_bits(w[0])),
        CType::Bool => Value::bool(w[0] != 0),
        CType::Str => {
            if w[0] == 0 {
                return trap("foreign function returned a null string");
            }
            let s = unsafe { CStr::from_ptr(w[0] as usize as *const c_char) };
            match s.to_str() {
                Ok(s) => Value::str(s),
                Err(_) => return trap("foreign function returned a string that is not UTF-8"),
            }
        }
        CType::Ptr => Value::U64(w[0]),
        CType::OptPtr => {
            if w[0] == 0 {
                Value::data(0, vec![])
            } else {
                Value::data(1, vec![Value::U64(w[0])])
            }
        }
        CType::Struct { fields, .. } => {
            let fmts = field_mts(prog, mt);
            let mut vals = vec![Value::unit(); fmts.len()];
            for (k, (_, idx, ft)) in fields.iter().enumerate() {
                vals[*idx] = value_of(prog, ft, &fmts[*idx], &w[k..k + 1])?;
            }
            Value::tuple(vals)
        }
        CType::Bytes | CType::Callback { .. } => return trap("internal: unsupported C result"),
    })
}

/// A value as a word (structs: a pointer to their field words).
fn word_of(t: &CType, v: &Value, keep: &mut Keep) -> R<u64> {
    Ok(match t {
        CType::Void => 0,
        CType::Int { .. } => v.as_i128().unwrap_or(0) as u64,
        CType::F32 => match v {
            Value::F32(x) => x.to_bits() as u64,
            _ => (v.as_f64().unwrap_or(0.0) as f32).to_bits() as u64,
        },
        CType::F64 => v.as_f64().unwrap_or(0.0).to_bits(),
        CType::Bool => v.as_bool() as u64,
        CType::Str => {
            let Ok(c) = CString::new(v.as_str()) else {
                return trap("a string passed to C contains a NUL character");
            };
            // C may keep pointers into its arguments (`strchr`), and the
            // native backend never frees strings either: the copy lives on.
            c.into_raw() as usize as u64
        }
        CType::Bytes => match v {
            Value::Bytes(b) => b.as_ptr() as usize as u64,
            _ => 0,
        },
        CType::Ptr => v.as_i128().unwrap_or(0) as u64,
        CType::OptPtr => match v {
            Value::Data(1, fs) => fs[0].as_i128().unwrap_or(0) as u64,
            _ => 0,
        },
        CType::Struct { fields, .. } => {
            let Value::Record(fs) = v else {
                return trap("internal: struct is not a record");
            };
            let mut ws = Vec::with_capacity(fields.len());
            for (_, idx, ft) in fields {
                ws.push(word_of(ft, &fs[*idx], keep)?);
            }
            let p = ws.as_ptr() as usize as u64;
            keep.structs.push(ws);
            p
        }
        CType::Callback { .. } => 0,
    })
}

unsafe extern "C" fn host_call(ctx: *mut c_void, slot: u32, args: *const u64, ret: *mut u64) {
    let ctx = &mut *(ctx as *mut CallCtx);
    if ctx.error.is_some() {
        return;
    }
    let Some((_, closure, mt)) = ctx.callbacks.iter().find(|(s, _, _)| *s == slot).cloned() else {
        return;
    };
    let it = &mut *ctx.interp;
    let prog = it.prog;
    let r = (|| -> R<()> {
        let CType::Callback { ret: cret, .. } = ffi::classify(prog, &mt).map_err(Ctl::Trap)? else {
            return trap("internal: not a callback");
        };
        let mut vals = Vec::new();
        let mut cur = &mt;
        let mut k = 0;
        while let MT::Fun(a, b) = cur {
            let ct = ffi::classify(prog, a).map_err(Ctl::Trap)?;
            if ct == CType::Void {
                vals.push(Value::unit());
            } else {
                vals.push(value_of(
                    prog,
                    &ct,
                    a,
                    std::slice::from_raw_parts(args.add(k), 1),
                )?);
                k += 1;
            }
            cur = b;
        }
        let v = it.apply(closure, vals)?;
        match &*cret {
            CType::Struct { fields, .. } => {
                let Value::Record(fs) = &v else {
                    return trap("internal: struct is not a record");
                };
                for (j, (_, idx, ft)) in fields.iter().enumerate() {
                    *ret.add(j) = word_of(ft, &fs[*idx], ctx.keep)?;
                }
            }
            t => *ret = word_of(t, &v, ctx.keep)?,
        }
        Ok(())
    })();
    if let Err(e) = r {
        ctx.error = Some(e);
    }
}

impl<'p> Interp<'p> {
    pub(crate) fn call_foreign(&mut self, id: FuncId, args: Vec<Value>) -> R<Value> {
        let prog = self.prog;
        if self.ffi.borrow().is_none() {
            let lib = load(prog).map_err(Ctl::Trap)?;
            *self.ffi.borrow_mut() = Some(Rc::new(lib));
        }
        let lib = self.ffi.borrow().clone().unwrap();
        let f = &prog.funcs[id];
        let (params, ret) = ffi::signature(prog, f).map_err(Ctl::Trap)?;
        let pmts: Vec<MT> =
            f.ty.params(f.arity as usize)
                .0
                .into_iter()
                .cloned()
                .collect();
        let rmt = f.ty.params(f.arity as usize).1.clone();
        let mut keep = Keep::default();
        let mut words = Vec::with_capacity(params.len());
        let mut callbacks = Vec::new();
        for (k, (i, ct)) in params.iter().enumerate() {
            if let CType::Callback { .. } = ct {
                callbacks.push((ffi::slot(id, k), args[*i].clone(), pmts[*i].clone()));
                words.push(0);
            } else {
                words.push(word_of(ct, &args[*i], &mut keep)?);
            }
        }
        let mut out = vec![0u64; ffi::result_words(&ret)];
        let mut ctx = CallCtx {
            interp: self as *mut Interp<'p>,
            callbacks,
            error: None,
            keep: &mut keep,
        };
        unsafe {
            // a callback may make foreign calls of its own: restore the
            // outer call's context when this one returns
            let prev = (lib.set_host)(
                host_call as *const c_void,
                &mut ctx as *mut CallCtx as *mut c_void,
            );
            (lib.shims[&id])(words.as_ptr(), out.as_mut_ptr());
            (lib.set_host)(host_call as *const c_void, prev);
        }
        if let Some(e) = ctx.error.take() {
            return Err(e);
        }
        value_of(prog, &ret, &rmt, &out)
    }
}

fn elem_size(mt: &MT) -> usize {
    match mt {
        MT::Con(n, _) => match n.as_str() {
            "std::I8" | "std::U8" => 1,
            "std::I16" | "std::U16" => 2,
            "std::I32" | "std::U32" | "std::F32" => 4,
            _ => 8,
        },
        _ => 8,
    }
}

fn ptr_elem(mt: &MT) -> MT {
    match mt {
        MT::Con(_, args) => args.first().cloned().unwrap_or(MT::unit()),
        _ => MT::unit(),
    }
}

/// `mem.*` and `ptr.*`: raw memory, as in the C backend.
pub fn pointer_prim(sym: &str, a: &[Value], params: &[MT], result: &MT) -> R<Value> {
    let addr = |v: &Value| v.as_i128().unwrap_or(0) as usize;
    unsafe {
        Ok(match sym {
            "mem.alloc" => {
                let n = a[0].as_i128().unwrap_or(0).max(1) as usize;
                let p = calloc(n, 1);
                if p.is_null() {
                    return trap("out of memory");
                }
                Value::U64(p as usize as u64)
            }
            "mem.free" => {
                free(addr(&a[0]) as *mut c_void);
                Value::unit()
            }
            "mem.string" => {
                let s = a[0].as_str().as_bytes();
                let p = calloc(s.len() + 1, 1) as *mut u8;
                if p.is_null() {
                    return trap("out of memory");
                }
                std::ptr::copy_nonoverlapping(s.as_ptr(), p, s.len());
                Value::U64(p as usize as u64)
            }
            "ptr.cast" => a[0].clone(),
            "ptr.address" => Value::U64(addr(&a[0]) as u64),
            "ptr.at" => {
                let size = elem_size(&ptr_elem(&params[1]));
                let i = a[0].as_i128().unwrap_or(0) as i64;
                Value::U64((addr(&a[1]) as i64).wrapping_add(i * size as i64) as u64)
            }
            "ptr.read" => {
                let p = addr(&a[0]) as *const u8;
                let mut b = [0u8; 8];
                let size = elem_size(result);
                std::ptr::copy_nonoverlapping(p, b.as_mut_ptr(), size);
                let w = u64::from_le_bytes(b);
                let t = ffi::classify_scalar(result);
                value_of_scalar(&t, result, w)?
            }
            "ptr.write" => {
                let mt = &params[0];
                let t = ffi::classify_scalar(mt);
                let mut keep = Keep::default();
                let w = word_of(&t, &a[0], &mut keep)?;
                let size = elem_size(mt);
                let b = w.to_le_bytes();
                std::ptr::copy_nonoverlapping(b.as_ptr(), addr(&a[1]) as *mut u8, size);
                Value::unit()
            }
            "ptr.read-string" => {
                if addr(&a[0]) == 0 {
                    return trap("reading a string at a null pointer");
                }
                let s = CStr::from_ptr(addr(&a[0]) as *const c_char);
                match s.to_str() {
                    Ok(s) => Value::str(s),
                    Err(_) => return trap("foreign function returned a string that is not UTF-8"),
                }
            }
            _ => return trap(format!("primitive `{}` is not implemented", sym)),
        })
    }
}

fn value_of_scalar(t: &CType, mt: &MT, w: u64) -> R<Value> {
    match t {
        CType::Int { bits, signed } => int_value(mt, w, *bits, *signed),
        CType::F32 => Ok(Value::F32(f32::from_bits(w as u32))),
        CType::F64 => Ok(Value::F64(f64::from_bits(w))),
        _ => trap("internal: not a scalar"),
    }
}

extern "C" {
    fn calloc(n: usize, size: usize) -> *mut c_void;
    fn free(p: *mut c_void);
}
