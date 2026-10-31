# Current work

**Next:** publish and validate the cached-function/evaluation-order repairs and
the eight new local ownership/representation/collection cases through the
three-host `lexical-bindings` suite. Audit every completed job before another push.
The user authorized all ten steps in [PLAN.md](../PLAN.md). Steps 1–6 are in
progress; steps 7–10 remain open. New syntax is not verified support yet.

Worktree: `/private/tmp/fwp-returned-callables`; branch `language-design-review`,
based on main `781ebabb0463efc2f03f0d3aa44b7d2c4766959d`.
Draft [PR #236](https://github.com/e6qu/fun-with-pipes/pull/236) is the only active
PR. Preserve unrelated changes in the primary checkout.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Verify REPL cached functions and strict curried-stage evaluation |
| 2 | In progress | Validate tooling/tutorials and finish the documentation audit |
| 3 | Implemented | Eight pairs pass focused O0/O2 checks; preserve them through integration |
| 4 | In progress | Verify local aliases and loop-carried String count limits |
| 5 | In progress | Verify four representation cases and immediate variant destructuring |
| 6 | In progress | Verify named range/map/filter fusion and eager-stage controls |
| 7 | Pending | Measure and remove remaining numerical loop costs |
| 8 | Pending | Attribute and remove a demonstrated derivative cost |
| 9 | Pending | Complete Swift attribution and qualified comparisons |
| 10 | Pending | Integrated application and final-head delivery gates |

## Current batch

Implemented: strict immutable `let`, single-input `fn`, named match patterns,
tuple/record destructuring, record shorthand, explicit captures and monomorphic
local inference. Macros preserve lexical scope and quote stages. Formatter,
editor navigation/rename, debugger inspection and notebook dependencies recognize
local names. Tutorials and the reference introduce these concepts with examples.
The remaining whole-repository documentation audit stays open.

The unpublished batch adds eight cases at 0/32/128 inputs, with count/allocation
requirements in PLAN.md before observations: local aliases, two String owner
loops, four aggregate representations and a range/map/filter/fold. It exposes an
immediately destructured record payload to existing scalar replacement and rejoins
single-use named ranges before fusion. Controls preserve aliases, eager output,
first traps and refutable alternatives. These new improvements are not verified.

## Validation and repairs

Focused run `41248126920`, source `f5b31b07ea39fcd33e9d4688368c0227853291ad`,
completed on Linux ARM64/AMD64 (GCC) and macOS ARM64 (Clang). All three complete
logs were audited. The sole failing target is the saved-closure REPL regression:
calling `out2` after redefining its source reaches the stored-value trap.

All three hosts pass all eight named/tacit cost pairs at O0/O2, macro/optimizer
unit checks, lexical cases, numeric-array fusion, ownership/call-liveness,
editor/debugger, formatting, infix, preemption and resource checks. Tutorial
programs and terminal sessions, source copies, three Python notebook/debugger
checks and the full raw interpreter corpus pass. Cost counts are not timings.
This verifies the array/fold cost repairs and fixture/WebSocket corrections from
failed run `41246880525` (`bcb4a468`; its docs run `41246883800` passed).

The REPL repair explicitly lowers result bindings as cached values, including
function values. A new regression requires construction effects once per cell.
The source review also found curried applications could delay a first-stage
calculation until after the next argument. Named entries now stop their argument
group before intervening work or observable resource disposal; unknown calls
stay sequential. Regressions cover unused returned functions, aliases and unknown
callbacks. These repairs await runner validation.

Docs run `41248112966` failed a stale evidence-reader count (nine REPL tests
instead of eleven). The count, synthetic log and total are repaired; eight guarded
reader tests pass. Other completed docs checks passed; later steps did not run.
Draft production run `41248112962` skipped its jobs, which is not acceptance.
No final-head production matrix has run for this PR.

Earlier failures are repaired: `41245768888` (probe borrow lifetime, OpenSSL
selection and preemption transcript) and `41242796910` (macro field move).
Superseded queued runs `41243195909`, `41243748366`, `41244787126` were cancelled.

Local checks through the unchanged guard:

| Check | Result |
|---|---|
| `cargo fmt --all` and `git diff --check` | Pass before publication; about one CPU second for formatting |
| `scripts/test-native-test-runner.py` | 21 pass, including target coverage |
| Frozen primitive inventory | 394 declarations, 384 symbols, no review symbols |
| `scripts/check-roadmap.py` | 192 doc link sets, 106 preparation pairs, ten steps pass |
| Standalone production parser/formatter modules | 17 pass, including continuation, record patterns, tutorial programs and round trips |
| Standalone `tests/examples.rs` source/output-copy test | All tutorial copies pass; no fwp execution |
| Standalone `tests/stdlib_doc.rs` generator | Pass; library reference regenerated |
| `scripts/test-collection-evidence.py` | Eight pass after REPL count correction |

Standalone harnesses are `/private/tmp/fwp-236-parser-check.rs`,
`/private/tmp/fwp-236-tutorial-docs` and `/private/tmp/fwp-236-stdlib-doc`.
They use Rust O1 with assertions/overflow checks. These checks do not verify
inference, lowering, ownership or native output. No full compiler build ran
locally. Full builds, suites and benchmarks stay on runners. Never raise limits.

## Verified baseline and remaining evidence

The user merged [#235](https://github.com/e6qu/fun-with-pipes/pull/235). Its tree
`9eda0ac6113d18741d9b0f85c1dcadbba409b2ac` matches tested head
`adeb9794544cd12deae3f7050fef79cf874a3f55`. Production `41229416050` passes all nine
jobs; documentation `41229416071` passes. Completed logs are audited. The merge
subject is one line, 61 characters, with no body/trailers. Duplicate postmerge run
`41241035081` was cancelled after confirming this identity. Old run `38888712709`
listed all jobs as finished; GitHub rejected cancellation because it was complete.

GC removal is verified; broader ARC minimization remains incomplete. The
[callable measurements](measurements/callable-phases.md) retain all eight passing
RAM limits and the three original Xeon construction regressions (8.6–16.1%).
Swift allocation/count attribution is missing; RSS does not isolate ARC cost.
The separate paired run `41225841156` has 32 qualified/four short ARM phases and
19 qualified/17 inconclusive AMD phases on a different CPU. All twelve AMD
construction phases are too short. Preserve those limits and failures; do not
retry unchanged experiments or claim the different CPU settles the regression.

D2 derivative timing and N1/N2 kernel timing acceptance remain open. Verified
count/allocation reductions are independent of those timing failures. No runtime
patch was justified by the constructor investigation. Follow the ten concrete
steps in PLAN.md rather than reimplementing completed GC/ARC milestones.

Callable raw archives are checked in. Earlier whole-program Swift artifacts
expire in January 2027 and still need durable retention. Earlier APFS deduplication
recovered about 1.2 GiB without changing any checkout's contents or status.
