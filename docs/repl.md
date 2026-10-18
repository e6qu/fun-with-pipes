# Try fwp interactively

Run `fwp repl` to enter expressions and see their results immediately. A REPL
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

## Multiline input and terminal editing

An unclosed parenthesis, list or record, or a trailing operator, continues onto
another line. An indented definition continues until a blank line. For example,
enter `long-word =`, then an indented `string.length | gt 3`, then a blank line.
`"hello" | long-word` gives `True` because its length, five, exceeds three.
Use `:paste` / `:end` for a block containing several declarations.

Tab completes names and commands. Arrow keys move through previous entries;
Ctrl-R searches them. Ctrl-C discards unfinished input or interrupts interpreted
calls. Blocking I/O can finish before the interpreter sees the interruption.
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
`:reset` first. External actions already performed by a failed cell, such as a
file write, cannot be undone by recovering from the error.

Results remain reachable through their `outN` names until `:reset` or exit. The
session also retains checked code for captured functions. This deliberately uses
memory to preserve interactive results; it is not a benchmark of a compiled
program's ownership or ARC behavior. Consume resources such as open files within
one cell, using helpers such as `file.with`; reusable results cannot hold affine
resources (values that may be consumed only once). Child tasks are joined at the
end of a successful cell and cancelled after a failed cell. Foreign C calls need
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
benchmark or a comparison with C/Rust. Use the [benchmark guide](benchmarks.md)
for those comparisons.

Native terminals save the last 1,000 history entries for recall. The startup
message prints the history path. Use `--history PATH` to choose it or
`--no-history` to avoid reading/writing a history file. The default is
`$XDG_STATE_HOME/fwp/repl-history` when set, otherwise
`$HOME/.local/state/fwp/repl-history` on Unix or
`%LOCALAPPDATA%/fwp/repl-history` on Windows. History is source text, not restored
variables. Piped input uses the same session engine without prompts, terminal
escapes or a history file; this mode also works in the WASI compiler.
