# Session handoff

This worktree is **unfinished UDP-handle preparation**, branch `owned-udp-lifetimes`
in `/private/tmp/fwp-owned-udp`, based on `4d9ecadd`. The prepared delivery remains
`owned-values-delivery`; do not include this delta until its acceptance checks pass.
The earlier delivery/CI state below remains relevant.

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
This file holds the next action and current evidence; old preparation branches
are evidence, not a second backlog. Keep one open delivery PR at a time.

## Current delivery and integration

[PR #152](https://github.com/e6qu/fun-with-pipes/pull/152) is the only open delivery.
Its current head is `485665795e47f6d7d6e078d386bc56b9c8cdeded`; fresh production
`38901011355` and docs `38901011298` are queued/running. Earlier `c81b0c9f` passed
ARM macOS, Windows and benchmarks, but both Intel jobs exceeded 90 minutes with
many tests remaining; that superseded run is canceled. The proposed repair uses
Rust optimization level 1 for CI compiler/test binaries while explicitly retaining
debug assertions and overflow checks. Test coverage and generated-C flags stay
unchanged. Runner comparison `38901188943` tests profiles 0/1 on identical `c81b0c9f`
source with separate warm caches and balanced sample order. Do not claim a speedup
until the evidence and full gates pass.

Integration worktree: `/private/tmp/fwp-owned-values-delivery`, branch
`owned-values-delivery`, based on previous head `c81b0c9f`. It applies only the delta after
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

## Socket scratch cleanup added during review

Source review found that TCP/UDP receive scratch buffers are not registered for
nonlocal cancellation or result-allocation failure, and UDP send resolver entries
can survive cancellation. Fix these within this batch. Acceptance: inject wait
cancellation, receive-result allocation failure and native allocation failure;
require native storage to return to baseline, preserve timeout/normal/error
behavior, and require omitted-cleanup controls to fail on all six native hosts.
The implementation now registers receive buffers and UDP resolver entries on the
existing cleanup stack and rejects a failed native receive allocation before use.
The new `native_sockets` control uses real runtime unwind with injected wait,
allocation and timeout outcomes; existing real socket/web peers remain required.
This does not promote socket handles to checked ARC or establish final-owner
lifetimes. Local `cargo fmt` passed under the guard (1.31s); native validation runs in
focused `sockets` run `38898918147` at `7224b3de`, which passes all six hosts.

## Recorded results and current checks

[The owned-values/kernel report](measurements/owned-values-and-kernels-2026-10-16.json)
retains six-host artifacts from `38893386853` at `457f00d3`. All kernel, decoder,
metrics, web and ordinary-library checks pass. The Windows jobs failed only the
new unload fixture's export selection; repair `234da577` passes all six focused
unload jobs `38894911944`. Runtime sources did not change for that repair.
Actual WASI `38891578037` passes both hosts at `c8f4646c`, including registry
shutdown, 32-bit count narrowing and final-block overflow controls.

Fresh preparation `cba3e810` adds DNS and moves existing private-list helpers into
the common primitive file. [DNS evidence](measurements/dns-ownership-2026-10-16.json) records all six native
jobs `38897597329` and both actual WASI regression jobs `38897600949` passing.
The six native artifact sets each report 81 distinct addresses, 162 managed
requests, cleanup at every injected failure and zero final managed/native storage.
The report preserves source/binary hashes and explicitly excludes resolver speed
and C/Rust comparisons. Guarded evidence verification passed in 0.25s.

Later integration `7224b3de` moves the resolver cleanup helper and fixes socket
scratch storage. Focused six-host run `38898918147` passes all six native hosts, including DNS
and socket scratch omission controls at O1/O2. Its initial workflow also ran unrelated
filesystem tests; selection now names `paths`/`filesystem` explicitly so future
focused runs do not pick them accidentally. No coverage was removed from full CI.
Full combined production checks have not yet run.

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

The next memory slice should cover UDP handles and all five UDP operations. An
address list is ordinary data; a socket also owns an operating-system descriptor,
so last-owner destruction is observable. Preserve explicit close through aliases,
original function lifetimes, captures in closures/records/tasks, and pending I/O
cancellation. Do not make sockets non-capturable merely to reuse File's simpler
contract. Ordinary File handles have an independent resource count and forbid
captures; copying that policy blindly would change existing networking semantics.
Closure/container cleanup with `FWP_FREE=0`, unknown retained callback graphs and
GC/library finalizer removal need explicit review before promoting UDP contracts.
No UDP-handle implementation has been added in this delivery.

A bounded accepted-interpreter probe creates a socket in a helper, returns its
address, then binds that address again after the helper returns. Raw and optimized
interpretation both print `rebound` (0.26s/0.25s under the guard). This establishes
the reference result, not native ownership support. Native lifetime/alias/capture,
allocation-failure and long-running descriptor-count controls remain to implement
for that next slice after this delivery.

UDP acceptance before implementation: preserve all existing capturing and aliasing
semantics; match raw/optimized interpreter and native results, including scope-end
rebind; own descriptor storage and partial receive tuples; close on last owner and
on constructor failure; retain handles through suspended I/O; explicit close affects
all aliases. Verify closure/record/task holders, checked ARC with no tracing symbols,
stress/reuse, disabled physical frees, library unload and repeated descriptor counts.
No new surface syntax or capture prohibition. Partial implementation is not support.

The first full UDP fixture reproduces an existing lifetime bug: the accepted raw
interpreter prints `holder released`, but optimized interpretation retains the
closure's socket and fails to bind its address again. The earlier scalar-address
probe did not expose this. Preserve raw scope-end behavior in both engines.
The fixture also covers a retained holder, explicit close through aliases, a UDP
round trip, cancelled task captures and repeated creation. Its task constructor
uses explicit prefix application because a function on the left of `|` denotes
composition. New compiler/native tests are not yet run.

Guarded preparation checks: `cargo fmt --all` passed (1.07s), accepted-compiler
fixture formatting passed (0.01s), macOS schedule tests passed (0.13s), documentation
audit passed (2.81s), and the primitive inventory passed (0.95s: 306 contracted
declarations, 37 distinct symbols still under review). Native resource semantics
and compiler unit tests require the six-host `udp` evidence workflow; constructor
failure, exhaustive receive failures, unload and descriptor-ledger controls remain
unfinished. This is a preparation commit, not completed support.
