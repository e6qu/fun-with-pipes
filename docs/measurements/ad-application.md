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
memory. These measurements do not establish bounded total memory for longer
runs or arbitrary nested differentiation. Measure those components and compare
matched C/Rust work before setting total-memory or language-overhead budgets.
