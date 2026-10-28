# Current work

**Next:** publish the callback-fixture and stack-marker repairs, rerun
`functional-probes` on Linux ARM64/AMD64, then start full final-head gates/G2
when focused results pass. Both hosts of `40714605188` finished; docs
`40714567963` passes. Resolve the measured mutual-loop
decision before starting the full final-head platform gates and G2 budgets.
F1–F3 remain unaccepted. A6 is now verified.

Worktree: `/private/tmp/fwp-parser-workspace`; branch:
`functional-calls-and-tail-loops`; [draft PR #222](https://github.com/e6qu/fun-with-pipes/pull/222).
Published head: `b2f45840f936d96f49c3ed069094ac92b4d574f0`; compiler code
remains `e85d794c`. Probe repairs shipped at `e2bf6818`; the required roadmap
table was restored at `b2f45840`. Old docs run `40714402852` was cancelled.

One follow-up source repair is uncommitted: the POSIX stack handler stored a
pointer to an expired local marker. It now retains only the numeric address.
A bounded 256 KiB main-stack test checks the handler after initialization returns,
at O0/O2. It deliberately uses unknown C recursion to prevent tail elimination;
this tests runtime handling, not fwp lowering. Rustfmt passes; native verification
is pending. This does not explain the separate original Intel compiler abort.

## Implementation and evidence

[The measurement guide](functional-costs.md) owns the exact F1–F3 fixtures,
scopes and budgets. F1 compares eight known/unknown function boundaries with
executed allocation, dispatch, box and retain observations. F2 permits weak
metadata in reused frames, removes only proved plain-capture cleanup anchors,
and ignores removed variables' unused type slots. Strong/unknown captures,
cached closures and fully applied closure factories retain their boundaries.
F3 prototypes a scalar mutual pair as one tagged worker, retaining callable
entries and ordinary non-tail calls. The comparison must accept or reject it
against ordinary calls and an explicit loop; noisy controls are inconclusive.

Focused `40710069104` at `e85d794c` finished on both Linux hosts. Both passed
compilation, formatting, all-target Clippy, 218 compiler units and the IR emitter.
Four units are intentionally ignored. Both docs `40709965204` and the preceding
docs `40708331268` pass.

All existing affected native targets pass: borrowed callbacks (1 test), closure
ownership (3), eight existing call-liveness cases, queued/weak functions (12),
resource fields (1), resource variants (1), resource frames (3), match cleanup
(1), State sequences (4), and the tail rejection control (1). Both complete logs
are audited; expected scheduler panic controls passed.

The weak-tail fixture passes raw/optimized interpretation and native O0/O2 before
the later mutual-fixture assertion fails. Independent saved-artifact audit verifies
outputs, zero live managed storage, ELF architectures and broken-stack exit 194.
Across 600,009 observed loop entries it requests 23 allocations / 1,090 bytes
for the whole fixture, including setup, output and cleanup. Maximum observed
stack ranges: ARM64 2,112/1,760 bytes and AMD64 2,496/2,160 bytes at O0/O2.
These compare visits across several invocations, not just one frame or elapsed
speed. Callback offset controls independently exit 210 when either guard is
removed; valid production/UBSan paths pass at O1/O2.

## Latest audit and pending repairs

Both hosts of `40714605188` pass all three tail tests: weak swaps/failure,
cancellation and mixed self/mutual recursion. The measurement also passes all
four O0/O2 comparisons. [The report](functional-costs.md#first-measured-decision)
and [raw record](measurements/mutual-recursion-2026-10-28-first.json) retain the
full data, including AMD64 O2's small slowdown versus ordinary calls. The
independent audit `/private/tmp/fwp-audit-b2f.py` passes sample/flag/ELF/hash/
stack/profile checks. Timed work excludes evidence writes. Subsequent records
also retain successful executable stdout, not just failed output.

The only failing native test is F1. The probe constructed partial applications
for direct-call-only exports; their function-table entries correctly lacked
callback ownership metadata. Both hosts trap at the first boundary call with
“counted owner escaped ARC contract.” The repaired source fixture explicitly
exports the same function identities as first-class values, making metadata
necessary. The native probe now checks those entries before allocating inputs.
The identity record is not part of the measured work; no compiler/runtime
compatibility wrapper or blanket callback-table emission is added.

The executable teardown, weak task application and mixed mutual fixture repairs
at `e2bf6818`/`b2f45840` are verified. The separate POSIX saved-address repair
above and its bounded stack test still need CI. Keep the working-tree changes;
no F1 acceptance or final platform claim yet.

`functional-probes` reruns the affected call/tail targets and measurement, plus
units, formatting and Clippy. `functional-calls` also runs the eight existing
resource/ownership targets; use it after compiler ownership changes. Full final
platform gates still cover all maintained tests. Four measurement-decision
controls pass; timing noise remains inconclusive rather than silently accepted.

## Earlier repairs and retained records

| Source | Focused result / repair |
|---|---|
| `8787b42d` / `40696627458` | u32/usize arity errors; fixed once at the indexing boundary with checked frame limits |
| `8b0fc929` / `40699575855` | Full failure audit found a wrong manual primitive name, source formatting/typing mistakes, too-short C calls, conservative capture anchors and an unreliable sanitizer control |
| `c56d644f` / `40703270836` | Owned partial applications replace short C calls; queued run cancelled before the complete batch |
| `1f65b46f` / `40708352241` | Capture proof and source controls added; queued run superseded and cancelled |
| `e85d794c` / `40710069104` | Compiler/lifetime controls pass; three remaining probe causes listed above |

Logs: `/private/tmp/fwp-222-{8787,8b0}-failed.log` and
`/private/tmp/fwp-222-e85-{arm,amd}.{log,txt}`. Artifacts:
`/private/tmp/fwp-222-e85-{arm,amd}-artifact`. Independent audit:
`python3 scripts/local-guard.py python3 /private/tmp/fwp-audit-e85.py` (passes).
Failed F3 reports retain the exact source and no accepted result. Later logs
are `/private/tmp/fwp-222-b2f-{arm,amd}.{log,txt}`; artifacts are
`/private/tmp/fwp-222-b2f-{arm,amd}-artifact`. Both complete logs are audited: 218
units, eight old call-liveness cases, three tail tests and the emitter pass;
only the F1 fixture fails. No compiler warnings.

## Completed parser delivery

All nine postmerge production jobs `40691815018`, docs `40691814677` and both
G2 hosts `40685939711` pass. Every completed log is audited, including warnings
and individual test summaries. [History](roadmap-history.md#scoped-parser-storage-and-analysis-work-pr-221)
owns the merge/tree/message verification and host counts. The parser and analysis
reports retain their separate source IDs and four timing sessions. The parser
remains slower than its C/Rust peers; GC removal and scoped storage do not imply
language-wide zero overhead or no ARC.

Preserve the unexplained [Intel compiler-abort evidence](measurements/compiler-abort.md).
Passing reruns do not establish its cause. No disassembly-led allocator experiments.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | Verified | Maintain the named A1–A6 guarantees |
| 3 | In progress | Finish F1–F3 probes, measurement decision and platform gates |
| 4 | Pending | Close measured CPU performance gaps |
| 5 | Pending | Derivative storage, timing and precision |
| 6 | Pending | CPU numerical kernels |
| 7 | In progress | Fixed comparison budgets and complete evidence |
| 8 | Pending | Larger-program correctness, cleanup and scale |

## Local checks and recovery

Guarded Rustfmt, Actionlint, fixture formatting, measurement-decision controls
and independent artifact audit pass. The actual formatter modules built alone
at Rust O1, then checked syntax equivalence and idempotence. No full local build,
suite or benchmark ran. The handoff rewrite initially omitted the required
eight-step status table; it is restored above. The repaired audit passes all
170 link sets, 106 preparation records, eight steps and commit-message checks.

The primary checkout remains detached at #209, with a recovery pointer and an
untracked compiler-abort report; preserve both. Prior raw records remain in
`/private/tmp/fwp-221-50dd-analysis`, `fwp-221-{45f9,ba383,dd91}-analysis`,
`fwp-221-35250-measurements`, `fwp-221-dbf1-{macos,windows}-{arm,amd}-parser`
and `/private/tmp/fwp-221-ef037-*.log`. Do not delete failed evidence.
Disk is about 73 GiB free; keep the 64 GiB/2 GiB/1 GiB/180-second guard limits.

GitHub lists old run `38888712709` as active although every job completed on
October 16. Normal cancellation says completed; force-cancel returns HTTP 409
“not in progress.” It has no active job and did not prevent current checks.

Publication and squash merge are authorized after all final-head gates pass:
one line <=80 characters, empty body, no trailers/attribution. Verify the merged
tree and message, then continue the next substantial PR. [PLAN.md](../PLAN.md)
owns the remaining roadmap; a completed PR does not complete it.
