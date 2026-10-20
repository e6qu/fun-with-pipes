# Session handoff

## Next action

Next: finish [PR #179](https://github.com/e6qu/fun-with-pipes/pull/179) on
`move-matched-variant-owners`, head `82bcf83f765e072afa6431cbf196532d433e3cad`.
Production `39417913864` has a passing benchmark job; the native jobs are starting
on their runners. Documentation `39417913929` passes. Audit every completed log
with `/private/tmp/fwp-audit-179.py`; fix every failure before squash merge.
Require all nine production jobs and documentation on this exact head. Use an
explicit one-line subject of at most 80 characters and empty body, then verify
the merge tree. Worktree: `/private/tmp/fwp-variant-moves`.
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
contains the next implementation; no second PR is open. It is not yet verified.
The compiler infers caller-owned parameters for eligible nonrecursive direct
workers. One contract drives call lowering, callee ownership, verification,
entry ticks and failure cleanup. Borrowed flat records need an independent
nonescape proof; field views keep their original boxes visible to tracing.
The existing generic entries still consume their arguments and release them
on success/failure. Functions used as values, exports, resource scopes, recursive
functions and workers without a supported representation retain owned arguments.
Plain-data eligibility reuses the tail-recursion type proof. Channels additionally
require every caller to keep that exact channel after the call; using another
tuple field is insufficient. This preserves native sink-context destruction
timing and does not admit new captures or channel cycles.

New unit cases cover read-only fields, transitive direct calls, escaping values,
function values, recursion and the distinction between borrowing and nonescape.
A native probe checks exact counts at O0/O2, caller failure, independent aliases,
generic boxed entries and a deliberately leaked-owner control. The ownership
checker now rejects a borrowed argument whose owner was consumed by a later
argument. Formatting passes under the guard (1.57s); the documentation audit passes
(2.50s), and formatting after the channel proof passes (1.47s). No local build
was run. Initial run `39420410381` was cancelled while both jobs were still queued,
before compilation; it supplies no evidence. Validation and channel counts will run in
`channel-costs`; review all
steps and generated binaries before any performance claim or next PR.

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
