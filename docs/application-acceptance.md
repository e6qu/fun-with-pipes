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
| [Text-file tools](../examples/cli) | Count words, filter lines, select CSV columns and update a task file | `tests/text_file_tools.rs`: maintained programs, repeated results and ownership checks | Scaled counting/filtering/CSV/task-file cleanup passes on six hosts; preserve current delivery coverage and separate input/output costs |
| Numerical pipeline | Map/reduce 65,537 elements and multiply 65×67 by 67×63 matrices, eight rounds | [Existing C/Rust comparison](benchmarks.md#numerical-kernels-and-record-moves) | Repeat current-revision comparisons; set per-size budgets; include a larger numerical application |
| Derivative application | Rosenbrock descent at 3, 33 and 129 dimensions; 199 updates plus zero/one/1,999-update controls | [AD storage](measurements/ad-application.md), [C/Rust peers](measurements/descent-peers.md), [packed arrays](measurements/packed-descent.md) and [array-owner moves](measurements/array-owner-moves.md) and [borrowed captures](measurements/array-capture-descent.md) on two Linux hosts | Stabilize identical-code timing controls and set per-input budgets; extend nested and platform evidence |
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

The maintained JSON API tests compare raw interpretation with native execution.
They check endpoints, concurrent requests over reused connections, and shutdown
that lets active replies finish. The tests require curl/compiler success, limit
startup/shutdown time and clean up child processes after failures. Separate tests
cover silent servers, incomplete or invalid startup lines, early exits and
preserved diagnostics. Windows uses CTRL_BREAK, a console shutdown signal,
restricted to the tested server's process group.

Before signaling shutdown, the test reads the request counter to confirm that
the slow request entered its handler and checks that its reply is still pending.
The `http-application` focused suite checks this example alone. The full
`server-checks` suite splits protocol tests from application/connection tests to
fit the existing 25-minute job limit. All twelve jobs passed on six native hosts
in [run 40062164443](https://github.com/e6qu/fun-with-pipes/actions/runs/40062164443).
Production CI keeps both HTTP test suites. These checks do not supply the
long-running service memory measurements still required above. Printed request
counts are correctness results, not throughput benchmarks.

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

The starting vector alternates −1.2 and 1.0. The original cases have 3, 33 or
129 dimensions. The raw-storage extension adds zero-update and 1,999-update
three-dimensional controls; all variants of each case perform identical work.
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
fwp allocation requests, bytes, retains and peak/final managed charge. Raw tape storage has its own allocator ledger: parent indices, local derivatives,
backward-pass adjoints and the tape registry. It observes successful allocation
and free calls, so losing a runtime pointer cannot hide a leak. Each backward
pass records the registry, retained workspace and other raw bytes. The selected
workloads require constant idle storage across updates and zero raw bytes after
real shutdown. Separate controls omit a parent-buffer free or the registry free;
both must fail. An extra untimed profile disables workspace reuse.

Process peak resident memory comes from a separate uninstrumented run under
GNU time. Managed charge, raw requested storage and resident memory measure
different things. Do not add their peaks: they may occur at different times and
resident memory already includes both allocators. Raw observations exclude
allocator metadata and temporary copies inside realloc. Typed nested weights
are managed values; this numeric descent experiment does not isolate them.

Generated C, native binaries, disassembly and hashes are retained. The final
observer requires no live tapes or managed charge; a control that omits tape
retirement must fail. This does not establish constant memory for arbitrary AD,
or bounded long-running retention from a clean exit alone. The [first measured results](measurements/ad-application.md) show much lower
managed peak storage with mixed, modest timing changes. The same report records
accepted raw-storage and process-memory measurements. The
[explicit-derivative comparison](measurements/descent-peers.md) supplies C/Rust
baselines. The [packed-array version](measurements/packed-descent.md) reduces
allocation requests, and [array-owner moves](measurements/array-owner-moves.md)
halve its retains with unchanged managed peak. That historical array-owner run
measured about 3.05× C time on AMD64 and 3.01× on ARM64 for the largest case.
[Capture borrowing](measurements/array-capture-descent.md) subsequently removes
the remaining retains; [callback locals](measurements/callback-locals.md) reduce
generated code further. Neither establishes a dependable timing improvement.
C and Rust reuse two buffers and compute each edge's residual once; fwp allocates
a new immutable array per update and may recompute a residual for each adjacent
coordinate. These ratios compare complete implementations, not language overhead.

The [repeated-solve protocol](measurements/descent-batches.md) balances positions
and immediate predecessor pairs and includes byte-identical controls. It runs
512 complete solves per process; the largest adapter-only fwp case takes roughly
10–12× C time. Some identical-copy controls still fail their 2% bound, so timing
budgets remain open. [Per-solve observations](measurements/descent-observers.md)
require zero managed/raw live storage after every solve and catch a deliberately
delayed release that final-only checks miss. These finite counts stay below
tape-generation exhaustion and do not prove a memory bound for arbitrary nesting
or indefinitely long runs. The [handoff](development-state.md) records current
delivery gates and the next measurement.

The [matched-formula comparison](measurements/coordinate-work.md) uses the expanded
callback-local compiler and adds C/Rust versions of fwp's coordinate formula.
The largest case still takes 10.40–13.69× C time and 11.86–14.07× Rust time.
Eleven of twelve identical-copy controls pass; AMD64's 3-coordinate/1,999-update
case fails the 2% limit. Numerical buffer probes require cleanup after every
C/Rust solve and catch deliberately omitted releases. Their buffer-only counts
are not comparable to all fwp managed values or process memory. Output, checked
access and buffer reuse remain separate costs to investigate.

The descent runner saves every count/storage violation in `budget-failures.json`
and in the final comparison report. It checks all requested input sizes before
exiting with failure, so one remaining retain cannot hide another size's larger
peak or changed allocation count. Output mismatches, cleanup violations, invalid raw-memory traces and tool
failures still stop that run immediately. Measurements from a run with failed requirements are
investigation evidence, not accepted performance results. The production benchmark
job and numerical workflow check the requirement collector against retained data
and deliberately corrupted profiles.

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

Task-file checks seed 128 or 4,096 Unicode tasks, list them, mark the first task,
reject item zero, clear completed tasks and append a new task. Rust computes
the full expected listing and final file contents independently. Every successful
round restores the seed, keeping the on-disk input size bounded. Three phases
repeat edits, a failed second append into a missing directory, and a failed
second read containing invalid UTF-8. Partial results and successful first writes
must survive or be released according to their ordinary semantics.

All five programs must match raw interpretation. Native checks compile fwp at O1
and generated C at O1 and O2 with LTO disabled. Existing small tracing/stress
checks remain; the larger observations use checked ARC. Each checkpoint records:

- Managed allocator charge after the preceding operation. It must stay constant
  within each phase and return to its initial value before runtime teardown.
- Successfully opened directory, file-read and file-write handles minus actual
  closes: zero. Write counters cover append, byte writes and replacement writes.
- C scratch bytes belonging to `file.read`: zero. This excludes other C buffers.
- Process resident memory at rounds 0, 32 and 63 of each phase, while the child
  waits at the checkpoint. RSS includes allocator pages, libraries, stacks and
  observer overhead. It is recorded separately, with no invented zero-growth
  threshold or claim that managed charge represents the whole process.

Controls deliberately omit managed releases, handle closes and file-read scratch
frees. A separate task-file control omits only write closes while flushing their
bytes, so later reads still see the same data. It must fail the handle observer,
not an unrelated output assertion. Each control must fail before shutdown.
The expanded focused suite retains generated C, 40 native binaries, disassembly,
twenty memory series and 80 execution outcomes per host. Both ordinary runs and
deliberately broken controls save stdout, stderr and exit status before any
result assertion; incomplete runs retain their partial observations. Production
jobs also upload these sources, binaries and execution records with their
ownership artifacts. On macOS, directory evidence comes from the GC test job
and text/task evidence from the regular job; both archives are required. A
coverage check follows the actual test assignments and rejects missing exports.
Focused measurements explicitly disable link-time optimization; production
artifacts retain production compiler settings. The earlier four-program report
retains its original 30 binaries and sixteen series; it does not verify this
extension. Machine headers verify the runner's actual architecture. These cases do not yet
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
  each diagnostic before admitting a new ownership pattern.
- **Tracing rejected:** the program fails ordinary compilation too, including
  intentional diagnostic fixtures. This is not an ARC migration failure.

Timeouts, compiler crashes and mismatched emitted memory modes fail the inventory.
Recorded ARC rejections are discovery results, not accepted language coverage.
The ordinary execution snapshots and the runtime ownership tests remain necessary.

The [current inventory](measurements/file-applications.md#which-execution-examples-pass-arcs-checks)
accepts 81 examples in both modes, including manual pointers with explicit caller
obligations. Three intentionally invalid examples fail ordinary compilation; the
expired inter-task derivative remains rejected by ARC. Existing `arc_corpus`
tests execute admitted programs and check their final managed storage; extend
that coverage as admissions change.

## Separating derivative and representation costs

The first `descent-peers` baseline compares four implementations of the same Rosenbrock
descent: fwp with reverse automatic differentiation (AD), fwp with an explicit
derivative, and explicit derivatives in C and Rust. An explicit derivative is a
formula written by the programmer; reverse AD computes it by recording arithmetic
and walking that record backwards. Comparing the two fwp forms helps expose that
extra work. Comparing the explicit forms measures complete implementations with
different storage: fwp uses immutable lists and intermediate pairs/lists, while
C and Rust reuse two contiguous buffers. This is not identical instruction-level
work or a promise that all of the difference is compiler overhead.

Each starts from alternating −1.2/1.0 coordinates, subtracts 0.001 times the
gradient per update, and prints the complete final vector. Selected cases have
3 coordinates with 0, 1, 199 or 1,999 updates, and 33/129 coordinates with 199
updates. For example, the zero-update case prints the initial vector. A separate
Python formula checks every component with absolute and relative tolerance
1e-10; reverse AD can round differently. Each fwp native form must exactly match
its own unoptimized interpreter output.

On each Linux architecture, GCC and Rust compile at O2 without link-time
optimization; C disables fused multiply-add and fast-math, and Rust enables
overflow checks. Explicit formulas preserve multiplication order. Inputs and
update counts are compile-time constants in all variants. Formatting algorithms,
allocation strategies and intermediate representations still differ.

Two warmups precede 24 fresh-process samples per variant, rotating and reversing
execution order. Timing includes startup, initialization, computation, complete
output and teardown. The zero-update control includes initialization and output,
so it does not isolate startup alone. Compilation times, machine code and binary
hashes are recorded separately. Untimed fwp profiles measure managed storage
and raw derivative buffers; separate runs measure resident process memory for
all four variants. Those peaks must not be added.

The [first baseline](measurements/descent-peers.md) passes both Linux hosts with
72 independently inspected images. Workload budgets and repeated-host timing
acceptance remain open. Preserve these samples and slower results before
choosing the next optimization; the session handoff records ongoing work.

The [packed comparison](measurements/packed-descent.md) adds a fifth implementation: explicit fwp derivatives with
packed `Array[F64]` storage. Each update reads the previous immutable array at
checked indices and generates one result array. It uses existing language/library
features; this is a program-representation comparison, not a compiler change.
For cases with at least 199 updates, require fewer managed allocation requests
and no higher managed peak than the explicit-list form, plus zero final managed
and raw charge. These requirements precede measurement. Retains and all timings,
including any regressions and extra short-case setup, remain visible.

The five-way run uses 40 samples after two warmups, rotating and reversing all
five positions equally. It recompiles and measures every peer on the same runner;
it does not compare times from different CPU models. The two original fwp forms
must reproduce their recorded managed/raw profiles exactly. The original four-way data
remains unchanged. Both Linux jobs and 96 image inspections pass; the report
records the allocation savings, unchanged retains, slower zero-update control
and remaining C/Rust gaps. The [array-owner move](measurements/array-owner-moves.md)
then halves retains without increasing allocation requests or managed peak. Its
timing controls expose variation and preserve slower results. Subsequent
[capture borrowing](measurements/array-capture-descent.md) removes the remaining
retains with unchanged request/peak budgets. [Callback locals](measurements/callback-locals.md)
also remove eligible function records and unused generic entries; their report
separates code/frame savings from inconclusive timing.
