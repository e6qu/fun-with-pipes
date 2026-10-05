# 13. Tooling

Three commands help with fwp code beyond running it: `fwp fmt` formats
it, `fwp lint` points out likely mistakes, and `fwp lsp` brings
diagnostics, types and navigation into an editor.

## Formatting

`fwp fmt` rewrites files in a canonical layout: 80 columns, 4-space
indentation, `match` arms on their own lines, and long pipelines one stage
per line.

```fwp
top-words =
    words
    | frequencies
    | map.to-list
    | sort-by (.1 | neg)
    | take 3
    | map (format "{}: {}")
```

It formats every `.fwp` file under the paths it is given (by default, the
current directory). Comments are kept, and formatting never changes what a
program means: the result always parses to the same syntax tree. In a
continuous integration job, `fwp fmt --check .` lists the files that are
not formatted and fails if there are any.

## Linting

`fwp lint` reports code that compiles but is probably not what was meant,
or could be simpler. On a version of the program below that maps twice and
has no `fwp:allow` comment, it prints:

```
main.fwp:14:32: warning: `map upper | map string.length` traverses twice; use `map (upper | string.length)` [map-fusion]
14 | word-sizes = words | map upper | map string.length
   |                                ^^^^^
main.fwp:16:1: warning: `shout` is never used [unused-binding]
16 | shout = upper | flip concat "!"
   | ^^^^^
```

The fixed version maps once:

```fwp
word-sizes = words | map (upper | string.length)
```

Each warning ends with the code of its rule. The other rules catch
`| id` stages, `match` expressions with a single `_` arm, top-level names
that hide standard library functions, and signatures without a binding.
To keep a rule quiet for one declaration, put `# fwp:allow(code)` in the
comment lines right above it:

```fwp
# fwp:allow(unused-binding)
shout = upper | flip concat "!"
```

## In an editor

`fwp lsp` is a language server: an editor starts it and talks to it over
stdin and stdout. While you type it shows syntax errors (several at once),
type errors and lint warnings; hovering over a name shows its inferred type;
go-to-definition jumps to top-level, imported and standard library names;
and it lists the file's declarations, completes names with their types and
formats the file. Point your editor's LSP client at the command `fwp lsp`
for `*.fwp` files; the [reference](../../reference.md#fwp-lsp) has
configurations for Neovim, Helix and VS Code.

## The program

[`main.fwp`](main.fwp):

```fwp
text : String
text = "the cat and the dog and the bird saw the other cat"

top-words : String -> List[String]
top-words =
    words
    | frequencies
    | map.to-list
    | sort-by (.1 | neg)
    | take 3
    | map (format "{}: {}")

word-sizes : String -> List[I64]
word-sizes = words | map (upper | string.length)

# fwp:allow(unused-binding)
shout = upper | flip concat "!"

main = [
    text | top-words | echo,
    text | word-sizes | echo,
    text | word-sizes | sum | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/13-tooling/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/13-tooling/main.fwp -o tooling`. The output is
[`main.out`](main.out):

```
["the: 4", "and: 2", "cat: 2"]
[3, 3, 3, 3, 3, 3, 3, 4, 3, 3, 5, 3]
39
```

`fwp fmt --check docs/tutorials/13-tooling` and
`fwp lint docs/tutorials/13-tooling` both succeed on it.

---

Previous: [Numerics](../12-numerics/README.md) · [All tutorials](../README.md) · Next: [Services](../14-services/README.md)
