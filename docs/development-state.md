# Session handoff

Updated 2026-10-12. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff.
[Queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
preserves accepted and superseded evidence. Root docs are authoritative.

Durable recovery branch: `roadmap/handoff-pr123-20261011`. Last verified
checkpoint `593553e47efa314b9c2b5df1803d9620caa7d693` passes audit38207907474.
Query the branch tip on recovery; an embedded checkpoint cannot identify its
own commit. restore-roadmap-recovery.py restores only temporary paths from a
bounded immutable archive after verifying Git blob hashes. Its runner audit
verifies201 targets/9603759 bytes. Reports are retained in
/private/tmp/fwp-verified-current-numeric-restoration. On recovery, run the
bounded restore-numeric-finalization-archive.py after restoring temporary
sources to reconstruct the verified gzip export from its retained base64 text. Never rerun completed publishers. Phase2 is accepted; phases3–6 remain unfinished.

## Execution contract

Finish the plan automatically, one coherent bundle production PR at a time. The
user requested larger related bundles to reduce testing cycle time. Preserve
all included regression/negative controls; run the full matrix once per final
bundle head. Keep one production PR open at a time. Publication,
repairs and squash merges are authorized across sessions. Fix failing checks;
CI gates merging while independent preparation continues. Preserve the language
semantics and phase order in PLAN. Require all six exact-head jobs and roadmap_docs:
`test`, `bench`, `macos (macos-15)`, `macos (macos-15-intel)`,
`macos_gc (macos-15)`, `macos_gc (macos-15-intel)`. Skipped, queued, cancelled,
superseded or earlier-head runs do not pass a gate. Regular macOS excludes only
the golden GC stress suite; dedicated GC jobs execute it.
The user also authorized the boy scout rule: fix encountered issues and bugs
even outside the current roadmap item. Preserve original controls and record
actual validation; bundle coherent fixes without changing the phase order.

Every entire commit message is one line, at most 80 characters, with no body,
trailers or attribution. Use ordinary author metadata. Squash with an explicit
subject, empty body and exact-head match. Verify the raw resulting message,
one parent and complete-tree parity before updating main.

```sh
gh pr merge NUMBER --squash --subject 'SUBJECT' --body '' --match-head-commit SHA
```

## Main and next delivery

Main is `cbf68ea60c3b9439a117ef9d9b28b472f23dc632` (PR #125). Exact head
`37e94c1efa1bb99e955d026b8dde46dfe632e972` passes all six jobs in CI38190218968 and roadmap_docs38190218974
before squash at 2026-10-12T02:13:11Z. The one-line subject `Check ownership fallbacks and allocation boundaries`
has 51 characters and no body, trailers or attribution.
One parent `3598a675b5bd9ad2e22ac17d42a27a89ea74fdeb` and complete tree `07fe7b60a473f8c5ae6b7aede7678ff7fb17906a` are verified
against the signed commit payload and tested tree. Actual merged-source
acceptance passes runner38194948983 at driverc65aee1c1e5324107972a106c7e95220d55bf9ea.
Reports are retained in /private/tmp/fwp-accepted-phase2-source. Local main stays
68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4; no local compiled checks or fast-forward ran.

## Current verified coverage

Phase2 is complete for the documented compatibility model. All375 declarations
are inventoried:168 contracts,19 IR combinators,11 flat signatures and177
explicit fallback declarations covering167 runtime symbols. The actual merged
source verifies argument/result/callback, retention, teardown and cycle policies.
Tracing remains required for unmodeled graphs and unreachable shared cycles;
this acceptance does not establish tracing-free execution.

Buffer growth/allocation failure, array sizes, bump initialization/alignment,
kernel stack and constant decoding, and device output/workspace bounds pass
original semantic, binary, sanitizer, omission, GC and reuse controls. Interpreter
and native paths preserve checked arithmetic and observable validation/trap order.
Node24 CI actions and current documentation pass final production gates.
Earlier resource/State/AD allocation profiles and immutable queue anchors stay
in history; no new timing or GPU hardware claim follows.

## Remaining ownership deliveries

Queue33 and35–112 are accepted;34 is a verified duplicate. No resource ownership
preparation remains open. Phase6 still requires tracing-free eligibility and a
supported cycle policy; retain explicit compatibility fallbacks until then.

## Numeric representation baseline

Three-platform runner38191886880 passes at2592570aa44b8dc41674238c405e19b33b7e9550
with native source37e94c1, whose full tree matches accepted PR125. Each257-element
I8/U8/I16/U16/I32/U32/F32/F64 array requests2064 header/payload bytes: an8-byte
header and8-byte elements. Exact signed/unsigned extension and negative-zero
bits pass. Diagnostic no-inline assembly shows three-F64 record workers return
through caller storage on both Macs; scalar V bridges use integer words.
This records representation and ABI, without a timing or total-live-memory claim.
Source, byte controls and assembly remain in fwp-numeric-layout-baseline-evidence.
Initial workflow26814b6 failed validation before jobs; moving runner.temp from
job env to step env fixed it. The final2592570 head passes all three jobs.

Initial views will cover only pointer-free numeric arrays. Pointer-bearing and
resource arrays retain copied slices until their disposal-order contracts are
proved. Views must retain backing owners, mask tagged lengths consistently,
avoid unsafe in-place updates and measure backing retention, not just headers.

## Active numeric representation bundle

Typed worker preparation9fe843746e9dd9a7ebf890caaa58a5b656a46076 passes all three
jobs in38195896907. Exact floating payloads and original record trap/ownership
semantics pass. ARM diagnostic assembly returns the three-F64 record in
FP registers d0/d1/d2; Intel uses caller storage for that24-byte result.
Diagnostic no-inline calls are separate from production performance; integrated
controls retain ordinary optimized scalar/record assembly too.

Packed branch ownership-evidence-packed-numeric-arrays is now at
21117f4971e838cf3ccfcf8aa001be804d16bc44; runner38200555737 passes all three platforms.
Previous1432b969b0ed1f780ffced363cc646e569bc4869 passes all three platforms in
38199430982, including packed bytes, original ownership/bounds controls, bit
bridges, view retention/reclamation and allocator-counter omission controls.
Reports, actual optimized assembly and hashes are retained in
/private/tmp/fwp-packed-representation-evidence. Preparation checks do not
establish full production or phase3 acceptance; main remains PR125.

The8-byte header remains; descriptor-directed I8/U8, I16/U16, I32/U32 and F32
payloads use1/2/4-byte elements. I64/U64/F64 remain8 bytes. Pointer-bearing
slices stay copies. Numeric leaf capacity permits array reuse while generic
record reuse keeps its scanned-slot restriction. Kernel constants now load
bits with memcpy from both word and actual double-backed storage, preserving
negative-zero/NaN payloads without effective-type aliasing.

The143 measurements exposed whole-backing retention for tiny slices. The211
refinement copies slices with payload at most the24-byte view header or less
than one quarter of the original backing length; larger numeric slices retain
flat backing owners. Permanent packed_numeric_storage tests cover exact bytes,
alignment, raw/native immutable operations, typed float payloads, complete
allocation counters, last-owner release, nested views and small-copy release.
Packed constructor omission controls exercise widths1/2/4/8. Actual wasm32
count controls must run on Linux and preserve callback/argument trap order.
Positive counts saturate at SIZE_MAX before allocation and slice/take bounds.
All211 refinements pass actual runner controls on all three platforms.

The94d first integration repeated helper insertion, causing C redefinitions.
The3b original scalar-array probe parsed the descriptor as a release function;
b66 corrected its lookup while preserving address-shaped scalar-bit controls.
Both earlier failures are retained; b66 and143 pass all three platforms.
Source generation starts from a stable typed core and a verified formatted ABI
source; publish repairs only with an exact branch lease.

Current sources and receipts: fwp-packed-array-runtime-draft,
fwp-packed-array-original-controls, fwp-packed-array-permanent-controls-publication.json,
fwp-packed-numeric-storage-test-draft.rs, fwp-packed-wasm-test-draft.rs and
fwp-packed-array-size-test-draft.rs. Measurement helpers preserve independent
omission controls and original golden traps. Accepted source provenance is in
fwp-numeric-representation-accepted-source-manifest.json.

Recovery current-map.json designates the active safe map rather than selecting
an obsolete map by entry count. The209 runner validates restoration of all111
temporary targets without executing helpers or the compiler. Historical source,
assembly and completed proofs remain in immutable checkpoints. A56-MiB inline
tree request failed without changing the branch; publication now reuses blobs
and bounds incremental requests. Checkpointb61cde67f467fc67d672b1d0efd3c0cf59a3acad passes audit38200778577
and retains211 sources plus143 reports; bounded restoration metadata is verified.
Current finalization and protocol refinements need the next checkpoint.

## Final bundle refinements

Finalization6bf6b1f2a5fb661d180403c22bf5d18ffede5c39 passes Linux runner38201574707:
formatting, all-target clippy, library and original focused controls, permanent
storage/ABI/view tests, actual wasm32 counts, protocol tests, primitive/fallback
coverage and roadmap docs. Runner-formatted production source hashes and reports
are retained in /private/tmp/fwp-numeric-storage-finalization-export.

Adjacent protocol repairs accept valid zero-byte record collections and check
allocation/count limits before construction. Rust lengths and constructor tags
are checked before narrowing to usize. Native array decoding writes directly
into packed destination storage; its complete allocator control requires one
request, without a word scratch buffer or intermediate list nodes. Truncated
numeric payloads, huge counts and omission controls pass under O1/O2 GC stress.
This focused finalization is not the six-job production merge gate.

Production PR126 is open at916263e7c07443bccd4f87e764ca0c3f33dc664e on
numeric-storage-and-worker-abi. Roadmap documentation38207662006 passes;
current CI38207662016 passes bench, regular ARM macOS and both dedicated GC
stress jobs. Linux and regular Intel macOS remain running. Superseded head8d244fed has the failures below.
CI38202824347 passes bench and both dedicated GC stress jobs, but Linux and
regular ARM macOS fail three older generated-C probes. Regular Intel is still
running. The probes assumed a one-argument array constructor, the previous
position of the array destructor and fwp_r2 worker results. Focused repair
f99f0a64e28f780ef61172fbb4b058994e7d89e1 passes runner38207493251, preserving
all original reclamation, partial-retain unwind, alias and omission controls.
Runner-formatted repairs are retained in /private/tmp/fwp-pr126-probe-repair-export
and published to the current PR126 head. All production gates must pass again. Native
implementation still matches the formatted export; phase3 is not accepted.
Initial13577c8 docs failed because the archive edit removed the tensor timing
anchor. The corrected102-KiB index retains383 unique historic heading names,
selected measurement text and the complete verified b61 snapshot. Superseded
CI38202469769 was cancelled; it is not a passing gate. Preserve its metadata and
old docs failure log. Do not change the current PR head merely for status updates;
keep the live local/recovery handoff current while exact-head gates run.

Require all six current-head jobs and roadmap_docs before squash with the
explicit subject and empty body. merge-numeric-storage.py verifies those gates,
raw resulting message, one parent and complete-tree parity. Actual merged-source
phase3 acceptance remains required after the merge. No new PR is open until then.
Then deliver phases4–6. Windows/new deployment/backends remain deferred.

## Next concrete action

Monitor CI38207662016 at current head916263e7 and require all six production jobs and roadmap_docs at the repaired head; fix any
further failures. Then squash with an explicit one-line subject and empty body,
verify signed commit/tree parity and audit the actual merged source for phase3.
Continue the independent numeric fusion preparation while CI runs. Open the next
coherent numerics PR only after PR126 merges; finish phases4–6 without repeating
already granted publication and merge approval.

## Local checks and recovery

Full builds/tests, benchmarks and large regeneration run on GitHub. Local
workloads are serial, low priority and guarded: sampled aggregate RSS below1GiB,
target below2GiB, at least64GiB free disk, deadline180 seconds. Stop at limits;
never raise or bypass them. Use `python3 scripts/local-guard.py COMMAND...` for
fwp checks. The fun-refactor guard applies to that other repository.
Latest disk observation:57,358,200KiB available, about54.7GiB; local target
103,696KiB, about101.3MiB. The64GiB reserve remains unavailable. No local compiled
check, broad doc audit, rebase or fast-forward ran. Only source edits and bounded
remote metadata publication/downloads ran serially at low priority.

Protect all11 authoritative docs before any guarded main fast-forward:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md,
docs/ownership.md, docs/primitive-ownership.md, docs/roadmap-queue.md,
docs/roadmap-history.md, docs/reference.md, docs/concurrency.md, docs/numerics.md.
Actual pre-acceptance hashed backup: /private/tmp/fwp-main-docs-remote-pre123.
Do not claim a local fast-forward or byte-for-byte restore that did not run.
Preserve other user changes. Last Rust checkout was
/private/tmp/fwp-library-resource-bundle-worktree; source identities require
guarded cleaning before switching compiled checkouts when resources permit.
Immutable tags, remote source heads and retained receipt hashes survive temporary
file loss. Never treat an earlier head, skipped check or source snapshot as a
passing production gate.

Recovery checkpoint688aa92caf2cfac9db9166d523882f734bbefec0 passes
audit38190497358: links, ancestry, subjects, helper syntax and actual immutable
archive restoration all pass. All479 temporary targets/14446001 bytes have
verified hashes. Protected backups keep exact original bytes under snapshot
source names; the restorer selects only complete safe maps containing their
own publisher. Metadata is in fwp-verified-complete-recovery-restoration. No
helper or compiler was executed by restoration and no local restore ran.
Earlier failed audits and their repairs are archived in history.

The duplicate main full matrix38189663885 was cancelled after all seven
pre-merge gates and complete-tree parity were proved. This is duplicate-run
avoidance, not a passing main gate. Proof: fwp-main124-duplicate-ci-proof.json.
Prepared merge-phase2-exit.py, publish-accepted-phase2-audit.py,
download-accepted-phase2-audit.py and record-accepted-phase2.py require actual
passing final gates and the accepted-source audit before advancing phase3.

Numeric design source:30 blob-verified files at frozen PR125 head37e94c1 in
fwp-numeric-representation-phase2-candidate-source. The design preparation
records descriptor-directed packed payloads, backing-owner views, leaf versus
scanned allocation and typed worker ABI bridges. Source review also corrects
the old four-field register claim in the future unboxed-record fixture; actual
placement follows target ABI. These are source-only plans/drafts. Finish PR125
and its actual merged-source phase2 audit before implementation.

## Prepared next-phase investigation

Phase4 preparation may continue while production CI runs; phase3 is not yet
accepted. Examine pure Array map/fold fusion, a blocked F64 matrix path retaining
per-cell floating-point order and generic fallback for malformed/cast shapes,
and bounded reusable AD workspaces with reentrancy/unwind controls. Source
inspection also found unchecked tape capacity multiplication on wasm32 and
realloc pointer replacement on failure; add bounded allocator fault/overflow
controls before changing those paths. They are tasks to fix in the next coherent
numerics bundle, not reasons to stop the roadmap. Numeric Array fusion c0281d6401a147fcbd70470be3aad91801187f8b passes focused
Linux runner38209247194. Direct flat loop arguments and scalar Array.get
variant fields remove all managed requests after constructing129/257-element
inputs, versus two intermediate arrays without fusion. The initial report's
compiler metadata printed clang although compilation used default cc; its
actual version was not captured. compiler-metadata-correction.json preserves
that limitation. Subsequent runners select/query clang explicitly.

Stronger controls60ba62771157b5281bf19e6f21d53a7216ff2c79 pass Linux
runner38210787637: effect/checked-trap order, recursive-callback rejection,
finite bits, arithmetic NaN classification, reclamation and AD allocator
omission controls. Exact NaN payloads remain in evidence; arithmetic payloads
follow existing compiler choices, while copies/storage/protocol/ABI retain
exact bit contracts. Early fixtures omitted rec and an undeclared JSON crate;
those test defects are fixed using the existing fwp JSON parser. Initial
arithmetic NaN payload equality was overconstrained; retain actual results and
the LLVM-backed contract in ownership/reference docs, not a new canonicalization.

Current preparatione166e1d67a11b2d9a3825f6de2936db5543b51ee on
ownership-evidence-numeric-array-fusion passes Linux runner38211872588.
Its single512-KiB bounded native AD workspace cache passes cold/warm profiles,
return/trap/cancellation, registry reentrancy and shutdown controls. The prior
2f run passed workspace controls but failed the fusion signed-zero control:
the updated fixture was missing from the publication map. Including that
fixture repairs the failure; no semantic assertion was removed. Formatted
source and reports are retained in fwp-numeric-fusion-workspace-evidence.
Original physical-free omission probes explicitly run with FWP_AD_WORKSPACE=0;
new cache controls run both settings. Matching interpreter tape size bounds
pass. A Rust workspace cache, blocked matrix path, actual wasm32 AD capacity
case and broader C/Rust memory/performance comparisons remain required.
Native workspace reuse and phase4 support are not yet accepted. Source drafts
are in fwp-phase4-ad-workspace-draft; receipts and preparation helpers are in
/private/tmp. No next production PR is open while PR126 remains unmerged.

After all PR126 gates pass, merge-numeric-storage.py checks signed one-line
squash/tree parity; publish-accepted-numeric-source-audit.py then audits the
actual main source, inventory/fallback coverage and every exact-head gate.
These audit helpers are prepared, not executed. Phase3 is unfinished until
that actual merged-source acceptance passes. Record all further failures and
fix them; continue phases4–6 automatically.
