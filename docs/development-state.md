# Session handoff

## Next action

Finish all of the following in the same [PR #167](https://github.com/e6qu/fun-with-pipes/pull/167),
then audit every final-head job and squash merge only after passing acceptance:

1. Complete cached-map borrowing and investigate the Xeon 8573C slowdown.
   Candidate `774d838c` is now integrated locally. Review found and repaired
   unnecessary tuple/variant boxing across `BorrowGlobal`; a new regression
   exercises both direct-result paths. Final Intel measurements and production
   acceptance remain required; do not infer a timing repair from count savings.
2. Add `==`, `!=`, `<`, `<=`, `>` and `>=` with arithmetic above comparison and
   pipes below it; preserve left-to-right evaluation and reject ambiguous chains.
3. Add general scalar math: inverse trig, hyperbolic functions, log/exponential
   variants and hypot, supporting the existing float formats without narrowing.
   The user selected scalar math rather than an autodiff expansion or infix power.
4. Add an interpreter REPL inspired by IPython: persistent definitions/imports,
   multiline entry, history, completion, type inspection and session reset.
   No JIT, and no replay of earlier effects when evaluating another cell.
5. Add a notebook UI with code/Markdown cells, dependency tracking and explicit
   handling of stale results and effectful reruns. The user also requested an
   ipdb-style interactive debugger and native disassembler, in this same PR.
   Add a scriptable debugger protocol and a Python SDK for execution events,
   breakpoints/stepping, frames/values and trace collection. Share this with the
   terminal debugger/notebook; document instrumentation boundaries precisely.
   The unanswered optional choice was resolved to a local browser notebook.
6. Keep tutorials, parser/compiler docs, benchmark methods and the live plan
   aligned; verify semantic changes against raw interpretation and native code.

Published checkpoint `ce55d194` passed focused run `39127659928`: formatting,
all-target Clippy, 18 selected Rust checks, six real Python SDK tests, and Chromium
notebook execution. Log audit found no failures, ResourceWarnings or leaked-process
warnings. SDK tests inspect native AMD64/cross ARM64 objects at O0/O1/O2/O3 with
C line mappings; cross objects are not executed. Actual desktop/mobile screenshots
were reviewed: readable cells, no horizontal overflow, safe Markdown as text.

The source-stepping compiler failures from `ec02ea2b` are repaired and verified.
New local changes extend coverage to tutorial semantics, real POSIX terminal
completion/history/multiline/interrupts, notebook stop/restart and rejected input,
and native SDK execution on the six production hosts. A stopped notebook run now
cannot silently start a replacement interpreter to execute its remaining cells.
Checkpoint `7b941c70` failed before tests: the terminal stop display borrowed an
event after moving it into its JSON envelope. Both the focused run `39128156407`
and all five measurement jobs `39128158656` report this same compiler error.
Every job log was audited; SDK/browser failures followed from the missing binary.
The display now runs before the move, without adding a clone. A separate SDK
regression preserves compiler diagnostics when debugger startup fails.
SDK documentation links were corrected; all 59 Markdown link sets and tutorial
copies pass (`/private/tmp/fwp-doc-audit.py`, guarded, 0.39 s). Guarded formatter
passed in 1.40 s and Python syntax in 0.22 s. Next: publish this coverage batch,
run the focused suite and a fresh five-host map measurement, fix every issue,
then run all final-head production gates. Full acceptance is still pending.

The notebook uses the explicitly installed Python package: `fwp notebook` launches
it, and `fwp repl --json` supplies the checked session. Runtime stdout/stderr are
captured separately, including child-task forwarding. Dependencies conservatively
include imports/types/traits; source edits mark results stale and never automatically
replay expression effects. The optional Jupyter-kernel choice received no answer;
work is proceeding with the recommended local browser notebook.

Local guard checks: primitive ownership inventory PASS (394 declarations,
371 contracts, 19 IR templates, three flat scalars, one reviewed symbol);
Python SDK syntax PASS; a tiny ARM64 C object confirms real LLVM disassembly
with C source lines. That probe exposed unsupported `--show-raw-insn`; removed
because LLVM already prints encodings by default. A guarded formatter hit a
process-group permission error; unchanged retry passed. Limits were not raised.

The obsolete documentation-head production run `39120276898` was audited with
no failed jobs (Windows AMD64, both ARM macOS jobs and benchmarks passed), then
cancelled to free runners. Docs `39120277029` passed. No merge has occurred.
Map measurement run `39125883230` at `085626f3` passed all five jobs. Guarded audit
`/private/tmp/fwp-audit-map-borrow-pr167.py` passed in 36.14 s, checking 80 actual
ELF/source/profile records, hashes and 24 balanced samples per variant. Raw data:
`/private/tmp/fwp-map-borrow-pr167`. Intel 8370C and 6973P-C are now measured:
joined borrowed/retained tracing ratios 0.9170/0.9357; combined new/old-separate
ratios 0.9685/0.9688. ARC combined ratios 0.9034/0.9305. Retains 2,000,001 → 1,
unchanged allocation/live-byte counts, zero final charge. Separate-layout tracing
borrowing is slower on both Intel samples (1.0630/1.0387): preserve those results.
The exact original Xeon 8573C is still unmeasured by this compiler; do not claim
that model's regression is settled. Raw reports and all slower cells are now in
`docs/measurements/cached-map-integrated-2026-10-18.json` and the benchmark guide.
All five job logs also show 12 focused checks each: 60 passed, zero failed.

[PLAN.md](../PLAN.md) owns the seven remaining work areas;
[design limits](design-limits.md) states feasible acceptance criteria.
Cycle/weak-reference APIs and guaranteed source tail-call elimination are proposals,
not implemented semantics. JIT is excluded. Default tracing removal is unfinished.

## Accepted baseline and workspaces

- Root: `/Users/zardoz/projects/fun-with-pipes`, branch `clarify-docs-and-benchmarks`, based
  on accepted PR #166 merge `de678a7d42af803948835cfbc43b4862b63164da`.
  This branch combines the documentation revision with the compiler and interactive-language work above.
  The local handoff records post-publication run IDs; fold that bookkeeping into
  any needed repair rather than restart CI solely for a status-only push.
- Preparation: `/private/tmp/fwp-collection-runtime-costs`, published clean compiler
  `774d838c8afccddf01cb2d3c0de498857c0d6f86`. Shared `target/debug/fwp` was built
  from this candidate, **not** the merged compiler. Record this when using it.
- PR #166 tested `91c8923f`: all nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/39109626103)
  and [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/39109626314) pass.
  All completed targets were audited: 3,670 passed, zero failed, 72 ignored.
  Merge files match; subject is one line without trailers. Duplicate postmerge
  run `39116485007` is confirmed cancelled. [History](roadmap-history.md#numeric-map-and-set-construction-pr-166)
  owns the detailed acceptance record.

## Documentation revision

The revision separates stable goals, current work and past evidence. It adds
[the real compiler pipeline](compiler-pipeline.md), including recursive-descent
parsing, precedence climbing, layout rules, desugaring, macro phases and limits.
[Ownership](ownership.md#proposed-cycle-policy) distinguishes current restrictions
from proposed scoped/weak ownership. [Tail calls](design.md#tail-calls-and-recursion)
distinguishes C-compiler optimization from a future native/interpreter guarantee.

The [benchmark guide](benchmarks.md) names inputs, compared implementations,
timers, samples, counter scopes and remaining costs. Historical prose is shortened;
measurement files, source identities and immutable preparation tags remain.
Accepted C/HTTP/REST/MCP/Wasm features no longer say verification is pending.
Lesson 10 uses an explicit Collatz loop; new lesson 22 explains recursion, loop
state, immutable sharing and cyclic graphs represented by node IDs. Both use
implemented features only. The `loop` library comment and generated reference
now state that callbacks can still recurse or retain growing data.

Focused local checks through the unchanged `scripts/local-guard.py`:

- `target/debug/fwp fmt --check` initially found lesson 10 formatting; the formatter
  repaired it and its README copy was synchronized. The expanded lesson 22 also
  needed formatting; final format checks pass.
- `python3 /private/tmp/fwp-doc-checks.py`: PASS (8.79 s). Both changed tutorials
  match their exact expected output under raw interpretation (`FWP_NO_OPT=1`) and
  native O1 in tracing and ARC: six executions. Compiler provenance is `774d838c`.
- `python3 /private/tmp/fwp-doc-front-end.py`: PASS (7.29 s), raw interpreter and
  native ARC O1 for lesson 11 and the pipeline guide's layout/macro/comptime/
  arithmetic examples: four executions.
- `python3 /private/tmp/fwp-doc-harnesses.py`: PASS (1.80 s). Compile only the two
  small documentation harnesses with root paths; regenerate/check the standard
  library reference, check all tutorial source/output copies, then formatting.
  An earlier existing-binary invocation selected zero tests and was not counted
  as validation; cached harnesses can contain another worktree's path.
- `python3 /private/tmp/fwp-doc-audit.py`: PASS (0.37 s), all 55 tracked/new
  Markdown link sets, tutorial copies/outputs and rewritten merge/test tree pairs.
- `python3 scripts/check-roadmap.py`: PASS (2.92 s), 106 immutable preparation
  pairs/tags, seven roadmap steps and commit subjects. `git diff --check` passes.
- Final staged audit `python3 /private/tmp/fwp-doc-final.py`: PASS (4.45 s),
  including all 55 Markdown files, immutable records, regenerated docs, tutorial
  copies, formatting and staged whitespace. Full production/platform gates
  remain required for this revision before merge.

## Prepared cached-map compiler

The internal `BorrowGlobal` expression borrows a cached numeric map across a
proved non-suspending read span. Lowering and verification reject unknown calls,
escapes and reentrant destruction. Nested continuation checks protect later reads;
initializers keep their original evaluation/failure/yield timing and cleanup.
Reentrant replacement releases the prior cached owner.

Candidate evidence, not full acceptance:

| Check | Result |
|---|---|
| Six native hosts, run `39112671024` | 120 focused tests pass |
| Five actual-compiler measurement jobs, `39112673197` | 55 checks pass; 80 executable/source/profile records audited |
| Collection binary report, `39116484410` | Pass |
| Earlier guarded local checks | Clippy; 35 RC tests; two cached-map tests; existing cached-value tests; collector/runner/workflow checks pass |

The large workload constructs 500,000 entries and makes two million queries.
Actual compiler output reduces retains 2,000,001 → 1 with unchanged allocation
counts and zero final charge. Same-layout medians improve 1.8–4.2% on the measured
AMD/ARM hosts. **There is no Intel result or full production gate for this candidate.**
Audits: `/private/tmp/fwp-compiled-map-borrow/audit.json`; scripts
`/private/tmp/fwp-audit-cached-map-candidate.py` (16.32 s) and
`/private/tmp/fwp-audit-compiled-map-borrow.py` (37.47 s).

## Unresolved measurements and limits

Xeon 8573C full-map tracing is 4.4–4.6% slower with joined storage in ordinary
runs, despite faster construction. Phase instrumentation changes the result;
it does not invalidate the slowdown. Use saved baseline run `39106005017`, source
`93cb93a0f717b317814ecfc162de0c2f516dbfbd`. [The guide](benchmarks.md#larger-maps-exposed-a-storage-layout-problem)
links both replays and the historical hand-edited borrowing prototype; that
prototype is not the actual compiler proof and does not settle the Xeon result.
Other numerical/derivative gaps remain in the guide, including slower samples.

Local work stays serial and bounded; full builds, tests and benchmarks run on CI.
A prior guard signalling `PermissionError` passed unchanged on retry; its OS cause
is unconfirmed. Never bypass enforcement. A prior disk refusal was resolved by
removing only verified regenerable disassembly, retaining binaries/sources/reports;
manifest `/private/tmp/fwp-regenerable-disassembly-cleanup.json` (3.413 GiB recovered).

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership/cycle contracts, tracing removal and reduced ARC |
| 2 | In progress | Functional intermediates, copies, counts and eligible tail recursion |
| 3 | In progress | Equivalent-work C/Rust gaps and actual machine code |
| 4 | In progress | Derivative precision, speed and storage/recomputation |
| 5 | In progress | CPU kernels and a device policy consistent with no JIT |
| 6 | In progress | Reproducible baselines, costs and regression budgets |
| 7 | In progress | Larger applications and actual browser execution |

Follow [AGENTS.md](../AGENTS.md) for fixed resource limits and delivery rules.
Require all nine final-head production jobs, docs and affected evidence before
squash merge; one-line subject ≤80 characters, empty body, no attribution/trailers.
