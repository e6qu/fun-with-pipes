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

Main is cca99c07c4c35c37bcdcb19549e4027abfdcae24, squash #90.
All six CI37765137522 gates passed at exact
8e6a891eadfaa500c5114ce6d598fe0c2bf66731 before merging. Whole message verified:
`Own optional list aliases and borrow synchronous find predicates`, empty body.
#74–#90 deliver native macOS and ownership through optional list results.
Phase1 is done; phase2 is incomplete; phases3–6 remain pending.

Next delivery: inference-call-effects (/private/tmp/fwp-inference-worktree),
rebased from immutable OLD list-option34023f35a42f9f686b6919307d83e17fd4ed7263
onto actual squash cca99c0. Focused cargo test --test call_effects: four pass,
CPU17.05 s /elapsed34.05 s. Native comparison rerun with explicit FWP_NO_OPT=1:
one passes1.72 s /3.50 s. Clippy lib/fixture2.36 s /4.69 s, fmt0.34 s /0.59 s.
All commands used env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3
/Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo ... .
Publish and open the sole next PR; all six exact-head gates are required.
Shared target belongs to inference checkout; no active workload remains.
Seven live docs were preserved in /private/tmp/fwp-main-docs-pre90 before
fast-forwarding main. Failing tests are mandatory repair work, never a roadmap
blocker; CI gates merging while implementation and preparation continue.

## Full evidence and actual repairs

Separate TLS/listener evidence at 9bcae30119028b1870efb8fecfcf9746f5808acb
passed ALL SIX CI37730777345 gates. It restored baseline roots/cache/tutorial
fixes and the real wide-record boxing repair without weakening allocation
thresholds. This is separate evidence; sequential PRs still need their own gates.
Evidence workflows never enter production ancestry.

Current separate WASM evidence checkout /private/tmp/fwp-wasm-evidence-worktree,
branch ownership-evidence-wasm-resources, published
5fd2ed65385a23f3226b2bef02eb10196f51aeb4. Fresh full CI37771769436 is running; its required WASI/File regressions pass. Full acceptance remains pending.
Previous74a6e3f /CI37766917931 failed Linux constructor omission control;
its concrete repair is verified/published and cancellation requested.
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
Current shared compiler target belongs to /private/tmp/fwp-wasm-evidence-worktree.
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
final fmt0.52 s /0.98 s and clippy0.07 s /0.37 s pass. Published as queue80 after final checks; no additional PR while #90 is open. Next audit:
safe finalizer unregistration and File header storage reclamation; preserve
closed-handle semantics, construction failure and retained/shared boundaries.
Shared target now belongs to this inline-path checkout.

Queue80 is published clean2d903d6617d99cec52600c8af43e4d08b5de6716,
parent658e5b73. Whole message verified one line, empty body:
`Store File paths inline in one aligned leaf allocation`. No extra PR opened.
Full sequential CI and actual WASI remain pending; existing evidence run is
left intact. Preserve OLD2d903d6 for the next preparation.

Queue80 post-publication audit passes nine doc link sets,74 immutable queue
pairs and complete inspected commit messages, CPU0.07 s /elapsed0.64 s.
Latest poll: #90 benchmark passes/five gates pending; repaired evidence Linux
live, benchmark passes/four Mac jobs queued. No merge gate yet.

Next concrete reclamation audit: fwp_file.refs is independent of the GC slot;
shared File headers can have slot0. Immediate unshared leaf freeing must not
reuse generic record poison (it assumes an object layout) or retain a stale
library finalizer. Existing runtime probes intentionally inspect discarded
shared headers; preserve their defined diagnostics. Add safe finalizer removal
before any unshared header reuse, protect construction failures, and distinguish
shared/unknown runtime boundaries before making an ARC-only storage claim.
Full graph/cycle coverage is still part of phase2; do not treat inline storage
as completion of ownership or optional tracing-free execution.


Active queue81 preparation: ownership-file-storage-disposal checkout
/private/tmp/fwp-file-storage-disposal-worktree, parent immutable2d903d6.
Implemented last-owner disposal of unshared native File leaf storage after
closing and removing finalizers. Shared headers and disabled-free/bump storage
keep allocator lifetime; poison mode leaves a closed zero-owner/empty-path
header instead of applying String-header poison. Constructor initializes native
storage ownership independently of File.refs. file.with_owned now closes while
its constructor owner is live, then drops that owner in one cleanup callback.
This avoids a scoped-close read after freeing the header on normal/error exits.

Initial checks exposed an old-layout allocation control with a const path;
restore its old destructor along with its old constructor/layout. Subsequent
storage test detected missing native fresh count; explicitly initialized it.
Finalizer omission caused an actual stale atexit finalizer crash; its control
now uses _Exit(4) as soon as the stale registration is detected. New disposal
matrix passes after repair (CPU0.98 s /4.20 s), including actual same-address
reuse with tracing off, freed-byte accounting, shared/disabled-free/poison
retention and final teardown. Added an unrelated retained File finalizer to
prove removal preserves other live registrations. Final eight tests across seven fixtures pass, CPU55.88 s /elapsed123.31 s.
The earlier failed gates are not acceptance evidence. API removal scans/compacts finalizer registrations
without allocating; no speed claim or universal tracing-free claim.
Shared compiler target now belongs to the storage-disposal checkout.

Final adjustment limits File finalizer removal to FWP_LIBRARY, where File headers
are registered. Executables skip the registry scan entirely. Library removal is
linear in current registrations and allocates nothing; retained unrelated File
finalization is verified. The final adjustment passes three storage/source tests, CPU21.35 s /46.82 s. Next exceptional-storage task: constructor failure
still closes an initialized header but leaves storage to its allocator lifetime;
transfer its temporary owner into close-then-drop cleanup after initialization,
without reading released memory in failure probes. Audit finalizer registry
realloc failure transactionality as well. Shared/cycle boundaries remain open.

Final disposal clippy lib/five fixtures passes CPU2.92 s /elapsed5.97 s;
git diff --check passes. Publish the preparation after final format check.
Final disposal format passes CPU1.00 s /elapsed2.63 s. No active workload remains.

Queue81 is published clean750a5cffd46b83c22fa403ed9453b9678bf77118,
parent immutable2d903d6617d99cec52600c8af43e4d08b5de6716. Whole message:
`Reclaim unshared File storage after removing library finalizers`, one line,
empty body. No second PR; full sequential platform/WASI validation pending.
Keep OLD750a5cf immutable for the constructor exceptional-storage preparation.

Latest exact-head #90 poll: benchmark and ARM regular Mac pass; Linux, Intel
regular and both GC gates pending. Fresh evidence Linux, ARM regular and Intel
GC are live; bench passes; Intel regular/ARM GC queued. Continue fixing and
preparing while CI runs, without opening the next PR before #90 squash.

Queue81 post-publication audit passes nine doc link sets,75 immutable queue
ancestry pairs and complete inspected commit messages, guard CPU0.32 s /
elapsed3.71 s. Seven live root doc edits remain ours; preserve all on main FF.


Active queue82 constructor-disposal preparation:
/private/tmp/fwp-file-construction-disposal-worktree, branch
ownership-file-construction-disposal, parent immutable750a5cf. Constructor
cleanup now owns an initialized header, closes it while live, then drops its
storage on recoverable traps. Before initialization, it still closes the raw
stream. Existing failure probes inspect dead headers only under poison retention.
Finalizer growth uses temporary pointer/capacity with overflow checking, commits
only after successful realloc, and preserves existing entries on failure.

Initial construction/storage checks pass CPU9.47 s /21.64 s. New test injects
actual registry realloc failure with zero or64 retained File owners; recoverable
trap mode verifies closed failed descriptor, fresh-header freed bytes (or retained
storage under disabled-free/poison), unchanged registry and surviving sentinels.
Production hard-OOM behavior remains exit102; an atexit audit verifies all64
registered descriptors close after allocation failure. O1/O2 and GC off/on with
stress/verification/both poison modes pass, CPU0.92 s /3.56 s. Added negative
control for prematurely published capacity (must fail rollback), alongside
close-only-constructor storage-leak control. Final four-fixture check passes CPU15.98 s /33.29 s. Format0.45 s /0.84 s passes.
Shared target belongs to the constructor-disposal checkout. No extra PR.

Queue82 final clippy lib/four fixtures passes2.71 s /5.43 s; fmt0.46 s /0.96 s;
diff whitespace check passes. Separate full evidence74a6e3f /CI37766917931
Linux fails constructor raw-only omission control: it reports stale handle then
normal exit runs its deliberately invalid finalizer, triggering glibc double-free
instead of expected exit3. Log /private/tmp/fwp-evidence-linux-37766917931.log,
job113276719315. Use _Exit(3) after detecting stale state, preserving all positive
close/teardown assertions. Same correction applied to original queue70, current
e9d575f (OLD remains immutable), separate evidence and queue82. Queue82 corrected
control passes1.04 s /3.35 s. Verify/publish queue70 correction and evidence;
then rerun all six full gates. Failure is a repair task, not a roadmap blocker.

Queue82 published clean17869223a5022ef060e24b06b0eacb73729f9589,
parent immutable750a5cffd46b83c22fa403ed9453b9678bf77118. Whole message:
`Release failed File constructors and preserve finalizer registry growth`,
one line, empty body. No extra PR. Original queue70 control check runs as
guard37700; shared target switching to
/private/tmp/fwp-file-construction-worktree. Fix and rerun full evidence next.

Original queue70 _Exit control repair passes independently:
cargo test --test file_construction_ownership under guard, CPU8.36 s /17.47 s.
Preserve immutable OLDe9d575f for queue71 when rewriting its current head.
Original queue70 clippy lib/fixture2.64 s /5.32 s and fmt0.45 s /0.85 s pass.

Original queue70 correction published722224705f7c65a11a2c393ddca47ad276f1a115,
exact lease against OLDe9d575f preserved for queue71. Message one line:
`Own file construction and stop controls before stale finalizers`, empty body.
Evidence early required stage now also runs file_construction_ownership;
combined control verification is guard45476. Publish then supersede failed
CI37766917931 with six fresh exact-head gates. Shared target is WASM evidence.

Combined constructor control repair passes CPU8.02 s /17.29 s; fmt0.46 s /0.94 s.
Fresh evidence5fd2ed65385a23f3226b2bef02eb10196f51aeb4 is published clean;
failed37766917931 cancellation requested after publication. No failed/
superseded gate is acceptance evidence. Record the fresh run and require all six.

Fresh repaired evidence CI37771769436 is queued at exact5fd2ed6. Final handoff
audit passes nine doc link sets,76 immutable ancestry pairs and inspected whole
commit messages (CPU0.07 s /0.60 s). No active local workload remains. Next:
inspect six exact-head #90 gates for squash; continue original resource variant/
nested-frame holders and shared/cycle boundary audits while CI runs. Keep all
seven live root doc edits through fast-forward; File-preparation branch snapshots
are historical and their full sequential/actual-WASI gates remain pending.


Active original-variant frame optimization preparation:
/private/tmp/fwp-resource-frame-variants-worktree, branch
ownership-resource-frame-variants, parent immutable17869223a5022ef060e24b06b0eacb73729f9589.
src/cgen.rs and new tests/resource_frame_variants.rs are dirty. The baseline
proved one parent allocation with FWP_FRAME_FIELDS=0; enabled mode initially
failed its zero-box requirement. Implemented tag/payload ResourceSlot::Variant,
mixed typed/variant cleanup frames and protected incoming owners before retains.
Capture cleanup IDs after helper generation. Boxed fallback transfers typed
payload ownership before dropping the original boxed owner.
Six related checks pass CPU25.41 s /50.90 s. Extended allocation/source and
partial-retain trap fixture passes CPU3.04 s /7.22 s; fmt0.45 s /0.82 s.
Actual source uses FWP_NO_OPT=1 interpreter oracle and native O1/O2, GC off/on
stress/verification, both poison modes, with FWP_REUSE=0/FWP_FREE=0. IR fixture
proves exact parent counts one versus zero. Injected second String retain failure
closes the File once and releases String ownership; omitted incoming-owner drop
leaks the descriptor as expected. No broad speed or tracing-free claim.
Next: cover scalar/nullary/dynamic tags and aliases, clippy and publish queue83;
full CI remains required. Shared target is this checkout; no local work is active.
Separate repaired evidence37771769436 passes required WASI/File stage and is
running full gates. Continue repairing any failures while delivering inference.
