# Current work

**Next:** finish [PR #233](https://github.com/e6qu/fun-with-pipes/pull/233), then
integrate its verified merge here before opening the next single PR. Its active
handoff is `/private/tmp/fwp-state-range-folds/docs/development-state.md`.
Keep both tested heads unchanged while their remaining gates run.

This worktree is `/private/tmp/fwp-returned-callables`, branch
`returned-callable-peers`. No PR is open for it. Candidate
`1f92902205c5da0269d1a0b20a2550736baff475` runs in focused matrix `41177534238`:
Linux AMD job `124468086194`, Linux ARM `124468086417`, macOS ARM `124468086503`.
All three completed: 49 Rust tests / eleven targets, 14 Python controls and eight
programs pass per host, with complete logs audited. Five code-level budgets pass;
ARM O1 alone fails whole-text growth (24,540 to 28,892 bytes, limit +5%). Its
decoded instructions grow by 272 bytes; 4,080 extra text bytes are zero padding
before `__divti3`. All count/storage and frame limits pass. This candidate is
not accepted. Keep the published limits and this rejection.

Next candidate action: run the `callable-link` diagnostic. It relinks retained
baseline/candidate objects with native GCC and a linker map, requiring exact
original executable hashes. It records the actual driver/linker options. This
identifies the padding without changing compiler code or repeating timing tests.
No repair has been selected. Independent audits and complete downloads are
`/private/tmp/fwp-callables-*-1f92*`; the only expected audit failure is ARM O1 text.

PR #233 tests `fd19b9e4d67c6c5f85ebbe6a12da14aaeedb0b1c` in `41174213818`,
with docs `41174213793`. Five gates are fully audited and passing: docs,
benchmarks, both ARM macOS jobs and Intel macOS ownership. Both Windows native
phase archives also pass their 49 resource and six callback targets. Linux,
Windows TLS/ownership and regular Intel macOS are still running. No current
failed step is reported. The State handoff owns the earlier repairs and audits.

## What this batch changes

An initial, exactly saturated borrowed call with no owned parameters enters
its existing typed function directly. It copies scalar captures, preserves the
caller's closure and returns an owned result. This removes effective count
updates and one application-helper entry. Under/overapplication and owned
captures keep their ownership handling. Returned callables during an extra
application are owned and still consumed. No new syntax or metadata field.

The generator's null argument destructor proves the complete arrow spine has
no owned parameters. Handwritten String/wide callback descriptors now state
their actual drops. The copied-list key callback consumes and protects its
String input like generated entries. Remaining entry-only grpc test records
are deliberately unused; the State-slot callback accepts only unit.

The new regression checks pointer-shaped scalar bits, aliases, owned results,
partial/extra arguments, typed failure, callback failure, cancellation and reuse.
Removing its returned-owner safeguard must preserve arithmetic but fail storage
validation with exit 229. State expectations now require one application-helper
entry, keeping two requests / 152 bytes.

## Baseline and acceptance

The [callable report](measurements/returned-callables.md) owns the representations,
equivalent work, complete baseline and limits published before implementation
at `4f2defb2`. Source `7d7cf98bc62944d6c040293f4d17543c3bb51470`, focused run
`41175225918`, passes all three hosts. Its 8.1-MB archive retains all 170 commands,
eight ordinary/profiled programs and full job logs per host. Immutable tag:
`roadmap/returned-callables-baseline-2026-10-31`. Audits/downloads are under
`/private/tmp/fwp-callables-*-7d7c*`.

At O1/O2 on every host, require zero invocation retains/releases and one helper
entry per call, with no construction/destruction or storage increase. Worker and
whole text must stay within 105% of baseline; largest C frame and summed borrowed
helper frames may grow by at most 64 bytes. Missing-release controls still fail.
The checker recomputes raw records and writes every budget decision. These
limits make no elapsed-time claim and cannot close D2/N1 timing acceptance.

## Local verification

All checks used `scripts/local-guard.py`. No full local build, suite or benchmark.

- Clang O1/O2 phases: outputs, overflow, missing release and failure/retry pass
  (2.16s), using `/private/tmp/fwp-check-returned-candidate.py`.
- New lifetime regression: ordinary exits 0; damaged owner guard exits 229 at
  O1/O2. Four binaries rechecked in 0.13s after tool output was lost.
  `/private/tmp/fwp-check-plain-borrowed.py` uses retained generated C with the
  exact current runtime function and real allocation-ledger instrumentation.
- Existing functional costs: all known rows pass at 32/128 and O1/O2 (1.72s).
  `/private/tmp/fwp-check-plain-functional.py`. State helper counts fall from two
  to one. These preflights do not replace production Rust tests or GCC checks.
- Three budget tests pass (0.37s), including 18 damaged limits. Three complete
  baseline archive tests pass (3.08s). Workflow lint passes (5.61s); roadmap audit
  passes (3.02s): 190 link sets, 106 immutable pairs and eight steps.
- Rust formatting uses the repository's 2021 edition (0.14s). An initial check
  mistakenly used 2024 and reported only style differences. Diff check passes.

Tracked measurement files were restored for docs checks after checking the
64-GiB free-space floor. Preserve local resource limits. After #233 merges,
integrate its shared-input service repair before this branch's full matrix.
Require all nine final-head production jobs plus docs before squash merge.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Preserve scoped A1–A6; broader costs belong to B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the recorded loop gap |
| 5 | In progress | Meet D2's remaining timing requirement |
| 6 | In progress | Resolve N1 controls before N2 timing acceptance |
| 7 | In progress | Deliver State reductions and finish B1/B2 comparisons |
| 8 | In progress | Complete numerical and integrated V1/V2 acceptance |

[PLAN.md](../PLAN.md) retains the unchanged budgets and failed timing controls.
This preparation does not close them or replace the active delivery order.
