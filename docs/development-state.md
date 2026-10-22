# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Ownership, borrowing and
removal of tracing remain the priority. JIT is excluded. Continue grouped PRs;
a completed delivery does not finish the language's memory/performance goals.

## Accepted baseline

The user merged [PR #197](https://github.com/e6qu/fun-with-pipes/pull/197) as
`b94710c9212cbbfc3e39409835e539b371069b36`. All nine production jobs
(`39793823991`) and docs (`39793823875`) passed exact head `0367e81941a213b96de14dbe175143ff0a121f77`.
The merge tree, sole parent and one-line message were verified. Receipts:
`/private/tmp/fwp-197-final-acceptance.json`, `/private/tmp/fwp-197-user-merge.json`.
Duplicate main production run `39809854139` was cancelled; passing docs were kept.
[History](roadmap-history.md#borrowed-array-captures-pr-197) preserves the result.

## Current PR and next action

[PR #198](https://github.com/e6qu/fun-with-pipes/pull/198) is the sole active delivery.
Branch `direct-call-entries` lives in `/private/tmp/fwp-direct-entry-delivery`.
The primary checkout remains detached at #197; use the delivery worktree.

**Next:** publish the checked grouped repair, then audit all nine production jobs
and docs for its final head. The publication receipt identifies the current head:
`/private/tmp/fwp-direct-callback-delivery-publication.json`. Consult it before
pushing or dispatching again; never rerun a completed publication helper.
Use `/private/tmp/fwp-audit-198-final.py` and inspect final-head capture binaries
with `/private/tmp/fwp-inspect-198-captures.py --host HOST --part PART`.
For Linux/Windows use `all`; for macOS inspect both `regular` and `gc`.
Fix every failure together. Squash merge is authorized only after exact-head
acceptance: one-line subject at most 80 characters, explicitly empty body,
no trailers or attribution. Verify tree/parent/message and continue PLAN.md.
No permission question is pending.

The PR combines:

- Local captures for known array generators and both fold directions; unused
  generic call adapters are removed while function values/external dispatch
  retain theirs. [Design](design.md) records eligibility and lifetime rules.
- Interpreter/native checks for reused/stored callbacks, ordinary calls, empty
  inputs, ordering, errors and cancellation, with broken-ownership controls.
- Per-solve memory observations and C/Rust comparisons that distinguish formula
  arrangement, buffers, checked access and output costs.
- Windows callback coverage, explicit executable paths for saved fold evidence,
  and parallel target execution with progress limits and retained build logs.
- Clearer benchmark/application guidance and a shorter current plan.

## Complete audit of the first production head

Head `41a6c570aac248f2a4488993ec98225a07574313` finished production run
`39820054190` and docs `39820054279`. All six Linux/macOS jobs, benchmarks and
docs passed. Both Windows jobs failed only
`right_fold_releases_accumulator_and_scratch_on_failure`: the artifact copy at
`tests/fold_unwind_ownership.rs:216` used an extensionless filename, while the
Windows linker produced `.exe`. Later Windows checks reported no other failures.
Complete logs and every completed target were audited. Receipt:
`/private/tmp/fwp-198-final-acceptance.json` (archive it by source before updating
that path for the repair). Early logs are also in `/private/tmp/fwp-198-windows-early/`.

Both fold artifact paths now use explicit `.exe` names. Windows adds four missing
array/fold targets and moves the already-covered fold-unwind target once.
The resource/TLS groups retain all 128 existing target occurrences through the
existing two-target runner, with 600-second progress limits and separate logs.
Combined logs still capture build failures. Final CI must verify these changes.
A speculative callback-path change was disproved by the accepted compiler and
removed; do not restore it or weaken cleanup assertions.

The first head's macOS ARM64 artifacts contain 80 independently inspected
callback/capture/unwind images and 136 verified observations, under
`/private/tmp/fwp-198-capture-evidence/41a6c570aac2/`. This is preparation evidence;
inspect the final-head artifacts too. Earlier invalid ARC stress settings and
an obsolete fold adapter probe were repaired before this head; their failed
runs remain recorded in the measurement reports, not counted as acceptance.

## Numerical evidence included in this PR

- [Callback locals](measurements/callback-locals.md): source `927c6b1852a69748ae613291d89774bb8ae31121`,
  run `39816519529`, both hosts pass; 132 inspected images. Largest instructions
  fall to 33,570 bytes on AMD64 and 31,612 on ARM64. Generator frames fall from
  96 to 48 bytes. Requests/retains/managed peak stay 459/0/7,200 bytes. No speed claim.
- [Per-solve observers](measurements/descent-observers.md): run `39816523757`,
  both hosts pass; 104 inspected images. All 512 checkpoints have zero live
  managed/raw storage. Delayed release fails 225; final-only observation misses it.
  This run uses saved adapter-only sources, not the expanded capture-local compiler.
- [Matched formulas](measurements/coordinate-work.md): preparation
  `b9d598629ab38cfdd29d7863ec9cdbfd9bd893b6`, run `39827232824`, both hosts pass;
  144 inspected images plus sixteen small controls per host. Largest fwp time
  is 10.40–13.69× coordinate C and 11.86–14.07× Rust. Eleven timing controls pass;
  AMD64 3:1999 exceeds 2% and remains inconclusive. Peer buffer-release faults
  and fwp delayed-release controls behave as required. Actual outer loops and
  AMD64 indirect allocation targets are inspected. One run per host is not a
  compiler speedup claim. Numerical preparation is fully integrated; receipts:
  `/private/tmp/fwp-coordinate-acceptance.json`, `/private/tmp/fwp-coordinate-integration.json`.

The earlier [inline experiment](measurements/descent-call-costs.md) failed its
predeclared 5% speed screen. Do not select an inlining rule from it. Preserve
historical timings, failed controls and implementation differences.

## Checks and local resources

Focused checks pass: grouped formatting/workflow/docs/budget/runner controls
(14.77s), integrated source hashes/new report links/formatting (3.42s), and exact
Windows target preservation plus workflow lint (0.26s). Helpers:
`/private/tmp/fwp-check-combined-repair.py`,
`/private/tmp/fwp-check-coordinate-integration.py`,
`/private/tmp/fwp-check-windows-group-coverage.py`.
These do not replace final native CI. No full build or benchmark ran locally.

Use `python3 scripts/local-guard.py COMMAND...` serially. Keep 64 GiB free disk,
target data below 2 GiB, aggregate sampled RSS below 1 GiB and the 180-second
limit; never raise limits. Free space was about 66 GiB before the new evidence
downloads. Preserve modified worktrees and receipts. Do not repeat old cleanup,
publication or integration helpers with existing receipts.

Preparation `/private/tmp/fwp-coordinate-costs`, branch `measure-coordinate-costs`,
is clean at `b9d59862`; its files/results are already integrated into #198's worktree.
Preserve its tag; do not create another PR for it. `/private/tmp/fwp-descent-call-costs`
is inactive. After this PR, separate remaining output, callback, bounds-check and
buffer costs before choosing the next optimization; ownership boundaries remain open.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit ARC at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |
