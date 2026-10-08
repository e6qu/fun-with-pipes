# Session handoff

Updated 2026-10-08. Read [PLAN](../PLAN.md), [ownership](ownership.md) and the
relevant [design](design.md) before changing code. This file is current state;
[queue](roadmap-queue.md) preserves preparation/rebase anchors and
[history](roadmap-history.md#session-evidence-through-2026-10-08-pr89-and-resource-preparations)
preserves the previous detailed handoff, exact checks, failure logs and measurements.
Prepared branch docs are historical snapshots; current root docs are authoritative.

## Authorization and invariants

Complete the entire active roadmap automatically, one focused PR at a time.
Failing tests are repair tasks, never roadmap blockers. CI gates merging;
continue diagnosis, repairs and separate preparation while it runs. Branch
publication, PR creation, fixes and squash merges are already authorized.

Preserve tacit, curried, data-last pipes, immutable values, tracked effects,
checked arithmetic and observable evaluation/trap order. Infer ordinary types
strongly; explicit generics specialize at compile time. Use FWP_NO_OPT=1 for
raw interpreter oracles. Prepared work, skipped tests and partial gates do not
prove support, ARC-only execution, tracing-free execution or performance.

Every complete commit message is exactly one line, at most 80 characters,
with no body, trailers or attribution. Use normal Git metadata. Squash only
with an explicit subject, empty body and matching current PR head:

```sh
gh pr merge NUMBER --squash --subject 'SUBJECT' --body '' --match-head-commit SHA
```

Require ALL SIX successful jobs at that exact head: test, bench,
macos (macos-15), macos (macos-15-intel), macos_gc (macos-15),
macos_gc (macos-15-intel). Regular macOS excludes only
golden_programs_under_gc_stress; dedicated jobs execute exactly that full
stress test. Their union preserves full coverage. Queued, skipped, cancelled,
superseded or earlier-head runs are not passing gates.

## Delivered and current PR

Main is dbdaee4448d4ccd62720f04d3f866d429db800aa, squash #89,
merged 2026-10-08 10:33:05 UTC after ALL SIX CI37758597151 gates at
bcdfb163c565b6275be4c36389e7c226882fb319. Whole message verified:
`Own typed list copies and retain borrowed suffix references`, empty body.
#74–#89 deliver native macOS ARM/Intel, primitive contracts, owned leaves/text,
compiled closure ownership/cleanup, concrete temporaries, stack children,
borrowed callbacks, map/filter/fold/zip/right-fold/prefix/list-copy ownership.
Phase1 is done; phase2 is incomplete; phases3–6 remain pending.

Sole open PR [#90](https://github.com/e6qu/fun-with-pipes/pull/90):
ownership-list-options at 8e6a891eadfaa500c5114ce6d598fe0c2bf66731,
checkout /private/tmp/fwp-list-option-worktree. Full CI37765137522:
benchmark passes; five gates pending at last authoritative poll.
Seven focused tests pass CPU23.21 s / elapsed46.79 s; clippy lib/four fixtures
2.41 s / 4.92 s; real inventory one test3.30 s / 6.89 s; fmt0.35 s / 0.74 s.
Both oracles explicitly use FWP_NO_OPT=1. Prepared ownership of nth/find/index-of
results needs its current-head full gate. No additional PR is open.

After all six pass, squash #90 with subject
`Own optional list aliases and borrow synchronous find predicates`, empty body.
Preserve all SEVEN live root docs before fast-forwarding main:
PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md.
Then rebase inference-call-effects (/private/tmp/fwp-inference-worktree)
from immutable OLD list-option34023f35a42f9f686b6919307d83e17fd4ed7263
onto the actual new squash. Resolve prepared doc snapshots using current root
copies while retaining each new contract. Test, publish and open its focused PR.

## Full evidence and actual repairs

Separate TLS/listener evidence at 9bcae30119028b1870efb8fecfcf9746f5808acb
passed ALL SIX CI37730777345 gates. It restored baseline roots/cache/tutorial
fixes and the real wide-record boxing repair without weakening allocation
thresholds. This is separate evidence; sequential PRs still need their own gates.
Evidence workflows never enter production ancestry.

Current separate WASM evidence checkout /private/tmp/fwp-wasm-evidence-worktree,
branch ownership-evidence-wasm-resources, published
74a6e3fe7c748b69f43c5930160d54e51f4871fa. Full CI37766917931 is live:
Linux in progress, benchmark passes, four Mac gates queued at last poll.
Mandatory early Linux stage requires actual WASI resource-count tests including
both free modes, FilePair, cached Task/Channel disposal and omission controls;
File runtime boundaries/discard and file_read_kinds run there too.
Earlier combined actual WASI stage passed on e9f31a9, but that full run failed.
It is not acceptance evidence. No local actual-WASI support claim.

CI37760628633 failed cli_fs binary reads on ARM/Intel GC and regular ARM:
file.read-bytes wrongly selected text UTF-8 validation. Fixed in queue72,
current22a520c262196da7e403e7cca3cc26837adda82c; OLD06419f4c59893e6b48c476c552bffee7c8f46b82
remains immutable for queue73. Shared cleanup uses a text-validation mode;
byte dispatch preserves arbitrary bytes. New file_read_kinds compares raw
interpreter and native O1/O2, GC off/on/stress/verification and both poison modes.
Original six file checks pass18.58 s /37.85 s, clippy2.56 s /5.23 s,
fmt0.43 s /0.84 s. Combined evidence three file checks16.20 s /32.85 s.

ARM regular also exposed a gRPC omission-control defect: first-match replacement
edited connection cleanup instead of listener cleanup. Target g_listener_finish
and assert exactly one match. Queue61 current6364bedd9a5c080963e211ed9abc43209dc0a439;
OLD0d5d3098e7827e36045984adcbf859901bde4b74 remains immutable for queue62.
Original positive O1/O2/both-poison and three omission controls pass10.35 s /
20.87 s; clippy2.70 s /5.40 s; fmt0.45 s /0.85 s. Combined probe3.45 s /7.09 s,
clippy lib/three fixtures2.69 s /5.43 s. Both repairs are in the fresh evidence.
Failed37760628633 and intermediate byte-only37766705040 cancellation requested;
neither supplies passing gates. Diagnose any new failure and repair its original
queue item before updating evidence. Do not supersede live runs just to add later work.

## Preparation and next ownership work

Queue79 ownership-resource-frame-fields is published658e5b73ae1c05fe086adfd99678db5c780bf7d4,
checkout /private/tmp/fwp-resource-frame-fields-worktree, parent681dd55 (queue78).
Eligible original resource records retain typed fields instead of a forced
parent box; already-boxed bindings keep one parent retain. FWP_FRAME_FIELDS=0
is the equivalent compiler control. Exact IR proves1 versus0 parent allocations
at O1/O2 with GC off/on/stress and both poison modes. Source matches raw oracle;
partial second-field-retain traps close File and release String. Omitted File
cleanup leaks the descriptor and fails. Six related checks37.15 s /74.45 s;
final fixture3.01 s /7.33 s; clippy2.49 s /5.03 s; fmt0.46 s /0.89 s;
inventory one test3.77 s /7.96 s. Full platform evidence remains required.

Next independent work: audit original resource variant/nested aggregate holders,
File header/path storage and safe finalizer unregistration, shared runtime graphs
and cycles. Retain original File frame/trap order and affine restrictions.
File header refs close streams independently of GC slots, but header/path storage
still follows allocator lifetime. Do not reclaim finalized storage before proving
no stale finalizer, partial-construction or shared-boundary use. Finish ownership
coverage before natural numeric storage/ABI, numerics/autodiff, broader measurements
and optional tracing-free mode. Windows/new deployment/new backend stay deferred.

Use immutable OLD anchors from the queue when rebasing descendants. Exceptions:
queue74 actually parents resource-frames current368dafc; queue78 parents WASM
resource-counts currentc889479. Do not substitute rewritten/squash heads for OLD.
Keep later changes separate and open the next PR only after the current one merges.

## Local validation and persistence

Full builds, full gates, benchmarks and large regeneration run on GitHub.
Local checks are serial, low priority, sampled and bounded: RSS1 GiB per workload,
target data below2 GiB, disk free at least64 GiB, deadline180 s. Stop at limits;
move work to CI, never increase or bypass limits. Use the persistent fwp guard:

```sh
env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo test --test RELEVANT_TEST
```

The fun-refactor guard applies to that other repository; do not use it for fwp.
Current shared compiler target belongs to /private/tmp/fwp-grpc-server-worktree.
Guarded cargo clean -p fwp before switching checkout. All local checks above
used this guard; no active workload remains at last handoff.

Last bounded documentation audit: nine doc link sets,73 immutable queue ancestry
pairs and inspected complete commit messages pass, CPU0.08 s /elapsed0.61 s.
Script /private/tmp/fwp-check-handoff.py; rerun after changing anchors/docs.
Update this handoff after meaningful progress with actual results and concrete
next actions. Preserve current live docs when fast-forwarding or resolving old
snapshots; archive detail in history. Temporary runner logs/check scripts are
located in the archived snapshot; do not claim their existence as a test result.

Handoff consolidation audit passes after archiving: nine link sets,73 immutable
queue pairs and complete inspected commit messages; guard CPU0.07 s /0.59 s.
Root now has SEVEN live doc edits, including history; preserve all seven.

Next concrete storage audit finding: File path is used for display in
runtime/fwp_rt_ops.c; it must remain valid through closed-handle display. Current
constructor separately allocates a traced24-byte header and leaf path. Explore
one leaf allocation with inline path and naturally aligned16-byte fixed header
(FILE pointer plus64-bit owner count), preserving display, constructor failures,
close order and finalizers. File has no GC-valued children once path is inline.
This can remove one allocation without claiming safe immediate header freeing;
finalizer unregistration and stale/shared handle coverage still require separate
proof. Start a new focused preparation from immutable queue79 head658e5b73;
compare equivalent allocation counts and raw interpreter output, O1/O2, stress,
poison, free/reuse flags and library teardown before publishing.


File inline-path preparation is implemented in
/private/tmp/fwp-file-inline-path-worktree, branch ownership-file-inline-path,
parent immutable658e5b73. Header/path become one leaf allocation; owned path copy
and existing resource references/finalizers are preserved. Four related construction,
discard, runtime ownership and frame-field checks pass CPU20.10 s /41.41 s.
New equivalent old/new allocation and source I/O tests pass3.91 s /8.04 s,
O1/O2, GC off/on/stress/verification, both poison modes; source also disables
free/reuse. Initial source File display was rejected correctly by Display typing;
replaced with valid file.read-all source, internal display remains host-probed.
Apple arm64, Apple Clang17.0.0; one versus two constructor allocations, fixed
header16 versus24 bytes, requested bytes eight fewer. No elapsed speed claim.
Clippy lib/four fixtures passes2.98 s /11.62 s; format0.55 s /1.07 s.
Final explicit header-size assertions pass with both new tests, CPU4.23 s /10.42 s;
final fmt0.52 s /0.98 s and clippy0.07 s /0.37 s pass. Publish
as queue80 after final checks; no additional PR while #90 is open. Next audit:
safe finalizer unregistration and File header storage reclamation; preserve
closed-handle semantics, construction failure and retained/shared boundaries.
Shared target now belongs to this inline-path checkout.
