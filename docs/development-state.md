# Current work

**Next:** verify the generic-primitive and trait-alias stage repair in
[PR #236](https://github.com/e6qu/fun-with-pipes/pull/236), then finish production.
Source review found that aliases still counted arrows added by substituting a
function for a primitive result, or ignored a trait implementation's strict
constructor boundary. The repair uses declared primitive stages and shares
trait selection with lowering. New regressions require a trap before a later
argument's `echo`. No timing/count limit is relaxed.

Production run `41261060185` tests prior head
`20109cf0f0e4ce5688e72a7e04f548f2c385f353`: benchmark and docs `41261025980`
pass/audited; eight platform jobs continue without a reported failed step.
Keep auditing them for other failures. This head must not be merged: it predates
the new semantic repair. Mark the PR draft while focused validation runs, then
require all nine production jobs and docs on the repaired final head.

All ten steps in [PLAN.md](../PLAN.md), publication and squash merge after passing
gates are authorized. Worktree `/private/tmp/fwp-returned-callables`, branch
`language-design-review`, base `781ebabb0463efc2f03f0d3aa44b7d2c4766959d`.
Preserve unrelated changes in the primary checkout. The first production matrix is running on the superseded source above;
draft skips and older passing heads do not establish final acceptance.

## Current checks

| Source / run | Scope | Last observed result |
|---|---|---|
| `f7f5309c`, `41257967346` | Full lexical, ownership, tooling, tutorial and raw checks on Linux ARM64/AMD64 and macOS ARM64 | All language, callback, tutorial, tooling and raw/native checks pass; only invalid unit fixture fails; all logs audited |
| `119439ea`, `41259139151` | Repaired unit checks and analysis budgets | Both pass: 231 unit checks, Clippy, scaling and startup budgets; logs audited |
| `119439ea`, `41259126851` | Documentation and all retained evidence | Pass; log audited |
| `f7f5309c`, `41258782085` | Two numerical sessions per Linux architecture | Complete: three pass; AMD64 session 2 fails identical-copy timing variation only; logs audited |
| `9d47a5fc`, `41256205285` | Previous four numerical sessions | Three pass; AMD64 session 1 has one timing rejection; all correctness/allocation/cleanup controls pass |
| `9d47a5fc`, `41258487184` | Independent audit/retention of those four sessions | Pass; all four sessions retained with the timing rejection |
| `f7f5309c`, `41260368842` | Independent audit/retention of current numerical sessions | Pass; all four sessions independently audited; copy-control rejection preserved |

Audit every completed target and compiler diagnostic, including passing jobs.
Logs are saved under `/private/tmp/fwp-236-*.log`. Batch known repairs before
pushing. Full suites, benchmarks and archive regeneration stay on GitHub.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | Implemented | Local names, patterns and strict evaluation on all supported hosts |
| 2 | Implemented | Final tooling, macro, tutorial and documentation gates |
| 3 | In progress | Generic primitive/trait alias order regressions and known-call cost checks |
| 4 | Implemented | Production alias/failure controls and zero/one-retain String loops |
| 5 | Implemented | Production direct scalar record/variant costs |
| 6 | Implemented | Production named fusion and eager evaluation order |
| 7 | Implemented | Preserve numerical cost/cleanup checks in production; timing acceptance open |
| 8 | Implemented | Preserve gradient-list savings and phase checks; original D2 speed goal open |
| 9 | Verified | Raw numerical/Swift records audited and retained; individual Swift ARC counts unmeasured |
| 10 | Pending | Application families, nine production jobs and documentation |

Focused run `41251272638` at `a61addc6` passes eight named/tacit pairs and eight
additional cost cases on three native hosts. String loops meet zero/one-retain
limits at 0/32/128. Numeric-array run `41254567543` at `a33c8ba9` passes
word/packed storage at O1/O2, with slices, aliases and physical cleanup.

The strict-stage repair at `a33c8ba9` ensures a saturated function constructor
runs before evaluating later arguments, including aliases and composed pipes.
Native probes at `9d47a5fc` follow those stages correctly and exposed a real
callback regression: pure `each` constructors hid known callbacks, while escaped
composition built three closures. All logs from `41256202095` and diagnostic
`41257109274` are audited. The latter retains compiler IR and all O0/O2 costs.

`src/opt/stages.rs` proves pure partial-function constructors before inlining.
It excludes executed computations, resource frames, observable locals, new
resource-bearing inputs and unused parameters. It renumbers locals and updates
known callers together. Strict construction/trap tests and cost limits remain
unchanged. The invalid resource fixture failed before this proof ran; `119439ea` uses
a real File owner, and both analysis hosts pass all 231 unit checks.

## Retained measurements

[Numeric array traversal](measurements/array-list-traversal.md) defines the six
solve cases, frozen limits and raw records. Original `dc0a6407` fails twenty
allocation/byte limits on each host because final reversal copies the list.
`9a2e954e` builds final-order lists directly only for pure, total callbacks with
scalar captures; folds and trapping/effectful callbacks keep forward order.
Both repaired session-2 hosts pass all limits. Session 1 exposed a probe that
freed a packed slice header without releasing its backing owner; the typed
array destructor repairs it at `a33c8ba9` without changing runtime behavior.

At `9d47a5fc`, all four sessions complete. AMD64 session 1 takes 1.023851 times
the reference time for zero-update history, exceeding 1.02. Preserve this
rejection; allocation, raw tape, cleanup, phase and copy controls pass everywhere.
The later `f7f5309c` run also completes four sessions: both ARM64 sessions and
AMD64 session 1 pass; AMD64 session 2 fails only identical-copy variation
(2.1023% versus 2%). All cost and cleanup requirements pass. The report states
C/Rust ratios and separate managed/raw storage. Its source tag is
`roadmap/array-lists-pure-constructors-2026-11-01`.
The gradient's final list conversion lies outside the six runtime phase clocks;
whole-solve savings are not a forward-recording improvement.

Original/repaired raw archives have independent passing audits `41257190382`
and `41257193865`. Their readers recompute decisions and preserve rejections.
Immutable `roadmap/array-lists-{first,repaired}-2026-11-01` tags retain their
source after squash merge. Historical audits load each recorded source adapter;
they must not compare old generated C with today's adapter.

[Swift allocation profiles](measurements/swift-allocations.md) pass on both
architectures at `9d47a5fc`, run `41256208614`; retention audit `41257220044`
passes. The raw archive and `roadmap/swift-allocations-2026-11-01` tag are retained.
On the same ARM host, system-library heaptrack loses control stack addresses;
explicitly selected libunwind 1.8.3 passes allocation/omitted-release controls.
Standalone unwinding passes with both libraries, so it does not isolate the
integration defect. AMD64 heaptrack passes with both. No fallback is introduced.

fwp's managed heap uses direct mappings outside heaptrack's allocator boundary.
Report its requests/live storage separately; never add independent peaks or
call malloc-only totals complete heap use. Swift ARC-operation counts remain
unmeasured. Four original timing sessions are separately retained in
`swift-peers-2026-10-31.tar.xz`; see [their report](measurements/swift-peers.md).

## Checks and delivery rules

No full compiler build ran locally. Guarded focused checks pass: Rust formatting,
documentation links/source anchors, primitive inventory, native target coverage,
standalone syntax/formatting, tutorial copies and generated library reference.
Evidence checks pass: array-list reader 5, Swift allocation reader 4, Swift timing
reader 5, historical callable reader 3. The latest Swift check verifies its tag.
Final production must cover the [application matrix](application-acceptance.md).

After exact-head gates pass, squash-merge with one explicit subject of at most
80 characters, empty body and no trailers or attribution; verify the result.
Keep one active PR. The roadmap is not complete while its open goals remain.

## Maintained guarantees and open limits

Baseline #235's tree `9eda0ac6113d18741d9b0f85c1dcadbba409b2ac` matches verified
head `adeb9794544cd12deae3f7050fef79cf874a3f55`; production `41229416050` and docs
`41229416071` pass, with logs audited. GC removal and scoped ARC reductions remain
verified. Broader ARC minimization, D2 derivative speed and N1/N2 kernel timing
remain open. The [callable study](measurements/callable-phases.md) retains three
Xeon construction regressions of 8.6–16.1%; other CPUs do not settle them.
The [Intel macOS compiler abort](measurements/compiler-abort.md) still has no
established root cause. Diagnose a recurrence from its input/source path;
do not resume speculative disassembly-led allocator changes.
