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
| 6 | In progress | Windows native allocator/fiber/socket, interpreter goldens and generated resource/task stress passed both architectures; static-memory and TLS controls pass both hosts; final production gates remain |

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
  decimal scratch allocation pass native fixtures on both architectures; final
  gates remain. DLL/OS resource allocations are excluded
  from the runtime storage budget.

## Current validation

- [Production 38558134779@09db8f25](https://github.com/e6qu/fun-with-pipes/actions/runs/38558134779):
  Both macOS GC jobs, both Windows jobs, bench and docs pass. The complete macOS ARM regular test shard
  passes except for library formatting; current-source formatting now preserves
  the syntax tree and is idempotent. Both Windows architectures pass foundations,
  interpreter goldens, generated runtime/GC stress, static-memory controls,
  TLS/executable ownership, native nested AD, native goldens and standalone
  packages: both Windows jobs are green. Linux AMD64 completed with the same
  formatting failures and a WASM CLI static-initializer error. Other Linux/Intel
  jobs are running. This older head is diagnostic evidence, not the final gate.
- [Focused 38560981174@b4d072bb](https://github.com/e6qu/fun-with-pipes/actions/runs/38560981174):
  all four Linux/macOS hosts pass the latest nested AD, completed-task identity,
  partial-retain unwind and omitted-release controls, numeric tape scopes,
  workspaces/capacity, library unload, checkpoints and Linux pipe ownership.
  Checkpoint measurements also pass on all four hosts.
  Full WASM and Windows checks of these newest changes still require the final run.
- [Four-host checkpoint evidence](https://github.com/e6qu/fun-with-pipes/actions/runs/38554877275)
  at `c5f9ff42` measures a 4096-step additive VJP with intervals 16/32/64. Interval
  32 cuts peak tape storage 262,248 → 2,152 bytes and increases managed peak
  336 → 12,816 bytes, allocations and elapsed time. Separate peaks need not be
  simultaneous. All measured storage is reclaimed without collection. Hardware,
  compiler, flags, timings, counts and hashes are in
  [the artifact](measurements/checkpoint-2026-10-14.json).
- Both Windows architectures previously passed native goldens, exact formats,
  foreign ABI and standalone packaging in
  [38552879801@e5fecb81](https://github.com/e6qu/fun-with-pipes/actions/runs/38552879801).
  Its TLS peer-close, CRLF probe and synthetic cancellation stack-bound failures
  are repaired and pass the corresponding stages of the newer production run.
- macOS ARM GC now passes the repaired ARC corpus/scheduler baseline, CSV partial
  construction, early publication and unpublished task reclamation controls.
  The allocator probe creates collector-only garbage in the collector frame;
  current-runtime O1/O2 positive/negative controls pass locally and on both
  Windows hosts. No runtime root range was weakened.
- Local checks are serial through `python3 scripts/local-guard.py`: focused
  clippy, current-runtime C syntax, formatting, workflow lint, inventory and
  roadmap/link/commit audits pass. Standalone `tests/stdlib_doc.rs` compilation
  and `env -u FWP_BLESS /private/tmp/fwp-stdlib-doc-current --exact stdlib_doc_is_current`
  pass (0.64s/0.52s). Compiling the current formatter modules and formatting
  `lib/autodiff.fwp`/`tests/run/ad_task_reuse.fwp` pass (1.15s/1.13s), with unchanged
  syntax trees. Full builds/tests/measurements remain on CI.
- Intel GC finished in 66 minutes; its regular shard is still running. The
  tentative move of REST/examples to the regular shard is reverted because
  current timings show it would lengthen Intel's slower job. The established
  partition, timeouts and complete stress coverage remain unchanged. Guarded
  partition coverage/failure tests pass; all integration targets are retained.
- Earlier development evidence and wide-record reductions remain in
  [history](roadmap-history.md#pr-135-development-evidence) and
  [the measurement artifact](measurements/wide-records-2026-10-14.json).

- Linux's WASM CLI failure came from widening a 32-bit closure address into a
  static 64-bit value initializer. Executable descriptors now keep a typed
  `fwp_clo` pointer and convert it only when invoking the existing borrowed call.
  Guarded clang wasm32 syntax accepts the corrected shape and rejects the old
  initializer (0.15s); focused clippy (17.17s), current-runtime C syntax (0.39s)
  and formatting pass. The focused WASM workflow now runs CLI/browser semantics
  and native executable ownership too. Run 38564481965@a85e0ab2 was cancelled
  while still queued because it lacks this repair; it is not a gate.

## Next action

Next: publish the WASM descriptor repair, restore PR #136 readiness and run
focused WASM checks alongside the final production matrix. Collect remaining
09db8f25 diagnostics
and fix every failure. Require all seven Linux/macOS production jobs, both native
Windows acceptance jobs and docs on the final head before squash merge. Use an
explicit one-line subject of at most 80 characters and an empty body.

The six-step implementation scope is complete when PR #136 passes those gates
and is merged. At a session restart, check its actual merge and final-head CI
state first. If both are complete, close out this bundle; do not start another
implementation PR from the historical preparation queue or invent new scope.

Use `python3 scripts/local-guard.py COMMAND...` for serial focused local work.
Preserve 64 GiB free disk, target below 2 GiB, aggregate sampled RSS below 1 GiB,
and the 180-second limit. Do not use the stale local compiler as an oracle or
raise limits. Cancelled, skipped and superseded runs are not passing gates.
