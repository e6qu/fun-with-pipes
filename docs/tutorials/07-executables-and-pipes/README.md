# 7. Functions as executables

Any `export`ed function can be built into a standalone program, or run
directly with `fwp exec`:

- the function's leading parameters come from the command line, written in
  fwp's text format;
- the last parameter may come from standard input, one record per line. A
  `List` parameter collects every line;
- a `List` result is written one element per line.

```
$ fwp exec main.fwp scale 6 7
42
$ printf '  Hello\n WORLD \n' | fwp exec main.fwp normalize
hello
world
$ printf '1\n2\n3\n' | fwp exec main.fwp total
6
$ fwp build main.fwp --fn fahrenheit -o fahrenheit
$ echo '{celsius = 21.5, sensor = "roof"}' | ./fahrenheit
Reading {celsius = 70.7, sensor = "roof"}
```

## Typed pipes

Executables connect like Unix tools. When one fwp program feeds another,
the data travels in a binary protocol that starts with a fingerprint of the
type, so a type mismatch is caught as soon as the pipe starts. `fwp pipe`
connects functions this way:

```
$ fwp pipe 'main.fwp:scale 2 | main.fwp:scale 5' <<< 3
30
```

`FWP_OUT=bin` makes any executable write the binary form;
[docs/protocol.md](../../protocol.md) describes the wire format.

## The program

[`main.fwp`](main.fwp):

```fwp
# 7. Functions as executables
#
# Every `export`ed function can become a standalone program: its curried
# parameters come from the command line, and the last one may come from
# standard input, one record per line.

export normalize : String -> String
normalize = trim | lower

export scale : I64 -> I64 -> I64
scale = mul

export total : List[I64] -> I64
total = sum

Reading = { sensor: String, celsius: F64 }

export fahrenheit : Reading -> Reading
fahrenheit = update { celsius = mul 1.8 | add 32.0 }

# `main` shows the same functions called from fwp.
main = [
    "  Hello WORLD " | normalize | print,
    7 | scale 6 | echo,
    [1, 2, 3, 4] | total | echo,
    { sensor = "roof", celsius = 21.5 } | fahrenheit | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/07-executables-and-pipes/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/07-executables-and-pipes/main.fwp -o executables-and-pipes`. The output is
[`main.out`](main.out):

```
hello world
42
10
Reading {celsius = 70.7, sensor = "roof"}
```

The program's `main` uses the same functions from fwp, which is how its
expected output is checked.

---

Previous: [Tasks and channels](../06-tasks-and-channels/README.md) · Next: [An HTTP server](../08-http-server/README.md) · [All tutorials](../README.md)
