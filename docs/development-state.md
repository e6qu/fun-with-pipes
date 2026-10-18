# Session handoff

## Next action

Next: audit every final-head CI job for branch `clarify-docs-and-benchmarks`, fix
any failures, and squash merge only after all required gates pass. Find its PR
with `gh pr view clarify-docs-and-benchmarks`. This delivery covers clearer plans,
historical records, parser/macro documentation,
examples and precise benchmark methods. Then integrate cached-map compiler
candidate `774d838c` into the next substantial delivery, measure Intel, and fix
the outstanding Xeon map slowdown. Do not infer a repair from allocation savings.

[PLAN.md](../PLAN.md) owns the seven remaining work areas;
[design limits](design-limits.md) states feasible acceptance criteria.
Cycle/weak-reference APIs and guaranteed source tail-call elimination are proposals,
not implemented semantics. JIT is excluded. Default tracing removal is unfinished.

## Accepted baseline and workspaces

- Root: `/Users/zardoz/projects/fun-with-pipes`, branch `clarify-docs-and-benchmarks`, based
  on accepted PR #166 merge `de678a7d42af803948835cfbc43b4862b63164da`.
  This branch changes documentation/examples; the compiler candidate is separate.
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
