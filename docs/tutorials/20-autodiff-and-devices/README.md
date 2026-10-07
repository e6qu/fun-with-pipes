# 20. Reverse-mode autodiff and devices

[Tutorial 12](../12-numerics/README.md) differentiated generic numeric
code with dual numbers (forward mode): one pass per input. This tutorial
uses the other two tools of `lib/autodiff.fwp` and `lib/tensor.fwp`:

- **Reverse mode.** `Rev[T]` numbers record each operation on a tape, and
  `grad f xs` walks it backwards once, so the whole gradient of a function
  of a thousand inputs costs about as much as one evaluation.
  `value-and-grad`, `vjp` (vector-Jacobian products) and `rev.jacobian`
  work the same way.
- **Devices.** Tensor expressions implement the numeric traits too, so the
  same generic code builds a fused elementwise kernel, which runs on a
  `Device`: `Cpu`, `CpuParallel n` (n threads) or `Gpu` (OpenCL).

Every number type implements the same traits, so one definition serves
them all:

```fwp
rosenbrock : List[t] -> t where Ring[t], FromFloat[t], Dup[t]
```

`grad rosenbrock` and `gradient rosenbrock` (forward mode) give the same
derivatives; reverse mode needs one forward and one backward pass where
forward mode needs one pass per input.

```fwp
descend = fork (zip-with sub) (grad rosenbrock | map (mul 0.001)) id
```

On tensor expressions, `soft` below does no work: it builds the
expression `ln(exp(x) + 1)`, which `tensor.sum-on` compiles to one kernel
and runs, here on four threads. The kernel reads each element once and
allocates no intermediate arrays. Every CPU device gives the same bits:
elementwise results do not depend on the thread count, and sums add
blocks of 4096 elements from the left, then the block sums from the left.
`tensor.grad` differentiates the sum of an expression with respect to
each of its leaves in reverse mode, building one more kernel per leaf.

```fwp
soft : t -> t where Field[t], Floating[t], FromFloat[t]
soft = exp | add 1.0 | ln
```

`tensor.opencl` shows the OpenCL C that the `Gpu` device compiles. The
GPU device loads `libOpenCL` (the OpenCL framework on macOS) when it is
first used; without it (or
without a device with double precision) `device.available Gpu` is
`False` and `realize-on Gpu` stops with the reason.

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

The interpreter and native code agree to the last bit, including the sums
of the parallel kernels. [docs/numerics.md](../../numerics.md) describes
the tape, the kernels and the devices.

---

Previous: [WebSockets and HTTP/2](../19-websockets-and-http2/README.md) · Next: [MCP tools](../21-mcp/README.md) · [All tutorials](../README.md)
