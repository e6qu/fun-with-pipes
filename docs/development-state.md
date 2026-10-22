# Session handoff

## Current delivery and next action

[PR #192](https://github.com/e6qu/fun-with-pipes/pull/192) groups unchanged-string
ownership, 32-bit bounds repairs, application comparisons and repeated file
cleanup. All seven [plan](../PLAN.md) areas remain open. Removing tracing GC and
reducing ARC remain the primary design goals; JIT compilation is excluded.

The combined repair is published at `36998a99f689b254edfc127bbbc8e8aac054c509`
on `application-ownership` (`/private/tmp/fwp-application-ownership`). Production
run `39714665578` is running its eight platform jobs; its benchmark job and
documentation `39714665552` pass with audited logs. The PR description
covers the combined scope and names the comparisons. Keep this head stable while
its gates run; no second PR is open. Next: audit final-head CI, fix every failure,
and prepare the next ownership group independently. Do not reuse the old merge
helper. Publication receipt:
`/private/tmp/fwp-application-delivery-publication.json`.

Audit every final-head job with
`/private/tmp/fwp-audit-192-final.py`. Fix all discovered failures together.
Only after all nine production jobs and documentation pass, run
`/private/tmp/fwp-merge-192-repaired.py`. It supplies a one-line subject of at most
80 characters and an empty body, checks the exact head, and verifies the squash
message, parent and identical tree. Then synchronize main, cancel redundant
same-tree push CI while preserving documentation checks, and continue the next
substantial roadmap group. Publication and merge are already authorized.

## Evidence already completed

- The original PR head `71bde450` finished all nine production jobs and docs
  (`39701165415`, `39701165422`). Complete logs show only two failures: the same
  Windows diagnostic-newline assertion. The repair compares diagnostic lines;
  program/interpreter byte comparisons stay exact.
- The text/bounds preparation `54b01db94079e692cddf8ec3fc56ee064c7bbbf1`, run
  `39699466703`, passes both Linux jobs. Native, actual 32-bit interpreter and
  generated WASI checks pass; 48 native binaries and 24 WASI modules are inspected.
  Current compiler/runtime/library code still matches this measured source.
- File execution preparation `c8e8199294a89bd96d67c86c892861c60e6971af`, run
  `39711302083`, passes all six native hosts. The Windows permission check uses
  PowerShell; Git Bash enables privileges that can bypass ACLs. Working-set
  sampling now calls Win32 directly instead of launching PowerShell per sample.
- Report preparation `bc302ea343a2da1571d475c215fda1aeeebdd810`, run
  `39713618145`, passes all six report jobs. It fixes implicit Windows decoding
  of UTF-8 CSV output. Original native output was correct. Reports regenerate
  from retained artifacts with original execution metadata and verified unchanged
  C/binary hashes; no programs are rebuilt or rerun for this report-only repair.
- Independent inspection covers 180 file-application binaries and 96 memory
  series. All 18,432 round checkpoints show baseline managed storage and zero
  tracked handles/scratch buffers; deliberately broken cleanup is detected.
  All 864 RSS samples remain recorded, including increases. Managed storage is
  not whole-process memory, and these are not speed comparisons.

The readable reports are `docs/measurements/unchanged-text.md`,
`ad-application.md` and `file-applications.md`, with their linked JSON evidence.
The word-frequency improvement removes 148,546 allocation requests on the large
input; current ARC medians still take 2.78–3.37 times C's time and 2.14–2.34 times
Rust's. The peers combine normalization into one pass, so these are whole-program
comparisons. File cleanup tests make no C/Rust speed claim.

Do not repeat completed downloads or binary inspection. Accepted artifacts are
under `/private/tmp/fwp-count-verification-evidence/54b01db94079` and
`/private/tmp/fwp-file-application-evidence/c8e8199294a8`; the latter's
`inspection.json` records original execution and report-generation sources.
Receipts are `/private/tmp/fwp-count-verification-acceptance.json`,
`/private/tmp/fwp-file-application-acceptance.json`,
`/private/tmp/fwp-file-report-acceptance.json` and
`/private/tmp/fwp-file-integration.json`.

## Next ownership and optimization work

The next group is on `pointer-ownership` in
`/private/tmp/fwp-pointer-ownership`, based on the final #192 head. It admits
manual raw addresses without counting/freeing pointees, including nullable
pointers, scoped callbacks and C exports. It preserves explicit Unsafe/caller
obligations; borrowed managed storage cannot escape as a raw address. The C
example now copies into a raw buffer before strchr and frees it after copying
its result. This is candidate code, not accepted native support.

The existing `arc_corpus` already executes admitted examples and checks final
managed storage; extend it rather than duplicate it. The 85-program inventory
had 80 admitted examples, three intentional compile errors and two ARC-only
rejections. The pointer change should admit ffi. `ad_task_reuse` deliberately
passes expired derivative values between tasks; its early rejection stays.
Tests now cover raw buffer releases separately from managed charges, nullable
callback values through reentry/failure/suspension/cancellation, and static/shared
library pointer aliases with independent owned strings. No pointee-lifetime proof
or automatic raw-buffer cleanup is claimed.

Focused commands passed through the local guard:
`python3 /private/tmp/fwp-check-pointer-fixtures.py` (2.75s: saved-compiler raw
interpretation, exact ffi golden, pointer tutorial and callback/library fixtures)
and `python3 /private/tmp/fwp-check-pointer-preflight.py` (17.30s: actionlint,
docs, native coverage/failure propagation, all 392 primitive declarations against
the frozen inventory, tutorial source copies, diff checks). Initial edit syntax
and callback application errors were corrected before these passes. Compiler
changes still require the new six-host `pointer-ownership` evidence suite and
final production gates. No additional PR is open; next publish this preparation,
audit every native result, and inspect retained binaries before delivery.

A separate 64-word/eight-word-vocabulary generated-C probe identifies the next
list optimization candidate. Moving unique list elements into `map` removes
64 of 194 retains and lowers managed peak from 7,744 to 5,376 bytes. Reusing
changed-case strings and same-typed list nodes reduces requests from 296 to 209.
All variants match the independent word oracle and end with zero charged storage.
This is **not implemented compiler code** and is not a timing claim. It assumes
unique nodes; a real change must preserve aliases, failure/cancellation cleanup
and observable resource lifetimes. Start with eligible string lists, not resource
payloads. Reproduction: `/private/tmp/fwp-probe-map-moves.py`; receipt:
`/private/tmp/fwp-map-moves-small-probe.json`. Case reuse alone saved nothing
because borrowed map inputs kept a second owner.

## Roadmap status

| Step | Status | Area |
|---|---|---|
| 1 | In progress | Remove tracing; limit ARC. |
| 2 | In progress | Remove avoidable functional costs. |
| 3 | In progress | Improve measured machine-level performance. |
| 4 | In progress | Improve autodiff time, memory and precision. |
| 5 | In progress | Validate CPU numerical kernels. |
| 6 | In progress | Establish comparable measurements and budgets. |
| 7 | In progress | Complete the finite application suite. |

## Worktrees and local checks

Primary `/Users/zardoz/projects/fun-with-pipes` remains detached at verified #191
merge `19f3afbcbed22802a96f092d9d0ee3d7913335e3`, with only this handoff dirty.
The file preparation worktree `/private/tmp/fwp-file-application-lifetimes`
preserves `bc302ea343a2`; `/private/tmp/fwp-application-baselines` preserves
`54b01db94079`. They are evidence, not additional delivery PRs. #191 is completed;
its full acceptance and merge are in `docs/roadmap-history.md`.

Run focused checks serially from the primary checkout with
`python3 scripts/local-guard.py python3 SCRIPT`. Full builds/tests/benchmarks stay
on GitHub. Preserve 64 GiB free disk, target below 2 GiB, workload RSS below 1 GiB
and the 180-second deadline; do not raise limits. Latest focused checks passed:
file observers with the saved prior compiler; permission restoration; Windows
counter type/layout checks; UTF-8 corruption reproduction; workflow/format/docs
checks; and independent artifact inspection. Native Win32 calls are verified by
both Windows CI jobs, not by the local type check. Temporary helper scripts and
receipts above preserve exact commands and results.
