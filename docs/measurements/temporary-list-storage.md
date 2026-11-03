# Remaining temporary list storage

**Status:** count-only protocol; no new compiler transformation selected.
Protocol anchor: `roadmap/temporary-list-protocol-2026-11-03`.
[PLAN.md](../../PLAN.md) groups the census, selected storage change, controls and
final measurements in one PR.

## What we need to explain

[PR #249](../roadmap-history.md#numeric-callback-owner-transfers-pr-249) removes
98.7% of retains in the largest saved derivative solve. Allocation traffic is
unchanged: 154,952 of 156,943 requests use the shared 24-byte record/list
constructor. A constructor creates one heap object; its current counter combines
several operations, so it does not tell us which temporary to remove next.

The saved source suggests this sequence:

```text
reverse result array → gradient list → scale every value → adjustment list
old coordinates + complete adjustment list → subtract each pair → new coordinates
```

All scaling finishes before subtraction starts. A storage optimization must keep
that order, including observable effects and traps. Input aliases must retain
their values.

## Fixed count-only experiment

- **Compiler:** build from the current Rust source. The verified starting tree is
  `ce8dab3adb4fca4643cd600286233ebf11d884bc`, tested at `6ca3c411` and merged as
  `46af240b`. Tag `roadmap/callback-owner-final-2026-11-03` preserves the tested
  commit. The census changes diagnostic C and measurement tools only.
- **Inputs:** one complete Rosenbrock solve for each coordinates/updates pair:
  3/0, 3/1, 3/199, 3/1999, 33/199 and 129/199. Use both current-only and
  history-retaining programs, native Linux ARM64/AMD64, GCC O1/O2, and explicit
  workspace settings 0/1: 96 observations. Keep the existing complete output and
  arithmetic order. [Workload definition](derivative-owner-transfers.md#what-is-measured).
- **Comparison:** the existing independent allocator/phase counters versus added
  constructor-site counters. Also compare ordinary native output with unoptimized
  interpretation. This is no elapsed-time comparison; do not rerun old noisy
  timing cases or infer speed from instrumented programs.
- **Baseline:** [verified counts](numeric-input-checks-2026-11-03/verified-counts.json.gz)
  from `5af0366c`. The only later change in compiler/runtime/library/test source is the unit-test
  box repair; production code is unchanged. Check that relationship before using
  these counts.
- **Attribution:** give each constructor call an explicit source ID. Forward it
  through existing record/list helpers and protected map finalization. Record
  source line, enclosing function, tag, field count, phase, requests and bytes.
  Reject unsupported references or unresolved callers; do not silently group them
  under an unknown origin. No production API, ownership or allocation changes.
- **Required equality:** constructor totals must exactly equal the independently
  counted `fwp_data` requests and bytes in each phase. Preserve all other managed
  and raw storage counts, full output, derivative work and zero final storage.
  Keep original/generated C, commands, native images, source/image hashes,
  stdout/stderr and all failed or timed-out attempts.

For `d` coordinates and `u` updates, all 96 existing observations match:

| Constructor requests | Current only | History |
|---|---:|---:|
| Outside derivative phases | `d + 3*d*u` | `d + 3*d*u + 2*(u+1)` |
| Forward recording | `(3*d+4)*u + 1` when `u > 0`; otherwise 0 | Same |

Every request in these observations is 24 bytes. These formulas match aggregate
counts and saved C; the census must establish the split between input-index cells,
input record boxes/cells, gradient results, scaling and coordinate updates.

## Controls and selection

Test direct and forwarded constructors, zero-field values, source comments and
strings, duplicate/missing/unknown sites, incorrect phase/byte totals and incomplete
cleanup. A rejected control must fail the audit, not merely print a warning.

After attribution, freeze one bounded storage change and its predicted savings
before editing the compiler. A candidate is the sole-use numeric adjustment list:
map into one numeric buffer, then let zip-with read it after the map completes.
Do not mutate the input list or interleave the two callbacks. Explicitly exclude
shared/escaping results and unsupported value layouts.

Verify ordinary/unoptimized/native behavior, aliases, empty and unequal inputs,
callback order, failures, cancellation and allocation errors. Keep the same-source
runtime reference and the existing 2% copy/regression and 5% large-case speed
limits. Report compiler time/RSS, managed/raw memory, process RSS and code/frame
costs separately. Prior missed goals remain open regardless of the new result.
