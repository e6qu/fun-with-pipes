# Ownership-analysis cost

This measures compiler work, not the execution speed of a compiled fwp program.
The initial measurements are pending in [PR #216](https://github.com/e6qu/fun-with-pipes/pull/216).
Do not claim a linear bound or a timing improvement from this protocol alone.

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
and closes the channel. The entry calls all workers and includes the two partial
applications above. Raw lowering (`FWP_NO_OPT=1`) prevents optimization from
erasing the growth in program size.

For each size, source checking and lowering finish before timing. The test warms
up the ownership proof once, then constructs seven fresh proofs of the same IR.
It prints every elapsed sample and their median. The timer includes proof setup,
iteration, final validation and destruction; it excludes parsing, type inference,
specialization, optimization, C generation, C compilation and program execution.
This is a comparison across input sizes, not against C/Rust or an older compiler.

The same run records:

- Source bytes, concrete function count after lowering, and expression-node count.
- Rounds through the summaries and function visits during those rounds.
- Summary updates: visits that add at least one new output fact.
- Final function/scope contexts, partial-closure identities and stored origin facts.
- Bytes per origin value. This excludes tree-node/container overhead.

Facts are summed across input, capture, output, callback, channel, task, State and
error sets. A fact can occur in several sets and is counted in each. These counts
describe retained analysis data; they are not measured peak heap bytes.

## Reproduce and assess

The `compiler-lifetimes` workflow runs this measurement alone on GCC/Linux AMD64
and Intel macOS, with the production Rust O1 profile and assertions/overflow
checks enabled. The test's counters exist only in the test build. Run it with:

```sh
FWP_NO_OPT=1 cargo test --locked --lib ownership_analysis_scaling -- --ignored --nocapture --test-threads=1
```

Runner artifacts retain the source revision, Rust/C versions, hardware and
`analysis-scaling.log`. The system `time` command also records peak resident
memory for the command, including Cargo, the test harness and frontend work.
Linux reports KiB; macOS reports bytes. This process peak does not isolate the
ownership pass or establish its incremental memory cost.

Before accepting the repair, record both hosts' samples and counts here, calculate
N→2N and 2N→4N ratios, and set explicit count/time regression budgets from that
baseline. Keep the source IDs with the observations. These three sizes exercise
one mix of queues, captures, recursion and pipes; they do not bound all programs.
