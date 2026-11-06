# Current work

**Next:** finish the census audit `42159822189` and compiler-cost audit
`42160109377`, inspect every saved result, then run the frozen qualified runtime
batch once. Preserve the AMD64 compiler-copy failure below; do not rerun unchanged
timings for a pass. Publish the pending diagnostic/receipt changes together.

Branch `recording-call-costs`, worktree `.worktrees/scalar-constant-lowering`;
draft [PR #263](https://github.com/e6qu/fun-with-pipes/pull/263).
Published measurement source: `ecfd740be6289b365dd2a1bb9e2f60980ab27c8f`.
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
| 4 | In progress | Three-host correctness and full audit pass. Census producers pass; compiler costs have one inconclusive control. Finish measurement audits, runtime/binary checks and final platform delivery. |

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
| Memory/work/stack | `ecfd740b` / `42158774007` | Both producers pass; audit `42159822189`, job `127702599856`, is queued. Complete producer logs have no unexpected diagnostics. |
| Compiler costs | `ecfd740b` / `42158777078` | ARM64 passes; AMD64 has the single copy-control failure below. Audit `42160109377`, job `127703506512`, is queued. |
| Docs | `ecfd740b` / `42158778585` | Pass. Earlier docs at `39a9f806` and `a029797e` also pass. |

Census jobs: ARM64 `127699163254`, AMD64 `127699163371`.
Compiler jobs: ARM64 `127699171640`, AMD64 `127699171809`.
No new runtime timing or final nine-job matrix has run. Draft-only CI is skipped
and is not platform evidence. Preserve all earlier PLAN.md timing misses.

## Compiler result that remains open

AMD64 `derivative-3-0`: identical reference copies have medians 0.3917460715 and
0.3838788290 seconds, ratio **1.0204940776**, exceeding 1.02. All commands complete;
observed candidate/reference time is 0.99721112 and peak RSS ratio 0.99949114.
All other observed time/RSS limits pass. This case is **inconclusive**, not a
verified compiler-cost bound. Audit saved source/order/samples before attributing
a cause; do not tune the setup or rerun it for a pass. The standing policy retains
verified reductions with timing goals open; it does not turn a failed control green.

## Pending publication and verification

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
hash verification: 0.25s. Full builds, measurements and large audits stay on GitHub.

First focused audit `42158262680` omitted `production_attempt`, causing argument
parsing and then empty-artifact upload to fail. Corrected `42158479402` explicitly
used attempt 1 and passed; native tests were not rerun. Its receipt retains both
logs. Earlier local control failures were missing sparse JSON/gzip fixtures;
restoring those exact tracked files fixed them. One Rust formatting line was fixed
before publication. There are no unresolved semantic or memory-safety failures.

Scratch: `/tmp/fwp-inline-*`, `/tmp/fwp-recording-*`, `../gradient-work/`.
About 80 GiB was free at the last disk check. Use the local guard, keep imports
at the top, and keep commit messages one line, at most 80 characters, no trailers.
