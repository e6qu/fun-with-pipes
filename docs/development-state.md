# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
This file holds the next action and current evidence; old preparation branches
are evidence, not a second backlog. Keep one open delivery PR at a time.

## Current delivery and integration

[PR #152](https://github.com/e6qu/fun-with-pipes/pull/152) is the only open delivery.
Its head is `c81b0c9f016f0e359f22e8819792baba0760ab30`; production `38890080777`
is running and docs `38890080771` pass. ARM macOS regular/stress, benchmarks and
both Windows jobs pass; Linux and Intel macOS remain running. Do not alter this
head for the following work. A prior run exposed an unformatted vector example;
the current head fixes it and checks language formatting before long suites.

Integration worktree: `/private/tmp/fwp-owned-values-delivery`, branch
`owned-values-delivery`, based on that exact head. It applies only the delta after
`3577ba3780c19051845a5beba3f064f608cedf1e` from preparation `cba3e810` on
`owned-cpu-kernels`. Numerical optimizations, measurements and early formatting
checks from #152 remain. The preparation worktree is `/private/tmp/fwp-owned-kernels`;
its published history preserves the original measured commits. Do not replay its
older numerical ancestry or open a competing PR.

Next: finish #152's gates and fix any failure. Once all nine production jobs and
docs pass for its exact head, squash merge with subject
`Borrow hash inputs and remove temporary numerical storage` and empty body.
Verify merge tree, parent and exact one-line message before canceling duplicate
postmerge production. Move this integration delta onto the accepted squash, finish
its focused checks, and publish the next substantial PR. Require fresh full
production and docs for that PR; focused preparation is not final acceptance.

Standing authorization covers publication, fixes and successive squash merges.
Every commit has one line, at most 80 characters, no body/trailers/attribution.
Queued CI gates merging, not independent work. Failed tests are work to fix.

## Next delivery: owned values, CPU kernels and DNS

The batch must preserve interpreter/native values, aliases, effects and trap
order while owning results and partially built values. Acceptance includes raw
and optimized interpreter comparisons, O1/O2 native tracing stress/verification,
reuse verification, checked ARC, cleanup failures and deliberately broken cleanup
controls. Actual WASI validates supported helpers and physical frees. Native-only
compression and networking are not WASI support.

- Ternary conversions traverse input lists directly and own partial results;
  packing writes result bytes directly. Width, digit, padding and count behavior
  stay unchanged.
- URL/form/HTTP decoders own copied fields and errors. HTTP builds headers without
  line-index/value scratch arrays. Compression and WebSocket helpers own native
  buffers while managed result construction can fail.
- Metrics compare complete names, including embedded NUL, and return copied
  immutable snapshots. Repeated updates reuse registry entries; new names consume
  storage. Registry storage is released at process exit or library unload.
  Syntax rendering owns its temporary native buffer.
- CPU tensor workers copy chunks into one owned result array, eliminating a
  second full-size native output and copy. Reductions retain ordered block sums
  and per-worker workspace. Failed thread creation joins started workers before
  trapping. Full-width counts and final-block indices are checked before narrowing
  or adding; small address-limit tests do not allocate huge arrays.
- DNS owns OS resolver entries and partial/final address lists. It preserves
  first-seen order and deduplication without the old 64-address cutoff. Both
  engines reject embedded NUL bytes. Real numeric/localhost tests are paired with
  a deterministic 81-address peer and all 162 managed-allocation failure points.
- Windows repairs cover native HTTP/2/OpenSSL prerequisites, console shutdown,
  clock selection and would-block handling. A real LoadLibrary/FreeLibrary peer
  verifies cached values, metric storage, suspended tasks, TLS keys, console
  handlers and host-owned resources at unload and static process exit.

## Recorded results and current checks

[The owned-values/kernel report](measurements/owned-values-and-kernels-2026-10-16.json)
retains six-host artifacts from `38893386853` at `457f00d3`. All kernel, decoder,
metrics, web and ordinary-library checks pass. The Windows jobs failed only the
new unload fixture's export selection; repair `234da577` passes all six focused
unload jobs `38894911944`. Runtime sources did not change for that repair.
Actual WASI `38891578037` passes both hosts at `c8f4646c`, including registry
shutdown, 32-bit count narrowing and final-block overflow controls.

Fresh preparation `cba3e810` adds DNS and moves existing private-list helpers into
the common primitive file. Native run `38897597329` and actual WASI `38897600949`
are queued/starting. Earlier evidence does not cover these new changes. Full
combined integration checks have not yet run.

For the fixed 8193-element F64 kernel, one-worker native temporary allocations
fall from three to two and native peak from 69,648 to 4,104 bytes against immutable
executor `21a621c6`. The managed output array remains; separate peaks cannot be
added as if they were simultaneous. Four-worker peak depends on overlap. Actual
ARC probe binaries contain packed multiply instructions and workspace copies.
This is an allocation comparison between fwp implementations, not elapsed-time,
cache, register-only or C/Rust parity evidence. See [benchmarks](benchmarks.md).

#152's final numerical runtime `b1a34ea0` passes six-native `38877218687`, both WASI
`38877223390`, four-host costs `38877226777` and paired run `38881665737`.
[Scalar-splat evidence](measurements/vector-scalar-splats-2026-10-16.json) records
two final-output allocations and zero retains/final storage for both selected
workloads. [Paired comparisons](measurements/vector-paired-2026-10-16.json) retain
remaining C/Rust overhead. Preserve these reports and the final scalar optimizer
when rebasing; neither result establishes whole-language zero-cost abstractions.

## Local checks and resource limits

Use `python3 scripts/local-guard.py` for serial focused checks: 64 GiB free disk,
target data below 2 GiB, sampled aggregate RSS below 1 GiB, 180-second deadline.
Full builds, suites, benchmarks and large regeneration run on GitHub. Earlier
local fwp builds and a standalone C probe compilation were refused by automatic
approval review; neither was bypassed. Do not retry them locally.

Latest guarded DNS-preparation checks:

| Check | Result |
|---|---|
| `cargo fmt --check` | Pass, 1.07 s |
| Accepted compiler `check tests/fixtures/dns_ownership.fwp` | Pass, 0.26 s |
| Standalone library-reference regeneration and recheck | Pass, 1.20 s |
| Primitive inventory against immutable baseline | Pass, 0.36 s; 301 contracted declarations, 42 distinct review symbols |
| `python3 scripts/check-roadmap.py` | Pass, 2.69 s |
| `python3 scripts/test-macos-test-shards.py` | Pass, 0.13 s |

The first DNS inventory check correctly rejected an unlisted contract transition;
the explicit expected transition is now audited. No local check establishes
native support. The accepted reference compiler is
`/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp`. After integration, guarded `cargo fmt --check` passed (1.30s), language formatting
for `lib examples docs/tutorials bench` passed (0.13s), the inventory passed (1.08s,
301 contracts/42 review symbols), and the documentation audit passed (2.57s).
The first consolidated handoff omitted its required status table; the table is
restored and the audit now passes. These checks do not replace combined runtime CI.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Deployment and primitive ownership; remove tracing GC |
| 2 | In progress | Remove remaining functional abstraction costs |
| 3 | In progress | Diagnose and reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation speed, memory scaling and precision |
| 5 | In progress | CPU kernels and the runtime OpenCL compilation gap |
| 6 | In progress | Repeatable comparisons across representative workloads |
| 7 | In progress | Larger numerical, collection-heavy and long-running programs |

The remaining ownership review is mostly networking plus exit and GPU execution.
Socket/callback lifetimes, mutable cycles and host re-entry need explicit policies
beyond the inventory count. The existing OpenCL runtime build violates the no-JIT
direction and remains unresolved; CPU changes do not fix that gap. No JIT, new
backend or distributed execution is authorized as a workaround.
