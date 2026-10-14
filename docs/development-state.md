# Session handoff

Updated 2026-10-14. Continue all remaining work in **one follow-up PR**, branch
`roadmap-after-135`, [PR #136](https://github.com/e6qu/fun-with-pipes/pull/136).
The user merged PR #135 and explicitly asked to continue.
Publication, fixes and squash merge after passing final-head
CI remain authorized. Do not merge a partial bundle or narrow its scope.
Every commit has one line, at most 80 characters, with no body or trailers.
Failing tests are work to fix; queued CI gates merging, not implementation.

## Baseline

The user merged PR #134 as `5c0287c959ad705a6ceefebe83346015cb23fff5`.
Its tree equals tested head `29b48c31a7012c941d0bc555ee51d12c2c594b0b`;
all seven Linux/macOS production jobs and docs passed.
[History](roadmap-history.md#pr-134-merge-closeout) preserves this acceptance.
The user merged PR #135 as `ad37059e5769a54911ee05ee3b7a11faf90f3480`.
Its tree equals head `5d6e96d895b80d8d4e9c142944a7016453e84f40` exactly.
This was a user merge before final platform acceptance; remaining work and
unresolved checks continue on `roadmap-after-135` without replaying merged code.

## Active bundle

| Step | Status | Implemented and still required |
|---|---|---|
| 1 | Implemented | One live handoff and immutable historical evidence; keep docs accurate through final acceptance |
| 2 | In progress | Four-host retained-task/scoped foreign proofs pass; CLI/protocol ownership and executable ARC implemented, new fixture repairs under validation; cycle boundaries remain explicit |
| 3 | In progress | Four-host wide record allocation measurements pass; numeric tail loops and direct array producer fusion implemented, latest ownership/transport/instruction checks running |
| 4 | In progress | Four-host nested/checkpoint semantic and ARC controls pass; managed failure/task/unload and checkpoint measurements pass four hosts; final gates remain |
| 5 | In progress | Actual F16/BF16/F128 values, text, arrays, closed workers, foreign ABI and protocol v2 implemented; final precision/ownership/platform gates remain |
| 6 | In progress | Windows native allocator/fiber/socket, interpreter goldens and generated resource/task stress passed both architectures; static memory/TLS repairs under validation; production gates are wired |

Scope includes Windows ARM64/AMD64 and actual half/quad formats, superseding
old deferrals. Follow [PLAN](../PLAN.md), [ownership](ownership.md) and the
[float contract](float-formats.md). No new backend, JIT or deployment interface.

## Current implementation and boundaries

- Typed owners cover retained task results/cancellation, synchronous foreign
  callbacks and copied/borrowed strings, CLI parsing and native executable
  arguments/defaults/frames/results/errors. Every exported ARC entry starts
  without an assumed State or AD scope. Linux pipe teardown closes descriptors
  and unmaps rings, including rejected headers and excess SCM_RIGHTS descriptors.
  Service/remote/library/WASM executable boundaries and unproved cyclic/channel/
  raw mutable graphs remain outside this expanded ARC admission.
- Exact formats use vendored SoftFloat 3e, scoped gdtoa and TLFloat 1.15.0.
  Canonical arithmetic NaNs, payload-preserving bit transport, direct decimal
  rounding and a 1-ULP transcendental contract are explicit. Protocol v2 has
  2/2/16-byte little-endian payloads and rejects incompatible versions.
  Half/bfloat arrays use two bytes and quad arrays sixteen; escaping quad values
  own their boxes. Closed numeric records/workers carry wide bits directly.
  Generic wide boundaries can still box. `SFloat` macros carry decimal text.
- Numeric self-tail calls evaluate arguments before replacing parameters and
  tick per iteration. Direct array-to-list iterator chains retain an array and
  advance an index; array construction, callback effects and trap order remain
  observable. Measurements compare enabled/disabled transformations and inspect
  generated C/native instructions; no universal speed claim follows.
- `vjp-checkpointed {steps, every} step seeds` stores ordinary checkpoints and
  replays one bounded segment per backward pass. Counts and segment precision
  are explicit; zero work and invalid seed sizes have controls. Nested reverse
  mode now uses `ReverseScalar` specialization and typed owned tape weights;
  adjoint arithmetic records into the enclosing tape. Controls cover second/
  third derivatives, active zeros, stale/mixed tokens, exact floats and physical
  reclamation. Raw, tracing-native and ARC focused controls pass; final platform
  acceptance remains pending.
- Windows uses UTF-16 native paths/environment/arguments, CreateProcessW with
  explicit inherited handles, concurrent output capture, native threads/fibers,
  full-width sockets/WSAPoll and PE roots. Root scanning and minor verification
  now share the same application stack bound, excluding collector scratch.
  LLVM-MinGW and vcpkg/OpenSSL sources are pinned. TLS COFF linking, dependency
  architecture checks and standalone PE packages are implemented but unaccepted.
  Windows static-memory reservations, reusable worker/fiber pools and explicit
  decimal scratch allocation are implemented locally with new native tests;
  runner execution remains required. DLL/OS resource allocations are excluded
  from the runtime storage budget.

## Current validation

- [Autodiff 38554877275@c5f9ff42](https://github.com/e6qu/fun-with-pipes/actions/runs/38554877275)
  passes on Linux AMD64/ARM64 and macOS Intel/ARM: all library tests, nested
  second/third derivatives, active zeros, stale/mixed/task identity, managed
  tape growth and wide reference counts, recovered failure/cancellation and
  real library unload. Omitted releases fail the controls. Existing numeric
  tape scopes/workspaces/capacity, checkpoint errors and Linux pipe teardown
  controls also pass. This is focused evidence, not final production acceptance.
- The same four-host run measures the 4096-step additive VJP at checkpoint
  intervals 16/32/64. Interval 32 cuts peak tape storage 262,248 → 2,152 bytes,
  increases managed peak 336 → 12,816 bytes and does more allocations and work.
  All measured storage is reclaimed without collection. Separate peaks are
  not necessarily simultaneous. Hardware/compiler/flags, timings, counts and
  hashes are in [the artifact](measurements/checkpoint-2026-10-14.json).
- [Windows 38555042817@c5f9ff42](https://github.com/e6qu/fun-with-pipes/actions/runs/38555042817)
  passes native foundations, interpreter goldens and generated resource/GC stress
  on both architectures. Static-memory exhaustion and fatal task exits pass.
  The reuse fixture failed before native execution at nonexistent `string.join`;
  it now calls the existing `join`. Startup-only allocation, worker/fiber reuse,
  pool scratch and negative allocation controls still require execution.
- [Full Windows 38552879801@e5fecb81](https://github.com/e6qu/fun-with-pipes/actions/runs/38552879801)
  passes AMD64 executable/CLI/foreign/task ownership, exact formats/protocol,
  native goldens and standalone packaging. TLS passes 9/10 cases: the remaining
  snapshot needs Windows peer-close normalization alongside reset/alert rejection.
  AD probe failures need CRLF handling and a Windows stack bound on the injected
  cancellation task. The older cross-task source typo is already fixed.
  ARM64 is completing. Neither architecture is accepted yet.
- The intermittent Windows allocator probe retained a stale mutator pointer to
  its supposed collector-only garbage. Its injection now creates that object
  inside the collector frame; a guarded current-runtime O1/O2 probe passes with
  the correct boundary and fails with the omitted boundary. CI repeats processes
  across address layouts. No runtime root range was weakened.
- Guarded local formatting, focused clippy, runtime and measurement C syntax,
  workflow lint, primitive inventory and roadmap/link/commit checks pass.
  Generated stdlib docs have been refreshed; old merged-main preflight failures
  require the final production run. Full builds/tests/measurements run on CI.
- Completed merged-main macOS ARM shard exposed three older harness failures:
  ARC corpus charged permanent scheduler root storage; CSV trap injection still
  named an old constructor; early task publication injection missed the new
  Windows conditional. The fixtures now initialize the scheduler baseline and
  assert current injection markers. A guarded O1 compile/run of the runner's
  emitted preemption program confirms balanced charged bytes after the baseline
  repair; current compiler agreement and all controls require CI. Preemption compares
  matching optimization settings because inlining changes function-entry counts;
  both raw engines now have a separate regression. Task preparation now owns
  the unpublished task allocation through scope/stack failure, with a physical
  reclamation ledger and a missing-release control pending CI.
- Both Windows architectures share one reusable acceptance workflow, including
  native nested AD, ownership, exact formats and standalone PE packaging.
  Require these plus all seven Linux/macOS production jobs and documentation.
- Earlier development evidence and wide-record reductions remain in
  [history](roadmap-history.md#pr-135-development-evidence) and
  [the measurement artifact](measurements/wide-records-2026-10-14.json).

## Next action

Next: publish the batched platform/probe repairs, then inspect full production
CI and fix every failure. The Windows static fixture now creates its numeric
array directly to avoid irrelevant list construction under per-allocation GC. Run full production gates
and streamline final docs with actual acceptance results. Keep all work
in the follow-up to PR #135. Require all seven Linux/macOS production jobs, both native Windows
acceptance jobs and docs on the final head before squash merge.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused local work.
Preserve 64 GiB free disk, target below 2 GiB, aggregate sampled RSS below 1 GiB,
and the 180-second limit. Do not use the stale local compiler as an oracle or
raise limits. Cancelled, skipped and superseded runs are not passing gates.
