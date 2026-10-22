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
documentation run `39737931776` are its exact-head gates. Documentation, benchmarks and all four Mac jobs pass;
both Linux and both Windows jobs remain running, with no failed step in the last audit.
Receipt: `/private/tmp/fwp-194-final-acceptance.json`.
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

## Independent preparation: command ownership and derivative storage

Branch `measure-derivative-storage`, worktree `/private/tmp/fwp-ad-memory`, is
based on #194. Keep it as preparation until #194 merges; then deliver this related
batch as one PR. Published source is `47359a129a246bb4e508e92dd2cd09ff9bc75ba5`;
the working tree adds test recovery, CI repairs and accepted measurement reports.

The derivative experiment at `be8d87f0e56cb6bb496716d102b0b89bff6d9000` passes
both Linux jobs in run `39739049666`. All 104 executed images, their disassembly,
hashes and deliberately broken cleanup controls were inspected. Its report
separates managed charge, raw tape buffers and process RSS. The three-coordinate
case keeps 1,792 raw bytes between updates at both 199 and 1,999 updates, and frees
them at shutdown. Timings are mixed, including a 5.3% slower ARM loop. This adds
measurement evidence, not a runtime optimization or C/Rust parity claim.
See [results](measurements/ad-application.md); acceptance and inspection are in
`/private/tmp/fwp-ad-memory-acceptance.json` and
`/private/tmp/fwp-ad-memory-evidence/be8d87f0e56c/inspection.json`.

Command changes remove the missing-compiler interpreter fallback, pass explicit
ARC/tracing settings through run/exec/test/serve/pipe, prove every native test
entry and free caught errors/formatting buffers. Explicit pipeline `--native`
overrides `FWP_RUN=interp`. Tracing remains the default pending migration.

Run `39741271730` tests this on six hosts. Both Linux and both Mac jobs finish
with the same two failures: an unnecessary Rust borrow and a malformed ownership
fixture (`get` lacked its unit argument). Both are repaired locally. Both Windows
jobs timed out after their test targets had already finished: surviving server
children kept the workflow step open. AMD64 also exposed concurrent cache
publication replacing an executing image (`Access is denied`). The full logs of
all six jobs are audited; the other targets, including ARC standard-library
tests, pass. Receipt: `/private/tmp/fwp-native-commands-acceptance.json`.

Review also reproduced a real interpreter/native mismatch: native root traps and
exits stopped the entire test suite. The working tree adds per-test recovery,
unwinds owners, cancels/joins pending children and releases state scratch storage.
Interpreter test output is now visible, matching native execution. Child traps
and exits stay process-fatal in both engines. New coverage includes long owned
messages, negative exit codes, state scopes, pending children, injected root
cancellation and missing-free controls. Generated compiler behavior still needs
six-host validation; local runtime probes alone do not establish it.

Server tests now own their process lifetime and stop the Windows launcher and
native child together, including during assertion unwinding; they check that the
listening socket closes. Imports in the changed Rust command modules are at file
scope. The existing test monitor accepts explicit target lists and Windows
process-tree termination. The focused suite and Windows command gate use a
600-second completed-test deadline, preserve per-target logs and still run other
targets after a failure. Full Linux/Mac selection and limits remain intact.
Cache publication now holds a short OS file lock and preserves the first image;
another compiler discards its private duplicate. Windows cache hits request
attribute-write access for eviction timestamps without writable executable data.
New tests hold the publication lock while two compilers prepare their images and
require timestamp refresh on a cache hit. These need native runner validation.

Focused checks use `python3 scripts/local-guard.py python3 SCRIPT`:

- `/private/tmp/fwp-check-test-recovery-fixtures.py`, 0.98s: eight new root
  examples and two child failures in the saved interpreter; formatting passes.
- `/private/tmp/fwp-check-native-test-runtime.py`, 1.34s: direct current runtime
  at O0/O2, ARC/tracing, trap/exit/cancellation and owner/state cleanup pass.
- `/private/tmp/fwp-record-ad-memory.py`, 0.14s: accepted measurements recorded;
  identical per-update checkpoints compressed losslessly to count/value pairs.
- `scripts/test-native-test-runner.py` from the prepared worktree, 7.70s:
  all 13 checks pass, including real stuck-child termination, noisy hangs,
  continued targets and rejection of invalid focused selections. Windows
  executes these same controls in the next six-host run.

Next independent action: publish all audited repairs together and rerun the
six-host suite, then inspect every result and its actual binaries. Preserve
#194's final head. Do not repeat accepted
derivative downloads or regenerate its timings with a different source.

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
