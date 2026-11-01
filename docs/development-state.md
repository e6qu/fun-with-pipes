# Current work

**Next:** publish the complete implementation and run the combined focused GCC/Clang
suite from [the protocol](measurements/derivative-recording-moves.md). Audit all
results before the full final-head matrix. No native results exist for this batch yet.

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
Native checks are pending. Use
`python3 scripts/local-guard.py` for focused local work, serially. Full builds,
suites and measurements stay on runners. Disk has about 64.3 GiB free, close to
the fixed 64 GiB floor; move refused work to CI instead of bypassing the guard.
