# Nested resource borrowing: runtime and compiler costs

**Qualified service cases use 16–21% less elapsed time. Full acceptance remains
open: one runtime comparison and one compiler comparison are noisy, and four
ARM64 process-RSS comparisons miss the limit.** No failed/noisy observation was
replaced by another run.

Source `d80357c8c81d206c9d9934b141b5a5fafe97c430`, tag
`roadmap/weak-callback-time-nested-resources-2026-11-10`;
[run 42798403679](https://github.com/e6qu/fun-with-pipes/actions/runs/42798403679).
Reference: `65719f7fc2277a5b97c5a790df941fea6c5eb4d7`.

## What was measured

Each service call constructs a queue, sends 64 or 4,096 messages with 16-integer
payloads, dispatches them and releases service-owned data. Four cases cover full
delivery, cancelling every fourth message, an expired target, and a handled error
after the middle message. Checks preserve every result and checksum.

- Native ARM Neoverse-N2 and AMD EPYC 7763; GCC 13.3.0 O2, no LTO or contraction,
  explicit architecture. Rust 1.99.1 builds both compilers from their exact sources.
- Ordinary programs have no ownership counters or profiler. Service time includes
  entry/result ownership and cleanup, excluding process launch and output checks.
  Complete-process time is also retained. Peak RSS is measured separately.
- Two sessions, 16 balanced rounds per case, original C-only batch selection,
  5 ms minimum and 2% identical-copy limit. Both binaries and identical copies
  are retained. [The contract](../nested-resource-owners.md) fixes all limits.

## Runtime gains and remaining peer gap

| Host | Qualified service comparisons | Less service time | Large-case target |
|---|---:|---:|---|
| ARM64 | 16/16 | 16.1–21.1% | All eight pass |
| AMD64 | 15/16 | 17.5–20.4% | Seven pass; one inconclusive |

AMD64 session 2, 4,096 messages with cancellation, reports a candidate/reference
ratio of 0.7983. Its reference copy differs by **2.134%**, above the frozen 2%
limit, so that apparent gain is not qualified. Every small-case timing target passes.

The separate contemporary peer experiment still shows a substantial gap for
full delivery at 4,096 messages; these ratios qualify in both sessions:

| Host | fwp / C time | fwp / Rust time | fwp / Swift time |
|---|---:|---:|---:|
| ARM64 | 16.70–16.78× | 14.35–14.41× | 4.32–4.34× |
| AMD64 | 14.93–14.94× | 12.64–12.66× | 5.33–5.34× |

For example, 4.32× Swift's time means about 332% more time. The implementations
produce equivalent results but use different queues, layouts and synchronization:
C uses explicit owners, Rust `Rc`/`Weak`, Swift weak references and arrays, and fwp
channels, weak channel references, arrays and a list. This is not an isolated ARC tax.

## Memory: retain the missed limits

[Native counts](../nested-resource-counts-2026-11-10/README.md) show unchanged
allocation requests and peak charged heap. Process RSS includes other memory;
28/32 comparisons meet its 5% limit. The four misses are all ARM64:

| Session | Messages / case | Reference peak, KiB | Candidate peak, KiB | Increase |
|---|---|---:|---:|---:|
| 1 | 64 / delivered | 1,688 | 1,920 | 13.74% |
| 1 | 64 / cancelled | 1,816 | 1,916 | 5.51% |
| 1 | 4,096 / expired | 2,712 | 2,952 | 8.85% |
| 2 | 64 / cancelled | 1,688 | 1,912 | 13.27% |

Each peak is the maximum of three fresh-process observations, not heap bytes or
an exact allocator peak. Candidate readings for the first row are 1,800, 1,920 and
1,672 KiB. [The separate RSS diagnosis](../nested-resource-rss.md) investigates
page categories and Linux counter accuracy; it does not erase these missed limits.

Code and static frame observations provide additional context, not a dynamic
stack bound or a substitute for working-memory measurements:

| Host | Executable bytes, old → new | `.text` bytes, old → new | Largest GCC frame, bytes |
|---|---:|---:|---:|
| ARM64 | 157,576 → 153,720 | 84,844 → 69,500 | 6,144 → 3,632 |
| AMD64 | 168,544 → 140,048 | 97,858 → 78,338 | 7,328 → 4,304 |

The frame columns are per-function reports; called functions, recursion and
dynamic frames prevent treating their maximum as whole-program stack use.

## Compiler work

Ordinary emit-C comparisons cover four complete applications and twelve growing
inputs in two sessions per host. **63/64 qualify and pass** the at-most-2% time
and 5% RSS limits. Maximum observed time increase is 1.61%; maximum compiler RSS
increase is 0.87%. All generated-C agreement and error-diagnostic checks pass.

AMD64 session 2, `generic-128`, has an apparent candidate/reference time ratio of
0.9897, but its candidate-copy ratio is **0.97643**, outside 0.98–1.02. Preserve it
as inconclusive. Compiler RSS passes for every case, including this one.

The separate proof-counter compiler emits byte-identical C for all 16 inputs on
both hosts. The service visits 811 nodes in each main scan plus 247 alias nodes;
HTTP visits 16,385 plus 5,186. Selected parameter sites are 43 and 1,310. These
observations verify the bounded scans on these inputs, not universal compile-time
complexity or speed from instrumented compilation.

## Evidence and checks

- ARM64 job `129769376089`, artifact `13758990658`; AMD64 job `129769376504`,
  artifact `13758139579`. Both complete logs pass review. The only setup warning
  concerns a missing packaged C++ manual page; there are no compiler diagnostics
  or unexpected test failures.
- Both runners reconstruct every raw service result, timing schedule, binary
  identity, RSS reading and service-build observation. Six altered peer reports and
  seven altered reference-comparison reports are rejected per host.
- `arm-reports.zip` and `amd-reports.zip` retain selected reports, raw reference
  command rows, compiler samples, proof observations and GCC stack/section reports.
  `analysis.json` keeps every case, including missed limits. Complete logs, run and
  artifact receipts and hashes are retained alongside them.
- `review-summaries.py` reconstructs reference outputs/durations, service/peer
  summaries, compiler comparisons and proof counts locally. From the repository
  root, use `PYTHONPATH=scripts` and explicit `--input`, `--source`, `--output`.
  Both hosts pass. This local review does not repeat the runner's full binary audit.

Selected ZIP members were CRC-checked. Full 76–79 MB native archives remain on
GitHub; their recorded whole-archive digests were not independently recomputed
locally. [Sustained HTTP load](../nested-resource-http-load-2026-11-10/README.md)
also passes; final platform gates and the RSS investigation remain separate.
