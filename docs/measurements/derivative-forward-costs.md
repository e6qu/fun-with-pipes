# Where derivative work allocates and changes owners

Preparation protocol, before new observer code. Baseline: verified PR #238,
merge `c124d0c8f13373b0ee11c58d685d850b1b9a5a08`. Its
[recording results](derivative-recording-moves.md) remove argument records and
transfer typed weights; they do not explain the remaining ordinary F64 costs.

## Question and workload

Which part of a complete gradient-descent solve requests storage or changes
reference counts? The old [phase timings](descent-costs.md) put most time in
forward work, but that includes arithmetic, temporary values and recording.
A count report can identify work to investigate. It cannot prove a speedup.

Reuse `measure-ad-application.py`'s current/history programs and analytic oracle.
Each adjacent pair contributes `100 * (y - x*x)^2 + (1 - x)^2`. An update subtracts
`0.001 * gradient` from each coordinate. Inputs alternate -1.2 and 1.0.
The current form keeps the latest vector; history retains every vector before
selecting the last. Both print the same complete final vector.

| Coordinates | Updates per solve |
|---:|---:|
| 3 | 0 |
| 3 | 1 |
| 3 | 199 |
| 3 | 1,999 |
| 33 | 199 |
| 129 | 199 |

Run one complete solve per observation, both forms, GCC O1/O2 on native Linux
ARM64/AMD64, with workspace reuse explicitly off/on. Set the compiler path, C
compiler, architecture baseline, optimization, source ID, output path and child
deadline explicitly. Use no LTO, fast math or floating-point contraction.
Builds and native observations run on GitHub; local observer checks use the guard.

## What the counters mean

Reuse the existing whole-program observer, source-site ownership observer and
six derivative boundaries. Add an outside-phase bucket so no work disappears:

```text
input construction
  → [setup → forward + recording → reverse setup → reverse traversal
     → result array → retirement]
  → result-list conversion and coordinate update → next gradient
  → final formatting and cleanup
```

The bracketed sequence occurs once per gradient. Everything else belongs to
outside-phase work. Zero updates must have six zero phase totals, while input
construction and output may still allocate. Nested/typed tapes and incomplete
phase sequences must be rejected by this scalar-F64 observer.

- Count managed allocation requests and requested bytes, with source locations
  for calls to the allocator helpers. A runtime helper's location is not the
  original language caller or a complete call stack; label that distinction.
- Count ownership operations at their existing generated-C source sites. Keep
  attempted calls, effective count changes and last-owner outcomes separate.
- Report peak/final managed charge and raw tape/workspace storage separately.
  Charge is not RSS. Peaks are maxima, never additive phase totals.
- Reuse the existing accounting window: after constant initialization through
  the pre-teardown observation point. Record source/C/image hashes, compiler
  identity, architecture, flags, stdout/stderr and all rejected observations.

For example, 129 coordinates and 199 updates produce 199 phase sequences and
25,671 input visits. The current objective records eight operations per adjacent
pair, so expect `8 * 128 * 199 = 203,776` nodes. This counts recording work; it
does not attribute every forward allocation to those nodes.

## Required controls

1. Build ordinary, totals-only and phase/site-instrumented images separately.
   Instrumented stdout must match the ordinary image byte for byte. Compare every
   result with raw interpretation and the analytic oracle at absolute/relative
   tolerance 1e-10; reject nonfinite values and incorrect output lengths.
2. Totals-only and detailed observers must agree on requests, bytes, effective
   retains, peak/final charge and raw-storage counters for each input and mode.
   Every additive phase/site subtotal must sum to its corresponding whole total.
3. Require the expected update/input/node counts, complete phase sequences and
   zero final managed/raw charge. Workspace caches may remain between gradients;
   physical raw storage must be zero after shutdown, with reuse both off and on.
4. Reject missing, duplicate or unknown site/phase rows, impossible count fields,
   omitted allocations/retains, wrong phase assignment and unfinished sequences.
   Use known-work native controls as well as report mutations. An unchanged
   control caused by a missing source hook must fail preparation.

Publish all six cases and all modes, not just the largest saving. Explain the
largest costs with their source locations and examples. Select any compiler or
runtime candidate from those observations, then publish its specific semantic,
count, memory and timing requirements before implementing it in this batch.
Do not weaken D2/N1/N2 limits, infer C/Rust parity, or infer Swift ARC counts.
The full final-head production matrix and documentation still gate delivery.

## Running and reading this measurement

The `derivative-forward-costs` suite in the numerical evidence workflow runs both
native Linux hosts. Each host records 24 program/optimization combinations, each
with workspace reuse off and on: 48 complete-solve observations per host.
`scripts/measure-derivative-forward-costs.py` saves the ordinary, totals-only and
detailed C/images, their outputs, source-site tables, compile commands and hashes.

The detailed report separates:

- `phases`: whole-phase requests, bytes, peaks and ownership operations;
- `allocations`: individual allocator sites within each phase;
- `ownership`: individual ownership-call sites within each phase;
- `raw`: tape buffers and cached workspace, outside the managed allocator.

`allocation-base.c` and `ownership-base.c` are the exact inputs to the respective
source rewrites. Site line numbers refer to those files. They do not refer to the
final instrumented file, whose inserted counters shift line numbers.

After downloading both job archives, `scripts/summarize-derivative-forward-costs.py`
requires explicit `--arm64`, `--amd64`, `--source`, `--run` and `--output` arguments.
It checks every archived file's hash, recomputes all observations from saved
stderr, checks output against the analytic result, and adds C caller names to
active sites. The output is a compressed JSON record. No saved binary is executed
during this audit. A successful measurement job alone does not replace this audit.
