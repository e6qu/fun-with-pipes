# Programs used to judge the roadmap

The [plan](../PLAN.md) needs a finite set of applications as well as small
compiler tests. These programs exercise features together. Passing them does
not prove every possible program safe or fast; new features still need tests.

The suite below is the initial acceptance set. Existing tests provide some
correctness and cleanup evidence. They do **not** yet satisfy all the scale,
performance and platform requirements in the last column.

| Program family | Work and current input | Existing evidence | Still required for this suite |
|---|---|---|---|
| [Word frequencies](../examples/wordfreq.fwp) | Read text, normalize words, count, rank and print five results; 4,096 words/64 distinct words and 65,536/1,024 | [C/Rust baseline](measurements/wordfreq.md) and [paired/repeated text comparison](measurements/unchanged-text.md) on two Linux hosts | Set time/memory budgets; validate the current runtime and preserve six-platform cleanup evidence |
| [Directory report](../examples/cli/dirstat.fwp) | Walk directories, group by extension and sort; 64/1,024-file trees and a small tracing control | [Six-host observations](measurements/file-applications.md): exact output, repeated success/error cleanup and process memory | Preserve these observations as ownership changes; allocation-failure coverage remains |
| [Text-file tools](../examples/cli) | Count words, filter lines, select CSV columns and update a task file | `tests/text_file_tools.rs`: maintained programs, repeated results and ownership checks | Scaled counting/filtering/CSV cleanup passes on six hosts; separate input/output costs and extend task-file coverage |
| Numerical pipeline | Map/reduce 65,537 elements and multiply 65×67 by 67×63 matrices, eight rounds | [Existing C/Rust comparison](benchmarks.md#current-numerical-comparison-and-record-moves) | Repeat current-revision comparisons; set per-size budgets; include a larger numerical application |
| Derivative application | Rosenbrock descent from alternating −1.2/1.0 inputs: 3, 33 and 129 dimensions, 199 gradient updates | [Measured descent comparison](measurements/ad-application.md) on two Linux hosts; nested/workspace checks remain | Measure raw tapes, workspace and process memory separately; set time/memory budgets and extend native evidence |
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
O2 settings. Each host builds once for native ownership checks, the 32-bit
WebAssembly interpreter and generated-code checks, and the paired measurement.
A failed check does not suppress the independent checks that follow it.
The script requires every input size, tool, sample count, warmup
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
The initial four-variant baseline uses sixteen samples after two warmups; the
paired six-variant comparison below uses 24. Order rotates and reverses, giving each
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
with independently inspected binaries. The [text candidate](measurements/unchanged-text.md)
adds paired measurements and explicit count requirements. See the
[session handoff](development-state.md) for the actual validation state.

## Descent with and without a saved history

The `ad-application` suite uses the objective and reverse-mode gradient from
[tutorial 20](tutorials/20-autodiff-and-devices/README.md). An objective assigns
one number to a candidate vector; a gradient says how each component changes
that number. Each update subtracts 0.001 times the gradient.

The starting vector alternates −1.2 and 1.0. Cases have 3, 33 or 129 dimensions.
The former tutorial expression `iterate 200 descend | last` retains 200 vectors, including the
initial one, so it performs **199 updates**. The comparison loop performs the
same updates while retaining only its current vector. Both return the complete
final vector; neither returns the discarded history. The tutorial now uses this loop. This is a change in program
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
or bounded long-running retention from a clean exit alone. The [first measured results](measurements/ad-application.md) show much lower
managed peak storage with mixed, modest timing changes. Total-memory measurements
and repeated-host timing budgets remain open.

## Testing unchanged string ownership

The text candidate consumes the source owner for ASCII case conversion,
trimming and replacement. If bytes do not change, the result receives that owner;
if bytes change, a new string is created before the old owner is released.
Other aliases retain their original bytes. Failure and cancellation must release
the consumed owner; deliberately omitting either cleanup must fail the probe.

For the two word-frequency inputs above, acceptance requires fewer allocation
requests and requested bytes than the frozen baseline, no additional retains or
higher managed peak charge, and zero final charge. These count requirements are
set before measuring the candidate. All timing results, including regressions,
remain reportable; a timing regression requires investigation before adoption.

The paired runner recompiles the accepted baseline's generated C and the candidate
with the same GCC flags. It also runs the same C/Rust peers. Six variants rotate
and reverse order over 24 samples after two warmups. Baseline input hashes and
managed counts must reproduce exactly. Downloaded baseline binaries are checked
against their original report; the newly executed binaries have their own hashes,
disassembly and size records. The explicit baseline source is
`74263bccf8e2e67865e1863e2c04a296a97877bb`, run `39690307737`.


## Repeated directory and file work

The `file-applications` workflow suite checks larger inputs with the current
compiler on all six native hosts. It is a cleanup experiment, **not a timing
comparison or evidence of C/Rust parity**. The [six-host report](measurements/file-applications.md) records focused acceptance,
actual memory observations and binary inspection. Full delivery status stays in
the [handoff](development-state.md).

The directory case creates 64 and 1,024 files spread among sixteen visible
folders and a hidden folder. Names include Unicode, hidden files and five
extension categories. A separate Rust calculation supplies expected file/byte
totals and sort order. Three reports cover hidden-file filtering, largest counts
and the first two names. Each process then repeats successful reports, missing
paths, a file used as a directory, and a permission-denied subtree 64 times.
The denied subtree sorts after a readable subtree, exercising partial traversal.
Tests verify that the operating system denies access and restore permissions.

The word-count case reads two UTF-8 files, each with 128 or 4,096 lines. It checks
line, word and byte counts against independent Rust counts, including blank lines,
tabs and multibyte characters, then checks the two-file total. It repeats three
cases 64 times each: both reads succeed; the second file is missing; the second
contains invalid UTF-8. Both failures follow a completed first read, so partially
built results must also be released.

The grep case uses the same two text files. It checks case-insensitive matches,
file/line prefixes, inverted counts and the no-match exit status against an
independent Rust calculation. Repeated matching and second-file errors exercise
both retained input lines and selected output strings.

The CSV case has 128 or 4,096 data records plus a header. Quoted fields contain
commas, escaped quotes and Unicode. It selects `name` and `id`, writes every
record as tab-separated text, and compares the complete output with independent
expected rows. Repeated failures cover a missing second file, invalid UTF-8 and
a requested column absent from a successfully parsed table. Output is drained
while observing memory, so a large report cannot fill a pipe and stall the test.

All four programs must match raw interpretation. Native checks compile fwp at O1
and generated C at O1 and O2 with LTO disabled. Existing small tracing/stress
checks remain; the larger observations use checked ARC. Each checkpoint records:

- Managed allocator charge after the preceding operation. It must stay constant
  within each phase and return to its initial value before runtime teardown.
- Successfully opened directory/file-read handles minus actual closes: zero.
- C scratch bytes belonging to `file.read`: zero. This excludes other C buffers.
- Process resident memory at rounds 0, 32 and 63 of each phase, while the child
  waits at the checkpoint. RSS includes allocator pages, libraries, stacks and
  observer overhead. It is recorded separately, with no invented zero-growth
  threshold or claim that managed charge represents the whole process.

Controls deliberately omit managed releases, handle closes and file-read scratch
frees. Each must fail the observer before shutdown. The tests retain generated C,
30 native binaries, disassembly, output and sixteen memory series per host. Machine headers verify
that artifacts target the runner's actual architecture. These cases do not yet
cover forced allocation failure or every file operation and do not complete the
application suite.

The observer reads Linux `/proc`, macOS `ps`, and Windows
`K32GetProcessMemoryInfo` working-set counters. Windows sampling opens and closes
one query handle per sample; it does not start a shell. These are process-wide
resident-memory observations, separate from the managed and file-buffer ledgers.

## Which examples pass ARC's ownership checks

`scripts/inventory-arc-programs.py` compares C emission for every `tests/run/*.fwp`
program in explicit tracing and ARC modes, with dynamic storage and stack
optimization enabled. The focused file-application workflow runs this inventory
on Linux AMD64 at fwp O1 and saves `arc-admission.json` with source/compiler hashes,
commands' diagnostics, and these categories:

- **Both accepted:** both modes emit C. This alone does not verify execution or cleanup.
- **ARC rejected:** tracing emits C, but ARC rejects the ownership contract. Investigate
  each diagnostic before changing the default memory mode.
- **Tracing rejected:** the program fails ordinary compilation too, including
  intentional diagnostic fixtures. This is not an ARC migration failure.

Timeouts, compiler crashes and mismatched emitted memory modes fail the inventory.
Recorded ARC rejections are discovery results, not accepted language coverage.
The ordinary execution snapshots and the runtime ownership tests remain necessary.

The [current inventory](measurements/file-applications.md#which-maintained-examples-pass-arcs-checks)
identifies the raw-pointer gap and distinguishes it from an intentionally invalid
inter-task derivative lifetime.
