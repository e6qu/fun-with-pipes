# Session handoff

## Next action

Next: publish the cached-map borrow candidate on `collection-runtime-costs`,
run six-host collection correctness and five-host actual-compiler `map-borrow`
measurements, and audit every failure and completed target. Use saved baseline
run `39106005017`, source `93cb93a0f717b317814ecfc162de0c2f516dbfbd`.
Integrate the verified candidate into existing PR #166, then require all nine
production jobs and documentation for its final commit before squash merge.
The Xeon timing regression remains unresolved; do not substitute allocation
savings or a hand-edited prototype for a measured repair.

## Workspaces and acceptance

The authoritative live handoff is the root checkout's
`/Users/zardoz/projects/fun-with-pipes/docs/development-state.md`.
Root branch `collection-build-storage` has PR #166 at
`91c8923fa68a754c29b85eb963f7f3b965b158d8`. Preparation is in
`/private/tmp/fwp-collection-runtime-costs`; its published measurement-only head
is `b5822671`. This candidate adds the compiler proof, native checks and actual-compiler
measurements. Its publication record identifies the resulting source and runs.
The shared `target/debug/fwp` is built from this compiler candidate, not PR #166.

At PR head `91c8923f`, production `39109626103` has three passing jobs and six
running; no failures in the audited completed targets. Documentation
`39109626314` passes. Six-host collection `39109625471` passes all 78 tests;
its binary-report run `39112360618` is dispatched. Replay `39109637834` passes
all four hosts and 64 binary checks but reproduces the Xeon regression.
These checks cannot accept the compiler edits in this preparation.

PR #165 is accepted as `69590778` after all nine jobs and docs passed.
[History](roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165) preserves
its exact sources and acceptance. All seven project work areas remain open.

## Candidate behavior and checks

`Expr::BorrowGlobal` is an internal ownership expression for a numeric cached
map and a proved non-suspending read span. Lowering and verification both reject
unknown calls, escaping uses and potentially reentrant destruction while the
borrow is needed. Nested continuation checks prevent an effect after an inner
read from invalidating a later outer read. Unused type slots left by inlining do
not introduce destructors. Initializers run at their original position, may fail
or yield before the borrow starts, and retain caller cleanup. Owned and borrowed
reads share setup; reentrant replacement releases the old cached owner.

Focused checks under the unchanged root `scripts/local-guard.py`:

- `cargo clippy --lib --bin fwp --test cached_map_borrows -- -D warnings`
  and `cargo test --lib rc::tests -- --nocapture`: pass, 35 tests, 0.86 s.
- `cargo test --test cached_map_borrows -- --nocapture`: pass, two native tests,
  15.74 s. Raw interpreter agreement; ARC/tracing; O1/O2; zero iterations;
  reentrant aliases; first-use trap cleanup; stress/verification; broken cleanup
  controls. ARC explicitly rejects reuse poisoning, which retains freed storage.
- Existing `caf_ownership` (three tests) and `inline_caf_ownership` (two) pass in
  the 32.47 s complete-target check. Its new trap fixture initially failed; it is
  fixed and passes in the later two-test run. No failure is relabeled as success.
- Tiny actual-compiler preflight: eight entries, sixteen queries, both layouts
  and modes, raw interpreter agreement, one retain instead of seventeen,
  six/eight allocation requests, zero final charge. Evidence/replay/runner
  regression suites (4/4/8), workflow lint and roadmap checks pass, 8.50 s.

Failures repaired during development: missing IR walker cases; proof selection
missing nested scalar calculations and unused type slots; an ARC fixture using
unsupported reuse poisoning; native fixture assuming boxed return signatures;
and a trap fixture injecting recovery without requesting a recoverable runtime.
Tests now use the actual numeric worker signature and task-enabled cleanup.
All native tests are scheduled on macOS and Windows; focused collection jobs
now require 20 tests per host. The collector and its regression fixtures agree.

## Measurements and outstanding issue

Joined construction removes intermediate lists/tuples and separate key/value
allocations. Successful six-host report `39109026750`, source `b8700990`, inspects
120 binaries: at 65,536 inputs, sets use four requests and maps five, zero retains
and zero final charge. Full 500,000-entry/two-million-query work uses six requests
rather than eight but the owned-read compiler still makes 2,000,001 retains.
[Benchmarks](benchmarks.md#building-numeric-maps-and-sets-without-temporary-lists)
records exact implementations, hardware, sizes, all samples and limitations.

The joined layout fixes EPYC sorting stalls, but Xeon 8573C full tracing remains
4.4–4.6% slower. The second replay reproduces that result; instrumentation changes
it. No cache/TLB mechanism or repair is claimed. ARM64 has overlapping/noisy full
query timings; slower samples remain recorded.

[Historical prototype](measurements/large-map-borrow-prototype-2026-10-18.json):
run `39110160483`, source `b5822671`, five hosts and 80 checked binaries. Hand-edited
queries remove two million retains and lower joined-layout medians roughly 1–4%.
Xeon 6973P-C combined tracing remains 1.014 times old separate/retained work.
This is not the compiler candidate or the original 8573C CPU. The current
`map-borrow` script instead compiles the real candidate and saved baseline with
the same native compiler, verifying identical fwp input, counts and 24 balanced
samples. Its required `--compiler` path and hash identify the measured compiler.

[Second replay](measurements/large-map-replay-two-2026-10-18.json) preserves all
four reports. Data-only audit directories `/private/tmp/fwp-map-borrow` and
`/private/tmp/fwp-map-replay-two` retain original binaries, sources and raw logs.
The respective temporary audit scripts are `fwp-audit-map-borrow.py` and
`fwp-audit-map-replay-two.py`. Update the former's expected source/run for actual
compiler evidence; do not confuse prototype acceptance with compiler acceptance.

## Delivery and local limits

Keep one active PR. Fix every encountered issue immediately, including unrelated
ones. Audit all failed/cancelled jobs and completed targets before each repair.
Queued CI only gates merging. Require the exact final head's nine production
jobs, docs and affected evidence. Squash subject is one line, at most 80 chars,
with an explicitly empty body and no trailers/attribution; verify message, parent
and tested/merged tree. Cancel duplicate postmerge CI and continue the roadmap.

Full builds, suites, benchmarks and large regeneration stay on GitHub. Local
checks are serial under the root guard: 64 GiB free disk, target below 2 GiB,
sampled aggregate RSS below 1 GiB, 180 seconds. Do not raise or bypass limits.
A disk refusal was resolved by deleting only 80 verified regenerable old `.asm`
files, retaining all original binaries/sources/reports; 3.413 GiB recovered.
Manifest: `/private/tmp/fwp-regenerable-disassembly-cleanup.json`.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership and tracing removal |
| 2 | In progress | Functional intermediates, copies and unnecessary counts |
| 3 | In progress | Controlled C/Rust gaps and actual machine code |
| 4 | In progress | Differentiation precision, speed and memory |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, equivalent-work comparisons |
| 7 | In progress | Representative applications and browser execution |

JIT is excluded, not deferred. A completed delivery does not complete the goals.
