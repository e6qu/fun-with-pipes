# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Remove tracing; prefer
ownership, borrowing and moves; reserve ARC for necessary sharing. JIT is excluded.

## Accepted foundation

[PR #199](https://github.com/e6qu/fun-with-pipes/pull/199) is accepted and merged as
`aedafcd909b3bff01ca1a1da00d57cdcf0ba028e`. Nine production jobs and documentation passed at
`5e17fc10e860b1971ffc9cd9cb57fcb795ccad24`; all completed logs were audited. Inspection verified
570 saved binaries across six native hosts. The squash tree matches the tested
source and its message is one line with no body or trailers.
[History](roadmap-history.md#checked-native-defaults-and-arc-metadata-pr-199)
and the [inspection record](measurements/native-default-2026-10-23.json) preserve
the evidence. Checked native execution now defaults to ARC; explicit tracing
remains. This does not complete GC removal or prove universal zero-cost execution.

## Current delivery and next action

Worktree: `/private/tmp/fwp-post-default-ownership`, branch `post-default-ownership`,
based on the accepted merge above. The primary checkout is detached at that merge
and holds the live handoff. Keep one active PR. Preserve prior worktrees/evidence.

**Next:** publish this constructor/variant cleanup group as a draft, run the
24-target GCC check, audit its entire log and inspect all 175 saved images. Then
run all nine production jobs plus documentation on the exact final source and
inspect all six native hosts. Squash-merge only after every gate passes, using
one subject of at most eighty characters and an explicit empty body. Continue
PLAN.md after the verified merge. No approval is pending.

## Changes

Six existing probes now exercise ARC and tracing for nested constructors,
constructor allocation, call preparation, cancellation, result storage, variant
conversion and partial field acquisition. Each repeats 32 rounds; ARC must return
its managed byte charge to baseline with no wide counts or collections. Missing
final releases and old partial-cleanup failures remain deliberately failing controls.
Complete programs compare with raw interpretation at O1/O2. Stack settings and
memory modes are explicit. [The report](measurements/record-cleanup.md) introduces
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
  scheduling pass (10.55s). Rust harness execution and final platforms need CI.

Receipts: `/private/tmp/fwp-{constructor,variant}-current/results.json`,
`/private/tmp/fwp-constructor-programs-current/results.json`,
`/private/tmp/fwp-constructor-selector-current/results.json` and
`/private/tmp/fwp-constructor-current-proof-links-with-suffix.json`.
Earlier substituted-runtime checks are supplemental evidence, not current acceptance.

## Resume tools

`/private/tmp/fwp-publish-constructor-ownership.py` publishes once and records
source, immutable tag, PR and dispatch state in
`/private/tmp/fwp-constructor-publication.json`. Read that receipt before any retry.
`/private/tmp/fwp-audit-constructor-focused.py` discovers the exact-source run and
audits its complete log and all 24 target completions.
`/private/tmp/fwp-inspect-constructor-builds.py` checks 175 images per host: three
default builds, twelve allocator binaries and 160 aggregate cleanup outcomes.
It is syntax-checked; validation against new CI artifacts is still required.
On macOS, general record copies, retain probes and result storage come from the
GC artifact; other aggregate probes come from the regular artifact.

Do not rerun completed mutation or publication helpers. The #199 merge and
post-merge receipts are `/private/tmp/fwp-199-merge.json` and
`/private/tmp/fwp-199-merge-runs.json`. Only redundant same-tree main production
CI may be cancelled; keep documentation and never cancel an unresolved failure.

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
