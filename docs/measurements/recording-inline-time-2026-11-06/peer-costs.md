# Whole-program time and memory versus C/Rust

Workload: **129 coordinates, 199 updates, eight solves per process**, returning
current coordinates. These are the original [four runtime sessions](README.md).

fwp records operations and traverses them backward to compute derivatives. C and
Rust use handwritten derivatives and two reusable coordinate buffers. Ratios
include those algorithm/allocation differences; they do not isolate language or
ARC overhead. All outputs are checked. fwp captures immutable initial input once;
C/Rust initialize it inside each call. Equal input-allocation work is not claimed.

## Elapsed time

Median milliseconds per sample: seven fresh processes and 56 solves, including
startup/output. Reference means fwp with only forced append inlining disabled.
A 12× ratio means twelve times the elapsed time, or 1,100% extra time.

| Session | fwp ms | Reference ms | C ms | Rust ms | fwp / C | fwp / Rust |
|---|---:|---:|---:|---:|---:|---:|
| ARM-1 | 135.539 | 146.822 | 11.417 | 11.568 | 11.87× | 11.72× |
| ARM-2 | 137.169 | 148.648 | 12.514 | 12.626 | 10.96× | 10.86× |
| AMD-1 | 175.115 | 189.658 | 10.023 | 10.735 | 17.47× | 16.31× |
| AMD-2 | 174.489 | 189.917 | 10.373 | 11.066 | 16.82× | 15.77× |

fwp remains about 11–17× slower in this complete-program comparison; this is not
parity with C/Rust. Swift is outside this batch. Its separate
[allocation comparison](../swift-allocations.md) retains its own workload and
allocator distinctions.

## Whole-process peak memory

GNU `time -v` maximum RSS in KiB from one separate untimed process per executable.
It includes library pages and allocator overhead. These are individual observations,
not repeated RSS comparisons, and establish no consistent process-memory reduction.

| Session | fwp KiB | Reference KiB | C KiB | Rust KiB |
|---|---:|---:|---:|---:|
| ARM-1 | 1,812 | 1,812 | 1,384 | 1,628 |
| ARM-2 | 1,764 | 1,756 | 1,384 | 1,636 |
| AMD-1 | 2,304 | 2,112 | 1,540 | 2,252 |
| AMD-2 | 2,304 | 2,176 | 1,544 | 2,288 |

Each eight-solve fwp process makes 4,361 managed allocation requests for 5,005,064
bytes, with 8 retains and 11,584 peak charged bytes. Raw tape storage peaks at
33,904 bytes. Both counters finish at zero. These counts match the reference in
both architectures and sessions. They exclude allocator overhead and are not RSS;
do not add separate peaks as though they happened together.
The [census](../recording-inline-census-2026-11-06/README.md) also checks workspace-off
and fresh-process costs.

## Code and compilation

Linked instruction bytes, whole executable bytes and largest reported individual
frame for this case. Both sessions of each architecture agree. Dynamic-stack
qualifications remain in the full reports; frames do not bound total stack use.

| Architecture | fwp instructions | Reference instructions | fwp file | Reference file | Largest fwp/reference frame |
|---|---:|---:|---:|---:|---:|
| ARM64 | 42,380 | 41,500 | 143,416 | 143,416 | 2,256 / 2,240 |
| AMD64 | 44,306 | 43,538 | 88,632 | 88,640 | 2,192 / 2,192 |

Native C compilation elapsed seconds, one command per version/session. These
untimed-build observations are separate from runtime samples and do not establish
a repeat-sampled C compiler cost. The [fwp compiler comparison](../recording-inline-analysis-2026-11-06/README.md)
measures startup through C emission separately.

| Session | Candidate GCC seconds | Reference GCC seconds |
|---|---:|---:|
| ARM-1 | 1.218 | 1.190 |
| ARM-2 | 1.249 | 1.199 |
| AMD-1 | 1.279 | 1.263 |
| AMD-2 | 1.280 | 1.251 |
