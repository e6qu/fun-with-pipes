# 12. Numerics

The numeric library builds on the traits from tutorial 3, so most of it
works for any number type.

- `Vector[T, N]` and `Matrix[T, M, N]` carry their sizes in their types.
  `matmul` of incompatible shapes is a compile-time error. The library
  provides `solve`, `determinant`, `inverse`, `cholesky`, `qr` and the
  conjugate gradient method `cg`.
- `Complex[T]` implements the arithmetic traits.
- `derivative`, `gradient`, `jacobian` and `hessian` compute exact
  derivatives with dual numbers (forward-mode automatic differentiation),
  for any function written against the numeric traits.

```fwp
f : t -> t where Ring[t], FromFloat[t]
f = fork mul id id | sub 2.0
```

`f` works on plain floats and on dual numbers alike, which is what lets
`derivative f` exist.

The standard library also has balanced ternary integers
(`TInt[N]`), portable SIMD vectors (`Vec[N, T]`) and tensor expression
graphs.

## The program

[`main.fwp`](main.fwp):

```fwp
# 12. Numerics: matrices, complex numbers and derivatives

# Vectors and matrices know their sizes; a shape mismatch is a compile
# error. Sizes come from the literals.
a = matrix [[4.0, 1.0], [1.0, 3.0]]
b = vector [1.0, 2.0]

# Generic numeric code works for floats, complex numbers and dual numbers.
f : t -> t where Ring[t], FromFloat[t]
f = fork mul id id | sub 2.0

# Newton's method for the root of f, with the derivative computed exactly
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

Run it with `fwp run docs/tutorials/12-numerics/main.fwp`, or compile it with
`fwp build docs/tutorials/12-numerics/main.fwp -o numerics`. The output is
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

Floating-point results are identical in the interpreter and in compiled
code, down to the last digit.

---

Previous: [Compile-time code and macros](../11-comptime-and-macros/README.md) · [All tutorials](../README.md)
