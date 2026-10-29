# D1 preparation while PR #225 completes CI

**Next:** review and publish the current-source descent measurement preparation,
then run its `descent-peers` workflow on this branch (four sessions). Coordinate
with PR #225's repair/merge below; do not open a second PR. D2 must follow measured
costs and predeclared limits, and D3 precision/nesting remains unimplemented.

Worktree `/private/tmp/fwp-ad-refresh`, branch `ad-cost-refresh`, based on
`18ae46cdbf2fa2cc8b33cee78b86ed9b8a2dce4a`. Changes are currently uncommitted.
Read [the D1 protocol](measurements/descent-costs.md) and [PLAN.md](../PLAN.md).

## Prepared

- Current-source runner updates `scripts/measure-descent-peers.py`: AD history,
  AD current, explicit list/packed fwp, C/Rust, and a byte-identical AD control.
  It no longer downloads an older generated-C archive or requires an older fwp.
- Six original cases, 2 warmups/56 Williams-scheduled samples, seed 20261029.
  Two sessions per native architecture; record actual CPU and keep host differences.
- Separate numeric tape clocks in `scripts/descent-phases.py` and
  `tests/fixtures/descent_phases.c`: setup, forward-with-recording, reverse setup,
  reverse traversal, result array, retirement. 2 warmups/12 alternating paired
  observer/ordinary rounds expose instrumentation effects. No per-node clocks.
- Managed/raw storage profiles with workspace on/off. For one-update AD-current,
  a missing parent free must exit 232 and an omitted phase must exit 233.
  Current runner includes their C/images/results in metadata; native execution
  still needs runners. Existing budget-control helper remains for historical tests.
- `descent_peers` workflow updated to four jobs with explicit session/settings,
  GCC observer controls, no old archive download. Full production not requested.

## Local checks and known limits

All checks used `python3 scripts/local-guard.py` serially. Four Clang observer
control groups pass; three historical budget controls pass. Python syntax,
actionlint and documentation audit pass. No full fwp build/test/benchmark locally.
The observer test initially assumed positive elapsed time for empty phases;
macOS can report zero at clock resolution. Fixed the reader to allow that, keeping
phase-count/order checks, and documented zero as below resolution, not free work.
The actual generated-C probe, native GCC run and six-case comparisons are not
verified yet. Output-cost refresh, full D1 archival verifier/budgets, D2 and D3
remain pending. Do not select an optimization or claim D1 complete yet.

## Active PR to finish first

PR #225 in `/private/tmp/fwp-cpu-phases` is at 18ae46cd, production `40813465621`.
Both Windows jobs fail the first native execution step; later suites still run.
Prepared local repair removes LF/CRLF mismatch in standalone decimal oracle output
and uploads failed-step logs early. Logs must confirm actual failures; batch all
repairs after auditing every completed target. Docs and benchmark gates pass and
are audited. Require all nine jobs plus docs at the repaired final head before
squash merge, one line <=80 chars, empty body, no trailers/attribution. Verify tree.
This worktree will need that small test/workflow repair and rebase onto the verified
squash before its own PR. Preserve measured source IDs once published.

The primary checkout remains detached at #209; preserve its recovery pointer and
untracked compiler-abort report. The old Intel abort is not diagnosed. No agents.
