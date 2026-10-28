# Measuring calls and recursion

These checks answer two different questions: what runtime work a convenient
source construct introduces, and whether a recursive computation can use a
bounded call stack. They are the F1–F3 work in [PLAN.md](../PLAN.md#3-functional-calls-and-recursion).
The implementation is under review in PR #222; results and acceptance are pending.

## Function-call pairs

[The fixture](../tests/fixtures/functional_costs.fwp) has eight pairs. Each pair
computes the same number. Its first version gives the compiler the function and
its use together. The second crosses an exported boundary: a native caller
supplies a callback or receives a value before using it. This prevents the fwp
compiler from assuming which function an unknown callback denotes or that an
escaped result can be destroyed inside its producer.

State is a scoped value updated by `modify` and returned by `run-state`. It is
not a global variable. Partial application supplies one argument to a curried
function and obtains a function waiting for the next argument. A closure is that
function together with any captured values it needs. An exported function remains
callable from outside the compilation unit. `Some` wraps a present optional value;
the record below has two named integer fields, `left` and `right`.

| Construct | Work for input `n` | Boundary control |
|---|---|---|
| Composed pipe | Add one, then double | Caller supplies the first function |
| Partial application | Capture `n` in addition, then add `n` | Caller owns the partial application before using it |
| Borrowed array callback | Sum `1` through `n` after mapping an array | Caller supplies the mapping function |
| Captured closure | Add three to captured `n`, then double | Caller owns the captured function before using it |
| Record and variant result | Sum record fields `n` and `n + 1` inside `Some` | Producer and consumer are separate exported calls |
| `each` | Add integers `0` through `n - 1` to State | Caller supplies the State callback |
| `fold` | Sum integers `0` through `n - 1` | Caller supplies the two-argument addition function |
| State loop | Count down and sum `n` through `1` | Caller supplies the loop step |

The test runs an unoptimized interpreter reference at `n = 32`, then invokes the
actual native exported entries at `n = 32` and `128`, compiled at O0 and O2.
Allocation requests, requested bytes, runtime application requests, record/variant
construction requests and effective count increments are recorded only during
the measured calls. Inputs are supplied by the native caller. All pairs must
use the actual saturated C entry signatures. Supplying fewer curried arguments
uses the runtime's owned partial-application constructor, including that allocation
in the control's counts. Captures here are integers or unit. Both versions must
return the expected results and restore the live-storage baseline after each call.
The normal root-completion operation runs after each entry; it releases empty
State scratch storage. That storage's allocation remains inside the measurement.
Unknown-call controls must execute a runtime application; known callbacks must
not add applications as input size grows. Existing alias, callback-failure and
caller-cleanup tests run alongside this matrix.

These counters describe operations requested by generated C. One application can
enter more than one runtime helper, and a C compiler can optimize a helper's
implementation. They are **not machine-instruction counts or speed measurements**.
The saved generated C, actual executables and disassembly allow inspection of
the entry and the worker it calls. A generic dispatch table present in an unused
part of a binary does not establish a cost on the measured path.

## Tail calls and weak handles

A tail call returns its callee's result without further work. Reusing its frame
means preparing the next arguments, releasing the old locals, and continuing in
the same function frame. Strong resource owners can make that cleanup observable.
Weak channel handles own only expiration metadata; they do not keep a channel
or its queued payload alive.

The new fixtures swap live and expired handles, duplicate aliases, carry handles
whose payload type is a callback, fail during next-argument evaluation and cancel
an active loop. Raw interpretation of small inputs supplies the semantic reference.
Native O0/O2 checks execute deep inputs, sample frame addresses at loop entries,
reject a deliberately broken stack observation, and check storage after cleanup.
Strong owners, unknown captures, resource regions and source-debugger frames keep
their existing restrictions. See [the design](design.md#implemented-lowering-and-its-limits).

## Mutual-recursion decision

The restricted prototype combines two matching scalar functions into one worker.
An internal integer chooses a body; each direct tail transfer supplies the next
integer and arguments. The original callable entries select their starting body.
Non-tail calls retain ordinary frames. Only I64, Bool and unit locals qualify.

The measurement computes parity by alternating two countdown functions. It compares
ordinary mutual calls, the grouped version of the **same typed intermediate code**,
and an explicit fwp `loop`. Each invocation counts down from 4,096 or 4,097;
1,024 invocations must produce checksum 512. Timed binaries contain no counters.
A common volatile native entry pointer prevents the C compiler from hoisting
repeated invocations. Wall time includes process startup, all invocations, checksum
output and cleanup. This is a comparison among fwp implementations, not C/Rust parity.

Before measuring, the runner records these acceptance limits:

- Eight alternating identical-binary control pairs must have median ratio ≤1.10.
- Grouped recursion must take at most 1.25× explicit-loop time at both O0 and O2.
- No managed allocations occur during the numeric entry calls.
- Increasing input from 16 to 4,096 adds at most 1,024 bytes to the observed stack
  range of the grouped and explicit loops. Ordinary O0 calls must grow, providing
  a control that can expose a missing transformation.
- The grouped executable's text section adds at most 1,024 bytes over ordinary calls.

Two warmups precede timing; candidate order rotates through eight samples. Separate
instrumented binaries collect function-entry counts and stack-address ranges.
Their instrumentation changes frames, so retained compiler stack-use reports from
the uninstrumented build are reported separately. Actual binaries, code, compiler
and hardware details, all samples and failed budgets are retained. A failed budget
requires repair or a documented rejection of the prototype; a completed workflow
alone does not accept it. Excessive timing noise or a missing ordinary-stack
control makes the comparison inconclusive; it cannot justify accepting or
rejecting the optimization. Synthetic controls test all these decision rules.

The focused runner suite is `functional-calls` in
[numerics.yml](../.github/workflows/numerics.yml). Full platform acceptance remains
the nine production jobs and documentation audit on the final PR commit.
