# Session handoff

Updated 2026-10-14. Continue all remaining work in **one follow-up PR**, branch
`roadmap-after-135`. The user merged PR #135 and explicitly asked to continue.
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
They have not executed yet. TLS tests explicitly select Git's OpenSSL curl for
PEM client keys and compare the limited Windows reset/alert failure category.

Historical development runs and measured wide-record reductions are in
[history](roadmap-history.md#pr-135-development-evidence) and
[the measurement artifact](measurements/wide-records-2026-10-14.json).

- At `6fde679d`, [Windows full preflight](https://github.com/e6qu/fun-with-pipes/actions/runs/38542607906)
  passed dependency setup, allocator/context/socket probes, interpreter goldens
  and generated resource/task/process stress on both architectures. This fixes
  the earlier AMD64 task-root failure. Remaining failures: two CLI fixtures
  lacked module exposure; exact-float headers selected an older Windows API
  before the runtime; WebSocket code called POSIX getpid; manual linking lacked
  Windows libraries; package smoke expected fixed rather than shortest quad
  text. Mutual TLS also assumed the peer rejection must arrive during handshake
  rather than a subsequent read. Repairs are implemented, pending rerun.
- [Four-host ownership](https://github.com/e6qu/fun-with-pipes/actions/runs/38542604291)
  at `6fde679d` failed. Inspected Linux ARM/macOS ARM failures are the two CLI
  fixtures and stale numeric ownership inventory expectations. At `72959c75`,
  [the repaired batch](https://github.com/e6qu/fun-with-pipes/actions/runs/38545352758)
  also includes array producer fusion, physical ARC reclamation and Linux pipe
  descriptor/mapping omission controls; it is running.
- [Checkpointing](https://github.com/e6qu/fun-with-pipes/actions/runs/38545880795)
  at `a732cdda` exposed a test literal incorrectly fixed to a primitive float
  instead of Rev, and an ARC proof that invoked closures merely carried as
  loop data. The repair uses runtime callback contracts to identify invocation
  positions and feeds callback results through subsequent iterations. A lowered
  IR control accepts a carried getter but rejects its actual unscoped call.
  Updated fixtures check raw/native behavior, errors, exact float types, ARC
  reclamation, tape bounds and omitted retirement; rerun remains required.
- At `fc697328`, [checkpointing](https://github.com/e6qu/fun-with-pipes/actions/runs/38546865567)
  passes raw and tracing-native semantic checks before ARC rejects the missing
  `prim.trap` contract. The contract is now explicitly Never; the native
  implementation unwinds its borrowed message. The macOS job also exposed a
  missing OpenSSL setup for library tests, now added. The new owned tape
  primitives and trap contract pass the guarded frozen-baseline audit
  (378 declarations, 223 contracts). Runtime C syntax and focused lint pass.
- The `72959c75` macOS ARM ownership/fusion batch passed. Linux ARM failed only
  because the standalone pipe probe omitted `fwp_static_memory`; the fixture
  now defines the dynamic-memory setting explicitly. Windows repairs are
  running at `fc697328` in [38546869551](https://github.com/e6qu/fun-with-pipes/actions/runs/38546869551).
  Dependency caches now save immediately after successful setup so later test
  failures do not force another OpenSSL source build.
- [First nested batch](https://github.com/e6qu/fun-with-pipes/actions/runs/38548685796)
  at `b4a28f47` passed the library unit tests (including callback-flow controls)
  and the Linux pipe descriptor/mapping proof. Language fixtures failed on an
  ambiguous owned-tape scalar: passing only a count erased its type connection.
  `ad.tape-owned` now borrows the typed input list and counts it without copying;
  its operation tuple is inferred from that element type. This repair needs
  runner execution; no nested/checkpoint lifetime acceptance is claimed yet.
- Guarded local `cargo fmt --all` and `cargo clippy --lib --tests -- -D warnings`
  pass. These do not execute the language fixtures. The guarded primitive
  inventory audit passed with 378 declarations and 223 contracts before the
  Boolean `not` contract below; frozen
  baseline evidence is unchanged. Full builds/tests/measurements stay on runners.
- At `59da2033`, [autodiff](https://github.com/e6qu/fun-with-pipes/actions/runs/38549214020)
  passes raw/tracing nested semantics, active-zero and stale/mixed controls,
  checkpoint capacity/errors and library unload. ARC checkpoint compilation
  needs the immortal Bool `not` contract; ARC tests must disable tracing-only
  reuse quarantine, and the numeric scope omission probe must distinguish the
  new managed backward function. All three repairs are implemented for rerun.

## Next action

Next: run the nested reverse implementation and repaired checkpoint/pipe proofs,
inspect the Windows portability batch, and fix every failure. Complete managed
tape failure/cancellation/library-unload proofs and Windows static memory.
Wire both native Windows acceptance jobs into production CI, finish remaining
measurement/ABI/ownership validation and streamline final docs. Keep all work
in the follow-up to PR #135. Require all seven Linux/macOS production jobs, both native Windows
acceptance jobs and docs on the final head before squash merge.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused local work.
Preserve 64 GiB free disk, target below 2 GiB, aggregate sampled RSS below 1 GiB,
and the 180-second limit. Do not use the stale local compiler as an oracle or
raise limits. Cancelled, skipped and superseded runs are not passing gates.
