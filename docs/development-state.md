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
| 4 | In progress | Segmented checkpointing and nested reverse differentiation implemented, runner proofs pending; remaining measured kernel/layout work and acceptance remain |
| 5 | In progress | Actual F16/BF16/F128 values, text, arrays, closed workers, foreign ABI and protocol v2 implemented; final precision/ownership/platform gates remain |
| 6 | In progress | Windows native allocator/fiber/socket, interpreter goldens and generated resource/task stress pass both architectures; TLS/package fixes pending, static memory and required production gates remain |

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
  reclamation. Raw and tracing-native semantics pass; ARC acceptance is pending.
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

Follow-up local checks: guarded `cargo fmt --all`, `cargo clippy --lib --tests
-- -D warnings` (23.4 seconds), runtime C syntax and `check-roadmap.py` pass.
The standalone guarded `tests/stdlib_doc.rs` generator refreshed the merged
autodiff signatures in `docs/stdlib.md`; final CI must check it without blessing.
Windows static tests now require task/worker reuse, no runtime VirtualAlloc/
CreateThread/CreateFiberEx after startup, committed stack arguments, exhaustion
diagnostics, GC stress/reuse and an injected allocation failure control.
They have not executed yet. TLS tests explicitly build a native OpenSSL curl for
PEM client keys and compare the limited Windows reset/alert failure category.

- At merged head `5d6e96d8`, [autodiff 38550312989](https://github.com/e6qu/fun-with-pipes/actions/runs/38550312989)
  **passes all four Linux/macOS hosts**: nested analytical derivatives, active
  zeros, stale/mixed tokens, checkpoint capacity/errors, ARC physical releases,
  callback scope controls, existing tape failure/cancellation/unload and Linux
  pipe descriptor/mapping proofs. The three earlier harness/contract failures
  are fixed. This is focused evidence, not a full production gate.
- Windows [38546869551@fc697328](https://github.com/e6qu/fun-with-pipes/actions/runs/38546869551)
  failed TLS on both architectures. Native foundations, interpreter/generated
  goldens, runtime stress and standalone compiler/package step passed. The
  failures concern Schannel curl with PEM keys and TCP reset/alert differences.
- [Windows 38551180442@c230a360](https://github.com/e6qu/fun-with-pipes/actions/runs/38551180442)
  failed dependency peer setup: Git's curl also uses Schannel. The pinned vcpkg
  build now explicitly requests `curl[core,openssl,tool]`; dependency caching
  preserves a completed install even if a later validation fails. Static-memory
  tests did not execute in that batch. No Windows acceptance is claimed yet.
- New follow-up tests inject recovered failures at five managed-tape stages,
  cancel a task with a live product owner, and track managed storage across real
  shared-library unloads. Omitted releases must fail. Guarded formatting and
  focused lint pass; these new cases require runner execution.
  At `2f70e2f8` in
  [38551928641](https://github.com/e6qu/fun-with-pipes/actions/runs/38551928641).
  managed library unload and omitted-free controls pass. The failure-injection
  fixture matched a second unrelated result constructor; its marker is now
  restricted to the managed backward result, and rerun is required.
  A subsequent review found that native managed tapes lacked the interpreter's
  task-owner check. Native task identity and WASM interpreter fiber identity
  are now explicit, with a raw/native cross-task rejection test pending.
- `scripts/measure-checkpoint.py` compares the same 4096-step additive VJP with
  a full tape and intervals 16/32/64. It records compiler/hardware/flags,
  managed and tape allocations/live bytes, process timings and native assembly;
  runner measurements are pending. It requires reclamation and a smaller tape
  peak, not a universal time improvement.
- Both Windows architectures now share one reusable acceptance workflow between
  manual preflight and production CI, with explicit final-head checkout. It
  includes nested AD/ownership and packaging as well as native runtime stress.
  It is required alongside all seven existing Linux/macOS jobs and docs.
- Historical development runs and measured wide-record reductions remain in
  [history](roadmap-history.md#pr-135-development-evidence) and
  [the measurement artifact](measurements/wide-records-2026-10-14.json).

## Next action

Next: execute the new managed-tape failure/cancellation/unload controls, inspect
the Windows static-memory/TLS batch and fix every failure. Finish remaining
measurement/ABI/ownership validation and streamline final docs. Keep all work
in the follow-up to PR #135. Require all seven Linux/macOS production jobs, both native Windows
acceptance jobs and docs on the final head before squash merge.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused local work.
Preserve 64 GiB free disk, target below 2 GiB, aggregate sampled RSS below 1 GiB,
and the 180-second limit. Do not use the stale local compiler as an oracle or
raise limits. Cancelled, skipped and superseded runs are not passing gates.
