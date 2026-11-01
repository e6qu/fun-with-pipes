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
requires explicit `--arm64`, `--amd64`, `--source`, `--run`, `--output` and
`--comparison` arguments.
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
- For each timing session, reuse `check-array-list-evidence.py` with explicit
  `--protocol record-zip --input-format zip --input MEASUREMENTS.zip --reference
  REFERENCE.zip`, plus the tested source, architecture, session and output-summary
  arguments. It checks saved process observations, outputs, ownership profiles,
  image/stack sizes and the exact reference-source patch without extracting or
  running the binaries. Failed acceptance limits remain in its summary.
- Use `record-zip-report` with explicit `evidence_run` and full `source_revision`
  to perform the large download, audit and compression on GitHub. It verifies
  artifact digests, retains rejected hosts and failed timing limits, and uploads
  both the full evidence and compact reports/logs. Audit errors preserve partial
  evidence and fail the job. No archived executable is run by this audit.
- `summarize-derivative-forward-costs.py --comparison record-zip --baseline
  docs/measurements/derivative-forward-costs-2026-11-01.json.gz` audits the two
  downloaded count archives. Supply their paths, tested source, run ID and output
  path through its required arguments. It recalculates saved observations and
  count limits, checks instruction/stack growth, and writes failures before
  rejecting them. `--comparison baseline` audits the original measurement alone.

### Verified allocation and ownership results

[Run 41324329567](https://github.com/e6qu/fun-with-pipes/actions/runs/41324329567)
passes on `b094fdd8c1aedde2957d0109a127b0a66efbdc0f`. Both native Linux jobs pass
the affected tests, GCC O1/O2 measurement controls and all six workloads. Complete
logs contain no compiler warnings or failed tests. The
[audited candidate report](derivative-record-zip-counts-2026-11-01.json.gz)
rechecks archive hashes, native image headers, outputs, phase/site counts,
allocation/retain limits and code/stack costs. All 96 observations match between
architectures.

Whole-solve counts, keeping only the current vector. Each arrow is baseline →
candidate; final managed charge is zero in every row.

| Coordinates, updates | Allocation requests | Requested bytes | Effective retains | Peak managed bytes |
|---|---:|---:|---:|---:|
| 3, 0 | 4 → 4 | 98 → 98 | 0 → 0 | 128 → 128 |
| 3, 1 | 48 → 43 | 1,232 → 1,112 | 19 → 13 | 480 → 448 |
| 3, 199 | 8,562 → 7,567 | 211,905 → 188,025 | 3,781 → 2,587 | 512 → 480 |
| 3, 1,999 | 85,962 → 75,967 | 2,127,100 → 1,887,220 | 37,981 → 25,987 | 512 → 480 |
| 33, 199 | 74,262 → 61,327 | 2,219,198 → 1,860,998 | 45,571 → 26,467 | 6,560 → 5,568 |
| 129, 199 | 284,502 → 233,359 | 8,642,558 → 7,214,534 | 179,299 → 102,883 | 25,952 → 21,888 |

The one-update case saves five allocations and six retains, all in forward
calculation and recording. Its 16 allocations outside the derivative and one
result-array allocation are unchanged. The largest case saves 51,143 requests,
1,428,024 requested bytes and 76,416 retains. Count savings explain which work
disappeared; they do not determine the fraction of elapsed time it occupied.

These counts agree at GCC O1/O2 with workspace reuse both off and on. Keeping
the full vector history produces the same request/byte/retain reductions; its
peak charge falls from 845,088 to 841,024 bytes. Managed charge excludes raw tape
buffers, allocator metadata and stacks; it is not total process memory. Raw
tape/workspace observations and zero-update counts are unchanged.

The separate record-pair probes cover 28 length/alias combinations per image.
Both architectures pass at O1/O2; all retained input fields survive, results are
correct, and live storage returns to its starting value. All omitted-result-cleanup
images exit 238 as required. Callback failure, partial-result failure and
cancellation checks also pass. Saved C and native images were inspected.

Ordinary instruction sections shrink by 848–2,496 bytes on ARM64 and
896–2,864 bytes on AMD64. The largest static frame is unchanged in every program;
this is not a measurement of total call-stack use.

### Audited timings: unmet limits, retention approved

Unlike the one-solve count observations above, timing repeats the solver and
full output within each process. The fwp wrapper captures its immutable starting
list once with `const`; it does not rebuild that list for every solve. Both fwp
candidate/reference programs share this rule. C/Rust repeat their workload
bodies, which initialize their inputs; their compilers may optimize that work.
See the [repeat protocol](descent-costs.md#repeating-solves-within-one-process).
These complete-process ratios do not isolate arithmetic or equalize allocation.

[Run 41325932590](https://github.com/e6qu/fun-with-pipes/actions/runs/41325932590)
completed on `a4cef01b`, whose compiler is unchanged from the count run.
[Audit 41329444021](https://github.com/e6qu/fun-with-pipes/actions/runs/41329444021)
passes: all saved process observations, outputs, profiles, image/stack sizes,
source hashes and exact reference patches agree with the reports. Failed limits
remain failures in the [retained index](derivative-record-zip-2026-11-01/original/index.json.gz).

Each cell below gives **current-vector / full-history** candidate/reference
elapsed-time ratios. Smaller is faster; bold values miss the frozen maximum.

| Coordinates, updates | ARM64 / 1 | ARM64 / 2 | AMD64 / 1 | AMD64 / 2 | Maximum |
|---|---:|---:|---:|---:|---:|
| 3, 0 | 0.9993 / 1.0037 | 1.0006 / 1.0033 | **1.0254** / 1.0057 | **1.0272** / 0.9994 | 1.02 |
| 3, 1 | **0.9901 / 0.9916** | **0.9912 / 0.9942** | **0.9964 / 0.9988** | **0.9930 / 0.9890** | 0.95 |
| 3, 199 | 0.9237 / 0.9215 | 0.9200 / 0.9216 | 0.9373 / 0.9192 | 0.9464 / 0.9253 | 0.95 |
| 3, 1,999 | 0.9149 / 0.9159 | 0.9159 / 0.9158 | 0.9326 / 0.9140 | 0.9210 / 0.9236 | 0.95 |
| 33, 199 | 0.8627 / 0.8615 | 0.8624 / 0.8617 | 0.8682 / 0.8664 | 0.8703 / 0.8624 | 0.95 |
| 129, 199 | 0.8508 / 0.8443 | 0.8510 / 0.8447 | 0.8527 / 0.8489 | 0.8530 / 0.8458 | 0.95 |

For example, 0.996431 means about 0.36% less elapsed time, below the required
5% improvement. The AMD64 zero-update ratios mean 2.54% and 2.72% more elapsed
time, exceeding the allowed 2%. The identical-copy, count, memory, code and stack
limits pass in all four sessions. Cases with 199 or 1,999 updates record
5.4–15.6% less elapsed time. This does not establish all-case acceptance.

The one-update diagnostic repeats 512 complete solves per process. In the
reference, the six derivative phases together occupy about 6.35–6.96% of elapsed
time; forward calculation/recording occupies only 4.41–4.93%. These ranges are
medians of each diagnostic sample's phase time divided by its process time,
across both forms and all four sessions. The optimization removes only part of
forward work. This evidence suggests the 5% whole-process target was too
aggressive for this selected change; it does not authorize weakening that target.

The clocks perturb execution: diagnostic/ordinary elapsed ratios range from
0.938 to 1.042 across these one-update observations. Phase shares are therefore
diagnostic evidence, not exact bounds on uninstrumented speed. They also do not
attribute all outside-phase time to printing. The zero-update regression remains
unexplained. Its candidate and reference C/image hashes differ even though their
allocation counts agree; code size alone does not explain the time difference.
Each zero-update binary and its C source are byte-identical between the two AMD64
sessions. A changed build does not explain the repeated regression.

Source review of those exact zero-update C files finds the same executed path:
the outer iterator keeps the input list alive; each callback retains it, passes
counter zero to the loop, receives the list immediately, prints it and releases
the temporary owners. The derivative-update branch is not taken. The emitted
loop-step body is identical in both versions; other functions and generated
names differ. This establishes neither identical optimized machine code nor the
cause of the slowdown. The GCC investigation below checks the optimized program
without changing the measured source or attributing the result to code layout.

The `record-zip-codegen` diagnostic audits AMD64 session 2's saved evidence, then
rebuilds its four zero-update programs with the original GCC version, source
paths and flags. It adds only
[GCC report options](https://gcc.gnu.org/onlinedocs/gcc/Developer-Options.html):
`-fopt-info-inline-all` explains inlining decisions, and `-fdump-tree-optimized`
shows GCC's optimized intermediate program. Each new executable must match the
measured executable's SHA-256 before execution; output must match its saved
hash and all 32,768 lines. Reports, build commands and outputs remain artifacts.
This is a compilation diagnostic, not a new timing session or an acceptance
exception. A difference is a hypothesis to test, not proof of timing causality.

[Diagnostic run 41337215456](https://github.com/e6qu/fun-with-pipes/actions/runs/41337215456)
passes on source `14f60e11`, job `124939474741`. All four executable and output
hashes reproduce exactly. The runner was an Intel Xeon 8370C with GCC 15.2;
it reproduces the saved AMD64 programs, not their EPYC timing conditions.

- GCC removes the initially stopped derivative loop from both current-only
  entry functions, `f0`.
- Their 619-line optimized function sections match after consistently renaming
  GCC's `D.<number>` temporary identifiers and mapping `fwp_drop9` to
  `fwp_drop10`. Those two generated string-cleanup functions have identical
  C bodies. No other entry-body difference is removed by this comparison.
- The history form's optimized thread entry differs, including cleanup
  inlining. It did not exceed the zero-update timing limit. Do not generalize
  the current-only comparison to every helper or to identical machine code.
- The current-only slowdown remains unexplained. The report establishes no
  source-level extra work in that entry body and justifies no speculative
  allocator or compiler change. All original failed timing limits remain open.

The [complete diagnostic archive](derivative-record-zip-2026-11-01/zero-codegen.zip)
contains all 26 files: compiler reports, commands, output and identities.
Its [GitHub metadata](derivative-record-zip-2026-11-01/zero-codegen-download.json)
records artifact `13097820491` and the verified archive digest; the
[full job log](derivative-record-zip-2026-11-01/zero-codegen.log.gz) retains the
input audit and rebuild results. Each report/output hash was checked against
the archive manifest and the previously audited AMD64 session.

Full reports and complete measurement logs are retained together:
[ARM64 / 1](derivative-record-zip-2026-11-01/original/aarch64-1.json.gz),
[ARM64 / 2](derivative-record-zip-2026-11-01/original/aarch64-2.json.gz),
[AMD64 / 1](derivative-record-zip-2026-11-01/original/x86_64-1.json.gz),
[AMD64 / 2](derivative-record-zip-2026-11-01/amd64-2/x86_64-2.json.gz).
The index identifies every original file hash, job and artifact. The downloaded
summary's API digest and each decompressed report/log hash were also verified.

For AMD64 session 2, the original job `124905745487` and replacement
run `41327509981` received an EPYC 9V45; run `41328989036` received an EPYC 9V74.
All three stopped before building because the frozen host is an EPYC 7763.
Run `41330973213` completed that session on qualified EPYC 7763/GCC 15.2 at
`215db5de`; measured source/tool files remain unchanged. Its independent
[audit](https://github.com/e6qu/fun-with-pipes/actions/runs/41336025525) passes and
retains all three failed limits in the
[session index](derivative-record-zip-2026-11-01/amd64-2/index.json.gz).
These replacements did not rerun completed timings.

Rejected hosts remain evidence, not timing results. Audit `41328986141` passes
for the first replacement, including its artifact digest and skipped build/timing
steps. Audit `41330970147` also passes for the second replacement. Their retained
indexes preserve [attempt 2](derivative-record-zip-2026-11-01/rejected-2/index.json.gz)
and [attempt 3](derivative-record-zip-2026-11-01/rejected-3/index.json.gz); the
original rejected attempt is in the main index above. The
immutable tag `roadmap/derivative-record-zip-sources-2026-11-01`
retains source commits through `844ff77f` and their preparation ancestors.
Tag `roadmap/derivative-record-zip-audits-2026-11-01` retains the later audit code
and replacement-session sources through `215db5de`.
Tag `roadmap/derivative-record-zip-codegen-2026-11-01` retains the GCC diagnostic
source `14f60e11`.

The candidate does not meet its frozen timing requirements. On November 1,
after the four timing sessions and GCC investigation, the user explicitly chose
"Retain reductions; leave timing goals open." This approves delivery of the
verified reductions while preserving all ten failed limits, including both
AMD64 zero-update regressions. It does not turn the saved `not-accepted` timing
reports into passes. D2 remains open. The final nine production jobs and
documentation must pass before merge.
