# Count characters without building integer text

`show | string.length` asks for the length of an integer's decimal display.
For `-17`, the result is `3`: a sign and two digits. Native lowering now counts
those characters without creating a temporary String. Concatenations of integer
displays and literal text qualify too; shared strings keep their storage.
The [design](../design.md#measuring-integer-text-without-building-it) explains
the bounds, supported types and preservation of effects and traps.

## What was compared

Source `37de5ba40970f7729bf735b347527f5628117dc0`, preserved by
`roadmap/revision-scalar-text-37de5ba4`, passes
[run 39446896772](https://github.com/e6qu/fun-with-pipes/actions/runs/39446896772)
on native Linux AMD64 and ARM64. GCC 13.3.0 builds fwp/C at optimization level O2;
fwp selects tracing GC and disables link-time optimization (LTO). Rust 1.99.1
uses `-O`. The CPUs are AMD EPYC 9V45 and
Neoverse-N2, respectively. This is one runner session per architecture.

Both text benchmarks execute the same fwp calculation:

```fwp
line : I64 -> I64
line = fork concat show (mul 3 | show) | concat "#" | string.length

main = range 0 2000000 | map line | sum | echo
```

`fork concat` applies both functions to the same input and concatenates their
results. Thus `line` combines the decimal displays of `i` and `3*i`, adds `#`,
and returns the character count. `main` sums those counts for integers from
zero through 1,999,999. Every character is ASCII in this benchmark.

The peers answer different questions:

- [`strings`](../../bench/strings): C uses `snprintf`/`strlen`; Rust uses
  `format!` and byte length. They still format text that fwp eliminates.
- [`text-length`](../../bench/text-length): C/Rust count digits by repeated
  division by ten. All three check multiplication and sums for overflow; these
  inputs fit. Failure messages differ and are not exercised by the timing run.

Each executable has one warmup and six timed fresh-process runs, in rotating
C/Rust/fwp order. Times include startup, calculation, allocation, output and
shutdown; compilation is excluded. The median averages the middle two samples.
Saved samples have 0.001 ms resolution. There is no paired old-fwp timing run.

## Direct-counting results

| Host | C | Rust | fwp | Extra fwp time versus C | Extra fwp time versus Rust |
|---|---:|---:|---:|---:|---:|
| AMD64 | 7.952 ms | 9.477 ms | 8.657 ms | +8.9% | −8.7% |
| ARM64 | 13.775 ms | 14.571 ms | 14.269 ms | +3.6% | −2.1% |

Extra time is `(fwp / peer − 1) × 100%`. These are observations for these programs,
not universal language overhead or a performance budget. AMD64's fwp samples
range from 8.346 to 12.619 ms; repeat sessions are needed for small differences.

Against the formatting peers, fwp takes about 10% as long on these hosts.
That reflects eliminated work, not a tenfold advantage over handwritten
character counting. The two fwp comparisons have identical generated C and
identical executable `.text` contents on each host, but their whole-file hashes
differ. Their small timing differences are separate samples of the same code.

## Storage and machine code

A separate 4,096-element probe uses the same integer pattern plus literal
`"é🙂"` and prints `40240`. It tests unoptimized O0 and optimized O2 builds in
both memory modes: tracing GC follows references to find live objects;
automatic reference counting (ARC) releases storage when its last owner goes.
The probe makes **zero
managed leaf-allocation requests after constant initialization**. A leaf
allocation holds bytes rather than references to other managed values. An
injected allocation makes each control exit with the expected failure code.
This does not count libc allocations, raw runtime buffers, stacks or process RSS.

The timed fwp loop was inspected in both actual executables: digit counting and
the running sum stay in CPU registers, with no calls, allocations or stack
loads/stores in normal iterations. Arithmetic checks remain. Runtime setup and output still have costs;
tracing remains in these binaries.

The complete fwp executable-code sections (`.text`) are 25,218 bytes on AMD64 and 22,908 on ARM64;
the direct C peers are 489 and 536 bytes. These include runtime and layout
differences, not just the counting loop. Whole-file sizes and all seven programs'
mixed timing results remain in the [raw report](integer-text-2026-10-20.json).
This optimization does not resolve the other benchmark gaps.

## Validation and reproduction

Each focused host passes 205 tests: 154 compiler tests, 49 integration tests,
the channel measurement and the seven-program benchmark test. The exact benchmark
selection filters out a separate ownership-check experiment. All complete logs
were audited. New tests cover integer widths/extremes, Unicode, shared strings,
effects, trap order, binary output and allocation controls; 24 test binaries
and their generated C/disassembly are archived across the two hosts.

Run the `scalar-text` suite in `.github/workflows/numerics.yml`, download its
artifacts, then use `scripts/summarize-scalar-text.py` with explicit `--run`,
`--source`, `--artifacts` and `--output` arguments. It checks source inputs,
architectures from executable files, timing samples, binary hashes and the
primitive inventory.
The [handoff](../development-state.md) tracks full production acceptance.
