# Session handoff

All seven PLAN.md areas remain open. Remove tracing, prefer ownership and borrowing,
and reserve ARC for necessary sharing. JIT is excluded.

## Current action

**Next:** audit the remaining native and benchmark jobs, publish the string-copy,
iterator-state and measurement repairs together, then inspect passing reruns.
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
The focused macOS ARM64 job saves its compiler, when built, for bounded
diagnostics; full builds remain on GitHub.

The repaired observer passes local production Clang O1/O2 checks using the accepted
#199 compiler (3.58s): 260 requests for the original 129-element program, zero
retained managed/text-buffer storage, and both omitted releases detected. This
checks instrumentation, not the new Rust optimization. Adding actual reference-count
increments to the same observer also passes all six controls (3.17s); optimized
cases require zero increments. This does not measure every bookkeeping instruction.
An actual intermediate
representation dump confirms the nested unary display case (0.26s). New compiler
runtime checks and binary inspection still require CI.

The first repair, `c3a479d55a17e4a2830d03fd701051dab9468081`, failed Rust
compilation on all six hosts in run `40043545777`: the guarded mutable match in
`first_evaluated` caused E0505. No runtime tests ran. All logs are audited in
`fwp-array-repair-audit.json`. The next repair decides whether to descend before
borrowing the mutable node. A bounded check compiles the exact function and
expression enum: it reproduces the old error and verifies six ordering boundaries
with the corrected function. Unused payload types are opaque in this local
check; it does not replace full compilation. The optional compiler-artifact step
now runs only when the file exists, avoiding a second error after a failed build.

## Remaining repair and measurement

`4aadfc11a8c590c6e626bdb4f203ce55ca74c40e`, run `40044090119`, compiles.
All six complete native jobs pass the value/effect test and adjacent targets, but
report two allocation failures: JSON followed by `echo` copies the resulting
string, and an array iterator allocates two initial state records. The new
repair removes top-level string-display copies before ownership lowering and
puts array/index/accumulator directly in the iterator's state fields. Nested
string escaping remains unchanged. Added shared string examples and expanded
focused loop, iteration and string cleanup checks. All six full logs are audited.

The matching C/Rust experiment `40044793534` failed both jobs before timing;
both full logs are audited. It uses the same source. Its existing
helpers assume an empty static initializer and an unfused array-to-list display
sequence. Both assumptions need updating for the new compiler. A local check
with the verified CI-built compiler passes eighteen Clang O1/O2 full-output,
checksum-dump and omitted-coordinate controls after the script repair (8.64s).
This validates the scripts, not the new Rust optimization or GCC execution.
The original failed source and artifacts remain retained. No timings accepted.

Compiler and generated C are in `/private/tmp/fwp-array-borrow-diagnostics`,
with their source/digest in `identity.json`; use them only for bounded diagnosis.
The source archive is `fwp-array-borrow-failure-evidence/macos-15-40044090119-12539959368.zip`.
New raw/value and allocation/retention checks remain required on all six hosts.
The published formatter evidence belongs to active #205; see its worktree and
the primary handoff for delivery gates and verified measurement reports.

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
