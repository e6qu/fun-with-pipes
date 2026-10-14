# Session handoff

Updated 2026-10-14. The six-step implementation is present at
`01c686d19f3288a2e02bc471649c29f1ad5d9130` on branch `roadmap-after-135`.
[PR #136](https://github.com/e6qu/fun-with-pipes/pull/136) contains the complete
follow-up to the user-merged PR #135. Publication, fixes and squash merge after
passing final-head CI remain authorized; do not ask for that permission again.

## Roadmap status

| Step | Status | Delivered scope |
|---|---|---|
| 1 | Implemented | Streamlined docs, immutable history and one completion rule for later sessions |
| 2 | Implemented | Typed retained-task, scoped foreign callback/string and CLI/executable ownership; failure, cancellation, alias and reclamation controls |
| 3 | Implemented | Direct array producer fusion, numeric self-tail loops and wide scalar/record workers; equivalent-workload allocation and native-instruction evidence |
| 4 | Implemented | Nested reverse AD, stable task identities, partial-retain cleanup, bounded tape/workspace lifetimes and measured checkpoint tradeoffs |
| 5 | Implemented | Actual F16/BF16/F128 arithmetic, decimal text, arrays, C ABI and protocol v2; exact-bit, rounding and ownership controls |
| 6 | Implemented | Native Windows ARM64/AMD64 runtime, TLS, static-memory pools, goldens, ownership stress and standalone PE packages |

The implementation is complete. PR #136's final delivery remains subject to
all required checks on its latest head. Documentation and shard adjustments do not waive that gate.

## Verification

- [Production 38568712872](https://github.com/e6qu/fun-with-pipes/actions/runs/38568712872)
  at `01c686d1` passes eight jobs: Linux ARM64/AMD64, regular ARM/Intel macOS,
  GC stress ARM macOS, native Windows ARM64/AMD64 and C/Rust benchmarks.
  Intel GC reached its 90-minute limit during `wide_workers`, after its complete
  stress golden suite and REST passed, without a failed assertion. REST took
  427 seconds; an earlier Intel run took 144 seconds for wide workers. Those
  targets now run in the regular shard, preserving every target exactly once
  and the separate full GC stress suite. Time and resource limits are unchanged.
  This timed-out run does not satisfy the merge gate.
  Native package checks execute copied compilers/generated binaries outside the
  checkout and inspect ELF/Mach-O/PE architecture and dependencies.
- [Documentation 38568712866](https://github.com/e6qu/fun-with-pipes/actions/runs/38568712866)
  passes at the same head. The final closeout changes documentation, its
  status-heading audit and test partition; compiler/runtime sources are unchanged.
- [Focused WASM 38566937737](https://github.com/e6qu/fun-with-pipes/actions/runs/38566937737)
  passes both Linux hosts at `cce2a70f`, whose compiler/runtime code equals
  `01c686d1`. It covers actual CLI/browser execution, exact arithmetic, physical
  reclamation and native executable ownership. The full production run also
  exercises the existing WASM and Asyncify gates.
- [Focused AD 38560981174](https://github.com/e6qu/fun-with-pipes/actions/runs/38560981174)
  passes all four Linux/macOS hosts at `b4d072bb`: nested derivatives, task reuse,
  partial-retain failures, omitted releases, cancellation, library unload,
  numeric tape bounds and checkpoint measurements.
- The code fixes all failures from the earlier production run: library formatting,
  Windows TLS peer diagnostics, collector-only probe roots, cancellation stack
  bounds/CRLF, scheduler allocation baselines, stale injection markers and the
  WASM CLI static initializer. Typed closure pointers avoid widening a 32-bit
  address into a static 64-bit value initializer. No semantic expectation or
  runtime root range was weakened.
- Local work remains guarded and focused: formatting, clippy, current-runtime C
  syntax, wasm32 initializer positive/negative controls, generated stdlib docs,
  workflow lint and roadmap/link/commit audits pass. Commit metadata checks
  enforce one-line subjects of at most 80 characters, without trailers.
  Final closeout checks through `python3 scripts/local-guard.py` pass:
  `python3 scripts/test-macos-test-shards.py` (3 tests, 0.17s),
  `python3 scripts/check-roadmap.py` (48 link sets, 106 anchors, 6 steps, 2.57s),
  and a Cargo metadata partition audit (194 targets exactly once, 99 regular/
  95 GC, 0.14s). The first sandboxed guard attempt could not inspect `ps`;
  rerunning with process-monitoring access passed without changing any limit.
  Full builds, suites and measurements run on GitHub.

[History](roadmap-history.md#pr-136-implementation-verification) records the
implementation evidence and permanent measurement artifacts. Final merge
status and exact-head checks are linked from PR #136.

## Boundaries

- Checked native ARC rejects unproved cycles, mutable/retained graphs and
  State/AD lifetimes. Service/remote/library/WASM executable ARC admission is
  outside this bundle; this does not remove their supported tracing behavior.
- Generic wide values and some lazy producers still allocate. Closed wide
  workers/records and natural-width arrays provide the measured improvements.
  No universal C/Rust performance or allocation-free claim follows.
- Checkpointing is explicit recomputation for memory savings. In the recorded
  4096-step VJP, interval 32 cuts peak tape bytes 262,248 → 2,152 while increasing
  managed peak 336 → 12,816 and elapsed time. Separate peaks need not coincide.
  All measured storage is reclaimed without collection.
- Windows static storage excludes DLL/OS resource allocations. Native compilation
  requires a C toolchain and TLS requires OpenSSL 3. One binary per OS/architecture
  meets the packaging objective; arbitrary cross-compilation is not implied.

## Next action

Next: inspect PR #136's current head, checks and merge state. If it is open,
finish all nine exact-head production jobs plus documentation, fix any failure,
then squash merge with an explicit one-line subject of at most 80 characters and
an empty body. If it is merged with passing gates, the roadmap is complete:
there are no implementation tasks to resume. Do not replay historical preparation
entries or create another roadmap PR without a new user instruction.

Keep all closeout work in this PR. Every commit is one line, at most 80 characters,
without trailers or attribution. Use `python3 scripts/local-guard.py COMMAND...`
for local checks; preserve 64 GiB free disk, target below 2 GiB, sampled aggregate
RSS below 1 GiB and the 180-second deadline. Never use stale local compiler
binaries as an oracle or raise limits. Skipped, cancelled and superseded runs do
not satisfy the final merge gate.
