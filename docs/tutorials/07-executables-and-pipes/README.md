# 7. Functions as executables

An exported function can be built into a standalone program, or run
directly with `fwp exec`. No `main` and no argument parsing are needed:

- the function's leading parameters come from the command line, written in
  fwp's text format;
- the last parameter may come from standard input, one record per line. A
  `List` parameter collects every line;
- a `List` result is written one element per line.

To follow along, go to this directory (`cd docs/tutorials/07-executables-and-pipes`).
The sessions below run exactly as shown: the test suite runs them.

## Running a function

[`tools.fwp`](tools.fwp) has four small functions:

```fwp
# Small tools: each exported function is a program of its own.

export normalize : String -> String
normalize = trim | lower

export scale : I64 -> I64 -> I64
scale = mul

export total : List[I64] -> I64
total = sum

Reading = { sensor: String, celsius: F64 }

export fahrenheit : Reading -> Reading
fahrenheit = update { celsius = mul 1.8 | add 32.0 }
```

`fwp exec` compiles a function (once; it is cached) and runs it with the
rest of the command line:

```console
$ fwp exec tools.fwp scale 6 7
42
$ printf '  Hello\n WORLD \n' | fwp exec tools.fwp normalize
hello
world
$ printf '1\n2\n3\n' | fwp exec tools.fwp total
6
```

## Building it

`fwp build --fn` builds one function into an executable that needs
nothing else to run. A record is written in fwp's text format:

```console
$ fwp build tools.fwp --fn fahrenheit -o fahrenheit
$ echo '{celsius = 21.5, sensor = "roof"}' | ./fahrenheit
Reading {celsius = 70.7, sensor = "roof"}
$ ./fahrenheit '{celsius = -40.0, sensor = "pole"}'
Reading {celsius = -40.0, sensor = "pole"}
```

## Typed pipes

Executables connect like Unix tools. When one fwp program feeds another,
the data travels in a binary protocol that starts with a fingerprint of the
type, so a type mismatch is caught as soon as the pipe starts. `fwp pipe`
connects functions this way:

```console
$ echo 3 | fwp pipe 'tools.fwp:scale 2 | tools.fwp:scale 5'
30
```

`FWP_OUT=bin` makes any executable write the binary form;
[docs/protocol.md](../../protocol.md) describes the wire format.

For a program with flags, `--help` and subcommands, see
[tutorial 16](../16-clis/README.md).

---

Previous: [Tasks and channels](../06-tasks-and-channels/README.md) · Next: [An HTTP server](../08-http-server/README.md) · [All tutorials](../README.md)
