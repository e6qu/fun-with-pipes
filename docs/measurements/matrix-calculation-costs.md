# Matrix calculation: source investigation

## Measured problem

The [current comparison](current-kernel-costs.md#results-november-2-2026) finds a
repeatable calculation-only gap for 257×259 by 259×255 products: current fwp takes
about 65% more time than the matched C peer on AMD64, and 6% more on ARM64.
Both sessions pass their identical-copy controls for this case. The runtime uses
zero effective retains during this workload. The paired-column candidate below
passes focused safety checks and the qualified timing comparisons below. Six
small-AMD64 noise limits remain open; the full production delivery is pending.

## Results: November 2, 2026

[Four sessions and every failed limit](matrix-columns-2026-11-02/README.md) are
retained with raw-report/file hashes and complete logs. Independent audit
`41422907313` at `9f6c8d00` passes. Three wrong-host allocations were rejected
before building or timing; no completed timing was repeated for a better result.

| Qualified comparison | Calculation time versus scalar fwp | Time versus C | Time versus Rust |
|---|---:|---:|---:|
| ARM64, small matrix | 33.5% less | 29.6% less | 6.0% less |
| ARM64, large matrix | 33.0% less | 29.2% less | 9.5–9.7% less |
| AMD64, large matrix | 30.8% less | 13.9–14.0% more | 3.6% less |

Allocation-through-cleanup takes 28.9–31.7% less time on ARM64 and 29.8–29.9%
less for the large AMD64 case. The small ARM64 inclusive result still takes
about 4.1–4.2% more time than Rust; faster calculation does not erase setup costs.

- Both fwp variants make five requests per product: three array payloads and two
  input records constructed by the C driver. C/Rust make three requests.
- The fwp variants request 88 extra bytes per product compared with C/Rust and
  peak 24 bytes above their payload count. Paired versus scalar storage is equal.
- Effective retains and final live workload storage are zero. The generated
  matrix worker's frame grows by 48 bytes: 1,408→1,456 on ARM64 and 1,568→1,616
  on AMD64. The benchmark driver's frame stays at 384/352 bytes respectively.
  These are compiler estimates, not whole-program stack peaks. Code grows by
  128/320 bytes respectively.
- Full process RSS varies independently: large-matrix fwp peaks around 3.46 MiB
  on ARM64 and 3.74–3.81 MiB on AMD64. Do not equate managed counts with total memory.

Small AMD64 timing remains **inconclusive**: identical copies differ by 2.6–8.3%
across six case/scope/control observations, exceeding the unchanged 2% limit.
All correctness, memory and independent raw-data checks pass. Following the
standing preference to retain verified improvements with unmet timing goals
explicit, keep the qualified gains and retain these six failures as open goals.
This is a delivery decision, not a change to the frozen measurement rules or a
claim that the entire experiment passed. Full production CI is still required.

The computation multiplies each left row by each right column. For example,
`[1, 2]` dotted with `[3, 4]` gives `1*3 + 2*4 = 11`. Each output cell must keep
its increasing inner-index order, including the order of multiplication and
addition; rearranging floating-point sums can change their result.

## Source facts and safety boundaries

- `fwp_p_matrix_valid_f64` checks signed dimensions, bounded products and actual
  input lengths. The specialized primitive is compiler-internal. Invalid runtime
  casts retain the original library behavior.
- The calculation allocates a fresh output and protects it with cleanup before
  computation. Inputs remain owned by the caller; they can share backing storage.
- Fixed-size byte copies preserve alignment and C aliasing rules for array data
  and views. Do not substitute `double *` casts without a valid representation proof.
- Only fresh output has a `restrict` promise: it cannot overlap either live input.
  The two input matrices can overlap each other.
- The 32-wide tiles still visit each cell's inner index in increasing order.
  Keep separate multiplication/addition, no contraction or reassociation.
- Task-free programs already omit scheduler polling. Existing `blocked_matrix`
  tests force an expired budget and check this explicitly. For task-using programs,
  preserve polling and failure cleanup before changing loop structure.
- The benchmark's two input records are allocated outside the calculation timer.
  Removing them cannot explain this calculation-only gap. Allocation-inclusive
  input setup uses a C driver, not source-compiled `array.generate`.

## First diagnostic, fixed before implementation

Reuse the existing GCC-report runner with the **current** retained executable
paths. Replace its obsolete old-baseline dispatch; historical reports keep their
recorded source and data. Do not maintain an implicit old-format fallback.

| Input | ARM64 | AMD64 |
|---|---|---|
| Measured source | `b9da15a1a323ae3f5d3ff247e0b6b4c59ab73528` | same |
| Run / session | `41404044761` / 2 | `41405063750` / 2 |
| Full measurement artifact | `13123885145` | `13123941925` |
| Native compiler | GCC 13.3.0 | GCC 15.2.0 |
| C target | `armv8-a` | `x86-64` |

The artifact identities and SHA-256 values are retained in the current report's
[index](current-kernels-2026-11-02/index.json). Verify the downloaded archive,
source and binary hashes before use. Rebuild C/fwp timing programs for all four
existing cases: the two arrays serve as controls, and both matrices are required.

Keep their original O2, C11, contraction, target, reuse and profile settings. Add
only GCC's vectorization explanation and optimized intermediate-code reports.
Require every rebuilt executable to match its measured binary byte for byte.
Run it once to check the exact result hash and live-storage result. Preserve all
printed data, but do not aggregate or accept these diagnostic durations as new
performance samples. No completed timing session is being repeated for a pass.

This diagnostic requires the original compiler version and native architecture,
not the original CPU model: it accepts no timing claim. Record the actual host.
Keep all partial failures, compiler reports, commands, source files and binaries.
Use the reports to locate a source-level difference; neither a compiler remark
nor a disassembly observation establishes a safe or faster transformation.

## Candidate selection and delivery

After this inspection, freeze one bounded source change and its exact reference
before implementation/timing. Use the [plan](../../PLAN.md) for semantic, alias,
cancellation and memory coverage. Any candidate must improve large-matrix AMD64
calculation time by at least 5%, keep every measured case/scope within 2% extra
time, and add no allocations, retains or peak storage. Both architectures and
independent copies are required. Keep a rejected candidate's results; do not ship
speculation as a speed improvement.

Group the justified change, probes, measurements and readable docs into one PR.
PR #243 remains the sole active PR until its complete final-head matrix passes
and it is squash-merged. This preparation does not change that tested head.

## Diagnostic results and first bounded candidate

Run `41412675762` at `f4fd8be4` passes on native ARM64 and AMD64. All eight
original C/fwp binaries reproduce byte for byte on each architecture, with exact
outputs and zero final workload storage. [Archives and full logs](matrix-codegen-2026-11-02/index.json)
retain the sources, commands, binaries and compiler reports; both artifact digests
and all completed logs are audited.

| Compiler | C matrix inner loop | fwp matrix inner loop |
|---|---|---|
| GCC 15.2 / AMD64 | Vectorizes using 16-byte vectors | Does not vectorize the byte-copy loads |
| GCC 13.3 / ARM64 | Does not vectorize: estimated cost is not worthwhile | Does not vectorize: would require a runtime alias check |

These explain compiler decisions, not the whole measured timing gap. The fwp loop
already marks its local output pointer `restrict`, but that does not produce the
same alias result as the C peer's kernel interface in these reports.

First test a small, standard-C expression of the existing read-only input rule:

```c
const unsigned char *restrict a = fwp_array_data(left);
const unsigned char *restrict b = fwp_array_data(right);
```

Keep byte-copy loads/stores, the existing fresh-output qualifier, loop structure,
arithmetic order, polling and cleanup. No typed-pointer cast, intrinsic, wrapper,
extra storage or new source-language rule is selected.

This does **not** prohibit `left` and `right` sharing data: both only read it.
[C11 draft N1570, §6.7.3.1 example 3](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf)
explicitly permits two restricted pointers to alias an unmodified object. fwp's
immutable inputs remain owned during the call, and the fresh output is separate.
Existing identical/sliced-input probes must still pass; add a partially overlapping
pair before accepting a compiler change.

First compile the exact source substitution against the retained programs, using
the same diagnostic settings and original C peers. Keep every result, including
unchanged binaries or missed vectorization. This is still not a timing acceptance
run. If it does not improve the intended compiler decision, record that outcome
before selecting another candidate; do not add qualifiers merely for appearance.

### Restricted local inputs: rejected without timing

Run `41414518831` at `dce1f2b6` passes exact outputs on both architectures, but
every candidate binary is byte-identical to its original. The vectorization
remarks are unchanged too. [Complete evidence](matrix-input-restrict-2026-11-02/index.json)
retains both archives and full logs. Do not add these ineffective qualifiers to
the runtime or spend a new timing session trying to find a speedup.

## Second candidate: two adjacent output columns

Freeze a source-only diagnostic of a two-column inner loop before implementation.
Keep the original input pointer declarations. For each row/inner-index pair:

```text
read x
read y[j], y[j+1], prior[j], prior[j+1]
value[j]   = x*y[j]   + prior[j]
value[j+1] = x*y[j+1] + prior[j+1]
store both values
```

For left row `[2, 3]` and right matrix `[[5, 7], [11, 13]]`, the pair develops as:

```text
start:        [0, 0]
first entry:  [2*5 + 0,  2*7 + 0 ] = [10, 14]
second entry: [3*11 + 10, 3*13 + 14] = [43, 53]
```

Each output keeps its original sum order. Only independent neighboring outputs
are calculated together.

Advance by two only while `je - j >= 2`, then use the original scalar operation
for a remaining odd column. Each cell keeps its increasing inner index and the
same multiplication/addition operands. The two cells are independent: the output
is fresh, inputs are read-only and validated, and canonical F64 arithmetic has no
source-level effects. The existing specialization already interleaves independent
cells; it preserves each cell's reduction order, not a global sequence of all cells.
Arithmetic NaN payload/sign rules remain [implementation dependent](../reference.md#types).

Use ordinary scalar `double` locals and existing fixed-size byte copies. No vector
type, alignment assumption, pointer cast, extra buffer, helper wrapper or runtime
hardware selection is added. The pair exposes independent arithmetic to GCC's
basic-block vectorizer; whether it combines that work must be checked, not assumed.
Bounds keep both accesses inside the tile and validated arrays. Polling, shape
checks, allocation and cleanup remain at their existing points.

Compile the exact substitution with the same original C/array controls first.
Retain all binaries, outputs and compiler remarks. Full compiler/interpreter,
partial-overlap, floating-edge and unwind probes are required before timing a
candidate selected for the runtime. The declared 5%/2% speed/noise rules above
still apply; diagnostic durations do not count toward them.

### Paired-column compiler result

Run `41416927586` at `15e8d0e6` passes both native jobs. Both GCC versions now
vectorize the paired matrix loop with 16-byte vectors; the odd-column remainder
remains scalar. Vectorization combines independent operations: a 16-byte vector
holds two eight-byte F64 values. This is loop vectorization, not the basic-block route originally
hypothesized. All eight outputs agree, and the six C/array controls reproduce
their original binaries. [Archives and full logs](matrix-paired-columns-2026-11-02/index.json)
retain the source, binaries and compiler decisions.

Select this exact paired loop for correctness/cleanup checks, then measurement.
Vectorization alone does not establish a speedup. Keep the old single-column
loop as the same-source comparison; no other runtime/compiler change is allowed
between the two timed implementations.

## Frozen paired-column measurement

This experiment measures the selected loop, not the earlier typed loop-state
optimization. Build one current compiler. Emit each matrix program once, then
construct its reference by replacing exactly the paired loop with the recorded
single-column loop. Require the production runtime to contain the exact candidate
and keep every other generated-source byte identical. Save both sources and hashes.

| Setting | Required value |
|---|---|
| Hosts | Native Linux ARM64 Neoverse-N2 / GCC 13.3 and AMD64 EPYC 7763 / GCC 15.2; four CPUs; exact versions from the current-kernel protocol |
| Programs | 65×67 multiplied by 67×63; 257×259 multiplied by 259×255 |
| Roles | C, Rust, paired fwp, its byte-identical copy, single-column fwp, its byte-identical copy |
| Sessions | Two independent qualified hosts per architecture |
| Work | Eight products per sample, five samples per process; 256 processes per role/round for the small case, four for the large case |
| Rounds | Two retained warmup rounds, then 18 measured rounds |
| Order | Role indices `[0,1,5,2,4,3]`, rotated by `(round + block) % 6`; use every observation |
| Compilation | Generated C and C peer: O2, `-ffp-contract=off`, `armv8-a` / `x86-64`, no LTO; Rust 1.99.1 at O2 and `generic` / `x86-64` |
| Calculation timer | Multiplication/accumulation loops only; excludes allocation, output zeroing, shape checks and cleanup |
| Inclusive timer | C-driver allocation/filling, calculation, output checksum and final release; excludes runtime startup, printing and shutdown |
| Reported time | Median round totals divided by calculations per round; fwp/peer ratios use those same totals |
| Correctness | Exact integer-derived outputs; matching profile samples; zero final live workload storage; deliberate retained-owner control must fail |
| Timing limits | Both identical-copy ratios ≤1.02 in each case/scope/session; paired/reference ≤0.95 for large AMD64 calculation, ≤1.02 everywhere else |
| Memory limits | No increase in requests, requested bytes, effective retains or peak charged storage in any profile sample |

The source compiler uses production Rust O1 with assertions/overflow checks; this
is distinct from the Rust peer's O2. Record complete toolchain, source and binary
identities, raw process output, allocation counts, RSS, executable/text bytes and
GCC static frames. Static frames are not a measured stack high-water mark, and
managed storage is not total process memory. Preserve all host rejections and
failed speed/noise limits; never rerun an unchanged timed experiment for a pass.

Array controls already reproduce byte-identical binaries in both diagnostics.
Do not repeat their timing: this runtime edit changes only the matrix loop. The
two declared matrix sizes cover the small-case overhead and large-case target.
The C driver still constructs fwp inputs; the inclusive ratio does not measure
source-compiled `array.generate`. Input records remain outside calculation time.

### Native safety checks

Run `41417716203` at `a4172afd` passes Linux GCC on both architectures and macOS
ARM64 Clang. [Full logs, sources and probe binaries](matrix-checks-2026-11-02/index.json)
retain four passing tests per host and twelve allocation/arithmetic cases at O1/O2
for both ordinary and blocked implementations. Checks include overlapping views,
NaNs, subnormals, infinities, order-sensitive sums, malformed shapes, traps and
cancellation. Every case returns to its starting live storage; deliberately
omitting the final release or unwind guard fails its intended observer.

The timing workflow requires this successful three-host run and exact equality
of compiler, runtime, library and probe source identities before measurements.
These focused checks do not replace the final nine-job production matrix.
