# Keep the tape capacity check at its caller

A derivative tape records operations for the later backward pass. Its buffers
usually have room for the next operation. At the baseline, each append calls a separate
routine even when that routine only checks the requested size and returns.

The [saved GCC reports](recording-inline-images-2026-11-06/README.md) show this call
remaining after append inlining. Each architecture's largest current-result
program has seven static reserve call sites. These are compiler call sites, not
execution counts or proof that they caused an earlier timing miss.

This contract precedes implementation. It uses source
`a90f793e485aa91736156ae87dfc3ae36ec9cbad`, the final head of
[PR #263](https://github.com/e6qu/fun-with-pipes/pull/263). That PR's [delivery](recording-inline-delivery-2026-11-06/README.md) passes;
its measurements are not this comparison. The capacity change subsequently
shipped in [PR #264](recording-capacity-delivery-2026-11-06/README.md).
The original acceptance rules below retain all missed timing limits.

## Change and safety proof

Split `fwp_tape_reserve` into an always-inlined checked gate and one ordinary
out-of-line growth body. The gate computes the existing limit, rejects negative
or excessive requests, returns if capacity is sufficient, otherwise passes the
explicit request and limit to the growth body. Keep the growth body unchanged.
Both F64 and typed append use the same gate. Keep append inlining and validated
lookup reuse in both measured versions.

```text
append validates tape and parents
  → reject invalid requested capacity
  → enough room? return directly
  → otherwise grow buffers, then return
  → write the new operation
```

This separation avoids duplicating allocation and cleanup code at every append.
It adds no runtime setting, alternative representation, public API or syntax.
It does not remove a validation, preallocate earlier or hoist work across traps.

Preserve these invariants:

- Validate the request before the capacity shortcut, even if capacity is large.
- Keep full-tape and parent checks before reserve, and writes after reserve.
- Keep capacity doubling/clamping and allocation order unchanged.
- Numeric parent pairs share one allocation; weight pairs share another.
  Move only initialized entries, preserving alignment and exact weight bits.
- Typed growth can trap after the parent allocation moves. Until weight growth
  succeeds, keep the old capacity and parent-region offset valid for retry or
  retirement. Publish the new offsets/capacity at the same point as before.
- Keep native allocation-failure release and exit code 102, scope ownership,
  cancellation, cached workspace limits and final release unchanged.

## Reference and correctness

Build a same-source reference by recombining only the split reserve routine into
its original checked body. Verify exact source reconstruction, changed-file
inventory and all other recorded source hashes. Do not depend on a previous fwp
binary, add a runtime switch or weaken checks in either version.

Extend `autodiff_capacity_bounds`, which already tests moving allocations,
overlapping region moves, native allocation failures, typed growth recovery and
WebAssembly bounds. Add negative/oversize request checks before the early return,
exact-capacity/no-growth cases and controls that deliberately break the bound or
gate. Compare ordinary and inline forms at native O1/O2; include an O0 direct
control. Keep paired-buffer, task/cancellation, nested/F128, workspace and raw
interpreter agreement checks. Use explicit `.exe` paths in the paired harness.

Verify both production GCC architectures and Clang on macOS. Extend existing test
targets instead of creating a new shard. Check instrumentation and reference
corruption controls before the combined measurement batch.

## Frozen measurements and limits

Use the [append-inlining protocol](recording-inline.md#frozen-measurement-limits)
unchanged: six coordinate/update/repetition cases, both current/history result
forms, two qualified sessions per architecture, Neoverse N2 and EPYC 7763, GCC O2,
no fast math/contraction/LTO, two warmups and 98 balanced rounds of seven fresh
processes. Use the same explicit workspace policies, O1/O2 memory census and
seven compiler inputs with 48 samples each.

| Measure | Required result |
|---|---|
| Long solves | At least 5% less elapsed time than the same-source unsplit reference |
| Small solves and identical-copy variation | At most 2% regression/variation |
| Compiler time and peak RSS | At most 5% growth, with existing copy qualification |
| Allocation, retains, lookups, parent/capacity checks and nodes | Unchanged counts; three lookups and eight recorded nodes per pair/update |
| Managed/raw memory | No larger peak; zero final storage |
| Largest reported stack frame | At most 128 additional bytes; retain dynamic-frame qualifications |
| Native code | Gate inlined at positive-update recording sites; original measured images reproduced exactly for the compiler-report check |

Retain native compile time, executable/instruction size, process RSS and C/Rust
peer results. Those peers use handwritten derivatives; their complete-program
ratios cannot isolate language or ARC overhead. Fewer calls alone are not a speed
or memory claim. Count validation separately from growth and call decisions.

Run each qualified session once after the related implementation and focused
controls are ready. Replace only hosts rejected before building/timing. Audit
every case and retain misses. Verified reductions may be kept with timing goals
open under the agreed policy; never retain failed semantics or memory safety.
This comparison cannot close an older missed limit. Finish with all nine exact-
head production jobs, docs and complete artifact/log audits before squash merge.
