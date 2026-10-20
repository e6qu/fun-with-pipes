# Session handoff

## Next action

Next: publish `flatten-channel-loop-state-delivery` as one PR, then require all
nine production jobs and documentation on its exact final head. Focused checks
below pass; full acceptance has not run yet. Fix every failure, audit completed
logs, then squash merge with an explicit one-line subject of at most 80 characters
and empty body. Verify the merged tree/message before cancelling redundant runs.

[PR #175](https://github.com/e6qu/fun-with-pipes/pull/175) is accepted as
`b9cfbbe656baacf30864c8a84b0184ca683ff5b6`, the base of this branch.
All nine production jobs `39363423392` and documentation `39363423384` passed
on tested head `6511a50f`. The merge has the same tree and a verified 58-character
subject with no body or trailers. Redundant post-merge runs `39370566486` and
`39370566329` are cancelled. [History](roadmap-history.md#function-queues-and-cheaper-sends-pr-175)
records the accepted queued-function proof, consuming sends and `tap` optimization.
Do not reopen their preparation branches as new work.

## Current changes

Channel programs still allocated a tuple each time they advanced loop state.
An action or branch could hide the next record from existing field-by-field
lowering. The compiler now follows a match when every arm ends in a record,
keeping eligible state fields in locals. Actions, patterns, aliases and failures
retain their semantics; existing shape and resource checks still apply.

Known, capture-free function aliases now expose direct calls. The measured
`string.length` callback no longer uses generic dispatch. Arity-zero constants
stay at their original evaluation point because they can allocate or trap.
There is no new syntax or runtime helper. See the
[example, counts and actual binary inspection](measurements/channel-loop-state.md).

The log audit also found five Linux resident-memory tests returning early on
macOS but appearing to pass. They now explicitly report the Linux `/proc`
requirement. Missing or failing C compilers fail GC checks; negative controls
verify both cases. The full stress golden suite still runs on macOS. Inline
imports found during review were moved to file scope, and temporary-directory
comments now describe the actual guarantees.

## Evidence

| Check | Revision and run | Result |
|---|---|---|
| Loop-state counts | `16adc74b`, `39363807189` | Both Linux architectures; 180 samples and 20 ordinary binaries audited |
| Loop-state ownership | `16adc74b`, `39364385408` | All six native platforms: 47 integration tests plus all compiler units each; both WASI hosts: 18 checks each |
| Resource fields with GCC | `cc850204`, `39365324259` / `39365327202` | 37 tests across 21 targets on each Linux architecture |
| Loop state plus function aliases | `75da96b8`, `39366497033` | All six native platforms: 62 integrations plus all compiler units each; both WASI hosts: 18 checks each |
| Combined counts | `75da96b8`, `39366501786` | Both Linux architectures; 180 samples and 20 ordinary binaries audited |
| GC test reporting | `bd9eb989`, `39368181540` | Eight tests per Linux host; three applicable tests and five explicit Linux-only ignores per macOS host; both invalid-compiler controls pass on all four |

Complete logs are audited. Except for the five explicit Linux-only GC tests on
macOS, these runs have no ignored or filtered tests. Native unit totals are 145,
or 146 on Windows. The current delivery carries the measured implementation plus
GC test/workflow repairs, import placement and documentation changes. These
focused runs do not replace final-head production acceptance.

The count comparison uses integrated PR #175 source `f3c6f8d9`, run `39362629293`,
with GCC O2 and LTO disabled on both revisions. Each of five cases saves one
allocation per additional message from loop-state lowering. Fresh/closed cases
save one retain, shared cases two. Every ARC profile ends with zero charged
storage. Alias propagation saves no further allocations or retains; the fresh-text
exchange frame shrinks by 48 bytes on each architecture. Reports separate code
size, file size and individual frames. These are fwp operation-count comparisons,
not elapsed-time improvements or evidence of C/Rust parity.

## Local checks and resource limits

Use `python3 scripts/local-guard.py COMMAND...` for serial bounded checks.
No local full compiler or generated native build was run. Disk is near the
64 GiB floor; heavy work belongs on runners. A guarded `cargo clean --profile dev`
removed 573.7 MiB in 0.58s before reaching the floor; do not rebuild locally.

Guarded raw interpretation checks the branched loop and retained alias (0.82s)
and the documentation example (0.86s). `scripts/summarize-channel-costs.py`
audits loop-only and combined reports (1.61s/1.55s). Complete-log audit scripts
verify resource fields (0.23s) and combined ownership (0.14s). ELF inspection
checks actual sections, calls and frames. `cargo fmt --all` and
`python3 scripts/check-roadmap.py` pass after preparation (1.55s/2.74s).

An earlier handoff edit omitted the required status table; restoring it fixed
the audit. A guarded `du` returned sizes but stopped with `Operation not permitted`
while controlling the system utility; it was not retried and no limits changed.
Redundant audited baseline/transfer/tap downloads were removed; committed reports
and GitHub artifacts remain. Integrated baseline and candidate binaries remain
under `/private/tmp/fwp-channel-{cost-combined,loop-costs,alias-costs}`.

Publication checks on the delivery branch pass under the guard: `cargo fmt --all
-- --check` (1.43s), `python3 scripts/check-roadmap.py` (2.89s),
`python3 scripts/check-primitive-inventory.py --baseline
tests/fixtures/primitive-inventory-baseline.json --output
/private/tmp/fwp-next-primitive-inventory.json` (1.06s), and
`python3 scripts/test-native-test-runner.py` (11 checks, 8.52s).

## Roadmap status

All seven areas in [PLAN.md](../PLAN.md) remain open.

| Step | Status | Work |
|---|---|---|
| 1 | In progress | Ownership and GC removal |
| 2 | In progress | Functional overhead |
| 3 | In progress | Machine performance |
| 4 | In progress | Autodiff |
| 5 | In progress | Numerical kernels |
| 6 | In progress | Reproducible comparisons |
| 7 | In progress | Larger applications |

Persistent subscriptions, resource captures, resource-owning tail frames and
mutual recursion need further proofs. Shared-text channel exchange still allocates
its receive result; removing it would need evidence for failure, cancellation and
call boundaries. That change is not implemented in this delivery. JIT is excluded.
Follow [AGENTS.md](../AGENTS.md): one active PR, final-head gates, bounded local
work and one-line commits without trailers.
