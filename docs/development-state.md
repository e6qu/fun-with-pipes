# Current work

**Next:** dispatch and audit all four `cpu-baselines` sessions for
[draft PR #223](https://github.com/e6qu/fun-with-pipes/pull/223).
freeze per-workload limits from their unchanged noise controls, then run the
full final-head matrix. No CPU optimization or new timing result is claimed yet.

Worktree: `/private/tmp/fwp-parser-workspace`; branch `cpu-baselines-and-budgets`.
Base: merged #222, `17978b97373f3e9236468ac19c1b8e0d290816d7`.
The batch adds the repeated collector, corruption controls,
runner selection and [protocol](measurements/cpu-baselines.md), plus the accepted
F1–F3 record and removal of obsolete pending/queue instructions.

## Scope and acceptance

Current tasks are B1/P1 and the corresponding B2 evidence checks for `loop` and
`text-length`. Build the existing checked C/Rust/fwp peers independently from
source. Two jobs per architecture use the same inputs, CPU model and compiler
settings. Each records two warmup batches and 32 rotating batches per variant, including
a second execution of the identical fwp image. A loop batch has one process;
a text-length batch has 32 fresh processes. Every output and summed duration
is checked. Short prior text timings justify batching without changing inputs
or acceptance limits. Preserve process startup/output/
cleanup inside timing and evidence writes outside it.

Median identical-code ratio must be <=1.03 and its nearest-rank 95th-percentile
paired ratio <=1.10. Unstable data is inconclusive. Freeze a candidate regression
limit of twice the larger session's observed 95th-percentile deviation, per
workload/host, before any candidate measurement. Future controls must stay inside
that frozen envelope. The protocol owns the complete rules and memory exclusions.
B1/B2 for other ownership, derivative and numerical workloads remains open.

The Python controls reject missing/reordered/wrong samples, changed source or
compiler, duplicate sessions, false statistics, noisy controls, and missing
memory/stack evidence. The suite reuses the actual benchmark binary and memory
audits. `verify` rejects edits to a frozen table by recomputing it from the four
original records. Initial run `40764926704` was cancelled while all four jobs
were queued, before applying the short-sample repair; no completed evidence was
discarded. All original seven-peer measurements remain available; extra repeated
timing targets only the two named CPU gaps.

## Verified previous delivery

F1–F3 are verified in #222. Final `b69f111e` and merge `17978b97` share tree
`5a434a44f164e664b31c70a8d7b1db9e8dc8ab5d`; the squash message is one line <=80
characters, without body or trailers. All nine production jobs `40721714559`,
docs `40721714558` and both G2 hosts `40721764744` pass. Every completed log is
audited without compiler warnings or failed targets. [History](roadmap-history.md#functional-calls-and-recursion-pr-222)
owns counts and links. Postmerge CI `40749834807` and docs `40749834937` also
report success; the acceptance record relies on the audited final-head runs.

Long timing `40721041382` at `98a1d8eb` accepts all four original limits after
increasing batches to 65,536 invocations. Only docs changed before the final head.
The independent audit verifies samples, order, outputs, compiler flags, actual
ELF hashes/text sizes, profiles and stack reports. ARM64 O2 remains about 1.9%
slower than ordinary calls; it beats the explicit loop and stays within the
fixed acceptance limit. The short noisy session remains inconclusive in its
original record. [The report](functional-costs.md) owns all three timing sessions.

Logs: `/private/tmp/fwp-222-{final,g2,long}.log`. Artifacts:
`/private/tmp/fwp-222-long-artifacts`, `/private/tmp/fwp-222-g2-artifacts`.
Guarded `/private/tmp/fwp-audit-long.py` passes. G2 preserves exact lifetime facts,
40-byte origins and the original work/time budgets. The existing historical Intel
[compiler abort](measurements/compiler-abort.md) remains unexplained; no recurrence
or new source evidence appeared. Do not resume disassembly-led allocator experiments.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | Verified | Maintain the named A1–A6 guarantees |
| 3 | Verified | Maintain the scoped F1–F3 call and recursion guarantees |
| 4 | In progress | Establish repeatable CPU gaps, then select a proved repair |
| 5 | Pending | Derivative storage, timing and precision |
| 6 | Pending | CPU numerical kernels |
| 7 | In progress | Freeze the two CPU budgets; broader B1/B2 remains open |
| 8 | Pending | Larger-program correctness, cleanup and scale |

## Local checks and recovery

Guarded independent recursion and log audits pass. Six focused baseline test groups, workflow lint and documentation audit pass.
Local commands use `python3 scripts/local-guard.py` with the respective Python
script or Actionlint; no limits were changed. No full local build, suite or benchmark runs. Keep the
64 GiB free / 2 GiB target / 1 GiB RSS / 180-second guard limits; last free disk
observation is 74 GiB. Primary checkout remains detached at #209 with a recovery
pointer and untracked compiler-abort evidence; preserve both.

Earlier raw records remain under `/private/tmp/fwp-221-*`,
`/private/tmp/fwp-222-ca914-artifacts` and `/private/tmp/fwp-222-b2f-*-artifact`.
GitHub's old `38888712709` status was inconsistent with all jobs completed;
cancellation said already completed. Do not treat it as a running workload.

Publication and squash merge are authorized after all final-head gates pass:
one line <=80 characters, empty body, no trailers/attribution. Verify the merged
tree and message, then continue [PLAN.md](../PLAN.md) in substantial groups.
