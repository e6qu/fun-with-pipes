# Keep numeric bounds through checked multiplication

The compiler must stop on integer overflow. It can also help the C compiler
recognize products whose bounds are known. For example, if `0 <= i < 2000000`,
then `3*i` is nonnegative and below six million. Counting its decimal digits
does not need a minus-sign case or cases for sixteen-digit numbers.

`I64` is a signed 64-bit integer; `ISize` is a signed machine-word integer,
also 64 bits on the supported targets. The candidate preserves their overflow check,
then returns the safe expression `x*y`. Previously it returned the C builtin's
output variable. GCC 13.3 loses useful bounds through that variable in this
program; the expression lets it recover them. Both operands have already been
evaluated, and overflow still traps before the expression is reached:

```c
int64_t x = (int64_t)l1, y = (int64_t)l0, r;
if (__builtin_mul_overflow(x, y, &r)) fwp_trap_overflow("I64");
return (V)(x * y);
```

`V` is the generated runtime's value carrier. `__builtin_mul_overflow` safely
computes the product and reports whether it fits.
The trap terminates execution. Thus the following signed expression cannot
overflow. This is a code-generation change, with no new language syntax.

## What was measured

The program is `bench/text-length`: sum the character counts of `i`, `3*i` and
one separator for two million integers starting at zero, then print `28518516`.
fwp, handwritten C and handwritten Rust all count digits directly with the same
grouped algorithm and ordinary inline hints. They check the relevant arithmetic;
none builds the displayed strings. Negative and extreme products are tested
separately, but their speed is not measured here.

[Run 39536765734](https://github.com/e6qu/fun-with-pipes/actions/runs/39536765734)
passed on Linux AMD64 and ARM64 at source
`b57e2dcda716ebd27007d01aaf5e4e79d22518b6`, retained by
`roadmap/revision-checked-product-b57e2dcd`. Both complete logs were audited.
[The raw report](checked-products-2026-10-21.json) retains every timing sample,
source and binary hash, compiler command, CPU description and memory counter.
The later [PR #183 delivery record](../roadmap-history.md#checked-product-bounds-pr-183)
records passing full-platform acceptance. The focused measurements above remain
tied to their original source and hosts.

GCC 13.3.0 builds C and generated C at O2; Rust 1.99.1 uses `-O`. fwp uses
tracing mode and `-ffp-contract=off`, without link-time optimization. There are
four allowed CPU IDs on each runner, tested separately. These are two virtual
runner sessions, not eight independent machines. AMD64 is an EPYC 7763; ARM64
is Neoverse-N2. Do not compare their absolute times with earlier runs on other
hosts to infer the effect of this change.

Each executable gets two warmups and 54 measured runs per CPU. Execution order
rotates and reverses so each of the nine variants occupies each position equally.
The first eight are the [earlier counting controls](integer-counting.md#what-the-timer-includes).
The ninth changes only the checked product's returned expression. Actual output
from the modified fwp compiler must match this ninth variant's C byte-for-byte,
and its executable must have the same machine instruction section and output.
Those checks pass on both architectures.

Timing includes process startup, computation, printing and shutdown. Elapsed
time includes the Python parent's launch; child CPU time measures the child's
user and system CPU use. Compilation, downloads and instrumentation are outside
timing. No sample is discarded. CPU placement does not control frequency,
virtualization, cache state or address layout.

## Results and remaining cost

These are ranges of four per-CPU elapsed-time medians, in milliseconds. "Before"
already includes grouped counting from PR #182. Ratios compare the two programs
on the same CPU, rather than dividing unrelated endpoints of the ranges.

| Host | Matched C | Matched Rust | fwp before | fwp candidate | Candidate extra time vs C | Vs Rust |
|---|---:|---:|---:|---:|---:|---:|
| AMD64, EPYC 7763 | 4.809–4.869 | 7.562–7.648 | 8.324–12.673 | 7.152–9.168 | +46.9–90.6% | −5.7% to +20.0% |
| ARM64, Neoverse-N2 | 3.176–3.219 | 5.765–5.826 | 7.409–7.449 | 6.127–6.177 | +91.9–92.9% | +5.8–6.3% |

Extra time means `(fwp / peer - 1) * 100%`. Relative to fwp before the change,
elapsed time falls **14.1–27.7% on AMD64** and **17.1–17.3% on ARM64**. Child CPU
time falls **14.6–29.0%** and **17.9–18.3%**, respectively. Remaining extra child
CPU time versus C/Rust is **+52.0–97.5% / −5.6% to +20.9% on AMD64** and
**+101.2–101.6% / +6.2–6.5% on ARM64**.

The AMD64 results vary substantially across CPU IDs: the candidate's child CPU
medians are 8.584, 6.768, 8.699 and 6.739 ms for IDs 0–3. Keep that variation
visible; the experiment does not explain it. The candidate improves against the
same-session fwp control on every CPU, but this is not a universal speedup or
proof of parity with C/Rust.

## Instructions, stack and memory

GCC removes the impossible sign and large-digit cases for the bounded product.
It carries `3*i` as a loop value increased by three, instead of multiplying every
iteration. The sum still has its overflow branch. Both fwp counting loops use
registers without calls or stack traffic. AMD64's former 40-byte normal-entry
frame disappears; ARM64 still has no normal-entry frame. Their overflow paths
reserve 8 and 16 bytes respectively, excluding AMD64's return address.

| Host | Text-section bytes before → candidate | Whole executable before → candidate |
|---|---:|---:|
| AMD64 | 25,586 → 25,522 | 61,776 → 61,776 |
| ARM64 | 23,356 → 23,244 | 83,432 → 83,440 |

Text-section bytes measure the ELF `.text` section, including compiler padding. Whole-file size also includes
metadata and alignment, so a smaller instruction section need not shrink the
file. The matched C loop still replaces more digit divisions with comparisons
and constants. The remaining timing gap has not been assigned to individual
instruction differences.

Ordinary products with runtime operands retain their overflow checks. In both
memory modes at O2/O3, AMD64 uses one product instruction and its overflow flag;
ARM64 computes the low and high product halves and checks sign agreement.
**At O0/O1, GCC emits an extra product for the returned expression on both
architectures.** These levels pass correctness checks, but this candidate does
not promise faster execution at every optimization level. The measured benefit
is for O2, and the saved ordinary binaries expose this tradeoff for review.

Separate instrumented counting executables report zero managed allocations,
requested bytes, retains, collections and peak/final charged storage after
constant initialization. A deliberately inserted 16-byte request is detected.
The counters exclude raw buffers, allocator metadata, stacks and libc. Tracing
code remains in these binaries; this is not evidence of complete GC removal or
of a process-memory improvement.

## Correctness and reproduction

Both Linux jobs pass formatting, Clippy, five integer-output tests and four
scalar-trap tests. The new signed-product test checks 173 operand pairs for each
of I64 and ISize against independent 128-bit expected results. It compares the
unoptimized interpreter with ARC/tracing native code at O0/O1/O2/O3. Successful
products preserve the before/product/after output sequence; overflow preserves
only the earlier output and exits with the language trap.

The actual emitted I64 primitive also runs under C's undefined-behavior sanitizer
at O1/O2/O3. Removing its overflow guard is a deliberate negative control:
maximum I64 times two must produce a signed-overflow diagnostic. Each host
retains fourteen scalar binaries and disassemblies, their sources and control
diagnostics, as well as twelve integer-counting semantic/control binaries.

Download all six artifacts from the linked run into `ARTIFACTS`, then run:

```sh
python3 scripts/local-guard.py python3 scripts/summarize-integer-counting.py \
  --run 39536765734 --source b57e2dcda716ebd27007d01aaf5e4e79d22518b6 \
  --comparison compiled-range --artifacts ARTIFACTS --output REPORT.json
```

The validator checks raw samples, medians, execution order, sources, architecture,
text-section bytes, hashes, memory controls and actual compiler output. It does
not rebuild or rerun Linux binaries locally. Full builds and measurement reruns
belong on GitHub runners via the `integer-counting` focused suite.
