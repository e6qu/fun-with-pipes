# Matching local callbacks without temporary tuples

A program can put a function and an optional value in a tuple, then match them.
The [tacit example in the design guide](../design.md#numerical-specialization)
returns `5` for `(add 1, Some 4)` and `0` for `(add 1, None)`. Each pattern hole
supplies an argument to the selected arm. The function value is an ordinary tuple
field; it is not a new calling convention or implicit conversion.

The compiler now binds nontrivial fields once, in order, before matching the
relevant field directly. This exposes existing direct-call and receive-result
optimizations. Effects and trapping constants still evaluate even when an arm
ignores their fields. Whole-tuple uses, multiple tested fields and protected
original resource bindings keep their existing lowering.

## What was measured

The baseline is PR #177's selected receive implementation, `a44d52a1`, run
`39372647179`. The candidate is `7a0c93ef4704b9443533f81e1c9c4a76e4179770`, [run 39396074107](https://github.com/e6qu/fun-with-pipes/actions/runs/39396074107).
[The audited report](channel-match-counts-2026-10-20.json) records 180 count samples
and hashes of 20 ordinary binaries, their C and disassembly.

Both revisions run the same five sequential channel programs at 0, 16 and 1024
messages, with three fresh profiles per input, in ARC and tracing modes.
Hosts are AMD EPYC 7763 and Neoverse-N2; GCC 13.3.0 uses O2 with LTO disabled and
floating-point contraction disabled. Raw interpreter and native outputs agree.
The [protocol](channel-transfer-protocol.md) defines each program and counter.
This compares fwp revisions: no execution timing or equivalent C/Rust peer was
measured, so these results do not establish a speedup or parity with C/Rust.

Both architectures have these ARC operations per additional message, calculated
from the count difference between inputs 16 and 1024:

| Program | Allocation requests, before → after | Retains, before → after |
|---|---:|---:|
| Fresh text | 1 → 1 | 2 → 2 |
| Fresh function | 5 → 2 | 3 → 2 |
| Shared text | 0 → 0 | 4 → 4 |
| Shared function | 3 → 1 | 7 → 6 |
| Closed function | 2 → 2 | 1 → 1 |

Fresh functions save the receive wrapper and two temporary callbacks; shared
functions save the receive wrapper and one callback. Calling a received function
still uses dynamic dispatch. The fresh function and its string result still need
storage; the shared-function program also allocates its comparison string on each
iteration. Queue setup and buffers remain. This is not a zero-allocation channel.

At 1024 messages, peak charged storage falls by 48 bytes for fresh functions and
16 for shared functions on each host. All ARC profiles finish with zero charged
storage and no collections. Charges exclude raw buffers, allocator metadata,
stacks and total process memory. Tracing profiles give the same operation-count
changes for these inputs.

## Actual machine code

The ordinary ARC binaries change as follows; unchanged cases have zero deltas:

| Program | AMD64 `.text` bytes | ARM64 `.text` bytes | File bytes, AMD64 / ARM64 |
|---|---:|---:|---:|
| Fresh function | −4336 | −64 | −5336 / −1136 |
| Shared function | −2832 | −2496 | −4688 / −520 |

The fresh-function ARM64 binary adds a 4096-byte load/branch-stub and padding
region, offsetting most of its function-code reduction. In tracing mode that
case's `.text` grows by 48 bytes while its file shrinks by 1136; this linked-layout
cost is retained in the comparison. Other changed tracing code sections shrink.
File size includes linker layout and metadata, not just executed instructions.

The ARC exchange frames shrink from 568 to 328 bytes for fresh functions and
584 to 392 for shared functions on AMD64. ARM64 frames shrink from 480 to 320
and 528 to 368 respectively. AMD64 totals include saved registers but exclude
return addresses; ARM64 includes saved registers and the link register. These
are individual frames, excluding callees and total task-stack peaks.

Generated C receives tag and payload directly and calls the known transformations
without constructing their partial-application objects. Actual disassembly
establishes the frame measurements; inspecting C alone would not establish them.

## Correctness checks and remaining acceptance

Both focused jobs pass 17 checks with none ignored or filtered, including
callback-effect tests, type-checker snapshots, ordered
constant/effect regressions and direct-call checks. Native examples compare raw
interpretation with optimized interpretation and O0/O2 in both memory modes.
Tracing runs use GC stress, GC verification and reuse verification. ARC runs
physically release storage and reject those tracing/retained-storage options.
Revision tag `roadmap/revision-channel-match-7a0c93ef` preserves the measured source.
The final delivery also includes the tacit example in the native/GC/WASI golden
program. All nine final-head production gates and documentation remain required.

Two earlier focused runs failed because the new test incorrectly enabled those
options for ARC. Both complete logs were reviewed, the settings were corrected,
and the test now collects all four native combinations before reporting failures.
Those failed workflows are not acceptance, even though their count steps passed.
