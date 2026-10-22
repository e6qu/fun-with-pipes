# Gradient descent: keeping weights without keeping their history

The [autodiff tutorial](../tutorials/20-autodiff-and-devices/README.md) minimizes
Rosenbrock's function by repeatedly subtracting a small multiple of its gradient.
A gradient contains one derivative per input coordinate. Both programs here use
the same objective, reverse-mode differentiation and step size.

`iterate 200 descend | last` builds a history containing the initial weights and
199 updates, then selects its last entry. An explicit counted loop performs the
same 199 updates while keeping only the current weights. The comparison asks
what storing that history costs. It does **not** compare fwp with C/Rust or show
a new compiler optimization. The history form remains useful when callers need
intermediate weights; removing it would change those programs' behavior.

[The protocol](../application-acceptance.md#descent-with-and-without-a-saved-history)
names the inputs and checks. Source `4815e3d16c349ad5af2ecca9fe313924dfa00985`,
retained as `roadmap/revision-ad-application-4815e3d16c34`, passes both Linux jobs
in [run 39692176065](https://github.com/e6qu/fun-with-pipes/actions/runs/39692176065).
The [full data](ad-application-2026-10-22.json) includes samples, generated-C and
binary hashes, build commands and independent inspection of 24 executed binaries.
This focused evidence is separate from final platform acceptance.

## Time

GCC O2, disabled link-time optimization and enabled derivative workspace reuse
are explicit. Each median covers sixteen fresh processes after two warmups,
with rotating and reversed execution order. Timing includes process startup,
calculation, printing and cleanup; it excludes compilation, interpreter checks
and separate memory instrumentation. Hosts are AMD EPYC 9V45 (AMD64) and
Neoverse N2 (ARM64). These are one runner session per host, not repeated-host
estimates of a stable speedup.

| Linux host | Coordinates | ARC history ms | ARC loop ms | Loop / history | Tracing history ms | Tracing loop ms |
|---|---:|---:|---:|---:|---:|---:|
| AMD64 | 3 | 1.493 | 1.503 | 1.006× | 1.687 | 1.369 |
| AMD64 | 33 | 7.449 | 7.325 | 0.983× | 7.147 | 7.429 |
| AMD64 | 129 | 24.525 | 24.101 | 0.983× | 24.084 | 23.457 |
| ARM64 | 3 | 1.913 | 1.909 | 0.998× | 1.902 | 2.152 |
| ARM64 | 33 | 11.256 | 11.162 | 0.992× | 11.454 | 11.130 |
| ARM64 | 129 | 41.470 | 40.021 | 0.965× | 41.100 | 39.950 |

The ARC loop takes about 1.7–3.5% less median time at 129 coordinates. Small
cases and tracing results are mixed, including slower loops. The large storage
reduction below is not a similarly large timing reduction.

## Managed storage and remaining costs

Both hosts and both memory modes give these counts:

| Coordinates | History requests | Loop requests | History retains | Loop retains | History peak bytes | Loop peak bytes |
|---|---:|---:|---:|---:|---:|---:|
| 3 | 25,878 | 25,477 | 16,321 | 15,920 | 32,032 | 896 |
| 33 | 282,618 | 282,217 | 219,301 | 218,900 | 224,032 | 6,896 |
| 129 | 1,104,186 | 1,103,785 | 868,837 | 868,436 | 845,424 | 26,288 |

Each loop removes 401 allocation requests, 401 retains and 11,208 requested
bytes. At 129 coordinates the peak managed charge falls about 96.9%, yet over a
million allocation requests remain. Most allocation/count traffic therefore
comes from the repeated gradient and weight updates, not the saved history.
This identifies a useful next investigation; it does not locate every cost.

All measured cases finish with zero managed charge, zero collections and no
live or owned derivative tapes before runtime shutdown. Deliberately leaving a
tape registered makes the independent observer fail. Raw interpreter outputs
match native output exactly; a handwritten analytic derivative independently
checks final coordinates within absolute/relative tolerance `1e-10`.

Managed counters exclude raw tape buffers, allocator metadata, stack storage and
process resident memory. Peak managed charge is not total differentiation
memory. The extension below measures raw storage and resident memory separately.
Neither experiment establishes bounded total memory for arbitrary nested
differentiation. Matched C/Rust work is still needed for language-overhead budgets.

## Raw derivative buffers and process memory

The extended experiment passes both Linux jobs in [run 39739049666](https://github.com/e6qu/fun-with-pipes/actions/runs/39739049666),
source `be8d87f0e56cb6bb496716d102b0b89bff6d9000` (tag
`roadmap/revision-ad-storage-be8d87f0e56c`). The [complete results](ad-storage-2026-10-22.json)
retain samples, build commands, environment details and inspection of 104 executed
ELF binaries, including deliberately broken cleanup controls. Repeated identical
checkpoints use a lossless count/value encoding. The earlier results above remain
a separate session: the AMD64 CPU changed from EPYC 9V45 to EPYC 7763.
The ARM64 host is Neoverse N2; both use GCC 13.3 O2 without LTO.

Raw storage means successful allocator requests for the tape registry, parent
indices, local derivatives and backward-pass adjoints. It excludes allocator
metadata and temporary copies inside realloc. The ledger observes actual frees;
forgetting a pointer cannot hide live storage. It records idle storage after
every backward pass and verifies zero live bytes after real shutdown. Omitting
a parent-buffer or registry free makes its corresponding control fail.

Both hosts give these loop results with workspace reuse enabled. The final
column compares allocation requests with reuse enabled and disabled; these are
separate untimed runs. Retained workspace is storage kept for the next update.

| Coordinates | Updates | Peak raw bytes | Raw bytes before shutdown | Requests, reuse on / off |
|---|---:|---:|---:|---:|
| 3 | 0 | 0 | 0 | 0 / 0 |
| 3 | 199 | 1,792 | 1,792 | 4 / 598 |
| 3 | 1999 | 1,792 | 1,792 | 4 / 5,998 |
| 33 | 199 | 8,560 | 8,560 | 8 / 1,394 |
| 129 | 199 | 33,904 | 33,904 | 12 / 2,190 |

The registry and workspace stay constant after every update in each selected
case; all other raw derivative storage is zero at those checkpoints. All cases
finish with zero raw bytes. Extending the three-coordinate run from 199 to 1,999
updates does not increase its retained workspace. This verifies these bounded
runs, not arbitrary nesting, tape-generation exhaustion or indefinite execution.

The same sixteen-sample fresh-process timing protocol gives the table below.
Peak RSS is resident process memory from a separate uninstrumented GNU time run,
including runtime, allocators and other process storage. It is not an allocation
count, and its peak need not coincide with managed or raw storage peaks. Do not
add these quantities. Startup costs matter for the smallest cases.

| Host | Coordinates | Updates | ARC history ms | ARC loop ms | Loop / history | Loop peak RSS bytes |
|---|---:|---:|---:|---:|---:|---:|
| AMD64 | 3 | 0 | 1.425 | 1.377 | 0.967× | 3,973,120 |
| AMD64 | 3 | 199 | 2.376 | 2.254 | 0.949× | 3,899,392 |
| AMD64 | 3 | 1999 | 11.250 | 11.298 | 1.004× | 4,030,464 |
| AMD64 | 33 | 199 | 12.533 | 12.534 | 1.000× | 4,161,536 |
| AMD64 | 129 | 199 | 47.292 | 43.502 | 0.920× | 4,370,432 |
| ARM64 | 3 | 0 | 1.121 | 1.106 | 0.987× | 1,433,600 |
| ARM64 | 3 | 199 | 2.042 | 2.151 | 1.053× | 1,449,984 |
| ARM64 | 3 | 1999 | 10.304 | 9.968 | 0.967× | 1,445,888 |
| ARM64 | 33 | 199 | 11.564 | 11.281 | 0.976× | 1,449,984 |
| ARM64 | 129 | 199 | 41.059 | 40.141 | 0.978× | 1,978,368 |

The ARM64 199-update, three-coordinate loop is 5.3% slower than its history
variant; other cases are mixed. These comparisons measure two fwp program forms,
not fwp overhead relative to C/Rust. The experiment adds measurements and cleanup
controls; it does not change the differentiation algorithm or establish a general
speedup. Equivalent-work C/Rust baselines and repeated-host budgets remain needed.
