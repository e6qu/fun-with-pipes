# Session handoff

## Next action

Next: finish [PR #179](https://github.com/e6qu/fun-with-pipes/pull/179), containing
matched payload moves, direct-call borrowing and compile-time handle rejection.
All focused checks and measurements pass. Published head
`63a129f25cfb9a3b940baf7786036265bfdf831d` is on `move-matched-variant-owners`.
Audit production `39438167856` and documentation `39438167895` with
`/private/tmp/fwp-audit-179-combined.py`; its receipt is
`/private/tmp/fwp-179-combined-acceptance.json`. Documentation, benchmarks and both ARM64 macOS gates pass; their complete logs are clean.
Six production jobs remain running, without reported failures.
All **nine production jobs and docs** must pass.
Keep the final head stable. Fix every failure; only squash-merge after exact-head
acceptance, with an explicit one-line subject of at most 80 characters and an
empty body. Verify the merged tree. Do not open a second PR for this preparation.

The measured compiler/test source is `f3e05d27c8f0610f9614b1421f2c7dbedb89c16c`,
preserved by `roadmap/revision-direct-borrows-f3e05d27`. Final head `63a129f2`
only adds docs/report updates. Root branch: `move-matched-variant-owners`.
Its previous local handoff is backed up at
`/private/tmp/fwp-root-handoff-before-combined-179.md`. This live handoff is the
only local root edit; do not publish a documentation-only change during CI.
Use `gh pr view 179 --json headRefOid` and `gh pr checks 179` to confirm status.
The published PR title/body cover the complete change.

## Independent preparation while CI runs

`/private/tmp/fwp-direct-borrows` now uses `borrow-function-channel-handles`,
branched from the final PR head. It investigates the remaining fresh-function
and closed-function channel retain. A continuing owner keeps the channel and
its queued values/native sink context alive regardless of payload representation.
The proposed rule therefore borrows such handles while leaving ARC's capture,
cycle and scope checks unchanged. Resource scopes and last-use inputs remain
excluded. This is preparation, not accepted support or part of PR #179.

Function-channel source `d8c62e175aa0beab727bb15960718f0bfca9ec53` passes
focused run `39440052683` on Linux ARM64/AMD64: 199 checks per host. Complete
logs are clean; receipt `/private/tmp/fwp-function-channel-borrow-audit.json`.
The native sink-context destruction probe covers aliases, consuming generic
entries and a leaked-owner control. Tests also cover ARC failure after applying
a queued function and existing capture, cycle and scope restrictions.
All 180 profiles and 20 binaries are audited in
`/private/tmp/fwp-function-channel-counts.json`; artifacts are in
`/private/tmp/fwp-function-channel-costs`. Fresh-function retains fall from
one/message to zero; allocation counts and peak charge stay unchanged. Other
cases retain their costs. ARC exchange frames shrink from 248 to 56 bytes on
AMD64 and 256 to 80 on ARM64, excluding callees (AMD64 also excludes the return
address). No timing claim. Preserve this source with
`roadmap/revision-function-channel-borrows-d8c62e17`.

The same preparation now removes temporary integer text whose only consumer is
`string.length`, including concatenations with literals. Real PR #179 benchmark
binaries still build two integer strings and two concatenations per string-loop
iteration; all six benchmark binaries match #178 exactly. New tests compare raw
interpreter/native results, effects, traps, Unicode, widths and shared strings,
and count leaf allocations with an intentionally allocating negative control.
Native checks are pending. The new pass is `src/cgen/scalar_text.rs`; full integer
output tests and the frozen primitive inventory are included in `channel-costs`.
The existing diagnostic interpreter accepts every new fixture, including the
failure order; guarded command
`python3 scripts/local-guard.py python3 /private/tmp/fwp-validate-text-length-fixtures.py`
passes (12.43s). It emits C but does not compile it. No local build or full suite.
IR inspection caught an incorrect new `add` primitive name; it is repaired to
`prim.add`. Superseded run `39445706902` at `a428f962` was cancelled while both
jobs were still queued (no executed steps, no acceptance claim). The replacement
`scalar-text` suite also saves 12 semantic/allocation-check binaries and runs the
complete C/Rust benchmark comparison on GCC for both Linux architectures.
The new `text-length` benchmark uses direct digit counting in C/Rust with checked
multiplication and sums. It complements `strings`, whose peers still format text.
Next: publish the corrected preparation, run `scalar-text`, audit all failures,
inspect its binaries and record measured costs. No timing result is claimed yet.
`/private/tmp/fwp-compare-channel-stages.py` takes explicit current/baseline
reports and artifact directories. Do not infer elapsed-time gains from counts.
Do not open a new PR until #179 is accepted and merged. Preserve measured source
with a tag; after the squash, transplant only commits after `63a129f2` onto the
merged tree, then require a new final-head production matrix for that delivery.

The previous PR head `82bcf83f765e072afa6431cbf196532d433e3cad` is **not accepted**:
eight production jobs in `39417913864` pass, but Windows AMD64 timed out during
cleanup at 90 minutes. Every test/build/upload step passed. Documentation
`39417913929` passes; all ten logs are audited in `/private/tmp/fwp-179-acceptance.json`.
Do not reuse that receipt for this combined head. Windows now allows 150 minutes,
matching macOS, and permanently includes callback-borrow, channel-cycle and task
ownership tests. Local limits are unchanged.

## Changes and verification

Single-payload matches transfer the payload owner instead of retaining it and
dropping its wrapper. Direct-call borrowing lets callers keep eligible arguments
alive through success, failure and cancellation. Every live caller must need the
same counted storage after the call; last-use inputs stay consuming. Flat records
also need a nonescape proof. Generic entries consume their inputs; original boxes
remain visible to tracing. Resource scopes, recursion, escapes and unknown calls
remain excluded. Later arguments cannot consume an earlier borrow's owner.
No new capture or cycle is admitted.

`comptime` now rejects runtime handles, including nested containers/captures.
Previously an open file worked in the interpreter but became zero in generated C.
File contents remain ordinary embeddable data. Tests cover both execution modes,
malformed IR, and O0/O2 execution after removing the compilation input. An initial
expected-output error omitted `print`'s newline; both failed logs were audited
and the correction passes. No unresolved focused failure remains.

[Focused run 39436111385](https://github.com/e6qu/fun-with-pipes/actions/runs/39436111385)
passes 189 checks per Linux host: 154 unit tests, 34 integration checks and one
measurement test, none ignored or filtered. Both complete logs are audited in
`/private/tmp/fwp-direct-borrow-final-audit.json`. Tests include aliases, boxed
generic entries, GC stress, reuse poisoning, failure, cancellation, deliberate
leak controls and complete ARC reclamation at O0/O1/O2 with stack placement on/off.

The [borrowing report](measurements/channel-direct-borrows.md) and raw JSON now
use that exact source. All 180 profiles and 20 ordinary binaries are audited.
All 100 generated-C/binary/disassembly hashes match the earlier passing proof.
Fresh-text retains fall from one/message to zero after the matched-payload move;
allocations and peak charge are unchanged. Exchange frames shrink from 216 to
40 bytes on AMD64 and 224 to 64 on ARM64, excluding callees. Other programs keep
their costs. No timing or C/Rust claim. Passing artifacts:
`/private/tmp/fwp-direct-borrow-accepted-costs`. Comparison helpers in `/private/tmp`:
`fwp-compare-borrow-costs.py`, `fwp-compare-borrow-artifacts.py` and
`fwp-inspect-borrow-symbols.py`; supply explicit artifact/report paths.

[Variant evidence](measurements/channel-variant-moves.md) uses tagged sources
`eecb4b5c` (21 focused checks/host) and `a59328d7` (214 checks/Unix host,
215/Windows host and 18/WebAssembly host). The normal production matrix includes
that broader native coverage and Linux's full WASI checks. Older partial matrices
are superseded; they do not establish acceptance of this final source.

## Accepted baseline

PR #178 merged as `2ee0159b941d7887d70f5d86342cfad08e4e35c2`, with the same tree
as tested head `732984c3fb6b8646f6f3ee4932c123eadb7f3555`. Nine production jobs
`39397311012` and docs `39397297724` pass; all logs and the one-line message were
verified. Receipt: `/private/tmp/fwp-178-acceptance.json`. Only its duplicate
post-merge production run was cancelled. See [history](roadmap-history.md#direct-matches-and-callbacks-pr-178).

## Local checks and limits

No local build or full suite. Guarded formatting passes (1.46s); the documentation
check passes 69 docs, 106 anchors and seven roadmap steps (3.31s).
The final measurement report and all code hashes were reproduced under the guard.
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
