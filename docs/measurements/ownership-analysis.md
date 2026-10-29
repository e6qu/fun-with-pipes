# Ownership-analysis cost

This measures compiler work, not the execution speed of a compiled fwp program.
Each measurement below identifies its source and host. Earlier samples remain
part of the evidence, not a claim about current compiler speed. The finite proof
does not promise linear running time.

## Current measurement repair: longer samples and an identical control

Run `40849863932` at `04efac8a` passes Linux but fails Intel macOS at 32 workers:
Separate takes a 9.881 ms median versus Merged's 6.262 ms (1.578×, limit 1.5×).
All 221 units, all-target lint, fact/count limits and both startup checks pass.
The [original record](ownership-analysis-short-2026-10-29.json) preserves both
full logs, all 84 timings, hardware and 18 artifact-file identities.

At that size, Merged's seven individual timings range from 1.777 to 11.078 ms,
and Separate's from 2.285 to 13.763 ms. The larger 64-worker input is steadier
and passes at 1.391×. These observations show instability in the short samples;
they do not identify a specific host process or establish a compiler regression.
The failed result remains rejected.

The revised test uses 12 fixed rounds, each with **64 fresh proofs per label**.
Its three labels are Merged, Separate and a second invocation of the identical
Separate implementation. Two cycles through all six label orders balance each
position and each predecessor within a round. Every proof gets a fresh analysis;
no proof state is reused. One warmup per label remains outside measurement.

Each individual call retains its duration and checks its result outside timing.
A round sums 64 call durations. The reported cost is the median of 12 round totals
divided by 64. No sample is removed. Both Separate labels must meet the original
1.5× ratio and all original absolute/count limits. Their medians must also differ
by at most **5%**; otherwise the timing is inconclusive and fails. This stability
criterion and fixed schedule are declared before running the repaired measurement.
No compiler admission rule, production analysis algorithm or budget is relaxed.
The new runner results are pending; passing older runs does not verify this repair.

## Current implementation: revisit changed dependencies

PR #221 run `40674942219`, source `45f9e81013fdf3b9e07aa0d4222c87bcde289e2d`,
failed the Intel macOS forms limit: 12.824 seconds against 10 seconds. Its
591,732 function visits produced only 2,585 output updates. The entry fixture
passed at 7.358 seconds; Linux passed at 5.991 and 4.070 seconds. Both hosts
passed the unit tests and 16/32/64-worker limits. Earlier passing samples do
not erase this failure.

The repair changes scheduling, not the ownership rules. A function is queued
when first reached or when its input facts grow. While checking it, the compiler
records which outputs, captures, callback continuations, channel payloads,
task results, State values and error values it reads. A growing set queues its
readers again, including readers that first saw an empty set. Service boundaries
participate too. Task computations are collected for final cycle validation;
no transfer function reads that table during iteration.

For example, if `a` calls `b` and `b` later returns a newly discovered closure,
`a` must be checked again. An unrelated function need not be. Reads are recorded
by finite function/scope and closure-site identities. Facts and dependencies only
grow; the finite sets ensure termination, not linear complexity. A deterministic
ordered queue preserves function order within each wave. Newly ready later
functions run in that wave; earlier/self readers wait for the next one, preventing
one function from starving others. A wave visits only queued functions; old
round counts described whole-program scans.

The test harness retains a full-scan scheduling reference, unavailable in the
compiler binary. Positive fixtures compare every input, output, capture, callback,
channel, task, State and error set; negative fixtures must still reject. Validation
must add no facts after convergence. A 128-call chain in both function-ID orders checks late propagation, no extra
waves and fewer than one quarter of the reference's visits. Both raw REST fixtures
also compare complete facts outside their unchanged analysis timer. Those extra
reference checks are not part of the reported production-scheduling time.

The first worklist attempt, `ba38308f3e333aff1fede3e02e71db83241bea51`, ran in
`40680214359`. Both hosts passed 212 units, all-target Clippy, exact-fact checks
and REST budgets. Forms/entry analysis took 0.339/0.264 seconds on Linux and
0.707/0.512 seconds on Intel macOS. Forms visits fell from 591,732 to 13,503;
entry visits fell from 379,958 to 11,787. Their final facts remained identical.
These elapsed samples come from different runs; they are not a paired speed ratio.

That attempt still failed: each small fixture needed 19 waves, above the unchanged
limit of 16. Freezing the queue at each wave delayed later functions even when
they could already use a new result. The ordering repair above lets them run in
the current wave. Both function-ID orders now have a regression check.
[The complete attempt record](ownership-worklist-2026-10-28.json) retains the
original timeout and failed worklist run, with all samples and host descriptions.

The ordered version `dd91cc9c4f8ba7306d1848542b3a63f60817fee1`, run `40683252110`,
needs nine small-fixture waves and passes all Intel macOS gates. Both hosts pass
212 units, Clippy, full-fact comparisons and REST budgets. Linux forms/entry
analysis takes 0.380/0.276 seconds; Intel macOS takes 0.725/0.575 seconds.
The sole remaining failure is Linux N=64: 2.008 ms for separate sites against
1.321 ms merged, a ratio of 1.5204 exceeding the unchanged 1.5 limit.

The cost repair uses the IR's existing `u32` arity range for capture counts,
with checked conversion. A focused Rust O1 probe measures 40 bytes per origin
instead of 48 on local ARM64; this is a value size, not measured peak memory.
Saturated calls also register each capture dependency once instead of twice.
The 328 distinct closure identities and their facts at N=64 remain separate;
the test control retains 13 merged identities.

Run `40685939711` passes both hosts at
`50dd674aa7f764d9e2a0ef75dbc736ace3e4f9c1`: 212 units, all-target Clippy,
complete fact-set comparisons and every unchanged analysis budget. Both hosts
measure 40 bytes per origin and nine waves for the small fixtures.

| Host | 64-worker merged / separate median | Separate / merged | Forms / entry analysis |
|---|---|---|---|
| Linux AMD64 | 1.025 / 1.485 ms | 1.449 | 0.304 / 0.249 s |
| Intel macOS | 3.009 / 4.136 ms | 1.374 | 1.586 / 0.651 s |

The limits remain 1.5 for the ratio, 16 small-fixture waves and 10 seconds per
REST fixture. Forms/entry visits are 14,454/12,791 versus 591,732/379,958 in the
original full scan. Final stored facts agree exactly; this is a reduction in
repeated proof work, not a change in admission rules. Timings are host-specific
samples, not a controlled cross-revision speedup ratio. PR #221's subsequent
full native matrix and documentation passed on the merged tree; the
[delivery record](../roadmap-history.md#scoped-parser-storage-and-analysis-work-pr-221)
contains the audited jobs. New changes still require their own final-head gates.

## Why this measurement is needed

The lifetime proof used to merge partial applications with the same function,
number of captured arguments and creation scope. That loses a necessary
distinction. For example:

```fwp
raw : I64 -> I64 -> I64
raw = const ad.tape
safe : I64 -> I64 -> I64
safe = curry (ad.scope (uncurry raw))
main = (0, 1) | (uncurry safe | ignore)
```

`ad.tape` creates temporary derivative storage and requires a live `ad.scope`.
`safe` opens that scope before calling `raw`. Both `uncurry safe` and
`uncurry raw` are constructed outside the scope, but they capture different
functions. Merging their captures invents a direct call to `raw` from `main` and
rejects this valid program. The same mistake affected `rev.jacobian`.

The repair distinguishes their creation positions in the typed intermediate
representation (IR). Each position is a function ID and an expression/constant
index. Calls still use their actual invocation scope: a closure does not keep a
finished handler alive. Function summaries remain indexed by function and the
existing State/AD scope bits. No recursive call histories or runtime addresses
become analysis identities. This keeps the set finite; it does not prove a
linear running time. The regression also checks a real unscoped call is rejected.

## Input and timing

`ownership_analysis_scaling` in [the proof tests](../../src/arc_scope.rs) generates
16, 32 and 64 separate worker functions. Each constructs a data channel, captures
an integer in a callback, calls a recursive scalar function through that callback,
and closes the channel. The entry calls all workers and creates a tape directly
inside `ad.scope`. This input is valid under both compared analyses; the separate
regression above requires the repaired analysis. Raw lowering (`FWP_NO_OPT=1`)
prevents optimization from erasing the growth in program size.

For each size, source checking and lowering finish before timing. Two test
policies use exactly the same IR: `Merged` reconstructs the earlier capture rule;
`Separate` uses creation positions. `Merged` does not exist in production builds.
Both use the current data structures and type filtering, so this isolates the
merging rule rather than benchmarking a historical compiler binary. Both also
number IR positions; the ratio does not measure the added numbering work or the
change from the older origin-value layout. Absolute repaired-proof timings
include those costs.

Historical runs below use one warmup and seven fresh proofs per policy, with
alternating Merged/Separate and Separate/Merged order. The current repair uses
[fixed batches and an identical control](#current-measurement-repair-longer-samples-and-an-identical-control).
Both protocols retain every elapsed sample. The timer includes proof setup,
iteration, final validation and destruction; it excludes parsing, type inference,
specialization, optimization, C generation, C compilation and program execution.
Timing includes the test-only counters and their final count collection; it is
not an uninstrumented production timing. This compares two analysis rules across
input sizes; it does not compare generated code with C/Rust.

The same run records:

- Source bytes, concrete function count after lowering, and expression-node count.
- Rounds through the summaries and function visits during those rounds.
- Summary updates: visits that add at least one new output fact.
- Final function/scope contexts, partial-closure identities and stored origin facts.
- Bytes per origin value. This excludes tree-node/container overhead.

Facts are summed across input, capture, output, callback, channel, task, State and
error sets. A fact can occur in several sets and is counted in each. These counts
describe retained analysis data; they are not measured peak heap bytes.

## Recorded baseline and budgets

[Run 40261359439](https://github.com/e6qu/fun-with-pipes/actions/runs/40261359439)
passed on source `092009f83a1ba217820f2495d459fdb5c3b10c74`.
[The dataset](ownership-analysis-2026-10-26.json) retains every sample, source
hash, count and host description. Both used Rust 1.99.1, O1, debug assertions and
overflow checks. Linux used an AMD EPYC 9V74 runner; macOS reported an Intel
Core i7-8700B. The C compiler is outside this experiment.

| Host | Workers | Merged median | Separate median | Separate / Merged | Median limit for either rule |
|---|---:|---:|---:|---:|---:|
| Linux AMD64 | 16 | 8.11 ms | 8.62 ms | 1.063× | 20 ms |
| Linux AMD64 | 32 | 14.39 ms | 15.56 ms | 1.081× | 35 ms |
| Linux AMD64 | 64 | 27.02 ms | 29.76 ms | 1.102× | 65 ms |
| Intel macOS | 16 | 22.68 ms | 24.53 ms | 1.082× | 55 ms |
| Intel macOS | 32 | 39.64 ms | 42.73 ms | 1.078× | 90 ms |
| Intel macOS | 64 | 82.36 ms | 80.79 ms | 0.981× | 170 ms |

On Linux, separating sites adds 6–10% in this instrumented comparison. The 64-worker
macOS samples vary substantially (Separate: 78.7–93.4 ms); its ratio does not
establish an improvement. Separate's N→2N and 2N→4N ratios are 1.80×/1.91× on
Linux and 1.74×/1.89× on macOS. Three sizes of one fixture do not establish
asymptotic complexity.

Both hosts produced the same counts:

| Workers | Concrete functions / contexts | IR nodes | Function visits | Separate closures | Separate facts |
|---|---:|---:|---:|---:|---:|
| 16 | 49 | 430 | 540 | 88 | 207 |
| 32 | 65 | 734 | 780 | 168 | 367 |
| 64 | 97 | 1,342 | 1,260 | 328 | 687 |

Both rules take 16 rounds and make six output-summary updates. Merged keeps
13 closure identities and 57 facts at every size; Separate retains the distinctions
needed by the regression. An origin occupies 48 bytes in both test policies.
The measured command's peak RSS is 46.36 MiB on Linux and 49.82 MiB on macOS;
these process peaks include the frontend and are not per-policy heap measurements.

The test enforces these count ceilings: functions/contexts `N+33`, IR nodes
`19N+126`, visits `15N+300`, 16 rounds and six summary updates. Separate permits
`5N+8` closure identities and `10N+47` facts; Merged permits 13 and 57.
The time limits above are 2.1× the repaired medians, rounded up in 5 ms
increments. Separate's median must also remain at most 1.5× Merged's.
These are regression screens with room for runner variation, not promised
compilation times. Budget failures retain all size/policy observations and need
investigation; do not silently raise a limit. New inputs or proof precision need
a reviewed replacement baseline.

## Capture lookup repair

[Run 40319010233](https://github.com/e6qu/fun-with-pipes/actions/runs/40319010233)
failed the relative budget on Intel macOS at 32 workers: 20.69 ms for separate
sites versus 11.18 ms for merged sites (1.85×). Absolute time and fact-count
budgets passed. This is a failed gate, not evidence of acceptable overhead.

Capture lookup used an ordered tree even though the proof never traverses
captures in key order. Separating sites grows that table from 13 to 168 entries
at this size, and each fixed-point round repeats the searches. The repair uses
a hash table for these lookups, preserving the same identities, capture facts,
ordered origin sets and validation. Both test policies use the same table.
[Run 40322274748](https://github.com/e6qu/fun-with-pipes/actions/runs/40322274748)
passed both analysis hosts on `3e1c14826b545f799824e11c9476704d52fc4a46`,
without changing the 1.5× ratio or any absolute/count budget.

| Host | Workers | Merged median | Separate median | Separate / Merged |
|---|---:|---:|---:|---:|
| Linux AMD64 | 16 | 1.29 ms | 1.64 ms | 1.273× |
| Linux AMD64 | 32 | 2.22 ms | 3.00 ms | 1.352× |
| Linux AMD64 | 64 | 4.08 ms | 5.77 ms | 1.416× |
| Intel macOS | 16 | 4.69 ms | 6.08 ms | 1.297× |
| Intel macOS | 32 | 7.90 ms | 10.72 ms | 1.357× |
| Intel macOS | 64 | 14.03 ms | 19.55 ms | 1.393× |

The run artifacts retain all seven samples per rule and size. These compare
analysis rules within the repaired compiler; different runner sessions do not
establish a paired speedup over the ordered-tree version. The older baseline
above remains historical evidence. REST admission also passed: forms/entry
fixtures took 6.42/3.85 seconds on Linux and 8.30/5.75 seconds on Intel macOS,
within the unchanged ten-second limit. Production validation failed separately;
passing analysis budgets alone does not verify collector removal.

The next source, `690610786ecb5dfec751149cefc2509dc8797331`, failed Intel's
32-worker relative gate in [run 40336921587](https://github.com/e6qu/fun-with-pipes/actions/runs/40336921587):
10.063 ms Separate versus 6.612 ms Merged, or 1.522×. The 16/64-worker ratios,
absolute/count limits and REST checks passed; Linux passed. A previous passing
run does not override this failed gate.

Source `4c79748ae670d90f85068a40eff0dcd37b63dc38` transfers new capture vectors
instead of copying their sets and skips identical set merges. It still failed
Intel in [run 40348021109](https://github.com/e6qu/fun-with-pipes/actions/runs/40348021109):
32 workers took 53.717 ms Separate versus 33.427 ms Merged (1.607×), and raw forms
admission took 10.146 s against the ten-second limit. The other REST fixture took
6.685 s. Linux passed. These failures remain part of the evidence; earlier passing
samples do not establish acceptance.

The follow-up removes parameter-vector allocation from return-type queries,
uses sequential snapshots instead of cloning the input search tree, avoids a
second input-table lookup, and reads primitive result properties once per visit.
Round snapshots, traversal order, identities, facts and budgets are unchanged.
The existing acceptance/rejection tests and timing gates must verify this source;
less allocation in the code alone is not a measured speedup.

The follow-up source `4e6261326a9baea367afa7d5a6cdb277b4535a52` passes both
hosts in [run 40356471366](https://github.com/e6qu/fun-with-pipes/actions/runs/40356471366),
including 192 ordinary library tests and both separately executed budget tests. Separate/Merged ratios at 16/32/64 workers are
1.267/1.337/1.393 on Linux and 1.305/1.357/1.405 on Intel macOS; the limit is 1.5.
Forms/entry analysis takes 5.358/3.225 seconds on Linux and 7.467/4.746 seconds on
Intel, each below ten seconds. Rounds, visits, summaries and facts match the prior
source. Different runner sessions do not establish a paired speedup. Production
still has separate platform-test failures; these timings do not verify GC removal.

## Reproduce and assess

The [`ownership-analysis` suite](../../.github/workflows/numerics.yml)
runs this measurement alone on Linux AMD64 and Intel macOS, with the production
Rust O1 profile and assertions/overflow checks enabled. The test's counters exist only in the test build. Run it with:

```sh
FWP_NO_OPT=1 cargo test --locked --lib ownership_analysis_scaling -- --ignored --nocapture --test-threads=1
```

Runner artifacts retain the source revision, Rust version, hardware and
`analysis-scaling.log`. The system `time` command also records peak resident
memory for the command, including Cargo, the test harness and frontend work.
Linux reports KiB; macOS reports bytes. This process peak does not isolate the
ownership pass or establish its incremental memory cost.

The final source must pass these budgets and the complete production correctness
matrix. This fixture covers one mix of queues, captures, recursion and pipes;
it does not bound all programs or establish pass-specific peak heap use.

## REST startup regression

The small worker fixture above did not expose the cost of repeatedly inspecting
large generated REST types. In production run `40262766433` at
`0db38df8bd0b3ea6f4dc1165edd985bc82c71ccb`, ARM64 macOS exceeded the existing
60-second forms-server deadline and 30-second raw REST ownership-entry deadline.
These deadlines remain unchanged.

The captured compiler reproduced expensive interpreted forms startup locally:
26.1 CPU seconds and 51.9 elapsed seconds under the half-core local guard. A
one-second call-stack sample reached `check_interpreter`, `Proof::expr` and
`refine_origins`, with repeated type traversal, comparison and allocation. This
is diagnostic evidence, not a controlled before/after speed comparison.

Refinement now inspects an owner kind only when that kind is present. Empty
origin sets skip result-type reconstruction after every child has been visited.
Scalar expressions still update summaries, validate scope effects and consume
their creation positions. The initial search for owner-bearing channel types
shares one visited set across the immutable type graph. No admission rule or
scope requirement is weakened.

The runner-only `ownership_rest_startup_budget` check compiles
`tests/rest/forms.fwp` and `tests/fixtures/server_entries.fwp` with optimization
disabled. It prints compilation and lifetime-checking times separately, then
requires each lifetime check to finish within ten seconds. Compilation, opening
a listener and serving requests are outside that analysis timer; the ordinary
REST tests still cover complete startup and responses. The repair and this new
budget need final-head runner results before claiming the regression is fixed.

The first startup repair (`793bf7dac78a4b70ae71ece35ec5821be0b90397`) still failed
this budget in run `40268967670`: the raw forms fixture has 4,063 concrete
functions and took 11.36 seconds for admission on Linux AMD64 and 48.92 seconds
on Intel macOS. Parsing/lowering took 1.24 and 4.72 seconds respectively. Both
hosts passed the small worker budgets. These are different inputs/settings from
the local diagnostic above; their ratio is not a measured speedup.

The follow-up caches complete type-property queries and expression types within
one proof. Keys are concrete types and finite IR positions; no dynamic call
history enters the cache. Recursive queries finish before caching their answer,
so a temporary negative answer on a back edge cannot hide a later callback field.
All cached values are discarded with the proof. Measurements now include cache
entry counts alongside the existing facts and visits; counts do not measure the
bytes occupied by cloned types or hash-table storage. The ten-second budget and
ordinary startup deadlines are unchanged.

Run `40270501455` at `577249f8bc4043d7eda033e3ed433806a0e9806d` passes both
analysis budgets and all 190 library tests on Linux AMD64 and Intel macOS.
[The raw record](ownership-rest-analysis-2026-10-26.json) includes source, hardware,
Rust version, compilation times and analysis counters. These are one sample per
fixture per host; separate runner sessions do not establish a paired speedup.

| Raw fixture | Linux analysis | Intel macOS analysis | Limit per host |
|---|---:|---:|---:|
| Forms server, 4,063 concrete functions | 6.20 s | 7.10 s | 10 s |
| Ownership-entry server, 3,345 functions | 3.90 s | 4.66 s | 10 s |

Forms caches 591 type queries and 18,379 expression types; the second fixture
caches 443 and 15,031. Both hosts produce identical analysis counts. This is a
compiler-cost check, not an fwp-versus-C/Rust execution benchmark. Serving requests,
listener startup and generated-program speed are outside the timer. Full server
regressions and final-head production checks remain required.

## Current budget repair

At `2499e7b7`, [run 40423924014](https://github.com/e6qu/fun-with-pipes/actions/runs/40423924014)
passed Linux and failed Intel macOS. At N=64 the separate-site median was
35.57 ms versus 21.80 ms for merged sites (1.63 times, limit 1.5). Forms analysis
took 12.02 seconds against the ten-second limit, with the same 591,732 visits,
2,585 summary updates, 25,817 facts and 591/18,379 type/expression cache entries.
These elapsed-time failures remain evidence even though previous runs passed.

The repair removes temporary captured-argument copies when a call has
all its arguments: input summaries can join the original sets directly. Partial
applications still own their stored captures; over-application still evaluates
the returned function with the remaining arguments. The analysis rules and timing
limits are unchanged. Both-host measurements and the production matrix are
required before claiming an improvement.

[Focused run 40433091299](https://github.com/e6qu/fun-with-pipes/actions/runs/40433091299)
at `5609b5c7fe4fbd3837781e3ba08a9e46750c09aa` passes both budget tests and all
192 ordinary library tests on both hosts. Proof rounds, visits, summary updates,
closure/fact counts and cache entries are unchanged.

| Host | Separate/merged ratio at 16 / 32 / 64 workers | Forms analysis | Entry analysis |
|---|---|---:|---:|
| Linux AMD64 | 1.249 / 1.309 / 1.366 | 5.977 s | 3.692 s |
| Intel macOS | 1.193 / 1.242 / 1.263 | 6.804 s | 4.181 s |

These are passing sessions under the existing budgets. Host load differs from
the failed session; the elapsed-time difference is not a paired speedup estimate.
The concrete change removes temporary argument-set copies from fully supplied
calls. The full native matrix must still verify the final published source.
