# Where derivative work allocates and changes owners

The protocol below was published before observer code. Baseline: verified PR #238,
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

## Verified baseline and selected change

[Run 41319946864](https://github.com/e6qu/fun-with-pipes/actions/runs/41319946864)
passes on source `afc0f78f9a68881f6c1db3c08be6276a320f7803`. Both complete job logs
were audited, without compiler warnings or failed tests. The
[audited report](derivative-forward-costs-2026-11-01.json.gz) covers all 96
observations, file hashes, source sites, native images and deliberate failures.
All detailed counts agree between architectures: Neoverse-N2/GCC 13.3 and
EPYC 7763/GCC 15.2. This establishes counts, not new timings.

For 129 coordinates and 199 updates, retaining only the current vector:

| Phase | Managed requests | Requested bytes | Effective retains |
|---|---:|---:|---:|
| Outside the derivative | 77,740 | 2,475,126 | 199 |
| Forward calculation and recording | 206,563 | 5,960,472 | 179,100 |
| Result array | 199 | 206,960 | 0 |
| Other four phases | 0 | 0 | 0 |
| Whole solve | 284,502 | 8,642,558 | 179,299 |

Peak managed charge is 25,952 bytes; final managed and raw storage are zero.
History has the same forward costs but retains previous vectors: its peak is
845,088 bytes. Raw tape buffers are recorded separately in the report. A zero
managed allocation count in reverse traversal does not mean it does no work.

The forward ownership sites identify a specific intermediate:

```fwp
values | zip (drop 1 values) | map pair-calculation
```

For each adjacent pair, `zip` builds a pair and a list node. `map` then reads
that pair and builds its own result list. For this input that means 25,472
temporary pairs and 25,472 temporary list nodes. The recorded `zip` retains
both `Rev[F64]` elements; the map entry retains the pair and extracts owned
elements again. These counts identify temporary collection ownership, not a
retain inside the tape append operation.

**Selected candidate:** extend the existing `map_zip` transformation in
`src/fuse.rs` from immediate numeric elements to flat records whose fields are
all those same immediate numeric types. `Rev[F64] = {value: F64, vertex: I64}`
fits. Use the existing `zip-with` construction and cleanup. Do not add a public
primitive, syntax, runtime switch or general nested-record/cycle analysis.

The source lists stay live throughout the call, the shorter list still determines
the result length, and the callback still runs once per pair in the same order.
Flat numeric records have no resource fields whose close timing could change.
Reject strings, functions, channels/files, nested aggregates and boxed wide
numbers at this selection boundary. Existing numeric selection remains intact.

### Candidate acceptance, frozen before compiler edits

- Compare raw interpretation, optimized interpretation and native GCC/Clang
  O1/O2. Cover named records, tuples, mixed scalar/record inputs, empty/unequal
  lists, captures, retained aliases, callbacks returning inputs, effects and
  traps. Verify excluded types stay excluded. Keep existing derivative precision,
  nested-tape, failure/cancellation and physical-release checks.
- A focused record-pair fixture must remove the temporary pair/list allocations,
  preserve both input aliases and release every completed/partial result. Its
  omitted-result-cleanup control must fail. Inspect generated C and native images;
  do not infer the representation from a timing result.
- Repeat all six count workloads and modes against the archived baseline. For
  `p = (coordinates - 1) * updates`, remove at least `2*p` managed requests,
  `48*p` requested bytes and `3*p` effective retains from each nonzero solve.
  Peak managed charge must not grow; final charge stays zero. The zero-update
  observations and raw tape/workspace counters must be unchanged. Preserve
  derivative node counts and numerical operation order.
- Use a reference compiler built from the candidate source with only the new
  flat-record eligibility disabled. Retain its exact patch and source hashes.
  Disabling all zip/map fusion would also remove existing numeric optimizations
  and would not isolate this change.
- Reuse the paired derivative timing protocol: two sessions each on the qualified
  Neoverse-N2/GCC 13.3 and EPYC 7763/GCC 15.2 hosts; all six cases, current/history
  forms, 98 rounds, seven fresh processes and the existing per-case solve counts.
  Include the byte-identical candidate copy and C/Rust context programs. Require
  copy variation at most 2%, candidate/reference at most 0.95 with updates and
  1.02 without updates. Retain every failure or inconclusive result. These are
  this candidate's timing requirements; earlier D2 failures remain historical
  failures and are not erased by a new comparison.
- Retain ordinary image sizes and every static frame. Limit instruction-section
  growth to 1,024 bytes and largest static-frame growth to 128 bytes per program.
  These are supporting cost limits, not a substitute for speed and live memory.
- Complete the full nine-job production matrix and documentation on the final
  head before merging. A focused measurement pass is not that delivery gate.

### Running the candidate checks

- `record-zip-checks` in the numerical workflow runs the affected compiler tests
  and all six count workloads on native Linux ARM64/AMD64 with GCC O1/O2.
  The archived baseline above supplies the count limits. Each job preserves
  generated C, executables, logs, stack reports and all observations.
- `record-zip-time`, with `native_runner=all` and `comparison_session=both`,
  runs the four timing sessions. `prepare-record-zip-reference.py` replaces only
  the new flat-record eligibility test; it verifies that no other tracked source
  changes. The reference retains scalar zip/map fusion, which already removes
  allocation during derivative-input construction.
- `summarize-derivative-forward-costs.py --comparison record-zip --baseline
  docs/measurements/derivative-forward-costs-2026-11-01.json.gz` audits the two
  downloaded count archives. Supply their paths, tested source, run ID and output
  path through its required arguments. It recalculates saved observations and
  count limits, checks instruction/stack growth, and writes failures before
  rejecting them. `--comparison baseline` audits the original measurement alone.

No candidate result is accepted yet. The implementation and measurement controls
are ready; native correctness, count savings, paired timings and final production
gates remain to be verified.
