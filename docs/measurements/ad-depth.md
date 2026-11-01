# Cost of nested derivatives

**Status:** both native Linux matrices pass and their complete artifacts/logs
are audited at `8e299f9f4b94fbe062b7f891eefb4ce6e4ac792e`. This establishes the
measured cases below; the PR still needs its final nine-job production gate.
This is D3's finite depth/size check, separate from the
[descent optimization](descent-costs.md).

## Equivalent results, different calculations

For N inputs, use `x[i] = i/N - 1/2`, with N = 1, 16 and 128. The function is
`sum(x[i]^4)`. Compare its first, second and third derivatives in F64 and F128:

| Depth | Automatic version | Explicit fwp version |
|---|---|---|
| 1 | `grad loss` | Map `4*x^3` |
| 2 | `grad (grad loss \| sum)` | Map `12*x^2` |
| 3 | `grad (grad (grad loss \| sum) \| sum)` | Map `24*x` |

Here `loss` sums the fourth powers. Summing a gradient before differentiating
again gives a vector of derivatives; this separable function has no mixed terms.
Both versions construct the same input and print the complete output vector.
The explicit version uses handwritten formulas in current fwp, not C or Rust.
Any timing ratio includes AD's recording and reversal work, not just compiler
or call overhead. These cases cannot establish costs for arbitrary functions.

The inputs are exact binary fractions. An independent rational calculation checks
every result. F64's shortest printed decimal is converted back to F64; F128 is
compared as an exact decimal fraction in this domain. AD and explicit-formula
outputs must also match byte for byte in the raw interpreter and native code.
The [accuracy tests](../numerics.md#accuracy-checks) separately cover nonzero finite
differences, F128 low bits, branches and checkpoints.

## What is recorded

Run [measure-ad-depth.py](../../scripts/measure-ad-depth.py) on native Linux ARM64
and AMD64. Compiler paths and architecture, warmups, samples and timeout are
explicit arguments. Use GCC O2, baseline ARMv8-A/x86-64, no fast math, separate
multiply/add rounding, no LTO, stack storage and unique reuse enabled, and tape
workspace reuse disabled. Compile emitted F128 C/C++ companions once with the
production exact-float settings; verify their identities for every program.

For each of the 18 depth/size/format combinations, retain generated source, ordinary
and observed native images, hashes, machine instructions and compiler stack
estimates. Separate ledgers record managed requests, requested bytes, retains and
peak/live charge, and raw tape allocation/release. They exclude allocator metadata
and OS reservations and must not be added to estimate process memory. Both ledgers
must finish at zero; no extra cleanup is inserted to produce that result.
Each AD case must record one completed backward pass per derivative level.
Intermediate checkpoints may retain enclosing tapes; after the last pass only
the reusable registry may remain until shutdown.
Deliberately omitted raw-parent and managed-weight frees must be detected.

Ordinary process timings alternate AD/formula order for two warmups and twelve
samples. They include startup, construction, differentiation, full output and
shutdown. Instrumented runs are excluded. These short timings are diagnostic:
there is no noise qualification or speedup acceptance threshold. Keep every sample,
including slow results. The measured counts and sizes describe these named cases;
they are not a constant-memory promise for nested AD.

## Measured storage and limits

At 128 inputs, both architectures report the same allocation counts and peaks:

| Format / depth | AD requests | Explicit requests | AD managed peak, bytes | AD raw tape peak, bytes |
|---|---:|---:|---:|---:|
| F64 / 1 | 1,302 | 257 | 21,760 | 16,488 |
| F64 / 2 | 4,525 | 257 | 49,632 | 62,672 |
| F64 / 3 | 13,637 | 257 | 121,424 | 233,888 |
| F128 / 1 | 4,246 | 899 | 35,200 | 4,200 |
| F128 / 2 | 13,347 | 899 | 104,640 | 20,688 |
| F128 / 3 | 36,521 | 899 | 346,928 | 82,336 |

A request is a successful managed allocation or reallocation observed during
input construction, differentiation and output. F128 weights use managed
storage, which explains why its raw tape column is smaller. The two peak columns
are independent maxima and must not be added. All ledgers finish at zero.
Explicit formulas avoid recording and higher-order differentiation; this table
quantifies that difference for the named polynomial, not general AD overhead.

For depth 3, AD versus explicit complete-process medians are 2.25/1.14 ms (F64)
and 4.10/1.25 ms (F128) on ARM64; 2.94/1.48 ms and 5.45/1.36 ms on AMD64.
These short observations include startup and printing and are not qualified
speedup comparisons. The raw reports retain all sizes, timings, code bytes and
stack entries. For example, the depth-3 F128 AD image has 257,116 instruction
bytes on ARM64 and 303,042 on AMD64, including linked exact arithmetic support.

[Run 40837334009](https://github.com/e6qu/fun-with-pipes/actions/runs/40837334009)
contains the 18 cases, 74 images, 76 stack reports and both broken-release
controls per architecture. [The artifact index](ad-depth-recording-artifacts-2026-10-29.json)
retains all 4,390 file identities. Original reports and full logs:

| Host | Report | Log |
|---|---|---|
| ARM64 | [JSON](ad-depth-recording-2026-10-29-arm.json.gz) | [Log](ad-depth-recording-2026-10-29-arm.log.gz) |
| AMD64 | [JSON](ad-depth-recording-2026-10-29-amd.json.gz) | [Log](ad-depth-recording-2026-10-29-amd.log.gz) |

The archived environment includes `FWP_REUSE=1`, an unused variable; it did not
control execution. Reuse is enabled by the absence of the C test macro
`FWP_NO_REUSE`. The generated sources and actual build flags were audited to
confirm that macro was absent. The runner now omits the unused variable, rejects
a source definition of the disabling macro, and passes `-UFWP_NO_REUSE` explicitly.
This corrects the stated configuration, not the recorded counts or program behavior.

### Before and after scalar stack recording

The [preceding audited baseline](ad-depth-artifacts-2026-10-29.json) at `89bbec5b`
uses heap argument records. At 128 inputs it has 1,686 / 6,572 / 19,907 managed
requests for F64 depths 1 / 2 / 3. Stack recording removes 384 / 2,047 / 6,270
requests. Both peak ledgers remain unchanged, as do all F128 allocation counts:
those typed recording arguments were deliberately excluded from that proof.
The later [typed-owner batch](typed-derivative-owners.md) has its own checks;
it does not change these historical measurements.

Code does not shrink uniformly. F64 AD instruction bytes change by
-1,408 / +240 / +1,232 on ARM64 and -1,600 / 0 / +672 on AMD64 for the three depths.
The full reports retain every frame entry and image. Neither these counts nor
cross-run short-process timings establish a speedup; the separate paired descent
comparison applies fixed acceptance limits.

An earlier preparation run at b349 failed because the observer missed typed
backward release; outputs and final totals were already correct. The repair
observes the real release after both typed values and raw parents are freed and
requires one checkpoint per derivative level. It adds no runtime cleanup.

The grouped final platform checks pass in
[PR #226](../roadmap-history.md#derivative-allocation-and-accuracy-pr-226), whose
merged tree matches the tested source. This completes D3's stated finite matrix;
it does not extend its precision, memory or speed claims to arbitrary programs.
