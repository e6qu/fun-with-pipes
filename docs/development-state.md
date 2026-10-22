# Session handoff

## Next action

Next: complete publication and final validation of branch `application-ownership`.
It is the next single substantial PR after accepted #191; do not open another
active delivery alongside it. Use `gh pr view application-ownership` and the
publication receipt for its PR number and final head. Audit all nine production
jobs and documentation for that exact head, fix every failure, then squash-merge
with one line ≤80 characters and an explicitly empty body. Continue the seven
plan areas afterward; none is complete.

The integrated code is byte-identical to preparation
`54b01db94079e692cddf8ec3fc56ee064c7bbbf1` outside documentation/PLAN.md. Its
combined run `39699466703` passes both Linux hosts: native ownership/count checks,
actual 32-bit Rust interpreter tests, generated WASI and paired C/Rust measurements.
All full logs are audited in `/private/tmp/fwp-count-verification-acceptance.json`.
Independent inspection covers twelve comparison binaries, 36 native ownership/
size controls and 24 WASI modules. The committed report is
`docs/measurements/unchanged-text-bounds-2026-10-22.json`. Do not rerun inspections.

The delivery includes unchanged-string owner transfer, large-count/index/size
repairs, explicit application acceptance, C/Rust and descent measurements, the
current-weights tutorial, and documentation recording #191 acceptance. Local
preflight/publication remain; `/private/tmp/fwp-application-pr-body.md` is the
reviewable PR description. Final platform acceptance is still required.

## Worktrees and accepted delivery

- Primary `/Users/zardoz/projects/fun-with-pipes` is detached at verified #191 merge
  `19f3afbcbed22802a96f092d9d0ee3d7913335e3`; only this handoff is dirty.
- Delivery: `application-ownership`, `/private/tmp/fwp-application-ownership`,
  based on #191 merge. `/private/tmp/fwp-application-integration.json` records
  the accepted source and patch. Publication receipt will be
  `/private/tmp/fwp-application-delivery-publication.json`.
- Preparation: `application-baselines`, `/private/tmp/fwp-application-baselines`,
  published at `54b01db94079e692cddf8ec3fc56ee064c7bbbf1` with immutable tag
  `roadmap/revision-count-verification-54b01db94079`. Its staged documentation
  was copied into the delivery. Preserve this source and the older evidence tags.
- `/private/tmp/fwp-task-results-cpu` and the older await/CPU worktrees preserve
  preparation evidence. Do not repeat their work or push handoff-only changes.

#191 passed all nine production jobs (`39688998592`), docs (`39688998567`) and
focused GCC (`39688997806`) at `12be5afcee7c81f1b98ffed2081d698e1124b000`.
Every full log was audited. `/private/tmp/fwp-191-final-acceptance.json` verifies
merge `19f3afbcbed22802a96f092d9d0ee3d7913335e3`, its identical tree and one-line
message. Duplicate same-tree production run `39700306060` was cancelled;
post-merge docs `39700305849` still need a final audit.

The accepted change transfers direct task-result fields, repairs State/Jacobian
and raw C-buffer cleanup, enforces explicit CPU worker contracts, removes runtime
OpenCL compilation and prepares foreign bridges before effects. Await preparation
`f2b5d400` passed six native and two WASM jobs in `39678830873`; independent
inspection covers 204 native binaries and 64 await modules. It removes 34 requests/
544 requested bytes from one fixture with unchanged retains/peak storage.

#190 is already accepted and merged at `a2b9130f`; its receipt is
`/private/tmp/fwp-190-final-acceptance.json`. Do not repeat that delivery.

## Application preparation and evidence

The next group defines a finite six-family application suite and measures
word frequencies, gradient descent and unchanged-string ownership. Its reports
are in `/private/tmp/fwp-application-baselines/docs/measurements/`; the acceptance
suite is `docs/application-acceptance.md`. No work area is complete.

| Preparation | Source / run | Actual result |
|---|---|---|
| Word-frequency C/Rust baseline | `74263bccf8e2` / `39690307737` | Both Linux jobs pass; eight binaries inspected. Larger ARC case takes 3.29–3.52× C and 2.45–2.54× Rust time. |
| Descent history versus current weights | `4815e3d16c34` / `39692176065` | Both Linux jobs pass; 24 binaries inspected. At 129 coordinates, managed peak falls 845,424 → 26,288 bytes, with modest/mixed timings. Raw tape buffers are outside the counters. |
| Unchanged string owners | `67b684506bb4` / native `39694262883`, WASI `39694266236` | Both native jobs pass; twelve comparison binaries and 24 cleanup controls inspected. Both full WASI jobs also pass; latest expanded-alias artifacts inspected separately. |
| Additional source aliases | `a9a6ba203ec1` / `39696094960` | Both focused native/WASI jobs pass with audited logs; four WASM modules and 24 native controls independently inspected. |
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

The extra fixture covers pattern/source, replacement/source and all-three
aliases. Both Linux jobs pass native ownership and synchronous WASI checks.
Receipts: `/private/tmp/fwp-text-alias-acceptance.json` and
`/private/tmp/fwp-owned-text-acceptance.json` are accepted. Inspection is saved in `/private/tmp/fwp-text-alias-evidence/a9a6ba203ec1/inspection.json`;
do not repeat completed alias, native baseline, AD or stack inspections. Final delivery requires all nine production jobs and docs.

Bounds preparation `32c09d46ad3e` exposed three harness/setup failures in
`39698466155` and `39698469582`: a size probe used an unrelated C struct (strict
aliasing UB), the Rust WASM build selected GCC, and a trap test expected 1 instead
of 101. All complete logs are in `/private/tmp/fwp-count-repair-acceptance.json`.
Source `54b01db94079` fixes all three, saves size-probe binaries, and combines the
checks in one `wordfreq` job per host. Independent checks continue after failures.
Publication and acceptance receipts use `/private/tmp/fwp-count-verification-*`.

The tutorial now performs 199 descent updates while keeping only current weights;
its first three outputs match raw/optimized prior interpretation. Bounds changes
preserve full-width indices/counts, bound slice and string-size arithmetic, avoid
empty repetition loops and validate SIMD lane storage before narrowing. F128
lanes require sixteen bytes. Earlier string timings describe `67b684506bb4`;
fresh runtime measurements at `54b01db94079` now pass and reproduce the same
allocation/retain counts. The large ARC case improves about 10–17% against the
paired original baseline, while still taking 2.78–3.37× C and 2.14–2.34× Rust time.
The small AMD64 RSS sample grows 131,072 bytes; whole ARC files grow 40/32 bytes
on AMD64/ARM64 even though code sections shrink. Retain those tradeoffs.

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
