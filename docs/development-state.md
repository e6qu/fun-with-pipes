# Current work

**Next:** finish the G5 test/report migration below, rebase onto verified merged
[PR #216](https://github.com/e6qu/fun-with-pipes/pull/216), then run integrated
compiler and production validation. This deletion branch is incomplete and has
not been built. Do not publish it as working code or claim GC removal is verified.

Worktree: `/private/tmp/fwp-delete-tracing`; branch `delete-tracing-collector`.
Base: #216 source `0db38df8bd0b3ea6f4dc1165edd985bc82c71ccb`.
Local checkpoints: `d83f4745` (runtime deletion) and `bd299fe0` (release controls).
Further reviewed edits are in the working tree. Nothing here has been pushed.

Only #216 is a public PR. Its worktree is
`/private/tmp/fwp-ownership-fault-matrix`, branch `remove-tracing-runtime`.
The primary checkout's handoff tracks its live CI status. Keep the final tested
head unchanged while its gates run. The primary checkout remains detached at
#209; preserve its untracked compiler-abort report. Old #214/#215 publishers
must stay stopped. No merge watcher is running.

## Implemented here; integration still pending

| Area | Change |
|---|---|
| Collector | Replaced `runtime/fwp_rt_gc.c` with `fwp_rt_heap.c`; removed root discovery, mark/sweep, collector settings and collection retries. Retained allocator, finalizers, WASI count table and scheduler cancellation registry. |
| Code generation | Removed `NativeOptions.arc`, `--gc`, optional counted lowering, `Gen.reuse` and root fences. Counts and typed destruction are unconditional; `FWP_NO_REUSE` remains an independent copy control. |
| Allocation accounting | `fwp_heap.live/peak` are exact physical slot/requested-byte balances. Cumulative allocated/released bytes use floating point. `FWP_ALLOC_STATS` reports six explicit byte/RSS fields. |
| Runtime callbacks | Removed unowned task spawn/within paths. Missing owned callbacks trap; verify callers and rejection expectations against the new runtime. |
| Diagnostics | Migrated native/static allocator probes, live-byte consumers, strict report parsing, 27 report consumers and 41 allocator-hook signatures. Physical-free observers use the single release path. |
| Memory cases | Loop/HTTP/REST/gRPC retain their RSS limits. Server startup is bounded and stderr is drained without accumulating logs. One counted run replaces duplicate modes. |
| Release controls | Retired collection-age tests and poison-only variants. Kept corpus outputs, failures, independent allocation ledger and reuse comparisons. The tree test retains its >100 MiB release bound; omitted physical frees must fail. |
| Static storage | The three-million-step normal case remains. A separate copied-value case must fit a 1 MiB pool with counted release and exhaust it with status 102 when physical frees are omitted. |
| Wide counts | Retained exact counts, overflow/OOM, metadata-free faults and high-fanout outputs. Added live interior-address count-slot mapping and fresh counts on reused addresses. No freed payload is read. |
| Test selection | Reviewed and selected counted C branches in 61 files. Removed collector-status terms from combined assertions while preserving live-byte, metadata and resource checks. |
| Numeric/CLI cases | Migrated nine test files to one counted run, retaining optimization/layout choices and deliberate faults. Integer evidence gates now require six length binaries and ten product/sanitizer binaries per host; direct-output inspection requires 72 binaries across six hosts. |
| Docs | Updated ownership, native commands, tutorials and allocator/report explanations. Historical measurements retain their original source/schema; reproduction instructions distinguish their revision from current tools. |

The nine mode migrations are `array_loop_borrows`, `cli_ownership`,
`clock_ownership`, `terminal_ownership`, `float_formats`, `integer_output`,
`scalar_math`, `scalar_traps` and `static_constants`.

## Remaining migration, in order

1. **Finish test mode removal.** Remove variable `--gc` arguments, duplicate
   ARC/tracing loops, obsolete environment settings and CLI-selector tests.
   Keep every distinct semantic input, optimization/layout choice and ownership
   fault. Retain errors for unsupported current options; no compatibility aliases.
2. **Finish C fixtures.** Remove remaining collector fields/calls, root-fence
   anchors and escaped `FWP_ARC_ONLY` blocks. Preserve independent lifetime,
   alias, failure/cancellation and resource assertions. Windows context/root
   probes still reference removed stack-root fields; retain ABI/register/rounding
   and host-fiber ownership checks, retire root-discovery-only checks.
3. **Finish report schemas and consumers together.** Client/server/numerical
   reports still carry collection fields. Remove them rather than printing dummy
   zeros. Update strict parsers, TSV/JSON producers, artifact audits and docs.
   Do not rewrite historical measurement JSON.
4. **Finish workflow coverage.** Replace collector-stress variants with the
   complete counted corpus and fault controls. Keep all nine production jobs and
   the explicit native target assignment audit. Rename obsolete shard/report
   labels consistently; a filename alone is not grounds to delete tests.
5. **Rebase and verify.** Incorporate #216's final admission/cache repairs and
   bounded server helpers. Resolve its handoff/GC-test overlap against this file.
   Compile/lint all targets on runners; fix all failures together. Then run one
   complete final-head matrix, docs, primitive inventory and actual-binary
   collector-absence checks. Focused Clang probes do not establish GCC, Windows,
   WASI, generated-program or integrated Rust support.

Text inventory after the nine mode migrations: `--gc` occurs in 107 test files;
collector fields/calls in 69, `FWP_ARC_ONLY` in 17 and root fences in 49.
These are review locations, not failing-test counts: absence assertions may
legitimately name deleted collector symbols.

## Candidate edits and recovery

`/private/tmp/fwp-single-mode-candidates` contains 93 parsed/formatted candidates
covering 165 duplicate-mode loops. Only the nine files listed above were applied.
The others are **unreviewed**, may leave obsolete helper parameters/single-value
loops, and do not update artifact consumers. Do not copy them wholesale.
Regeneration would overwrite later candidate refinements; preserve reviewed edits.

Automatic approval review rejected an earlier broad rewrite because substantial
work was uncommitted. No part of that command ran. We saved `bd299fe0`, generated
separate candidates, reviewed every C-branch diff, and applied them with a clean
checkpoint/source check. That safer action was approved. No permission is pending.

Temporary helpers in `/private/tmp` are one-shot edits, not publishers:
`fwp-preview-counted-test-probes.py`, `fwp-apply-reviewed-test-probes.py`,
`fwp-preview-mode-removal.py`, `fwp-refine-mode-candidates.py`,
`fwp-check-mode-candidates.py`, `fwp-apply-reviewed-mode-tests.py`.
Earlier deletion/migration helpers must not be rerun blindly either.
`unifdef -t` handles raw C blocks in Rust; ordinary C parsing rejects Rust
lifetimes. Mixed conditions and escaped C strings need explicit review.

## Checks actually run

All local checks used `python3 scripts/local-guard.py`; no full build/suite ran.
Scripts below live in `/private/tmp` unless a repository path is given.

| Guarded command | Result and limit |
|---|---|
| `python3 fwp-check-counted-allocator.py` | Actual allocator slice, Clang 17 ARM64 O1/O2: zero/small/large first allocation, page reuse, wide metadata and unload pass; omitted free fails with 27. |
| `python3 fwp-check-static-allocator.py` | Same compiler/settings, explicit 1 MiB static pool: slot/page reuse passes; exhaustion exits 102. |
| `python3 fwp-check-allocation-report.py` | Strict parser accepts valid LF/CRLF and rejects missing/duplicate fields, invalid numbers and wrong units. |
| `python3 fwp-check-report-runtime.py` | O1/O2 actual allocator: 100,032 allocated; 32 released/100,000 live, then 100,032 released/zero live; peak 100,032 and extent 196,608. |
| `python3 fwp-check-memory-startup.py` | Migrated harness compiles at Rust O1 with warnings denied; three helper tests pass. Does not run generated memory servers. |
| `python3 fwp-check-deletion-edits.py` | Rust formatting, changed Python parsing, whitespace, 253-target native schedule and integer artifact gate checks pass. |
| `python3 scripts/check-roadmap.py` | Pass after this rewrite: 162 link sets, 106 immutable preparation pairs/tags, eight roadmap rows and commit messages. |

Local harness repairs: fixed a moved expected value in the parser check and an
unused shutdown helper in startup-only consumers. A slow edit helper was stopped,
then rewritten and run within the guard; never raise its limits. No helper remains
running. Integrated runtime tests and the new wide/static/tree controls are pending.

## Verified starting point and later goals

PR #215 merged as `4e7b74be8e11634fac9309e67cb4efccfb34d360`, with the same tree as
tested `bd77d65f58d8c5117ea678cb86cf15fbcf9231f7`. Nine production jobs
`40221722197` and docs `40221722121` passed. G3/G4 are delivered.
[History](roadmap-history.md) and [ownership diagnostics](ownership-diagnostics.md)
record that evidence and the collector-check deletion map.

After G5, continue A2–A6 for ARC minimization; deleting tracing does not eliminate
counts or heap allocations. The [Intel compiler abort](measurements/compiler-abort.md)
remains unexplained; investigate recurrence from source/input. Squash merge only
passing exact-head gates, with an explicit one-line subject of at most 80
characters and an empty body. Verify the message/tree and continue PLAN.md.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | In progress | G2/G5 final validation, then tracing deletion |
| 2 | In progress | A2–A6 residual-cost baseline, unique buffer and scoped workspace |
| 3 | In progress | F1–F3 function-call and recursion costs |
| 4 | In progress | P1–P3 measured CPU budgets |
| 5 | In progress | D1–D3 derivative correctness and time/storage budgets |
| 6 | In progress | N1–N2 numerical accuracy and kernel budgets |
| 7 | In progress | B1–B2 reproducible comparisons and enforced budgets |
| 8 | In progress | V1–V2 application correctness, cleanup and scaling matrix |
