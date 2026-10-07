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
   `macos-portability`, latest head `c7aeb6f`, baseline `7a05b58` (#73).
   Latest gate [37583294535](https://github.com/e6qu/fun-with-pipes/actions/runs/37583294535)
   is queued. Never substitute a prior or cancelled run for this gate.
2. Published preparation `ownership-contracts`, checkout
   `/private/tmp/fwp-ownership-worktree`, head `798d2ed`, base `ccecf20`.
   No PR yet. Centralizes 35 container contracts and borrows comparison-only
   keys. Runtime sharing protects saturation, interior references and spill.
3. This published preparation `ownership-leaves`, checkout
   `/private/tmp/fwp-leaf-worktree`, implementation `186dd1b`, base `798d2ed`.
   No PR yet. Adds selected String/Bytes ownership and safe typed leaf drops.

After #74 passes and squash-merges, fetch main and rebase the container checkout
with `git rebase --onto origin/main ccecf20 ownership-contracts`, reconcile docs,
push with lease and open its PR. After that PR merges, rebase this branch from
`798d2ed` onto main and reconcile docs before opening its PR. Inherit the latest
macOS runtime fixes. Keep one open PR; do not combine these ownership changes
with the macOS PR just to avoid waiting for CI.

## macOS failures and fixes

Full run `37576889350` on `ccecf20`: ARM failed, Linux full tests and benchmarks
passed, Intel still running at this update. ARM exposed BSD `wc` padding,
OpenSSL alert wording, list GC crashes and native server crashes. Fixes at
`252d6b1` and `c7aeb6f` retain constructor sources, list source/buffers, flat-map
and generic/specialized right-fold buffers through allocating operations.
The forms server, stressed web server, TLS stream snapshot and tutorial 19 pass
focused checks. Traits, shortened iterator/partition and filesystem fixtures
pass at `-O1`/`-O2`, GC stress/verification and both poison modes. Original long
stress workloads remain on CI. Darwin full support is not yet verified.

## Ownership implementation and evidence

[primitive-ownership.md](primitive-ownership.md) lists the contracts. String and
Bytes locals participate in IR ownership. Copied leaves establish counts;
identity/no-op aliases duplicate a reference. Read-only boundaries borrow;
unknown runtime/FFI boundaries share. Typed drops free leaf storage directly;
sharing skips byte payloads and reuse poison stays inside allocation capacity.
Canonical monomorphic type names are `std::String` and `std::Bytes`.

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
Full architecture and benchmark gates remain required for each ownership PR.

## Next implementation work

Complete nested text result ownership (Option/List), typed container elements,
escaping closure captures and retained runtime callback values. Preserve alias
semantics and check callbacks returning inputs/captures. Add handler unwind,
cancellation and FFI lifetime cleanup; define cycle policy. Old marked objects
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
