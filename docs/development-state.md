# Session handoff

## Current delivery and next action

[PR #192](https://github.com/e6qu/fun-with-pipes/pull/192) groups unchanged-string
ownership, 32-bit bounds repairs, application comparisons and repeated file
cleanup. All seven [plan](../PLAN.md) areas remain open. Removing tracing GC and
reducing ARC remain the primary design goals; JIT compilation is excluded.

The combined repair is integrated in `application-ownership` at
`/private/tmp/fwp-application-ownership`, based on published head
`71bde4502267a033221446a52b7bc0b5d08d4753`. Reports and the shorter handoff are ready.
Next: run the final documentation/diff checks, then publish with
`/private/tmp/fwp-publish-192-repair.py` through the local guard. The script updates
the same PR and records its new production/documentation run IDs. No second PR
is open. Do not reuse the old merge helper.

After publication, audit every final-head job with
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

The compiler inventory covers 85 top-level execution examples: 80 emit C in
both memory modes, three are intentional compile errors, and two reject ARC.
`ffi.fwp` uses manually managed C pointers and needs an admitted lifetime policy.
`ad_task_reuse.fwp` deliberately passes expired derivative values between tasks;
its earlier rejection is correct and must remain. C emission alone does not
verify execution or cleanup. Extend native ARC execution coverage as the foreign
boundary is implemented; preserve explicit `Unsafe` obligations and the existing
rule that callbacks may run only on the calling task during the foreign call.

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
