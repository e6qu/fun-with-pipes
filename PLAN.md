# Plan

The platform/ownership roadmap and four autodiff follow-ups are accepted through
[PR #140](https://github.com/e6qu/fun-with-pipes/pull/140), merged as `09f1a029`.
All nine production jobs and documentation passed at tree-identical head
`cdb76905`; focused four-host AD and both WASM checks also passed.
[History](docs/roadmap-history.md) retains prior deliveries and evidence.

The final follow-up pairs native AD metadata buffers. Implementation, native
regression controls and four-host measurements are complete in
[PR #141](https://github.com/e6qu/fun-with-pipes/pull/141), on
`autodiff-metadata-block`. It halves metadata growth requests without changing
payload sizes or numeric evaluation order; timings are mixed.
[The handoff](docs/development-state.md) records actual checks and next actions.
Delivery requires all nine production jobs and documentation on the final head,
plus both focused WASM jobs at the unchanged runtime revision. Once PR #141
merges under these gates, all eleven steps are complete; there is no queued
implementation task. Do not replay historical preparation entries.

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
| 10 | Skip known unavailable AD registry slots | Lowest-slot reuse and generation limits preserved; four-host allocation/timing/instruction evidence and all nine production jobs |

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

## Final follow-up

| Step | Work | Acceptance |
|---|---|---|
| 11 | Pair native AD metadata buffers | Two growth requests for numeric metadata and one for managed parents; preserve alignment, byte bounds, values, cleanup and reuse; force relocation and allocation/trap failures; measure actual allocations and inspect native instructions |

Parents retain separate contiguous `pa`/`pb` regions in one allocation; numeric
weights retain `da`/`db` regions in another. Splitting these two allocations keeps
the existing 32-bit node bound representable. Growth preserves initialized
regions and leaves old offsets usable until potentially trapping allocation
finishes. Managed language weights retain their separate typed owner. Workspace
payload bytes and its 512 KiB budget stay unchanged. The interpreter remains the
semantic oracle; no interpreter storage or language syntax change is planned.
Measured allocator reduction alone will not establish a general speedup.

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
