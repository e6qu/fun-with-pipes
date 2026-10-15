# 12. Numerics

Read lessons 1–3 first. A vector is an ordered set of numbers; a matrix is a
rectangular grid of numbers. Their sizes are part of their types, so incompatible
matrix multiplication is rejected before execution. `solve a` finds `x` in the
linear system `a * x = b`; the determinant is a scalar property of a square
matrix. A complex number has real and imaginary parts, with the imaginary unit
satisfying `i * i = -1`.

A derivative measures how a function's output changes near an input. A gradient
collects one derivative for each input of a scalar-valued function. Automatic
differentiation applies arithmetic derivative rules while evaluating the program.
It avoids estimating derivatives by subtracting nearby function evaluations,
but floating-point operations still round.

The numeric library builds on the traits from tutorial 3, so most of it
works for any number type.

- `Vector[T, N]` and `Matrix[T, M, N]` carry their sizes in their types.
  `matmul` of incompatible shapes is a compile-time error. The library
  provides `solve`, `determinant`, `inverse`, `cholesky`, `qr` and the
  conjugate gradient method `cg`.
- `Complex[T]` implements the arithmetic traits.
- `derivative`, `gradient`, `jacobian` and `hessian` propagate derivatives
  with dual numbers (a value paired with its derivative, called forward mode),
  for any function written against the numeric traits.

```fwp
f : t -> t where Ring[t], FromFloat[t]
f = fork mul id id | sub 2.0
```

`f` works on plain floats and on dual numbers alike, which is what lets
`derivative f` exist.

For further numeric formats and execution choices, see the
[numerics guide](../../numerics.md). This lesson needs only floating-point
numbers, matrices, complex numbers and forward differentiation.

Here `f` computes `x² − 2`; `Ring` supplies addition/subtraction/multiplication
and `FromFloat` converts the floating-point literal for the chosen number type.
Its derivative is `2x`, so at 3 the program prints 6. `newton-step` applies
`x − f(x)/f′(x)`, moving toward a root of `f`. Five steps from 1 approach √2.
The final function is `x² + y`, whose gradient at `(3, 4)` is `[6, 1]`.

## The program

[`main.fwp`](main.fwp):

```fwp
a = matrix [[4.0, 1.0], [1.0, 3.0]]
b = vector [1.0, 2.0]

f : t -> t where Ring[t], FromFloat[t]
f = fork mul id id | sub 2.0

newton-step : F64 -> F64
newton-step = fork sub (fork div (derivative f) f) id

main = [
    a | matmul a | echo,
    b | solve a | echo,
    a | determinant | echo,
    complex 1.0 2.0 | mul (complex 3.0 -1.0) | echo,
    3.0 | derivative f | echo,
    1.0 | iterate 5 newton-step | last | echo,
    [3.0, 4.0]
    | gradient (fork
        add
        (nth 0 | option.unwrap-or zero | fork mul id id)
        (nth 1 | option.unwrap-or zero))
    | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/12-numerics/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/12-numerics/main.fwp -o numerics`. The output is
[`main.out`](main.out):

```
Matrix {cols = 2, data = array[17.0, 7.0, 7.0, 10.0], rows = 2}
Some (Vector {data = array[0.09090909090909091, 0.6363636363636364]})
11.0
Complex {im = 5.0, re = 5.0}
6.0
Some 1.4142135623746899
[6.0, 1.0]
```

The tests require this program to print these values in both the interpreter
and native code. This checks the example; it is not a claim that every floating
calculation or external device produces identical bits on every host.

---

Previous: [Compile-time code and macros](../11-comptime-and-macros/README.md) · Next: [Tooling](../13-tooling/README.md) · [All tutorials](../README.md)
