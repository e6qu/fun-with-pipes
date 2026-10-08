# Session handoff

Updated 2026-10-08 04:30 UTC. Read [PLAN](../PLAN.md), [ownership](ownership.md)
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

Current main: `01c6f5807e1462fe97763a125dbfb70acc1fcde7`, squash #84, merged
2026-10-08T04:29:26Z. All six jobs passed in CI `37722779465` at exact
`a5185a9dce590b640ff5513a12665c3a4b9d0b88`. Verified subject (59 characters)
`Own synchronous filter spines and selected input references`, empty body.
Root main fast-forward preserved all ten current docs/tooling files; backup
`/private/tmp/fwp-main-docs-pre84`. Previous #83 squash `0f1ca94` passed all six
CI `37719069685` gates at `0c5bec4` (history records the full earlier hashes).

#74–#84 deliver native macOS ARM/Intel, container ownership contracts, owned
text/byte leaves and fresh text trees, compiled closures and cleanup, concrete
argument temporaries, owned stack children, borrowed callbacks, map and filter ownership.
Full earlier hashes/runs, measurements and delivered language features remain in
[history](roadmap-history.md). Phase 1 is complete; phase 2 is incomplete;
phases 3–6 (numeric representation, numerics/autodiff, broader evidence and
optional tracing-free execution) have not met acceptance. Windows/new deployment
interfaces/new backend remain deferred.

## Next sequential PR

No PR is open after #84 merged. Fold is next: `/private/tmp/fwp-fold-worktree`,
branch `ownership-fold-transfers`, original head
`a180c3fb5f429edc79facd340577c5115f1a78cf`. Rebase from immutable OLD filter
`1ea7f079043c` onto current main `01c6f5807e1462fe97763a125dbfb70acc1fcde7`;
resolve docs with authoritative current root files. Run focused fold/adjacent
checks under the guard, clippy/inventory/fmt; use an explicit unoptimized
interpreter oracle. Include the live docs/history/queue/persistent guard cleanup
in this next PR. Publish with an explicit lease and create the sole next PR.
Require all six successful exact-head gates before its explicit squash. Preserve
OLD `a180c3f` for zip. See queue for all later OLD anchors; never substitute a
rewritten/squashed parent for an original anchor.

Filter validation: five filter/map/borrowed-callback checks CPU 15.72 s / elapsed
31.81 s; warning/inventory/fmt checks pass. Both corrected explicit-no-opt
oracles pass CPU 4.85 s / elapsed 9.87 s. Equivalent shared/owned generated
controls free 4.6/5.0 MiB respectively (0.1 MiB precision), with identical output
and zero collections; no elapsed-time speed claim. Initial nonexistent test target
ran zero tests and was corrected; it is not acceptance evidence.

## Separate repaired preparation evidence

Checkout `/private/tmp/fwp-tls-evidence-worktree`, branch
`ownership-evidence-tls-listeners`, clean published exact head
`283a0cf5170cd683399e6aea1ed51531d1fa91af`. Full CI `37725214652` in progress.
Bench and ARM GC PASS. Unchanged full wide allocation acceptance and raw
unoptimized TLS streams with GC/reuse verification PASS on Linux AND both macOS
architectures. Other full regular/GC jobs still run. This evidence is not a PR,
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
`6bda2c815a7107c059370d83f1f090b50996d152`; not yet committed. A standalone
fixture explicitly arms a real major trace before String copy and observes
whether the actual TLS session is finalized. Baseline loses that owner (exit 1,
CPU 7.02 s / 14.82 s). The fence fixes it; removing only the fence restores
exit 1. O1/O2 with actual GC stress/verification and both poison modes passes,
with matching interpreter TLS protocol results. Three ALPN/peer-subject/library
resource checks pass CPU 2.79 s / 8.91 s; fmt CPU 0.37 s / 0.74 s. This fixture
proves the boundary when collection is armed; production library tracing stays
unarmed and no host-root tracing claim follows. Warning check now passes CPU 2.40 s / 4.77 s; publish the preparation separately.

Next audit remaining reconstructed/untyped aggregate owners (in particular
boxed nested loop-state fields), general File/socket resource discard, retained
callback teardown and cycle lifetime policy. Implicit effectful resource release
must preserve observable lifetime/evaluation order; it is distinct from harmless
memory reclamation and needs a language/interpreter contract before widening it.
Keep
phase 2 incomplete until acceptance is proved. Do not start a new deployment
interface or backend, or claim speed without equivalent workload evidence.

## Local operation and durable documentation

Root main has ONLY our pending live docs/history/queue/guard changes; preserve
those on fast-forward. Prepared published production checkouts are clean. Current
shared compiler target belongs to `/private/tmp/fwp-tls-alpn-root-worktree`; use
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
All local links in the live/archived documents resolve; queue has 60 entries.

The live plan/handoff now contain current priorities rather than repeated old
"next" actions. Historical notes are preserved verbatim except relative link
adjustments. Queue generation verified all 60 published parent/head ancestry relationships.
The root README/design/ownership docs now distinguish delivered #74–#84 work
from preparation, removing obsolete first-task/CI-pending claims.
Include these docs and persistent guard in the next sequential PR, reconcile
future snapshots against them, and update current state rather than appending
another competing priority queue. No roadmap work is blocked by test failures.
