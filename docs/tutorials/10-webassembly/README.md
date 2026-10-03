# 10. WebAssembly

`--target wasm32-wasi` compiles a program to a WebAssembly module for WASI
runtimes such as wasmtime or node. `--target wasm32-browser` also writes a
small JavaScript loader for web pages:

```
fwp build main.fwp --target wasm32-wasi -o collatz.wasm
wasmtime collatz.wasm          # or: node tests/wasm/wasi-run.mjs collatz.wasm

fwp build main.fwp --target wasm32-browser -o collatz.wasm   # also collatz.js
```

In a page:

```html
<script type="module">
  import { run } from "./collatz.js";
  await run({ stdout: (line) => console.log(line) });
</script>
```

WebAssembly has no sockets, so programs that use `Network` are rejected
when they are compiled for these targets, with an error naming the
effect. Tasks and channels (`Async`) work where the JavaScript engine has
JavaScript Promise Integration, which suspends a task's stack while it
waits: Chrome and Edge 137 and later, and node 24 (node 22 with
`--experimental-wasm-jspi`). Built with `--wasm-async=asyncify`, they
work in any JavaScript engine. In wasmtime a program that starts a task
traps. Everything else, files
included (for WASI, in preopened directories), behaves exactly as in a
native build.

Building for WebAssembly needs clang with a WASI sysroot. On Debian or
Ubuntu, install `clang`, `lld`, `wasi-libc` and
`libclang-rt-18-dev-wasm32`.

## The program

[`main.fwp`](main.fwp):

```fwp
# 10. WebAssembly
#
# The same program runs in the interpreter, natively, under WASI and in a
# browser. It only uses effects that every target provides.

# the number of steps of the Collatz sequence from n down to 1
rec collatz-length : I64 -> I64
collatz-length = match
    1 -> 1
    _ -> if (rem 2 | eq 0) (div 2) (mul 3 | add 1) | collatz-length | add 1

# the start below n with the longest sequence
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
