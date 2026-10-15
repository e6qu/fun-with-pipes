# 10. WebAssembly

Read lessons 1–4 first. WebAssembly is a portable compiled instruction format.
A **host** runs that code and supplies access to the outside world. WASI is one
such interface for things like files and standard output. A browser instead
uses JavaScript glue to connect the module to a page. A **sysroot** supplies the
headers and libraries needed to compile for the target rather than your computer.

Build commands using `main.fwp` below run from this lesson's directory. Paths
starting `tests/` or `docs/` are relative to the repository root. The HTML example
loads the generated JavaScript as a module; `await` waits for its asynchronous
`run` operation to finish.

`--target wasm32-wasi` compiles a program to a WebAssembly module for WASI
runtimes such as wasmtime or node. `--target wasm32-browser` also writes a
small JavaScript loader for web pages. A WASI module runs under
wasmtime, or under node with `node tests/wasm/wasi-run.mjs collatz.wasm`:

```
fwp build main.fwp --target wasm32-wasi -o collatz.wasm
wasmtime collatz.wasm
```

For a page, the build writes `collatz.js` next to the module:

```
fwp build main.fwp --target wasm32-browser -o collatz.wasm
```

In a page:

```html
<script type="module">
  import { run } from "./collatz.js";
  await run({ stdout: (line) => console.log(line) });
</script>
```

These fwp WebAssembly targets do not expose sockets, so programs that use
`Network` are rejected
when they are compiled for these targets, with an error naming the
effect. Tasks and channels (`Async`) need JavaScript Promise Integration (JSPI),
which lets the host suspend a WebAssembly stack while a task waits, or a build
with `--wasm-async=asyncify`, which transforms the module to support suspension.
The repository tests these paths separately. In wasmtime, starting a task traps.
WASI file access is limited to directories the host explicitly opens for the
module (preopened directories). See the [target limits](../../reference.md#targets)
before moving a native program to either target.

Building for WebAssembly needs clang with a WASI sysroot. On Debian or
Ubuntu, install `clang`, `lld`, `wasi-libc` and
`libclang-rt-18-dev-wasm32`.

## Reading the example

The Collatz sequence halves even inputs and maps odd inputs to `3n + 1`,
repeating until 1. `rec` declares recursion. `collatz-length` counts terms including
that final 1, so starting at 27 gives 112. `longest` checks inputs 1 through 999
(`range` excludes its upper bound), pairs each with its length, sorts by `.1`
(the length), and selects the last. The result is optional because `last` can
receive an empty list. For this range it is `Some (871, 179)`.

## The program

[`main.fwp`](main.fwp):

```fwp
rec collatz-length : I64 -> I64
collatz-length = match
    1 -> 1
    _ -> if (rem 2 | eq 0) (div 2) (mul 3 | add 1) | collatz-length | add 1

longest : I64 -> Option[(I64, I64)]
longest = range 1 | map (both id collatz-length) | sort-by .1 | last

main = [
    27 | collatz-length | echo,
    1000 | longest | echo,
    "fwp" | string.reverse | upper | print,
] | ignore
```

Run it with `fwp run docs/tutorials/10-webassembly/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/10-webassembly/main.fwp -o webassembly`. The output is
[`main.out`](main.out):

```
112
Some (871, 179)
PWF
```

`rec` is required for a recursive definition; it can go on the signature
line, as here.

---

Previous: [Calling C](../09-c-interop/README.md) · Next: [Compile-time code and macros](../11-comptime-and-macros/README.md) · [All tutorials](../README.md)
