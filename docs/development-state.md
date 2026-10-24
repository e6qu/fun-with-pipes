# Session handoff

All seven [plan](../PLAN.md) areas remain open. Prefer ownership and borrowing;
reserve ARC for sharing and remove tracing. JIT is excluded.

## Current action

**Next:** publish the grouped ARC benchmark/map PR from `arc-map-delivery`, then
complete its exact-head nine production jobs, docs and actual-binary reviews.
Keep one active PR. Squash-merge only after every final gate passes, with one
subject of at most 80 characters and an empty body, then continue the plan.

Checkout `/private/tmp/fwp-arc-benchmark-comparison`. Prepared from verified #208
merge `058dc4e5954571ed222ca4d26af4403a52a8516b` and published preparation `e08646c505bb38ec0b0dc8869a06823f92463956`.
Receipt `/private/tmp/fwp-arc-map-delivery-preparation.json` records this transition.
Do not rerun completed preparation/publication helpers. Use their receipts.

## Grouped changes and evidence

The C/Rust comparison explicitly selects compiler, ARC and no LTO, saves actual
executables and six elapsed samples, and separately measures RSS and managed
storage. See [the comparison](measurements/arc-comparison.md) for programs,
arithmetic differences, timings and remaining costs.

Map builders free sort scratch before result allocation. Borrowed words compact
into input lanes whose original owners stay alive. Duplicate handling is preserved.
The 500,000-entry map peak falls 24,000,008 → 16,000,008 managed bytes on both Linux
hosts; four requests, 24,000,032 requested bytes, one retain and zero final charge
are unchanged. AMD64 instruction bytes +16; ARM64 unchanged. Observed instrumented
entry/sort frames are unchanged. No timing gain or general C/Rust parity is claimed.

Focused preparations, all published with immutable revision tags:

| Source | Run | Verified result |
|---|---|---|
| `617bb2319760` | `40075912779` | Two Linux hosts; 42 actual baseline images and eight corrupted-copy controls |
| `b16ed5e33f29` | `40076674217` | 70 timed/profile images, RSS/count samples and fourteen leak controls |
| `18ac20729402` | `40077293691` | 98 images; arithmetic screen fails AMD64, so no compiler rule adopted |
| `6a6e8eea325c` | `40078374681`, `40078376733` | Six map jobs and two benchmarks; lower peak confirmed, 70 benchmark images reviewed |
| `4c294917006b` | `40079580345` | All six map jobs; 138 actual images, 96 peak observations, failures/reuse and exact control-source edits reviewed |
| `2a973dea2e07` | local guarded checks | Reports, source matching, stack details, production artifacts, docs gate and plan updates published |
| `e08646c505bb` | guarded artifact reinspection | Shared focused/production inspector reproduces the identical six-host report |

[Native map evidence](measurements/map-scratch-native-2026-10-24.json) includes
ARC/tracing at production GCC/Clang settings and deliberate missing-cleanup,
wasted-slot and late-release controls. All eight collection-evidence controls and
eighteen native coverage/failure controls pass. Primitive inventory: 392
declarations, 382 distinct symbols, zero unclassified contracts. Final production
acceptance of this new delivery remains required.

## Previous delivery

#208 is verified and merged. [History](roadmap-history.md#api-memory-stack-guards-and-connection-cleanup-pr-208)
links all gates and 8,454 binary files; source `227e671257d885185e54b3f915f6d1ebf470b3ea`.
Merge and after-merge receipts/helpers are under `/private/tmp`, prefixed
`fwp-http-memory-delivery`. Preserve primary checkout's operational handoff.

Keep unique failed API/mapping/socket evidence: `ef66ca99`, `027be46e`,
`10626760`. All diagnosed faults were repaired. Original failure archives remain;
never treat an isolated repeat as their repair. Verified duplicate caches and
clean published checkout copies were pruned with receipts. Branches, reports,
source tags and ignored-file backups remain.

## Local limits

Focused local checks use `python3 scripts/local-guard.py COMMAND...`, serially.
Full builds, suites and benchmarks run on GitHub. Preserve 64 GiB free, target
below 2 GiB, sampled RSS below 1 GiB and the 180-second deadline. Do not retry the
full local API compilation that exceeded RSS, or raise limits. Inspect binaries
without executing downloaded files. Record each new check and unresolved failure.

## Remaining direction

Finish this delivery, then use explicit equivalent-work budgets to choose the
next ownership/representation or measured numerical costs. The arithmetic and
inlining experiments failed their full screens; do not adopt them from loop-only
wins. Persistent subscriptions, externally retained callbacks, host-owned values,
cycles and collector-specific diagnostics remain part of tracing removal.
Differentiation and numerical/application budgets also remain open; a finished PR
does not finish any of the seven work areas by itself.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |

The pre-push documentation check caught this status table missing from the
streamlined handoff. It was restored before publication; no source-code failure
or unresolved test was hidden.
