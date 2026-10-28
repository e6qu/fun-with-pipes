# Current work

**Next:** run focused correctness and four measurement jobs for the smaller-block
policy and compiler-scale repair. Audit every job/artifact before publishing
measurements and starting the full final-head production/G2 gate.

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
- Focused run `40593718067` at `c9df8b8d7cf60eee55d0455973c3b2a7b3d6d1ae`
  passed on both native Linux hosts: 211 unit tests, six allocator tests, six
  parser tests, two record tests, Clippy and actual WASI O1/O2 controls.
  All logs and 26 retained probes per host were independently audited for
  complete outputs, statuses, live-storage baselines and binary architecture.
  Documentation `40593704633` passed. Draft production jobs were skipped;
  they do not establish final platform support.
- The cancellation observer requires five nodes and one block before cancellation,
  then verifies the cancelled cleanup. Its missing-free mutation exits 243 and
  retains storage; ordinary cleanup exits zero with zero final live bytes.
- Completed clone weight now includes new context arguments and must fit the
  growth budget before publication. Controls cover 1/16/32/64 roots. Programs
  without an eligible node/entry avoid a whole-program copy. Direct pass
  measurements passed on all four native measurement hosts.
- Measurement run `40593725874` failed identically in all four jobs before timing:
  the harness expected a generic-value entry, but the previous compiler emits an
  unboxed scalar worker and public entry bridge. All logs/artifacts were audited.
  The repaired adapter explicitly checks that bridge and still times the public
  entry. Local small-input checks passed against both actual retained C forms
  (#220 baseline and `c9df8b8d` candidate). No compiler change is needed.
  The repaired batch also runs C/Rust malformed-input, multiplication, signed
  minimum and overflow controls on the production toolchains.
- Earlier source/toolchain repairs passed `40578305643`: recursive public calls
  preserve five separate owners, and Linux WASI compiler/linker/libraries now
  share an explicitly checked LLVM 18 setup. Unversioned Clang 21 had caused the
  previous AMD64 link failure; all affected workflows use the shared repair.
- Run `40596927743` at `a55f0ee7` completed runtime measurements on all four
  hosts, then correctly failed audit because the scale command compiled empty
  `main` instead of the exported parser roots. All logs and retained artifacts
  were audited. Runtime samples, frozen budgets, values, cleanup and binaries
  passed; every whole-compilation row is invalid and must be replaced. The
  command now selects exports explicitly and both writer/auditor check all roots.
- Those runtime samples exposed wasted space in the fixed 4 KiB first block:
  the small tree used 616 node bytes but retained 4,096 payload bytes. The new
  policy starts at 256 bytes, doubles to a 4,096-byte cap, and uses exact storage
  for oversized nodes. Small-tree payload becomes 768 bytes. Actual heap peaks
  and timing still need the new runner batch; there is no C/Rust parity claim.
- The real allocator passes local Clang O1/O2 controls for every growth boundary,
  nested owners, oversized nodes, each allocation failure and deliberate omitted
  release. The instrumented parser and peers pass small-value/cleanup checks.
  Nine evidence controls include rejection of empty-main compiler observations.
- New measurement tools compare the previous fwp program, the candidate and
  explicit C/Rust indexed arenas. Four fixed tree shapes, 1/16/256 repetitions,
  independently frozen timing budgets, compiler scale, actual binary hashes,
  stack files and precise allocation ledgers run in two independent sessions
  on each Linux architecture. Results are pending, not a claimed speedup.
- Nine evidence controls pass locally under the guard. Small Clang O2/Rust O2
  harness checks passed values, balanced/left-nested shapes, cleanup, malformed
  input and overflow. The generated-C harness checks instrumentation; it does not replace GCC
  verification or the complete final-head platform matrix.

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
