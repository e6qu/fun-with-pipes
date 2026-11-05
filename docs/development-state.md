# Current work

**Next:** publish the completed PR #261 group, mark it ready, then monitor all nine
production jobs and docs on that exact final head. Fix every failure, audit every
completed log/artifact and squash merge only after all final gates pass. Use a
single-line subject of at most 80 characters and an empty body; verify the merge.

## Roadmap status

| Step | Status | Evidence still needed |
|---|---|---|
| 1 | Implemented | Bounded proof verified in focused tests; final production coverage remains. |
| 2 | Implemented | Exact scalar reads verified; final production coverage remains. |
| 3 | Verified | Three native hosts and complete artifact audit pass. |
| 4 | Verified | Census/compiler/runtime audits pass; 27 timing targets remain explicitly open. |
| 5 | In progress | Nine exact-head production jobs, docs, full audit and squash merge. |

[PR #261](https://github.com/e6qu/fun-with-pipes/pull/261), branch/worktree
`scalar-constant-lowering`. Compiler/test source matches focused
`37da72171d64dbb53dd87dbc49254f61f3ebf0bd`. Measurements use
`76690b385514c58ad94c5591da3553fa48218535`; subsequent changes repair evidence
checkers and docs only. No timing reruns are needed or permitted for a better result.

## Verified evidence

| Check | Original run | Complete audit / records |
|---|---|---|
| 25 targets, 828 native images and 844 observations per host | `42048215807` | `42070540044`; [focused receipts](measurements/scalar-constant-checks-2026-11-05/native-passing/README.md) |
| Unchanged allocations, cleanup, work and stack | `42072583890` | `42074145465`; [census](measurements/scalar-constant-census-2026-11-05/README.md) |
| 336 compiler commands per host | `42074639596` | `42076024832`; [costs](measurements/scalar-constant-analysis-2026-11-05/README.md) |
| ARM1/ARM2/AMD1 and rejected AMD2 host | `42074728167` | `42078637088`; [runtime](measurements/scalar-constant-time-2026-11-05/README.md) |
| Qualified AMD2 replacement | `42075136884` | `42078654369`; same original measurement source |

All four qualified runtime sessions measured once. Their 27 failures are long-case
5% speed targets; all other measured limits pass. Retain the verified transformation
under the agreed policy, with misses in PLAN.md. The rejected EPYC 9V45 host ran
no builds/timing; its EPYC 7763 replacement is separate. No claimed C/Rust parity.

## Repairs included

- [Native observer](measurements/scalar-constant-checks-2026-11-05/native-passing/README.md):
  keep a computed byte length for cache-ownership instrumentation; exact-bit probes pass.
- [Census observer](measurements/scalar-constant-checks-2026-11-05/census-observer/README.md):
  follow live borrowed callbacks. Four controls and 21 saved programs pass.
- [Runtime audit](measurements/scalar-constant-checks-2026-11-05/runtime-audit/README.md):
  classify instrumented references correctly. Original samples re-audited successfully.
- Four-session checker: keep the archive path separate from source-file paths.
  Guarded combined audit passes; regression rejects a corrupted last reference.
- Docs inventory: four cache tests, not three; eight controls pass. Full docs
  passed at `26a5cbe6` and `76690b38`; the final head still needs its own gate.
- Oversized workflow split; docs enforce GitHub's 512,000-byte limit.

## Sources and resources

Protocol tag: `roadmap/scalar-constant-lowering-protocol-2026-11-05` (`4bad4992`).
Pre-rebase sources: `roadmap/scalar-constant-premerge-2026-11-05` (`5e1c51d5`).
Original measurement setup: `roadmap/scalar-constant-measurements-2026-11-05`
(`26a5cbe6`); repaired observer: `roadmap/scalar-constant-observer-repair-2026-11-05`
(`76690b38`). [Parent #260 delivery](measurements/packed-pair-delivery-2026-11-05/README.md)
is verified at `a85f59d2`.

About 84 GiB remains free. User-authorized cleanup removed 1,098,786,631 bytes of
verified duplicate downloads; receipt is in `../gradient-work/removed-verified-downloads-2026-11-05-user-cleanup.json`.
Use the unchanged local guard. Full builds, suites and large audits stay on GitHub.
