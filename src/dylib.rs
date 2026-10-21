//! Native shared libraries used by foreign calls and TLS.
use std::ffi::{c_void, CStr};
use std::path::Path;

pub(crate) enum Scope {
    Local,
    Global,
}

pub(crate) struct Library(*mut c_void);

impl Library {
    pub(crate) fn open(path: &Path, scope: Scope) -> Result<Self, String> {
        platform::open(path, scope).map(Self)
    }

    /// The caller must use the symbol with its declared ABI and keep this
    /// library loaded for every use of the returned address.
    pub(crate) unsafe fn symbol(&self, name: &CStr) -> Result<*mut c_void, String> {
        platform::symbol(self.0, name)
    }
}

impl Drop for Library {
    fn drop(&mut self) {
        unsafe { platform::close(self.0) };
    }
}

#[cfg(all(test, not(target_family = "wasm")))]
mod tests {
    use super::*;

    #[test]
    fn loads_calls_and_releases_a_native_symbol() {
        #[cfg(windows)]
        let (path, symbol) = ("kernel32.dll", c"GetCurrentProcessId");
        #[cfg(target_vendor = "apple")]
        let (path, symbol) = ("/usr/lib/libSystem.B.dylib", c"getpid");
        #[cfg(all(not(windows), not(target_vendor = "apple")))]
        let (path, symbol) = ("libc.so.6", c"getpid");
        // Reopen after Drop too, so stale process-global handles cannot satisfy
        // only the first load. Both ABI declarations return a 32-bit PID.
        for _ in 0..2 {
            let lib = Library::open(Path::new(path), Scope::Local).unwrap();
            let address = unsafe { lib.symbol(symbol) }.unwrap();
            let pid: unsafe extern "system" fn() -> u32 = unsafe { std::mem::transmute(address) };
            assert_eq!(unsafe { pid() }, std::process::id());
            assert!(unsafe { lib.symbol(c"fwp_missing_symbol_for_test") }.is_err());
        }
    }

    #[test]
    fn rejects_invalid_paths() {
        assert!(Library::open(Path::new("fwp_missing_library_for_test"), Scope::Local).is_err());
        assert!(Library::open(Path::new("bad\0path"), Scope::Local).is_err());
    }
}

#[cfg(not(windows))]
mod platform {
    use super::*;
    use std::ffi::{c_char, c_int, CString};

    extern "C" {
        fn dlopen(path: *const c_char, flags: c_int) -> *mut c_void;
        fn dlsym(handle: *mut c_void, symbol: *const c_char) -> *mut c_void;
        fn dlclose(handle: *mut c_void) -> c_int;
        fn dlerror() -> *const c_char;
    }

    unsafe fn error() -> String {
        let p = dlerror();
        if p.is_null() {
            "dynamic loader returned a null address".into()
        } else {
            CStr::from_ptr(p).to_string_lossy().into_owned()
        }
    }

    pub(super) fn open(path: &Path, scope: Scope) -> Result<*mut c_void, String> {
        let path = CString::new(path.as_os_str().as_encoded_bytes())
            .map_err(|_| "library path contains NUL")?;
        let global = if cfg!(target_vendor = "apple") {
            0x8
        } else {
            0x100
        };
        let flags = 2 | match scope {
            Scope::Local => 0,
            Scope::Global => global,
        };
        unsafe {
            let handle = dlopen(path.as_ptr(), flags);
            if handle.is_null() {
                Err(error())
            } else {
                Ok(handle)
            }
        }
    }

    pub(super) unsafe fn symbol(handle: *mut c_void, name: &CStr) -> Result<*mut c_void, String> {
        let p = dlsym(handle, name.as_ptr());
        if p.is_null() {
            Err(error())
        } else {
            Ok(p)
        }
    }

    pub(super) unsafe fn close(handle: *mut c_void) {
        dlclose(handle);
    }
}

#[cfg(windows)]
mod platform {
    use super::*;
    use std::ffi::c_char;
    use std::os::windows::ffi::OsStrExt;

    #[link(name = "kernel32")]
    extern "system" {
        fn LoadLibraryW(path: *const u16) -> *mut c_void;
        fn GetProcAddress(handle: *mut c_void, name: *const c_char) -> *mut c_void;
        fn FreeLibrary(handle: *mut c_void) -> i32;
    }

    pub(super) fn open(path: &Path, _scope: Scope) -> Result<*mut c_void, String> {
        // PE resolves dependencies by module name; it has no RTLD_GLOBAL flag.
        let mut path: Vec<u16> = path.as_os_str().encode_wide().collect();
        if path.contains(&0) {
            return Err("library path contains NUL".into());
        }
        path.push(0);
        let handle = unsafe { LoadLibraryW(path.as_ptr()) };
        if handle.is_null() {
            Err(std::io::Error::last_os_error().to_string())
        } else {
            Ok(handle)
        }
    }

    pub(super) unsafe fn symbol(handle: *mut c_void, name: &CStr) -> Result<*mut c_void, String> {
        let p = GetProcAddress(handle, name.as_ptr());
        if p.is_null() {
            Err(std::io::Error::last_os_error().to_string())
        } else {
            Ok(p)
        }
    }

    pub(super) unsafe fn close(handle: *mut c_void) {
        FreeLibrary(handle);
    }
}
