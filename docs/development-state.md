# Session handoff

Updated 2026-10-14. The user merged [PR #134](https://github.com/e6qu/fun-with-pipes/pull/134).
Continue the remaining directions in [PLAN](../PLAN.md) from that merged baseline
on `roadmap-after-134`, [PR #135](https://github.com/e6qu/fun-with-pipes/pull/135).
The user authorized all remaining work together in this one draft PR. Publication, fixes and squash
merge after passing final-head CI remain authorized. Every commit has one line,
at most 80 characters, with no body, trailers or attribution. Failing tests are
work to fix; queued CI gates merging, not implementation.

## Baseline and scope

PR #134 merged as `5c0287c959ad705a6ceefebe83346015cb23fff5`; tree
`f6f70ed9e41cde021ba223241f59b7cee745b4b0` equals tested head
`29b48c31a7012c941d0bc555ee51d12c2c594b0b`. All seven Linux/macOS production
jobs and documentation passed. [History](roadmap-history.md#pr-134-merge-closeout)
records exact runs. The merge delivers the implemented subset, not completion
of the original six-item scope. Linux/macOS ARM64/AMD64 packages remain supported;
full Windows and true half/quad language formats remain unfinished.

## Active bundle

| Step | Status | Implemented and still required |
|---|---|---|
| 1 | Implemented | One live handoff, accepted baseline and historical evidence; remove stale next actions |
| 2 | In progress | Scalar foreign ARC and proved WASM/File freeing tested; retained callbacks, protocols and cyclic ownership proofs remain |
| 3 | In progress | Direct iterate fusion measured; broader producer/worker/aggregate specialization remains |
| 4 | Pending | Measured kernel/layout improvements, nested reverse differentiation and checkpointing |
| 5 | In progress | Exact scalar values, inline arrays, closed quad workers and protocol v2 implemented; C ABI, numeric record workers and complete ownership/platform acceptance remain under validation |
| 6 | In progress | Native Windows Rust and generated C allocator probes pass on both architectures; full C runtime/resources/networking/TLS and PE packages remain |

The [float contract](float-formats.md) is authoritative. The accepted PR #134
baseline aliases F16/BF16 to F32 and F128 to F64. PR #135 is changing scalar
values, parsing, math, text/JSON and protocol encoding to real formats; these
changes are under development and not yet accepted by runner validation. Migrate both engines, arrays/workers, ownership,
foreign ABI, text and versioned wire encoding together; do not publish partial
format support or silently narrow quad values. Nested reverse mode and
checkpointing are not implemented.

## Current implementation

The merged baseline admits scalar foreign-C ARC via the ABI classifier; the
active bundle extends scoped strings and callbacks as described below. WASM typed last-owner destruction
removes count metadata before libc free, including closed File headers.
Unproved shared/cyclic graphs remain retained. Direct `iter.iterate` fusion
preserves eager lookahead, effect/trap order, early stopping and owned captures.
[History](roadmap-history.md#pr-134-development-evidence-not-final-acceptance)
links the four-platform proofs and scoped allocation/instruction measurements.

Windows Rust uses native socket handles/WSAPoll and owned DLL lifetimes.
Generated C allocation uses VirtualAlloc/VirtualFree, actual commitment/reuse,
monotonic timing, working-set accounting and PE writable-section roots with a
missing-root negative control. LLVM-MinGW UCRT assets are hash-pinned; Rust's
MSVC target separately uses SDK-aware Clang. Generated C tasks now use Windows fibers with explicit suspended register/stack
roots, demand-committed stacks, native console shutdown and overflow handling.
A native probe checks each root range independently, floating-point state,
reclamation and preservation of a host-owned fiber. Its runner execution is
pending; generated networking, resources/processes, static memory and packaging
still need the rest of the Windows port.

SoftFloat 3e, scoped gdtoa and TLFloat 1.15.0 are vendored with licenses,
provenance and recorded patches. The shared core has exact half/bfloat/quad
arithmetic, direct decimal rounding/shortest text, full-width integer conversion,
comparison, ties-away integral rounding and truncating remainder. Transcendentals
have an explicit 1-ULP contract and fixed integer storage. Arithmetic NaNs are
canonical; bit transport preserves payloads. Decimal calls use 4 KiB stack
scratch and release overflow storage on success/failure. Math object checks
reject allocator/C++ runtime dependencies; UBSan has an omitted-guard control.

Tokens/AST preserve decimal text until monomorphization. `SFloat` now carries
an unsuffixed decimal String, with matching validation/rendering in both engines.
The public macro API change is documented. `float_literals` checks formatting,
macro expansion and raw/native O1/O2 behavior at a known F32 rounding boundary.

## Validation

- All seven final-head production jobs passed in
  [38460359221](https://github.com/e6qu/fun-with-pipes/actions/runs/38460359221):
  Linux ARM64/AMD64, regular and GC-stress macOS ARM/Intel, and bench.
  [Final-head docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38458685467)
  also passed. The merged tree is identical to this tested tree.
- All four focused repair jobs passed at `5bad4a6` in
  [38458280091](https://github.com/e6qu/fun-with-pipes/actions/runs/38458280091),
  including the corrected raw/native child-signal status assertions.
- Both native Windows diagnostic jobs passed at `02a802d` in
  [38457143007](https://github.com/e6qu/fun-with-pipes/actions/runs/38457143007).
  These cover Rust/compiler/socket/DLL, exact math C ABI, allocator and interpreter
  goldens; they do not establish the unfinished Windows C runtime or packages.
- Both focused WASI jobs passed at `412a813` in
  [38455262012](https://github.com/e6qu/fun-with-pipes/actions/runs/38455262012),
  including math C ABI, resource controls and full goldens. Final production CI
  also passed its required WebAssembly checks.

Merge-closeout local check passed: `python3 scripts/local-guard.py python3
scripts/check-roadmap.py` (48 doc link sets, 106 immutable anchors, six plan
steps and commit-message checks).

The known Windows header, sharder, WASI loader and CLI assertion failures are
fixed. Older failures/cancellations remain historical evidence, not current next
actions. Full builds/suites/benchmarks stay on runners. Local checks must use
`python3 scripts/local-guard.py` and retain the 64 GiB free-disk, 2 GiB target,
1 GiB RSS and 180-second limits. Do not use the stale local compiler as an oracle.

## Active implementation

PR #135 includes exact scalar values/arithmetic, direct decimal rounding,
text/JSON, 2/2/16-byte protocol v2 payloads and versioned fingerprints. F128
arrays store inline bits, with independent owned boxes at escaping boundaries;
half/bfloat worker fields use u16 bits. Closed quad numeric workers use direct
bit-struct arithmetic without intermediate boxes. Generic quad values still box. Closed flat numeric record workers now carry
F128/I128/U128 fields directly in C structs; boxed entry/exit copies bits, drops
incoming owners and protects partial returned records. Raw/native/trap-order
checks and allocation/stack/disassembly measurements await runners. Nested or
non-numeric record fields continue through ordinary typed lowering.

The C ABI uses explicit u16 half/bfloat bits and a two-word quad struct, including
shim records/callbacks and pointer widths. ARC uses the same recursive pointer-free
C value classifier. Raw foreign pointers and callbacks returning managed C addresses still need
lifetime proofs. Scoped text/byte borrows, copied string results and synchronous
callbacks carrying C value bits are now implemented with task-local contexts and
unwind cleanup; physical-reclamation, reentry, suspension and cancellation
controls need runner execution.
C/C++ core archives are keyed by source/toolchain/target/options; emitted C has
companion core sources. Cache pinning protects already-open archives from concurrent
eviction. Cache concurrency, manual linking and library exports need acceptance.

Array builders protect initialized elements, temporary escaping elements and fold
accumulators through failure. Consumed updates, view headers and sort scratch also
have cleanup owners. The new nonreturning `fail` ownership contract corrects an
ARC rejection for boxed result types; it does not manufacture a normal result.

Retained-task ARC admission is under development. Child callbacks start with fresh
State/AD contexts in the closure-flow proof. Typed handles/captures/results are
acyclic when channels and raw pointer mutation remain excluded. New controls cover
aliases, older captured handles, independent State, cancellation before/after entry,
scope failure and physical reclamation without collection. No general cyclic or
external-callback admission is claimed.

## Active checks

- At `dfca8e6`, all four Linux/macOS hosts passed exact-format/protocol/array
  tests and all seven foreign ABI/export tests in
  [38527790040](https://github.com/e6qu/fun-with-pipes/actions/runs/38527790040).
  The only failures were reversed `compose` arguments in the new task and
  foreign lifetime fixtures. `9aed34b` corrects their left-to-right order.
- [38528964109](https://github.com/e6qu/fun-with-pipes/actions/runs/38528964109)
  at `9aed34b` is queued for the combined task/foreign lifetime, numeric record
  worker and allocation/stack/disassembly checks. These new proofs have not
  passed yet. Keep fixing actual failures before claiming acceptance.
- All four hosts passed manual exact-core linking and concurrent core-cache
  publication/reuse/eviction at `3800499` in
  [38526720651](https://github.com/e6qu/fun-with-pipes/actions/runs/38526720651).
  Later scalar/ABI changes still need final-head production verification.
- At `bb523a5`, both actual WASI jobs passed in
  [38523463736](https://github.com/e6qu/fun-with-pipes/actions/runs/38523463736),
  including goldens, core math and physical reclamation. Both native Windows
  foundation jobs passed in
  [38523466974](https://github.com/e6qu/fun-with-pipes/actions/runs/38523466974).
  These Windows checks do not establish the generated runtime or packages.
- Guarded focused lint passed for the compiler and the `wide_workers`,
  `arc_tasks`, `foreign_callback_ownership`, `arc_execution`, `ffi`,
  `float_linking`, `array_unwind_ownership` and `windows_context` targets.
  `python3 scripts/local-guard.py cargo fmt --all -- --check` and guarded
  concatenated runtime C syntax checking passed after the fiber integration.
  The Windows-only probe is excluded on macOS; only native Windows execution
  can verify it. Guarded Python syntax checking passed for `measure-wide.py`.

## Next action

Next: validate and fix array unwind, C ABI and retained-task ARC controls on
all four Linux/macOS hosts. Finish quad record-worker measurements and ABI/cache acceptance, plus managed
foreign/protocol ownership proofs. Keep raw/native agreement and exact rounding.
Then complete the Windows C runtime and PE packages, broader ownership/worker
proofs, and nested reverse differentiation/checkpointing with measured layout
improvements. Documentation closeout is complete; five implementation areas
remain. Do not replay the merged core/fusion/reclamation work.

Use focused dispatched checks during implementation. Require all Linux/macOS
production jobs, added Windows acceptance jobs and docs on the final follow-up
head before squash. Skipped, cancelled or superseded runs do not establish that
gate. No universal GC-free, allocation-free or C/Rust speed claim is justified.
