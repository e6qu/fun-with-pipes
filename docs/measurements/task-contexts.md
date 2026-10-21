# Saved CPU state in task stacks

A task is work that can pause while other tasks run. Its **stack** holds active
function calls. Its **task record** holds scheduling and ownership information.
When a task pauses, the runtime also saves CPU registers so it can resume at the
same instruction. That saved image is called a **context** here; it is separate
from service settings and the language's `State` effect.

On glibc Linux, the saved image was embedded in each heap-allocated task record.
The candidate places each child's image at an aligned address in that task's
existing stack allocation, above its usable call frames. The task record holds
a pointer. The root task uses the host's stack, so its image occupies runtime
static storage instead. The runtime clears that image at teardown and clears
completed child pointers before reusing their stacks.

The saved bytes still exist. This change reduces heap record size and allocator
rounding; it does not eliminate CPU state or guarantee lower process memory.
The root static image and each child's context plus any alignment padding must
be counted separately. glibc still performs context switching, including its
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
emits C at O1; the C compiler builds each layout at O0 and O2, under both checked
ARC and tracing. ARC means automatic reference counting without a tracing
collector. Collections and reuse verification are disabled for the counted runs,
and physical freeing is enabled.

These are comparisons between two fwp representations. They do not compare
fwp with C/Rust implementations, or establish zero-cost task abstraction.

## Initial native results

Both jobs in [run 39600508036](https://github.com/e6qu/fun-with-pipes/actions/runs/39600508036)
passed at `c4a6fb0abb70704662f2736a5ee981e62f1b3f31`. All 62 ELF binaries,
including the accompanying service-response checks, have the expected native
architecture. Their C, symbols and disassembly were inspected. An initial excerpt
selector picked a GCC cold error block on some AMD64 binaries; bounded independent
LLVM disassembly corrected those excerpts to the actual task-creation bodies.

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

## Lifetime checks and remaining measurement

A separate C probe excludes ordinary stack copies and checks that objects held
only in saved root/child register images survive collection. Deliberately hiding
those images must exit 191/192; omitting root-state cleanup must exit 193. All ten
omission controls passed across the two hosts. The probe also checks rounding
and signal-mask restoration. Task, scope, cancellation and 72-call service cleanup
regressions pass on both hosts.

The expanded probe adds nine fresh-process samples per layout, memory mode and
optimization level. It alternates execution order. Linux `VmHWM` records the peak
resident memory observed at the post-task-teardown checkpoint, before final
allocator/process exit. This includes startup and shared mappings, not just fwp
values, and is not private physical memory. Elapsed time includes process startup,
output capture and complete exit; these short runs do not isolate switching cost.
Those samples are pending. Do not infer a process-memory or speed improvement
from the smaller heap records alone.

Reproduce with `.github/workflows/numerics.yml`, `suite=task-contexts` and
`native_runner=all`. Full production acceptance remains required; see
[the handoff](../development-state.md).
