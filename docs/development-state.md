# Current work

**Next:** finish run `42440117133` at `066175c3a` (suite `fresh-array`),
then audit all four sessions and run the prepared C/Rust comparison against its
retained candidate images. The complete audit `128607338068` passes. Measurement jobs `128609245028`,
`128609245031`, `128609245033` and `128609245092` are queued. Keep the
compiler unchanged while these checks run; finish the docs in the same normal
PR. No PR is open yet. The candidate is **not performance-accepted**.

The preceding run `42439586418` at `a0c6fb084` stopped before timings: the new
diagnostic audit needed historical Git source, but its checkout was shallow.
Commit `066175c3a` adds `fetch-depth: 0`; source validation is unchanged.
The preceding complete safety audit passes all eight targets per host:
348/348/342 native images and 372 probe statuses each on ARM64 GCC/AMD64
GCC/Clang. Preserve these results; no native test rerun is needed for this
checkout-only repair.

Implementation head: `f21bf1390` (fresh F64 stores). Focused jobs are AMD64 GCC
`128603076444`, ARM64 GCC `128603076704`, and Clang ARM64 `128603076570`.
All three jobs pass, including every native target. Documentation run
`42438695310`, job `128603080353`, passes. Subsequent edits change docs, measurement/audit tools and the builder comment
clarifying destructor-free prefixes; executable compiler/runtime behavior is
unchanged. Preserve the implementation while its checks finish.

## Workspace

Branch `performance-roadmap-review`, worktree `.worktrees/recording-capacity-gate`,
base `bbcaafea00d6bf9e26feea60f90d8d440aa16d00` (merged #269). The root worktree
has unrelated changes; do not modify/reset it. #269's tested/merged trees match;
[all production, documentation and complete audits pass](measurements/computed-numeric-delivery-2026-11-08/README.md).
Duplicate post-merge run `42431179791` was cancelled after confirming no failed
jobs and equal trees (`3a6d513c61e331f86f10824b5a1926b4306db543`); it was still
occupying four runners. Acceptance relies on the earlier complete verified run.

## Roadmap status

| Step | Status | Evidence and remaining work |
|---|---|---|
| 1 | In progress | Reusable loop/array improvement plus complete docs/tutorial refresh. Fresh F64 output selected after three diagnostics; no accepted speed improvement yet. Finish verification/measurements and final gates together. |
| 2 | Pending | Broader lifetime/representation proofs selected from measured costs, covering at least two application patterns. |
| 3 | Pending | Structured differentiation across three objective families, preserving general reverse AD, nesting and precision. |
| 4 | Pending | Current Swift/C/Rust ownership comparisons, with phase timing and explicit memory boundaries. |
| 5 | Pending | Three end-to-end application/tooling paths and compiler phase/scaling costs; demonstrated usability repairs. |

[PLAN.md](../PLAN.md) owns acceptance. The user requests one substantial normal
PR combining milestone 1 and the complete documentation refresh, with focused
checks during development and one final nine-job production matrix plus docs
and complete audits. Do not use a draft to suppress CI.

## Current experiment

The [frozen investigation](measurements/shared-loop-array-costs.md) gives inputs,
selection boundaries, timing scope and the 10% computation target. Retain missed
limits; do not rerun unchanged timings for a pass.

| Experiment | Source / run | Result |
|---|---|---|
| Force callback inlining in generated C | `7a8d24c2e`, `42433452458` | Rejected. Largest manual/local cases take 1.11–2.04% more process time. [Retained results](measurements/loop-array-diagnosis-2026-11-08/README.md). No production forced inlining. |
| Cache captured array address/length | Implementation `fed65b39e`; measurements `f227830b08ff115f7b0711274545d6685b4be0be`, `42435795842` | Rejected and removed. ARM large maps save roughly 1%, manual derivatives 3–5%, local derivatives 0–1%; the 10% target is missed. [Complete audit and retained results](measurements/borrowed-array-metadata-2026-11-08/README.md). |
| Remove redundant fresh-output checks/count updates | Tool source `432d19715c87a5aae9681c4b7b3507847eb87a53`, `42437082841` | Both jobs pass. ARM large maps take 28–32% less computation; larger manual updates about 11% less. Most AMD copy controls fail. [Results](measurements/fresh-array-diagnosis-2026-11-08/README.md). Selected for production verification, not accepted yet. |

The replacement emits direct word stores only for known `array.generate` results
of exactly F64. Fresh output cannot be a view; F64 has no element destructor.
The existing protected builder still frees partial/completed output. No new
runtime helper, metadata capture parameters or source API. All input reads,
bounds checks, callbacks and other element types retain their existing behavior.

The **rejected metadata candidate's** focused run `42434812986` at `fed65b39e86fd6c422e9f46e4ab6adf39f7078a1`
passes AMD64 GCC `128591289751`, ARM64 GCC `128591289810` and macOS ARM64
Clang `128591289622`. Complete artifact/log audit `128594236952` in
`42435795842` passes. Original artifacts remain on GitHub.

Review job `128598127188` in `42437082841` passes all four original metadata
timing sessions, commands, sources, output bits, copied/native images and raw
samples. Compact artifact `13600670203` is verified and retained. Fresh-output
diagnostics `128599976437`/`128599976447` and their complete independent audit
`128607338068` pass. Those diagnostics do not verify the new compiler code.

Still needed for an accepted implementation:

- Two-session native timing acceptance; the active run includes separate memory,
  compiler/RSS and image/stack observations in each architecture's first session.
- Complete artifact audits, including those separate observations. Suite
  `array-review` audits a completed measurement run without repeating timings.
- C/Rust computation comparisons: suite `array-peers` takes the completed run and
  exact source as inputs. Its explicit templates, six-role schedule, separate process-RSS observations
  and complete raw-record audit are ready; native execution remains unverified.
- Full platform gates, documentation and their complete final-head audits.

## Documentation

All 24 tutorial READMEs have been reviewed and edited. Lesson 7 now returns
`fahrenheit` instead of mislabeling Fahrenheit as `celsius`; source and transcripts
change together. Its native session and formatter still need runner verification.
The standalone source/output-copy test passed locally before the last four
prose-only lesson edits.

[The documentation map](README.md) separates learning, reference, compiler work
and evidence. The benchmark overview uses #269's verified reports; #233 is dated
historical evidence. The sweep removes stale delivery instructions, old milestone
jargon and duplicate merge bookkeeping while preserving raw results/contracts.
The prose/navigation sweep covers the tracked Markdown inventory, including
historical reports, tool guides and fixture READMEs. Local link checks cover all
381 files; the full runner audit and tutorial execution still need final-head
verification. Original observations and acceptance limits remain intact.

Full documentation audit `42437087245`, job `128598137245`, **passes** at
`432d19715`. Later documentation edits need the final-head audit.
The generated library reference must be updated through its source/generator,
not edited manually. Preserve vendor licenses and source attribution.

## Checks and resource limits

- Guarded checks pass: twelve measurement controls, five diagnostic controls,
  Rust formatting, tutorial source/output copies and sparse/index documentation
  audit (381 Markdown files, five roadmap rows). The extended audit-tool controls, workflow syntax and all changed cross-links
  pass locally. No local compiler build or native suite was run.
- Disk previously fell to 58 GiB and the guard refused work; nothing ran below
  the limit. The latest reading is 86 GiB. Preserve 64 GiB free and use the guard;
  full builds, tests, benchmarks and large regeneration remain on runners.
- An earlier local full documentation audit stopped on a tracked but absent
  example in this sparse checkout. Use the complete runner checkout; do not
  materialize large evidence just to satisfy a local audit.
- `numerics.yml` is close to GitHub's 512,000-byte limit. Use
  reusable workflows for additions. Its first oversized dispatch failed before
  running and was repaired; no test coverage was removed.
- The saved loop C is
  `/tmp/fwp-269-loop-bench-evidence-e7965762490c89d2a39f5937fe8322291ea906fc-3757-loop-generated.c`;
  `/tmp/fwp-computed-129.c` is the earlier local-AD program. Their source
  observations select experiments, not accepted performance claims.
