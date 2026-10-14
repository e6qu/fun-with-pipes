# Plan

The original roadmap and follow-up bundles are accepted through PR #133.
[PR #135](https://github.com/e6qu/fun-with-pipes/pull/135) was merged by the user
as `ad37059e` before final platform acceptance. It delivered further ownership,
array fusion, exact formats, checkpointing/nested AD and Windows implementation;
it did not finish all six directions. Focused passing checks remain scoped
evidence, and Windows TLS failures are still work to fix.
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

## Implemented so far

| Area | Current implementation | Verification boundary |
|---|---|---|
| Native platforms | Linux/macOS ARM64 and AMD64; Windows allocator, fibers, sockets, Unicode paths/processes, TLS and PE packages | Linux/macOS support accepted previously; Windows static storage and TLS peer repairs need native acceptance |
| Ownership | Typed Dup/Drop, reuse, scoped File/State owners, retained tasks, synchronous foreign callbacks, CLI/protocol lifetimes | Checked ARC rejects unproved cycles and resource graphs; final follow-up gates remain |
| Numeric storage | Natural-width arrays, retained views, wide scalar/record workers, actual F16/BF16/F128 and protocol v2 | Four-host exact-format/ABI proofs and wide-record measurements pass; final six-platform gates remain |
| Iteration | Tacit data-last combinators, direct count/list/iterate/array producer fusion, known State callbacks and numeric self-tail loops | Allocation and instruction probes preserve effects, forcing and traps; some general lazy tails still allocate |
| Autodiff | Nested reverse mode, explicit segmented checkpointing and bounded numeric workspaces | Analytical, ARC, managed failure/task/unload and checkpoint measurements pass four hosts; final platform gates remain |
| Language design | Strong ordinary inference, explicit generic specialization, checked arithmetic, immutable values and tracked effects | Pipe semantics and explicit `const` remain stable; no new parser mechanism is needed for these runtime improvements |

[History](docs/roadmap-history.md) retains prior acceptance and measurements.
[Preparation anchors](docs/roadmap-queue.md) remain immutable evidence, not work
to repeat. The table distinguishes implementation from the remaining acceptance
work; it does not claim universal collector-free execution or C/Rust performance.

## Remaining roadmap

PR #135 is merged. Continue from `ad37059e` on `roadmap-after-135`; do not reopen
the merged PR or replay completed preparation work. Preserve the six direction
identifiers below: implementation is in place, while final platform validation
and encountered failures remain. The user authorized all remaining work together
in one follow-up PR. The scope supersedes earlier Windows and floating-format deferrals.

| Step | Work | Acceptance |
|---|---|---|
| 1 | Close out and streamline docs | Record the PR #135 merge separately from acceptance and maintain one current handoff |
| 2 | Expand collector-free coverage | Retained tasks, scoped foreign callbacks/records/strings and typed CLI/executable protocol owners; explicit rejection of unproved cycles; alias, preparation failure, unwind, cancellation and reclamation controls |
| 3 | Remove allocation and dispatch overhead | Direct array producer fusion, numeric tail workers and wide scalar/aggregate workers; measured allocation reductions and native instruction evidence; preserve forcing, effects and trap order |
| 4 | Improve numerics and autodiff | Nested reverse differentiation and explicit checkpointing; measured layout and tape/checkpoint costs; raw/native agreement, task isolation and bounded lifetime evidence |
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
