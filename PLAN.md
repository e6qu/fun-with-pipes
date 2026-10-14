# Plan

The original roadmap and follow-up bundles are accepted through PR #133.
[PR #134](https://github.com/e6qu/fun-with-pipes/pull/134) merged as `5c0287c`
with full Linux/macOS CI passing. It delivered further ownership, iteration,
exact-format core and Windows foundations; it did not finish all six directions.
The remaining scope below carries forward, including Windows ARM64/AMD64 and
real half/quad language formats.
[The handoff](docs/development-state.md) records actual progress and checks;
[history](docs/roadmap-history.md) retains completed delivery evidence.
Completion of an earlier bundle does not establish general collector-free
execution, allocation-free abstractions or universal C/Rust performance.

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
| Windows | Active implementation; not accepted yet | Active implementation; not accepted yet |

Windows is now included on both architectures. Each combination needs actual
interpreter and generated-program execution, runtime/ABI and dependency checks,
ownership/GC stress and reuse verification, and an independently usable binary.
Cross-builds, emulation and skipped suites do not establish native acceptance.
Retain all seven Linux/macOS production jobs and add required native Windows
coverage before claiming six-platform support. Cross-compilation between every
host/target pair is not implied.

## Delivered

| Area | Accepted result | Boundary |
|---|---|---|
| Native macOS | ARM and Intel support, both engines and full platform gates | Separate binary per OS/architecture meets the packaging objective |
| Runtime ownership | Typed Dup/Drop, reuse, aliases, cleanup on unwind/cancellation, scoped resources | Unproved runtime graphs and cycles still require tracing |
| Numeric representation | Natural-width eligible arrays, retained views, typed scalar/aggregate ABI | Generic I128/U128 boundaries remain boxed; half/wide floats retain existing representations |
| Compiler and autodiff | Fused numerical loops, blocked matrices, bounded reusable AD workspaces | Fusion preserves effects, checked traps and floating-point order |
| Performance evidence | Allocation/count/live-memory controls and scoped C/Rust comparisons | No universal speed or cache-efficiency claim |
| Checked native ARC | Collector-free execution for admitted ownership graphs, scoped File owners and scalar foreign-C calls | Managed foreign pointers/callbacks and unproved graphs remain outside the proved subset |
| WASM reclamation | Physical freeing of proved typed owners and closed File headers | Unproved shared/cyclic graphs remain retained |
| Exact-format foundations | Shared half/bfloat/quad arithmetic, decimal and math cores; literal text preserved through macros | Language values/storage/ABI/protocol have not migrated |
| Windows foundations | Native Rust interpreter goldens, sockets/DLLs and C allocator/PE root probes on both architectures | Complete generated C runtime and standalone packages remain |
| Tacit examples and CI | Explicit `const` explanations; balanced macOS test shards | Full coverage and resource limits preserved |
| Iteration and records | `iter.fold`, `iter.each`, `iter.find`, `fold-until`, `map-accum`, `make { .field }` | Direct count/list/iterate producer chains and known State callbacks specialize; other lazy tails can allocate |

Phases 1–6 were accepted through PR #128; documentation, examples/CI and
iteration/projection follow-ups through #129–131. [History](docs/roadmap-history.md)
indexes verification and measurements. [Preparation anchors](docs/roadmap-queue.md)
remain immutable evidence, not work to repeat.

## Remaining roadmap

PR #134 is merged. Continue from `5c0287c` on `roadmap-after-134`; do not reopen
the merged PR or replay completed preparation work. Preserve the six direction
identifiers below: documentation is maintained, while five implementation areas
remain. The user authorized all remaining work together in one follow-up PR. The scope supersedes earlier Windows and floating-format deferrals.

| Step | Work | Acceptance |
|---|---|---|
| 1 | Close out and streamline docs | Maintain the accepted PR #134 baseline and one current handoff; remove stale merge/retry instructions |
| 2 | Expand collector-free coverage | Prove retained-callback and managed foreign/protocol lifetimes; establish an explicit cycle policy; extend coverage beyond the merged scalar foreign and typed WASM/File proofs, with alias/unwind/cancellation/reclamation controls |
| 3 | Remove allocation and dispatch overhead | Broader producer fusion and native worker/aggregate coverage; measured reductions in generic boxing and closure allocation; preserve forcing, effects and trap order |
| 4 | Improve numerics and autodiff | Measured register/layout/cache improvements; nested reverse differentiation and checkpointing with explicit lifetime/precision contracts; raw/native agreement and bounded memory evidence |
| 5 | Implement real half/quad formats | Actual F16/BF16/F128 arithmetic, literals, conversions, text, arrays and ABI; coordinated versioned protocol migration; exact-bit and rounding controls in both engines |
| 6 | Support Windows ARM64 and AMD64 | Native interpreter/compiler/generated programs, platform resources/networking/TLS, ownership stress/reuse and standalone PE packages tested on both native architectures |

Use [the float migration contract](docs/float-formats.md) for item 5. Software
arithmetic must implement the declared format on targets without hardware
instructions; reduced precision is not an alternative implementation. Keep
ordinary typing strongly inferred and generic specialization explicit.
Ownership coverage expands only with proofs and negative controls. Any residual
unsupported boundary must remain an explicit diagnostic and be recorded in the
handoff; it cannot silently acquire tracing or an implicit lifetime.

The merge gate includes the existing seven production jobs, required native
Windows suites on both architectures, and documentation on the final PR head.
Use early focused runner checks while developing; run full final gates once the
bundle is ready, fix all failures, and squash with one explicit subject of at
most 80 characters and an empty body. A new backend, JIT and distributed
execution are not part of this bundle.

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
bundles, one PR at a time, fix encountered failures, all existing Linux/macOS and added Windows exact-head CI jobs
plus documentation audit before squash, one-line commit messages of at most
80 characters without bodies or trailers. Keep the handoff current; delete
obsolete next actions instead of accumulating competing plans.

Use `python3 scripts/local-guard.py COMMAND...` for focused serial local checks.
Full builds, suites, benchmarks and large regeneration run on GitHub. Preserve
64 GiB free disk, target data below 2 GiB, sampled workload RSS below 1 GiB and
the 180-second deadline. Stop at limits. Memory changes require GC stress,
verification and reuse controls; semantic changes require raw interpreter
(`FWP_NO_OPT=1`) and native comparisons. Skipped or cancelled runs are not gates.
