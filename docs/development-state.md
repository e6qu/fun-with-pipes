# Next: finish derivative recording and accuracy

**Next:** audit repeated-solve run `40829884152` at
`a31f24c4fdc215383cc61d95f6f6d743e66cb1a3`, replace its rejected AMD session with
an independently qualified run, and freeze D1's comparison limits. Then implement
and measure the D2 scalar `ad.push` no-escape contract and finish D3 per-depth costs.
Worktree `/private/tmp/fwp-ad-recording`, branch `ad-recording-costs`; draft PR #226.

## Current measurements

Run `40829884152` at a31f: ARM sessions 1/2 (123301407687/123301407660) and
AMD session 1 (123301407679) passed. Their full logs and 3,471 artifact identities are audited, including every
output, process sample, binary, stack report and deliberate-failure control.
Identical-code median variation is below 1% in these three sessions.
AMD session 2 (123301407651) rejected an EPYC 9V74 before building; the required
host is EPYC 7763. Replacement job 123315775454 qualified and is measuring at the
same source (attempt 2). Preserve every host rejection and timing observation.

The [derivative report](measurements/descent-costs.md) fixes inputs, repeated-solve
counts, complete-output checks and the 2% identical-code control. Three audited
repeated-solve reports await the fourth qualified session. Earlier grouped-process run `40822958582`, source
`b1ca235415d4d2caabdb4f568d9300cf50a59400`, passed all four matching-host jobs;
its audited archive retains 4,628 file identities, 80 images/68 stack reports per
session, and noisy controls. Grouping alone did not establish comparison budgets.

## Verified preparation, not final platform acceptance

Source `a31f24c4` passes focused run `40829434472`: jobs 123299993842 (AMD) and
123299994082 (ARM). Each passes 221 library units, two F64/F128 precision tests,
15 callback-effect tests, type/interpreter snapshots, native O1/O2 nominal
selection, formatting and 14 measurement-control tests. Full logs are audited:
`/private/tmp/fwp-nominal-a31f-{arm,amd}.log`. Four ignored library tests are not
counted as passes; G2 explicitly exercises its two budget tests separately.

G2 run `40829442112` passes Linux job 123300017881 and Intel macOS 123300017458:
221 units, all-target Clippy and both unchanged budget tests. Audited logs:
`/private/tmp/fwp-nominal-a31f-g2-{linux,macos}.log`. The 64-worker separate/merged
medians are 1.526/1.053 ms (Linux) and 3.984/2.923 ms (macOS), below the 1.5 ratio
limit. Both use nine waves. Forms/entry analysis is 0.279/0.175 s and 0.436/0.305 s,
below 10 s each. These are compiler-analysis observations, not program speedups.

The incidental inference repair keeps immediate selector fields and shared type
variables. Nominal constraints preserve names through aliases; infinite phantom
types still fail. Three focused production type-table tests also pass locally.
The earlier delayed-selector attempt (`9d843129`, run `40826160826`) and query
attempt (`61689688`, run `40827556438`) failed in io/websocket/rest and were removed.
`226a2b40`, run `40828555694`, passed precision/effects/native selection; only the
old anonymous `Acc` display snapshot failed. The updated snapshot and dedicated
native output/overflow test pass at a31f. Logs for each attempt remain in `/private/tmp`.

## D3 depth evidence

Run `40834762049` at `89bbec5bdb18fbda92a27f011983d77ca9628bb9` passes native
ARM job 123316848991 and AMD job 123316849123. All 18 cases, 74 images, 76 stack
reports, command outputs, analytical results, memory ledgers and both deliberate
leak controls per host are audited. [The report](measurements/ad-depth.md) owns
the counts, costs and archived logs; all 4,390 file identities are retained.
Source, raw interpreter and native ordinary/profile outputs agree. Final ledgers
are zero. Timings are diagnostic, not speedup claims. Full production acceptance
remains pending for the grouped PR.

The failed b349 run `40833238845` missed the owned backward observer hook; its
F64 cases and F128 output/final totals passed. The repair requires one real release
checkpoint per derivative level. ZIPs/logs remain at
`/private/tmp/fwp-depth-{b349,89bb}-{arm,amd}.{log,zip}`. A guarded Clang O2 depth-3
probe also passed; no complete local suite was run.

## Prepared D2 changes: do not publish the future assertion yet

Runtime `ad.push` copies four scalar fields and retains no record address.
Its argument is the selected stack-allocation candidate; `ad.push-owned` is excluded.
No ownership contract has changed. The paired measurement and its fixed
acceptance limits are prepared: 5% less time with updates, at most 2% regression
without updates, exact recording fixture plus per-node allocation savings,
unchanged raw storage and bounded code/stack growth. Reference and candidate
compilers use the same source, differing only in the scalar no-escape fact. Three local files are deliberately uncommitted:

- `tests/fixtures/ad_scalar_recording.fwp`: 256 recorded identity operations,
  differentiating the final node. Raw interpretation returns 1.
- `tests/fixtures/ad_unwind_probe.c`: overwrite the caller's record, then seed its
  recorded node; this extends existing failure/cancellation/retirement controls.
- `tests/ad_tape_ownership.rs`: future O1/O2 test expects 256 heap argument records
  with stack storage disabled and zero with it enabled. Current code still has
  256 in both modes. Publish the zero assertion only with the no-escape contract.

The exact fbed macOS compiler and a guarded Clang O2 probe establish that baseline:
256 calls, 256 argument records, derivative 1, no live managed storage or tapes.
Files `/private/tmp/fwp-ad-scalar-{baseline,observed}.c`; observed executable shares
that stem. The repaired compiler has not run this D2 test. After the contract,
check primitive inventory, scope/failure/cancellation/nesting, counts, code/stack
costs and D1 timing limits. Bundle all into one substantial PR.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain F1–F3's stated call/recursion scope |
| 4 | Verified | Selected decimal cost delivered; loop gap remains recorded |
| 5 | In progress | D1 fixed limits, D2 stack arguments, D3 per-depth costs |
| 6 | Pending | N1–N2 numerical kernels |
| 7 | In progress | Broader B1/B2 comparisons |
| 8 | Pending | V1–V2 application validation |

## Completed delivery and recovery

PR #225 merged as `6735c4e3841ad4991f99c3c413daeb9d432c709c` after all nine
production jobs `40821277777` and docs `40821277750` passed and every log was
audited. Test head fbed and squash share tree `f70bc35d25a9e8fb566ed085f8afab65fb2a9f48`;
message verified one line, empty body, no trailers. Duplicate push CI `40830143795`
was cancelled. [History](roadmap-history.md#decimal-counting-and-current-derivative-baselines-pr-225)
owns the counts and outcome. Merge e5c7f75f brings main into this branch without
changing a31f's tree; measured source identity is preserved.

Read PLAN.md for remaining D/N/B/V work; GC removal and A/F guarantees remain
verified, not universally allocation-free. The older Intel compiler abort remains
unexplained. Preserve the primary checkout's untracked compiler-abort report.
Primary checkout stays detached at #209 with a recovery pointer; cpu-phases is
completed delivery, ad-refresh is retained evidence. No agents.

All local checks use `scripts/local-guard.py`, serially: 64 GiB free, target <2 GiB,
RSS <1 GiB, 180 seconds. About 68 GiB free, no local build tree. Full work runs on
GitHub. Source formatting and the 176-link-set/106-anchor/8-step docs audit pass.
