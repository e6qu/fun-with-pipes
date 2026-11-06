# Current work

**Next:** publish the reference-inventory audit repair, then re-audit runtime run
`42162092035` and audit both AMD64 runs when complete. Only the saved artifacts
need rechecking; do not repeat qualified timings. Retain all results, declare
binary diagnostic inputs, then run final platform gates.

Branch `recording-call-costs`, worktree `.worktrees/scalar-constant-lowering`;
draft [PR #263](https://github.com/e6qu/fun-with-pipes/pull/263).
Census/compiler measurement source: `ecfd740be6289b365dd2a1bb9e2f60980ab27c8f`.
Production code/tests: `39a9f806891b524042b391b85480cbafc022afbc`; all subsequent
changes are measurement tools, Python controls or documentation. Their `src`,
`runtime`, `lib`, `tests`, Cargo and build-script trees match that passing source.

Base: [verified PR #262](measurements/recording-lookup-delivery-2026-11-06/README.md),
merge `9a9dc49c53212b562cd9de06f908248ceb6109af`, tree
`66f69ee54dcc207be2a9041d2cae9e89ad3d9aa3`, identical to tested `a8e427e8`.
Its verified squash subject has 54 characters and no body/trailers. Duplicate
post-merge runs `42152999846`/`42152999847` were cancelled after tree equality.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | PR #262 delivery and saved source comparison are retained. |
| 2 | Verified | All 72 original images reproduced; complete GCC reports/logs audited. |
| 3 | Verified | Scalar append inlining contract frozen at `29f99b70` before production edits. |
| 4 | In progress | Three-host correctness and full audit pass. Memory/work/stack and complete measurement audits pass; one compiler control is inconclusive. Finish runtime/binary checks and final platform delivery. |

## Change and evidence

The [implementation](measurements/recording-inline.md) marks the existing F64
append body always-inline. It changes no validation, arithmetic order, allocation,
cleanup or lifetime proof. Ordinary and proved-state callers share the same body.
The reference removes only that declaration attribute; both keep lookup reuse.

[The earlier native diagnostic](measurements/recording-call-analysis-2026-11-06/README.md)
reproduced 72 original images at `7d68bcea`, run `42155555677`. GCC left the append
body out of line in all three compared versions; the forwarding wrapper was
already inlined. This motivates the candidate, not a cause for the earlier slowdown.

| Gate | Source / run | Result and next action |
|---|---|---|
| [Focused correctness](measurements/recording-inline-checks-2026-11-06/README.md) | `39a9f806` / `42156552424`; audit `42158479402` | Three hosts pass, each with 25 targets, 856 native images and 872 observations. Full logs and retained hashes verified. |
| [Measurement controls](measurements/recording-inline-controls-2026-11-06/README.md) | `a029797e` / `42157525720`, job `127695118390` | 14 suites, 107 tests pass; all logs/digests retained. |
| [Memory/work/stack](measurements/recording-inline-census-2026-11-06/README.md) | `ecfd740b` / `42158774007` | Both producers and audit `42159822189` pass. Retained counts and all 4,038 record hashes verified; maximum frame growth ARM64 16 bytes, AMD64 zero. |
| [Compiler costs](measurements/recording-inline-analysis-2026-11-06/README.md) | `ecfd740b` / `42158777078` | 13/14 qualify; audit `42160109377` passes and preserves the copy failure below. All 672 commands and 2,162 retained record hashes verified. |
| Docs | `1c6ee1ef` / `42162532119`, job `127711334406` | Pass before the pending audit repair. |

Census jobs: ARM64 `127699163254`, AMD64 `127699163371`.
Compiler jobs: ARM64 `127699171640`, AMD64 `127699171809`.
Runtime run `42162092035` uses source `7dba6db7010af483f9d694b78e10cf71df2653a3`,
with both sessions on both architectures and focused prerequisite `42156552424`.
ARM64 `127709922516`/`127709922520` completed: each misses four 5% speed targets
(3/199 and 3/1999, both forms); other timing limits pass. Initial AMD64 jobs
`127709922590`/`127709922633` were rejected before building/timing (Xeon, EPYC 9V45).
Replacement `42162639619` at `1c6ee1ef` rejected job `127711689991` on EPYC 9V45;
qualified AMD2 `127711690001` and AMD1 `127712782292` (run `42162975545`) are timing.
Audit `42163629822`, job `127714862013`, failed both ARM64 sessions at the same stale
reference-file inventory assertion. [Repair and complete failure records](measurements/recording-inline-audit-repair-2026-11-06/README.md)
are retained; source/tests stay unchanged. Corrected artifact audits remain pending.
The final nine-job matrix has not run. Draft-only CI is skipped
and is not platform evidence. Preserve all earlier PLAN.md timing misses.

## Compiler result that remains open

AMD64 `derivative-3-0`: identical reference copies have medians 0.3917460715 and
0.3838788290 seconds, ratio **1.0204940776**, exceeding 1.02. All commands complete;
observed candidate/reference time is 0.99721112 and peak RSS ratio 0.99949114.
All other observed time/RSS limits pass. This case is **inconclusive**, not a
verified compiler-cost bound. The saved-sample review finds all copies slower in the second half; copy
identity and position are partly confounded. No cause is established; do not tune the setup or rerun it for a pass. The standing policy retains
verified reductions with timing goals open; it does not turn a failed control green.

## Remaining verification

The binary-report tool now requires an explicit committed `--plan` JSON and the
workflow requires `call_plan`. [Original inputs](measurements/recording-call-inputs.json)
match every source/index/variant of the completed 72-image diagnostic; do not rerun
it. After runtime audits, create the new candidate/reference input file from those
saved sessions, rebuild each image byte-for-byte and require GCC's candidate
inlining reports. No native programs or timings execute in this diagnostic.

Local guarded checks pass: count/phase/timing/compiler controls, reference edits,
full reference manifest corruption tests, explicit diagnostic inputs/report parsing,
Python syntax, workflow sizes and actionlint. New complete-reference test: 0.72s;
six diagnostic tests: 0.13s; original-input equivalence: 0.13s; full focused audit
hash verification: 0.25s. Measurement receipts/hash check: 0.50s; saved
compiler sample review: 0.13s. Full builds, measurements and large audits stay on GitHub.

First focused audit `42158262680` omitted `production_attempt`, causing argument
parsing and then empty-artifact upload to fail. Corrected `42158479402` explicitly
used attempt 1 and passed; native tests were not rerun. Its receipt retains both
logs. Earlier local control failures were missing sparse JSON/gzip fixtures;
restoring those exact tracked files fixed them. One Rust formatting line was fixed
before publication. There are no unresolved semantic or memory-safety failures.

Scratch: `/tmp/fwp-inline-*`, `/tmp/fwp-recording-*`, `../gradient-work/`.
About 80 GiB was free at the last disk check. Use the local guard, keep imports
at the top, and keep commit messages one line, at most 80 characters, no trailers.
