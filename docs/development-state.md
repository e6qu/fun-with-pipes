# Session handoff

Updated 2026-10-08 10:34 UTC. Read [PLAN](../PLAN.md), [ownership](ownership.md)
and the relevant [design](design.md) before code changes. This file is current
operational state. [Preparation queue](roadmap-queue.md) records immutable rebase
anchors; [history](roadmap-history.md) preserves detailed earlier evidence.
Prepared branch docs are historical snapshots; current root docs are authoritative.

## Authorization and invariants

Complete the active roadmap automatically, one focused PR at a time. Failing
tests are tasks to fix, never roadmap blockers. Queued CI gates merging only;
continue diagnosis, repairs and separate next-task preparation. No repeat approval
is needed for authorized branches, publication, PRs, fixes or squash merges.

Preserve tacit, curried, data-last pipes, immutable values, tracked effects,
checked arithmetic and observable evaluation/trap order. Ordinary types infer
strongly; generic signatures remain explicit and compile-time specialized.
Compare native and interpreter behavior; optimizer references use `FWP_NO_OPT=1`.
Do not claim ARC-only, tracing-free execution, performance or platform support
from an implementation, skipped test or partial gate.

Every commit message is exactly one line, at most 80 characters, with no body,
trailers, AI attribution, Co-authored-by or Authored-by. Use normal Git metadata.
Squash with an explicitly supplied subject and empty body, matching the current
PR head. Require ALL SIX successful exact-head CI jobs:

- `test` (Linux, including full suite/tooling and WebAssembly checks)
- `bench`
- `macos (macos-15)` and `macos (macos-15-intel)`
- `macos_gc (macos-15)` and `macos_gc (macos-15-intel)`

Regular macOS excludes only `golden_programs_under_gc_stress`; dedicated jobs
execute precisely that full stress test. Their union preserves full coverage.
Queued, skipped, cancelled, superseded or earlier-head runs are not passing gates.

## Merged support

Current main: `dbdaee4448d4ccd62720f04d3f866d429db800aa`, squash #89,
merged 2026-10-08 10:33:05 UTC. ALL SIX CI 37758597151 jobs passed at exact
`bcdfb163c565b6275be4c36389e7c226882fb319`. Whole commit message verified:
`Own typed list copies and retain borrowed suffix references`, one line, empty body.
Root fast-forward preserved all six live docs in /private/tmp/fwp-main-docs-pre89.
Previous #88 squash 49f9108 passed ALL SIX CI 37750832622.

#74–#89 deliver native macOS ARM/Intel, container ownership contracts, owned
text/byte leaves and fresh text trees, compiled closures and cleanup, concrete
argument temporaries, owned stack children, borrowed callbacks, map, filter, fold, zip, right-fold, list-prefix and list-copy ownership.
Full earlier hashes/runs, measurements and delivered language features remain in
[history](roadmap-history.md). Phase 1 is complete; phase 2 is incomplete;
phases 3–6 (numeric representation, numerics/autodiff, broader evidence and
optional tracing-free execution) have not met acceptance. Windows/new deployment
interfaces/new backend remain deferred.

## Next sequential PR

Zip #86 has merged after all six exact-head gates passed. Seven zip/fold/filter/
borrowed-callback checks pass CPU 20.63 s / elapsed 41.50 s; clippy lib/four tests
CPU 2.18 s / 4.42 s, inventory CPU 3.07 s / 6.46 s, fmt CPU 0.35 s / 0.63 s.
Both zip references explicitly use FWP_NO_OPT=1. Equivalent shared/owned control
verifies more than 0.8 MiB additional reclamation, identical outputs and no
collections; no speed claim. All 64 immutable queue pairs through construction
and all links in nine docs verify; verify new publication pairs too.

Right-fold #87 merged after ALL SIX exact-head CI gates passed. Seven focused
checks passed CPU 19.42 s / elapsed 39.03 s; clippy lib/four tests 2.39 s / 4.77 s;
format 0.35 s / 0.75 s; inventory one real lib test 3.28 s / 6.79 s.
Both oracles explicitly use FWP_NO_OPT=1. Equivalent owned/shared controls
verify identical output, no collections and >0.3 MiB extra reclamation;
no speed claim. OLD preparation anchor remains `adc7947a25f297d5de53d587a4bcdeb11d29fdb7`.

Prefix #88 has merged after all six exact-head gates passed. Seven focused
checks passed CPU 21.41 s / elapsed 42.98 s; clippy lib/four fixtures 2.32 s /
4.76 s, real inventory one test 3.30 s / 6.88 s, format 0.32 s / 0.61 s.
Both oracles use FWP_NO_OPT=1. OLD prefix remains 376e77ae9469.
Next: list-copy, actual branch `ownership-list-copies`, checkout
`/private/tmp/fwp-list-copy-worktree`, OLD head `bb00baa4ab9577ed785e5cb2f3280c9d6697dde6`.
Rebased from immutable OLD prefix `376e77ae94690057ededafd3468e72075cd4bb1c`
onto actual #88 squash 49f9108. Both interpreter oracles explicitly use
FWP_NO_OPT=1. Seven list-copy/prefix/right-fold/borrowed-callback tests passed
CPU 21.03 s / elapsed 42.42 s. Clippy lib/four fixtures passed 2.20 s / 4.44 s;
real inventory one lib test passed 3.02 s / 6.43 s. Formatting initially failed
on the corrected oracle expressions; formatted and rechecked successfully,
CPU 0.36 s / 0.51 s. Commands use the documented fwp local guard.
List-copy #89 has merged after all six current-head gates passed. Its immutable
OLD anchor remains bb00baa4ab9577ed785e5cb2f3280c9d6697dde6.
Next: list-option, branch ownership-list-options, checkout
/private/tmp/fwp-list-option-worktree, OLD head 34023f35a42f9f686b6919307d83e17fd4ed7263.
Rebase from immutable OLD list-copy bb00baa4 onto actual #89 squash dbdaee4,
replace stale docs with current root copies, correct raw interpreter oracles,
then run focused checks and publish the sole next PR. No PR currently open.

In parallel preparation, `/private/tmp/fwp-file-runtime-owners-worktree`, branch
`ownership-file-runtime-owners`, is published clean as `e21c92ea2f6c7bdfcf881d05e485f57683df0b85` atop resource-frame preparation
`368dafc5567dab757e779017784ce347c908593c`. File header counts are independent
of GC metadata; owned borrowed-I/O wrappers and String unwind cleanup are implemented. Nine focused runtime/File construction/I/O/visibility/frame checks pass CPU
23.50 s / elapsed 47.19 s. The runtime probe has three omission controls for
returned-alias retention, extra-reference unwind and fresh-String unwind; O1/O2
with GC stress/verification and both poison modes pass. Explicit close and
library finalization do not double-close. Final runtime matrix additionally passes with FWP_GC=off, CPU 1.21 s /
elapsed 3.65 s. Clippy lib/five fixtures passes 2.45 s / 5.08 s; fmt
0.45 s / 0.84 s. No native frame integration or header/path storage
reclamation claim. No extra PR was opened. The subsequent native frame preparation is recorded below.

Fold local evidence: five fold/filter/borrowed checks CPU 15.84 s / 31.87 s;
clippy lib/three tests CPU 2.20 s / 4.51 s; inventory CPU 3.08 s / 6.51 s;
fmt CPU 0.35 s / 0.75 s. Both corrected no-opt oracles pass. No speed claim.
The published preparation `a180c3f` was rebased with an exact lease, and the
whole commit body/subject and CI head were verified before/after squash.

Filter validation: five filter/map/borrowed-callback checks CPU 15.72 s / elapsed
31.81 s; warning/inventory/fmt checks pass. Both corrected explicit-no-opt
oracles pass CPU 4.85 s / elapsed 9.87 s. Equivalent shared/owned generated
controls free 4.6/5.0 MiB respectively (0.1 MiB precision), with identical output
and zero collections; no elapsed-time speed claim. Initial nonexistent test target
ran zero tests and was corrected; it is not acceptance evidence.

## Separate repaired preparation evidence

Checkout `/private/tmp/fwp-tls-evidence-worktree`, branch
`ownership-evidence-tls-listeners`, clean published exact head
`9bcae30119028b1870efb8fecfcf9746f5808acb`. Repaired full CI `37730777345`
completed successfully: ALL SIX jobs passed at that exact head. Early Linux
probes pass under both GCC and Clang, and both regular macOS jobs pass the
delayed-timer regression. This confirms the repairs on this separate evidence
branch; every sequential PR still needs its own six exact-head gates. Prior
full CI `37725214652` at `283a0cf` completed with failures: Linux and Intel regular
FAIL; ARM regular, bench and both ARM/Intel GC PASS. Failure logs are
`/private/tmp/fwp-evidence-37725214652-failures.log`; the concrete failures are repaired below. Unchanged full wide allocation acceptance and raw
unoptimized TLS streams with GC/reuse verification PASS on Linux AND both macOS
architectures. The prior failures were repaired and the new full run passes; the prior run is not an acceptance gate. This evidence is not a PR,
never replaces sequential exact-head gates, and its workflow never enters
production ancestry.

Old CI `37719202504` is terminal cancelled after actual ARM regular/GC failures
were diagnosed and concrete repairs verified. It establishes no passing gate.
Prepared original ancestry lacked root fixes already merged on main:
fwp_data/fwp_str_new/fwp_list_items/flat-map/right-fold keep-alives, read-only AOT
cache access and tutorial wc spacing. These are restored solely in evidence as
`8e5fb6a99c74aace434fbaec0faf442dfcaca2dc`. Focused actual roots regression passes
CPU 14.31 s / elapsed 28.86 s. Real wide-record regression (366.2 MiB) came from
boxing a recursive six-field worker result only to unpack it for another worker;
ABI-aware local eligibility is repaired without raising inline budgets or the
existing <1 MiB allocation threshold. Evidence includes only that compiler/test
repair from the published production preparation. All full gates remain required.

Earlier evidence `37718591863` passed explicit `FWP_NO_OPT=1` TLS stream comparison
on all three platforms. The portable alert snapshot accepts only one vendor alias
after raw engine equality. The large local TLS stream check exceeded 1 GiB and
was stopped; it moved to GitHub rather than increasing limits.

Completed failing-job logs while a run is live can be obtained with
`gh api --allow-escape-sequences repos/e6qu/fun-with-pipes/actions/jobs/ID/logs`
redirected to a temporary file, then searched with rg. Whole-run log commands may
refuse until all jobs finish. Earlier logs:
`/private/tmp/fwp-tls-current-arm-113122693830.log` and
`/private/tmp/fwp-tls-current-arm-gc-113122693964.log`.

## Latest preparation and outstanding audits

All published preparations and immutable parents are indexed in
[the queue](roadmap-queue.md), with focused evidence in history. They cover list/
container callbacks, count/effect inference, state transfer, old reclamation,
task boundaries, runtime/compiler unwind, aggregate/type/CAF ownership, retained
task/channel/library owners, OpenCL and TLS/resource teardown. They require
rebasing and full sequential CI; no second PR is open.

Latest published preparations:

- TCP/TLS cancellation: `0cc612650ab9ee8cd2fb8cb6560e3cadcb9c0392`, parent OLD
  `f6598e4`. Four actual scheduler cancellation cases plus successful/refused
  connection checks and omission controls pass; clippy CPU 2.33 s / 4.60 s.
- Record worker locals: `b8f3752d236f217385923a06dacd1afcdaf716ca`, parent OLD
  `0cc6126`. Complete compatible calls and typed count aliases stay unboxed;
  partial/dynamic uses remain boxed. Six worker/alias/boxing/preparation checks
  pass CPU 16.30 s / 32.81 s, O1/O2 with GC/reuse verification. Shortened original
  source matches explicit no-opt interpreter; exact typed children, scalar
  pointer-shaped words, aliases, traps and partial captures are checked. Clippy
  and fmt pass. Full original allocation acceptance now passes on CI above.
- TLS peer subject: `6bda2c815a7107c059370d83f1f090b50996d152`, parent OLD
  `b8f3752`. Checked malloc avoids a null memcpy; a stack node owns its copied
  buffer through String conversion/traps. Real OpenSSL failure/omission/retry
  checks and actual interpreter TLS socket-pair metadata agree. Three peer/cache/
  connect checks pass CPU 2.40 s / 8.96 s; final oracle test CPU 0.67 s / 2.45 s;
  warning/fmt checks pass. Original allocation crash reproduced before repair.
  Library resource probes use unarmed collection and do not prove host-root
  tracing or general tracing-free coverage. One formatting approval review timed
  out; its permitted single retry succeeded. No approval remains outstanding.

Borrowed TLS ALPN owner fence is now prepared on `ownership-tls-alpn-roots`,
checkout `/private/tmp/fwp-tls-alpn-root-worktree`, immutable parent OLD
`6bda2c815a7107c059370d83f1f090b50996d152`; published as
`e0f11626f60955d080669a4e38e2e81ac06fff9f`, clean checkout. A standalone
fixture explicitly arms a real major trace before String copy and observes
whether the actual TLS session is finalized. Baseline loses that owner (exit 1,
CPU 7.02 s / 14.82 s). The fence fixes it; removing only the fence restores
exit 1. O1/O2 with actual GC stress/verification and both poison modes passes,
with matching interpreter TLS protocol results. Three ALPN/peer-subject/library
resource checks pass CPU 2.79 s / 8.91 s; fmt CPU 0.37 s / 0.74 s. This fixture
proves the boundary when collection is armed; production library tracing stays
unarmed and no host-root tracing claim follows. Warning check passes CPU 2.40 s / 4.77 s. Verified single-line subject and
no body/trailers; full sequential CI remains required.

Nested-loop preparation is in progress on `ownership-nested-loop-boxing`,
checkout `/private/tmp/fwp-nested-loop-boxing-worktree`, published clean as `b00215dc10f561747f2adbfb04e404e81581f598`,
parent OLD CI repair `e503e10a97807a91f0ce1794f5b8b3e7cb955114`. Preserved dirty
work through stash/rebase/pop before completion.
Typed prepared aliases now let rebuilt inner records stay flattened (st[5]
instead of st[3]); Again stops boxing the inner tuple. A real source/C fixture
then exposes a leaked original/partial owner when that inner value is boxed on
Stop and preparation traps (exit 2). Initial fixture compile errors (missing
trap declaration and selecting a vbox rather than vdrop definition) were corrected
before leak evidence. Precise Field ownership checkpoint, progressive retains and
allocation scopes now fix that leak: all alias/scalar/fault cases pass O1/O2 with
stress/verification and both reuse modes (CPU 8.50 s / 17.32 s). The small
generated-code inspection passes CPU 0.35 s / 0.74 s. Three omission controls
now detect missing original, partial and pending boxed-field scopes (exit 2).
Six loop/preparation/worker checks pass CPU 11.78 s / elapsed 24.05 s;
17 compiler ownership analysis tests pass CPU 3.32 s / 6.84 s. Clippy lib/four
tests passes CPU 2.35 s / 4.77 s; format CPU 0.34 s / 0.62 s. The first adjacent
run crashed because its old cancellation probe treated the now-flattened String
fields as a boxed pair; the updated typed-field probe passes with unchanged
release/alias/scalar assertions. An initial mistyped target ran no checks and
was corrected. Queue 69 is published with a 65-character single-line subject and empty body;
sequential full CI still required. Audit resource construction/discard and retained
cycles next while full CI continues.
Small emitted-code checks only; no full allocation workload ran locally.

CI repair is prepared separately in `/private/tmp/fwp-ci-probe-repairs-worktree`,
branch `ownership-ci-probe-repairs`, parent OLD `e0f1162`, published clean as
`e503e10a97807a91f0ce1794f5b8b3e7cb955114` (no extra PR).
All five Linux failing probes call `fwp_gc_chunk_of` with a null index output;
that helper unconditionally writes the index for managed pointers. Replace the
invalid calls with actual `size_t` output storage; no runtime ownership rule or
assertion is weakened. All five references also now explicitly disable optimizer
for interpreter oracles. Both Intel mismatches are independent 20/40-ms child
prints: relative timers establish no happens-before relationship. The fixtures
now share a channel: the 40-ms child waits until the 20-ms child prints and sends.
Both children still sleep concurrently and the scope still joins both. A focused
regression intentionally delays the shorter timer's start by 100 ms, checking
raw interpreter/native O1/O2 equality across three preemption slices, stress,
verification and both reuse modes. Initial curried composition errors corrected;
small raw oracle prints the unchanged expected order. Ten focused checks pass
under the persistent guard, CPU 27.31 s / elapsed 54.75 s; clippy lib/six tests
passes CPU 2.38 s / 4.92 s; format CPU 0.43 s / 0.87 s.
Linux early runner confirmation now PASS for all ten tests under BOTH GCC and
Clang in CI `37730777345`; Intel delayed-timer regression also PASS; all six full evidence gates now PASS at exact `9bcae301`.

File construction is prepared on `ownership-file-construction`, checkout
`/private/tmp/fwp-file-construction-worktree`, parent OLD `b00215d`, published clean as
`e9d575fdf990d28ae899c7562b369fe6b4f4401d`. The original direct open/create boundary loses its fopen stream
when handle/path construction traps: baseline probe exit 2 (CPU 6.78 s / 13.95 s).
The constructor now owns the raw stream before allocating, transfers cleanup to
the initialized handle, roots the borrowed path, then relinquishes the scope only
on successful construction. file.with starts its callback scope after construction,
preventing duplicate stream ownership on a construction trap. Handle/path/finalizer
registration/callback fault probes verify exactly one close, EBADF, cleared failed
handles and safe loaded-region teardown. Removing the constructor scope or managed
handle transfer restores failures (exit 2/3). Armed fixture stress/verification and
both poison modes pass O1/O2. Five constructor/unwind/library tests pass CPU 4.48 s /
10.58 s; initial expanded source oracle incorrectly duplicated affine File via tap,
was corrected to second file.close, then matches explicit-no-opt interpreter.
This preserves the language's resource Dup/capture restrictions. Native allocator
OOM still exits the process (102); injected recoverable trap checks establish
cleanup behavior, not a new recoverable OOM interface. Production library tracing
stays unarmed. Format passes CPU 0.37 s / 0.75 s; clippy lib/three tests passes CPU 2.37 s /
4.77 s.

Queue 70 is published (no extra PR). #87 passed ALL SIX and merged; prefix #88
is the sole sequential PR. Full separate evidence passes all six gates.

Following the separate runtime-count foundation, connect native typed File ownership on `ownership-file-discard`, checkout
`/private/tmp/fwp-file-discard-worktree`, current parent `e21c92e`, with bounded file
descriptor pressure and compare raw interpreter/native before changing lifetimes. The initial affine File discard reproducer was `tests/file_discard_ownership.rs`
in that checkout, originally untracked and failing; native preparation below repairs it. It lowers ONLY each interpreted/native child descriptor limit to 32
through setrlimit/pre_exec (never the session/compiler/test process), then opens
and ignores 64 Files in loop steps. Explicit-no-opt interpreter prints discarded;
O1 native with FWP_GC=off traps with Too many open files (CPU 7.34 s / 14.87 s).
The native File type has neither typed discard nor executable finalizer; its
finalizer exists only for library teardown. This is an actual semantic/resource
repair task. Avoid a blind File addition to rc::needs_rc: effectful early close
can differ from interpreter frame lifetimes; FWP_REUSE=0/FWP_FREE=0 must not
change language behavior. Interp::eval Local clones values; Let retains its local
until the function frame ends. File lifetime/discard therefore needs either precise
frame ownership/transfer or an explicit consistent internal ownership policy,
with raw interpreter evaluation/flush/close order tests. Surface File remains
affine and partial resource capture forbidden. No implementation is accepted yet.
The tight 4-descriptor parameter-lifetime counterexample passes raw AND optimized
interpreter plus O1/O2 native after both I/O repairs: reopening after ignore still
fails until the original File parameter frame exits (CPU 9.02 s / 18.20 s). A blind last-use destructor
would incorrectly make it succeed. Any fix must preserve this trap behavior.
Resource lifetime anchors must survive function inlining and loop lowering;
optional count/reuse/free flags must not disable required resource disposal.
The File-discard 32-descriptor native failure reproduced again after both I/O
repairs (CPU 0.88 s / elapsed 2.03 s). That failure was the native frame repair target; the follow-up below now passes. A separate four-descriptor helper test exposes an optimized
interpreter bug: two inlined helpers incorrectly retain the first helper's File
into the second call, whereas raw execution closes its frame (baseline CPU
1.02 s / elapsed 2.24 s). Original frame metadata fixes this below.

Resource-frame preparation is on `ownership-resource-frames`, checkout
`/private/tmp/fwp-resource-frames-worktree`, parent OLD `06419f4`. The original
File-containing parameters/bindings are recorded as typed ResourceRegion nodes
before optimization. Optimizer protects their binders while still optimizing the
body; inlining binds resource parameters to fresh locals and substitution retains
those anchors. Type checking rejects missing, repeated and scalar owner slots.
Recursive nominal/resource aggregate classification excludes nonowning arrows.
Interpreter clears only the region's slots on return/error; returned aliases and
handled Error[File] payloads remain owners. IR walkers, specialization/fusion and
loop-state rewriting preserve the markers. Native tail-call jumps cannot erase
an original resource frame. The C backend otherwise currently evaluates each
region body without emitting resource destruction; this is NOT accepted File ARC
or native discard coverage.

The three resource-frame checks cover the reproduced helper mismatch, original
parameter trap lifetime, returned File/record aliases and handled File error
payloads. The last two compare raw/optimized interpreter and native O1/O2; result/
error checks run armed GC stress/verification with both reuse modes. Ten file I/O,
visibility, frame and unwind checks pass CPU 25.48 s / elapsed 52.96 s. Two
resource classification/type-metadata unit checks pass CPU 3.60 s / 7.54 s;
clippy lib/four tests CPU 2.49 s / 5.03 s; final lib/frame warning check CPU
2.37 s / 4.77 s; fmt CPU 0.45 s / 0.86 s. Initial test fixture used invalid
match syntax; corrected to tacit holes before error-alias evidence. A nonexistent
opt::tests filter ran zero tests and is not acceptance evidence. All compiler
edits were copied/byte-verified into the separate frame checkout before restoring
the discard checkout's tracked files; its untracked audit remained preserved.

Published original `dcc5bbac318f567bf952bb72ab280d3ab75bca11` with verified
one-line subject and empty body, no extra PR. Dirty File-discard was preserved
through stash/rebase/pop from 06419f4 onto dcc5bba; its untracked four-test audit
remains, with the native 32-descriptor case still the known failing target.

Follow-up in the frame checkout: pure source arrows can still own File frames,
so fusion must treat ResourceRegion as observable rather than derive only its
body's trap set. A controlled map/length pipeline fuses when the region is removed
and remains unfused with the region, preserving cleanup boundaries. Three
resource unit checks now pass CPU 3.64 s / 7.52 s; repeated three frame checks
CPU 12.80 s / 25.86 s; format CPU 0.46 s / 0.85 s. Published the focused correction as `368dafc5567dab757e779017784ce347c908593c`,
verified single-line subject and empty body; final warning check passes CPU
2.36 s / elapsed 4.65 s. dcc5bba remains immutable OLD. Dirty File-discard was preserved through stash/rebase/pop from dcc5bba onto
that corrected current head. Its four-test untracked audit remained. Before the
native follow-up below, the concrete action was: add typed File retain/drop and
primitive result contracts; retain original parameter/binding owners in stack
region slots and release them on normal/error/trap/cancellation exits. Protect
partial initialization and returned/error aliases. Cover direct handles and
resource aggregates; native count metadata and WASM stub counts differ. Required
disposal must be independent of optional reuse/free controls. A mandatory
ownership path must keep actual physical reuse disabled under FWP_REUSE=0.
Do not expose new resource syntax or accept a last-use close that changes the
four-descriptor original-frame trap. The region direction and required flags/escape/error/cancellation
acceptance are durable in ownership.md. Required disposal must work without GC
and with FWP_REUSE=0/FWP_FREE=0; supported WASM needs a count representation
independent of native GC slots. Preserve the four-descriptor parameter trap while
making the 32-descriptor native discard succeed. General retained resources and
cycle teardown remain phase 2 work. No accepted File ARC implementation yet.

File-write visibility is prepared on `ownership-file-write-visibility`, checkout
`/private/tmp/fwp-file-write-visibility-worktree`, immutable parent `e9d575f`.
Rust writes reach the descriptor immediately; native stdio buffering instead
made a read in the still-live original File frame observe empty data. Baseline
reproduced (CPU 1.02 s / elapsed 2.08 s). Native file.write now checks fflush
before returning, without fsync or a new durability guarantee. Short fwrite and
failed fflush produce the existing write IoError and preserve the borrowed File;
closed handles keep their existing behavior. O1/O2 actual source comparison uses
FWP_NO_OPT=1 and real GC stress/verification with both reuse modes. C probes check
immediate descriptor visibility, error timing, no premature close and exactly one
explicit close; removing only flush is detected (exit 3). Six visibility,
construction and unwind checks pass CPU 12.42 s / elapsed 25.22 s. Clippy lib/three
tests passes CPU 2.36 s / 4.80 s; fmt CPU 0.35 s / 0.62 s. The first sandboxed
format invocation could not sample ps and stopped; the guarded monitored retry
passed without changing limits. Published clean as `5ac710398a14f68453c2cb9f0bf1477ca08d8b81`, single-line
subject and empty body verified, no extra PR. Dirty File-discard audit was
preserved through stash/rebase/pop from e9d575f onto 5ac7103; its two tests remain
untracked. The known discard failure still requires a lifetime-preserving repair.

File I/O errors are prepared on `ownership-file-io-errors`, checkout
`/private/tmp/fwp-file-io-errors-worktree`, parent OLD `5ac7103`. Actual directory
read baseline returns success where raw interpreter reports a read error (CPU
7.41 s / elapsed 15.10 s). Both file.read and file.read-all now check read errors
and strict UTF-8, preserving existing path-bearing/pathless IoError messages.
Temporary read buffers have stack cleanup through conversion/recoverable traps;
file.read owns its stream while file.read-all borrows its handle. Keep the latter
handle reachable through returned tuple allocation. file.write-new checks short
writes and buffered close failures, closes once and preserves the original write
errno even if close overwrites it. Fault probes and omission controls independently
catch lost buffer cleanup, lost stream cleanup and ignored write errors. O1/O2
with actual armed GC stress/verification and both reuse modes pass. Eight read,
visibility, construction and unwind tests pass CPU 11.73 s / elapsed 24.14 s;
clippy lib/four tests CPU 2.27 s / 4.55 s, format CPU 0.44 s / 0.89 s.
Published clean as `06419f4c59893e6b48c476c552bffee7c8f46b82` with a verified
one-line subject and empty body, no extra PR. Dirty File-discard was preserved through stash/rebase/pop from
5ac7103 onto that published head; only its untracked two-test reproducer remains. Allocation fault probes prove recoverable-trap
cleanup, not a new recoverable OOM interface. General File discard is still open.

General File/socket resource discard, retained
callback teardown and cycle lifetime policy follow. Implicit effectful resource release
must preserve observable lifetime/evaluation order; it is distinct from harmless
memory reclamation and needs a language/interpreter contract before widening it.
Keep
phase 2 incomplete until acceptance is proved. Do not start a new deployment
interface or backend, or claim speed without equivalent workload evidence.

## Local operation and durable documentation

Root main has ONLY our pending five live doc changes; preserve
those on fast-forward. Prepared published production checkouts are clean. Current
shared compiler target belongs to `/private/tmp/fwp-resource-frames-worktree`; use
guarded `cargo clean -p fwp` before switching compiler checkouts. Never run local
workloads concurrently.

Persistent equivalent guard: [scripts/local-guard.py](../scripts/local-guard.py).
Use from any prepared checkout:

```
env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo test --test RELEVANT_TEST
```

It fixes the shared target, serializes workloads, lowers priority, samples/throttles
CPU toward half one core, and stops at sampled 1 GiB aggregate RSS, target 2 GiB,
free disk below 64 GiB or 180 seconds. It has no limit-raising switches. Full
builds/tests/benchmarks/regeneration run on GitHub. Never use the user's
fun-refactor guard against fwp. Prior checks used the equivalent temporary guard
`/private/tmp/fwp-local-guard.py`; persistent guard syntax and real child success/
exit-7 forwarding checks pass (CPU 0.01 s / 0.27 s and 0.00 s / 0.14 s).
A real persistent-guard cargo fmt check passes CPU 0.34 s / 0.63 s.
All local links in the live/archived documents resolve.

The live plan/handoff now contain current priorities rather than repeated old
"next" actions. Historical notes are preserved verbatim except relative link
adjustments. Queue verification passes all 67 immutable OLD parent/head relationships
through resource frames; all links in nine docs resolve. All local links in nine current/archived docs resolve.
The root README/design/ownership docs now distinguish delivered #74–#84 work
from preparation, removing obsolete first-task/CI-pending claims.
The guard and compact documents landed with #85. Include current updates in
the next sequential PR, reconcile
future snapshots against them, and update current state rather than appending
another competing priority queue. No roadmap work is blocked by test failures.


File runtime-count preparation: `ownership-file-runtime-owners`, checkout
`/private/tmp/fwp-file-runtime-owners-worktree`, parent `368dafc5567dab757e779017784ce347c908593c`
(the corrected current resource-frame head, not OLD dcc5bba). Three omission
controls fail independently: no returned-alias retain exits 6, no extra-owner
unwind exits 7, no String unwind exits 10. Correct code passes O1/O2, GC stress/
verification and disabled tracing, both reuse poison modes; no-free mode preserves
stream semantics while leaving String storage to tracing. File header retains
300 aliases even with its GC slot cleared; last owner closes once. Recoverable
read/write/conversion/tuple failures preserve the borrowed original owner;
checked UINT64_MAX overflow does not touch the stream or leak cleanup entries.
Header/path storage remains allocator-managed; finalizers need the header until
library finish. This is runtime foundation only: native typed File Dup/Drop,
resource-result dispatch and region scopes are next. Published clean as queue 74 at `e21c92ea2f6c7bdfcf881d05e485f57683df0b85`,
verified one-line subject `Count File aliases independently of tracing metadata`
and empty body; no extra PR. Rebased the preserved four-case dirty File-discard
audit from 368dafc onto that publication; only the audit is untracked. Keep the original 4-descriptor parameter failure
while repairing the 64-open/discard native failure. Local checks used:
`env FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3 /Users/zardoz/projects/fun-with-pipes/scripts/local-guard.py cargo test --test file_runtime_ownership --test file_io_errors --test file_construction_ownership --test file_write_visibility --test resource_frames`;
all nine passed, CPU 23.50 s / elapsed 47.19 s. Final runtime-only matrix,
fmt and clippy lib/five fixtures commands used the same guard and passed above.


Pre-native handoff verification: nine current/archive doc link sets, all 68 immutable
queue ancestry pairs and whole-message checks for #87 squash, prefix publication
and File runtime foundation pass (guarded python check, CPU 0.05 s / 0.48 s).
At that earlier snapshot #88 gates were pending; all six have since passed and #88 merged.
No local workload is running. Shared target was cleaned with the guard before
switching to `/private/tmp/fwp-file-discard-worktree`, now at e21c92e with only
its then-four-case untracked audit. The next compiler step at that point was: rc::free_in must count original
ResourceRegion parameters as free uses (but not uninitialized local bindings),
so early drops stay inside the original frame; Checker must record entry owners
before region retention can allocate. Then connect typed File retain/drop and
owned I/O result dispatch and emit protected, initialized native region slots.
Validate parameter trap order and returned/error aliases alongside repairing the
native discard failure; mandatory disposal must survive optional reuse/free flags.
Prefix CI failures, if any, are repair tasks, never roadmap blockers.


Native File frame preparation is now implemented on `ownership-file-discard`,
checkout `/private/tmp/fwp-file-discard-worktree`, parent e21c92e (queue 74).
The formerly failing 64-open/discard loop succeeds at O1/O2 with a child descriptor
limit of 32 and GC off; all reuse/free combinations, real stress/verification and
both poison modes pass. Omitting only the normal frame release restores the
original EMFILE failure. Original parameter/record slots have separate frame
references, zero initialization and registered cleanup through partial retention.
Incoming parameter owners remain live before frame setup; dead drops occur inside
regions. Native scalar/record/variant result paths release the region after result
ownership transfers. Original bindings currently use boxed slots; optimizing these
holders into typed fields remains necessary for allocation efficiency.

File enters the mandatory ownership pass even under FWP_REUSE=0. Physical reuse
stays disabled by runtime uniqueness guards and no reuse tokens. File-bearing
aggregate drops still traverse resource children under FWP_FREE=0. Typed callback,
worker, loop, task/channel and container boundaries select File header retains.
Borrowed File I/O calls select the already-owned runtime wrappers. Explicit close
is unchanged. The original four-descriptor parameter EMFILE behavior passes;
inlined helpers now also close before the next helper in native mode, including
reuse/free disabled. Returned File/record aliases pass. Handled Error[File] first
exposed an early close (`internal: duplicate discarded file`); typed fail payload
retention and an owned synchronous attempt wrapper repaired it. Both Result
branches protect payload ownership through result allocation.

Earlier sixteen focused File/runtime/frame/effect checks passed CPU 30.13 s /
60.58 s. After trimming duplicate audit cases, eight final File/frame/effect
checks (including the frame-release omission control) pass CPU 24.89 s / 49.84 s.
Nineteen RC invariants pass 3.64 s / 7.54 s; actual primitive inventory one test
passes 0.00 s / 0.13 s; clippy lib/four fixtures 2.35 s / 4.77 s; fmt 0.45 s /
0.87 s. Final thirteen typed File/frame/effect/task/channel/map/set checks pass CPU
34.92 s / elapsed 70.20 s. Final format passes 0.34 s / 0.63 s; final
compiler/six-fixture warning check passes 2.26 s / 4.68 s. Published queue 75 as `923ad4a4fb07a5f6e2211c16c219308b5bddcf56`, clean
with verified one-line subject `Release native File owners at original resource frame boundaries`
and empty body; no second PR. All local checks used the same serial, low-priority fwp guard. The standalone discard audit now contains
only its new descriptor-pressure/flags/omission check; its other three cases are
maintained in tests/resource_frames.rs, with native helper coverage added.

This is preparation, not merged File ARC acceptance. Header/path storage retains
its allocator lifetime; File-bearing WebAssembly aggregates still need logical
ownership despite stub native count slots. Unknown/shared runtime graphs,
resource-bearing callback teardown, error/cancellation scopes and original
aggregate-holder allocation need further audit. Do not claim optional tracing-free
execution. Continue phase 2 repairs while sequential CI runs; the native preparation is published without an extra PR. Next sequential PR after
prefix remains list-copy from immutable OLD prefix 376e77ae9469.


Earlier native-frame preparation was published clean at 923ad4a.
Next concrete audit: File-bearing runtime results/borrowed containers and
WebAssembly aggregate ownership (the latter cannot rely on native RC slots),
then remove unnecessary boxes from original aggregate frame holders and complete
header/path storage lifetime. Preserve the exact native/interpreter cleanup/trap
order; keep phase 2 incomplete. Prefix #88 subsequently passed all six exact-head gates and merged. Failures remain repair tasks.


File runtime-boundary preparation is published clean as
`30fe112db93c727e565fed0a4c25e4da713a10ad` on `ownership-file-runtime-boundaries`,
checkout `/private/tmp/fwp-file-runtime-boundaries-worktree`, parent OLD/current
`923ad4a4fb07a5f6e2211c16c219308b5bddcf56` (queue 75). Native actual-source
checks cover an independently opened File returned through file.with, cached task
File results and loop Step File results. The final loop callback selection depends
on runtime read-all input and has distinct step branches, preventing constant
callback folding; its final matrix passes CPU 11.56 s / elapsed 23.30 s. Raw interpreter references use
FWP_NO_OPT=1. O1/O2, reuse/free disabled and enabled, tracing off and armed stress/
verification, and both poison modes pass. Initial task fixture had an invalid
no-hole None arm using const; corrected before recording semantic evidence.

file.with now borrows its synchronous callback, receives an owned tuple, retains
its returned typed value, drops the tuple and both File owners, and closes the
scoped stream idempotently. The raw scoped stream remains registered through
errors/traps/cancellation; no new surface resource duplication is permitted.
Omitting only the result retain is detected at O1/O2 (exit 101, duplicate discarded
File). Header/path storage still follows the existing allocator lifetime.

The audit also found FWP_FREE=0 was bypassed by ordinary child drop functions
inside a resource-bearing parent. Such children now have count-only drop bodies;
resource children still close. Task/channel object storage also honors the no-free
macro while releasing their owned resource results/queued values. Exact generated
C accounting verifies fwp_gc.freed == 0.0 for all three sources with tracing off,
at O1/O2, without rounded counters. Restoring ordinary child frees in the scoped
probe fails that accounting check (exit 29). These are flag semantics checks,
not a heap reduction or speed claim.

Eleven focused File/frame/effect/task checks pass CPU 36.83 s / elapsed 73.76 s.
Final boundary matrix with both omission controls and exact no-free accounting
passes 17.60 s / 35.40 s. Format 0.44 s / 0.62 s and clippy lib/five fixtures
2.33 s / 4.77 s pass. The actual inventory check passes one test, CPU 3.48 s / 7.34 s.
Published without a second PR; verified one-line subject
`Own scoped File results and honor disabled freeing`, empty body. Same fixed serial/low-priority fwp guard throughout.
Next: WebAssembly resource-bearing aggregates and runtime owners cannot use their
stub RC operations (fresh/dup/drop/release-last are currently no-ops). Require
actual runner WASI evidence; native GC-off checks are not WASM support. Original
aggregate-holder boxing and File header/path reclamation also remain required.


Earlier boundary preparation used `/private/tmp/fwp-file-runtime-boundaries-worktree`,
clean at 30fe112. Root now has six live doc edits (including
prepared primitive File/effect contracts), all ours; preserve all six on the next
main fast-forward. Next preparation base is actual 30fe112. WebAssembly's bump
allocation remains intentional, but zero RC slots prevent last-owner resource
cleanup in boxed aggregates and runtime cached values. Add a focused reproducer
and logical ownership repair, then require actual runner WASI execution. Do not
substitute native GC-off evidence for that platform check. Task/callback cycle
policy, shared runtime graphs, aggregate frame boxes and header storage remain
active phase 2 work. Prefix #88 subsequently passed all six gates and merged; list-copy follows from immutable OLD prefix 376e77ae9469.


WebAssembly logical-count repair is in progress on `ownership-wasm-resource-counts`,
checkout `/private/tmp/fwp-wasm-resource-counts-worktree`, parent actual 30fe112, published clean as
`c889479eed7aba4967b2e5f87d7a368193b18be9` (queue 77); immutable OLD
046f7e85a9eb remains unchanged after the WASI predicate correction.
Independent logical aggregate/task counts now apply only to File-bearing
programs, without changing value layout, bump storage or physical reuse.
The stable exact-value counter map avoids reading arbitrary scalar/constant words
as headers. 64-bit counts and compact-slot access cover 300 aliases and overflow;
Logical destruction removes entries with normal freeing enabled; disabled-free
metadata lifetime still needs repair below. Metadata storage and lookup work increase;
no zero-cost, heap-reduction or complete tracing-free claim follows.

A generated typed (File, File) destructor is exercised on the actual non-GC C
path at O1/O2: 300 aliases preserve the two stream owners, the last aggregate
drop closes the descriptor, and 128 cycles leave zero counter entries. Removing
only FWP_RESOURCE_OWNERS restores the descriptor leak (exit 4). Pointer-shaped
scalars/constants stay uncounted; UINT64_MAX overflow leaves the count intact.
The first fixture overflow recovery omitted fwp_trap_recover and exited 101;
adding the required test recovery hook fixes the fixture. Runtime code was unchanged.

Guarded `cargo test --test wasm_resource_counts --test file_runtime_boundaries
--test file_discard_ownership` passed the three executed host/native tests,
CPU 24.61 s / elapsed 49.75 s. The fourth test (actual WASI) skipped because the
local toolchain is unavailable; an explicit nocapture rerun confirms the skip,
CPU 0.00 s / 0.13 s. Clippy lib/three fixtures passed 2.27 s / 4.55 s; fmt
passed 0.34 s / 0.63 s. No local workload remains running; shared target belongs
to this checkout. Preparation is published without another PR. Run full
separate evidence with FWP_REQUIRE_WASM_RESOURCE_COUNTS=1 so runner skips fail.

Next: real WASI runner execution, shared graphs/callback teardown and bounded
metadata lifetime with freeing disabled; then remove aggregate frame boxes and
finish File header/path storage lifetime. Keep phase 2 incomplete. One PR #89
remains open; failures are repair tasks and all six current-head gates still gate
its squash. After squash, rebase list-option from immutable OLD bb00baa4.


Separate WASI evidence is published at `01cb806b578ec012da1065bf2887b03b5dbe96b3`,
branch `ownership-evidence-wasm-resources`, checkout
`/private/tmp/fwp-wasm-evidence-worktree`. CI `37759368719` is queued at that exact
head; no result accepted yet. It restores only the already-merged root/cache/
tutorial fixes as 1d42a67, uses the current six-job platform split, and runs the
three focused fixtures early on Linux with FWP_REQUIRE_WASM_RESOURCE_COUNTS=1.
Neither its baseline/workflow commits nor passing evidence replace sequential
PR gates or enter production ancestry. It has no PR.

Next concrete preparation after 046f7e8: reproduce disabled-free metadata growth.
Generated resource-parent destructors use fwp_rc_drop instead of physical free;
that leaves the last count-map entry behind on WASM even after children close.
Separate logical counter disposal from retained object storage for resource
parents and task/channel storage, keep native exact zero-free accounting, and
add the disabled-free omission control before publication. Unknown/shared graph
and closure cycles remain subsequent audits; no general tracing-free claim.


Required WASI evidence 37759368719 failed the real descriptor check; Linux bench
passed, other gates were superseded/cancelled. Diagnostic run 37759763830 proved
File refs had reached zero but fcntl(F_GETFD) still returned 1 with errno 0 under
WASI, whereas EBADF was expected. The predicate now uses actual fstat validity
and still requires EBADF after last-owner drop. Both unchanged omitted-count and
positive assertions remain. Prepared queue 77 was rewritten with exact lease as
c889479; its OLD 046f7e8 remains permanent. Native fstat checks pass at O1/O2.
Repaired evidence CI 37760170473 is live at
`1d6a5d6bedd203c4302599c4e3165412cacd6265`; no passing WASI or full gate claim yet.
Logs: /private/tmp/fwp-wasm-evidence-37759368719-linux.log and
/private/tmp/fwp-wasm-evidence-37759763830-linux.log. Both superseded runs were
cancelled to conserve runner resources, never treated as successful gates.

Disabled-free follow-up is prepared on ownership-wasm-count-disposal, checkout
/private/tmp/fwp-wasm-disposal-worktree. Baseline concrete metadata-growth
reproducer fails exit 5 (CPU 7.53 s / elapsed 15.45 s). Resource-parent and
Task/Channel disposal helpers now remove logical counter metadata on the bump
heap even with FWP_FREE=0; native storage retention stays count-only. Actual
generated File-pair destructor and cached task/channel runtime destructors close
last owners and leave no counter entries. Restoring aggregate count-only teardown
fails exit 5; restoring runtime storage count-only teardown fails exit 9.

Four executed host/native tests pass CPU 27.27 s / elapsed 54.95 s, including
native exact zero-freed-bytes accounting. Actual WASI skips locally (unavailable
toolchain), not support. Final task/channel matrix passes 1.58 s / 3.79 s, final
fstat host matrix 2.29 s / 6.13 s; clippy lib/three fixtures 2.53 s / 5.15 s and
final test refactor 0.06 s / 0.26 s; fmt 0.46 s / 0.87 s. Full runner WASI matrix
now covers both freeing modes, aggregates and cached task/channel owners with
omission controls. Publish this preparation after rebasing onto corrected actual
queue 77 c889479, then add it to the separate full runner evidence. No extra PR.


Required early WASI/host/File stage passed on repaired evidence 37760170473 at
1d6a5d6, including actual WASI O1/O2 omitted-count failure and positive last-owner
closure. This is focused platform evidence, not six full gates. The run was
superseded/cancelled after adding the disabled-free repair; no full-pass claim.

Queue 78 is published clean as `681dd55136b030866c28afb227f222503c21113b`,
parent actual corrected queue 77 `c889479eed7aba4967b2e5f87d7a368193b18be9`.
Rebase completed cleanly; final guarded focused host matrix passes CPU 9.54 s /
elapsed 19.95 s, real WASI explicitly skipped locally. Whole subject is one line,
empty body. Combined runner evidence head is
`e9f31a94e018d399fc4ae5ef583abee7780cfb0c`, CI `37760628633`, queued/live without
accepted results yet. Both freeing modes and actual cached task/channel cleanup
now run under mandatory WASI; fix any failures. Evidence formatting passes
0.47 s / 0.87 s. No additional PR exists.

Current operations: root main remains 49f9108 with only six live doc edits, all
ours; preserve them before the next main fast-forward. Sole PR #89 remains
bcdfb163 at CI 37758597151; all five remaining gates must pass before squash.
Shared compiler target belongs to /private/tmp/fwp-wasm-disposal-worktree; no
local workload is running. Keep every immutable queue anchor, especially OLD
prefix 376e77ae, OLD list-copy bb00baa4 and OLD WASM counts 046f7e8.

Next independent audit: unknown/shared runtime graphs and retained callback
resource aliases, then remove original resource aggregate-holder boxes and
reclaim File header/path storage without leaving stale library finalizers.
Current File last-drop closes only the stream; native library finalizer entries
still retain headers. Do not add immediate storage reclamation until unregister/
finalization and partial-construction unwind are proven safe. After #89 squash,
rebase list-option from OLD bb00baa4 onto the actual new main and publish the
sole next PR. Phase 2 remains incomplete; preserve the subsequent phase order.


Required combined WASI stage passes on evidence e9f31a9 / CI 37760628633:
O1/O2, both freeing modes, File aggregates and cached Task/Channel owners,
positive cleanup and original-count/aggregate-disposal/runtime-disposal omission
controls. The separate full run remains live; only bench full gate passed at the
last check. Sequential production gates remain mandatory for each preparation.

Original record-frame optimization is implemented in ownership-resource-frame-fields,
checkout /private/tmp/fwp-resource-frame-fields-worktree, parent actual 681dd55.
Original frame contexts retain counted fields only when a binding is eligible
for unboxing; ordinary boxed records keep one parent retain. The compiler-only
FWP_FRAME_FIELDS=0 comparison restores boxed holders. No surface syntax changes.
Raw typed IR and equivalent generated C show exactly one record box in the
control versus zero with fields at O1/O2, GC on/off and both poison modes.
The existing source control was already unboxed and could not prove the change;
the fixture was corrected to exercise an actual original record binding. Invalid
initial recursive source duplicated affine File input; the final valid source
uses a sequential read-all pipeline and matches explicit FWP_NO_OPT=1 output.

Six focused frame/holder/runtime/discard tests pass under the guard CPU 37.15 s /
elapsed 74.45 s after narrowing eligibility. A new File/String partial-retain
probe traps before the second field retain, verifies one stream close, EBADF,
empty unwind chain and reclaimed String; omitting owner drops restores exit 2.
The first poison observation incorrectly demanded a zero count; the runtime's
poisoned String payload is the correct dead-state check. Final allocation/source/
IR/unwind matrix passes CPU 3.01 s / elapsed 7.33 s. Clippy lib/four fixtures
passes 2.49 s / 5.03 s; format 0.46 s / 0.87 s; inventory one actual test
3.77 s / 7.96 s. No elapsed-time speed or complete unboxed-aggregate claim.
Publish the focused preparation without another PR; full runner evidence follows.
Original resource variants/nested holders and header/path reclamation remain.

Current main is dbdaee4 with six live doc edits, all ours. No local workload
runs; shared compiler target belongs to /private/tmp/fwp-resource-frame-fields-worktree.
Next sequential publication is list-option, rebased from OLD bb00baa4; preserve
that anchor. Unknown/shared resource graphs, retained callbacks/cycles, original
variant/nested holders and safe File header/path finalizer removal remain phase 2
audits. Failing tests are repair work, never roadmap blockers.
