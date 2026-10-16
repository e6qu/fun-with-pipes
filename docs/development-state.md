# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
This worktree is UDP preparation: `/private/tmp/fwp-owned-udp`, branch
`owned-udp-lifetimes`, based on the prepared owned-values delivery at `4d9ecadd`.
It is not a second open PR and is not accepted platform support.

## Current delivery

[PR #152](https://github.com/e6qu/fun-with-pipes/pull/152) is the only open delivery.
Its head is `485665795e47f6d7d6e078d386bc56b9c8cdeded`. Documentation
`38901011298` passes; production `38901011355` is running. Require all nine jobs
on that exact head before squash merge. The subject must have one line, at most
80 characters, with an explicitly empty body and no trailers or attribution.
Verify the squash tree, parent and message, then cancel duplicate postmerge CI.
Standing authorization covers publication, fixes and successive merges.

The previous production head `c81b0c9f` passed ARM macOS, Windows and benchmarks,
but both Intel jobs exceeded 90 minutes. Its superseded run is canceled. The
current CI configuration optimizes Rust compiler/test builds at level 1 while
retaining debug assertions and overflow checks, test coverage and generated-C
flags. Comparison `38901188943` passes both AMD64 hosts: selected-test median
elapsed ratios are 0.805 on Linux and 0.747 on Intel macOS versus level 0. Initial
builds cost an extra 26.63s/158.20s. This does not predict full-gate timing or
measure fwp/C/Rust program parity. The report is committed in prepared delivery
`7b6775a8`, `docs/measurements/ci-compiler-profiles-2026-10-16.json`.

## Next substantial delivery

`/private/tmp/fwp-owned-values-delivery`, branch `owned-values-delivery`, head
`7b6775a8`, is based on `c81b0c9f`. After #152 merges, rebase only its delta after
`c81b0c9f` onto the accepted squash; preserve the CI profile settings, formatting
preflight and final numerical optimizations/reports. Publish one combined PR.
Add this UDP delta only after its focused acceptance passes.

The prepared batch owns ternary, URL/form/HTTP and compressed-byte/frame decoder
results, metric snapshots, syntax text, CPU tensor output/scratch and DNS lists.
It repairs Windows web prerequisites, clocks, retry checks, shutdown and unload
fixtures. Socket receive buffers and UDP resolver storage unwind on cancellation
and allocation failure. Exact evidence is retained in
[owned values and kernels](measurements/owned-values-and-kernels-2026-10-16.json)
and [DNS](measurements/dns-ownership-2026-10-16.json).

- Owned values/kernel run `38893386853` at `457f00d3`: all relevant tests pass;
  Windows failed only the new unload fixture's export selection. Fixture repair
  `234da577` passes all six unload jobs `38894911944` without runtime changes.
- Actual WASI `38891578037` at `c8f4646c`: both hosts pass.
- DNS `cba3e810`: all six native jobs `38897597329` and both actual WASI regression
  jobs `38897600949` pass. The deterministic peer checks 81 distinct addresses,
  all 162 managed allocation failures and zero final measured storage.
- Integrated socket scratch repair `7224b3de`: all six native jobs `38898918147`
  pass, including real socket behavior and omitted-cleanup controls.
- Combined full production gates have not yet run for this next delivery.

## UDP acceptance and implementation

Preserve aliases, original scopes and captures without new syntax or File's
capture prohibition. The last owner closes the OS descriptor; explicit close
changes every alias. Suspended I/O must retain its socket and unwind correctly.
Own partial receive results and constructor storage. Require raw/optimized
interpreter parity, O1/O2 native tracing stress/reuse and checked ARC, no tracing
symbols in ARC binaries, disabled-physical-free cleanup, actual library unload,
repeated descriptor counts and deliberately broken cleanup controls.

The preparation adds five UDP operation contracts and a separate 64-bit logical
owner count. It preserves original resource frames and possible closure holders
before optimization; opaque function types do not expose captures. That
conservative policy may inhibit optimizations and is not a zero-cost claim.
Trace-mode finalizers cover unproved sharing; checked ARC still rejects unproved
retention. TCP/TLS ownership and arbitrary callback graphs remain work.

A reproduced optimizer bug motivates the frame change: raw interpretation releases
a captured socket when its helper returns only an address, while the accepted
optimized interpreter keeps it alive and makes rebind fail. The new compiler must
match the original behavior. Prefix application constructs task callbacks where
putting a function on the left of a pipe would instead mean composition.

The tests cover 4096 bind/drop cycles, 301 aliases, constructor failure, all three
receive allocations, closure/record holders, suspended receive cancellation,
two simultaneous receivers closed through another alias, and library load/unload
while a host socket remains open. Linux now releases closed-descriptor wait lists
and their empty table; resumed tasks do not recreate removed entries. Omitted
wait-list cleanup must fail the same charged-storage assertion.

Address review also found native C-string truncation at embedded NUL bytes.
The shared TCP/UDP resolver now receives the complete string value and rejects
NUL before using its prefix. Interpreter validation reports the same explicit
error. Separate regressions cover TCP listen/connect and UDP bind/send; ordinary
raw/optimized output and native stress behavior must agree.

## Focused results and next action

| Revision | Run | Result |
|---|---|---|
| `91f24f63` | `38904425456` | Initial lifetime checks pass Linux/Windows, both architectures; superseded before both macOS jobs completed; canceled. |
| `947a6868` | `38905209906` | Expanded constructor/receive/unload checks pass on Linux ARM64; suspended receive exposes retained Linux polling storage. Windows2 and ARM macOS pass. Superseded run canceled. |
| `89e66d53` | `38906218307` | Polling repair passes all six native hosts. |
| `89e66d53` | `38906222140` | Actual WASI shared-helper regression queued; no networking claim. |

Next: publish the compact-header repair, then
run fresh six-native `udp` and actual `wasi-arc` checks, retiring superseded work.
Inspect any failure and fix it. Retain successful functional/cleanup C, binaries,
statuses and outputs with exact source hashes before integrating into the delivery.
No local native build has been run. Full production remains required after merging
preparation into the next PR.

## Local checks and resource limits

Use `python3 scripts/local-guard.py` serially: at least 64 GiB free disk, target
data below 2 GiB, sampled workload RSS below 1 GiB and a 180-second deadline.
Full builds, tests, benchmarks and large regeneration run on GitHub. Earlier local
fwp and standalone C builds were refused by automatic approval review; do not
retry or bypass that restriction. Current disk availability is about 92 GiB.

The accepted reference compiler is
`/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp`.

| Guarded check | Latest result |
|---|---|
| `cargo fmt --all` | Pass, 1.30s |
| Accepted compiler `fmt` / `check` for address fixture | Pass, 0.01s / 0.25s |
| Raw accepted-interpreter UDP fixture | Pass, 0.36s; original lifetime and invalid-address reference |
| Primitive inventory | Pass, 0.95s; 306 contracted declarations, 37 distinct review symbols |
| macOS schedule tests | Pass, 0.13s; 228 integration targets assigned |
| Standalone `tests/stdlib_doc.rs` regeneration/recheck | Pass, 0.13s / 0.01s; generated from library comments |
| `python3 scripts/check-roadmap.py` | Pass, 2.78s |

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

Remaining ownership review is mostly networking plus exit and GPU execution.
Inventory counts do not settle retained callbacks, mutable cycles or host re-entry.
The existing OpenCL runtime build remains incompatible with the no-JIT objective.
No JIT, new backend or distributed execution is authorized as a workaround.

Final representation review found that a separate UDP count field enlarged all
TCP headers too. UDP now shares the existing TLS payload slot under the socket
kind tag. Actual generated-runtime tests require the prior header size and proper
64-bit alignment; a destructor probe with TLS enabled rejects treating a UDP
counter as a TLS pointer. Its broken-tag control must exit 248. This layout change
needs fresh runner checks; it is not a measured throughput improvement.

The final focused increment keeps the previous header size on each ABI and tests
TLS/UDP tag dispatch, including a deliberately missing-tag failure. Guarded
`cargo fmt --all -- --check` and the documentation audit pass (1.11s/2.76s).
The preceding polling implementation `89e66d53` passes all six native jobs in
`38906218307`; the address and final header changes still require fresh checks.
#152 now has passing Windows2, ARM macOS regular/GC, benchmarks and docs; Linux2
and both Intel macOS jobs remain in progress. Do not merge early.

Runtime `8d9a79cb` is under final six-native `38907692064` and actual WASI
`38907697173` validation. The only following increment extends library acceptance:
ordinary and checked-ARC exports repeatedly create/release UDP sockets before
returning; both undergo real unload, host-socket preservation and missing-finalizer
controls. The existing `library-unload` workflow now includes that targeted test.
There is no runtime change in this test increment, so its focused result can be
combined with the earlier exact-runtime checks before full production acceptance.

`8d9a79cb` exposes two validation issues. Windows ARM64 passes normal UDP,
allocation/unload and address checks but the isolated TLS-tag probe requested
OpenSSL linking via the production feature marker. Its valueless preprocessor
switch now enables only the tested destructor branch; controlled peers supply
those operations, with no OpenSSL runtime dependency. The WASI workflow's native
collector-free allocator controls failed because UDP cleanup referenced native
collector metadata. That path now uses the existing typed collector-free free
operation, matching File cleanup. Actual WASI program tests passed, but the whole
regression gate remains failed until all controls pass. Neither failure is waived.
Fresh six-native and WASI validation is required for this repair; the separate
ARC-library test increment also remains under validation.
