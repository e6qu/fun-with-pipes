# Session handoff

Updated 2026-10-12. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff.
[Queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
preserves accepted and superseded evidence. Root docs are authoritative.

Durable recovery branch: `roadmap/handoff-pr123-20261011`. Last verified
checkpoint `a627bcfae3b1994004da28ff5f7166bad709d221` passes audit38189357799.
Query the branch tip on recovery; an embedded checkpoint cannot identify its
own commit. restore-roadmap-recovery.py restores only temporary paths from a
bounded immutable archive after verifying Git blob hashes. Its runner audit
verifies395 targets/9594149 bytes. Never rerun completed publishers. Phases2–6
remain unfinished.

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

Main is `3598a675b5bd9ad2e22ac17d42a27a89ea74fdeb` (PR #124). Frozen head `3aae99bfa705e26babc2cf251b0e583dfd95cf38` passes all six
jobs in CI38184549852 and roadmap_docs38184549850 before match-head squash
at 2026-10-12T00:52:11Z. Subject `Own resource and State lifetimes and preserve inferred effects` has 62 characters,
one line and no body/trailers/attribution. One parent `b4285fc177b3ae7afaf195e5ebd7115cc77b815c` and complete
tree `28ae0e5cea7fa5948683adb39a035ed40fb9b226` match the tested head. Raw signed payload:
fwp-pr124-signed-payload.txt. All11 docs were backed up before these acceptance
edits in /private/tmp/fwp-main-docs-remote-pre124. Local main remains `68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4`;
no local fast-forward or compiled check ran while free disk is below64GiB.

Queue33 and35–112 are accepted;34 is a verified duplicate. PR124 accepts resource
and network owners, compiler/cache/effect repairs, scoped AD and list/closure
lifetimes, typed State and14 fresh codec leaves, plus codec fixture-copy repair. Borrowed scoped inputs require
Dup; affine File rejection, type snapshots, actual WASI and all original nonlocal
exit/omission controls pass. Public Pipe and grad/vjp signatures remain unchanged.
Raw buffers still require mem.free; unknown reconstruction and retained contexts
keep tracing. Fake OpenCL tests do not establish GPU hardware support.

## Current verified bundle evidence

Accepted strict inventory:375 declarations/365 symbols,40 aliases,168 contracts,
19 IR combinators,11 flat signatures and177 review declarations/167 symbols.
Complete counters include initializer fast paths and count slow delegation once.
Independent Linux/ARM/Intel and final combined Linux profiles pass. Scoped grad
matches33 calls/720 requested bytes per gradient. State4096-call profiles reduce
managed calls16384→12288 and requested bytes272212→206676, with counted freed
bytes0→262144. List2048-call profiles retain43008 calls/965374 bytes and raise
counted freed bytes65536→917504. These are workload-specific results, without
a timing or tracing-free claim. Earlier partial counter reports remain archived.

## Remaining ownership deliveries

All immutable preparation rows74–112 are delivered; their contracts, heads and
original checks are archived in history. Queue anchors remain unchanged.
Next: rebase the passing finite fallback audit, checked buffer/array/bump allocation and
kernel stack/constant decoding and device allocation fixes with current CI actions onto the actual PR124 squash, preserve all11 current docs, publish one focused
ownership exit PR and require its six exact-head jobs and roadmap_docs. Confirm
actual merged-source coverage before marking phase2 complete. Then implement
natural-width numeric storage and views, followed by phases4–6. No numeric
representation or tracing-free acceptance is established yet.

## Next bundle preparation

The177 remaining declarations have an explicit shared-fallback review draft at
/private/tmp/fwp-phase2-explicit-fallback-review-draft.json. It records argument,
result, callback, retention, teardown and cycle policies across18 families.
Three-platform review38180899508 passes at167d769deaa28fae9b361ba4e9fa33b443d1a79c
on ownership-evidence-phase2-exit-review: actual inventory, compiler fallback
rules and the buffer controls agree. PR124 is accepted; the next final full
production matrix and merged-source audit remain required; this does not establish tracing-free eligibility.
Validate the actual accepted inventory and compiler wrappers before phase2 exit.
Verifier and three-platform workflow drafts: fwp-check-explicit-fallback-review-draft.py
and fwp-phase2-exit-review-evidence.yml. No phase2 exit claim is established. Publication receipt:
fwp-phase2-exit-review-publication.json.

The boy scout audit found structural buffer addition/doubling overflow and
unchecked realloc failure in the exact1aadb runtime/fwp_rt_ops.c. Draft repair
preserves malloc/free storage and exits102 on overflow/allocation failure.
Runner-only branch ownership-evidence-structural-buffer publishes
c95d970c8c300cf3b342847ee60f7fd052294f28; runner38180514117 passes Linux and both Macs. Tests cover
ordinary growth/data preservation, addition overflow, capacity overflow and
allocation failure at O1/O2 with ASan/UBSan, plus three deliberate omission
variants. Drafts: fwp-structural-buffer-{draft.c,test.rs,probe.c,patch.json}.
Deliver it with the finite ownership exit review in the next coherent bundle.

Array-limit candidate296ea83b45bb153c2b86d1df68e05c799013b2eb on
ownership-evidence-array-size-limits passes all three jobs in38182446407.
Central constructor multiplication, matching interpreter make/generate limits,
bump alignment overflow and nonnull empty initialization are checked. Five
raw/native cases preserve oversized make/generate traps, argument trap order
and negative counts at O1/O2 with reuse on/off and real GC/reuse verification.
ASan/UBSan constructor/bump omission controls,71 library units, all golden type
snapshots and eight effect tests pass. Proof: fwp-array-size-passing-proof.json.
Earlierd8/b42 failed a missing native forward declaration; a2 passed all C/unit/
effect/snapshot controls but the new semantic fixture expected1 rather than the
established trap status101. The final head corrects that fixture and makes the
initialization omission's null-address arithmetic defined. No control was removed.
Logs: fwp-array-size-d8-failed.log and fwp-array-size-a2-linux-failed.log.
Include this passing repair in the same phase2 exit bundle; final full gates still
apply. Drafts: fwp-array-size-{runtime-draft.c,interpreter-draft.rs,gc-draft.c,
test.rs,probe.c}; fwp-bump-size-probe.c.

Completed acceptance: fwp-record-pr124-remote-acceptance.py backed up11 docs
and archived39 live/primitive rows after exact-head squash/raw-payload proof.
It streamlined obsolete design/resource notes into history. Do not rerun it. fwp-finalize-phase2-exit-on-runner.py and
fwp-publish-phase2-exit-finalization.py require the actual PR124 squash and passing
finite review. That finalizer pins the passing296ea83 array/bump source
and passing kernel/device sources and all three verified preflight jobs.
It preserves original controls and exports one ownership exit/allocation bundle and fresh docs for the next full matrix.

Numeric design preparation reads30 blob-verified files at d5ae8c and maps108
direct array references in seven runtime files. Current arrays have8-byte
headers and V-word payloads; F32 values use low32-bit encoding. Draft layout
alternatives and producer/consumer, view-owner and ABI requirements are in
fwp-numeric-representation-design-preparation.json. This is source review, not
a representation implementation or compiled evidence. Complete phase2 before
changing numeric representation.

Kernel candidate d240231c5dd33e83ecdd5bf3df06715a0e279768 passes all three
platform jobs in38186836622. It guards empty-stack pointer formation and reads
F64 constant V words through the existing memcpy bit decoder. Extracted actual
kernels pass O1/O2 sanitizers with first leaf/constant operations, lengths
0/1/7/127/256, nonzero offsets, exact bytes and sentinels. Omitted stack guards
and constant decoders fail their controls. Original parallel/missing-OpenCL
tests pass against FWP_NO_OPT=1; the benchmark remains ignored, with no timing
or GPU hardware claim. Proof: fwp-kernel-constant-bits-passing-proof.json.

Device candidate6ee21a54dee1029178b28291d60dd31dd179a7a7 on
ownership-evidence-device-output-bounds checks positive output counts before
multiplication/allocation, preserving malformed code and input-length trap order
and releasing the temporary input table. Workspace limits follow input validation
in both implementations. All three jobs in38188567610 pass; proof: fwp-device-bounds-passing-proof.json. Previous
857 candidate passed both Macs; Linux38188246198 found LeakSanitizer changed
deliberate omission exits because the sentinel left small probe allocations alive.
The repaired sentinel records omitted bounds/cleanup before freeing its own
allocations; leak detection remains enabled. Original raw/O1/O2/GC/reuse and
omission controls remain. The passing candidate is ready for inclusion in the next coherent
bundle; its final production gates remain required. Receipts: fwp-device-bounds-publication.json and
fwp-device-bounds-control-cleanup-publication.json; diagnostic log:
fwp-device-bounds-857-linux-failed.log.

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

The cancelled d5 Linux log independently confirms the same codec source-copy
failure; retained Linux/Intel logs reveal no other completed test failure before
cancellation. Cancelled jobs supply no passing evidence. A Node20 action-runtime
deprecation warning was also encountered. Verified official checkout/upload v7
manifests use Node24. A source-only action-version patch is prepared for the next
phase2 exit bundle; job definitions, checks and artifact inputs remain intact.
Node24 checkout/uploads pass the three-platform preflights; full production
gates remain required. Recipe:
fwp-node24-actions-patch.json; preparation: fwp-node24-actions-preparation.json.
Finalization driver83f240569685274589bc1a003f2f444b0dd79e94 on
ownership-phase2-exit-finalization uses the accepted3598a675 base and includes
all passing buffer/array/kernel/device candidates and this action patch. Its
combined runner controls, formatting, library tests and exact-source audit are
pending. Export native changes after PASS; refresh current root docs before
opening the one production PR, then require its exact full gates. The accepted-source phase2 audit remains a source-only draft until the
finite review bundle is merged and its exact source is checked.

Recovery checkpoint f7290c8827f641d8f9cdc9928f1c68a59954e61a passes
audit38188292080. The bounded immutable archive path actually restores395
temporary targets (9594149 bytes) on a disposable GitHub runner, verifying all
source hashes. Helpers and compiler were not executed. Only bounded reports
were downloaded into fwp-verified-archive-recovery-restoration; no local restore
ran. Node24 checkout/upload pass there and in all three kernel preflights.
Keep finalization metadata separate from binary control artifacts.

The duplicate main full matrix38189663885 was cancelled after all seven
pre-merge gates and complete-tree parity were proved. This is duplicate-run
avoidance, not a passing main gate. Proof: fwp-main124-duplicate-ci-proof.json.
Prepared merge-phase2-exit.py, publish-accepted-phase2-audit.py,
download-accepted-phase2-audit.py and record-accepted-phase2.py require actual
passing final gates and the accepted-source audit before advancing phase3.

Recovery audit38189929028 at42c1aa913f8ba370b29068c7edbb2803ce47871b
found that copied backup Markdown was being checked as live documentation,
so its original relative links no longer resolve inside the backup directory.
Preserve the original bytes under snapshot source names and remove duplicate
live Markdown paths on the recovery branch; then rerun that audit. Production
source/combined validation is independent and passes38189708217.

Combined ownership exit preparation passes runner38189708217 at driver83f240569685274589bc1a003f2f444b0dd79e94.
Native export 07fb6f72f7a0b4309057f89209250ca573d7103e has tree30a0ccea090697165713d2411ed75f3f0aa03a35 on the actual
PR124 squash. All original allocation, sanitizer, raw/native, codec, type,
format/library/docs, inventory and finite fallback controls pass together.
Current root docs are refreshed before opening the production PR; this update
changes documentation only. Query ownership-exit-and-buffer-bundle for its
current tip and require all six exact-head jobs and roadmap_docs before squash.
Phase2 stays open until the actual merged-source audit passes.

Current delivery is PR[#125](https://github.com/e6qu/fun-with-pipes/pull/125),
head37e94c1efa1bb99e955d026b8dde46dfe632e972 on the accepted PR124 squash.
Roadmap_docs38190218974 passes; full CI38190218968 is running. The combined
runner38189708217 passes at83f240569685274589bc1a003f2f444b0dd79e94;
exportd5e0386c526c399f4bfe67c171ed44f9c3bc2f05 then documentation-only37e94c1
preserves the verified native tree. Do not restart this matrix for handoff-only
updates. Require all six current-head jobs and docs before merge-phase2-exit.py;
then run the accepted-source audit and record its actual proof before phase3.
Receipts: phase2-exit-finalization-export/publication.json,
fwp-phase2-exit-docs-publication.json and fwp-pr125-publication.json.

Recovery audit38190316575 atc1d0b8b04a7c4f97526056ed9780f3aba05555e9
passes links/ancestry/subjects, but restoration selected an older map because
the repair publisher lacked the checkpoint suffix. The restorer now considers
all publish Python files with safe literal maps, requires every mapped blob to
exist and requires a self entry before selecting the largest map. Verify this
refinement with actual runner restoration before marking recovery verified.

Numeric source preparation now also retains30 blob-verified files at frozen
PR125 head37e94c1 in fwp-numeric-representation-phase2-candidate-source. This is
source preparation only; full gates and actual merged-source phase2 acceptance
remain required before representation implementation.
