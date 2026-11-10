# Current work

**Next:** verify and repair HTTP backpressure on both Windows architectures,
finish the compiler-checking attribution, then publish their combined changes in
[PR #274](https://github.com/e6qu/fun-with-pipes/pull/274) for final native gates.
Audit all failures before the push. Merge only after nine production jobs,
documentation and the complete-log audit pass for that exact final commit.

Worktree `.worktrees/application-milestone`, branch `application-tooling-costs`.
The local branch combines the repair and `compiler-checking-costs` preparation;
the published PR still points to `a0261f9ccaa4a87651fbcae11966afee68208d4d`.
Preserve unrelated root-worktree changes and the preparation worktree's local
handoff. There is one active PR; no separate preparation PR.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup repair | Recorded measurement limits still apply |
| 5 | In progress | Applications, compiler reports/growth, HTTP allocation/backpressure and timed sessions | Windows pressure repair and exact-head final delivery |

#273 merged as `8887114f6ad3be3cd42d37b976ec208e27e4a5a2`; its
[receipt](measurements/ownership-peer-final-gates-2026-11-09/README.md) retains
passing source, all gates and audit. Original milestone 1–3 timing limits remain
open. Do not repeat unchanged noisy measurements to obtain qualification.

## Current failure and focused repair

Production `42730888995` at published head `a0261f9cc` is complete:
seven jobs pass; both Windows jobs fail only
`http_application::api_slow_clients_release_backpressured_output_o2`.
All nine complete logs have been inspected: no other failed target or compiler
warning. Docs `42730888467`, job `129548275958`, passes; deliberate runner-failure
controls are expected. The passing matrix-wide log audit has not been run.

[The repair contract](measurements/http-backpressure.md) records the exact
failure and acceptance. Both Windows server logs show eight connections waiting
for reads, no blocked writes and no first cleanup checkpoint. Do not infer a
runtime deadlock or accept absence of backpressure as a successful test.

- Original Windows jobs: ARM64 `129548282561`, AMD64 `129548282333`.
- Failure-group artifacts: ARM64 `13729108766`, AMD64 `13730116338`.
- Server artifacts: ARM64 `13729304404`, AMD64 `13730133131`; only small stderr,
  RSS and exit-status members were downloaded from these large archives.
- Original-send diagnostic: source `9054528ba`, immutable tag
  `roadmap/http-pressure-diagnosis-2026-11-10`, run `42742448906`, ARM64 job
  `129586576306`. It confirms one successful send of all 8,388,717 bytes;
  the small requested send buffer did not force a partial/blocked send.
  It also reproduces the diagnostic mutex-poisoning bug repaired below.
- Candidate: source `924eb8795`, tag `roadmap/http-pressure-bounds-2026-11-10`.
  Diagnostic sends are capped at 16 KiB; the unread Windows client requests and
  verifies a 256 KiB receive buffer. Same deadlines, exact bytes, real would-block
  branch, other-client progress and cleanup. Ordinary runtime writes are unchanged.
  Focused ARM64 `42744070652` and AMD64 `42744095817` are pending.
- Subsequent local `e58842d01` fixes diagnostic error reporting: clone the log
  before panicking, so the mutex is released and cleanup can retain evidence.
  This does not change the candidate's success path. Final gates must test it.
- Failure logs now publish before the next Windows test group.

## Completed measurements and prepared compiler work

[Application/compiler/load results](measurements/application-compiler-load-2026-11-10/README.md)
retain the original full source `7a65a8bb2ac23df0554610dfb90609c5fed30ee8`, ten
focused logs, all 48 compiler comparisons and 34 HTTP trials. All timed runs pass
at that source. Raw HTTP streams remain in identified artifacts until February 8,
2027. Keep CPU models separate and distinguish tracked summaries from archives.
No unchanged timing reruns are needed for the diagnostic-only transport repair.

[Initial checking attribution](measurements/compiler-checking-preparation-2026-11-10/README.md)
at `f43dfcd1c52292dfe84253cba5801bf3749597e6` passes application/report contracts
and all growth/error observations on both Linux architectures: runs `42736751196`
and `42737726682`. Library checking accounts for about 206–227 ms; ordering 3–5 ms.

[Complete applications](measurements/compiler-applications-2026-11-10/README.md)
at `ea531da149d085dbb146a64cd6ff1f92b61b170b`, run `42741790147`, also pass.
All eight ordinary/observed builds preserve exact C. Library checking costs
208–234 ms; the full HTTP compile costs 1.2–1.4 seconds. These single observations
are attribution, not speedup or observer-overhead measurements.

Finer parts (bodies, deferred operations, constraints, validation, generalization)
are prepared at `7761a41544c0c9538880f75cb5b1a177de3d2f6c`, tag
`roadmap/compiler-checking-parts-2026-11-10`, run `42743138148`. ARM64 job
`129588849571` and AMD64 `129588850096` both pass. They verify eight report
contracts at production Rust O1, then use release fwp on all four applications.
No solver algorithm or trait lookup changed. Select an optimization only from
attributed costs under the [investigation contract](measurements/compiler-checking.md).
The original coarse report's measured overhead does not cover these added spans.
The [receipt](measurements/compiler-checking-parts-2026-11-10/README.md) retains
both clean logs and all group partitions. ARM64 body checking is 156–158 ms;
AMD64 (different EPYC 9V45 host) is 105–110 ms. Bodies dominate, validation is
next. These are observed boundaries, not ordinary timings or function-level CPU
attribution. Keep the new observer's overhead explicitly unmeasured.

## Delivery and local limits

After final production/docs pass, dispatch `suite=production-log-audit` with the
exact source, production run/attempt, documentation job and `audit_host=all`.
Squash-merge with one subject of at most 80 characters and an empty body, without
trailers or attribution. Verify the merged tree/message and continue PLAN.md.

Guarded formatting, actionlint and roadmap checks pass for the repair/preparation.
No local fwp build or full suite ran. Keep local checks serial through
`python3 scripts/local-guard.py`; retain 64 GiB free, target data below 2 GiB,
sampled RSS below 1 GiB and the 180-second deadline. Do not raise limits.
