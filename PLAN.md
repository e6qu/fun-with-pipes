# Plan

The original six-phase roadmap and accepted follow-ups are merged through
PR #131. The desired platform matrix below includes deferred Windows support.
Earlier completion does not establish general
GC-free execution, allocation-free abstractions or universal C/Rust parity.
[The handoff](docs/development-state.md) records accepted source, checks and
current work. [Design](docs/design.md) specifies the language;
[ownership](docs/ownership.md) specifies memory contracts and limits.

## Direction

Preserve tacit, curried, data-last pipes, immutable values, tracked effects,
checked arithmetic and observable evaluation/trap order. Infer ordinary types
strongly; retain explicit generic signatures and compile-time specialization.
Prefer compiler-internal ownership over new surface syntax. Avoid needless
wrappers, fallbacks, magic and implicit defaults. Register spills are ordinary
lowering; protocol-defined alternatives are peers.

Aim for few heap allocations, natural numeric storage, suitable alignment and
effective register/cache use. Checked native `--gc arc` rejects unsupported
ownership rather than switching to tracing. Performance claims require equivalent
workloads and measurements of allocations and live memory alongside time.
Inspect generated C and native instructions; source-level abstractions alone
cannot establish efficient machine code.

Target Linux, macOS and Windows on both ARM64 (`aarch64`) and AMD64 (`x86_64`).
Package a separate binary for each of these six combinations. Universal binaries
are not an objective. Existing additional targets need not be removed.

## Platform objective and current evidence

| OS | AMD64 | ARM64 |
|---|---|---|
| Linux | Existing native CI baseline | Cross-compilation/QEMU coverage; full native acceptance remains to establish |
| macOS | Accepted native support | Accepted native support |
| Windows | Desired; deferred and not implemented | Desired; deferred and not implemented |

Windows is desired on both architectures but deferred; prioritize Linux/macOS,
ownership and compiler performance. Each combination needs actual compiler/interpreter and
generated-program execution, runtime/ABI and dependency validation, ownership/GC
stress and reuse checks, and an independently usable binary. Cross-build or
emulated checks alone do not establish full native acceptance. Extend CI as
platforms are implemented; the existing six jobs do not cover this six-target
matrix. Cross-compilation between every host/target pair is not implied.

## Delivered

| Area | Accepted result | Boundary |
|---|---|---|
| Native macOS | ARM and Intel support, both engines and full platform gates | Separate binary per OS/architecture meets the packaging objective |
| Runtime ownership | Typed Dup/Drop, reuse, aliases, cleanup on unwind/cancellation, scoped resources | Unproved runtime graphs and cycles still require tracing |
| Numeric representation | Natural-width eligible arrays, retained views, typed scalar/aggregate ABI | I128/U128 remain boxed; half/wide floats retain existing representations |
| Compiler and autodiff | Fused numerical loops, blocked matrices, bounded reusable AD workspaces | Fusion preserves effects, checked traps and floating-point order |
| Performance evidence | Allocation/count/live-memory controls and scoped C/Rust comparisons | No universal speed or cache-efficiency claim |
| Checked native ARC | Collector-free execution for admitted ownership graphs and scoped File owners | Explicit rejection outside the proved subset |
| Tacit examples and CI | Explicit `const` explanations; balanced macOS test shards | Full coverage and resource limits preserved |
| Iteration and records | `iter.fold`, `iter.each`, `iter.find`, `fold-until`, `map-accum`, `make { .field }` | Iterator state and callbacks can still allocate |

Phases 1–6 were accepted through PR #128; documentation, examples/CI and
iteration/projection follow-ups through #129–131. [History](docs/roadmap-history.md)
indexes verification and measurements. [Preparation anchors](docs/roadmap-queue.md)
remain immutable evidence, not work to repeat.

## Active ten-task bundle

The user authorized all ten tasks below in one PR, including the pending docs
cleanup. Keep the bundle open until every acceptance criterion is met; passing
partial or superseded runs do not complete it. Windows remains deferred.

| Task | Work | Acceptance |
|---|---|---|
| 1 | Finish docs cleanup | One current plan/handoff, valid links, immutable evidence preserved |
| 2 | Native Linux ARM64 CI | Both engines, generated programs, GC stress and reuse execute natively |
| 3 | Separate platform binaries | Linux/macOS ARM64/AMD64 artifacts validated outside build directory |
| 4 | Current-compiler combinator measurements | Allocations/live memory, timing, generated C and actual native disassembly |
| 5 | Remove avoidable callback dispatch | Known callbacks specialize with capture and evaluation order intact |
| 6 | Remove avoidable loop-state allocations | Eligible tuple/record state stays scalar/stack; allocation and machine-code controls |
| 7 | Fuse direct iterator consumers | Eligible lazy chains eliminate intermediate stages without extra forcing or reordered effects/traps |
| 8 | ARC for a reconstructed-value boundary | A concrete parser/decoder owns nested results and cleans partial failures |
| 9 | Counted I128/U128 owners | Construction, arithmetic, aliases, aggregates and cleanup verified before ARC admission |
| 10 | Checked scoped autodiff | Supported tape/workspace lifetime subset, escapes and exceptional cleanup proved and measured |

The handoff tracks implementation and actual evidence per task. Preserve raw
interpreter/native semantics, checked arithmetic and floating-point order.
No task authorizes general ARC eligibility without complete ownership contracts.
Real half/128-bit float formats require a separate precision and wire-format
decision. Windows, a new backend and new deployment interfaces remain deferred.
Native ARC does not imply WebAssembly ownership support.

## Agreed syntax

Keep prefix calls and infix pipes; application binds more tightly than pipes.
Use explicit parentheses for nested arguments. Existing layout delimits
continuations and match arms; indentation-based argument groups and colon
application remain set aside. Keep `if` alongside `match`, explicit `const`
(constant function construction), and `()` as the unit value. Values do not
implicitly become constant functions. Tuple projections are zero-indexed.

Prefer short tacit callbacks and meaningful names for reusable stages; do not
add names merely to remove parentheses. Iteration and state combinators remain
ordinary library functions. Record projection shorthand expands to existing
selectors without new runtime semantics.

## Delivery and validation

[AGENTS.md](AGENTS.md) retains the standing authorization and workflow: coherent
bundles, one PR at a time, fix encountered failures, all six exact-head CI jobs
plus documentation audit before squash, one-line commit messages of at most
80 characters without bodies or trailers. Keep the handoff current; delete
obsolete next actions instead of accumulating competing plans.

Use `python3 scripts/local-guard.py COMMAND...` for focused serial local checks.
Full builds, suites, benchmarks and large regeneration run on GitHub. Preserve
64 GiB free disk, target data below 2 GiB, sampled workload RSS below 1 GiB and
the 180-second deadline. Stop at limits. Memory changes require GC stress,
verification and reuse controls; semantic changes require raw interpreter
(`FWP_NO_OPT=1`) and native comparisons. Skipped or cancelled runs are not gates.
