# Current work

**Next:** finish [PR #275](https://github.com/e6qu/fun-with-pipes/pull/275):
monitor its nine production jobs and audit complete logs before squash merge.
Use one subject of at most 80 characters and an empty body; verify the resulting
message and tree. Keep four noisy growth comparisons open after delivery.

## Current branch and verified baseline

Delivery worktree `.worktrees/compiler-checking-costs`, branch `compiler-body-costs`.
PR #275 is open at `a232e1e35062a37aa013975ac77bbd8cb4620663`. Production run
`42767361217` is active; docs run `42767360650`, job `129666864000`, passes.
Keep its exact head stable. This separate worktree `.worktrees/service-cpu-costs`,
branch `service-cpu-costs`, prepares [service CPU attribution](measurements/service-cpu-costs.md).
No second PR or runtime change is introduced. Protocol commit `8fcea595d` is
published as `roadmap/service-cpu-protocol-2026-11-10`. Local preparation extracts
shared CPU readers and adds service/source accounting. Five compiler-reader and
five service-reader controls pass. Extraction caught a missed call signature/import;
both are fixed. Service controls caught valid C names (`f1`, `add`) being treated as
hex addresses; the reader now compares bare addresses with the recorded IP.
Native replay and service recording remain unverified; no workflow is dispatched.
Rebase preparation onto the verified squash after #275 merges.
PR #274 is merged as `e8997ac874f2c57009a5a13a7a5192c4f762272e`; its tree equals
passing source `9fdb5e7bd3b23e7a720c490c7b8a21a843b4221b`.
[All production/docs/audit gates pass](measurements/application-final-gates-2026-11-10/README.md).
The redundant post-merge run `42760668107` was cancelled to free six runner slots;
its complete logs are audited and retained. Interrupted uploads add no coverage.

## Compiler change and results

Candidate `c65ecb37691538ef5a24619376f68b1d243cbdea`, retained by
`roadmap/compiler-borrowed-types-2026-11-10`, borrows input type trees in
`free_vars` and `zonk`. Variable chains stay iterative; normalization, variable
order, rows, effects and diagnostics are preserved. Row flattening is unchanged.
Reference `35a12dfee0266134237d03d1262649be69df7c41` has ordinary compiler sources
identical to merged #274. Later branch commits retain evidence and clarify docs.

[Focused run `42763406320`](measurements/compiler-borrowed-types-2026-11-10/README.md)
passes ARM64 `129654174367` and AMD64 `129654174360`: seven type tests, eight
report/option tests, signature/error snapshots, sixteen exact-C comparisons and
all growth error locations. Both hosts remove the same 1.09–1.10 million copies
per application (29–32%), with unchanged visit counts and C. Separate observer
patch/source hashes and every complete log are verified.

[Timing run `42764964658`](measurements/compiler-type-time-2026-11-10/README.md)
passes its four execution jobs at that same candidate. Recomputed raw samples
verify all sixteen complete-application targets: word counting uses 11–14% less
emit-C time, callbacks 8–10%, numerical 5–7%, HTTP 3–4%. Peak RSS growth is at most
0.18% across all 64 comparisons. ARM64 uses Neoverse-N2; AMD64 session 1 uses
Xeon 8573C and session 2 EPYC 7763. Do not pool different CPUs.

Four AMD64 growth comparisons fail the frozen 2% copy-noise control: generic-8
in both sessions, generic-128 and nesting-8 in session 2. Retain those as
inconclusive, following the user's preference to keep verified gains while leaving
timing goals open. Do not weaken the [contract](measurements/compiler-type-walks.md)
or rerun unchanged noise to qualify it. All raw samples and failures are retained;
copy reductions do not imply lower allocation bytes or application runtime cost.

## Profiler and documentation repairs

[Replay `42763409910`](measurements/compiler-cpu-samples-2026-11-10/README.md)
passes AMD64 `129654190514` and ARM64 `129654190596`, reusing source `5cab084d5`
recordings from `42761474854`. Direct DWARF stack reading replaces the unavailable
parent column; explicit Ubuntu 24.04/perf 6.8 avoids the original libdw load-base
problem. A ten-second addr2line read deadline preserves the 120-second total limit.
All eight reports retain exact sample/period totals with no empty stacks. Unnamed
leaf frames account for 25–42% of periods; attribution is incomplete. Original
failed replays and the ineffective per-thread experiment remain retained.

The docs explain type variables/substitution with examples, remove stale #274
instructions, and distinguish measured gains from open acceptance. Recurring docs
CI now runs all three compiler measurement-reader control suites.

## Verification and local limits

Guarded local checks pass: sampling reader (5 controls), ordinary comparison
reader (4), growth reader (3), changed workflow lint, Rust formatting and roadmap
links. A renamed heading exposed one stale link; it was repaired. Small artifact
members passed CRC; source/observer hashes, schedules, counts and timing results
were rechecked. Full compiler builds, tests and measurements run only on GitHub.
The final staged documentation check passes: 452 document link sets, 106
immutable preparation anchors and all six milestone rows.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup; all gates | Recorded comparison limits apply |
| 5 | Verified | #274 applications, compiler reports/growth, HTTP load and pressure repair; all gates | Recorded observation limits apply |
| 6 | In progress | Borrowed types: native correctness, fewer copies and all application speed/memory targets | Four noisy growth comparisons; final delivery gates |

After delivery, attribute the queued service and HTTP cost to payloads, queues,
protocol work and cleanup before selecting another implementation. Keep the public
gradient API unchanged without representative evidence. Earlier noisy goals stay open.

Preserve unrelated root-worktree changes, old worktrees and handoff stash
`451bbf713d451f2d62d80fd7676839404875846a`. Local checks remain serial through
`python3 scripts/local-guard.py`: 64 GiB free, target data <2 GiB, sampled RSS
<1 GiB, 180-second deadline. Last disk check: about 114 GiB free. Never raise or
bypass limits. A guard serialization refusal earlier was resolved by waiting for
the previous download to finish; no limits changed.

The service collector and workflow are now prepared locally: 32 exact-output
controls, 16 large-case profiles, per-peer one-second calibration and independent
raw-record reconstruction. Shared CPU decoding preserves unresolved work. Guarded
controls pass (5 compiler-reader, 5 service-reader, 3 collection/audit), and changed
workflow lint passes. Mock platform/path/archive stubs were repaired before these
passes; no native collection has run yet. The emitted function table was checked
against retained generated C, and Swift demangling preserves the stack format.
Publish the observation source/tag and run its two native jobs plus compiler-profile
replay while #275 finishes; keep one active PR and do not restart #275's CI.
