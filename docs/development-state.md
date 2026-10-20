# Session handoff

## Next action

Finish [PR #179](https://github.com/e6qu/fun-with-pipes/pull/179) as one combined
ownership delivery: matched payload moves plus caller-owned direct arguments.
Do not open a second PR for the prepared borrowing work.

The published PR head is `82bcf83f765e072afa6431cbf196532d433e3cad` on
`move-matched-variant-owners`, in `/Users/zardoz/projects/fun-with-pipes`.
All nine production jobs in `39417913864` finished: eight pass, but Windows AMD64
is **cancelled**, so this is not accepted. GitHub's annotation confirms its
90-minute limit expired during final job cleanup. Every test step, golden program,
standalone compiler build and artifact upload passed. Documentation `39417913929`
passes; all ten complete logs are audited in `/private/tmp/fwp-179-acceptance.json`.
Do not merge this head or treat the cancelled job as passing.

`/private/tmp/fwp-direct-borrows`, branch `borrow-direct-function-arguments`,
contains the combined code at `fe005a4995f7a2aeb0459798802adc34d2c38946`.
Focused run `39431240368` passes on both Linux hosts for that stricter source.
Both complete logs are audited, with no failure or panic, in
`/private/tmp/fwp-direct-borrow-lifetimes-audit.json`.
An additional local workflow edit gives Windows production 150 minutes, matching
the macOS production jobs. Local resource limits are unchanged. Three ownership targets are
also added permanently to Windows production: callback borrowing, channel cycles
and task cleanup. The normal production matrix now covers every broader native
target, and Linux retains the full WASI checks. Avoid another duplicate preflight
matrix; all nine final-head production jobs and documentation remain mandatory.

Next: finish the incidental compile-time handle repair and its runner checks,
then publish the combined PR. The interpreter accepted `comptime (file.open ...)`,
but C generation silently embedded zero. The prepared repair rejects runtime
handles, including nested containers/captures, and validates IR before native
generation. Ordinary compile-time file contents remain supported. Added tests
cover both execution modes, malformed IR and native O0/O2 execution after removing
the compilation input. This repair is not yet runner-verified; the pending
`fe005a49` run covers borrowing before this additional change. Dispatch
`numerics.yml`, suite `channel-costs`, for the repair commit; it includes all
new unit/integration checks and reproduces measurements on ARM64 and AMD64.

After the focused run passes, download its artifacts and reproduce the report
with `scripts/summarize-channel-costs.py`. Check counts, hashes, actual ELF code
and frames against the previous evidence. Preserve the measured source with a
tag. Update the report, PLAN, ownership notes and this handoff around the combined
scope. Commit the final docs and workflow fix. The preparation branch descends
from the current PR head, so fast-forward it into the PR branch without rebasing
or a merge commit. Save the root's local handoff before switching/cleaning it;
inspect both worktrees for other changes. Publish once with a clear combined PR
title/body and then keep that final head stable through its production gates.
The draft body `/private/tmp/fwp-direct-borrow-pr-body.md` still needs combined
scope and final evidence updates. Do not reuse the initial-head audit receipt for
the new head. Squash-merge only after exact-head acceptance, using one explicit
subject of at most 80 characters and an empty body; verify the resulting tree.

## Accepted baseline

The user merged PR #178 as `2ee0159b941d7887d70f5d86342cfad08e4e35c2`.
Its tree equals tested head `732984c3fb6b8646f6f3ee4932c123eadb7f3555`.
All nine production jobs `39397311012` and documentation `39397297724` pass;
all ten complete logs and the one-line merge message were verified. Receipt:
`/private/tmp/fwp-178-acceptance.json`. Only duplicate post-merge production
`39417022563` was cancelled; post-merge documentation passed.
[History](roadmap-history.md#direct-matches-and-callbacks-pr-178) preserves acceptance.

## Current change and evidence

Matched variants with one payload in local fields transfer that payload's owner
instead of retaining it and immediately dropping the variant. Boxed/multiple
payloads and protected resource slots keep their existing cleanup. The
[variant report](measurements/channel-variant-moves.md) records unchanged
allocations/peak charge and mixed binary sizes. Focused `39399972415` passes
21 checks per Linux host at `eecb4b5c11246e6b9223bd7eda84f7857daeef30`.
Broader `39402978160` passes 214 checks per Unix host, 215 per Windows host and
18 per WebAssembly host at `a59328d765adab49b2faead775f8237f0eec7b82`.
All logs, 180 profiles and 20 binaries are audited; both sources have immutable
`roadmap/revision-*` tags. Artifacts: `/private/tmp/fwp-variant-final-costs`.

Direct-call borrowing uses one inferred contract for call lowering, ownership
verification, entry ticks and cleanup. Every live caller must already need the
same counted values after the call; last-use inputs retain consuming conventions
so their storage is not prolonged. Flat records also need a nonescape proof;
scalar-only tuples keep their ordinary field convention. Original boxes remain
visible to tracing. Generic entries consume and release their inputs. Returns,
stores, function-value uses, recursion and resource scopes remain excluded.
Keeping channel owners also preserves destruction of hidden native sink context.
No new capture or cycle is admitted. The verifier additionally rejects a borrowed
argument whose owner is consumed while evaluating a later argument.

Earlier borrowing source `ad3cd792c079bac8d04bc1dcab69936eb62e97e5`, preserved by
`roadmap/revision-direct-borrows-ad3cd792`, passes focused `39423983460`: 185 checks
on each Linux host, none ignored or filtered. Both complete logs are audited in
`/private/tmp/fwp-direct-borrow-repair-audit.json`. Native probes cover independent
aliases, boxed entries, failure, cancellation at worker entry and a deliberately
leaked-owner control. A checked-ARC channel failure checks full reclamation at
O0/O1/O2, with stack placement enabled and disabled. The initial two fixture
failures (constant type context and missing generated unwind support) were fully
reviewed and repaired together. Broader `39424662531` passes 231 checks each on
ARM macOS and Linux ARM64, plus 18 ARM WebAssembly checks. The five remaining
jobs were cancelled because the stricter source supersedes it. Every completed
log is audited in `/private/tmp/fwp-direct-borrow-proof-audit.json`; cancelled
logs contain only the requested cancellation error, no test failure. These partial
checks are not acceptance of the stricter source.

The preparation branch's `docs/measurements/channel-direct-borrows.md` and raw
JSON currently describe `ad3cd792`, not final acceptance of `fe005a49`.
Its 180 profiles and all 100 code hashes were reproduced by the passing run:
fresh-text retains fall from one/message to zero, allocations/peak charge stay
unchanged, and the other four programs' ordinary binaries are byte-identical.
Fresh-text exchange frames fall from 216 to 40 bytes on AMD64 and 224 to 64 on
ARM64, excluding callees. No timing or C/Rust comparison was made. Reproduce
these results for the stricter source before final publication. Passing artifacts:
`/private/tmp/fwp-direct-borrow-final-costs`; comparison helpers:
`/private/tmp/fwp-compare-borrow-costs.py`, `/private/tmp/fwp-inspect-borrow-symbols.py`.
The latter still points to the earlier diagnostic download; use passing artifacts.

## Local checks and limits

No local build was run. Guarded `cargo fmt --all` passes (1.57s);
`python3 scripts/check-roadmap.py` passes 69 Markdown files, 106 immutable anchors
and seven roadmap steps (2.77s). The six new compile-time fixture expressions
were accepted by an existing diagnostic compiler using `--emit-c` (5.19s);
this confirms syntax only, not the new rejection. Use
`python3 scripts/local-guard.py COMMAND...`;
from the preparation worktree, use its absolute path in the main checkout.
Keep checks serial. Full builds, suites and measurements belong on runners.
Preserve 64 GiB free disk, target data below 2 GiB and sampled aggregate RSS below
1 GiB; do not increase local limits. The latest disk check had about 70 GiB free.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish repeatable equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger maintained programs and bounded live memory. |

All seven areas in [PLAN.md](../PLAN.md) remain open: GC removal, functional and
machine overhead, autodiff, numerical kernels, dependable comparisons and larger
programs. Default native execution still includes tracing. Persistent
subscriptions, resource captures, resource-owning tail frames and mutual recursion
need further proofs. Captured-channel eligibility needs provenance as well as
payload types. JIT is excluded. Follow [AGENTS.md](../AGENTS.md).
