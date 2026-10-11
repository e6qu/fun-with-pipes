# Session handoff

Updated 2026-10-12. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff.
[Queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
preserves accepted and superseded evidence. Root docs are authoritative.

Durable recovery branch: `roadmap/handoff-pr123-20261011`. Last verified
checkpoint `fd021cf198e753e3a9f356136b335c903dd50f10` passes audit38171968563.
The next checkpoint retains the completed repair export and this streamlined
handoff. Query the branch tip when recovering; do not assume an embedded
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
Production head is `1aadb8a075e1737d0e6a4db96eae5d675f6fb404`, complete tree
`e630e0ff07988dee60a7e2a61bb3689d089ed92b`. CI38174221614 is running;
roadmap_docs38174221611 passes at that head. No full-matrix acceptance yet.
Publication receipt: /private/tmp/fwp-pr124-combined-repair-export/publication.json.

Duplicate main CI38161107239 was cancelled while all six jobs were queued,
after complete-tree identity and all seven passing pre-merge gates were proved.
This is duplicate-run avoidance, not a passing main gate. Proof:
/private/tmp/fwp-main123-duplicate-ci-proof.json.

## Current verified bundle evidence

Combined driver `85b305ccad63527101a329e3f4bab2c3318458da` passes preflight38173831552.
The published tree matches runner export31c86694f4f7f6eec870ffa73add7dabbdd0eba0.
All71 library units, type snapshots, effect controls, format stability/faithfulness,
stdlib docs and expanded State ownership tests pass together. Four positive
stored-callback cases and two missing-IO negatives protect both inference fixes:
call-time ambient labels extend temporary call rows, while row unification
refreshes tails after common payload unification. Signature instantiation and
function-pipe composition semantics stay intact.

State stack records own typed values, retain borrowed initials and gets, protect
replacement/callback results, and release on normal/error/trap/cancellation and
boxing failure. Task switches preserve each owner chain. Scalar address-shaped
bits remain uncounted. Array/record States and runtime-dependent heap-capturing
closures agree between raw interpretation and native O1/O2 with stack placement
on/off, real GC stress/verification and reuse verification on/off. C/source/
binary/status artifacts are retained before assertions. Unknown legacy activations
and boxed unmodeled payloads retain their documented tracing fallback.

Strict integrated inventory verifies374 declarations,364 symbols,40 aliases,
153 contracts,19 IR combinators,11 flat signatures and191 review declarations
representing181 symbols. Missing contracts are classification work, not inherently
bugs. State focused evidence38167118922 and allocation evidence38166896486 pass
Linux/ARM/Intel. Existing resource, WASI and omission controls remain required.

Original production38164685147 failed only lib/autodiff formatting assertions;
its documentation38164685131 failed the numeric-row parser. Both repairs pass the
combined preflight. Earlier failed/cancelled preflights are archived in
[history](roadmap-history.md#pr124-combined-repair-preflight-chronology).

Next: monitor all six jobs on the current production head, repair any failures,
then exact-head squash with the required one-line subject and empty body. Preserve
this running full matrix rather than restarting it solely for docs. Carry the
streamlined root docs into the next bundle after merge. Prepare the remaining
phase2 classification and concrete fixes while CI runs; no later production PR
opens before #124 merges.

Allocation evidence review found that fwp_alloc_init has a fast path bypassing
fwp_gc_alloc. Existing managedCalls/managedRequestedBytes instrumentation counts
only fwp_gc_alloc entries; it does not count every managed allocation. The
published comparison is valid only for that entry-point subset. Correct the
instrumentation and rerun equivalent State/AD/list reports on runners before
using those counters for phase2 acceptance. Do not claim total allocation parity
from the earlier reports. No timing or tracing-free claim is established.

Corrected State allocation driver771c2b83b9a5db0142df759006b960704606a86a
on ownership-evidence-typed-state-allocations-complete is published; three-platform
measurements are pending. It counts initializer fast paths and counts their
slow-path delegation once. Receipt: /private/tmp/fwp-typed-state-allocation-complete-publication.json. AD/list counter repairs still need equivalent reruns.

Fourteen serializer/codec leaf contracts remain source-reviewed unpublished
drafts: /private/tmp/fwp-serializer-leaf-ownership-patch.json and
/private/tmp/fwp-serializer-leaf-preparation.json. Bundle validated contracts,
classification and the measurement repair in the next coherent delivery.

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
and [primitive contracts](primitive-ownership.md) against merged source. The current153-contract inventory leaves191 declarations/181 symbols for
classification. Preserve conservative fallbacks until typed ownership and
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

## Local checks and recovery

Full builds/tests, benchmarks and large regeneration run on GitHub. Local
workloads are serial, low priority and guarded: sampled aggregate RSS below1GiB,
target below2GiB, at least64GiB free disk, deadline180 seconds. Stop at limits;
never raise or bypass them. Use `python3 scripts/local-guard.py COMMAND...` for
fwp checks. The fun-refactor guard applies to that other repository.
Latest disk observation:44,108,824KiB available, about42.1GiB; local target
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
