# Remaining temporary list storage

**Status:** historical census and selection contract for the scalar map-to-zip change.
Protocol anchor: `roadmap/temporary-list-protocol-2026-11-03`.
[Delivery history](../roadmap-history.md) records the subsequent implementation
and verification. [PLAN.md](../../PLAN.md) owns current work.

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
  The diagnostic table accepts one tag/field shape per source site and phase;
  it rejects a mixed shape explicitly. This restriction concerns the observer,
  not the language. Counters use static storage and add no heap allocations.
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

`constructor-census` in the numerical evidence workflow runs the experiment.
Each native host first checks that production sources match the verified #249
tree. It builds the current compiler, runs GCC O1/O2 controls, and compares
ordinary, existing-counter and constructor-counter executions. A separate audit
reconstructs the instrumented C and site tables from saved ordinary C, checks
every archived hash and native image, and recomputes all phase totals.

The [verified census](temporary-list-census-2026-11-03/README.md) attributes the
adjustment list to its map and matches `d*u` cells in all 96 observations. The
following contract is frozen before compiler edits; anchor
`roadmap/scalar-map-zip-protocol-2026-11-03`.

## Selected storage change

Keep the sole-use scalar map in one private numeric buffer. Then zip-with reads
that buffer directly and builds its ordinary output list:

```text
Before: gradient list → complete scaled list → zip-with old coordinates → new list
After:  gradient list → complete numeric buffer → same zip-with → new list
```

- Select a direct map with a known single-argument callback. Its input and result
  must be machine integers through 64 bits, F32 or F64. No child owners are stored.
- Prove one consumer, including any straight-line local aliases. Every alias
  must have one use; update their types together. The consumer must be a direct
  zip-with with a known two-argument callback, scalar inputs and scalar output.
  Support either input slot while preserving data-last argument order.
- Exclude shared/escaping map results, captures, unknown callbacks, records,
  boxed wide values, resources and unproved control flow. Other programs retain
  their ordinary representation. If both zip inputs qualify, select only one.
- Keep the map, intervening effects and zip argument expressions in their
  original positions. Finish **every** map callback before starting zip, even
  when the other list is shorter or empty. Preserve checked arithmetic and traps.
- Borrow the source list while filling one protected `Array[I64]` of numeric
  bits. Zip borrows the buffer and other list, uses one protected output scratch
  area, then constructs its result. Do not mutate either source collection.
- Keep the existing callback scheduling checks. Release the buffer, scratch and
  partial output on return, traps, cancellation and allocation failure. Changed
  allocation points do not authorize leaked owners or hidden retries.
- Collect uses once and follow disjoint alias chains; avoid repeatedly scanning
  unrelated function tails. Check scaling with deterministic visit counts and
  measure compiler time/RSS against the same-source reference.

### Predicted savings and comparison

For one solve with `d` coordinates and `u` updates:

| Cost removed | Amount |
|---|---:|
| Adjustment list cells | `d*u` allocations, `24*d*u` requested bytes |
| Zip's copy of that input into scratch | `u` allocations, `8*(d+1)*u` bytes |
| Total | `(d+1)*u` allocations, `(32*d+8)*u` bytes |

The map's old scratch allocation becomes the numeric buffer. At 129/199, expect
25,870 fewer requests and 823,064 fewer requested bytes. Zero-update counts must
stay unchanged; output, derivative work and final live storage must match.
Measure peak managed storage, raw buffers, RSS, instructions and frames separately.

The reference will disable only this new selection in the same Rust source.
Use one `scalar_map_zip::lower(&mut numeric_program)` call after packed-record
lowering and before numeric-parameter lowering; the reference bypasses that call.
Keep packed-record map/fold and numeric-input transformations enabled in both
builds; builds must not depend on an older fwp compiler. Publish and verify that
source rewrite before measurements.

### Required controls

- Both zip input slots; each supported scalar kind; empty and unequal lists.
- Shared source lists; shared/escaping map results and unsupported callbacks.
- Printed callback order, intervening effects, subtraction argument order, and
  a map trap beyond the shorter zip input. These must match unoptimized execution.
- Partial map, partial zip and result-construction failures, cancellation,
  allocation failures, physical frees and deliberately omitted destruction.
- Ordinary/unoptimized interpretation and native GCC/Clang O1/O2; all saved
  count cases, workspace settings and the grouped final platform gates.

Keep the same-source runtime reference and the existing 2% copy/regression and 5% large-case speed
limits. Report compiler time/RSS, managed/raw memory, process RSS and code/frame
costs separately. Prior missed goals remain open regardless of the new result.

### Execution of the frozen comparison

Use `scalar-map-zip-checks` first. Both native jobs must pass, and their compiler,
runtime, library and test sources must match the measured sources.

| Measurement | Fixed execution |
|---|---|
| Compiler cost (`scalar-map-zip-analysis`) | Five programs: field transfers, autodiff tutorial, and generated 3/0, 33/199, 129/199 solves. Four executable copies (two candidate, two reference), two warmups each, then ten balanced rounds: 240 commands per architecture. Measure the whole C-emission command and GNU time peak RSS. |
| Program cost (`scalar-map-zip-time`) | Two independent sessions on native Neoverse N2 ARM64 and EPYC 7763 AMD64. Reuse the complete derivative driver and its qualified GCC/Rust toolchains. Run all six inputs, both current-only and history forms, two warmups and 98 timed samples. |
| Instrumented work | Preserve separate allocator/phase runs, ordinary output, native images, source hashes, commands and diagnostics. Instrumented execution does not establish elapsed speed. |
| Independent audit (`scalar-map-zip-report`) | Download each complete or failed session, verify archive hashes, reconstruct the exact reference patch and recalculate all acceptance results from retained observations. |

Runtime batches use 32,768, 512, 32, 4, 32 and 8 solves per process for the six
inputs in the order listed above. Each timed sample sums seven process runs per
implementation; each process performs the stated number of solves.
Phase timing uses two warmups and 12 samples. Seed `20261029` fixes process order;
no host or session is selected implicitly. Reject unqualified hosts before
measurement; preserve every completed timing outcome.

The compiler limit remains 5% for elapsed time and peak RSS, with at most 2%
identical-copy variation. Program timings keep 2% identical-copy variation,
at most 2% slowdown for zero/one update, and at least 5% improvement for 199 or
more updates. Require the exact allocation savings above and unchanged retains;
managed peak must not grow, final storage must be zero, and raw derivative work
must match. Report code size without a size cap; the largest static frame may
grow by at most 128 bytes. These limits are unchanged from the selected contract.
