# Comparing integer character counters

This experiment asks how to reduce the cost of `show | string.length` without
building a string. For example, `-17` has three characters: two digits and a minus
sign. The candidate counts decimal digits in groups of 16, 8, 4, 2 and 1 rather
than dividing by ten for every digit. For `123456`, dividing by 10,000 removes
four digits and leaves `12`; one more comparison gives six digits in total.
Signed values first use their unsigned magnitude, then add one for a minus sign.
Unsigned subtraction handles the smallest signed integer without overflowing
signed negation. No lookup table, allocation or new runtime setting is needed.

The candidate is under investigation. No speed improvement or explanation of
earlier timing variation is established yet. An earlier candidate merely shared
one loop between positive and negative values; its AMD64 CPU medians were about
1–4% higher than an unchanged rebuild, so it was not selected as an improvement.
That experiment's source is `995d3ecf`, run `39525618134`; both Linux hosts passed
and the complete results are retained. See the [handoff](../development-state.md)
for the current source and checks.

## What runs

The maintained `bench/text-length` programs count characters of `i` and `3*i`,
plus one separator, for integers from zero through 1,999,999. They sum the counts
and print `28518516`. C, Rust and fwp all count digits directly and check the
relevant arithmetic. This is different from the `strings` peers, which construct
formatted strings; their timings do not measure the same work.

Five executables run on the same GitHub Linux machine:

| Executable | Purpose |
|---|---|
| Saved C | Handwritten direct-counting comparison. |
| Saved Rust | Handwritten direct-counting comparison. |
| Saved fwp | Repeat the exact previously measured binary. |
| Rebuilt fwp | Compile the unchanged saved generated C to expose rebuild differences. |
| Candidate fwp | Compile that C with only the integer counting helpers replaced. |

The script verifies the source run, its successful jobs, input source hashes,
saved benchmark samples and executable architectures before use. Both rebuilds
use GCC `-O2 -std=gnu11 -ffp-contract=off`, without link-time optimization.
It records commands, tool versions, source and binary hashes, executable sizes,
instruction-section sizes and complete disassembly. The candidate does not
remove checked arithmetic, tracing support or ownership operations.

## Timing and memory

`scripts/measure-integer-counting.py` runs only on GitHub's native Linux ARM64
and AMD64 workers. The workflow explicitly selects each CPU allowed to the job.
The Python parent and its children are restricted to one CPU at a time; results
remain separate for each CPU. The script restores the original CPU set afterward.
Address randomization is recorded and left unchanged.

After two warmups per executable, thirty rounds rotate and reverse execution
order, balancing each executable's position. Every output must match. Each sample
records elapsed time and the child's user plus system CPU time. Both cover
startup, computation, output and shutdown. Elapsed time also includes Python's
process launch; child CPU time excludes the parent's work and time descheduled.
Compilation, downloads, disassembly and storage instrumentation are outside
timing. No timing sample is discarded.

Each ratio divides the candidate's median by the named peer's median. A ratio of
`1.10` means ten percent more time; `0.90` means ten percent less. Inspect the raw
samples and each CPU before interpreting a ratio: pinned execution does not
control clock frequency, virtualization, caches or process address layout.

Separate instrumented rebuilds count managed allocations, requested bytes,
retains, peak/final charged storage and collections after constant initialization.
The baseline and candidate must report zero in this workload. A deliberate
16-byte allocation must be detected independently. These counts exclude raw
buffers, allocator metadata, stacks and libc; they do not claim zero whole-process
memory use. Earlier [saved-binary memory measurements](integer-text.md) describe
process-memory costs. The instrumented programs are never timed.

Correctness checks in `tests/integer_output.rs` compare unoptimized interpretation
and native ARC/tracing execution. Inputs include signed and unsigned extremes
and values immediately before, at and after every representable power of ten;
signed cases include both signs. Expected lengths also come from Rust decimal
formatting. Other cases preserve Unicode lengths, shared strings, effects and
trap order. Passing this experiment alone does not replace full native CI.
