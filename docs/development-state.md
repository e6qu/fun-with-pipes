# Preparation handoff: collection construction

## Next action

Next: audit the direct-set six-host run and its binary/timing report while PR #165
finishes acceptance. Do not open a
second PR. The authoritative live delivery handoff is
`/Users/zardoz/projects/fun-with-pipes/docs/development-state.md`; replace this
preparation-only file with that handoff before the delivery PR.

## Sources and evidence

This preparation is based on PR #165 head `836f39b30079ec52f56b41d81baf468e8384a71b`.
Rebase onto its accepted identical tree after merge. Preserve measured source IDs.

- Original numeric map/set source `cf2fb20c1cf3326187b998789bc31990cfcbcf65`, run
  `39096618831`: 62 passed, 16 failed, no ignored tests. Every failure was audited.
  Three AMD64 fixtures assumed an arithmetic NaN sign that is unspecified.
  Windows ARM64's forbidden toolchain download let all 13 tests continue with
  the wrong compiler. Both causes are fixed, including sibling workflow checks.
- Repair `488d182203605870ab34d5f431c62f5d58a2a7b1`, run `39098119495`:
  all six hosts, 78 passed, no failures/skips; all measurements complete.
  Preserved as `evidence/collection-build-20261018`.
- Report-tool commit `5446d4f1` adds complete-target and log-interleaving checks.
  Report run `39098876424` inspects the source-488d1822 baseline: 120 actual
  binaries, raw counters and repeated timings. It does not execute downloaded
  binaries or claim C/Rust parity. The run passes; saved baseline data and a
  Linux register/stack review are linked from [benchmarks](benchmarks.md#building-numeric-maps-and-sets-without-temporary-lists).

Refresh from the root with its local guard and
`/private/tmp/fwp-refresh-current-audits.py`. The source-488d1822 audit is
`/private/tmp/fwp166-collection-repair-audit.json`; original failures use the
separate `fwp166-collection-build-*` files. Never relabel earlier measurements.

## Current set construction follow-up

The passing baseline still used four temporary word arrays for sets although
sets contain only keys. Current compiler/runtime changes remove both unused
value arrays, including ordinary managed-key set construction. The stable sorter
shares key/value lanes and avoids copying identical output twice. Final set
value slots remain explicit unit values. Maps retain separate value buffers.
A native regression checks that equal, separately allocated strings keep the
first key's identity and correct reference counts.

Published set-buffer source `8fcd7486881c627f078d8bff7ad6e6c82f040734`
passes six-host run `39100058501` (78 tests, no failures/skips, all measurements).
Report `39100710058` passes and verifies 120 actual binaries. The unchanged
runner report is saved in `docs/measurements/collection-set-storage-2026-10-18.json`.
At 65,536 inputs, all hosts use four set allocation requests and peak at
1,053,712 counted bytes, versus six requests and 2,102,304 before this change. Keep it separate from the new direct-call
change: actual baseline AMD64 set machine code calls general function dispatch
per item and reloads values from the stack. Published follow-up `c34ca8e340c6f3dbb6251729553e1a8dbf513903`, run `39100652902`,
checks the new direct calls separately. Known set callbacks now use the
existing owned entry, including primitive argument cleanup. Dynamic callbacks
retain their ordinary dispatch. Tests add dynamic sets and managed captures,
including caught errors, and exercise eight actual emitted builder bodies.

All local checks use the root `scripts/local-guard.py`, serially, with fixed
limits. Full builds, suites, measurements and large evidence processing stay on CI.

- Three collection tests, formatting and Clippy pass (55.20 s): raw/native
  behavior, errors, aliases, 50 allocation failures and 48 callback exits per
  configuration, ARC/stressed tracing/reuse and deliberate missing cleanup.
- Five managed map/set tests pass (27.96 s), including first-key identity and
  106/108 failure injections across 22 operations. Fewer failure points follow
  removed allocations; every remaining allocation is still injected.
- Tiny 8/32-input probe passes (7.53 s): set requests fall from six to four,
  peak charged bytes to 288/768; maps remain seven requests and 448/1,408 bytes.
  All cases have zero retains, final counted bytes and collections. Data and
  source hashes: `/private/tmp/fwp-collection-set-prototype/`. These counts precede
  the final identical-copy guard and do not establish a timing improvement.
- Formatting, focused Clippy, workflow/docs checks and report regressions pass
  (7.38 s). The final eight-test rerun after the copy guard passes (76.84 s guarded).
  Final tiny counts are unchanged and saved separately in
  `/private/tmp/fwp-collection-set-final/`; final tiny/tooling checks pass
  (18.88 s guarded).

The shared root `target/debug/fwp` contains this preparation, including the
set-buffer follow-up. Rebuild the intended source before root PR #165 checks.
The original/intermediate tiny probes remain separately under
`/private/tmp/fwp-collection-{baseline,prototype,range-prototype,worker-prototype}`.
Do not overwrite their source identity with current compiler output.

## Delivery requirements

The direct-set follow-up passes formatting, Clippy and all three collection
tests (56.97 s guarded): 56 allocation failures and 64 callback exits per
configuration, raw/native agreement, managed captures, aliases and deliberately
missing cleanup. Tiny counts remain four set/seven map requests with zero retains,
final bytes and collections; data stays separate in
`/private/tmp/fwp-collection-direct-set-prototype/`. Tiny probes, focused linting,
workflow/docs checks and report regressions pass (12.80 s guarded). The collector now expects these eight-builder results and four
set allocation requests. Earlier six-builder reports keep their source identity. The evidence checker now
requires the direct-call marker for sets as well as maps; saved tiny generated C
files satisfy both checks. Documentation/report checks pass (2.67 s guarded).
The ownership overview no longer calls accepted PR #164 Wasm work pending. Run all six hosts, inspect actual binaries and timing changes, then update the draft PR
body `/private/tmp/fwp-collection-build-pr.md`. The earlier report remains tied to
its earlier source. Production acceptance still requires nine exact-head jobs
plus documentation. One-line commit messages, at most 80 characters, with no
body, trailers or attribution. Fix every encountered issue without hiding or
deferring it. Standalone binaries remain one per operating system/architecture.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Host/result owners, partial cleanup and tracing removal |
| 2 | In progress | Functional intermediates, copies and unnecessary counts |
| 3 | In progress | C/Rust gaps, registers/cache and code costs |
| 4 | In progress | Differentiation precision, speed and memory |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, equivalent-work comparisons |
| 7 | In progress | Larger representative programs |

All seven [plan](../PLAN.md) areas remain open. JIT is excluded, not deferred.
This preparation does not finish ownership or performance work.
