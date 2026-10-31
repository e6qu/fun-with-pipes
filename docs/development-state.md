# Current work

**Next:** publish this combined repair to
[PR #232](https://github.com/e6qu/fun-with-pipes/pull/232), then monitor and audit
all nine production jobs and documentation for its new head. Squash-merge only
when all pass, using an explicit one-line subject of at most 80 characters and
an empty body. Production run `41144314581` at
`d92939b897efa6290be37d9e82d0970bd7a9bc6f` is completely audited: six platform
jobs fail only the stale allocation expectation; every other target and all
post-test checks pass. The repair requires exactly zero allocations.

Worktree `/private/tmp/fwp-ownership-peer-baselines`, branch
`generated-array-folds`. Combined repair:

- Require exactly zero allocation/byte costs for the known borrowed-array
  pipeline; preserve original measurements as historical evidence.
- Remove obsolete GC switches and empty collection hooks from seven cleanup
  probes. Keep all cases and total repetitions; repeat complete success/failure sequences
  so healthy calls follow prior failures, and check live bytes every time.
- Release the mapped-array probe's own input, check final input teardown in
  list/zip/unzip probes, and test an intentionally omitted input release.
- Check managed storage after the Windows cwd second-read failure.
- Upload retained failure binaries only when files exist. Preserve failures
  from both the corpus and its artifact-retention controls; unrelated failures
  previously produced a misleading empty-artifact warning.
- Correct stale #230 application-delivery wording and explain the new counts.

These edits were prepared in `/private/tmp/fwp-application-cleanup-controls`
(branch `application-cleanup-controls`) and copied into this PR's worktree.
That preparation branch is now superseded; do not publish it or open a second PR.
No compiler/runtime change accompanies these repairs.

## CI audit

Production `41144314581`, documentation `41144314613`, source `d92939b8`:

| Gate | Job | Complete audit |
|---|---|---|
| Documentation | `124365690137` | Pass: 47 Python suites / 320 cases, tutorials and roadmap |
| C/Rust benchmarks | `124365690783` | Pass: 2 Rust checks, 14 Python controls, binary/storage inspections |
| macOS ARM regular | `124365690883` | Pass: 132 Rust summaries / 628 cases, 22 Python cases, 3,801 evidence files |
| macOS Intel regular | `124365691086` | Pass: same counts and evidence coverage |
| macOS ARM ownership | `124365691692` | 127 summaries / 365 passed, one stale allocation expectation |
| macOS Intel ownership | `124365690825` | Same sole failure; all other targets pass |
| Windows AMD | `124365691048` | 206 summaries / 821 passed, same sole failure |
| Windows ARM | `124365690853` | Same complete result as AMD |
| Linux ARM | `124365690786` | 257 summaries / 996 passed, same sole failure; post-test checks pass |
| Linux AMD | `124365690784` | Same complete result as ARM, including passing post-test checks |

Full logs/audits are `/private/tmp/fwp-232-<host>-d929.{log,audit.json}`;
labels: `docs`, `bench`, `mac-arm-regular`, `mac-intel-regular`,
`mac-arm-ownership`, `mac-intel-ownership`, `win-amd`, `win-arm`, `linux-arm`,
`linux-amd`.
All completed targets and diagnostics are audited. The Windows unit suite's sixteen
panics are intentional controls; 22 Python cases include five platform-specific
skips. The AMD TLS unknown-CA message is an intentional rejection control.
The macOS empty corpus-failure archive warnings are repaired by checking for
retained files before upload; copy failures now fail the collection step;
the corpus passed on both hosts. The ARM crash ZIP contains only the compiler.

Retained step archives: Windows AMD `13022467794`, Windows ARM `13022149747`
(each 98 targets / 252 passed / same one failure); Linux ARM `13023227401`
and Linux AMD `13024160184` (each 256 targets / 995 passed / same one failure).
Their local ZIP/audit files use `win-{arm,amd}-tls` and
`linux-{arm,amd}-targets` labels. Linux ARM verifies 7,301
ownership evidence files; each macOS ownership job verifies 3,046.

Query direct job endpoints when aggregate Actions listings lag. A repaired head
needs all nine production jobs and documentation again. Squash-merge only when
every final-head gate passes, with an explicit subject of at most 80 characters
and empty body.

The earlier `76ee7a80` docs failure was a stale numeric-array test count (2 → 3).
Both inventory and synthetic total are repaired; eight focused checks and final
docs pass. Superseded runs `41142900417`, `41143677115` and `41143677127` were
cancelled; all completed targets/partial logs were audited. Missing artifacts
there followed cancellation, not a new implementation failure.

## Allocation and timing evidence

[Generated-array elimination](measurements/generated-array-folds.md) replaces
eligible generate/map/fold chains with one loop. Reused arrays, unknown/effectful
callbacks, resources and F128 remain excluded. Preserve count bounds, evaluation
order and trap behavior. Compiler implementation is unchanged after `826e447f`;
measured source is `899ad012c19a9f49abce941070cdbfef610725d5`.

[Focused checks](measurements/generated-array-checks-2026-10-31.json) cover thirteen
GCC tests per Linux host, allocation/unwind controls and both G2 analysis hosts.
All pass. Three 4,096-element scans go from three allocations to zero; instruction
bytes grow 3.17% / 3.03%, with unchanged largest reported frame components.
The stronger observer rejects equal nonzero initial/peak/final count storage;
144 retained observations pass it.

[All four timing sessions](measurements/generated-array-timings-2026-10-31.json)
are audited and retained. Only AMD session one passes all controls; three sessions
fail the unchanged 2% identical-copy limit. Timing acceptance stays open. No
measured session was retried. Eight wrong-CPU attempts stopped before measuring.
The [full-buffer sessions](measurements/buffer-current.md) likewise retain 25/48
failed controls. Keep verified cost reductions separate from elapsed speed.

## Local checks and recovery

Guarded checks pass: corrected Rust formatting; workflow lint; eighteen Clang
O1/O2 cleanup-fixture executions using retained generated C, including missing
input/scratch controls (235/231). `/private/tmp/fwp-check-cleanup-inputs.py` took
4.75s; the complete success/failure sequence recheck passes in 4.71s. This is a fixture preflight, not rebuilt Rust/GCC/Windows verification.

The downloaded exact-head ARM macOS compiler emitted the borrowed-array entry;
its generated C contains a scalar loop. `/private/tmp/fwp-check-borrowed-cost.py`
passes at Clang O0/O2 for inputs 32/128: correct sums, zero allocation requests
and restored live bytes. Its initial entry lookup was repaired to handle the
scalar worker. No full local build or suite ran. Final formatting and roadmap
checks pass for the completed batch. The actual artifact-collection script
passes empty, retained-file (including spaces), symlink/directory exclusion and
forced-copy-failure controls. Workflow lint passes after that refinement.

Keep the dirty primary checkout `/Users/zardoz/projects/fun-with-pipes` untouched:
detached #209, recovery handoff and compiler-abort report. Automatic review rejected
replacing that handoff. Backup `/private/tmp/fwp-primary-recovery-before-file-checks.md`.
Preserve original CI archives. Space briefly fell below 64 GiB; guard refused work
until it recovered. No limits were bypassed or original evidence deleted.

[#231 delivery](roadmap-history.md#direct-scalar-folds-and-process-timing-pr-231)
is verified, squash `97b2c29ae15ebec84f2534c523b8f1260fd2fb67`, tree equal to its
tested head. The old `ownership-peer-baselines` branch must not be pushed.
The unexplained Intel compiler abort remains open: diagnose any recurrence from
source and input, preserving its evidence. Do not restart disassembly-led guessing.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve GC-free lifetime and cycle guarantees |
| 2 | Verified | Preserve scoped A1–A6; broader ARC costs remain in B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the unoptimized loop gap |
| 5 | In progress | Resolve D2's remaining timing requirement |
| 6 | In progress | Resolve N1's control before N2 timing acceptance |
| 7 | In progress | Deliver generated-array elimination; finish B1/B2 |
| 8 | In progress | Finish numerical and integrated V1/V2 acceptance |
