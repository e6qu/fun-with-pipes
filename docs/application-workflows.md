# Follow an application through the tools

Use the same functions in a program, the REPL, a notebook and the debugger.
The REPL, notebook and debugger interpret checked fwp code. A native build
compiles through C before execution. None uses JIT compilation.

Read [lessons 1–5](tutorials/README.md) first. Commands below start at the
repository root with `fwp` on `PATH`; shell redirection uses POSIX syntax.
Notebook setup is in [the notebook guide](notebooks.md), and Python installation
and debugger commands are in [the debugger guide](debugging.md).

## Count words

The [word-count program](../examples/wordfreq.fwp) separates input/output from
`count-words`, a function taking text and returning up to five `(word, count)`
pairs:

```text
text → split words → normalize → count occurrences → sort → first five
```

Normalization lowercases ASCII and removes commas and periods. Sorting puts
larger counts first, then alphabetically orders words with equal counts. This
is a small text-processing example, not a complete natural-language tokenizer.

```sh
fwp run --interp examples/wordfreq.fwp < tests/run/wordfreq.in
fwp build examples/wordfreq.fwp -O2 -o wordfreq
./wordfreq < tests/run/wordfreq.in
```

Both should print:

```text
the: 4
dog: 3
fox: 3
a: 2
lazy: 2
```

In `fwp repl --no-history`, load the definitions and call the function directly:

```text
:load examples/wordfreq.fwp
"hello Hello." | count-words
```

The result is `[("hello", 2)]`: both words normalize to `hello`. `:load` checks
the file's definitions; it does not run `main` or read standard input.

For a notebook, make three code cells:

1. Copy the example's `normalize` and `count-words` definitions, including the
   type signature. Leave out `main`, which reads program input.
2. Define `text = "Pear pear apple"`.
3. Evaluate `text | count-words`.

The third cell shows `[("pear", 2), ("apple", 1)]`. Change the second cell to
`text = "Pear pear apple apple"`. The old result becomes stale; run the third
cell to obtain `[("apple", 2), ("pear", 2)]`. Try `text = 7`: running the third
cell reports that `count-words` needs a string. Restore the text and run again.

To follow the complete program in the debugger:

```sh
fwp debug --input tests/run/wordfreq.in examples/wordfreq.fwp
```

At the debugger prompt, enter `break count-words`, `continue`, then `print 0`.
Slot zero contains the text passed to the function. `clear count-words` and
`continue` finish the calculation and print the counts. The input file belongs
to the program; debugger commands use a separate stream.

## Take one numerical optimization step

[Lesson 20](tutorials/20-autodiff-and-devices/README.md) defines `rosenbrock`,
which scores a list of candidate numbers, and `descend`, which adjusts them.
A lower score is better. Its **gradient** is a list of derivatives: each tells
how the score changes when one input changes slightly.

For each neighboring pair `(x, y)`, the score adds
`100 * (y - x * x) * (y - x * x) + (1 - x) * (1 - x)`.
There are two pairs in `[-1.2, 1.0, 0.5]`. Their scores are 24.2 and 25.0,
giving 49.2 overall, subject to floating-point rounding.

In the REPL:

```text
:load docs/tutorials/20-autodiff-and-devices/main.fwp
[-1.2, 1.0, 0.5] | rosenbrock
[-1.2, 1.0, 0.5] | grad rosenbrock
[-1.2, 1.0, 0.5] | descend
```

The gradient is approximately `[-215.6, 112.0, -100.0]`. `descend` subtracts
`0.001 * gradient` from the input, giving approximately `[-0.9844, 0.888, 0.6]`.
For example, the first component becomes `-1.2 - 0.001 * -215.6 = -0.9844`.
Printed values can include additional rounding digits. One step is not a promise
of convergence for arbitrary inputs or step sizes.

In a notebook, copy just the lesson's `rosenbrock` and `descend` definitions into
one cell. Put this input in another:

```fwp
start : List[F64]
start = [-1.2, 1.0, 0.5]
```

Evaluate `start | grad rosenbrock` and `start | descend` in separate cells.
Change `start` to `[1.0, 1.0, 1.0]`: the score and gradient are zero, so
`descend` leaves the input unchanged. Editing an input marks results stale;
it does not run either computation automatically.

To debug the step, save those definitions and input in `minimize.fwp`, followed
by `main = start | descend | echo`. Run `fwp debug minimize.fwp`, set
`break descend`, and continue. `print 0` shows the input list before adjustment.
The [Python SDK](debugging.md#instrument-execution-from-python) can make the
same stop with `break_at("descend")` and read it with `inspect(0)`.

## Deliver queued callbacks

The [callback service fixture](../tests/fixtures/weak_callback_service.fwp)
builds pending messages, delivers selected messages to a channel, then drains
the channel and checks what arrived. Each message owns sixteen integers and a
**weak reference** to its destination. The weak reference does not keep the
destination alive. Successful lookup obtains an owning reference for delivery;
lookup after the destination is gone returns `None`.

The public `service` function takes `(message-count, mode)` and returns a record.
For 64 messages:

| Mode | Behavior | Calls / received | Checksum |
|---|---|---:|---:|
| `0` | Deliver everything | 64 | 39,936 |
| `1` | Cancel every fourth message before delivery | 48 | 30,336 |
| `2` | Release the destination before dispatch | 0 | 0 |
| `3` | Report an error after delivering message 32, then stop | 33 | 12,408 |

Messages are numbered from zero. Message `i` contains `i` through `i + 15`;
its checksum is `16 * i + 120`. The receiver separately sums delivered payloads.
Mode 3 has one handled error: that message was sent before the callback failed,
so it remains part of both checksums. This is an in-process channel workload,
not an HTTP server or a network throughput test.

```text
:load tests/fixtures/weak_callback_service.fwp
(64, 1) | service
```

The returned record has `cancelled = 16`, `calls = received = 48`, and
`sum = received_sum = 30336`. Read a field with, for example,
`(64, 1) | service | .received`.

For a notebook, copy the fixture's definitions above `main` into one cell.
Define `configuration = (64, 0)` in another and evaluate
`configuration | service` in a third. Change the mode and rerun that expression.
The expression creates and finishes a new service each time; the notebook does
not preserve a live service between these runs. To debug one run, save the
definitions with `main = (64, 0) | service | json.write | print` and stop in
`service`. Slot zero contains `(64, 0)`.

## Keep results and inspect compilation

- **Save notebook** saves source and explanations, not live values or output.
  Reopen it: cells must stay unexecuted until you choose to run them.
- Only selected expression cells run. Editing definitions must not replay a
  previous print, file write or service request. Already performed effects
  cannot be undone by stopping a run.
- The [disassembler SDK](debugging.md#compare-c-with-machine-code-across-targets-and-optimization-levels)
  accepts these same program files. Select the compiler, target and
  `levels=("O0", "O1", "O2", "O3")` explicitly. It retains generated C and
  actual object instructions; cross-target inspection does not execute them.
- Interpreter/debugger timings are not native performance measurements.
  [The application measurement plan](measurements/application-tooling.md)
  separately specifies compiler costs and sustained server load.
