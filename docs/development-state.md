# Session handoff

## Next action

Next: finish [PR #179](https://github.com/e6qu/fun-with-pipes/pull/179) on
`move-matched-variant-owners`, head `82bcf83f765e072afa6431cbf196532d433e3cad`.
Production `39417913864` has passing benchmarks, all four macOS jobs,
Linux ARM64 and Windows ARM64. Linux AMD64 and Windows AMD64 remain running.
Documentation `39417913929` passes. Eight completed logs are audited in
`/private/tmp/fwp-179-acceptance.json`. Audit every completed log
with `/private/tmp/fwp-audit-179.py`; fix every failure before squash merge.
Require all nine production jobs and documentation on this exact head. Use an
explicit one-line subject of at most 80 characters and empty body, then verify
the merge tree. Worktree: `/Users/zardoz/projects/fun-with-pipes`.
Keep the final head stable while healthy gates run; record status here locally.
Independent borrowing investigation is in `/private/tmp/fwp-direct-borrows`,
branch `borrow-direct-function-arguments`; no second PR is open.

## Accepted baseline

The user merged [PR #178](https://github.com/e6qu/fun-with-pipes/pull/178) as
`2ee0159b941d7887d70f5d86342cfad08e4e35c2`. Its tree equals tested head
`732984c3fb6b8646f6f3ee4932c123eadb7f3555`; the message is one line without
trailers. All nine production jobs `39397311012` and documentation `39397297724`
pass. All ten complete logs were audited; receipt:
`/private/tmp/fwp-178-acceptance.json`. Only duplicate post-merge production
`39417022563` was cancelled; post-merge documentation passed.
[History](roadmap-history.md#direct-matches-and-callbacks-pr-178) records the change.

## Current change and evidence

Matching a variant with one payload already held in local fields can transfer
that payload's owner instead of retaining it and immediately dropping the variant.
Scalar, record and variant results use the rule. Aliases preserve their owners;
boxed variants, multiple fields and protected resource slots keep existing cleanup.
Original expression nodes preserve failure-cleanup scope identity.

[The report](measurements/channel-variant-moves.md) compares the same five
channel programs with PR #178. Per additional message, fresh text, fresh function
and shared text each save one retain; shared function saves two. Allocations and
peak charged storage stay unchanged. Actual exchange frames shrink; binary sizes
are mixed. This is not a timing comparison or evidence of parity with C/Rust.

Passing focused run `39399972415` uses `eecb4b5c11246e6b9223bd7eda84f7857daeef30`,
preserved by `roadmap/revision-variant-moves-eecb4b5c`. Both Linux hosts pass 21
checks, none ignored or filtered. All 180 samples and 20 binaries are audited.
Passing broader run `39402978160` uses `a59328d765adab49b2faead775f8237f0eec7b82`,
preserved by `roadmap/revision-variant-proof-a59328d7`: 214 checks on each Unix
host, 215 on each Windows host, and 18 on each WebAssembly host. All eight
complete logs pass, with no ignored or filtered checks. The rebased branch's
compiler, runtime, tests and workflows match both passing sources. Final
production gates are still required for this delivery.

The first focused/broad runs failed because two test functions were unreachable
and correctly omitted from generated C. The repaired fixture references all three
result forms and keeps the three-move assertion. All failed logs were reviewed;
no other failure was found. The passing runs above verify the repair. Native
probes cover unique/shared owners, O0/O2, GC stress/verification, reuse poisoning
and a deliberately leaked-owner control. Existing queue cases cover cancellation,
failure after receiving a function and undrained captures.

Local evidence: `/private/tmp/fwp-variant-final-costs`,
`/private/tmp/fwp-variant-repair-audit.json` and
`/private/tmp/fwp-variant-final-proof-audit.json`. Baseline binaries remain in
`/private/tmp/fwp-match-final-costs`. Guarded final log audits passed in 10.26s
(PR #178) and 12.49s (broader variant checks). Guarded formatting passes (1.58s); the documentation audit passes all 68 Markdown
files, 106 immutable anchors and seven roadmap steps (2.63s). No local build was run.
Use `python3 scripts/local-guard.py COMMAND...` for serial focused checks;
from the worktree, use the guard's absolute path in the main checkout.
Full compilation, suites and measurements belong on runners. Preserve 64 GiB
free disk, target data below 2 GiB and sampled aggregate RSS below 1 GiB.

## Prepared direct-call borrowing

`/private/tmp/fwp-direct-borrows`, branch `borrow-direct-function-arguments`,
contains the next change. Its previous measured source is
`ad3cd792c079bac8d04bc1dcab69936eb62e97e5`, preserved by
`roadmap/revision-direct-borrows-ad3cd792`. No second PR is open.
Focused run `39423983460` passes 185 checks on each Linux host, none ignored or
filtered. Both complete logs are audited in
`/private/tmp/fwp-direct-borrow-repair-audit.json`. Broader run `39424662531`
passes 231 checks each on ARM macOS and Linux ARM64. Its remaining jobs were
requested cancelled because the tightening below supersedes that source.
Audit final cancellation with `/private/tmp/fwp-audit-direct-borrow-proof.py`.
Those partial checks do not establish full platform acceptance.

A subsequent review found that borrowing a last-use plain input could prolong
its storage beyond the callee's last use. The tightening requires
every live caller to need the same counted values after the call, for all eligible
parameter types. Scalar-only tuples keep their ordinary field convention.
Regression cases cover String as well as Channel fields and transitive calls.
Three previously absent broader targets (`borrowed_callbacks`,
`channel_cycle_ownership`, `task_ownership`) are added to Windows production.
The final nine production jobs now cover every broader native target, and Linux
production retains all WASI cases; do not rerun a duplicate extra matrix.
Run the stricter source through both focused measurement jobs, then finish the
report and open/ready the next PR only after #179 merges. All final-head
production jobs and documentation remain mandatory before its squash merge.

The compiler infers caller-owned arguments for eligible nonrecursive direct
workers. One contract drives lowering, ownership verification, entry ticks and
failure cleanup. Flat tuple views need an independent nonescape proof and keep
original boxes visible to tracing. Generic entries still consume their inputs.
Returns/stores, function-value uses, resource scopes, recursive functions and
unsupported representations retain existing ownership. Every live caller must keep the same counted values after the call; later use
of another tuple field is insufficient. This preserves hidden native sink-context
destruction timing without admitting new resource captures or channel cycles.

The verifier now rejects a borrowed argument whose owner is consumed while
preparing a later argument. Native probes check unique/shared owners, boxed
entries, failure, cancellation at worker entry and a deliberate leaked-owner
control. A checked-ARC channel case fails after receiving and verifies full
reclamation at O0/O1/O2, with stack placement both enabled and disabled.
The first focused run `39421484177` failed in two fixtures: missing constant type
context and missing generated unwind support. Both complete logs were audited
and both fixtures repaired together; the passing run above verifies the fixes.
Initial `39420410381` was cancelled while queued and supplies no evidence.

Passing artifacts: `/private/tmp/fwp-direct-borrow-final-costs`. All 180 profiles
and 20 ordinary binaries were audited using `scripts/summarize-channel-costs.py`
(1.68s under the guard). They reproduce all earlier diagnostic profiles and
100 code hashes. Fresh text falls from one retain/message to zero, with unchanged
allocations and peak charge; the four other cases' ordinary binaries are unchanged.
Actual fresh-text exchange frames fall from 216 to 40 bytes on AMD64 and 224 to
64 on ARM64, excluding callees. There is no elapsed-time or C/Rust comparison.
Documentation commit `ac4424a6` is published on the preparation branch with the new `docs/measurements/channel-direct-borrows.md`
report, its raw JSON and updated ownership/design/pipeline/benchmark explanations.
These measurements describe `ad3cd792`; reproduce them for the stricter
current implementation before finalizing the next PR. The next PR description is prepared in
`/private/tmp/fwp-direct-borrow-pr-body.md` and still needs final acceptance links. Keep the source stable while healthy
gates run; update this handoff locally as results arrive. No local build was run. Guarded repair formatting
passes (1.75s), and the documentation audit passes all 69 Markdown files after staging the new
report (2.38s).

Next: publish and validate the lifetime tightening; merge PR #179 only after
its exact-head gates pass. Record its accepted tree, rebase this preparation
onto the actual merge, finish the report/handoff and documentation audit, then
open the next single PR. A draft may precede the focused result; mark it ready
only when the measurements and final docs are included, to start production once.

## Roadmap status

All seven areas in [PLAN.md](../PLAN.md) remain open.

| Step | Status | Work |
|---|---|---|
| 1 | In progress | Ownership and GC removal |
| 2 | In progress | Functional overhead |
| 3 | In progress | Machine performance |
| 4 | In progress | Autodiff |
| 5 | In progress | Numerical kernels |
| 6 | In progress | Reproducible comparisons |
| 7 | In progress | Larger applications |

Persistent subscriptions, resource captures, resource-owning tail frames and
mutual recursion need proofs. Captured channels cannot be admitted from element
types alone: native callback channels retain hidden context, so provenance must
also be proved. Default native execution retains tracing. JIT is excluded.
Follow [AGENTS.md](../AGENTS.md).
