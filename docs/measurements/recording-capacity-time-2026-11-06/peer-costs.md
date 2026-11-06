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
startup/output. Reference means fwp with only the checked capacity routine recombined.
A 12× ratio means twelve times the elapsed time, or 1,100% extra time.

| Session | fwp ms | Reference ms | C ms | Rust ms | fwp / C | fwp / Rust |
|---|---:|---:|---:|---:|---:|---:|
| ARM-1 | 123.556 | 135.562 | 11.396 | 11.592 | 10.84× | 10.66× |
| ARM-2 | 125.067 | 137.048 | 12.450 | 12.563 | 10.05× | 9.96× |
| AMD-1 | 153.185 | 176.172 | 11.331 | 12.034 | 13.52× | 12.73× |
| AMD-2 | 150.099 | 174.566 | 10.768 | 11.395 | 13.94× | 13.17× |

fwp remains about 10–14× slower in this complete-program comparison; this is not
parity with C/Rust. Swift is outside this batch. Its separate
[allocation comparison](../swift-allocations.md) retains its own workload and
allocator distinctions.

## Whole-process peak memory

GNU `time -v` maximum RSS in KiB from one separate untimed process per executable.
It includes library pages and allocator overhead. These are individual observations,
not repeated RSS comparisons, and establish no consistent process-memory reduction.

| Session | fwp KiB | Reference KiB | C KiB | Rust KiB |
|---|---:|---:|---:|---:|
| ARM-1 | 1,828 | 1,764 | 1,384 | 1,624 |
| ARM-2 | 1,756 | 1,764 | 1,384 | 1,760 |
| AMD-1 | 2,108 | 2,176 | 1,544 | 2,148 |
| AMD-2 | 2,108 | 2,176 | 1,544 | 2,308 |

Each eight-solve fwp process makes 4,361 managed allocation requests for 5,005,064
bytes, with 8 retains and 11,584 peak charged bytes. Raw tape storage peaks at
33,904 bytes. Both counters finish at zero. These counts match the reference in
both architectures and sessions. They exclude allocator overhead and are not RSS;
do not add separate peaks as though they happened together.
The [census](../recording-capacity-census-2026-11-06/README.md) also checks workspace-off
and fresh-process costs.

## Code and compilation

Linked instruction bytes, whole executable bytes and largest reported individual
frame for this case. Both sessions of each architecture agree. Dynamic-stack
qualifications remain in the full reports; frames do not bound total stack use.

| Architecture | fwp instructions | Reference instructions | fwp file | Reference file | Largest fwp/reference frame |
|---|---:|---:|---:|---:|---:|
| ARM64 | 42,604 | 42,380 | 143,424 | 143,424 | 2,256 / 2,256 |
| AMD64 | 44,498 | 44,306 | 88,640 | 88,640 | 2,192 / 2,192 |

Native C compilation elapsed seconds, one command per version/session. These
untimed-build observations are separate from runtime samples and do not establish
a repeat-sampled C compiler cost. The [fwp compiler comparison](../recording-capacity-analysis-2026-11-06/README.md)
measures startup through C emission separately.

| Session | Candidate GCC seconds | Reference GCC seconds |
|---|---:|---:|
| ARM-1 | 1.260 | 1.233 |
| ARM-2 | 1.255 | 1.280 |
| AMD-1 | 1.407 | 1.384 |
| AMD-2 | 1.313 | 1.309 |
