# Preparation handoff: repair variable map construction time

## Next action

Next: publish and run the additional storage-phase diagnostics. Performance run
`39104667835` passes both jobs and all 76 binary/sample checks, but does not prove
the repair: its AMD64 host is Intel Xeon 8573C, while the original slow sorting
was on AMD EPYC 9V74. Both old/new layouts are fast on this Xeon. Full-work
tracing is 4.6% slower with joined storage, despite faster construction-only
medians. Resolve both questions before integration. Compiler/runtime remain
identical to `725e2198d721e835be282e2032d99ac5f10b4605`; six-host correctness run
`39104669727` is still in progress. Once all six hosts pass, collect their report with the new
collector and explicit measured source/run inputs. No second PR. The authoritative live
handoff is `/Users/zardoz/projects/fun-with-pipes/docs/development-state.md`.
PR #166 remains at `7f782388270b5d73a60eaf3c253a6f9a6e680e95` while production runs.
Do not merge it before fixing the observed AMD64 performance issue.

## What the measurements established

Source `9f0632f9c1abf4f067fa659f1d95c5768cb8a965`, run `39102838322`, passes both
Linux hosts; 36 actual binaries, raw samples, counters and hashes are audited.
It is preserved as `evidence/large-map-baseline-20261018`. Its raw reports are
`docs/measurements/large-map-construction-2026-10-18.json` (committed with the repair).
The maintained program builds 500,000 entries and performs two million lookups.
Optimization cuts full-work requests from 1,500,009 to eight and peak counted
bytes from 56,000,040 to 24,000,040, but still performs 2,000,001 retains.

ARM64 improves. AMD64 optimized construction alternates between fast and much
slower processes, including checked ARC. These samples cannot be dismissed as
ordinary noise or cleared by allocation savings. Preserve the original failures.

Follow-up source `f01f50bfc346a7e848a95b12dcbe380fd3c6c462`, run `39103286520`,
passes both hosts. Data-only artifacts and full audit are in
`/private/tmp/fwp-map-followup`; original data is `/private/tmp/fwp-large-map-baseline`.
Separate phase probes identify sorting as the variable cost: roughly 19–35 ms
versus 100–109 ms in all 32 optimized AMD64 samples. Their slow/fast grouping
correlates exactly with virtual address bit 22. Record:
`/private/tmp/fwp-map-layout-correlation.json`. This does not prove a particular
cache or TLB mechanism. Allocation and cleanup remain fast; occasional slow
sorting also occurs with ordinary construction. All 116 original AMD64 sort
instructions match after normalizing addresses. Do not add arbitrary padding.

Rejected lookup experiments: lower-bound integer search is 8–9% slower on ARM64;
separating cached-value producers shows no clear ARM64 benefit and increases code
size. AMD64 samples remain confounded by the construction issue. Neither proposal
changes compiler/runtime source. Preserve their evidence at the measured source,
and remove their unused scripts from the eventual delivery.

## Current repair

Published compiler/runtime changes join related key/value lanes into one owned
allocation, both for generated numeric builders and ordinary typed maps. Sort
scratch uses the same layout. No unused sentinel word or allocator-sized gap;
sets keep one lane. The final exact-size container and stable duplicate handling
remain unchanged. Empty ordinary maps avoid unnecessary scratch allocations.
Explicit size guards check the complete storage multiplication before allocation.
Cleanup releases each allocation once, including errors and cancellation.

`scripts/measure-map-storage.py` reconstructs the original separate-buffer layout
from an explicit measurement fixture, preserving callbacks and sorting. Twenty-four
fresh processes per variant rotate order on the same runner; full and
construction-only work, both memory modes, counters, actual binaries and hashes
are retained. The control is never part of production runtime code. Ordinary
C/Rust comparison and separate phase probes also rerun. No speed claim yet.

## Validation and publication

Use the root `scripts/local-guard.py` with unchanged fixed limits. All builds,
full suites, full benchmarks and large reports remain on GitHub.

- Formatting, focused Clippy and three collection tests pass (74.75 s guarded).
- Eight collection/map ownership tests pass after adding two size-overflow guards
  (65.01 s). Eight actual builders cover 48 allocation failures and 64 callback
  exits per configuration; 22 managed-map operations cover 104/106 injected
  failures. Raw interpreter, native O1/O2, ARC, stressed tracing, reuse poisoning,
  aliases and deliberately missing cleanup are covered. No failures or skips.
- Tiny comparison preflight passes (10.63 s guarded), using root guard and
  `/private/tmp/fwp-map-storage-preflight.py`: eight entries, sixteen lookups,
  independent interpreter output, two layouts, both modes, zero final charge,
  requests 8 → 6, unchanged 17 retains, phase-probe syntax and workflow/docs.
  Peak counted storage is 464 → 400 bytes; both modes finish at zero charge.
- Shared root `target/debug/fwp` now contains the joined-buffer
  compiler at source `725e2198`. It is no longer the published PR #166 compiler. Root CI auditing
  remains data-only; run candidate checks from this preparation worktree.
- New storage-phase diagnostics pass eight tiny compiled/interpreter comparisons
  (8.92 s guarded), covering both layouts and both memory modes. The first probe
  incorrectly assumed construction happened inside queries and failed locally;
  it now measures the actual earlier construction and subsequent loop separately,
  verifies one construction before queries and none during them, and preserves
  evaluation order. Sub-microsecond tiny loops may measure zero on macOS; full
  runner measurements require positive durations. No full benchmark ran locally.
- The report description now explains that input keys are scrambled, not already
  sorted. Historical raw reports retain their text with an explicit correction;
  samples, source IDs and binary hashes are unchanged.

The old phase/lookup source is preserved as `evidence/large-map-phases-20261018`;
its unused candidate scripts are removed. The report collector previously expected 56 allocation failures and four leaked
scratch objects. It now requires 48 failure points and two owned scratch
allocations, retaining exact checks. Report/script/workflow/docs preflight and
three incomplete-log regressions pass (3.39 s guarded), using
`/private/tmp/fwp-joined-report-preflight.py`.
This report-only fix does not invalidate the running source tests. Audit every
failed production job before one coherent PR repair push. Final acceptance needs
all nine production jobs, documentation and relevant focused evidence for the
actual PR commit. Commit/squash messages: one line, at most 80 characters, no
body, trailers or attribution. Standing authorization covers publication and
squash merge after acceptance.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership and tracing removal |
| 2 | In progress | Functional intermediates, copies and unnecessary counts |
| 3 | In progress | Controlled C/Rust gaps and actual machine code |
| 4 | In progress | Differentiation precision, speed and memory |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, equivalent-work comparisons |
| 7 | In progress | Representative applications and browser execution |

All seven [plan](../PLAN.md) areas remain open; JIT is excluded, not deferred.
