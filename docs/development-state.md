# Current work

**Next:** repair the known-callback regression exposed by strict call stages.
Retain compiler IR and all O0/O2 cost failures to locate the lost specialization;
keep the existing limits and constructor trap-order guarantees. Audit remaining
numerical/allocation jobs and retain their raw evidence. Then finish
the documentation audit and run the final production matrix for
[draft PR #236](https://github.com/e6qu/fun-with-pipes/pull/236).

The user authorized all ten steps in [PLAN.md](../PLAN.md), publication and squash
merge after passing gates. Worktree `/private/tmp/fwp-returned-callables`, branch
`language-design-review`, base `781ebabb0463efc2f03f0d3aa44b7d2c4766959d`.
Preserve unrelated changes in the primary checkout. No final production matrix
has run for this PR; draft production skips are not acceptance.

## Roadmap status

| Step | Status | Remaining verification |
|---|---|---|
| 1 | Implemented | Preserve local names, patterns and strict evaluation in integration |
| 2 | Implemented | Finish documentation audit and tooling/platform gates |
| 3 | Implemented | Updated native-call and returned-callable probes |
| 4 | Implemented | Preserve alias/failure controls and zero/one-retain String loops |
| 5 | Implemented | Preserve direct scalar record/variant cost limits |
| 6 | Implemented | Preserve named fusion and eager evaluation order |
| 7 | In progress | Two numerical sessions per architecture and retained evidence |
| 8 | In progress | Gradient-list savings, exact results and complete phase observations |
| 9 | In progress | Same-host observer diagnosis and durable allocation archives |
| 10 | Pending | Finite application matrix, nine production jobs and documentation |

## Current runner work

All runs below use published source `9d47a5fc` except where an audited historical
source is explicit. Full source IDs are in GitHub run metadata.

| Run | Scope | Last observed state |
|---|---|---|
| `41256202095` | `lexical-probes`: Linux ARM64/AMD64 GCC, macOS ARM64 Clang | Fails: each dispatch grows with input; escaped composition constructs three closures |
| `41256205285` | `array-list-measurements`: two sessions per Linux architecture | Running |
| `41256208614` | `swift-allocations`: native Linux ARM64/AMD64 | AMD64 passes; ARM64 running |
| `41256218712` | `array-list-report`: original `dc0a6407`, run `41252379702`, session 2 | Fails: output verifier was nested inside collector; now exported and tested |
| `41256230139` | `array-list-report`: repaired `9a2e954e`, run `41253549233`, session 2 | Same verifier failure; repair ready |

Do not repeat the unchanged full language corpus while repairing these probes.
The final production matrix will cover the integrated source. Completed logs are
saved under `/private/tmp/fwp-236-*.log`; audit every target and diagnostic, not
just the first failing step. Known deliberate failure controls are expected only
inside their passing observer tests.

At `9d47a5fc`, all three probe logs are audited. Other call/cleanup tests pass;
`each-count` dispatch/allocations grow with input and returned composition uses
three closures (56 bytes) with per-call retains. This is a compiler regression,
not permission to relax count requirements. Generated C and native observations
are retained in `41256202095`; the next probe also saves compiler IR and collects
all O0/O2 cost failures before failing. Both evidence-audit failures share the
non-exported Python verifier, repaired with an analytic-output corruption test.
Docs `41256193316` fails because historical generated C was compared with today's
adapter. The auditor now loads the exact recorded adapter source; its three
historical/corruption tests pass locally. All failure logs are audited.

## Verified behavior and repaired failures

At `a61addc6`, focused run `41251272638` passes all three native hosts: language,
macros, ownership, tooling, tutorial copies, Python integration and raw interpreter
corpus. Eight named/tacit pairs and eight added cost cases pass. String loops
meet zero/one-retain limits at 0/32/128. Counts are not timings.

At `a33c8ba9`, run `41254567543` passes those language contracts and all
word/packed numeric-array cost checks at O1/O2, including offset slices, aliases
and physical cleanup. Its sole failure on each host is a probe that assumes every
arrow in a function type belongs to one C entry. `9d47a5fc` repairs that helper
and the returned-callable benchmark adapter to use the compiler's actual stages.
A saturated constructor may return a function; subsequent inputs call that result.
The source algorithms and their cost requirements are unchanged.

The underlying compiler repair at `a33c8ba9` prevents delayed construction of
function-valued globals. New raw/native controls require constructor failure
before a later argument's effect, including aliases and composed constructors.
Ownership run `41254575615` passes Linux and Intel macOS: 229 unit checks and
analysis budgets. Docs `41254565452` passes. All completed logs are audited.

### Numerical evidence

The [array-list protocol](measurements/array-list-traversal.md) freezes six solve
cases, allocation limits, two sessions, copy/noise controls, phase measurements
and code/stack bounds. The final gradient list lies outside runtime phase clocks;
whole-solve savings are not a forward-recording reduction.

- Original `dc0a6407`, run `41252379702`: both session-2 hosts meet timing,
  raw-tape, cleanup, phase and code/stack limits but fail twenty allocation/byte
  limits each. Generated C builds a reversed list and copies it during reversal.
- `9a2e954e` constructs final-order lists directly for pure, total callbacks
  with scalar captures. Folds and trapping/effectful callbacks stay forward.
  Both session-2 hosts in `41253549233` meet all six frozen case budgets.
- Session 1 instead exposes a packed-view test bug: freeing only its header
  leaves its backing owner. `a33c8ba9` uses the exported typed array destructor;
  all three focused hosts now pass. No runtime patch or relaxed limit was needed.

Both failed and passing logs are fully audited. Independent
`check-array-list-evidence.py` recomputes raw totals, medians, ratios, memory,
phases, ELF text sizes and stack records without executing saved binaries. It
preserves failed budgets. Its four corruption tests and twelve older derivative
archive tests pass. Full directory audits and durable raw archives remain pending.

### Swift evidence

The original four-session timing archive is retained as
`docs/measurements/swift-peers-2026-10-31.tar.xz`, SHA-256
`8ddb06a630969718322cacd10e3a3472f7e0da1c5da97106b8c0090806604118`.
Retention run `41251278856` audits original source `80a0504a`, run `41214191081`.

[Allocation profiling](measurements/swift-allocations.md) at `a33c8ba9`, run
`41254571983`, passes independent allocation/omitted-release controls on both
architectures with explicitly selected libunwind 1.8.3. The previous ARM observer
recorded no stack addresses. Standalone unwinding also passes with the system
library, so it does not reproduce that heaptrack defect. The current run compares
full heaptrack controls with both libraries on each host; there is no automatic
observer substitution. Unused coredump/ptrace helper builds were removed after
emitting upstream implementation warnings. All completed logs are audited.

fwp's managed heap uses direct mappings outside heaptrack's allocator boundary.
Its requests/live storage are reported separately. Never add independent peaks
or treat malloc-only totals as complete fwp heap use. Individual Swift ARC-operation
counts remain unmeasured. Current profiles need a durable raw archive after audit.

## Local checks and delivery

Use the unchanged resource guard; no full build ran locally. Full builds, suites,
benchmarks and large archive regeneration remain on GitHub runners.

Passed: Rust formatting, diff checks, workflow actionlint, 194 documentation link
sets/106 preparation anchors/ten plan steps, primitive inventory (394 declarations,
384 symbols), 21 runner/coverage checks, 17 standalone parser/formatter tests,
tutorial copies and generated library reference. Evidence tests pass: collection
8, derivative budgets 9, derivative archives 12, array-list audit 4, Swift timing
archive 5, Swift allocator/unwinder 3, callable records 5. Standalone syntax tests
do not verify compiler inference or native behavior.

After final-head gates pass, squash-merge with an explicit one-line subject of
at most 80 characters and empty body; verify no trailers or attribution. Keep one
active PR. A completed PR does not settle the open timing goals below.

## Maintained guarantees and open limits

Baseline #235's merged tree `9eda0ac6113d18741d9b0f85c1dcadbba409b2ac` matches
verified head `adeb9794544cd12deae3f7050fef79cf874a3f55`; production `41229416050`
passes all nine jobs and docs `41229416071` passes. Logs are audited.

GC removal and scoped A1–A6 ARC reductions are verified; broader ARC minimization
remains incomplete. D2 derivative speed and N1/N2 kernel timing acceptance remain
open. The [callable study](measurements/callable-phases.md) retains three Xeon
construction regressions (8.6–16.1%); noisy/short observations on a different CPU
do not settle them. Retain the [Intel macOS compiler-abort evidence](measurements/compiler-abort.md);
its root cause is still unknown. Do not resume speculative disassembly-led fixes.
