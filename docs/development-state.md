# Session handoff

Updated 2026-10-13. Complete all six directions in [PLAN](../PLAN.md) together
on `ownership-formats-windows`, [PR #134](https://github.com/e6qu/fun-with-pipes/pull/134).
The PR is a draft. Publication, fixes and squash merge after passing final-head
CI are authorized. Every commit has one line, at most 80 characters, with no
body, trailers or attribution. Keep working while CI queues; failures are work
to fix. Do not merge this unfinished bundle.

## Baseline and scope

PR #133 is accepted at `d14ec10d24765c2686dc4cfb0798012611c02a61`, with a tree
identical to tested head `70de849771aff10a3af938746c82f9b975bc989b`. All seven
production, four preflight and documentation jobs passed.
[History](roadmap-history.md) retains exact trees, runs and measurements.
Linux/macOS ARM64/AMD64 packages are accepted. Native Windows and real half/quad
language representations remain work in this bundle.

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

## CI repairs and current validation

Published code head: `5bad4a6`.

- `02a802d` fixes the Windows math build by explicitly including `<type_traits>`.
  Both native Windows jobs passed in
  [38457143007](https://github.com/e6qu/fun-with-pipes/actions/runs/38457143007),
  including compiler, socket/DLL, exact Rust/C math, allocator and all interpreter
  golden outputs/statuses. This is focused acceptance, not full Windows support.
- `5bad4a6` fixes the signal-status regression assertion exposed by the ARM macOS
  second shard in [full CI 38453295129](https://github.com/e6qu/fun-with-pipes/actions/runs/38453295129).
  The helper returns stdout/stderr plus the outer exit status; both engine
  assertions now expect `137\ncode=0`. The raw/native test runs early in
  [four-platform repair validation 38458280091](https://github.com/e6qu/fun-with-pipes/actions/runs/38458280091).
  Those repair jobs are queued; their results still need checking.
- Math WASI compilation, C ABI/resource controls and full goldens passed on both
  architectures at `412a813` in
  [38455262012](https://github.com/e6qu/fun-with-pipes/actions/runs/38455262012).
  Linux ARM64 portability passed at the same head in
  [38455264989](https://github.com/e6qu/fun-with-pipes/actions/runs/38455264989);
  remaining jobs in that older run are still running/queued.
- The retained full matrix at `ebaff5a` continues; its known CLI assertion failure
  is fixed on the branch, but the failed old head is not a passing gate. An older
  duplicate matrix was cancelled to release runner capacity; details are in history.

Focused local checks passed under `python3 scripts/local-guard.py`:
`cargo check --lib`, `cargo check --test cli`, `cargo fmt --all -- --check`,
`python3 scripts/check-roadmap.py`, and
`python3 /private/tmp/fwp-float-math-check.py` (C linking, dependency inspection,
ASan/UBSan). The permanent tests retain these checks for runners. Preserve the
64 GiB free-disk, 2 GiB target, 1 GiB RSS and 180-second local limits. Do not use
the stale local compiler as an oracle; full builds/suites/benchmarks stay on CI.

## Next action

Next: check the four-platform repair run and remaining full CI; fix further failures.
Then continue the coordinated exact-format integration, complete the Windows C
runtime and packages, and finish the remaining ownership/worker and nested-AD
acceptance rows. All six remain in this same PR. During implementation use
focused dispatched checks and cancel superseded duplicate work when appropriate.
Once complete, mark the PR ready and require all existing Linux/macOS production
jobs, added Windows acceptance jobs and docs on the final head before squash.
Skipped, cancelled or superseded runs do not establish that gate.
