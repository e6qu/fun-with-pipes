# 1. Pipes and functions

You only need `fwp` installed and a terminal for this lesson. Run the commands
from the repository root. A `.fwp` file contains definitions; `name = expression`
gives a name to a value or function. Execution begins with `main`.

## The pipe

Start with this function, taken from the complete program below:

```fwp
double = mul 2
```

`mul` multiplies numbers. `mul 2` is a function waiting for the number to double.
`5 | double` gives `10`: `|` sends the value on its left to the function on its
right. A pipe between two functions creates a new function that runs them in
order:

```fwp
ten = 5 | double
quadruple = double | double
```

Thus `ten` is a number, while `quadruple` is a function. The latter doubles an
input and doubles the result again. `3 | quadruple` gives `12`.

## One argument at a time, with the input last

Every function takes one argument. Its result can be another function:
`mul 2` returns a function that multiplies its input by two. `mul 2 5` means
`(mul 2) 5`, giving `10`. This way of expressing successive arguments is called
**currying**. Supplying only some arguments is **partial application**; `mul 2`
is an example. The input to transform comes last (**data-last**), so `10 | sub 1`
means `10 - 1`, and `"hello" | concat "!"` gives `"hello!"`.

A definition such as `double = mul 2` never names its input. This style is called
**tacit** programming. It uses ordinary functions; it does not add a special
runtime mechanism. Parentheses group a function or expression used as one
argument, as in `map (mul 2)`.

## Arithmetic expressions

You can also write arithmetic between values: `2 + 3 * 4` gives `14`.
Multiplication (`*`), division (`/`) and remainder (`%`) bind more tightly than
addition (`+`) and subtraction (`-`). Parentheses change that grouping:
`(2 + 3) * 4` gives `20`. Operators at the same level group left to right, so
`20 - 6 - 2` gives `12`.

Arithmetic binds more tightly than a pipe: `2 + 3 * 4 | echo` prints `14`.
Function calls bind more tightly than arithmetic: `double 3 + 1` gives `7`,
while `double (3 + 1)` gives `8`. Prefix functions remain useful for tacit
code: `map (add 1)` adds one to each list element.

Write spaces around subtraction: `x - 1`. Hyphenated names such as `count-long`
remain identifiers, and `add -1` still means adding negative one.
`-(2 + 3)` negates the whole sum. These forms use the same numeric types and
overflow checks as the prefix functions.

## Name an input or an intermediate result

A **local binding** gives a value a name within one expression:

```fwp
energy : I64 -> I64
energy = fn x -> let square = x * x in square + square
```

`I64` is a signed 64-bit integer. The signature says `energy` takes one integer
and returns one. `fn x -> ...` names its input `x`. `let square = x * x`
calculates the product once. `in` starts the expression that uses that name;
its result becomes the result of the entire `let`. For input `3`, `square` is
`9`, so `square + square` is `18`. It adds two values; it does not call a function
twice. `3 | energy` and `energy 3` both give `18`.

Bindings are immutable: they cannot be assigned a different value. A nested
`let` may introduce a new name with the same spelling, called **shadowing**:
`let x = 3 in let x = x + 1 in x` gives `4`. The initializer sees the outer `x`;
the body sees the new one. A name is visible only in its own body, not after it.
Unused initializers still run, including their effects and failures.

The body extends through the rest of its expression. Parentheses delimit a
function used as an argument: `map (fn x -> x * x)`. Use `fn _ -> 7` to ignore
an input. `const value` constructs a function that ignores its input and returns
that value. If `calculate` takes the empty tuple `()`, then `const (calculate ())`
calculates once when the function is constructed; `fn _ -> calculate ()`
calculates on every call.

Successive named inputs still mean nested single-argument functions:
`fn amount -> fn value -> value + amount`. A function can remember a value from
its surrounding scope; this is a **capture**. For example, `fn amount -> add amount`
returns a function that remembers `amount`. Captures obey the same ownership and
resource rules as other stored values; names do not promise heap allocation.

## Sending one input to several functions

A **combinator** connects other functions. Keep these when they make a pipe easy
to read; use names when a formula is clearer that way.

| Function | Meaning |
|---|---|
| `id` | Return the input unchanged. |
| `both f g` | Run both functions on the input and return their results as a pair. |
| `fork f g h` | Run `g` and `h`, then pass their results to `f`, in that order. |
| `flip f` | Exchange the first two successive arguments. |
| `tap f` | Run `f`, then return the original input. |
| `const value` | Return a function that ignores its input and returns `value`. |

`length` counts a list and `sum` adds it. For `[3, 5, 10]`, `both length sum`
returns `(3, 18)`, a two-value **tuple**. `average = fork div length sum` gives
`6`: data-last `div 3 18` means `18 / 3`.

A tuple is one argument. `curry` converts a pair-taking function to successive
arguments; `uncurry` converts back. For example, `sum-pair = uncurry add` takes
`(2, 3)` and returns `5`; `sum-curried = curry sum-pair` accepts `2` and then `3`.
The compiler never implicitly unpacks a tuple passed to an ordinary function.

`const 7` is a function; `7` is a number. `[1, 2, 3] | map (const 7)` gives
`[7, 7, 7]`. `map 7` is a type error. Here `const` means “constant function,”
not an immutable binding declaration. It may also return a function:
`const (add 1)` ignores one input and returns `add 1`, which still needs a number.
[Lesson 4](../04-effects/README.md) uses this when updating handled state.

## The complete program

Square brackets make a list. Its elements run left to right; `ignore` discards
the resulting list. `echo` prints a value, `print` prints a string without quotes,
and `upper` changes a string's letters to uppercase.

[`main.fwp`](main.fwp):

```fwp
double = mul 2

ten = 5 | double

quadruple = double | double

decrement = sub 1

energy : I64 -> I64
energy = fn x -> let square = x * x in square + square

average = fork div length sum

sum-pair : (I64, I64) -> I64
sum-pair = uncurry add

sum-curried : I64 -> I64 -> I64
sum-curried = curry sum-pair

main = [
    ten | echo,
    3 | energy | echo,
    3 | quadruple | echo,
    10 | decrement | echo,
    [3, 5, 10] | average | echo,
    [3, 5, 10] | both length sum | echo,
    (2, 3) | sum-pair | echo,
    3 | sum-curried 2 | echo,
    "pipes" | upper | concat "!" | print,
] | ignore
```

Run `fwp run docs/tutorials/01-pipes-and-functions/main.fwp` from the repository
root. It compiles and caches native code. Add `--interp` to interpret instead.
Expected [`main.out`](main.out):

```
10
18
12
9
6
(3, 18)
5
5
PIPES!
```

Next: [Data](../02-data/README.md) · [All tutorials](../README.md)
