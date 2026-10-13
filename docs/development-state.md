# Session handoff

Updated 2026-10-14. The user merged [PR #134](https://github.com/e6qu/fun-with-pipes/pull/134).
Continue the remaining directions in [PLAN](../PLAN.md) from that merged baseline
on `roadmap-after-134`. No follow-up PR is open yet. Publication, fixes and squash
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
| 5 | In progress | Shared exact arithmetic/text/math cores and decimal-preserving syntax; value/storage/ABI/protocol migration remains |
| 6 | In progress | Native Windows Rust and generated C allocator probes pass on both architectures; full C runtime/resources/networking/TLS and PE packages remain |

The [float contract](float-formats.md) is authoritative: F16/BF16 still use F32
language values and F128 still uses F64. The shared exact cores do not yet
change that public behavior. Migrate both engines, arrays/workers, ownership,
foreign ABI, text and versioned wire encoding together; do not publish partial
format support or silently narrow quad values. Nested reverse mode and
checkpointing are not implemented.

## Current implementation

Scalar foreign-C ARC admission follows the actual ABI classifier and rejects
managed strings, pointers and callbacks. WASM typed last-owner destruction
removes count metadata before libc free, including closed File headers.
Unproved shared/cyclic graphs remain retained. Direct `iter.iterate` fusion
preserves eager lookahead, effect/trap order, early stopping and owned captures.
[History](roadmap-history.md#pr-134-development-evidence-not-final-acceptance)
links the four-platform proofs and scoped allocation/instruction measurements.

Windows Rust uses native socket handles/WSAPoll and owned DLL lifetimes.
Generated C allocation uses VirtualAlloc/VirtualFree, actual commitment/reuse,
monotonic timing, working-set accounting and PE writable-section roots with a
missing-root negative control. LLVM-MinGW UCRT assets are hash-pinned; Rust's
MSVC target separately uses SDK-aware Clang. Generated C task contexts and
platform resources still need a complete native Windows port.

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

## Next action

Next: integrate the already-tested exact-format cores with language values,
native arrays/workers, ownership/foreign ABI, text and a versioned protocol
migration. Keep interpreter/native agreement and direct rounding throughout.
Then complete the Windows C runtime and PE packages, broader ownership/worker
proofs, and nested reverse differentiation/checkpointing with measured layout
improvements. Documentation closeout is complete; five implementation areas
remain. Do not replay the merged core/fusion/reclamation work.

Use focused dispatched checks during implementation. Require all Linux/macOS
production jobs, added Windows acceptance jobs and docs on the final follow-up
head before squash. Skipped, cancelled or superseded runs do not establish that
gate. No universal GC-free, allocation-free or C/Rust speed claim is justified.
