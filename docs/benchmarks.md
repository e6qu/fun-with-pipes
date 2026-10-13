# Benchmarks

The accepted roadmap measurements are recorded in:

- [Numerical kernels](measurements/numerical-kernels-2026-10-12.json): equivalent
  numerical and autodiff workloads on Linux and ARM/Intel macOS, with runner,
  compiler, flags and measurement scope.
- [Ownership and checked ARC](measurements/ownership-and-arc-2026-10-12.json):
  allocation/live-memory and ownership controls, ARC executions and rejections,
  binary evidence and the aggregate-return regression follow-up.

Reports distinguish preparation measurements from production acceptance.
[History](roadmap-history.md) indexes accepted gates; [the handoff](development-state.md)
records the latest tested source. These results do not establish universal C/Rust
parity. Iterator measurements use the current compiler, dynamic input and paired
consumer-fusion controls. `scripts/measure-iteration.py` retains generated C,
native instructions, allocation/retain counts, charged live storage and separate
process timings on each Linux/macOS architecture. Timing includes startup and
output; it is not kernel throughput. Producer Yield values and lazy tail closures
still allocate. Fold-until and map-accum remain measured controls, without a
claimed allocation improvement. The [handoff](development-state.md) records the
measurement revisions and final acceptance gates.

## Running comparisons

Run full workloads on GitHub runners. `bench/<name>/` contains fwp, C and Rust
programs with matching output. `tests/bench.rs` builds them with `fwp build -O2`,
`cc -O2` and `rustc -O`, checks output agreement and reports the best of three runs:

```sh
cargo test --release --test bench -- --ignored --nocapture
```

Results go to stdout, `target/bench.md` and the CI `bench` job summary. Assert
outputs and stable allocation properties, not noisy shared-runner timing bounds.
Record hardware, compiler/version, flags, input sizes, allocation/count totals,
peak live memory and collections. Separate input construction and allocation
from kernel-only timing where applicable.

| Workload | Scope |
|---|---|
| `fib` | Recursive calls and integer arithmetic (`fib 35`) |
| `loop` | Pair-state loop, 100 million iterations |
| `map` | Build from 500,000 pairs, then 2 million lookups |
| `pipeline` | `range \| map \| filter \| sum`, one million elements, 20 rounds |
| `strings` | Format, concatenate and measure two numbers, 2 million rounds |

Matching outputs do not ensure equivalent implementation work. The map comparison
uses sorted arrays in fwp/C and a B-tree in Rust. The fwp string-length optimizer
can avoid formatting that the C/Rust versions still perform. Those workloads
cannot establish equal kernel throughput or a general language speed ratio.
Use equivalent algorithms and actual work for optimization acceptance, and
inspect native instructions when claiming eliminated allocation or dispatch.
