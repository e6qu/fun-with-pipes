# Session handoff

All seven [plan](../PLAN.md) areas remain open. Remove tracing; prefer ownership
and borrowing, with ARC for necessary sharing. JIT is excluded.

## Current action

**Next:** finish production acceptance of the `http-memory-delivery` branch,
squash-merge after all nine production jobs, documentation and binary reviews
pass, then continue ownership checks and measured numerical costs. Keep one active
PR; use one subject at most 80 characters and an empty body, and verify the merge.

## Current grouped delivery

Checkout `/private/tmp/fwp-http-application-memory`, branch `http-memory-delivery`.
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
Record the resulting PR, final source and run IDs after publication. All earlier
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
