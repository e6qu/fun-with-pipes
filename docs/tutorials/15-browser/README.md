# 15. fwp in the browser

There are two ways to run fwp in a web page. A finished program can be
compiled to WebAssembly with a small JavaScript loader. Or fwp itself, the
compiler and the interpreter, can run in the page. This is what the
playground does, and it needs no server and no C compiler.

## A program, compiled for the browser

`--target wasm32-browser` writes the module and a loader next to it:

```
fwp build main.fwp --target wasm32-browser -o palindromes.wasm   # also palindromes.js
```

```html
<pre id="out"></pre>
<script type="module">
  import { run } from "./palindromes.js";
  const out = document.getElementById("out");
  const code = await run({ stdout: (line) => (out.textContent += line + "\n") });
</script>
```

`run` resolves to the exit code. It also takes `stderr`, `args`, `env` and
`stdin` (a string). The page must be served over HTTP, since the loader
fetches the `.wasm` file, for example with `python3 -m http.server`. The
program gets standard streams, clocks and random numbers; there are no
files. As in [tutorial 10](../10-webassembly/README.md), programs with
`Network` are rejected when they are compiled, tasks need a browser with
JavaScript Promise Integration (Chrome and Edge 137 and later), and
compiling needs clang with a WASI sysroot.

## fwp itself, in the browser

fwp is written in Rust without dependencies, so it also builds for
WebAssembly:

```
rustup target add wasm32-wasip1
scripts/build-playground.sh             # web/fwp.wasm and web/examples/
python3 -m http.server -d web 8000      # then open http://localhost:8000
```

The playground (`web/index.html`) has an editor, a box for standard input
and an example menu with these tutorials. **Run** calls `fwp run main.fwp`,
**Check** calls `fwp check`, **Format** calls `fwp fmt -` and **Test**
calls `fwp test`. fwp runs in a web worker, and `web/wasi.js` gives it
a WASI with an in-memory file system, so `import` works there too. The same
`fwp.wasm` runs under other WASI runtimes, such as wasmtime or node's
(`tests/wasm/fwp-run.mjs` runs it with either node's WASI or the
playground's):

```
node tests/wasm/fwp-run.mjs wasi web/fwp.wasm run main.fwp
echo 'main = print "hi"' | node tests/wasm/fwp-run.mjs shim web/fwp.wasm run -
```

A file name of `-` reads the program from standard input. That is
convenient for hosts that have no file system to offer.

This build has the limits of the `wasm32-wasi` target, and for the same
reasons. WebAssembly has no threads, so tasks run as fibers that the
browser suspends and resumes with JavaScript Promise Integration: the
example menu includes [tutorial 6](../06-tasks-and-channels/README.md),
which runs in Chrome and Edge 137 and later. It has no sockets, it cannot
start processes, and it cannot load C code. A program that needs sockets
or foreign C functions (or tasks, in a browser without JSPI) is rejected
before it starts, with an error that names what is missing. `fwp build` (except
`--emit-c`), `fwp pipe` and `fwp serve` say that they are not available.
Deep recursion is limited by the engine's stack, which in a browser is a
few hundred to a few thousand nested calls; beyond that, the program traps
with `stack overflow`. Long lists are fine.

## The program

The program below uses only pure functions and standard output. So it runs
unchanged in the interpreter, as a native executable, compiled to
WebAssembly, and in the playground:

```fwp
# The words that read the same backwards, each once.
palindromes : String -> List[String]
palindromes = words | filter (fork eq string.reverse id) | unique
```

Its `test` declaration runs with `fwp test main.fwp`, or with the
playground's **Test** button:

```fwp
test "palindromes" = "noon or never" | palindromes | eq ["noon"]
```

[`main.fwp`](main.fwp):

```fwp
# 15. fwp in the browser
#
# A program that runs the same in the interpreter, natively, compiled to
# WebAssembly, and in the playground, where fwp itself is WebAssembly.

poem = "level noon kayak\nrefer to the radar\nstats"

# The words that read the same backwards, each once.
palindromes : String -> List[String]
palindromes = words | filter (fork eq string.reverse id) | unique

# The length of the longest line.
widest : String -> Option[I64]
widest = lines | map string.length | maximum

test "palindromes" = "noon or never" | palindromes | eq ["noon"]

main = [
    poem | palindromes | echo,
    poem | widest | echo,
    poem | lines | map (format "> {}") | each print,
] | ignore
```

Run it with `fwp run docs/tutorials/15-browser/main.fwp`, or compile it with
`fwp build docs/tutorials/15-browser/main.fwp -o browser`. The output is
[`main.out`](main.out):

```
["level", "noon", "kayak", "refer", "radar", "stats"]
Some 18
> level noon kayak
> refer to the radar
> stats
```

---

Previous: [Services](../14-services/README.md) · Next: [Command-line programs](../16-clis/README.md) · [All tutorials](../README.md)
