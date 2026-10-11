# Session handoff

Updated 2026-10-11. Read [PLAN](../PLAN.md), [ownership](ownership.md) and
[design](design.md) before changing code. This is the sole live handoff. The
[queue](roadmap-queue.md) preserves immutable anchors; [history](roadmap-history.md)
contains detailed checks and superseded instructions. Root docs are authoritative;
prepared branch docs are historical snapshots.

Durable recovery: current tip of `roadmap/handoff-pr123-20261011`. The latest
publication receipt is /private/tmp/fwp-pr123-acceptance-checkpoint.json. It retains
all11 authoritative docs and the recovery/inventory/compiler/cache/autodiff
repair drafts under `scripts/roadmap-recovery/`. Restore helpers there if
/private/tmp is lost; copy the inventory pair into repo scripts before its
GitHub audit. Publication verifies source blobs, not draft execution or
production acceptance. Inspect the exact current branch-head docs audit on
GitHub; an earlier or cancelled audit does not verify the current snapshot.
Current checkpoint6a2f51c33d5a355291f7e7a3ee258f733928eb68 has
exact-head audit38160936480 queued. Earlier checkpoints and cancelled audits
remain in history. Before publishing the finalization driver, set its recovery
binding to this current checkpoint; its saved draft contains the preceding
checkpoint identity because a commit cannot embed its own hash.

The saved goal controller is active again, verified by get_goal on this resumed
turn. Keep the full objective active: phases2–6 remain unfinished. Queued CI and
failing tests remain work to monitor and fix, not roadmap stop conditions.

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
checkout update or full check ran. Actual-main documentation status must still be
collected; do not infer it from the PR gate.

Queue33 and35–73 are accepted; queue34 is a verified duplicate. PR123 accepts
all42 original library/OpenCL/TLS/file/resource commits and both pointer and
raw-memory repairs. Raw pointer offsets wrap at the native pointer width;
ordinary arithmetic remains checked. Nine raw-memory primitive contracts
borrow their arguments; ptr.read-string returns a counted independent managed
copy. C buffers still require mem.free. Fake OpenCL coverage does not prove
GPU hardware support, and F16/128-bit/WASI pointer widths remain unverified.

Next delivery: related resource/network items74–112 plus the compiler/cache,
autodiff, list and State repairs below. Preparation38140923130 passed at
driver82c7bc7509c04b9e94004c06b02d83d665539ac6; its85-commit history is published
at066b497040ff7b7f59fec6ff3337c63428f83d77. Once the remaining focused gates
pass, finalize on this actual squash with all11 fresh docs, preserve original
tests/subjects and mandatory WASI, then publish the sole next production PR.
Require six
exact-head production jobs and roadmap_docs, then complete the finite phase2
exit review. Phases2–6 remain incomplete.

Actual-main docs38161107226 is queued. Duplicate full CI38161107239 was cancelled
while all six jobs were queued, after proving complete-tree identity with the
accepted pre-merge head and all seven passing gates before squash. This is
duplicate-run avoidance, not a passing main gate or a replacement for the next
PR's exact-head matrix. Proof: /private/tmp/fwp-main123-duplicate-ci-proof.json.

## Evidence and preservation requirements

Completed independent evidence is archived in
[history](roadmap-history.md#archived-completed-evidence-before-pr122-acceptance).
Original tests ran once per architecture, with zero ignored; controls,
C/binaries/flags/disassembly and proof JSON remain retained. These runs do not
replace the final production gates or establish speed/collector-free support.

Completed layout, pointer, prepared112 integration and inventory evidence is in
[history](roadmap-history.md#completed-evidence-removed-from-the-live-pr123-handoff).
It does not substitute for current-head gates. The frozen primitive baseline
remains669c19e7cb67 / CI38099556010, with its proof and JSON retained locally.

Preserve inherited worker, HTTP2/x86 root and static-handler fixture repairs,
exact omission/allocation controls, raw interpreter comparisons and original
multi-commit repairs. Rows77–78 require actual mandatory WASI on Linux in both
free modes. OpenCL57–58 fake APIs do not establish hardware coverage. Recheck
the finite primitive inventory against actual merged source at phase2 exit.

## Remaining ownership deliveries

Original focused checks are preserved in
[history](roadmap-history.md#prepared-ownership-checks-retained-during-handoff-streamlining).
Use actual bases below, never immutable OLD parents. Preserve all11 root docs
when resolving conflicts. Remove a live row only after verified acceptance or
a verified duplicate, retaining its queue anchor and history. All listed
preparations need final squash rebases and all seven exact-head production gates.

| Row / branch | Current head | Actual current base | Delivery status |
|---|---|---|---|
| 74 ownership-file-runtime-owners | 8d5cb3c4e3e4 | 3dba256655a3 | 39-item runner rebase and full gates pending |
| 75 ownership-file-discard | 423a7ddcc760 | 8d5cb3c4e3e4 | 39-item runner rebase and full gates pending |
| 76 ownership-file-runtime-boundaries | 603bb0b914db | 423a7ddcc760 | 39-item runner rebase and full gates pending |
| 77 ownership-wasm-resource-counts | f4a26004d5a8 | 603bb0b914db | 39-item runner rebase and full gates pending |
| 78 ownership-wasm-count-disposal | 13c77dbb7b82 | f4a26004d5a8 | 39-item runner rebase and full gates pending |
| 79 ownership-resource-frame-fields | 2f842d5d266f | 13c77dbb7b82 | 39-item runner rebase and full gates pending |
| 80 ownership-file-inline-path | 010e622f064e | 2f842d5d266f | 39-item runner rebase and full gates pending |
| 81 ownership-file-storage-disposal | 6e5063786651 | 010e622f064e | 39-item runner rebase and full gates pending |
| 82 ownership-file-construction-disposal | ecfd9a28c39e | 6e5063786651 | 39-item runner rebase and full gates pending |
| 83 ownership-resource-frame-variants | 7b7e45b20230 | ecfd9a28c39e | 39-item runner rebase and full gates pending |
| 84 ownership-resource-frame-binding-kinds | e2a2baa977fa | 7b7e45b20230 | 39-item runner rebase and full gates pending |
| 85 ownership-match-scrutinee-types | ebe69e13a935 | e2a2baa977fa | 39-item runner rebase and full gates pending |
| 86 ownership-resource-record-binding-kinds | a0de231a4c0c | ebe69e13a935 | 39-item runner rebase and full gates pending |
| 87 ownership-nominal-source-context | 5a4ef15301c8 | a0de231a4c0c | 39-item runner rebase and full gates pending |
| 88 ownership-channel-cycle-lifetimes | 3db25573057b | 5a4ef15301c8 | 39-item runner rebase and full gates pending |
| 89 ownership-http2-body-roots | 5bc4f862bd5a | 3db25573057b | 39-item runner rebase and full gates pending |
| 90 fix-http2-body-bounds | fabe0ac7b24a | 5bc4f862bd5a | 39-item runner rebase and full gates pending |
| 91 ownership-http2-peer-cleanup | 5029a447bcec | fabe0ac7b24a | 39-item runner rebase and full gates pending |
| 92 ownership-grpc-peer-completion | 26545f1b279b | 5029a447bcec | 39-item runner rebase and full gates pending |
| 93 ownership-grpc-status-cleanup | 9ad102d5a16f | 26545f1b279b | 39-item runner rebase and full gates pending |
| 94 ownership-grpc-receive-cleanup | ec0fd11c6b26 | 9ad102d5a16f | 39-item runner rebase and full gates pending |
| 95 ownership-grpc-force-cleanup | 91ab62452636 | ec0fd11c6b26 | 39-item runner rebase and full gates pending |
| 96 ownership-grpc-render-cleanup | b4087dc07beb | 91ab62452636 | 39-item runner rebase and full gates pending |
| 97 ownership-grpc-send-cleanup | 0203804096d8 | b4087dc07beb | 39-item runner rebase and full gates pending |
| 98 ownership-grpc-request-encoding | 9c2c91fa8e21 | 0203804096d8 | 39-item runner rebase and full gates pending |
| 99 ownership-grpc-canonical-encoding | 58bf72dbf3df | 9c2c91fa8e21 | 39-item runner rebase and full gates pending |
| 100 ownership-grpc-response-encoding | 3b13964722ba | 58bf72dbf3df | 39-item runner rebase and full gates pending |
| 101 ownership-grpc-client-requests | a584b59ec896 | 3b13964722ba | 39-item runner rebase and full gates pending |
| 102 ownership-grpc-client-failure-text | 4e6dbbddf888 | a584b59ec896 | 39-item runner rebase and full gates pending |
| 103 ownership-grpc-client-receive | 09b5e3e70117 | 4e6dbbddf888 | 39-item runner rebase and full gates pending |
| 104 ownership-grpc-connect-cleanup | 518e5cfaca02 | 09b5e3e70117 | 39-item runner rebase and full gates pending |
| 105 ownership-grpc-connect-startup | 4802e1dfb8a5 | 518e5cfaca02 | 39-item runner rebase and full gates pending |
| 106 ownership-grpc-context-restore | 2308b7c1db43 | 4802e1dfb8a5 | 39-item runner rebase and full gates pending |
| 107 ownership-grpc-context-resources | a2b3b132f094 | 2308b7c1db43 | 39-item runner rebase and full gates pending |
| 108 ownership-grpc-capture-resources | ef437370ca74 | a2b3b132f094 | 39-item runner rebase and full gates pending |
| 109 fix-grpc-tls-pool-identity | c9d841ee5a9d | ef437370ca74 | 39-item runner rebase and full gates pending |
| 110 ownership-grpc-environment-cache | bf297ac299ea | c9d841ee5a9d | 39-item runner rebase and full gates pending |
| 111 ownership-grpc-packed-options | 5a01572cb2c6 | bf297ac299ea | 39-item runner rebase and full gates pending |
| 112 ownership-grpc-connection-addresses | b45e93a71d40 | 5a01572cb2c6 | 39-item runner rebase and full gates pending |

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

## Autodiff tape bug fixes prepared for the next bundle

Independent branch ownership-evidence-autodiff-tapes is at
602e076604d3dd759c47b396c10cf848dd9dbb61; evidence38139112950 passed on
Linux, ARM macOS and Intel macOS. The source repairs out-of-bounds parent/output
indices in both backends, register all five detached native buffers for normal
and exceptional release, and retire exhausted generation slots instead of
wrapping them. Backward still consumes the selected tape before validation;
push failure leaves it live. Mixed-tape and outside-lifetime trap precedence,
zipped-output behavior, negative constants and arithmetic order are preserved.
Zero-input backward remains valid. Slots stop at generation32767 and 65535
slots; exhaustion traps instead of recycling old identities.

One interpreter unit regression checks bounds, gradients, consumption, mixed
precedence, empty/unpaired outputs and an injected terminal-generation boundary.
Native O1/O2 probes require a real GC and exercise return, mixed/invalid traps,
injected result-allocation failure and actual task cancellation. Four omitted
controls must fail specifically: registration/release41, wrapping46 and bounds31.
Public Pipe cases compare raw FWP_NO_OPT=1 with optimized native builds. Artifacts
retain source, binaries, output/statuses, compiler/hardware and formatted drafts.
All three focused tape jobs passed; final bundle gates and merged acceptance
remain required. The separate scope candidate below supplies callback failure
and cancellation controls; its replacement checks remain pending.

Recipes /private/tmp/fwp-ad-ownership-patch.json reproduce both native files
from immutable b0ae without replacing later device changes. Other drafts:
fwp-ad-ownership-test.rs, fwp-ad-unwind-probe.c and fwp-ad-ownership-evidence.yml.
Original evidence89447/38138590114 failed workflow validation before any jobs:
runner.temp was used in job env. Corrected6f781/38138762594 was cancelled while
still queued before strengthening real-collection and omission controls.
Current finalization draft requires all three current AD jobs as well as
PR123/preparation/GC gates, adds the exact AD transforms and tests, and formats
the final candidate on GitHub before its own full exact-head CI. It stages new
test files before comparing the repair-file whitelist. Rebase retains the
accepted docs/stdlib.md fix while preserving the preparation's b0ae anchor.
The draft adds a cheap standard-library documentation preflight before Cargo
gates in all six jobs, using the actual generator test; original full gates
and mandatory WASI remain unchanged. Runner validation is pending.

Disk is below64GiB; the current observation is recorded in Local checks below.
No local build, test,
format or rebase is authorized while the reserve is unavailable; only source
editing and lightweight remote administration ran here.

## Scoped gradient ownership candidate

Branch ownership-evidence-autodiff-scopes at
fbc7e38087b3708c60d21302e29b9013c7d6fa2c builds on602e0766's bounds, cleanup
and retirement fixes. Replacement38159488927 is queued for Linux and both macOS
architectures. The internal ad.scope primitive wraps value-and-grad and vjp;
grad, grad-vector and reverse Jacobians use those paths. Public signatures,
curried/data-last semantics and original numerical bodies stay unchanged.
Native owners are stack cleanup records with stable slot links; backward
unlinks consumed tapes. Task-local cleanup chains carry scope membership
through existing switches. Interpreter RAII tracks only active scoped tokens,
removing each on backward, including exceptional consumption.

AD tape/push borrow inputs and return scalar tokens; backward borrows all three
inputs and returns a counted fresh F64 array. The scoped callback borrows its
function and transfers its typed owned result. New source recipes cover six
files in /private/tmp/fwp-ad-scope-patch.json. Regression drafts are
fwp-ad-scope-test.rs and fwp-ad-scope-probe.c. Tests cover callback return/error,
actual task cancellation before backward, nested scopes, registry relocation,
multiple live tapes and consumed unlinking. O1/O2 under actual collection and
reuse verification require omitted linking61, unlinking62 and result counting76
to fail specifically. Native output records tape alignment/size and stack
context sizes; no measured layout or performance claim is made before runs.
Raw interpreter/native cases include the original reverse-AD golden program
and gradient/vjp callback errors. Compiler argument vectors and artifacts are
retained. Scoped evidence runs all library units and both AD integration targets;
its FWP_BLESS regeneration and subsequent exact doc comparison verify the
standard-library reference on GitHub. Previous475cb242/run38141558055 failed all
three jobs: its negative Pipe fixture used undeclared `panic`. Library/lint/doc,
inherited tape tests and the native scope/omission controls passed before that
fixture failed. The corrected fixture uses declared `prim.trap`; raw/native
oracles now require exit101 and the actual runtime trap line, rejecting compiler
errors that merely quote the fixture's message. It retains every semantic case,
source/binary/status artifacts and both reuse modes. Native scope source is
unchanged, verified by Git blob identity in
/private/tmp/fwp-ad-scope-trap-publication.json. Failed log:
/private/tmp/fwp-ad-scope-475-failed.log. All three replacement scope jobs passed
in38159488927. Final bundle validation and merged acceptance remain required.
Before accepting the scope, measure equivalent
steady-state gradient allocation counts/bytes against602e0766 at O1/O2 on the
runners. A stack owner does not establish that its curried callback/return
bridges avoid extra managed boxes. Preserve public signatures and fix any
allocation regression before final bundle acceptance. Do not claim zero-cost
scopes or no-extra-allocation from the owner layout alone.

Allocation comparison driver9ae50851389fbfa7c5c155fca477a4b958589c99,
branch ownership-evidence-autodiff-allocations, runs38159536008 (queued).
It preserves an explicit exported entry and compares runtime-dependent
quadratic gradients on baseline602e0766 and
scope candidatefbc7e380 at O1/O2 across Linux and both macOS architectures.
The 4096-call steady-state probe requires real managed allocations and five
external tape-buffer allocation calls per gradient. It records cold/warm
requested bytes, external live/peak bytes, collected live/peak bytes, collections,
tape size/alignment, compiler arguments, hardware and source/binary hashes.
Acceptance requires no additional steady-state managed calls/bytes and identical
external calls/bytes, with external live bytes equal to the persistent registry
slot size after all tape buffers are released. ARM and Intel comparisons passed;
Linux remains queued. No speed or no-tracing
claim. Superseded50036dc3/run38144127914 was cancelled while entirely queued.
The intermediatea2513d60/run38144375898 was also cancelled while entirely
queued before fixing entry retention and checking external buffer reclamation.
The olde586/38145198463 was cancelled entirely queued before binding the repaired
scope candidate; no measurement was discarded. Current receipt:
/private/tmp/fwp-ad-allocation-trap-publication.json. Recovery must retain
measure-ad-scope-allocations.py, ad-scope-allocation.yml and this receipt.

The finalizer now requires all three allocation jobs and verifies downloaded
comparison metrics, exact baseline/candidate/driver identities and source/binary
hashes before integrating scoped gradients. Source review also fixed its attempt
to copy scoped tests from the earlier tape-only commit and overwrite later
interp/ownership/autodiff source wholesale; it now copies only the two tape
fixtures there and applies scoped source transformations to the later bundle.
These runner draft repairs have not executed and need their actual runner gate.

Older scopea369/38140572629 andd262/38141448694 were cancelled while queued
before adding counted-array controls and correcting the array destructor
observation. Current finalization draft requires all three exact scope jobs,
then applies both AD recipes without overwriting later native source, preserves
all original tests and formats the final candidate on GitHub. Source inventory
now intentionally includes the new scope and three AD refinements, but actual
counts and phase2 exit remain unverified until merged-source runner evidence.

## List ownership and State root cleanup candidate

Branch ownership-evidence-list-applicative at
4f21a9ea99c1a06a3f1ba67818936194fe43e42a runs38160607296, queued on
Linux and both macOS architectures. Its exact baseline is PR123 head9e7d0b24.
The recipe adds borrowed list.ap inputs, counted output spines
and owned callback results. Two borrowed scratch arrays and the completed result
prefix have separate unwind owners; partial list construction transfers each
result exactly once. Callback order remains function-major/input-minor.
The Cartesian-product size is checked before allocating its output scratch.

The list regression tests cover real collection, GC/reuse verification, raw/native
alias and trap-order agreement, empty inputs/functions, shared function
captures, callback failure, actual task cancellation, partial-spine allocation
failure and size boundaries without dereferencing fabricated storage. Three
omission controls require exact native exits: missing result-prefix owner81,
missing counted spine86 and missing product-size guard88. The probe explicitly
requires real FWP_UNWIND=1 from a task-yield fixture. It retains source, binaries,
statuses, compiler arguments, hardware and source/binary hashes.
The combined replacement ARM job passed all five tests and its allocation
comparison. Linux and Intel remain queued; these are candidate contracts,
with final bundle acceptance and tracing-free support unproved. Superseded runs
are recorded in history.

The combined candidate also owns list.flat-map callback chunks before copying
any output spine, preserving callback-before-copy evaluation order. Copied
aliases acquire typed element references; the output stays protected while the
original chunks are destroyed. Runtime owners use stack storage and existing
scanned scratch. Scalar copies have no element retain function. These changes
are source preparations, with no measured allocation/performance claim yet.

Additional raw/native cases cover fresh and repeated String aliases, captured
functions, scalar and empty chunks, and callback trap order. Native GC/reuse
probes add callback failure, task cancellation, partial-spine construction and
immediate chunk drop controls. Omitted chunk-prefix ownership must exit99;
omitted copied-element retain must exit100 before reading freed storage.
No original applicative control was removed. The finite inventory draft permits exactly
these two collection contracts, with actual derived counts still pending.

The same focused jobs now include runner-only equivalent allocation evidence.
/private/tmp/fwp-measure-list-callback-allocations.py compares the exact current
candidate with PR123 head9e7d0b24 at O1/O2. An explicitly exported scalar entry
keeps the optimized runtime-dependent pipeline reachable: show/repeat chunks,
flat-map, applicative alias/fresh results, length and sum. All2048 calls must
produce the independently computed numeric result. Raw interpreters must agree.
It records warmup and steady-state managed allocator calls/requested bytes,
counted increments/decrements, explicit sharing calls/count clears, counted-storage
freed bytes, collection-sampled live/peak bytes, process peak RSS, value layout,
compiler arguments/hardware and source/binary hashes. The finalizer verifies all
three downloaded reports. Acceptance requires no increase in managed calls/bytes,
fewer shared count clears and more counted-storage reclamation on this workload.
No timing, total external-allocation or tracing-free claim; measurements pending.
Build targets stay outside uploaded artifacts, on GitHub runners only.
Original controls remain intact.

Boy scout source review found a recoverable closure-destructor bug: a capture
trap or spill-buffer OOM leaves the per-thread work context pointing into the
discarded C frame. The repair registers a stack cleanup that clears the context
and frees its spill buffer on normal return and recovered trap. It preserves
PR123's context getter/setter and native-library pthread-key unload behavior.
Its runtime/fwp_rt_gc.c transform preserves the tested baseline; copying local
main's older whole file would lose those library changes and is prohibited.
A third regression test forces normal queue spilling, a capture-destructor trap
and failure of the second actual spill allocation, then checks a subsequent
drop. A no-op unwind registration must exit94 before dereferencing dead storage.
O1/O2 and both reuse settings retain C, binaries and statuses and require actual
collection. Current ARM controls passed; Linux/Intel and final bundle gates
remain pending. Failed destruction is not
retried; pending unreachable values retain the tracing fallback, so this is no
claim of complete deterministic cleanup after arbitrary destructor failure.
Receipt: /private/tmp/fwp-closure-drop-list-publication.json. Publication verifies
the exact-base function transform and source bytes; runner checks remain pending.

Source review also found inactive State pointers in the GC-scanned backing
buffer after normal pop, depth restoration and task exit. The candidate clears
those words while preserving active prefixes, returned/error aliases and
suspended task states. This uses existing storage, with no new allocation or
ownership contract. Typed State ownership and trace-free eligibility remain
separate phase2 work.
Two additional tests cover pop and grown-buffer restoration, actual collector
scans, run-state return/error, gRPC served-call trap/error recovery, and normal
and cancelled C callbacks on the real scheduler. Three omitted stores require
exact native exits104/105/112 before reading discarded values. Raw/native Pipe
controls cover retained aliases, nested states, inner/outer errors and task
cancellation. O1/O2 with both reuse settings require GC stress/verification and
retain source, binaries and statuses. Current ARM controls passed; the other
platforms and final bundle remain pending.
Receipt: /private/tmp/fwp-state-slot-list-publication.json. The seven-source
recipe is reproduced from PR123's exact baseline; bounded replacement counts
also preserve prepared112's additional File handler. Finalization includes the
new state_slot_probe.c and all three State runtime sources, rather than replacing
whole earlier files. The previous88b5 evidence run was cancelled entirely queued.
The final list fixtures use declared `prim.trap`, with exact raw/native trap
exit101 and runtime diagnostics. The undeclared-name correction changed only
tests, with all seven native source blobs and the recipe identical; receipt:
/private/tmp/fwp-list-ap-trap-publication.json. The collector hook also now
bounds its inspection by the actual scanned allocation during buffer growth,
when the published capacity already describes the next allocation. That probe
correction changes no runtime code; receipt:
/private/tmp/fwp-state-probe-range-publication.json. Both preceding list runs
were cancelled entirely queued, preserving every original control.
ARM job114529582483 at e03/run38159610009 then passed the State collector/handler
and real task controls, closure recovery and raw/native list semantics, but the
combined ownership probe returned99: its tracker inspected only three scratch
entries, while flat-map allocates four. A second fixture composed child before
task.spawn, passing a String where a thunk was required. The repair tracks the
latest unfreed allocation instance, handles reused addresses, detects repeated
or unregistered frees before freeing, and explicitly uses task.spawn child.
It changes only the two fixtures; all native source and recipe blobs remain
identical. Current receipt: /private/tmp/fwp-list-probe-fixes-publication.json;
failed log: /private/tmp/fwp-list-e03-arm-failed.log. The old run was cancelled
only after verifying that its remaining two jobs were queued and none running.
Those partial passes do not verify the replacement head or its allocation gate.

Drafts: /private/tmp/fwp-list-ap-ownership-patch.json, fwp-list-ap-test.rs,
fwp-list-ap-probe.c, fwp-closure-drop-probe.c, fwp-state-slot-probe.c,
fwp-list-ap-evidence.yml and fwp-state-slot-list-publication.json.
After all three focused jobs pass, the finalizer applies the exact tested recipe
to the later resource bundle, preserving its source instead of copying older
whole files. Full final-head production gates remain mandatory. The finite exit
inventory draft permits these two additional explicit contracts and hashes the
actual list runtime; its derived counts still have not been verified.

The finalizer now carries the finite inventory into the candidate and its regular
Linux/ARM/Intel production jobs. It adds scripts/check-primitive-inventory.py,
scripts/primitive-inventory.rs and the unchanged frozen baseline JSON. Baseline
SHA256 is fa71949b3e93e8696b7c8bc7c35b729641c3ef156896803b679b05ccb4b62e0e;
the finalizer verifies its passing669c19e inventory job and original source hashes.
The candidate audit permits only the recorded raw-memory, AD and list contract
changes; all other declaration rows must match the frozen review. It checks the
declared candidate Git head, hashes compiler/runtime/library sources and retains
compile/declaration statuses plus observed rows before contract assertions.
CI uploads these reports before the full tests, including on audit failure.
All four CI templates explicitly check out the PR head (or push SHA); all six
job names, original commands and required WASI remain intact. Candidate
finalization also executes the audit before export, after committing the final
source/docs. These are unexecuted integration drafts, not a passed inventory or
phase2 exit. Derived counts and retained/exceptional/cycle policies still need
actual evidence on the accepted source before proceeding to phase3.

## Local resource incident and next preparation

Local compiled checks and rebases remain stopped below the64GiB reserve;
Target data is approximately101MiB; current free disk is recorded below.
Source editing and lightweight remote administration continue. Earlier refusals,
recoveries and measurements are archived; no limit was raised or bypassed.

Current preparation driver82c7bc7509c04b9e94004c06b02d83d665539ac6,
branch ownership-roadmap-preparation, passed38140923130. It preserves
all39 rows74–112 and85 original commits from source112b45e93a71d40/from73
3dba256655a3 onto immutable candidateb0ae. Required native repairs, accepted
golden diagnostics and mandatory WASI remain unchanged. Final rebase onto the
actual accepted123 squash must retain its docs/stdlib.md repair.

The preceding38130008122 rebase/docs checks succeeded, but publication failed:
runner App tokens cannot update workflows. The corrected driver exports
preparation.json, rebase.log and prepared-commits.json.gz with read-only
permissions. /private/tmp/fwp-export-prepared-commits.py exports every linear
snapshot, original metadata and changed blobs; limits are32MiB decoded/5MiB
compressed,2MiB per blob. /private/tmp/fwp-publish-exported-history.py verifies
an exact successful runner head, blob hashes, all snapshot trees, messages,
parents and author/committer instants, then publishes via the user's existing
authorized connection. Publication uses atomic branch creation or GitHub's
beforeOid lease for final rebase, with a resumable artifact publication.json.
The exporter passed the exact preparation job. The first publisher attempt
verified all117 blobs, then GitHub rejected a retained empty commit's empty tree
update with HTTP422. The corrected publisher reuses the parent's verified tree
for empty deltas and preserves their original commit metadata/subject. It is
resuming from the journal, without discarding original commits or repeating blob
creation. Publication now passed: ownership-resource-network-bundle is at
066b497040ff7b7f59fec6ff3337c63428f83d77 with runner tree
915ac11b269e90d0f9bc567b7f6e50a711061abd. All85 original commits, their parent
sequence, metadata instants and single-line subjects are verified; source trees
match the exported snapshots. The receipt is artifact publication.json, with
export hash116ed0418eeb082ecb44b946f24849b97ed17506fce2f3de9b35a55a288a02b1.
No production PR or finalization has run. Finalizer preparation binding now uses
this verified published head. GitHub confirmed RefUpdate beforeOid from its live schema.
No local build, rebase or broad credential grant is required.

The bounded artifact is /private/tmp/fwp-resource-network-verified-export;
the resumable publication command is:

```sh
nice -n 15 python3 /private/tmp/fwp-publish-exported-history.py \
  --artifact /private/tmp/fwp-resource-network-verified-export \
  --run 38140923130 --driver 82c7bc7509c04b9e94004c06b02d83d665539ac6
```

Finalization also exports instead of pushing with a
runner App; set FWP_PREPARATION_HEAD to the verified published SHA and provide
the current recovery/evidence bindings before publishing its driver. Include
scripts/export_prepared_commits.py beside the finalizer on that driver. After
its successful exact head, publish its artifact with --expected-old matching
finalization.json previous. Keep one production PR and require its full matrix.

The phase2 exit inventory draft is /private/tmp/fwp-check-primitive-inventory-exit.py
with /private/tmp/fwp-primitive-inventory-exit.rs. It compares every parsed
declaration and actual Rust contract with the frozen669c19e baseline, allowing
only nine raw-memory contracts, three refined AD contracts, list.ap, list.flat-map and the
one internal ad.scope declaration/owned callback contract; every other row stays
identical. It checks actual borrowed AD inputs and fresh counted F64 gradient
arrays, and hashes both runtime/interpreter tape implementations. It has not executed or established new counts. Copy it into an
evidence branch on actual merged112-equivalent source and run on GitHub after
the resource/network bundle is accepted; retain the old JSON as baseline.

New GC harness source-review finding: tests/gc.rs returns None for every native
build failure, so a failed valid O2 compilation can silently leave stress
coverage. Draft /private/tmp/fwp-gc-strict-build-draft.rs instead compares build
errors with expected snapshots, records real exit/signal/core status and keeps
failed binaries/C/reports outside the temporary directory. A real failing-CC
control checks propagation and retained C/status. This draft has not compiled
or executed; run focused checks on GitHub and include it in the next bundle,
preserving every original regression. /private/tmp/fwp-gc-diagnostics-ci-draft.yml
adds failure artifacts to both macOS GC jobs. Apply only its added GC steps to
the future workflow; copying the whole draft would lose mandatory WASI.
PR123's accepted native source remains unchanged by this later harness repair,
which still requires its focused and final production gates.
Published independent validation branch: ownership-evidence-gc-build-diagnostics,
head6f2ff860197831b990c2c918e25aa29871488ea3 on PR123 native source.
Replacement38161909445 is queued. Previous38136959809 at a44c3da failed formatting
before lint or native regression execution. Its 95KiB artifact is retained at
/private/tmp/fwp-gc-build-diagnostics-a44-artifacts. The repair copies all six
runner-formatted Rust files and updates the compiler replay recipe to reproduce
those exact bytes from b0ae. Publication/source parity is verified. That
a27/run38151169253 passed formatting, lint and the GC failing-CC control, then
both compiler diagnostics tests failed parsing the foreign fixture's invalid
`-7:I32` literal. The repair uses `-7`; its c-abs signature infers I32, as in the
existing FFI suite. Only that fixture changed; compiler/cache/runtime source
and every positive, signal and omission control remain intact. Failed log:
/private/tmp/fwp-gc-a27-failed.log; current receipt:
/private/tmp/fwp-foreign-compiler-fixture-publication.json. Replacement positive
and omission gates remain pending. Earlier formatting receipt:
/private/tmp/fwp-formatted-compiler-diagnostics-publication.json. No local compiler
workload ran; free disk remains below the required64GiB reserve.
Superseded38132388036 and38135741797 were confirmed
cancelled while unstarted before adding the compiler and cache repairs.
The replacement runs formatting, focused lint, a real failing-CC
control and a positive native GC
execution, then requires exact Rust test exit101 and the specific diagnostic
when compiler failure reporting is deliberately silenced. Artifacts include
generated C, the positive binary, real statuses, hardware/compiler and hashes.
Evidence is pending, with no production PR or extra full matrix. Copy only the
tested gc.rs and added GC failure steps into the next bundle; keep the evidence
workflow outside production ancestry and preserve mandatory actual WASI.
Compiler source review also found that native and interpreter FFI builds discard
compiler stdout and termination details. Published repairs share diagnostic
rendering, preserve stdout/stderr and exit/signal/core status, and detect OpenSSL
errors in stdout as well as stderr. Two new compiler_diagnostics tests cover
stdout-only and mixed errors, status37, signal15, TLS hints and successful
native/raw-interpreter execution. A deliberately discarded stdout control must
fail with exact Rust exit101 and its specific diagnostic. These tests have not
run yet. Journals: /private/tmp/fwp-combined-compiler-diagnostics-publication.json
and /private/tmp/fwp-cache-compiler-diagnostics-publication.json.
The AOT cache source also allowed pruning to delete the executable returned for
execution: zero limits removed all entries, and a future-dated older entry could
make the just-built file sort first. The candidate reserves one entry for the
current executable, prunes only older entries and applies reduced limits on cache
hits. Two cache_lifetime tests cover zero/one limits, future timestamps, native
execution against a raw interpreter and limit reduction on a hit. An omitted
current-file protection control must fail with exact Rust exit101 and its
specific eviction diagnostic. No cache tests have run yet.
After focused evidence passes, apply the exact compiler-diagnostics-patch.json
transforms to the final resource bundle; do not copy older whole cgen/ffi files
over its85 prepared commits. The recipe now includes src/aot.rs; include both
tests/compiler_diagnostics.rs and tests/cache_lifetime.rs. The finalizer verifies
that each recipe reproduces the exact tested/formatted evidence source before
applying it to the later bundle. Formatting repairs must update the recipes too.
For the original85-commit preparation, preserve accepted base CI plus the
intentional mandatory WASI requirement. After the GC repair is verified and
integrated, additionally allow its explicit GC failure-artifact steps. Preserve
all six job names, full test commands and inherited golden diagnostics; do not
resolve either change by replacing the entire workflow with an older snapshot.

Runner finalization draft: /private/tmp/fwp-finalize-resource-network-on-runner.py
and its matching .yml. Publish its separate driver only after PR123 merges,
the85-commit preparation passes and the focused GC repair passes. It requires
all seven original PR123 gates completed before squash, validates the raw
one-line message/parent/tree, restores all11 authoritative recovery docs and
records acceptance in a runner worktree. It then rebases the verified preparation
onto the actual squash, preserves its complete tree and original subjects,
and adds the tested GC harness/artifact steps, compiler/cache transforms and
tests, plus fresh accepted docs. Its candidate reference documents the minimum
one-entry cache and current-executable protection only alongside that repair.
An exact old-head push lease protects concurrent edits. This is an unexecuted
draft, with final documentation audit and all production gates still required.
Its workflow bindings must follow any repaired evidence heads. Local main
requires a separate guarded protection/update when the disk reserve permits.

## Local checks and durable recovery

Full builds/tests, benchmarks and large regeneration run on GitHub. Local work
is serial, low priority and guarded: sampled aggregate RSS below1GiB, target
below2GiB, at least64GiB free disk, deadline180 seconds. Stop at limits and move
work to CI; never raise or bypass limits. The fun-refactor guard applies only to
that other repository.

Latest disk observation: df reports38,958,772KiB available, about37.2GiB.
No local compiled check, full documentation audit or rebase ran on this turn.
Source edits and publication ran serially; GitHub runner validation remains
required. State publication command:
`nice -n 15 python3 /private/tmp/fwp-publish-state-slot-list-evidence.py`.
It verifies baseline recipe counts, staged/source hashes and the current branch
parent before publication; receipt records head0d1c44fe. It is source verification,
not a compiler or runtime result. Do not rerun completed publication helpers.

Temporary files disappeared during continuation. Fifty-two recovery helpers
were restored from checkpoint1992c95d after verifying every Git blob hash;
/private/tmp/fwp-recovery-restoration.json records source identities. Root docs
were preserved. Do not execute restored old publication helpers: receipts and
current GitHub branch heads remain authoritative. The finalizer/monitor bindings
were updated to current replacement gates after restoration. Restoring source
does not establish runtime support or restore old passing artifact evidence.

```sh
env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo test --test RELEVANT_TEST
python3 scripts/local-guard.py python3 scripts/check-roadmap.py
```

Last Rust checkout: /private/tmp/fwp-library-resource-bundle-worktree.
Focused pointer/raw-memory/resource checks,65 units, lint and formatting passed
on ed442426ff6e0ce4e646913720c95c098596da02 before the preserved final rebase.
The source/check journal is /private/tmp/fwp-library-raw-memory-focused-checks.json;
these earlier checks do not replace the current full PR gates.

Before switching Rust checkouts, use the absolute root guard
with cargo clean -p fwp in that last checkout, then rebuild requested targets.
Do not infer source identity from shared outputs. Refusals and prior metrics
remain in history; each new guard invocation samples current resources.

Protect all11 docs with a fresh hashed snapshot before each main fast-forward:
CONTRIBUTING.md, PLAN.md, docs/design.md, docs/development-state.md, docs/ownership.md,
docs/primitive-ownership.md, docs/roadmap-queue.md, docs/roadmap-history.md,
docs/reference.md, docs/concurrency.md and docs/numerics.md. Preserve other tracked
user changes too. Latest snapshot: /private/tmp/fwp-main-docs-pre123, restored
byte-for-byte. Actual bases, immutable preparation tags and retained revision
tags are the recovery record if temporary helpers disappear. The shared audit
checks all tracked links, whole commit messages, immutable ancestry and live
head/base consistency. Audit again after links, refs or subjects change.
