# Current work

**Next:** publish the typed-destructuring repair and rerun the affected native
suite, now including `local_bindings`, for
[PR #238](https://github.com/e6qu/fun-with-pipes/pull/238). Audit all results before
the full final-head matrix. [The protocol](measurements/derivative-recording-moves.md)
defines acceptance.

Worktree `/private/tmp/fwp-returned-callables`, branch `move-derivative-weights`.
Base `94abb83cb33cb52bdcafb19c67c855cf9007059f`. Preserve the primary checkout's
unrelated edits. Implementation, publication and squash merge are authorized.
One-line commit subjects, at most 80 characters; no body, trailers or attribution.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | Verified | Protocol published as `238926d0` |
| 2 | Implemented | Recording API, interpreter, C generation and runtime need runner verification |
| 3 | Implemented | Caller, inventory, count and failure/alias updates need focused verification |
| 4 | Pending | Focused native evidence, then full exact-head gates and merge |

## Verified baseline

PR #237 passed production `41292025233` and documentation `41292025256` on
`7590f36b770690cc9df730246b4ef614077e2edd`. Every completed target and diagnostic
was audited. Merge `94abb83cb33cb52bdcafb19c67c855cf9007059f` has the identical tree
`7d86145d9038ccea1b07e7ab719cf8490abf6da8` and a verified one-line squash message.
[History](roadmap-history.md#typed-derivative-owners-and-documentation-pr-237)
records the delivery; its focused counts are not elapsed-time measurements.

No failure is open in that final pipeline. Deliberate panic/TLS rejection and
runner failure controls passed. D2/N1/N2 timing acceptance, the original Xeon
construction regressions and individual Swift ARC counts remain open.

## Checks for this batch

Guarded Rust/language formatting and generated library documentation passed.
The guard first refused checks below 64 GiB; deleting duplicate downloaded #237
artifacts (retained on GitHub) restored enough space. No limits changed.
Frozen primitive inventory passed: 394 declarations, 384 symbols, no unresolved
contracts. Historical timing-budget controls passed (9 tests). The roadmap checker
rejected the unsupported status word “Complete”; corrected it to “Verified”.
The corrected roadmap audit passed: 196 document link sets, 106 preparation pairs
and four steps. A bounded Clang O1 runtime-only probe passed the normal transfer
and missing-cleanup/extra-retain controls with workspace reuse off/on. It uses
the saved minimal C harness with the current runtime; it does not verify compiler
lowering or raw interpretation. Command:
`python3 scripts/local-guard.py python3 /private/tmp/fwp-moves-runtime-check.py`.
The first harness assembly stopped before compilation because its saved kernel
differed; explicit runtime-section boundaries fixed assembly. All six executions
then matched their expected statuses (0, 237 and 243).

Focused run `41301660682` on `f5f61bf2b09efbc3d7b572133fb5926a30cbca28`
failed on all three hosts. Every completed job was audited: one Rust E0308 error
at `src/interp.rs:542` (Vec passed where a slice reference is required), followed
by the same failed test build and the report's expected rejection of missing
artifacts. Formatting and inventory passed; no native test executed. The caller
now passes `&a`; guarded Rust formatting passes. Docs `41301661813` had no failed
steps when this repair was prepared. Verify the repair on runners.

Cancelled redundant post-merge run `41298428164` on #237’s already-verified
identical tree; it had no failed steps. Preserve pending #238 runs. Use
`python3 scripts/local-guard.py` for focused local work, serially. Full builds,
suites and measurements stay on runners. Disk has about 64.3 GiB free, close to
the fixed 64 GiB floor; move refused work to CI instead of bypassing the guard.

## Destructuring repair

Run `41302699512` on `9285227a3f8e360a9c191ea1dc45ac95e0e6a62d` was audited
on GCC ARM64/AMD64 and Clang ARM64: all 29 affected native cases ran per host;
23 passed and six failed in four targets. Direct recording/counts, physical
cleanup, cancellation, workspace, capacity and library unload passed. The six
failures share an unresolved `?` type during native ownership admission (scopes,
nested/Jacobian, precision and checkpoint semantics). Lint, two ownership unit
tests, inventory and native reports passed. Docs `41302703312` passed; its only
failure text comes from the deliberately failing runner-control fixture.

A small `fn`/tuple-destructuring helper reproduces the rejection with the existing
#236 compiler. Adding an explicitly typed intermediate binding makes it compile.
`mono.rs` now preserves that binding automatically for destructuring lets, so
inlining cannot erase the value’s known type before ownership lowering. Ownership
admission remains strict. A regression in `local_bindings` exercises a generic
sine derivative rule through raw interpretation and native modes. Runner checks
of this repair are pending.
