//! Ahead-of-time compilation for `fwp run`, `fwp exec`, `fwp test` and
//! `fwp serve`: the program is compiled to a native executable through C,
//! cached by the hash of everything that decides its contents, and run.
//! The interpreter stays the reference and runs a program when asked
//! (`--interp`, `FWP_RUN=interp`), inside WebAssembly, and when no C
//! compiler is found.

use std::path::{Path, PathBuf};

/// How a command runs a program.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Mode {
    Native,
    Interp,
}

/// Remove `--interp` and `--native` from the options before the program
/// file, and decide the mode: the option, else `FWP_RUN`, else native.
pub fn take_mode(args: &mut Vec<String>) -> Result<Mode, String> {
    let mut mode = None;
    let mut i = 0;
    while i < args.len() {
        match args[i].as_str() {
            "--interp" => {
                mode = Some(Mode::Interp);
                args.remove(i);
            }
            "--native" => {
                mode = Some(Mode::Native);
                args.remove(i);
            }
            a if a.ends_with(".fwp") || a == "-" => break,
            _ => i += 1,
        }
    }
    if let Some(m) = mode {
        return Ok(m);
    }
    match std::env::var("FWP_RUN").as_deref() {
        Ok("interp") => Ok(Mode::Interp),
        Ok("native") | Ok("") | Err(_) => Ok(Mode::Native),
        Ok(other) => Err(format!("FWP_RUN is `native` or `interp`, not `{}`", other)),
    }
}

/// Remove an `-O0`..`-O3`/`-Os` option before the program file.
pub fn take_opt(args: &mut Vec<String>, default: &str) -> String {
    let mut i = 0;
    while i < args.len() {
        let a = &args[i];
        if a.ends_with(".fwp") || a == "-" {
            break;
        }
        if a.starts_with("-O") && a.len() <= 4 {
            return args.remove(i);
        }
        i += 1;
    }
    default.to_string()
}

/// The C compiler native programs are built with.
pub fn cc() -> String {
    std::env::var("CC").unwrap_or_else(|_| "cc".into())
}

/// Whether the C compiler can be started.
pub fn have_cc() -> bool {
    std::process::Command::new(cc())
        .arg("--version")
        .stdout(std::process::Stdio::null())
        .stderr(std::process::Stdio::null())
        .status()
        .is_ok_and(|s| s.success())
}

/// The directory of cached executables: `FWP_CACHE_DIR`, else
/// `$XDG_CACHE_HOME/fwp`, else `~/.cache/fwp`, else one in the temporary
/// directory.
pub fn cache_dir() -> PathBuf {
    let var = |k: &str| {
        std::env::var_os(k)
            .filter(|v| !v.is_empty())
            .map(PathBuf::from)
    };
    if let Some(d) = var("FWP_CACHE_DIR") {
        return d;
    }
    if let Some(d) = var("XDG_CACHE_HOME") {
        return d.join("fwp");
    }
    if let Some(h) = var("HOME") {
        return h.join(".cache").join("fwp");
    }
    std::env::temp_dir().join("fwp-cache")
}

/// How many executables the cache keeps (`FWP_CACHE_MAX`, default 256);
/// the least recently used go first.
fn cache_max() -> usize {
    std::env::var("FWP_CACHE_MAX")
        .ok()
        .and_then(|v| v.parse().ok())
        .unwrap_or(256)
}

fn hex(bytes: &[u8]) -> String {
    bytes.iter().map(|b| format!("{:02x}", b)).collect()
}

/// The cache key of an executable: the C source, the compiler and its
/// options, the C code and libraries it links, and this version of fwp.
fn key(c_source: &str, opt: &str) -> String {
    let mut k = Vec::new();
    for part in [env!("CARGO_PKG_VERSION"), &cc(), opt, c_source] {
        k.extend_from_slice(part.as_bytes());
        k.push(0);
    }
    if let Some(prefix) = std::env::var_os("FWP_OPENSSL_DIR") {
        k.extend_from_slice(prefix.as_encoded_bytes());
    }
    k.push(0);
    for l in crate::ffi::links() {
        k.extend_from_slice(l.as_bytes());
        k.push(0);
        // a linked source or object file changes the executable
        if let Ok(bytes) = std::fs::read(&l) {
            k.extend_from_slice(&crate::grpc::web::sha1(&bytes));
        }
        k.push(0);
    }
    hex(&crate::grpc::web::sha1(&k))
}

/// Why there is no executable.
#[derive(Debug)]
pub enum Error {
    /// The C compiler cannot be started: the program is interpreted.
    NoCc,
    Failed(String),
}

/// The cached executable for a C program, compiled when missing.
pub fn executable(c_source: &str, opt: &str) -> Result<PathBuf, Error> {
    let dir = cache_dir().join("native");
    std::fs::create_dir_all(&dir)
        .map_err(|e| Error::Failed(format!("cannot create the cache {}: {}", dir.display(), e)))?;
    let exe = dir.join(key(c_source, opt));
    if exe.is_file() {
        // used now: the cache drops the least recently used first. Open the
        // executable read-only: a writable open can make concurrent native
        // stages terminate on macOS, even without writing any bytes.
        if let Ok(f) = std::fs::File::open(&exe) {
            let _ = f.set_modified(std::time::SystemTime::now());
        }
        return Ok(exe);
    }
    if !have_cc() {
        return Err(Error::NoCc);
    }
    // compiled under a private name and renamed into place, so concurrent
    // runs of one program never see half an executable
    let tmp = dir.join(format!(
        ".{}.{}.tmp",
        exe.file_name().unwrap().to_string_lossy(),
        std::process::id()
    ));
    let built = crate::cgen::compile_c(c_source, &tmp, opt)
        .and_then(|_| std::fs::rename(&tmp, &exe).map_err(|e| e.to_string()));
    if built.is_err() {
        let _ = std::fs::remove_file(&tmp);
    }
    built.map_err(Error::Failed)?;
    prune(&dir);
    Ok(exe)
}

/// Remove the least recently used executables beyond the cache's size.
fn prune(dir: &Path) {
    let Ok(rd) = std::fs::read_dir(dir) else {
        return;
    };
    let mut entries: Vec<(std::time::SystemTime, PathBuf)> = rd
        .filter_map(|e| e.ok())
        .filter(|e| !e.file_name().to_string_lossy().starts_with('.'))
        .filter_map(|e| Some((e.metadata().ok()?.modified().ok()?, e.path())))
        .collect();
    let max = cache_max();
    if entries.len() <= max {
        return;
    }
    entries.sort();
    for (_, p) in &entries[..entries.len() - max] {
        let _ = std::fs::remove_file(p);
    }
}

/// `fwp cache dir` prints the cache directory; `fwp cache clean` empties it.
pub fn cache_command(args: &[String]) -> i32 {
    match args.first().map(String::as_str) {
        Some("dir") => {
            println!("{}", cache_dir().display());
            0
        }
        Some("clean") => {
            let dir = cache_dir().join("native");
            match std::fs::remove_dir_all(&dir) {
                Ok(()) => 0,
                Err(e) if e.kind() == std::io::ErrorKind::NotFound => 0,
                Err(e) => {
                    eprintln!("fwp cache: cannot remove {}: {}", dir.display(), e);
                    1
                }
            }
        }
        _ => {
            eprintln!("fwp cache: usage: fwp cache dir | fwp cache clean");
            2
        }
    }
}

/// Run an executable with arguments, the program's name as `argv[0]`, and
/// the standard streams of this process. On Unix the executable replaces
/// this process, so signals, the process id and the exit status are the
/// program's own; elsewhere it runs as a child and this returns its status.
pub fn run(exe: &Path, name: &str, args: &[String]) -> i32 {
    let mut cmd = std::process::Command::new(exe);
    cmd.args(args);
    #[cfg(unix)]
    {
        use std::io::Write;
        use std::os::unix::process::CommandExt;
        let _ = std::io::stdout().flush();
        let _ = std::io::stderr().flush();
        let e = cmd.arg0(name).exec();
        eprintln!("fwp: cannot run {}: {}", exe.display(), e);
        1
    }
    #[cfg(not(unix))]
    {
        let _ = name;
        match cmd.status() {
            Ok(s) => s.code().unwrap_or(1),
            Err(e) => {
                eprintln!("fwp: cannot run {}: {}", exe.display(), e);
                1
            }
        }
    }
}

/// Whether a command runs programs natively: in the native mode, outside
/// WebAssembly.
pub fn wants_native(mode: Mode) -> bool {
    mode == Mode::Native && !cfg!(target_family = "wasm")
}

/// The note printed when a program is interpreted for want of a C
/// compiler (not when `FWP_RUN` chose the mode).
pub fn note_no_cc(cmd: &str) {
    if std::env::var_os("FWP_RUN").is_none() {
        eprintln!(
            "fwp {}: no C compiler (`{}`), so the program is interpreted; set CC, or pass --interp",
            cmd,
            cc()
        );
    }
}

/// Run a program natively: generate its C, compile it into the cache when
/// missing, and run it. `None` when there is no C compiler, so the caller
/// interprets the program instead.
pub fn run_native(
    cmd: &str,
    generated: Result<String, String>,
    opt: &str,
    name: &str,
    args: &[String],
) -> Option<i32> {
    let csrc = match generated {
        Ok(s) => s,
        Err(e) => {
            eprintln!("fwp {}: {}", cmd, e);
            return Some(1);
        }
    };
    match executable(&csrc, opt) {
        Ok(exe) => Some(run(&exe, name, args)),
        Err(Error::NoCc) => {
            note_no_cc(cmd);
            None
        }
        Err(Error::Failed(e)) => {
            eprintln!("fwp {}: {}", cmd, e);
            Some(1)
        }
    }
}

/// The options of a TLS server as its native executable takes them.
pub fn tls_args(tls: &Option<crate::tls::ServerFiles>) -> Vec<String> {
    let mut a = Vec::new();
    if let Some(t) = tls {
        a.extend(["--tls-cert".to_string(), t.cert.clone()]);
        a.extend(["--tls-key".to_string(), t.key.clone()]);
        if !t.client_ca.is_empty() {
            a.extend(["--tls-client-ca".to_string(), t.client_ca.clone()]);
        }
    }
    a
}
