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

## Sending one input to several functions

A **combinator** is an ordinary function that connects other functions. `id`
returns its input unchanged. The combinators used here are:

| Function | Meaning |
|---|---|
| `both f g` | Run `f` and `g` on the same input and return `(first result, second result)`. |
| `fork f g h` | Run `g` and `h` on the input, then give their results to `f`, in that argument order. |
| `flip f` | Exchange the order of `f`'s first two arguments. |
| `curry` / `uncurry` | Convert a pair-taking function to successive arguments / convert back to a pair-taking function. |
| `tap f` | Run `f` on the input, then return the original input; useful for an action such as printing. |
| `const value` | Make a function that ignores its input and returns `value`. |

`length` counts elements in a list; `sum` adds them. For `[3, 5, 10]`,
`both length sum` gives `(3, 18)`. This two-value group is a **tuple**.
`average = fork div length sum` passes `3` and `18` to `div`; because the input
is last, `div 3 18` means `18 / 3`, giving `6`.

A tuple is one value, so taking a tuple still means taking one argument.
It differs from taking a value and returning another function. The ordinary
library functions `curry` and `uncurry` make that conversion explicit.
A **type signature** follows `:`. `I64` means a signed 64-bit integer, and `->`
separates an input type from its result type:

```fwp
sum-pair : (I64, I64) -> I64
sum-pair = uncurry add

sum-curried : I64 -> I64 -> I64
sum-curried = curry sum-pair
```

The first signature takes one pair and returns an integer. The second takes an
integer and returns a function from another integer to an integer: `I64 -> (I64 -> I64)`.

`(2, 3) | sum-pair` gives `5`. `3 | sum-curried 2` also gives `5`, as does
`3 | add 2`. Ordinary curried calls need neither helper; use them when changing
between a pair and successive arguments. The compiler does not implicitly
unpack `(2, 3)` when it is passed to `add`.

## Constant functions

`const 7` is a function; `7` is a number. `map` applies a function to each element
of a list, so `[1, 2, 3] | map (const 7)` gives `[7, 7, 7]`. Passing `7` directly
to `map` is a type error: the argument needs to be callable.

The name `const` means “constant function,” not an immutable variable declaration.
It does not delay evaluating its argument. A constant function can return another
function: `const (add 1)` ignores one input and returns `add 1`, which still needs
a number. [Lesson 4](../04-effects/README.md) explains why this is useful when
updating an explicitly handled state value.

## Reading the complete program

Square brackets make a list, and commas separate its elements. In `main`, each
element prints a result. Elements run left to right, and `ignore` discards the
resulting list. `echo` prints a value; `print` prints a string without quotes.
`upper` changes the letters of a string to uppercase. The final line therefore
prints `PIPES!`.

## The program

[`main.fwp`](main.fwp):

```fwp
double = mul 2

ten = 5 | double

quadruple = double | double

decrement = sub 1

average = fork div length sum

sum-pair : (I64, I64) -> I64
sum-pair = uncurry add

sum-curried : I64 -> I64 -> I64
sum-curried = curry sum-pair

main = [
    ten | echo,
    3 | quadruple | echo,
    10 | decrement | echo,
    [3, 5, 10] | average | echo,
    [3, 5, 10] | both length sum | echo,
    (2, 3) | sum-pair | echo,
    3 | sum-curried 2 | echo,
    "pipes" | upper | concat "!" | print,
] | ignore
```

Run it with `fwp run docs/tutorials/01-pipes-and-functions/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/01-pipes-and-functions/main.fwp -o pipes-and-functions`. The output is
[`main.out`](main.out):

```
10
12
9
6
(3, 18)
5
5
PIPES!
```

`main` is a list because the elements of a list (or a tuple) are
evaluated, and their effects performed, from left to right; `ignore`
discards the result. `echo` shows any value; `print` writes a string.

---

Next: [Data: records, tuples and variants](../02-data/README.md) · [All tutorials](../README.md)
