# Session handoff

Updated: 2026-10-07. Read [PLAN.md](../PLAN.md), [ownership.md](ownership.md)
and [design.md](design.md). This branch is prepared work, not merged behavior.

## Authorized workflow and priority

Complete the active roadmap automatically, one focused PR at a time. Fix failing
tests; CI queues and failures gate merging, not useful implementation. Full gates
run on GitHub. Squash only after passing current-head CI with an explicit subject
of at most 80 characters and an empty body, no trailers or attribution. Keep pipe
syntax, typing, evaluation/trap order and immutable value semantics stable.

## Branch and PR sequence

1. Open PR [#74](https://github.com/e6qu/fun-with-pipes/pull/74), branch
   `macos-portability`, latest head `2c2a46d`, baseline `7a05b58` (#73).
   Current-head gate is
   [37591744197](https://github.com/e6qu/fun-with-pipes/actions/runs/37591744197).
   Run
   [37584632219](https://github.com/e6qu/fun-with-pipes/actions/runs/37584632219)
   on `8bc372f` completed ARM with one timer fixture failure; benchmark
   equivalence passed. Never substitute an earlier run for the current head.
2. Published preparation `ownership-contracts`, checkout
   `/private/tmp/fwp-ownership-worktree`, head `798d2ed`, base `ccecf20`.
   No PR yet. Centralizes 35 container contracts and borrows comparison-only
   keys. Runtime sharing protects saturation, interior references and spill.
3. Published preparation `ownership-leaves`, checkout
   `/private/tmp/fwp-leaf-worktree`, head `2ce7a05`, base `798d2ed`.
   No PR yet. Adds direct String/Bytes ownership and borrowed-root lifetimes.
4. Published preparation `ownership-text-results`, checkout
   `/private/tmp/fwp-text-worktree`, head `bab67ea`, base `2ce7a05`, no PR yet. Owns selected
   copied Option/List text trees and releases conversion scratch arrays.
5. Published preparation `ownership-closures`, checkout
   `/private/tmp/fwp-closure-worktree`, head `0d96bfe`, base `bab67ea`, no PR yet. Compiled
   dynamic calls own heap closures and typed captures; callbacks still share.
6. This preparation `ownership-closure-cleanup`, checkout
   `/private/tmp/fwp-drop-worktree`, base `0d96bfe`, no PR yet. Function capture
   cleanup uses a bounded-depth work list with explicit spill release.

After #74 passes and squash-merges, fetch main and rebase the container checkout
with `git rebase --onto origin/main ccecf20 ownership-contracts`, reconcile docs,
push with lease and open its PR. After that PR merges, rebase the leaf branch from
`798d2ed` onto main and reconcile docs before opening its PR. Inherit the latest
macOS runtime fixes. Keep one open PR; do not combine these ownership changes
with the macOS PR just to avoid waiting for CI. After the leaf PR merges,
rebase the text branch from `2ce7a05` onto main and run its full CI via a PR.
After its merge, rebase this closure branch from `bab67ea` onto main, reconcile
docs and run full CI in the next PR. After the closure PR merges, rebase this
cleanup branch from `0d96bfe` onto main and validate it as the next PR.

## macOS failures and fixes

Full run `37576889350` on `ccecf20`: both macOS jobs failed; Linux full tests
and benchmarks passed. ARM exposed BSD `wc` padding,
OpenSSL alert wording, list GC crashes and native server crashes. Runtime fixes at
`252d6b1` and `c7aeb6f` retain constructor sources, list source/buffers, flat-map
and generic/specialized right-fold buffers through allocating operations.
The forms server, stressed web server, TLS stream snapshot and tutorial 19 pass
focused checks. Traits, shortened iterator/partition and filesystem fixtures
pass at `-O1`/`-O2`, GC stress/verification and both poison modes. Original long
stress workloads remain on CI. Intel also exposed unsynchronized timer print
order; `8bc372f` collects scoped
wake results in a channel and prints sorted results after the scope completes.
All slice/GC checks and exact golden outputs pass locally; full WASM/fiber
validation stays on CI. ARM then exposed the same assumption in the
socket-enabled `tasks.fwp`; `2c2a46d` applies scoped result collection there
and adds it to every slice/backend/GC-stress check. The expanded focused
test passed locally (CPU 41.59 s / elapsed 83.89 s). Its other ARM targets
passed. Darwin full support still requires the new current-head gate.

## Ownership implementation and evidence

[primitive-ownership.md](primitive-ownership.md) lists the contracts. String and
Bytes locals participate in IR ownership. Copied leaves establish counts;
identity/no-op aliases duplicate a reference. Read-only boundaries borrow;
unknown runtime/FFI boundaries share. Typed drops free leaf storage directly;
sharing skips byte payloads and reuse poison stays inside allocation capacity.
Borrowed pointer arguments remain conservative roots through primitive calls,
even if an inlined drop is reduced to metadata access. Alias/copy regressions
pass at both `-O1` and `-O2`. Canonical monomorphic type names are `std::String` and `std::Bytes`.

Focused checks passed through the local resource guard:

- One container inventory check and eight IR ownership checks.
- Three container tests: alias/callback GC/reuse verification, comparison-key
  allocation/reuse and runtime saturation/interior-reference/spill protection.
- Two leaf tests: retained aliases, copies and no-op paths under GC/reuse
  verification; a 10,000-step copy loop with tracing off and zero collections.
- All five FFI regressions; formatting and whitespace checks.

Apple Silicon, Apple Clang 17, `-O1`: the leaf loop frees 0.9 MiB by counts versus
0.0 MiB with `FWP_FREE=0`, with identical output (0.1 MiB precision). The key
comparison loop allocates 0.0 MiB versus 0.8 MiB when only the old sharing boundary
is restored. These are counter results, not timing or register-placement claims.
Fresh-tree checks pass for copied Option/List results, retained inputs,
Unicode and invalid/missing cases at `-O1`/`-O2`, GC stress/verification and
both poison modes. All 31 string declarations, seven byte declarations and
35 container declarations have consistent argument/result contracts. Numeric
parse options stay shared. A word-list loop frees 2.1 MiB by counts versus
0.0 MiB with freeing disabled, with tracing off. Conversion scratch buffers use
releasable allocations; restoring only their previous lifetime grows the same
no-tracing workload's heap from 1.7 MiB to 9.2 MiB with identical output.
Full architecture and benchmark gates remain required for each ownership PR.

## Next implementation work

Complete other runtime-generated text results, typed container elements and
retained runtime callback values. Compiled escaping heap captures are prepared
here; their default stack and task-callback regressions passed locally. Preserve alias
semantics and check callbacks returning inputs/captures. Add typed cleanup for stack aggregate fields, handler unwind,
cancellation and FFI lifetimes; define cycle policy. Add an exact overflow
count path before general no-tracing execution: current byte counts saturate
at 255 and promote the graph to tracing-managed sharing. Old marked objects
remain under generational reclamation and WASI remains a bump allocator. Phase 2
is incomplete; these focused leaf checks do not establish general ARC or no-GC
execution. Later numeric/AD phases remain active in PLAN.md.

## Local resource limits

Full builds, test gates and evidence generation belong on GitHub runners. Local
checks are serial and low priority: 1 GiB sampled aggregate RSS, target below
2 GiB, at least 64 GiB free disk, 180-second deadline, CPU toward half one core.
The temporary `/private/tmp/fwp-local-guard.py` adapts the user's guard only to
this repository root. It needs process-sampling/priority permissions. Use
`CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target` in temporary
worktrees so the guard monitors the shared target. Never run checks concurrently
across those worktrees or increase limits after a refusal.

## Prepared closure validation

Eight IR ownership checks and ten focused closure/leaf/container/text tests
passed through the guard. Retained aliases, partial applications, capture
sharing and functions returning their inputs pass interpreter/native comparisons
with GC stress/verification and both poison modes. The heap-closure loop with
tracing disabled reports zero collections and 1.2 MiB freed by counts versus
0.0 MiB with freeing disabled. Five FFI checks and the local fat-binary baseline
passed. Task callback output and both FWP_STACK=0/1 closure paths passed locally,
including O1/O2, GC stress/verification and both poison modes. The strengthened
closure check used CPU 4.39 s / elapsed 8.85 s under the guard. No full local gate was run. Full CI must cover WASI,
x86-64, both Darwin jobs, runtime stress and benchmark equivalence before merge.

Bounded deep function capture cleanup is prepared here: the 8,000-node linear
and branching probes exhaust a 256 KiB worker stack with only recursive release
restored, but complete with the work list, exact interpreter output and zero
collections at O0. Three cleanup/closure checks passed (CPU 5.90 s / elapsed
11.97 s). The branching case exercises explicit spill-buffer release.

Next: carry concrete expected types into constructor temporaries. A borrowed
List literal currently can fall back to unknown, decrementing its outer count
without typed child release. Add counted-child evidence for this case, then
stack aggregate cleanup and retained callbacks. Count saturation, exceptional
paths and generational old-object reclamation still delegate to GC.
