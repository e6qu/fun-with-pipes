# Numerical calculations, derivatives and devices

Start with [tutorial 12](tutorials/12-numerics/README.md) for vectors, matrices
and derivatives, then [tutorial 20](tutorials/20-autodiff-and-devices/README.md)
for reverse differentiation and execution devices. This guide explains behavior,
precision, memory and implementation limits. Function signatures are in the
[standard library reference](stdlib.md).

A derivative measures local change in an output as an input changes. A gradient
is the list of those derivatives for a scalar output. A Jacobian is the table
for several outputs and inputs; a Hessian contains second derivatives of a scalar
function. Automatic differentiation (AD) applies arithmetic derivative rules
while evaluating a program. It avoids finite-difference estimates but still
performs floating-point arithmetic, with rounding and domain limits.

Numeric traits describe supported operations: `Ring` includes addition,
subtraction and multiplication; `Field` adds division; `Floating` supplies
functions such as `exp` and `ln`; `FromFloat` converts floating literals.
For example, this complete definition computes `ln(exp(x) + 1)`:

```fwp
soft : t -> t where Field[t], Floating[t], FromFloat[t]
soft = exp | add 1.0 | ln
```

The same definition can evaluate ordinary numbers, propagate derivatives or
build an array expression, depending on the chosen type. That reuse does not
make those computations equally expensive.

| Use | What the input type makes it do |
|---|---|
| `2.0 \| soft` | Ordinary F64 arithmetic |
| `2.0 \| derivative soft` | Carry a value and derivative through each operation |
| `[2.0] \| grad (head \| option.unwrap-or zero \| soft)` | Record operations, then accumulate derivatives backward |
| `xs \| tensor.lazy \| soft \| realize-on (CpuParallel 4)` | For a previously defined vector `xs`, build then evaluate an elementwise expression |

`head` returns `Option`; `option.unwrap-or zero` supplies a value for an empty
list. The reverse example deliberately uses only the first input. `xs` in the
last row is a placeholder for the vector from tutorial 20, not a global library
variable.

## Forward mode

`Dual[T] = { re: T, eps: T }` pairs a value (`re`) with its derivative (`eps`).
Arithmetic propagates both. `derivative` handles one input; `gradient` and
`jacobian` repeat evaluation for input directions. `hessian` nests dual numbers
to obtain second derivatives. This is useful when there are few inputs, or many
outputs relative to inputs. The implementation is library code, but its extra
arithmetic and values still have runtime costs.

## Reverse mode

`Rev[T] = { value: T, vertex: I64 }` pairs a value with a reference to its recorded
operation. A **tape** stores operations and their dependencies. `grad f xs`
records one forward evaluation, then walks backward to compute the gradient.
Unlike forward `gradient`, it does not rerun the function once per input.
It does allocate/store records and do extra backward arithmetic; one forward
plus one backward pass is not a measured wall-clock cost ratio.

| Function | Result and work |
|---|---|
| `grad f xs` | Gradient of a scalar output, one forward and one backward pass |
| `value-and-grad f xs` | Value plus the same gradient |
| `grad-vector f v` | Corresponding operation for a `Vector` input |
| `vjp f seeds xs` | Weighted output derivatives, one backward pass |
| `rev.jacobian f xs` | One row per output, a backward pass for each output |
| `rev.const x` | A constant that contributes no recorded dependency |

A **seed** weights an output before backward propagation. VJP means
vector-Jacobian product: the supplied output weights multiply the Jacobian.
An **adjoint** is the derivative accumulated for a recorded value during that
backward pass. A **primal** value is the ordinary value before considering its
derivative. Local partial derivatives are the weights on parent dependencies.

`ReverseScalar` supports the five float types and recursively `Rev[T]`. Base-float
reverse tapes accumulate adjoints in F64 and convert results back to the element
type. This is a precision choice, including for F128; it does not promise an
F128-precision gradient. Nested reverse levels keep typed weights and record
backward arithmetic on the enclosing tape. A `Float[T]` constraint alone does
not describe this nested behavior; generic reverse callers use `ReverseScalar[T]`.
Comparisons use primal values, so a piecewise program differentiates the branch
actually taken. This does not define a smooth derivative at every branch boundary.

### Lifetime and nesting

A `Rev` value belongs to the tape that created it. Using it after that scope
ends, combining different tapes at the same level, or using it from another task
traps. Nesting is supported: a backward operation can record into an enclosing
tape. `rev.jacobian (grad f)` expresses a reverse Hessian; `hessian` remains the
nested-forward helper. Nesting does not relax stale-token or task checks.

Scoped helpers release tapes on success, failure, traps and cancellation. Native
library teardown retires tape owners before the managed heap. Checked ARC needs
a proof that calls run within `ad.scope`/`ad.scope2`; raw unscoped operations and
unknown callback targets are rejected. Returned scalar tokens do not keep a tape
alive. Child tasks start independent derivative scopes.

### Tape layout and reuse

A base-float operation stores two 32-bit parent indices and two F64 local
derivatives: 24 payload bytes before adjoint storage, spare capacity and allocator
metadata. Inputs have node indices but need no operation records. Nested tapes
instead own typed derivative values and operation callbacks. A failed append
releases partially acquired owners without publishing an incomplete record.

The vertex token encodes `(tape id << 32) | index`, with −1 for constants.
The tape ID encodes `(generation << 16) | (slot + 1)`. Generation numbers prevent
an old token from naming a new tape in a reused slot; slots retire after generation
32767. At most 65,535 slots are representable. Node capacity is also limited by
the signed node index and native address width before allocation.

Backward processing validates requested outputs in order, seeds them in order
(including duplicates), then visits dependent records in reverse order. Numeric
adjoints retain all input slots and only the prefix through the last seeded output.
Later recorded nodes cannot affect earlier outputs because parents precede children.
Forward evaluation still runs in full, including possible failures. Nested tapes
skip only recursively inactive constant zeros; a numeric zero with an active
derivative must still propagate.

Native parent arrays share one allocation; numeric derivative arrays share another.
Growth preserves initialized entries and alignment, and only base pointers free
storage. This reduces allocation requests, not the 24-byte payload per operation.
Moving the second regions during growth adds copying, which can offset allocation
savings. The interpreter keeps its independent vector representation.

The active-tape table doubles capacity up to its slot limit. A cursor skips slots
known to be unavailable, while earlier released slots move it back. It preserves
the lowest-reusable-slot rule; arbitrary holes can still require linear search.
Table capacity remains until shutdown to preserve retired generation identities.

One detached numeric workspace may retain at most 512 KiB. Larger buffers are
released, reused adjoints are cleared, and empty or managed tapes do not evict a
useful numeric cache. `FWP_AD_WORKSPACE=0` disables that cache for comparison.
The table's capacity and returned managed gradient arrays are separate costs.
[Numerical benchmark reports](benchmarks.md) record cold/warm cases, allocations,
live memory and mixed timing results against earlier fwp implementations.

### Checkpointing

`xs | vjp-checkpointed {steps = 1000, every = 32} step seeds` differentiates
1000 applications of a pure `step`. `xs`, `step` and `seeds` must be supplied by
the program. `steps` must be nonnegative and `every` positive. The forward pass
saves values at segment boundaries; the backward pass recomputes each segment
and propagates its derivatives. This trades stored operations for extra work.

Storage is roughly `steps / every` saved values plus one segment's tape. Each
step is evaluated twice. Zero steps return the seeds without invoking the step;
seed length must match the final output. A forward trap stops before replay.
There is no implicit interval or automatic recomputation in ordinary `vjp`.

Each segment follows VJP precision: F64 adjoints converted back to the element
type. Narrow types can round at segment boundaries, so a checkpointed result
need not match a single unsegmented accumulation bit for bit.

The [4096-step measurement](measurements/checkpoint-2026-10-14.json) compares
checkpoint interval 32 with ordinary fwp VJP under ARC, with cache reuse off.
Peak tape bytes fall from 262,248 to 2,152, while peak managed bytes rise from
336 to 12,816. Those separate peaks need not coincide. Tape requests rise from
34 to 1,153 and managed requests from 16,410 to 38,408. Time increases on all
four measured hosts. This is a memory/recomputation tradeoff, not a C/Rust
comparison or a general speed improvement.

## Tensor expressions and kernels

`TensorExpr[N]` describes elementwise arithmetic over `Vector[F64, N]` inputs.
A leaf is an input vector or constant. `tensor.lazy` makes a leaf; numeric
operations construct an expression graph. Construction has a cost even though
individual elements are not evaluated yet.

A **kernel** is the executable sequence of element operations produced from that
graph. The CPU evaluator processes blocks of 256 elements, dispatching each
operation once per block and using inner array loops. It avoids full-length
intermediate arrays for supported operations. `tensor.map` accepts an arbitrary
fwp function; that subexpression is evaluated first on the CPU and becomes an
input, so it is not included in that no-intermediate-array claim.

| Function | Meaning |
|---|---|
| `realize e` | Evaluate using `Cpu` |
| `realize-on d e` | Evaluate on explicit device `d`; trap with a reason if unavailable |
| `tensor.try-realize-on d e` | Return failure as a `Result` instead |
| `tensor.sum-on d e`, `tensor.sum e` | Evaluate and sum elements |
| `tensor.grad-on d e`, `tensor.grad e` | Derivatives of the sum with respect to each leaf, in left-to-right order |
| `tensor.kernel e` | Build the kernel description |
| `kernel.run d k`, `kernel.sum d k` | Execute a built kernel |
| `tensor.opencl e` | Produce OpenCL C source without requiring device execution |

Tensor gradients differentiate the expression graph into another expression per
leaf. Repeating a leaf in the tree, such as through `fork`, counts as separate
leaves. `tensor.map` cannot be differentiated and traps; `tensor.abs` has NaN as
its derivative at zero. A NaN is a floating-point non-number result.

## Devices

`Device` selects where a tensor kernel runs:

- `Cpu` uses the calling thread.
- `CpuParallel n` divides blocks among CPU threads, at most 256 and no more than
  one per block. The calling thread handles the first range. Workers access
  kernel inputs/output, not the collected fwp heap. These WebAssembly targets run
  this selection like `Cpu`; they do not launch those native worker threads.
  Availability requires `n >= 1`.
- `Gpu` uses a discovered OpenCL device with double-precision support, preferring
  a GPU. OpenCL is the host interface for compiling and executing device kernels.
  It is loaded when used; `FWP_OPENCL_LIB` can name the library. macOS uses its
  OpenCL framework. Discovery is not proof that a kernel executed successfully.

`device.available` reports availability. An unavailable device returns an error
through `tensor.try-realize-on` and traps through `realize-on`. GPU sums evaluate
elements on the device and add them on the CPU in the defined order.

CPU reductions add each block of 4096 elements left to right from zero, then
add block sums left to right. Changing the worker count preserves that order.
Interpreter/native tests check the expected outputs at their supported settings.
OpenCL transcendental functions can differ in their last bits from the host C
math library; matching operation order does not establish identical CPU/GPU bits.
Contraction is disabled. The current GPU evidence covers unavailable-device
behavior, host API lifetime controls and generated source, not verified execution
on real double-precision GPU hardware.

## Not implemented

Just-in-time compilation (JIT) is explicitly excluded from fwp; it is not a
planned way to optimize numerical programs. Distributed tensor execution and
device kernels for general matrix products and arbitrary-axis reductions are
not implemented. Native matrix multiplication has a separate optimized CPU path;
it is not an OpenCL kernel.

The existing GPU implementation calls `clCreateProgramWithSource` and
`clBuildProgram` while running a program, in both the interpreter and native
runtime. This runtime device compilation must be resolved under the
[no-JIT direction](../PLAN.md#excluded-direction); GPU execution does not yet
meet an ahead-of-time-only compilation policy.

## Scoped-gradient allocation validation

Historical tests of the first scoped-gradient wrapper found an increase from
33 to 40 managed allocation requests (720 to 872 bytes) per gradient. Passing
borrowed inputs directly and projecting inside the callback restored 33 requests
and 720 bytes on the measured 4096-call workload. This compares fwp implementations;
it does not measure overhead against C. The counts exclude private tape buffers,
which need separate counters. [History](roadmap-history.md) preserves the accepted
source and test evidence; [benchmarks](benchmarks.md) explains counter meanings.

## Numerical kernel measurements

[The numerical kernel report](measurements/numerical-kernels-2026-10-12.json)
compares equivalent array/matrix computations in fwp, C and Rust. It records
hardware, compiler versions, flags, samples, outputs, allocation/reference counts,
live storage, collection activity and resident process memory. Timing uses separate
uninstrumented binaries so counting does not distort the measured loop.

Array kernel time includes consuming/releasing an existing input. Matrix kernel
time excludes output allocation and zeroing. Allocation-inclusive time covers
construction, computation and cleanup. C/Rust counters report allocator payload;
fwp separates requested from charged storage, excluding allocator metadata.
These are not interchangeable with resident process memory or reserved address
space. Use the scope attached to each ratio before calling it language overhead.

Eligible array pipelines avoid intermediate arrays and per-element owner updates.
Matrix multiplication allocates one output; its public generic boundary also
builds two matrix records. Those records remain a representation cost. Wide
workers, view layout and scalar calling conventions have separate controls in
[ownership](ownership.md#accepted-numeric-representation). Fewer allocations or
vector instructions alone do not establish equal speed with C/Rust. Shared-runner
timings are descriptive; CI asserts outputs and stable allocation properties.
