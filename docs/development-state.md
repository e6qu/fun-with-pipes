# Current work

**Next:** implement [nested resource-owner borrowing](measurements/nested-resource-owners.md)
under its frozen contract. Start with inner parameter anchors proved covered by an
enclosing live owner. Preserve interpreter scope metadata, weak expiration,
ordinary ownership and all failure/cancellation paths. Deliver this change with
the profiler repairs, measurements and docs in one substantial normal PR.

## Verified delivery

[PR #275](https://github.com/e6qu/fun-with-pipes/pull/275) merged as
`13d31fc4041a664129ed5674845750836faa0a84`. Its tree equals verified head
`a232e1e35062a37aa013975ac77bbd8cb4620663`; its message is one line, 49 characters,
with an empty body and no trailers. [All final gates and receipts](measurements/compiler-borrowed-final-gates-2026-11-10/README.md)
are retained: production `42767361217`, docs `42767360650`, complete-log audit
`42778134759`. All ten audit reports match the exact passing head. Complete archive
size, SHA-256 and every CRC pass. Duplicate main runs `42779270202` and `42779270047`
were cancelled after equal-tree verification.

[Borrowed compiler types](measurements/compiler-borrowed-types-2026-11-10/README.md)
remove 29–32% of type copies with identical C and diagnostics. Ordinary compilation
takes 11–14% less time for word counting and 8–10% less for callbacks. All complete
applications and memory limits pass. [Four AMD64 growth comparisons](measurements/compiler-type-time-2026-11-10/README.md)
remain noisy under the frozen 2% copy-control limit; do not rerun them unchanged.

## Current branch and source identities

Worktree `.worktrees/service-cpu-costs`, branch `service-cpu-costs`, rebased onto
the verified squash. No delivery PR yet. Immutable observation source
`fac4a47440fb02667ddbf385dba959ae8f91a310` is retained by
`roadmap/service-cpu-observation-2026-11-10`.
Reference ordinary compiler/runtime `65719f7fc2277a5b97c5a790df941fea6c5eb4d7` is
retained by `roadmap/service-cpu-software-clock-2026-11-10`; its ordinary sources
match the recording source. Publish the candidate contract before production edits.

## Verified service diagnosis

[Run `42781360626`](measurements/service-cpu-attribution-2026-11-10/README.md) passes:

| Host | Job | Artifact | Verification |
|---|---|---|---|
| ARM64 | `129711934407` | `13746173266` | 32 original cases / 16 profiles reconstructed |
| AMD64 | `129711935132` | `13747030196` | Same |

Every service result, calibration choice, sample period and attribution row
reconstructs both on runners and locally. Complete archive sizes, hashes and CRCs
pass. Saved recordings/binaries were decoded; no programs were rebuilt or rerun.
The pinned perf reader repair requires the `0x` prefix before an end marker;
unpatched readers still produce 115 ARM / 121 AMD errors as controls.
[All failed LLVM/setup attempts](measurements/service-decoder-replay-2026-11-10/README.md)
remain separate records. Both complete passing logs contain only optional manual-
page notices and the download action's Node Buffer deprecation. The next workflow
uses `gh api`, verifies source/archive hashes/CRCs, and avoids that deprecated path.

Identified count operations account for 40–43% of fwp sampled CPU work on ARM64,
48–51% on AMD64. Cleanup push/pop leaf samples account for 26–32% and 12–14%.
Do not add unlike attribution categories or equate samples with ARC counts.
fwp unknown leaf work is below 1%; nearly every stack has an unknown libc ancestor.
Inlining erased construction/dispatch/drain boundaries; they stay unclassified.
C/Rust/Swift have larger unresolved leaf shares. These are not peer time ratios.

Generated `w40` contains nested frame holds for values already owned by an outer
frame. Review `src/resource.rs`, `src/cgen.rs` and interpreter region clearing.
A native-lowering proof can leave interpreter/debugger metadata intact. Consider
exact aliases first; allow immutable projections only with dominance and lifetime
proof. Do not change ordinary owner transfer or retain an obsolete proof across
loop rebinding. Inspect actual HTTP selection before claiming shared benefit.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup; all gates | Recorded comparison limits apply |
| 5 | Verified | #274 applications, compiler reports/growth, HTTP load; all gates | Recorded observation limits apply |
| 6 | In progress | #275 borrowed types; application speed/memory targets; all gates | Four noisy growth comparisons |
| 7 | In progress | Verified service CPU profiles; selected lifetime proof | Implementation, focused controls, measured acceptance and final delivery |

## Local checks and preservation

Four guarded collection/replay controls pass, including altered periods, wrong
classification and skipped calibration. Five compiler-reader and five service-reader
controls previously pass. Shared compiler replay `42772707168` exactly matches the
previous reader's rows/counts/periods on both hosts. New summaries independently
reconstruct all 32 profiles. Actionlint passes the explicit verified-download step.
The latest docs audit passed 457 link sets / 106 anchors / seven milestones; audit
the new attribution report and candidate contract before publication. No local builds.

Use `python3 scripts/local-guard.py` serially: 64 GiB free disk, target data <2 GiB,
sampled RSS <1 GiB, 180 seconds. Last free space: about 112 GiB. Preserve unrelated
root changes, old worktrees and stash `451bbf713d451f2d62d80fd7676839404875846a`.
Pre-rebase service backup: `540b0682408d751afb6e439d58a3b887bdcba373`.
