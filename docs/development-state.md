# Session handoff

All seven [plan](../PLAN.md) areas remain open. Remove tracing; prefer ownership
and borrowing, with ARC for necessary sharing. JIT is excluded.

## Current action

**Next:** finish exact-head review and merge [PR #207](https://github.com/e6qu/fun-with-pipes/pull/207),
then deliver the API memory, socket-lifetime and stack-guard work together.
Keep one active PR. Merge requires all nine production jobs, documentation and
independent binary review; one subject at most 80 characters, empty body.

## Active delivery

PR #207 source `bd0dc0100a516099590c340c012f74b7b666ebd2`; production
`40064764447`, docs `40064764348`. Nine gates pass with complete logs audited;
Linux AMD64 is still testing. No observed failure. Clean checkout:
`/private/tmp/fwp-file-http-delivery`. Repeatable auditor:
`/private/tmp/fwp-audit-file-http-delivery-final.py`.

Final binary reviews are COMPLETE for both macOS hosts, Linux ARM64 and Windows
ARM64. Their duplicate ZIP caches were pruned after verification; reports remain
in `/private/tmp/fwp-file-http-delivery-evidence/bd0dc0100a51` and the matching
`fwp-file-http-delivery-layout` path. Do not repeat completed reviews.
Windows AMD64 download is starting; inspect its files/session before retrying.
Linux AMD64 review is unrun. Use `fwp-review-file-http-delivery-host.py` phases:
download, ownership, arrays, floats, Linux-only controls, files, prune.
Final totals: 8,166 core outcomes, 240 file binaries, 480 file executions,
23,040 file checkpoints, twelve stack objects and 144 paired layouts.

`fwp-merge-file-http-delivery.py` and `fwp-after-merge-file-http-delivery.py`
are UNRUN. They require passing exact-head gates/reviews, verify the single-line
squash and preserve this dirty primary handoff before switching the checkout.
PR #206 is already verified and merged at
`8cd5153b3ed7084ec46601cfd5b2551825f64057`; its helpers are COMPLETE.
Primary remains detached there with only this handoff dirty.

## Next grouped delivery

Preparation checkout `/private/tmp/fwp-http-application-memory`, branch
`http-application-memory`, has published source
`05de0f652ae291df3f97c521a447a6f9636efce3` plus an uncommitted static-guard fix.
No second PR is open. The [API report](measurements/http-application-memory.md)
in that checkout describes inputs, fixed budgets, controls and raw samples.

- Six-host API run `40069237866` at `4fc97ca1` passes. Tests cover 3,440 replies,
  idle memory, partial-body disconnects and shutdown with seven pending handlers.
  Missing-free and missing-close controls fail as required. Budget stays warm
  RSS plus 8 MiB; idle deadline stays 20s.
- Linux mapping run `40069848297` at `4fc97ca1` passes; independent review is
  COMPLETE. All 96 repaired samples use ordinary task-stack pages. AMD64 API
  RSS is about 13 MiB versus 44–46 MiB in baseline diagnostics; growth at most
  196 KiB. This is memory evidence, not throughput or C/Rust parity.
- Windows handle run `40070406753` at `05de0f65` passes both native targets;
  PE/import/source/observation review is COMPLETE. Cloned Rust sockets are
  inheritable and keep connections alive in unrelated children. One owned
  buffered socket fixes the clients; no scheduler or deadline changes.
- HTTP/protocol run `40070408748` at `05de0f65`: all twelve jobs PASS, complete
  logs audited. Includes the portable child-lifetime regression and Linux
  repeated HTTP/REST memory checks.
- Static Unix startup also ignored guard setup failure. The new fix releases
  the shared mapping and exits before running tasks. The actual initializer
  passes local Clang O1/O2 guard faults, writable bodies, repeated initialization,
  first/last protection failures, map failure and deliberately missing guard.
  Native Linux/macOS verification is pending. Existing `static_memory` target
  and focused/production artifact wiring include the test.

Focused API binary review at `4fc97ca1` is COMPLETE on both Linux and both macOS
hosts; both Windows hosts remain unrun. Use `fwp-review-http-stack-host.py`.
Reports: `/private/tmp/fwp-http-memory-evidence/4fc97ca1f1c2`. Linux page-policy
binary/failure reviews are COMPLETE too. Earlier focused source does not replace
final delivery acceptance. All publication helpers through
`fwp-publish-http-socket-owner.py` are COMPLETE; never rerun them.

Original failures remain evidence: `ef66ca99` parsed `80.0` as an integer;
`027be46e` exceeded Linux RSS by 20 KiB and timed out on Windows; `10626760`
incorrectly required EOF instead of accepting reset after child termination.
All failed jobs were audited. Preserve `/private/tmp/fwp-http-memory-failures-027be46e`
and diagnostic archives. Isolated Windows repeats passed but were not repairs.
Detailed sources/results: `fwp-http-*-publication.json`, `fwp-http-mapping-evidence`,
`fwp-socket-inheritance-evidence/05de0f652ae2` under `/private/tmp`.

## Resource and validation notes

Use `python3 scripts/local-guard.py COMMAND...` serially. Full builds/suites run
on GitHub. Keep 64 GiB free, target below 2 GiB and sampled RSS below 1 GiB.
The local full API Clang build exceeded RSS and was stopped; do not retry or
raise limits. Small source/wiring/client checks pass. Latest static guard check:
`fwp-check-static-guard.py`, 1.39s, ten mode/optimization outcomes; formatting,
workflow syntax and diff whitespace pass. It does not establish GCC support.

Clean, published #206 and array-followup checkout copies were removed after
remote-ref verification; branches, tags, commits, dirty work and evidence remain.
Receipt: `/private/tmp/fwp-pruned-completed-206-checkouts.json`. Removed checkouts'
completed helpers must not be rerun. Disk remains close to its reserve: prune
only verified duplicate caches, never unique failures or dirty trees.

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

After service acceptance, continue replacing collector-based checks and choose
optimizations from equivalent-work numerical measurements. Allocation savings
alone do not establish speed parity with C/Rust.
