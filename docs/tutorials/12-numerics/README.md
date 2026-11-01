# 12. Numerics

Read lessons 1–5 first. A vector is a fixed-length sequence of numbers; a matrix is a
rectangular grid of numbers. Their sizes are part of their types, so incompatible
matrix multiplication is rejected before execution. `solve a` finds `x` in the
linear system `a * x = b`. A square matrix's determinant measures how it changes
area or volume; zero means it collapses at least one direction. A complex number
has real and imaginary parts, with the imaginary unit satisfying `i * i = -1`.

A derivative measures how a function's output changes near an input. A gradient
collects one derivative for each input of a scalar-valued function. Automatic
differentiation applies arithmetic derivative rules while evaluating the program.
It avoids estimating derivatives by subtracting nearby function evaluations,
but floating-point operations still round.

The numeric library builds on the traits from tutorial 3, so most of it
works for any number type.

- `Vector[T, N]` and `Matrix[T, M, N]` carry their sizes in their types.
  `T` is the element type; `M` and `N` are dimensions. `matmul` rejects
  incompatible shapes before execution. `solve` and `determinant` are used below.
- `Complex[T]` implements the arithmetic traits.
- `derivative` and `gradient` use **dual numbers**: each ordinary value travels
  with its derivative. This is **forward mode**. Numeric traits let the same
  function work with ordinary numbers and these pairs.

```fwp
f : t -> t where Ring[t], FromFloat[t]
f = fn x -> x * x - 2.0
```

`f` works on plain floats and on dual numbers alike, which is what lets
`derivative f` exist.

For further numeric formats and execution choices, see the
[numerics guide](../../numerics.md). This lesson needs only floating-point
numbers, matrices, complex numbers and forward differentiation.

Here `f` computes `x² − 2`; `Ring` supplies addition/subtraction/multiplication
and `FromFloat` converts the floating-point literal for the chosen number type.
Its derivative is `2x`, so at 3 the program prints 6. `newton-step` applies
`x − f(x)/f′(x)`, moving toward a root of `f`.

`iterate 5` includes the starting
value, so four updates from 1 approach √2.
The final function names two list elements and computes `x² + y`, whose gradient
at `[3, 4]` is `[6, 1]`. `nth` returns an `Option`; `option.unwrap-or zero`
explicitly uses zero if that element is absent.

The sample supplies both elements.
The local bindings give each lookup a name and evaluate it once.

The remaining outputs follow from these calculations:

| Expression | Result and reason |
|---|---|
| `a \| matmul a` | Multiply each row by each column: the first entry is `4*4 + 1*1 = 17`. |
| `b \| solve a` | `Some` holds the solution `[1/11, 7/11]`; both equations give `b = [1, 2]`. `None` would mean the solver found no unique solution. |
| `a \| determinant` | For this 2×2 matrix, `4*3 - 1*1 = 11`. |
| Complex multiplication | `(3-i)*(1+2i) = 5+5i`, using `i*i = -1`. |
| `last` after iteration | `Some` holds the final estimate; the list contains the initial value and four updates. |

## Follow a derivative through multiplication

A dual number can be read as `(ordinary value, derivative)`. At input `3`,
the input's derivative with respect to itself is `1`:

| Calculation | Ordinary value | Derivative |
|---|---|---|
| Input `x` | `3` | `1` |
| `x * x` | `9` | `1 × 3 + 3 × 1 = 6` |
| `x * x - 2` | `7` | `6 - 0 = 6` |

`derivative f 3.0` returns the derivative `6.0`, not the ordinary value `7.0`.
The next lesson on [reverse mode](../20-autodiff-and-devices/README.md) shows
how a tape records the same dependencies for a backward calculation.

## The program

[`main.fwp`](main.fwp):

```fwp
a = matrix [[4.0, 1.0], [1.0, 3.0]]
b = vector [1.0, 2.0]

f : t -> t where Ring[t], FromFloat[t]
f = fn x -> x * x - 2.0

newton-step : F64 -> F64
newton-step = fn x -> let slope = derivative f x in x - f x / slope

main = [
    a | matmul a | echo,
    b | solve a | echo,
    a | determinant | echo,
    complex 1.0 2.0 | mul (complex 3.0 -1.0) | echo,
    3.0 | derivative f | echo,
    1.0 | iterate 5 newton-step | last | echo,
    [3.0, 4.0]
    | gradient (fn values ->
        let x = values | nth 0 | option.unwrap-or zero
        in let y = values | nth 1 | option.unwrap-or zero
        in x * x + y)
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
