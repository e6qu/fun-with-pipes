# Implementation plan

Build an ahead-of-time language with simple pipes, immutable values, strong types
and useful inference. Prefer direct values, moves and borrows; use ARC for sharing
that needs it. Tracing GC is removed. JIT and backward compatibility are excluded.
[Terminology](docs/terminology.md) explains these terms with worked examples.

## Current batch: fewer owners in typed derivatives

PR #236 delivered local names/functions, tooling and the selected allocation
optimizations after all nine production jobs and documentation passed. Its
[delivery record](docs/roadmap-history.md#local-names-and-allocation-optimizations-pr-236)
replaces the completed ten-step implementation backlog. The original numerical
speed requirements remain open; delivery did not convert noisy timings into passes.

The next batch reduces temporary storage and ownership operations in F128 and
nested reverse-mode derivatives. Their tapes keep language values alive, unlike
the ordinary floating tape's numeric buffers. The
[protocol](docs/measurements/typed-derivative-owners.md) fixes selected count and
cleanup requirements before implementation. No arithmetic, callback order,
public API or tracing mechanism changes are planned.

| Step | Work | Completion requirement |
|---|---|---|
| 1 | Document terminology and close the merged batch | Worked examples, updated links, exact merged-source verification and no obsolete CI-watch instructions |
| 2 | Borrow typed recording records | Direct temporary `ad.push-owned` tuples use stack views while retained weight children remain independently owned; counted fixtures and failure controls pass |
| 3 | Reduce backward-pass owners | Initial adjoints borrow the tape's zero; completed owned input adjoints move into result cells; alias, failure, cancellation and nested-derivative controls pass |
| 4 | Verify and deliver together | Focused native checks, audited count/cleanup evidence, all nine production jobs and documentation pass on one final head |

## 1. Terms and current status

Use `docs/terminology.md` as the single lookup guide. Explain tapes with an actual
forward/backward calculation; introduce seeds, adjoints, nodes, weights and scopes.
Include examples for lexical names, ownership, compilation, parsing and measured
costs. Link from tutorials and design guides; remove the replaced glossary.
Check runnable examples and distinguish current behavior from goals and history.

Record #236's tested head, merge tree and passing runs in delivery history.
Replace pending integration claims with their verified outcome. Retain all failed
or inconclusive measurements and their source identities. The handoff keeps one
next action and actual checks for the new batch.

## 2. Typed recording

`ad.push-owned` reads a four-field argument and separately retains its two typed
weights. It does not retain the outer record. Prove that distinction and allow
the existing borrowed-record lowering for this primitive. Keep child owners alive
through buffer growth, both retains and failure cleanup. Do not extend this proof
to arbitrary primitives or escaping containers.

Require a repeated 256-operation fixture to remove exactly 256 outer heap records
with stack storage enabled, compared with the explicit stack-disabled control.
Use F128 and nested reverse weights, plus reused aliases. Preserve raw interpreter
results and native GCC/Clang O1/O2, stale/mixed/tape-full failures, workspace on/off
and zero managed/raw live growth. Audit the frozen primitive inventory.

## 3. Backward ownership

Untouched adjoint slots may borrow the tape's existing zero value. Slots holding
that exact value are borrowed; other slots own their values. Normalize callback
results that alias the shared zero by dropping only their independently returned
owner. Numerical equality is not an ownership test: use exact value identity.

Move completed nonzero input owners into result-list cells instead of retaining
and later releasing them. A result containing the shared zero still needs its
own owner. Keep the transferred value protected if list allocation fails.
Test untouched slots, repeated seeds, callbacks returning the shared zero or an
existing argument, failure while building results and cancellation. Preserve
all callback calls, including inactive checks; do not prune arbitrary typed
backward work using the scalar tape's assumptions.

Count initialization retains and result-transfer retains separately. Require zero
per-slot retains during initialization and zero extra retains when moving distinct
owned results. Verify that deliberate omitted releases and borrowed-zero overdrops
fail the observer. Retain emitted C and native images, allocation/byte/count/peak
and final-storage observations. Counts alone establish no speed improvement.

## 4. Integration and measurements

Use existing integration targets and one focused runner suite for the related
changes; full builds and suites run on GitHub. Local checks use the unchanged
resource guard. Audit every failed job and completed target before a repair push.
Run the full matrix once the batch is complete, then fix any discovered issue.
Require all nine production jobs and documentation on the exact final head;
skips and emulation do not establish native support.

Squash-merge only after passing gates. Use one subject of at most 80 characters,
empty body, no attribution or trailers, and verify the resulting tree and message.
Keep one active PR. The current user request and standing authorization cover
implementation, documentation, publication and merge.

## Open performance goals

- [D2 derivative speed](docs/measurements/descent-costs.md): original 5% limits
  remain open. Typed-owner count reductions do not settle the ordinary F64
  Rosenbrock timings. The array-to-list change's AMD64 copy control also remains
  inconclusive; do not repeat unchanged noisy runs for a pass.
- [N1/N2 numerical kernels](docs/measurements/kernel-baselines.md): preserve
  qualified-host, arithmetic-order and identical-copy requirements. Diagnose
  measurement resolution before accepting an optimization on those cases.
- [Closure construction](docs/measurements/callable-phases.md): retain the original
  Xeon regressions; another CPU does not settle them. Freeze qualified work counts
  before selecting a new candidate.
- Broader ARC minimization needs specific escaping/alias boundaries and measured
  costs. There is no goal of count-free arbitrary sharing, universal stack storage
  or automatic reclamation of all owning cycles.
- [Swift comparisons](docs/measurements/swift-allocations.md) measure allocator
  traffic and selected fwp-managed storage separately. Individual Swift ARC
  operations remain unmeasured. Do not infer them from RSS or elapsed time.

## Maintained guarantees and evidence

GC removal, scoped A1–A6 ARC reductions, F1–F3 call/recursion coverage, decimal-count
improvements, D3 derivative accuracy and #236's selected transformations are
verified deliveries. [Ownership](docs/ownership.md), [functional costs](docs/functional-costs.md)
and [history](docs/roadmap-history.md) record their scope. Keep their failure,
cancellation, reuse, application and binary checks as current regression coverage.

The [intermittent Intel compiler abort](docs/measurements/compiler-abort.md) has
no established root cause. Preserve its evidence and diagnose a recurrence from
its input/source path. Passing reruns are not a repair, and speculative
disassembly-led allocator changes are not justified.
