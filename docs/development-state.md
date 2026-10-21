# Session handoff

## Next action

Next: audit [PR #191](https://github.com/e6qu/fun-with-pipes/pull/191) at
`12be5afcee7c81f1b98ffed2081d698e1124b000`. Production `39688998592`, documentation
`39688998567` and focused GCC `39688997806` must all pass for this exact head.
Documentation, benchmarks, focused GCC and both ARM macOS jobs pass with full
logs audited. Six production jobs remain running; no failure has been reported.
Keep this delivery head fixed. Fix all discovered failures together.

Use `/private/tmp/fwp-audit-191-final.py` and `/private/tmp/fwp-audit-191-gcc.py`.
Once accepted, `/private/tmp/fwp-merge-191.py` rechecks the gates/base, squash-merges
with an explicit one-line subject and empty body, then verifies message, parent
and identical tree. Continue the application group below as the next substantial
PR, then the seven remaining plan areas. Do not open a second delivery PR.

## Delivery and worktrees

- Primary checkout `/Users/zardoz/projects/fun-with-pipes` is detached at verified
  #190 merge `a2b9130fa1811c32e8807ba8cf61a8647fbcba60`; only this handoff is dirty.
- #191 branch/worktree: `task-results-cpu`, `/private/tmp/fwp-task-results-cpu`.
  Receipt: `/private/tmp/fwp-combined-publication.json`. Its only local edit is the
  handoff; do not push that alone while final gates run.
- Next group: `application-baselines`, `/private/tmp/fwp-application-baselines`,
  based on #191's tested head. Current published head is `4ce989e5ffb9252fe47abbdb7dbebb50728fbad7`.
  New uncommitted work adds three source-level replacement alias cases, the repeat
  report and a focused native/WASI `text-owners` workflow selection. Publish them
  together and require their checks before delivery.
- Older await/CPU preparation worktrees and immutable tags are evidence. Preserve
  them; their superseded instructions are not new work.

#191 combines direct task-await fields, State/Jacobian cleanup, raw C-buffer
cleanup, explicit CPU execution contracts, removal of runtime OpenCL compilation
and preparation of foreign bridges before program effects. Its code matched
accepted CPU preparation `2cefc648` before the workflow/documentation integration.
Await source `f2b5d400` passed six native and two WASM jobs in `39678830873`;
independent inspection covers 204 native binaries and 64 await modules. Its
measured fixture removes 34 allocation requests/544 requested bytes with unchanged
retains and peak storage. See the delivery's `docs/measurements/task-await-fields.md`.

#190 passed all nine production jobs and docs; its squash tree/message are
verified in `/private/tmp/fwp-190-final-acceptance.json`. Redundant same-tree
post-merge production `39688181299` was cancelled; post-merge docs `39688181354`
pass with a full-log audit. Do not repeat that merge or completed inspections.

## Application preparation and evidence

The next group defines a finite six-family application suite and measures
word frequencies, gradient descent and unchanged-string ownership. Its reports
are in `/private/tmp/fwp-application-baselines/docs/measurements/`; the acceptance
suite is `docs/application-acceptance.md`. No work area is complete.

| Preparation | Source / run | Actual result |
|---|---|---|
| Word-frequency C/Rust baseline | `74263bccf8e2` / `39690307737` | Both Linux jobs pass; eight binaries inspected. Larger ARC case takes 3.29–3.52× C and 2.45–2.54× Rust time. |
| Descent history versus current weights | `4815e3d16c34` / `39692176065` | Both Linux jobs pass; 24 binaries inspected. At 129 coordinates, managed peak falls 845,424 → 26,288 bytes, with modest/mixed timings. Raw tape buffers are outside the counters. |
| Unchanged string owners | `67b684506bb4` / native `39694262883`, WASI `39694266236` | Both native jobs pass; twelve comparison binaries and 24 cleanup controls inspected. WASI jobs still run. |
| Repeat identical word-frequency binaries | runner `4ce989e5ffb9` / `39695137827` | Both jobs pass; repeated ARC improvements and eight independently checked stack-estimate binaries with identical code bytes. |

Full logs for completed jobs are audited. Each source has an immutable
`roadmap/revision-*` tag, recorded in its publication receipt. Auditors and receipts:

- `/private/tmp/fwp-application-acceptance.json` and `fwp-ad-application-acceptance.json`.
- `/private/tmp/fwp-owned-text-publication.json`, `fwp-audit-owned-text.py` and
  `fwp-owned-text-acceptance.json`.
- `/private/tmp/fwp-wordfreq-repeat-publication.json`, `fwp-audit-wordfreq-repeat.py`
  and `fwp-wordfreq-repeat-acceptance.json`.

Raw artifacts and independent inspections are in `/private/tmp/fwp-application-evidence/74263bccf8e2`,
`fwp-ad-application-evidence/4815e3d16c34`, `fwp-owned-text-evidence/67b684506bb4`
and `fwp-wordfreq-repeat-evidence/4ce989e5ffb9`. Do not rerun completed inspectors.

The text candidate consumes the source owner for lower/upper/trim/replace. An
unchanged result receives that owner; a changed result copies before releasing
it. Aliases keep their bytes; trap and cancellation controls require cleanup.
No in-place mutation or new syntax is introduced. Six primitive contracts have
explicit frozen-inventory migrations. Native schedules and WASI cover the cases.

The large word-frequency input removes 148,546 of 397,353 requests, with unchanged
138,250 retains and lower managed peak. Paired ARC medians improve about 17–18%
on both Linux hosts and repeat similarly, but still take roughly 2.6–2.8× C time.
The peers combine normalization in one pass, so this is not an isolated compiler
overhead. Code sections shrink. Main-worker stack frames grow 16 bytes and
lowercasing gains a 48/64-byte separate frame; do not claim every cost decreases.

The latest extra fixture covers pattern/source, replacement/source and all-three
aliases. Four raw-interpreter cases pass with a prior compiler after fixing an
incorrect data-last `apply` order. **Current native/WASI acceptance of these new
cases is pending.** The focused workflow reuses one release build per Linux host
for native ownership and synchronous WASI checks; it does not rerun benchmarks.
Final delivery still requires all nine production jobs and docs.

## Local checks and limits

All checks use the primary `python3 scripts/local-guard.py python3 SCRIPT`.
Completed: formatting, workflows, primitive inventory, eleven runner tests,
documentation links; nine C/Rust/interpreter word-frequency controls; four small
paired descent controls; binary/code-section inspections; four added alias cases.
`fwp-probe-owned-text.py` also passes twelve small macOS ARM64 C controls. It
combines saved generated C with current helpers and an explicit owner boundary,
so it does not verify the new Rust compiler. Its missing cancellation declaration
and scheduler-baseline harness errors were fixed before publication.

Full builds, suites and benchmarks stay on runners. Preserve 64 GiB free disk,
generated target below 2 GiB, sampled aggregate RSS below 1 GiB and the guard's
180-second deadline. Latest disk observation was about 65 GiB free. Stop on limits;
do not raise or bypass them. Every commit is one line ≤80 characters, no body,
trailers or attribution. Never merge a skipped or partially passing gate.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and prove remaining ownership boundaries. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate CPU numerical kernels; #191 removes runtime compilation. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
