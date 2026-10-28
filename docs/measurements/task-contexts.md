# Saved CPU state in task stacks

The numbers below describe the October 21 source and toolchain, not the current
compiler. Keep the recorded source when reproducing them.
Current tests retain both task layouts, register/rounding/signal restoration,
explicit release, context alignment and teardown controls. They no longer test
collector roots or run a second tracing mode. They passed
[PR #217's platform gates](../roadmap-history.md#tracing-gc-removal-pr-217).
New measurements are separate work; the numbers below have not been refreshed.

A task is work that can pause while other tasks run. Its **stack** holds active
function calls. Its **task record** holds scheduling and ownership information.
A task started by another task is its child; the original program task is the root.
When a task pauses, the runtime also saves CPU registers so it can resume at the
same instruction. That saved image is called a **context** here; it is separate
from service settings and the language's `State` effect.

glibc is the C library used by the supported Linux runners. On these hosts, the
saved image was embedded in each heap-allocated task record.
The candidate places each child's image at an aligned address in that task's
existing stack allocation, above its usable call frames. The task record holds
a pointer. The root task uses the host's stack, so its image occupies runtime
static storage, which belongs to the program rather than a heap allocation.
The runtime clears that image at teardown and clears
completed child pointers before reusing their stacks.
Programs that never use the task runtime do not initialize or clear a saved root
image. Native task-free checks and an unconditional-clear control pass on both
Linux architectures.
The inspected task-free binaries still reserve the static image.

The saved bytes still exist. This change reduces heap record size and allocator
rounding; it does not eliminate CPU state or guarantee lower process memory.
The root static image and each child's context plus any alignment padding must
be counted separately. Child call frames have that much less usable space within
the unchanged stack reservation. glibc still performs context switching, including its
signal-mask and floating-point environment handling.

## What is compared

The [test](../../tests/task_context_storage.rs) generates this program:

```fwp
worker : I64 -> I64 ! {Async}
worker = tap (const () | task.yield) | add 1
main = range 0 32 | task.map worker | map (option.unwrap-or 0) | sum | echo
```

`range 0 32` produces the integers 0 through 31. `tap` runs an operation while
keeping its original input. Here `const ()` supplies unit to `task.yield`, which
lets another ready task run. Each worker then adds one. `task.map` waits for
results, represented as `Some value` when completed or `None` when cancelled.
`option.unwrap-or 0` supplies zero for the latter case. None is cancelled here,
so the final line prints `528`, the sum of 1 through 32.

Both native variants use the same generated program. The control reconstructs
the preceding heap layout in generated C; production has no layout switch or
compatibility mode. Raw interpretation independently checks the output. fwp
emitted C at O1; the C compiler built each layout at O0 and O2, under both checked
ARC and tracing in this historical measurement. ARC means automatic reference counting without a tracing
collector. Collections and reuse verification are disabled for the counted runs,
and physical freeing is enabled.

These are comparisons between two fwp representations. They do not compare
fwp with C/Rust implementations, or establish zero-cost task abstraction.

## Measured storage

Both jobs in [run 39606188022](https://github.com/e6qu/fun-with-pipes/actions/runs/39606188022)
passed at `dec32109b52b8783c7234cd5c72e242583742a4c`, preserved by tag
`roadmap/revision-task-contexts-dec32109b52b`. The
[raw report](task-contexts-2026-10-21.json) retains source/binary hashes, hardware,
compiler versions, all samples and ranges. Both runners use GCC 13.3.0 and expose
four logical CPUs: an AMD EPYC 9V74 on AMD64 and Neoverse-N2 on ARM64.

Each standalone sample makes 227 managed allocation requests and performs 159
effective retains in both layouts. All four ARC/tracing O0/O2 configurations agree
on the following counts. Requested bytes sum all allocation requests; peak charge
includes allocator rounding and measures simultaneously live managed storage.
Both layouts end with zero managed charge and zero collections.

| Host and layout | Task record bytes | Requested bytes | Peak charged bytes |
|---|---:|---:|---:|
| Linux AMD64, embedded context | 1,504 | 54,256 | 54,592 |
| Linux AMD64, context on stack | 544 | 22,576 | 25,024 |
| Linux ARM64, embedded context | 5,216 | 176,752 | 206,656 |
| Linux ARM64, context on stack | 656 | 26,272 | 29,248 |

Each saved context still occupies 968 bytes on AMD64 or 4,560 on ARM64. The
candidate uses one such image in static storage for the root and one in each
child's stack. Stack mappings/pools, allocator metadata, code and shared libraries
are outside these managed-byte counts. Service task records also include extra
service fields, so their sizes differ from this standalone program.

## Process memory and elapsed time

Nine fresh processes run per layout, memory mode and C optimization level,
alternating execution order. Both layouts have the same allocation-counting and
reporting hooks. Candidate-only lifetime and bounds assertions run in separate
verification binaries, excluded from timing.
Collection is disabled in both measured modes; "tracing" means collector code
is present, not that collection runs during the timed work.

Linux `VmHWM` records peak resident memory through the post-task-teardown
checkpoint, before final allocator/process exit. It includes startup, code,
shared mappings and stacks; it is not private physical memory. Time includes
process startup, output capture and complete exit. The two scopes differ.

Each arrow below means preceding layout to candidate. A ratio divides the
candidate median by the preceding median: below 1 means less, above 1 means more.

| Host | Mode / C level | Median peak KiB | Median elapsed ms | Memory ratio | Time ratio |
|---|---|---:|---:|---:|---:|
| AMD64 | ARC / O0 | 2,608 → 2,588 | 1.631 → 1.614 | 0.992 | 0.989 |
| AMD64 | ARC / O2 | 1,972 → 1,944 | 1.438 → 1.441 | 0.986 | 1.002 |
| AMD64 | Tracing / O0 | 2,604 → 2,592 | 1.548 → 1.555 | 0.995 | 1.004 |
| AMD64 | Tracing / O2 | 1,984 → 1,956 | 1.554 → 1.559 | 0.986 | 1.003 |
| ARM64 | ARC / O0 | 2,076 → 1,940 | 1.617 → 1.660 | 0.934 | 1.027 |
| ARM64 | ARC / O2 | 1,796 → 1,620 | 1.426 → 1.408 | 0.902 | 0.987 |
| ARM64 | Tracing / O0 | 2,084 → 1,948 | 1.558 → 1.558 | 0.935 | 1.000 |
| ARM64 | Tracing / O2 | 1,800 → 1,628 | 1.425 → 1.353 | 0.904 | 0.950 |

These short runs have overlapping elapsed-time ranges and occasional outliers.
They show lower median process memory for this workload and mixed timings;
they do not isolate switching cost or establish a general speed improvement.
The report retains an earlier run's identity but excludes its timings because
candidate-only correctness assertions still ran in those binaries.

## Actual code and service storage

All 80 saved ELF binaries have the correct native architecture. Generated C,
symbols and complete disassembly were inspected; ARC binaries exclude collector
routines. The task setup still calls glibc `getcontext` and `makecontext` and
passes an aligned address inside the existing stack. ARM64 uses a 16-byte
alignment mask for its 4,560-byte image. No new context-switch implementation is
introduced.

The following ARC binaries include the common measurement hooks. `.text` is
executable code; `.bss` is zero-initialized program storage, including the new root
image and alignment padding. File size also includes headers, symbols and padding.
Smaller heap records do not imply every code or file size shrinks.

| Host / C level | Code bytes, preceding → candidate | Static `.bss` bytes | Executable file bytes |
|---|---:|---:|---:|
| AMD64 / O0 | 299,074 → 298,882 | 199,376 → 200,336 | 443,376 → 443,416 |
| AMD64 / O2 | 44,610 → 42,530 | 66,888 → 67,856 | 90,400 → 86,392 |
| ARM64 / O0 | 310,668 → 310,812 | 199,264 → 203,840 | 458,784 → 458,832 |
| ARM64 / O2 | 41,532 → 40,012 | 66,792 → 71,352 | 87,016 → 87,104 |

The existing [72-call service fixture](queued-grpc-responses.md) supplies a second
workload. Service task records shrink from 1,584 to 624 bytes on AMD64 and 5,296
to 736 on ARM64; they have extra fields beyond the standalone record. Managed
requested bytes fall from 210,304 to 131,584 on AMD64 and 514,688 to 140,768 on
ARM64. All configurations still make 902 allocation requests and 481 retains.
The live listener accounts for the final 544 charged bytes; every response owner,
stream, connection and child task finishes. This interval starts after listener
readiness and excludes stack pools, root static storage, allocator metadata and
OS buffers. It does not measure service speed or orderly listener shutdown.

## Lifetime checks and reproduction

At the recorded revision, a separate C probe excluded ordinary stack copies and checked that objects held
only in saved root/child register images survived collection. Deliberately hiding
those images must exit 191/192; omitting root-state cleanup must exit 193. All ten
register/teardown omission controls passed across the two hosts. Two more controls
detect unnecessary clearing in task-free programs. The probe also checks rounding
and signal-mask restoration. Task, scope, cancellation and 72-call service cleanup
regressions pass on both hosts. Library unload checks include an intentionally
omitted root-image clear. Static-memory checks run with `strace` installed, so
the check for unexpected memory mappings actually executes.

Reproduce with `.github/workflows/numerics.yml`, `suite=task-contexts` and
`native_runner=all` at the recorded source. Each host artifact contains 40 binaries
and 72 process samples, with generated C, symbols, disassembly and toolchain data.
[PR #189](../roadmap-history.md#compact-task-records-and-repaired-native-validation-pr-189) records the subsequent passing production and documentation checks.
