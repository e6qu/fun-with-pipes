# Current work

**Next:** publish the export-inspection repair and audit its three-host focused
run before freezing measurements. All three jobs in `41640932807` are audited:
each passes 39 tests and fails the same test-root inspection. Continue monitoring
PR #252's final gates and merge only after every log is audited. Open the follow-up
PR afterward.

## Checkout and source identities

- Work here: `.worktrees/direct-array-callbacks`, branch `direct-array-callbacks`.
  Contract `776e8d98`, tag `roadmap/direct-array-callbacks-protocol-2026-11-03`,
  precedes implementation `8537e7a9`. Repair/comparison tools: `36bfee09`.
- [PR #252](https://github.com/e6qu/fun-with-pipes/pull/252) remains the only active
  PR, branch/worktree `gradient-array-results`, final head
  `e2d55aa81a7830cf7379570944ed7f307c55f7af`. Keep that head fixed unless a real
  failure needs repair. After merge, rebase this follow-up onto its squash commit.
- Scratch and evidence: `.worktrees/gradient-work`. `/private/tmp` was cleared
  earlier. Leave the detached primary checkout's recovery edits alone.
- No direct-call measurement source is frozen yet. The reference disables only
  the new scalar array-map selector; both compilers retain all gradient arrays.

## Roadmap status

The [contract](measurements/direct-array-callbacks.md) limits selection to known,
closed callbacks with ordinary scalar inputs/results. Code reuses array accessors,
caller-owner protection and partial-array cleanup. It adds no layout or syntax.
Native correctness, memory limits and performance remain unverified. A separate
[storage review](measurements/remaining-gradient-storage.md) records remaining
input/output ownership constraints and unused iteration history; it selects no
new implementation and changes no measurement protocol.

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Contract frozen before implementation; keep scope and limits fixed |
| 2 | In progress | Audit the repaired three-host focused run, fixing all failures together |
| 3 | Pending | Freeze the verified source; measure compiler costs and four runtime sessions |
| 4 | Pending | Finish #252 delivery, open the sole next PR, complete its final gates and merge |

## Follow-up checks and repairs

First run `41638033527` at `8537e7a9` failed on all three hosts before native tests:
an unescaped C brace in a Rust format string prevented compilation, then missing
artifact directories failed uploads. [Complete logs and repair](measurements/direct-array-callbacks-2026-11-03/README.md).
The brace is corrected. CI now records source/host/compiler identity before checks,
retains format/lint/build logs, and runs native targets whenever the compiler builds,
even after a lint failure. Every failing step still fails the job.

Run `41640932807` checked eight affected targets on GCC ARM64/AMD64 and Clang ARM64.
The new cases cover numeric widths, conversions, empty and sliced arrays, aliases,
effects/traps and excluded callbacks. Map/zip probes count direct calls and zero
generic applications; normal/disabled reuse and missing-cleanup controls remain.

Guarded local checks pass:

- Reference controls: 3; timing budgets: 17; compiler-analysis controls: 7;
  retained-patch audit: 15; comparison groups: 12; retention: 3.
- Rust formatting (1.85s), workflow lint (6.41s), documentation audit (2.80s).
- The production initializer format alone compiles and emits the intended C
  initializer (0.84s). This does not verify the native implementation.

The first native attempt's complete logs, targets, image identities and cleanup
observations are retained in [the repair record](measurements/direct-array-callbacks-2026-11-03/README.md).
The inspection wrongly expected exported names in a main-only build. The repair
requests exported roots separately, preserves ordinary main execution, saves C
before assertions and prints compiler diagnostics as text. All ten cleanup
observations per host pass. Native selection/value verification remains incomplete.

Use `../gradient-work/collect-direct.py` under the guard with the new `--run`,
exact `--source` and a fresh `--output` directory. It retains complete job/target
logs, validates archive/native-image identities and reconciles eight direct-map
plus ten cleanup observations. Keep failed-run directories; do not overwrite them.

## PR #252: final gates still running

Production `41635110882` requires nine jobs; docs `41635092370` also must pass.
Benchmarks, docs and both macOS ARM64 jobs pass and are fully audited; six
platform jobs remain. Use `../gradient-work/collect-252.py` under the guard to collect new
completed jobs. Results are in `../gradient-work/platforms-252`.
Carry final gate records into this follow-up rather than restarting #252 for a
status-only edit. After all ten pass, squash with an explicit one-line subject
(≤80 characters), empty body and no trailers; verify the raw message and tree.

[Storage checks](measurements/gradient-array-storage-2026-11-03/README.md),
[compiler costs](measurements/gradient-array-analysis-2026-11-03/README.md) and
[all runtime observations](measurements/gradient-array-time-2026-11-03/README.md)
are complete. Largest current-only solve: 105,203 → 79,731 allocation requests;
3,736,014 → 3,326,870 requested bytes; retains 995, peak managed bytes 14,976 and
final bytes 0 unchanged. Four raw audits reconcile 5,336 file records. All 32
required 5% speed gains remain open; AMD64 current-only whole-process RSS rises
about 9%. Keep these outcomes and rejected hosts; never rerun for a better result.
Measurement source `1f6a4ac80ed3e9e89106c27573d0c73d46bb6968`, tag
`roadmap/gradient-array-measurement-2026-11-03`. Focused prerequisite `41626196812`
at `f00fb9dc`; unchanged implementation trees are verified by measurement jobs.

## Local limits

Use `python3 scripts/local-guard.py` serially. Full builds, suites, benchmarks and
large regeneration belong on GitHub. Preserve 64 GiB free, target data below 2 GiB,
sampled workload RSS below 1 GiB and the 180-second deadline. Last free space about
86 GiB. Never raise or bypass limits. No local compiler build is running.
