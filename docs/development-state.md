# Current work

**Next:** implement and verify the three typed-derivative ownership reductions in
[the protocol](measurements/typed-derivative-owners.md), together with the worked
[terminology guide](terminology.md). Keep one substantial PR for the batch.

Worktree `/private/tmp/fwp-returned-callables`, branch `reduce-derivative-ownership`,
base `658123c7c09aa8991ca69cbb82643e68244edc95`. The primary checkout contains
unrelated local changes; preserve it. Implementation, publication and squash merge
after all exact-head gates pass are authorized. Commit messages have one line,
at most 80 characters, no body, trailers or attribution.

## Verified baseline

PR #236 is merged. Tested head `f89ef8a597d9ba64b0b0de165e7c21cc9f787494`
and merge `658123c7c09aa8991ca69cbb82643e68244edc95` share tree
`3ea5adc038b819c9a6e5b722d0dd41ca4437485f`. All nine production jobs in
`41272009971` and documentation `41271982217` pass; every completed job log was
audited. Both Linux hosts passed 257 integration targets, both macOS shards per
architecture passed, and native Windows ARM64/AMD64 completed tests and packaging.
The 68-character squash subject and empty body were verified. Details are in
[history](roadmap-history.md#local-names-and-allocation-optimizations-pr-236).

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | Verified | Worked example, links and merged-source status checked; final documentation CI remains part of step 4 |
| 2 | Pending | Typed recording proof, cost fixture and lifetime controls |
| 3 | Pending | Shared-zero adjoints, result moves and failure/count controls |
| 4 | Pending | Focused native checks, evidence audit, complete final-head matrix and merge |

## Checks and constraints

The terminology example uses `x*x+2` at input 3 and prints `[6.0]`. Passed command:
`python3 scripts/local-guard.py env FWP_NO_OPT=1
/private/tmp/fwp-236-786-mac-package/fwp-macos-arm64/fwp run --interp
/private/tmp/fwp-terminology-tape.fwp` (0.11 CPU seconds, exit 0).
The guarded documentation audit also passes: 195 link sets, 106 immutable
preparation pairs and four roadmap steps. The first attempt preceded staging the
glossary rename and saw the old tracked path; after staging, the audit passed.
This downloaded compiler contains the same compiler source as #236; final new-source
native checks are still required. No new compiler/runtime implementation has run.

Use the local guard serially; full builds, suites and benchmarks run on GitHub.
Free disk was about 65 GiB at start, close to the fixed 64 GiB floor. Do not raise
limits or duplicate large artifacts. No compiler/test workload is running locally.

## Measurements to preserve

The [array traversal report](measurements/array-list-traversal.md) retains the
verified 208,552 fewer requests and 6,622,720 fewer requested bytes for eight
129-coordinate solves at its recorded source. Retains and peak managed storage
stay unchanged. AMD64 session 2's identical-copy variation is 2.1023% against 2%,
so timing remains inconclusive. This is final-list work, not forward recording.
The original D2/N1/N2 speed requirements and Xeon closure regressions remain open.

Swift raw/native allocator traffic and fwp's directly mapped managed heap are
separate observations; individual Swift ARC counts remain unmeasured. Preserve
all archives and immutable source tags. The Intel compiler abort is unresolved;
a recurrence needs source/input diagnosis, not speculative allocator changes.
