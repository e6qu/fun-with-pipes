# Current work

**Next:** run the prepared mapped-resize/two-arena-retry controls, retain the passing
fwp heap/region results, then integrate this complete comparison batch into #273
for final production gates. Service timing and actual C/Rust allocation traces
pass and their complete results are retained. Follow the
[frozen service timing protocol](measurements/weak-callback-time.md). Keep this
batch in [PR #273](https://github.com/e6qu/fun-with-pipes/pull/273). Milestone 4 is
incomplete; do not merge an interim green head.

Worktree: `.worktrees/recording-capacity-gate`. Preparation branch:
`ownership-buffer-review`; native allocator repair `62775d559`, tag
`roadmap/parser-native-allocator-repair-2026-11-09`. The next prepared suite is
`parser-heap-events` with an explicit immutable `parser_memory_tag`. PR branch:
`ownership-peer-comparisons`, still `b06a2b6fe20f2842f5b9c9a3bb4e00be0278f011`.
Integrate the complete preparation batch into this PR before final production
verification. Preserve unrelated root-worktree changes and inactive handoffs.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 documentation refresh and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | In progress | Buffer/closure comparisons; weak phases, storage, reuse, census and timing; service correctness, cleanup, allocations and paired timing; parser entry repair and process accounting | fwp parser heap/region events; remaining allocator path coverage |
| 5 | Pending | Existing language tools and correctness tests | Three applications, compiler phase/scaling costs and sustained load |

Retain original noisy/unmet timing results. Fewer operations or smaller images do
not complete runtime acceptance. Do not rerun unchanged samples to qualify them.

## Current verified results and failures

- **fwp heap/region events:** source `823791751`, tag
  `roadmap/parser-heap-events-2026-11-09`, run `42682917578`, AMD64 `129381983810`
  and ARM64 `129381984032`, passes. Ten builds, eight actual O1/O2 traces, eight
  wrong expected results and 24 missing-release/broken-observer controls pass per
  host. Artifacts `13702983607` / `13704330690`; docs `42682924250` /
  `129381997520` passes. Complete native logs have no warnings/errors; local raw
  reconstruction and compact retention are next. Mapped/retry native controls
  are prepared separately; their six reader tests pass locally.
- **Service timing repair:** source `069e76ed8`, run `42675215554`, AMD64
  `129354672051`, ARM64 `129354672223`. Both pass all 28 builds, 178 result/fault
  checks, 64 invalid arguments and two interpreter modes. Both paired timing
  sessions, raw-evidence audits and six corruption controls per host now pass.
  Artifacts: AMD64 `13700674134`, ARM64 `13700694287`.
  Docs `42675219991` / `129354681805` passes. Full delivery at 4,096 messages
  takes 18.65–20.23× C and 5.12–6.70× Swift across hosts. All comparisons qualify
  in both sessions. Reports, ratios, RSS/build costs, controls and logs are retained.
  No samples rerun.
  [First failures and combined descriptor/link repair](measurements/weak-callback-time-2026-11-09/README.md)
  retain all native logs and journals; no measurement ran before those repairs.
- **Parser allocation observer:** source `19b8b48fe`, run `42679061783`; AMD64
  `129368372898`, ARM64 `129368372298`. Both pass five builds and eight ordinary
  results; all 12 diagnostic executions fail. Repair all three observer causes:
  tail-call return tracking, C expressions in Rust frames and late auto-load
  settings. [Complete retained failures](measurements/parser-native-allocator-2026-11-09/README.md).
  Docs `42679066951` / `129368381461` passes. Repair `62775d559`, run
  `42680540810`, passes AMD64 `129373593731` and ARM64 `129373593563`: eight
  actual traces and four omitted frees each. All compact records reconstruct;
  largest requested peak is 425,984 bytes, 30% above endpoint capacity.
  [Tables and complete retained records](measurements/parser-native-allocator-2026-11-09/README.md).
  Repair docs `42680547196` / `129373594319` passes.
- **Parser accounting:** source `6d1608c4f`, run `42673573956`; docs `42673580483`.
  Attempts 1 and 2 failed before jobs with GitHub internal errors. Attempt 2 IDs:
  `b32b4d94-27e5-4122-8539-4301d00c7a35` / `7f804619-adc9-4c50-b9fa-12ed4c5199e6`.
  Attempt 3 passes: ARM64 `129352636403`, AMD64 `129352636561`, docs `129352646215`.
  Each host passes all six parser tests, primitive inventory, memory observations
  and seven corruption controls. All 195 raw snapshots per host reconstruct;
  complete text records are retained compactly. The generated 1 GiB worker stack
  matches the large accountable mapping; it is not 1 GiB of resident RAM.
  [Measured scopes and exact tables](measurements/parser-process-accounting-2026-11-09/README.md).
- **Service native profiles:** source `c0ac432fc`, run `42664664795`, AMD64
  `129325013027`, ARM64 `129325013096`: 16 diagnostic builds and 80 profiles per
  host pass. Docs `42664675441` / `129325039434` passes. Ordinary C/Rust/Swift
  service storage is released; actual omitted payload/weak releases retain exactly
  the expected bytes. [Results and limits](measurements/weak-callback-profiles-2026-11-09/README.md).
- **Service archive audit:** repair `f3f023820`, run `42669442687` /
  `129341760168`, passes: both archives reconstruct, all 954 command records and
  164 heaptrack status blocks are checked. Docs `42669449481` / `129341771404`
  passes. The audit now parses normal profiler stderr and rejects extra warnings;
  it does not suppress diagnostics. Compact complete journals/stacks and the
  original failed audit remain retained. No native profile was rerun.
- **Allocator calibration:** source `3c214f136`, run `42666642464`, AMD64
  `129331964348`, ARM64 `129331964527`: four real resize controls pass with empty
  debugger stderr. Source-path/timestamp issues are repaired, not suppressed.
  [Original warnings, failed repair and final evidence](measurements/parser-allocator-calibration-2026-11-09/README.md).
- **Mapping accounting:** same source, run `42666647306`, AMD64 `129331981618`,
  ARM64 `129331981260`: O1/O2 ordinary/no-reservation mappings and eight actual
  omitted-touch/unmap controls pass per host. Both retain mode-0 host policy.
  Accountable extents and resident pages are distinct; system-wide commit counters
  are not a process guarantee. [All raw snapshots and controls](measurements/parser-mapping-accounting-2026-11-09/README.md).
- **Docs for `3c214f136`:** run `42666658591` / `129332015531` passes. Complete
  allocator/accounting logs contain no warnings/errors. Native service logs have
  the optional g++ manual-page notice and normal libtool install-time relinking.

## Compiler repair and earlier evidence

The parser's consuming region worker and owning function entry both released its
input. The entry now shares `rc::consumes_arg` with direct calls. Source
`ee30d13b0`, run `42645911091`, passes both Linux hosts, all six parser tests,
primitive inventory and memory/corruption controls. Native/WASI regressions cover
aliases, parse errors, allocation failure and actual extra-drop faults; remaining
platforms still require final gates. [Repair](measurements/parser-entry-cleanup-2026-11-09/README.md).

The fwp service physical ledger passes at `cf6a0a12e`, run `42658708144`: eight
raw/optimized dynamic/static O1/O2 builds release all allocations; actual omitted
weak release fails with status 205. [Evidence](measurements/weak-callback-service-2026-11-09/README.md).

[Weak timings](measurements/weak-operation-time-2026-11-09/README.md) show substantial
C/Rust lookup gaps and mixed Swift results. The [census](measurements/weak-operation-census-2026-11-09/README.md)
finds a temporary 16-byte `Some` allocation per successful fwp lookup and none for
expired lookup; this does not explain all measured gaps.
[Buffer timing](measurements/returned-buffer-time-2026-11-09/README.md) retains both
sessions and every original noise failure. ARC operation counts and maximum dynamic
stack use remain unmeasured. [Scope](measurements/ownership-peers.md).

## Prepared work and delivery checks

- Service timing implementation is published: 28 O1/O2 or Onone/O native builds,
  178 result/fault checks, 64 invalid arguments and two interpreter modes gate
  collection. A C-only pilot fixes each work count before two balanced sessions;
  both service and process clocks retain separate 2% copy controls. The collector
  also records RSS, build costs and native images; six changed-evidence controls
  must fail. Both native caller-verification groups now pass; timing and its
  reconstruction/corruption controls now pass on both hosts.
- Guarded local C/Rust/Swift O2 callers pass 48 result cases and actual missing
  delivery/backward-clock controls. The first Swift link found that the local
  clock object targeted macOS 15 while Swift targeted 14; explicitly compiling
  the clock for 14 repairs it. Only affected Swift builds were repeated. Four
  timing-reader tests and two descriptor-boundary tests pass. No local fwp build
  or benchmark was run.
- The repaired boundary accepts both actual native emitted sources; focused Rust
  archive-link result/fault checks pass locally. Both complete failed native
  journals were audited before publication; no other failure was found.
- Parser accounting validation now rejects invalid kernel/system records and
  policy changes during a process. Seven archive corruptions include policies
  whose hashes and journals were updated consistently. Local reader checks pass
  10 tests; the Linux stopped-child check remains runner-only.
- Prepared [actual native allocator observer](measurements/parser-native-allocator.md):
  O2 ordinary/observed C/Rust parser pairs, four real omitted-tree-release controls,
  matched libc/Rust debug source, bounded raw events and exact vector-ledger
  reconciliation. Five local reader tests pass, including duplicate nested returns,
  mapped/retry models and missing/reordered events. Native repair now passes;
  synthetic paths are not native verification. The separate
  [fwp heap/region observer](measurements/parser-heap-events.md) is prepared:
  ten O1/O2 builds, eight actual traces, eight wrong-result checks and 24 actual
  missing-release/observer faults. Five local reader tests pass. All four source
  variants patch both retained native generated programs; no local compiler build
  or parser execution was run. The first patch found both native and WASI resize
  definitions; it now selects the native allocation body explicitly.
- The handoff rewrite briefly removed the status column required by its checker;
  the column is restored. The audit now passes 430 doc link sets, 106 immutable
  preparation pairs and all five roadmap steps.
- Local focused checks use `python3 scripts/local-guard.py` unchanged. Disk free
  space is about 137 GiB. Full builds, profiles and suites stay on GitHub.
- Complete parser-control artifacts are under 128 KiB compressed each; all raw
  snapshots, manifests and native headers reconstruct locally. Service journals
  exceed the 2 MiB member limit and are processed on runners. Do not raise limits.
- Final integration requires nine exact-head production jobs, docs and full-log
  audit. [Earlier passing head `7645384bb`](measurements/ownership-peer-gates-2026-11-09/README.md)
  does not verify later changes. The numerical dispatcher must stay below 512,000 bytes.
