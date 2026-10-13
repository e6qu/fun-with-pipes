# Plan

The original six-phase roadmap and accepted follow-ups are merged through
PR #132. The seven-step extension is implemented in PR #133 and requires
its final acceptance gates. The desired platform matrix below includes deferred Windows support.
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
| Linux | Native CI and standalone package checks | Native CI and standalone package checks |
| macOS | Accepted native support | Accepted native support |
| Windows | Desired; deferred and not implemented | Desired; deferred and not implemented |

Windows is desired on both architectures but deferred; prioritize Linux/macOS,
ownership and compiler performance. Each combination needs actual compiler/interpreter and
generated-program execution, runtime/ABI and dependency validation, ownership/GC
stress and reuse checks, and an independently usable binary. Cross-build or
emulated checks alone do not establish full native acceptance. Extend CI as
platforms are implemented; the seven production jobs cover Linux/macOS, not the deferred Windows
combinations. Cross-compilation between every host/target pair is not implied.

## Delivered

| Area | Accepted result | Boundary |
|---|---|---|
| Native macOS | ARM and Intel support, both engines and full platform gates | Separate binary per OS/architecture meets the packaging objective |
| Runtime ownership | Typed Dup/Drop, reuse, aliases, cleanup on unwind/cancellation, scoped resources | Unproved runtime graphs and cycles still require tracing |
| Numeric representation | Natural-width eligible arrays, retained views, typed scalar/aggregate ABI | Generic I128/U128 boundaries remain boxed; half/wide floats retain existing representations |
| Compiler and autodiff | Fused numerical loops, blocked matrices, bounded reusable AD workspaces | Fusion preserves effects, checked traps and floating-point order |
| Performance evidence | Allocation/count/live-memory controls and scoped C/Rust comparisons | No universal speed or cache-efficiency claim |
| Checked native ARC | Collector-free execution for admitted ownership graphs and scoped File owners | Explicit rejection outside the proved subset |
| Tacit examples and CI | Explicit `const` explanations; balanced macOS test shards | Full coverage and resource limits preserved |
| Iteration and records | `iter.fold`, `iter.each`, `iter.find`, `fold-until`, `map-accum`, `make { .field }` | Direct count/list producer chains and known State callbacks specialize; other lazy tails can allocate |

Phases 1–6 were accepted through PR #128; documentation, examples/CI and
iteration/projection follow-ups through #129–131. [History](docs/roadmap-history.md)
indexes verification and measurements. [Preparation anchors](docs/roadmap-queue.md)
remain immutable evidence, not work to repeat.

## Active seven-step bundle

The ten-task bundle was accepted in [PR #132](https://github.com/e6qu/fun-with-pipes/pull/132),
squash `c67800ec8530e44501c54c69719af26b0585bedc`. All seven production jobs
and documentation passed on tested head `7036ecebdbef50a5a8f851ed084378c830af1e79`;
the squash has the same tree. Four native packages and allocation/disassembly
artifacts were verified. [History](docs/roadmap-history.md) retains the evidence.

The user authorized these seven steps together in [PR #133](https://github.com/e6qu/fun-with-pipes/pull/133).
All are implemented; final acceptance requires the complete exact-head gates
recorded by that PR. The handoff is the single live validation record.

| Step | Work | Acceptance |
|---|---|---|
| 1 | Close out and streamline docs | Accepted PR #132 results replace pending actions; one current plan/handoff |
| 2 | Expand reconstruction ownership | Typed CSV and JSON/protocol reconstruction have counted results, aliases and partial-failure cleanup controls |
| 3 | Prove scoped State and callback lifetimes | ARC admits proven scoped owners; escape, replacement and unwind controls; unsupported cycles remain explicit |
| 4 | Remove producer and callback overhead | Eligible lazy producers and known State updates avoid per-step closures/dispatch, preserving forcing/trap order |
| 5 | Unbox wide integers where safe | Native worker/local I128/U128 representation with correct boxed boundaries, overflow and alias cleanup |
| 6 | Measure and improve numerics/autodiff | Equivalent C/Rust kernels and bounded AD workspaces; packed decoding, direct formatting and smaller hot arithmetic frames; allocation/live-byte and native instruction evidence |
| 7 | Settle float formats | Explicit F16/BF16/F128 precision, conversion and wire-format decision; docs distinguish implemented behavior from future formats |

Keep raw interpreter/native agreement, checked arithmetic and floating-point
order. No task authorizes general ARC eligibility without complete ownership
contracts. Windows, a new backend and new deployment interfaces remain deferred.
Native ARC does not imply WebAssembly ownership support.

After PR #133 passes and merges, this seven-step roadmap is complete. Remaining
engineering directions are explicit future work: broader proved ownership
(including foreign/protocol contexts and cycles), wider producer/worker shapes,
true half/quad formats with protocol migration, further measured kernel/AD
improvements, and deferred Windows. They are not unfinished acceptance items
for this bundle or silently authorized new platform/backend work.

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
bundles, one PR at a time, fix encountered failures, all seven exact-head CI jobs
plus documentation audit before squash, one-line commit messages of at most
80 characters without bodies or trailers. Keep the handoff current; delete
obsolete next actions instead of accumulating competing plans.

Use `python3 scripts/local-guard.py COMMAND...` for focused serial local checks.
Full builds, suites, benchmarks and large regeneration run on GitHub. Preserve
64 GiB free disk, target data below 2 GiB, sampled workload RSS below 1 GiB and
the 180-second deadline. Stop at limits. Memory changes require GC stress,
verification and reuse controls; semantic changes require raw interpreter
(`FWP_NO_OPT=1`) and native comparisons. Skipped or cancelled runs are not gates.
