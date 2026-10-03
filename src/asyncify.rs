//! `fwp build --wasm-async=asyncify`: tasks on WebAssembly engines without
//! JavaScript Promise Integration. Binaryen's Asyncify pass (`wasm-opt
//! --asyncify`) rewrites a module so that its call stack can be unwound
//! into memory and rewound later; web/fibers.js then switches fibers by
//! unwinding one and rewinding another, in any engine (Firefox, Safari,
//! node without flags). wasm-opt is an optional tool: it comes with
//! binaryen (`npm install -g binaryen`, or a system package); `FWP_WASM_OPT`
//! names it explicitly.

use std::path::{Path, PathBuf};
use std::process::Command;

/// How tasks of a WebAssembly program switch stacks.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum WasmAsync {
    /// JavaScript Promise Integration (the default).
    Jspi,
    /// Binaryen's Asyncify.
    Asyncify,
}

impl WasmAsync {
    pub fn parse(s: &str) -> Option<WasmAsync> {
        match s {
            "jspi" => Some(WasmAsync::Jspi),
            "asyncify" => Some(WasmAsync::Asyncify),
            _ => None,
        }
    }
}

/// The line that makes the C runtime check the stacks of tasks itself
/// (with Asyncify, their calls run on the engine's main stack).
pub const ASYNCIFY_MARK: &str = "#define FWP_ASYNCIFY 1\n";

/// binaryen's wasm-opt: `FWP_WASM_OPT`, or `wasm-opt` on the PATH.
pub fn wasm_opt() -> Option<PathBuf> {
    let exe = std::env::var_os("FWP_WASM_OPT")
        .map(PathBuf::from)
        .unwrap_or_else(|| PathBuf::from("wasm-opt"));
    let ok = Command::new(&exe)
        .arg("--version")
        .output()
        .is_ok_and(|o| o.status.success());
    ok.then_some(exe)
}

/// Apply Asyncify to the module at `path` in place, optimizing at `opt`
/// (`-O0` to `-O3`, `-Os`, `-Oz`). Only the calls that may switch fibers
/// (indirect calls: the switch hook is called through the function table)
/// are instrumented; WASI imports never unwind.
pub fn apply(path: &Path, opt: &str) -> Result<(), String> {
    let exe = wasm_opt().ok_or(
        "--wasm-async=asyncify needs binaryen's wasm-opt (`npm install -g binaryen`, or set FWP_WASM_OPT)",
    )?;
    let mut cmd = Command::new(&exe);
    cmd.arg(path)
        .arg("--asyncify")
        .arg("--pass-arg=asyncify-imports@fwp.none");
    if opt != "-O0" {
        cmd.arg(opt);
    }
    let out = cmd
        .arg("-o")
        .arg(path)
        .output()
        .map_err(|e| format!("cannot run {}: {}", exe.display(), e))?;
    if !out.status.success() {
        return Err(format!(
            "wasm-opt --asyncify failed:\n{}",
            String::from_utf8_lossy(&out.stderr)
        ));
    }
    Ok(())
}
