# Remove range-list storage inside a known State consumer

This is a proposed allocation change, not a verified optimization. PR #232 must
finish its own unchanged CI before this work is published as the next delivery.
The starting compiler is `05d96484`; its compiler/runtime match `d92939b8`.

## Program and source finding

`range 0 | run-state 0 (each (add | modify)) | .1` sums the integers from zero
through one less than its input. For input `4`, it returns `6`. `run-state`
establishes a scoped value, `modify` replaces it, and `.1` selects the final
value from the returned pair. The range list is temporary.

The existing functional-call fixture observes `n + 2` allocations and
`24n + 152` requested bytes for inputs 32 and 128. Generated C builds the list
before calling the State handler. Its known fold callback already uses direct
calls and a stack closure for `modify`. The `n` list nodes account for the
growing cost; two State setup/result allocations remain separately.

## Restricted transformation

Replace the list input to a known, single-use State consumer with its scalar
range bounds. Specialize that consumer's body to a counted loop; keep the
existing State handler. Do not introduce syntax, an alternate runtime memory
mode or compatibility wrappers.

The first scope is I64 bounds, I64 State, unit callback results and plain scalar
captures. The callback must consume its list exactly once through a known fold;
only trivial local bindings may precede it. Keep argument and capture evaluation
in their original order, including empty/reversed ranges. Evaluate each callback
once per index, in ascending order. Checked user arithmetic, nested State,
failure and cancellation retain their existing behavior. Advancing an index
below its exclusive I64 upper bound cannot overflow.

Do not relax general map/fold fusion's purity rule. This proof depends on a bare
range with no eager intermediate stages, no resource-bearing elements and no
second use of the list. Shared/reused lists, unknown consumers, resource captures,
wide integers and arbitrary generators remain outside this transformation.
A rejected proof keeps the language's ordinary implementation.

## Acceptance fixed before implementation

- The known fixture at 32 and 128 must request exactly two allocations and 152
  bytes, with one result box and no list-dependent count operations. Runtime
  application requests must not grow with input size. Keep unknown-call controls.
- Preserve raw/optimized interpreter and native results for empty, negative,
  reversed and near-I64-boundary ranges, ordered callbacks, captures, arithmetic
  traps, nested State, recoverable failure and cancellation. Observe restored
  storage before teardown; deliberately omitted cleanup must fail the observer.
- Check rejected shapes retain their list path and execute correctly. Test both
  stack settings and native O1/O2; the existing cost fixture also keeps O0.
- Compare selected entry and reachable worker code against the unchanged source
  with the transformation explicitly disabled. At O2, instruction bytes may grow
  at most 5%; the largest reported frame component may grow at most 64 bytes for
  the added scalar bounds/loop state. Report every value; this component is not
  a whole-call-chain stack bound. Retain actual native ARM64/AMD64 executables.
- Preserve the existing G2 compiler-analysis budgets and all final-head production
  gates. No new compiler build dependency on older fwp is allowed.

This task makes no elapsed-time acceptance claim. Any later timing comparison
needs its own declared inputs, peers, timing boundary and controls. D2/N1 and
previous failed identical-copy controls remain open; allocation savings do not
replace their requirements. Full builds and measurements run on GitHub after
the implementation batch; focused local work stays resource-guarded.
