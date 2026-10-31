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

## How the code and stack check works

`scripts/check-state-range-size.py` emits the example above with fusion explicitly
off and on, using the same compiler. Native GCC builds use O2, no LTO, checked
fwp arithmetic, disabled floating-point contraction/fast math, and explicit
`x86-64` or `armv8-a` targets. A volatile function pointer keeps the input dynamic.
The ordinary runtime startup and cleanup remain in both executables. Raw and
optimized interpretation and native execution must agree for -3, 0, 1, 32, 128
and 4096; the native program checks released storage before runtime teardown.

The 5% limit applies to retained generated entries, workers, callbacks and their
numbered loop/ownership/argument helpers in the linked binary, including GCC
clones and runtime work inlined into them. Shared runtime functions are excluded;
the report also gives the entire `.text` section, so that exclusion is visible.
Identical symbol aliases count once. The stack report lists every compiler frame
and compares the largest component against the unchanged +64-byte limit. This
is not a whole-call-chain bound. Sources, commands, binaries, symbol sizes,
section sizes, stack reports and outputs are retained; no elapsed time is sampled.

## First focused run and repair

Run `41157639553` at `855f53ce` passed all new semantic, failure, cancellation and
rejected-shape checks on both GCC hosts and macOS Clang. The exact-cost test
found one extra 32-byte allocation: the initial loop tuple was boxed because
the generator treated its unit field as a nested record. Its existing direct
field entry supports unit as an ordinary value slot. The repair corrects that
eligibility check and its declaration; the two-allocation budget is unchanged.
macOS also failed two TLS-using targets because this focused workflow omitted
`FWP_OPENSSL_DIR`; the repair supplies the documented setting. Both Linux runs
passed all 225 compiler unit tests; macOS passed 224 and failed the TLS case.
These repairs and the code/stack budgets still require runner verification.
