# fwp tools for Python

Use Python to control the fwp debugger, collect execution events, and compare
emitted C with machine instructions. The package also supplies the local notebook
UI. It needs Python 3.10+ and an installed `fwp` compiler, with no Python runtime
dependencies.

From the repository root:

```sh
python3 -m pip install ./sdk/python
```

Read the [debugger and disassembler guide](../../../docs/debugging.md) for a runnable
program, stepping commands, event meanings, binary inspection and target/O0–O3
comparisons. Read the [notebook guide](../../../docs/notebooks.md) for cell semantics,
launching the browser UI, dependencies and saved files.

```python
from fwp_tools import Debugger, Disassembler

with Debugger("program.fwp", fwp="fwp") as debug:
    debug.on("output", lambda event: print(event["text"], end=""))
    debug.continue_()

listing = Disassembler(llvm_objdump="llvm-objdump").inspect("program")
print(listing["text"])
```

`program.fwp` must be an existing program with a `main`; `program` must already
be a compiled binary. The context manager reaps the debugger process. Debugger
inspection is read-only and runs the interpreter; disassembly never executes
the inspected binary. Cross-target objects do not establish native execution.

The [integration tests](tests/test_tools.py) run actual compiler processes and
compare C/object listings on selected native/cross targets. The
[browser check](browser/check_notebook.py) uses a real Chromium session; its
separate pinned Playwright dependency is only for testing. Current verified
revisions and remaining work are recorded in the
[project handoff](../../../docs/development-state.md).
