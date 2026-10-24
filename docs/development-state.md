# Session handoff

All seven [plan](../PLAN.md) areas remain open. Prefer ownership and borrowing,
reserve ARC for necessary sharing, and remove tracing. JIT is excluded.

## Current action

**Next:** publish the combined interpreter shutdown repair in
[PR #210](https://github.com/e6qu/fun-with-pipes/pull/210), then audit all nine
production jobs, documentation and final-head binary evidence. Audit every failed
job and completed target before another repair push. Keep one active PR.
The user stopped disassembly-led diagnosis: do not resume allocator-cookie work.
The original Intel macOS compiler abort remains unexplained; these source repairs
are not an established explanation for it.

## Source repair and checks

Checkout `/private/tmp/fwp-checked-peer-comparison` is being integrated into
`list-copy-delivery`. Tested source
`0ad90b5a0a6a1653a66e2890586d1d5e56ea6296` passes focused run
[40122813261](https://github.com/e6qu/fun-with-pipes/actions/runs/40122813261)
on Linux AMD64 and native Intel macOS: 236 checks per host and all-target Clippy.
Both complete logs are audited. Six gRPC measurements are explicitly ignored,
not claimed as validation. Both early cleanup artifacts have verified digests and
source IDs; `/private/tmp/fwp-compiler-lifetimes-v4-review.json` and
`/private/tmp/fwp-compiler-lifetime-cleanup-v4-review.json` are COMPLETE.
These focused checks do not replace final production acceptance.

The repair makes every public interpreter evaluation enter a cleanup boundary:
ordinary children finish; background workers are cancelled and joined; connection
pools close; only then does evaluation return or propagate a Rust panic. Blocking
calls restore the scheduler turn during unwinding. Low-level evaluation and raw
transfer are internal. Task handles cannot cross arbitrary Rust threads. Writers
require `Send` and use shared locked ownership, replacing raw writer pointers.
Macros, `comptime`, command execution and exported constants use this boundary.
Sender completion waits for its cancelled task to release captures.

**Shutdown regressions pass:** an abort guard prevents a
panic during cleanup itself from escaping with live borrowed tasks. A test makes
cleanup panic in a child process and checks that it stops instead of returning. Shutdown also drains connections registered while
it waits for workers; a real-socket regression checks closure and owner release.
Focused run `40122286598` at `e479c9db553c94c5b611001ecadd5224aaef70d0`
was cancelled after both Clippy steps and 184 unit checks per host passed. Its
completed logs are audited; interrupted suites are not counted as passes. The
final guard tracks completion and tests entry calls from a destructor during an
existing Rust unwind, as well as cleanup failure.
The final focused run above passes these controls on both hosts. The workflow
publishes cleanup results before longer tests.

The macro regression was reproduced against
`/private/tmp/fwp-verified-array-construction-compiler/fwp`: two macro invocations
spawn printing children, but the old compiler prints neither message. The new
regression passes on both focused hosts. Repeated tests also cover capture release,
background shutdown, root/child panics while blocked, output ownership and tasks
created during cleanup. The three-cell REPL fixture was checked against the saved
baseline; the passing focused suite checks the changed implementation.

Local checks used `python3 scripts/local-guard.py`: Rust formatting, actionlint,
127 documentation link sets and the frozen primitive inventory (392 declarations,
382 symbols, no unclassified items) pass. No full local build or suite ran.

## Active PR and original abort

The preceding PR head is `2fa14cac340aeece7b2676ab43056315520f8269`.
The combined repair must receive a new production run after publication.
Production [40114747612](https://github.com/e6qu/fun-with-pipes/actions/runs/40114747612)
has eight passing production jobs; every completed log is audited. Only Linux
AMD64 remains running. Documentation `40114747617` passes. No new failure has
been reported. This run checks the earlier PR source, not the shutdown repair.

Earlier-head `40106524885` is completely audited: six failures were repaired by
`ff1aca3e` and `85df5485`; both Windows jobs and benchmarks pass. The repairs fix
Clippy, explicit SDK compiler prerequisites and the macOS ASan nano-zone warning.
The workflow does not cancel older runs when a new head is pushed.

The [abort investigation](measurements/compiler-abort.md) holds original crash
metadata, source review and saved experiments. The production-toolchain ASan run
`40114625111` passed all 90 combinations. Its log, archive and compiler hashes are
verified; `/private/tmp/fwp-console-stable-asan-review.json` is COMPLETE. Passing
reruns do not establish the cause. The original nine console inputs invoke no
macros; the reviewed front-end path uses owned Rust data with no unsafe blocks.
No source defect was found in that path.

Original-head binary reviews are complete only for macOS ARM64 and benchmarks.
Other hosts are UNRUN; all final acceptance must match the eventual delivery head.
Old merge/after-merge helpers are UNRUN and source-specific: do not reuse them for
a different head. Squash-merge only after acceptance, with one subject of at most
80 characters and an empty body, without trailers or attribution.

## Prepared next group: array sorting and construction

`/private/tmp/fwp-array-sort-ownership`, branch `array-sort-ownership`, is clean at
report checkpoint `9824e22e827cfd6116c55ac2fcc2651ed02a7dcc`; tested code is
`e0c4dd51bae37c0e09be10fcb373dd035279f815`. No second PR is open.
Unique arrays are reused for sorting; shared arrays/views remain unchanged.
List conversion moves an unshared prefix and copies the shared tail. Interrupted
operations release owned storage. No surface syntax changes.

All six native jobs in `40100508025` and both Linux cost jobs in `40100509770`
pass; full logs and independent reviews are complete. Native reviews cover
504 executable variants, 144 repeated observations and 288 broken controls.
Cost reviews cover 128 executables and eight wide-sort objects. At 4,096 words,
list conversion removes 4,096 retains; allocations and peak storage are unchanged.
Instruction bytes grow by 176–336 on ARM64 and 224–272 on AMD64; the ARM64 O1
entry frame grows 16 bytes. Slower C/Rust rows remain in the report.

In that checkout, `docs/measurements/array-sort-ownership.md` and
`array-construction-*-2026-10-24.json` contain the results. All
`fwp-array-construction` publication/download/review/prune helpers and
`fwp-record-array-construction.py` are COMPLETE: do not repeat them. Full delivery
acceptance remains pending after #210. The saved compiler path above is verified.

## Resources and baseline

Local work must use the guard, serially: preserve 64 GiB free, target data below
2 GiB, sampled aggregate RSS below 1 GiB and the 180-second deadline. Free space
is about 65 GiB. Download/review/prune one host at a time. Preserve failed evidence,
reports, layout objects and dirty older checkouts. Earlier allocator/download
helpers and `fwp-prune-reviewed-list-copy.py` are COMPLETE; never repeat completed
publication, pruning or APFS-clone helpers.

#209 passed ten gates and 8,627 binary reviews, then merged as
`2520d136b7036ab878cac0ef48947b581c81b84a`; duplicate main CI was cancelled.
The primary checkout remains detached there with this operational handoff and
`docs/measurements/compiler-abort.md` dirty. Preserve both. The
[plan](../PLAN.md) is the backlog; [history](roadmap-history.md) is accepted evidence.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |
