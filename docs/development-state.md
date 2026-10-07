# Session handoff

Updated: 2026-10-07. Read [PLAN.md](../PLAN.md), [ownership.md](ownership.md)
and [design.md](design.md). Prepared branches are not merged behavior.

## Authorized workflow

Complete the active roadmap automatically, one focused PR at a time. Failing
tests are work to fix, never a roadmap blocker. Queued CI gates merging only;
continue diagnosis, fixes and separate next-task preparation. Full builds,
full tests, benchmarks and large evidence generation run on GitHub runners.
Squash only after all current-head gates pass, with an explicit one-line
subject of at most 80 characters and an empty body. No trailers, AI attribution,
Co-authored-by or Authored-by lines. This authorization persists across sessions.
Keep simple data-last pipes, strong typing/inference, explicit generic signatures,
immutable value semantics, effects and evaluation/trap order stable.

## Merged baseline and current work

- Main: `af15d26`, squash merge of [PR #74](https://github.com/e6qu/fun-with-pipes/pull/74)
  on 2026-10-07. Verified commit message: one line, 65 characters, no body/trailers.
- Its final head `2c2a46d` passed all four jobs in
  [run 37591744197](https://github.com/e6qu/fun-with-pipes/actions/runs/37591744197):
  ARM macOS, Intel macOS, Linux full tests and benchmark equivalence. Earlier
  macOS GC, socket, TLS snapshot, BSD wc and unsynchronized timer failures were
  repaired. Phase 1 meets its native-platform acceptance gate.
- Current branch: `ownership-contracts`, checkout
  `/private/tmp/fwp-ownership-worktree`. Three implementation commits rebased
  onto main; implementation head `ee80a7e`. Documentation commit follows.
  Remote previously held `798d2ed`; use force-with-lease for the reviewed rebase.
  Published head `678abf6`, [PR #75](https://github.com/e6qu/fun-with-pipes/pull/75).
  Full gate [37605739266](https://github.com/e6qu/fun-with-pipes/actions/runs/37605739266)
  is queued/running. The previous run `37603180337` passed benchmarks, then
  was superseded by corrected macOS status docs and cancelled; it is not a gate
  for this head. Fix failures and squash only after all current-head jobs pass.
- Scope: shared metadata for all 35 array/map/set declarations, comparison-key
  borrowing, owning-wrapper selection and safe graph sharing at saturation,
  interior references and traversal-stack spill. Stored values and callbacks
  remain shared. This is the first step of phase 2, not complete ARC/no-GC.

## Current ownership evidence

One inventory invariant, eight IR ownership checks and three container
regressions passed before rebase. Tests cover interpreter/native agreement,
retained aliases and callbacks with GC stress/verification and reuse poisoning.
The comparison-key loop allocates 0.0 MiB versus 0.8 MiB with only the old sharing
boundary restored (Apple Silicon, Apple Clang 17, O1, 0.1 MiB counter precision).
This is allocation evidence, not a speed or register-placement claim. The runtime
regression exercises count saturation, interior references and 70-branch traversal
spill; restoring the previous saturation transition corrupts a visible alias.
Post-rebase checks passed: inventory (1), IR ownership (8), container tests (3),
formatting and whitespace. The container run used CPU 9.63 s / elapsed 19.46 s
under the guard. Full current-head CI remains required.

## Prepared sequence

All following branches are published, have focused local evidence, and have no
PR yet. Open each only after its parent PR merges. Fetch main, rebase from the
listed OLD base onto main, reconcile docs with the latest handoff, validate,
push with lease and run full CI. Do not replay the parent's pre-squash commits.

| Branch | Checkout under /private/tmp | Head | Old base to remove |
|---|---|---|---|
| ownership-leaves | fwp-leaf-worktree | 2ce7a05 | 798d2ed |
| ownership-text-results | fwp-text-worktree | bab67ea | 2ce7a05 |
| ownership-closures | fwp-closure-worktree | 0d96bfe | bab67ea |
| ownership-closure-cleanup | fwp-drop-worktree | 7cf5c78 | 0d96bfe |
| ownership-temporary-types | fwp-temporary-worktree | 0acbc06 | 7cf5c78 |
| ownership-stack-arguments | fwp-stack-worktree | b563360 | 0acbc06 |
| ownership-borrowed-callbacks | fwp-callback-worktree | 029fac4 | b563360 |
| ownership-map-callbacks | fwp-map-worktree | 41ef82d | 029fac4 |

Example after this PR merges: from fwp-leaf-worktree,
`git rebase --onto origin/main 798d2ed ownership-leaves` after fetching main.
Review runtime changes against the latest macOS fixes and resolve documentation
conflicts by carrying forward verified state, not by preserving stale statuses.
Temporary worktrees are conveniences; published branches preserve the work.

- Leaves: String/Bytes counted ownership, fresh/copy/alias contracts, leaf-only
  destruction/poisoning and address fences for borrowed allocating calls. Two
  alias/copy regressions pass at O1/O2 with GC stress/verification and both poison
  modes; no-tracing copy loop frees 0.9 MiB versus 0.0 with freeing disabled.
- Text: copied Option/List trees use FreshTree only when no input aliases exist.
  Conversion buffers use separately releasable memory. Three focused tests pass;
  no-tracing word loop frees 2.1 MiB, and buffer cleanup reduces the equivalent
  probe's committed heap from 9.2 to 1.7 MiB. All 31 string and seven byte
  declarations are inventoried on that branch.
- Closures: typed heap captures, consuming dynamic application and metadata
  for owned entry/capture cleanup. Runtime callbacks still share. Aliases,
  partial application, returned inputs and stack on/off pass O1/O2 GC/poison
  checks. No-tracing selected loop frees 1.2 MiB versus 0.0 with freeing disabled.
- Deep closure cleanup: work list with 64 local slots and freed spill storage.
  Linear/branching 8,000-node graphs reclaim with zero collections on a 256 KiB
  native worker stack at O0; restoring recursive release exhausts that stack.
- Temporary types: concrete call parameter types preserve typed constructor
  child cleanup. No-tracing function-list loop frees 0.5 MiB versus 0.0 when only
  outer-only release is restored. Eight IR and twelve ownership checks pass.
- Stack arguments: eligible stack locals/aliases and consumed calls own typed
  child references, with nested cleanup scopes and address fences. Borrowed
  calls keep owners until IR Drop. Six escape and fifteen ownership checks pass.
  Restoring old child lifetimes gives variant/closure frees 0.0/1.3 MiB versus
  0.5/1.7 MiB after cleanup. Existing stack closure allocation test, five FFI
  checks and local fat baseline pass. Full platform gates remain required.

All counter probes use identical outputs, tracing disabled and zero collections;
results are rounded to tenths of a MiB. None establishes general no-GC support.

## Remaining acceptance work and next implementation

Synchronous borrowed callback and map ownership are prepared after b563360.
Next prepare filter callback ownership while current CI runs; keep retained
callbacks shared until their full lifetime and exceptional cleanup are checked.
Other constructor/result contexts, typed container elements, retained callbacks,
handler unwind, cancellation and FFI lifetimes remain. Define cycle policy.
Byte counts at 255 still promote whole graphs to tracing-managed sharing;
implement an exact overflow path before general no-tracing execution. Old marked
objects still rely on generational reclamation. WASI remains a bump allocator.
Phase 2 is incomplete. Continue numeric storage/ABI, fused numerics/autodiff,
measured evidence and optional no-tracing phases in PLAN.md after ownership.

Darwin cross targets/universal binaries, Clang PGO and Darwin static-memory
validation remain deferred. Native static linking is explicitly unsupported.
OpenCL framework discovery works; hardware execution is unverified. Linux-only
strace/process RSS suites still need platform alternatives. Windows, new
interfaces and new backends are outside the active roadmap. Historical Linux
benchmark numbers are not current macOS performance evidence.

## Local resource limits

Checks are serial and low priority: 1 GiB sampled aggregate RSS, target below
2 GiB, at least 64 GiB free disk, 180-second deadline, CPU toward half one core.
Use `/private/tmp/fwp-local-guard.py`, adapted only to this repository root,
with `CARGO_TARGET_DIR=/Users/zardoz/projects/fun-with-pipes/target` in temporary
worktrees. It needs process-sampling/priority permissions. Recreate the temporary
guard with the same limits if missing. Do not bypass a refusal or increase limits;
move the workload to CI. No full local gates were run.

## Next callback change: design constraints

Start with synchronous map callbacks, not retained task/channel/FFI callbacks.
Add a typed borrowed application path: duplicate supplied pointer arguments
according to function metadata, consume those copies in the owned entry, and
retain the original function owner. Partial and overapplication must duplicate
arguments in chunks according to each actual function's parameter types, never
by guessing whether scalar bits resemble an address. Callback results then have
one owned reference, including aliases of inputs/captures and returned functions.

Map needs owned fresh list spines with already-owned elements; FreshTree is not
valid for aliased callback results. Do not reset child counts or recursively
promote borrowed inputs to sharing. Release the temporary result buffer after
transferring its references into new nodes. Add aliases/captures/function-result,
GC/reuse and zero-tracing reclamation tests; validate hardware/benchmark gates.

Preserve specialized direct callbacks and captured HOF loops. Function locals
are now counted, so a borrowed callback temporary can hide its known partial
application behind a local. Recover its function/captures for specialization,
and allow stack callbacks only when the contract proves synchronous invocation
without retaining the function itself. A Borrow argument may still have aliased
results; borrowing alone is not a no-escape proof. Stack caller cleanup must
run only for consumed arguments; borrowed ones are released by their IR Drop.
The stack change already consults rc::consumes_arg for that distinction.

Byte counts still saturate into tracing-managed sharing at 255. An exact overflow
path, other constructor/result contexts, exceptional cleanup, old-generation
reclamation, retained runtime graphs/cycles and WASI reclamation remain required
before general no-tracing execution. Do not claim phase 2 or phase 6 complete.

## Borrowed callback foundation preparation

`ownership-borrowed-callbacks`, `/private/tmp/fwp-callback-worktree`, base
`b563360`, published at `029fac4`, has typed argument-slice duplication metadata and a borrowed dynamic
application entry. Exact/partial/overapplication, captured/input aliases,
compiler-generated mixed scalar/pointer metadata and stack callbacks pass at
O1/O2, GC stress/verification and both reuse-poison modes. The focused probe
used CPU 1.03 s / elapsed 2.59 s under the guard. Sixteen focused ownership regressions passed (CPU 29.75 s / elapsed 59.69 s).
Five FFI checks and the local fat baseline passed (CPU 5.27 s / elapsed 10.60 s).
This foundation leaves existing map/retained callbacks unchanged. Next: owned map spines, scratch-buffer release,
synchronous callback contracts and preserved specialized HOF loops. Full CI is
required after all parent merges. Prepared work never completes phase 2 alone.

## Synchronous map preparation in progress

`ownership-map-callbacks`, `/private/tmp/fwp-map-worktree`, base `029fac4`,
is published at `41ef82d`, with no PR yet. FreshSpine owns new list nodes
without resetting already-owned callback elements. Generic callbacks use typed
borrowed application; direct/captured HOF loops keep specialization and typed
per-call ownership. Only map's synchronous function slot gets a no-escape proof;
Borrow alone is insufficient. Scratch arrays are explicitly released.

Alias checks cover new allocated captures, retained inputs and returned functions,
O1/O2, stack on/off, GC stress/verification and poison modes. The selected
no-tracing differential restores only the shared-result boundary: identical
outputs and zero collections; counts free 2.7 MiB versus 4.6 MiB with owned map
results. This is counter evidence, not a speed claim. The existing stack closure allocation regression passed (CPU 7.20 s / elapsed
14.70 s including rebuild); six escape checks and the contract inventory passed.
Final post-review ownership set passed: eighteen tests, CPU 33.90 s / elapsed
68.10 s under the guard. Full current-head CI remains required after parent merges. A review added original callback/list address fences
around specialized calls and clears stale local callback-origin information.

Five FFI checks and the local fat baseline also passed for map ownership
(CPU 5.66 s / elapsed 11.28 s). Formatting and whitespace passed after applying
the reported formatting changes. No local full gate or benchmarks were run.

After stack ownership merges, rebase borrowed callbacks from b563360; after
that merges, rebase map callbacks from 029fac4. Each gets its own full CI PR.
For filter, duplicate a selected element by its concrete callback parameter
type before transferring that reference into the result spine. Retain input
list and callback roots; preserve direct/captured specialized loops and exact
callback/trap order. A predicate consumes typed argument copies and returns Bool;
its call alone does not acquire the reference needed by a selected output node.

## Filter preparation in progress

`ownership-filter-callbacks`, `/private/tmp/fwp-filter-worktree`, base `41ef82d`,
is not committed yet. Synchronous filter borrows predicate/list, gives selected
elements their own typed references, returns an owned fresh spine and frees
scratch storage. Direct/captured loops retain specialization and root fences.

Two focused probes pass: O1/O2, stack on/off, GC stress/verification and poison
modes cover selected String/function aliases and newly allocated captures.
The no-tracing differential restores only the shared-result boundary: identical
output and zero collections; counts free 4.6 versus 5.0 MiB. The initial fixture
needed a separate pure function-list signature; it now passes. A prematurely
started formatting check was refused by the guard's workload lock, so no checks
overlapped. Formatting ran only after the test completed, with unchanged limits.
Twenty focused ownership regressions passed (CPU 38.40 s / elapsed 76.96 s).
Five FFI checks and the local fat baseline passed (CPU 5.61 s / elapsed
11.21 s). The contract inventory covers both map/filter declarations.
Formatting and whitespace passed; full current-head CI remains required.
Next: other synchronous callbacks (fold/zip-with), typed container elements,
remaining contexts, exact overflow counts, exceptional/retained runtime cleanup,
old-generation and WASI reclamation, plus cycle policy. Phase 2 is incomplete.

## Next fold design

Start with synchronous fold. Its function/list borrow; the accumulator transfers
one owned reference into every callback, and the returned value replaces it.
Empty input returns the incoming accumulator reference. Introduce a typed
borrowed-application helper with an owned-prefix length: skip duplication of
transferred prefix arguments, duplicate the remaining slice by actual function
metadata, and carry the remaining prefix length across overapplication chunks.
Ordinary borrowed callbacks use prefix zero. Fold uses prefix one; avoid an
extra retain/release of the accumulator every iteration.

Preserve direct/captured fold specialization: duplicate captured pointer values
and the input element by concrete types, transfer the accumulator, invoke the
owned entry and keep original function/capture/list roots through allocations.
Use separate owned two-argument callback wrappers if needed; map/filter's wrappers
borrow all supplied arguments. Define an OwnedValue result contract, not
FreshTree/FreshSpine: the accumulator may alias a supplied element or capture.
Add empty/alias/function-accumulator and partial/overapplication checks plus a
no-tracing differential, then run the focused ownership and full CI gates.
Fold-right/zip-with and retained callbacks remain separate follow-up scopes.
