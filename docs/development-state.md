# Current work

**Next:** audit the two submitted scalar-fold comparison sessions, verify the
additional view/cancellation controls and publish the verdict and require all nine final-head
production jobs plus docs before squash merge. No candidate speed result exists.

[Draft PR #231](https://github.com/e6qu/fun-with-pipes/pull/231), branch
`ownership-peer-baselines`, worktree `/private/tmp/fwp-ownership-peer-baselines`.
Comparison source: `8c8c6363a2c1a17374ab3e40e7c87395da98f9e6`.
The next test-only commit leaves its compiler and measured programs unchanged.
Keep one active PR.

## Submitted comparison

The [budget and protocol](measurements/unique-buffer-peers.md#next-accepted-workload-and-budget)
were published at `1bcf261d` before the candidate. Each session uses length 4,096,
256 calls/process, two warmup and 36 measured rounds, twelve processes per label,
seed 20261030: **2,736 attempts**, with three identical copies per implementation.
The reference binaries are frozen at `fadebf713e0854d6d132fc6e3666f275b214fc17`.
Do not retry an unchanged experiment or relax its limits.

| Session | Run | AMD job | ARM job |
|---|---|---|---|
| 1 | `41110921616` | `124252833022` | `124252833485` |
| 2 | `41110926781` | `124252851994` | `124252852332` |

Both runs use `numerics.yml`, `suite=scan-comparison`, `native_runner=all`, explicit
session 1 or 2. Jobs verify the frozen reference, current scalar-fold tests,
interpreter/native agreement, storage and damaged-evidence controls before timing.
At 19:10 UTC on October 30 all four jobs and docs `41110902702` / `124252757094`
remain queued; execution logs return 404. Earlier status responses have lagged
completed logs, so check both. GitHub reports a mitigated Actions delay incident
[under monitoring](https://www.githubstatus.com/incidents/pwxsjgnvrk6b); its role in
these particular queues is not confirmed. No full production matrix has run for #231.

## Candidate and repaired test

`array.fold add 0` previously used general callback dispatch for every element.
The candidate at `89fda951` calls the existing numeric entry directly when both
parameters and the result are plain numeric values and the callback has no
captures. Unknown callbacks, F128 and other types keep their existing rules.
Initial-value/input order, folding order and caller-owned array cleanup remain.
This does not extend the restricted count-free array proof.

Run `41108169261` is fully audited on both architectures. Buffer, overflow,
consumer and failure-cleanup checks pass. Both hosts expose one fixture error:
a supposedly unknown callback was statically known, so its function was inlined
away and the assertion could not find it. The published repair selects it through
input and checks general dispatch. It also tests initial/input effect order and
optimized-interpreter overflow order. The submitted comparison jobs verify this repair.

For three 4,096-element calls, diagnostics remove 12,288 ineffective duplicate and
release entries each. Payload remains three requests, 98,328 requested bytes,
32,776 peak bytes, zero final bytes and one cached count byte. Ordinary `.text`
falls from 16,780 to 10,588 bytes on ARM and 18,162 to 11,090 on AMD. Largest
reported frame components fall from 592/576 to 368/320 bytes; no new dynamic frame
appears. These are not timing or final-platform acceptance claims.

Candidate jobs/artifacts: ARM `124243375996` / `13001672994`; AMD `124243375828` /
`13001633556`. Complete archives, logs and audits are
`/private/tmp/fwp-buffer-candidate-{arm,amd}-89fd.{zip,log,audit.json}`.
Both archives have 830 files. Docs `41108173620` / `124243377087` pass with full
log audit: `/private/tmp/fwp-229-docs-231-89fd.log`.

## Additional controls awaiting native checks

The original two-element slice was copied, not a view. New fixture cases exceed
the view threshold, produce 248 and 1008.0, and run with packing on/off. A mixed
F32-element/I64-accumulator case checks the element descriptor independently of
the result type. The cleanup probe cancels after two scalar steps and requires
zero remaining payload/cleanup frames; deliberately omitted cancellation cleanup
must fail. Compiler/runtime and measurement inputs are unchanged by these tests.
Native execution of these additions remains required. `suite=scalar-fold-checks`
reuses the focused build/test job for just the three affected release targets;
it does not repeat the buffer baselines or unrelated diagnostics.

Local checks use `scripts/local-guard.py`: raw/optimized fixture checks pass
(about 0.25s each); the task/error fixture produces four expected errors (0.25s).
Rust formatting, full workflow lint (5.73s) and roadmap audit (3.05s) pass before
these last test additions; formatting passes again (0.25s).
The six schedule controls pass (0.24s), paired evidence rejects fifteen damaged
inputs (6.07s), and the refactored baseline rejects eleven (5.71s).
An obsolete pre-repair program archive correctly failed the missing-objcopy-output
check; the current archive passes. No full local build, suite or timing ran.

## Baselines and included repairs

Four baseline sessions at `fadebf71` are fully audited: `41103040883` (session 1)
and `41103049899` (session 2), both architectures. **35/48 case controls fail**;
the 4,096-element scan passes all four and takes 10.1–14.4 times C's elapsed time.
The [report](measurements/unique-buffer-peers.md) and its artifact index retain all
results, inputs, source IDs, storage/code/stack observations and failed controls.
Archives/logs/audits: `/private/tmp/fwp-buffer-baseline-{arm,amd}-{1,2}-fade.{zip,log,audit.json}`.

Pre-candidate focused source `6eca1176`, run `41102080961`, passes both complete
native buffer suites and numerical-output consumer checks. Earlier failures
`41097911057` and `41100000646` remain in the report and retained archives.
Repairs cover Linux tabs, stable Rust frame reports, preserving objcopy inputs,
native library ordering in both numerical consumers, and complete attempt/evidence
retention. The native runner interleaves its existing queues and starts the long
WebAssembly ownership target earlier, preserving coverage and concurrency.

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
Last free-space reading after compaction was about 64.9 GiB; recheck before downloads.

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
