# Remove an immediately consumed numeric array

**Production verification is complete in PR #232; timing acceptance stays open.**
The first full matrix found a stale one-allocation expectation in the existing
functional-call test: its known array pipeline now requests zero allocations.
Both input sizes still return the expected sum and restore live storage.
The exact zero-cost expectation and its [explanation](../functional-costs.md#generated-array-removal)
are updated, and the repaired full matrix passes. The
[delivery record](../roadmap-history.md#generated-array-elimination-pr-232)
identifies the tested source, complete log audits and verified squash merge.
The [current buffer results](buffer-current.md)
retain all four sessions, including their failed timing controls. This work
targets a remaining allocation, without claiming that the measurements already
establish a stable speed comparison.

## Program and opportunity

```fwp
sum-generated = flip array.generate id | array.fold add 0
```

`array.generate` calls its function with each index from zero through length
minus one. `id` returns that index. `flip` lets this definition bind `id` before
the pipe supplies the length. `array.fold add 0` adds the elements from left to
right, starting at zero. Thus `sum-generated 4` returns `6`.

The reference native code allocates and fills the array, then reads it in a second
loop. When nobody else uses that array, one loop could generate each number and
immediately add it. Stored arrays still need the direct fold delivered in #231;
this transformation concerns only a producer consumed at this call site.

## Required proof

- The generator, intervening numeric maps and fold callback are known, pure and
  terminating. Reuse the compiler's existing memoized behavior analysis; reject
  unknown calls, recursion, effects and distinguishable reordered failures.
- Elements, accumulator and captures are inline numbers. Exclude F128, resources,
  shared containers and captures needing ownership changes from this first step.
- Preserve argument evaluation: initial value, producer count and callback
  captures keep their original order. Evaluate each once. Preserve the order of
  checked additions; do not replace the sum with a closed-form formula.
- Negative lengths remain empty. The same target-dependent oversized-array
  boundary must fail before any generator call, even though storage disappears.
  A zero length still evaluates its arguments but invokes neither callback.
- Only the immediately consumed result disappears. Arrays reused elsewhere,
  unknown callbacks and rejected proofs keep their existing implementation.

The implementation extends `src/fuse.rs` and its existing loop lowering.
An internal checked-count operation shares the real constructor's count rule;
removing storage does not remove size validation.

## Acceptance declared before implementation

Use the same scan entry and lengths 0, 16, 4,096 and 262,144. The frozen reference
is `377cf9ce25c65afba595b6413e5bb1d50721ea7a`, the verified #231 head.
Its compiler/runtime match the measured `3ca66b54`; only
wait tests, workflow ordering and documentation changed. If a compiler repair changes the reference, declare
that source before candidate runs. Do not change the C/Rust programs, arithmetic,
production flags or sample counts.

| Requirement | Passing evidence |
|---|---|
| Values and failures | Raw interpreter, optimized interpreter and native O1/O2 agree on output, exit status and first failure |
| Storage | The selected entry makes zero managed allocation requests and zero count updates, with zero peak/final payload and no retained count slot |
| Mechanism | Generated C and actual binaries contain the fused loop; disabling the transformation restores the materialized array and its observed allocation |
| Cleanup | Failure and cancellation preserve outer owners; a deliberately omitted cleanup must fail the check |
| Code and stack | At most 5% instruction-byte growth against the reference; no larger reported frame component or new dynamic-frame requirement |
| Compiler cost | Both existing G2 analysis-budget hosts pass without raising limits |
| Production | All nine native production jobs and documentation pass on the final head |

Test empty and negative counts, the first oversized count, initial/count/capture
evaluation order, distinct generator/fold traps, effectful and unknown callbacks,
numeric element/accumulator differences and a reused input. Exercise both array
packing settings and enable/disable controls. Add these cases to existing native
targets, then check shard coverage; avoid running the full matrix per edit.

Timing uses the existing paired scalar-scan protocol: two sessions per native
architecture, byte-identical copy variation at most 2%, and at least 10% less
elapsed time in every qualified session. A failed control or speed budget keeps
timing acceptance open; retain every observation and do not retry an unchanged
experiment. Verified allocation removal and timing acceptance are separate
results. Neither establishes parity with C/Rust or a bound on total stack usage.

## Reference files and observers

The paired comparison reuses the ordinary, uninstrumented programs from run
`41122911946`, session one on both hosts, built at `3ca66b543bb8764527fe2a5142119831df15cfb7`.
That source and the declared `377cf9ce` reference have identical compiler,
runtime, library, vendor, build and buffer-program inputs. Their differences
repair wait-test cleanup and change workflow ordering/documentation. The retained
program records keep the actual build source; they are not relabeled as `377cf9ce`.
`scan-comparison.py --experiment generated-array` verifies the frozen image hashes:

| Host | Reference executable SHA-256 |
|---|---|
| ARM64 | `ca6ade423f576bf02549fe760a76e38eb7dfe517c5aa0381fbd0a071d6e77377` |
| AMD64 | `cde3a363d93b0558eb027f99836c5fe6bdc597ee1bfba70430f08ffe6b1cffd6` |

The original dispatch experiment remains separately verifiable with
`--experiment scalar-dispatch`; its source and hashes are unchanged. These are
separate declared comparisons, not interchangeable reference choices.

Storage checks require an explicit `--scan-storage materialized` or `elided`.
For an elided scan, inserting an allocation that is immediately freed must fail
the zero-allocation check. There is no removed array owner whose release could
be omitted. The generated-loop native test instead checks failure and cancellation
with an outer registered owner and a surviving alias; removing either unwind
cleanup must fail. Numeric-only captures remain the admission rule.

Phase diagnostics report `computationNs` for the fused scan, because generation
and reduction now share one loop. They do not invent construction or release
intervals. Process-memory snapshots use `before-work` and `after-work`; these
are not a measure of peak memory inside the loop. C/Rust peers and the other fwp
entries retain their real construction/release boundaries. All such observers
run in separate diagnostic binaries and are excluded from ordinary timing.

## Verified costs and remaining gates

At `899ad012c19a9f49abce941070cdbfef610725d5`, the five focused native targets
pass thirteen tests on each Linux architecture. Both packing settings and O1/O2
verify negative/empty counts, rounding order, narrow-integer overflow, argument
order, size limits and preserved materialization for rejected proofs. Failure
and cancellation after two completed loop steps preserve an outer string alias;
deliberately omitting either cleanup is detected.

The [check index](generated-array-checks-2026-10-31.json) records artifacts,
hashes, allocation cases, native images, cleanup controls and compiler budgets.
Independent observers at `048c92c5` use the same compiler implementation; later
changes repair the test's loop selection and extend its cases. All eight scan
observations per host (four lengths at O1/O2) have zero managed requests,
count calls, count storage and peak/final payload.

An inserted allocate/free pair
is rejected even though it leaks nothing.
Review also tightened the diagnostic checker: equal nonzero starting, peak and
final count storage must fail, not just unequal values. A correlated-error test
now covers that case. Retained observations pass the stronger rule; no timed
program or measurement was changed.

| Cost | ARM64 reference → candidate | AMD64 reference → candidate |
|---|---|---|
| Managed requests, three 4,096-element scans | 3 → 0 | 3 → 0 |
| Requested payload bytes | 98,328 → 0 | 98,328 → 0 |
| Peak live payload bytes | 32,776 → 0 | 32,776 → 0 |
| Instruction bytes (`.text`) | 10,588 → 10,924 (+3.17%) | 11,090 → 11,426 (+3.03%) |
| Largest reported frame component | 368 → 368 bytes | 320 → 320 bytes |

Code grows within the 5% limit; no new dynamic frame requirement appears.
The existing AMD64 reporting frame remains dynamic but bounded. Frame reports
do not establish a bound on the whole call stack.

Both G2 compiler-analysis hosts pass: Linux AMD64 and Intel macOS each pass
224 unit tests, all-target lint and 6,912 recorded proof timings. G2 measures
ownership analysis with ordinary optimization disabled; it does not isolate
the compile-time cost of this fusion transformation.

The full production matrix passes. The [timing index](generated-array-timings-2026-10-31.json)
records all four completed sessions. Each was independently reconstructed on
CI and from its retained archive locally. Each
session times 256 scans per process, including process startup, output and
cleanup, with 2,736 complete process records. Ratios below compare candidate
fwp with the frozen previous fwp, not C/Rust. A ratio below one means less time.

| Host/session | Old identical-copy ratio | New identical-copy ratio | Candidate/reference time | Timing acceptance |
|---|---|---|---|---|
| ARM64 / 1 | 1.00852 | 1.02054 | 0.36231 | Inconclusive |
| ARM64 / 2 | 1.00679 | 1.02164 | 0.39265 | Inconclusive |
| AMD64 / 1 | 1.01947 | 1.01927 | 0.66473 | Passes this session |
| AMD64 / 2 | 1.02917 | 1.02258 | 0.66828 | Inconclusive |

Three rows exceed the 1.02 identical-copy limit in at least one family. The
experiment therefore does not qualify for timing acceptance. No collected
session was retried. Wrong CPU models are rejected before build/timing and their
qualification artifacts remain retained; replacing them collects no second
measurement of an already observed session.
