# Debug a program and inspect its machine code

Use the debugger to follow a calculation and inspect its values. Use the
disassembler to see what ahead-of-time compilation produced. The debugger runs
the interpreter; it is not a native-process debugger. Neither tool uses a JIT.

## Stop inside a function

Save this as `square.fwp`:

```fwp
square : F64 -> F64
square = fork mul id id
main = 3.0 | square | echo
```

`square` takes and returns a 64-bit floating-point number. `fork mul id id`
passes the same input to both sides of multiplication, so the result is nine.
Run `fwp debug square.fwp`. At the `(fwpdb)` prompt:

```text
break square
continue
locals
print 0
next
continue
```

The debugger first stops before `main`. `break square` adds a function
breakpoint; `continue` runs until that breakpoint. `locals` lists initialized
slots in the selected frame. A **frame** is one active function call. Since fwp
functions usually leave their input unnamed, parameters are numbered from zero:
`print 0` inspects the first input, `3.0`. It does not evaluate or modify the
program. Floating snapshots include their raw bits; `3.0f64` is
`4008000000000000` in hexadecimal.

| Command | Action |
|---|---|
| `break NAME` / `break FILE:LINE` | Stop at a reachable function or source line. |
| `clear NAME` / `clear FILE:LINE` | Remove that breakpoint. |
| `breakpoints` | List current breakpoints. |
| `step` | Advance to the next source point or function entry, including calls. |
| `next` | Advance within the current call, stepping over nested calls. |
| `return` | Stop when the current call returns. |
| `continue` | Run until a breakpoint, error or completion. |
| `stack` | Show active frames, their source locations and typed local slots. |
| `frame N` | Select a frame; zero is the outermost call. |
| `locals` / `print NAME_OR_SLOT` | Inspect initialized values / one value by its visible source name or slot. |
| `list` | Show the selected frame's current source location and line. |
| `trace EVENTS` | Stream the chosen instrumentation events in JSON mode. |
| `quit` | End this debug execution. |

Named fn/let/match bindings appear with a `name` beside their slot at source
points. `print x` resolves the currently visible `x`; an outer shadowed value
remains inspectable by its slot. These are snapshots, not evaluations of new
expressions. The Python SDK accepts `debug.inspect("x")` as well as a slot number.

Source points are expression boundaries, not every character or C instruction.
One source line can contain several expressions and stop several times. A
breakpoint on a line without an evaluated expression will not be reached.
Program standard input is separate: `fwp debug --input data.txt square.fwp`
reads program data from that file. Without `--input`, a program that tries to
read standard input gets a diagnostic rather than consuming debugger commands.

## Instrument execution from Python

From the repository root, install the SDK into your Python environment with
`python3 -m pip install ./sdk/python`. It requires Python 3.10 or newer and an
`fwp` executable. There are no runtime Python package dependencies.

```python
from fwp_tools.debugger import Debugger

values = []
with Debugger("square.fwp", fwp="./target/debug/fwp", input_file=None, timeout=30) as debug:
    debug.on("value", values.append)
    debug.break_at("square")
    debug.continue_()
    print(debug.inspect(0))
    debug.trace("call", "expression", "value", "bind", "return", "error")
    debug.continue_()

print(values)
```

The compiler, input choice and timeout are required settings. `input_file=None`
forbids program standard input; pass a path to supply it. `timeout=30` bounds each
protocol read to 30 seconds. The context manager closes and reaps the debugger
process. `on` registers a
Python callback; `trace` selects which execution events the interpreter emits.
The example gathers typed expression results after stopping in `square`.
`call`/`return` mark function boundaries, `expression` marks an internal operation
about to run, `value` contains a completed source expression's result, and `bind`
records a local slot being assigned. Output, stops and completion have their own
events. Each execution event identifies its task, function, call depth and source
location when available. Capturing every expression has time and output costs;
select the events needed for a measurement.

Callbacks receive snapshots and must return before execution continues. They
cannot recursively send control commands. Control methods run while paused;
`step()`, `next()`, `return_()` and `continue_()` consume events until the next
stop or completion. `stack()`, `frame(n)`, `locals()` and `inspect(n)` inspect the
paused state. The constructor's `timeout` bounds each protocol read; it is not a
program execution budget. Closing the context terminates a still-running debug
process.

The transport is newline-delimited JSON from `fwp debug --json`. Requests have
`id`, `command` and `argument`; replies carry the same `id` and either `result`
or `error`. Events have `event` instead of a request ID. Program output is sent
as output events, so it cannot impersonate a protocol reply. See the
[Python implementation](../sdk/python/fwp_tools/debugger.py) and
[integration tests](../sdk/python/tests/test_tools.py) for complete examples.

Instrumentation covers interpreted fwp calls and source expressions, including
child tasks and failure propagation. It does not step through the Rust/C runtime,
foreign machine instructions or macro execution during compilation. It does not
change values in paused frames. These are concrete boundaries, not a claim to
instrument every instruction in every execution mode. Debug source markers are
absent from ordinary native compilation.

## Read actual native instructions

Build an executable, then inspect it:

```sh
fwp build square.fwp -O2 -o square
fwp disassemble --tool /path/to/llvm-objdump square
```

Select an installed LLVM `llvm-objdump` with the required `--tool` option.
Use `--tool llvm-objdump` to resolve that name through `PATH`. On macOS, `xcrun --find llvm-objdump` locates the tool shipped with
Xcode command-line tools. `--json` returns structured instruction addresses,
encoding text, assembly and C file/line annotations where debug information is
present. The complete LLVM listing and tool version are retained too.
Disassembly reads the binary; it does not execute it.

An optimized executable without debug information cannot reliably identify its
source lines. Use the SDK comparison below to keep emitted C and debug line
tables. An **encoding** is an instruction's raw hexadecimal representation;
LLVM prints individual bytes on some targets and an instruction word on others.
The report preserves that spelling rather than claiming it is always a sequence
of bytes in memory order.

## Compare C with machine code across targets and optimization levels

```python
from fwp_tools.disassembler import Disassembler, Target

tool = Disassembler(
    fwp="./target/debug/fwp",
    llvm_objdump="/path/to/llvm-objdump",
    timeout=180,
)
report = tool.compare(
    "square.fwp", "square-code-report",
    targets=[
        Target("amd64-linux", "x86_64-linux-gnu-gcc", "x86_64-linux-gnu", triple=None, sysroot=None),
        Target("arm64-linux", "aarch64-linux-gnu-gcc", "aarch64-linux-gnu", triple=None, sysroot=None),
    ],
    levels=("O0", "O1", "O2", "O3"),
)
for target in report["targets"]:
    print(target["name"], target["generated_c"])
for variant in report["variants"]:
    print(variant["target"], variant["optimization"])
    for instruction in variant["instructions"]:
        print(instruction["c_line"], instruction["c_source"],
              instruction["address"], instruction["encoding"], instruction["assembly"])
```

Those compiler paths are examples: install matching toolchains for the requested
targets. Tool paths, timeout, targets and optimization levels are all required.
Ownership is the same counted model as ordinary native execution. The report
records it and each exact C-generation command. Invalid target names or
optimization levels fail before creating output.

The example allows 180 seconds per subprocess. The third `Target` argument
selects fwp's C generation target: `"native"` for the host, or a supported Linux
triple. C is generated separately for each target.
With Clang, supply `triple=...` to select its target. `triple=None` uses the
selected compiler's target, as in the cross-GCC examples. A **sysroot** supplies
the target's headers and libraries; pass its path or explicitly use `sysroot=None`
to use the selected compiler's header search configuration. Missing toolchains or
headers fail explicitly; the tool does not substitute another architecture.
`O0` disables C optimization; `O1`, `O2` and `O3` select the compiler's increasing
optimization levels. fwp's own earlier optimization passes are the same in each
variant. You can also request `Os`, `Oz` or `Og` when the selected C compiler
supports them; unsupported flags report an error. An instruction can correspond to several C operations after inlining or
other transformations; debug line tables are associations, not a one-to-one proof.

The destination must be a new directory. It retains the emitted C, one object
per target/level, source and binary hashes, exact compiler commands/versions,
compiler diagnostics and
`report.json`. An **object file** contains machine code before final linking.
These listings cover the emitted C translation unit, including its embedded
runtime, but not separately linked float/TLS libraries. Inspect a fully linked
binary to include those libraries. Cross-target inspection does not establish
execution support or performance on that processor.

Use the [benchmark guide](benchmarks.md) for timing and memory comparisons.
Disassembly alone cannot tell how fast a program runs on real hardware.
