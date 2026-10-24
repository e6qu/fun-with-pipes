# Session handoff

All seven [plan](../PLAN.md) areas remain open. Remove tracing, prefer ownership
and borrowing, and reserve ARC for necessary sharing. JIT is excluded.

## Current action

**Next:** publish the constant-array stack repair with the array/iterator group,
run its six-host focused checks and Linux measurements, then assemble one PR
against verified main `336692f4329d9f628c05d6a42a7353c1702bdc09`. Require all nine
production jobs, docs and binary inspection at the final head before squash merge.
No PR is currently open. Standing publication/merge authorization remains active.

Worktree `/private/tmp/fwp-array-list`, branch `array-list-preparation`.
Committed base `6516169a07680a8579c9a534436f78cdd057b25f` has native compiler files
identical to `dbef97e1a9e843c1ffcfc8806650741782f10487`. Uncommitted work repairs
constant-array stack use, adds compiler frame reports and corrects benchmark
wording. Do not discard these edits. Local helper paths below are `/private/tmp`.

## Completed delivery

[PR #205](https://github.com/e6qu/fun-with-pipes/pull/205) merged as `336692f4329d9f628c05d6a42a7353c1702bdc09`.
Tested head `51c295e02a8037f985fe9f662b8e1000fcd97798`; exact tree and sole parent
verified. Subject: `Speed up float printing and explain numerical performance costs`.
The raw commit message has one line and no body or trailers.
All nine production jobs (`40037426686`) and docs (`40037426647`) passed; complete
logs audited. Independent inspection passed 7,158 saved outcomes, plus sixteen
coordinate observations per Linux host. Same-tree main CI `40048973688` cancelled.
Receipts: `fwp-float-delivery-{publication,final-acceptance,merge,merge-runs}.json`.
Do not rerun completed merge helpers. Integrate acceptance into history in this PR.

## Array group and evidence

[Array examples and test scope](measurements/array-text.md) explain literal-array
storage, direct array-to-text output, immutable String reuse and flat iterator
state. The production compiler still needs final acceptance for this group.

Native run `40047565887` at `dbef97e1a9e8`: all six hosts and all fifteen targets
pass, with complete logs audited. All **1,008 saved outcomes** pass independent
inspection (168 per host). Expanded reviews retain 24 paired O2 binaries and C
files per host, with assembly, section data and symbols:
`fwp-array-layout-review/dbef97e1a9e8`. Reports:
`fwp-array-native-evidence/dbef97e1a9e8`; log audit:
`fwp-array-state-repair-audit.json`. Verified ZIP caches were pruned; originals
remain on GitHub. Preserve unique failure archives.

Binary review found about 15 KiB entry frames on Clang. Constant initialization
emitted a separate temporary type descriptor per element. The repair uses one
block-local descriptor per array; stores only read it and never retain it.
Local saved-C check at Apple Clang 17: O1 frame 15,040 → 720 bytes; O2 remains
704 bytes. Exact output and allocation/cleanup results agree. Initial diagnostic
incorrectly required improvement at both levels; corrected to retain the unchanged
O2 result. Recheck passed in 1.23s: `fwp-array-init-stack-check/results.json`.
The native test adds O1/O2 compiler frame reports and object files, with a 4 KiB
individual startup-frame bound for this fixture. New Rust/native execution is
still required on CI. This is not a total-call-stack bound.

Windows layout inspection also needed repair: PE can place zero-initialized data
in a virtual tail of `.data`, absent from stored bytes. The inspector now validates
actual PE section bounds before treating those bytes as loader-zeroed. Both
Windows reviews pass. AMD64: 168 outcomes followed by corrected 24-layout review
(1.12s); ARM64 full download/inspection/review/pruning (26.37s). The incomplete
AMD64 review remains separately named; it is not acceptance evidence.

## Measurements

Latest `6516169a0768` run `40049587794`: both Linux jobs and complete logs pass
(4.37s audit), including explicit compiler deadlines and child cleanup controls.
Audit: `fwp-array-build-time-output-audit.json`. Its binaries and build-time
journals still need inspection with `fwp-inspect-array-output-build-times.py`.

Previous `40047568819` passed AMD64; ARM64 exceeded its former 60-second compiler
limit before the largest timing input. Failed C is byte-identical to a previously
successful source. Unique archive retained in `fwp-array-measurement-failure-evidence`;
identity is in `fwp-array-timeout-diagnostics`. Repair separates an explicit
180-second CI build deadline from the unchanged 60-second execution deadline,
records every command's elapsed time/status/diagnostics and kills its process group
on timeout. Four actual controls pass. Local guard limits remain unchanged.

First run `40045991255` at `41f6438cf6fb`: both logs and 338 binary inspections pass.
Largest input: 200 full-output / 199 checksum managed requests, zero count increments
or retained managed storage; charged peaks 4,352 / 2,560 bytes. EPYC 9V45 full-output
ratios are 8.535× C / 9.313× Rust; Neoverse-N2 ratios 7.192× / 8.289×.
AMD64 3:1 checksum copy ratio 1.02758 fails the fixed 2% noise limit; retain it as
inconclusive. This intermediate source had a separate iterator failure; these
numerical results do not establish general compiler acceptance.
Reports: `fwp-array-output-evidence/41f6438cf6fb`; extraction:
`fwp-array-output-first-results.json`. Current comparisons include formatter
algorithm differences and are not paired before/after speed claims. New full
output formats arrays directly; it creates no output list. Managed counts exclude
static inputs, text capacity, runtime metadata and library allocations.

## Earlier failures repaired

| Source | Diagnosis and repair |
|---|---|
| `5f3efa1ea150` | Folding invalidated a dynamic probe; cached entry hid repeated work; nested display was missed. Corrected all three checks/traversals. |
| `c3a479d55a17` | Rust mutable-traversal borrow failure; compute the match before borrowing. Save compiler artifacts only when built. |
| `4aadfc11a8c5` | Extra String copy and iterator state tuples; removed those costs. Benchmark helpers now handle nonempty initialization and fused output. |
| `41f6438cf6fb` | Reconstructed iterator state lost field types; directly project typed fields. All six hosts verified the repair at `dbef97e1a9e8`. |

All failed native jobs and completed targets were audited before each repair.
Unique failure archives remain in `fwp-array-{initial,borrow,cost}-failure-evidence`.
Earlier source/run identities and complete logs remain in the corresponding
`fwp-array-*-audit.json` receipts. Do not reinterpret failed sources as support.

## Resources and verification

Use `python3 scripts/local-guard.py COMMAND...` serially. Full builds, tests and
measurements run on GitHub. Preserve 64 GiB free space and all other guard limits.
Merged clean checkouts #198–204 and verified duplicate archives were pruned with
receipts `fwp-pruned-*.json`. The clean #205 checkout `fwp-float-delivery` remains
available for verified pruning if needed. Never remove dirty preparation worktrees
or unique failed evidence. Primary checkout is detached at main with a modified
handoff only. Backup: `fwp-handoff-before-float-delivery-merge.md`.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |
