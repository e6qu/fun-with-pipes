# Current work

**Next:** verify the corrected recursive-expansion fixtures, then complete the
frozen compiler and HTTP timing sessions in the same PR. Audit every current job
before batching repairs; retain failed/noisy results unchanged.

Normal [PR #274](https://github.com/e6qu/fun-with-pipes/pull/274) is open.
Worktree: `.worktrees/application-milestone`, branch `application-tooling-costs`.
Preserve unrelated root-worktree changes. This batch changes tests/docs only;
compiler, runtime, applications and measurement runners remain at verified source
`7fa50257155abf63fa220cd17f9500ea6d9bdd16`. Record the new head/runs after publication.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup repair | Recorded measurement limits still apply |
| 5 | In progress | Application workflows, compiler reports/growth, HTTP allocation/backpressure controls | Recursive negative fixture, timed sessions, final delivery |

#273 is merged as `8887114f6ad3be3cd42d37b976ec208e27e4a5a2`. Its
[receipt](measurements/ownership-peer-final-gates-2026-11-09/README.md) retains all
nine production jobs, docs and complete-log audit at tested source `0f3c0b94a1afa5b1e2c9b12435a2905532b0d072`.
Verified tag: `roadmap/ownership-peer-delivery-2026-11-09`. Do not repeat unchanged
experiments to obtain qualification; original milestone 1–3 limits stay open.

## Focused results at `7fa502571`

| Run | Result |
|---|---|
| Applications `42721015315` | Both hosts: seven compiler-option tests pass; one recursive fixture fails before specialization because it lacks `rec`. All three SDK applications, eight integer tests and O0–O3 inspection pass; AMD64 browser passes. |
| Compiler growth `42721021055` | Both hosts: all twelve sizes, exact ordinary/observed C and outputs, early/late type errors pass. The 512-type regression is repaired. |
| HTTP `42721026186` | Both hosts: actual API request check, driver failure controls, exact allocation/cleanup, disabled counter and slow-client backpressure pass. |
| Docs `42721032218` | Pass |
| PR docs `42721961173`, head `16e19fd9dbbdbcfb18e06e3d80b986a8a6504968` | Pass; only documentation differs from `7fa502571` |

[The retained receipt](measurements/compiler-http-checks-2026-11-09/README.md)
contains all six native logs, selected artifact members and independent HTTP
record re-audits. No other compiler warnings or failing targets were found.
Original [application](measurements/application-workflows-2026-11-09/README.md)
and [growth/connection-policy failures](measurements/compiler-http-preparation-2026-11-09/README.md)
remain retained. Superseded `3bd0a9f0c` runs `42718472554`, `42718478175`,
`42718483690`, `42718488627` were cancelled while wholly queued.

The new test repair adds `rec` to both direct and mutual generic recursion
fixtures. It now gathers both diagnostics before asserting, so one failure cannot
hide the other. Rust formatting passes; corrected native execution is pending.
The earlier failure did not exercise the compiler's expansion bound.

## Production CI

Run `42721961219` tests PR head `16e19fd9d`; it is still running and contains the
known fixture error. Audit completed targets and all failures. Automatic approval
review rejected cancelling this active run because it would discard in-progress
verification; leave it intact. New repair pushes must not cancel it indirectly.
No final delivery claim is established by focused Linux checks.

## Remaining measurements and delivery

1. Verify both corrected recursion cases. Keep bounded expansion, source locations,
   ordinary/report equivalence and the verified 512-type breadth case.
2. Freeze the source and run two compiler sessions per Linux host under the
   [protocol](measurements/application-tooling.md): separate fwp from GCC time,
   retained raw reports, identical-copy controls and process memory. Growth
   correctness prerequisites pass; no timing session has run yet.
3. Run two HTTP sessions per host: 1/8/32/64 connections, two 30-second windows
   each, and one 300-second soak per host. The correctness prerequisites pass.
   Keep ordinary timing separate from allocation and pressure instrumentation.
4. Retain/audit reports, update this PR and docs, then require nine production
   jobs, docs and complete-log audit at the exact final head. Squash-merge with
   one line ≤80 characters, empty body and no trailers/attribution; verify the
   resulting tree and message.

## Local checks and limits

Use `python3 scripts/local-guard.py` serially. Rust formatting, actionlint, Python
syntax, compiler-accounting controls, HTTP-reader/sampler controls and doc links
pass. Bounded artifact reads verified selected ZIP members; both HTTP check
summaries were reconstructed from retained compressed attempt records. No local
fwp build, full suite or load measurement ran. Last free disk: 122 GiB.
Keep 64 GiB free, generated targets below 2 GiB, workload RSS below 1 GiB and the
180-second guard deadline. Full builds/suites/measurements stay on GitHub.
Dispatcher size is 502,964 bytes; keep it below 512,000.
