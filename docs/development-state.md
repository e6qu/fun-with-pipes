# Session handoff

## Next action

Next: publish and audit the complete C-library and map-cleanup batch from
`/private/tmp/fwp-library-result-owners`, based on accepted PR #164
(`25f95f9c6cb157b7f4e2d74760f6f1e27be83f47`).
Run `numerics.yml` suite `map-storage` on all six hosts. Audit every job/target,
inspect saved binaries as data, and fix every failure before acceptance. Require
all nine production jobs and documentation for the final commit before squash
merge; the new map changes are not covered by earlier library evidence.

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

Worktree `/private/tmp/fwp-library-result-owners`, branch `library-result-owners`,
is based on accepted PR #164 squash `25f95f9c`.
Published library source
`d6d36961f532167beec8a116b35462906ba1cc6f` is retained by
`evidence/library-results-20261018`. The complete map changes and reports/docs are ready for publication. Draft body: `/private/tmp/fwp-library-results-pr.md`.
Only follow-up commits were replayed; the old delivery remains in accepted main.

The shared root `target/debug/fwp` is built from this preparation. Rebuild before
using it as evidence for another revision. Every focused local check uses
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
Native six-host evidence and final production acceptance remain pending.

## Latest local verification

All checks below used the root guard, serially:

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
