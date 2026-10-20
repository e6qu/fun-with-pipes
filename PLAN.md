# Project plan

Build a simple pipe-based language whose ordinary programs run close to the
machine with predictable memory use. The central memory objective is to remove
tracing garbage collection (GC), use ownership and borrowing to avoid runtime
bookkeeping, and reserve automatic reference counting (ARC) for genuine shared
ownership. Completing a delivery does not complete this project.

[The session handoff](docs/development-state.md) records current work, checks,
failures and the next concrete action. [Delivery evidence](docs/roadmap-history.md)
records past results; completed checklists and preparation branches are not an
active backlog.

This is very early pre-alpha development. Backward compatibility is not an
objective, including compatibility with already compiled programs. Change source
APIs, internal layouts, calling conventions and binary formats when the design
benefits; rebuild affected programs and libraries with the matching compiler.
Update current examples, documentation and correctness checks together. Do not
add compatibility machinery solely to keep an older version working.

## Existing foundation

The compiler provides strong ordinary type inference, explicit generic
signatures, specialization, native C generation and an interpreter. There are
packed numeric arrays, selected stack/direct-value representations, collection
and iterator optimizations, nested automatic differentiation, several floating
formats, a formatter, linter and language server. These are foundations to extend;
they do not establish that every abstraction is free or every program avoids GC.

Default native execution still combines reference counting with tracing.
Checked `--gc arc` removes tracing for supported programs, including accepted
synchronous WASI entries, gRPC clients/services and HTTP clients/servers. Some
closures, containers and call boundaries still allocate, and measured numerical
workloads still have performance gaps. See [ownership](docs/ownership.md),
[numerics](docs/numerics.md) and [benchmarks](docs/benchmarks.md) for current limits.

## Memory direction

An owner is responsible for a value's storage. A move transfers that responsibility;
a borrow uses the value while its owner keeps it alive. Prefer proving these
relationships at compile time, in the spirit of Rust, while preserving fwp's
immutable values, inference and simple pipes.

Use this order of preference:

- Eliminate intermediate values or keep their fields directly in local values.
- Use stack storage when lifetime and size permit; use owned heap buffers when
  needed. Moving ownership or borrowing must not require reference-count traffic.
- Reuse uniquely owned storage without changing any observable older value.
- Use ARC only when multiple independently live owners actually need to share
  storage. Remove redundant retain/release operations and measure the remainder.

Removing GC is not equivalent to disabling collection, retaining unreachable
objects forever, or replacing every allocation with a reference-counted object.
Define an explicit policy for cycles, retained callbacks, foreign pointers and
host-owned values. Do not silently fall back to tracing. Prefer compiler-internal
ownership; any unavoidable surface restriction or syntax change needs an explicit
design decision that preserves the agreed language semantics.

A zero-cost abstraction adds no runtime machinery compared with equivalent
handwritten code. Necessary data storage, checked arithmetic and deliberate
sharing still have costs. Demonstrate the claim for specific patterns using
allocation/count measurements and generated machine code.

## Remaining project work

Numbers identify work areas, not a requirement to finish one entire area before
starting another. Establish measurements and representative programs first;
ownership and removal of GC are the primary design priority.

| Step | Work | Completion evidence |
|---|---|---|
| 1 | Remove tracing GC and limit ARC | Agree and implement ownership/cycle contracts for maintained language features and deployment modes; migrate maintained programs without silently weakening their behavior; verify cleanup on success, failure and cancellation; default generated binaries exclude tracing; selected unshared hot paths avoid count traffic; repeated bounded-live workloads show no accumulating retention. |
| 2 | Remove avoidable costs from functional code | Define and test a representative set of pipes, partial applications, closures, records, variants, iteration and state patterns whose known targets/lifetimes permit direct calls, loops and elimination of intermediate heap objects; establish constant-stack execution for eligible self-tail recursion in native code and the interpreter; report necessary storage, dispatch and sharing costs outside those patterns. |
| 3 | Improve machine-level performance | Set per-workload budgets from repeated equivalent-work C/Rust baselines on named ARM64/AMD64 hosts; diagnose known regressions and meet those budgets without hiding slower results; inspect register use, spills, vector instructions and layout while preserving arithmetic and failure rules. |
| 4 | Improve differentiation speed, memory and precision | Validate supported derivative operations and precision; meet measured time/memory budgets for selected sizes and nesting depths; resolve known regressions; report recording, recomputation, output and workspace costs separately. No constant-memory or zero-overhead promise for arbitrary differentiation. |
| 5 | Strengthen numerical kernels | Meet accuracy and measured time/memory budgets for selected CPU arrays, reductions and matrix products. Resolve the runtime-compilation conflict separately; claim GPU support only for explicitly supported devices with ahead-of-time artifacts and real execution evidence. |
| 6 | Make performance comparisons dependable | Establish a reproducible comparison protocol with current revisions, comparable algorithms and explicit arithmetic rules; retain repeated samples and environment details; report timing, memory, compilation/startup and binary-size costs; define regression thresholds and how inconclusive results are investigated. |
| 7 | Validate the language with larger programs | Select a finite acceptance suite of numerical, collection-heavy and long-running applications; test its supported targets and memory modes, including failure/cancellation and bounded-live repeated work; fix observed implementation and usability issues. Add coverage as features expand, without treating this suite as proof for all programs. |

### Acceptance limits

The [feasibility review](docs/design-limits.md) explains the limits behind these
goals. Name the programs, inputs, platforms and budgets before measuring a change.
Do not promise zero heap use, zero ARC, universal C/Rust parity, constant-memory
autodiff or perfect inference of every lifetime. Correctness remains required
outside the benchmark suite.

### Immediate priorities

1. Extend [cycle-safe ownership contracts](docs/ownership.md#proposed-cycle-policy)
   for persistent subscriptions, retained resource captures and cyclic data graphs.
   Nested channels and selected queued functions already have native and
   WebAssembly acceptance. Explicit weak handles remain a proposal. Prefer
   borrowing and scoped cleanup; distinguish a definite cycle from a missing proof.
   Reject unproved retention rather than silently use tracing.
2. Investigate the remaining integer-counting timing gap with controlled
   comparisons on the same host. Saved identical binaries show variable AMD64
   CPU time, so elapsed-time differences alone do not identify a compiler
   regression. Retain every sample and inspect generated instructions before
   selecting a change. [Accepted PR #181](docs/roadmap-history.md#temporary-channel-borrows-and-failure-cleanup-pr-181)
   removes the closed-send retain and one shared-text retain and repairs failure
   cleanup; its complete native matrix passes. [PR #180](docs/roadmap-history.md#function-channel-borrows-and-integer-text-pr-180)
   already eliminates eligible integer text. Their reports preserve remaining
   C/Rust gaps, storage costs and necessary shared ownership. Resource-owning
   tail frames and mutual recursion still need separate proofs.
3. Use representative applications and equivalent-work measurements to select
   the next costs to remove: dynamic closures/calls, input copies, container
   layout, numerical workspace and derivative recording. Use the accepted
   [numeric representation measurements](docs/benchmarks.md#numeric-hash-specialization)
   as baselines, preserving mixed timings and C/Rust gaps. Investigate known
   regressions before claiming a performance improvement.

All seven work areas remain open. The syntax and native-platform foundations
are implemented; the main remaining work is ownership, representation,
performance and validation of larger programs. A passing microbenchmark or a
completed PR does not finish a work area. The [handoff](docs/development-state.md)
contains the next concrete action, checks and unresolved issues.

## Platform objective and current evidence

Native execution and compiler packages have passing delivery evidence on Linux,
macOS and Windows, each on ARM64 and AMD64. Preserve that coverage with one binary
per operating system/architecture. Universal binaries are not an objective.
A C toolchain is needed for native compilation; encrypted networking needs
OpenSSL 3. Existing support does not promise every cross-compilation combination.

The memory objective includes native executables, libraries, services and
WebAssembly: current checked ARC exclusions are remaining work, not evidence
that these boundaries can already execute safely without a collector.

## Syntax and behavior to preserve

`x | f` passes a value to a function; `f | g` combines functions. Arguments come
before the data being transformed. Keep prefix calls such as `add 1` and allow
infix arithmetic with standard precedence; parentheses override grouping and
delimit nested arguments. Preserve tacit composition, strong typing
and inference, explicit generic signatures, immutable values, tracked effects,
checked arithmetic, and observable evaluation and trap order.

Every function takes one argument and may return another function: `f x y`
means `(f x) y`. A tuple is one value, so a tuple-taking function also takes
one argument. Keep explicit `curry` and `uncurry` helpers to convert between
tuple-taking and curried functions; do not introduce automatic tuple conversion.
This is the language model, not a requirement to allocate intermediate closures
or tuples when the compiler can eliminate them.

Keep both `if` and `match`, explicit `const` for constant functions, and `()` for
unit. Tuple positions start at zero. Iteration and state helpers remain library
functions. No colon application or indentation-based argument groups are planned.
Avoid needless wrappers, implicit conversions and hidden fallback behavior.
Use explicit parameters and settings for toolchains, targets and execution
policy; do not add compatibility adapters or silently choose those settings.
Register spills and alternatives defined by a protocol are ordinary implementation
choices, not fallbacks.

## Excluded direction

A just-in-time compiler (JIT), which compiles running program code during
execution, is explicitly excluded. It is not deferred or a future optimization
option. Keep native compilation ahead of execution and the interpreter; do not
add a JIT to either the compiler or the generated runtime.

The existing OpenCL path builds device source at runtime through `clBuildProgram`.
That is an existing implementation gap against this direction, not an exception
or proof of ahead-of-time device compilation. Step 5 must resolve device build
and loading requirements before claiming the policy holds for GPU execution;
do not expand runtime kernel compilation.

## Deferred expansions

A replacement backend, distributed execution and new networking protocols
remain outside this roadmap. General GPU matrix kernels and additional deployment
interfaces follow the core memory and CPU work; do not let them displace it.

## Delivery and acceptance

Follow [AGENTS.md](AGENTS.md) and [Contributing](CONTRIBUTING.md). Bundle coherent
changes to reduce repeated CI cycles, keep one active delivery PR at a time, and
fix discovered failures even when unrelated. Full CI must pass for the final
commit before squash merge. Commit messages are one line, at most 80 characters,
with no body, trailers or attribution.

Use `python3 scripts/local-guard.py COMMAND...` for focused local checks. Full
builds, suites, benchmarks and large regeneration run on GitHub. Keep the fixed
limits: 64 GiB free disk, generated target data below 2 GiB, sampled aggregate
RSS below 1 GiB and a 180-second workload deadline. Do not raise them.

During GC removal, retain existing stress/reuse/cleanup controls. Replace
collector-specific checks with evidence for the new ownership guarantees in the
same delivery that removes the collector; do not simply drop their coverage.
Every semantic change must compare interpreter and native behavior. Record
actual results and unresolved limits in the handoff after meaningful progress.
