# Work in a notebook

A notebook keeps code cells, results and explanations together. fwp's local
notebook uses the same checked interpreter sessions as the [REPL](repl.md).
It borrows the useful notebook habits of visible dependencies, source-only files
and clear stale results. It is a local browser application, not a Jupyter kernel.

## Start a notebook

From the repository root, install the companion tools into your Python environment:

```sh
python3 -m pip install ./sdk/python
fwp notebook --python python3 --directory . --port 0
```

The tools need Python 3.10 or newer. All three settings are required:
`--python PATH` selects the Python where you installed the package,
`--directory PATH` selects the directory for code and imports, and `--port N`
selects a port. Port `0` explicitly asks the OS for an unused port. The launcher
uses the same fwp executable you invoked. Open the printed address; the server
listens only on `127.0.0.1`. Stop it with Ctrl-C.

To select a different compiler, launch the Python module directly:
`python3 -m fwp_tools.notebook --fwp /path/to/fwp --directory . --port 0`.
If its interpreter process dies, the current run reports an error. Starting a
fresh session requires another explicit cell run; effects are never retried.

The initial notebook explains and computes a 3–4–5 triangle's distance. Its first
code cell defines `x = 3.0` and `y = 4.0`. The next evaluates `x | hypot y`, which
gives `5.0`. `hypot` computes √(x² + y²). The final cell compares the sum of the
squares with 25 and gives `True`. See [scalar math](numerics.md#scalar-math) for
formats, domains and rounding.

## Edit and run cells

- A **definition cell** contains ordinary fwp declarations. Names are shared
  across the notebook; a name must have one definition. All definitions are
  checked together, so their visual order need not match dependency order.
- An **expression cell** evaluates one expression and displays its result.
  Its output is a display, not an implicit variable. Put reusable calculations
  in named definitions rather than relying on REPL `it` or `outN` names.
- A **Markdown cell** contains explanations. The renderer supports headings,
  paragraphs, lists, inline code and fenced code blocks. It treats HTML as text.

Local names stay inside their expression. For example, an expression cell can
contain `let square = 3 * 3 in square + square`, which displays `18`. The
initializer computes `9` once; the body adds that value to itself. `let` and
`in` belong to the same expression: `in` separates the definition from its body.
It neither creates a
notebook-wide `square` nor depends on another cell defining that name. A local
name such as `out1` is an ordinary binding, not a reference to a REPL result.
Named inputs in `fn x -> x * x` likewise do not create cell dependencies.
See [local bindings](repl.md#name-an-input-or-intermediate-value) for more examples.

Choose **Run** on a code cell, or press Ctrl/Command + Enter in its editor.
**Run all** evaluates expression cells in their displayed order after checking
all definitions. **Stop** terminates the current interpreter session; the next
run starts a fresh one. This can stop a nonterminating computation. External
actions already performed, such as a file write, are not undone.

Changing code marks previous results **stale**. They remain visible for comparison
but are not presented as current. Type, trait and macro changes can affect more
than direct value references, so invalidation is deliberately conservative.
Dependency labels show cells providing names or shared type/import context; they
are not a promise that every possible macro dependency has been inferred.
Expression effects never rerun merely because another cell was edited.
Compile-time code can perform its declared actions when definitions are checked;
those are separate from a cell's runtime output.

Definitions remain lazy, as in source files. After code changes, the session is
rebuilt from declarations, and requested expressions are evaluated. Rebuilding
never replays other expression cells. The UI does not silently execute an imported
notebook on open. No notebook feature changes fwp's type, function or effect rules.

## Save explanations with source

**Save notebook** downloads a `.fwpnb` file: readable JSON containing the title,
cell kinds and source text. It does not save live values, execution order state or
captured output. **Open** loads that source without running it. Code edits and
runtime state are separate; run cells to establish new results after opening.

Files are limited to 2 MiB and 500 cells in this first notebook implementation.
The standard library and the imported files in the chosen working directory
remain normal compilation inputs. Use ordinary `.fwp` files for reusable modules.

For terminal experimentation, use the [REPL](repl.md). For stepping through a
calculation or comparing emitted C and native instructions, see the
[debugger/disassembler guide](debugging.md) and its Python SDK examples.

Program standard input is unavailable in JSON/notebook sessions because that
stream carries control commands. Use an explicit file for input data. Attempts
to read standard input, including during macro evaluation, report an error and
leave the session available for the next cell.
