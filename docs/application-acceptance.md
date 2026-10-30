# Programs used to judge the roadmap

The [plan](../PLAN.md) needs a finite set of applications as well as small
compiler tests. These programs exercise features together. Passing them does
not prove every possible program safe or fast; new features still need tests.

The suite below is the initial acceptance set. Existing tests provide some
correctness and cleanup evidence. They do **not** yet satisfy all the scale,
performance and platform requirements in the last column.

| Program family | Work and current input | Existing evidence | Still required for this suite |
|---|---|---|---|
| [Word frequencies](../examples/wordfreq.fwp) | Read text, normalize words, count, rank and print five results; 4,096 words/64 distinct words and 65,536/1,024 | [Four current C/Rust sessions and fixed budgets](measurements/wordfreq-current.md), plus historical [text comparison](measurements/unchanged-text.md) | Baseline/evidence checks verified in #228; string candidate qualifies four timing sessions, with final-head platform coverage pending |
| [Directory report](../examples/cli/dirstat.fwp) | Walk directories, group by extension and sort; 64/1,024-file trees and small ownership controls | [Six-host observations](measurements/file-applications.md): exact output, repeated success/error cleanup and process memory | [Allocation-boundary failure checks](measurements/directory-failures.md) verified in #228; maintain them as ownership changes |
| [Text-file tools](../examples/cli) | Count words, filter lines, select CSV columns and update a task file | `tests/text_file_tools.rs`: maintained programs, repeated results and ownership checks | Scaled counting/filtering/CSV/task-file cleanup passes on six hosts; preserve current delivery coverage and separate input/output costs |
| Numerical pipeline | Map/reduce 65,537/262,145 elements; multiply 65×67 by 67×63 and 257×259 by 259×255 matrices, eight rounds | [Current four-case protocol and partial results](measurements/kernel-baselines.md) | Complete qualified N1 baselines and resolve the failed timing control before selecting N2 |
| Derivative application | Rosenbrock descent at 3, 33 and 129 dimensions; 199 updates plus zero/one/1,999-update controls | [Repeated current baselines and fixed limits](measurements/descent-costs.md), [nested accuracy/storage](measurements/ad-depth.md) and [capture costs](measurements/eager-captures.md) | Resolve D2's failed zero-update recheck and preserve six-platform cleanup/accuracy coverage; earlier allocation gains do not close the speed goal |
| Long-running service | Existing HTTP/gRPC clients, handlers, streams and task cancellation | [Service ownership](ownership.md#http-ownership) and [service measurements](measurements/remote-server-storage.md#server-memory-after-completed-remote-calls) | The [API memory scenario](measurements/http-application-memory.md) passed #208 delivery; preserve failure/cancellation and repeated-memory coverage as ownership changes |

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
Production CI keeps both HTTP test suites. The separate
[API memory check](measurements/http-application-memory.md) samples between
completed request groups, including disconnects and forced shutdown. It passed
six-host production delivery in #208. Printed request counts are correctness
results, not throughput benchmarks.

Use each family's recorded timing budget where one exists. Other families need
repeated baselines before setting a budget. Retain slower and inconclusive results;
one application's improvement does not complete this suite.

## Word-frequency comparison

The [current baseline](measurements/wordfreq-current.md) is the source for new
work: two independent sessions on each named Linux CPU, a byte-identical fwp
control, 16 measured rounds of 64 processes per label and retained complete
outputs. It records source `dc963bb5`, whole-program C/Rust gaps, managed counts,
code/stack costs and workload-specific limits declared before a candidate.

Use **Numerical and ownership evidence**, `suite=wordfreq-current`,
`native_runner=all`, `comparison_session=both` to collect that protocol. A native
build needs no earlier fwp compiler. Qualification rejects other CPU/toolchain
assignments before execution. The evidence checker independently recomputes
results and rejects damaged observations; a green baseline job accepts no speedup.

The [program](../examples/wordfreq.fwp) lowercases ASCII letters and removes commas
and periods. `words` splits on space, tab, line feed and carriage return; other
characters remain in a word. It counts normalized words, sorts by decreasing
count then by spelling, and prints five results. `Pear pear apple` therefore
prints `pear: 2`, then `apple: 1`.

The [C](../tests/fixtures/wordfreq_bench.c) and
[Rust](../tests/fixtures/wordfreq_bench.rs) peers count with sorted contiguous
key/count pairs, as fwp does. No peer uses a hash table. C/Rust combine three
normalization operations; fwp uses its ordinary string/list/map representations.
Allocation growth, ranking and I/O buffers also differ. This compares complete
ASCII applications, not Unicode behavior or pure compiler overhead.

Elapsed time includes process launch, input reads, computation, printing and
cleanup; compilation, input generation and parent input-file opening are excluded.
Managed counters come from separate instrumented runs, process RSS from separate
fresh executions. Neither is a C/Rust allocation-count comparison. The report
states the exact scopes, ratios, raw observations and limitations.

The [first comparison](measurements/wordfreq.md) and
[text-copy experiment](measurements/unchanged-text.md) retain historical results.
Their `wordfreq-baseline`, `wordfreq` and `wordfreq-repeat` workflow selections
reproduce those protocols; they do not replace the current identical-copy controls
or establish budgets for new work. Use scripts from each recorded source revision
when reproducing it.

## Descent with and without a saved history

The program minimizes the Rosenbrock function: an objective assigns one number
to a vector, and its gradient says how that number changes with each component.
Starting coordinates alternate −1.2 and 1.0. Each update subtracts 0.001 times the
gradient. [Tutorial 20](tutorials/20-autodiff-and-devices/README.md) introduces this
calculation; [the current protocol](measurements/descent-costs.md) defines the six
input/update cases, peers, complete outputs, repeated sessions and fixed limits.

The earlier `iterate 200 descend | last` computes **199 updates** and retains
200 vectors, including the initial one. A loop can perform the same updates while
keeping only its current vector. Both must return the same complete final vector.
This is an explicit program choice, not a universal compiler optimization.

Raw and optimized fwp results must agree with native execution. An independent
handwritten derivative checks components with the stated absolute/relative
accuracy bounds. Zero-update cases print the initial vector; they include
initialization and output and therefore do not isolate process startup.

Require zero managed and raw derivative storage after each completed solve,
not only at process exit. Track tape buffers and registry storage separately
from managed values; deliberately delayed or omitted frees must fail the
[per-solve observers](measurements/descent-observers.md). Workspace reuse may
retain documented storage between updates, but shutdown must release it.
Neither these finite runs nor a clean exit prove bounded memory for arbitrary
nesting or indefinitely repeated work.

D1's repeated baseline and D3's accuracy/depth checks are verified. D2 remains
open: the repaired-source zero-update recheck exceeds its unchanged 2% limit.
[Capture costs](measurements/eager-captures.md) and
[timing variation](measurements/timing-variation.md) retain all observations.
Do not replace that failed control with an earlier passing run. See
[D1–D3](../PLAN.md#5-differentiation) for the remaining acceptance work.

## Testing unchanged string ownership

ASCII case conversion, trimming and replacement consume the source owner. If
bytes stay unchanged, the result receives that owner. ASCII case conversion can
reuse uniquely owned input; changed trimmed results use a new string. The current
replacement candidate also reuses unique storage when the result cannot grow.
Shared inputs receive a separate changed result, preserving the original bytes. Failure and cancellation must release consumed owners; deliberately
omitted cleanup must fail its observer. `string.repeat` borrows its source and
returns a separate result, including when the count is one.

The [earlier ownership experiment](measurements/unchanged-text.md) owns its
historical source, count reductions and timing schedule. Its old acceptance
rules are not the current candidate's rules.

The [direct-result experiment](measurements/direct-string-results.md) removes
temporary libc buffers from replacement and repetition. Its first candidate
passes native/WASI checks but fails the timing requirement. Unique replacement
storage then confirms fewer managed allocations, with all six native hosts and
both WASI hosts passing, but still misses the required speed gain. The latest
one-byte search candidate passes focused GCC checks and four timing sessions;
complete final-head production acceptance remains required. Retains and peak managed
charge remain unchanged; raw-buffer removal alone is not an ARC reduction.
Compare exact old/new function bodies, preserve the current word-frequency
budgets, and retain separate raw-buffer, managed-storage, timing, code and stack
observations. The word-frequency application does not use `string.repeat`, so
its timing cannot establish a speedup for repetition.

## Repeated directory and file work

The [directory allocation-boundary checks](measurements/directory-failures.md) inject
recoverable traps before the first scratch allocation, during name collection,
at scratch growth and during result-list construction. Each trap must close
opened handles, release partial owners and permit a successful retry, including
when the caller retains a path alias. Controls deliberately omit each cleanup
and must trigger the corresponding observer. Native O1/O2 checks pass on all
six hosts, with the first failed harness and all final results retained.

Managed-heap exhaustion has a different contract: `fwp_heap_oom` prints
`fwp: out of memory` and exits with status 102. A separate subprocess checks that
handler at the same boundaries. It does not claim recovery or pre-exit cleanup,
and it does not exhaust the host's memory.

The `file-applications` workflow suite checks larger inputs with the current
compiler on all six native hosts. It is a cleanup experiment, **not a timing
comparison or evidence of C/Rust parity**. The [six-host report](measurements/file-applications.md) records focused acceptance,
actual memory observations and binary inspection.
[PR #207](roadmap-history.md#file-cleanup-and-http-example-checks-pr-207) records
its complete production validation.

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
and generated C at O1 and O2 with LTO disabled. Small boundary controls and
larger observations use counted ownership. Each checkpoint records:

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
ownership artifacts. On macOS, directory evidence comes from the ownership/corpus job
and text/task evidence from the regular job; both archives are required. A
coverage check follows the actual test assignments and rejects missing exports.
Focused measurements explicitly disable link-time optimization; production
artifacts retain production compiler settings. The earlier four-program report
retains its original 30 binaries and sixteen series; it does not verify this
extension. Machine headers verify the runner's actual architecture. The original scale cases do not cover forced allocation failure. The separate
directory-boundary probes above add that coverage for directory traversal; the [file-read boundary controls](measurements/file-read-failures.md) add probes
for text/byte reads. Focused ARM64 macOS and AMD64 GCC checks pass; complete
platform coverage remains pending. Other operations still need their own
allocation-failure evidence. The prepared
[file-boundary portability checks](measurements/file-boundary-portability.md)
extend error, flush and borrowed-handle probes to Windows. Both repaired native
Windows focused runs pass, with all 22 saved executions per host audited. Complete
final-head coverage, including related resource-frame and WASI repairs, remains
required.

The observer reads Linux `/proc`, macOS `ps`, and Windows
`K32GetProcessMemoryInfo` working-set counters. Windows sampling opens and closes
one query handle per sample; it does not start a shell. These are process-wide
resident-memory observations, separate from the managed and file-buffer ledgers.

## Which examples pass the ownership checks

[`inventory-program-admission.py`](../scripts/inventory-program-admission.py)
records C emission for every `tests/run/*.fwp` program, with dynamic storage and
stack optimization enabled. The focused file-application workflow runs it on
Linux AMD64 at fwp O1 and saves `program-admission.json`, including source/compiler
hashes, commands and diagnostics. `accepted` means C was emitted; `rejected` means
the compiler reported an error. Neither category establishes execution or cleanup.
Timeouts, crashes and obsolete memory selectors in emitted C fail the inventory.
Investigate every rejection before claiming support; execution snapshots and
runtime ownership tests remain necessary.

The [85-program inventory from before GC removal](measurements/file-applications.md#which-execution-examples-pass-arcs-checks)
records 81 accepted examples, three intentionally invalid programs, and an
expired inter-task derivative rejected by ownership checking. Its tracing-mode
comparison is historical: tracing is no longer available. Current `arc_corpus`
tests execute admitted programs and check final managed storage; use current
inventory artifacts when claiming today's compiler admission.

## Separating derivative and representation costs

Reverse automatic differentiation records arithmetic and walks that record
backwards. An explicit derivative is a formula written by the programmer.
Comparing these two fwp forms exposes recording work; comparing explicit fwp,
C and Rust programs also includes differences in arrays, allocation, formatting
and checked access. The ratio is not pure compiler overhead.

Use the [current derivative baseline](measurements/descent-costs.md) for new
experiments. Earlier reports remain evidence at their recorded revisions:
[initial explicit peers](measurements/descent-peers.md),
[packed arrays](measurements/packed-descent.md),
[array-owner moves](measurements/array-owner-moves.md),
[capture borrowing](measurements/array-capture-descent.md),
[callback locals](measurements/callback-locals.md), and
[matched coordinate formulas](measurements/coordinate-work.md).
Their lower allocation/count costs and rejected timing controls remain visible;
they neither reset current budgets nor establish general C/Rust parity.
