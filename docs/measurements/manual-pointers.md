# C pointers without tracing collection

This change lets native `--gc arc` programs use manually managed C pointers in
foreign calls, synchronous callbacks and exported libraries. It does not make
raw pointers safe or automatically free them. A `Ptr[T]` copies an address;
its programmer or host remains responsible for the storage at that address.
The [C tutorial](../tutorials/09-c-interop/README.md#a-pointer-into-a-c-buffer)
shows allocation, a borrowed pointer into that allocation, copying and release.

The focused suite passes on all six native hosts and actual 32-bit WebAssembly.
Independent inspection covers **150 native images and 12 WASI modules** at source
`7173927b7bc899f8c43b17e909656d9550bb2bbe`,
[run 39721437783](https://github.com/e6qu/fun-with-pipes/actions/runs/39721437783).
The [machine-readable report](manual-pointers-2026-10-22.json) records C/binary
hashes, architecture and code inspection, outputs, source IDs and complete-log
hashes. Exact-head production and documentation gates still precede delivery;
see the [handoff](../development-state.md).

These are correctness and cleanup checks, not benchmarks or C/Rust speed claims.

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
Checked ARC callbacks returning managed C string addresses remain rejected. See the full
[ownership contract](../ownership.md#c-library-results-and-foreign-calls).

## Programs and observations

| Check | Work | Required result |
|---|---|---|
| Execution corpus | 85 maintained top-level programs plus a bounded interpreter control | 82 execute with matching interpreter behavior; three intentional compile errors match diagnostics; the invalid cross-task derivative lifetime remains rejected. |
| Interpreter string copies | Repeated returned aliases, nested string callbacks, callback errors and failed argument conversion | Real allocations and frees of the temporary NUL-terminated copies balance after each group; copied results remain valid. |
| 32-bit pointers | Actual WebAssembly interpreter and generated WASI at O0/O2 | Pointer-sized reads/writes preserve adjacent bytes and signed values; offsets advance by four bytes; oversized allocation counts trap before narrowing. A deliberately omitted bound is detected. |
| Raw buffers | The C sorting, formatting and suffix-search example at O0/O2, tracing and ARC | Exact golden output; all tracked manual allocations released; deliberately omitting `mem.free` exits with the observer's failure code. ARC also checks final managed charge and no collection. |
| Callbacks | Nullable pointers, 65 repeated calls, nested calls, a caught error, suspension and cancellation; O1/O2 in both modes | Exact raw-interpreter output; no remaining callback frames or managed charge in ARC; omitted result release and task-context controls fail. |
| Wide integer buffers | Two adjacent, unaligned I128/U128 cells, signed extremes and upper bits, at O0/O2 | All 128 bits round-trip, guard bytes stay unchanged, element offsets use 16 bytes, and ARC result boxes leave no managed charge. |
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
also runs all compiler unit tests and audits the primitive contracts. Each host
passes 24 test functions across seven integration targets; Linux AMD64 also
passes 176 compiler unit tests. The corpus function executes its 82 programs
and four diagnostic cases within that count.

Preparation found and fixed missing executable suffixes in Windows artifact
copying and missing OpenSSL setup on Windows/ARM macOS. The corpus now records
native compilation errors while continuing through later cases. The new string
allocation test initially omitted its exported entries; the repaired test checks
that all four probes are compiled before calling them. Every native target and
completed job was audited before the combined repair. Earlier preparation runs
are retained in the handoff's receipts; the source and results above supersede them.

Selecting `native_runner=all` also runs the `pointer_width` job. It compiles the
Rust interpreter tests for `wasm32-wasip1` and executes them in Node, then runs
generated WASI pointer checks at O0/O2. Native pointer tests alone cannot verify
32-bit behavior. No emulated run establishes support for a native platform.

The accepted suite retains 25 native images per host for inspection: 21
executables and four static/shared libraries, with their generated C. Inspection
checks artifact hashes, native architecture, actual disassembly and absence of
tracing symbols in ARC images. It also checks exact outputs, raw-buffer negative
controls, callback results and library unload ledgers. The 82 executed corpus
cases are reported separately; only its C-interoperation binary is part of
these 25 retained images. Four cover the wide-integer repair. The 32-bit job
retains 12 WASI modules: pointer-sized storage, wide integers, three oversized
allocation traps and a deliberately missing-bound control, each at O0/O2.

The entry points are [raw-memory tests](../../tests/raw_memory_ownership.rs),
[callback tests](../../tests/foreign_callback_ownership.rs),
[library tests](../../tests/arc_library.rs) and
[corpus tests](../../tests/arc_corpus.rs). Full production and documentation checks
are still required for the exact delivery commit.
