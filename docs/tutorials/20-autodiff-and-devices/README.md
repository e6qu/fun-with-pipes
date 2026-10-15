# 20. Reverse-mode autodiff and devices

Read lessons 3 and 12 first. Automatic differentiation calculates derivatives
by applying the derivative rule for each arithmetic operation. Forward mode
carries a derivative alongside each value. To get all partial derivatives of a
scalar result, the `gradient` helper repeats that process for each input.

**Reverse mode** records operations and their dependencies in a **tape**. After
computing the result, it walks those records backward, accumulating how each
input influences that result. `Rev[T]` is the tracked numeric value; `grad f xs`
returns the gradient. This takes one forward and one backward pass for a scalar
result, but those passes store records, allocate memory and do extra arithmetic.
It is not a promise that a gradient costs the same as evaluating `f` once.
Floating-point rounding applies in both modes.

`value-and-grad` returns the function value as well. A vector-Jacobian product
(`vjp`) weights several output derivatives by caller-supplied weights; the
Jacobian is the table of derivatives of every output with respect to every input.
Those operations are described in the [numerics guide](../../numerics.md).

The example's `rosenbrock` sums `100(y − x²)² + (1 − x)²` for adjacent input
pairs. Its trait requirements allow ordinary or derivative-tracking numbers.
`descend` multiplies the gradient by 0.001 and subtracts it from the original
vector: one small step toward reducing the function. `zip-with sub` combines
corresponding elements; because subtraction takes its subject last, the original
vector is the final argument. Repeating this step lowers the objective in this
example; it does not guarantee convergence for arbitrary functions.

## Expressions and execution devices

A tensor expression describes arithmetic over an array. `tensor.lazy` creates
an input expression; applying `soft` builds the expression `ln(exp(x) + 1)`.
Building this description does work, but does not yet evaluate every element.
`tensor.sum-on` evaluates and sums it on a selected device. A **kernel** here
is the compiled loop that performs the arithmetic for each element. Combining
the operations into that loop avoids arrays for intermediate `exp` and `add`
results.

`Cpu` uses one CPU thread; `CpuParallel 4` requests four. CPU sums add blocks of
4096 elements in a fixed order and then add the block sums in order, so changing
the thread count does not change that addition order. The test below compares
both results; it does not benchmark their speed. `tensor.grad` builds derivatives
of the sum with respect to each input leaf; the sample prints the first two
elements of each resulting gradient vector.

`Gpu` uses OpenCL, an interface for running kernels on a supported device.
`tensor.opencl` prints the OpenCL C source without executing it. Execution needs
an OpenCL library and a device with double-precision support. Check
`device.available Gpu`; an unavailable device makes `realize-on Gpu` fail with
the reason. Device math libraries may differ; the printed CPU agreement below
does not establish identical GPU results.

## The program

[`main.fwp`](main.fwp):

```fwp
rosenbrock : List[t] -> t where Ring[t], FromFloat[t], Dup[t]
rosenbrock =
    fork zip id (drop 1)
    | map (fork
        add
        (fork sub (.1 | fork mul id id) .0 | fork mul id id | mul 100.0)
        (.1 | flip sub 1.0 | fork mul id id))
    | sum

descend : List[F64] -> List[F64]
descend = fork (zip-with sub) (grad rosenbrock | map (mul 0.001)) id

soft : t -> t where Field[t], Floating[t], FromFloat[t]
soft = exp | add 1.0 | ln

xs : Vector[F64, _]
xs = 1000 | range 0 | map (int.to-float | mul 0.01 | sub 5.0) | vector.from-list

main = [
    [-1.2, 1.0, 0.5] | grad rosenbrock | show | print,
    [-1.2, 1.0, 0.5] | gradient rosenbrock | show | print,
    [-1.2, 1.0, 0.5]
    | iterate 200 descend
    | last
    | option.unwrap-or []
    | rosenbrock
    | show
    | print,
    xs | tensor.lazy | soft | tensor.sum-on (CpuParallel 4) | show | print,
    xs | tensor.lazy | soft | tensor.sum-on Cpu | show | print,
    xs
    | tensor.lazy
    | soft
    | tensor.grad
    | map (vector.to-list | take 2)
    | show
    | print,
    vector [0.0, 1.0] | tensor.lazy | soft | tensor.opencl | print,
] | ignore
```

Run it with `fwp run docs/tutorials/20-autodiff-and-devices/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/20-autodiff-and-devices/main.fwp
-o autodiff`. The output is [`main.out`](main.out):

```
[-215.59999999999997, 112.00000000000001, -100.0]
[-215.59999999999997, 112.00000000000001, -100.0]
3.493467774689583
1410.6489026879174
1410.6489026879174
[[0.006692850924284856, 0.006759660510713249]]
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#pragma OPENCL FP_CONTRACT OFF
__kernel void fwp_kernel(__global double *out, __global const double *k, const long n, __global const double *x0) {
    const long i = get_global_id(0);
    if (i >= n) return;
    double s0, s1;
    s0 = x0[i];
    s0 = exp(s0);
    s1 = k[0];
    s0 = s0 + s1;
    s0 = log(s0);
    out[i] = s0;
}

```

The expected output checks interpreter/native agreement for this program,
including the sums of its parallel CPU kernels. [docs/numerics.md](../../numerics.md) describes
the tape, the kernels and the devices.

---

Previous: [WebSockets and HTTP/2](../19-websockets-and-http2/README.md) · Next: [MCP tools](../21-mcp/README.md) · [All tutorials](../README.md)
