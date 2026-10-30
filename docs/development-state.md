# Current work

**Next:** watch PR #231's final-head nine production jobs and documentation gate,
audit every completed target/diagnostic, repair failures, then squash merge with
one subject of at most 80 characters and an empty body. The user accepts the
verified cost reductions with timing acceptance open. After merge, follow PLAN's
full buffer comparison using the repaired waiting method; no unchanged reruns.

[PR #231](https://github.com/e6qu/fun-with-pipes/pull/231), branch
`ownership-peer-baselines`, worktree `/private/tmp/fwp-ownership-peer-baselines`.
The final documentation commit follows tested measurement source
`df23cbcb341db53bb372337649ffc14702977078`; compiler/runtime and benchmark inputs
are unchanged. Read the branch head and PR checks for final delivery IDs. Keep
one active PR. GitHub status responses have lagged completed execution: inspect
available job logs as well as status; do not call queued/running jobs passes.

## Results retained in this PR

Known numeric `array.fold` callbacks call the existing numeric entry directly.
Unknown/captured callbacks and other types retain existing ownership rules.
Three 4,096-element calls remove 12,288 ineffective duplicate/release entries each.
Requests remain 3, requested bytes 98,328, peak bytes 32,776, final payload 0 and
one cached count byte. ARM/AMD instruction bytes shrink 16,780/18,162 to
10,588/11,090; largest reported frame components shrink 592/576 to 368/320 bytes.
These are not total-stack bounds or claims of parity with C/Rust.

The [report and artifact indexes](measurements/unique-buffer-peers.md) retain:

- Four original C/Rust/fwp buffer sessions at `fadebf71`: 35/48 copy controls fail.
- Three original paired scan sessions at `8c8c6363`: both ARM sessions pass;
  AMD session 1 fails its copy control at 3.881%. Both AMD session-2 attempts
  reject the wrong CPU before building/timing; no observations were discarded.
- Four repaired paired sessions at `df23cbcb`: the same sample counts, inputs,
  flags and limits, with parent polling sleeps removed. Three pass; AMD session 2
  remains inconclusive at **1.0203993797184912 > 1.02**. Timing acceptance stays open.

| Repaired session | Run | Job | Artifact |
|---|---|---|---|
| ARM 1 | `41120582008` | `124285888639` | `13009486099` |
| AMD 1 | `41120582008` | `124285888984` | `13007908554` |
| ARM 2 | `41120594482` | `124285926747` | `13009241146` |
| AMD 2 | `41120594482` | `124285926490` | `13009610442` |

Each archive has 212 files, 2,736 ordinary attempts, 136 native commands and
126 storage commands (18 intentional omitted-release failures). Complete logs
and archives are independently audited: all code, reported-frame and O1/O2
storage budgets pass. Local files: `/private/tmp/fwp-scan-{arm,amd}-{1,2}-df23.{zip,audit.json}`,
`/private/tmp/fwp-scan-repaired-JOB.log`, `/private/tmp/fwp-scan-repaired-logs.audit.json`.
Original observations remain separately named with `8c8c` or `fade`.

## Verification and incidental repairs

At `df23cbcb`, every comparison job passes six Rust tests in the three affected
release targets, raw/optimized/native results, storage observers, ten wait tests,
five process controls, six schedule controls, twelve damaged-baseline controls
and sixteen damaged-paired-evidence controls. Tests cover real array views,
mixed F32-element/I64-accumulator descriptors, overflow/effect order, aliasing
and cancellation after two steps. Omitted cancellation cleanup must fail.

The shared captured wait uses a POSIX alarm deadline with a blocking wait;
Windows uses its kernel timeout. It preserves raw partial output and kill/reap,
requires serial main-thread execution and an unused alarm, and restores signal
state. A deterministic old-method control reproduces polling sleeps. The first
local build test caught an intermediate descendant-cleanup regression; all six
build controls pass after restoring process-group cleanup on compiler failure.
Native macOS and Windows final jobs also run the wait controls.

Docs `41120563490` / `124285834359` pass: 46 Python suites / 318 cases, no unexpected
warnings or workflow errors, one intentional Rust failure control. Full audit:
`/private/tmp/fwp-docs-231-df23.{log,audit.json}`. The final documentation head still
requires its own gate plus all nine production jobs before merge.

Guarded local checks: wait tests 1.92s, word-frequency cancellation/output tests
1.13s, build controls 1.42s, workflow lint 5.64s, roadmap audit 2.89s. Each complete
comparison archive audit took under one second. One premature audit correctly
rejected an incomplete download; the completed archive passed. Updated large
synthetic evidence controls ran on GitHub. No full local compiler build, suite or
benchmark ran.

Other included repairs: Linux memory-field tabs, stable Rust frame reports,
non-destructive objcopy inspection, native static-library link order in both
numerical consumers, and complete attempt retention. The native runner
interleaves existing queues and starts the long WebAssembly ownership target
earlier, preserving coverage and concurrency. Earlier failing runs
`41097911057`, `41100000646` and `41108169261` remain retained in the report.

## Recovery and resource limits

Preserve the primary checkout: detached #209, dirty recovery handoff, untracked
compiler-abort report. Automatic approval review rejected replacing its handoff;
do not retry or work around that rejection. Backup:
`/private/tmp/fwp-primary-recovery-before-file-checks.md`. Former #229/#230 worktrees
also retain local handoffs; do not publish changes there.

Preserve 64 GiB free disk and all guard limits. A temporary dip below that limit
stopped local validation; only disposable synthetic outputs were removed. Original
CI archives remain. Two #224 evidence directories are now `.tar.gz` archives with
all 2,142 files checked; matching `.archive-audit.json` files retain hashes:
`/private/tmp/fwp-224-{arm-initial,amd-qualified}`. Four older descent-output
archives retain all 5,784 files. The paired synthetic control is preserved with
all 135 files verified at `/private/tmp/fwp-scan-synthetic-control-1.zip`.
Latest free-space reading is close to 64 GiB; recheck before downloads.

## Prior delivery and open measurements

[PR #230](https://github.com/e6qu/fun-with-pipes/pull/230) is verified and merged:
squash `3639f4fad3da318346340f92a89d8ba127f04e73` has the tested `e2fad32c` tree,
a one-line 55-character message and no trailers. All nine jobs `41075128588` and
docs `41071247882` pass with full log audits. [History](roadmap-history.md#file-cleanup-portability-and-measurement-clocks-pr-230)
owns its details.

D2 remains **1.022815765 > 1.02** in `40912773534`; N1 remains
**1.030786192 > 1.02** in `40951090783`. No unchanged rerun or relaxed limit.
The [Intel compiler abort](measurements/compiler-abort.md) remains unexplained;
preserve evidence and diagnose source/input if it recurs, not disassembly.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve GC-free lifetime and cycle guarantees |
| 2 | Verified | Preserve A1–A6; broader ARC costs remain in B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the unoptimized loop gap |
| 5 | In progress | Resolve D2's remaining timing requirement |
| 6 | In progress | Resolve N1's control before N2 timing acceptance |
| 7 | In progress | Finish buffer comparisons, then the other B1/B2 gaps |
| 8 | In progress | Finish numerical and integrated V1/V2 acceptance |
