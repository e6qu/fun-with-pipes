# Current work

**Next:** publish the combined repair, then monitor all nine production jobs plus
documentation for the repaired commit. Audit full/target logs, fix every further
finding, and squash merge only after all exact-head gates pass. Record the new
source/run IDs here after publication; do not repeat unchanged measurements.

[PR #259](https://github.com/e6qu/fun-with-pipes/pull/259) is ready for review.
Branch `gradient-call-storage`, worktree `.worktrees/owned-numeric-updates`.
Other worktrees are unrelated.

## First production pass: fully audited, repaired

Source `4160061cd0d421a55ab4e467c6ec5fb6fd88cbf6`, production `41971248924`,
docs `41971245959` (job `127059774586`). All nine production jobs failed;
docs passed. [Complete reconciliation](measurements/gradient-call-checks-2026-11-05/production-repair/summary.json)
accounts for every failed step and every target. No unexplained diagnostic remains.
Draft run `41971246083` skipped and is not a production gate.

- All four Linux/macOS lint jobs found `field_reassign_with_default` in the
  `fold_fields.rs` unit fixture. Initialize `Program` directly. Compiler code
  outside the test module is unchanged. Focused lint now includes all targets.
- Format `lib/autodiff.fwp` and update the exact reference-patch marker. This
  fixes formatter targets on both Linux/macOS hosts, the Linux browser formatter
  check, and ownership/Windows/benchmark preflights. Focused formatting now
  checks lib/examples/tutorials/bench as well as the new fixtures.
- Benchmark execution never started; its absent-artifact failure follows from
  formatting. Preserve that original failure rather than claiming benchmark
  verification. All remaining executed checks pass.
- Each Linux host: 257 target logs, only formatter/browser targets fail.
  Each regular macOS host: 131 logs, only formatter fails. Each macOS ownership
  host: all 126 targets pass. Each Windows host: 57 early logs and all 155 native
  probe targets pass, along with golden programs and packaging.

[Repair evidence](measurements/gradient-call-checks-2026-11-05/README.md#first-production-run-lint-and-formatting-repairs)
retains complete logs, target archives, summaries and artifact identities.
Independent final reconciliation passes (0.14s). Windows artifact audits fit the
local guard: ARM64 127.05s, AMD64 142.02s. These are log/image-record audits, not
local builds or repeated native tests.

The repair changes a unit fixture, library formatting, its reference marker,
focused workflow coverage and docs. It does not change the optimization or
runtime behavior; measurements retain their original sources.

## Collect the repaired head

`../gradient-work/collect-gradient-call-final-platforms.py` takes explicit
`--run`, `--source`, `--host`, `--docs-job` and `--output` arguments. Use the new
head/run IDs after publication, one host per guarded invocation. Hosts:
`linux-arm`, `linux-amd`, `mac-arm`, `mac-amd`, `mac-arm-ownership`,
`mac-amd-ownership`, `windows-arm`, `windows-amd`, `bench`, `docs`.

The collector retains full logs, digest-checked target archives, Windows probe
logs and per-host audits. It deliberately exits nonzero on failed heads;
inspect every finding. Individual job logs are available through
`gh api .../actions/jobs/ID/logs` before the whole run finishes.

First-pass scratch: `../gradient-work/gradient-call-final-first/`. All results
are now retained in the repository; Windows outer probe downloads were removed
after verification/retention. Do not re-fetch them to redo completed audits.

## Roadmap status

[PLAN.md](../PLAN.md) and this table track the same five steps.

| Step | Status | Work |
|---|---|---|
| 1 | Implemented | Borrow scoped gradient inputs; focused lifetime controls and allocation counts pass. |
| 2 | Implemented | Pass fold fields directly; seed/order/precision controls and counts pass. |
| 3 | Implemented | Seed backward directly; scalar/owned-weight and failure controls pass. |
| 4 | Implemented | Consume derivative scratch; alias/view, both positions and unwind controls pass. |
| 5 | In progress | Pass repaired production gates and full audits, then squash merge. |

## Verified measurements

| Evidence | Source and result |
|---|---|
| [Frozen contract](measurements/gradient-call-storage.md) | `1ed3ad99`, tag `roadmap/gradient-call-storage-protocol-2026-11-05`; frozen before implementation. |
| [Focused native checks](measurements/gradient-call-checks-2026-11-05/README.md#passing-focused-matrix) | `8c0e4b0e`, run `41962981349`, docs `41962933179`: three hosts pass 292 units and 124 native tests in 25 targets; 798 images and 814 probe statuses audited per host. Four units are explicit runner-only measurements; no native test ignored. |
| [Allocation census](measurements/gradient-call-census-2026-11-05/README.md) | Original run `41964853201`, source `8c0e4b0e`, failed phase-byte attribution. Scratch reserves N+1 words. Correct phase savings: `(8N+8)U` outside, `120U+24` during recording; unchanged total `(8N+128)U+24`. Original failures retained; corrected report-only audit `41967470333` and docs `41967470162` pass. |
| [Compiler costs](measurements/gradient-call-analysis-2026-11-05/README.md) | `d494dd91`, run `41967900961`: 336 commands and six controls per host; all limits pass. |
| [Runtime and memory](measurements/gradient-call-time-2026-11-05/README.md) | `d494dd91`, measurement run `41967904120`, independent audit `41970153152`: all 5,336 raw records checked; 17 timing misses remain open. No unchanged timing rerun. |

Full measured source: `d494dd910723303f99992610895d9784968c79e8`, tag
`roadmap/gradient-call-timing-2026-11-05`. It changed only measurement checks/docs
relative to `8c0e4b0ef06aa9f528eeaedbfbab9461a82dd0d7`, tag
`roadmap/gradient-call-storage-measurements-2026-11-05`.
`../gradient-call-recorded-checker` is a clean sparse checkout of the latter,
including scripts/src/runtime/lib/tests/docs/tutorials. Reproduce old census
checks from the frozen timing tag: later library formatting changes its marker.

Fresh 129-coordinate/199-update solve: 2,121 → 727 requests and
1,265,230 → 1,034,366 requested bytes; 398 fewer retains. Three-coordinate long
solves improve 14.3–25.2%. All sixteen 33/199 and 129/199 timings miss 5%; AMD64
session 2 3/0 current is 2.1822% slower, beyond 2%. All 48 memory comparisons
match the census; final managed/raw bytes are zero. Process RSS is mixed.
Keep these misses and all older goals separate under the accepted policy.

## Local checks and resources

Full builds/tests/measurements stay on runners. Bounded repair checks pass:
Rust formatting, actionlint and test-only source comparison (6.93s); three
reference controls and workflow/diff checks (6.47s); repository language format
(0.51s); docs links (285 sets, 106 anchors, five steps; 2.53s). An incorrectly
named new evidence receipt was fixed before the passing link check. The final
handoff shortening also omitted the required five-row status table; restored it
before publication, preserving the plan/handoff consistency check.

The formatter is the verified PR #258 macOS ARM64 package, artifact `13376149858`;
parser/formatter/AST/main sources match. Its binary hash and use are in the
[receipt](measurements/gradient-call-checks-2026-11-05/production-repair/formatter-use.json).
No local compiler build was needed. Existing inventory (397), native assignment
(255), library docs, budget controls and evidence reconstruction checks pass;
individual commands/results are retained in the linked evidence.

The guard stopped collection below 64 GiB. Removed only digest-verified duplicate
downloads after checking preserved evidence records: 516.57 MiB, then 255.62 MiB
(0.37s). After auditing Windows ARM64, removed its verified 382.70 MiB
probe download (all logs/receipts preserved), then 372.50 MiB of verified prior
focused downloads (0.38s). Removed the verified 388.10 MiB AMD64 probe download
after retention too (0.26s), leaving 65.696 GiB free. No limits raised. Keep the
64 GiB reserve, generated target below 2 GiB, sampled RSS below 1 GiB and 180s
local deadline. Original sources/images remain in identified GitHub artifacts;
repository archives retain observations, logs and file hashes.

## After verified delivery

Squash merge with an explicit one-line subject of at most 80 characters and empty
body, then verify commit message and tree. Continue the roadmap in the next PR.
PR #258 already merged at `68115090b161f198e11fb625946259f65f781580`, tree equal
to tested `35745c0b`; [receipts](measurements/owned-numeric-checks-2026-11-05/platforms/final-gates.json)
confirm all gates. Its four AMD64 timing misses remain separate.

Source investigation notes: `../gradient-work/gradient-call-next-source-notes.md`;
next proof draft: `../gradient-work/packed-pair-reuse-draft.md`. Neither is frozen
acceptance or implemented support. They map the remaining two forward buffers
(`32NU` bytes) to indexed-record producer → neighboring-pair map → fold. Reusing
the first buffer requires consuming ownership, equal-width plain fields and
complete callback-stage order, including failure/cancellation cleanup.

`../gradient-work/gradient-call-zero-sample-review.json` reviews the two complete
balanced cycles of existing zero-update samples (0.26s). Their differing ratios
establish no cause and do not relax the failed limit. Review that source/driver
path separately; positive-update storage savings cannot explain it. Freeze any
new experiment before implementation or measurements.
