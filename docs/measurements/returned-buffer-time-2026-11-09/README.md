# Returned-array time and process memory

The factory returns an array, a separately compiled function sums it, and the
caller releases it. The shared case adds a second owner, reads again after
releasing the first, then releases the survivor. This measures external function
boundaries and ownership, not every local array expression or copy-on-write.

[Run 42602375928](https://github.com/e6qu/fun-with-pipes/actions/runs/42602375928)
passes both sessions and raw-record audits on both architectures. Source:
`b37b15ac2d636187b97ccd00192e50638bd788d0`, retained as
`roadmap/returned-buffer-time-2026-11-09`. Passing the audit means the measurements
are consistent with their raw records; noisy timing results remain inconclusive.

## What the results establish

Ratios below are **fwp elapsed time / peer elapsed time**. Smaller is faster.
Ranges span the two sessions, not a confidence interval.

| Case | Qualified result in both sessions | Meaning |
|---|---|---|
| ARM64, unique empty arrays | Process: 6.31–6.33× C; 1.63–1.64× Swift | Empty-array construction, calls and release still carry substantial overhead. |
| ARM64, unique length 16 | Process: 1.04× C; 0.569–0.570× Swift | Nearly C's elapsed time overall; about 43% less time than Swift for this workload. |
| ARM64, unique length 262,144 | Process: 0.887–0.902× C; 0.755–0.765× Swift | Lower overall time does not imply a faster reader. |
| ARM64, shared length 4,096 | Process: 2.20–2.22× Rust | A substantial Rust advantage remains; its allocation/representation differs. The cause is not established. |
| ARM64, length 262,144, either owner mode | Reading: 1.20× C; 1.20–1.21× Swift; 1.69–1.73× Rust | The reader is slower even where the complete process is faster. |
| AMD64, shared empty arrays | Process: 1.26–1.29× C; 0.890–0.905× Swift | More time than C, less than Swift; this is a qualified whole-workload difference. |
| AMD64, unique length 16 | Construction: 0.339–0.345× C; 0.209–0.212× Swift | Array construction qualifies separately; whole-process session 2 does not. |

Most AMD64 nonempty whole-process comparisons fail at least one session's
identical-copy control. **There is no two-session AMD64 large-array speed claim.**
Some release intervals are below 5 ms; their large numerical ratios are also
inconclusive. No thresholds were changed and no unchanged experiment was rerun.
[Every phase, absolute median, ratio and qualification](tables.md) is retained,
including adverse and inconclusive results.

## What memory means here

Six additional runs per case/language measure peak process RSS: resident pages
including runtime, allocator and mapped libraries. For four simultaneously live
arrays of 262,144 integers (8 MiB of elements), across both owner modes:

| Host | fwp KiB | C KiB | Rust KiB | Swift KiB |
|---|---:|---:|---:|---:|
| ARM64 | 9,844–9,984 | 9,152–9,216 | 9,864–9,956 | 15,932–15,960 |
| AMD64 | 10,128–10,436 | 9,504–9,648 | 10,168–10,388 | 16,300–16,756 |

See the [per-case RSS table](tables.md) before comparing other lengths.
[Separate native storage profiles](../returned-buffer-phases-2026-11-09/README.md)
measure allocation requests and retained storage. Those are not RSS. fwp uses
managed heap storage; C/Rust/Swift use their ordinary native allocation paths.
This experiment does not isolate ARC-operation cost, allocator-internal peaks,
reservation or committed bytes. ARC operations and maximum stack use remain
unmeasured. fwp unmaps its reservation at shutdown, so exit RSS cannot prove
timely array release; the managed live-byte/omitted-release checks remain necessary.

## Reproduction and evidence

- [Frozen protocol](../returned-buffer-phases.md): C-only pilot, eight original/copy
  executables, two warmup rounds and 16 balanced measured rounds per case/session;
  two sessions on each same host. Each phase needs at least 5 ms and copy medians
  within 2%. Separate GNU-time processes measure RSS.
- ARM64: four Neoverse-N2 CPUs, job `129109750299`. AMD64: four visible CPUs on
  AMD EPYC 7763, job `129109750206`. Both use Linux runners, GCC 13.3, Rust 1.99.1
  and Swift 6.4.2. The reports retain exact OS and architecture settings.
- GCC/generated C use O2, Rust O2 with checked overflow, Swift `-O`; factory and
  caller compile separately without LTO. The fwp compiler emits its actual owned
  entries. Reading includes the retain required before its consuming fold.
- Each exact-source prerequisite job passes 16 phase builds, 120 result/error/
  backward-clock checks and 64 clock-helper controls. The audit checks source/tag,
  manifest and image hashes, actual machine architecture, copies, command exits,
  checksums, pilot selection, sample order, summaries, compile costs and RSS.
- [Artifact identities](artifacts.json), compressed reports and complete job logs
  are retained here. Full archives contain commands, source, binaries, section
  reports and unwind tables. Selected local members have ZIP CRC verification;
  complete artifact ZIP hashes were not independently recomputed locally.

The timing source's docs run failed because its handoff omitted the required
status column. The column was restored without weakening the checker; docs
`42603916827` at `c9bf8dfac` pass. This documentation repair does not change the
frozen measurement source or justify rerunning its timings.

## What to investigate next

Use the qualified empty-array overhead and ARM64 reading gap to select future
source-level investigations. Keep construction, reading, release and memory
boundaries separate: these results do not establish an ARC-specific cause or a
universal advantage over another language. Finish the weak-registration and
parser comparisons in the [current milestone](../../../PLAN.md) before choosing
another narrowly tuned optimization.
