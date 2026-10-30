# File errors and borrowed handles on every native target

**Prepared, not yet executed.** This extends the application cleanup checks after
PR #229. It changes tests and CI assignments, not file semantics or runtime code.

A borrowed file handle belongs to its caller. A write or read may return another
owner for the same stream. If that operation fails, its temporary owner must be
released while the caller's stream stays usable. Explicit close stops I/O;
dropping the last owner must not close the stream twice.

Three existing test targets cover the boundaries:

- `file_io_errors`: missing files and invalid UTF-8 agree with raw and optimized
  interpretation at native O1/O2. Unix also checks reading a directory. Native
  probes interrupt reads before conversion/result construction and inject write
  and close errors. The original write error must survive a later close error.
- `file_runtime_ownership`: 300 aliases release back to one owner. Failed writes,
  flushes, reads and result construction preserve that owner, while temporary
  text is freed. Count overflow must trap before changing ownership or I/O.
- `file_write_visibility`: another reader sees written bytes before the owning
  frame closes its file. A missing flush must be detected. Write/flush errors
  retain the borrowed handle, and explicitly closed handles perform no more I/O.

The previous read/error probes were excluded on Windows. They now capture the
native OS handle while the `FILE` is live, then inspect it with Windows APIs or
Unix descriptor queries. Observers compare and clear the stream pointer before
`fclose`, avoiding a comparison after the pointed-to object has ended. Windows
path hooks observe UTF-16 opening; source examples use explicit relative paths
and working directories rather than embedding platform path separators.

The ignored-write-error control now removes only the error-reporting branch,
keeping the same open/write/close path on every platform.

At O1/O2 the probes retain 22 executions per host, including controls that omit
cleanup, ownership or flushes and must fail. One diagnostic explicitly suppresses
physical frees to distinguish count release from actual freeing; this is a test
control, not an execution mode offered to programs. Every probe saves generated
C, native image, stdout, stderr and exit status under `FWP_ARC_ARTIFACTS`.

The `file-applications` focused suite includes all three targets. Linux/macOS
already assign them; Windows now explicitly assigns them too. Require focused
production Clang/GCC checks, both native Windows architectures and the complete
final-head matrix before claiming support. These are correctness/cleanup checks,
not timing measurements or comparisons with C/Rust performance.
