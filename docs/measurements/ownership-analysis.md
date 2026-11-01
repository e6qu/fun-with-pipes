# Cost of the ownership proof

This measures time spent by the compiler checking lifetimes, not the speed of a
compiled program. The latest focused check covers [returned functions](#returned-function-recheck).
Current-source acceptance belongs to
[PLAN.md](../../PLAN.md) and [the handoff](../development-state.md).

## What the compiler proves

A closure is a function plus its captured values. Two closures can call the same
function while holding different values or requiring different active scopes.
The proof distinguishes where each closure was constructed. For example:

```fwp
raw : I64 -> I64 -> I64
raw = const ad.tape
safe : I64 -> I64 -> I64
safe = curry (ad.scope (uncurry raw))
main = (0, 1) | (uncurry safe | ignore)
```

`ad.tape` creates derivative storage and requires an active `ad.scope`. `safe`
opens that scope before calling `raw`. `uncurry safe` and `uncurry raw` capture
different functions. Merging their captures would invent an unscoped call from
`main` to `raw` and reject this valid program. A separate negative test requires
an actual unscoped call to fail.

The proof uses function IDs and expression positions, not runtime addresses or
unbounded call histories. Its sets only grow and have finite possible members,
so analysis terminates. This does **not** establish linear running time.

When function `a` calls `b`, it records a dependency on `b`'s results. New facts
about `b` queue `a` for another visit. Unrelated functions need not run again.
The same rule covers captures, callbacks, channels, tasks, State and errors.
An ordered queue lets newly ready later functions run in the current wave;
earlier or self-dependent functions wait for the next wave.

The test-only full-scan reference visits every function each wave. Tests compare
all final fact sets, require no new facts after validation, and check a 128-call
chain in both function-ID orders. The production compiler contains no selectable
full-scan implementation. Type-property and expression-type caches live only for
one proof; a temporary answer from a recursive query is never cached as final.

## Inputs, timers and limits

`ownership_analysis_scaling` in [src/arc_scope.rs](../../src/arc_scope.rs) builds
16, 32 and 64 workers. Each creates a channel, captures an integer in a callback,
calls a recursive scalar function through that callback, then closes the channel.
Raw lowering keeps optimization from erasing this input growth.

Three labels use the same checked intermediate representation:

| Label | Rule |
|---|---|
| Merged | Test-only older rule that combines closure creation sites |
| Separate | Production rule that keeps the sites distinct |
| SeparateCopy | A fresh invocation of exactly the Separate rule |

Both rules use current data structures. This isolates the site-merging rule;
it is not a comparison of old and new compiler binaries. The timer includes
proof setup, iteration, validation, destruction and test counters. It excludes
parsing, type inference, optimization, C generation/compilation and execution.

After one warmup per label, run 12 batches of 64 fresh proofs per label. Each
triplet executes all three labels. Orders cycle through `012, 021, 120, 210,
102, 201`; every batch balances the two identical copies across positions.
Report every duration and the median batch total divided by 64. Do not remove
outliers. Across Linux AMD64 and Intel macOS this records 13,824 proofs.

Both Separate labels must meet the following limits:

| Workers | Linux median per proof | Intel macOS median per proof |
|---|---:|---:|
| 16 | 20 ms | 55 ms |
| 32 | 35 ms | 90 ms |
| 64 | 65 ms | 170 ms |

The Separate/Merged ratio must be at most 1.5. The identical-copy medians may
differ by at most 5%; a failure makes timing inconclusive. These are regression
screens, not promised compilation times. Never raise them to pass a run.

Count ceilings are functions/contexts `N+33`, expression nodes `19N+126`, visits
`15N+300`, 16 waves and six output-summary updates. Separate permits `5N+8`
closure identities and `10N+47` stored facts; Merged permits 13 and 57. A fact
stored in several sets is counted several times. Bytes per origin exclude hash
nodes, cloned types and other container storage, so neither count is peak memory.

`ownership_rest_startup_budget` separately checks raw forms-server and ownership-
entry fixtures. Each lifetime proof must finish within ten seconds. Parsing,
lowering, listener startup and serving requests are outside that timer. Ordinary
REST tests retain their 60-second forms and 30-second raw-entry deadlines.

Run the `ownership-analysis` workflow suite on GitHub. It uses production Rust O1
with assertions and overflow checks, retains compiler/host identities and logs,
and runs this ignored measurement explicitly:

```sh
FWP_NO_OPT=1 cargo test --locked --lib ownership_analysis_scaling -- --ignored --nocapture --test-threads=1
```

System `time` also records process peak RSS: KiB on Linux, bytes on macOS. That
includes Cargo, the test harness and frontend work; it does not isolate proof
memory. Full production correctness gates remain separate.

## Returned-function recheck

Run `41265260150` at `4f1a63a2` passes Linux and Intel macOS: 234 units, lint,
all original scaling/count/copy limits and both raw startup limits. The proof
now keeps one outer construction site when a function returns another function;
it still uses finite source positions, not an accumulating call history.
Removing the required State handler remains a rejection.

Origins occupy 56 bytes on these hosts, versus the 40-byte representation in the
older worklist record below. This is a per-origin cost, not total proof memory.
Forms/entry analysis takes 0.260/0.192 seconds on Linux and 0.593/0.447 seconds
on Intel macOS, within the unchanged ten-second limits. These separate sessions
do not establish a speedup over an older compiler. Jobs `124726646393` and
`124726646304` retain every duration, host identity and diagnostic.

## State range recheck

Run `41158981359` at `f82016d9` passed Linux but failed Intel's identical-copy
control at N=32: 357.748791 versus 338.686527 ms per batch, a 5.63% difference.
All original time, ratio, count and startup limits passed. The
[rejected record](state-range-rejected-2026-10-31.json) retains all 13,824 durations,
hosts and logs; artifacts are `13026856049` (Intel) and `13026306985` (Linux).

The earlier six-order schedule balanced a whole run but not each 64-triplet
batch. The mirrored order above fixes that imbalance without changing counts,
limits or the median. It does not prove the cause of the earlier variation.

Run `41160463103` at `ea0f300b` passes both hosts: jobs `124416671214` (Linux)
and `124416671326` (Intel), with 226 units, lint and both startup checks. Maximum
identical-copy differences are 0.42% and 1.32%. The
[retained result](state-range-focused-2026-10-31.json) preserves all durations and
recomputed checks. This validates that schedule at that source, not a speedup.

## Earlier measurement changes

These records explain why the protocol changed. A later pass does not erase a
failure or make different runner sessions a paired speed comparison.

| Run / source | Observation and change | Retained evidence |
|---|---|---|
| `40849863932` / `04efac8a` | Intel N=32 ratio 1.578; seven short samples were unstable | [Short samples](ownership-analysis-short-2026-10-29.json) |
| `40852937323` / `516a10a5` | Fixed 64-proof batches and identical copy pass both hosts | [Batched results](ownership-analysis-batched-2026-10-29.json) |
| `40863396927` / `80da3971` | Intel N=64 identical-copy difference 6.89%, above 5% | [Failed control](ownership-analysis-batched-control-2026-10-29.json) |
| `40866146124` / `7af1a518` | Interleaving labels within triplets passes; maxima 0.16% Linux, 0.69% Intel | [Interleaved results](ownership-analysis-interleaved-2026-10-29.json) |
| `40876750730` / `02e4ee21` | PR #226 source passes; maxima 0.23% Linux, 1.51% Intel | [Final #226 record](ownership-analysis-final-226-2026-10-29.json) |

The old grouped and interleaved records retain their actual schedules. They are
not rewritten to use the later mirrored ordering.

## Earlier compiler repairs

The original [baseline](ownership-analysis-2026-10-26.json), run `40261359439`
at `092009f8`, used Rust 1.99.1 O1, EPYC 9V74 and Intel i7-8700B. Seven samples
per rule established the unchanged absolute/count limits. Both rules took 16
full-scan rounds; origins occupied 48 bytes. At 64 workers Separate retained
328 closure identities and 687 facts, while Merged retained 13 and 57. Those
small-fixture distinctions are required for correctness.

| Failure | Repair and verification |
|---|---|
| `40262766433`, `0db38df8`: macOS REST startup deadlines exceeded | Avoid repeated empty/type refinement; first attempt `40268967670` still took 11.36 s Linux / 48.92 s Intel for forms admission |
| Expensive recursive type queries | Cache completed type and expression queries. `40270501455`, `577249f8`, passes: forms 6.20/7.10 s, entry 3.90/4.66 s on Linux/Intel. [Raw record](ownership-rest-analysis-2026-10-26.json) |
| `40319010233`: Intel N=32 ratio 1.85 | Hash capture lookups; `40322274748`, `3e1c1482`, passes both hosts |
| `40336921587`, `69061078`: Intel N=32 ratio 1.522 | Move new capture vectors and skip equal merges; `40348021109`, `4c79748a`, still fails at 1.607 and forms 10.146 s |
| Temporary query/snapshot allocations | Avoid parameter-vector copies, duplicate lookups and repeated result properties; `40356471366`, `4e626132`, passes both hosts |
| `40423924014`, `2499e7b7`: Intel ratio 1.63, forms 12.02 s | Join saturated-call capture sets without copying. `40433091299`, `5609b5c7`, passes; largest ratios 1.366 Linux / 1.263 Intel |
| `40674942219`, `45f9e810`: Intel forms 12.824 s; 591,732 visits for 2,585 updates | Revisit only changed dependencies. `40680214359`, `ba38308f`, cuts visits but fails the 16-wave limit at 19 |
| `40683252110`, `dd91cc9c`: ordered queue passes wave/startup limits but Linux N=64 ratio is 1.5204 | Store capture counts in checked `u32` fields and avoid duplicate dependency registration. `40685939711`, `50dd674a`, passes both hosts |

The [worklist record](ownership-worklist-2026-10-28.json) keeps both failed
attempts, hosts and samples. The accepted queue uses nine small-fixture waves
and 40 bytes per origin. Forms/entry visits fall to 14,454/12,791 from
591,732/379,958, with identical facts. These are verified work reductions;
timings from different jobs do not establish a controlled speedup ratio.
[PR #221 delivery](../roadmap-history.md#scoped-parser-storage-and-analysis-work-pr-221)
and [PR #226 delivery](../roadmap-history.md#derivative-allocation-and-accuracy-pr-226)
record the corresponding final production gates. New source changes need fresh
validation; this finite input family does not bound every program.
