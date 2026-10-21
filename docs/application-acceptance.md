# Programs used to judge the roadmap

The [plan](../PLAN.md) needs a finite set of applications as well as small
compiler tests. These programs exercise features together. Passing them does
not prove every possible program safe or fast; new features still need tests.

The suite below is the initial acceptance set. Existing tests provide some
correctness and cleanup evidence. They do **not** yet satisfy all the scale,
performance and platform requirements in the last column.

| Program family | Work and current input | Existing evidence | Still required for this suite |
|---|---|---|---|
| [Word frequencies](../examples/wordfreq.fwp) | Read text, normalize words, count, rank and print five results; 4,096 words/64 distinct words and 65,536/1,024 | [First C/Rust baseline](measurements/wordfreq.md); two Linux hosts | Repeat same-host C/Rust comparisons; set time/memory budgets; retain cleanup and native ARM64/AMD64 evidence |
| [Directory report](../examples/cli/dirstat.fwp) | Walk directories, group by extension and sort; current test repeats a six-file tree 64 times | `tests/directory_report.rs`: interpreter/native agreement and final managed storage | Add a larger tree, permission/error controls and repeated live-memory measurements |
| [Text-file tools](../examples/cli) | Count words, filter lines, select CSV columns and update a task file | `tests/text_file_tools.rs`: maintained programs, repeated results and ownership checks | Scale file sizes; measure input/output storage separately; record failure cleanup |
| Numerical pipeline | Map/reduce 65,537 elements and multiply 65×67 by 67×63 matrices, eight rounds | [Existing C/Rust comparison](benchmarks.md#current-numerical-comparison-and-record-moves) | Repeat current-revision comparisons; set per-size budgets; include a larger numerical application |
| Derivative application | Rosenbrock descent from alternating −1.2/1.0 inputs: 3, 33 and 129 dimensions, 199 gradient updates | [Descent comparison](#descent-with-and-without-a-saved-history); measurements pending; existing nested/workspace checks remain | Measure retained history and workspace separately; set time/memory budgets and extend native evidence |
| Long-running service | Existing HTTP/gRPC clients, handlers, streams and task cancellation | [Service ownership](ownership.md#http-ownership) and [service measurements](benchmarks.md#server-memory-after-completed-remote-calls) | Consolidate one repeatable service scenario with bounded concurrency, disconnects and repeated live-memory samples |

Before declaring this suite accepted, name the exact revisions, inputs and native
hosts for each row. Require identical observable results against an independent
oracle or a documented reference, plus interpreter/native comparisons where the
interpreter supports the interface. Cover Linux/macOS/Windows ARM64 and AMD64;
WebAssembly claims require their own executed subset. A skipped test is no support.

Require zero unreleased managed storage after teardown in checked ARC. For a
long-running process, also compare live storage after completed operations at
increasing repeat counts; a clean exit alone does not prove bounded retention.
Record intentional live data, raw buffers, external library storage and process
memory separately. Keep failure/cancellation controls and checks that deliberately
omit a release, so a broken observer cannot report success.

Timing budgets remain unset until repeated baselines identify ordinary variation.
Record the chosen host/input budget before optimizing, retain slower results and
investigate inconclusive measurements. Do not choose a universal percentage or
mark this suite complete because one application improved.

## Word-frequency comparison

Run the `wordfreq` suite in the **Numerical and ownership evidence** workflow.
It measures Linux AMD64 and ARM64 separately, using production GCC and explicit
O2 settings. The script requires every input size, tool, sample count, warmup
count and timeout; it has no implicit benchmark configuration.

The fwp program lowercases ASCII letters and removes commas and periods from
each word. `words` splits on space, tab, line feed and carriage return. Other
characters stay in a word. It counts normalized words, sorts by decreasing count
and then by the word, and prints the first five. For example, `Pear pear apple`
prints `pear: 2` and then `apple: 1`.

[C](../tests/fixtures/wordfreq_bench.c) and
[Rust](../tests/fixtures/wordfreq_bench.rs) implement that operation for ASCII
input. All three materialize normalized words and count with sorted contiguous
key/count pairs using binary search and insertion. No peer uses a hash table.
The generated inputs vary case and punctuation and retain their exact hashes.
A separate Python oracle checks results. Empty input, ties, punctuation-only
words and separator boundaries have small correctness controls.

This compares complete implementations, with known differences. fwp uses its
general string/list/map representations. C/Rust combine normalization into one
pass, while fwp expresses three operations. Their allocation growth, ranking sort
and standard-I/O buffers also differ. The C/Rust peers reject non-ASCII input;
this is not a Unicode benchmark or a pure measurement of compiler overhead.

The timer includes process launch, reading the saved input, all computation,
allocation, printing and teardown. Input generation and compilation are excluded.
Two warmups precede sixteen samples; order rotates and reverses, giving each
implementation every position equally. Keep every sample. A ratio of 1.25 means
fwp's median took 25% more time than that named peer on that host and input.

Compilation time, executable size and disassembly are retained separately.
Peak resident memory comes from a separate fresh-process run of each executable.
Instrumented fwp runs count allocation requests, requested bytes, retains and
peak/final managed charge after constant initialization through cleanup. These
counts exclude raw buffers, stacks, allocator metadata and process startup; they
are not resident memory or C/Rust allocation counts. Profiled execution times
never enter the timing comparison. ARC binaries must omit tracing symbols and
finish with zero managed charge and collections.

**Status:** the [first Linux C/Rust baseline](measurements/wordfreq.md) passes
with independently inspected binaries. No performance improvement is claimed. See the
[session handoff](development-state.md) for the actual validation state.

## Descent with and without a saved history

The `ad-application` suite uses the objective and reverse-mode gradient from
[tutorial 20](tutorials/20-autodiff-and-devices/README.md). An objective assigns
one number to a candidate vector; a gradient says how each component changes
that number. Each update subtracts 0.001 times the gradient.

The starting vector alternates −1.2 and 1.0. Cases have 3, 33 or 129 dimensions.
The original `iterate 200 descend | last` retains 200 vectors, including the
initial one, so it performs **199 updates**. The comparison loop performs the
same updates while retaining only its current vector. Both return the complete
final vector; neither returns the discarded history. This is a change in program
structure, not an implemented compiler optimization.

Both raw interpreter forms must agree bit-for-bit with each other and with the
native outputs. An independent handwritten derivative also checks each component
with relative and absolute tolerance 1e-10; different floating-point operation
orders can round differently. That Python calculation is a correctness oracle,
not a timed C/Rust baseline.

Linux ARM64/AMD64 measurements use explicit GCC O2, ARC/tracing, disabled LTO and
enabled bounded derivative-workspace reuse. Two warmups precede sixteen timed
fresh processes per variant, with rotated and reversed order. Timing includes
startup, calculation, printing and teardown. Separate instrumented runs record
fwp allocation requests, bytes, retains and peak/final managed charge. Raw tape
buffers, allocator metadata, stacks and resident memory are outside those counters;
these numbers cannot establish total autodiff memory use.

Generated C, native binaries, disassembly and hashes are retained. The final
observer requires no live tapes or managed charge; a control that omits tape
retirement must fail. This does not establish constant memory for arbitrary AD,
or bounded long-running retention from a clean exit alone. Runner results and
budgets remain pending.
