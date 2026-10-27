# Current work

**Next:** validate A6's integrated compiler transformation in the focused
Linux ARM64/AMD64 runner suite, fix every failure, then complete WASI and the
C/Rust measurement evidence in the same draft PR before the full production gate.

[Draft PR #221](https://github.com/e6qu/fun-with-pipes/pull/221) uses
`/private/tmp/fwp-parser-workspace`, branch `scoped-parser-workspace`, based on
verified squash `56d5aac63a9963ae6b16574f10d6dc3087a08d8a` (#220).
[The workspace contract](parser-workspace.md) specifies admission, cleanup and
fixed inputs. The compiler changes are not verified support yet.

## A6 implementation state

- The admission proof caches type containment. It rejects owning fields in nodes,
  unknown/captured/escaping uses, cached graphs, constants with existing storage
  and self-tail roots. Ordinary helpers remain available to escaping callers.
- Lowering distinguishes internal links with `TypeShape::RegionLink`. A
  `RegionEntry` owns its blocks and calls a specialized worker. Allocation helpers
  receive the context explicitly; pure readers do not. Typed constructors use
  the block allocator. Mixed records retain their String/token-list owners.
- Analysis and cloning have program-size budgets. A reverse call graph propagates
  context requirements without repeatedly walking recursive helper bodies.
- Eleven unit controls and four integration tests cover admission, semantic
  agreement, overflow, nested calls, suspension/cancellation, escaped/cached trees,
  block alignment, physical cleanup and every block-allocation failure. The
  generated-parser probe rejects any count operation on a live internal link;
  deliberate extra-count and missing-free mutations must fail their observers.
- The Rust changes have not been built/run yet. The focused `parser-workspace`
  suite builds from Rust at production O1, runs unit/affected integration checks,
  Clippy and generated-C O1/O2 probes with GCC on both Linux architectures.
  Full CI remains deferred until this whole batch and its evidence are ready.

## Checks and the incidental repair

Postmerge docs `40552108553` failed three local-guard tests before their intended
sampler checks: the real runner had less than 64 GiB free. The test harness now
controls disk readings only inside its copied guard subprocess. It adds exact
64 GiB acceptance, preflight refusal and refusal during sampling. All nine tests
pass locally under the real guard. `scripts/local-guard.py` and its limits are
unchanged. The complete failed job log was audited; these were its only failures.
The repaired draft documentation gate `40553700208` passed at `ab0fccf1`.

Other focused local checks, all through `scripts/local-guard.py`:

- Raw parser-fixture interpretation and formatting pass with the verified #219
  executable; these frontend/runtime paths are unchanged. This is a temporary
  check, not a maintained build dependency. CI builds the compiler from Rust.
- All 20 native-runner/coverage controls pass; Rust formatting and doc links pass.
- The actual block-owner fragment passed Clang O1/O2 probes on macOS ARM64 using
  the unchanged verified runtime: empty, 1/257/8,193-node chains, nested ownership,
  repeated physical-baseline restoration and every block-allocation failure.
  Deliberately omitting block release exits 248 at O2. Flags: `-std=gnu11`,
  `-ffp-contract=off`, no LTO. This does not verify GCC or compiler integration.

No full compiler build, suite or benchmark ran locally. Free disk was 74 GiB.
Keep the fixed 64 GiB/2 GiB/1 GiB/180-second limits; move large work to runners.

## Verified deliveries

[PR #220](roadmap-history.md#temporary-record-owners-and-sort-keys-pr-220) completed
A3/A4. All nine production jobs `40516763516`, docs `40516754393`, both G2 hosts
`40516769076` and both timing hosts `40516778004` passed at final `06e3a923`.
The first longer timing `40514452443` also passed. Both timing artifact sets were
independently audited; [the report](measurements/inline-sort-keys.md) retains every
sample, sources, budgets and the initial rejected short control.

Squash `56d5aac6` has tested tree `1c824b804dddd30460bb11b2f5a9a40dd9fe16b4` and one
55-character message with no body/trailers. All logs were audited: 256 passing
target summaries per Linux host, 132 per regular macOS host, 126 per ownership
macOS host and 201 per Windows host. Duplicate postmerge CI `40552108647` was
cancelled after identical-tree verification. The postmerge docs failure above
is repaired and passed the draft documentation gate.

A1–A5 are verified for their stated shapes; A6 and roadmap steps 3–8 remain open.
[History](roadmap-history.md) owns older delivery IDs and evidence. Preserve G2's
analysis budgets and measure region selection separately.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle controls |
| 2 | In progress | A6: invocation-owned parser storage and measurements |
| 3 | Pending | Functional calls and recursion acceptance cases |
| 4 | Pending | Measured CPU performance gaps |
| 5 | Pending | Differentiation storage, timing and precision |
| 6 | Pending | CPU numerical kernels |
| 7 | In progress | Extend fixed measurement budgets beyond delivered cases |
| 8 | Pending | Complete the larger-program acceptance matrix |

## Recovery

The primary checkout remains detached at #209 with a worktree pointer and an
untracked compiler-abort report; preserve both. The original intermittent Intel
compiler abort remains unexplained. Investigate source/input on recurrence.
No detached merger runs. Publication and squash merge are authorized after all
required final-head gates pass; use one line <=80 characters, empty body, no
trailers/attribution, and verify the merged tree and message. Continue the plan.
