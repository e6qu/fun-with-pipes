# Session handoff

All seven PLAN.md areas remain open. Remove tracing, prefer ownership and borrowing,
and reserve ARC for necessary sharing. JIT is excluded.

## Current action

**Next:** publish the consolidated repair batch, then require passing six-host
reruns and inspect their saved binaries. All initial jobs have been audited.
Keep active PR #205 unchanged; this is a separate preparation branch with no PR.

Worktree `/private/tmp/fwp-array-list`, branch `array-list-preparation`, starts at
`51c295e02a8037f985fe9f662b8e1000fcd97798`. #205's production run `40037426686` and
docs run `40037426647` remain the current delivery gates. Primary handoff records
their latest audit and prepared merge/inspection helpers.

Saved generated C for the 129-coordinate descent case builds 129 input list
nodes before `array.from-list`, and 129 output nodes before `show`. Its measured
459 managed allocation requests include these temporary values. Removing them
is a proposed compiler improvement, not measured support yet.

Planned checks: constant numeric input construction; direct list-style text and
JSON output from numeric arrays; empty/sliced/aliased arrays; unchanged formatting,
effect/trap order and older values after updates; managed/raw cleanup and actual
machine code on all six native targets. Numeric constants may use existing static
storage; this must not retain dynamic values permanently. Report static-data,
stack/code size and allocation costs, and compare complete programs before making
speed claims. Keep resource-owning/boxed cases outside a transformation until
its lifetime/representation proof covers them. No new surface syntax is planned.

Implementation is not accepted yet: fusion recognizes immediate numeric
`array.to-list | show` / `json.write`; native/interpreted list-style display reads
the borrowed array directly. Its internal primitive has an explicit nonescaping
borrow/fresh-string contract. Fixed-width numeric literal lists consumed by
`array.from-list` become existing static array constants; target-sized integers
are excluded. The display writer's unused argument was removed. Constant arrays
exposed an existing type reconstruction error: an array map/fold could reconstruct
a List type, and iterator fusion could lose the array type entirely. Both now
derive the correct array type; the new allocation checks exercise those neighbors.

`tests/array_text.rs` now adds 120 semantic outcomes across modes/layouts/settings and
48 allocation/cleanup outcomes, including eight deliberate missing-release
controls. Each balanced allocation case repeats 64 times. Tests compare raw and
optimized interpreters with O1/O2 native programs. The new target is assigned to
regular macOS and native Windows; Linux discovers all targets. The preparation
[protocol](measurements/array-text.md) fixes expectations before measurements.

Local guarded checks: reference fixture execution with the accepted #199 compiler
passed (0.26s; syntax/reference behavior only, not the new compiler); frozen
primitive inventory passed (1.37s, 392 declarations/382 symbols); all fourteen
native-runner coverage and failure controls passed (7.70s). Formatting passed.
The initial source `5f3efa1ea15065c8f9ced617309b76112d096e7a` compiles and passes
lint, but all six native jobs fail the same three checks. Full logs and all
other target results are retained in `fwp-array-preparation-audit.json`. The unit
tests and six other integration targets pass on every host; all three failures
are addressed together below.

The repair keeps the dynamic-primitive ownership probe on explicit unfused input,
repeats the actual workload behind its cached entry, and lets fusion reach `show`
inside a unary `print` call without moving earlier effects. A new shared-list
case checks that multiple consumers retain their list. Generated C is now saved
before structural assertions, and a missed lowering no longer hides later cases.
The focused macOS ARM64 job will also save its compiler for bounded diagnostics;
full builds remain on GitHub.

The repaired observer passes local production Clang O1/O2 checks using the accepted
#199 compiler (3.58s): 260 requests for the original 129-element program, zero
retained managed/text-buffer storage, and both omitted releases detected. This
checks instrumentation, not the new Rust optimization. Adding actual reference-count
increments to the same observer also passes all six controls (3.17s); optimized
cases require zero increments. This does not measure every bookkeeping instruction.
An actual intermediate
representation dump confirms the nested unary display case (0.26s). New compiler
runtime checks and binary inspection still require CI.

## Scope and verified preparation

The formatter reuses already-rounded scientific digits for fixed decimal output.
The [report](measurements/float-text-results.md) explains why this saves work,
all input timings, matching-model acceptance, the remaining C/Rust gap and the
larger stack/code costs. Allocation counts and per-solve live storage are unchanged.
Six native jobs pass at `550ef3157720`; twelve saved cases per host cover exact
ordinary/JSON output, rounding and deliberately corrupted results. The first
Windows attempt found an LF-only summary assertion; its repaired line parser
passes both Windows hosts. Runtime and measurement sources did not change.

Timing sources `5476466183f7` and `d7ad3e55f386` have identical runtime and benchmark
inputs. Runs `40027402138`, `40027406689`, `40032008445` retain five measurements,
including unmatched CPU models. Matching pairs satisfy the original 2% copy-control
limit and 5% largest-case reduction on both architectures. All 600 timing/control
images and 72 native correctness images passed independent binary inspection.
The first mixed workflow retains its old Windows failures; its timing jobs passed.
Later six-host correctness evidence verifies the repair. Do not label that entire
initial workflow successful or replace final-head gates with preparation evidence.

The [output diagnostic](measurements/descent-output-longer.md) separately compares
ordinary printing with a shared checksum consumer. It passed 676 binary checks;
nine of twelve input/host pairs pass repeated controls. Three smaller AMD64 pairs
remain inconclusive and cannot set budgets. Initial results and all samples remain
linked. Checksum work is not pure arithmetic or isolated formatting time.

## Accepted preceding delivery

[PR #204](https://github.com/e6qu/fun-with-pipes/pull/204) passed nine production
jobs, docs and 6,966 binary inspections at `80c89baa53567839dce0599d88f18d5791285943`.
[History](roadmap-history.md#derivative-storage-arrays-and-borrowed-callbacks-pr-204)
and the [inspection record](measurements/derivative-array-cleanup-2026-10-24.json)
retain source, merge, logs and six-host outcomes. Cleanup checks remain required
when the runtime changes; they do not establish complete removal of tracing.

## Resume rules

Use `python3 scripts/local-guard.py COMMAND...` serially; full builds, suites and
benchmarks stay on GitHub. Keep at least 64 GiB free disk and never raise limits.
Read receipts before mutations. Preserve failure evidence, unique results and
immutable source tags; prune only inspected duplicate caches after remote checks.
Keep one active PR. Publication and squash merge after passing final gates are
authorized; every commit is one line, at most eighty characters, without trailers
or attribution. Python package initializers stay empty; imports stay at file top.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |
