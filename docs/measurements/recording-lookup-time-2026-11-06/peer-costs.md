# Whole-program time and memory versus C/Rust

The case is **129 coordinates, 199 updates, eight solves per process**, returning
current coordinates. These are the original [four runtime sessions](README.md).

fwp records operations and traverses them backward to compute derivatives.
C and Rust use handwritten derivatives and two reusable coordinate buffers.
The comparison includes those algorithm and allocation differences; it cannot
isolate language or ARC overhead. All implementations check the same expected
output. fwp captures its immutable initial input once; C/Rust initialize input
inside each call. Equal input-allocation work is not claimed.

## Elapsed time

Median milliseconds per sample: seven fresh processes, 56 solves in total,
including startup and output. Reference is fwp with only lookup reuse disabled.
A ratio of 12× means twelve times the elapsed time, or 1,100% extra time.

| Session | fwp ms | Reference ms | C ms | Rust ms | fwp / C | fwp / Rust |
|---|---:|---:|---:|---:|---:|---:|
| ARM-1 | 147.800 | 150.552 | 11.980 | 12.098 | 12.34× | 12.22× |
| ARM-2 | 147.883 | 150.606 | 11.962 | 12.193 | 12.36× | 12.13× |
| AMD-1 | 190.173 | 186.264 | 10.464 | 11.157 | 18.17× | 17.05× |
| AMD-2 | 190.772 | 183.606 | 10.364 | 11.050 | 18.41× | 17.27× |

This remains a large complete-program gap, not evidence of parity with C/Rust.
Swift is not measured in this batch; the separate [Swift allocation comparison](../swift-allocations.md)
keeps its own inputs, timing scope and allocator distinctions.

## Whole-process peak memory

GNU `time -v` maximum RSS in KiB from a separate, untimed process per executable.
It includes runtime/library pages and allocator overhead. These are observations,
not a repeat-sampled RSS comparison; they establish no consistent memory reduction.

| Session | fwp KiB | Reference KiB | C KiB | Rust KiB |
|---|---:|---:|---:|---:|
| ARM-1 | 1,824 | 1,764 | 1,384 | 1,636 |
| ARM-2 | 1,824 | 1,760 | 1,384 | 1,636 |
| AMD-1 | 2,412 | 2,108 | 1,544 | 2,276 |
| AMD-2 | 2,304 | 2,172 | 1,544 | 2,184 |

For each eight-solve fwp process, managed storage requests are 4,361, requested
bytes 5,005,064, retains 8 and peak charged bytes 11,584. Raw derivative storage
peaks at 33,904 bytes; both tracked kinds finish at zero after shutdown. Those
counts are unchanged versus reference, in both sessions and architectures.
They exclude allocator overhead and are not RSS. Do not add these peaks to RSS
or sum separately observed peaks as if they happened together.
The [census](../recording-lookup-census-2026-11-06/README.md) also checks workspace-off
behavior and fresh process costs.

## Code and stack costs

Linked instruction bytes and whole executable bytes for this case. Both sessions
of each architecture agree. Code size is reported separately from performance.

| Architecture | fwp instructions | Reference instructions | fwp file | Reference file | Largest fwp/reference frame |
|---|---:|---:|---:|---:|---:|
| ARM64 | 41,500 | 45,308 | 143,400 | 143,448 | 2,240 |
| AMD64 | 43,538 | 43,090 | 88,624 | 84,552 | 2,192 |

Individual-frame reports do not bound total call-stack use. Dynamic qualifications,
full code, section tables and compiler commands remain in the retained evidence.
The source review and safety checks establish the lifetime proof; timing results
do not establish why an architecture speeds up or slows down.
