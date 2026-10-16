# Session handoff

Updated 2026-10-16. This preparation worktree is `/private/tmp/fwp-zip-map`,
branch `fuse-numeric-zip-maps`, based on `1850f832`. The only active delivery is
[PR #149](https://github.com/e6qu/fun-with-pipes/pull/149), ready at
`5748f7496a8f1db0e93145c53e380a0703affc2f`. Exact-head production
[38841142126](https://github.com/e6qu/fun-with-pipes/actions/runs/38841142126)
and [docs 38841118993](https://github.com/e6qu/fun-with-pipes/actions/runs/38841118993)
are queued. Its CPU/collector diagnostic passes all four hosts; final acceptance
is still required. Its authoritative handoff
is in `/Users/zardoz/projects/fun-with-pipes/docs/development-state.md`.
Do not open another PR or replay parent preparation. Transfer only changes after
`1850f832` after the current PR passes all nine production jobs and docs and merges.
Standing authorization covers fixes, publication and squash merge with an explicit
single-line subject of at most 80 characters and an empty body. No attribution or
trailers. JIT is excluded. Full builds and measurements run on GitHub; bounded
local checks use `python3 scripts/local-guard.py COMMAND...` without raising limits.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion. None of its seven whole areas is done.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Accept process/terminal ownership, then remaining deployment boundaries |
| 2 | In progress | Remove immediately consumed numeric zip pairs/list nodes |
| 3 | In progress | Measure resulting calls, instructions and reference-count traffic |
| 4 | In progress | Reduce measured derivative initialization intermediates |
| 5 | Pending | Broaden CPU kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Retain repeated timings, CPU time and normal-collector profiles |
| 7 | In progress | Preserve maintained applications across ownership changes |

Next: implement and check numeric `zip | map` elimination, then measure it against
the same compiler with only this transformation disabled. Continue monitoring
#149 independently; queued CI gates merging, not preparation.

## Selected change and acceptance

The existing four-host derivative allocation profile attributes 4,194,304 of
25,184,777 managed requests to temporary zip pairs and their list nodes. Array
construction work in #149 removes a different group of 2,097,152 requests.
A tiny accepted-compiler IR inspection confirms derivative initialization builds
numeric pairs and immediately maps a known callback over them.

Recognize immediate `map f (zip ys xs)` with inline numeric inputs and a known
callback. Use existing `zip-with` ownership machinery and a specialized callback
body whose pair fields can stay local. Preserve eager input order, shorter-list
truncation, callback effects/traps, aliases and result cleanup. Managed inputs
remain outside this initial proof, because changing their last-owner timing could
change resource behavior. No new surface function or syntax is needed.

Allow a single-use intermediate to reach its immediate consumer through record
fields only when preceding fields are plain locals/constants. Do not cross
calls, resource regions, effects or traps. Inspect actual generated C/machine
code: removing one list must not silently replace it with tuple boxing or
indirect callback calls. Consider borrowed flat callback arguments only after
this first measurement identifies remaining reference-count traffic.

Acceptance compares raw and optimized interpretation with native O1/O2 tracing
and ARC, including empty/unequal inputs, order, checked failures, captures,
returned tuples/managed results and excluded managed inputs. Count allocations,
retains and final storage with aliases and deliberate cleanup omissions. Run
six native hosts, four-host repeated derivative/direct measurements, then the
full nine production jobs plus docs for the final combined delivery. Performance
and peak memory must be measured; fewer requests alone do not establish speed.


## Preparation checks and adjacent cleanup repair

The isolated pass compiles against the existing local library after fixing a
borrow in the first-operation traversal. Small ordered/captured/derivative cases
match the accepted #148 raw interpreter in tracing and ARC (7.13 s), with the
newer mapped-array primitive disabled because that older library cannot emit it.
Six fixture groups match raw interpretation under native tracing stress (7.07 s).
Their explicit expectations preserve actual argument order: the zip argument
prints before its piped subject. These are partial compiler checks, not acceptance
of the rebuilt compiler.

Allocation probes with empty/unequal/129-element inputs and retained aliases pass
tracing/ARC and a missing-result-cleanup control (5.28 s). For 129 pairs, requests
fall from 390 to 131, requested bytes from 12,408 to 5,176 and retains from 129 to
zero. Final charged storage returns to the initial value. Native CI and repeated
workload performance remain pending; do not extrapolate these tiny counts.

Review found ordinary `zip` leaves its scratch and already duplicated fields
unprotected if a later retain traps. The batch now gives its partial result and
both pending fields explicit cleanup using the existing ownership helpers. Forced failure, real retain-overflow, aliases and three negative controls now
pass in edited C for tracing/ARC (4.12 s). The old helper fails the same probe
with leaked references (exit 248); the repaired helper passes. The six-host
changed-compiler suite remains pending. Managed zip inputs retain their original evaluation
path; this repair applies even when numeric zip/map fusion is disabled.


The transformation now runs after existing map/fold and map/array consumers.
Early zip replacement would hide their map input and reintroduce output lists;
there is a dedicated regression for that ordering. After this adjustment the
isolated pass compiles (1.09 s) and the six fixture groups pass again (7.22 s).
The full Rust test harness compiles against the existing library (0.26 s).
This is not a local full compiler build or acceptance of its code generation.

The new `zip-maps` six-host suite covers this batch and neighboring array, map,
ARC and derivative ownership. `zip-map-costs` compares the same compiler with
only `FWP_ZIP_MAP` off/on, keeping mapped-array construction enabled. It measures
128 numeric result lists before reducing them, 512 reverse derivatives and the
256-input nested derivative control. Retain eight alternating whole-process
samples, separate counts/peak/final memory, retained references, compilation and
binary sizes, source hashes and actual disassembly. This is fwp versus fwp, not
C/Rust parity. The measurement script parses (0.13 s); all timings run on GitHub.


Numeric producer bindings are preserved around the replacement; only inline
numbers and lists of inline numbers may extend through the callbacks. Managed or
resource-bearing bindings are excluded. A tiny version of the direct workload
matches raw/native output with the transformation off/on (2.29 s). This also
checks that the intended transformation is actually reached. The old zip cleanup
regression is reproduced before the repair, rather than inferred from inspection.

Current #149 docs pass at `5748f749`; the nine production jobs have begun running.
Keep this preparation separate until that delivery merges. No gate is waived.
