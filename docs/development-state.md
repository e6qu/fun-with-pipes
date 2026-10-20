# Session handoff

## Next action

Next: publish the corrected compile-time regression test on
`borrow-direct-function-arguments`, then run `numerics.yml` with
`suite=channel-costs`. Audit both complete logs and fix every failure before
publishing the combined [PR #179](https://github.com/e6qu/fun-with-pipes/pull/179).
Keep the borrowing work in this PR; do not open another delivery PR.

Preparation worktree: `/private/tmp/fwp-direct-borrows`. Its code repair is
`d5f9c0aad6f4d52a28323f32ac282570b266bd84`; the current edit corrects one test's
expected output because `print` adds a newline. Run `39434495223` failed only
that assertion on both hosts. All other unit/integration checks and measurements
passed; both full logs were audited in
`/private/tmp/fwp-direct-borrow-constants-audit.json`. The positive test stopped
before native execution, so that part still needs passing runner evidence.

The published PR remains at `82bcf83f765e072afa6431cbf196532d433e3cad`, branch
`move-matched-variant-owners`, in `/Users/zardoz/projects/fun-with-pipes`.
Eight production jobs in `39417913864` pass; Windows AMD64 is **cancelled**.
Its 90-minute limit expired during cleanup after every test/build/upload step
passed. Documentation `39417913929` passes. All ten logs were audited in
`/private/tmp/fwp-179-acceptance.json`; this is not acceptance. The preparation
branch gives Windows 150 minutes, matching macOS, and adds the callback-borrow,
channel-cycle and task-ownership targets to permanent Windows coverage.

After the focused run passes, download its artifacts and run
`scripts/summarize-channel-costs.py` with the exact run/source. Reproduce counts,
hashes, actual code and frames; preserve the source with a `roadmap/revision-*`
tag. Update the report and this handoff, then commit the final docs. The prepared
branch descends from the PR head: fast-forward it into the PR branch without a
rebase or merge commit. Preserve the root's local handoff before switching;
inspect both worktrees for other changes. Publish once and keep the final head
stable through nine production gates and documentation. Rewrite the PR title/body
from `/private/tmp/fwp-direct-borrow-pr-body.md`, replacing its pending validation
paragraph. Squash-merge only after exact-head acceptance, using an explicit
one-line subject of at most 80 characters and an empty body; verify the tree.
Do not reuse the old acceptance receipt for the new head.

## Changes and measured evidence

Single-payload matches transfer the payload owner instead of retaining it and
dropping its wrapper. Direct-call borrowing lets callers keep eligible arguments
alive through success, failure and cancellation. Every live caller must need the
same counted storage after the call; last-use inputs stay consuming. Flat records
also need a nonescape proof. Generic entries consume their inputs; original boxes
remain visible to tracing. Resource scopes, recursion, escapes and unknown calls
remain excluded. The verifier catches later arguments consuming an earlier
borrow's owner. No new capture or cycle is admitted.

The incidental `comptime` repair rejects runtime handles, including nested
containers/captures. Previously an open file worked in the interpreter but became
zero in generated C. File contents remain ordinary embeddable data. Tests check
both execution modes, malformed IR, and O0/O2 execution after removing the input.

[Variant measurements](measurements/channel-variant-moves.md) use `eecb4b5c`,
focused run `39399972415` (21 checks/host). Broader run `39402978160` at
`a59328d7` passes 214 checks/Unix host, 215/Windows host and 18/WebAssembly host.
Those sources have immutable tags; artifacts are `/private/tmp/fwp-variant-final-costs`.

[Borrowing measurements](measurements/channel-direct-borrows.md) currently describe
`ad3cd792`, focused run `39423983460`: 185 checks/host. The stricter lifetime
source `fe005a4995f7a2aeb0459798802adc34d2c38946` passes run `39431240368` with
185 checks/host and reproduces all 180 profiles and 100 code hashes. Fresh-text
retains fall from one/message to zero; allocations and peak charge are unchanged.
Its exchange frames shrink from 216 to 40 bytes on AMD64 and 224 to 64 on ARM64,
excluding callees. Other programs keep their costs. No timing or C/Rust claim.
Update the report to the repaired source only after its run passes.

Passing stricter-source artifacts: `/private/tmp/fwp-direct-borrow-lifetimes-costs`;
summary: `/private/tmp/fwp-direct-borrow-lifetimes-counts.json`; full-log receipt:
`/private/tmp/fwp-direct-borrow-lifetimes-audit.json`. Comparison helpers are
`/private/tmp/fwp-compare-borrow-costs.py`, `fwp-compare-borrow-artifacts.py` and
`fwp-inspect-borrow-symbols.py` in the same directory; pass explicit artifact paths.
The older partial broader run is superseded, not final acceptance. The normal
production matrix now includes its native targets and Linux's full WASI checks.

## Accepted baseline

PR #178 merged as `2ee0159b941d7887d70f5d86342cfad08e4e35c2`, with the same tree
as tested head `732984c3fb6b8646f6f3ee4932c123eadb7f3555`. All nine production
jobs `39397311012` and docs `39397297724` pass; all logs and the one-line merge
message were verified. Receipt: `/private/tmp/fwp-178-acceptance.json`.
Only its duplicate post-merge production run was cancelled. See
[accepted history](roadmap-history.md#direct-matches-and-callbacks-pr-178).

## Local checks and limits

No local build or full suite. Guarded `cargo fmt --all` passes (1.57s);
`python3 scripts/check-roadmap.py` passes 69 docs, 106 anchors and seven roadmap
steps (2.77s, before this handoff rewrite). Six new fixture expressions pass
`--emit-c` with an existing diagnostic compiler (5.19s): syntax evidence only.
The passing stricter-source report and hashes were reproduced under the guard.
Use `python3 scripts/local-guard.py COMMAND...`, with its absolute path in the
main checkout when working in preparation. Keep checks serial. Preserve 64 GiB
free disk, target data below 2 GiB, sampled RSS below 1 GiB and the 180-second
limit. Last observed: about 70 GiB free, root target 4 KiB, no preparation target.
Full builds, suites and measurements belong on runners; never raise local limits.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |

All seven [work areas](../PLAN.md) remain open. Default native execution still
includes tracing. Persistent subscriptions, resource captures, resource-owning
tail frames and mutual recursion need further proofs. Captured-channel eligibility
needs provenance as well as payload types. JIT is excluded. Follow [AGENTS.md](../AGENTS.md).
