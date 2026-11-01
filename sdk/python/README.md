# fwp tools for Python

Use Python to control the fwp debugger, collect execution events, and compare
emitted C with machine instructions. The package also supplies the local notebook
UI. It needs Python 3.10+ and an installed `fwp` compiler, with no Python runtime
dependencies.

From the repository root:

```sh
python3 -m pip install ./sdk/python
```

Read the [debugger and disassembler guide](../../docs/debugging.md) for a runnable
program, stepping commands, event meanings, binary inspection and target/O0–O3
comparisons. Read the [notebook guide](../../docs/notebooks.md) for cell semantics,
launching the browser UI, dependencies and saved files.

Try a complete example. Save `program.fwp`:

```fwp
square : I64 -> I64
square = fn x -> x * x
main = 3 | square | echo
```

Build the binary that will be inspected: `fwp build program.fwp -O2 -o program`.
The debugger executes the checked source; the disassembler reads that saved binary.

```python
from fwp_tools.debugger import Debugger
from fwp_tools.disassembler import Disassembler

with Debugger("program.fwp", fwp="fwp", input_file=None, timeout=30) as debug:
    debug.on("output", lambda event: print(event["text"], end=""))
    debug.continue_()

listing = Disassembler(fwp="fwp", llvm_objdump="llvm-objdump", timeout=180).inspect("program")
print(listing["text"])
```

- The output callback prints the program's `9`; it receives an event, not source code.
- `listing["text"]` contains machine instructions, not another execution result.
- Tool paths, timeouts and input choice are explicit. `input_file=None` forbids
  program standard input; the debugger timeout bounds each protocol read.
- The context manager closes/reaps the debugger. Inspection reads snapshots;
  disassembly does not execute the binary. Cross-target objects do not verify
  native execution on that target.

The [integration tests](tests/test_tools.py) run actual compiler processes and
compare C/object listings on selected native/cross targets. The
[browser check](browser/check_notebook.py) uses a real Chromium session; its
separate pinned Playwright dependency is only for testing. Current verified
revisions and remaining work are recorded in the
[project handoff](../../docs/development-state.md).
