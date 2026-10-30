# Current work

**Next:** finish the waiting-method repair, publish it with the retained scalar-fold
results, then run two repaired comparison sessions per architecture and all nine
final-head production jobs plus docs. Squash merge only after the delivery gates
pass. The user accepts the verified cost reductions with timing acceptance open.

[Draft PR #231](https://github.com/e6qu/fun-with-pipes/pull/231), branch
`ownership-peer-baselines`, worktree `/private/tmp/fwp-ownership-peer-baselines`.
Published head: `4b5c49ce567a97900b669fcd494c77a89a130b8e`.
Original comparison source: `8c8c6363a2c1a17374ab3e40e7c87395da98f9e6`.
Compiler candidate: `89fda9513e255fe9227a5abe657a8c5ed75de66e`.
The uncommitted batch changes measurement helpers, controls and docs; it does
not change compiler/runtime behavior or benchmark inputs. Keep one active PR.

## Scalar-fold results and decision

The [budget](measurements/unique-buffer-peers.md#next-accepted-workload-and-budget)
was published at `1bcf261d` before implementation. Each session retains all
2,736 attempts: 4,096 elements, 256 calls/process, two warmup and 36 measured
rounds, twelve processes per label, seed 20261030. Three identical copies per
family control variation. Reference source: `fadebf713e0854d6d132fc6e3666f275b214fc17`.

| Session | Run | Job | Artifact | Result |
|---|---|---|---|---|
| ARM 1 | `41110921616` | `124252833485` | `13004727528` | All original limits pass; new/old time 0.242776 |
| ARM 2 | `41110926781` | `124252852332` | `13003824503` | All original limits pass; new/old time 0.239186 |
| AMD 1 | `41110921616` | `124252833022` | `13005661197` | Copy ratio 1.038806 exceeds 1.02; timing inconclusive |
| AMD 2, attempt 1 | `41110926781` | `124252851994` | `13005685897` | Wrong CPU; no build or timing |
| AMD 2, attempt 2 | `41110926781` | `124267725441` | `13007082510` | Wrong CPU again; no build or timing |

Both rejected hosts were EPYC 9V45 instead of required EPYC 7763. Do not retry
AMD 1 or reinterpret the missing fourth session as a pass. The user explicitly
accepted dispatch/count-call and code-size reductions while leaving timing open.
[The report and artifact index](measurements/unique-buffer-peers.md#scalar-folds-cost-reductions-retained-timing-acceptance-open)
retain complete audited results. Local archives/logs/audits:
`/private/tmp/fwp-scan-{arm,amd}-{1,2}-8c8c.{zip,log,audit.json}` (three measured
sessions only); rejected-host ZIPs and replacement log are separately named.

Known numeric `array.fold` callbacks now call the existing numeric entry directly.
Unknown/captured callbacks and other types keep their existing ownership rules.
Three 4,096-element calls remove 12,288 ineffective duplicate/release entries each;
requests remain 3, requested bytes 98,328, peak bytes 32,776, final bytes 0 and one
cached count byte. ARM/AMD instruction bytes shrink 16,780/18,162 to 10,588/11,090;
largest reported frame components shrink 592/576 to 368/320 bytes. These do not
establish total stack bounds or parity with C/Rust.

## Checks and repaired measurement

Run `41113640046` at `4b5c49ce` passes all six tests in the three affected native
release targets on both GCC hosts: AMD `124262140087`, ARM `124262140241`.
The tests cover real array views, mixed F32-element/I64-accumulator descriptors,
checked overflow/effect order, aliases and cancellation after two scalar steps.
Omitted cancellation cleanup must fail. The earlier statically known callback
fixture defect is repaired and verified. Full logs were audited:
`/private/tmp/fwp-scalar-controls-{amd,arm}-4b5c.log`.
Docs `41113641549` / `124262133583` pass with full audit at
`/private/tmp/fwp-229-docs-231-4b5c.log`. No full production run for #231 yet.

A deterministic child reproduces timed POSIX wait polling sleeps inside the
original elapsed timer. `process_wait.py` uses blocking capture with an explicit
alarm deadline, restores signal state, and preserves kill/reap on failure.
It requires serial main-thread execution and an unused alarm. Windows uses its
kernel wait. A shared captured runner applies the repair to affected measurement
callers. The [declared comparison](measurements/unique-buffer-peers.md#waiting-repair-declared-before-new-measurements)
keeps every count, input and limit unchanged and records `waitPolicy=posix-alarm`.
Old evidence requires explicit `timed-polling`; never mix protocols.

Guarded local checks: ten wait-lifecycle tests pass (1.92s); five buffer-process
controls pass (0.62s); four word-frequency failure/cancellation controls pass
(1.13s). Six build controls pass (1.42s) after catching and fixing an intermediate
regression that failed to kill a failed compiler's surviving descendants.
Python script parsing and diff whitespace checks pass. Final workflow lint (5.64s) and roadmap audit (2.89s) pass. Native macOS and
Windows jobs also run the wait controls; Linux runs them in docs and comparisons. Updated real-binary synthetic evidence controls move to CI because
free disk is close to the 64 GiB floor; do not expand old archives locally.
No full local compiler build, suite or benchmark ran.

## Included baseline work

Four full baseline sessions at `fadebf71` are audited: `41103040883` and
`41103049899`, both architectures. **35/48 case controls fail**; only the selected
scan passes all four. The [report](measurements/unique-buffer-peers.md) retains
all results, inputs, storage/code/stack observations and failed controls.

Pre-candidate `6eca1176`, run `41102080961`, passes both native buffer suites and
numerical-output consumer checks. Earlier failures `41097911057` and `41100000646`
remain retained. Repairs cover Linux tabs, stable Rust frame reports, preserving
objcopy inputs, native library ordering in both numerical consumers and complete
attempt retention. The native runner interleaves its existing queues and starts
the long WebAssembly ownership target earlier, preserving coverage/concurrency.

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
