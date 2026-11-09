# Current work

**Next:** verify the new weak-registration checks on native Linux ARM64/AMD64,
then complete the remaining milestone 4 comparisons in one substantial PR.
Branch: `ownership-peer-comparisons`, worktree `.worktrees/recording-capacity-gate`.
No new PR is open yet. Preserve unrelated root-worktree changes.

## Roadmap status

| Step | Status | Delivered or verified | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance remains open. |
| 2 | In progress | #271 captured maps and empty-owner transfer | Noisy timing acceptance remains open. |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates pass | Original AMD timing acceptance remains open. |
| 4 | In progress | [Native buffer/parser checks](measurements/ownership-peer-checks-2026-11-08/README.md) pass on ARM64/AMD64 | Matched buffer phases, returned functions, weak registrations and parser memory. |
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

New, unverified C/Rust/Swift weak-registration fixtures cover live and expired
lookup, cancellation before/during/after a callback, nested acquisition, last-owner
release during a callback and later target creation. Actual C omissions of active
release, expiration and metadata release must fail. They use native Swift weak
references and Rust Rc/Weak for the serial contract, without pretending their
allocation layouts match fwp. They do not force address reuse or count ARC calls.
The existing `ownership-peer-checks` suite includes the new checks and retains
partial evidence even when an independent step fails.

Remaining: matched external buffer barriers and returned-buffer phases, scalar
Swift closure allocation attribution, weak-operation/service timing and storage,
parser allocator-internal transient peaks/reservations/RSS. Do not retry unchanged
failed timing controls. Keep one active PR and publish no draft PRs.

## Local checks and disk

Free space has fallen to about 12 GiB on 2026-11-09. The previous cleanup restored
105 GiB, but subsequent disk activity consumed it. No local tests/builds or large
regeneration may run below the 64 GiB reserve; use GitHub runners. Small source/docs
edits and report inspection continue. Do not bypass the guard or raise its limits.

Before the new weak-registration work, the guarded roadmap audit passed 398
Markdown link sets, 106 preparation pairs/tags and five roadmap steps (0.42 CPU
seconds, 3.16 seconds elapsed). New code/docs require remote verification.
The active checkout includes docs, examples, SDK and vendor inputs needed by
link validation. Older inactive worktrees remain sparse, preserving each modified
handoff; their tracked source/evidence remains in Git. Cleanup removed disposable
build/download/provider caches, not infrastructure state or active workloads.
