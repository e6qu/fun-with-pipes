# Current work

**Next:** publish the completed driver-comparison batch as one PR, then audit all
nine production jobs and documentation for its exact final head before squash
merge. No further diagnostic timing is needed; all four declared sessions passed
native controls and independent full-archive audit. Original timing goals remain open.

## Branch and delivery

- Worktree `/private/tmp/fwp-array-consumption`, branch
  `array-observation-diagnostics`, now rebased onto verified main `7e48e438`.
  The primary checkout remains untouched. Keep one active PR.
- [PR #246](roadmap-history.md#array-preparation-diagnostic-pr-246) merged as
  `7e48e438d3b78ea357017a0cd1adae26a85fb0a0`, after all nine production jobs
  (`41478753238`) and documentation (`41478745298`) passed at `44626348`.
  Every full job/target log is audited. Tree `dd953092b6d9c0945ef1fc687220efa2a2939326`
  matches the tested head; the raw squash message is one 61-character line, with
  no body/trailers. Duplicate main checks `41495751007` / `41495750634` were cancelled.
- Audit logs, metadata and helpers remain under `/private/tmp/fwp-246-*`.
  Both Linux archives cover 257 targets / 1,034 tests; each macOS architecture
  covers 131 regular targets / 650 tests and 126 ownership targets / 379 tests.
  Each complete Windows job reports 853 passing tests. Existing ignored runner
  measurements and Windows' two POSIX-PTY SDK skips remain explicit; its eleven
  applicable SDK tests pass. Reviewed panic messages are deliberate scheduler
  controls. No unresolved production failure.

## Driver-comparison evidence

- Frozen [protocol](measurements/array-observation-boundaries.md): `c583459b`,
  tag `roadmap/array-observation-protocol-2026-11-02`.
- Measured source: `d1f18ff74727a62cffa85506fc912597a8a3d7e6`, tag
  `roadmap/array-observation-runner-2026-11-02`. These original identities remain
  retained after rebase. There is no compiler/runtime change.
- [Complete report](measurements/array-observations-2026-11-02/README.md): four
  native sessions, all source/binary/command/sample identities audited;
  four CPU-only rejections retained. No completed timing repeated.
- Added observations alone retain the early large-AMD64 pattern. The complete
  zero-preparation driver changes it but raises total timed work 7.7–9.8%.
  ARM64 consumption instead becomes 4.5–5.4% slower. All ARM64 and large-AMD64
  copies pass; thirteen small-AMD64 copy limits fail and stay explicit.
- Every version/copy/sample position, managed count, RSS, instruction size and
  stack estimate is retained. Absent CPU/fault observations stay blank. Close
  this diagnostic without hidden preparation or a speculative ownership fix.

| Session | Run / job | Artifact | Full local audit |
|---|---|---|---|
| ARM64 1 | `41483622413` / `125408109437` | `13160584315` | Pass, 4.51s |
| ARM64 2 | `41483622413` / `125408109314` | `13162246109` | Pass, 4.56s |
| AMD64 1 | `41483622413` / `125408109605` | `13162735018` | Pass, 4.63s |
| AMD64 2 | `41487610457` / `125421960114` | `13163836448` | Pass, 4.82s |

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Frozen three-driver boundaries and exact source reconstruction |
| 2 | Verified | Native numerical, ownership, actual omitted-destruction and clock-failure controls |
| 3 | Verified | All four full archives audited, every host rejection preserved |
| 4 | Verified | Complete 96-role table and report preserve all timing limits and failures |
| 5 | In progress | Publish this combined batch, complete final gates and verified squash merge |

## Checks, repairs and resources

Guarded checks pass: three source/schedule tests (0.14s), all 48 retained C input
variants (0.86s), workflow lint (6.33s), 213 documentation link sets (3.00s), and
complete compact write/check replay (2.96s / 3.13s). All 48 memory profiles have
identical storage fields across five samples (0.25s). The report's representative
values also capture their maxima. The final delivery-record link check passes
(213 link sets, 106 immutable pairs/tags, five roadmap steps; 3.03s).
No local compiler build, full suite or benchmark.

A source test caught and fixed a global clock replacement before publication;
controls now alter only benchmark clocks. One local audit rejected an unfinished
download; waiting for completion resolved its digest check without a measurement
rerun. Stale #243/#245 and derivative/array next-step passages now link completed
work. The glossary explains drivers, clocks, faults, switches and virtual memory.

Completed #243/#244 temporary checkouts were removed after tree verification.
The completed #245 checkout was removed after saving its exact uncommitted handoff
and patch under `/private/tmp/fwp-245-worktree-handoff-preserved`; commits and
evidence remain. Preserve at least 64 GiB free; use the local guard serially.

After this delivery, [PLAN.md](../PLAN.md#next-compiler-investigation-temporary-derivative-lists)
names the next source-level opportunity: compact temporary mapped records while
preserving map-before-fold order. First profile current code; do not assume the
historical allocation sites survive or interleave stateful derivative operations.

Merge only after all final-head gates and audits pass. Supply one subject of at
most 80 characters and an empty body, with no trailers/attribution. Verify tree
and message, then continue PLAN.md.
