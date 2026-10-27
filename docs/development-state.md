# Current work

**Next:** run the combined parser correctness/measurement batch on native Linux
ARM64 and AMD64, audit every job and retained artifact, and fix all failures.
Only then publish the measurements and run the full final-head production/G2 gate.

[Draft PR #221](https://github.com/e6qu/fun-with-pipes/pull/221) uses
`/private/tmp/fwp-parser-workspace`, branch `scoped-parser-workspace`, based on
verified squash `56d5aac63a9963ae6b16574f10d6dc3087a08d8a` (#220).
[The workspace contract](parser-workspace.md) specifies admission and cleanup;
[the measurement protocol](measurements/parser-workspace.md) defines the exact
fwp/C/Rust comparison. A6 is not verified support yet.

## A6 implementation and checks

- Explicit internal link types distinguish invocation-owned nodes from ordinary
  owners. Only recursive integer/link variants qualify. Escaping/cached graphs,
  unknown/captured calls, runtime boundaries and self-tail roots keep ordinary
  ownership. Helpers receive explicit storage context; pure readers do not.
- A public recursive call starts a fresh owner. Helpers within one parse share
  that parse's blocks. Mixed records preserve String/token owners. Cleanup runs
  on normal return, failure and task cancellation.
- Focused run `40578305643` at `de6e0be935d77cad51e08cd3eeaa8241d61d75bd`
  passed on both native Linux hosts: 209 unit tests, six allocator tests, five
  parser tests, two record tests, Clippy and actual WASI O1/O2 controls.
  All logs and 22 retained probes per host were independently audited for
  complete outputs, statuses, zero final live storage and binary architecture.
  Documentation run `40578309634` passed. Draft production jobs were skipped;
  they do not establish final platform support.
- That batch fixed the Ubuntu AMD64 WASI mismatch: unversioned Clang had advanced
  to 21 while libraries remained LLVM 18. All affected workflows now use one
  checked setup script pinning Clang, linker and WASI libraries to LLVM 18.
  It also verified five distinct live owners in the recursive parser example.
- The next batch avoids copying the whole program when there is no eligible
  region candidate. It checks completed clone weight, including new context
  arguments, against the growth budget before publication; the earlier estimate
  did not precisely bound rewritten size. Added growth controls cover 1/16/32/64
  roots, with separate pass measurements on runners.
- A sixth parser test observes cancellation only after five nodes and one block
  exist, then requires that cancelled cleanup releases them. Omitting that cleanup
  must fail both the live-block and allocation-report observations.
- New measurement tools compare the previous fwp program, the candidate and
  explicit C/Rust indexed arenas. Four fixed tree shapes, 1/16/256 repetitions,
  independently frozen timing budgets, compiler scale, actual binary hashes,
  stack files and precise allocation ledgers run in two independent sessions
  on each Linux architecture. Results are pending, not a claimed speedup.
- Eight evidence controls pass locally under the guard. Small Clang O2/Rust O2
  harness checks passed values, balanced/left-nested shapes, cleanup, malformed
  input and overflow. The generated-C harness used retained `de6e0be9` C; this
  checks instrumentation only, not the pending compiler changes or GCC.

## Checks and the incidental repair

Postmerge docs `40552108553` failed three local-guard tests before their intended
sampler checks: the real runner had less than 64 GiB free. The test harness now
controls disk readings only inside its copied guard subprocess. It adds exact
64 GiB acceptance, preflight refusal and refusal during sampling. All nine tests
pass locally under the real guard. `scripts/local-guard.py` and its limits are
unchanged. The complete failed job log was audited; these were its only failures.
The repaired draft documentation gates `40553700208` at `ab0fccf1` and
`40556027112` at `f16da74d` passed.

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
