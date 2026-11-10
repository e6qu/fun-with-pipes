# Current work

**Next:** finish the exact-final-head production matrix, docs and complete-log
audit for [PR #274](https://github.com/e6qu/fun-with-pipes/pull/274), repair any
failures, then squash-merge. All planned focused checks and measurements pass;
do not rerun unchanged timings.

Worktree: `.worktrees/application-milestone`, branch `application-tooling-costs`.
Preserve unrelated root-worktree changes. This final report batch changes only
docs/evidence. Measured source: `7a65a8bb2ac23df0554610dfb90609c5fed30ee8`, retained by
`roadmap/application-tooling-measurements-2026-11-10`. Compiler/runtime/application
and runner code are unchanged from `7fa50257155abf63fa220cd17f9500ea6d9bdd16`;
`7a65a8bb2` repairs the negative recursion fixtures and records earlier checks.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup repair | Recorded measurement limits still apply |
| 5 | In progress | Applications, compiler reports/growth, HTTP allocation/backpressure and all timed sessions | Exact-head final delivery gates |

#273 merged as `8887114f6ad3be3cd42d37b976ec208e27e4a5a2`. Its
[receipt](measurements/ownership-peer-final-gates-2026-11-09/README.md) retains all
nine production jobs, docs and complete-log audit at source
`0f3c0b94a1afa5b1e2c9b12435a2905532b0d072`.
Verified tag: `roadmap/ownership-peer-delivery-2026-11-09`.
Original milestone 1–3 timing limits remain open. After M5 delivery, follow
[PLAN.md](../PLAN.md): attribute compiler/library and service CPU costs before
selecting the next optimization; do not infer ARC cost from whole-service time.

## Verified M5 results

The [November 10 receipt](measurements/application-compiler-load-2026-11-10/README.md)
retains all ten complete focused logs, raw compiler samples/commands, HTTP
summaries/process traces and exact identities. All following runs pass at `7a65a8bb2`:

| Run | Coverage |
|---|---|
| Applications `42724971788` | Both hosts: all eight compiler-option tests, three SDK applications, eight integer tests, O0–O3 C/object reports; AMD64 browser |
| Compiler timing `42725018602` | Two sessions per host; all 48 case/session copy controls pass; identical C and checked execution for all 1,728 builds including warmups |
| HTTP timing `42725023571` | Two sessions per host; all 34 trials, including two five-minute soaks; 26,807,548 attempts including warmup/late replies, zero failures |
| Documentation `42724948809` | Pass |

Independent local audit recomputed all compiler medians/noise controls and all
HTTP RSS/CPU traces. Each trial's sampled server RSS is flat. Type checking is
the largest fwp phase; GCC dominates the largest declaration/generic builds.
Keep different host CPU models separate. Raw HTTP attempts stay in the identified
CI artifacts until February 8, 2027; the receipt explicitly distinguishes those
archives from permanently tracked samples/summaries. No new peer-overhead claim.

## Repairs and original evidence

- [Initial applications](measurements/application-workflows-2026-11-09/README.md):
  scripted REPL mode, integer formatting and saved-source audit repairs.
- [Preparation](measurements/compiler-http-preparation-2026-11-09/README.md):
  independent generic uses incorrectly hit a global cap; the measured HTTP source
  needed an explicit long-lived connection policy.
- [Repaired correctness](measurements/compiler-http-checks-2026-11-09/README.md):
  all twelve growth sizes, early/late errors, allocation and slow-client cleanup
  pass. The remaining recursive test omitted `rec`; both corrected fixtures now
  reach the expansion bound and pass in `42724971788`.

Superseded production `42721961219` tested `16e19fd9dbbdbcfb18e06e3d80b986a8a6504968`.
Both Windows logs failed only on that missing-`rec` fixture. All completed targets
and available full logs were audited. Initial cancellation was rejected by
approval review. After `7a65a8bb2` had its own nine-job matrix and those failures
were audited, cancellation of the superseded run was approved and completed.

## Final CI

Production `42724948766` tests `7a65a8bb2`: benchmark passes; eight native jobs
are still running without a reported failure at this report's preparation.
The new documentation/evidence commit needs its own nine jobs and docs gate;
record their IDs here after publication. Audit every failed step and completed
target before any repair push. Preserve the final head while gates finish.
Focused Linux passes do not establish final native platform delivery.

After all nine jobs and docs pass, dispatch `suite=production-log-audit` for the
exact source/run/attempt/documentation job. Merge only after that audit passes.
Use one squash subject ≤80 characters and an empty body; no trailers or
attribution. Verify the resulting message and tree, then continue PLAN.md.

## Local checks and limits

Use `python3 scripts/local-guard.py` serially. Rust formatting, actionlint,
Python syntax, compiler-accounting controls, HTTP-reader/sampler controls and
doc links pass (440 link sets, 106 immutable anchors, five roadmap rows).
All 251 receipt file hashes/sizes and all 34 exact request/response samples were
checked against staged bytes. This report also uses guarded `/tmp/fwp-analyze-m5.py` to
recompute all measurements and bounded ZIP readers to verify selected members.
No local fwp build, full suite or load measurement ran. Last free disk: 122 GiB.
Keep 64 GiB free, generated targets below 2 GiB, workload RSS below 1 GiB and the
180-second deadline. Full builds/suites/measurements stay on GitHub.
Dispatcher size: 502,964 bytes; limit: 512,000.
