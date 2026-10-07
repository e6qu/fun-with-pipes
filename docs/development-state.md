# Session handoff

Updated: 2026-10-07. This file records current work, not permanent design.
Read [PLAN.md](../PLAN.md), [ownership.md](ownership.md) and [design.md](design.md)
for priorities and contracts. Update this file before ending a work session.

## Baseline and active work

- Baseline: `7a05b58`, PR #73, explicit interfaces and stateless MCP.
- Branch: `macos-portability`.
- Implementation/docs commit: `7ec02d0`.
- Published draft PR: [#74](https://github.com/e6qu/fun-with-pipes/pull/74).
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
- Full Linux/macOS tests, clippy, GC/reuse verification and benchmark evidence:
  pending [GitHub CI](https://github.com/e6qu/fun-with-pipes/pull/74/checks).
  At publication, all four jobs were queued: Apple Silicon macOS, Intel
  macOS, Linux tests and Linux benchmarks. Check the latest PR head before
  recording a result; this handoff update triggers a new run.
  Do not describe either architecture as verified yet.
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
