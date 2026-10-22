# Smaller binaries for directly called functions

The compiler previously emitted a generic call adapter for every live function,
even if all calls named the function directly. An adapter unpacks a runtime array
of arguments and invokes the concrete function. The function table kept these
adapters and otherwise unused code in the executable.

For example, `direct = add 7` called by
`read-all () | string.length | direct | echo` needs a direct call. If a program
chooses a function at runtime, stores it and applies it later, that function still
needs an adapter. The preparation removes direct-only adapters and explicitly
keeps service dispatch and transport-created iterator entries. Function IDs,
names, source syntax and arithmetic rules are unchanged.

The mathematical formula is shared, but its evaluation differs: packed fwp
computes each coordinate independently and can recompute an edge residual for
both adjacent coordinates. C/Rust compute that residual once per edge and add
its contributions to both coordinates. This work difference is included in the
ratios alongside allocation, checked indexing and formatting.

## Numerical evidence

[Run 39806328073](https://github.com/e6qu/fun-with-pipes/actions/runs/39806328073)
compares compiler source `e681dc447039cd1ce5fbf4a27add9e96f9238275` with the
[borrowed-capture baseline](array-capture-descent.md). Both jobs pass; all 132
native executable images are independently inspected. The
[raw record](direct-call-entries-2026-10-22.json) includes samples, profiles,
commands, binary hashes, disassembly and frame records.

The work is the same explicit derivative update as the prior report. Each
coordinate/update case runs once per process. All seven timing entries are rebuilt
together: new/old packed fwp, a byte-identical new-fwp copy, explicit list fwp,
automatically differentiated fwp, explicit C and explicit Rust. C/Rust reuse two
buffers while fwp creates an immutable array for each update; formatting differs.
Times include startup, computation, complete output and teardown, with two warmups
and 56 samples per entry in balanced fourteen-round blocks.

AMD64 ran on AMD EPYC 9V45 and ARM64 on Neoverse N2, with GCC 13.3.0 O2 and Rust
1.99.1 O2. Commands preserve checked integer arithmetic, baseline architecture,
no fast-math, disabled floating contraction and no Rust LTO. CPU models differ
from some earlier runs; only programs timed together are compared here.

The code-size goal, recorded in the preparation handoff before measurement, was
smaller instructions for 129×199 on both architectures and no instruction growth
in other packed cases. Both hosts meet it. Generic adapters fall from 18 to two;
the remaining stack function values still retain ownership metadata. The
`next-contribution` helper loses its generic adapter, but the array callback's
stack function value still keeps one. Four static calls to the numerical helper
remain, down from five; this is not a count of dynamically executed calls.

## All measured cases

Instruction bytes count executable instructions, not the whole file. Ratios divide
new packed fwp's median by the named peer's median. Below one is faster;
`2.0× C` means twice the C time. The identical-copy column should be near one;
its difference cannot be caused by a compiler optimization.

| Host | Coordinates-updates | Old instructions | New instructions | New / old | New / identical | New / C | New / Rust |
|---|---|---:|---:|---:|---:|---:|---:|
| x86_64 | 3-0 | 30418 | 23266 | 1.2419 | 1.2184 | 1.6136 | 1.3189 |
| x86_64 | 3-1 | 30498 | 23314 | 1.1558 | 1.1199 | 1.7943 | 1.4809 |
| x86_64 | 3-199 | 30498 | 23314 | 1.0886 | 1.0196 | 1.4419 | 1.0692 |
| x86_64 | 3-1999 | 30498 | 23314 | 0.9737 | 0.9796 | 1.3676 | 1.1108 |
| x86_64 | 33-199 | 35394 | 28882 | 1.1253 | 1.1080 | 1.7092 | 1.2730 |
| x86_64 | 129-199 | 41778 | 34418 | 1.0376 | 1.0475 | 2.2176 | 1.7102 |
| aarch64 | 3-0 | 30844 | 23372 | 1.0013 | 0.9997 | 1.3670 | 1.1149 |
| aarch64 | 3-1 | 30892 | 23420 | 0.9705 | 0.9810 | 1.4246 | 1.1257 |
| aarch64 | 3-199 | 30892 | 23420 | 1.0069 | 0.9826 | 1.4109 | 1.1695 |
| aarch64 | 3-1999 | 30892 | 23420 | 1.0153 | 0.9845 | 1.4549 | 1.1946 |
| aarch64 | 33-199 | 35292 | 28508 | 1.0526 | 1.0171 | 1.7693 | 1.4506 |
| aarch64 | 129-199 | 40172 | 32508 | 1.0014 | 1.0060 | 2.2964 | 1.9013 |

The largest instruction sections shrink about 18% on AMD64 and 19% on ARM64.
The largest managed profile stays at 459 requests, 216,925 requested bytes,
zero retains and a 7,200-byte peak. All six packed cases preserve zero retains;
managed and raw storage finish at zero with no tracing collections. Allocation
requests/bytes and raw derivative profiles are unchanged for the AD and list peers.

Timing is inconclusive: AMD64 identical copies differ by up to 22%, and ARM64's
33-coordinate candidate is 5.3% slower than its baseline. The ARM64 largest case
is almost unchanged. These results support smaller code, not a speed improvement
or parity with C/Rust. The [batched protocol](descent-batch-protocol.md) investigates
startup noise and the apparent slowdowns separately, preserving this report.

## Native validation status

All six hosts in the initial focused native run failed the same new test:
it mistakenly enabled tracing stress in an ARC-only binary. The first repair
still enabled reuse verification, which retains released storage and is also
prohibited in ARC mode. The complete repair enables stress and reuse verification
only for tracing. Both failures remain recorded and are not compiler passes. Existing
callback, ownership, gRPC and queued-function checks passed independently; the [handoff](../development-state.md) records every host and the
repair. Full delivery gates are still required for the final PR head.

The [native artifact record](direct-call-native-2026-10-22.json) preserves all
714 inspected executables/libraries from the individually passing tests, plus
twelve executed WASI modules. It retains the six failed-job statuses and their
only failed test. Native images cover Linux, macOS and Windows on both architectures;
WASI checks 32-bit storage and allocation bounds separately. Inspection verifies
machine types, instructions, output, ownership counters and broken cleanup controls.
A repaired Linux AMD64 run and final delivery CI must pass before merge.
