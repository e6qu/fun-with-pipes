# Benchmarks

Roadmap measurements are recorded in:

- [Numerical kernels](measurements/numerical-kernels-2026-10-12.json): equivalent
  numerical and autodiff workloads on Linux and ARM/Intel macOS, with runner,
  compiler, flags and measurement scope.
- [Ownership and checked ARC](measurements/ownership-and-arc-2026-10-12.json):
  allocation/live-memory and ownership controls, ARC executions and rejections,
  binary evidence and the aggregate-return regression follow-up.
- [Native platform and ownership bundle](measurements/native-ownership-2026-10-13.json):
  paired iterator controls on Linux/macOS ARM64/AMD64, actual checked register
  arithmetic, ARC scope omission controls and cold/warm workspace counts.

- [Reconstruction and native workers](measurements/reconstruction-and-workers-2026-10-13.json):
  direct producer/State allocation controls, I128/U128 native register arithmetic,
  reconstruction ownership and refreshed numerical/AD evidence for PR #133.

- [Wide scalar and record workers](measurements/wide-records-2026-10-14.json):
  four-host I128/U128/F128 and mixed-record allocation, retention, live storage
  and native-instruction controls.
- [Checkpointed autodiff](measurements/checkpoint-2026-10-14.json): four-host
  4096-step VJP comparisons at intervals 16/32/64. Smaller peak tape storage
  costs more managed storage, allocations and time; all measured storage is
  reclaimed without collection.

Reports distinguish preparation measurements from production acceptance.
[History](roadmap-history.md) indexes accepted gates; [the handoff](development-state.md)
records the latest tested source. These results do not establish universal C/Rust
parity. Iterator measurements use the current compiler, dynamic input and paired
consumer-fusion controls. `scripts/measure-iteration.py` retains generated C,
native instructions, allocation/retain counts, charged live storage and separate
process timings on each Linux/macOS architecture. Timing includes startup and
output; it is not kernel throughput. Direct count-from/from-list chains avoid
per-step producer allocation, and known State updates call their entries directly.
Other lazy producers and dynamic callbacks retain their declared behavior.
Fold-until and map-accum remain measured controls, without a
claimed allocation improvement. The [handoff](development-state.md) records the
measurement revisions and final acceptance gates.

## Numeric backward prefix

[Four-host native measurements](measurements/ad-prefix-2026-10-14.json) compare
the same ARC program with bounded backward work and a full-prefix control.
Both record 12,291 nodes; only the three inputs are seeded. Bounding adjoints
reduces peak tape storage from 491,648 to 393,344 bytes (98,304 bytes, about
20%) and avoids scanning 12,288 unused operation nodes. Tape allocation request
counts stay at 38; requested bytes fall from 883,328 to 785,024. Managed counts
and peak storage are unchanged, and all measured storage is reclaimed without GC.

| Native host | Bounded process median | Full-prefix control |
|---|---:|---:|
| Linux AMD64 | 2.943 ms | 2.913 ms |
| Linux ARM64 | 2.466 ms | 2.536 ms |
| macOS ARM64 | 9.547 ms | 9.575 ms |
| macOS AMD64 | 13.754 ms | 13.588 ms |

These seven-sample process timings include startup/output and show no consistent
speedup. The result establishes reduced storage and reverse scanning for this
workload, with forward work unchanged. Workspace reuse is disabled for the
comparison; existing larger cached buffers can remain within their fixed budget.
The artifact records compiler/flags, hardware, raw samples, allocation counts,
source/binary/disassembly hashes and native instruction inspection. Generated C,
binaries and disassembly are retained by the linked runner artifacts.

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
