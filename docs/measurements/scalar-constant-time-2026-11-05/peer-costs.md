# Whole-program time and memory versus C/Rust

The case is **129 coordinates, 199 updates, eight solves per process**, returning
final coordinates. Every implementation checks against the same expected output.
These are the original samples from the [four runtime sessions](README.md).

fwp computes derivatives by recording operations and traversing them backward.
C and Rust use handwritten derivatives with two reusable coordinate buffers.
The table measures the cost of these complete implementations, including the
derivative algorithm difference. It cannot isolate language or ARC overhead.

## Elapsed time

Median milliseconds per sample: seven fresh processes, 56 solves total, including
startup and output. “Reference” is fwp with only scalar replacement disabled.
A ratio of 12.34× means fwp takes 12.34 times the peer's elapsed time (1,134% more).

| Session | fwp ms | Reference ms | C ms | Rust ms | fwp / C | fwp / Rust |
|---|---:|---:|---:|---:|---:|---:|
| ARM-1 | 150.892 | 157.363 | 12.228 | 12.392 | 12.34× | 12.18× |
| ARM-2 | 148.090 | 154.468 | 10.644 | 10.533 | 13.91× | 14.06× |
| AMD-1 | 187.752 | 200.018 | 11.592 | 12.187 | 16.20× | 15.41× |
| AMD-2 | 186.568 | 199.198 | 11.411 | 12.013 | 16.35× | 15.53× |

The constant optimization reduces some execution cost, but the complete-program
gap remains large. These results do not establish parity with C/Rust or explain
which remaining operation causes the gap. Swift is not measured in this batch;
the separate [Swift allocation comparison](../swift-allocations.md) keeps its own
inputs and scope.

## Whole-process peak memory

GNU `time -v` maximum RSS in KiB, from one separate process per executable.
This includes runtime/library pages and allocator overhead. It differs from
[managed allocation and live-storage counters](../scalar-constant-census-2026-11-05/README.md).

| Session | fwp KiB | Reference KiB | C KiB | Rust KiB |
|---|---:|---:|---:|---:|
| ARM-1 | 1,752 | 1,824 | 1,384 | 1,760 |
| ARM-2 | 1,760 | 1,760 | 1,384 | 1,636 |
| AMD-1 | 2,408 | 2,172 | 1,544 | 2,188 |
| AMD-2 | 2,172 | 2,280 | 1,544 | 2,136 |

RSS varies across these observations; it does not establish a consistent process
memory reduction. Managed allocations, raw derivative storage and final cleanup
are unchanged and verified separately.

## Code and stack costs

Linked instruction bytes and executable bytes for this same case; both sessions
of each architecture agree. Size is reported separately from speed.

| Architecture | fwp instructions | Reference instructions | fwp file | Reference file |
|---|---:|---:|---:|---:|
| ARM64 | 41,132 | 41,308 | 143,360 | 143,560 |
| AMD64 | 43,058 | 43,218 | 84,488 | 84,688 |

Maximum reported frames remain 2,240 bytes on ARM64 and 2,192 on AMD64 for both
compilers. These individual-frame reports do not bound total stack usage;
[the stack audit](../scalar-constant-census-2026-11-05/README.md#stack-costs-are-unchanged)
retains dynamic entries. Full code, section tables and compiler settings remain
in the runtime bundles.
