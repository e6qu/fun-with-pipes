# Session handoff

Updated 2026-10-12. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff.
[Queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
preserves accepted and superseded evidence. Root docs are authoritative.

Durable recovery branch: `roadmap/handoff-pr123-20261011`. Last verified
checkpoint `2e597098a5f2007be64bf09e5ff1e330ec93487a` passes audit38182062034
and retains the latest AD/input and callback diagnostic sources. Query the branch tip when recovering; do not assume an embedded
checkpoint identifies its own commit. Restore only temporary paths with verified
Git blob hashes using restore-roadmap-recovery.py. The AST-based restore repair
is source-reviewed, but its execution has not been validated. Never rerun
completed publishers. Phases2–6 remain unfinished.

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

Main is `b4285fc177b3ae7afaf195e5ebd7115cc77b815c` (PR #123). Frozen head `9e7d0b24610524cf54125c44b47ee07185c0b7c3`
passes all six exact-head jobs in CI38138731040 and roadmap_docs38138731036
before match-head squash at 2026-10-11T17:47:22Z. Subject `Own library file and raw-memory resource lifetimes`
has 50 characters, one line, empty body and no trailers or
attribution. One parent `68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4` and complete tree `c94ed7f1bbc4e0c1f8f74b2fcbbbbe70e1359b0c` match
the tested head. The raw signed payload is retained in
/private/tmp/fwp-pr123-signed-payload.txt. All11 live docs were backed up before
acceptance edits in /private/tmp/fwp-main-docs-remote-pre123. Local main remains
`68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4` until the guarded fast-forward has at least64GiB free disk; no local
checkout update or full check ran. Actual-main documentation38161107226 passes independently.

Queue33 and35–73 are accepted; queue34 is a verified duplicate. PR123 accepts
all42 original library/OpenCL/TLS/file/resource commits and both pointer and
raw-memory repairs. Raw pointer offsets wrap at the native pointer width;
ordinary arithmetic remains checked. Nine raw-memory primitive contracts
borrow their arguments; ptr.read-string returns a counted independent managed
copy. C buffers still require mem.free. Fake OpenCL coverage does not prove
GPU hardware support, and F16/128-bit/WASI pointer widths remain unverified.

Current delivery is PR[#124](https://github.com/e6qu/fun-with-pipes/pull/124):
resource/network items74–112, compiler/cache diagnostics, AD tape/scoped-gradient
lifetimes, list callback owners, closure cleanup and typed State ownership.
Production head is `d5ae8c2d5422fe2ef6e1c94009c6b62dffda9db0`, complete tree
`db8348f963973fa32fb0803348fcb53a2c072a52`, identical to the final runner export.
Full CI38180852377 is running at that exact head; bench and ARM GC pass; the other
three regular-platform jobs run; both GC jobs pass. Roadmap_docs38180852369 passes.
Publication receipt: /private/tmp/fwp-pr124-final-ownership-export/publication.json.
Do not merge until all six jobs and the documentation audit pass.

Duplicate main CI38161107239 was cancelled while all six jobs were queued,
after complete-tree identity and all seven passing pre-merge gates were proved.
This is duplicate-run avoidance, not a passing main gate. Proof:
/private/tmp/fwp-main123-duplicate-ci-proof.json.

## Current verified bundle evidence

Final integration driver489508a071d908d7c5396cd7a117176173980e39 passes
runner38179558348. It combines direct scoped gradients,14 fresh codec contracts,
typed State, the callback effect repair and complete allocator instrumentation.
All71 library units, original type snapshots, task/State/AD controls, affine File
rejection, input aliases, formatting and stdlib docs pass together. Its strict
inventory verifies375 declarations/365 symbols,40 aliases,168 contracts,
19 IR combinators,11 flat signatures and177 review declarations/167 symbols.

The final diagnostic refinement6ff1ffb1a7ad14b83e2149757f5c476d806803b4 passes
runner38179961853: eight effect controls, original snapshots, native task aliases,
State controls and71 library units. Argument comparison permits only the
parameter's known outer effects, preserves nested input rows and displays the
original callback type on every mismatch. No original task fixture was changed.
Final driver040a3f64f4e2fcc9466c76aea7466a6fc36a3d68 integrates this refinement
and streamlined docs; runner38180262247 passes and its exact tree is published.

Complete counters include initializer fast paths and count slow delegation once.
Independent Linux/ARM/Intel State38174682933, list38175393180 and scoped
AD38176126768 comparisons pass; combined-source Linux profiles also pass in
38179558348. State4096-call O1/O2 managed calls fall16384→12288 and requested
bytes272212→206676; counted freed bytes rise0→262144. List2048-call profiles
retain43008 calls/965374 bytes and raise counted freed bytes65536→917504.
Scoped grad4096-call profiles match the baseline33 calls/720 bytes per gradient,
repairing the40-call/872-byte regression without weakening assertions. Hardware,
compiler, flags and source/binary hashes remain in the runner artifacts. Combined
Linux report metadata is retained in fwp-pr124-final-combined-profile-metadata,
with source893a9c60586ede490c8d949223d6a45862ae3fd8 and artifact11716429988.
No timing or tracing-free claim is established.

The old production38174221614 is complete: regular Linux/ARM/Intel fail only
the original pass-fn callback comparison; bench and both GC jobs pass.
Documentation38174221611 passes. These are earlier-head diagnostics, not final
gates. Logs: fwp-pr124-combined-{linux,arm,intel}-failed.log.

Next: monitor all six production jobs and roadmap_docs at d5ae8c. Fix any
failures without weakening original controls; squash only after all seven gates
pass for that head. Prepared merge/verification scripts now pin d5ae8c and both
current run IDs; do not execute while gates are pending. Keep one production PR.
Prepare the finite177-declaration phase2 classification while CI runs. Earlier
preflights and cancelled runs cannot supply final production gates. Phases2–6
remain open. Integration recipe: fwp-integrate-final-ownership-on-runner.py.
Final runner/export head0b4a2d61781b6151fda28d690c0db9a5463b9090 has the
same complete tree as production d5ae8c. No local compiled test ran.

## Remaining ownership deliveries

Original focused checks are preserved in
[history](roadmap-history.md#prepared-ownership-checks-retained-during-handoff-streamlining).
Use actual bases below, never immutable OLD parents. Preserve all11 root docs
when resolving conflicts. Remove a live row only after verified acceptance or
a verified duplicate, retaining its queue anchor and history. All listed
preparations need final squash rebases and all seven exact-head production gates.

| Row / branch | Current head | Actual current base | Delivery status |
|---|---|---|---|
| 74 ownership-file-runtime-owners | 8d5cb3c4e3e4 | 3dba256655a3 | Runner integration passed; production gates pending |
| 75 ownership-file-discard | 423a7ddcc760 | 8d5cb3c4e3e4 | Runner integration passed; production gates pending |
| 76 ownership-file-runtime-boundaries | 603bb0b914db | 423a7ddcc760 | Runner integration passed; production gates pending |
| 77 ownership-wasm-resource-counts | f4a26004d5a8 | 603bb0b914db | Runner integration passed; production gates pending |
| 78 ownership-wasm-count-disposal | 13c77dbb7b82 | f4a26004d5a8 | Runner integration passed; production gates pending |
| 79 ownership-resource-frame-fields | 2f842d5d266f | 13c77dbb7b82 | Runner integration passed; production gates pending |
| 80 ownership-file-inline-path | 010e622f064e | 2f842d5d266f | Runner integration passed; production gates pending |
| 81 ownership-file-storage-disposal | 6e5063786651 | 010e622f064e | Runner integration passed; production gates pending |
| 82 ownership-file-construction-disposal | ecfd9a28c39e | 6e5063786651 | Runner integration passed; production gates pending |
| 83 ownership-resource-frame-variants | 7b7e45b20230 | ecfd9a28c39e | Runner integration passed; production gates pending |
| 84 ownership-resource-frame-binding-kinds | e2a2baa977fa | 7b7e45b20230 | Runner integration passed; production gates pending |
| 85 ownership-match-scrutinee-types | ebe69e13a935 | e2a2baa977fa | Runner integration passed; production gates pending |
| 86 ownership-resource-record-binding-kinds | a0de231a4c0c | ebe69e13a935 | Runner integration passed; production gates pending |
| 87 ownership-nominal-source-context | 5a4ef15301c8 | a0de231a4c0c | Runner integration passed; production gates pending |
| 88 ownership-channel-cycle-lifetimes | 3db25573057b | 5a4ef15301c8 | Runner integration passed; production gates pending |
| 89 ownership-http2-body-roots | 5bc4f862bd5a | 3db25573057b | Runner integration passed; production gates pending |
| 90 fix-http2-body-bounds | fabe0ac7b24a | 5bc4f862bd5a | Runner integration passed; production gates pending |
| 91 ownership-http2-peer-cleanup | 5029a447bcec | fabe0ac7b24a | Runner integration passed; production gates pending |
| 92 ownership-grpc-peer-completion | 26545f1b279b | 5029a447bcec | Runner integration passed; production gates pending |
| 93 ownership-grpc-status-cleanup | 9ad102d5a16f | 26545f1b279b | Runner integration passed; production gates pending |
| 94 ownership-grpc-receive-cleanup | ec0fd11c6b26 | 9ad102d5a16f | Runner integration passed; production gates pending |
| 95 ownership-grpc-force-cleanup | 91ab62452636 | ec0fd11c6b26 | Runner integration passed; production gates pending |
| 96 ownership-grpc-render-cleanup | b4087dc07beb | 91ab62452636 | Runner integration passed; production gates pending |
| 97 ownership-grpc-send-cleanup | 0203804096d8 | b4087dc07beb | Runner integration passed; production gates pending |
| 98 ownership-grpc-request-encoding | 9c2c91fa8e21 | 0203804096d8 | Runner integration passed; production gates pending |
| 99 ownership-grpc-canonical-encoding | 58bf72dbf3df | 9c2c91fa8e21 | Runner integration passed; production gates pending |
| 100 ownership-grpc-response-encoding | 3b13964722ba | 58bf72dbf3df | Runner integration passed; production gates pending |
| 101 ownership-grpc-client-requests | a584b59ec896 | 3b13964722ba | Runner integration passed; production gates pending |
| 102 ownership-grpc-client-failure-text | 4e6dbbddf888 | a584b59ec896 | Runner integration passed; production gates pending |
| 103 ownership-grpc-client-receive | 09b5e3e70117 | 4e6dbbddf888 | Runner integration passed; production gates pending |
| 104 ownership-grpc-connect-cleanup | 518e5cfaca02 | 09b5e3e70117 | Runner integration passed; production gates pending |
| 105 ownership-grpc-connect-startup | 4802e1dfb8a5 | 518e5cfaca02 | Runner integration passed; production gates pending |
| 106 ownership-grpc-context-restore | 2308b7c1db43 | 4802e1dfb8a5 | Runner integration passed; production gates pending |
| 107 ownership-grpc-context-resources | a2b3b132f094 | 2308b7c1db43 | Runner integration passed; production gates pending |
| 108 ownership-grpc-capture-resources | ef437370ca74 | a2b3b132f094 | Runner integration passed; production gates pending |
| 109 fix-grpc-tls-pool-identity | c9d841ee5a9d | ef437370ca74 | Runner integration passed; production gates pending |
| 110 ownership-grpc-environment-cache | bf297ac299ea | c9d841ee5a9d | Runner integration passed; production gates pending |
| 111 ownership-grpc-packed-options | 5a01572cb2c6 | bf297ac299ea | Runner integration passed; production gates pending |
| 112 ownership-grpc-connection-addresses | b45e93a71d40 | 5a01572cb2c6 | Runner integration passed; production gates pending |

## Finish phase2, then continue the plan

The pointer-width and raw-memory contracts are accepted in PR123.
Independent Linux/ARM/Intel evidence remains in
/private/tmp/fwp-pointer-boundary-passing-proof.json and its retained artifacts.
The twelve sanitizer binaries preserve exact success0/overflow1 statuses;
F16/128-bit, WASI pointer widths and automatic raw-buffer lifetimes remain
separate requirements. Production acceptance is recorded above.

After queue112 is delivered, recheck the finite [ownership exit gates](ownership.md#phase-2-exit-gates)
and [primitive contracts](primitive-ownership.md) against merged source. The verified final candidate168-contract inventory leaves177 declarations/167
symbols for classification. Preserve conservative fallbacks until typed ownership and
teardown are proved.

Review borrowed metadata roots, reconstruction/partial failure, retained
callbacks/contexts and resource disposal. The source-reviewed fallback list also
includes per-task typed State slots and remaining callback/reconstruction paths;
see [primitive contracts](primitive-ownership.md). List reconstruction owners
and inactive State root clearing now have published candidate controls below.
Typed State ownership is verified in the candidate; full production gates and
merge remain required.
Channel close preserves queued values;
explicit drain breaks its counted cycle, while automatic unreachable-cycle
reclamation remains unproved. Scalar AD tape handles do not prove external
buffer lifetimes. Numeric lifetime findings and future regressions are in
[numerics](numerics.md). Complete phase2 before representation, numerics/AD,
performance and tracing-free work. Phases3–6 still require implementation and
measured acceptance; the prepared ownership queue is not the whole plan.

## Next bundle preparation

The177 remaining declarations have an explicit shared-fallback review draft at
/private/tmp/fwp-phase2-explicit-fallback-review-draft.json. It records argument,
result, callback, retention, teardown and cycle policies across18 families.
Three-platform review38180899508 passes at167d769deaa28fae9b361ba4e9fa33b443d1a79c
on ownership-evidence-phase2-exit-review: actual inventory, compiler fallback
rules and the buffer controls agree. PR124 acceptance and the next final full
production matrix remain required; this does not establish tracing-free eligibility.
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
Fold it into the next ownership exit bundle after PR124 acceptance; no second
production PR opens before that merge.

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
Fold this passing repair into the same phase2 exit bundle; final full gates still
apply. Drafts: fwp-array-size-{runtime-draft.c,interpreter-draft.rs,gc-draft.c,
test.rs,probe.c}; fwp-bump-size-probe.c.

Prepared post-merge helpers: fwp-record-pr124-remote-acceptance.py backs up11 docs
and archives39 live/primitive rows only after exact-head squash/raw-payload proof.
It streamlines obsolete design/resource notes into history. Never execute before
verified acceptance. fwp-finalize-phase2-exit-on-runner.py and
fwp-publish-phase2-exit-finalization.py require the actual PR124 squash and passing
finite review. That finalizer pins the passing296ea83 array/bump source
and all original controls. It will export a focused ownership
exit/buffer/array-limit bundle and fresh docs for the next full matrix.

Numeric design preparation reads30 blob-verified files at d5ae8c and maps108
direct array references in seven runtime files. Current arrays have8-byte
headers and V-word payloads; F32 values use low32-bit encoding. Draft layout
alternatives and producer/consumer, view-owner and ABI requirements are in
fwp-numeric-representation-design-preparation.json. This is source review, not
a representation implementation or compiled evidence. Complete phase2 before
changing numeric representation.

## Local checks and recovery

Full builds/tests, benchmarks and large regeneration run on GitHub. Local
workloads are serial, low priority and guarded: sampled aggregate RSS below1GiB,
target below2GiB, at least64GiB free disk, deadline180 seconds. Stop at limits;
never raise or bypass them. Use `python3 scripts/local-guard.py COMMAND...` for
fwp checks. The fun-refactor guard applies to that other repository.
Latest disk observation:61,067,468KiB available, about58.2GiB; local target
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
