# Numerics: automatic differentiation and devices

This page covers how fwp differentiates programs and where tensor kernels
run. The library itself is listed in [stdlib.md](stdlib.md) (sections
*Autodiff* and *Tensors*); [tutorial 12](tutorials/12-numerics/README.md)
and [tutorial 20](tutorials/20-autodiff-and-devices/README.md) introduce
it.

Runtime ownership and natural-width numeric storage are accepted. The active
work in [../PLAN.md](../PLAN.md) is numerical loop fusion, blocked matrix
multiplication and bounded autodiff workspace reuse, followed by broader
performance evidence and optional tracing-free execution.
[ownership.md](ownership.md) records the representation and floating-point
contract; [development-state.md](development-state.md) records current evidence.

Numeric code in fwp is written once against the numeric traits (`Ring`,
`Field`, `Floating`, `FromFloat`, ...). Floats, complex numbers, dual
numbers, reverse-mode numbers and tensor expressions all implement them,
so the same function evaluates, differentiates, or builds a kernel
depending on the type it is used at:

```
f : t -> t where Field[t], Floating[t], FromFloat[t]
f = exp | add 1.0 | ln
```

| Use | `t` |
|---|---|
| `2.0 \| f` | `F64` |
| `2.0 \| derivative f` | `Dual[F64]` (forward mode) |
| `[2.0] \| grad (head \| option.unwrap-or zero \| f)` | `Rev[F64]` (reverse mode) |
| `xs \| tensor.lazy \| f \| realize-on (CpuParallel 4)` | `TensorExpr[n]` (a fused kernel) |

## Forward mode

`Dual[T] = { re: T, eps: T }` carries a value and a derivative
(`lib/autodiff.fwp`). `derivative`, `gradient`, `jacobian` and `hessian`
(nested duals) evaluate the function once per input direction. It is the
right tool for few inputs or many outputs; it needs no runtime support.

## Reverse mode

`Rev[T] = { value: T, vertex: I64 }` is a number that records each
operation on a tape. `grad f xs` makes a tape whose first nodes are the
inputs, evaluates `f` once at `Rev` numbers, and walks the tape backwards
once from the result, so the gradient of a function of n inputs costs a
small constant times one evaluation, where `gradient` costs n.

| Function | Result |
|---|---|
| `grad f xs` | the gradient of a scalar function `List[Rev[t]] -> Rev[t]` |
| `value-and-grad f xs` | the value and the gradient, from one forward and one backward pass |
| `grad-vector f v` | `grad` for a function of a `Vector` |
| `vjp f v xs` | the vector-Jacobian product vᵀ·J of `List[Rev[t]] -> List[Rev[t]]`, one backward pass |
| `rev.jacobian f xs` | the Jacobian (rows are outputs), one backward pass per output |
| `rev.const x` | a constant: no gradient flows through it |

`T` is a float type (`F64`, `F32`, ...); adjoints are accumulated in `F64` and converted
back. Since `Rev` implements `Add`, `Sub`, `Mul`, `Div`, `Neg`, `Zero`,
`One`, `FromInt`, `FromFloat`, `Ring`, `Field` and `Floating`, generic
code over lists, `Vector`s and `Matrix`es (`dot`, `norm`, `matmul`,
`matrix.apply`, ...) differentiates unchanged. Comparisons (`lt`, `max`)
compare `.value` first, so piecewise functions work (the derivative is
that of the branch taken).

**The tape.** The tape lives in the runtime, outside the program's values
(`src/numerics.rs` for the interpreter, `runtime/fwp_rt_kernel.c` for
native code): per node, two parent indices and two partial derivatives,
in growable arrays of numbers. A `Rev` value refers to its node as
`(tape id << 32) | index`, with -1 for constants; the tape id is
`(generation << 16) | (slot + 1)`. Operations call the primitive
`ad.push`, which appends a node to the tape of its operands (an operation
on constants records nothing); `ad.backward` seeds the outputs, visits the
nodes from the last to the first, adds `adjoint × partial` to each parent
(skipping nodes whose adjoint is zero), returns the adjoints of the inputs
and retires the tape. Its detached capacity may be reused within the bounded
workspace described below. The order of these additions is the same in both
backends, so gradients agree bit for bit. Tapes are independent, so
tasks can differentiate concurrently.

The primitives have pure types, which is sound because the optimizer
never duplicates, merges or hoists primitive calls (`src/opt.rs`), and a
node is only reachable through the value returned for it.

**Limits.** A `Rev` value belongs to the `grad` that made it: using one
after its `grad` returned is a trap, and so is combining values of two
different `grad`s. Nested reverse mode is not supported (`Rev[T]` needs
a primitive float `T`); for second derivatives use `hessian` (nested
forward mode).
Reverse mode needs the tape's memory, 24 bytes per operation; there is no
checkpointing.

Accepted PR124 registers detached tape buffers and adjoints for cleanup
through normal return, mixed-tape errors, recoverable traps and cancellation.
It preserves consumption of the selected tape before output validation.
Token validation checks live tape identity and node bounds; slots retire after
generation32767 so old tokens cannot identify a later tape after wrap.
Interpreter/native and deliberate omission controls pass on Linux and both Macs.
Verified production acceptance is recorded in [the handoff](development-state.md).

Internal ad.scope/ad.scope2 release tapes when callbacks fail before backward.
Native scopes use stack owners and stable slot links in each task's cleanup chain;
interpreter scopes use RAII. Borrowed inputs require Dup. Public grad/vjp types
remain unchanged; direct arguments and projection inside the grad callback avoid
wrapper allocations. [Allocation validation](#scoped-gradient-allocation-validation)
records the complete counters and limits. A single detached workspace may retain
at most 512 KiB of numeric buffers. Reuse zeroes adjoints and preserves stale-token
checks; oversized capacity is released. FWP_AD_WORKSPACE=0 disables this cache
for comparison. Native library unload releases both live and cached tape owners.
No tracing-free support is claimed.

Historical timing samples are preserved in
[the benchmark history](roadmap-history.md#archived-numerics-timing-samples).
Future comparisons must record equivalent workloads, hardware, compiler,
flags, allocations and live memory alongside elapsed time, as required by
[the ownership contract](ownership.md).

## Tensor expressions and kernels

`TensorExpr[N]` (`lib/tensor.fwp`) is a lazy elementwise expression over
`Vector[F64, N]` leaves: `tensor.lazy`, `tensor.fill`, `tensor.add`,
`tensor.sub`, `tensor.mul`, `tensor.div`, `tensor.scale`, `tensor.abs`,
`tensor.unary`, the `Floating` functions, and `tensor.map` with any
function. Through its trait impls, generic numeric code builds
expressions too.

Running an expression compiles it to a `Kernel` (`tensor.kernel`): postfix
code (`Array[I64]`: 0 an input, 1 a constant, 2–5 the arithmetic
operations, 6–13 the unary operations), its constants and its input
arrays. A `tensor.map` subexpression is evaluated first, on the CPU (it
may be any fwp function), and becomes an input. The runtime evaluates the
code 256 elements at a time on a stack of 256-element columns, so the
interpretation costs one dispatch per operation per 256 elements and the
inner loops are plain array loops; no intermediate arrays of the full
length are allocated.

| Function | |
|---|---|
| `realize e` | `realize-on Cpu` |
| `realize-on d e` | evaluate on device `d` (a trap with the reason when it cannot run there) |
| `tensor.try-realize-on d e` | the same as a `Result` |
| `tensor.sum-on d e`, `tensor.sum e` | the sum of the elements |
| `tensor.grad-on d e`, `tensor.grad e` | the gradient of the sum with respect to each leaf, in order from the left |
| `tensor.kernel e`, `kernel.run d k`, `kernel.sum d k` | the kernel and running it |
| `tensor.opencl e` | the OpenCL C source of the kernel |

`tensor.grad` is reverse mode over the expression graph: the adjoint of
each leaf is itself an expression (the adjoint of `a·b` with respect to
`a` is `g·b`, and so on), compiled and run on the device. A leaf used
twice in the tree (for example after `fork`) is two leaves. `tensor.map`
cannot be differentiated (a trap); the derivative of `tensor.abs` at 0 is
NaN.

## Devices

```
Device =
    | Cpu
    | CpuParallel I64
    | Gpu
```

- **`Cpu`** runs the kernel on the calling thread.
- **`CpuParallel n`** splits the 256-element chunks into n contiguous
  ranges (at most 256 threads, at most one per chunk) and runs them on OS
  threads: POSIX threads in native code, `std::thread::scope` in the
  interpreter, the first range on the calling thread. The workers read the
  input arrays and write memory of their own; they never touch the
  program's heap, so the native collector needs no synchronization (the
  calling task waits for them, and nothing else allocates meanwhile). In
  WebAssembly, and in the WebAssembly build of fwp, there are no threads
  and it runs like `Cpu`. `device.available (CpuParallel n)` is
  `n >= 1`; fewer threads run as one.
- **`Gpu`** is the first OpenCL device with double precision
  (`cl_khr_fp64`), a GPU if there is one. The library is loaded with
  `dlopen` when the device is first used (`libOpenCL.so.1`, or the file
  `FWP_OPENCL_LIB` names; on macOS, the system OpenCL framework), in both backends, so programs neither link
  nor require it. `device.available Gpu` says whether one was found;
  running on an unavailable GPU is an `Err` from `tensor.try-realize-on`
  and a trap (`fwp: trap: device: no OpenCL device: ...`) from
  `realize-on`. The kernel is `tensor.opencl`'s source: one work item per
  element, the same postfix evaluation, `FP_CONTRACT OFF`. Sums on the GPU
  compute the elements there and add them on the CPU in the fixed order.

**Determinism.** Elementwise results do not depend on the device or the
thread count: each element is computed by the same operations in the same
order, and `+ - × ÷ sqrt` are correctly rounded everywhere. Reductions
(`tensor.sum-on`, `kernel.sum`) add the elements of each block of 4096
from the left, starting from 0.0, then the block sums from the left,
whatever the number of threads; so every CPU device, in both backends,
returns the same bits, and `tensor.sum` is reproducible from run to run.
The interpreter and native code call the same C library for `exp`, `ln`,
`sin`, `cos` and `tan`, and compile without contraction
(`-ffp-contract=off`). On a GPU, `exp`, `log` and the trigonometric
functions are OpenCL's, which may differ from the C library in the last
bits.

**Tests.** `tests/run/devices.fwp` and `tests/run/autodiff_reverse.fwp`
(golden, both backends and under `FWP_GC_STRESS`),
`tests/numerics.rs` (300 001 elements on six devices and thread counts,
in both backends; the GPU device without OpenCL and with a library
without platforms), and the library's own tests (`fwp test --std`). No
OpenCL device was available where this was written: the OpenCL host code
is exercised only up to platform discovery, and the generated source is
checked as text.

Historical tensor-kernel timings are preserved in
[history](roadmap-history.md#archived-tensor-kernel-timing-samples). They lack
recorded processor/compiler details and allocation/live-memory measurements,
so they cannot establish a current performance baseline or equal kernel speed
between backends. Future comparisons must separate input construction from
kernel execution and use equivalent workloads under the measurement contract.
Framework loading on Darwin does not prove a usable double-precision device
or successful kernel execution. Preserve deterministic reduction order and
disabled contraction while measuring SIMD, buffer reuse and fused gradients.

## Not implemented

- A JIT: native builds are compiled ahead of time; the interpreter runs
  kernels with its own Rust implementation of the same evaluator.
- Distributed execution: sharding tensors across processes and
  collectives (`all-reduce`) over services.
- Nested reverse mode and checkpointing.
- Kernels other than elementwise expressions and sums (matrix products,
  reductions along an axis) on devices.


## Scoped-gradient allocation validation

Complete managed-allocation counters include initializer fast paths and count
slow delegation once. They exposed a33→40 calls/720→872 bytes regression per
gradient in the first scoped wrapper. Direct borrowed arguments through internal
ad.scope/ad.scope2 and projection inside the grad callback restore33 calls/720
bytes, matching the baseline on4096 equivalent O1/O2 calls across Linux and
ARM/Intel macOS. The accepted combined Linux profiles also pass. Public grad/vjp
signatures stay intact; borrowed scoped inputs require Dup, and affine File
rejection, input aliases and tape cleanup controls pass. [The handoff](development-state.md)
records measured source identities and passing production gates. No timing gain or tracing-free
support is established, and earlier partial counters do not prove allocation parity.

## Numerical kernel measurements

The phase4 preparation compares identical array and matrix computations in C,
Rust and generated fwp code on Linux and ARM/Intel macOS. The retained
[measurement record](measurements/numerical-kernels-2026-10-12.json) includes
source hashes, hardware, compiler versions, build flags, samples, allocations,
reference counts, live memory, collection counts and process RSS. Raw reports
and uninstrumented disassembly are artifacts of the linked runner execution.
Run the Numerical kernel evidence workflow manually to regenerate the same
controls on GitHub runners; no local full benchmark run is required.

Timings use separate uninstrumented binaries. Array kernel time consumes and
releases an existing input; matrix kernel time excludes output allocation and
zeroing. Allocation-inclusive time covers construction, computation and cleanup.
C/Rust report allocator payload; fwp reports requested and charged storage,
with allocator metadata excluded from charged bytes. Reserved virtual address
space and process RSS are separate metrics. Shared-runner timing is descriptive;
CI asserts exact results and stable allocation properties.

The retained phase4 preparation allocates no array intermediates but still
retains/releases its carried array once per element. Matrix multiplication allocates one output;
the benchmark's public generic input boundary also builds two Matrix records.
These remaining costs are explicit targets for phase5. Neither zero intermediate
allocations nor vector instructions alone establish C/Rust speed parity.

Phase5 preparation gives flat loop fields independent owners and removes
per-element array retain/release pairs. Unwind scopes remain around fallible
operations; concrete scalar reads and F32/F64 arithmetic need none. Generated
type descriptors are read-only, allowing fixed element-width dispatch to be
removed. Raw floating-point order and bounds/trap behavior remain unchanged.
Measurements and full production acceptance for this later delivery belong to
the handoff; a lower instruction/count total alone is not a timing guarantee.
The checked ARC subset currently excludes raw reverse-mode tape lifetimes;
normal native autodiff continues to use the scoped bounded workspace above.
