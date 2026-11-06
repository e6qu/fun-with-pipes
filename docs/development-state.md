# Current work

**Next:** monitor final production run `42166013453` (nine jobs) and documentation
run `42166011721`, job `127722548913`, at exact head
`a90f793e485aa91736156ae87dfc3ae36ec9cbad`. Audit every completed job/target and
fix all failures together. Once final gates and complete audits pass, squash-merge
with empty body and subject `Inline checked scalar derivative recording`;
verify the actual message and tree. Do not rerun completed measurements.

Branch `recording-call-costs`, worktree `.worktrees/scalar-constant-lowering`;
[PR #263](https://github.com/e6qu/fun-with-pipes/pull/263), ready for review.
Measurement/input publication: `48c2ae70ab58813bc04ab7bda4b8d7845ccef852`.
Final head `a90f793e485aa91736156ae87dfc3ae36ec9cbad` retains only the native-image
receipt/docs; tree `c7bef970b64dc07dc487592a14402b8d46ccf388`. Keep this status update
local until delivery is recorded, so final gates continue against the frozen head.
Production code/tests: `39a9f806891b524042b391b85480cbafc022afbc`;
subsequent production trees are identical. Base is [verified PR #262](measurements/recording-lookup-delivery-2026-11-06/README.md),
merge `9a9dc49c53212b562cd9de06f908248ceb6109af`, tree
`66f69ee54dcc207be2a9041d2cae9e89ad3d9aa3`, identical to its tested head.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | PR #262 delivery and saved source comparison retained. |
| 2 | Verified | All 72 original images reproduced; complete GCC reports/logs audited. |
| 3 | Verified | Inlining contract frozen at `29f99b70` before production edits. |
| 4 | In progress | Correctness, memory and complete measurement audits pass. Native reports pass with all 48 images identical. Retain misses; finish final platform delivery. |

## Change and evidence

The [change](measurements/recording-inline.md) forces the existing checked F64
append body inline. It changes no validation, arithmetic, allocation or cleanup.
The same-source reference removes only that declaration attribute; both versions
keep lookup reuse. The earlier 72-image diagnostic motivated this candidate but
did not establish the previous AMD64 slowdown's cause.

| Gate | Source / run | Result |
|---|---|---|
| [Focused correctness](measurements/recording-inline-checks-2026-11-06/README.md) | `39a9f806` / `42156552424`; audit `42158479402` | Three hosts, each 25 targets, 856 images and 872 observations. Complete logs/hashes pass. |
| [Measurement controls](measurements/recording-inline-controls-2026-11-06/README.md) | `a029797e` / `42157525720` | 14 suites, 107 tests; complete logs retained. Later reference/file-list controls also pass. |
| [Memory/work/stack](measurements/recording-inline-census-2026-11-06/README.md) | `ecfd740b` / `42158774007`; audit `42159822189` | Counts unchanged; zero final storage. Max frame growth ARM64 16 bytes, AMD64 zero. All 4,038 retained record hashes verified. |
| [Compiler costs](measurements/recording-inline-analysis-2026-11-06/README.md) | `ecfd740b` / `42158777078`; audit `42160109377` | All 672 commands succeed; 13/14 cases qualify. AMD64 zero-update copy control remains inconclusive. |
| [Runtime](measurements/recording-inline-time-2026-11-06/README.md) | ARM `7dba6db7` / `42162092035`; AMD `1c6ee1ef` / `42162639619`, `42162975545` | Four qualified sessions; audits `42164603033`, `42164773822`, `42164952097` pass. 13/32 long targets pass, 19 remain open. |
| [Native inlining](measurements/recording-inline-images-2026-11-06/README.md) | `48c2ae70` / `42165452140` | Both jobs pass; all 48 measured images identical, candidate inlining verified, complete hashes/logs retained. |
| Docs | `a90f793e` / `42166011721`, job `127722548913` | Final-head full controls pass. Complete log has only the three deliberate runner-failure controls. |
| Final platforms | `a90f793e` / `42166013453`, attempt 1 | Seven jobs pass; Linux ARM64 and Windows AMD64 continue, no failed steps. Completed logs have no unexpected diagnostics. Full artifact audit follows all nine jobs. |

Runtime producer heads have identical production, benchmark and recorded source
hashes. Long cases use 2.26–8.12% less elapsed time. Small-case slowdown peaks at
1.53%; identical-copy variation at 1.43%, both below 2%. The 19 misses are both
architectures' 3/199 and 3/1999 forms in both sessions, plus AMD64 history 33/199
in session 1 and 129/199 in both. Keep every older PLAN.md miss too.

Compiler AMD64 `derivative-3-0`: identical reference medians 0.3917460715 and
0.3838788290 seconds differ by 2.0494%, above 2%. Observed time/RSS ratios stay
below 1.05. All four copies slow later; copy identity and position are partly
confounded. This remains inconclusive; no cause or passing bound is established.

## Repairs and remaining gates

The [first runtime audit](measurements/recording-inline-audit-repair-2026-11-06/README.md)
expected `source/src/cgen.rs` instead of the changed runtime file. The repair
moves inventory validation into the complete reference validator and adds extra/
wrong-path controls. Every failed session was re-audited from its saved artifacts;
no timing was rerun. Three wrong-CPU hosts were rejected before builds/timing.
All failure/rejection records remain linked in the runtime receipts.

The [new input plan](measurements/recording-inline-call-inputs.json) selects each
architecture's audited session 1, both forms, six cases and both versions. All original image hashes and candidate append inlining pass; no program
executed during this diagnostic. Do not rerun the original 72-image diagnostic. The final exact-head nine-job matrix and docs are running; complete production/doc
audits follow. Earlier draft-only skipped CI is not platform evidence. Squash-merge only after final gates pass, with one
subject at most 80 characters and empty body, then verify tree/message identity.

Local guarded checks: measurement receipt hashes 0.50s; saved compiler review
0.13s; corrected reference controls 0.71s; runtime digests 0.25s and four-report
reconciliation 0.49s; complete native-image record hashes 0.13s. Sparse historical fixtures were left to the passing GitHub
full documentation gate. Scratch report generation needed explicit `PYTHONPATH=scripts`;
no product change. Full builds, large audits and benchmarks stay on GitHub.
About 78 GiB free at last check. Scratch: `/tmp/fwp-inline-*`, `../gradient-work/`.

## Next candidate review

Read-only review during final CI: the saved GCC reports leave
`fwp_tape_reserve` out of line after append inlining. Its two runtime callers are
ordinary F64 append and typed append. Each checks the node/parents first; reserve
then checks the requested bound before returning when capacity is sufficient.
The growth body owns paired parent/weight reallocations and typed-weight recovery.
The next group is isolated in `.worktrees/recording-capacity-gate`, branch
`recording-capacity-gate`; no second PR is open. Contract commit `10b275c0` froze
the checked inline gate/shared growth change before edits. Its source proof
reconstructs the previous runtime byte for byte. Two focused reference/corruption
controls pass under the guard (0.13s), as does that reconstruction (0.13s).
Runtime and capacity boundary/failure controls are implemented but not yet native
validated. Explicit runtime/memory/compiler protocols and workflow choices are
wired at `7b4b34fb`. All four complete source/reference controls pass under the
guard (0.73s), including full inventories and corruption cases. The 23 runtime
budget controls, nine phase/memory controls and the focused all-workload census
control also pass. Workflow syntax
passes actionlint with shellcheck/pyflakes disabled. A missing 5 MB historical
fixture was restored before the 23-test budget check passed. No native builds or
timings have run. Native compiler-report support now takes an explicit target;
six controls pass, including capacity plans and similarly named functions. The
existing literal-reference reader control passes after restoring its 212 KB
fixture. Publish this isolated branch and run `recording-capacity-checks` on all
three hosts plus `storage-measurement-controls`; do not dispatch measurements
until those exact-production-source checks pass. No second PR until #263 merges.
After PR #263 delivery, rebase this branch onto its verified squash merge, retain
the delivery receipt and update PLAN/history. Do not publish a second active PR.
Scratch review: `/tmp/fwp-capacity-review.md`; frozen contract is
`docs/measurements/recording-capacity.md` on that branch. No cause for earlier
timing misses or speedup from the next change is established.
