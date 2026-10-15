# Plan

The platform/ownership roadmap and three autodiff follow-ups are accepted through
[PR #139](https://github.com/e6qu/fun-with-pipes/pull/139), merged as `5d05cdd6`.
All nine production jobs and documentation passed at its tree-identical head
`917d28a3`; four-host focused AD and both WASM checks also passed.
[History](docs/roadmap-history.md) retains prior deliveries and evidence.

The user requested continued development. The current follow-up removes repeated
scans of known unavailable AD tape slots in both runtimes. Keep implementation,
regression controls, four-host measurements and streamlined docs together on
`autodiff-registry-search` in [PR #140](https://github.com/e6qu/fun-with-pipes/pull/140).
[The handoff](docs/development-state.md) records actual
checks and next actions. Delivery requires all nine production jobs and
documentation on the final head; historical anchors are not further work.
[Four-host evidence](docs/measurements/ad-search-2026-10-15.json) records reduced
scan work, equal allocation/live-memory counters and actual native instructions.
Once PR #140 merges with those gates, step 10 is complete.

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

## Platform objective and current evidence

| OS | AMD64 | ARM64 |
|---|---|---|
| Linux | Native execution and standalone package verified | Native execution and standalone package verified |
| macOS | Native execution and standalone package verified | Native execution and standalone package verified |
| Windows | Native execution and standalone package verified | Native execution and standalone package verified |

Each combination has native interpreter/compiler execution, generated-program
checks and a separately packaged compiler exercised outside the checkout.
Ownership, GC stress/reuse, ABI and networking/TLS controls run on the applicable
native hosts. Windows static-memory controls cover startup-only runtime storage,
worker/fiber reuse, exhaustion and fatal exits. DLL and OS resource allocations
remain outside that runtime budget. Native compilation requires a C toolchain;
TLS requires OpenSSL 3.

Package one binary per OS/architecture. Universal binaries are not an objective.
Cross-compilation between every host/target pair is not implied.

## Delivered roadmap

| Step | Delivered work | Evidence and boundary |
|---|---|---|
| 1 | Streamlined docs and one session handoff | Completed statuses, linked verification and one delivery rule; historical anchors remain immutable |
| 2 | Expanded collector-free ownership | Retained tasks, scoped foreign callbacks/strings and typed CLI/executable owners pass reclamation, alias, failure and cancellation controls; unproved cycles remain rejected |
| 3 | Reduced allocation and dispatch | Direct array producer fusion, numeric self-tail loops and wide scalar/record workers pass semantic and native-instruction controls; recorded allocation reductions apply to equivalent measured workloads |
| 4 | Nested autodiff and checkpointing | Second/third derivatives, stable task identities, partial-retain cleanup and bounded tape/workspace lifetimes pass; explicit checkpointing trades recomputation for storage |
| 5 | Actual F16/BF16/F128 | Correct-format arithmetic, direct decimal rounding, arrays, C ABI and protocol v2 pass exact-bit/rounding and ownership controls; software arithmetic preserves the declared precision |
| 6 | Native Windows ARM64/AMD64 | Both native jobs pass runtime/resources, TLS, interpreter/native goldens, static storage, ownership stress and standalone PE packages |
| 7 | Seeded-prefix numeric backward bounds | Input/seed order, validation, workspace growth and unwind controls; four-host storage/binary evidence and all nine production jobs |
| 8 | Operation-only AD metadata | Stable input tokens, atomic weight retains, four-host allocation/binary evidence and all nine production jobs |
| 9 | Geometric AD registry growth and numeric workspace preservation | Stable slot/generation selection, forced relocation and allocation-failure controls; four-host allocation/binary evidence and all nine production jobs |

[Ownership](docs/ownership.md) and [float formats](docs/float-formats.md) specify
the contracts. Generic wide boundaries can still box; arbitrary lazy producers
can still allocate. Unproved cyclic, mutable or retained graphs and unproved
State/AD lifetimes remain explicit ARC diagnostics. This bundle does not claim
universal collector-free execution, allocation-free abstractions or C/Rust speed
parity. A new backend, JIT and distributed execution are outside this roadmap.

[Measurements](docs/benchmarks.md) record hardware, compiler, flags, allocations,
live storage and timings. [History](docs/roadmap-history.md) preserves earlier
acceptance; [preparation anchors](docs/roadmap-queue.md) are evidence, not a queue
to replay.

## Current follow-up

| Step | Work | Acceptance |
|---|---|---|
| 10 | Skip known unavailable AD registry slots | Preserve lowest-slot selection, generation exhaustion, validation and release order in both runtimes; cover scope exit, failed and nested backward; measure search work, allocations and actual native instructions |

A cursor skips a prefix whose slots are live or generation-exhausted. Releasing
a reusable earlier slot lowers it before reentrant callbacks. Sequential creation
should no longer rescan the occupied prefix. Arbitrary holes can still require a
linear scan; do not claim constant-time allocation in every workload. The cursor
adds no heap allocation and leaves registry growth and the workspace budget intact.

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

[AGENTS.md](AGENTS.md) retains the standing authorization: publish, fix encountered
failures and require all nine production jobs plus documentation on the final
head before squash merge. Use one explicit subject of at most 80 characters and
an empty body, without trailers or attribution. Historical preparation entries
are evidence, not an automatic task queue.

Use `python3 scripts/local-guard.py COMMAND...` for focused serial local checks.
Full builds, suites, benchmarks and large regeneration run on GitHub. Preserve
64 GiB free disk, target data below 2 GiB, sampled workload RSS below 1 GiB and
the 180-second deadline. Memory changes require GC stress, verification and
reuse controls; semantic changes require raw interpreter/native comparisons.
Skipped, cancelled and superseded runs are not passing final-head gates.
