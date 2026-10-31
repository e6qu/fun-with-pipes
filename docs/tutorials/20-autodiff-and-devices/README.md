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

`grad` and `vjp` create a tape scope for each call and release its temporary
records when the call ends. A tracked `Rev` value belongs to that scope; it
cannot be used afterward or moved to another task for calculation. Return the
ordinary result or derivative values instead. Nested gradients use enclosing
tapes without extending the lifetime of an expired inner tape.

`value-and-grad` returns the function value as well. A vector-Jacobian product
(`vjp`) weights several output derivatives by caller-supplied weights; the
Jacobian is the table of derivatives of every output with respect to every input.
Those operations are described in the [numerics guide](../../numerics.md).

The example's `rosenbrock` sums `100(y − x²)² + (1 − x)²` for adjacent input
pairs. `zip (drop 1 values)` pairs each value with its successor; the pattern
`fn (x, y) -> ...` names those two numbers. Local `distance` and `offset` values
make the formula readable and are computed once per pair. Its trait requirements
allow ordinary or derivative-tracking numbers.
`descend` multiplies the gradient by 0.001 and subtracts it from the original
vector: one small step toward reducing the function. `zip-with sub` combines
corresponding elements; because subtraction takes its subject last, the original
vector is the final argument. Repeating this step lowers the objective in this
example; it does not guarantee convergence for arbitrary functions.

The descent loop keeps a pair `(steps-left, weights)`. `both (const 199) id`
creates that pair: `const 199` ignores its input and supplies the count, while
`id` keeps the starting weights. `.0` selects the count and `.1` the weights.
Each `Again` supplies the next pair; `Stop` returns the final weights. The loop
therefore makes exactly 199 updates without keeping a list of earlier vectors.

Keeping a history is useful when plotting the path, but this example only needs
the final result. `iterate 200 descend | last` would retain 200 vectors including
the starting one and perform the same 199 updates. The
[measured comparison](../../measurements/ad-application.md) explains the storage
saved by the loop and the remaining cost of derivative recording.

## Expressions and execution devices

A tensor expression describes arithmetic over an array. `tensor.lazy` creates
an input expression; applying `soft` builds the expression `ln(exp(x) + 1)`.
Building this description does work, but does not yet evaluate every element.
`tensor.sum-on` evaluates and sums it on a selected device. A **kernel** here
is an instruction array evaluated by compiled CPU loops for each element. Combining
the operations into that loop avoids arrays for intermediate `exp` and `add`
results.

`Cpu` uses one CPU thread; `CpuParallel 4` permits up to four. CPU sums add blocks of
4096 elements in a fixed order and then add the block sums in order, so changing
the thread count does not change that addition order. The test below compares
both results; it does not benchmark their speed. `tensor.grad` builds derivatives
of the sum with respect to each input leaf; the sample prints the first two
elements of each resulting gradient vector.

Worker limits must be between 1 and 256. `device.available (CpuParallel 4)`
returns `True`; a limit of 0 or 257 is invalid and traps when used. Small kernels
use fewer workers; WebAssembly executes serially. GPU execution is not supported.

## The program

[`main.fwp`](main.fwp):

```fwp
rosenbrock : List[t] -> t where Ring[t], FromFloat[t], Dup[t]
rosenbrock = fn values ->
    values
    | zip (drop 1 values)
    | map (fn (x, y) ->
        let distance = y - x * x
        in let offset = 1.0 - x
        in distance * distance * 100.0 + offset * offset)
    | sum

descend : List[F64] -> List[F64]
descend = fn values ->
    let adjustment = grad rosenbrock values | map (mul 0.001)
    in values | zip-with sub adjustment

soft : t -> t where Field[t], Floating[t], FromFloat[t]
soft = exp | add 1.0 | ln

xs : Vector[F64, _]
xs = 1000 | range 0 | map (int.to-float | mul 0.01 | sub 5.0) | vector.from-list

main = [
    [-1.2, 1.0, 0.5] | grad rosenbrock | show | print,
    [-1.2, 1.0, 0.5] | gradient rosenbrock | show | print,
    [-1.2, 1.0, 0.5]
    | both (const 199) id
    | loop
        (if (.0 | eq 0) (.1 | Stop) (both (.0 | sub 1) (.1 | descend) | Again))
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
```

The expected output checks interpreter/native agreement for this program,
including the sums of its parallel CPU kernels. [docs/numerics.md](../../numerics.md) describes
the tape, the kernels and the devices.

---

Previous: [WebSockets and HTTP/2](../19-websockets-and-http2/README.md) · Next: [MCP tools](../21-mcp/README.md) · [All tutorials](../README.md)
