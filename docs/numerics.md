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

## Scalar math

A scalar is one number, rather than a vector or matrix. The following functions
accept and return the same floating format: `F16`, `BF16`, `F32`, `F64` or `F128`.
`Float[a]` selects these concrete formats; it does not supply derivative rules
for the `Dual`/reverse-mode types accepted by some `Floating` operations.

| Functions | Calculation and domain |
|---|---|
| `asin`, `acos`, `atan` | Inverse sine, cosine and tangent, with results in radians; `asin`/`acos` take inputs in [−1, 1]. |
| `atan2 x y` | Angle of the point `(x, y)` in radians, using both signs to choose the quadrant. |
| `sinh`, `cosh`, `tanh` | Hyperbolic sine, cosine and tangent. |
| `asinh`, `acosh`, `atanh` | Their inverses; real `acosh` needs x ≥ 1 and finite `atanh` needs −1 < x < 1. |
| `log2`, `log10` | Base-two and base-ten logarithms; positive inputs give finite results. |
| `log1p` | Natural logarithm of 1 + x, avoiding the loss of tiny x when forming that sum first. |
| `exp2` | 2 raised to the input. |
| `expm1` | exp(x) − 1, avoiding cancellation for small x. |
| `hypot x y` | Distance √(x² + y²), without overflowing merely because the intermediate squares are too large. |

For example:

```fwp
main = [
    3.0 | hypot 4.0 | echo,
    8.0 | log2 | echo,
    0.0 | atan2 -1.0 | gt 3.0 | echo,
    1e-100f64 | log1p | eq 1e-100f64 | echo,
] | ignore
```

The output is `5.0`, `3.0`, `True`, `True`, on separate lines. The first result
is the 3–4–5 triangle's distance. The second follows from 2³ = 8. The third
angle is π radians, greater than three. The last input is so small that
`1.0 + 1e-100f64` rounds to `1.0`; `log1p` preserves the small result instead.
In a pipe the transformed value comes last: `y | atan2 x` means the conventional
atan2(y, x), and `y | hypot x` computes the distance.

Out-of-domain real inputs produce NaN (not-a-number); logarithms at zero and
some endpoints produce infinity. These follow floating-point rules, not checked
integer traps. Rounding still applies. F32/F64 call the host math library;
F16/BF16/F128 use the bundled fixed-storage implementation without narrowing to
F64. This extension does not add complex or automatic-differentiation overloads.
[Format tests](float-formats.md) describe representation and precision checks;
[benchmarks](benchmarks.md) explain why a correctness test is not a speed claim.

## Fixed-size lane operations

Use `Vec[N, T]` when an operation acts on a fixed number of values independently.
A **lane** is one position; `Vec[4, F64]` means four F64 lanes. The count is part
of the type. `Vector[T]`, used by the matrix and differentiation helpers, instead
has a length determined at runtime; the two names describe different APIs.

[The complete lane example](../examples/vector-lanes.fwp) doubles four numbers.
Its function signature supplies the lane count, so callers need no lane-count
argument:

```fwp
double-four : Vec[4, F64] -> Vec[4, F64]
double-four = simd.mul (simd.splat 2.0)
```

`simd.splat 2.0` fills all four lanes with 2.0. `simd.mul` multiplies matching
lanes. `array.from-list` constructs the input array; `simd.from-array` checks its
length and returns `Some vector` on success or `None` for the wrong length.
The declared lane count is checked before conversion to the target's pointer
width. For example, an empty array cannot satisfy `Vec[4294967296, I64]` on a
32-bit WebAssembly target. Constructing that vector with `simd.splat` traps with
`array too large` before allocation. F128 lanes require sixteen bytes each;
representable lengths do not guarantee that sufficient memory is available.

`option.map` applies a function inside `Some` and leaves `None` unchanged:

```fwp
[1.0, 2.0, 3.0, 4.0] | array.from-list | simd.from-array
    | option.map (double-four | simd.to-array | array.to-list) | echo
```

This prints `Some [2.0, 4.0, 6.0, 8.0]`, because each input is multiplied by two.
A three-element input produces `None`. Converting back to a list here is for
printing the example, not a requirement for subsequent vector operations.

The exposed record definition also permits manual `Vec` construction without a
length check. Binary lane operations currently process the common input prefix
in that case. Use `simd.from-array` to validate lengths at an input boundary;
the type annotation alone does not validate a manually supplied array.

SIMD abbreviates single instruction, multiple data. The current implementation
stores an array inside a record and emits C loops; the C compiler may turn suitable
loops into vector instructions. The API alone guarantees neither those instructions
nor a speedup. Integer lane addition, subtraction, multiplication and sum wrap on
overflow; ordinary fwp integer arithmetic is checked. Division keeps its checks.
Floating operations preserve their existing order and format. Choose these rules
explicitly when using the lane API. [Lane measurements](measurements/vector-lanes.md#fixed-size-lane-calculations-against-c-and-rust)
compare the same dot-product workloads with C/Rust, explain removed temporary
values and retain the remaining overhead. [Ownership](ownership.md#representation-and-numerics)
records the current value contract.

## Dense F64 solvers

A dense matrix stores every element, including zeros. The existing solvers use
F64 arithmetic and copy input elements into temporary buffers so the original
immutable arrays, including slices, remain unchanged. They perform no automatic
precision conversion or differentiation of the solver itself.

| Operation | Result | Temporary storage, excluding returned arrays |
|---|---|---|
| LU solve | Solve `A x = b`; `None` for a singular matrix | Matrix copy and one vector |
| Determinant | Scalar measure of a square matrix; zero when singular | Matrix copy |
| Inverse | Matrix that reverses multiplication; `None` when singular | Two matrices |
| Cholesky | Lower triangular factor for a positive definite matrix; `None` when a diagonal step is nonpositive | Two matrices |
| QR | Orthogonal columns and an upper triangular factor | An `m` by `n` matrix and an `n` by `n` matrix |
| Conjugate gradient | Iterative solution for a symmetric positive definite system | Matrix copy and four vectors |

For `n` by `n` inputs, a matrix buffer contains `n*n` doubles and a vector
contains `n` doubles. Buffers also reserve one extra double for zero-length
allocation safety. Dimensions and input lengths are checked before arithmetic.
QR separately checks the square output size: even zero input rows must not allow
an enormous column count to overflow output allocation.

The native implementation now owns these buffers explicitly and releases them
on return, singular-result paths and unwinding. Partial result arrays remain
protected until their containing result is constructed. Checked ARC contracts
cover all six primitives, with accepted evidence in
[PR #147](roadmap-history.md#numerical-precision-and-filesystem-ownership-pr-147). These are existing algorithms with
unchanged arithmetic order, not a claim of BLAS-level speed or improved numerical
stability. Conjugate gradient keeps its explicit iteration limit and tolerance;
it does not automatically switch algorithms on difficult inputs.

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

`ReverseScalar` supports the five float types and recursively `Rev[T]`.
F16/BF16/F32/F64 tapes accumulate adjoints in F64 and convert results back to the
element type. F128 weights, seeds and adjoints remain F128, preserving its wider
precision and exponent range. Nested reverse levels keep typed weights and
record backward arithmetic on the enclosing tape. A `Float[T]` constraint alone does
not describe this nested behavior; generic reverse callers use `ReverseScalar[T]`.
Comparisons use primal values, so a piecewise program differentiates the branch
actually taken. This does not define a smooth derivative at every branch boundary.

### Accuracy checks

The D3 test batch compares `f(x) = x^4` with its analytic derivative
`4*x^3` at -2, -0.5, 0.5 and 2. It checks both forward and reverse mode in F64
and F128. A separate central difference computes `(f(x+h) - f(x-h)) / (2*h)`
without AD. It is an approximation: for this polynomial its exact truncation
error is `4*x*h*h`, before floating-point rounding.

The F64 check uses `h = 2^-16` and absolute tolerance `8e-9`; F128 uses `h = 2^-40`
and `1e-20`. These tolerances cover this finite input set, not arbitrary functions.
At x = 0.5, the first three nested reverse derivatives must be exactly 0.5, 3 and
12. Three quartic steps also compare ordinary and checkpointed reverse mode,
with checkpoint interval 2 and seed 1. Existing tests retain low-bit/exponent
checks and failure, cancellation and tape-release controls.

For the piecewise function `if x < 0 then -x else x`, checks approach zero from
both sides and expect -1 or 1. At zero, fwp follows the `else` branch and returns
1. That is an execution rule: the mathematical function has no derivative there.
The raw interpreter and native GCC O1/O2 checks pass on Linux ARM64/AMD64 at
`a31f24c4`, with workspace reuse both enabled and disabled. The
[finite depth/size cost matrix](measurements/ad-depth.md) also passes on both
Linux architectures at `89bbec5b`. Full platform acceptance remains. This does
not claim accuracy outside the
stated domains or constant costs for nested differentiation.

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

An F16/BF16/F32/F64 operation stores two 32-bit parent indices and two F64 local
derivatives: 24 payload bytes before adjoint storage, spare capacity and allocator
metadata. Inputs have node indices but need no operation records. F128 and nested
tapes instead own typed derivative values and operation callbacks. F128 values
can require separately allocated boxes and reference counts; the 24-byte figure
does not describe their complete storage cost. Preserving precision is not a
claim of equal speed or allocation cost.

The [four-host precision report](measurements/f128-gradient-precision-2026-10-15.json)
covers ten checks, including low bits, exponent range, nested/checkpointed
arithmetic and 65 repeated gradients. The complete fixture makes 2,843 managed
allocation requests for 143,082 requested bytes after initialization, including
output formatting. Checked ARC finishes with zero retained managed charge
at O1/O2 with workspace reuse off/on. These totals exclude unmanaged
registry, linked-library and host allocations; they measure neither peak process
memory nor speed relative to C/Rust. A failed append
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

Each segment follows VJP precision: F16/BF16/F32/F64 adjoints accumulate in F64,
while F128 adjoints remain F128. Narrow types can round at segment boundaries,
so a checkpointed result need not match a single unsegmented accumulation bit
for bit.

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
| `tensor.sum-on d e`, `tensor.sum e` | Evaluate and sum elements |
| `tensor.grad-on d e`, `tensor.grad e` | Derivatives of the sum with respect to each leaf, in left-to-right order |
| `tensor.kernel e` | Build the kernel description |
| `kernel.run d k`, `kernel.sum d k` | Execute a built kernel |

Tensor gradients differentiate the expression graph into another expression per
leaf. Repeating a leaf in the tree, such as through `fork`, counts as separate
leaves. `tensor.map` cannot be differentiated and traps; `tensor.abs` has NaN as
its derivative at zero. A NaN is a floating-point non-number result.

## Devices

`Device` selects where a tensor kernel runs:

- `Cpu` uses the calling thread.
- `CpuParallel n` allows at most n workers, including the calling thread.
  The accepted range is 1–256. Smaller workloads use fewer workers, with at most
  one per block. WebAssembly runs this policy serially; it launches no native
  worker threads. Static-memory builds also respect their configured worker pool.

`device.available` checks the worker setting. For example, `CpuParallel 256` is
valid and `CpuParallel 257` is not. Both `kernel.run` and `kernel.sum` trap on an
invalid count, including for an empty kernel; they no longer silently clamp it.
They return an array and an F64 respectively. `realize-on` wraps the resulting
array as a vector. These CPU operations have no always-successful `Result` wrapper.
A valid setting does not guarantee that the operating system can start workers.

Workers borrow inputs and write distinct parts of the owned output; they allocate
no language objects. The CPU-only implementation removes the OpenCL compiler,
GPU selection and source-generation API, with full production acceptance in
[PR #191](roadmap-history.md#task-results-and-explicit-cpu-execution-pr-191). GPU execution is not supported.

CPU elementwise workers write directly
into one result array, avoiding a second full-size native output and copy. Input
arrays remain borrowed and unchanged. A small pointer table identifies inputs;
each worker still allocates arithmetic workspace for 256 elements at the maximum
expression-stack depth. Reductions also allocate one scalar per 4096-element
block. These are real remaining costs, so tensor evaluation is not heap-free.

The caller protects output and scratch through validation, allocation and worker
startup. If a requested native worker cannot start, it joins every worker already
started, frees pending storage and reports a trap. It does not silently execute
missing workers on the caller. Counts are validated before conversion to WASI's
32-bit address size; final reduction blocks use remaining lengths to avoid index
overflow. The output-storage and failure-cleanup checks passed native and WASI
validation in [PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153).
The worker-range rules also passed the full PR #191 acceptance above.
[Measured storage costs](measurements/cpu-tensor-storage.md#cpu-tensor-output-storage) distinguish the
removed buffer from remaining allocations. No timing improvement is claimed here.

CPU reductions add each block of 4096 elements left to right from zero, then
add block sums left to right. Changing the worker count preserves that order.
Interpreter/native tests check the expected outputs at their supported settings.
Floating-point results can still differ between host math libraries; fixed
reduction order does not promise cross-platform bit equality for every operation.
Contraction is disabled.

## Not implemented

Just-in-time compilation (JIT) is excluded. The CPU runtime evaluates the kernel's
instruction array using already compiled arithmetic routines; it generates no
machine code during execution. GPU execution and distributed tensors are outside
the CPU roadmap. Native matrix multiplication has its own CPU implementation.

## Scoped-gradient allocation validation

Historical tests of the first scoped-gradient wrapper found an increase from
33 to 40 managed allocation requests (720 to 872 bytes) per gradient. Passing
borrowed inputs directly and projecting inside the callback restored 33 requests
and 720 bytes on the measured 4096-call workload. This compares fwp implementations;
it does not measure overhead against C. The counts exclude private tape buffers,
which need separate counters. [History](roadmap-history.md) preserves the accepted
source and test evidence; [benchmarks](benchmarks.md) explains counter meanings.

## Numerical kernel measurements

[The numerical kernel protocol and recorded results](measurements/numerical-kernels.md)
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
