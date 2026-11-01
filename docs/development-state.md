# Current work

**Next:** audit PR #237's exact-head nine production jobs and documentation.
The PR is ready and published; use its check URLs to follow the current head.
Fix all failures in one repair batch; squash-merge only after every gate passes.

Worktree `/private/tmp/fwp-returned-callables`, branch `reduce-derivative-ownership`.
Base `658123c7c09aa8991ca69cbb82643e68244edc95`. The primary checkout has unrelated
local changes; preserve them. Implementation, publication and squash merge are
authorized. Commit messages: one line, at most 80 characters, empty body/trailers.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | Implemented | Broad docs/tutorial revision and local audits complete; final-head docs/native example gates pending |
| 2 | Implemented | All three focused hosts pass stack-record controls; full final-head matrix pending |
| 3 | Implemented | All three focused hosts pass adjoint, alias, failure and cancellation checks; full matrix pending |
| 4 | In progress | Audit nine production jobs plus docs, then squash-merge |

## What changed

- Typed F128/nested derivative recording borrows direct outer argument records;
  retained weight children keep their independent owners.
- Initial adjoints borrow the tape-owned exact zero. Distinct owned input results
  move into list cells, protected through allocation failure.
- All 24 tutorials have additional worked traces/tables/diagrams. Lesson 1 teaches
  `let … in …` as one expression and runs chained, nested and shadowed bindings.
- Terminology, reference, parser/pipeline, memory limits and benchmarking explain
  concepts before use. All 28 library introductions were revised through source
  comments and regenerated. Historical prose is shorter; raw evidence and frozen
  criteria remain. Stale delivered/pending claims were corrected.
- Scope and acceptance: [PLAN.md](../PLAN.md) and the
  [typed-derivative protocol/results](measurements/typed-derivative-owners.md).

## Native checks and evidence

Focused run [41290359214](https://github.com/e6qu/fun-with-pipes/actions/runs/41290359214)
passes at `c5acb7d980a0efba9505b5edc4a37802337cad4f`:
Linux ARM64/GCC 13.3, Linux AMD64/GCC 15.2 and macOS ARM64/Clang 23.1.4.
Every host passes eight affected targets, ownership unit checks and primitive
inventory. All job logs and completed targets were audited; no compiler warnings
or unexpected failures. Thirty image/source hashes and native architectures,
84 typed-probe outcomes and all static-frame reports were independently checked.
[Saved observations](measurements/typed-derivative-owners-2026-11-01.json.gz)
retain source/run/artifact identities and the measurements. No speed claim.

First run `41289222076` at `5f1741624834da7ded8e4990ef3bc3245ac8aacd`
failed only the two new probes on all hosts. A source marker matched four sites;
a capacity query omitted immutable heap records. `c5acb7d9` repairs both observers
without runtime changes or relaxed limits. Existing targets passed throughout.
Details and distinct negative-control statuses are in the linked report.

Documentation runs `41288414731`, `41289225334` and `41290361065` pass and their
logs are audited. Deliberate duplicate/unknown/failing/hung runner controls are
expected, not unresolved failures. Draft production skips do not count as gates. Initial ready run `41291903384`
and docs `41291886572` target `d36dc26a`; the final command-path/handoff correction
supersedes that head. Follow the newer exact-head checks, not those old statuses.

## Focused local checks

All workloads use `python3 scripts/local-guard.py`; full builds/suites stay on CI.
The sandbox initially denied `ps`; the same unchanged guard ran with permission.
No resource limit was bypassed. Free disk remains about 65 GiB, near the 64 GiB floor.

| Check | Command after the guard | Result |
|---|---|---|
| Links, preparation records, plan | `python3 scripts/check-roadmap.py` | 195 docs, 106 immutable pairs, four steps pass |
| Rust formatting | `cargo fmt --all -- --check` | Pass |
| Library docs | Standalone O1 `tests/stdlib_doc.rs`; `FWP_BLESS=1` regeneration, then ordinary check | Pass; standard-library-only harness, no compiler rebuild |
| Tutorial listings/output copies | Standalone O1 `tests/examples.rs`, exact `tutorial_readmes_match_their_programs` | All pass |
| Lesson 1 results | `env FWP_NO_OPT=1 /private/tmp/fwp-236-786-mac-package/fwp-macos-arm64/fwp run --interp docs/tutorials/01-pipes-and-functions/main.fwp` | Matches `main.out`, including 7/16/4; 0.10 CPU seconds |
| Tape example and typed fixtures | Same verified raw interpreter | `[6.0]`; both typed fixtures `True` |
| Artifact audit | `python3 /private/tmp/fwp-237-audit.py` | 0.10 CPU seconds; hashes, headers, outcomes and frames pass |

Standalone Rust harnesses use O1, debug assertions and overflow checks. Binaries
are `/private/tmp/fwp-237-{stdlib-doc,tutorial-doc-check}`. This does not replace
new-source native verification. Earlier direct F128 relinking omitted its math
archive and produced no executable; the successful runner checks use the complete
toolchain. Full logs/ZIPs are `/private/tmp/fwp-237-retry-{mac,arm,amd}.*`.

## Baseline and remaining goals

PR #236 passed nine production jobs `41272009971` and docs `41271982217`.
Tested `f89ef8a597d9ba64b0b0de165e7c21cc9f787494` and merge
`658123c7c09aa8991ca69cbb82643e68244edc95` share tree
`3ea5adc038b819c9a6e5b722d0dd41ca4437485f`; the one-line squash was verified.
[History](roadmap-history.md#local-names-and-allocation-optimizations-pr-236) owns details.

D2/N1/N2 timing requirements and original Xeon closure regressions remain open.
Preserve inconclusive copy controls, array-traversal allocation savings and Swift's
separate allocator/managed-memory accounting; individual Swift ARC counts are
unmeasured. The Intel compiler abort remains unexplained: diagnose a recurrence
from source/input, not speculative disassembly-led changes.
