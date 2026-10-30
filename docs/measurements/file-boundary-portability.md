# File errors and borrowed handles on every native target

**Focused checks pass; complete delivery gates remain pending.** This extends
the application cleanup checks after PR #229. It changes tests and CI assignments,
not file semantics or runtime code.

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

A source audit also found seven test probes assigning `setjmp` to a local
initializer. C does not permit that context; they now branch directly on
`setjmp`, keeping failure flags assigned only after returning from the jump.
The same repair covers the resource-frame and WASI resource-count probes.
The repaired file probes pass both native Windows architectures. The complete
next matrix must also execute the resource-frame and WASI changes; this is not a
diagnosed runtime failure.

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

## First focused results

Source `3cbc6b63`: Linux GCC run `41053039581`, job `124053572242`, passes all
16 tests in six targets. Its complete log and all 22 saved boundary executions
pass independent audit, including exact error/flush omission controls and native
AMD64 headers. Artifact `12975797627` retains the evidence.

Windows ARM run `41053015126`, job `124053490719`, completes all six targets:
13 tests pass and three C probes fail compilation. Their prefixes include C
headers before declaring the Windows 10 API target; those headers select an older
target, which the production runtime correctly rejects. The repair declares the
required target before every include, including the shared stream observer and
the independent flush probe. The full log has no other failures or warnings.
Windows AMD run `41053005173`, job `124053458381`, has exactly the same three
failures among 13 passes; its full log is audited. ARM Mac run `41053051853`, job
`124053615503`, passes 16 tests in six targets. Its full log and all 22 saved
executions/native headers are audited; artifact `12976686469` retains the evidence.

## Repaired Windows results

At source `c69b9b918c77e1050299e85fd6489123285be2aa`, both native Windows
runs pass all 16 tests in six targets. Their complete logs have no failed targets
or warnings. All 22 saved executions per host pass independent audit: exact
write-error and missing-flush controls, outputs, statuses, sources and native
PE architecture headers.

| Host | Run / job | Saved evidence artifact |
|---|---|---|
| Windows AMD64 | `41055449823` / `124061719633` | `12977885309` |
| Windows ARM64 | `41055457917` / `124061748283` | `12977067487` |

The earlier Linux/macOS results precede the `setjmp` repair. Require the next
complete final-head matrix before delivery, including the resource-frame and
actual WASI resource-count tests. Passing focused Windows probes does not replace
those gates.
