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

Main: 3c0685c34f9808db82ef9a9b151a6fcfb8eddb47, squash #91. All six
CI37774239006 gates passed at7018086b8f9851f576350ba24e8af5041c3bb594.
Verified whole message: `Keep call effect contexts separate from pure callback types`,
one line, empty body. #74–#91 deliver native macOS, selected ownership through
optional list results, and separate call-effect contexts. Phase1 is done,
phase2 incomplete, phases3–6 pending. Nine live docs were refreshed/preserved
before the fast-forward; current design retains the merged call-effect rule.

No PR is currently open. Next row14 ownership-wide-counts is locally rebased
onto actual #91 squash3c0685c ated679ed8999b5576dc7e3af97cadd6f725bcd3f0.
Source/tests match previously verifiedcb0d7e6 exactly. Final sharing check
passes7.16 s CPU /15.00 s elapsed, all three wide_counts checks7.28 s /14.80 s.
The initial filtered command ran zero wide tests; the separate complete focused
rerun supplies their coverage. Publish with exact lease against remotecb0d7e6
and open the sole next PR. OLD anchors remain immutable. Its squash
subject is `Keep native reference counts exact beyond byte-sized metadata`,
empty body, after all six exact-head gates pass. Separate evidence HTTP crash
repair remains active work; the failed run is not acceptance.

## Next sequential preparations

These source oracle fixes explicitly use FWP_NO_OPT=1. Published preparations
still need final squash rebases and six exact-head gates; original measurements
are archived. Current bases below differ from immutable OLD queue parents.

| Row / branch | Current head | Actual current base | Focused checks (CPU / elapsed) |
|---|---|---|---|
| 14 ownership-wide-counts | final publication pending | 3c0685c34f98 | wide_counts 14.19 /28.94 s; sharing 0.75 /1.79 s; lint 2.34 /4.78 s |
| 15 ownership-list-order | 5fe569218a4b, published | cb0d7e6db7e5 | list_order_ownership 11.16 /22.44 s; lint 2.40 /4.82 s |
| 16 ownership-sort-callbacks | 5c19337f216d, published | 5fe569218a4b | sort_callback_ownership 12.54 /25.46 s; lint 2.30 /4.59 s |
| 17 ownership-state-sequences | 15743b853d6a, published | 5c19337f216d | state_sequence_ownership 12.09 /24.23 s; lint 2.34 /4.61 s |
| 18 ownership-loop-state | 112f3c8de87b, published | 15743b853d6a | loop_ownership 19.08 /38.44 s; lint 2.18 /4.38 s |

Rows14–18 are published clean with exact leases against previous remote
heads. Row18 full head112f3c8de87beddab2374f51e19d6dc94846919d
includes the documentation-only inventory cleanup; tested runtime is unchanged. No second PR. Row17 full head15743b853d6a190a53ea4a95532eb9845b4c685a. Row16 full head5c19337f216d78845fada0b8c29fac98d7b18689.
Row19 published clean as6ce37fb180e1d88903dd94dadaf47181085ab09e on actual
current base112f3c8; preserve immutable OLDc05a5d9/parent787763d. Three raw
oracles, four structural checks16.10 s /32.47 s, lint2.45 s /4.99 s and
format0.33 s /0.61 s pass. Next active task: repair the evidence HTTP GC crash.
Worktree paths follow queue NAME; all source checks, sharing controls, format
commands and compiler flags are preserved in history. Later rebase each current
base onto its parent's actual squash, keeping OLD heads/parents untouched.

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
ee4bd2238e078238cf1a0867e1c891cbf3170279, CI37780278972: ARM GC fails
http.fwp under GC_STRESS=1/VERIFY with empty output and signal exit (-1 in
the harness). Completed job113321340968 log is
/private/tmp/fwp-resource-arm-gc-37780278972.log. Intel GC/regular run; other
jobs remain queued. Diagnose a focused HTTP reproduction; no root cause yet.
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
belongs to wide-counts checkout. Guarded cargo clean -p fwp before switching
checkouts; last switch0.00 s /0.13 s. No local workload is active.
Last doc audit: eleven link sets including heading fragments,82 immutable queue
ancestry pairs and whole commit messages pass0.09 s /0.62 s under the guard.
Publication anchors and current messages are included. Original handoff/ownership
snapshots are archived; current tables keep the handoff compact. Primitive
inventory536→195 lines removes stale pending-merge claims and preserves exact
contract/evidence notes in history. User-facing GC-off and channel docs agree
with the current ownership plan.

Preserve all nine live root docs before fast-forward/rebase conflict resolution:
PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md, docs/concurrency.md.
Latest preservation snapshot: /private/tmp/fwp-main-docs-pre91; refresh all nine
files immediately before updating main to include later progress.
Update current sections after progress; archive chronology in history rather
than appending contradictory next actions. Windows, new deployment interfaces
and a new backend remain deferred.
