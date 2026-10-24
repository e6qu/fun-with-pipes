# Hashing values without constructing their encoded bytes

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

**Work:** build integers `0..N-1` in an array, hash `(iteration, array)` repeatedly,
and XOR the results. Small: 16 integers × 4,096 hashes. Large: 4,096 integers ×
1,024 hashes. The changing iteration prevents reuse of one hash. All implementations
encode identical little-endian I64 fields and lengths and use FNV-1a, a
noncryptographic XOR/multiply fingerprint with arithmetic modulo 2^64.

**Comparison:** [fwp tracing, ARC, buffered-hash ARC, C and Rust](structural-hash-2026-10-16.json).
C/Rust know this schema directly; fwp uses runtime type descriptions. Streaming
feeds encoded bytes into the hash without allocating the complete byte buffer.
The interpreter's buffered path independently checks output.

**Method for this hash series:** optimization level 2, one warmup, ten rotating
whole-process samples unless a repeat states otherwise. Times include startup,
input construction, hashing and printing. Reports retain elapsed and child CPU
time, hardware, compiler flags and source/binary hashes. Compilation, allocation
profiles and process peak memory are separate. These initial ARC CPU ratios use
references measured alongside fwp:

| Host | Small / C | Small / Rust | Large / C | Large / Rust | Small / buffered fwp | Large / buffered fwp |
|---|---:|---:|---:|---:|---:|---:|
| Linux AMD64 | 1.670 | 1.542 | 1.044 | 1.044 | 0.318 | 0.165 |
| Linux ARM64 | 1.824 | 1.660 | 1.033 | 1.029 | 0.350 | 0.160 |
| macOS ARM64 | 1.435 | 1.236 | 1.016 | 1.012 | 0.553 | 0.285 |
| macOS AMD64 | 1.475 | 1.328 | 1.018 | 1.012 | 0.374 | 0.079 |

Streaming removes 12,288/11,264 hash-buffer growth requests for small/large work,
and 256/65,536 peak temporary bytes. The original surrounding fwp programs still
make 12,309/7,173 managed requests and 12,288/3,072 retains. C/Rust count one
application array allocation, excluding startup/printing internals; fwp counters
can include output values, so their allocation scopes differ.

[Binary evidence](structural-hash-code-2026-10-16.json) confirms a
recursive hash visitor with no encoder/allocator call in its inspected body.
All measured owned storage releases. The following reports address surrounding
pipeline costs; this initial table does not describe the final compiler.

### Keeping captured computations outside a fused hash loop

**Change:** keep the captured array outside the known callback loop, then combine
mapping and XOR reduction without interleaving observable traps or effects.
The [post-fusion report](hash-pipelines-2026-10-16.json) uses the
same hash inputs and method above. Counts match on four hosts in tracing and ARC:

| Workload | Managed requests, before → after | Retains, before → after | Peak charged bytes, before → after |
|---|---:|---:|---:|
| Small array | 12,309 → 4,114 | 12,288 → 4,096 | 295,112 → 656 |
| Large array | 7,173 → 5,122 | 3,072 → 1,024 | 163,848 → 163,848 |

Final charged storage is zero. At this revision each hash still allocates a tuple
and retains its array; range input still builds a list. ARC CPU overhead versus
C in this run is 22–48% for small inputs and roughly −0.2% to +3.3% for large
inputs. These are simultaneous C comparisons, not a before/after speedup measured
across different runners. The paired repeat below isolates the revision change.

### Repeating both hash pipeline revisions together

**Comparison:** verified pre/post-fusion fwp binaries with C/Rust beside them,
using the same hash workloads. The [paired report](hash-pipeline-cpu-2026-10-16.json)
uses twelve balanced whole-process samples, forward/reverse order, and separate
profiles that reproduce original counts. Ratios below mean after/before:

| Host | Small ARC CPU / elapsed | Large ARC CPU / elapsed | Large tracing CPU / elapsed |
|---|---:|---:|---:|
| Linux AMD64 | 0.902 / 1.077 | 0.995 / 0.998 | 0.996 / 0.996 |
| Linux ARM64 | 0.759 / 0.788 | 1.002 / 1.002 | 0.998 / 0.999 |
| macOS ARM64 | 0.807 / 0.838 | 0.995 / 1.002 | 1.019 / 1.021 |
| macOS AMD64 | 0.811 / 0.895 | 0.999 / 0.999 | 1.028 / 1.023 |

Small ARC CPU time falls everywhere, but Linux AMD64 elapsed time rises from
2.325 to 2.505 ms. Large traced macOS medians also rise, with overlapping samples.
In this repeat, large Intel macOS ARC takes 1.327 times C and 1.404 times Rust,
a larger gap than the first report. Neither run establishes portable parity.

### Intermediate stack placement experiment

The [partial experiment](hash-stack-intermediate-2026-10-16.json)
puts nonescaping hash tuples on the stack. Only Linux/macOS ARM64 completed;
the other queued jobs were cancelled when the combined experiment replaced it.
It reduces small/large managed requests from 4,114/5,122 to 18/4,098; array retains
remain 4,096/1,024. This is not four-host acceptance.

The subsequent [direct-range report](hash-range-arrays-2026-10-16.json)
constructs input arrays without range lists. All four hosts then report two
requests: the array and printed result. Small/large requested bytes are
165/32,805; peak charged bytes are 144/32,776; final charge is zero. Retains are
unchanged. Both reports use the hash workloads/method above, including slower
large macOS samples; measurements from separate runs do not isolate a speedup.

### Borrowing temporary fields without counting them

**Comparison:** post-fusion fwp versus stack tuples, direct range arrays and
borrowed fields. A borrow uses the array while its existing owner keeps it alive;
the temporary tuple needs no additional owner. The [four-host report](hash-borrowed-fields-2026-10-16.json)
uses the same hash programs and timing method above:

| Workload | Managed requests, post-fusion → current | Retains, post-fusion → current | Peak charged bytes, post-fusion → current |
|---|---:|---:|---:|
| Small array | 4,114 → 2 | 4,096 → 0 | 656 → 144 |
| Large array | 5,122 → 2 | 1,024 → 0 | 163,848 → 32,776 |

Two allocations hold input and output; final charge is zero. The inspected ARM64
loop keeps the array pointer, iteration and accumulator in registers across the
hash visitor call and has no allocation or retain/release call. The recursive
visitor still has its own stack and type-description work.

In this run small ARC CPU overhead versus C is 19–34%; large macOS gaps reach
10% on ARM64 and 22% on AMD64. The next paired runs compare old/new binaries on
the same machines, rather than attribute different-run times to the compiler.

### Repeating the allocation and borrowing changes together

**Comparison:** verified post-fusion baseline versus the combined borrowing
change, beside C/Rust. [Two paired runs](hash-borrowed-cpu-2026-10-16.json)
use twelve balanced rotating whole-process samples each and separate profiles.
All current profiles reproduce two requests, zero retains and zero final charge.
Small Linux and Intel macOS CPU medians fall in both repeats; large-input changes
are generally small. First-run macOS ARC slowdowns reverse in the repeat, with
overlapping ranges. Large Intel macOS tracing is 6.5% slower in the second run.

These are the second run's current ARC CPU ratios against C/Rust:

| Host | Small / C | Small / Rust | Large / C | Large / Rust |
|---|---:|---:|---:|---:|
| Linux AMD64 | 1.381 | 1.178 | 1.020 | 1.015 |
| Linux ARM64 | 1.373 | 1.237 | 1.028 | 1.024 |
| macOS ARM64 | 1.144 | 0.979 | 1.043 | 1.050 |
| macOS AMD64 | 1.216 | 1.097 | 1.059 | 1.022 |

For example, small Linux ARM64 work still takes 37.3% more CPU than C, despite
removing the targeted allocations and retains. Startup, input construction,
printing and generic hash traversal remain in the measured interval.

### Numeric hash specialization

Hashing turns a value's encoded bytes into a 64-bit fingerprint. The compiler
can emit a loop for known numeric types instead of asking a general runtime
visitor for each element's type. This preserves the bytes and hash result;
`FWP_TYPED_HASH=1/0` selects specialized/general traversal for comparison.

The repaired [initial report](numeric-hashing-2026-10-20.json) and
[repeat](numeric-hashing-repeat-2026-10-20.json) measure source
`0bb385ab`, including the C aliasing repair and direct integer output. The
[older initial](numeric-hashing-2026-10-19.json) and
[older repeat](numeric-hashing-repeat-2026-10-19.json) preserve the
pre-repair samples. Those earlier Clang results did not expose the GCC defect
and are not acceptance evidence for the repaired compiler.

Each program builds one I64 collection containing `0..N-1`, repeatedly hashes
`(iteration, collection)` and combines results with XOR. The iteration prefix
changes each hash. All versions encode the same eight-byte integers and unsigned
LEB128 length (a variable-length integer encoding).

| Case | Elements | Hashes per process |
|---|---:|---:|
| Small array | 16 | 4,096 |
| Large array | 4,096 | 1,024 |
| Ordered set | 65,536 | 64 |

C/Rust store the same ordered keys in an array/vector; no version sorts them.
The initial run compares specialized tracing/ARC, general ARC, C/Rust, and a
separate general-ARC control that constructs an encoded byte buffer. That slower
buffered control does not stand in for general traversal. All fwp variants
explicitly enable array/collection fusion and direct integer output.

One warmup precedes twelve balanced rotating/reversed samples. The repeat reuses
the exact saved specialized ARC, general ARC and C/Rust executables: two warmups,
then 24 balanced samples, 1,152 timed executions in total. Both include startup,
input construction, hashing and output. Compilation and instrumented allocation
profiles are separate. Child CPU is processor time charged to the program; wall
time also includes waiting for the host. Raw reports retain both, with compiler
versions/commands, hardware, RSS, profiles and binary hashes. Builds use O2 and
C `-ffp-contract=off`.

Each cell below is **initial / repeated child-CPU median**, specialized ARC divided
by general ARC. For example, 0.968 means 3.2% less CPU. This compares fwp with fwp.

| Host and processor | Small array | Large array | Set |
|---|---:|---:|---:|
| Linux AMD64, Xeon 8573C / EPYC 9V74 | 0.863 / 0.996 | 0.998 / 0.994 | 0.991 / 1.001 |
| Linux ARM64, Neoverse N2 | 0.954 / 0.925 | 0.968 / 0.968 | 0.987 / 0.986 |
| macOS ARM64, virtual Apple M1 | 0.895 / 0.983 | 0.987 / 0.964 | 0.940 / 0.987 |
| macOS AMD64, Core i7-8700B | 0.946 / 0.948 | 0.968 / 0.853 | 0.994 / 0.926 |

Linux AMD64 changed processor between runs; within each run every variant uses
the same host. Do not compare absolute times across those processors. Repeated
Linux ARM64 large-array/set results are faster in all 24 pairs with separated
ranges. Other ranges overlap. AMD64 sets are 0.11% slower in the repeat, with
12 of 24 pairs faster: 37.776–38.376 ms versus 37.806–38.211 ms. That result is
inconclusive. Initial ARM macOS small-case wall time is 3.8% higher despite a
lower CPU median; its repeated wall median is 3.0% lower. Keep both observations.

Remaining **repeated CPU overhead against C / Rust** is:

| Host | Small array | Large array | Set |
|---|---:|---:|---:|
| Linux AMD64 | +28.1% / +13.5% | +1.7% / +1.3% | +1.5% / +1.2% |
| Linux ARM64 | +32.1% / +18.3% | +0.7% / +0.5% | +0.8% / +0.5% |
| macOS ARM64 | +15.8% / −1.5% | +2.3% / +1.7% | +0.7% / −1.1% |
| macOS AMD64 | +17.5% / −0.8% | +2.8% / +1.5% | +3.6% / −1.0% |

Negative overhead means a lower observed fwp median; overlapping samples do not
establish superiority or parity. These are costs of these programs on these
runners, not an overhead percentage for the language. The separate million-key
[PR #173 production baseline](range-set-peers-2026-10-19.md) and
[final PR #174 results](numeric-output-peers-2026-10-20.md)
use GCC and tracing, with different workloads. Their percentages cannot be
subtracted from this table. Both retain all six production benchmark programs.

The final PR #174 report uses AMD EPYC 7763, GCC 13.3 and Rust 1.99.1. It times
whole processes, including startup, input construction and output, with one
warmup and six rotating samples per implementation. Median fwp extra time against
C / Rust is +38.3% / +3.9% for the arithmetic loop, −11.9% / +8.5% for the map,
−41.7% / +13.1% for the pipeline, +5.9% / +7.1% for the range set, and
+15.7% / +16.5% for strings. Work and arithmetic guarantees differ as explained
in that report; these are observations, not isolated costs of the language.
The [pre-repair report](numeric-hash-pre-repair-peers-2026-10-19.md)
remains historical evidence. Its loop/map timing ranges overlap the final run;
the pipeline median returned from 26.089 ms to 17.258 ms. Keep the raw samples
when assessing changes rather than selecting one favorable median.

Specialized and general ARC profiles now match at **one managed allocation**,
zero retains and zero charge after cleanup. Small/large/set programs request
136 / 32,776 / 524,296 bytes and peak at 144 / 32,776 / 524,296 bytes. This is
the input buffer; direct integer printing removes the earlier second request.
C/Rust count one application buffer of 128 / 32,768 / 524,288 bytes. fwp's extra
eight requested bytes store length; charged storage can include rounding.
Counters exclude allocator metadata and libc output storage. Hash bodies add
no allocation or retain/release operation; deliberate added operations must fail
the corresponding tests. This does not establish zero whole-process heap use.

The collector inspects 96 correctness binaries and 48 measured fwp binaries.
Specialized ARC executable code sections are 1,432–1,952 bytes smaller than
general ARC. The inspected Linux ARM64 set loop has no calls or stack accesses;
AMD64 saves one register around the function, outside the element loop. The
caller still builds a stack tuple and calls once per hash. Eight dependent
FNV-1a byte steps per key remain; removing type dispatch cannot remove them.

The [output report](integer-output-2026-10-20.json) inspects another
144 binaries from the same 456-test native run. For its small print-then-trap
example, ARC/O2 code sections shrink by 3,536–3,712 bytes across the six hosts.
ARM macOS reserves 112 bytes for the whole main-thread frame, including startup;
the formatter's 24-byte buffer is not a whole-frame or whole-program bound.
ARC binaries exclude tracing functions, but runtime initialization remains.

To reproduce, run `hash` and `hash-costs` at one source revision. After they pass,
`hash-report` takes their `evidence_run` / `costs_run` IDs and `source_revision`.
It checks complete tests, saved-file hashes, sample balance, medians and actual
binary sections/tracing symbols. `integer-output-report` uses the same test run
and inspects the direct/ordinary output binaries. `hash-specialization-repeat`
uses the completed cost run as `evidence_run` and the same source revision.
Inspect saved assembly before claiming that a loop avoids calls or stack spills.

Acceptance requires identical canonical results, no allocation/count traffic
inside hashing, and unchanged ARC profiles versus general traversal. Target
lower time on the large array and set without a reproducible small-case
regression. Overlapping results require investigation; retain slower samples,
C/Rust gaps and code-size costs. A passing collector does not replace full
production acceptance.
