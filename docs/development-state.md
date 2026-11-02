# Current work

**Next:** finish auditing PR #246's exact-head CI and squash merge when all gates
pass. Production run `41478753238`, documentation `41478745298`, source
`44626348b71bf3af1aa16030aae1e7976cb26c37`. Do not change that passing head.

## Final PR #246 gates

| Gate | Status / audit |
|---|---|
| Documentation | Passed; full log and intentional runner failures audited |
| C/Rust benchmarks | Passed; full log audited |
| macOS ARM64 regular | Passed; full log, 131 targets / 650 tests audited |
| macOS ARM64 ownership | Passed; full log, 126 targets / 379 tests audited |
| macOS AMD64 ownership | Passed; full log, 126 targets / 379 tests audited |
| Windows ARM64 | Passed; full log: 206 passing summaries / 853 tests; native archive: 57 logs / 428 tests |
| macOS AMD64 regular | Running; no reported failed step |
| Linux ARM64 / AMD64 | Running; no reported failed step |
| Windows AMD64 | Running; native archive passes 57 logs / 428 tests; full job audit pending |

Both macOS corpus archives pass 85 distinct programs. Existing ignored runner
measurements remain explicit. Reviewed diagnostics are Homebrew already-installed
notices, echoed strict-warning commands and the intentional scheduler entry/child
panic controls in `src/sched.rs`; their test passes. No unresolved failure.
Logs and audit helpers are `/private/tmp/fwp-246-*`; artifact identities are in
`/private/tmp/fwp-246-final-artifacts.json`. Refresh that list before downloads.

## Independent next batch: complete driver comparison

Worktree `/private/tmp/fwp-array-consumption` checks out
`array-observation-diagnostics`, a child of #246. Its branch has no PR yet. The
primary checkout remains untouched. Keep one active PR: after #246 merges,
rebase only the child commits, publish this complete batch and run final gates.

- Frozen [protocol](measurements/array-observation-boundaries.md): `c583459b`,
  tag `roadmap/array-observation-protocol-2026-11-02`.
- Measured source: `d1f18ff74727a62cffa85506fc912597a8a3d7e6`, tag
  `roadmap/array-observation-runner-2026-11-02`. No compiler/runtime change.
- [Complete report](measurements/array-observations-2026-11-02/README.md): four
  native sessions, complete sources/binaries/commands independently audited;
  four CPU-only rejections retained. No completed timing repeated.
- Added observations alone retain the early large-AMD64 consumption pattern;
  the complete zero-preparation driver changes it but raises total timed work
  7.7–9.8%. All ARM64 and large-AMD64 copies pass. Thirteen small-AMD64 copy limits
  fail and remain explicit. Original performance acceptance remains open.
- The report includes every version/copy/sample position, managed counts, RSS,
  instruction size and stack estimates. Absent CPU/fault measurements stay blank.
  Close this diagnostic without hidden preparation or a speculative ownership fix.

| Session | Run / job | Artifact | Full local audit |
|---|---|---|---|
| ARM64 1 | `41483622413` / `125408109437` | `13160584315` | Pass, 4.51s |
| ARM64 2 | `41483622413` / `125408109314` | `13162246109` | Pass, 4.56s |
| AMD64 1 | `41483622413` / `125408109605` | `13162735018` | Pass, 4.63s |
| AMD64 2 | `41487610457` / `125421960114` | `13163836448` | Pass, 4.82s |

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Retained sample analysis preserves all earlier failures |
| 2 | Verified | Native numerical, ownership and deliberate-failure controls pass |
| 3 | Verified | All four preparation sessions and all four subsequent driver sessions audited |
| 4 | Verified | Driver effect documented; original limits retained; no runtime change justified |
| 5 | In progress | Finish #246 gates/merge, then deliver the separate completed driver batch |

## Checks, repairs and resources

Guarded checks pass: three source/schedule tests (0.14s), all 48 retained C input
variants (0.86s), workflow lint (6.33s), all 213 documentation link sets (3.03s), and complete compact write/check replay (2.96s / 3.13s).
The 96-role CSV reproduces all raw data. Final report/workflow checks pass after
staging. No local compiler build, full suite or benchmark.

The source test caught and fixed a global clock-call replacement before publication;
failure controls now alter only benchmark clocks. One local audit rejected an
incomplete download; waiting for completion resolved its digest check, with no
measurement rerun. Stale #243 kernel directions now link completed #244/#245 work;
the derivative page no longer calls its delivered phase report a next task.

PR #245 is verified and merged as `c43f05c22ed36277b491490b7d9e222dfd0af025`,
with the tested tree and one-line message. Completed #243/#244 temporary checkouts
were removed only after tree verification. The completed #245 checkout was also
removed after saving its exact uncommitted handoff and patch under
`/private/tmp/fwp-245-worktree-handoff-preserved`; commits and evidence remain.
Free space is about 64.5 GiB. Preserve at least 64 GiB; use the local guard, serially.

Merge only after all nine production jobs and documentation pass for the exact
head, with full audits. Supply one subject (at most 80 characters), empty body,
no trailers/attribution; verify merged tree and message. Then continue PLAN.md.
