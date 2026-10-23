# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Remove tracing; prefer
ownership, borrowing and moves; reserve ARC for necessary sharing. JIT is excluded.

## Accepted foundation

[PR #199](https://github.com/e6qu/fun-with-pipes/pull/199) is accepted and merged as
`aedafcd909b3bff01ca1a1da00d57cdcf0ba028e`. Nine production jobs and documentation passed at
`5e17fc10e860b1971ffc9cd9cb57fcb795ccad24`; all completed logs were audited. Inspection verified
570 saved binaries across six native hosts. The squash tree matches the tested
source and its message is one line with no body or trailers.
[History](https://github.com/e6qu/fun-with-pipes/blob/69c3b1e0135dd95961dba3729911ec27dc1736b6/docs/roadmap-history.md#checked-native-defaults-and-arc-metadata-pr-199)
and the [inspection record](https://github.com/e6qu/fun-with-pipes/blob/69c3b1e0135dd95961dba3729911ec27dc1736b6/docs/measurements/native-default-2026-10-23.json) preserve
the evidence. Checked native execution now defaults to ARC; explicit tracing
remains. This does not complete GC removal or prove universal zero-cost execution.

## Current delivery and next action

Worktree: `/private/tmp/fwp-post-default-ownership`, branch `post-default-ownership`,
based on the accepted merge above. The primary checkout is detached at that merge
and holds the live handoff. Keep one active PR. Preserve prior worktrees/evidence.

**Next:** audit final production run `39939679368` for
[PR #200](https://github.com/e6qu/fun-with-pipes/pull/200), exact source
`69c3b1e0135dd95961dba3729911ec27dc1736b6`, and inspect 175 saved images on each
of the six native hosts. Documentation run `39937419223` passed. Focused run
`39937418440` passed 69 integration tests across 24 targets, 179 library tests
and independent audits; its complete log has no errors or unexpected diagnostics.
All 175 focused GCC images passed inspection (26.09s), including 160 aggregate
cleanup outcomes and sixty allocator observations. PR #200 is ready and its full
production matrix is registered; the delivery worktree stays clean.

After all nine production jobs, documentation and binary reports pass, use
`/private/tmp/fwp-merge-200.py`; verify the one-line subject, empty body, tree and
sole parent, then continue PLAN.md. No approval is pending.

## Changes

Six existing probes now exercise ARC and tracing for nested constructors,
constructor allocation, call preparation, cancellation, result storage, variant
conversion and partial field acquisition. Each repeats 32 rounds; ARC must return
its managed byte charge to baseline with no wide counts or collections. Missing
final releases and old partial-cleanup failures remain deliberately failing controls.
Complete programs compare with raw interpretation at O1/O2. Stack settings and
memory modes are explicit. [The report](https://github.com/e6qu/fun-with-pipes/blob/69c3b1e0135dd95961dba3729911ec27dc1736b6/docs/measurements/record-cleanup.md) introduces
the value types, failure cases and measurement limits.

A constructor fixture had changed the environment-variable name selecting its
record case while substituting a function name. It ran the variant case twice.
The corrected placeholder and distinct expected statuses (14/4) prevent that
false pass. Windows gains the missing constructor-allocation target and binary
stdout; all six executable paths explicitly end in `.exe`. Focused CI selects
24 targets in both shell variants. Runtime rules and language syntax are unchanged.

## Verification

Local work uses `python3 scripts/local-guard.py COMMAND...`, serially. Full builds,
suites and measurements stay on GitHub. Preserve 64 GiB free disk, target data
below 2 GiB, sampled workload RSS below 1 GiB and the 180-second guard deadline.
Never raise or bypass limits.

Checks use the unmodified compiler/runtime package at
`/private/tmp/fwp-check-compiler-5e17fc10/fwp`, verified against accepted source
`5e17fc10e860b1971ffc9cd9cb57fcb795ccad24`, artifact `12490932313`, SHA-256 and ARM64 format:

- Sixty Apple Clang ARM64 probe images pass 76 observations, including missing
  releases, missing cleanup and the old wide-count error (25.38s/12.10s).
- Twenty-four complete ARC/tracing O1/O2 builds match raw interpretation (18.98s).
- The old constructor selector reproduces the wrong status in four controls;
  corrected record cases return 14 (2.83s).
- Saved source, C and binary hashes match all six probes. The suffix-only check
  verifies the final harness files while preserving original receipts (0.26s).
- Formatting, documentation, thirteen native-runner controls and Windows/focused
  scheduling pass (10.53s). The shortened handoff initially omitted the required
  roadmap status table; restoring its seven rows fixed the documentation failure.
  Rust harness execution and final platforms need CI.

Receipts: `/private/tmp/fwp-{constructor,variant}-current/results.json`,
`/private/tmp/fwp-constructor-programs-current/results.json`,
`/private/tmp/fwp-constructor-selector-current/results.json` and
`/private/tmp/fwp-constructor-current-proof-links-with-suffix.json`.
Earlier substituted-runtime checks are supplemental evidence, not current acceptance.

## Resume tools

`/private/tmp/fwp-publish-constructor-ownership.py` COMPLETED; do not rerun. It records
source, immutable tag, PR and dispatch state in
`/private/tmp/fwp-constructor-publication.json`. Read that receipt before any retry.
`/private/tmp/fwp-audit-constructor-focused.py` discovers the exact-source run and
audits its complete log and all 24 target completions.
`/private/tmp/fwp-discover-200-runs.py` and `/private/tmp/fwp-audit-200-final.py`
register and audit full validation. Discovery COMPLETED; the final audit is
ready to run repeatedly as jobs finish.
`/private/tmp/fwp-merge-200.py` is also UNRUN. It requires ten passing final
gates and six 175-image reports, then publishes the final plain-language body
and verifies the one-line squash message, tree and sole parent. All three parse
under the local guard (0.14s).
The live primary handoff passes `scripts/check-roadmap.py` through the guard (2.95s).
`/private/tmp/fwp-inspect-constructor-builds.py` checks 175 images per host: three
default builds, twelve allocator binaries and 160 aggregate cleanup outcomes.
It passed actual focused GCC artifact inspection; final platform artifacts
remain required.
`/private/tmp/fwp-ready-constructor-ownership.py` COMPLETED after checking the
24-target acceptance receipt and all 175 focused images. Do not rerun.
On macOS, general record copies, retain probes and result storage come from the
GC artifact; other aggregate probes come from the regular artifact.

Do not rerun completed mutation or publication helpers. The #199 merge and
post-merge receipts are `/private/tmp/fwp-199-merge.json` and
`/private/tmp/fwp-199-merge-runs.json`. Only redundant same-tree main production
CI may be cancelled; keep documentation and never cancel an unresolved failure.

## Following batch in preparation

`/private/tmp/fwp-post-constructor-collections`, branch
`post-constructor-collection-ownership`, starts from `69c3b1e0`. It is not
published. Four probes now cover repeated ARC/tracing cleanup for loop preparation,
map, filter/take-while and zip-with, including cancellation, allocation failures,
aliases and scalar address bits. Missing final releases, missing temporary-buffer
releases and missing loop cleanup remain deliberately failing controls.

Thirteen related probes now save generated C, binaries and unexpected output
before asserting success; formerly the early assertion lost failure artifacts.
This changes harness ordering, not their C fixtures or runtime behavior.
Focused CI expands from 24 to 28 targets; all are already selected on Windows and
in exactly one macOS shard. The new collection cleanup guide defines the concepts
and explains an executed failure example. PLAN.md and ownership links are updated.

Checks use the accepted 5e17fc10 compiler with its unchanged embedded runtime:

- `/private/tmp/fwp-check-loop-current.py`: sixteen ARM64 images (9.69s), including
  four complete O1/O2 programs matching raw interpretation.
- `/private/tmp/fwp-inspect-loop-current.py`: saved hashes, architecture and
  ARC/tracing symbol controls; formatting passes (1.12s). This receipt predates
  the harness-order repair, whose unchanged C is checked below.
- `/private/tmp/fwp-check-collections-current.py --test map`, `--test selection`
  and `--test zip`: 48/48/60 ARM64 images, including twelve complete programs
  (30.56s/30.86s/38.23s). All positive and deliberate-failure outcomes pass.
- `/private/tmp/fwp-check-collection-proof-links.py`: generated C and binaries
  match the final Rust fixtures; thirteen final harness hashes are recorded,
  and the order-only repair leaves their C unchanged (0.26s).
- `/private/tmp/fwp-check-collection-docs.py`: formatting, links (including the
  untracked guide), thirteen runner controls, 28-target scheduling, macOS/Windows
  coverage and the guide's interpreter/native example pass (12.38s).

Reports: `/private/tmp/fwp-loop-current/{results,inspection}.json`,
`/private/tmp/fwp-collections-current/{map,selection,zip}/results.json`,
`/private/tmp/fwp-collection-current-proof-links.json`. The guide example lives in
`/private/tmp/fwp-collection-doc-example`. Rust harness and full native execution
remain CI requirements. Field/match aliases and reuse-token probes were only
reviewed; do not describe them as implemented changes or verified extensions.

`/private/tmp/fwp-prepare-loop-ownership.py` and
`/private/tmp/fwp-prepare-collection-ownership.py` COMPLETED; do not rerun.
`/private/tmp/fwp-collection-save-order-before.json` preserves pre-repair harnesses.
`/private/tmp/fwp-inspect-collection-builds.py` is a separate syntax-checked
next-batch inspector (0.13s): 331 saved images per host, including 316 aggregate
outcomes and fifteen default/allocator images. It still needs actual CI-artifact
validation. On macOS the loop and selection probes use the GC artifact; map and
zip use regular artifacts. Keep PR #200 unchanged while its gates run.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |

The [plan](../PLAN.md) remains the backlog: remove tracing at remaining boundaries,
extend borrowing, reduce measured numerical costs, improve differentiation and
CPU kernels, establish dependable performance budgets and finish the application
acceptance suite. The largest measured descent case still takes about 10–14 times
the C/Rust time; fewer allocations alone do not establish parity. No numerical
optimization was selected by the failed inlining experiment.
