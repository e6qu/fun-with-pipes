# Word-frequency application: first C/Rust comparison

The maintained [word-frequency program](../../examples/wordfreq.fwp) reads text,
normalizes words, counts them and prints five results. This comparison gives the
memory/performance roadmap a complete application with fixed inputs.
It does not establish a language-wide overhead or an improvement over older fwp.
For current collector-free costs and new-work limits, use the
[four-session baseline](wordfreq-current.md).

The recorded [source protocol](https://github.com/e6qu/fun-with-pipes/blob/74263bccf8e2e67865e1863e2c04a296a97877bb/docs/application-acceptance.md#word-frequency-comparison) explains
the algorithms, input generation, controls and known differences. In particular,
all peers count with sorted contiguous pairs, but C/Rust combine normalization
into one pass. fwp expresses three operations and uses its string/list/map layouts.
The ASCII inputs do not compare general Unicode behavior.

## Results

Source `74263bccf8e2e67865e1863e2c04a296a97877bb`, retained as
`roadmap/revision-wordfreq-74263bccf8e2`, passed both complete jobs in
[run 39690307737](https://github.com/e6qu/fun-with-pipes/actions/runs/39690307737).
The [full report](wordfreq-2026-10-22.json) retains all samples, CPU/compiler
details, flags, inputs and binary hashes. Eight executed binaries were also
independently checked for their hashes, ELF architecture and absent ARC tracing
symbols. Final delivery acceptance remains separate from these measurements.

Times below are medians of sixteen fresh processes after two warmups. They include
startup, reading, normalization, counting, ranking, printing and cleanup. Input
generation and compilation are excluded. Native GCC O2 and Rust opt-level 2 are
explicit; Rust retains overflow checks. Order rotates and reverses equally.

| Host | Words / distinct words | C ms | Rust ms | fwp ARC ms | fwp tracing ms | ARC / C | ARC / Rust |
|---|---:|---:|---:|---:|---:|---:|---:|
| Linux AMD64 | 4,096 / 64 | 1.467 | 1.927 | 3.053 | 3.050 | 2.08× | 1.58× |
| Linux AMD64 | 65,536 / 1,024 | 10.776 | 15.492 | 37.979 | 39.403 | 3.52× | 2.45× |
| Linux ARM64 | 4,096 / 64 | 1.308 | 1.695 | 2.896 | 2.984 | 2.21× | 1.71× |
| Linux ARM64 | 65,536 / 1,024 | 10.039 | 12.973 | 33.012 | 34.803 | 3.29× | 2.54× |

For the larger case, ARC takes about **229–252% more time than C** and
**145–154% more than Rust**. These are two runner sessions. Repeat measurements
on the same hosts before choosing a timing budget or claiming a change helped.
Small ARC/tracing differences here do not establish a general winner.

## Storage and remaining work

Both hosts and both fwp modes give the same managed counts:

| Input words | Allocation requests | Requested bytes | Retains | Peak managed charge | Final managed charge |
|---|---:|---:|---:|---:|---:|
| 4,096 | 24,865 | 668,304 | 8,650 | 557,064 | 0 |
| 65,536 | 397,353 | 10,692,144 | 138,250 | 8,912,904 | 0 |

ARC collects zero times; tracing collects once for the larger input. The counters
cover execution after constant initialization through cleanup. They exclude raw
buffers, stacks and allocator metadata; requested bytes and allocator-charged
bytes are different quantities. No C/Rust allocation-count parity is claimed.

Separate fresh-process samples put larger-case peak resident memory at roughly
4.4–4.6 MB for C, 6.1–6.3 MB for Rust and 11.5–12.6 MB for fwp ARC. Each is one
sample per host/implementation, including process startup and library storage.
It is not a retained-memory measurement, and it must not be subtracted from the
managed counters to infer a particular runtime component's cost.

The [unchanged-text comparison](unchanged-text.md) follows this baseline. It
removes copies when case conversion, trimming or replacement leave bytes
unchanged, checks aliases and cleanup, and measures old/new generated programs
in the same runner session. That report owns the candidate's counts, timing and
acceptance status; this page preserves the original C/Rust baseline.
