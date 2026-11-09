# Current work

**Next:** identify the exact optimized Swift queued-cleanup failure with
line-numbered lifetime checks. First run `42603913802` fails only Swift `-O`
on both architectures; C/Rust, Swift `-Onone` and all 16 C fault builds pass.
Follow-up source `e9cf680093870bf98770a3a2c8b1c2954f36c1af`, run `42607637111`,
makes the outside owner live explicitly through weak
lookup and cancellation. It ends that lifetime before invoking the callback,
so only the acquired owner protects callback execution. This is unverified;
retain the diagnostic run on the original operations. Do not infer a compiler
bug from the trap. Buffer timing run `42602375928`
at `b37b15ac2d636187b97ccd00192e50638bd788d0` passes both sessions and audits
on both hosts; retain and interpret all results without unchanged reruns.
Keep work in [PR #273](https://github.com/e6qu/fun-with-pipes/pull/273).
Docs for the result tables are queued in `42606196247` at `2cb8e313d`.
Milestone 4 is not complete; do not merge it yet.

Worktree: `.worktrees/recording-capacity-gate`. Active preparation branch:
`ownership-buffer-review`. PR branch: `ownership-peer-comparisons`, currently
`b06a2b6fe20f2842f5b9c9a3bb4e00be0278f011`. The review branch has no separate PR.
Integrate the complete measurement batch into the same normal PR, then run the
final production matrix. Preserve unrelated root-worktree changes and inactive
worktrees' modified handoffs.

## Roadmap status

| Step | Status | Verified delivery | Remaining |
|---|---|---|---|
| 1 | In progress | #270 documentation refresh and fresh F64 stores | Original AMD timing acceptance. |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance. |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance. |
| 4 | In progress | Buffer correctness/phases/native storage, Swift scalar allocations, weak cancellation/error lifetimes, parser allocation/frame checks | Weak-operation/service costs and queued cleanup/reuse; parser memory boundaries. Buffer copy-control misses remain explicit. |
| 5 | Pending | Existing tools and correctness tests | Three application paths, compiler phase/scaling costs and sustained load. |

Original misses remain in their reports. Verified count reductions do not erase
failed or inconclusive timing acceptance; do not repeat unchanged experiments.

## Verified comparison sources

| Evidence | Source | Native runs |
|---|---|---|
| [Matched four-language buffers](measurements/four-language-buffers-2026-11-09/README.md) | `9850a0fda` | `42579398196`, both pass |
| [Scalar Swift closure allocations](measurements/swift-scalar-closures-2026-11-09/README.md) | `96e2bf43a` | `42580332788`, both pass; first ARM setup failure retained |
| [Weak callback errors](measurements/weak-callback-errors-2026-11-09/README.md) | `9a7f1baaf` | `42584848642`, both pass |
| [Returned-buffer ownership/release](measurements/returned-buffer-checks-2026-11-09/README.md) | `9d8bbb79a` | `42590570921`, both pass |
| [Buffer time and process RSS](measurements/returned-buffer-time-2026-11-09/README.md) | `b37b15ac2` | `42602375928`, both sessions/audits pass; noisy timings remain inconclusive |
| [Buffer phases and native storage](measurements/returned-buffer-phases-2026-11-09/README.md) | `ec9313228681689daa4c20c495edd8b5f9faa583` | `42600727564` phases and `42600729662` profiles/audits, both hosts pass |
| [Parser allocation transitions/frames](measurements/ownership-peer-checks-2026-11-08/README.md) | `4c6cda41f` | `42522747197`, both pass |

Reports retain exact revisions, commands, images/archive identities and faults.
ARC operations remain unmeasured. Native requested bytes, fwp managed bytes and
process RSS are distinct measurements. Qualified phase/peer ratios belong to
their frozen workload; they do not establish language-wide parity.

## Current buffer measurements

`roadmap/returned-buffer-observers-2026-11-09` retains verified source `ec9313228`:

- Each host passes 16 phase builds and 120 result/argument/backward-clock checks,
  plus the original 48 builds, 528 native and 14 interpreter checks.
- Each host passes 60 C/Rust/Swift profiles with actual first/last release
  omissions, ordinary cleanup and independent allocator/unwinder controls.
- Both runners fully hash/audit the original failed profile archives and all
  324 AMD64 / 234 ARM64 commands. The only failed child commands are the five
  original ARM Rust links. Original and corrected stack attribution are retained.
- Docs `42600729223`, job `129104245085`, passes: four pilot/sample-reader tests,
  three allocation-reader tests, 407 link sets and all retained-evidence controls.
  The complete log has only the named failing-child/test-runner controls.

The first phase run found a Rust clock object after system libraries; the shared
builder now links a native static library without disabling stack protection.
The first profiler missed Rust's v0 symbol names and conflated Swift type metadata
with array storage. The repaired observer reports both categories and total costs;
ordinary array storage must still reach zero. All first failures remain in the
[report](measurements/returned-buffer-phases-2026-11-09/README.md).

[Timing and RSS results](measurements/returned-buffer-time-2026-11-09/README.md)
now retain both sessions on both hosts. ARM64 large-buffer reading is slower even
where process time is lower; empty-array churn and the shared 4,096-element Rust
comparison expose costs. Many AMD64 copy controls fail, so those comparisons
remain inconclusive. Do not rerun unchanged measurements to seek qualification.
Compile time/RSS, image/section/unwind evidence and all raw observations remain.
Maximum stack use and ARC-operation counts are unmeasured. The
[parser memory preparation](measurements/parser-process-memory.md) now specifies
phase checkpoints, ordinary RSS and actual mapping controls. Its allocator-internal
peak and committed-memory boundaries remain unresolved; no result is claimed.

The weak-registration preparation adds queued-message
cancellation/expiration and callback-error cleanup in C/Rust/Swift. Four new C
faults omit acquired ownership, queued weak metadata, payload release or cleanup
of unprocessed messages. The checker now retains independent group failures.
Source `c9bf8dfac`, retained as `roadmap/weak-queued-cleanup-2026-11-09`, is testing
in `42603913802`; both optimized Swift cases fail with an anonymous trap.
All other native/fault builds pass. Diagnostic source `24f7a033e` adds explicit
Swift line numbers; run `42605354450` is queued. First records are retained in
[the report](measurements/weak-queued-cleanup-2026-11-09/README.md).
Docs repair `42603916827` passes; the full log has only intentional failing-child
and test-runner controls. This measures no allocation/timing costs and does not establish forced
address reuse.

Docs `42602380180` at timing source `b37b15ac2` failed because the shortened
handoff omitted its required milestone-status column. That column is restored
without changing the checker. Reverify docs with the queued-cleanup batch;
preserve the timing source and measurements rather than rerunning them.

## Production gates and incidental repair

[All nine production jobs and full-log audit pass](measurements/ownership-peer-gates-2026-11-09/README.md)
for earlier PR head `7645384bb336acc728deebf24eae96280a45163f`: production
`42578853160`, docs job `129032587978`, audit `42590693699`/`129071304611`.
These do not verify later heads. Final delivery needs all nine jobs, docs and
complete-log audit for the final combined commit.

Intermediate matrix `42583726102` was cancelled before tests. The packaging
repair skips only cancellation before any evidence directory exists; partial
evidence is retained and ordinary missing/invalid evidence fails. Its first
invalid `cancelled()` expression is retained in `42589084768`; the repair uses
`job.status`. All 27 status/input controls pass. Cancellation is not a gate pass.

## Local resources and previous merge

About 14 GiB is free, below the required 64 GiB. Keep tests/builds/profiles on
GitHub; never bypass the local guard. Active target data is empty. Inspected user
caches total about 1.4 GiB, insufficient to restore the reserve. Earlier cleanup
preserved modified handoffs, source and infrastructure state. Small report reads
use bounded HTTP ranges; large archive audits run on GitHub.

The user merged #272 as `32d643d0a3e29c25a55d9b05c5492c0ab73e7c20`. Its tree equals
tested `8e7cdb94337c6fdac5656dfcbdab768d4a36e985`, and its message follows the
commit rule. [Its receipt](measurements/structured-callback-delivery-2026-11-09/README.md)
verifies every gate. Duplicate merge run `42577384035` was cancelled and its
interrupted logs reviewed. Current work is based on that exact merge.
