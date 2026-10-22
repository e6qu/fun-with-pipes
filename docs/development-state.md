# Session handoff

## Current delivery

Main is `13680b82e6bd96371d0978bc6a23d5069f5adb93`, the verified squash merge of
[PR #193](https://github.com/e6qu/fun-with-pipes/pull/193). All nine production
jobs and documentation passed for `91502f538d2265f3f7afd8606760dfcc4a088005`.
The merge has identical files and a single-line message with no body or trailers.
Redundant same-tree push CI `39737137413` was cancelled. [History](roadmap-history.md)
records the manual-pointer and foreign-storage changes.

[PR #194](https://github.com/e6qu/fun-with-pipes/pull/194) is open at
`489d8414e68678e30829df525982ce8790a4aadc`. Production run `39737931809` and
documentation run `39737931776` are its exact-head gates. Documentation passes; all nine production jobs are
running with no failed step in the last audit. Receipt: `/private/tmp/fwp-194-final-acceptance.json`.
The delivery is branch `move-strings-and-repair-reuse`, worktree
`/private/tmp/fwp-string-map-delivery`. It groups:

- Moving unique strings through known map callbacks and reusing private ASCII
  case-conversion storage. Shared aliases keep their values.
- Correct age checks for large immutable allocations, preventing unsafe reuse
  after collection. Both repaired checks have deliberately broken controls.
- Real Windows reuse execution, reported native compilation failures and
  missing-compiler controls, replacing silent test skips.
- WASI map output, alias and physical-cleanup checks at O0/O2.

[The measurement report](measurements/string-map-ownership.md) explains the code,
comparisons and remaining costs. For 65,536 words, requests fall 248,807 → 226,961,
retains 138,250 → 72,714 and peak managed charge 7,794,440 → 5,465,713 bytes.
Larger-case ARC time improves 6.2–7.7%, but is still 2.57–3.05× C time and
1.98–2.12× Rust time. Smaller AMD64 ARC is 3.6% slower than previous fwp.
Code size grows. These are measured cases, not universal performance claims.

Next: audit this batch’s final CI, requiring all nine production jobs and
documentation for its exact final commit. Audit every failure and fix all known
causes together. Squash-merge only after passing gates, with an explicit subject
of at most 80 characters and an empty body. Verify the resulting message, tree
and parent, then continue the plan. Publication and merge are authorized.

## Accepted preparation and checks

The delivery replays four commits onto #193's merge. Its compiler/runtime match
native source `15ee3615d2df858f508ec459e6305fa163037917`; the final preparation
`66f4a2f6dc9a02baba7154ec5c81923df8d0db29` adds only WASI tests and documentation.
Final production acceptance is still required; preparation is not a merge gate.

| Check | Accepted evidence |
|---|---|
| Six native hosts | Run `39730741666`: 19 tests per host across seven targets, plus 176 Linux AMD64 unit tests; 228 inspected images and 180 interpreter/native comparisons. All six reuse tests execute on Windows. |
| Paired C/Rust comparison | Run `39731820120`: both Linux architectures pass; 48 native images and 24 WASI modules inspected. Previous-source C is recompiled on the same runner. |
| WASI ownership | Run `39733027038`: both Linux hosts pass 28 tests across four targets; eight map modules, their disassembly and missing-free controls inspected. |
| Local reuse-age probe | Guarded `/private/tmp/fwp-check-reuse-age.py`, 3.31s; saved C at O0/O2, protected exit 0 and broken checks exit 239/238. No local compiler rebuild. |
| Local WASI fixture comparison | Guarded `/private/tmp/fwp-check-string-map-wasi-preparation.py`, 3.00s; all five reference outputs match. This does not establish WASI execution. |

Complete samples, toolchains, inputs, memory and binary hashes are in the
[report data](measurements/string-map-2026-10-22.json). Earlier failures and slower
measurements remain there with their source revisions. Native/WASI acceptance
receipts and downloaded evidence live under `/private/tmp/fwp-string-map-*`.
The integration receipt is `/private/tmp/fwp-string-map-delivery-integration.json`;
#193's accepted merge is `/private/tmp/fwp-193-final-acceptance.json`.
Do not repeat completed downloads. Official WABT 1.0.42 is checksum-verified at
`/private/tmp/fwp-wabt-1.0.42/`; it provides the WASM disassembly Apple objdump lacks.

Use the primary checkout for serial bounded checks:
`python3 scripts/local-guard.py python3 SCRIPT`. Preserve 64 GiB free disk,
target data below 2 GiB, sampled RSS below 1 GiB and the 180-second deadline.
Delivery formatting, workflow syntax, documentation links and commit checks
pass through guarded `/private/tmp/fwp-ready-map-docs.py` (8.26s).
Full builds, suites and benchmarks run on GitHub. A comparison download hit the
deadline; checkpointed inspection completed in 5.94s without raising limits.
The primary checkout is detached at #193 with this live handoff as its only edit.

## Independent preparation: derivative storage

While #194 runs, branch `measure-derivative-storage` in
`/private/tmp/fwp-ad-memory` extends the descent experiment. It counts actual raw
parent/partial/adjoint/registry allocations, samples idle storage after every
backward pass, verifies physical shutdown release, and measures process peak RSS
separately with an uninstrumented executable. Extra profiles disable workspace
reuse; zero-update and 1,999-update cases extend the original selected dimensions.
No runtime optimization or total-memory improvement is claimed.

Guarded `/private/tmp/fwp-check-ad-raw-observer.py` passes in 1.43s against saved
generated C. Both missing-parent-free and missing-registry-free controls fail
with workspace reuse on and off. This is local observer validation, not evidence
for the current compiler or all platforms. The next independent check is the
runner-only `ad-application` suite on both Linux architectures; do not merge it
into #194 or open a second PR. Preserve the existing final-head gates.

## Roadmap status

| Step | Status | Area |
|---|---|---|
| 1 | In progress | Remove tracing; limit ARC. |
| 2 | In progress | Remove avoidable functional costs. |
| 3 | In progress | Meet measured machine-level budgets. |
| 4 | In progress | Improve autodiff time, memory and precision. |
| 5 | In progress | Validate CPU numerical kernels. |
| 6 | In progress | Establish comparable measurements and budgets. |
| 7 | In progress | Complete the finite application suite. |

All seven [plan](../PLAN.md) areas remain open. Default native execution still
uses tracing. Retained foreign callbacks, host owners and cyclic data remain
ownership work; performance and application acceptance also remain incomplete.
Keep the [application suite](application-acceptance.md) current and continue in
substantial related batches. JIT is excluded.
