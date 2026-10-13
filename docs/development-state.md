# Session handoff

Updated 2026-10-13. The original implementation roadmap is complete through
PR #128. PRs #129–130 delivered the final docs, tacit examples and macOS CI
partition repair. The active user-approved bundle is iteration and record
projections. Read [PLAN](../PLAN.md), [design](design.md) and
[ownership](ownership.md); [history](roadmap-history.md) preserves completed
work and evidence. The immutable [queue](roadmap-queue.md) supplies no new task.

## Accepted baseline

Main is `db10b9fd9849446475a68caaf832f17bfe76ba9e`, PR #130's squash.
Tested head `13886787b5b96c195595ad57b3a1f2689c2d7889` and squash have identical
complete tree `efd9d775b616e59074a9efdb0f04fc128f5706e8`. All six jobs in
CI 38312668875 and roadmap_docs 38312668877 passed before merge. The signed
one-line message is `Clarify tacit examples and balance macOS test coverage`.
All 170 ordinary integration targets actually ran once per macOS architecture,
across regular/GC shards. Each GC job also ran its separate stress test.
Main roadmap_docs 38317942639 passes; duplicate main CI 38317942712 was
cancelled after tested-tree parity and supplies no additional passing gate.

ARC support remains the proved immutable graphs and scoped File owners.
Unproved mutable cycles, boxed I128/U128, raw reverse-mode tapes/pointers and
foreign/deployment boundaries remain rejected. No universal speedup is claimed.
Measurements and actual-source acceptance are linked in the ownership docs.

## Remaining ownership deliveries

None. All six original implementation phases are accepted. Do not reopen
archived preparations. Windows, new deployment interfaces and a new backend
remain deferred.

## Active bundle

Branch: `iteration-and-record-projections`, based on the baseline above.
The user accepted all recommendations after the prefix/piped discussion:

- Keep prefix calls and infix pipes, explicit `const`, and both `if`/`match`.
  Colon application and implicit/indented argument grouping remain set aside.
- Add `iter.fold`, `iter.each` and `iter.find` using existing loops, without
  building intermediate lists. Callback effects finish before forcing a tail;
  `find` and failures leave the next tail unforced.
- Add list `fold-until`, returning the state from `Stop` or the current state
  on exhaustion. Lists are still evaluated eagerly before traversal.
- Add `map-accum`: state precedes the element; callbacks return
  `(mapped value, next state)`, and the API returns `(mapped list, final state)`.
- Add `make { .field }`, including nominal builders. The parser expands to
  the existing selector field. Nested and numeric paths need explicit names;
  other record forms keep explicit assignments. Existing canonical label
  evaluation order remains unchanged.

Implementations, explicit generic/Dup/effect signatures, 12 library tests,
two golden programs, raw-interpreter/effect/long-traversal integration checks,
parser/formatter regressions and reference updates are prepared. Canonical
formatting abbreviates identity fields in six existing library/example/tutorial
files. Tutorial excerpts and generated stdlib docs are updated. No new runtime
primitive, implicit conversion, or fusion eligibility rule is introduced.

## Validation so far

All local workloads run serially through `python3 scripts/local-guard.py`:

- Focused current-source parser/formatter harness: 10 tests pass (0.92s sampled
  CPU / 1.78s elapsed). It includes exact value-formatting helper source;
  the first harness compile missed that dependency and was corrected.
- Canonical formatting plus AST preservation/idempotence for library,
  examples, tutorials and benchmarks: pass (17.30s CPU / 34.55s elapsed).
- `/private/tmp/fwp-check-iteration-bundle.py`: raw interpreter/native probes
  agree for both golden programs (3.07s CPU / 6.11s elapsed). The available
  compiler predates this bundle: new library definitions were prepended, and
  shorthand was explicitly expanded. Current-source parser tests cover the
  expansion; full combined validation still requires CI. An initial expected
  record effect order was corrected to the observed existing canonical order.
- Focused 12 new library tests pass in both engines; new fixtures formatted
  and generated stdlib reference regenerated (1.43s CPU / 3.02s elapsed).
  No full compiler build, full suite or benchmark ran locally.

- Five new IO omission checks reject as intended; tutorial source excerpts
  match and the documentation audit passes (44 doc link sets, 106 immutable
  queue pairs/tags, zero live ownership rows). A trailing blank line found
  by the whitespace check was removed.

## Published head and next action

PR #131: https://github.com/e6qu/fun-with-pipes/pull/131.
Initial head: `cd5a918dbba4e5d7febcd081db4893f96b6bcb7a`.
CI 38321908920 was still running and roadmap_docs 38321908967 passed when
review found an additional parser edge case. Selectors can spell keywords,
constructor names, a lone underscore and digit-prefixed text that are not legal
named output fields. Shorthand now rejects those spellings, with regressions;
ordinary identifiers including `if`, `_private` and `first-name` remain valid.
Publish the repair and require a fresh complete matrix at its exact head.
The earlier run does not establish acceptance of this repair.

The guarded native representation probe
`python3 scripts/local-guard.py python3 /private/tmp/fwp-inspect-iterator-code.py`
passes (0.99s CPU / 2.35s elapsed). An argument-controlled fold over 100 elements
returns 4950. Generated C and ARM64 Mach-O disassembly show a fixed-frame loop,
but also record allocations and dynamic callback dispatch. This uses the
available compiler with the new definitions; it is not exact-head compiler
acceptance or a zero-allocation/speedup claim. Evidence:
/private/tmp/fwp-iterator-code/{fold.fwp,fold.c,fold,fold.disassembly,fold.symbols}.

Monitor all six exact-head platform jobs. Long traversals, GC stress and
reuse verification remain pending there. Fix failures and keep this handoff
current; queued or failed CI does not block useful work. Merge only after all
required gates pass, using a one-line subject <=80 characters and empty body.
The standing authorization covers publication, fixes and squash merge.

## Recovery

Durable recovery branch: `roadmap/handoff-pr123-20261011`; last verified
checkpoint `3af176bc210cd9de367bbdf98d2eb49b2626098f`, audit 38285912566.
Its validated restoration covers 275 targets / 31127348 bytes. Query the branch
tip on recovery and use current-map.json with its designated publisher; never
rerun completed publishers. Restore temporary evidence only through the
hash-checking restore-roadmap-recovery.py procedure. PR #130 proof files use
/private/tmp/fwp-tacit-examples-* and /private/tmp/fwp-pr130-* prefixes.
