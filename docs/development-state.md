# Current work

**Next:** publish the batched repairs and documentation updates, then verify
`lexical-bindings` on Linux ARM64/AMD64 and macOS ARM64. Run the read-only
`swift-peer-report` retention job alongside it. All completed logs from focused
run `41250023104` at `8842030c4b180a273c1cd86cb43b651985ca9829` are audited.
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
The remaining whole-repository documentation audit stays open. The unpublished
pass removes obsolete A6/GC and sort-work directions, replaces the 500-line proof
history with the current protocol plus linked evidence tables, and corrects old
kernel/derivative/Swift status text. A runner step will archive all four original
Swift sessions after re-auditing them, before their January expiry.

The latest batch adds eight cases at 0/32/128 inputs, with count/allocation
requirements in PLAN.md before observations: local aliases, two String owner
loops, four aggregate representations and a range/map/filter/fold. It exposes an
immediately destructured record payload to existing scalar replacement and rejoins
single-use named ranges before fusion. Controls preserve aliases, eager output,
first traps and refutable alternatives. These new improvements are not verified.

## Validation and repairs

Focused run `41250023104` (`8842030c`) finished on both Linux GCC hosts and
macOS ARM64 Clang. Every completed target and diagnostic was audited. All hosts
have the same three failures; the remaining targets pass, including all eleven
REPL tests, tutorials/terminal sessions, Python integration and the raw corpus.
The earlier REPL saved-closure failure in `41248126920` is repaired.

| Failure | Cause and repair awaiting verification |
|---|---|
| Two String-loop count cases | Record destructuring hid fields from loop unpacking; argument preparation duplicated an owner before a later borrow. Expose irrefutable flat fields before counts and defer the final move through proved borrows. |
| Unknown curried callback | Inference assigned the caller's IO to its otherwise pure parameter. Use declared named-function input types before inferring their bodies; retain negative effect checks. |
| Resource-frame fixture | The added File case violated the existing affine partial-application rule. Use shareable UdpSocket inputs to test disposal between successive calls under the same descriptor limit. |

The eight original named/tacit pairs pass O0/O2. Six new cases also meet their
limits: tuple, record, variant, String record, local alias and range/map/filter.
The failed loop measurements are exactly `2n+1` retains (owner only) and `2n+2`
(with caller alias), at 0/32/128 on all three hosts. Keep the requirements at
zero/one. Source C confirms the record and per-iteration retains; these are cost
counts, not timings. Added duplicate-field and failed-borrow controls must preserve
normal/error cleanup. RC unit tests now run in this focused workflow too.

Strict-stage coverage also adds a top-level let returning a function and a match
arm returning a function. Their initializers/arm computations must run before
later arguments; they must not be delayed by type-based native arity selection.
All these repairs are unpublished and unverified by the production compiler.

Dispatch for `253da9e8` was rejected before jobs started: adding evidence upload
accidentally removed the next workflow job heading. The heading is restored;
this was a workflow editing error, not a runner failure.

Docs run `41248112966` failed a stale evidence-reader count (nine REPL tests
instead of eleven). The count, synthetic log and total are repaired; eight guarded
reader tests pass. Other completed docs checks passed; later steps did not run.
Docs `41250017533` at `8842030c` passes the complete audit, including the corrected
reader and all later evidence checks. Its full log is retained at
`/private/tmp/fwp-236-884-docs.log`; deliberately failing native-runner controls
are expected and verified by the enclosing test. Draft production runs skip
their jobs, which is not acceptance.
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
