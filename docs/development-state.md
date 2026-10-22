# Session handoff

## Current delivery

Main is `3003e2cdebf6e98f45b06b4f523d8dd21d8150c5`, the verified squash merge of
[PR #192](https://github.com/e6qu/fun-with-pipes/pull/192). Its nine production
jobs and documentation passed. The redundant same-tree push run was cancelled;
post-merge documentation passed. [History](roadmap-history.md) records delivery.

[PR #193](https://github.com/e6qu/fun-with-pipes/pull/193) is open at
`91502f538d2265f3f7afd8606760dfcc4a088005` in branch `manual-pointer-ownership`,
worktree `/private/tmp/fwp-manual-pointer-delivery`. It groups manual C pointers
without tracing, interpreter C-string cleanup, checked 32-bit allocation bounds,
pointer-sized storage and complete I128/U128 raw access. Its
[report](measurements/manual-pointers.md) records the lifetime obligations and
accepted six-host/32-bit preparation evidence.

Production run `39725180238`: benchmark, both Apple ARM64 jobs and regular Intel
macOS pass; five native jobs remain in progress without a reported failed step. Documentation run
`39725180233` passes. Keep this tested head unchanged. Next: audit all remaining
jobs with `/private/tmp/fwp-audit-193-final.py`; only after its receipt accepts all
nine production jobs plus docs, run `/private/tmp/fwp-merge-193.py`. That helper
requires the exact head, an explicit one-line subject under 80 characters and
an empty body, then verifies the merge message, parent and identical files.
Publication and merge are authorized; do not ask again or open a duplicate PR.

## Next batch: string ownership and safe reuse

Branch `string-map-ownership`, worktree `/private/tmp/fwp-pointer-ownership`, is
based on PR #193's tested head. It consumes unique strings through known list-map
callbacks and reuses private storage for changed ASCII case conversion. Shared
list/tail/string aliases keep their values. Output list nodes remain fresh because
callbacks can collect. No public syntax or primitive is added.

Source `12ce47ad00f28bdc32235c31e04204a7526a0f8f` passes all six focused jobs in
run `39727552658`; full logs are audited. Independent inspection covers 192 native
images and 180 interpreter/native comparisons. Paired word-frequency run
`39728410578` also passes on Linux ARM64/AMD64; inspection covers another 48 native
images and 24 WASI modules. The [report](measurements/string-map-ownership.md)
and [complete data](measurements/string-map-2026-10-22.json) retain inputs,
samples, toolchains, memory, actual binaries and remaining C/Rust gaps.

For 65,536 words, requests fall 248,807 → 226,961, retains 138,250 → 72,714 and
peak managed charge 7,794,440 → 5,465,713 bytes. ARC medians improve 6.8–7.0%
against previous fwp C output recompiled in the same session, but remain 2.61–3.03× C and
2.02–2.11× Rust. The small AMD64 tracing case is 3.0% slower than its baseline.
The report preserves that result and distinguishes observed timings from promises.

The accepted repair fixes two real gaps discovered during review:

- Both large-object age checks used the small-object bitmap. Large immutable
  allocations have a separate age mark; treating old storage as young could hide
  new child references from minor collection. Tests collect actual small/large,
  immutable/mutable objects and include two deliberately broken controls.
- Five older reuse tests returned without executing on Windows; golden reuse
  ignored native compilation failures. These now execute on Windows, verify
  intentional front-end errors and aggregate unexpected build failures. Native
  golden tests also fail on missing compilers. Focused CI includes negative
  compiler controls; production Windows includes reuse and string-map checks.

The 12ce measurements do not validate these later repairs. The combined repair is published at `15ee3615d2df858f508ec459e6305fa163037917`,
run `39730741666`. All six jobs pass and complete logs are audited: 19 test
functions per host across seven targets, plus 176 Linux AMD64 unit tests. All six
reuse tests execute on Windows; both missing-compiler controls fail as required.
Inspection covers 228 native images and 180 interpreter/native comparisons.
Paired benchmark run `39731820120` is in progress at the repaired source; its
results still require full-log and artifact inspection. Then
integrate the accepted batch onto #193's verified merge, refresh the handoff and
run the full production/documentation gates in one substantial PR. Keep one
active delivery PR. All failures are tasks to fix, not reasons to stop the plan.

The new WASI test extends the same five map inputs to the WebAssembly backend,
including aliases, dynamic callbacks, caught errors and a physical-free negative
control at O0/O2. This is test/documentation-only work: compiler and runtime files
remain identical to accepted native source 15ee. Its source, run and gate receipt
will be recorded separately at `/private/tmp/fwp-string-map-wasi-publication.json`
and `/private/tmp/fwp-string-map-wasi-acceptance.json`. Require executed WASI
modules and inspection before integrating the delivery. The local fixture check
matches all five accepted reference outputs (`fwp-check-string-map-wasi-preparation.py`,
3.00s); it does not establish WASI execution.

## Evidence and local checks

Use the primary checkout for guarded checks:
`python3 scripts/local-guard.py python3 SCRIPT`.
Keep work serial, at least 64 GiB free disk, target data below 2 GiB, sampled RSS
below 1 GiB and the 180-second deadline. Full suites/builds/benchmarks run on
GitHub. Do not raise limits or use the separate fun-refactor guard.

- `/private/tmp/fwp-check-reuse-age.py` passes in 3.31s: current runtime functions
  in saved generated C, O0/O2, verify 0/1; protected exit 0, missing large-unique
  age exit 239, missing large-young age exit 238. Native artifacts remain under
  `/private/tmp/fwp-reuse-age-evidence/`. This is not a new compiler build.
- Six-host map inspection receipts and archives:
  `/private/tmp/fwp-string-map-evidence/12ce47ad00f2/`.
- Paired comparison artifacts and inspection:
  `/private/tmp/fwp-string-map-comparison-evidence/12ce47ad00f2/`.
  Guarded inspection passed in 25.00s. Do not repeat completed downloads.
- Preparation publication/audit: `/private/tmp/fwp-string-map-{publication,acceptance}.json`;
  comparison: `/private/tmp/fwp-string-map-comparison-{publication,acceptance}.json`.
  Their audit scripts have the same `fwp-audit-string-map` names.
- The first map source failed because its helper preceded `FWP_K`; all six failed
  logs were audited, declaration order was repaired and 12ce passed. Archived
  receipts carry suffix `972d0fda9a25`; this failure is resolved.

A private non-expanding replacement prototype now requires the result to fit
the same allocator size class; large allocations require equal byte size. The
64-word diagnostic keeps its allocation savings (274 → 248 requests versus map
plus case reuse) without extra charge. O0/O2 controls cover shared aliases, UTF-8,
overlapping matches and large-to-small results; removing the size restriction
fails. It is still private saved-C work, not repository code or native-platform
acceptance. Scripts: `/private/tmp/fwp-probe-bounded-replacement.py` (2.47s) and
`/private/tmp/fwp-check-bounded-replacement.py` (1.83s).

The primary checkout is detached at #192 with this live handoff as its only edit.
The preparation is clean at `15ee3615d2df858f508ec459e6305fa163037917`; the delivery workspace stays
clean at its tested head. Old pointer preparation documents were preserved at
`/private/tmp/fwp-pointer-preparation-local-docs/` before reusing that worktree. After #193 merges,
`/private/tmp/fwp-after-merge-193.py` preserves this handoff and cancels only
redundant same-tree push CI. `/private/tmp/fwp-prepare-string-map-delivery.py`
requires the verified merge, accepted repaired measurements and all inspection
receipts before replaying the three map/reuse commits onto the merge. These
helpers are prepared, not yet executed.
Completed large evidence archives remain byte-verified under the task-record
`c10934f5dadf` and task-await `f2b5d400feda` evidence directories in `/private/tmp`.

## Roadmap status

| Step | Status | Area |
|---|---|---|
| 1 | In progress | Remove tracing; limit ARC. |
| 2 | In progress | Remove avoidable functional costs. |
| 3 | In progress | Meet measured machine-level budgets. |
| 4 | In progress | Improve autodiff time, memory and precision. |
| 5 | In progress | Validate CPU numerical kernels. |
| 6 | In progress | Establish comparable measurements and budgets. |
| 7 | In progress | Complete the finite application suite. |

All seven [plan](../PLAN.md) areas remain open. A merged PR does not finish these
goals. JIT is excluded. Continue in substantial related batches, retaining current
checks and unresolved failures in this one handoff and the
[application suite](application-acceptance.md).
