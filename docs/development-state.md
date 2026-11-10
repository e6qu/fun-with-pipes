# Current work

**Next:** obtain function-level compiler CPU samples on both native Linux
architectures under the [checking contract](measurements/compiler-checking.md#next-cpu-samples-inside-checking).
This branch is preparation only; do not open a second PR while
[PR #274](https://github.com/e6qu/fun-with-pipes/pull/274) completes delivery.
Its nine production jobs, documentation and complete-log audit must pass for
the exact final source before squash merge. Preserve that source while it runs.

Worktree `.worktrees/compiler-checking-costs`, branch `compiler-body-costs`,
based on delivery source `9fdb5e7bd3b23e7a720c490c7b8a21a843b4221b`.
The application worktree owns final delivery. This preparation changes only
measurement scripts/workflows/docs: no compiler algorithm or runtime change.
Use the new `compiler-sampling` suite on this branch; retain all four original
applications, raw recordings and unknown samples. Review actual hot functions
before selecting an optimization. Parser controls and workflow lint pass locally
under the guard; no local fwp build or full suite ran.
Current profiler repair: `f7f4336f7`, immutable tag
`roadmap/compiler-cpu-flow-2026-11-10`, run `42754692740`.
Both native jobs recorded all four applications but caller attribution failed.
Replay source `63ae40d08`, tag `roadmap/compiler-user-stacks-2026-11-10`,
run `42757176892`, decodes these existing recordings on both hosts.
`perf report --parent` does not attach parents reconstructed from DWARF user
stacks; a direct `perf script` reader is prepared, retaining all samples and
cross-checking their counts/periods against the original flat report. Replay the
existing recordings on runners; no compiler rebuild or new timing is needed.
Replay passes ARM64's four applications. AMD64 callbacks pass; the other three
contain empty unwind cursors. Retaining their periods exposes a second limitation:
word counting and the numerical input have no decoded body-checking caller at all.
Do not accept those profiles. The next replay retains verbose unwind diagnostics,
without rebuilding or sampling. Five reader controls and workflow lint pass.
Windows ARM64 now passes too; its log contains only deliberate scheduler panic
controls, with all tests passing. Six production jobs and docs now pass.
The obsolete `42753509308` was cancelled after
publishing the bookkeeping fix; its ARM64 failure is audited and its queued
AMD64 job is not a pass. [The checking contract](measurements/compiler-checking.md)
records all earlier source IDs and repaired causes. The latest local regression
exercises every application and continuation after a deliberate child failure.

The next [type-copy investigation](measurements/compiler-type-walks.md) is also
prepared. It builds ordinary and counted copies of the same source, injecting
counters only in a separate diagnostic checkout. Generated observer Rust parses,
double instrumentation is rejected, workflow lint and documentation links pass
under the guard. No compiler optimization has been implemented or selected from
these incomplete caller profiles. Once native profiling passes, dispatch
`compiler-type-walks` on this preparation branch and inspect all four application
counts on both architectures before changing a type traversal.
Preserve unrelated root changes and the saved preparation handoff stash
`451bbf713d451f2d62d80fd7676839404875846a`.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup repair | Recorded measurement limits still apply |
| 5 | In progress | Applications, compiler reports/growth, HTTP load and verified Windows pressure repair | Exact-head final delivery |

#273 merged as `8887114f6ad3be3cd42d37b976ec208e27e4a5a2`; its
[receipt](measurements/ownership-peer-final-gates-2026-11-09/README.md) retains
passing source, all gates and audit. Original milestone 1–3 timing limits remain
open. Do not repeat unchanged noisy measurements to obtain qualification.

## PR #274 final gates

Current published source: `9fdb5e7bd3b23e7a720c490c7b8a21a843b4221b`, retained by
`roadmap/application-delivery-format-2026-11-10`. Preserve this head.
Production `42749157893`, attempt 1, has all nine jobs; docs `42749157995`, job
`129608390924`, passes. Benchmark `129608390557` passes. Both complete logs are
clean apart from deliberate documentation failure controls. All four macOS jobs also pass. Both Linux and both Windows jobs remain running;
Windows ARM64 has passed the repaired TLS/executable group. No final-head
failure is reported. Audit each completed log and preserve the delivery head.

| Gate | Job |
|---|---|
| Linux ARM64 / AMD64 | `129608390602` / `129608390809` |
| macOS ARM64 regular / ownership | `129608390711` / `129608390510` |
| macOS Intel regular / ownership | `129608390783` / `129608390960` |
| Windows ARM64 / AMD64 | `129608390770` / `129608390842` |

After these pass, dispatch `suite=production-log-audit`, `audit_host=all`, with
that exact source, run, attempt and docs job. Only then squash-merge with one
subject of at most 80 characters, an empty body and no trailers or attribution.
Verify the merged tree/message and continue this preparation against merged main.

## Repairs already included

- The original full matrix at `a0261f9cc` (`42730888995`) passed seven jobs;
  both Windows jobs exposed an invalid backpressure-test assumption. Winsock
  accepted the whole 8 MiB response despite a small requested send buffer.
  The diagnostic test now bounds sends and verifies its receive buffer, retaining
  real blocked-write events, exact output, progress and cleanup requirements.
  Both native Windows focused repairs pass: 11 HTTP tests, all six blocked-write
  cohorts, 72/72 sockets closed and zero final managed bytes. The
  [repair receipt](measurements/http-pressure-repair-2026-11-10/README.md) retains
  all original logs, reproduction, exact sources and both repaired results.
- A diagnostic timeout now releases its log mutex before panicking, avoiding
  poisoned cleanup. Formatting that panic is the only change from `88a303659`
  to the current final source. Guarded whole-tree formatting passes.
- Superseded production `42747990312` was cancelled only after all replacement
  jobs existed. Its nine logs and docs are audited: four identical formatting
  errors, requested cancellations and missing not-yet-created artifacts; no
  additional test or compiler failure. Earlier passes do not verify the new head.

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
