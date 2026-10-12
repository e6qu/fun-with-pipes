# Session handoff

Updated 2026-10-12. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff.
[Queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
preserves accepted and superseded evidence. Root docs are authoritative.

Durable recovery branch: `roadmap/handoff-pr123-20261011`. Last verified
checkpoint `162952070773bca2abf0f6dce089f3089dedbb27` passes audit38195043195.
Query the branch tip on recovery; an embedded checkpoint cannot identify its
own commit. restore-roadmap-recovery.py restores only temporary paths from a
bounded immutable archive after verifying Git blob hashes. Its runner audit
verifies559 targets/30385213 bytes. Never rerun completed publishers. Phase2 is accepted; phases3–6 remain unfinished.

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

Packed branch ownership-evidence-packed-numeric-arrays is at
b66e60d1342f261a07efa567e696b9a823f10cd7. Runner38197625349 passes Linux and ARM;
Intel remains running. Main stays accepted PR125: these are preparation checks,
without a final production gate, full performance or phase3 acceptance claim.
The8-byte header remains; descriptor-directed I8/U8, I16/U16, I32/U32 and F32
payloads use1/2/4-byte elements. I64/U64/F64 remain8 bytes. Numeric views retain
backing owners; pointer-bearing slices remain copied. Structural operations,
constants, decoding, SIMD and kernels use matching descriptors or word-wide
view data helpers. Original ownership and bounds tests remain required.

The94d first integration repeated helper insertion, causing C redefinitions.
The3b original scalar-array probe parsed the new descriptor as a release function;
b66 fixes its lookup while preserving its address-shaped scalar-bit controls.
Source generation now starts from a stable typed core. Preserve actual failed
logs and do not treat either earlier head as passing. Pending source refinements
add leaf-array capacity without broadening generic record reuse, view backing
retention/reclamation measurements and explicit target-width count controls.
Positive count normalization saturates at SIZE_MAX before allocation/clamp checks.

Current helpers: prepare-packed-array-runtime.py, prepare-packed-array-integration.py,
measure-packed-numeric-arrays.py, publish-packed-numeric-arrays.py and publication
receipts. Original controls and source drafts are in fwp-packed-array-original-controls
and fwp-packed-array-runtime-draft. Actual accepted source snapshot is recorded
in fwp-numeric-representation-accepted-source-manifest.json. Never overwrite the
b66 branch with pending sources without an exact lease and rerunning its controls.

Recovery now designates the current safe map with current-map.json rather than
choosing an obsolete map by its entry count. Historical source/assembly and
completed ownership proofs remain in immutable checkpoints; current recovery
restores only phase3 work and necessary acceptance proofs. Publication reuses
unchanged blobs and bounds incremental tree requests. A56-MiB inline tree request
was rejected; no branch changed until the bounded publisher verified its tree.
New recovery source changes still require a passing disposable-runner restoration.

## Next concrete action

Deliver phase3 in one coherent representation/ABI bundle: descriptor-directed
naturally packed narrow numeric arrays, checked views retaining their backing
owners, and typed scalar/aggregate worker layouts with ordinary V bridges.
Start from the actual accepted main above; preserve Pipe semantics and all
existing generic, callback, ownership and exceptional controls. Prove exact
bytes, alignment, immutable update behavior, serialization/hash/FFI compatibility
and actual ARM/Intel ABI assembly before performance claims. Source preparation:
fwp-numeric-representation-design-preparation.json and its verified source
manifest. Refresh those snapshots to this accepted base before implementing.
Finish phases3–6 with full exact-head gates and one-line squash messages.

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
