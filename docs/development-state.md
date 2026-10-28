# Current work

**Next:** implement F1–F3 together: a finite functional-call cost matrix,
weak-handle self-tail reuse with cleanup controls, and a measured mutual-recursion
prototype. Carry the pending analysis evidence and stale-comment fix into this
next PR. Postmerge docs `40691814677`, the benchmark and both macOS ownership jobs
pass. Both ownership logs have 125 successful targets and no compiler diagnostics;
the benchmark log is also audited. Six jobs of `40691815018` remain running with
no failed steps at the latest check. Roll failures into this batch; A6 acceptance is pending.

The active worktree remains `/private/tmp/fwp-parser-workspace`, now on branch
`functional-calls-and-tail-loops`, based on merged #221
`ef037415f401cdf9ed44c7deffe735edfa99e0cd`. The grouped delivery is
[draft PR #222](https://github.com/e6qu/fun-with-pipes/pull/222).
The user merged #221 before the final production matrix. The merge tree
`531fcffc2796aed8fb8b06b00145dddf2e7309d9` exactly matches focused-tested head
`50dd674aa7f764d9e2a0ef75dbc736ace3e4f9c1`. Its message is one 49-character line,
without a body or trailers. Merge is not full acceptance.

F1 reuses existing callback, closure, `each` and call-liveness tests, adding only
missing executed dispatch/allocation observations and escaping/unknown controls.
F2 admits metadata-only WeakChannel handles before traversing phantom payloads;
strong owners, unknown captures, resource regions and debugger frames stay out.
F3 compares a restricted tagged loop with mutual calls and an explicit source
loop, at O0/O2, before accepting or rejecting the optimization. Preparation and
existing-test pointers are in `/private/tmp/fwp-next-functional-notes.md`.

F2 implementation admits weak metadata in `tailrec::plain_data` and
tests its shared borrowed-parameter caller contract. Deep weak swaps, aliases,
callback payloads, argument failure and cancellation have fixtures. Native tail
tests now sample executed loop-frame addresses at O0/O2 and include a deliberately
bad-stack observer control. F3's scalar-pair prototype lives in
`src/tailrec/pairs.rs`; it preserves separate entries and ordinary non-tail calls.
Unit controls cover both entries, renamed pattern locals, deep parity, repeated
pass execution and rejection of resources, debug frames and dynamic calls.
First focused run `40696627458` at `8787b42d` failed compilation on both hosts:
seven diagnostics all came from using the IR's u32 arity as a usize vector index
in the new pair pass. Both full logs are saved in
`/private/tmp/fwp-222-8787-failed.log`; no tests ran. The repair converts once at
the indexing boundary and checks the combined frame's arity/local limits.
F1 now has eight executable fixture pairs in `tests/fixtures/functional_costs.fwp`
and an observer in the existing call-liveness target. It measures allocations,
bytes, runtime application requests, boxes and effective retains inside actual
exported calls at two input sizes and O0/O2. No timing claim follows from counts.
F3 emits ordinary/grouped versions of identical typed IR and an explicit fwp loop.
Its runner script freezes timing, allocation, code-size and stack budgets before
measurement and retains every sample. A failed budget requires an explicit
rejection or repair, not an acceptance claim. These additions await validation.
The new `functional-calls` focused workflow uses production GCC on Linux ARM64
and AMD64; full final-head gates run after the implementation batch is ready.

The grouped second head `8b0fc929b92604898bd1078275f55c65fb435d67` has focused
run `40699575855` and docs `40699544670` queued. Before they started, source review
found short C calls in the F1 probe to curried entries. Native entries need full
arity: the repaired probe uses the runtime's owned partial-application constructor
for scalar/unit captures and asserts arities. The probe also calls the normal
root-completion operation before its live-storage check, releasing State scratch
while keeping its allocation inside the measured call. No language wrapper is added.
The next push also adds tested measurement decisions (four guarded Python tests
pass), retains successful compiler diagnostics, and preserves F1 artifacts through
the existing ARC evidence setting on every production host. No measured result yet.
After publishing, supersede the queued old head with one focused run of the batch.

[The parser contract](parser-workspace.md), [parser measurements](measurements/parser-workspace.md)
and [analysis report](measurements/ownership-analysis.md) own the A6 evidence.

## Passing focused checks

- Compiler source `50dd674aa7f764d9e2a0ef75dbc736ace3e4f9c1` passes G2 run
  `40685939711` on Linux AMD64 and Intel macOS: 212 units, all-target Clippy,
  unchanged size/time/ratio limits and exact facts against the test-only full scan.
  All logs are audited. Docs `40685831377` passes, including evidence-rejection,
  native-shard coverage and failure-propagation controls; its log is audited too.
- At 64 workers, separate/merged analysis ratios are 1.449 on Linux and 1.374 on
  Intel macOS, below 1.5. Small fixtures need nine waves, below 16. Forms/entry
  analysis is 0.304/0.249 seconds on Linux and 1.586/0.651 on Intel, below 10 each.
  Facts are identical; forms visits fall from 591,732 to 14,454 and entry visits
  from 379,958 to 12,791. These timings are not a paired cross-revision speed ratio.
- The proof queues changed inputs and readers of changed outputs, captures,
  callbacks, channel payloads, task results, State and errors. Service boundaries
  participate. Later readers run in the current ordered wave; earlier/self reads
  wait for the next. Validation must add no facts. Both function-ID orders of a
  128-call chain compare facts, waves and visits with the full scan.
- Origins use the IR's existing u32 arity range with checked conversion: 40 bytes
  instead of 48 on both G2 hosts. Saturated calls register capture reads once.
  Preserve all lifetime rules, closure identities and budgets. The
  [attempt record](measurements/ownership-worklist-2026-10-28.json) retains the
  original timeout, 19-wave failure, 1.5204 ratio failure and passing repair.

## Parser evidence and limits

Parser representation/runtime source is `ca56023eb362259cf2099c9c9d477b20b3cf6793`.
Linux ARM64/AMD64 run `40650396700` passes 211 units, six allocator tests, six
parser tests, two record tests, Clippy and actual WASI O1/O2 checks. All logs and
26 native/WASI probes per host passed independent output, cleanup, deliberate
mutation and actual-binary architecture audits.

Measurement source `35250b3a5ecdaa8f3e02ddb7af9664c84068f186` passes two sessions
per architecture: AMD64 `40656341807`, ARM64 `40657569359`. All four artifacts
passed independent sample, budget, allocation, binary-size, stack and compiler-
scale audits. Keep earlier failed controls; no threshold was relaxed. These
measurements retain their source IDs; the later proof repair has separate G2 data.

The fixed parser cases take 18–28% less time than previous fwp, still 5.7–9.4× C
and 5.2–8.6× Rust. The peers borrow tokens; fwp owns them. Allocations decrease,
but allocated slot bytes rise 4–14%; peak live slots match previous fwp. One call
owns aligned blocks; integer/link nodes need no counts. Strings/tokens retain
ordinary owners. Escaping/cached trees, unknown/captured uses, managed fields
and self-tail roots remain outside this optimization. This is one workspace,
not general regions or C/Rust parity.

The benchmark consumes its own quoted text format. It is not fwp source syntax:
fwp uses infix arithmetic such as `2 + 3 * 4`. PR wording, guides and fixture
comments now make that distinction explicit. Grammar and calculations did not
change. A stale GC-stress comment now refers to ownership checks.

## Completed old-run audit and repairs

Every job and target of production run `40659395283` at `dbf1c0ba` was audited:

- Each regular macOS shard: 131 targets, 608 tests; each ownership shard: 125/353.
- Each Windows host: 150 retained targets, 408 tests, plus direct unit/library,
  SDK, protocol, golden and package checks in the complete job logs.
- Linux ARM64: 256 targets, 966 tests. Linux AMD64: 965 tests passed; only the
  TLS stream snapshot failed. Both passed all six parser and 21 WASI tests.

Four Clippy jobs failed only on a test helper borrowing a mutable `usize::MAX`
temporary. The helper now uses a local budget. All four intermediate Clippy jobs
pass at `45f9e810`; focused linting now includes all test targets. CI uploads
failed compiler diagnostics before long tests finish.

Ubuntu OpenSSL reported `record layer failure` rather than `wrong version number`
for the deliberately plain-text TLS peer. The snapshot accepts those two reasons
only on the complete expected client line. Other errors and success remain distinct;
production TLS is unchanged. Actual extracted snapshot code at Rust O1 replays
the entire CI failure and passes rejection controls; the old code fails both.
Full interpreter/native TLS execution still needs the final matrix.

All 20 saved parser probes per macOS/Windows architecture passed independent
output, failure-code, physical-storage and Mach-O/PE audits. The retained ARM
crash is the expected `cleanup_panic_aborts_before_borrowed_tasks_escape` control,
confirmed by source stack and passing unit test. The separate original intermittent
Intel compiler abort remains unexplained; preserve and investigate its source/input
if it recurs. Do not resume disassembly-led allocator experiments.

This PR also fixes disk-dependent guard tests and mismatched Linux WASI tools.
Production resource limits are unchanged; WASI pins matching LLVM/Clang 18 tools.
Old production `40674858299`, `40676851764` and queued docs `40676851675` were
cancelled. Draft CI skips and superseded runs are not acceptance gates.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | In progress | A6 final platform acceptance |
| 3 | In progress | F1–F3 functional calls and recursion |
| 4 | Pending | Close measured CPU performance gaps |
| 5 | Pending | Derivative storage, timing and precision |
| 6 | Pending | CPU numerical kernels |
| 7 | In progress | Fixed comparison budgets and complete evidence |
| 8 | Pending | Larger-program correctness, cleanup and scale |

## Local checks and recovery

Guarded fmt, actionlint, roadmap audit and diff checks pass. No full local build,
suite or benchmark ran. The independent worklist-record audit passes all 48
sample sets, 16 REST observations, failed-attempt checks and unchanged final facts:
`python3 scripts/local-guard.py python3 /private/tmp/audit-fwp-worklist-record.py`.
Local probes use Rust O1 with assertions/overflow checks:
`python3 scripts/local-guard.py python3 /private/tmp/check-fwp-origin-layout.py`;
TLS replay used `/private/tmp/check-fwp-tls-snapshot.py` before its control revision
became HEAD. Pin that script's old control to `45f9e810` before reusing it.

Artifacts: `/private/tmp/fwp-221-50dd-analysis`, `fwp-221-35250-measurements`,
`fwp-221-dbf1-{macos,windows}-{arm,amd}-parser`, and the retained `dbf1` full/target
logs. Earlier parser evidence is in `fwp-221-{a55,ec36,ca560,a51}-measurements`;
earlier proof attempts are in `fwp-221-{45f9,ba383,dd91}-analysis`. Do not delete
failed evidence. Preparation for the next group is `/private/tmp/fwp-next-functional-notes.md`.

GC removal is verified in #217; A1–A5 through #220. A6 needs final platform gates;
steps 3–8 remain open. [History](roadmap-history.md) owns delivery IDs and
[PLAN.md](../PLAN.md) owns the remaining tasks. The primary checkout is detached
at #209 with a recovery pointer and an untracked compiler-abort report; preserve
both. Disk is about 73 GiB free. Keep the fixed 64 GiB/2 GiB/1 GiB/180-second local
limits. No detached merger runs.

Publication and squash merge are authorized after all final-head gates pass:
one line <=80 characters, empty body, no trailers/attribution. Verify the merged
tree and message, then continue the next substantial PR.
