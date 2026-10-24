# Checked ARC compared with C and Rust

This comparison runs seven small programs compiled from fwp, handwritten C and
handwritten Rust. fwp uses automatic reference counting (ARC): an object is
released when its last owner releases it. It does not run the tracing collector.
This establishes a current measurement baseline, not a compiler speedup.

## Programs and timing

The [program table](../benchmarks.md#what-each-program-actually-does) defines
the exact input and calculation for each example. For instance, `loop` starts
at 100,000,000, repeatedly adds `(i*3)%7` to a sum and decrements `i` to zero.
`text-length` counts the decimal digits of `i` and `3*i`, plus a separator,
for two million inputs. It avoids constructing the text in all three languages.

Each executable has one warmup and six measured fresh-process runs. Execution
order rotates so each language occupies each position twice. Every run must
print the same result. Times include process startup, input construction,
computation, allocation, printing and shutdown. Compilation is measured once
separately. No sample is removed. These are shared GitHub runners; six samples
in one session cannot establish a stable performance budget.

[Run 40075912779](https://github.com/e6qu/fun-with-pipes/actions/runs/40075912779)
passed on native Linux AMD64 and ARM64 at source
`617bb2319760ccade91afea2bb0045c1984abbdf`, retained by
`roadmap/revision-arc-benchmark-617bb2319760`. Both complete logs are audited.
The AMD64 runner reports AMD EPYC 9V45; ARM64 reports Neoverse-N2. Both use
GCC 13.3.0 for C and generated C at O2, and Rust 1.99.1 with `-O`.
fwp explicitly selects `--gc arc` and `FWP_LTO=0`, meaning no link-time
optimization. [All samples, hardware details, hashes and reports](arc-comparison-2026-10-24.json)
remain available.

## Observed results

The median averages the middle two sorted samples. Extra time is
`(fwp / peer - 1) * 100%`: positive means fwp took longer; negative means less.
It is not a separate measurement of the language's overhead.

| Host | Program | C ms | Rust ms | fwp ms | Extra vs C | Extra vs Rust |
|---|---|---:|---:|---:|---:|---:|
| AMD64 | `fib` | 10.102 | 17.842 | 8.699 | -13.9% | -51.2% |
| AMD64 | `loop` | 54.258 | 65.664 | 73.490 | +35.4% | +11.9% |
| AMD64 | `map` | 269.431 | 231.702 | 239.911 | -11.0% | +3.5% |
| AMD64 | `pipeline` | 13.437 | 10.123 | 7.267 | -45.9% | -28.2% |
| AMD64 | `range-set` | 8.730 | 8.783 | 8.762 | +0.4% | -0.2% |
| AMD64 | `strings` | 72.418 | 86.898 | 3.931 | -94.6% | -95.5% |
| AMD64 | `text-length` | 2.450 | 4.147 | 3.748 | +53.0% | -9.6% |
| ARM64 | `fib` | 17.636 | 21.578 | 6.790 | -61.5% | -68.5% |
| ARM64 | `loop` | 90.515 | 86.569 | 130.616 | +44.3% | +50.9% |
| ARM64 | `map` | 493.731 | 449.293 | 449.415 | -9.0% | +0.0% |
| ARM64 | `pipeline` | 26.636 | 19.578 | 15.692 | -41.1% | -19.8% |
| ARM64 | `range-set` | 11.086 | 11.090 | 11.918 | +7.5% | +7.5% |
| ARM64 | `strings` | 141.342 | 147.241 | 6.179 | -95.6% | -95.8% |
| ARM64 | `text-length` | 3.037 | 5.621 | 5.954 | +96.0% | +5.9% |

The integer loop remains slower on both hosts. `text-length` remains slower than
C on both hosts and is slightly slower than Rust on ARM64. Faster `strings`
results chiefly reflect eliminated formatting work: its C/Rust peers still build
text. The pipeline implementations also do different amounts of intermediate
storage work. Maps use the same sorted-pair search structure but different sorts.

Except for `text-length`, the C and optimized Rust peers do not provide fwp's
checked signed-arithmetic guarantees. The measured inputs fit, but the optimizers
have different obligations. These ratios therefore compare the named complete
implementations; they do not isolate ARC, allocation, overflow checks or compiler
quality. No ARC-versus-tracing speedup can be inferred from earlier runs on
other revisions or hosts. The next arithmetic comparison must match those checks
and preserve trap order before choosing a compiler change.

## Binary and storage evidence

Independent inspection covers all **42 actual measured executables**, including
all fourteen fwp programs. Their ELF architecture and executable headers match
the native hosts. Source inputs match the recorded commit; six positive samples
per language/program reproduce the reported medians. Generated C selects ARC,
and all fwp symbol tables exclude tracing scan/mark/sweep functions.

The report records whole-file sizes and instruction-section sizes. Instruction
sections include alignment padding; whole files also include linking/runtime
choices and non-code data. Neither number alone measures memory in use. Four
corrupted-copy controls per host must fail: wrong memory mode, wrong machine
architecture, object file in place of executable, and a missing timing sample.
Review uses disassembly without executing downloaded programs.

This comparison does **not** measure allocation counts, peak live memory, ARC
traffic or stack frames. Those need separately scoped measurements; prior
ownership reports cannot be relabelled as measurements of these binaries.
Compilation times are one observation per program, including tool startup and
linking but excluding the build of the fwp compiler itself.

Use the [explicit reproduction command](../benchmarks.md#running-comparisons)
and retain the native artifacts. Focused verification is not the nine-job
production acceptance required for the next PR.
