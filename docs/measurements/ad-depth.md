# Cost of nested derivatives

**Status:** the runner is prepared; no complete measurement is accepted yet.
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
Deliberately omitted raw-parent and managed-weight frees must be detected.

Ordinary process timings alternate AD/formula order for two warmups and twelve
samples. They include startup, construction, differentiation, full output and
shutdown. Instrumented runs are excluded. These short timings are diagnostic:
there is no noise qualification or speedup acceptance threshold. Keep every sample,
including slow results. The measured counts and sizes describe these named cases;
they are not a constant-memory promise for nested AD.
