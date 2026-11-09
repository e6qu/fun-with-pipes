# Current work

**Next:** verify the separate returned-buffer factories and release controls,
then freeze their phase-timing protocol in [PR #273](https://github.com/e6qu/fun-with-pipes/pull/273).
The matched four-language and scalar Swift allocation batch is verified and is
integrated at `b06a2b6fe`; milestone 4 is not complete.

Active worktree: `.worktrees/recording-capacity-gate`. PR branch:
`ownership-peer-comparisons`. `ownership-buffer-review` retained the focused
verification commits; it has no separate PR. Preserve unrelated root-worktree
changes. Keep one normal PR, with no draft PRs.

## Roadmap status

| Step | Status | Delivered or verified | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance remains open. |
| 2 | In progress | #271 captured maps and empty-owner transfer | Noisy timing acceptance remains open. |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates pass | Original AMD timing acceptance remains open. |
| 4 | In progress | Four-language buffer boundaries, scalar Swift allocations, native weak lifetimes and parser allocation/frame checks | Returned-buffer phases, weak-operation/service costs, parser memory boundaries and peer timings. |
| 5 | Pending | Existing tools and correctness tests | Three application paths, compiler phase/scaling costs and sustained load. |

## Verified merge

The user merged #272 as `32d643d0a3e29c25a55d9b05c5492c0ab73e7c20`.
Its tree equals tested head `8e7cdb94337c6fdac5656dfcbdab768d4a36e985`;
the message meets the one-line/80-character/no-trailer rule.
[Delivery receipt](measurements/structured-callback-delivery-2026-11-09/README.md)
retains the complete verified audit archive and gate identities. All nine production
jobs, documentation and complete-log audit pass. The next branch was rebased onto
this exact merge. Timing misses remain in their original reports.

## This branch

[Ownership comparison scope](measurements/ownership-peers.md) names the matched
programs, phase boundaries and representation differences. No new compiler
optimization or peer timing result is claimed.

[First peer report](measurements/ownership-peer-checks-2026-11-08/README.md):
source `4c6cda41fc2739569cdeda241da85b2a7310b89c`, retained by immutable tag
`roadmap/ownership-peer-checks-2026-11-08`. Run `42522747197` passes on ARM64
(`128859624064`) and AMD64 (`128859624152`): 630 buffer cases per host, twelve
reader tests, parser allocation transitions, native Rust frames and fault controls.
The first run's masked Rust observer abort and its repair remain in the report.

[Verified C/Rust/Swift weak-registration fixtures](measurements/weak-peer-checks-2026-11-09/README.md) cover live and expired
lookup, cancellation before/during/after a callback, nested acquisition, last-owner
release during a callback and later target creation. Actual C omissions of active
release, expiration and metadata release must fail. They use native Swift weak
references and Rust Rc/Weak for the serial contract, without pretending their
allocation layouts match fwp. They do not force address reuse or count ARC calls.
Run `42578072461` passes on both hosts at `5dfd82825`; complete logs and raw
commands are reviewed. Immutable tag `roadmap/weak-peer-checks-2026-11-09` retains
that source. Docs run `42578075331` passes; its complete log contains only named runner
negative controls. The matching-barrier run `42578815959` has passed ARM64
(job `129032480582`); AMD64 (`129032480648`) now also passes. The next buffer change
prepares all three peer languages with the same external C input/result barrier,
plus actual wrong-barrier rejection controls. The review branch additionally
selects fwp explicitly, builds the current compiler, prepares its emitted C with
the same harness/barrier and checks 42 raw/optimized interpreter results. C/fwp
CLI validation rejects impossible array sizes before calling the workload; this
is a harness error check, not a claim about native allocator failure behavior.
The four-language addition passes run `42579398196`, source `9850a0fda`,
ARM64 job `129034306146` and AMD64 job `129034306496`. [Full logs and raw records are reviewed](measurements/four-language-buffers-2026-11-09/README.md):
840 native checks, 42 interpreter results and 24 actual barrier-fault rejections
per host. This verified batch is integrated into #273.

[Scalar Swift profiles](measurements/swift-scalar-closures-2026-11-09/README.md)
pass on both architectures at `96e2bf43a`, run `42580332788`. AMD64 passed attempt
1 (`129037264818`); ARM64 passed attempt 2 (`129039789077`). First ARM setup
(`129037264981`) returned HTTP 504 before profiles started; only that failed job
was rerun. The source, AMD observations and original failed setup are preserved.
Bounded retries for the same pinned download were added for future jobs.

All kinds/repetitions observe 1,048,576 factory allocations, 98,304 attributed
bytes at the process heap peak, and zero ordinary exit bytes. Deliberately omitted
release retains 25,165,824 bytes: 24 bytes per closure. Both complete archives and
the failed setup match GitHub digests; full logs/raw stacks were reviewed. The
new retained-report auditor reconstructs manifests, raw profiles and controls;
its local invocation was refused after disk fell below 64 GiB again. Remote
docs run `42582489716`, job `129044322503`, passes at `52385a6a7`: both raw-profile
reports reconstruct, 402 Markdown link sets and all preparation identities pass.
The complete log is reviewed: `/tmp/fwp-peer-report-docs.log`. The local refusal
remains a refusal; no guard was bypassed.

Remaining: returned-buffer phases, weak-operation/service timing and storage,
parser allocator-internal transient peaks/reservations/RSS, and the matched
peer timing protocol. Complete-operation barriers and scalar Swift closure
allocation attribution now pass on both architectures. Do not retry unchanged
failed timing controls. Keep one active PR and publish no draft PRs.

## Local checks and disk

Free space recovered independently from 12 GiB to about 73 GiB on 2026-11-09.
During that interval the unchanged guard permitted focused checks: closure record controls pass
(two tests, 0.13 seconds elapsed), and roadmap links pass (400 Markdown link sets,
106 preparation pairs/tags, five steps; 0.38 CPU seconds, 3.27 seconds elapsed).
Disk has since fallen below 64 GiB again; further checks move to GitHub.
Full builds, suites and profiles remain on GitHub. Recheck free space before
local work and never bypass the 64 GiB reserve or raise limits.

Before the new weak-registration work, the guarded roadmap audit passed 398
Markdown link sets, 106 preparation pairs/tags and five roadmap steps (0.42 CPU
seconds, 3.16 seconds elapsed). New code/docs require remote verification.
The active checkout includes docs, examples, SDK and vendor inputs needed by
link validation. Older inactive worktrees remain sparse, preserving each modified
handoff; their tracked source/evidence remains in Git. Cleanup removed disposable
build/download/provider caches, not infrastructure state or active workloads.

## Current PR gates

Combined head `b06a2b6fe20f2842f5b9c9a3bb4e00be0278f011`: production
`42583726102` was cancelled to avoid a full intermediate matrix before the batch
is complete; docs `42583726111` passes. One Linux job (`129048368142`) began
toolchain setup just before cancellation; the other eight never started. Its
complete log (`/tmp/fwp-pr273-intermediate-cancel.log`) shows cancellation followed
by packaging/upload errors because no evidence directory existed yet. This is
not a production pass. The review repair skips that exact early-cancellation
case while retaining partial evidence and ordinary missing-evidence failures;
controls execute all three actual workflow bodies with present/absent/invalid
inputs and successful/failed/cancelled statuses. Its first version (`264da8fa3`)
used the unsupported `cancelled()` function in a `run` expression; GitHub rejected
workflow `42589084768` before jobs ran. The current repair uses `job.status`,
which is permitted there. New docs verification is required; this is not a pass.

The review branch
adds callback-error cleanup in C/Rust/Swift and a weak-only runner suite at
`9a7f1baaf`: focused run `42584848642` and docs `42584852665` pass.
[Both complete archives and logs are reviewed](measurements/weak-callback-errors-2026-11-09/README.md):
six ordinary and eight actual fault builds per native host, exact error statuses,
matching archive digests. No native allocation or ARC-operation count is claimed.
Review head `348cc12f58a10559b13aefa96f8885d890cb445b` adds four-language returned-buffer factories, unique/shared
owners, raw/optimized sum checks and actual wrong-scan/omitted-release controls.
Docs `42586123724` passes; focused run `42586120264` fails on both hosts because
Swift iteration/alias return consumed explicitly borrowed arrays. The repair
uses borrowed indexed access and explicit `copy`, and collects all independent
build-group failures before failing the run. [Both failed records are retained](measurements/returned-buffer-checks-2026-11-09/README.md).
The original run did not reach native fwp. There is no timing result.
Only 15 GiB is free locally, below the required 64 GiB reserve; keep checks on
runners and preserve failed observations. The checkout's target directory is empty;
the three inspected user caches total about 1.4 GiB, far below the missing reserve.
The [returned-buffer timing protocol](measurements/returned-buffer-phases.md) now
defines populations, phase boundaries, the C-only batch pilot, copy controls and
RSS runs. Implement and verify those boundaries before freezing its source tag
and collecting timing; no samples have been collected under this protocol.

Previous PR head `7645384bb336acc728deebf24eae96280a45163f`: production `42578853160`,
docs `42578853071` (passes), focused peers `42578815959` (both pass). All nine
production jobs now pass. The first six completed main logs in `/tmp/fwp-pr273-129032*.log`
show only OpenSSL already-installed notices and named scheduler panic controls;
complete per-target/archive audit still follows the finished run. Review every failed/completed
job before repairs. The combined update requires new final-head gates; previous
results do not claim a pass for the new head. Do not merge while milestone 4 work
or final gates remain.
Redundant post-merge CI `42577384035` was cancelled after verifying #272
merge/tree equality and its passing original full gates; no failed step was
reported before cancellation. All five interrupted main logs are reviewed: cancellation, and Linux packaging
of evidence not yet created, are the only error diagnostics. No unexpected test
failure/compiler warning was found. Logs: `/tmp/fwp-pr272-merge-cancel-*.log`. Its docs
run `42577384011` passes. Cancellation is not another production pass.
