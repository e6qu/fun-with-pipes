# Current work

**Next:** monitor [PR #271](https://github.com/e6qu/fun-with-pipes/pull/271), run all
nine final-head production jobs plus docs, audit every completed log/artifact, then squash-merge
with a one-line subject (at most 80 characters) and empty body. Fix any failure
before merging. Do not repeat completed timings to obtain better results.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | #270 delivered the docs refresh and fresh F64 stores; original AMD timing acceptance stays open. |
| 2 | In progress | Captured maps pass native safety and measurement audits; final production delivery and noisy timing acceptance remain open. |
| 3 | Pending | Compare structured autodiff on neighboring pairs, independent losses and a dense coupled objective. |
| 4 | Pending | Update Swift/C/Rust ownership comparisons with separate time and memory boundaries. |
| 5 | Pending | Three application/tooling paths, compiler phase/scaling costs and demonstrated usability repairs. |

## Workspace and scope

Branch `captured-array-map-reuse`, worktree `.worktrees/recording-capacity-gate`.
Base `f87796b52081889b96859dbd72bf4af9a6726207` is merged PR #270. Preserve unrelated
root-worktree changes. Initial head `6605c3608d56c249136fea335efb605b56fe3c8d`
started production run `42482278753` and docs `42482278727`. A final docs review
found the benchmark guide incorrectly calling a fixture-only gradient helper
public. Correct that statement and the numerical guide, then cancel superseded
jobs once the corrected head's matrix is queued. Keep that head stable afterward.

Known scalar captures now pass directly to a consuming array map. Capture values
are saved once at the original binding; other closure uses remain valid. Only the
last array argument is consumed. Exclusive arrays can supply output storage;
nonempty aliases and views preserve their original data. Empty ordinary arrays
transfer unchanged, including shared inputs. Empty views release their backing
owner. There is no language API or syntax change.

## Verified results

| Evidence | Source / run | Outcome |
|---|---|---|
| Expanded ownership and identity checks | `4da9011873ce7cc6f67af71448cd3591c1d5562c`; `42477156079` | ARM GCC `128720938985`, AMD GCC `128720938835`, macOS ARM Clang `128720938966` pass: 57 native tests in ten targets and 14 units per host, nine bounded analysis rows. |
| Complete focused audit | `42478473189`, job `128724990571`; repeated in `42479872910`, job `128729288911` | All identity logs, 444 probe outcomes per host and actual native image checks pass. [Retained evidence](measurements/captured-map-empty-checks-2026-11-08/README.md). |
| Repaired measurements | `c8611f5e67c773a1d380255eb0c49088424325b8`; `42479872910` | ARM1 `128729874165`, ARM2 `128729874189`, AMD1 `128729874176`, AMD2 `128729874145`: all 48 cases and complete observation audits pass. |
| Documentation | Same measured source; `42479874918`, job `128729292696` | Passes. Full log reviewed, including expected failure-propagation controls. |

All completed native and measurement logs were reviewed; no unresolved compiler
warnings/errors remain. The workflow verifies compiler/native-fixture identity
against the passing safety run before measurements. The [complete report](measurements/captured-map-repaired-2026-11-08/README.md)
retains both sessions per architecture and exact source/toolchain identities.

- Both largest 199-update applications qualify in every session: 84–94% less
  computation than the same-source reference without captured-map selection.
- Allocations fall from 600 to 401; sensor requested bytes fall from 419,441,600
  to 2,105,168. Managed peak roughly halves. Final live storage is zero.
- Remaining loop-state/step boxes account for 400 requests; the input array adds
  one. Payload extraction still retains 200 times. No heap/ARC-free claim.
- No qualified timing regression remains. Of 48 cases per session, copy controls
  are inconclusive in 7 and 7 on ARM, and 32 and 37 on AMD, so combined acceptance stays
  open. This does not establish parity with Swift/C/Rust.

## Repairs and preserved evidence

[Initial measurements](measurements/captured-map-initial-2026-11-08/README.md)
retain shared-empty regressions and all original limits. The empty-owner repair
`ca837567a` passes after stale pointer/allocation expectations were fixed in
`4da901187`; affected float identity checks were included before measuring.

[Driver failure and repair](measurements/captured-map-driver-repair-2026-11-08/README.md):
run `42478473189` found missing shared-reference drops in the C benchmark driver
on both architectures (status 214). The repair uses the runtime's normal
release-before-free order and includes status/timeout in diagnostics. An Intel
host was rejected before timing; the remaining build was cancelled. All logs and
failure records are retained. No compiler change was needed for this repair.

[#270's complete delivery audit](measurements/fresh-array-delivery-2026-11-08/README.md)
is retained. This batch also repairs recovered exact-source checkout handling
in the production auditor while preserving original diagnostics.

## Local verification and resources

All checks use `python3 scripts/local-guard.py`, serially. Full suites/builds,
benchmarks and large generation run on GitHub runners.

- Formatting, four captured-map controls, 14 borrowed-array controls and ten
  production-auditor controls pass. Eight clock helpers pass 64 Clang executions.
- `/tmp/fwp-replay-empty-owner.py`: ten exact O1/O2 success/failure cases pass
  (reuse, no-reuse, corrupt output, missing suffix and missing captured owner).
- `/tmp/fwp-replay-captured-driver.py`: old C reproduces 214 at O1/O2; 24 corrected
  exclusive/shared/view cases pass, with unchanged final managed storage.
- All four full artifact digests and retained raw-file hashes pass verification;
  cross-architecture managed counts agree for all 48 cases. One verification was
  attempted before a download completed and rejected it; the completed download
  passed before retention. No partial artifact was accepted.
- The docs check caught and fixed a missing status table in the shortened
  handoff. All five roadmap rows, 391 Markdown files and workflow limits pass.

Disk fluctuates across the 64 GiB reserve. Stop on guard limits; never bypass or
raise them. Space was 77 GiB before final artifact downloads. Guarded replays took
5.43 and 24.31 seconds; they supplement, not replace, GCC and final platform gates.

## Roadmap after this batch

[PLAN.md](../PLAN.md) owns the ordered milestones. #270 delivered the broad docs
refresh; its original AMD timing target stays open. This batch extends ownership
coverage to sensor and pixel applications; final delivery and noisy timing
acceptance remain separate. Next comes structured autodiff across neighboring
pairs, independent losses and a dense coupled objective, then Swift/C/Rust
ownership comparisons and three application/tooling/compiler-scaling exercises.
Freeze each next comparison before implementation; preserve general AD, nested
differentiation and F128 precision. Tracing GC remains removed; JIT is excluded.
