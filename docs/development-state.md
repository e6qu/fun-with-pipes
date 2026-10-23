# Session handoff

All seven PLAN.md areas remain open. Remove tracing, prefer ownership and borrowing,
and reserve ARC for necessary sharing. JIT is excluded.

## Current action

**Next:** publish the explicit single-host formatter measurement selector and run
one additional AMD64 comparison. The first two AMD64 runs used different CPU
models, so they do not yet meet the predeclared matching-model rule. Preserve both
results and the unchanged protocol. Inspect the completed second ARM64 artifact.
Keep one active delivery PR; prepare the next grouped delivery after #204 merges.

Worktree `/private/tmp/fwp-float-format`, branch `float-format-preparation`, is at
`550ef3157720127c7064aa349e569ebe819a344d`, with only workflow/docs edits pending.
The selector accepts `all`, `ubuntu-latest` or `ubuntu-24.04-arm` explicitly.
It avoids repeating accepted ARM64 work or correctness checks for an AMD64 timing
repetition. Unsupported selections fail. Runtime, tests and measurements are unchanged.

## Active delivery

[PR #204](https://github.com/e6qu/fun-with-pipes/pull/204) remains at
`80c89baa53567839dce0599d88f18d5791285943`. Seven production jobs and documentation
passed full-log audits; Linux AMD64/ARM64 are still running. Exact-head gates are
production `40019873535` and docs `40019873426`. Require all nine production jobs,
docs and 1,161 saved files per host (6,966 total) before squash merge.

Mac ARM64 inspection passed all 1,161 files. Its two ZIP caches were pruned after
remote verification. Intel GC archive `12533329161` is downloaded; the regular
Intel and both Windows artifacts are now available. Finish those inspections,
then inspect the Linux artifacts when their jobs pass. The delivery worktree is
clean. Publication receipt and helpers use the `fwp-derivative-array-` prefix in
`/private/tmp`; merge and post-merge helpers remain UNRUN.

[PR #203](https://github.com/e6qu/fun-with-pipes/pull/203) is verified merged at
`3e3ebd2717f4d77c8d8331e7df1936768546d1ed`: all gates, complete logs and 5,118 binary
inspections passed. Its redundant main CI was cancelled; docs were retained.
[History](roadmap-history.md#tasks-state-and-runtime-call-cleanup-pr-203) records it.

## Formatter checks and timing

The candidate reuses rounded digits when formatting fixed decimal text. Integer
and scientific output retain their existing paths. [The protocol](measurements/float-text.md)
explains the example, comparison, output contract and fixed acceptance screen.

Source `550ef3157720127c7064aa349e569ebe819a344d`, run `40028991372`, passed all six
native correctness jobs, complete logs and 72 independent binary inspections.
The two Windows jobs at initial source `5476466183f7adc663d54dc69118fdb69225f8f8`
failed an LF-only test assertion despite zero numerical mismatches and boundary
writes. All targets were audited. The repair parses one summary line, accepts
platform line endings, and saves all six precision/control cases before reporting
collected failures. Native reruns verify it. No runtime or measurement change was
needed. Failure evidence and both immutable tags are retained.

Timing uses source `5476466183f7adc663d54dc69118fdb69225f8f8`, runs `40027402138`
and `40027406689`. All four measurement jobs passed. The first run has 240 actual
binary inspections accepted; the second AMD64 job has 120 accepted. All six inputs
pass both noise controls in these three inspected jobs. Largest-case ratios of
current/original fwp time are 0.7115 on EPYC 9V74, 0.7274 on EPYC 7763 and 0.6798
on Neoverse-N2. Require a matching AMD64 pair and the second ARM64 inspection
before accepting repeated gains. Do not relax the 2% noise limit or 5% target.

Costs must accompany gains. In the first GCC runs, formatter frames grow
224→256 bytes on AMD64 and 208→288 on ARM64; surrounding writer frames stay
720/704 bytes. Whole-program instruction bytes grow 33,010→33,826 and
30,972→31,516. Allocation and live-memory observations match between formatters.
The first current programs still take 9.47/9.95 times C/Rust time on AMD64 and
7.12/8.24 on ARM64. This is an improvement candidate, not C/Rust parity.

Receipts `fwp-float-preparation.json` and `fwp-float-repair-publication.json` record
completed publication. Use `fwp-audit-float-focused.py`, `fwp-inspect-float-checks.py`
and `fwp-inspect-float-costs.py`; reports are in `fwp-float-check-evidence` and
`fwp-float-cost-evidence`. Read receipts before any mutation; do not repeat completed
publication, recording or pruning. Download archives explicitly before inspection.

## Accepted diagnostic

[Longer output measurements](measurements/descent-output-longer.md) at
`a948b7478278a6ee8c5b81cfaf6e8272e96bf935` passed runs `40024299907`, `40024303916`,
complete-log audits and 676 binary inspections. Nine of twelve input/host pairs
pass both runs' controls on matching models. AMD64 3–0, 3–1 and 3–199 remain
inconclusive. The report retains every sample and explains the different output
work and memory scopes; it does not claim isolated formatting time.
The [initial result](measurements/descent-output-initial.md) retains its five
inconclusive rows and 338 inspected files. Inspected duplicate ZIP caches were
pruned only after checking digests and unexpired remote originals.

## Resume rules

Use `python3 scripts/local-guard.py COMMAND...` serially. Full builds, benchmarks
and suites stay on GitHub; never raise resource limits. Keep failure evidence,
source tags, logs and reports. Publication and squash merge are authorized after
final acceptance: one subject of at most eighty characters, empty body, no trailers
or attribution. A preparation run never replaces the final delivery matrix.

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
