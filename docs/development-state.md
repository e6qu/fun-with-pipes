# Current work

**Next:** finish the unpublished G5 collector deletion after repairing and
verifying [PR #216](https://github.com/e6qu/fun-with-pipes/pull/216).
Only #216 is an active public PR. Its worktree is
`/private/tmp/fwp-ownership-fault-matrix`, branch `remove-tracing-runtime`.
Use that worktree's handoff for current CI failures and checks. This file owns
only the unpublished collector-deletion work; do not duplicate changing PR status.

This separate worktree is `/private/tmp/fwp-delete-tracing`, branch
`delete-tracing-collector`, based on #216 head
`0db38df8bd0b3ea6f4dc1165edd985bc82c71ccb`. Rebase onto verified merged
#216 before publication. The primary checkout remains detached at #209; preserve
its handoff and untracked compiler-abort report.

## Incomplete deletion work — not buildable or verified

- Selected counted branches in runtime C with `/usr/bin/unifdef`; preserved native
  allocator, library cleanup and scheduler tasks. The integrated compiler has not been built or tested.
- Replaced `runtime/fwp_rt_gc.c` with `fwp_rt_heap.c`: removed root scanning,
  marking/sweeping, collector options/state/retries and uncounted sharing traversal.
  `fwp_heap` now tracks physical live/peak slot bytes, cumulative allocation/release
  bytes and heap extent. Allocation reporting uses `FWP_ALLOC_STATS`.
- Renamed allocator symbols to `fwp_heap_*`, classes to `HEAP_*`, platform selection
  to `FWP_NATIVE_HEAP`, task registry to `fwp_tasks_active`/`all_next`/`all_prev`.
  Registry still owns cancellation/shutdown traversal; finalizers still release
  external resources before library unmapping. Removed runtime root-fence calls.
- Added null checks before subtracting initially empty bump/end pointers. Review
  zero-size allocation, first charge, small/big release and allocation-report
  precision/overhead before accepting the new accounting.
- Removed the native mode selector/CLI, FWP_ARC_ONLY emission and generated
  root-fence bookkeeping. Rust formatting/parsing passed after repairing a help
  string terminator. Removed the `FWP_FREE`/`FWP_REUSE` compiler switches and selected counted
  lowering/drop generation unconditionally. Removed the always-true `Gen.reuse` flag, selected 31 counted branches, and
  deleted unreachable uncounted higher-order helper implementations. Rust parsing
  and formatting pass; integrated compiler/Clippy checks are still pending. The runtime `FWP_NO_REUSE` copy control
  remains distinct and keeps reference counts.
- Reworked native allocator tests to preserve explicit release, first charge,
  page reuse, wide counts, library-unload cleanup and static-heap exhaustion.
  The small isolated C probes passed on Apple Clang 17 ARM64 at O1/O2, including
  a deliberately omitted-free failure (27). Guard command:
  `python3 scripts/local-guard.py python3 /private/tmp/fwp-check-counted-allocator.py`.
  Static-heap probes also passed slots/pages/exhaustion at O1/O2 via
  `/private/tmp/fwp-check-static-allocator.py`. These checks do not verify Rust
  compilation, generated programs, GCC or other hosts.
- Updated native ledger hooks to the new allocator signatures. Removed obsolete
  `NativeOptions.arc` setup from 44 tests and one internal HTTP/2 test. Renamed
  allocator symbols in 298 active source/test/script files; historical datasets
  are unchanged. Task-only unowned spawn paths are removed; the scheduler keeps
  explicit unique/shared ownership, with a trap for a missing owned callback.
- Migrated the 150 old accounting consumers to direct `fwp_heap.live` values.
  The old accumulated budget represented net charge, so those expressions must
  become live bytes, not the new cumulative allocation count. Leak comparisons
  reverse the old remaining-budget inequality. This migration is not executed.
- Removed literal `--gc arc/tracing` argument pairs from 120 active test/script
  files. Variable-mode loops and obsolete-option error tests still need review.
  Retired `old_reclamation` and its workflow/shard entries using the deletion
  table; independent task, typed-child and allocation-balance controls remain.
  Removed unreachable runtime poison-copy branches. Guarded formatting and
  native schedule audit pass with 253 integration targets. The temporary helper
  first failed because it tried formatting a deleted file; it now filters those.
- Added the strict six-field byte/RSS report parser in
  `tests/support/allocation_report.rs` and its regression in `native_allocator`.
  The guarded standalone extraction passed valid LF/CRLF records and rejects
  missing/duplicate fields, wrong units, negative/fractional/out-of-range values.
  Its first compile caught an unintended moved expected value in the test; the
  assertion now borrows it. Command:
  `python3 scripts/local-guard.py python3 /private/tmp/fwp-check-allocation-report.py`.
  This verifies parsing, not end-to-end generated reporting or consumer migration.
- Migrated 27 allocation/release report consumers to the strict byte parser.
  Text and leaf release tests now deliberately omit physical frees in otherwise
  identical generated C, replacing removed free-disabled compiler switches.
  Existing MiB thresholds use explicit division by 1,048,576, preserving their
  budgets. Removed their vacuous zero-collection assertions. The old free-disabled
  comparisons and poison controls still need replacement, so these tests are not
  claimed working yet. The actual allocator's report probe passes Clang 17 ARM64 O1/O2: cumulative
  100,032 bytes, live 100,000 then zero, peak 100,032, extent 196,608.
  Command: `python3 scripts/local-guard.py python3 /private/tmp/fwp-check-report-runtime.py`.
  The integrated test additionally parses the records, checks process RSS and
  runs on native CI. Generated-program reporting is not yet runner-verified.
- Updated 41 allocator-hook declarations and matching arguments/predicates from
  the old parameter name to `kind`; values still distinguish initialization,
  byte storage and mutable storage. Generated hook bodies still need execution.
  Migrated list, array and construction observers to the single physical-free
  path, and updated gRPC cache/HTTP omission hooks to the new counted release
  bodies. Their fault probes still require integrated runner execution.
- Migrated long-loop and HTTP/REST/gRPC memory tests to the single counted
  runtime, preserving 64 MiB process RSS, 16 MiB HTTP/REST growth and 8 MiB gRPC
  growth limits. Removed the intentionally unowned tracing comparison and
  duplicate gRPC mode. Carried #216's bounded-startup/log-drain repair forward.
  The first standalone compile found the startup-only helper's unused shutdown
  function; the narrow allow from #216 is now included. The migrated harness
  then compiled with warnings denied and passed all three helper tests under
  `python3 scripts/local-guard.py python3 /private/tmp/fwp-check-memory-startup.py`. Corpus/diagnostic names
  still need coordinated workflow renaming; runtime checks await integration.
- Updated ownership/reference/service guides, native tutorial commands and
  contributor allocator guidance for the removed mode selector. The ownership
  guide explicitly marks deletion verification pending. Historical measurements
  remain unchanged; benchmark/control docs and the remaining diagnostics inventory
  still need their coordinated final migration.
- Retired reuse collection-age/poison-only tests and their age fixture; ordinary
  aliases remain in the complete ledger-backed corpus and fault probes. Reuse's
  tree test keeps its >100 MiB release threshold and now deliberately omits
  physical frees in the negative control. The missing-compiler check targets the
  maintained corpus. Removed its obsolete late-poison environment mutation and
  collector fields; live-byte/ledger checks, all source cases, frontend errors
  and raw/native result comparisons remain. No integrated run is claimed yet.
- Replaced the static 1 MiB heap's collection requirement with counted release
  versus deliberately missing physical frees. Both controls force copies; the
  positive must keep its output and the negative must exhaust that same pool
  with status 102. The three-million-step normal ownership case remains too.
  This new integrated program control has not run yet.
- Migrated wide-count coverage: retired sweep/promotion cases, retained exact
  counts, overflow/OOM, real metadata-free fault, aliases and O1/O2 output checks.
  Added live interior-address count-slot mapping and fresh-count address reuse to
  the ledger-backed dynamic/static fixture. The ledger rejects count operations
  on interior pointers, so the mapping check uses the live owning address for
  updates. Integration is pending. Removed positive collector-status terms from
  84 files' combined assertions; live bytes, metadata and resource checks remain.
- Before the next broad selection of counted C test branches, automatic approval
  review rejected the command because uncommitted work could be lost. Save this
  local checkpoint first; generate candidate edits separately and review diffs.
  Nothing from that rejected command ran. A read-only trial established that
  `unifdef -t -DFWP_ARC_ONLY=1` handles raw C in Rust tests; normal C mode cannot
  parse Rust lifetimes. Mixed preprocessor conditions and escaped C strings still
  require explicit review. Do not apply a broad unchecked rewrite.
- Still required: retire collector-only controls/fields, migrate remaining report schemas,
  remove CLI mode arguments from callers,
  and update reports/workflow schedules together. Do not invent
  dummy collection counters or old-API aliases just to make tests compile.
  Tests still reference old allocator names/accounting, so this intermediate
  checkout must not be published as working code. Remove obsolete collector-only
  tests using the deletion table, retaining their independent ownership controls.
- Do not migrate historical measured datasets to new field names. New evidence
  needs its own source identity and explicit measurement schema.
- Edit scripts are `/private/tmp/fwp-delete-collector-core.py` and
  `/private/tmp/fwp-delete-collector-callers.py`,
  `/private/tmp/fwp-remove-memory-selector.py`,
  `/private/tmp/fwp-delete-root-fences.py`, and
  `/private/tmp/fwp-update-native-allocator-tests.py`,
  `/private/tmp/fwp-update-test-mode-selection.py`, and
  `/private/tmp/fwp-rename-active-allocator-symbols.py`, and
  `/private/tmp/fwp-migrate-live-accounting.py`, and
  `/private/tmp/fwp-remove-literal-gc-arguments.py`, and
  `/private/tmp/fwp-remove-counting-switches.py` and
  `/private/tmp/fwp-remove-counting-branches.py` and
  `/private/tmp/fwp-migrate-allocation-reports.py` and
  `/private/tmp/fwp-update-allocator-hook-parameters.py` and
  `/private/tmp/fwp-migrate-release-observers.py` and
  `/private/tmp/fwp-migrate-native-memory-tests.py` and
  `/private/tmp/fwp-retire-reuse-collector-tests.py` and
  `/private/tmp/fwp-migrate-static-heap-test.py`; they are one-shot edits, not
  idempotent publishers. Do not rerun blindly. Full builds/suites belong on CI. The branch-selection edit helper initially
  rescanned strings inefficiently; that process was stopped and an improved
  version completed under the guard (1.45 CPU seconds, 2.86 elapsed).

## This delivery

The interpreter and native compiler now share queue, State and derivative
lifetime checks before program effects. Coverage includes returned functions,
macros, compile-time calls, REPL recovery and gRPC handlers. Native representation
and C ABI checks remain separate.

## Prior-batch evidence

The active #216 handoff owns admission, analysis-budget and CI evidence. Do not
repeat its changing status here. The report in
[ownership analysis](measurements/ownership-analysis.md) records the original
small-fixture comparison; it does not verify this unpublished deletion tree.

## Local checks

No full local build or suite ran. Commands use `python3 scripts/local-guard.py`:

- `python3 /private/tmp/check-fwp-callback-preparation.py`: formatting, metadata,
  native schedule (254 targets) and diff checks pass.
- `python3 scripts/check-roadmap.py`: 162 link sets, 106 preparation pairs/tags,
  eight roadmap rows and commit messages pass. The rewrite initially omitted
  the required status index; restoring it fixed the audit.
- `python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /private/tmp/fwp-g5-primitive-inventory.json`:
  394 declarations, 384 symbols, 40 aliases, 373 contracts, 19 templates; no reviews.
- `python3 /private/tmp/fwp-check-rejection-expectations.py`: 40 old-compiler
  rejection probes pass. This does not verify the later performance repair.
- `python3 /private/tmp/fwp-check-server-startup.py`: three bounded-startup tests pass.
- `python3 /private/tmp/fwp-check-memory-startup.py`: changed memory harness
  compiles with warnings denied; its three bounded-startup tests pass.

## Verified base and next group

PR #215 merged as `4e7b74be8e11634fac9309e67cb4efccfb34d360`, with the same tree as
tested head `bd77d65f58d8c5117ea678cb86cf15fbcf9231f7`:
`dad73fe097358b3f5842b5d44dcfc13b84fb6bac`. Production `40221722197` and docs
`40221722121` passed. G3/G4 are delivered; [history](roadmap-history.md) records them.

`/private/tmp/fwp-delete-tracing`, branch `delete-tracing-collector`, contains
unpublished, incomplete G5 deletion based on `0db38df8`. Its handoff lists runtime,
code-generation, report and test migrations. Do not claim it builds. Rebase onto
verified merged #216 before publication; keep one active PR. The finite deletion
map is in [ownership diagnostics](ownership-diagnostics.md). A2–A6 then address
remaining reference counts, boxes, unique buffers and scoped workspaces.

Keep old #214/#215 publishers stopped; they would overwrite newer docs. No merge
watcher runs. After final-head gates pass, squash with an explicit single-line
subject of at most 80 characters and empty body, verify tree/message, then continue
PLAN.md. No trailers or AI attribution.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | In progress | G2/G5 final validation, then tracing deletion |
| 2 | In progress | A2–A6 residual-cost baseline, unique buffer and scoped workspace |
| 3 | In progress | F1–F3 function-call and recursion costs |
| 4 | In progress | P1–P3 measured CPU budgets |
| 5 | In progress | D1–D3 derivative correctness and time/storage budgets |
| 6 | In progress | N1–N2 numerical accuracy and kernel budgets |
| 7 | In progress | B1–B2 reproducible comparisons and enforced budgets |
| 8 | In progress | V1–V2 application correctness, cleanup and scaling matrix |
