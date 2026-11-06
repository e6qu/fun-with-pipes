# Current work

**Next:** publish the final native-image receipt, mark PR #263 ready and monitor
all nine production jobs plus documentation for that exact head. Audit every
completed job/target and fix all failures together. When all final-head gates and
complete audits pass, squash-merge with an empty body and subject
`Inline checked scalar derivative recording`; verify the actual message and tree.
Do not rerun
qualified measurements or the completed native diagnostics.

Branch `recording-call-costs`, worktree `.worktrees/scalar-constant-lowering`;
draft [PR #263](https://github.com/e6qu/fun-with-pipes/pull/263).
Measurement/input publication: `48c2ae70ab58813bc04ab7bda4b8d7845ccef852`.
The next commit retains only its native-image receipt and documentation; use the
exact resulting PR head for final production gates.
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

| Gate | Source / run | Verified result |
|---|---|---|
| [Focused correctness](measurements/recording-inline-checks-2026-11-06/README.md) | `39a9f806` / `42156552424`; audit `42158479402` | Three hosts, each 25 targets, 856 images and 872 observations. Complete logs/hashes pass. |
| [Measurement controls](measurements/recording-inline-controls-2026-11-06/README.md) | `a029797e` / `42157525720` | 14 suites, 107 tests; complete logs retained. Later reference/file-list controls also pass. |
| [Memory/work/stack](measurements/recording-inline-census-2026-11-06/README.md) | `ecfd740b` / `42158774007`; audit `42159822189` | Counts unchanged; zero final storage. Max frame growth ARM64 16 bytes, AMD64 zero. All 4,038 retained record hashes verified. |
| [Compiler costs](measurements/recording-inline-analysis-2026-11-06/README.md) | `ecfd740b` / `42158777078`; audit `42160109377` | All 672 commands succeed; 13/14 cases qualify. AMD64 zero-update copy control remains inconclusive. |
| [Runtime](measurements/recording-inline-time-2026-11-06/README.md) | ARM `7dba6db7` / `42162092035`; AMD `1c6ee1ef` / `42162639619`, `42162975545` | Four qualified sessions; audits `42164603033`, `42164773822`, `42164952097` pass. 13/32 long targets pass, 19 remain open. |
| [Native inlining](measurements/recording-inline-images-2026-11-06/README.md) | `48c2ae70` / `42165452140` | Both jobs pass; all 48 measured images identical, candidate inlining verified, complete hashes/logs retained. |
| Docs | `66aed9ac` / `42164607195`, job `127718027559` | Full controls pass, including historical archives and the inventory repair. |

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
executed during this diagnostic. Do not rerun the original 72-image diagnostic. The final exact-head
nine-job matrix and complete production/doc audits have not run. Draft-only skipped
CI is not platform evidence. Squash-merge only after final gates pass, with one
subject at most 80 characters and empty body, then verify tree/message identity.

Local guarded checks: measurement receipt hashes 0.50s; saved compiler review
0.13s; corrected reference controls 0.71s; runtime digests 0.25s and four-report
reconciliation 0.49s; complete native-image record hashes 0.13s. Sparse historical fixtures were left to the passing GitHub
full documentation gate. Scratch report generation needed explicit `PYTHONPATH=scripts`;
no product change. Full builds, large audits and benchmarks stay on GitHub.
About 78 GiB free at last check. Scratch: `/tmp/fwp-inline-*`, `../gradient-work/`.
