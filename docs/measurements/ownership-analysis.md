# Ownership-analysis cost

This measures compiler work, not the execution speed of a compiled fwp program.
For the 64-worker fixture below, the repaired proof took 29.8 ms on Linux AMD64
and 80.8 ms on Intel macOS. It fixes a false rejection; this is not a compiler
speedup claim or a proved linear bound.

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

After one warmup per policy, the test constructs seven fresh proofs per policy.
Execution order alternates Merged/Separate and Separate/Merged. It prints every
elapsed sample in execution order and the median for each policy. The timer
includes proof setup, iteration, final validation and destruction; it excludes parsing, type inference,
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
