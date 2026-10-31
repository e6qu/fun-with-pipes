# Current work

**Next:** run the repaired native Swift comparison, audit every result and
publish the performance/memory assessment. The first run stopped before timing. The user prioritizes runtime
performance over executable size and requires Swift as an ARC peer. The original
callable size-budget rejection stays recorded; fewer counts are not a measured
speedup. PR #233 is verified, merged and integrated. Draft PR #234 groups this
ownership change with the Swift comparison; final production gates have not run.

This worktree is `/private/tmp/fwp-returned-callables`, branch
`returned-callable-peers`, [PR #234](https://github.com/e6qu/fun-with-pipes/pull/234). Revised candidate
`dacaf253d02b40bb18b0b39977afa69b3c2001f7` runs in `41179056746`: macOS ARM job
`124472518749`, Linux ARM `124472518855`, Linux AMD `124472518974`.
All three completed and are fully audited: 49 Rust tests, 16 Python cases and
170 measurement commands per host. The same ARM O1 text limit fails; every
other decision passes. The second complete rejection archive and immutable tag
`roadmap/returned-callables-copy-rejected-2026-10-31` retain the results.
The user has redirected acceptance toward performance and working memory, with
Swift included. No further size-only decision is pending. Preserve the original
failed budget and collect the missing performance evidence before delivery.

First candidate `1f92902205c5da0269d1a0b20a2550736baff475`, run `41177534238`:
Linux AMD job `124468086194`, Linux ARM `124468086417`, macOS ARM `124468086503`.
All three completed: 49 Rust tests / eleven targets, 14 Python controls and eight
programs pass per host, with complete logs audited. Five code-level budgets pass;
ARM O1 alone fails whole-text growth (24,540 to 28,892 bytes, limit +5%). Its
decoded instructions grow by 272 bytes; 4,080 extra text bytes are zero padding
before `__divti3`. All count/storage and frame limits pass. This candidate is
not accepted. Keep the published limits and this rejection.

The byte-identical linker diagnosis passes in run `41178567613`, job
`124471094949`, source `23d55c0a`. GCC's effective link includes the Cortex-A53
843419 repair; its 16-byte stub reserves a 4-KiB region. Both O1/O2 baseline and
candidate hashes match. The rejected candidate and linker diagnosis are retained
in the callable report's compressed archives. Limits and hardware protection stay
unchanged. The one-shot workflow was removed after retaining its results;
`scripts/report-callable-link.py` remains the explicit relinking tool.

Two contiguous
plain-value slices now use `memcpy`; an empty supplied slice is never passed to
it. The added full-capture/zero-new-argument
case and all existing lifetime controls pass locally at O1/O2 (2.17s). Phase,
overflow and cleanup checks pass (1.80s). These do not establish native acceptance.
Independent first-candidate audits/downloads are `/private/tmp/fwp-callables-*-1f92*`;
linker files/audits are `/private/tmp/fwp-callable-link-23d5*`.

PR #233 passed all nine production jobs and docs at
`fd19b9e4d67c6c5f85ebbe6a12da14aaeedb0b1c`. All complete logs are audited.
Squash `73a6b20d4d10a4f2dff50d78dc0b32ee2c17b4b5`, merged at 07:28:43 UTC on
2026-10-31, has the same tree `2a8c3c40755fc8b60b5f20861fd8b1051a23a400`.
Its exact 42-character subject is `Avoid temporary range lists in State folds`,
with no body or trailers. Duplicate runs `41180750528` and `41180750575` are
confirmed cancelled. [Delivery history](roadmap-history.md#state-range-elimination-pr-233)
records every job, result and repair; raw audits are `/private/tmp/fwp-233-*`.

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

## Swift comparison preparation

Seven Swift sources now match the maintained benchmark inputs. The `swift-peers`
workflow runs two native sessions on each Linux architecture, with explicit Swift
6.4.2 / language mode 6, optimized checked builds, 24 balanced rounds, copy controls
and separate RSS samples. Historical C/Rust results remain unchanged. Native Swift
closure factories use a separate module; reference-capture cleanup is a separate
control. Scalar Swift allocation/count and phase-time measurements are still open.
First collection: `41212931691`, source `3e6dbb4d9f8b25df313ea6d61892dcabd5da7c9a`.
AMD sessions 1/2 are jobs `124571511919` / `124571512131`; ARM sessions 1/2
are `124571512142` / `124571512086`. All four complete logs are audited: the container lacked `cc1plus`, needed by
fwp's numeric C++ support. Install `g++`, select `CXX=g++`, preserve build logs
before measurements, and only upload existing evidence. Rustup's sudo check is
explicitly disabled for GitHub's known root-container /github/home layout; no
HOME variable is changed. No timing samples were collected, so this is a setup
repair, not a retry of an observed measurement. Raw logs: `/private/tmp/fwp-swift-*-3e6d.log`.
No Swift speed or memory result has been accepted yet.

Focused local Swift 6.2.1 ARM64 checks pass (2.92s): eight checksum/representation
rows, normal release and omitted-release exit 78. Three timing-record tests pass
(0.13s), including balanced ordering and incomplete/noisy records. Workflow lint
passes (5.83s); the roadmap audit passes (3.11s). Full measurement stays on runners.

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
  baseline archive tests pass (3.08s). Five revised budget/archive/linker tests
  pass (1.47s). Workflow lint passes (5.03s); roadmap audit
  passes (3.02s): 190 link sets, 106 immutable pairs and eight steps.
- Rust formatting uses the repository's 2021 edition (0.14s). An initial check
  mistakenly used 2024 and reported only style differences. Diff check passes.
- After integrating #233: workflow lint passes (5.82s), roadmap audit passes
  (2.62s: 190 link sets, 106 immutable pairs and eight steps), and no merge
  conflicts remain. Compiler/runtime files match the tested `dacaf253` candidate.

Tracked measurement files were restored for docs checks after checking the
64-GiB free-space floor. Preserve local resource limits. The #233 shared-input service repair is integrated before this branch's full matrix.
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
| 7 | In progress | Add Swift and finish performance/memory B1/B2 comparisons |
| 8 | In progress | Complete numerical and integrated V1/V2 acceptance |

[PLAN.md](../PLAN.md) retains the unchanged budgets and failed timing controls.
This preparation does not close them or replace the active delivery order.
