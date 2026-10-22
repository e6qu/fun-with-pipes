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

The initial source `0ca3fba4f718fb02afbcc385ac41e763a8320361`, native run
`39716002463`, passes Linux AMD64/ARM64 and Intel macOS. Independent inspection
verifies 21 images per host (63 total), exact outputs and cleanup controls.
ARM macOS finishes all seven targets; only the corpus fails because OpenSSL
headers are missing. The explicit macOS setup in 003c7e84685d repairs that
configuration; verify it in the new run. Retain those baseline results; do not repeat
completed inspection. Evidence: `/private/tmp/fwp-pointer-evidence/0ca3fba4f718/`;
publication/audit: `fwp-pointer-publication.json`, `fwp-audit-pointer.py` in
`/private/tmp`.

Both initial Windows jobs finished all seven targets and found missing `.exe`
suffixes in artifact copying. Repair `2eaccbc77c42` then exposed omitted OpenSSL
setup in the focused corpus job. All six other targets passed. Preparation
`003c7e84685d711e676ec51a5509225c2e94be17` adds production TLS setup and aggregates
corpus native-build errors. Windows runs `39718444232`/`39718446980` now both pass,
with all logs audited. Receipt: `/private/tmp/fwp-pointer-repair-acceptance.json`.
The same explicit macOS setup repairs ARM macOS's missing OpenSSL headers.

Preparation `e3ddc84eddaf14163ab7d27f4044d29f81cc22d9`, run `39719795583`, repairs
three implementation bugs: leaked interpreter C strings, eight-byte pointer-sized
storage on 32-bit targets, and allocation counts narrowed before validation.
The actual 32-bit interpreter and generated WASI job passes with audited logs;
all six native hosts finish all seven targets with only the new C-string fixture
failing: its entry functions lacked explicit export declarations, so no
allocation assertion ran. Every completed job and test target has been audited.
The fixture now exports
all four probes; a local C-header emission check verifies their actual interfaces.
Publication/audit helpers are
`/private/tmp/fwp-pointer-boundary-publication.json` and
`/private/tmp/fwp-audit-pointer-boundaries.py`. These compiler changes invalidate
any claim that earlier program source is unchanged.

String copies now belong to the receiving foreign call, including callback
results and nested calls; returned strings copy before those owners drop.
Argument conversion and callback errors also drop the copies. Allocation and
string-terminator bounds are explicit; nonpositive counts still allocate one byte.
Checks count real C-string allocations/releases. Actual 32-bit execution checks
signed values, adjacent bytes, offsets and bounds at O0/O2, with a missing-bound
negative control. Earlier results are baselines, not acceptance of later changes.

The full width review then reproduced another existing bug: writing/reading
1267650600228229401496703205377 through Ptr[I128] returned 1. I128/U128 raw access
used the 64-bit conversion, losing upper bits; native generation also mistook
boxed values for scalar words. The local repair uses 16-byte cells and explicit
boxing/unboxing. It does not extend the foreign C by-value ABI. New native and
WASI fixtures use adjacent unaligned signed/unsigned cells, extremes, guard
bytes and physical ARC cleanup checks. The complete run found no other failures. Publish the wide repair together with
the export-fixture fix, then validate the complete new source.
No second PR is open.

Guarded checks passed: `fwp-check-pointer-boundary-fixes.py` (6.71s: fixture
semantics, allocator observer with intentional retention/recovery, format,
workflow/docs); `fwp-check-pointer-final-preparation.py` (12.00s: generated
library docs, 11 native-runner checks, 392 primitive contracts); and
`fwp-check-wide-pointer-preparation.py` (6.80s: exact old-bug reproduction,
new fixture syntax, format, workflow/docs). Scripts live in `/private/tmp`.
The expanded width fixture and docs pass again in 6.69s. The repaired export
fixture, actual emitted C header and allocator observer pass in 6.63s. Changed
Rust execution requires CI. Publish with `/private/tmp/fwp-publish-wide-pointer-repair.py`
only after `/private/tmp/fwp-audit-pointer-boundaries.py` has audited all seven
completed jobs. The helper checks that every native failure is the known fixture
error, archives the old receipts, publishes one repair and starts all seven jobs.

A separate 64-word/eight-word-vocabulary generated-C probe identifies the next
list optimization candidate. Moving unique list elements into `map` removes
64 of 194 retains and lowers managed peak from 7,744 to 5,376 bytes. Reusing
changed-case strings and same-typed list nodes reduces requests from 296 to 209.
All variants match the independent word oracle and end with zero charged storage.
This is **not implemented compiler code** and is not a timing claim. It assumes
unique nodes; a real change must preserve aliases, failure/cancellation cleanup
and observable resource lifetimes. Start with eligible string lists, not resource
payloads. A tracing collector can age a node during its callback; checking uniqueness
before that callback does not permit a later old-to-young field write. Start
with element moves and freshly allocated mutable result nodes, or prove every
mutation separately. No map compiler implementation has been added.
Reproduction: `/private/tmp/fwp-probe-map-moves.py`; receipt:
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

Completed task-record evidence was losslessly archived to protect disk space:
`/private/tmp/fwp-task-record-evidence/c10934f5dadf/completed-native-evidence.zip`.
Its adjacent receipt verifies all 1,348 files byte-for-byte; extracted duplicates
were removed, saving 245,634,872 bytes. No source or current evidence was removed.
Guarded archival passed in 4.63s; free disk afterward was 64.98 GiB.

Completed task-await evidence is also archived losslessly at
`/private/tmp/fwp-task-await-evidence/f2b5d400feda/completed-native-evidence.zip`.
The receipt verifies all 1,466 files; extracted duplicates were removed, saving
137,986,136 bytes. Guarded archival passed in 3.81s, with 65.23 GiB free afterward.
