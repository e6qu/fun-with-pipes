# Programs used to judge the roadmap

The [plan](../PLAN.md) needs a finite set of applications as well as small
compiler tests. These programs exercise features together. Passing them does
not prove every possible program safe or fast; new features still need tests.

The suite below is the initial acceptance set. Existing tests provide some
correctness and cleanup evidence. They do **not** yet satisfy all the scale,
performance and platform requirements in the last column.

| Program family | Work and current input | Existing evidence | Still required for this suite |
|---|---|---|---|
| [Word frequencies](../examples/wordfreq.fwp) | Read text, normalize words, count, rank and print five results; 4,096 words/64 distinct words and 65,536/1,024 | [Comparison protocol](#word-frequency-comparison); measurements pending | Repeat same-host C/Rust comparisons; set time/memory budgets; retain cleanup and native ARM64/AMD64 evidence |
| [Directory report](../examples/cli/dirstat.fwp) | Walk directories, group by extension and sort; current test repeats a six-file tree 64 times | `tests/directory_report.rs`: interpreter/native agreement and final managed storage | Add a larger tree, permission/error controls and repeated live-memory measurements |
| [Text-file tools](../examples/cli) | Count words, filter lines, select CSV columns and update a task file | `tests/text_file_tools.rs`: maintained programs, repeated results and ownership checks | Scale file sizes; measure input/output storage separately; record failure cleanup |
| Numerical pipeline | Map/reduce 65,537 elements and multiply 65×67 by 67×63 matrices, eight rounds | [Existing C/Rust comparison](benchmarks.md#current-numerical-comparison-and-record-moves) | Repeat current-revision comparisons; set per-size budgets; include a larger numerical application |
| Derivative application | Repeated gradients/Jacobians, including unused tapes and nested differentiation | [Numerical contracts](numerics.md#reverse-mode), `tests/autodiff_nested.rs` and `tests/autodiff_workspace.rs` | Select an end-to-end model and fixed data; compare supported precision, recording/workspace/output costs and scaling |
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

**Status:** protocol and comparison implementations are prepared; no runner
measurement or performance improvement is claimed yet. See the
[session handoff](development-state.md) for the actual validation state.
