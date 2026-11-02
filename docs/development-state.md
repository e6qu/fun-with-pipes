# Current work

**Next:** publish and run focused checks for the drafted numeric callback-input
rewrite, then audit every target/count result and batch any repairs. Complete-field
transfers pass all focused correctness/count audits. [PLAN.md](../PLAN.md) tracks that batch. PR #248 is verified and
merged; no delivery PR is currently open.

## Checkout and source identities

- Worktree `/private/tmp/fwp-array-consumption`, branch `numeric-owner-transfers`.
  Primary checkout untouched. Next-batch commits were rebased onto verified main
  `31e4e25b9a0494a2ce3d75a189fe1b1b7c177247` after #248 merged.
- The current focused run uses immutable source
  `ceecb569c6748a226ec6ddebc417dc16351490e9`, tag
  `roadmap/field-owner-emission-checks-2026-11-03`. Rebased compiler checkpoint
  `3c838fad` has identical sources; later `85a01d01` adds independent site auditing.
- Preparation `9a4129be` is published after the rebase, with immutable protocol tag
  `roadmap/numeric-callback-input-protocol-2026-11-03`, before second-stage code.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Both native GCC/Clang controls and all 96 counts independently audited |
| 2 | Implemented | Numeric-input rewrite drafted; runner build, controls and counts pending |
| 3 | Pending | Combine exact counts, source attribution, cleanup and compiler-cost checks |
| 4 | Pending | Two timing sessions per architecture after the grouped implementation is ready |
| 5 | Pending | One substantial PR, full final gates and verified squash |

## Current focused run

[41538264130](https://github.com/e6qu/fun-with-pipes/actions/runs/41538264130):
AMD64 job `125595570185` and ARM64 job `125595570447` pass on `ceecb569`.
Both full job logs and all 16 native target logs are audited: 30 tests per host,
no diagnostics. All 96 observations, source-site attribution, archive manifests,
image headers, code size and frames pass independent audit (1.94s / 2.16s).
All 40 saved probes are checked: 16 ordinary returns and 24 rejected broken
controls, with actual native images and observed exits (0.14s).

Largest solve: 77,411 → 51,939 retains; allocations, peak and raw storage/work
unchanged; final storage zero. The projection removes exactly `p` retains and
mapper inputs stay `2*p` in every observation. No speed claim.
[Retained evidence](measurements/derivative-owner-transfers.md#first-stage-results).
Counts artifacts: ARM `13185303628`, AMD `13185213550`; native controls:
ARM `13186166031`, AMD `13185333094`. Local archives:
`/private/tmp/fwp-field-owner-{counts,checks}-{arm,amd}.zip`.

The suite runs five GCC and three Clang target groups at production Rust settings
and generated C O1/O2, then reuses the compiler for every count observation.
Native controls include direct/boxed/shared owners, two/eight fields, repeated
child aliases, exact counts, traps, actual cancellation, result-boxing allocation
failure and deliberately omitted physical release. No new target or reduced
coverage. Full timing and platform validation wait for the related batch.

The `field-owners` count policy requires at least `p=(coordinates-1)*updates`
fewer retains, no allocation/peak growth, unchanged raw storage/work and zero
final storage. Independent `summarize-derivative-forward-costs.py --comparison
field-owners` also checks the removed projection and unchanged mapper input
retains (`2*p`) in saved C and observations. It reports code size without adding
a size acceptance limit, and keeps the frozen 128-byte maximum frame growth.
Thirteen observer/acceptance tests pass locally (13.45s), including changed
site/phase/count and missing physical-storage evidence controls.

## First-stage proof and repaired failures

[Protocol](measurements/field-owner-transfer-protocol.md) was published at
`5cf8813a` under `roadmap/field-owner-transfer-protocol-2026-11-02` before code.
`src/cgen/field_transfers.rs` selects complete consecutive transfers of two-to-eight
separately owned counted fields. It excludes borrowed/resource, repeated/partial,
interrupted and still-live parents. It preserves original IR and call-liveness
identities; boxed entry cleanup stays in place.

- Initial probe `41533745677` was cancelled before either job started. Review
  found repeated continuation scans could become quadratic. The revised index
  walks an eligible emission tree once and checks each bounded group against it,
  including uses in enclosing continuations. Metadata:
  `/private/tmp/fwp-field-owner-superseded-jobs.json`.
- Revised probe `41535112048`, source `6d490362`, compiled/linted and passed four
  unit controls. All eight native target logs per host were audited: 22 passes /
  four failures across GCC and Clang. The two new controls failed on selection;
  other targets passed. Complete logs have no other diagnostics.
- Root cause: C generation emits a cloned function body, but the candidate indexed
  the stored body. Pointer identities therefore differed and nothing selected.
  Repair makes the lazy index part of `FnGen`, rooted in the exact emitted body.
  Worker, boxed entry, borrowed callback and normalized loop paths were checked.
  No added body copy or per-binding scan. This is the current `ceecb569` probe.

[Complete failed logs and artifact identities](measurements/derivative-owner-transfers.md)
are retained in `docs/measurements/field-owner-transfer-checks-2026-11-03/`.
Downloaded archives and audits: `/private/tmp/fwp-field-owner-{arm,amd}.*`,
`/private/tmp/fwp-audit-field-owner.py`; all source/digest checks pass (0.13s).

## Second-stage investigation

[Saved-source audit](measurements/derivative-owner-transfers.md): all 48 sources /
96 observations attribute `2*p` retains to mapper input preparation and `p` to the
first tuple-field projection. Largest case: 76,416 of 77,411 retains (98.7%).
Repository auditor replay agrees with the independent report (0.50s).

The saved mapper `w164` merely forwards its two `Rev[F64]` inputs to `w124`.
There is no later local use proving continuing ownership. Current borrowing
inference rejects nested records and requires continuing owners, so enabling a
flag or deleting argument preparation is unsafe.

The [numeric-input protocol](measurements/numeric-callback-input-protocol.md)
selects a two-level numeric record consumed only through leaf reads, rewrites all
known direct callers, and lets the forwarding callback pass numeric fields.
Protocol tag `roadmap/numeric-callback-input-protocol-2026-11-03` was published
at `9a4129be` before code. It freezes
selection/exclusions, at least another `2*p` retains removed, unchanged storage,
linear analysis, compiler timing/RSS limits and the final paired timing protocol.

Implement after packed-record lowering, before ownership insertion, using its
already-owned result to avoid another whole-program clone. Keep original map
input types; only the internal nested-record callee changes type. Its forwarding
callback's unchanged flat input types gain the existing numeric-field ABI.
Packed-map preparation must then pass those fields while retaining normal owning
preparation for any parameters still requiring it. Read the protocol before edits.

### Drafted numeric-input candidate

`src/cgen/numeric_parameters.rs` selects only internal one-argument functions,
bounded two-level numeric records, leaf-only uses and pure literal-record direct
call arguments. It checks all function-value/entry references and uses iterative
strong-component analysis to reject recursion. Lexical record aliases disappear;
all direct callers and the internal parameter type change together. Five unit
groups include signature/caller agreement, exclusions, numeric read reuse and
32/128/512-function analysis scaling.

The pass mutates the already-owned packed lowering result, before ownership
insertion and the existing typed-IR check. It adds no whole-program clone.
Packed mapper emission reads numeric input fields directly; a mixed two-parameter
ABI has at most one boxed parameter to prepare, so no earlier prepared owner is
stranded by a later failing retain. Existing fully boxed preparation is unchanged.

New native fixture `numeric_callback_inputs.fwp` covers direct forwarding,
numeric/boxed mixed parameters, map/fold effect order, empty/unequal/shared inputs,
aliases and final storage. Existing packed failure/cancellation/physical-release
controls now also exercise unpacked numeric inputs. The focused suite is
`numeric-input-checks`: five numeric selection tests plus four field-transfer
tests, five native target groups under both GCC/Clang, and all 96 counts against
stage 1 with at least another `2*p` retains removed. No local Rust build or
candidate runtime result yet. New fixture formatting/interpreter baseline pass
(0.01s / 0.26s); thirteen count/site tests pass (13.57s).

Remaining before delivery: full exclusion/cleanup audit, independent attribution
of both removed mapper sites, same-source comparison compiler, compiler time/RSS
experiment, combined paired runtime timings and the final nine-job matrix.

## Verified previous delivery

[PR #248](roadmap-history.md#packed-temporary-numeric-records-pr-248) merged as
`31e4e25b9a0494a2ce3d75a189fe1b1b7c177247`. All nine production jobs in
`41524286630` and documentation `41524286169` pass on
`32aae4f79b66f5e88e9aded39d6df794439b7430`; every job/target log is audited.
Merge tree `8213af3a5722c84c8730bad5071f24e5f6579ed3` matches the tested head.
Raw message is exactly `Keep mapped numeric records in one temporary buffer`
(51 characters, no body/trailers). [Final gate identities](measurements/derivative-temporary-storage-2026-11-02/final-gates.json).
Duplicate identical-tree main runs `41539187897` / `41539188093` are confirmed
cancelled.

Both Linux target archives contain 257 targets / 1,037 passes / 20 ignored, no
diagnostics. Full jobs have 258 summaries / 1,038 passes plus SDK/package checks.
Final logs `/private/tmp/fwp-248-final-*.log`; archive metadata
`/private/tmp/fwp-248-final-artifacts.json`; ARM target `13184911088`, AMD
`13185416122`. Guarded final audits pass (0.13–0.14s). Only benign install notices,
echoed warning flags and source-verified intentional failure controls appear.

[Measurements](measurements/derivative-temporary-storage-2026-11-02/README.md):
largest solve saves 51,143 allocations / 4,064 peak managed bytes. All four timing
sessions are audited; cases with at least 199 updates use 5.1–14.2% less time.
Keep the AMD64 zero-update history regression (2.024%, limit 2%) and D2 open.
No unchanged measurement repeats for a pass. Detailed old attempts and repairs
belong in the linked verification report, not the active task list.

## Focused checks and local resources

- Rust formatting: pass (1.81s); workflow lint: pass (6.72s).
- Thirteen observer/site/acceptance tests: pass (13.45s).
- Latest docs audit before delivery updates: 220 link sets, 106 immutable pairs,
  five steps pass (3.13s). Recheck after the final plan/history/handoff edits.
- Verified previous compiler `/private/tmp/fwp-248-macos-arm` formats, interprets
  and emits baseline C for the new fixture. It does not verify the candidate.

No local full build, suite or benchmark. Use `python3 scripts/local-guard.py`
serially. Last free disk: 67 GiB; no local target data. Keep 64 GiB free, workload
RSS below 1 GiB and the fixed 180-second deadline. Move refused work to runners.
