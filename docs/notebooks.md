# Work in a notebook

A notebook keeps code cells, results and explanations together. fwp's local
notebook uses the same checked interpreter sessions as the [REPL](repl.md).
It borrows the useful notebook habits of visible dependencies, source-only files
and clear stale results. It is a local browser application, not a Jupyter kernel.

## Start a notebook

From the repository root, install the companion tools into your Python environment:

```sh
python3 -m pip install ./sdk/python
fwp notebook
```

The tools need Python 3.10 or newer. `--python PATH` chooses the Python executable
used by `fwp notebook`. Open the local address printed in the terminal. The server
listens only on `127.0.0.1`; code runs with your local interpreter and working
directory. `--directory PATH` chooses that directory, and `--port N` selects a
port. Stop the server with Ctrl-C.

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
