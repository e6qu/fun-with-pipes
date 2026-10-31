# Current work

**Next:** audit focused lexical-binding CI, fix every compiler/test failure, then
complete the named/tacit cost checks before final-head production validation.
The user authorized all ten steps in [PLAN.md](../PLAN.md). Steps 1–3 are in
progress; steps 4–10 remain open. New syntax is not verified support yet.

Worktree: `/private/tmp/fwp-returned-callables`; branch `language-design-review`,
based on main `781ebabb0463efc2f03f0d3aa44b7d2c4766959d`.
Draft [PR #236](https://github.com/e6qu/fun-with-pipes/pull/236) is the only active
PR. Preserve unrelated changes in the primary checkout.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Validate local names, patterns, types and cleanup |
| 2 | In progress | Validate tooling/tutorials and finish the documentation audit |
| 3 | In progress | Verify eight named/tacit cost pairs and repair extra costs |
| 4 | Pending | Extend measured borrowing/move cases |
| 5 | Pending | Remove selected tuple/record/variant boxes |
| 6 | Pending | Extend eligible collection pipeline removal |
| 7 | Pending | Measure and remove remaining numerical loop costs |
| 8 | Pending | Attribute and remove a demonstrated derivative cost |
| 9 | Pending | Complete Swift attribution and qualified comparisons |
| 10 | Pending | Integrated application and final-head delivery gates |

## Current batch

Implemented, awaiting compiler/native validation:

- Strict immutable `let pattern = value in body`, single-input `fn pattern ->
  body`, named match patterns, tuple/record destructuring and record shorthand.
  Local types are monomorphic; duplication/capture rules still apply. `_`
  discards in fn/let and record fields; other match holes forward their values.
- Explicit capture lowering and direct parameters for simple fn inputs. Eight
  named/tacit cost pairs check dispatch, allocation and count limits. Alias,
  error, cancellation and physical-release controls cover captured values.
- Macro pattern validation before freshening names; separate scopes for nested
  quotes; computed splices run once when a template is constructed. Invalid
  splice arity and out-of-range template indices are type errors.
- Scope-aware linting, editor navigation/rename/completion and debugger names;
  Python inspection accepts a source name. Generated OpenAPI names use the
  lexer's keyword list. Field shorthand retains labels when a local is renamed.
- Replaced the roadmap, corrected obsolete links, updated the reference/parser
  and compiler guides, and rewrote lessons 1, 2, 6, 9, 11, 12, 16, 17, 19, 20, 21, 23 and 24. The glossary
  explains local scope/capture and the two meanings of `_`. Library docs are
  regenerated from source. The remaining documentation audit is still open.

The next batch repairs the failures below and adds scope-aware notebook
analysis, REPL continuation for let/fn, saved-closure tests, record-pattern
formatting and clearer interactive guides. History is ordered by delivery;
duplicate status summaries are removed without deleting evidence.

## Validation and failures

Focused run `41246880525`, source `bcb4a468e44c1cb66424505c231f5a8ac943c385`,
completed on Linux ARM64/AMD64 (GCC) and macOS ARM64 (Clang). All three complete
logs were audited, including successful targets and diagnostics. Docs run
`41246883800` passes. The three hosts report the same failures:

- Named array mapping/folding retains one temporary array: 264 bytes at 32
  elements, 1,032 at 128. Named list folding creates two allocations per element
  and four runtime applications. Other named pairs meet their limits at O0.
  These are failed cost requirements, not timing results. O2 did not run after
  the assertion; the repaired test now collects cost failures across both levels.
- The new shared-capture fixture used reserved `make` as a name. The OpenAPI
  fixture expected an unreferenced schema to be emitted. Both fixtures are fixed;
  all lexical cases now run even when an earlier one fails.
- WebSocket lesson 19 passed socket/message arguments in reverse order. Its
  source and README now use the declared data-last order.
- Compiler lint, macro scopes, closure ownership/cleanup, other call-liveness
  tests, debugger, infix syntax, formatting, golden parsing/checking, lint,
  editor tests, preemption and resource frames pass. Tutorial programs, source
  copies and library docs pass. The raw corpus passes on all three hosts.

Pending compiler repairs reconnect a single-use named generator before array
fusion, crossing only total argument expressions. Known curried callbacks expose
both argument stages through existing specialization; resource frames and eager
capture evaluation remain in place. Numerical controls cover aliases, callback
effects, seed evaluation and distinct first traps. Cost limits are unchanged.

The preceding run `41245768888` failed the Rust probe's inferred borrow lifetime,
macOS OpenSSL executable selection and raw preemption transcript. Those repairs
are verified by `41246880525`. Earlier compile failure `41242796910` was fixed by
borrowing a macro record field instead of moving it from a value with Drop.
Superseded queued runs `41243195909`, `41243748366`, `41244787126` were cancelled.

The next focused run must verify these repairs, notebook/REPL integration and
all remaining lexical cases. Full production validation follows the completed
batch; draft skips are not passes. No final-head production matrix has run yet.

Local checks through the unchanged guard:

| Check | Result |
|---|---|
| `cargo fmt --all` and `git diff --check` | Pass; formatting about 1 CPU second |
| `scripts/test-native-test-runner.py` | 21 pass, including new target coverage |
| Frozen primitive inventory | 394 declarations, 384 symbols, no review symbols |
| `scripts/check-roadmap.py` | 192 doc link sets, 106 preparation pairs, ten steps pass |
| Standalone production parser/formatter modules | 16 pass, including REPL continuation, record patterns, tutorial programs and round trips; 3.36 CPU seconds to compile |
| Standalone `tests/examples.rs` source/output-copy test | All tutorial copies pass; no fwp execution |
| Standalone `tests/stdlib_doc.rs` generator | Pass; library reference regenerated |

Standalone harnesses are `/private/tmp/fwp-236-parser-check.rs`,
`/private/tmp/fwp-236-tutorial-docs` and `/private/tmp/fwp-236-stdlib-doc`.
They use Rust O1 with assertions/overflow checks. The local checks do not verify inference,
lowering, ownership or native output. No full compiler build ran locally.
Full builds, suites and benchmarks stay on runners. Never raise the guard limits.

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
