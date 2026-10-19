# Design goals and practical limits

These are engineering goals with defined acceptance cases, not universal
optimality guarantees. Before selecting a performance change, name the programs,
inputs, hosts, semantic rules and measured budget it must satisfy. Set budgets
from reproducible baselines; do not invent a universal percentage or move a target
after seeing a regression. Correctness obligations apply beyond the benchmark set.

**1. Memory ownership is feasible, but unrestricted cycle reclamation is not
provided by ordinary ARC.** Immutable values, explicit effects and specialization
help infer moves and borrows. Runtime-dependent sharing still needs an ownership
mechanism; the compiler need not prove every safe lifetime to be useful. A channel
holding a callback that captures that channel can form an owning cycle. Closing
the channel currently preserves queued messages, so silently draining it would
change behavior. The cycle policy is a required design decision: scoped/group
owners, non-owning links or restrictions on escaping ownership are possibilities,
not adopted semantics. Arbitrary strong cycles, ordinary ARC alone and guaranteed
automatic reclamation cannot all be promised together. Rust also permits leaked
reference cycles; its memory-safety guarantee is not a leak-freedom guarantee.
See [Rust's cycle explanation](https://doc.rust-lang.org/book/ch15-06-reference-cycles.html).

Ownership contracts at foreign calls must state when the host releases or stops
using a value. Compiling fwp cannot prove arbitrary foreign code obeys them or
remove a JavaScript host's collector. Bounded memory means bounded by live data
and documented workspace/cache limits, not constant memory for a program that
keeps growing its results. Prefer fewer necessary heap objects, not zero heap
storage for unbounded or escaping data. Functional in-place reuse has research
precedent in [Perceus](https://www.microsoft.com/en-us/research/publication/perceus-garbage-free-reference-counting-with-reuse/);
that precedent does not establish fwp's callback/channel contracts.

**2. Zero-cost abstraction is a claim about named patterns.** Known curried calls
can become direct native calls without intermediate closures. An escaping
function with runtime captures needs those values stored somewhere; an unknown
target may need indirect dispatch. Sharing immutable old and new values can
require extra storage or bookkeeping. Fusion must preserve effects, termination
and trap order: a strict two-stage list traversal cannot always become one
element-at-a-time loop. Eliminate abstraction machinery where a proof permits it;
do not promise every higher-order program is allocation-free.

**3. Native performance is attainable; universal C/Rust parity and optimal
register/cache use are not acceptance criteria.** The existing C backend already
delegates instruction selection and register allocation to mature toolchains.
Finite registers require spills in some programs. Alignment can add padding;
smaller layouts can require extra loads or decoding. Optimize measured tradeoffs.
Checked overflow, observable traps and ordered floating-point arithmetic constrain
legal transformations. Compare against implementations honoring the same rules;
unchecked or reassociated comparisons remain useful only with that difference
explicit. [LLVM's vectorizer documentation](https://llvm.org/docs/Vectorizers.html)
describes the restrictions on floating-point reductions. It does not imply that
all strict arithmetic prevents vectorization.

**4. Efficient differentiation is feasible within its mathematical and storage
limits.** Reverse mode needs intermediate information, supplied by storage or
recomputation. Checkpointing trades memory for repeated work and requires safe
replay; fwp currently exposes it for pure steps. Gradient/Hessian outputs also
require space proportional to the values returned. Arbitrary nesting cannot have
constant cost. Preserve F128's defined arithmetic, without promising F64 speed or
exact real-number derivatives. Branchwise differentiation does not create a
derivative at a discontinuity. See the [AD survey](https://www.jmlr.org/papers/v18/17-468.html)
and the implemented [precision and tape contracts](numerics.md#reverse-mode).

**5. CPU numerics fits the design; portable GPU execution without runtime
compilation needs a narrower scope.** Improve known CPU kernels while preserving
their rounding/reduction rules; do not silently enable reassociation or fused
operations to match a different numerical contract. The present OpenCL path
compiles source at runtime. Loading an intermediate binary is not sufficient
proof of no runtime compilation: [OpenCL binaries can contain intermediate code](https://registry.khronos.org/OpenCL/specs/unified/refpages/man/html/clCreateProgramWithBinary.html).
An ahead-of-time device path would need supported toolchain/device artifacts and
verified loading behavior. Arbitrary runtime-created kernels on arbitrary devices
are not a promised extension. The decision between a bounded ahead-of-time path
and removing runtime GPU execution remains open; no JIT exception is authorized.

**6. Dependable measurement is achievable; noise-free or universal overhead
numbers are not.** Repeated same-host comparisons can distinguish useful effects
from ordinary variation. They cannot guarantee a speedup on every CPU, input,
allocator or compiler. Separate equivalent-work overhead from algorithm changes;
report allocation counts, peak live storage and process memory as different
quantities. A performance improvement can trade one of these for another.

**7. Representative application validation is achievable and must be finite.**
Strong ordinary inference and simple pipes do not require eliminating all type
annotations; explicit generic signatures already bound the language's inference
model. Improve diagnostics and libraries against real programs. Testing can
establish the maintained acceptance matrix, not prove every possible program
correct, fast, leak-free or easy to express. Keep larger coverage a maintenance
obligation after a defined roadmap milestone is complete.

## Related design work

[Ownership contracts](ownership.md#proposed-cycle-policy) explain callback and
channel restrictions, weak references and scoped cleanup.
[Tail calls](design.md#tail-calls-and-recursion) explain implemented self-tail
frame reuse and the limits of extending it to other calls.
The [plan](../PLAN.md) owns priorities; this page owns their feasibility limits.
