# Direct calls through numeric record bindings

## Problem and selected change

These callbacks compute the same running sum:

```fwp
projected : (I64, F64) -> (I64, F64) -> (I64, F64)
projected = fn acc -> fn item ->
    ((acc | .0) + (item | .0), (acc | .1) + (item | .1))
destructured : (I64, F64) -> (I64, F64) -> (I64, F64)
destructured = fn (count, total) -> fn (n, value) ->
    (count + n, total + value)
```

For seed `(0, 0.5)` and input `[(1, 1.5), (2, 2.5)]`, both produce `(3, 4.5)`.
The second form currently leaves an indirect call in its worker and misses the
numeric fold optimization. Saved #241 C shows that boundary; a retained verified
#239 compiler reproduces its source IR:

```text
apply (let count = acc.0 in let total = acc.1 in known(count, total)) item
```

The callee and all arguments are known, but `Opt::apply` cannot pass through
field-reading bindings because its existing purity test excludes every field
read. The chosen change keeps the bindings first and exposes the inner call:

```text
let count = acc.0 in let total = acc.1 in known(count, total, item)
```

Extend only this application simplification for a valid field of a local, flat
record whose fields need no reference counting. Keep existing resource-frame
and binding checks. Do not change global purity, constructor arities, escaping
function layouts, collection representation or source syntax. Fields containing
managed/nested values and wide boxed numbers remain outside this new proof.
The existing direct-worker and fold rules still decide native representation.

## Requirements before implementation

- Keep each binding before later argument evaluation. Compare raw interpreter,
  optimized interpreter and native GCC/Clang O1/O2, including errors/traps,
  empty inputs, shared records and effectful callbacks.
- Accept tuple and named-record destructuring without rewriting user source to
  projections. Verify the expected direct worker and fold selection explicitly.
- Preserve constructor stages and computed captures. Reject field reads with
  managed/nested fields, invalid field indices or an unknown base in the local
  proof. Keep resource anchors, cached values and existing owner-release guards.
- Reuse exact fold probes: zero allocations for an empty fold, one 24-byte final
  record otherwise, no per-element retains, final live storage zero. Include
  deliberate omitted-release failures and real cancellation/allocation failure.
- Test the proof's boundaries and caller rewriting in existing Rust test targets;
  use the production Rust profile and GCC Linux ARM64/AMD64 plus Clang macOS ARM64.
- Retain generated source, executable probes and observations. Report allocation
  and call removal as such. This batch makes no elapsed-time claim and does not
  rerun the unchanged derivative timing sessions or waive their failed limits.
- Group the simplification, semantic/ownership regressions, docs and any full-CI
  repairs in one PR. Require all nine final production jobs and documentation
  before agent-initiated squash merge.

This is an existing direct-call optimization extended across a proved binding,
not a change to when a partially applied source function executes. Broader record
storage and heap-lifetime transformations require their own proof and evidence.

Preparation commit `e0280ee2` and tag
`roadmap/numeric-callback-bindings-protocol-2026-11-02` precede compiler edits.
The implementation extends `Opt::apply` only. Unit controls protect field/type
boundaries and constructor stages. Existing native probes now exercise tuple and
named-record destructuring, exact allocation/release counts, first-stage overflow
before a later effect, escaping aliases and cancellation. These new checks pass
on GCC ARM64/AMD64 and Clang ARM64 in run `41386463046`; complete validation
including the following repairs is still required.

## Cleanup repair found by full CI

#241 full run `41385349559` exposed a leak when a fused collection callback
fails. The generated loop executed before the caller's cleanup record was
installed. That record therefore could not release the original captured string
or input list during error recovery:

```text
Before: evaluate arguments → run inline loop → install cleanup → bind result
After:  evaluate arguments → install cleanup → run inline loop → remove cleanup
```

`FnGen::owned_hof` now returns an evaluated value. Ordinary calls install cleanup
when binding their call expression; inline map/set construction, mapped arrays
and `modify` install it before emitting the work. Argument evaluation order and
typed owner accounting stay intact. No collector or extra retention is added.

Small Clang O1 controls using #241's emitted C isolate the order change:

| Case | Live bytes after recovery, before repair | After moving cleanup before work |
|---|---:|---:|
| Captured map callback over a range | 32 | 0 |
| Captured set callback over a range | 32 | 0 |
| Captured set callback over a list | 160 | 0 |
| Captured state callback overflowing I64 | 16 | 0 |

These are causal generated-C controls, not validation of the new Rust compiler.
The unfused collection controls already return to zero. Existing collection
failure tests now include captured mapped arrays. A state-overflow test checks
raw interpretation, native O1/O2 with stack storage enabled/disabled, the exact
trap, typed cleanup and zero final live storage. It restores the observer's State
depth after unwinding so normal runtime scratch cleanup can finish.

Full CI also found C harnesses relying on entries remaining reachable through
`main`. Their directly called definitions now have explicit export roots. Runtime
application probes additionally expose an actual function value so generic entry
metadata remains present. Ordinary executable/interpreter comparisons, alias
checks and deliberate omitted-release failures remain enabled.
