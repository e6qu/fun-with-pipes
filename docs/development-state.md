# Current work

**Next:** run and audit both focused Linux application jobs plus documentation
for the combined milestone 5 repair at the current branch head. Then implement compiler-phase reporting
and the sustained HTTP protocol in this same substantial batch. Keep one active PR.

Worktree: `.worktrees/application-milestone`, branch `application-tooling-costs`.
It is rebased onto merged #273, `8887114f6ad3be3cd42d37b976ec208e27e4a5a2`.
There is no open milestone 5 PR yet. Preserve unrelated root-worktree changes.

## Verified delivery

[PR #273](https://github.com/e6qu/fun-with-pipes/pull/273) is merged. All nine
production jobs, documentation and the complete-log audit pass at
`0f3c0b94a1afa5b1e2c9b12435a2905532b0d072`:

- Production `42689448177`, attempt 1; documentation `42689448429`, job `129404997478`.
- Full audit `42704685230`, job `129458290946`, artifact `13712907583`.
- The [retained archive](measurements/ownership-peer-final-gates-2026-11-09/README.md)
  verifies all ten reports, source IDs, logs and artifact digests. No unresolved
  diagnostics. Verified source tag: `roadmap/ownership-peer-delivery-2026-11-09`.
- Squash commit message: `Measure ownership costs and fix consuming entry cleanup`.
  Exactly one line, under 80 characters, no body or trailers. Its tree matches
  the tested head. Do not rerun unchanged comparison timings for qualification.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 documentation refresh and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons, parser cleanup repair, all delivery gates | No remaining delivery gate; recorded measurement limits still apply |
| 5 | In progress | Application protocol, walkthroughs, initial SDK/browser/inspection checks | Combined repairs, compiler phases/scaling, sustained HTTP load, final delivery |

The [application/compiler/load plan](measurements/application-tooling.md) fixes
inputs and measurement scopes. No compiler-phase timings or sustained-load
results exist yet. Callback-service measurements still show 18.65–20.23× C time
and 5.12–6.70× Swift time; attribute payload/queue/effect/channel costs before
choosing a shared optimization. A 16-byte weak-lookup result alone does not
explain the complete service gap.

## First milestone 5 checks and current repairs

Published preparation `d11df79f042c7af01c93a6fd3ce59568b28e3624` is retained by
`roadmap/application-tooling-preparation-2026-11-09`. It predates the rebase;
its source tree is preserved. Focused run `42704406738` fails on both hosts:
AMD64 job `129457305054`, ARM64 `129457305122`. Documentation `42704411415`
also fails. All failed steps and completed jobs have been inspected.

- Real AMD64 notebook browser checks pass for all three applications: input
  edits, stale/error states, explicit effects and source-only save/reopen.
- SDK application checks require `repl --stream` for scripted input. They used
  terminal-only `--no-history`; the diagnostics correctly rejected that setting.
  The word-count notebook/debugger checks and earlier native executions pass;
  do not claim unexecuted checks after a method's first failure.
- Both word-count files need the short `main` pipeline on one line.
- O3 generated-code inspection exposes a GCC `-Wstringop-overflow` diagnostic
  in `fwp_fmt_u128`, inlined through signed/duration formatting. The 128-bit
  domain has at most 39 decimal digits; the old loop did not expose that bound.
  The repair bounds conversion by 39 digits and gives duration formatting a
  41-byte signed-number buffer. Caller capacities were sufficient; no actual
  overflow has been demonstrated. New independent decimal-boundary/canary
  checks cover signed/unsigned extremes, zero and durations at O0/O1/O2/O3,
  compiling with warnings as errors. Native verification is pending.
- The historical direct-string audit compared archived benchmark source with
  today's example. It now reads the exact recorded Git source. All eight
  controls pass locally for ARM64 session 1, including rewritten sources with
  matching manifests being rejected. Other sessions run in documentation CI.
- Inspection now reports all application diagnostics before failing instead of
  stopping at the first application. Original failed logs/artifacts are retained
  by their run IDs; compact local records are under `/tmp/fwp-m5-*`.

Rebased preparation commits: `804c81967`, `d6ca10020`, `ce88409b7`. The combined
repair follows them on this branch. Resolve its exact head and fresh run IDs;
do not use the failed preparation run as acceptance. Keep the immutable tag
and original failures. Native verification of the repair is still pending.
No final milestone 5 production matrix has run yet.

## Local verification and resources

Use `python3 scripts/local-guard.py` serially. Python syntax, actionlint, Rust
formatting and 436 documentation link sets pass, including the new delivery
receipt; all 106 immutable anchors and five roadmap rows pass. One historical evidence session passes
all eight controls. The final #273 archive matches its 1,173,657-byte size and
SHA-256, and all ten reports pass verification.

The bounded AMD64 artifact stream hit the 180-second deadline; it was stopped.
The repair workflow reads those previous diagnostics on a runner instead.
No local compiler build, full suite or benchmark ran. Full/native checks remain
on GitHub. Preserve 64 GiB free disk, 2 GiB target data, 1 GiB workload RSS and the
180-second deadline. The numerical dispatcher is 502,359 bytes; keep it below
512,000. Record any guard refusal and move the affected work to runners.
