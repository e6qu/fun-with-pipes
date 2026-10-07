# Session handoff

Updated: 2026-10-07. This file records current work, not permanent design.
Read [PLAN.md](../PLAN.md), [ownership.md](ownership.md) and [design.md](design.md)
for priorities and contracts. Update this file before ending a work session.

## Baseline and active work

- Baseline: `7a05b58`, PR #73, explicit interfaces and stateless MCP.
- Branch: `macos-portability`.
- Implementation/docs commit: `7ec02d0`.
- Published PR (ready for review): [#74](https://github.com/e6qu/fun-with-pipes/pull/74).
  The user explicitly authorized the push and PR creation on 2026-10-07;
  the earlier publication block is resolved. The implementation and workflow handoff are on GitHub.
- Continuing authorization: the user requested automatic completion of the
  active roadmap, one PR at a time, with full CI before each squash merge.
  Use an explicit single-line subject of at most 80 characters and an empty
  body; no trailers, AI attribution, Co-authored-by or Authored-by lines.
  Continue to the next roadmap task after merging. An active thread goal
  tracks the whole roadmap; the plan/handoff carry the state across sessions.
- User direction: macOS, ownership with minimal tracing GC, efficient native
  representations/numerics/autodiff, and stable simple pipe semantics.
- Current scope: the first native macOS portability pass plus durable docs.
  Runtime ownership contracts are the next focused implementation change.

## Implemented on this branch

- Mach-O symbol/directive handling for the custom x86-64/AArch64 task switch.
- Mach-O image/segment discovery for collector roots, including writable-at-load
  constant data; Darwin peak RSS converted from bytes to KiB.
- Actual OS page size for task guard pages.
- Lifetime fences for list construction/append/flatten buffers. Optimized
  Apple Clang exposed missing conservative roots when it preloaded short
  buffers; the stressed task and reverse-autodiff cases now pass.
- Distinct context-switch assembly symbols for each fat-binary variant.
- Native shared library naming/linking (`.dylib`, `-dynamiclib`), including the
  interpreter's FFI shim, and a clear rejection of native `--static` on macOS.
- `FWP_OPENSSL_DIR` for native headers/linking and interpreter loading; Darwin
  `RTLD_GLOBAL` corrected; the prefix participates in the native cache key.
- OpenCL framework lookup on macOS. Hardware kernel execution is unverified.
- Apple Silicon and Intel macOS CI jobs, with OpenSSL 3 and the full test gate.
- Darwin regressions for real collection, global roots, tasks/autodiff and libraries.
- Existing reuse/stack suites enabled on Darwin: portable allocation counters,
  immediate reclamation, and the full golden reuse/GC verification sweep.

## Validation

- Six focused escape-analysis unit tests passed locally.
- Concatenated ordinary runtime passed Apple Clang syntax checking.
- Four focused Darwin regressions passed locally on Apple Silicon, including
  GC stress/verification, global roots, tasks/reverse autodiff, wide records,
  shared-library defaults, static-link rejection and OpenSSL in both backends.
- All five FFI tests passed locally: interpreted/native foreign calls, a
  shared library from C, a static library from Rust and unsupported-type errors.
- Fat-binary test passed locally on Apple Silicon (baseline variant only;
  the Intel variants still need their macOS CI job).
- Darwin wide-record allocation and counted-reclamation regressions passed
  locally after enabling the portable suites (`cargo test --test stack
  wide_records_are_returned_without_allocating`, `cargo test --test reuse
  objects_are_freed_by_their_counts`). Each used the same resource guard.
- `cargo fmt --all -- --check` and `git diff --check` passed.
- CI run `37571212303` for `66eafb8`: Linux full tests (including WASM,
  cross builds and GC/reuse checks) and benchmark equivalence passed. Both
  macOS jobs passed fmt/clippy, then failed in the AOT server tests because
  HTTP/2 listener creation used Linux-only `SOCK_CLOEXEC` without a fallback.
  Fixed with `fcntl(FD_CLOEXEC)` where the socket flag is unavailable; failed
  descriptor setup closes the socket and preserves the error.
  Both failing server regressions passed locally after the fix with
  `FWP_OPENSSL_DIR=/opt/homebrew/opt/openssl@3 python3
  /private/tmp/fwp-local-guard.py cargo test --test aot serve_`. An initial
  local invocation without the required OpenSSL prefix failed at header
  discovery; the configured rerun passed both tests.
  Full CI now uses `--no-fail-fast` to report all failing test targets in one
  run while preserving every assertion and the failing exit status.
  The latest revision needs a new full [CI gate](https://github.com/e6qu/fun-with-pipes/pull/74/checks).
  Do not describe either architecture as fully verified yet.
- Workflow correction: failing tests are implementation tasks; queued CI only
  prevents merging. Continue diagnostics, fixes and separate next-task
  preparation, with one open PR. Do not mark the roadmap blocked for normal
  failures or runner delays. The user reiterated this on 2026-10-07.
- Local resource guard for this session: `/private/tmp/fwp-local-guard.py`,
  the user's guard adapted only to this repository root, with the same limits.
  It is temporary; recreate it or use an equivalent bounded check next session.
  It needs process-sampling/priority permissions. Full gates belong on CI.
  Commands completed: `cargo test --lib escape::tests`,
  `cargo test --test macos` (with `FWP_OPENSSL_DIR` set), and
  `cargo test --test ffi`, `cargo test --test fat`, and the formatting
  check, each through the temporary guard. Target data was 80 MiB after
  these focused checks; no local full gate or benchmarks were run.

## Next actions

1. Inspect both macOS jobs and Linux CI on PR #74; fix failures without weakening tests
   or silently treating missing optional tools as coverage.
2. Check the newly enabled reuse/stack suites on both Darwin runners.
   Static-memory and external-process RSS suites still use Linux guards;
   `strace` and process-memory evidence need platform alternatives.
3. Record exact CI results and remaining platform limitations here.
4. Start the ownership-contract inventory described in `ownership.md`.

## Current CI fixes and prepared work

- Full run [37576889350](https://github.com/e6qu/fun-with-pipes/actions/runs/37576889350)
  on `ccecf20`: ARM macOS failed; Intel and Linux are still running; benchmark
  equivalence passed. The no-fail-fast sweep exposed tutorial `wc` padding,
  OpenSSL alert wording, GC-stressed list crashes and native server crashes.
- Reproduced native forms/format server failure locally: SIGSEGV in
  `fwp_list_items`, reached from `fwp_p_flat_map`. Preserving constructor
  source buffers, the list source and the flat-map buffer fixes the focused
  forms test and the stressed web test. The optimized traits program also
  changed from SIGSEGV to the expected output. A focused Darwin regression
  now covers `-O1`/`-O2`, GC stress/verification and both reuse-poison modes.
- Focused fixes checked locally: `cargo test --test rest forms_and_formats_native`,
  `cargo test --test web native_under_gc_stress`,
  `cargo test --test macos optimized_lists_under_collection` and
  `cargo test --test tls streams` and
  `FWP_TUTORIAL=19 cargo test --test examples tutorial_sessions`, all through the same resource guard with
  the installed OpenSSL prefix where needed. All passed.
- Make the tutorial's byte-count command strip BSD `wc` padding. Canonicalize
  only OpenSSL's alternate `ssl/tls alert bad certificate` label in the TLS
  snapshot harness; retain all other message and behavior assertions.
- Other full-suite failures (`stdlib_fixes`, HTTP, filesystem stress and
  the remaining REST cases) still require the new CI head. The filesystem
  golden mismatch followed a stress crash that left its scratch directory.
  Do not claim the full macOS gate passed based on focused checks.
- Prepared/published branch: `ownership-contracts`, checkout
  `/private/tmp/fwp-ownership-worktree`, head `798d2ed`, base `ccecf20`.
  No second PR is open. All 35 container contracts are centralized; comparison
  keys borrow. Tests cover aliases/callbacks, count saturation, interior
  references and traversal spill. Twelve focused checks passed. The key loop
  allocated 0.0 MiB versus the old boundary's 0.8 MiB, rounded to tenths.
- After #74 passes and merges, fetch main and rebase that checkout with
  `git rebase --onto origin/main ccecf20 ownership-contracts`, reconcile docs,
  push with lease, then open its PR. Run full CI before its squash merge.
- Further preparation: local branch `ownership-leaves`, checkout
  `/private/tmp/fwp-leaf-worktree`, base `798d2ed`. String/Bytes ownership,
  copy/alias result contracts and safe leaf destruction are being tested.
  Its two focused regressions passed with GC/reuse verification; the copy
  loop freed 0.9 MiB by counts versus 0.0 MiB with freeing disabled. Five FFI
  checks passed. Full ownership, exceptional cleanup and closures remain work.
  This branch has no PR; publish one PR at a time after its parent merges.

## Boundaries and deferred work

Darwin cross-target spellings and universal binaries are not implemented.
Use `--target native` on macOS. Clang PGO is not implemented; `--pgo` still
requires GCC. Static memory on Darwin has not yet been validated. Linux UDS/SHM
fast transports keep their existing portable pipe fallback elsewhere.
Windows, new interfaces and new compiler backends are deferred.

Do not claim tracing GC is gone: strings, escaping closures and runtime-shared
values still rely on it. WebAssembly and embedding-host reclamation remain
separate ownership tasks. Existing published benchmark numbers are historical
Linux measurements, not results from this branch or promises about macOS.
