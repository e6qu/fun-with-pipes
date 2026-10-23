# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Remove tracing; prefer
ownership, borrowing and moves; reserve ARC for necessary sharing. JIT is excluded.
Continue substantial grouped PRs with one active delivery and exact-source gates.

## Accepted baseline and active PR

[PR #198](https://github.com/e6qu/fun-with-pipes/pull/198) is squash-merged as
`27a3e009b83e28f06130a5d686a3196b9934e53f`. All nine production jobs and docs passed
source `30c6d65c10b3cc33cfeb72f523e4d47624508896`; inspection covered 480 binaries
and 816 observations. The tree, sole parent and one-line message were verified.
[History](roadmap-history.md#local-callback-captures-and-repeated-numerical-work-pr-198)
records the evidence. Redundant main production CI was cancelled; docs were kept.

[PR #199](https://github.com/e6qu/fun-with-pipes/pull/199) is the only open delivery.
Published source: `3321091d8dcdda1ee3041288cbda4c9cad06c089`, branch
`checked-native-default`, worktree `/private/tmp/fwp-checked-native-default`.
The PR is draft. Focused run `39906577400` failed one of 53 integration tests:
`ad_tape_scopes` referenced tracing-only diagnostic state in an ARC probe.
All other integration tests, all 179 library tests, compiler/lint checks,
inventory and coverage audits passed. The complete log is audited in
`/private/tmp/fwp-arc-metadata-focused-acceptance.json`.

The repository audit found the same issue in cached-map cleanup and TCP/UDP
library-unload probes. The working repair preserves physical-free assertions in
ARC and poison assertions in tracing, with a deliberately missing autodiff
release as a failure control. The focused suite now includes cached maps and
socket ownership (fifteen targets). Tracing-only probes retain their diagnostics;
no fake runtime flag or ARC poisoning path is added.
The clean preparation worktree `/private/tmp/fwp-arc-metadata-cleanup` remains
at `3321091d`; edit only the delivery worktree. The primary checkout stays detached
at #198 and holds this live handoff.

The superseded `4e16d81c` run `39900026387` was cancelled after the grouped repair
was pushed. Both ARM macOS jobs, benchmarks and docs passed; six platform jobs
were interrupted. All ten completed logs have been audited: no unexpected
compiler/test diagnostic, only the six requested cancellation errors. This is
partial evidence, not acceptance of either revision. Retained audit:
`/private/tmp/fwp-199-production-acceptance-4e16d81c.json`.

**Next:** finish focused local probe/format/doc checks, commit and publish all
probe repairs together, and dispatch the expanded focused suite. Keep the PR draft
until its exact-source job and independent audits pass, then start nine production
jobs and docs. Inspect actual default and allocator binaries on six native
platforms before squash merge. Verify the tree, sole parent and one-line message
(maximum 80 characters, empty body), then continue PLAN.md. No permission question
is pending and no automatic merge is queued.

Publication state: `/private/tmp/fwp-default-ownership-publication.json`.
Its `knownUnresolved` marker records the failed probe audit. Preserve earlier
receipts and create new source-specific publication/dispatch/ready records; do not
rerun completed helpers or use the thirteen-target acceptance for the new suite.

## What this PR changes

Ordinary native commands, builds, generated modules and compiler APIs use checked
ARC by default. Unproved ownership remains an error, without a tracing fallback.
Explicit `--gc tracing` still exists; this does not finish GC removal or eliminate
ARC. Collector probes explicitly select tracing. The invalid inter-task derivative
keeps its runtime trap under tracing and separate ARC compile rejection.
Default command tests cover cache identity, rejection before execution, and saved
O0/O1/O2 binaries. Python disassembly requires and records an explicit ownership
mode, with both modes tested at O0–O3. Guides and historical next actions are cleaned up.

The first full matrix found four failures, all repaired: two missed collector-mode
selections, a mislabeled unsupported C-type diagnostic, and the invalid derivative
in the static-memory golden suite. Independent SDK, packaging and measurements
now continue after an earlier failure. Inventory failures propagate through log
capture; an injected exit 37 checks that repair.

The added real-collection control exposed two static-heap bugs. Pressure now
forces a full collection and rechecks slots freed inside partly live pages.
The original 1 MiB limit remains. Deliberately removing each fix, or disabling
collection, produces the expected exhaustion. These repairs passed the focused
run and both ARM macOS full jobs at `4e16d81c`.

The published repair additionally prevents a host's late `FWP_REUSE_VERIFY` change
from retaining released ARC objects, arrays, files and sockets. ARC excludes those
diagnostic paths at compilation time; invalid startup options still fail.
Unused mark storage and age checks are removed from ARC, along with the collector's
stack-bound lookup. Page metadata falls from 4,648 to 4,128 bytes; inline counts
remain 4,096 bytes. Tracing's layout is unchanged. This is a structure-size result,
not a timing or resident-memory claim. [The report](measurements/arc-metadata.md)
explains the measurement and limits.

## Verification and retained evidence

The focused job `120234298323` in run `39898475722` passed 52 integration tests
across thirteen targets, all 179 library tests, compiler/lint checks, inventory and
failure controls. Its complete log has no unexpected errors. This is evidence for
`4e16d81c`, not acceptance of the newer working repair. The earlier first-matrix
and failed focused audits remain in `/private/tmp/fwp-199-production-acceptance-8bf72ec9.json`
and `/private/tmp/fwp-default-repair-focused-acceptance.json`.

Every local check uses `python3 scripts/local-guard.py COMMAND...`. Full builds,
full suites and large measurements stay on GitHub. Local C checks use Apple Clang
on ARM64, C emitted by accepted compiler #197, and the exact working runtime
substituted into it. They do not establish new-compiler or other-platform support.

- `/private/tmp/fwp-check-probe-repair.py` passed eight ARM64 binaries and twelve
  observations at O1/O2 (4.83 seconds): scoped autodiff cleanup succeeds in both
  ownership modes, and removing the output release fails with status 77. Tracing
  also checks poisoned storage. Results: `/private/tmp/fwp-probe-repair/results.json`.
- `/private/tmp/fwp-check-probe-docs.py` passed focused Rust formatting, whitespace,
  107 doc link sets, 106 immutable anchors, all seven roadmap rows and thirteen
  native test coverage/failure controls (10.52 seconds). No full local build ran.
- Static-pressure checks passed 27 observations, then 54 using the tracked fixture
  at O0/O1/O2. Nine actual ARM64 binaries were inspected. Evidence:
  `/private/tmp/fwp-static-pressure{,-fixture}-verified/`.
- `/private/tmp/fwp-probe-late-reuse-option.py` reproduced the ARC defect: uniqueness
  changed to poisoned-copy mode and 32 released bytes stayed retained. The repaired
  probe passes with uniqueness 1 and zero retained bytes.
- `/private/tmp/fwp-check-arc-metadata-fixture.py` passed twelve inspected binaries
  and sixty observations in 6.01 seconds. Both ownership/memory modes, O0/O1/O2,
  wide counts and all four affected resource paths are covered. ARC symbols exclude
  poisoning and stack discovery. Results: `/private/tmp/fwp-arc-metadata-fixture/`.
- `/private/tmp/fwp-check-arc-metadata-negative.py` used the actual old runtime to
  reproduce all four defects in six binaries/thirty observations (2.79 seconds).
  Results: `/private/tmp/fwp-arc-metadata-negative/`.
- `/private/tmp/fwp-check-late-corpus-samples.py` passed array-alias and task/channel/
  UDP examples against the interpreter and goldens, with ordinary/late options
  and return-memory ledgers (3.47 seconds). The complete corpus remains a CI gate.
- `/private/tmp/fwp-check-metadata-docs.py` passed focused formatting, whitespace,
  107 doc link sets, 106 immutable anchors and all seven roadmap status rows.
  The staged measurement report and required handoff table are included.

The new native test saves twelve C files/executables and sixty outcomes per host
under `allocator-metadata/`. The corpus reuses each compiled binary for its second
environment, avoiding another compilation per program.

## Resume tools and resource limits

`/private/tmp/fwp-audit-199-final.py` audits registered final production/docs jobs.
Do not run it until the new full runs are registered. Existing receipts are tied
to their source; archive them before any further repair. Completed publication,
dispatch and ready helpers must not be rerun.

`/private/tmp/fwp-inspect-default-builds.py` now requires explicit default and
metadata artifact/job arguments. Linux/Windows use the same artifact for both;
macOS default binaries come from the regular job and metadata binaries from the
GC job (`ownership-evidence-gc-macOS-{ARM64,X64}`). Each host needs three default
and twelve metadata binaries, with sixty metadata observations. No final images
have been inspected for the pending repair yet. Windows legitimately uses the stack-bound
API for contexts/static memory; inspect the collector entry at O0 rather than
banning that import globally. `/private/tmp/fwp-merge-199.py` requires all six
expanded reports plus fresh exact-source confirmation of all ten checks. The
Windows ARM64 check uses `/private/tmp/fwp_pe_startup.py` to resolve O0 import
loads/calls from LLVM disassembly and PE symbol addresses, rejecting unresolved
indirect calls. `/private/tmp/fwp-check-windows-startup-inspection.py` confirmed
both native Windows architectures identify the old stack query in accepted #198
binaries (0.13 seconds); a name-only ARM64 search would have missed it.

Keep local work serial and guarded: 64 GiB free disk, generated target data below
2 GiB, sampled aggregate RSS below 1 GiB and a 180-second deadline. Never raise
limits. Preserve worktrees, source hashes, binaries and receipts.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit ARC at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |

No further optimization is selected beyond this PR.
