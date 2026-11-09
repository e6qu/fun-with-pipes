# Current work

**Next:** verify the returned-buffer phase callers and their real backward-clock
controls on both Linux architectures, then add native storage observations and
implement the [phase timing protocol](measurements/returned-buffer-phases.md).
Keep this work in [PR #273](https://github.com/e6qu/fun-with-pipes/pull/273).
Milestone 4 is not complete; do not merge it yet.

Worktree: `.worktrees/recording-capacity-gate`. Active preparation branch:
`ownership-buffer-review`. PR branch: `ownership-peer-comparisons`, currently
`b06a2b6fe20f2842f5b9c9a3bb4e00be0278f011`. The review branch has no separate PR.
Keep preparing coherent groups there, then integrate into the same normal PR.
Hold the next full matrix until the measurement batch is ready. Preserve unrelated
root-worktree changes and the sparse inactive worktrees' modified handoffs.

## Roadmap status

| Step | Status | Verified work | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance. |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance. |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance. |
| 4 | In progress | Matched/returned buffers, Swift scalar allocations, weak cancellation/error lifetimes, parser allocation/frame checks | Buffer phases/native storage, weak-operation/service costs, parser memory boundaries and peer timings. |
| 5 | Pending | Existing tools and correctness tests | Three application paths, compiler phase/scaling costs and sustained load. |

Do not repeat unchanged noisy timings to obtain qualification. Original misses
remain in their reports; verified count reductions do not erase them.

## Verified comparison sources

| Evidence | Source | Native runs |
|---|---|---|
| [Matched four-language buffer boundaries](measurements/four-language-buffers-2026-11-09/README.md) | `9850a0fda` | `42579398196`, both pass |
| [Scalar Swift closure allocations](measurements/swift-scalar-closures-2026-11-09/README.md) | `96e2bf43a` | `42580332788`, both pass; first ARM setup failure retained |
| [Weak callback errors](measurements/weak-callback-errors-2026-11-09/README.md) | `9a7f1baaf` | `42584848642`, both pass |
| [Returned-buffer ownership and release](measurements/returned-buffer-checks-2026-11-09/README.md) | `9d8bbb79a` | `42590570921`, both pass |
| [Parser allocation transitions and native frames](measurements/ownership-peer-checks-2026-11-08/README.md) | `4c6cda41f` | `42522747197`, both pass |

Reports retain exact revisions, commands, images or archive identities, faults
and limits. Swift scalar closures request one 24-byte allocation each; native
requested bytes are not interchangeable with fwp's older payload-only counters.
ARC operations remain unmeasured. No new performance improvement is claimed here.

The returned-buffer repair passes 48 builds, 528 native checks and 14 interpreter
checks per host. All 671 raw commands and both complete logs are reviewed. Its
first run (`42586120264`, source `348cc12f5`) failed because Swift iteration and
alias return consumed borrowed arrays. The repair uses indexed reads and `copy`;
it collects all independent build failures before failing the final result.

Docs run `42590575105`, job `129070910754`, passes at `9d8bbb79a`: 405 link sets,
all immutable preparation identities, and the evidence controls. The seven
packager tests include 27 actual-workflow status/input cases. The complete log
is retained with the returned-buffer report; it has no unexpected diagnostic.

## Current preparation, not yet verified

The phase callers keep fixed populations alive, read every buffer, release first
owners before reading surviving aliases, and use four/six clock readings per
unique/shared batch. Reusable caller slots are allocated outside the phases.
No timing comparison has run. The C-only batch pilot, two sessions, balanced
copy controls and separate RSS runs remain to implement.

The shared native builder now lives in `scripts/returned_buffer_build.py`; the
owned-entry adapter moved to `scripts/returned_buffer_source.py`. Both the old
result checks and new phase checks use it. `returned-buffer-phases` reruns the
changed builder's correctness coverage, then checks all four phase callers,
invalid arguments, wrong sums and an actually decreasing linked clock.
Do not interpret these preliminary clock values as performance samples.

## Production gates and incidental repair

[All nine production gates and complete-log audit pass](measurements/ownership-peer-gates-2026-11-09/README.md)
for earlier PR head `7645384bb336acc728deebf24eae96280a45163f`: production
`42578853160`, docs job `129032587978`, audit `42590693699`/`129071304611`.
The complete audit ZIP matches GitHub's digest. It does not verify later heads.

Intermediate matrix `42583726102` was cancelled before tests, avoiding another
full run while the batch grows. One Linux job began toolchain setup; eight never
started. Missing-evidence packaging then produced secondary errors. The fix skips
only cancellation before an evidence directory exists, preserves partial files,
and keeps ordinary missing/invalid evidence fatal. Its first expression used
`cancelled()` where GitHub disallows it (`42589084768`); the verified repair uses
`job.status`. Cancelled runs are not production passes. Final delivery still needs
all nine jobs, docs and complete-log audit for the final combined commit.

## Local resources and previous merge

Only about 15 GiB is free, below the required 64 GiB. Keep tests/builds/profiles on
GitHub; never bypass the local guard. Active target data is empty. The inspected
user caches total about 1.4 GiB, insufficient to restore the reserve. Earlier
cleanup preserved modified handoffs, source and infrastructure state.

The user merged #272 as `32d643d0a3e29c25a55d9b05c5492c0ab73e7c20`. Its tree equals
tested `8e7cdb94337c6fdac5656dfcbdab768d4a36e985`; its commit message follows the
one-line/80-character/no-trailer rule. [Its retained receipt](measurements/structured-callback-delivery-2026-11-09/README.md)
verifies every delivery gate. Duplicate merge run `42577384035` was cancelled;
all interrupted logs were reviewed. Current work is based on that exact merge.
