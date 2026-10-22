// Resident-memory samples of a live native test process, in KiB.
#[cfg(windows)]
use std::ffi::c_void;
#[cfg(target_os = "macos")]
use std::process::Command;

// Win32 PROCESS_MEMORY_COUNTERS, with pointer-sized SIZE_T fields.
// https://learn.microsoft.com/windows/win32/api/psapi/ns-psapi-process_memory_counters
#[cfg(windows)]
#[repr(C)]
#[derive(Default)]
struct ProcessMemoryCounters {
    cb: u32,
    page_fault_count: u32,
    peak_working_set_size: usize,
    working_set_size: usize,
    quota_peak_paged_pool_usage: usize,
    quota_paged_pool_usage: usize,
    quota_peak_non_paged_pool_usage: usize,
    quota_non_paged_pool_usage: usize,
    pagefile_usage: usize,
    peak_pagefile_usage: usize,
}

#[cfg(windows)]
#[link(name = "kernel32")]
extern "system" {
    fn OpenProcess(access: u32, inherit: i32, pid: u32) -> *mut c_void;
    fn K32GetProcessMemoryInfo(
        process: *mut c_void,
        counters: *mut ProcessMemoryCounters,
        bytes: u32,
    ) -> i32;
    fn CloseHandle(handle: *mut c_void) -> i32;
}

#[cfg(any(target_os = "linux", target_os = "macos", windows))]
pub fn process_rss_kib(pid: u32) -> u64 {
    #[cfg(target_os = "linux")]
    {
        let status = std::fs::read_to_string(format!("/proc/{pid}/status")).unwrap();
        status
            .lines()
            .find_map(|line| line.strip_prefix("VmRSS:"))
            .unwrap()
            .split_whitespace()
            .next()
            .unwrap()
            .parse()
            .unwrap()
    }
    #[cfg(target_os = "macos")]
    {
        let out = Command::new("ps")
            .args(["-o", "rss=", "-p", &pid.to_string()])
            .output()
            .unwrap();
        assert!(out.status.success(), "{out:?}");
        String::from_utf8(out.stdout)
            .unwrap()
            .trim()
            .parse()
            .unwrap()
    }
    #[cfg(windows)]
    {
        // Query the live child's working set directly. Starting a shell for each
        // sample makes the observer dominate short repeated-work tests.
        // https://learn.microsoft.com/windows/win32/api/psapi/nf-psapi-getprocessmemoryinfo
        const PROCESS_QUERY_LIMITED_INFORMATION: u32 = 0x1000;
        let process = unsafe { OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, 0, pid) };
        assert!(
            !process.is_null(),
            "open process {pid} for RSS: {}",
            std::io::Error::last_os_error()
        );
        let bytes = std::mem::size_of::<ProcessMemoryCounters>() as u32;
        let mut counters = ProcessMemoryCounters {
            cb: bytes,
            ..ProcessMemoryCounters::default()
        };
        let queried = unsafe { K32GetProcessMemoryInfo(process, &mut counters, bytes) };
        let query_error = (queried == 0).then(std::io::Error::last_os_error);
        // Close even when the query fails, before any assertion can unwind.
        let closed = unsafe { CloseHandle(process) };
        assert_ne!(
            closed,
            0,
            "close RSS process handle: {}",
            std::io::Error::last_os_error()
        );
        assert!(
            query_error.is_none(),
            "query process {pid} RSS: {query_error:?}"
        );
        (counters.working_set_size / 1024) as u64
    }
}
