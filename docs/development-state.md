# Current work

**Next:** verify the delivery PR from `ownership-diagnostics`. Require all nine
production jobs plus documentation on its exact final head,
fix every failure, then squash with `Check native ownership without retaining freed storage`,
empty body and no trailers. Worktree: `/private/tmp/fwp-ownership-diagnostics`.

## This group

[The diagnostic guide](ownership-diagnostics.md) explains the test-only live-address
table, which detects duplicate/invalid frees, stale count operations, invalid shared
reuse and allocations left at cleanup. It runs alongside existing byte-balance
checks, including a control that records a free but omits physical reclamation.
The table removes freed entries and retains no objects or dead-address history.
It does not detect arbitrary raw reads or distinguish a stale pointer after its
address has been allocated again. Do not call it a complete borrow checker.

The helper now covers the native ARC golden corpus and execution tests, plus
O1/O2 dynamic/static probes. Eight and 1,024 rounds exercise allocation paths,
collision deletion and capacity bounds. Existing tracing stress and poisoning
coverage remains. The workflow records every collector-setting mention with source
revision, file hash and line text; this is an inventory, not replacement coverage.
An incidental native WASI allocator-probe filename now explicitly ends in `.exe`.

## Baseline and checks

PR #213 passed all nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/40177475991)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/40177475958)
at `0ac1f6f714a1a9a5f62d3d4b14a8db806358d140`. The guarded merge produced
`11a0f5ac3baea83609577c00d9a9dd7a67f627a3`, with the same tree and verified
one-line subject. The old merge watcher finished; do not restart it. Duplicate
postmerge production `40184730062` was cancelled; documentation `40184730066` passed.

Focused local work uses `python3 scripts/local-guard.py`:

- Downloaded and verified #213's macOS ARM64 compiler against its package manifest,
  SHA-256 `faf994ee0067f5249da86877a7f450efe7cedcfdd433084ebee046319fff47fa`.
  Package: `/private/tmp/fwp-compiler-213/fwp-macos-arm64/fwp`.
- Extracted the two changed Rust test functions, preserving their bodies and using
  a local temporary-directory/C-compiler shim with production C flags. Built at
  Rust O1 with debug/overflow checks. The full existing ARC execution test passed
  at native O0/O1/O2, including aliases, failures, scheduler cleanup and the updated
  missing-release controls. This does not compile the full Cargo target.
- The new dynamic/static ledger probe passed at O1/O2, including all fault controls.
  Wraparound and artifact-capture checks also pass; evidence is retained under
  `/private/tmp/fwp-ownership-ledger-local/record-ownership/ownership-ledger`.
- Formatting, whitespace and workflow lint pass. Documentation audit passes:
  158 link sets, 106 immutable preparation records and eight roadmap steps.
- Collector-setting inventory: 283 tracked files and 2,756 matching lines. File
  hashes/line contexts and wrong-revision rejection pass. Local report:
  `/private/tmp/fwp-ownership-ledger-local/memory-diagnostics.json` (dirty checkout
  recorded explicitly). CI regenerates it for the exact committed revision.

No full local build, golden corpus or benchmark was run. Integrated CI must compile
actual Rust targets and execute the entire instrumented ARC corpus on all six hosts;
local Clang checks do not verify GCC or Windows.

## Remaining decisions and preserved work

The earlier cycle-policy question remains unanswered: retain current ARC restrictions
with scopes/IDs when deleting tracing, or first add an explicit cycle-breaking API.
Do not infer an answer from silence. This does not block independent G4 work.
Next after integration: finish the reuse/borrow fault matrix, then the separate
WASI/external-resource mapping in [the diagnostic guide](ownership-diagnostics.md).

The original intermittent Intel macOS compiler abort remains unexplained. Preserve
[its evidence](measurements/compiler-abort.md); previous repairs and passing reruns
are not an established cure. Investigate source lifetimes on recurrence, without
allocator-cookie/disassembly-led experiments.

The primary checkout remains detached at #209 with an operational handoff and an
untracked abort report. Preserve both. Old delivery worktrees and their measurements
are evidence; do not repeat completed preparation. The initial G4 textual inventory
and notes under `/private/tmp/fwp-g4-*` predate this branch's new ledger.

## Roadmap status

Concrete unfinished tasks and acceptance criteria live in [PLAN.md](../PLAN.md).

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | G2–G3: settle remaining graph policy; G4 complete diagnostic replacements; G5 delete tracing |
| 2 | In progress | A2–A5: account for residual counts, remove redundant ownership work/boxes, prove count-free unique storage |
| 3 | In progress | F1–F3: cost fixtures, proved tail-frame extensions and mutual-recursion decision |
| 4 | In progress | P1–P3: checked comparisons and per-workload CPU budgets |
| 5 | In progress | D1–D3: AD recording/workspace costs and precision/nesting checks |
| 6 | In progress | N1–N2: accuracy and performance budgets for selected CPU kernels |
| 7 | In progress | B1–B2: repeated baselines and enforced evidence/budget rules |
| 8 | In progress | V1–V2: execute the finite application acceptance matrix |
