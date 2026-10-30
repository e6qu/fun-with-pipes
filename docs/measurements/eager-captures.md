# Eager captures in derivative programs

The comparison was published in `8a495a72` before implementation. All four matching-host measurements pass their frozen limits after independent
audit at the original sources listed below. Full CI exposed a mixed-record
return defect; its repair passes focused checks. The repaired-source recheck
retains one failed zero-update timing rule, so D2 acceptance remains open.
[PR #227 delivered the implementation](../roadmap-history.md#eager-captures-and-typed-numerical-loops-pr-227)
after all production, documentation and analysis checks passed; its user merge
does not close the failed performance requirement.
[The earlier scalar-recording experiment](descent-costs.md#scalar-recording-results-allocation-reduction-retained-speed-goal-open)
keeps its allocation reduction and failed timing result. Its limits are unchanged.

## Cost and implemented change

A partial application supplies some arguments now and returns a function waiting
for the rest. For example, `add (calculate ())` must evaluate `calculate ()` when
the function is made, even if that function is called later. It must not repeat
that calculation, move it past another effect, or delay a failure.

The optimizer substitutes a function used once when its captured expressions can
safely move. Computed captures often prevent this, leaving temporary closures and
runtime dispatch. A diagnostic of the retained three-coordinate, one-update
Rosenbrock C program at `98b252a8` counted 111 visits to owned dispatch and 22
partial-application allocations per solve. All 512 complete outputs matched the
ordinary executable. This is a local Clang O2 operation count, not a timing or GCC
result, and it does not count every possible dispatch convention.

The change binds complete eager capture computations at their original
point, once, in left-to-right order. It reuses the existing `bind_captures` helper
in `src/opt.rs`, already used to specialize known callbacks. The resulting known
partial application can then be substituted without moving its computations.
This exposes existing direct-call and callback specialization opportunities.
Do not raise inlining limits, add AD-specific wrappers, or change runtime APIs.

Only descend through known unsaturated applications. Do not enter an arbitrary
call returning a function. Keep original resource anchors; reject transformations
that cannot preserve observable cleanup or determine capture types. Rejection
must discard all newly prepared bindings/locals and leave the expression intact.

## Correctness requirements

Compare unoptimized interpretation, optimized interpretation and native GCC and
Clang O1/O2. Cover eager effects before input evaluation; two distinct failures
where the first must win; captures evaluated once; nested closures; aggregate
captures; unknown and saturated function-producing calls; and observable resource
or weak-channel lifetimes. Add structural checks that accepted examples expose
known calls, while rejected lifetime cases remain untransformed.

Preserve numerical operations and their order. Do not include F64 conversion
elimination: current raw/native NaN payload behavior does not justify an
all-engine bitwise-identity claim. Preserve mixed/stale-node and tape-full
rejection, exceptional/cancelled cleanup, workspace reuse and nested derivatives.
Use the existing test targets where possible; full builds and suites run on CI.

## Comparison fixed before implementation

Use [the repeated scalar-recording protocol](descent-costs.md#fixed-scalar-recording-acceptance-rules):
all six coordinate/update cases, current-result and retained-history programs,
complete output checks, two independent sessions on each matching Neoverse-N2
and EPYC 7763 host, identical compiler settings, explicit workspace/stack/reuse
settings, all 98 timing rounds and every individual process observation.

Build candidate and reference compilers from the same source. The reference
reverts only this experiment's eager-capture transformation to the existing
constant-only transformation. Both keep scalar recording's no-escape proof.
Archive that exact patch, source/file hashes, toolchains and both compiler hashes;
reject missing, partial or different reference changes. Keep C/Rust explicit
formulas as contextual peers; they do less work than general differentiation.

For each case and form, require all of these without changing limits afterward:

- Candidate/reference median whole-solve time is at most **0.95** with updates
  and **1.02** with zero updates. The identical-code control stays within **2%**;
  an unstable control makes the session inconclusive, not accepted.
- Managed allocation requests fall for every case with updates and do not rise
  with zero updates. Retains and peak managed charge do not increase. Every
  managed/raw ledger ends at zero. Raw tape profiles and release checkpoints
  match the reference; no retained dead scopes or enlarged workspace cache.
- Instruction sections grow by at most **1,024 bytes**, and the largest reported
  static frame grows by at most **128 bytes**, for each ordinary program.
  Retain all frame entries and whole binary sizes, not only the maximum.
- Complete outputs, operation/trap order, precision and lifetime controls pass.
  Counters and optional phase diagnostics are separate from timed executables.

Audit all failed criteria after preserving every observation. A failed candidate
must remain failed in the report; do not infer a speedup from fewer closures or
rewrite the earlier rejected scalar-recording result. This experiment can close
only its named D2 budget. Final delivery still requires all nine production jobs,
documentation and both compiler-analysis hosts on the final commit.

## Running the checks

Dispatch `Numerical and ownership evidence` with `suite=eager-captures` and
`native_runner=all` for focused GCC checks on Linux ARM64/AMD64 and Clang checks
on ARM macOS. This does not replace the final native matrix. After those pass,
use `suite=eager-capture-time`, `native_runner=all` and `comparison_session=both`
for the four predeclared matching-host sessions. A host rejected before timing
can be replaced with its specific native runner and `comparison_session=1` or
`2`; keep its original rejection. Missing sessions and unsupported hosts fail
explicitly. No session is selected implicitly.

`prepare-capture-reference.py` restores the original capture block and helper in
an isolated checkout of the same source. It verifies that only `src/opt.rs`
changes and scalar ownership stays identical, then records both source hashes,
the patch and reference compiler hash. The reference tests check the production
source against preparation `8a495a72` and reject incomplete or changed transforms.
Both comparison protocols use the shared budget evaluator with an explicit
comparison name; their allocation requirements remain distinct. The original
scalar-recording archive and every rejected timing case still pass their audits.

## Results

The comparison uses the Rosenbrock objective, a sum over adjacent coordinates:
`100 * (y - x*x)^2 + (1 - x)^2`. Inputs alternate -1.2 and 1.0. Each update
computes its gradient and subtracts `0.001 * gradient` from the coordinates.
The current-result program keeps the latest vector; the history program retains
every update. Candidate and reference compute the same derivatives and outputs.
The reference disables only eager-capture binding; both keep #226's stack
recording. C/Rust compute explicit derivative formulas using two reusable buffers,
so their timings do not isolate compiler overhead from general AD work.

Each timed process repeats a complete solve and writes every final vector.
There are 32,768 / 512 / 32 / 4 / 32 / 8 solves for the six rows below. Each
round sums seven fresh process durations per implementation; medians use all
98 rounds after two warmups. Timers include process startup, calculations, output
and cleanup. Profiled allocation/memory runs and diagnostic phase timers are
separate. See the [retained reports and artifact index](eager-captures-artifacts-2026-10-29.json)
for every process observation, compiler flag, output and file identity.

Ratios below are **candidate time / reference time**, covering both forms and
both independent sessions per architecture. For example, 0.28 means about 72%
less elapsed time for that workload, not universal language overhead.

| Coordinates / updates | ARM64 ratio range | AMD64 ratio range | Current-result requests, reference → candidate |
|---|---:|---:|---:|
| 3 / 0 | 1.002–1.006 | 0.992–1.012 | 65,539 → 65,539 |
| 3 / 1 | 0.859–0.873 | 0.849–0.869 | 58,372 → 26,116 |
| 3 / 199 | 0.372–0.384 | 0.416–0.434 | 713,284 → 312,100 |
| 3 / 1,999 | 0.355–0.372 | 0.399–0.410 | 895,564 → 391,816 |
| 33 / 199 | 0.286–0.292 | 0.308–0.324 | 7,399,714 → 2,604,610 |
| 129 / 199 | 0.280–0.299 | 0.336–0.337 | 7,199,170 → 2,485,258 |

Requests count one process, including its repeated solves and cleanup; they are
not bytes or requests per solve. The largest current-result case uses 65.5% fewer
requests. Both forms meet the allocation rule. Retains and peak managed charge
never increase; final managed and raw tape storage is zero. Raw tape profiles
and every release checkpoint match the reference, with workspace reuse on/off.

The byte-identical timing control varies by at most 1.22% (limit 2%). Zero-update
ratios remain visible; they pass the separate 1.02 limit. Instruction sections
shrink by 7,376–16,208 bytes on ARM64 and 5,504–14,864 on AMD64. The largest static
frame changes by -192 to 0 bytes on ARM64 and -160 to +16 on AMD64, within the
128-byte growth limit. All frame entries and whole binary sizes are retained.

For 129 coordinates and 199 updates, the current-result process medians divided
by seven processes and eight solves are 9.59–9.60 ms per solve on ARM64 and
11.40–11.43 ms on AMD64. This includes each process's amortized startup/output
cost. The same case still takes 43.9–44.0 times C's time on ARM64 and 55.8–58.3
times on AMD64. Removing temporary closures improves general AD substantially;
it does not make automatic recording equivalent to a handwritten derivative.

## Verification and source identities

Full run `40901634818` at `56528ffb` fails two ARM macOS REST cases. An authorized
DELETE returning an empty reply crashes natively, though both interpreters return
204 correctly. A direct record was split into fields before a `match`, then read
as a boxed local because another branch could fail. The C generator repair keeps
each branch in the caller's field-return context. Regression cases include
dynamic record returns, caller aliases and exceptional cleanup. The repair at
`694e31b7` passes focused run `40909968650`: 333 tests/22 summaries, lint and the
raw interpreter corpus on GCC ARM64/AMD64 and Clang ARM64. Every full log is
audited. Both original Linux and both regular macOS jobs fail only the same two
REST cases; both Windows and both ownership jobs, plus benchmarks, pass.

The [repaired-source recheck](eager-captures-recheck-artifacts-2026-10-29.json)
retains four complete sessions: ARM 1/2 in `40912310643`, AMD 2 in `40912523280`
and AMD 1 in `40912773534`. The first three pass. AMD 1's zero-update history case
has candidate/reference ratio **1.022815765**, exceeding **1.02**. Other cases and
all memory/code/stack requirements pass; all four full logs and artifacts are
independently audited. The original accepted observations below remain intact,
but they do not erase this failure. [Timing diagnosis](timing-variation.md)
describes the next experiment; [host rejections](captures-recheck-rejections-2026-10-29.json)
retain every unmatched attempt. No limit is relaxed and no sample is removed.

Focused run `40871650124` at `89d0dfa1` passes 299 tests/18 summaries and lint on
each of Linux ARM64, Linux AMD64 and ARM macOS. All three full logs are audited.
The measurement commits have identical compiler/runtime/library/test source.

| Session | Source | Run | Job |
|---|---|---:|---:|
| ARM64 1 | `4ffeb0d2` | 40876515001 | 123456633689 |
| ARM64 2 | `4ffeb0d2` | 40876515001 | 123456633700 |
| AMD64 1 | `8703104d` | 40878172336 | 123462304392 |
| AMD64 2 | `4ffeb0d2` | 40876515001 | 123456633658 |

Hosts are four-processor Neoverse-N2 with GCC 13.3.0 and EPYC 7763 with GCC 15.2.0;
all use Rust 1.99.1. Original AMD session 1 received EPYC 9V45 and was
[rejected before building or timing](eager-captures-host-rejection-2026-10-29.json).
Its replacement changes only workflow selection and documentation; compiler,
measurement scripts, inputs and reference transformation are unchanged.

All four full logs, 368 binaries, 320 stack reports, complete outputs, individual
process timings and memory/phase controls are audited. Each first session also
passes 243 Rust tests in five targets; every session passes 22 Python checks.
The artifact index retains the exact reference patch/compiler and every file hash.
The documentation gate recomputes schedules, medians and all acceptance limits;
negative controls reject omitted sessions, relabeled sources/runs, changed
reference identities, altered samples and changed measured-source hashes.

This satisfies the selected experimental D2 budget. Final delivery still needs
all nine production jobs, documentation and both G2 hosts on the final commit.
The earlier scalar-recording experiment remains rejected for speed; this result
does not change its limits or erase its slower observations.
