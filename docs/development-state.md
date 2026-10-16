# Session handoff

Updated 2026-10-16. This file is the current action list; [PLAN.md](../PLAN.md)
defines the remaining project work. None of its seven whole areas is complete.

## Accepted and active deliveries

[PR #150](https://github.com/e6qu/fun-with-pipes/pull/150) merged as
`729db67f71386750aad0bbe477f546e5276b0223` after all nine production jobs
`38851567232` and docs `38851565415` passed for `7a7b40e1`. Tree, parent and
one-line/empty-body message were verified. Duplicate `38860909658` is canceled.

The only open delivery is [PR #151](https://github.com/e6qu/fun-with-pipes/pull/151),
branch `wasi-hash-delivery` in `/private/tmp/fwp-wasi-delivery`, final head
`796f5a4c3cd920eb49f709f9a0a5551dc98481fc`. Docs `38861611496` passes; production
`38861611494` is running. Require all nine jobs and docs for that exact head.
Earlier `38861119765` was canceled after repairing the allocation test counter.
That PR owns synchronous WASI ARC, streaming hash and callback/fusion changes.

The following preparation is `/private/tmp/fwp-hash-borrows`, branch
`borrowed-hash-arguments`, anchored at old pre-rebase `28cc4d0e`. After #151
merges, transfer only later commits onto its verified squash commit. Never replay
that old parent chain or open a second delivery PR while #151 is open.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Complete deployment and primitive ownership; remove tracing |
| 2 | In progress | Deliver borrowed hash fields and direct range arrays |
| 3 | In progress | Measure remaining C/Rust gaps and inspect generated code |
| 4 | In progress | Reduce derivative recording costs and validate scaling |
| 5 | Pending | Broaden kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Retain comparable, repeated measurements and storage costs |
| 7 | In progress | Extend maintained programs across deployment boundaries |

## Current batch and acceptance

The batch removes hashing tuple allocations, builds packed integer range arrays
directly, and removes unnecessary references to temporary tuple fields. Its
latest compiler change is `ac72124c2fd10178d70b1b1dde5b9d56ce178a7f`.

- Hash's explicit nonescape proof means its input is used only during the call.
  Borrowing alone does not establish this. Existing stack placement removes
  temporary tuple storage; ordinary functions propagate the proof.
- A direct structural tuple passed to hash borrows fields from live owners.
  Ownership lowering preserves aliases and later consumption; the independent
  verifier checks owner liveness after all fields. Plain named field reads and
  sole-use tuples can be exposed without crossing calls, traps or resource frames.
  Nominal records and escaping tuples retain their existing ownership.
- Immediate inline-integer `range | array.from-list` writes packed array storage
  directly. Bounds retain their order; equal/descending bounds are empty. Wide
  arithmetic rejects oversize arrays before machine-size conversion. I128/U128
  elements retain their existing boxed path. Existing comparison switches apply.
- Tests compare raw interpreter and native results, all inline integer widths,
  alias mutation, first traps, allocation failure and actual WASI physical frees.
  Disabled optimizations and deliberately removed cleanup/size checks must fail
  the corresponding controls. Hashing's measured loop must have zero retains.
- SIMD library comments now describe C loops and possible compiler vectorization,
  removing an unsupported instruction guarantee. Generated docs follow the source.
  No SIMD runtime implementation changed in this batch.

At `ac72124c`, focused native `38864599295` passes all six hosts and WASI
`38864602220` passes both actual WASI hosts. Four-host costs `38864604854` also
pass. All four verified reports show two managed allocation requests and zero retains
for both workloads, with zero final charged storage. Source/binary/assembly hashes
were checked under the guard (0.13 s); the report is
`hash-borrowed-fields-2026-10-16.json`. Its inspected ARM64 loop keeps state in
registers and stores the tuple on the stack, with no allocation or count calls.
Paired before/after run `38866837452` passes all four hosts and compares baseline
`38856285939` against these final costs at documentation/script head `aab2a928`.
Its raw report is `hash-borrowed-cpu-2026-10-16.json`. A second balanced run `38867789225` also passes all four hosts. The earlier small
ARM macOS and large Intel macOS ARC regressions did not repeat. Both raw reports,
remaining C/Rust overhead and the regression investigation are retained together;
all binary/source/assembly identities agree across repeats (guarded 0.13 s).
No universal speedup claim is justified.
These focused workflows contain intentionally unselected jobs: skipped jobs do
not count as production support. The delivery still needs all nine full gates.

## Measurements and resolved failures

[Benchmark explanations](benchmarks.md) introduce the implementations, workloads,
timing and allocation scopes. Reports preserve raw samples and known overhead.

The intermediate stack report `hash-stack-intermediate-2026-10-16.json` covers
only ARM Linux/macOS from `38860426497`. Small/large requests fell to 18/4,098;
retains remained 4,096/1,024. The four-host direct-range report
`hash-range-arrays-2026-10-16.json` is from passing `38861849157` at `a2f4ccd9`:
two managed requests, 144/32,776 peak charged bytes and zero final storage, but
still 4,096/1,024 retains. These are intermediate evidence, not new tasks.

Resolved failures explain the current checks:

- An allocation counter missed `fwp_alloc_init`, making the disabled-stack
  control falsely pass. It now counts that fast path and the nonduplicated slow
  allocation path. #151 includes the same repair as `796f5a4c`. Benchmark
  instrumentation already counted both paths, so old reports need no correction.
- Range bound-order fixtures lacked concrete unit-input signatures. Their repair
  passed the accepted interpreter and five native hosts in `38862399186`; the
  remaining queued job was superseded by the final combined focused run.
- The first field-borrow implementation still retained named array aliases.
  Linux ARM64's strict zero-retain control caught this in `38863443177`.
  Generated C confirmed the remaining counts. The named-field repair is
  `ac72124c`; the current five passing native hosts include that strict control.
  Superseded native `38863443177` and costs `38863448662` are canceled. Earlier
  WASI `38863445808` passed both hosts before that repair.

Guarded local formatting passed before the latest doc consolidation. The final
documentation audit passes (2.57 s), including all seven status rows. The inventory check at `1c5ace42` reports "Expected contract
changes verified": 378 declarations, 368 symbols and 262 contracted declarations.
The remaining review bucket has 91 declarations, not 91 independent features.
Its frozen baseline was not changed. Small fixtures were checked with accepted
#148's interpreter; no changed compiler was built locally. The local compiler
probe previously stopped with an OS signal error; no process remained and no
limit was raised. Changed-compiler validation remains on GitHub runners.

## Next concrete actions

Next: finish the final runner evidence and merge #151 when its exact-head gates
pass, then publish the combined ownership and allocation batch.

1. Monitor #151's exact-head gates, fix failures and squash merge when all pass.
   Verify tree, parent and exact message; cancel only duplicate postmerge gates.
2. Hash checks and two paired comparisons are complete at `ac72124c`. Preserve
   their retained evidence while validating the combined vector batch below;
   no hash compiler source changed after those focused checks.
3. Transfer this batch after #151 merges, reconcile docs and publish one substantial
   PR. Require fresh full production and docs checks for its combined final head.
4. Combine the vector preparation into this same substantial delivery once its
   focused checks pass. It is `/private/tmp/fwp-owned-vectors`, branch
   `owned-vector-preparation`, anchored at `aab2a928`; transfer only later commits.
   Runtime implementation `637b3eb2` runs native `38867603162` and WASI
   `38867607803`. Follow-up `6be8f245` adds a concept-first runnable example,
   manual-record compatibility coverage and a C/Rust lane comparison under
   `38869050349`; it does not change the runtime. Its own handoff records the contracts and failure controls.
   This avoids a separate full-matrix cycle for related numerical ownership.
5. Use measured remaining costs and ownership gaps to select the next batch.
   Browser/service boundaries, retained callbacks, numerical/network contracts,
   derivative scaling and OpenCL runtime compilation remain open. JIT is excluded.

Standing authorization covers fixes, publication and passing-CI squash merge.
Every commit is one line, at most 80 characters, with no body or trailers. Use
`python3 scripts/local-guard.py` for bounded serial local checks; do not increase
limits or restart the refused optimizer compilation. Full builds, suites,
benchmarks and large regeneration run on CI.
