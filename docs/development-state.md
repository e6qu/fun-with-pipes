# Current work

**Next:** run the expanded structured-autodiff focused checks, implement the
frozen method comparison, and measure it before choosing a compiler/library
change. Keep all work and docs in one substantial PR; no PR is open yet.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | #270 delivered the broad docs refresh and fresh F64 stores; original AMD timing acceptance stays open. |
| 2 | In progress | #271 delivered captured maps and empty-owner transfer with all gates passing; combined noisy timing acceptance stays open. |
| 3 | In progress | Validate and measure neighboring, independent and dense objectives; select and verify a reusable improvement. |
| 4 | Pending | Swift/C/Rust ownership comparisons with separate time and memory boundaries. |
| 5 | Pending | Three application/tooling paths, compiler phase/scaling costs and demonstrated usability repairs. |

## Branch and verified base

Branch `structured-autodiff-comparison`, worktree `.worktrees/recording-capacity-gate`.
Base `b76306b20a1d7727917ef6184c9a8716967ceb89` is the verified squash merge of
[PR #271](https://github.com/e6qu/fun-with-pipes/pull/271). Its one-line message
has no body/trailers. Tested head `9584ae2e293529430af983b2030fc9cb43add01f` and
merge share tree `163d7093b878080d0b63592b24ab45442f6770a0`.
Preserve unrelated root-worktree changes.

All nine production jobs (`42482501918`), docs (`42482501764`, job
`128737287761`) and complete audit (`42490732997`, job `128762314926`) pass.
All ten job logs were reviewed without unexpected diagnostics. The audit archive
and receipts are [retained](measurements/captured-map-delivery-2026-11-08/README.md).
Original [measurement limits](measurements/captured-map-repaired-2026-11-08/README.md)
remain unchanged: both largest applications improve 84–94%, but copy noise leaves
combined timing acceptance open. Do not rerun unchanged cases to obtain a pass.

## Current batch

[The comparison contract](measurements/structured-autodiff.md) specifies 41
method/input combinations, complete-gradient boundaries, two sessions per native
architecture, exact settings and noise limits. It precedes measurement code.
No new public numerical API or compiler transformation is selected yet.

- Two fixtures define generic objectives and 30 exact gradient/boundary checks.
  They cover empty/singleton values, repeated tensor leaves, dense matrices,
  two neighboring formulas and unchanged caller values.
- Empty differentiated inputs need an explicit `List[F64]` type; the fixture now
  states it. This was an example inference error, not a compiler failure.
- The existing `autodiff_precision` target and focused local-derivative workflow
  include the new checks. Native Rust/GCC execution on the new source is pending.
- Current tensor nodes support elementwise AD, not complete shifted/dense AD.
  Combine every repeated-leaf contribution; unsupported combinations stay explicit.
- General `grad`, nested AD and F128 remain required. The local pair helper is
  still experimental; independent losses already use `array.map (derivative f)`.

## Local checks and resources

All local checks use `python3 scripts/local-guard.py`, serially. No full local build.
The exact-base macOS compiler came from artifact `13620145916`; archive and
binary hashes match the final-head manifest. It is a check tool, not a build
input or compatibility requirement. Path: `/tmp/fwp-pr271-compiler/fwp-macos-arm64/fwp`.

Type checking and raw interpretation pass. Thirty exact results pass at Clang
O1/O2 in 5.37 seconds (2.59 seconds CPU); fixture formatting passes. This does
not establish GCC behavior, a Rust-test build, storage bounds or performance.
Commands/outputs are in `/tmp/fwp-structured-ad-preparation/boundary-native-results.json`.
The earlier eight-example checks and analytic rational oracles also pass.

Free disk fluctuated from 75 to 49 GiB; the guard refused at 49. Checks resumed
only after recovery to 74 GiB. Preserve the 64 GiB reserve and all other limits;
move builds/benchmarks to runners. Full final-head matrix/docs/audit run after
this coherent batch is ready. Keep one active normal PR.
