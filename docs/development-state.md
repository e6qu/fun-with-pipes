# Session handoff

## Next action

Next: finish [PR #179](https://github.com/e6qu/fun-with-pipes/pull/179), then deliver the
combined preparation below. Keep one active PR. All seven roadmap areas remain
open; default native execution still includes tracing GC.

PR #179's final head is `63a129f25cfb9a3b940baf7786036265bfdf831d` on
`move-matched-variant-owners`. Production run `39438167856` and docs
`39438167895` must pass for that exact source. Documentation, benchmarks, Linux
ARM64, both ARM64 macOS gates and both Windows gates pass; their complete logs
are clean. Linux AMD64 and the two Intel macOS gates remain running without
reported failures. The PR is still open; keep its head stable.

Audit with `python3 scripts/local-guard.py python3 /private/tmp/fwp-audit-179-combined.py`.
Receipt: `/private/tmp/fwp-179-combined-acceptance.json`. Merge only when it says
`EXACT HEAD ACCEPTED: True`: all nine production jobs and docs, with logs checked.
Use squash merge, an explicit subject of at most 80 characters and an empty body;
verify the merged tree and one-line message. No trailers or attribution. Cancel
only redundant postmerge CI for the identical accepted tree.

## Current delivery: PR #179

The changes move matched variant payloads, borrow eligible direct-call arguments,
and reject compile-time runtime handles that previously became zero in native C.
The caller must need the same counted storage after a borrowed call. Generic
entries still consume arguments. Resource scopes, recursion and escapes remain
excluded; cleanup preserves failure, cancellation and observable lifetimes.
Windows permanently includes the additional ownership checks and allows 150
minutes, matching macOS. Its superseded 90-minute run finished tests but timed
out during cleanup; that earlier head is not accepted.

Compiler/test source `f3e05d27c8f0610f9614b1421f2c7dbedb89c16c` is preserved by
`roadmap/revision-direct-borrows-f3e05d27`. Final head only adds reports/docs.
Focused run `39436111385` passes 189 checks per Linux host; all logs are clean.
Receipt: `/private/tmp/fwp-direct-borrow-final-audit.json`. See the
[borrowing report](measurements/channel-direct-borrows.md) and
[matched-payload report](measurements/channel-variant-moves.md) for methods,
source revisions, allocation counts and inspected machine code.

## Next combined preparation

Worktree: `/private/tmp/fwp-direct-borrows`. Branch:
`borrow-function-channel-handles`, based on PR #179's final head. Measured compiler/test
source: `37de5ba40970f7729bf735b347527f5628117dc0`.
Focused `scalar-text` run `39446896772` passes on both Linux architectures:
205 tests per host, clean complete logs. Receipt `/private/tmp/fwp-scalar-text-audit.json`.
The code is tagged `roadmap/revision-scalar-text-37de5ba4` on the remote.
Artifacts: `/private/tmp/fwp-scalar-text-costs`. Both reports are audited:
`docs/measurements/integer-text-2026-10-20.json` and
`docs/measurements/function-channel-borrows-2026-10-20.json` in preparation.
All 100 channel C/binary/disassembly files and profiles match the earlier d8 proof.

Next independent action: publish the report/profiler changes and dispatch
`numerics.yml` with `suite=scalar-text-memory`, `evidence_run=39446896772`,
`source_revision=37de5ba40970f7729bf735b347527f5628117dc0`.
This profiles the actual saved C/Rust/fwp binaries with GNU time and separate
managed-allocation probes; it does not repeat the compiler suite. Record both
complete logs and memory artifacts before finishing the report. The profiler
is `scripts/measure-scalar-text-memory.py`; its syntax and instrumentation match
both real C artifacts under the guard (0.13s). Native execution is pending.

This batch contains:

- **Borrow function-channel handles.** A continuing owner keeps the whole queue
  and native sink context alive. Payload capture, cycle and scope checks remain
  unchanged. Tests cover generic entries, aliases, native-context destruction,
  failed queued calls and a deliberately leaked-owner control.
- **Count integer text without building it.** `show | string.length` and eligible
  concatenations count characters directly for integers up to 64 bits. The pass
  preserves effects, traps, Unicode character counts and shared strings. New
  native checks compare raw interpreter results and count leaf allocations with
  an intentionally allocating control; 12 test binaries are retained for inspection.
- **Compare equivalent calculations.** The new `text-length` benchmark uses the
  same fwp program as `strings`, but C/Rust count digits directly and check
  multiplication/sums. Existing `strings` peers still format text. The focused
  suite runs all seven complete-program comparisons with GCC on both hosts.
  The measured direct-counting gap is +8.9% versus C on AMD64 and +3.6% on ARM64;
  fwp takes less time than these Rust peers. Raw samples and limits are in
  `docs/measurements/integer-text.md`. Separate memory profiling is pending.

An incorrect arithmetic primitive name was caught by IR inspection and fixed
to `prim.add` before these passing runs. All semantic/allocation controls pass.
The timed fwp loops use registers without calls or stack traffic in normal
iterations. The two text comparisons have identical generated C and executable
code sections; whole-file hashes differ. No old-fwp timing speedup is claimed.

The channel-only source `d8c62e175aa0beab727bb15960718f0bfca9ec53` is already
verified by focused run `39440052683`: 199 passing checks per host, clean logs.
It is tagged `roadmap/revision-function-channel-borrows-d8c62e17`. All 180 profiles
and 20 binaries are audited in `/private/tmp/fwp-function-channel-counts.json`;
artifacts: `/private/tmp/fwp-function-channel-costs`. Fresh-function retains fall
from one/message to zero, with unchanged allocations and peak charged storage.
ARC exchange frames shrink from 248 to 56 bytes on AMD64 and 256 to 80 on ARM64,
excluding callees (AMD64 also excludes the return address). Other cases retain
their costs. No elapsed-time claim. The closed-channel loop still creates an
owned alias after inlining; this direct-call change does not eliminate it.

Compare with `/private/tmp/fwp-direct-borrow-accepted-costs` and the checked-in
[baseline JSON](measurements/channel-direct-borrow-counts-2026-10-20.json).
`/private/tmp/fwp-compare-channel-stages.py` requires explicit current/baseline
report and artifact paths. The source/report validator is
`scripts/summarize-channel-costs.py`.

After #179 merges, preserve measured preparation heads with remote revision
tags. Transplant only commits after `63a129f2` onto the accepted merge, update
reports/plan and open the next substantial PR. Require its own exact-head nine
production gates and docs. Root has only the live handoff edit. Preparation
adds report/docs updates, `scripts/summarize-scalar-text.py`, the
memory profiler and its focused workflow. The report audit passes both ELF
architectures, source inputs, timings, 24 saved test binaries and the frozen
contract inventory (1.95s). The channel report audits 180 profiles/20 binaries
(1.68s). Do not change PR #179's healthy head for these preparation updates.

## Accepted baseline and local checks

PR #178 merged as `2ee0159b941d7887d70f5d86342cfad08e4e35c2`, identical in tree
to tested `732984c3fb6b8646f6f3ee4932c123eadb7f3555`. Its nine production gates,
docs and one-line message were audited; receipt `/private/tmp/fwp-178-acceptance.json`.
See [history](roadmap-history.md#direct-matches-and-callbacks-pr-178).

No local build or full suite. Serial guarded checks pass: `cargo fmt --all`
(1.64s), `python3 scripts/check-roadmap.py` (3.11s), and
`python3 /private/tmp/fwp-validate-text-length-fixtures.py` (12.43s). Run these
through `python3 scripts/local-guard.py COMMAND...`; use the guard's absolute
path from the preparation worktree. Last observed: about 69 GiB free, root target
4 KiB, no preparation target. Preserve 64 GiB free disk, target data below 2 GiB,
aggregate RSS below 1 GiB and the 180-second deadline. Full work runs on GitHub.

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

Persistent subscriptions, resource captures, resource-owning tail frames and
mutual recursion need further proofs. Captured-channel eligibility needs
provenance as well as payload types. JIT is excluded. Follow [PLAN.md](../PLAN.md)
and [AGENTS.md](../AGENTS.md); completed batches do not complete the roadmap.
