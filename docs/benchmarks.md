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

## Operation-only autodiff metadata

[Four-host measurements](measurements/ad-operations-2026-10-15.json) compare
identical ARC programs with operation-only capacity and a control that also
reserves capacity for inputs. All four Linux/macOS hosts report these counts:

| Workload | Input count | Native tape peak, control → operations | Native allocation requests, control → operations |
|---|---:|---:|---:|
| Identity VJP | 4,096 | 131,176 → 32,872 bytes | 6 → 2 |
| Mapped VJP | 4,096 | 262,248 → 163,944 bytes | 10 → 30 |
| Nested gradient | 256 | 28,920 → 16,632 bytes | 19 → 21 |

Numeric managed allocation counts and peak storage are unchanged. The nested
case also reduces requested managed bytes 142,780 → 131,516 and peak charged
managed storage 64,192 → 60,096 bytes. Native and managed peaks are measured
separately and must not be added as a simultaneous peak. Every measured owner
is reclaimed, with zero collections and zero final charged/native tape bytes.

The smaller cold operation buffers grow geometrically. This increases growth
requests in the mapped and nested workloads, despite lower requested bytes and
peak storage; warm workspace reuse remains bounded by the existing budget.
Seven-sample process timings vary by host and workload, so no consistent speedup
is claimed. The control changes reserved capacity, not the new logical offsets;
it isolates storage rather than reproducing every cost of the previous code.

Native instruction inspection on all four hosts shows a register subtraction
for operation offsets and hoisted metadata-base adjustment in backward loops.
Parent loads remain 32-bit, weights 64-bit, and multiplication/addition remain
separate. The report retains hardware/compiler/flags, raw samples and verified
source/binary/disassembly hashes. PR #138 subsequently passed all nine production
jobs and documentation; [history](roadmap-history.md#pr-138-merge-acceptance)
records its accepted merge.

## Autodiff registry growth

[Four-host measurements](measurements/ad-registry-2026-10-15.json) compare identical
ARC gradient batches with geometric registry growth and a control that grows one
slot per request. All four Linux/macOS hosts report these registry counters:

| Simultaneously recorded tapes | Allocation requests, control → geometric | Peak registry bytes, control → geometric |
|---|---:|---:|
| 1 | 1 → 1 | 104 → 104 |
| 256 | 256 → 9 | 26,624 → 26,624 |
| 257 | 257 → 10 | 26,728 → 53,248 |
| 4,096 | 4,096 → 13 | 425,984 → 425,984 |

For 4,096 tapes, total native tape requests fall 8,192 → 4,109. Cumulative
requested registry bytes fall 872,628,224 → 851,864; this is the sum of realloc
request sizes, not physical copied bytes or a peak-memory reduction. Registry
storage is included in tape storage and must not be added again. Peak charged
managed storage remains 294,920 bytes, with 36,867 managed requests and no retains.
Managed counters agree across both variants at every size. All final tape/managed
storage is reclaimed with zero collections.

Spare capacity adds 26,520 live bytes in the 257-tape case. First-free-slot search
remains linear; this change reduces allocation requests, not search complexity.
Seven process samples per case include startup and output and vary across sizes
and hosts, so no general speedup is claimed. The control isolates registry growth
policy and does not reproduce every cost of the previous compiler revision.

Actual instructions on all four hosts branch around realloc when spare capacity
exists, compute doubling/clamping in registers and initialize one 104-byte slot.
Backward instructions also bypass adjoint allocation and clearing at zero active
nodes. Separate positive/negative controls prove empty passes preserve a warm
cache and allocate no private adjoint; interpreter tests prove managed and empty
tapes preserve numeric workspace ownership. Those cache fixes have regression
evidence rather than a timing claim. The report records hardware/compiler/flags,
raw samples, verified archive/source/binary/disassembly hashes and inspection
addresses. [The handoff](development-state.md) records final production acceptance.

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
