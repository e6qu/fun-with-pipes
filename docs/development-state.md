# Current work

**Next:** publish the batched F1–F3 repairs and run `functional-calls` on Linux
ARM64/AMD64. Audit every result, resolve the measured mutual-recursion decision,
then run the full final-head gates. No F1–F3 acceptance or speed claim yet.

Worktree: `/private/tmp/fwp-parser-workspace`; branch:
`functional-calls-and-tail-loops`; [draft PR #222](https://github.com/e6qu/fun-with-pipes/pull/222).
Base is merged #221, `ef037415f401cdf9ed44c7deffe735edfa99e0cd`, whose tree
`531fcffc2796aed8fb8b06b00145dddf2e7309d9` matches focused-tested `50dd674a`.
The squash message is one 49-character line with no body/trailers.

## What this batch changes

- F1: eight pairs compare known function uses with exported/unknown boundaries.
  Native O0/O2 observations count allocations, application requests, boxes and
  effective retains; they do not measure speed. The probe uses saturated C
  signatures or the owned partial-application constructor and includes State
  scratch allocation and root cleanup. Actual C/binaries/results are retained.
- F2: weak handles own metadata, so their phantom payload type does not prevent
  tail-frame reuse. Swaps, aliases, callback payloads, argument failure and
  cancellation have interpreter/native controls. Known partial applications
  containing only plain data or weak handles can lose their cleanup anchor;
  strong/unknown captures and cached or saturated closure factories cannot.
  Tail analysis ignores removed variables' unused type-table slots, while checking
  all parameters and every remaining binding/use. O0/O2 loops sample stack
  addresses and reject a deliberately broken observation.
- F3: a scalar mutual pair can select bodies inside one tagged worker. Original
  entries and non-tail calls remain. The measurement compares identical typed IR
  before/after lowering with an explicit fwp loop. Fixed timing/allocation/text/
  stack limits must accept or reject the prototype; noisy controls are inconclusive.
  [The measurement guide](functional-costs.md) owns the exact matrix and limits.

## Focused failures and repairs

`8787b42d`: run `40696627458` failed compilation on both hosts (seven u32/usize
arity diagnostics, one cause). `8b0fc929` fixes indexing and checks frame-size
limits. Both hosts of `40699575855` then compiled and passed all-target Clippy;
the run completed before cancellation was attempted. It exposed all of these:

- Manual recursion IR called `sub` instead of primitive `prim.sub` (one unit and
  the measurement emitter failed). The downstream missing C file was a consequence;
  measurement now requires a successful emitter.
- Two fixtures needed formatting. The repository formatter, built alone under
  the guard, has formatted them and checked syntax equivalence and idempotence.
- The weak cancellation fixture composed incompatible function types; it now
  uses an explicitly typed curried task callback.
- Weak swaps retained cleanup anchors for known scalar/weak-only closures. The
  new value proof removes only these anchors before substitution, preserving
  effect order and unknown/strong owners. Unit controls cover both admission
  and rejection. This compiler change still needs execution on CI.
- The F1 native probe called curried C entries with too few arguments. Published
  repair `c56d644f` uses owned partial applications and checks entry arities.
- The existing borrowed-callback negative sanitizer control returned success:
  an unused NULL+0 result need not survive C optimization. A source observer now
  checks the offset operation before it can disappear. Removing either guard
  must exit 210 at production O1/O2 on every native platform. Original runtime
  arithmetic also runs under Clang UBSan on Unix. Production guards are unchanged.

At `8b0fc929`, 215 units passed, one failed, four were ignored. Closure ownership
(3), State sequence ownership (4), and eight pre-existing call-liveness tests
passed. Tail tests had one pass/two failures. Full failed logs are saved at
`/private/tmp/fwp-222-8b0-failed.log` and normalized `.txt`; the earlier compile
log is `/private/tmp/fwp-222-8787-failed.log`. Expected scheduler panic controls
passed. Docs passed at all three published heads (`40696632338`, `40699544670`,
`40703221563`). Focused `40703270836` at `c56d644f` is cancelled because the
completed older run revealed the additional repairs above. Draft full-gate skips
are not validation.

## Postmerge A6 gates

Production `40691815018`: benchmark, both Windows jobs, Linux ARM64, regular
macOS ARM64 and both macOS ownership jobs pass. Linux AMD64 and regular Intel
macOS are still running without reported failures. Docs `40691814677` passes.
Completed logs are saved under `/private/tmp/fwp-221-ef037-*.log` and audited:
Linux ARM64 has 257 passing summaries/969 tests, regular macOS ARM64 132/610,
each Windows host 202/790. Each macOS ownership job has 125 targets and 127
passing summaries/356 tests including controls. No compiler warnings/errors.
A6 platform acceptance remains pending the last two jobs and their log audit.

The benchmark's current-host loop ratio is 1.392× Rust and text-length 1.905× C.
These are not paired cross-revision regressions. Its missing-cleanup leak is an
expected negative control. Preserve the unexplained original Intel compiler
abort evidence; a passing rerun does not establish its cause.

## Local checks

Guarded checks: Rustfmt, four measurement-decision Python controls, workflow
Actionlint and roadmap audit passed before the current repairs. Current repairs:
Rustfmt, Actionlint and the roadmap audit pass; the actual formatter modules built at Rust O1 (2.51 CPU seconds,
4.98 seconds elapsed), then formatted all three fixtures with syntax-equivalence
and idempotence checks. The first guarded invocation was denied process inspection
by the sandbox; the same guard ran with permission, without raised limits.
Full compiler builds, native tests and measurements remain on GitHub.

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
