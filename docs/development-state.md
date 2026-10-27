# Current work

**Next:** monitor PR #220's final production/documentation/analysis gates and
isolated timing. Keep the final head unchanged while passing gates run. Audit
all completed targets; batch every necessary repair before rerunning affected
checks. Squash-merge only after all gates pass, then continue A6. The primary
checkout pointer records run IDs after dispatch.

Work in `/private/tmp/fwp-sort-key-fields`, branch `borrow-sort-key-fields`, PR
[#220](https://github.com/e6qu/fun-with-pipes/pull/220). PR #219 is merged; rebasing
onto its squash preserved the measured tree. Compiler/runtime source remains
`dfd844c1`, retained by `evidence/inline-sort-key-probe-dfd844c1`.

Focused correctness `40512388783` and saved-artifact audit `40512399031` passed.
All completed target logs and 62 probe statuses per host were audited, including
12 inline-key and six scalar/fault outputs. The fixture's missing signatures and
formatting are fixed. The initial short timing run `40513939015` rejected AMD64's
256-key identical-code control (12.7% deviation); ARM64 passed both sizes. Longer
run `40514452443` uses eight times more work, retaining the 10% noise limit. It passed both hosts at protocol source `4bc72c60`. Independent repeat
`40516778004` at final `06e3a923` also passed both hosts. Both artifact sets were
independently inspected; the repeated report is retained in this next worktree.
Final docs `40516754393` and G2 `40516769076` pass. Production `40516763516`
is still running, with no reported failures; its benchmark job passes.
Do not repeat passing compiler/count measurements without a relevant code change.

## Combined A3/A4 work

- Scalar record reads no longer acquire temporary owners for unused fields.
  Known `sort-by` callbacks use existing specialization, removing a duplicated
  input pair. Shared/String-result and interruption controls preserve required
  owners. [A3 measurements](measurements/sort-key-ownership.md) verified 2D fewer
  retain/release pairs for D distinct words, unchanged memory and smaller code.
- A4 now stores selected `(I64, String)` keys together and calls the existing
  field-based worker on `(String, I64)` inputs. The saved String remains owned;
  partial cleanup and stable comparison use explicit initialized-prefix storage.
  [The declared budget](measurements/inline-sort-keys.md) requires D fewer boxes
  and D additional retain/release pairs without peak-storage growth.
- New probes exercise empty/singleton inputs, equal-key stability, integer limits,
  every scratch/output allocation failure, callback-entry interruption and
  deliberately omitted String release or buffer freeing. Source programs cover
  newly allocated key text, partial key failure and cancellation. All probes passed
  at e19eed00 after fixing the fixture signatures and formatting.
- Docs remove stale GC-removal status, shorten completed roadmap work and now
  record verified A5.

## Existing evidence

A3 prototype `00957a15` passed both Linux hosts in `40499978041`. Combined source
`a44ed18ee72301fd9363ef934596064b55eb751f` passed correctness checks in
`40501234007`; its original budget incorrectly expected fewer successful last-owner
queries, although the removed queries returned false. Reader repair `2baf3ec0`
requires the exact attempt reductions and unchanged successful queries.
Artifact-only audit `40503213568` passed without rerunning unchanged programs.
The full report and immutable source tag are linked from the A3 report.

All completed target logs and six scalar/fault artifacts per host were audited.
The A4 report in `measurements/inline-sort-keys-2026-10-27.json` passes its
declared budget; it does not replace or discard A3 observations. Sorting timing and the final
production/analysis gates remain required before A4 acceptance.

Local checks used `scripts/local-guard.py`: Rust formatting, workflow lint,
twelve ownership-reader controls, four timing-reader controls and documentation
links passed. The timing reader independently verified both initial artifacts,
including exact binary hashes, every pair and the rejected control. No compiler
build, full suite or benchmark ran locally. Keep the fixed limits. Free disk was
about 73 GiB; check it before another workload or large artifact download.

## Verified deliveries

#219 merged as `413a10ebe1b2b08375383bebae8272129043d94a`, tree
`5653457a60d29370c82bad2367f17816860ddba0`, identical to tested `aab8fe71`.
All nine production jobs `40498383568`, docs `40498379836` and both analysis hosts
`40498382182` passed. Complete logs were audited: 256 passing target summaries
per Linux host, 126 per macOS ownership host and 201 per Windows host. The squash
message is one 56-character line without body/trailers. Duplicate postmerge CI
`40511055857` was cancelled after tree verification. A5 is complete for the
restricted local-array shape, not all arrays or containers.

[Delivery history](roadmap-history.md) records #218's callback/count attribution
and #217's verified GC removal. ARC minimization and roadmap steps 2–8 remain open.
Continue A3/A4, then A6's scoped parser workspace, preserving G2 analysis budgets.

## Recovery

Primary checkout remains detached at #209 with a worktree pointer and an untracked
`docs/measurements/compiler-abort.md`; preserve both. The original intermittent
Intel compiler abort remains unexplained. Preserve evidence and investigate its
source/input on recurrence. No detached merger is running; active timed checks
monitor CI. Squash merge only after all exact-head gates pass, with one line
<=80 characters and an empty body; verify the message and tree afterward.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve GC-free lifetime and binary checks |
| 2 | In progress | Finish A3/A4 and A6; A1/A2/A5 are verified |
| 3 | In progress | F1–F3 functional calls and recursion |
| 4 | In progress | P1–P3 measured CPU budgets |
| 5 | In progress | D1–D3 derivatives and time/storage budgets |
| 6 | In progress | N1–N2 numerical accuracy and kernel budgets |
| 7 | In progress | B1–B2 repeated baselines and enforced budgets |
| 8 | In progress | V1–V2 application correctness and scaling |

## A6 preparation in the next worktree

`/private/tmp/fwp-parser-workspace`, branch `scoped-parser-workspace`, is based on
PR #220's frozen head. No next PR is open. [The workspace contract](parser-workspace.md)
spells out admission, internal links, exceptional cleanup and C/Rust comparisons.
The fixture covers parsing errors, nested success/failure, cancellation after tree
construction and an escaping tree. Raw interpretation passes. Arithmetic overflow
is a trap (exit 101), so the new integration target tests it in separate processes.
The target is assigned to native macOS/Windows jobs; all 20 runner/coverage controls
pass under the guard. Rust tests have been written but not built/run yet.

`src/cgen/regions.rs` is an unconnected admission-proof draft with seven unit controls.
`runtime/fwp_rt_region.c` is an unconnected block-owner draft. A focused probe
using the unchanged verified #219 runtime passed Clang O1/O2 on macOS ARM64: empty,
1/257/8,193-node chains, nested ownership, repeated physical-baseline restoration
and every block-allocation failure. The omitted-free O2 control exits 248 as
intended. Commands used the local guard, std=gnu11 and ffp-contract=off. This is
prototype runtime evidence, not GCC/platform or compiler-integration verification.
The maintained test builds the current compiler and embeds the actual runtime
fragment; it has no dependency on an older fwp binary. Neither draft participates
in generated programs yet; neither establishes region support. Finish explicit
internal link typing, helper specialization and owner cleanup together before the
consolidated CI build. The selected design must preserve mixed records' ordinary
String/list owners and reject unknown node boundaries. Do not publish a proof-only
optimization or claim that zero live bytes proves absence of count operations.

Formatting/raw interpretation, native-runner controls, doc links and the focused
C block-owner probes ran locally. The three integration tests are not yet built. No fwp compiler build, full suite or benchmark ran. Free disk: 74 GiB.
