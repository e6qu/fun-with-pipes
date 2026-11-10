# Current work

**Next:** finish PR #274's exact-head production gates and complete-log audit,
then squash-merge and continue the compiler-cost investigation as the next
substantial PR. Keep one PR active; do not restart passing gates for status edits.

## Delivery: PR #274

- PR: https://github.com/e6qu/fun-with-pipes/pull/274
- Worktree `.worktrees/application-milestone`, branch `application-tooling-costs`.
- Source `9fdb5e7bd3b23e7a720c490c7b8a21a843b4221b`, tag
  `roadmap/application-delivery-format-2026-11-10`.
- Production `42749157893`, attempt 1: eight jobs pass; Windows AMD64 remains running.
  Docs `42749157995`, job `129608390924`, passes. No final-head failure reported.

| Gate | Job | Last checked state |
|---|---|---|
| C/Rust benchmark | `129608390557` | Pass; log audited |
| Linux ARM64 / AMD64 | `129608390602` / `129608390809` | Both pass; logs audited |
| macOS ARM64 regular / ownership | `129608390711` / `129608390510` | Both pass; logs audited |
| macOS Intel regular / ownership | `129608390783` / `129608390960` | Both pass; logs audited |
| Windows ARM64 / AMD64 | `129608390770` / `129608390842` | ARM passes and log audited; AMD running |

Known log messages: macOS OpenSSL already-installed notices; deliberate scheduler
panic and documentation failure controls. No unexpected diagnostic found in the
completed logs. Windows ARM64 passes the repaired backpressure test and all
remaining native groups, cleanup and packaging.

After all gates pass, dispatch `numerics.yml`, `suite=production-log-audit`,
`audit_host=all`, `source_revision=9fdb5e7bd3b23e7a720c490c7b8a21a843b4221b`,
`evidence_run=42749157893`, `production_attempt=1`,
`documentation_job=129608390924`. Inspect its retained audit before merging.
Use an explicit squash subject ≤80 characters and an empty body, no trailers or
attribution. Verify the merged message and tree against the passing source.
Retain the final receipt in the next coherent PR.

The [Windows repair receipt](measurements/http-pressure-repair-2026-11-10/README.md)
retains the original seven-pass/two-failure matrix, reproduction and both focused
repairs. The test now creates real backpressure instead of assuming an 8 MiB send
must block; ordinary runtime behavior is unchanged. The diagnostic panic releases
its log mutex before unwinding. Superseded `42747990312` failed only formatting;
all nine logs/docs were audited, and cancellation followed replacement-job creation.
The current source fixes that formatting; guarded whole-tree formatting passes.

## Independent preparation: compiler costs

Worktree `.worktrees/compiler-checking-costs`, branch `compiler-body-costs`, based
on the delivery source. No second PR and no compiler algorithm/runtime change yet.
Current preparation `35a12dfee0266134237d03d1262649be69df7c41`, tag
`roadmap/compiler-unwind-diagnosis-2026-11-10`.

- [Checking attribution](measurements/compiler-checking-parts-2026-11-10/README.md)
  passes both hosts: expression bodies dominate library-checking time. These are
  diagnostic spans, not measured ordinary-build overhead or speedups.
- [CPU recordings and repair history](measurements/compiler-cpu-samples-2026-11-10/README.md)
  retain failed attempts. Source `f7f4336f79ee3d76684cc77960ffb7fc0ef3a387`, run
  `42754692740`, records all four applications on both hosts with identical C.
  Perf's parent column does not cover DWARF-reconstructed callers.
- Direct-stack replay `42757176892` passes all ARM64 applications and AMD64
  callbacks. AMD64 words/numerical lack resolved body-checking callers; incomplete
  stacks remain explicitly unattributed, not discarded. Do not accept these
  profiles. Replay `42757980005` is queued. A new per-thread reader avoids shared
  unwind-cache state and retains the mixed-thread control; every original sample
  and per-thread period sequence must agree. Its native verification is pending.
  It does not compile or sample again.
- [Type-copy count](measurements/compiler-type-walks.md), run `42758033441`,
  independently observes the existing compiler on both hosts. It injects counters
  only in a separate checkout and requires identical generated C. This can verify
  copy costs while profiler diagnosis continues; it does not select an optimization.
  Inspect all four application counts and source patches before changing a walk.

Local guarded checks: six reader/flow controls pass, including child failures,
unknown/empty stacks, loss accounting and mismatched totals. The actual AMD64
saved reports confirm missing callers; they remain failures. Workflow lint and
roadmap links pass. Generated counter Rust parses and duplicate instrumentation
is rejected. No local compiler build, full suite or benchmark ran.

After merging #274, move preparation onto the tree-equivalent squash commit,
retain its delivery receipt, and use verified costs to freeze/select the compiler
change. Preserve the [correctness and timing contract](measurements/compiler-type-walks.md#acceptance-before-changing-a-walk).

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 documentation and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup repair; all gates | Recorded comparison limits apply |
| 5 | In progress | Applications, compiler reports/growth, HTTP load and Windows pressure repair | #274 final delivery |

#273 merged as `8887114f6ad3be3cd42d37b976ec208e27e4a5a2`;
[receipt](measurements/ownership-peer-final-gates-2026-11-09/README.md).
[Application/compiler/load results](measurements/application-compiler-load-2026-11-10/README.md)
retain all 48 compiler comparisons and 34 HTTP trials. Original milestone 1–3
timing limits stay open; do not repeat unchanged noisy runs to obtain acceptance.
Keep differing CPU models separate and observer overhead explicitly unmeasured.

Preserve unrelated root-worktree changes, old worktrees and handoff stash
`451bbf713d451f2d62d80fd7676839404875846a`. Local checks remain serial through
`python3 scripts/local-guard.py`: 64 GiB free, target data <2 GiB, sampled RSS
<1 GiB, 180-second deadline. Full gates, builds and measurements run on GitHub.
