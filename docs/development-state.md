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

Final head: `a0261f9ccaa4a87651fbcae11966afee68208d4d`.

- Production: `42730888995`: benchmark job `129548282228` passes; its complete
  log has no failure or compiler warning. macOS ARM64 ownership job
  `129548282212` and regular job `129548282408` also pass, both full logs
  audited clean. Both Intel macOS jobs also pass with clean full logs.
  Both Linux jobs also pass with clean complete logs: ARM64 `129548282407`,
  AMD64 `129548282206`. Windows ARM64 job `129548282561` failed its
  `Native TLS and executable ownership` step; later checks continue. Its full
  log is not available until completion (API 404); watch the failure artifact
  published after command tests and audit every failed target before repairing.
  Artifact `13729108766` identifies one failed test:
  `http_application::api_slow_clients_release_backpressured_output_o2` timed out
  waiting for a blocked-write marker at line 613. All other completed TLS-group
  targets pass without compiler warnings. Root cause not yet established.
  Local commit `9054528ba`, tag `roadmap/http-pressure-diagnosis-2026-11-10`, adds
  socket-send/round diagnostics and publishes failure logs before command tests.
  Only the tag was pushed; PR still tests `a0261f9cc`. Focused Windows ARM64 run
  `42742448906`, job `129586576306`, is pending. Do not infer an implementation
  fault or relax the test deadline without the actual send/progress evidence.
  Windows AMD64 artifact `13730116338` shows the same single failed test; the
  rest of that completed group is clean. ARM64 has finished; its complete job
  log has no other failed target or compiler warning. Small files read from
  artifact `13729304404` show round zero never reached a cleanup checkpoint:
  all eight connections wait for reads, none for writes. A single large send
  being accepted into transport buffers is the current hypothesis; the isolated
  diagnostic will report each send's actual result.

  Prepared repair candidate: cap diagnostic sends at 16 KiB and explicitly set
  and read back Windows clients' receive-buffer request of 256 KiB. Continue to
  require real would-block/readiness, exact payloads, other-client progress and
  cleanup with the same deadlines. This changes test transport pressure only,
  not ordinary runtime sends or throughput measurements. Native checks pending.
  Candidate tag `roadmap/http-pressure-bounds-2026-11-10` points to local commit
  `924eb8795`; focused ARM64 `42744070652` and AMD64 `42744095817` are queued.
  [Repair contract and exact failure](measurements/http-backpressure.md).
- Documentation: `42730888467`, job `129548275958`: passed. Complete log
  inspected: only the deliberate runner-failure/timeout controls; no unexpected
  failure or compiler warning.
- Superseded `42724948766` at `7a65a8bb2`: benchmark passed and was audited;
  no failed steps in the other jobs. Cancellation was approved after all nine
  final-head replacement jobs existed. All eight cancelled-job logs are now
  audited: only requested cancellations, no test failures or compiler warnings.

Audit every failed step and completed target before any repair push. Preserve
this final head while gates finish. Focused Linux passes do not establish final
native platform delivery.

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

## Isolated next preparation

While final CI waits, branch `compiler-checking-costs` in
`.worktrees/compiler-checking-costs` prepares nested type-checking observations
and their contract. It has no PR. Source
`f43dfcd1c52292dfe84253cba5801bf3749597e6` is published for focused verification
in run `42736751196` (`application-tooling`, both Linux hosts). Formatting and
the roadmap audit pass. Focused verification now passes on both Linux hosts,
  including all eight compiler-option contracts and AMD64 browser checks; both
  full logs are clean. Inference is unchanged. Release growth attribution runs
  in `42737726682` at tag `roadmap/compiler-checking-preparation-2026-11-10`.
Finish #274 before publishing another PR. The preparation handoff records its
remaining diagnostic/application work; it is not a delivered optimization.
