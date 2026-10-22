# C pointers without tracing collection

This change lets native `--gc arc` programs use manually managed C pointers in
foreign calls, synchronous callbacks and exported libraries. It does not make
raw pointers safe or automatically free them. A `Ptr[T]` copies an address;
its programmer or host remains responsible for the storage at that address.
The [C tutorial](../tutorials/09-c-interop/README.md#a-pointer-into-a-c-buffer)
shows allocation, a borrowed pointer into that allocation, copying and release.

**Validation is in progress.** Linux AMD64/ARM64 and Intel macOS pass the native suite and independent
binary inspection. ARM macOS and the Windows setup repair are pending. See the
[handoff](../development-state.md) for current jobs and the final delivery gate.
These are correctness and cleanup checks, not benchmarks or claims of parity
with C/Rust.

## What changes at the boundary

C's nullable pointer maps to `Option[Ptr[T]]`: NULL becomes `None`, and another
address becomes `Some address`. The option may need a counted fwp allocation;
its release never frees the pointee. The same distinction applies to records
with both pointer and string fields. Their string fields have explicit result
owners; their raw pointers do not.

For example, `strchr` returns an address inside its input buffer. The updated
example uses `mem.string` to allocate that buffer, calls `strchr`, copies the
suffix with `ptr.read-string`, then calls `mem.free`. Searching `"hello"` for
byte 108 (`l`) produces `Some "llo"`. The copied suffix remains valid after the
C buffer is freed. C must not return or retain a raw address into a managed
`String` or `Bytes` argument whose borrow ends with the foreign call.

Callbacks remain synchronous on the calling task, including suspension and
reentrant calls. C cannot keep a callback after the receiving call returns.
Callbacks returning managed C string addresses remain rejected. See the full
[ownership contract](../ownership.md#c-library-results-and-foreign-calls).

## Programs and observations

| Check | Work | Required result |
|---|---|---|
| Execution corpus | 85 maintained top-level programs plus a bounded interpreter control | 82 execute with matching interpreter behavior; three intentional compile errors match diagnostics; the invalid cross-task derivative lifetime remains rejected. |
| Raw buffers | The C sorting, formatting and suffix-search example at O0/O2, tracing and ARC | Exact golden output; all tracked manual allocations released; deliberately omitting `mem.free` exits with the observer's failure code. ARC also checks final managed charge and no collection. |
| Callbacks | Nullable pointers, 65 repeated calls, nested calls, a caught error, suspension and cancellation; O1/O2 in both modes | Exact raw-interpreter output; no remaining callback frames or managed charge in ARC; omitted result release and task-context controls fail. |
| Libraries | Pointer identity, nullable pointers, a record with an owned string and borrowed pointer, and manual allocation/copy/release | The host's buffer remains its own; copied strings survive buffer changes/freeing; releasing a returned record releases its strings only. |
| Library lifetime | 257 ordinary call sequences per loaded instance, failure controls, O1/O2, static/shared linkage, and three shared-library load/unload rounds | Zero final managed charge and collections; existing controls detect lost owners, extra result boxes and redundant retains. |

The corpus records the exit status and whether each case reaches ordinary
teardown. An intentionally trapping program is not a successful return-ledger
observation. Separate callback and library tests exercise cleanup on failure and
cancellation. Raw buffers and managed storage have separate counters; neither is
whole-process resident memory. No elapsed-time or allocation-free claim follows
from these observations.

## Reproduction and binary inspection

The `pointer-ownership` suite in the **Numerical and ownership evidence** workflow
uses production GCC on Linux, Clang on macOS and LLVM-MinGW on Windows. Select
`native_runner=all` for all six hosts, or name a host explicitly. It runs the
existing corpus, raw-memory, callback, library, ARC execution, C interop and
pointer-arithmetic targets without stopping after a failed target. Linux AMD64
also runs all compiler unit tests and audits the primitive contracts.

Program/compiler source is `0ca3fba4f718fb02afbcc385ac41e763a8320361`, run
`39716002463`. Both Windows jobs completed all seven targets and found two
artifact-path failures: execution found the `.exe`, while filesystem copying
used an extensionless path. Repair `2eaccbc77c428ab37986d8130d70ff1c2e9ca1cf`
adds explicit `.exe` paths in those two tests; compiler, runtime and program
fixtures are identical. Windows reruns are `39717062123` (AMD64) and
`39717065021` (ARM64). Those reruns pass the pointer checks but expose missing OpenSSL headers at the
corpus HTTP example. The focused workflow now uses production TLS setup, and
the corpus records native compilation failures without abandoning later cases.
Final repair sources/runs remain in the handoff until acceptance is complete.
Passing Unix jobs are not repeated for these setup/reporting changes.

Each passing host retains 21 native images for independent inspection: 17
executables and four static/shared libraries, with their generated C. Inspection
checks artifact hashes, native architecture, actual disassembly and absence of
tracing symbols in ARC images. It also checks exact outputs, raw-buffer negative
controls, callback results and library unload ledgers. The 82 executed corpus
cases are reported separately; only its C-interoperation binary is part of
these 21 retained images.

The entry points are [raw-memory tests](../../tests/raw_memory_ownership.rs),
[callback tests](../../tests/foreign_callback_ownership.rs),
[library tests](../../tests/arc_library.rs) and
[corpus tests](../../tests/arc_corpus.rs). Full production and documentation checks
are still required for the exact delivery commit.
