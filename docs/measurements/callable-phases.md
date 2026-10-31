# Where returned functions spend time

A returned function keeps captured values alive after its factory returns.
For example, a factory capturing `7` can return a function that adds `7` to each
later input. The [existing comparison](returned-callables.md) checks results,
cleanup, allocations and reference counts. This experiment measures elapsed time
and resident memory separately. It extends the [Swift comparison](swift-peers.md).

## Fixed experiment

This protocol was frozen before the first samples; results follow below.
Use native Linux ARM64 and AMD64, with two sessions sequentially on each same
runner. Record actual CPU and toolchains; do not combine different CPU models.
Both sessions rebuild from the same source, using GCC O2, Rust O2 and Swift `-O`
with checked arithmetic. Factory and caller compile separately, without LTO.
The common C clock uses `CLOCK_MONOTONIC` and fails if the clock cannot be read;
its failed-clock controls run before measurements. Process timing uses the
existing deadline-aware child runner, without polling sleeps.

Compare five implementations and one byte-identical copy of each:

- C returns a function pointer and inline integer capture.
- Rust implements the same record through `core`, linked to the C caller. This
  measures Rust functions, not startup of a complete Rust standard-library app.
- Swift returns its native escaping function value. A typed native buffer stores
  the values; initializing and deinitializing slots delimit their lifetimes.
  There is no extra class wrapper or C representation of Swift closures.
- Current fwp uses the merged borrowed-call optimization.
- The fwp reference uses the same generated C with only that optimization's
  condition disabled. It is not an old compiler or a second supported runtime.

Each process runs 256 batches. Each batch constructs 4,096 functions capturing
`index + 7`, calls every function for inputs 0 through 15, then destroys the
whole population. Two cases compute `capture + input` and
`2 * (capture + input)`. Every process checks the exact sum. The input never
overflows; factories retain their checked operations. Timing includes checksum
accumulation, but no per-call clocks or allocation counters.

Four clock readings per batch separate construction (including buffer allocation),
invocation, and release (including freeing the buffer). Aggregate each phase
across all 256 batches; report nanoseconds for that complete workload and clearly
state any per-operation conversion. Process time additionally includes startup,
clock calls, cleanup checks and output. Construction includes 1,048,576 factories;
invocation includes 16,777,216 calls. C/Rust record release is trivial; do not add
artificial work to match ARC languages. Swift's manually initialized buffer is a
measurement device for precise phase boundaries, not a recommended application API.

Two warmup rounds precede 20 measured rounds. Ten-round blocks balance the
positions and preceding programs for all ten executable labels. Every duration,
output and status is retained. A copy ratio above 1.02 makes that implementation's
phase inconclusive. An aggregate phase below 5 ms is also inconclusive. Pairwise
claims require both implementations and their copies to qualify; a cheap C
release does not invalidate a separate fwp/reference invocation comparison.
Do not rerun unchanged noisy results, relax limits or remove failed samples.

## Candidate acceptance and memory

For **both operations, sessions and architectures**, require qualified invocation
time at least 5% below the same-source reference. Qualified construction, release
and complete-process time must be no more than 2% above the reference. If a
required phase fails its copy or duration control, timing acceptance stays open.
This is a new performance assessment; it does not rewrite the original rejected
ARM O1 code-size budget. Retain executable sizes and section reports as context.

Three additional runs per implementation/case measure peak resident RAM with
GNU time. These are separate from timed samples and include runtime, allocator
and mapped libraries. Require current fwp's maximum no more than 1 MiB above its
reference's maximum in each session. Do not call RSS an allocation count.
Separate diagnostic executables retain the existing single-closure construction,
invocation, release, intentionally omitted release and failure/retry controls.
They must show unchanged payload requests/storage and zero invocation retain/
release pairs for current fwp, versus one pair per call in the reference.
The diagnostic ledger is not used for the 4,096-closure population.

Keep every source, generated-C variant, native executable, command, raw timing,
RSS sample, count record and digest. Audit samples against command output, source
identity and byte-identical executable copies. Successful collection means the
records are complete, not that performance acceptance passed. Swift allocation
and ARC-operation counts remain missing; phase timings alone cannot attribute
its costs specifically to ARC. Its reference-capture lifetime controls and scalar
overflow controls remain in the earlier Swift suite.

## Delivery status

PR #234 was user-merged as `219e3a0130c18d60750fd55ec9c0a684c1dcefd4` before the
full production matrix. Main run `41218527464` owns those pending checks. Do not
mark them verified or cancel them as duplicates. The new PR will include these
measurements, any repairs and final-head production validation.

## First results: invocation improves, construction still needs work

Source `dfb6ff8e8aac215009e9a9cf48a8bce492ef4eae`,
[run 41219092543](https://github.com/e6qu/fun-with-pipes/actions/runs/41219092543),
passes both jobs: ARM64 `124589718380`, AMD64 `124589718541`. Each completes both
sessions and audits its artifacts. The [summary](callable-phases-2026-10-31.json)
retains all phase medians, copy decisions, memory samples, CPUs and artifact IDs.
The complete [AMD64 archive](callable-phases-amd64-2026-10-31.zip) and
[ARM64 archive](callable-phases-arm64-2026-10-31.zip) retain raw samples, commands,
sources, binaries and memory/control observations for both sessions. Their
digest-checked CI audit recomputes the summary without executing saved binaries.
The source is retained by `roadmap/callable-phases-2026-10-31`; GitHub's expiring
artifacts are no longer the only copies of this experiment.
Both jobs pass six timing-record tests, 56 clock executions, 33 Swift arithmetic
cases and both fwp variants' cleanup/count controls. The only setup diagnostic is
an absent C++ manual page; there are no compiler warnings in these jobs.

Both ARM64 sessions use Neoverse-N2. Across the two operations and sessions:

| Cost per full workload | Reference fwp | Current fwp | Result |
|---|---:|---:|---|
| Construct 1,048,576 closures | 8.25–8.31 ms | 8.29–8.39 ms | Within 2% |
| Invoke 16,777,216 times | 386–393 ms | 166–169 ms | 56–57% less time |
| Release the populations | 16.28–16.34 ms | 16.33–16.43 ms | Within 2% |
| Complete process | 412–420 ms | 192–196 ms | 52.5–53.5% less time |
| Peak resident RAM | 1,784–1,800 KiB | 1,920–1,932 KiB | Within the fixed 1 MiB allowance |

All sixteen ARM64 candidate phase comparisons qualify and meet their limits.
Swift invocation takes 269–276 ms and the full process 367–376 ms; fwp is faster
in these qualified comparisons. Rust invocation is about 30 ms: fwp remains
roughly 5.6–5.7 times slower. C's second-session addition has a 60% copy difference,
so do not claim repeated C parity. C/Rust construction and release are too short
for phase qualification. Swift release fails its copy limit in the second session.
Swift's peak RAM is 8,732–8,820 KiB. None of these ratios isolates ARC overhead.

Both AMD64 sessions use Intel Xeon Platinum 8370C. **Combined acceptance fails.**

| Case | Construction, current/reference | Invocation | Complete process |
|---|---:|---:|---:|
| Session 1, addition | Inconclusive | Inconclusive | Inconclusive |
| Session 1, composition | 16.1% longer: fails | 54.5% less time | 48.6% less time |
| Session 2, addition | 9.2% longer: fails | 54.7% less time | 49.0% less time |
| Session 2, composition | 8.6% longer: fails | 54.5% less time | 48.8% less time |

All AMD64 release comparisons and memory limits pass. The first addition case
has markedly different absolute durations and failed copy controls; do not merge
it with later durations or retry it unchanged. Three qualified construction
regressions remain even after excluding that case. Faster overall execution does
not erase them or satisfy the frozen combined rule.

For the three AMD64 case/session rows with qualified invocation comparisons,
the peer costs are below. These ranges describe individual observations, not a
pooled result; addition qualifies only in session 2. RAM covers all twelve
separate samples per implementation, including the first case's memory runs.

| Implementation | Invoke 16,777,216 times | Complete process | Peak resident RAM |
|---|---:|---:|---:|
| C inline capture | 19.56–24.45 ms | 21.69–26.63 ms | 1,660–1,780 KiB |
| Rust core, C caller | 19.60–24.45 ms | 21.74–26.63 ms | 1,660–1,780 KiB |
| Swift native closure | 313.69–313.92 ms | 395.63–397.20 ms | 9,352–10,140 KiB |
| Reference fwp | 384.61–387.08 ms | 424.11–428.28 ms | 1,868–2,188 KiB |
| Current fwp | 175.12–175.28 ms | 217.84–218.71 ms | 1,868–2,264 KiB |

Current fwp takes about 44% less invocation time than Swift in these three rows,
but 7.2–8.9 times Rust's invocation time. Its smaller resident footprint includes
runtime/library differences; it is not a measurement of ARC overhead alone.
The first addition observation remains in the summary with failed invocation
controls and is excluded from these timing ranges, not deleted.

The source construction path is unchanged between the reference and current
variants: allocate storage, set function/count fields, copy captures, establish
one owner. No observed allocation or cleanup defect explains the timing yet.
The follow-up reproduced the measured objects while retaining GCC's
[source-level optimization reports](https://gcc.gnu.org/onlinedocs/gcc-13.1.0/gcc/Developer-Options.html).
It required byte-identical objects before using those reports to explain the
measured compilation. This diagnostic did not rerun timing, inspect disassembly,
change runtime behavior or relax the acceptance limits.


## Follow-up: one constructor, two invocation paths

Both native diagnoses pass: AMD64 job `124593267611` and ARM64 `124593267740`
in `41220300146` reproduce the original objects byte for byte.
The complete [AMD64](callable-construction-amd64-2026-10-31.zip) and
[ARM64](callable-construction-arm64-2026-10-31.zip) report/object archives are
retained here, with digest and body-equality tests. On each host, GCC's optimized
bodies for `returned_make`, `fwp_heap_alloc`, its slow/refill paths,
`fwp_rc_forget_slot` and `fwp_mem_free` are identical between variants.
The factory and allocator's source-level optimization decisions do not explain
the regression. This is not a claim of identical final instruction placement,
nor proof that preceding work has no effect on a later phase.

Freeze the following **diagnostic** before collecting it. Build one executable
containing both invocation paths, sharing exactly one factory and allocator.
Select the invocation entry once before timing. Both paths use the same indirect
call in the separate C caller; this extra indirection means the new numbers are
not replacements for the original timings. Keep a byte-identical executable
copy. Compare zero, one and sixteen calls per closure for both operations, with
the same 4,096 closures and 256 batches. Zero calls supplies an identical-work
control: the selected invocation entry never runs.

Run two sessions on each native host, two warmup rounds and twenty measured
rounds per case. Four-round blocks balance both mode/copy pairs' positions and
predecessors. Preserve every output and timestamp, require the exact checksum
for each call count, and keep the existing 2% copy and 5 ms duration controls.
The zero-call invocation phase should be too short to qualify. Verify final
payload cleanup after every batch. No production runtime changes, memory-saving
claims, unchanged timing retries or acceptance-limit changes are part of this
study. If a construction difference persists only after invocation within this
shared executable, preceding work affects its measured cost; that alone cannot
distinguish cache, scheduling, frequency or other hardware effects.
