# Exact scalar constants without lazy caches

Preparation for the group after PR #260. Parent source:
`ba3f0d8793dc3bbd3c21f94d06a1bca2896b6d45`. Require its verified merge before
publishing this PR or collecting native measurements. Freeze this contract in
Git before changing compiler code; retain all earlier timing misses.

## Why investigate this

The parent measurements put objective evaluation plus derivative recording at
73–75% of separately instrumented stage time for 129 coordinates / 199 updates.
This is not a percentage of ordinary end-to-end time. Saved generated C calls
lazy caches for `One[F64].one` and `prim.one` inside numeric workers. Source review
establishes those lookups, not their machine cost: the C compiler may remove work.

For example, a monomorphic `one : F64` is exactly the bits for `1.0f64`.
Reading that value needs no allocation, mutable initialization flag or user code.
An arbitrary zero-argument definition can still perform effects or trap; it
must keep its existing first-use evaluation and cache ownership.

## Implementation boundary

- Reuse the bounded constant proof currently used for packed fold seeds. Share
  that proof instead of introducing a second evaluator or running user code.
- Recognize only immediate I8/I16/I32/I64, U8/U16/U32/U64, F32/F64 literals,
  exact primitive zero/one and acyclic zero-argument aliases of those values.
  Check each entry's declared type; exclude pointer-width aliases initially.
- Replace proved scalar references at their existing expression positions.
  Keep their exact bits, including signed zero and NaN payloads. Do not evaluate
  floating-point arithmetic at compile time or add implicit conversions.
- Preserve the existing packed-fold record-seed rule independently. An aggregate
  proof is not permission to erase ordinary aggregate allocation or ownership.
- Do not fold effects, traps, resource scopes, traced expressions, arbitrary
  calls, recursion, owned/wide values or function-valued caches. Keep a finite
  256-node proof budget and memoization; exhaustion means no replacement.
- Preserve evaluation order, cancellation and cleanup. Review every affected
  caller and probe; a test that rewrites a constant body into an effect must use
  an actual nonconstant input when checking effectful-cache behavior.
- No public syntax, runtime flag, tape validation change or allocator change.

## Grouped checks

Unit controls cover aliases, cycles, type mismatches, proof exhaustion, exact
float bits and rejected effect/resource/owned values. Native checks compare raw
interpreter results with optimized interpretation and native O1/O2; they include
constant users outside autodiff, unused trapping arguments, eager captures,
first-use effects and owned-cache retry/reentry/cleanup. Keep existing numeric,
packed-fold, ownership, cancellation and full corpus coverage.

Check generated complete programs for the selected constant reads and retain
actual native images. Do not infer a runtime cause from disassembly. Deliberately
broken selection/bits/order observers must fail. Run the grouped focused checks
on GCC Linux ARM64/AMD64 and Clang macOS ARM64, then one final production matrix.
No local builds while resource limits refuse them.

## Fixed comparison and acceptance

Use one internal compile-time selection constant to construct a same-source
reference disabling only general scalar replacement. Both builds retain packed
fold seed lowering, pair reuse and every correctness repair. Verify the edit is
unique/reversible and all other files identical. Record exact revisions, commands,
compilers, flags, artifact hashes and every outcome before claiming acceptance.

Use the parent's six complete solves, current/history forms and explicit workspace
reuse settings: coordinates/updates/solves per process are 3/0/32768, 3/1/512,
3/199/32, 3/1999/4, 33/199/32 and 129/199/8. Count allocations, managed/raw current
and peak storage, final cleanup, recording nodes and phase work before timing.
General scalar replacement predicts unchanged allocation/node counts, not a
particular speedup; reconcile the reference with the parent's saved counts.

Retain the established seven compiler inputs and 48 scheduled compilations per
input, with at most 5% time/RSS growth and 2% identical-copy variation. Add explicit
constant-chain and unrelated nonnumeric correctness controls; bounded analysis
must not inspect arbitrary user code.

For runtime, two qualified EPYC 7763 and Neoverse-N2 sessions each; GCC O2,
no fast math/contraction/LTO, explicit native targets, two warmups and 98 balanced
rounds of seven fresh processes. A sample is the sum for all seven processes.
Require 5% faster long solves, no small-case slowdown above 2%, and identical-copy
variation at most 2%. No unchanged timing reruns for a pass. Retain failed host
qualifications before requesting any replacement.

Require unchanged allocation/node counts, no greater peak managed/raw storage,
zero final storage and at most 128 extra reported frame bytes. Report dynamic
stack entries separately; GCC's reported bytes do not bound total stack use.
Report process RSS, instruction and file bytes without treating size as speed.
Retain C/Rust complete-program comparisons, explaining that handwritten
derivatives differ from fwp recording/reverse traversal.

Verified structural reductions may be retained under the accepted policy with
missed timing targets explicit. That does not waive semantic, memory or compiler
cost failures. Delivery still needs all nine exact-head production jobs, docs,
complete log/artifact audits and a one-line squash message of at most 80 characters.
