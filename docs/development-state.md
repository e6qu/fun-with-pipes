# Session handoff

Updated 2026-10-11. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff.
[Queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
preserves accepted and superseded evidence. Root docs are authoritative.

Durable recovery branch: `roadmap/handoff-pr123-20261011`, checkpoint
69fa8ff9c173a78dc8a8d7875e7ae44cc569305a. Its docs audit38162836405 was last
observed queued. It retains all11 docs and recovery recipes/helpers under
scripts/roadmap-recovery/. The running finalizer binds this immutable checkpoint.
Its latest driver receipt is /private/tmp/fwp-resource-finalization-driver-publication.json.
Preserve the next publication receipt and fresh docs in a new checkpoint after
publication; do not rerun completed publishers. Restore source by verified Git
blob hashes with restore-roadmap-recovery.py if temporary files disappear.
Source recovery is not runtime verification. Phases2–6 remain unfinished.

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

Next delivery: resource/network items74–112 plus compiler/cache diagnostics,
autodiff tape/scoped-gradient lifetimes, list callback owners, closure cleanup
and inactive State root clearing. All focused prerequisites pass; finalization
38163941948 passes at driver77f4e22f5d3b280482e65616e5f03abae1ac350e.
It retains all85 original commits, applies verified source transformations on
the actual squash, preserves mandatory WASI and audits the actual inventory.
Integrated history is published at0dac249f2d3767021c46be89de123b78d0970791 with tree
fb87faedfe1a9ec851757085ea2176bf49d187a0. All87 commits and155 source blobs match
runner snapshots. This documentation commit preserves that native source. Next:
open the sole production PR and require all six exact-head jobs plus roadmap_docs.
These integration/focused passes do not replace production gates.

Duplicate main CI38161107239 was cancelled while all six jobs were queued,
after complete-tree identity and all seven passing pre-merge gates were proved.
This is duplicate-run avoidance, not a passing main gate. Proof:
/private/tmp/fwp-main123-duplicate-ci-proof.json.

## Current verified bundle evidence

Integrated inventory at runner head13c92139da8ddc3d7c9755539cd1e95d80a5b2b9
reports374 declarations,364 symbols,40 aliases,149 explicit contracts,19 IR
combinators,11 flat signatures and195 review declarations representing185
symbols. It permits exactly nine raw contracts, three AD refinements, two list
contracts and internal ad.scope. This is source classification, not a count
of ownership bugs or a replacement for runtime/phase2 exit evidence.

| Work | Exact source / driver | Passing run |
|---|---|---|
| 85 original resource commits | preparation driver82c7bc7509c04b9e94004c06b02d83d665539ac6 | 38140923130 |
| Compiler failure and cache lifetime controls | 6f2ff860197831b990c2c918e25aa29871488ea3 | 38161909445 |
| AD bounds, tape cleanup and token retirement | 602e076604d3dd759c47b396c10cf848dd9dbb61 | 38139112950; Linux/ARM/Intel |
| Scoped gradients and owned F64 results | fbc7e38087b3708c60d21302e29b9013c7d6fa2c | 38159488927; Linux/ARM/Intel |
| Equivalent gradient allocation comparison | 9ae50851389fbfa7c5c155fca477a4b958589c99 | 38159536008; Linux/ARM/Intel |
| List/closure/State controls and allocation comparison | 4f21a9ea99c1a06a3f1ba67818936194fe43e42a | 38160607296; Linux/ARM/Intel |
| Integrated export and primitive inventory | 77f4e22f5d3b280482e65616e5f03abae1ac350e | 38163941948 |

The finalizer verifies downloaded allocation reports and their source/binary
hashes. Scoped gradients add no steady-state managed calls/bytes on the tested
4096-call O1/O2 workload and preserve five external buffer calls per gradient.
List ownership adds no managed calls/bytes on the tested2048-call O1/O2 workload,
reduces shared-count clears and increases counted-storage reclamation. These
are workload-specific allocation results, with no timing or tracing-free claim.

All original controls remain: raw FWP_NO_OPT=1/native semantics, real collection,
GC/reuse verification, O1/O2, callback/trap order, allocation failure, task
cancellation and exact omission exits before invalid reads. Native compiler
failures now fail the GC gate; diagnostics include stdout/stderr/status/signals.
Cache pruning protects the returned executable and retains at least one entry.
AD bounds/identity cleanup preserves consumption and failure precedence; slots
retire at generation32767 rather than wrapping. Internal scopes preserve public
Pipe signatures. List.ap/flat-map own callback results and counted spines.
Closure nonlocal cleanup clears discarded work contexts and releases spills.
State pop/restore/task exit clear inactive scanned words without changing active
suspended states or proving typed State ownership. Final production gates remain
required for this combination. Detailed failures and controls are in
[preparation history](roadmap-history.md#resource-bundle-preparation-before-finalization).

The read-only finalizer exports complete snapshots instead of pushing with a
runner App. The publisher verifies blob hashes, all snapshot trees, one-line
subjects, parent chains and original metadata instants. Empty commits reuse
their parent's tree. Publication uses GitHub beforeOid as an exact branch lease.
The verified integrated branch head is0dac249f2d3767021c46be89de123b78d0970791. Its exact-head
production gates remain pending; do not substitute the focused passes. Export metadata is retained in
/private/tmp/fwp-resource-network-finalized-export; binaries stay on GitHub.

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
and [primitive contracts](primitive-ownership.md) against merged source. The
prepared112 audit resolves373 declarations into363 runtime symbols after40
aliases:134 explicit contracts,19 ordinary IR combinators,12 flat scalar
signatures and208 review declarations representing198 symbols. Missing metadata
alone is not a sharing bug. Preserve conservative fallbacks until concrete
typed ownership and teardown are proved.

Review borrowed metadata roots, reconstruction/partial failure, retained
callbacks/contexts and resource disposal. The source-reviewed fallback list also
includes per-task typed State slots and remaining callback/reconstruction paths;
see [primitive contracts](primitive-ownership.md). List reconstruction owners
and inactive State root clearing now have published candidate controls below.
Typed State retention and deterministic teardown remain acceptance work.
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
Latest disk observation:38,958,772KiB available, about37.2GiB. No local compiled
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
