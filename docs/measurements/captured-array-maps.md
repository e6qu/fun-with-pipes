# Reuse array storage with scalar callback captures

Status: the initial implementation passes focused native verification. Its first
measurements expose a shared-empty-input regression; an empty-owner transfer
repair passes expanded native checks and all four measurement audits. No qualified
regression remains; noisy controls leave combined timing acceptance open. Final platform
delivery remains pending. The first native run found that the selector
missed let-bound callbacks. The repair indexes actual partial applications and their bindings. This extends
the existing same-type numeric `array.map` proof; it does not close #270's
unresolved AMD64 timing limits or change its original results.

The [initial four-session report](captured-map-initial-2026-11-08/README.md)
retains all gains, regressions, inconclusive controls and memory/compiler costs.
The [repaired measurements](captured-map-repaired-2026-11-08/README.md) use
the same protocol below without replacing the initial observations.

## Programs and the cost to remove

A callback can use numbers supplied when the program runs:

```fwp
calibrate : F64 -> F64 -> Array[F64] -> Array[F64]
calibrate = fn scale -> fn offset -> fn readings ->
    readings | array.map (fn value -> value * scale + offset)

brighten : U8 -> Array[U8] -> Array[U8]
brighten = fn offset -> fn pixels -> pixels | array.map (add offset)
```

`calibrate 2.0 1.0` turns `array[1.0, 3.0]` into `array[3.0, 7.0]`.
`brighten 3u8` turns `array[10u8, 20u8]` into `array[13u8, 23u8]`.
Both return immutable values. An alias must still see the original input.

Before this extension, the consuming-map proof required a callback with no saved arguments.
These callbacks save `scale`/`offset`, so they miss the proof even though those
numbers own no heap data. The extension passes them directly to the existing
private worker and consumes the array only at its last use. An exclusive ordinary
array supplies its output storage; nonempty shared arrays and all views need
independent output. An empty ordinary array can return its existing owner without
writing, even when shared. Empty views still release their backing storage rather
than keeping a potentially large array alive. This does not permit a neighboring-coordinate update to overwrite inputs
that later coordinates still need.

## Selection and safety

- A known callback has exactly one unapplied argument. Captures, input and result
  are supported plain scalars; input/result types match. F16, BF16, F128, 128-bit
  integers, references and unknown callbacks remain outside this proof.
- Captures evaluate once, left to right, before the array argument. The partial
  internal call cannot execute its callback body yet. Preserve computed captures,
  effects, first traps and resource boundaries; add no syntax or conversion.
- Liveness proves the array has no later use. ARC still protects earlier owners
  and shared ancestors. Keep necessary runtime uniqueness and view checks.
- The empty ordinary-array path performs no writes, element-callback calls, allocation or
  ownership-count changes. It transfers the input owner to the result even with
  reuse disabled. Views retain the existing independent-output and cleanup path.
- Preserve element order, checked overflow, float bits and callback effects.
  Existing protected owners cover allocation failure, traps and cancellation.
  Every physical allocation must be released exactly once.
- Index known callback bindings once, then use the existing reverse liveness
  walk and rewrite. Save captures at their original binding, including computed
  values; remove the closure only when no other use needs it. Each traversal
  visits existing expressions once. Selection checks and rewriting do work per
  capture per selected map; a shared callback therefore adds `maps × captures`
  scalar arguments. There is no whole-program search.

## Verification before delivery

Use existing targets rather than adding a native shard:

| Check | Required evidence |
|---|---|
| Selection and order | IR tests for zero/one/multiple and computed captures, last uses, excluded types and partial-call arity; ownership validation after rewriting |
| Values and effects | Raw/optimized interpretation and native output; empty/singleton inputs, narrow overflow, computed capture order, aliases and slices |
| Cleanup and reuse | Actual allocation/free observer; allocation failure, callback trap/cancellation, reuse disabled and deliberately broken cleanup controls |
| Production compilers | Native ARM64/AMD64 GCC and macOS Clang; packing on/off, C O1/O2; formatting and lint |
| Delivery | Nine final-head production jobs, docs and complete log/artifact audit; report compiler scaling with runtime results |

The first two focused runs found implementation and test gaps before timing:

| Run/source | Finding and repair |
|---|---|
| [42468684378](https://github.com/e6qu/fun-with-pipes/actions/runs/42468684378), `b41752cac` | All three hosts missed captured selection: production binds partial `Apply` expressions to locals. Replaced the inline-only selector with binding indexing and snapshots at the original evaluation point. |
| [42470453910](https://github.com/e6qu/fun-with-pipes/actions/runs/42470453910), `0c704421f` | All 13 ownership units and six native targets pass per host; captured export selection now works. Two test assumptions fail: main may optimize away its map, and the missing-input owner is caught at alias-count status 248 before the leak check. Select exported runtime-argument functions explicitly; keep separate ordinary-main checks and require the exact observed negative-control status. |

Every native target result and all three complete logs were reviewed for each
run. No timing was collected from either failed run.

[Run 42471671589](https://github.com/e6qu/fun-with-pipes/actions/runs/42471671589),
test repair `46ac4cf38`, passes on ARM64 GCC, AMD64 GCC and macOS ARM64 Clang:
13 ownership units, eight native targets (47 tests) and nine bounded analysis
observations per host. This includes O1/O2 cleanup, cancellation and the repaired
deliberate-failure controls. Complete logs contain no compiler warnings or errors;
the documentation audit also passes. The compiler is unchanged from `0c704421f`.

The [complete focused audit](captured-map-checks-2026-11-08/README.md) also passes,
including native image identities and every retained target/probe result.

The empty-owner repair's first run,
[42475715012](https://github.com/e6qu/fun-with-pipes/actions/runs/42475715012),
passes 13 units and seven native targets per host. The remaining target still
requires distinct empty arrays inside returned records. Update its exact identity
and allocation counts, including temporary inputs and the related float identity
control; preserve all alias/free checks. The compiler is unchanged from `ca837567a`.

[Expanded run 42477156079](https://github.com/e6qu/fun-with-pipes/actions/runs/42477156079),
`4da901187`, passes on all three hosts: 57 native tests in ten targets and 14
ownership/identity units per host, plus docs. Full logs have no compiler warnings
or errors. The empty-owner path is natively checked and measured under the
unchanged protocol below; full platform delivery remains pending.
The [complete expanded audit](captured-map-empty-checks-2026-11-08/README.md)
passes, including the separate identity/float logs and 444 probe outcomes per host.

## Measurement contract before collecting results

Compare a same-source reference disabling only captured callback selection;
keep no-capture optimization in both. No previous fwp build dependency.

- Applications: F64 sensor calibration and U8 pixel adjustment above, with
  runtime coefficients. Sizes: 0/16/65,537/262,145; exclusive input, retained
  alias and interior slice. Check every result and preserved input.
- Run one update and 199 updates. Construct input outside the work timer; work
  includes callbacks and consumed/intermediate cleanup. Time final release
  separately; retain whole-process observations.
- Aim for 10% less computation on both large exclusive-input applications, in
  two sessions per native architecture. Qualified controls must not regress over
  2%; identical-copy variation over 2% is inconclusive. Freeze host/toolchain,
  repeat counts and rotated schedule before running.
- Count requests, bytes, retains and peak/final live storage separately. Unique
  mapping should need no output allocation; aliases/views must preserve data.
  Counts do not prove speed. Record ordinary RSS, code/stack and compiler costs.
- Do not pool CPU models, rerun unchanged failed timings for a pass, or relax
  original limits. Preserve every miss and distinguish reductions from acceptance.

### Fixed measurement settings

| Setting | Value |
|---|---|
| Programs | Sensor `value * scale + offset`, with F64 scale 1 and offset 0.25; pixels use the same expression with U8 scale 1 and offset 1. Coefficients enter through opaque runtime arguments. |
| Inputs | Element `i` starts at `i % 17`; 199 pixel updates therefore stay at or below 215. Sensor outputs are exact multiples of 0.25. |
| Cases | 2 programs × 4 lengths × 2 update counts × 3 ownership cases = 48 |
| Repetitions per process | 256 for lengths 0/16; 8 for large one-update cases; 1 for large 199-update cases |
| Process schedule | Candidate, reference and an identical copy of each; 2 warmup rounds, then 24 measured rounds. Rotate the first role each round. |
| Hosts | Native Linux Neoverse-N2 ARM64; native AMD64 EPYC 7763, 9V74 or 9V45. Four assigned processors; record the actual model and affinity. Keep sessions/models separate. |
| Toolchain | GCC 13.3 on ARM64, GCC 15.2 on AMD64, Rust 1.99.1; exact versions checked by the workflow before building |
| Generated C | O2, strict floating point, no contraction or LTO, generic ARMv8-A/x86-64 target; retain stack-usage files |
| fwp switches | Stack, array fusion, packing, value returns and frame fields enabled; LTO disabled |

Construction includes input filling and alias/view creation. Computation includes
all updates and intermediate releases. Final release is timed separately.
The [driver cleanup repair](captured-map-driver-repair-2026-11-08/README.md)
documents correct release of a shared empty result and the failed run it fixes.
Result/alias checks sit outside those three timers; they remain inside loop and
whole-process elapsed time. Whole-process time therefore includes the checker
and is **not** an end-to-end application speed claim.

Only session 1 adds memory instrumentation and compiler resource measurements,
after every ordinary timing finishes. Report requests/bytes/actual retains,
managed peak/final storage, ordinary process RSS, binary bytes, per-function C
stack estimates, and fwp/C compiler time and RSS. Managed storage excludes compiler
memory and system/library allocations. A stack estimate is not total call-stack
use. Sizes change runtime input, not compiler source size.

Compiler analysis also checks 1/8/128 map calls with 0/2/8 captures. It must share
one private worker and visit no more than `(15 + 3 * captures) * maps + 5` IR nodes.
A shared two-capture binding used by 1/8/128 maps also keeps one snapshot/worker
and at most `12 * maps + 20` visits. The counter measures tree visits, not total
compiler instructions or emitted argument copies. Separate compiler time/RSS
observations do not establish general compiler scaling.

The [measurement script](../../scripts/measure-captured-maps.py) saves all commands,
source, raw observations and failures. [The audit](../../scripts/audit-captured-maps.py)
reconstructs every comparison, checks native image identity and the isolated
reference, and rejects missing samples or changed commands. Qualified speed
misses remain reported results, not auditor failures.

[PLAN.md](../../PLAN.md) owns the roadmap. [Ownership](../ownership.md) explains
immutable values and reuse; [benchmarks](../benchmarks.md) defines measurement
boundaries. The [fresh-output report](fresh-array-costs-2026-11-08/README.md)
remains the source for PR #270's gains and unresolved limits.
