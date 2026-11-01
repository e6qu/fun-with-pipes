# Current work

**Next:** finish the integrated checks for [draft PR #236](https://github.com/e6qu/fun-with-pipes/pull/236),
repair every failure, then run the final nine-job production matrix and docs.
The pure-constructor optimization restores the native callback cost limits.
Its resource-frame unit fixture incorrectly marked an integer as a resource;
the pending repair supplies a real `File` owner. Do not weaken the IR validator.

All ten steps in [PLAN.md](../PLAN.md), publication and squash merge after passing
gates are authorized. Worktree `/private/tmp/fwp-returned-callables`, branch
`language-design-review`, base `781ebabb0463efc2f03f0d3aa44b7d2c4766959d`.
Preserve unrelated changes in the primary checkout. No final production matrix
has run for this PR; draft skips are not acceptance.

## Current checks

| Source / run | Scope | Last observed result |
|---|---|---|
| `f7f5309c`, `41257967346` | Full lexical, ownership, tooling, tutorial and raw checks on Linux ARM64/AMD64 and macOS ARM64 | Language and native callback probes pass on all three hosts; unit fixture fails; tutorial/raw checks continue |
| `f7f5309c`, `41257970283` | Unit checks, Clippy and analysis budgets on Linux and Intel macOS | 230 unit checks pass; only invalid resource fixture fails; Clippy and analysis budgets pass |
| `f7f5309c`, `41257924374` | Documentation and retained evidence | Pass; log audited |
| `f7f5309c`, `41258782085` | Two numerical sessions per Linux architecture | Running; measures the changed compiler, not an unchanged timing retry |
| `9d47a5fc`, `41256205285` | Previous four numerical sessions | Three pass; AMD64 session 1 has one timing rejection; all correctness/allocation/cleanup controls pass |
| `9d47a5fc`, `41258487184` | Independent audit/retention of those four sessions | Pass; all four sessions retained with the timing rejection |

Audit every completed target and compiler diagnostic, including passing jobs.
Logs are saved under `/private/tmp/fwp-236-*.log`. Batch known repairs before
pushing. Full suites, benchmarks and archive regeneration stay on GitHub.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | Implemented | Local names, patterns and strict evaluation on all supported hosts |
| 2 | Implemented | Final tooling, macro, tutorial and documentation gates |
| 3 | Implemented | Known-callback proof fixture repair and production cost checks |
| 4 | Implemented | Production alias/failure controls and zero/one-retain String loops |
| 5 | Implemented | Production direct scalar record/variant costs |
| 6 | Implemented | Production named fusion and eager evaluation order |
| 7 | In progress | Changed-source numerical sessions and retained measurements |
| 8 | In progress | Gradient-list savings and phase observations; preserve timing rejections |
| 9 | In progress | Complete numerical archives and peer ratios; Swift profiles retained |
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
unchanged. The failing unit fixture is a validation error before this proof runs.

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
