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
  discards in fn/let and retains its forwarding meaning in match.
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
  and compiler guides, and rewrote lessons 1, 2, 6, 11, 12, 20 and 24. The glossary
  explains local scope/capture and the two meanings of `_`. Library docs are
  regenerated from source. The remaining documentation audit is still open.

The nested-quote and later-tutorial changes follow published head
`a48c9c5b9ea6fc0f26c80a31d8f7bbb2ee44844e`; obtain their source from the next commit,
not that earlier head. Do not present added tests as passing native evidence.

## Validation and failures

Focused run `41242796910` failed compilation on all three hosts: macro record
pattern decoding moved a field from a value with a destructor. All failed steps
were audited; no language tests ran. The repair borrows the field. Documentation
run `41242798221` passes.

Runs `41243195909` and `41243748366` never started and were cancelled when their
sources were superseded. Run `41244787126` at `a48c9c5b` remains queued on Linux
ARM64/GCC, Linux AMD64/GCC and macOS ARM64/Clang. Documentation run `41244782819`
is also queued. Replace these only when the next coherent batch is published.
The focused suite covers language/ownership, named/tacit costs, editor/debugger,
macro scopes, tutorial execution and source copies, and the raw interpreter corpus.
Full production validation follows the completed batch; draft skips are not passes.

Local checks through the unchanged guard:

| Check | Result |
|---|---|
| `cargo fmt --all` and `git diff --check` | Pass; formatting about 1 CPU second |
| `scripts/test-native-test-runner.py` | 21 pass, including new target coverage |
| Frozen primitive inventory | 394 declarations, 384 symbols, no review symbols |
| `scripts/check-roadmap.py` | 192 doc link sets, 106 preparation pairs, ten steps pass |
| Standalone production parser/formatter modules | 13 pass, including nine changed programs and round trips; 3.22 CPU seconds to compile |
| Standalone `tests/examples.rs` source/output-copy test | All tutorial copies pass; no fwp execution |
| Standalone `tests/stdlib_doc.rs` generator | Pass; library reference regenerated |

Standalone harnesses are `/private/tmp/fwp-236-parser-check.rs`,
`/private/tmp/fwp-236-tutorial-docs` and `/private/tmp/fwp-236-stdlib-doc`.
They use Rust O1 with assertions/overflow checks. They do not verify inference,
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
