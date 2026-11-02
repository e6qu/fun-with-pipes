# Direct calls through numeric record bindings

## Problem and selected change

These callbacks compute the same running sum:

```fwp
projected = fn acc -> fn item ->
    ((acc | .0) + (item | .0), (acc | .1) + (item | .1))
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
before a later effect, escaping aliases and cancellation. Native results pending.
