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
| 1 | Remove tracing GC and limit ARC | Compile-time ownership, moves and borrows cover maintained program and deployment modes; shared ownership and cycles have an explicit policy; cleanup works on success, failure and cancellation; binaries exclude tracing; unshared hot paths avoid retain/release traffic; long-running memory remains bounded. |
| 2 | Remove avoidable costs from functional code | Representative pipes, partial applications, closures, records, variants, iteration and state compile to direct calls and loops where their lifetimes/targets are known, without avoidable intermediate heap objects; remaining costs are measured and explained. |
| 3 | Improve machine-level performance | Diagnose and reduce the largest equivalent-work C/Rust gaps on ARM64 and AMD64; inspect register use, spills, vector instructions, layout and cache behavior; preserve checked arithmetic, floating-point rules and failure order. |
| 4 | Improve differentiation speed, memory and precision | Reproduce and address known timing regressions; reduce recording and workspace costs without losing correctness; show memory scaling across input sizes and nesting; preserve and validate F128 gradient precision; measure the typed representation's allocation and arithmetic costs. |
| 5 | Strengthen numerical kernels | Benchmark arrays, reductions and matrix products across useful sizes/layouts; improve CPU kernels with documented accuracy and allocation costs; establish real-device evidence before claiming GPU execution support. |
| 6 | Make performance comparisons dependable | Use current revisions, comparable algorithms and explicit arithmetic rules; vary run order and retain repeated samples; report elapsed time, allocations, live memory, compilation/startup cost and binary size; use repeatable regression criteria rather than noisy single timings. |
| 7 | Validate the language with larger programs | Maintain numerical, collection-heavy and long-running applications; run them across supported targets and memory modes; use observed failures and friction to improve inference diagnostics, libraries, tooling and documentation without expanding syntax unnecessarily. |

### Current delivery and next acceptance

[PR #165](https://github.com/e6qu/fun-with-pipes/pull/165) is accepted after all
nine production jobs and documentation passed. C callers can release returned
strings and records explicitly; partial maps, sets and their temporary storage
clean up on failure. Related Windows toolchain, output, cancellation-fixture and
artifact problems are repaired. [History](docs/roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165)
records the exact sources, complete failure audits and acceptance. Default
execution still uses tracing; input copies, retained callbacks and actual browser
engine coverage remain work.

The current delivery removes intermediate lists and numeric result tuples from
map/set construction. Immediate ranges provide values directly; known callbacks
use direct calls. Sets use two temporary key arrays instead of four key/value
arrays. Order, duplicates, aliases, arithmetic and failure behavior stay unchanged.
All three focused runs pass 78 tests on six native hosts, with 120 actual
binaries inspected per report. Direct known-set loops avoid per-item dispatch
and stack access in the inspected Linux AMD64/ARM64 binaries. Set peak counted storage at 65,536
inputs falls from 2,102,304 to 1,053,712 bytes after removing the unused buffers.
[Measurements](docs/benchmarks.md#building-numeric-maps-and-sets-without-temporary-lists)
identify the exact comparisons and their limits. The [handoff](docs/development-state.md)
tracks the next PR's full production acceptance. The C/Rust benchmark now keeps
its actual measured executables and source inputs for subsequent code inspection;
its full execution and artifact checks remain part of that production gate.

The larger maintained map benchmark exposed variable AMD64 sorting time. The
current repair joins related key/value buffers under one owner, with explicit
size checks and no arbitrary padding. Local ownership/failure tests pass;
six-host correctness and same-run old/new layout measurements remain required.
Do not merge based on allocation savings while the timing issue is unresolved.

All seven areas above stay open. Each delivery must identify its workload,
expected change and acceptance criteria. Investigate performance regressions
even when allocations fall, and preserve traps, cancellation and interpreter
agreement. A passing microbenchmark does not complete a work area.

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
