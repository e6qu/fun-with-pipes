# Scalar arithmetic controls and rejected optimization

Active draft [PR #224](https://github.com/e6qu/fun-with-pipes/pull/224), branch
`proved-scalar-bounds`, is in `/private/tmp/fwp-scalar-bounds`. The experiment
used `08039d8698743116c31cc0b8929e705c3562f833`; the final batch removes both
compiler candidates and retains tests/evidence. No compiler speedup is accepted.

**Next:** monitor #224's final-head production and documentation gates, audit every
completed target and diagnostic, fix failures together, and merge only after all
nine production jobs plus documentation pass. The PR checks identify the run IDs.

## Final scope and evidence

The [proved-bounds experiment](measurements/proved-scalar-bounds.md) tested range
advances and bounded character sums, separately and together. Both candidates are
removed: stable text timings miss the unchanged improvement limits on ARM64 and
AMD64. AMD64 loop noise is inconclusive and remains visible. Compiler, runtime,
library and benchmark sources now match #223's verified merge.

Keep the new runtime endpoint tests for all twelve integer types, empty/descending
ranges, raw/optimized interpretation and native O0–O3. Callback/fold overflow and
overflow before integer display must still trap. The experiment's four compilers
passed all six integer-output groups, seven-peer checks and memory controls on
both hosts. Actual code, source patches, profiles, raw samples and logs are audited.
No compiler warning or failed test target remains in the qualified jobs.

Qualified jobs: ARM64 `123159395558` in `40786050786`; AMD64 `123161045925` in
`40786537977`, both at the experiment head. The first run's AMD64 job rejected
an unqualified Xeon 6973P-C before candidate execution; preserve its empty timing
record. Documentation `40786054592` passes, including the original six comparison
controls. Draft-skipped production is not acceptance of the final batch.

All observations and original peer/memory records are retained under
`docs/measurements/scalar-bounds-*.json`. The active reader checks source identity,
raw timing decisions and archive hashes. The closed build/measurement runner is
linked at its original source, not maintained as a command for reverted code.
The two older closed map-order/checked-bounds options and four stale readers are
also removed; their historical data and original script links remain.

## Checks

Guarded independent audits pass for both full artifacts: source patches/hashes,
168 timed peer images, 112 instrumented images, memory/stack records and raw
observations. Complete command logs contain no compiler diagnostics or failed
targets. The audit normalizes Git's seven-versus-eight-digit display abbreviations
while still verifying full source hashes; that presentation difference was not
a source mismatch. No downloaded native image was executed locally.

Seven local evidence-control groups now pass, including corrupted archive and
wrong compiler-source rejection. Rustfmt and final workflow lint pass. The doc check caught a missing
roadmap-status table during the rewrite; restoring its eight rows fixes it. The
172-link-set audit and exact CI record-verification command now pass. No
full local build, suite or benchmark. Preserve 64 GiB free disk, 2 GiB target,
1 GiB RSS and the guard's 180-second deadline.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | Verified | Maintain named A1–A6 guarantees |
| 3 | Verified | Maintain scoped F1–F3 call and recursion guarantees |
| 4 | In progress | Separate execution costs before the next measured repair |
| 5 | Pending | Derivative storage, timing and precision |
| 6 | Pending | CPU numerical kernels |
| 7 | In progress | Extend fixed baselines and integrity controls beyond these CPU cases |
| 8 | Pending | Larger-program correctness, cleanup and scale |

GC removal, named A1–A6 ownership work and scoped F1–F3 call/recursion work remain
verified. #223 establishes the two fixed CPU baselines and their integrity checks.
P2/P3 remains open: before another optimization, measure setup, calculation, output
and cleanup for the existing loop/text inputs and peers; keep instrumented
observations separate from unchanged whole-process timings. Broader baselines,
derivatives, CPU kernels and larger applications remain in [PLAN.md](../PLAN.md).

The historical Intel [compiler abort](measurements/compiler-abort.md) is still
unexplained. Diagnose recurrence from source/input; do not resume unproductive
disassembly-led allocator experiments.

## Recovery and delivery

#223 final `a4cceb8d` passes all nine production jobs `40771179934` and docs
`40771144344`, with every complete log audited. Squash `330a08939ea68a7967aecdc60a2c77ac9b55a1bb`
has the identical tree `e3774208e2da356915f479688e5839d37d404b79` and compliant
one-line message. Duplicate same-tree postmerge production `40785172656` was
cancelled; acceptance uses the audited premerge run. Postmerge docs passed.
[History](roadmap-history.md#fixed-cpu-baselines-pr-223) owns that record.

Raw current artifacts: `/private/tmp/fwp-224-arm-initial`,
`/private/tmp/fwp-224-amd-qualified`, `/private/tmp/fwp-224-amd-unqualified-1`.
Logs: `/private/tmp/fwp-224-*.log`; independent audit:
`/private/tmp/fwp-audit-scalar-session.py`. Earlier #221/#222/#223 evidence remains.
The primary checkout is detached at #209 with a recovery pointer and untracked
compiler-abort evidence; preserve both. #223's worktree is clean and retained.

Keep one published PR active. Publication and squash merge are authorized after
all final-head gates pass: explicit one-line subject <=80 characters, empty body,
no trailers/attribution. Verify tree/message and continue the roadmap.
