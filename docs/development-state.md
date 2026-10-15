# Session handoff

Updated 2026-10-15. Current branch: `docs-for-new-readers`, based on `41f30475`.
The user requested a complete documentation rewrite for outside readers, with
concepts introduced before use and honest comparisons of fwp performance with
its baselines. Publication, fixes and squash merge after the required checks
remain authorized. The complete documentation bundle is
[PR #142](https://github.com/e6qu/fun-with-pipes/pull/142).

## Roadmap status

| Step | Status | Delivered scope |
|---|---|---|
| 1 | Verified | Documentation and session notes |
| 2 | Verified | Reference-counted memory |
| 3 | Verified | Less intermediate work |
| 4 | Verified | Derivatives of derivatives |
| 5 | Verified | Additional floating-point formats |
| 6 | Verified | Windows on both processor families |
| 7 | Verified | Smaller derivative workspaces |
| 8 | Verified | Less recorded derivative data |
| 9 | Verified | Fewer bookkeeping reallocations |
| 10 | Verified | Less bookkeeping search |
| 11 | Verified | Fewer derivative-buffer allocations |
| 12 | Implemented | Documentation for new readers; acceptance tracked by PR #142 |

## Accepted starting point

[PR #141](https://github.com/e6qu/fun-with-pipes/pull/141) merged as `41f30475`.
All nine production jobs and documentation passed at `f31f7b66`, which has the
same files as the merge. Four-platform derivative tests and both WebAssembly
checks passed at its runtime revision. [History](roadmap-history.md) keeps the
run links. The previous eleven-step implementation plan is complete; do not
repeat its old publication or merge instructions.

## Documentation rewrite

All 50 Markdown files (including the two new guides) have been revised. The
change also updates explanations in 17 hand-written example files and all 28
library module introductions; the generated REST client remains generated code.
Raw measurement JSON and immutable preparation IDs are unchanged.

- README, tutorials and example guide introduce notation, prerequisites, inputs,
  steps and output before advanced material. A glossary supports lookup.
- Compiler/memory/numerics guides explain current contracts and remaining costs.
  History preserves evidence without old active instructions. Windows and
  floating-point status now reflect accepted support.
- Benchmarks name C/Rust or fwp-only baselines, show signed extra time, and state
  timing/memory scope. The runner retains samples, compiler/CPU metadata and both
  ratios; CI publishes its readable report as an artifact.
- Library explanations come from `lib/*.fwp` and `tests/stdlib_doc.rs`, with
  `docs/stdlib.md` regenerated rather than edited independently.
- The review found and fixed a raw buffer leak in tutorial 9 and incorrect
  remainder distribution in tutorial 21. A 1001-cent/3-person transcript catches
  the latter. Tutorial 5 no longer presents an obsolete project-age example.

## Checks

All local workloads used `python3 scripts/local-guard.py`; no limits were raised.
The existing compiler binary was used only for focused example checks. Full CI
must rebuild and validate the published change.

| Check | Result |
|---|---|
| `python3 scripts/check-roadmap.py` through the guard | Passed: 50 link sets, 106 immutable preparation rows/tags, 12 plan steps, commit rules |
| Standalone `tests/stdlib_doc.rs` test, regenerated with `FWP_BLESS=1`, then checked without it | Passed; all 28 modules current |
| Standalone `tests/examples.rs`, `tutorial_readmes_match_their_programs` | Passed for every tutorial source/output copy |
| `rustfmt --check` for changed Rust and `rustc --test -D warnings tests/bench.rs` | Passed; benchmarks themselves remain runner-only |
| `target/debug/fwp fmt --check` on tutorials 5, 9 and 21 | Passed |
| Tutorial 9, `FWP_NO_OPT=1 ... run --interp` and native `run` | Both pass with unchanged expected output; buffer now freed after copying |
| Tutorial 21, raw-interpreter and native `exec ... split-bill 1001 3` | Both return 334, 334, 333 |
| `FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 FWP_TUTORIAL=21` standalone `tutorial_sessions` | Passed in 15.94 s under the guard |
| Final serial preflight `/private/tmp/fwp-docs-preflight.py` | Passed in 3.53 s; includes links, generated docs, tutorial copies, Rust formatting/compile and diff whitespace |

The first MCP transcript run failed because OpenSSL's prefix was unset and a
second displayed copy of the old bill order remained. Both were corrected;
the rerun above passes. No known local failure remains. Temporary standalone
harnesses are conveniences, not required project files; CI uses the checked-in
Rust test targets.

## Next action

Next: inspect [PR #142](https://github.com/e6qu/fun-with-pipes/pull/142) and its
checks for the current PR commit. If open, fix failures and require all nine
production jobs plus documentation before squash merge. If already merged with
those passing checks, step 12 is accepted and this documentation roadmap is
finished: do not republish the branch or repeat the old eleven implementation
steps. No further implementation work is queued by this plan.

The table records implementation status at publication; the PR's final checks
and merge record supply acceptance without requiring a new commit merely to
copy a transient CI status. Use the subject `Rewrite documentation and explain
benchmark costs` (one line), with an explicitly empty squash body. Old PR #141
checks do not validate this change. A future session should read the PR result
before treating this conditional next action as unfinished work.

Use `python3 scripts/local-guard.py COMMAND...` for focused local checks. Keep
full builds, suites, benchmarks and large regeneration on GitHub runners. Do not
raise fixed local resource limits or count skipped checks as passing support.
