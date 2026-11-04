# Same-type float conversions and redundant array maps

**Preparation:** frozen before implementation, based on PR #253's final head
`89394229`. That PR is now [delivered](../roadmap-history.md#direct-scalar-array-calls-pr-253).
[The handoff](../development-state.md) records this group's exact sources and checks.

The rule for this implementation is that converting a float to its own type
preserves every bit. Cross-type conversion rules remain unchanged.

## Observable behavior

```fwp
same : F64 -> F64
same = float.convert
narrow : F64 -> F32
narrow = float.convert
```

`same` returns exactly the input bits, including negative zero and NaN payloads.
A NaN is a non-number float value; its sign and extra payload bits can differ
between representations of NaN. `narrow` changes the format and rounds according
to the existing conversion rules. Its behavior is unchanged by this work.

Apply the same-type rule to F16, BF16, F32, F64 and F128. At the preparation source, the
interpreter canonicalized NaNs that native F64 preserved. Scalar paths must agree
before the map can be removed. Keep generic F128 results independently owned: returning a
borrowed box as an owned result is not an identity optimization.

## Selected optimization

An `array.map` whose callback is exactly the known primitive
`float.convert : F64 -> F64` may return its input array instead of allocating and
copying an identical array. Select only that primitive, concrete type and arity;
do not infer arbitrary user callbacks to be identities.

- Rewrite at the existing optimizer call site before ownership insertion. Use
  constant work per candidate from existing function/type information.
- Evaluate the input expression once, at the original point. A unique owner
  moves; shared inputs receive ordinary result ownership. Slices keep the right
  backing owner. Later immutable updates cannot mutate an alias.
- Cross-type, dynamic, captured and effectful callbacks keep their existing map.
  F16/BF16/F32/F128 array-map elimination is outside this initial scope.
- Remove no user callback effects, traps or scheduler entries. Pure allocation
  can disappear; allocation failure in remaining work must still clean up.
- Do not change array layout, public APIs, tracing policy, callback dispatch,
  coordinate lists, input derivative records or iteration-history storage.

## Required verification

1. Compare raw/optimized interpreter and native primitive/specialized entries
   using exact bits: signed zeros, subnormal and normal boundaries, infinities,
   quiet/signaling NaNs with both signs and several payloads. Retain cross-type
   rounding and canonical-NaN controls. Cover all five scalar formats.
2. Check selected/rejected compiler cases, input evaluation, empty/full/sliced
   arrays, shared aliases and subsequent immutable updates. Use GCC ARM64/AMD64
   and Clang ARM64 at O1/O2, packed arrays enabled/disabled.
3. Verify unique-owner transfer and shared-owner survival. Exercise allocation
   failures and cancellation around remaining work, reuse enabled/disabled,
   missing-cleanup controls, and zero final managed/raw storage. Check emitted
   C and saved native binaries for absent conversion-map allocation/traversal.
4. Keep the primitive inventory unchanged. Audit native test assignments if any
   target is added. Run focused checks as one group, repair all findings together,
   then run the final nine production jobs plus documentation once ready.

### Allocation-failure policy found during source review

The native allocator's `fwp_heap_oom` prints `fwp: out of memory` and exits 102;
it does not unwind. Test that terminal behavior separately. The fault probe calls
the fatal allocator path at the next allocating array read; it does not claim to
exhaust the host or observe zero live storage after process termination.
Recoverable traps and cancellation at that boundary must unwind the generated
owner and leave zero additional managed storage, including aliases and views.
This clarifies the failure checks before measurements; it changes no runtime
failure policy or performance limit.

## Measurement isolation and limits

Freeze a same-source reference that disables only this array-map rewrite. Both
candidate and reference include the scalar correctness repair and PR #253's
implementation. Retain source/patch/compiler identities and corruption controls.

Use the existing six gradient coordinate/update pairs, current/history forms,
98-sample schedule, seven processes and two qualified sessions per architecture.
Keep source programs, GCC settings, workspace policy and output identical.
Require copy variation ≤2%, zero/one-update regression ≤2%, and ≥5% less elapsed
time on larger cases. Compiler analysis time/RSS must stay within 5%; largest
reported frame growth must stay within 128 bytes. Report code size separately.

Require the selected unique case to remove its replacement array and traversal
without new retains. Report allocation requests/bytes, ARC operations, live and
raw-buffer peaks, final cleanup, and whole-process RSS separately. Shared/view
cases may retain existing backing storage longer: measure and state those costs;
do not generalize the private-gradient result to every alias pattern.
The native owner probe measures 256-element arrays, both unique and shared, and
256-element slices of 1,024-element arrays. For each, report allocation/count
operations and charged allocator bytes during the map, live bytes before/after,
peak live bytes and final cleanup. Charged bytes include allocator size classes;
they are not requested bytes or whole-process RSS. Packed-off controls use copied
slices and must not be described as views.

Retain every failed timing/noise limit without rerunning completed measurements
for a pass. Accepted policy permits verified reductions with speed goals open.
Keep [older goals](../../PLAN.md#open-performance-goals) open against their original
references. Follow the [remaining-storage review](remaining-gradient-storage.md)
for unselected candidates; do not fold them into this experiment.
