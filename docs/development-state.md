# Session handoff

Updated 2026-10-08 07:28 UTC. Read [PLAN](../PLAN.md), [ownership](ownership.md)
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

Current main: `90affeb3954a8d5da9f4f66a2cbcdc235f57a6f7`, squash #86, merged
2026-10-08T07:24:02Z. ALL SIX jobs passed in CI `37733658893` at exact
`cf8ce6e61295170fb455957fe83218c30e9cd8b4`. Verified one-line subject
`Own zip callback results and preserve typed input aliases`, empty body.
Root fast-forward preserved five current docs in `/private/tmp/fwp-main-docs-pre86`.
The guard and compact docs are tracked. Previous #85 squash `d4e5261`
passed ALL SIX CI `37728301773` at exact `a090f1f`.

#74–#86 deliver native macOS ARM/Intel, container ownership contracts, owned
text/byte leaves and fresh text trees, compiled closures and cleanup, concrete
argument temporaries, owned stack children, borrowed callbacks, map, filter, fold and zip ownership.
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

Next sole PR is right-fold, branch `ownership-right-fold`, checkout
`/private/tmp/fwp-right-fold-worktree`, OLD head `adc7947a25f297d5de53d587a4bcdeb11d29fdb7`.
Rebase from immutable OLD zip `bdb750f6d46b69153fb9f577a5fa4cbe12b7e523`
onto actual #86 squash `90affeb3954a8d5da9f4f66a2cbcdc235f57a6f7`.
Never use rewritten zip `cf8ce6e` as the OLD anchor. Resolve historical docs with
current root docs, verify explicit no-opt oracles and focused checks, then publish
with an exact lease and open the sole PR. Keep later preparations separate.

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

Queue 70 is published (no extra PR). #86 passed ALL SIX and merged; right-fold is now
the next sequential task. Full separate evidence now passes all six gates.

After finishing the file I/O error preparation, repair affine File discard on `ownership-file-discard`, checkout
`/private/tmp/fwp-file-discard-worktree`, parent OLD `e9d575f`, with bounded file
descriptor pressure and compare raw interpreter/native before changing lifetimes. Current affine File discard reproducer is `tests/file_discard_ownership.rs` in
that checkout, untracked and intentionally failing until repaired; no commit or
second PR. It lowers ONLY each interpreted/native child descriptor limit to 32
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
The tight 4-descriptor parameter-lifetime counterexample also passes current
raw interpreter/O1/O2 native: reopening after ignore still fails until the original
File parameter frame exits (CPU 7.89 s / 15.97 s). A blind last-use destructor
would incorrectly make it succeed. Any fix must preserve this trap behavior.
Resource lifetime anchors must survive function inlining and loop lowering;
optional count/reuse/free flags must not disable required resource disposal.
Current compiler target is the separate file-write visibility checkout below.

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
Publish separately without another PR, then rebase dirty File-discard from
5ac7103 onto that published head. Allocation fault probes prove recoverable-trap
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
shared compiler target belongs to `/private/tmp/fwp-file-io-errors-worktree`; use
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
adjustments. Queue verification passes all 64 immutable OLD parent/head relationships
through File construction; verify the next published pair after publication. All local links in nine current/archived docs resolve.
The root README/design/ownership docs now distinguish delivered #74–#84 work
from preparation, removing obsolete first-task/CI-pending claims.
The guard and compact documents landed with #85. Include current updates in
the next sequential PR, reconcile
future snapshots against them, and update current state rather than appending
another competing priority queue. No roadmap work is blocked by test failures.
