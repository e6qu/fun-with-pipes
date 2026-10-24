# Session handoff

All seven [plan](../PLAN.md) areas remain open. Remove tracing; prefer ownership
and borrowing, with ARC for necessary sharing. JIT is excluded.

## Current action

**Next:** finish exact-head acceptance of [PR #208](https://github.com/e6qu/fun-with-pipes/pull/208),
squash-merge after all nine production jobs, documentation and binary reviews
pass, then continue ownership checks and measured numerical costs. Keep one active
PR; use one subject at most 80 characters and an empty body, and verify the merge.

## Current grouped delivery

Checkout `/private/tmp/fwp-http-application-memory`, branch `http-memory-delivery`,
clean at `227e671257d885185e54b3f915f6d1ebf470b3ea`. Initial `d8fc00eb` runs
`40073914806` and `40073914646` were superseded and cancelled after auditing
all jobs for failures. The repair retains Linux stack-page binaries in production
and adds an upload-wiring regression; all seventeen runner controls pass.
Publication, preparation and wiring-repair helpers are COMPLETE; do not rerun.
Receipts: `fwp-http-memory-delivery-{preparation,publication}.json` and
`fwp-stack-artifact-wiring-publication.json` under `/private/tmp`.
It adds API memory/cancellation acceptance, ordinary Linux task-stack pages,
checked dynamic/static Unix guard setup, single-owner HTTP/WebSocket test sockets,
physical-page diagnostics and clearer measurement records. The
[API report](measurements/http-application-memory.md) defines the workload,
unchanged budgets and limitations. No throughput or C/Rust parity claim is made.

Prepared source `cf3a11e4995cf228db9d2b783d20583da5a056f5` passes all six
focused API jobs in run `40072655673`, including Linux page-policy checks and
Linux/macOS static guard faults/failure cleanup. Eight actual static-guard
binaries and forty outcomes pass independent review. Client/protocol run
`40070408748` at `05de0f65` passes all twelve jobs, including Linux repeated
HTTP/REST memory checks. Complete logs are audited.

The earlier `4fc97ca1` API run `40069237866` passes on all six native hosts;
all 36 API binaries and their saved execution records pass independent review.
Mapping run `40069848297` confirms ordinary Linux task-stack pages in all 96
repaired idle samples. AMD64 process memory is about 13 MiB versus 44–46 MiB
in baseline diagnostics. The [raw page samples](measurements/http-stack-pages.json)
and [focused evidence](measurements/http-memory-focused-2026-10-24.json) retain
exact sources and hashes. Earlier evidence does not replace final-head acceptance.

Native Windows probe `40070406753` confirms duplicated Rust sockets inherit into
unrelated children. Both actual PE binaries and all six observations pass review.
Clients now borrow one owned socket for writes; the regression requires closure
while a separate child remains alive. No scheduler changes or relaxed deadlines.

The delivery fixture uses 1 MiB task stacks, matching the production static
default and leaving writable body pages on 64 KiB-page hosts. Focused source
used 64 KiB fixture stacks on the runners above; final native checks cover this
portable fixture adjustment. The runtime change is unchanged apart from comments.

Final acceptance requires exact-head API binaries on all six native hosts and
static guard binaries on four Unix hosts, Linux page-policy/failure binaries,
as well as the existing ownership,
file, numerical, stack and layout evidence. `scripts/inspect-http-application.py`
checks saved API images/records. CI preserves guard evidence in
`ownership-evidence/static-guards` and Linux allocation-block evidence in
`ownership-evidence/task-context/pages`. A wiring regression checks both uploads.
A skipped target never establishes support.

Publication and acceptance receipts use `/private/tmp/fwp-http-memory-delivery-*`.
Repeatable final audit: `/private/tmp/fwp-audit-http-memory-delivery-final.py`.
Production run `40074183388`; documentation run `40074183289` PASSES.
All final-head binary reviews are unrun. Use
`fwp-review-http-memory-delivery-host.py`: download, ownership, arrays, floats,
Linux-only controls, files, services, prune. The services phase verifies six API
binaries per host, two static guard images per Unix host and two page-policy
images per Linux host. Pruning requires those reports. Initial source
`d8fc00eb` publication/audit receipts are archived separately; never use them as
acceptance of `227e6712`. Review helpers have syntax/path checks; saved-artifact
execution begins only after the corresponding production host passes. All earlier
publication helpers through `fwp-publish-static-stack-guards.py` are COMPLETE;
never rerun them. Preparation helpers also have receipts; inspect before retrying.

## Previous delivery and retained failures

PR #207 is verified and merged at `46a7235a81c46d30d0c155f319913e6b7fe4ddbc`. Source
`bd0dc0100a516099590c340c012f74b7b666ebd2` passed production `40064764447`
and docs `40064764348`. Review covered 8,166 core outcomes, 240 file binaries,
480 file executions, 23,040 checkpoints, twelve stack objects and 144 layouts.
The [delivery record](measurements/file-http-delivery-2026-10-24.json) retains
identities and review hashes. Its completed helpers must not be rerun.

Keep original failed evidence: `ef66ca99` misparsed floating metric text;
`027be46e` exceeded Linux RSS by 20 KiB and timed out on Windows; `10626760`
incorrectly rejected a connection reset in the socket diagnostic. All failures
were audited and repaired. Isolated Windows repeats passed but were not repairs.
Unique archives remain under `/private/tmp/fwp-http-memory-failures-027be46e`
and the mapping/socket diagnostic directories. Do not delete them as caches.

## Independent benchmark preparation

Checkout `/private/tmp/fwp-arc-benchmark-comparison`, branch
`arc-benchmark-comparison`, based on PR #208 source `227e6712`. No second PR.
The clean merged #207 checkout was moved here; its old path
`/private/tmp/fwp-file-http-delivery` no longer exists. Branches, commits and
reports remain; completed #207 helpers must not be rerun.

The general comparison now requires `CC`, `FWP_BENCH_OWNERSHIP` and `FWP_LTO=0`.
Production selects checked ARC; the scalar-text historical protocol explicitly
selects tracing and rejects wrong-mode evidence. Descriptive six-sample timings
retain their existing scope and arithmetic differences. Actual binaries, input
hashes and sample summaries are inspected; four corrupted-artifact controls must
fail. Native Linux AMD64/ARM64 focused run `40075912779` PASSES at source
`617bb2319760ccade91afea2bb0045c1984abbdf`. Publication is COMPLETE; do not
rerun `fwp-publish-arc-benchmark-preparation.py`.

The saved verified #206 compiler accepts all seven benchmark programs under
checked ARC and emits C (3.15s total with formatting/workflow/Python checks).
Compiler/library/program inputs match the current branch, but embedded runtime
is older; this is admission diagnostics, not current-source native acceptance or
a timing result. Receipt: `/private/tmp/fwp-arc-benchmark-admission/receipt.json`.
The active PR #208 stays unchanged while this preparation runs.


Both complete logs are audited; independent review of all 42 measured native
binaries and eight corruption-control failures passes (0.97s AMD64, 0.96s ARM64).
Reports: `/private/tmp/fwp-arc-benchmark-evidence/617bb2319760`.
The preparation now documents all seven results and their limits in
`docs/measurements/arc-comparison.md`; the integer loop and direct text counting
still have C/Rust gaps. No compiler speedup or memory-count claim is made.

A related preparation now adds separate peak-process-memory measurements for
C/Rust/fwp and fwp managed allocation/retain/live-storage counts, with seven
intentional leak controls. Local template checks passed for all fourteen retained
generated C programs (2.99s including syntax/docs); native run `40076674217` PASSES on both hosts at `b16ed5e33f29`.
The full measurements remain runner-only and do not change PR #208's passing head.


Memory run `40076674217` at `b16ed5e33f29774c2d56e5500c8d7548ea52ce06` passes;
both complete logs and all 70 actual binaries are independently reviewed (1.22s
AMD64 and 1.22s ARM64). All fourteen injected leaks are detected. `map` records
four managed requests, 24,000,032 requested bytes, one retain and 24,000,008 peak
charged bytes; other scalar/pipeline cases have zero requests/retains. All ordinary
profiles end with zero additional charge. These are scoped managed counts, not
C/Rust allocator counts or process memory. Evidence and exact timings are under
`/private/tmp/fwp-benchmark-memory-evidence/b16ed5e33f29`.


The next prepared experiment edits generated C only: preserve successful signed
subtraction/addition expressions after their existing overflow checks. The
checked-bounds protocol fixes 32 samples, two warmups, all allowed CPUs, an
identical-binary control within 3%, at least 5% loop improvement and no more than
3% slowdown elsewhere. Both wall and child CPU time must pass on both hosts.
No compiler change is selected. Protocol and runner are prepared; publication
and native execution remain pending.


## Prepared map storage reduction

The benchmark branch now compacts typed map/set borrowed words into their input
scratch lanes and frees sort scratch before result allocation. All three runtime
callers and the numeric compiler builder keep source owners alive or use unboxed
words; their input scratch is discarded after return. Source and hash/layout
semantics remain unchanged. Do not compact an owning container without proving
its cleanup contract.

Map/set failure injection now includes every comparison, so the existing missing
scratch-owner control remains meaningful during sorting. A new regression in the
existing `map_set_ownership` target checks map/set peak charge at O1/O2 in ARC and
tracing, with a delayed-release control that must exceed the budget. It uses
4,096 entries so both buffers use exact large-object charges, avoiding small-slot
rounding. The map-focused workflow now uses production GCC on Linux and Clang
elsewhere, and records the actual selected C compiler.

Local formatting passes (1.47s). Native compilation, memory measurements and
six-host failure/reuse acceptance are pending publication. The prior arithmetic
experiment passed correctness on both hosts, but its screen failed on AMD64 due
to noisy controls and some slower rows; ARM64 passed. No arithmetic compiler
change is selected. Full binary/sample review of that experiment remains pending.

## Local limits

Use `python3 scripts/local-guard.py COMMAND...` serially. Full builds/suites and
benchmarks stay on GitHub. Keep 64 GiB free, target below 2 GiB and sampled RSS
below 1 GiB. A local full API Clang build exceeded RSS and was stopped; do not
retry or raise limits. Focused guard checks pass at Clang O1/O2 (1.39s), native
runner coverage/artifact/failure controls pass (seventeen cases, 7.57s), and formatting,
workflow syntax and docs checks pass. Local Clang does not establish GCC support.

Only verified duplicate caches and clean published checkout copies were pruned.
Dirty trees, commits, tags and unique failures remain. Current disk space is close
to the reserve; inspect it before downloading. Completed evidence reviewers and
downloaders are not repeatable unless their receipt explicitly says so.

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
