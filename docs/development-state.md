# Session handoff

All seven PLAN.md areas remain open. Remove tracing, prefer ownership and borrowing,
and reserve ARC for necessary sharing. JIT is excluded.

## Current action

**Next:** finish this grouped formatter/output delivery: audit all nine final-head
production jobs and documentation, then inspect the native binaries. Require
7,158 saved files: 6,966 ownership/cleanup files, 72 float cases and 120 Linux
output/lifetime controls. The publication receipt under `/private/tmp` records
the final source, PR and run IDs; preparation evidence does not replace them.
Squash merge only after final acceptance, with one subject at most eighty
characters and an explicit empty body. Continue the roadmap after that merge.

Worktree `/private/tmp/fwp-float-delivery`, branch `float-output-delivery`, is based
on verified #204 squash `2ba458a9a8049a33c2fa5c73a374c83c8fe34e10`.
Compiler/runtime, language tests, measurement scripts and workflows match
preparation `d7ad3e55f38685d3abaaa9c87badc3a8fc4a045f`, apart from removing one
extra final blank line in the frozen test oracle. The local resource guard
also repairs an exit/signalling race; six regression and disk tests pass with
all resource limits unchanged.
Documentation includes its accepted measurements and #204's final evidence.
Local source identity, roadmap/link, Python syntax and workflow checks passed
(3.13s). The guard repair passed six tests (1.65s); repeated inspection then
passed all 120 AMD64 binaries (13.68s). Real permission failures still stop work.
All inspected preparation ZIP caches were pruned after checking remote originals.

Use `fwp-float-delivery-publication.json`, `fwp-audit-float-delivery-final.py` and
`fwp-inspect-float-delivery-{ownership,text,controls}.py` under `/private/tmp`.
`fwp-merge-float-delivery.py` requires every final gate and inspection before its
one-line squash; `fwp-after-merge-float-delivery.py` verifies the primary guard
repair before preserving the handoff and advancing to that merge.

## Scope and verified preparation

The formatter reuses already-rounded scientific digits for fixed decimal output.
The [report](measurements/float-text-results.md) explains why this saves work,
all input timings, matching-model acceptance, the remaining C/Rust gap and the
larger stack/code costs. Allocation counts and per-solve live storage are unchanged.
Six native jobs pass at `550ef3157720`; twelve saved cases per host cover exact
ordinary/JSON output, rounding and deliberately corrupted results. The first
Windows attempt found an LF-only summary assertion; its repaired line parser
passes both Windows hosts. Runtime and measurement sources did not change.

Timing sources `5476466183f7` and `d7ad3e55f386` have identical runtime and benchmark
inputs. Runs `40027402138`, `40027406689`, `40032008445` retain five measurements,
including unmatched CPU models. Matching pairs satisfy the original 2% copy-control
limit and 5% largest-case reduction on both architectures. All 600 timing/control
images and 72 native correctness images passed independent binary inspection.
The first mixed workflow retains its old Windows failures; its timing jobs passed.
Later six-host correctness evidence verifies the repair. Do not label that entire
initial workflow successful or replace final-head gates with preparation evidence.

The [output diagnostic](measurements/descent-output-longer.md) separately compares
ordinary printing with a shared checksum consumer. It passed 676 binary checks;
nine of twelve input/host pairs pass repeated controls. Three smaller AMD64 pairs
remain inconclusive and cannot set budgets. Initial results and all samples remain
linked. Checksum work is not pure arithmetic or isolated formatting time.

## Accepted preceding delivery

[PR #204](https://github.com/e6qu/fun-with-pipes/pull/204) passed nine production
jobs, docs and 6,966 binary inspections at `80c89baa53567839dce0599d88f18d5791285943`.
[History](roadmap-history.md#derivative-storage-arrays-and-borrowed-callbacks-pr-204)
and the [inspection record](measurements/derivative-array-cleanup-2026-10-24.json)
retain source, merge, logs and six-host outcomes. Cleanup checks remain required
when the runtime changes; they do not establish complete removal of tracing.

## Resume rules

Use `python3 scripts/local-guard.py COMMAND...` serially; full builds, suites and
benchmarks stay on GitHub. Keep at least 64 GiB free disk and never raise limits.
Read receipts before mutations. Preserve failure evidence, unique results and
immutable source tags; prune only inspected duplicate caches after remote checks.
Keep one active PR. Publication and squash merge after passing final gates are
authorized; every commit is one line, at most eighty characters, without trailers
or attribution. Python package initializers stay empty; imports stay at file top.

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
