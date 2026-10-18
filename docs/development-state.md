# Session handoff

## Next action

Next: publish the combined PR #165 repair and its current benchmark evidence,
then require all nine final-head production jobs and documentation before merge.
All known failures are repaired and focused native checks pass. CI has no
cancel-on-push concurrency rule: keep the original production run running and
continue its complete audit alongside the final-head gates. Waiting for still-running
original jobs is not required to publish these already-audited fixes. The PR still points to
`7c2b5638881cea6b476997b333aa61006dba1381`; production `39092728270` has its
benchmark and regular ARM macOS gates passing, with seven jobs running.
The macOS job completed all 119 scheduled targets (451 tests, no failures/skips). Documentation `39092728362`
passes. Use `/private/tmp/fwp-audit-165.py` to retain every completed job/target
and failure. Already-published step logs are also audited in
`/private/tmp/fwp165-production-step-audit.json`: each Windows native phase has
111 passes and the same three map failures now fixed in the six-host diagnostic;
both macOS sampled-GC steps pass. These partial logs do not replace full-job
acceptance. Queued or running CI does not prevent independent repair work.

The original map run `39092741368` is fully audited: four hosts pass; both
Windows hosts have the same six failures (four C stdout newline mismatches and
two extensionless executable reads). Commit `af834f8c67c6c5b7d543615755feeb0a85e81c87`
fixes these. Its diagnostic ref `map-portability-repair` and run `39093309107`
pass all six hosts: 24 summaries, 66 tests, zero failures/skips. Data-only
inspection verifies all 48 actual executables, failure controls and callback
outputs. [The report](measurements/map-failures-2026-10-18.json) preserves that
exact source; do not relabel the original failing runs.

Sibling artifact repairs are committed as `99410a018a9e8c39f9d8d1b63abd53be3c672595`,
on diagnostic ref `artifact-path-repair`. Run `39093555361` is fully audited:
22 passed, eight failed, no skips across both Windows hosts. All eight traces
were read. Each host has three missing-OpenSSL failures and one list cancellation
failure (AMD64 wrong cleanup count; ARM64 access violation). Array/device checks
and the new GC failure-binary retention regression pass on both native hosts.
The original audits/logs are `/private/tmp/fwp165-artifact-paths-*`; refresh via
`/private/tmp/fwp-audit-artifact165.py`.

The current repair sets the Windows stack boundary on the affected hand-built task
fixtures: without it, collection skips main's active stack and can reclaim live
list inputs. The sibling audit covers State, derivative, matrix and worker
cancellation probes too. The focused Windows workflow now configures OpenSSL;
production runs list/State/codec checks after its existing TLS setup. A duplicate
derivative-scope invocation was removed while preserving its existing later
coverage. Additional derivative and kernel executable artifact paths are explicit.
The compiler now gives Windows OpenSSL setup advice rather than Linux package
instructions. Commit `463c00bfddf8824b88dc953acd2f192c3acb4dcd` is published on
`cancellation-probe-repair`; run `39094282067` passes both Windows hosts:
52 tests, 22 summaries, zero failures/skips. All expanded ownership, array/device
bounds and failure-artifact checks pass. Audit it with `/private/tmp/fwp-audit-cancellation165.py`, preserving separate
`fwp165-artifact-repair-*` logs and JSON. Its native result establishes this repair; it does not replace full production
acceptance.

Require all nine exact-head production jobs, documentation and complete focused
map/artifact evidence before authorized squash merge. Use one subject of at most
80 characters, empty body and no trailers; verify the entire message, sole parent
and identical tested/merged tree. Fix every encountered issue, including unrelated
ones; do not defer failures or treat skipped checks as support.

PR #164 is accepted. Its nine production jobs (`39087594221`) and documentation
(`39087594154`) pass for head `a845e0c5e9a37dad185c99566ddc6ce413b4293b`:
1,248 summaries, 3,588 passed, zero failed, 72 ignored. All 964 scheduled targets
completed. Ignored tests do not establish support. The entire single-line message,
sole parent and identical tested/merged tree were verified. Duplicate production
`39092256990` was cancelled. [History](roadmap-history.md#server-entries-exact-json-and-webassembly-task-owners-pr-164)
records accepted behavior, source IDs, measurements and repaired failures.
Merge record: `/private/tmp/fwp164-merge-record.json`; final target audit:
`/private/tmp/fwp164-combined-audit.json` (all nine logs retained separately).

## Current batch: C result owners and failed map cleanup

The root workspace holds branch `library-result-owners` at local repair
`463c00bf`, three commits ahead of PR #165. The grouped fixture/workflow
repair passes on both Windows hosts on a separate diagnostic ref. It is based on accepted #164. The old preparation worktree
`/private/tmp/fwp-library-result-owners` is detached at PR head `7c2b5638` and
inactive. Its only root handoff edit was backed up before checkout to
`/private/tmp/fwp165-root-handoff-before-checkout.md`. Rebase tree identity and
all four one-line commit messages were verified before publication. The PR body
is `/private/tmp/fwp-library-results-pr.md` and uses ordinary language.
Original measured library source `d6d36961f532167beec8a116b35462906ba1cc6f`
remains tagged `evidence/library-results-20261018`; do not relabel that evidence.

The shared root `target/debug/fwp` includes the Windows diagnostic-text change,
rebuilt by the focused kernel check. Rebuild before testing another compiler revision. Every focused local check uses
`python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py COMMAND...`.
Keep its fixed resource limits; full gates/builds/regeneration stay on CI.

### C callers own returned strings

C callers receive owned strings and record string fields, releasing each complete,
unchanged result once with `fwp_release_NAME(result)` before unload. Unique owners
move; shared fields acquire only the owners C needs. Direct record worker results
avoid boxing/unpacking when arguments use the ordinary word convention. Raw
pointers remain outside checked ARC. Input strings still copy, including read-only
calls; borrowing nonescaping inputs remains work. Headers, C/Rust examples,
tutorial and reference explain the contract.

All six focused jobs in `39090619574` pass: 36 summaries, 90 passed, no failures
or skips. The audit is `/private/tmp/fwp-library-results-repaired-audit.json`;
refresh with `/private/tmp/fwp-audit-library-results-repaired.py`. Checks cover
static/shared results, aliases, partial conversion/retain failure, rejected
unproved lifetimes, unload, C/Rust callers and TCP/UDP library unload.

The [report](measurements/library-results-2026-10-18.json) verifies 24 actual ARC
libraries, 48 execution configurations, 96 zero-byte/zero-collection shutdown
observations and 24 deliberately failing controls. Internal runtime names exist;
tracing scan/mark/sweep functions are absent. Identity adds zero retains; two
fields sharing a string require one. Both measured result forms allocate zero
record boxes. Fresh count initialization, release work and input copies remain
costs. This is not a timing comparison with C/Rust.

Initial run `39088723884` at `9cbba70e` exposed the same two failures on both
Windows hosts (80 passed, four failed). Diagnostic `39089692041` at `e1e8e84b`
passed 13 tests and retained the last failure. Both are fixed on native hosts:

- Rust callers use `*-pc-windows-gnullvm` and the matching LLVM-MinGW linker;
  the fwp compiler keeps its MSVC target.
- `norm` existed inside the DLL but was not exported, so C imported Windows'
  different function and returned 25 instead of 5. Entries and result releases
  now use explicit Windows exports. Repaired hosts import `norm` from
  `libgeom.dll` and return 5. Unload hooks are explicitly exported too; full
  production will additionally exercise the TLS resource hook.

Artifacts: `/private/tmp/fwp-library-result-evidence/39090619574`; baseline uses
`39088723884` under the same parent. Diagnostic import/export data is under
`/private/tmp/fwp-library-windows-diagnostic/39089692041`. Original audits remain
separate (`fwp-library-results-audit.json`, `fwp-library-windows-diagnostic-audit.json`).
Collector: `scripts/summarize-library-results.py --artifacts DIR --audit AUDIT
--llvm-bin DIR --record-results direct --output FILE`. LLVM tools locally are in
`/Library/Developer/CommandLineTools/usr/bin`. Never execute downloaded artifacts.

### Maps and sets release partial results

A tiny checked-ARC reproducer caught 32 failed `map.map-values` calls and leaked
2,048 bytes (64 per call). The repaired probe has zero bytes after warmup and
all failures. Baseline C/output are preserved under
`/private/tmp/fwp-map-failure-probe/`; driver `/private/tmp/fwp-map-failure-probe.py`.
This was discovered while inspecting the slow `collections_build.fwp` stress
case. Its 100,000-item native workload was emitted only, never executed locally.

`runtime/fwp_rt_prims.c` now protects partial map/set results, scratch, list
conversions, pending fields and consumed insert/remove/update inputs with existing
stack cleanup records. Acquired keys enter the tracked prefix before a later
value acquisition can fail. `src/cgen.rs` uses the output value type for
`map.map-values` cleanup. `runtime/fwp_rt_decode.c` clears its owner before calling
consuming insertion, avoiding two cleanup owners for the same map.

New tests extend existing `map_set_ownership`, with fixtures `map_failures.fwp`
and `map_failure_probe.c`. They deliberately fail every allocation and retain
across 22 operations, preserve independent aliases and heap-address-like scalar
bits, compare changing-type callbacks with the interpreter, and require zero
counted bytes at ARC shutdown. Missing map-result and scratch owners are separate
failing controls. Windows production now explicitly includes this target; the
six-host `map-storage` suite also checks list-map unwind and typed decoder paths.
`FWP_MAP_FAILURE_ARTIFACTS` retains actual C, binaries, outputs and controls.

The failure probe passes 108 injected failures per ordinary configuration and
110 under reuse verification, at O1/O2 in ARC and stressed/verified tracing.
Both missing-cleanup controls fail with the expected live-allocation diagnostic.
All six native focused jobs pass on repair `af834f8c`; final production acceptance
remains pending. Collector `scripts/summarize-map-failures.py` verifies source IDs,
all six jobs, actual binary formats/internal symbols, tracing presence/absence,
callback interpreter agreement and deliberate failing controls. Artifacts are
`/private/tmp/fwp-map-storage-evidence/39093309107`; audit is
`/private/tmp/fwp165-maps-repair-audit.json` (refresh with
`/private/tmp/fwp-audit-map165-repair.py`). No downloaded code is executed.

## Latest local verification

All checks below used the root guard, serially:

- Windows map repair: all nine tests in the three affected targets pass locally
  (54.95 s); formatting/Clippy/docs pass (9.70 s).
- Sibling artifact path checks: GC executable-retention regression passes
  (3.05 s); formatting/Clippy/workflow checks pass (4.23 s).
- Hand-built task repair: Cartesian cancellation probe passes (8.02 s).
  Six other changed probes pass serially (31.01 s), using
  `env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3
  /private/tmp/fwp-cancellation-checks.py`. The first attempt failed because the
  installed headers were not configured; that failure was fixed, not skipped.
- Cancellation formatting/Clippy/workflow checks pass (3.77 s), then pass after
  TLS ordering and Windows diagnostic repairs (8.56 s).
- Documentation validation passes (2.65 s): 52 link sets, 106 immutable
  preparation pairs, seven roadmap steps and commit messages.
- Kernel executable-path sanitizer/omission check passes (18.50 s including
  compiler rebuild).
- Six-host map artifact download passes (13.99 s). Repository report collector
  passes (1.37 s), reading 48 executables without executing them.

- Tiny map callback reproducer: baseline fails (1.66 s), repair passes (1.40 s).
  Compiler rebuild passes (15.52 s); interpreter fixture passes (0.86 s).
- `cargo test --test map_set_ownership map_ -- --nocapture`: four tests pass;
  the new scalar injection exposed a test-only source-replacement error. It
  replaced a one-line scalar wrapper and the following function together.
  The replacement now checks that exact one-line boundary. Focused rerun passes
  (5.79 s): 108/110 injected failures, scalar bits and both cleanup controls.
- Callback interpreter/native agreement and zero-byte ARC shutdown pass at O1/O2
  in the preceding combined run. Artifact-retention callback rerun passes (5.02 s). Focused Clippy
  for compiler/map/decoder targets passes (5.84 s). Do not label the earlier
  failed combined run as passing.
- The final failure probe also passes when launched with inherited GC stress,
  verification and reuse enabled (5.91 s). Each ARC execution explicitly selects
  compatible settings; tracing executions still stress/verify collection.
- Rust/workflow/docs preflight passes; the fixture formatter initially rejected
  the new source, which was formatted and then passes (5.92 s combined check).
- Final serial formatting, Clippy, workflow lint, documentation and fixture
  checks pass together (7.67 s).
- Earlier C library checks: ARC/FFI/unload ten passed (53.74 s); artifact-retention
  C/Rust checks passed (3.69 s). Focused Clippy passed (5.83 s); formatting,
  workflow lint and docs passed (6.14 s). These precede the map changes.
- Six-host library evidence collection passes (1.32 s), Windows import/export
  inspection passes (0.26 s), and serial downloads pass (2.90/11.27/3.50 s).

The initial failure probe also missed the initialized-object allocator's fast
path, producing inconsistent injection counts. It now instruments both allocator
entry points exactly once. No runtime failure was hidden by that test correction.
A prior free-disk guard refusal was resolved by deleting only a redundant,
verified remote-backed artifact download; no guard limit was changed.

## Current C/Rust timing baseline

The passing production benchmark at `7c2b5638` now replaces the obsolete
shortest-of-three example in [benchmarks](benchmarks.md#recorded-example-and-overhead).
[Saved data](measurements/complete-programs-2026-10-18.json) contains all 90 elapsed
samples, 15 compilation times and 15 binary sizes, with CPU/compiler/flags and
scope. All three maps use sorted pairs. fwp takes 10.7% longer than C and 35.8%
longer than Rust in this whole-program run; sorting and construction differ.
No allocation or peak-memory counters were collected, and pipeline samples are
noisy. This selects investigation, not a cross-revision regression or speedup claim.
Original report: `/private/tmp/fwp165-benchmarks/bench.md`; validation driver:
`/private/tmp/fwp-record-current-bench.py` (0.15 s guarded, no benchmark rerun).

## Independent next preparation

`/private/tmp/fwp-collection-build-storage`, branch `collection-build-storage`,
starts at PR #165 head `7c2b5638`. It has no compiler changes or second PR.
Inspect range-to-map/set allocation costs while #165 gates run. The tiny local
baseline compares 8 and 32 elements only: sets make 23/71 managed allocation
requests, maps 32/104, with zero retains, zero final bytes and zero collections.
That is two additional allocations per set input and three per map input over
this small range. Results agree with raw interpretation; the probe passes in
7.41 s guarded. No timing or C/Rust parity claim follows from these counts.

Reproducer `/private/tmp/fwp-collection-baseline.py`; source, instrumented C,
local binaries and JSON are in `/private/tmp/fwp-collection-baseline/`.
It uses the existing `scripts/measure-iteration.py` allocation instrumenter,
which counts both allocator entry points without double-counting the initialized
allocator's slow path. Emitted 100,000-item code still constructs range/mapped
lists; do not execute that stress workload locally. Existing `bench/map` already
provides C/Rust sorted-pair comparisons. Establish native before/after timing,
allocation and machine-code evidence before claiming an optimization. Preserve
first-key/last-value duplicate semantics, floating ordering and callback traps.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Finish host/result owners, partial cleanup and tracing removal |
| 2 | In progress | Remove functional intermediates, input copies and unnecessary counts |
| 3 | In progress | C/Rust gaps, register/cache use and code costs |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Dependable repeated performance comparisons |
| 7 | In progress | Larger representative applications |

All seven [plan](../PLAN.md) areas remain open. Actual browser engines, retained
foreign callbacks and other unproved boundaries still need ownership work.
JIT is excluded, not deferred. Historical preparation anchors are evidence, not
new tasks. Fix every encountered issue; audit every failed job and completed
target before repair pushes. Preserve healthy final heads while their gates run.
