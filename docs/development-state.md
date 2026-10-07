# Session handoff

Updated 2026-10-08. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before code changes. This file records current work;
[queue](roadmap-queue.md) preserves immutable rebase anchors and
[history](roadmap-history.md#archived-handoff-and-ownership-notes-through-queue86)
archives detailed checks, failures and superseded status. Prepared branch docs
are historical snapshots; current root docs are authoritative.

## Execution contract

Complete the active roadmap automatically, one focused PR at a time. Publication,
PR creation, fixes and squash merges are authorized across sessions. Failing tests
are repair tasks; CI gates merging while diagnosis and separate preparation continue.

Preserve tacit, curried, data-last pipes, immutable values, tracked effects,
checked arithmetic, affine resources and observable evaluation/trap order.
Use FWP_NO_OPT=1 explicitly for raw interpreter oracles. Prepared changes,
skipped tests and partial gates do not prove support or performance.

Every complete commit message is one line, at most 80 characters, with no body,
trailers or attribution. Use ordinary Git author metadata. Squash only after
all six jobs succeed at the current exact head: test, bench, macos (macos-15),
macos (macos-15-intel), macos_gc (macos-15), macos_gc (macos-15-intel).
Regular macOS excludes only golden_programs_under_gc_stress; dedicated GC jobs
execute that full test. Queued/skipped/old/superseded/cancelled runs are not gates.

```sh
gh pr merge NUMBER --squash --subject 'SUBJECT' --body '' --match-head-commit SHA
```

## Delivered and sole open PR

Main: cca99c07c4c35c37bcdcb19549e4027abfdcae24, squash #90. All six
CI37765137522 gates passed at 8e6a891eadfaa500c5114ce6d598fe0c2bf66731.
Verified whole message: `Own optional list aliases and borrow synchronous find predicates`.
#74–#90 deliver native macOS and ownership through optional list results.
Phase 1 is done, phase 2 incomplete, phases 3–6 pending.

Sole open [PR #91](https://github.com/e6qu/fun-with-pipes/pull/91):
inference-call-effects, /private/tmp/fwp-inference-worktree, exact
7018086b8f9851f576350ba24e8af5041c3bb594. CI37774239006: benchmark passes,
Linux and all four Mac jobs run. Four focused call_effects tests
pass17.05 s CPU /34.05 s elapsed; explicit raw-oracle rerun1.72 s /3.50 s;
clippy2.36 s /4.69 s, fmt0.34 s /0.59 s.
After all six gates pass, squash with subject:
`Keep call effect contexts separate from pure callback types`, empty body.
Next row14 ownership-wide-counts is being prepared on current PR head7018086
from immutable OLD inference89b7bde2c8f035e4767fe9543b18dc6385769635.
After #91 merges, rebase its current base7018086 onto the actual squash and
rerun any affected checks before publication and the sole next PR.
Original OLDwide3a791dc7e9f373a327780ded04774acd7f4825cb remains immutable.
Wide-count preparation is rebased on7018086; original anchors stay immutable.
All three wide_counts checks pass14.19 s CPU /28.94 s elapsed with explicit
FWP_NO_OPT=1 interpreter oracles. The sharing regression passes0.75 s /1.79 s;
fmt0.35 s /0.63 s; clippy lib/two fixtures2.34 s /4.78 s.
Published clean ascb0d7e6db7e57a0369c5aecc7ecb70d7b19c0e23 with explicit
lease against OLDwide3a791dc. Wait for #91 before rebasing from current7018086
onto the actual squash and opening the next PR.
Resolve docs using current root copies; explicit raw-oracle corrections and
focused tests/lint pass and branch is published. No second PR is open.

## Separate full evidence

TLS/listener evidence9bcae30119028b1870efb8fecfcf9746f5808acb passed all six
CI37730777345 jobs, including the unchanged wide-record allocation threshold.
Baseline roots/cache/tutorial and real boxing repairs are recorded in history.

WASM/resource evidence: ownership-evidence-wasm-resources,
/private/tmp/fwp-wasm-evidence-worktree, exact
5fd2ed65385a23f3226b2bef02eb10196f51aeb4, CI37771769436: all six gates pass.
Required actual-WASI/File stage passes, including both free modes and
FilePair/cached Task/Channel disposal. This validates the combined evidence,
not production delivery. Each sequential PR still needs its exact-head gates.
Evidence workflows and baseline repairs never enter production ancestry.

Current resource-frame evidence: ownership-evidence-resource-frames,
/private/tmp/fwp-resource-evidence-worktree, exact
ee4bd2238e078238cf1a0867e1c891cbf3170279, CI37780278972 queued at publication.
It adds rows79–88 and their required regressions to the passing WASM/resource
baseline. Preserve live runs; diagnose failures and keep preparing separate work.

Repaired failures preserved in history: WASI descriptor audit uses fstat rather
than fcntl(F_GETFD); byte reads bypass UTF-8 validation (queue72 current22a520c);
gRPC omission control targets listener cleanup (queue61 current6364bed); stale
constructor-finalizer control uses _Exit(3) (queue70 current7222247).
Failed/cancelled/superseded runs never supply acceptance evidence.

## Ownership preparations and active work

Rows79–88 are published with focused evidence; full sequential CI remains required.

| Row | Preparation | Current head | Focused evidence |
|---|---|---|---|
| 79 | Resource record fields | 658e5b73ae1c | One versus zero parent boxes; partial-retain cleanup |
| 80 | Inline File path | 2d903d6617d9 | One allocation; aligned native header; copied path |
| 81 | File storage disposal | 750a5cffd46b | Finalizer removal, shared/no-free/poison controls |
| 82 | Constructor disposal | 17869223a502 | Allocation/registration failure; intact registry growth |
| 83 | Variant frame holders | 786e4bbb99f1 | Parent boxes, dynamic tags and partial-retain traps |
| 84 | Variant binding kinds | ae00e6929e86 | Per-path payload initialization; implicit one-close audit |
| 85 | Match scrutinee types | 3a0cbdb33b79 | Whole-pattern context; typed temporary; implicit close |
| 86 | Record binding kinds | f85cc4e09db4 | Per-path field initialization; allocation and close audits |
| 87 | Nominal source context | 8abfd46b3476 | Explicit raw oracles; 64 nested File discards under32 descriptors |
| 88 | Channel cycles | 291f8f75f196 | Close retains queue; typed drain breaks counted cycle |

Immutable full heads/parents are in the queue. Rows74 and78 inherit corrected
current bases368dafc andc889479 respectively; their OLD parents reflect this.
Never substitute a rewritten/squash head for an immutable descendant anchor.

Latest preparation: ownership-channel-cycle-lifetimes,
/private/tmp/fwp-channel-cycle-worktree, exact291f8f75f19688f139b2dcae7f31482cac810643,
parent immutable8abfd46b34762b0cf69e417b65a85a1d783b61ac, published clean.
Channel fixture passes1.37 s /3.13 s, related queue/task tests9.04 s /18.50 s,
clippy2.37 s /4.87 s, fmt0.45 s /0.86 s. Poison assertions verify tombstones
rather than cleared metadata. Detailed checks are archived in history.
This verifies explicit draining, not automatic cycle reclamation.
A follow-up doc sweep corrects the stale reference claim that GC-off prevents
all freeing, adds FWP_FREE=0, and states close/drain semantics in concurrency.
Published follow-up291f8f7 includes these user docs and current roadmap copies.
Immutable OLDdc2ad1f remains the original preparation; runtime/test evidence
is unchanged. Whole subject: `Clarify tracing controls and queued channel lifetime documentation`.

Combined evidence publication and constructor conflict validation are archived
in history: focused constructor check8.22 s CPU /17.58 s elapsed, fmt0.46 s
/0.84 s. This evidence is never a production PR.

Following row15 list-order is being prepared on current wide-count headcb0d7e6
from immutable OLDparent3a791dc. Its original OLDheadc83557825d8ab49f4334e764b1cac82cd2f82057
stays immutable. Both raw-oracle calls explicitly use FWP_NO_OPT=1. Two
list_order_ownership checks pass11.16 s CPU /22.44 s elapsed (O1/O2, stack
on/off, GC stress/verification, poison modes and no-tracing reclamation).
Format0.34 s /0.62 s; clippy lib/fixture2.40 s /4.82 s. Publish without a
second PR; its later rebase must use actual current basecb0d7e6.

Next independent work: ambiguous nominal contexts without whole-value binders,
nested holders and shared/cycle graphs. Source match functions begin with typed
scrutinee parameters; direct IR can still lack that context. Preserve partial
pattern bindings until original frame exit, matching interpreter behavior.
Complete ownership coverage before numeric representation, numerics/autodiff,
broader measurements and optional tracing-free mode.

## Local checks and durable state

Full builds, full tests, benchmarks and large regeneration run on GitHub.
Local focused work is serial, low priority and sampled: RSS below1 GiB,
target below2 GiB, free disk at least64 GiB, deadline180 seconds. Stop at limits
and move work to CI; do not increase or bypass limits. Use:

```sh
env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo test --test RELEVANT_TEST
```

The fun-refactor guard applies to the other repository. Shared target currently
belongs to list-order checkout. Guarded cargo clean -p fwp before switching
checkouts; last switch0.00 s /0.14 s. No local workload is active.
Last doc audit: eleven link sets including heading fragments,82 immutable queue
ancestry pairs and whole commit messages pass0.09 s /0.62 s under the guard.
Publication anchors and current messages are included. Handoff448→133 lines and ownership460→177 lines;
exact previous snapshots are archived in history.

Preserve all nine live root docs before fast-forward/rebase conflict resolution:
PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md, docs/concurrency.md.
Previous preservation snapshot: /private/tmp/fwp-main-docs-pre90.
Update current sections after progress; archive chronology in history rather
than appending contradictory next actions. Windows, new deployment interfaces
and a new backend remain deferred.
