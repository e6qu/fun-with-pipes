# Current work

**Next:** watch the repaired [PR #233](https://github.com/e6qu/fun-with-pipes/pull/233)
at its new exact head. Merge only after all nine production jobs and docs pass.
Keep one active PR; the independent callable preparation is not another PR.

## Active State range delivery

Worktree `/private/tmp/fwp-state-range-folds`, branch `state-range-folds`.
The first head `a7f6246150d7f300b926afe3e101e46db8e5bd59` has known comparison failures;
**do not merge that head**. Production run `41166997085`, docs `41166997076`.
The batched repair changes tests, measurement checks, workflows and docs; compiler
and runtime source remain the focused `ea0f300b` implementation.

Use squash subject `Avoid temporary range lists in State folds`, with an empty
body. Verify the merged tree equals the passing head and the commit has exactly
one line, at most 80 characters, no trailers or attribution.

### First matrix: all ten jobs completely audited

| Gate | Job | Result at a7f62461 |
|---|---|---|
| Benchmarks | 124436595057 | Pass: 2 Rust / 14 Python cases |
| macOS ARM regular | 124436595221 | Pass: 633 Rust / 22 Python |
| macOS Intel regular | 124436595213 | Pass: 633 Rust / 22 Python |
| macOS ARM ownership | 124436595281 | 366 passed / one service comparison failure |
| macOS Intel ownership | 124436595251 | 366 passed / the same failure |
| Linux ARM | 124436595302 | 1,002 passed / the same failure; 12 Python pass |
| Windows ARM | 124436595447 | 827 passed / the same failure; 22 Python pass |
| Windows AMD | 124436595325 | 827 passed / the same failure; 22 Python pass |
| Linux AMD | 124436595442 | 1,002 passed / the same failure; 12 Python pass |
| Documentation | 124436595008 | Sole capture-reference hash failure; 20 later steps skipped |

Both Windows audits distinguish their 16 intentional panic controls from the
service failure. The ARM macOS compiler-report artifact contains only the
compiler, no crash report. Linux target artifacts `13030914670` / `13032515528`
and Windows TLS artifacts `13030059727` / `13031253656` were also audited as soon
as their phases completed. No additional unexpected diagnostic was found.

Logs, metadata, archives and audits: `/private/tmp/fwp-233-*`.
Auditors: `/private/tmp/fwp-audit-233-green.py`,
`fwp-audit-233-service-failure.py`, `fwp-audit-233-linux-tests.py`,
`fwp-audit-233-windows-tls.py` and `fwp-audit-233-docs-failure.py`.
These are frozen to the first head; supply the actual new source in final audits.

After repair, expected complete counts are Linux 1,003 Rust / 257 summaries;
regular macOS 633/132; ownership macOS 367/127; Windows 828/206; benchmarks 2/2.
Expected Python cases: Linux 12, regular macOS and Windows 22, benchmarks 14,
docs 328 in 49 suites. Confirm actual results; expectations do not waive gates.

## Batched repairs

The capture-reference test froze the whole optimizer module. Making `substitute`
visible to State fusion changed that hash, although capture behavior was intact.
The repair freezes only the two original capture blocks and requires reversing
the replacement to reproduce the complete current source. The original blocks
still match preparation `8a495a72`; historical measurements and limits are intact.
Six reference and eight derivative-budget tests pass under the guard.

The service comparison mixed different input costs. Plain State eliminates its
range list; the deadline callback captures a `Duration` record and keeps it.
The exact packaged compiler reproduces two fixed requests for plain versus
35/131 requests for deadline at 32/128 inputs. Reusing each list for State updates
and `length` makes input construction comparable. All seven scope comparisons
pass with their original limits and zero retained storage. The test additionally
checks the input-node slope and prints rows before assertions. CI now preserves
service sources/counters/binaries; the focused State workflow includes this caller.
Linux explicitly selects GCC for those evidence records.

Caller review found an obsolete 347-contract/seven-unresolved assertion in the
service collector. It now checks the frozen-baseline audit and complete,
consistent rows, requiring no unresolved contracts. The current 373-contract
report passes; twelve damaged reports fail, including empty and duplicate rows.
List-iteration descriptions now explain that the current full-program comparison
also includes range elimination. Historical numbers and timing policy are intact.
Stale directions to implement already-merged array and typed-state work are removed.

Focused local verification uses the guard only: the native service reproduction
passes in 27.68s (13.78s CPU); retained-row/inventory controls in 0.13s each;
Rust format in 1.71s; workflow lint in 0.26s/5.66s; the final roadmap audit in
2.62s (189 link sets, 106 immutable preparation pairs, eight steps and commit
subjects). Scripts/data: `/private/tmp/fwp-check-service-comparison.py`,
`fwp-check-service-inventory.py`, `fwp-233-service-comparison/rows.json`.
This Clang check does not establish GCC or Windows support; the new full matrix must.

## Existing evidence and next preparation

[State range scope and evidence](measurements/state-range-folds.md) owns the
frozen protocol, three-host focused results, both G2 results and retained rejected
experiments. The maintained evidence checker recomputes both decisions without
rerunning measurements. There is no elapsed-time acceptance claim.

[PR #232](roadmap-history.md#generated-array-elimination-pr-232) is verified and
merged as `c71ac217`, with the exact tested `05d96484` tree and required commit
format. Both duplicate post-merge runs were cancelled after verification. Do not
resume its old retry. The State branch includes that verified main through
`203c501f`, preserving the prepared tree exactly.

Independent B1 worktree `/private/tmp/fwp-returned-callables`, branch
`returned-callable-peers`, is published through `df8f9ce8` (protocol `8c77d111`).
C/Rust peers pass O1/O2 checksums and overflow controls (1.98s). An additional
uncommitted fwp fixture passes raw/optimized checksums (0.48s); a temporary native
probe passes separate-compilation repeated calls and pre-teardown cleanup at
Clang O1/O2 (1.11s). Its handoff records remaining phase counters, failure/retry,
omitted-release controls, GCC checks and complete evidence work. There is no
complete comparison or speed result and no second PR. Integrate verified #233
before publication. D2/N1's failed timing requirements remain open.

## Local workspace

No full local build, suite or benchmark ran. Preserve the dirty primary checkout
and other worktrees. The primary handoff points here; its original content is
preserved below that pointer and in
`/private/tmp/fwp-primary-handoff-before-current-pointer-2026-10-31.md`.
Five clean historical worktrees omit duplicate measurement files through sparse
checkout; their Git objects and original downloaded archives remain intact.
Keep the 64-GiB disk floor and all other guard limits; never bypass them.

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

[PLAN.md](../PLAN.md) retains the scopes, unchanged budgets and failed controls.
Allocation reductions do not complete D2/N1 execution-timing acceptance.
