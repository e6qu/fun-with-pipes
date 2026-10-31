# Try fwp interactively

Run `fwp repl --no-history` to enter expressions and see their results immediately. A REPL
means *read, evaluate, print, loop*. It checks and interprets each entry; it does
not generate machine code or use a JIT. Read [lesson 1](tutorials/01-pipes-and-functions/README.md)
for pipes and functions, then try:

```text
In [1]: 2 + 3 * 4
Out[1]: 14
In [2]: out1 | mul 2
Out[2]: 28
In [3]: it == 28
Out[3]: True
```

Multiplication precedes addition. `out1` is the first expression's stored value;
`it` names the latest successful result. A pipe passes that value to the next
function, so `mul 2` doubles it. `==` tests equality. Input numbers count cells,
including definitions and failures; commands such as `:type` do not take a number.

## Define functions and inspect types

Enter ordinary definitions, such as `double = mul 2`, then `21 | double` gives
`42`. A **type** describes the values a function accepts and returns. `:type 42`
shows `I64`, a signed 64-bit integer; `:type 1 == 2` shows `Bool`. Writing `42?`
is another way to request its type without evaluating it. `:names` lists session
bindings and their signatures.

A function that works at several types is **generic**. Definitions keep the
language's normal explicit-signature rule for generics. `:type id` can inspect
a generic expression, but evaluating an expression needs a concrete type.
Use a concrete signature when saving a function as a result:

```fwp
increment : I64 -> I64
increment = add 1
```

Enter those two declarations with `:paste`, followed by a line containing `:end`.
Now `40 | increment` gives `41`. `I64 -> I64` means one integer argument and one
integer result. The input remains unnamed: `add 1` already describes the function.

## Name an input or intermediate value

`fn x -> body` defines a function with one input named `x`. A strict local binding,
`let name = value in body`, computes `value` once and makes the name available in
`body`. For example, enter these expressions in a fresh session:

```text
In [1]: let square = 3 * 3 in square + square
Out[1]: 18
In [2]: (fn x -> x * x) 4
Out[2]: 16
```

The first expression adds the stored value `9` to itself. `in` starts the
expression that uses the binding; it does not call a function or repeat the
initializer. `square` is local to that expression and is unavailable in the next
cell. The second expression calls a single-input function with `4`.

Nested functions can keep earlier inputs. With `:paste`, enter:

```fwp
make-adder : I64 -> I64 -> I64
make-adder = fn amount -> fn value -> amount + value
```

`make-adder 3` returns a function that remembers `3`; `make-adder 3 4` returns `7`.
Saving the returned function as an expression result preserves its captured value
and checked code, even if you redefine `make-adder` later. Computation that builds
the returned function runs when you submit the expression. Reading its `outN`
result later uses that same value; it does not repeat the construction or its
effects.

## Multiline input and terminal editing

An unclosed parenthesis, list or record, or a trailing operator, continues onto
another line. A `let` without its `in` body also continues. An indented definition continues until a blank line. For example,
enter `long-word =`, then an indented `string.length | gt 3`, then a blank line.
`"hello" | long-word` gives `True` because its length, five, exceeds three.
Use `:paste` / `:end` for a block containing several declarations.

Tab completes names and commands. Arrow keys move through previous entries;
Ctrl-R searches them. Ctrl-C discards unfinished input or interrupts interpreted
calls. Blocking I/O can finish before the interpreter sees the interruption.
In this terminal session, Ctrl-C also interrupts code that polls
`signal.shutdown-requested`. Standalone programs keep that API's graceful
shutdown behavior.
Ctrl-D on empty input or `:quit` exits. A type error or runtime trap leaves the
session open; a failed redefinition leaves the prior definition available.

## Values, effects and memory

Definitions are lazy, as in ordinary source: a cached value is evaluated when
first used at a concrete type. An expression executes once and saves its result.
Reading `out1` later does not run the first cell again. For instance,
`42 | tap echo` prints `42` while computing the result; reading that result in a
later cell prints only the REPL's result line, without repeating `echo`.
`tap f` performs `f` and returns the input unchanged.

Redefining a name affects subsequent uses; stored results and captured functions
keep their earlier values. Types with live values cannot be redefined: use
`:reset` first. The same rule applies when an imported file changes a named
type's fields or variants; stored values keep their original representation.
External actions already performed by a failed cell, such as a
file write, cannot be undone by recovering from the error.

Results remain reachable through their `outN` names until `:reset` or exit. The
session also retains checked code for captured functions. This deliberately uses
memory to preserve interactive results; it is not a benchmark of a compiled
program's ownership or ARC behavior. Consume resources such as open files within
one cell, using helpers such as `file.with`; reusable results cannot hold affine
resources (values that may be consumed only once). Child tasks are joined at the
end of a successful cell and cancelled and joined after a failed cell. Background
connection workers also stop before the cell returns; consume remote streams
within that cell rather than saving an unfinished stream for later. This keeps
workers from retaining the previous cell's program or output writer. Foreign C calls need
an ahead-of-time executable; the REPL does not compile C shims.

## Save work and measure a cell

| Command | Meaning |
|---|---|
| `:load path.fwp` | Add/check source declarations. Imports resolve from the session's starting directory. |
| `:save path.fwp` | Write current user declarations to a source file; overwrites that file. Stored `outN` values and `it` are omitted. |
| `:history` | Show cells entered in this session, including failed cells. |
| `:time expression` | Execute once; show checking/linking time separately from interpreted evaluation. |
| `:reset` | Release definitions, results and retained code; keep input history. |
| `:help` | List commands and editing keys. |

`:save` writes source, not a snapshot of runtime values. A declaration referring
to `outN` or `it` needs to be rewritten to a normal definition before using the
saved file independently. `:time` includes the expression's effects and waiting
for its tasks. It is a one-shot interpreter measurement, not a repeated native
benchmark or a comparison with Swift, C or Rust. Use the [benchmark guide](benchmarks.md)
for those comparisons.

Choose the session mode explicitly. `--history PATH` enables terminal editing
and saves the last 1,000 history entries at that path. `--no-history` enables
terminal editing without reading or writing a history file. History is source
text, not restored variables. Neither mode silently switches to scripted input
when a terminal is unavailable.

Use `fwp repl --stream` for piped input without prompts, terminal escapes or a
history file; this mode also works in the WASI compiler. `--json` selects the
notebook/automation protocol. Every JSON request needs a string `command` and
string `source`: for example, `{"command":"submit","source":"6 * 7"}` returns
42. Commands are `submit`, `type`, `analyze` and `reset`; reset takes empty source.
Missing fields report errors and never implicitly execute code.

Program standard input is unavailable in JSON/notebook sessions because that
stream carries control commands. Use an explicit file for input data. Attempts
to read standard input, including during macro evaluation, report an error and
leave the session available for the next cell.
