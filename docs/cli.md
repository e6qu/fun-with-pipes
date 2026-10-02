# Command-line programs

Any exported function is a command-line program. Its parameters are the
command line: a record parameter becomes flags, the others are positional
arguments, the last one may come from standard input, and the comments
above it become `--help`. One file of exported functions builds into one
executable with a subcommand per function. There is nothing to declare
and no argument parser to call.

```
$ fwp build examples/cli/todo.fwp --cli -o todo
$ ./todo add buy milk
added
$ ./todo list
  1. [ ] buy milk
$ ./todo done 1 -f todo.txt
item 1 is done
$ ./todo help
usage: todo <command> [arguments...]
...
```

This page describes the mapping. [protocol.md](protocol.md) describes the
binary protocol between fwp programs, and the
[tutorial](tutorials/16-clis/README.md) walks through an example.
`examples/cli/` has four complete programs: `wc.fwp`, `grep.fwp`,
`todo.fwp` and `dirstat.fwp`.

## Building and running

| Command | Result |
|---|---|
| `fwp build file.fwp --fn f -o f` | the exported function `f` as an executable |
| `fwp build file.fwp --cli -o tools` | every exported function as a subcommand of `tools` |
| `fwp exec file.fwp f args...` | runs `f` with the interpreter, as `--fn f` would |
| `fwp exec --cli file.fwp args...` | runs the file as `--cli` would, named after the file |

`--target wasm32-wasi` builds the same programs as WebAssembly modules
(for example `wasmtime --dir=. wc.wasm -l notes.txt`), without the `Process`
effect. The interpreter and native executables parse the same command lines,
print the same help and errors and exit with the same statuses (the test
suite runs every scenario of `tests/cli.rs` both ways).

## Positional arguments and standard input

A function `f : A -> B -> C -> R` takes `A`, `B` and `C` as arguments, each
written in fwp's text format (the format `show` produces), except that a
string is taken as it is and a `Bool` may also be `true` or `false`.

* With all of them, `f` runs once.
* With one fewer, the last parameter comes from standard input: one value
  per line (or binary frames from another fwp program, see
  [protocol.md](protocol.md)). A `List[T]` parameter receives every line
  at once; any other type runs `f` once per line, streaming.
* Other counts are usage errors.
* A final `()` parameter is not an argument: `tracked : () -> List[String]`
  runs with no arguments.

An argument that starts with `-` followed by a digit is a number, not a
flag: `scale -3 14` works. `--` ends the flags; everything after it is
positional.

### Names and the remaining arguments

A comment line `# args:` above the `export` names the positional
parameters for the usage line and the help. A trailing `...` on the last
name, whose parameter must be a `List`, makes it take all remaining
arguments (zero or more), each parsed as an element; it then never reads
standard input, so the function can do that itself:

```fwp
# Count the lines, words and bytes of each FILE, or of standard input when
# there is none, with a total for several files.
# args: FILE...
export wc : WcOptions -> List[String] -> List[String] ! {IO, FileIO, Error[IoError]}
```

A line `# command: NAME` gives the command another name, for exported
functions whose natural name is taken by the standard library (`add`,
`list`, `count`...): `export add-item` with `# command: add` is
`todo add`.

## Flags from a record

When the first parameter is a record (nominal or structural, but not a
tuple, `()` or `Duration`), it is the *options record*: each field is a
flag, written as the field is named.

```fwp
GrepOptions = {
    # -i  ignore case
    ignore-case: Bool,
    # -v  print the lines that do not match
    invert: Bool,
    # -n  print line numbers
    line-number: Bool,
    # -c  print only the number of selected lines
    count: Bool,
}
```

| Field type | On the command line | When absent |
|---|---|---|
| `Bool` | a switch: `--invert`, `--no-invert`, `--invert=false` | `False` |
| `Option[T]` | `--label text` or `--label=text` | `None` |
| `List[T]` | repeatable: `-e a -e b` gives `["a", "b"]` | `[]` |
| any other `T` | `--times 3` or `--times=3` | required |

* A field comment that starts with `-x` gives the flag the short form
  `-x`; the rest of the comment describes the flag in the help. Short
  switches combine (`-iv`), and a short flag takes its value from the next
  argument or from the rest of the word (`-n 5`, `-n5`).
* Flags and positional arguments may be mixed; a flag given twice keeps
  the last value (a list collects them).
* Values are parsed by the field's type, like positional arguments.
* Unknown flags, missing values and values that do not parse are usage
  errors (exit status 2), reported with the usage line:

```
$ ./grep --colour x
grep: unknown option `--colour`
usage: grep [options] PATTERN [FILE...]
```

A function whose only parameter is a record keeps its older meaning when
its first argument does not start with `-`: `norm '{x = 3.0, y = 4.0}'`
and records on standard input still work, and `norm --x 3 --y 4` uses
flags. (When every field has a default, no argument also means flags.)

### Defaults

Defaults are values, so they are typed and checked:

```fwp
export dirstat.defaults : { top: I64 }
dirstat.defaults = { top = 10 }
```

* `export f.defaults` is a record with some of the fields of `f`'s options
  record, of the same types; those fields are no longer required.
* `export defaults` gives defaults to every command that has those fields
  (fields a command does not have are ignored), and `f.defaults` overrides
  it. `examples/cli/todo.fwp` uses it for the `--file` of all its
  commands.
* A default may be given for any field, so a switch can default to
  `True` (`--no-name` turns it off) and a list to some elements (the flag
  then replaces them).

Neither value is a command, and both are computed when the program starts
(they are pure values).

## Help, usage and version

`--help` and `-h` print the help on standard output and exit with status
0 (unless the options record has a field `help` or a short flag `-h`):

```
$ ./grep --help
usage: grep [options] PATTERN [FILE...]

Print the lines of the FILEs (or of standard input) that contain
PATTERN.

arguments:
  PATTERN  String
  FILE...  String, any number

options:
  -i, --ignore-case  ignore case
  -v, --invert       print the lines that do not match
  -n, --line-number  print line numbers
  -c, --count        print only the number of selected lines
  -h, --help         show this help
```

* The description is the block of `#` comments directly above the
  `export` (without the `# args:`, `# command:` and `# fwp:allow` lines).
  Its first sentence is the command's summary in a multi-command help.
* Each flag shows its value type, its comment, and `(default: ...)`,
  `(required)` or `(repeatable)`.
* Positional arguments show their names (or `<Type>`), their types, and
  whether they may come from standard input.

`--version` prints the program name and the exported
`version : String`, and exists only when there is one:

```fwp
export version : String
version = "1.0.0"
```

## Multi-command programs

`fwp build file.fwp --cli -o tools` makes `tools`, whose first argument
names an exported function (or its `# command:` name):

```
tools <command> [arguments...]    run a command
tools help                        the commands and their summaries
tools help <command>              the help of a command
tools <command> --help            the same
tools --help, tools -h            the commands
tools --version                   the version
tools                             the commands, on stderr, exit status 2
```

The program's description is the comment block at the top of the file,
when a blank line separates it from the first declaration. The name of
the program is the name of the executable given with `-o` (or the file
name), and messages of a command start with `tools command:`.
`version`, `defaults` and `*.defaults` are not commands.

## Results, errors and exit statuses

| The function... | The program |
|---|---|
| returns a value | writes it as text (strings without quotes), then a newline |
| returns a `List[T]` | writes one line per element |
| returns `Option[T]` | writes the value, or nothing for `None` (a per-line function returning `Option` is a filter) |
| returns `()` | writes nothing |
| returns `Result[T, E]` | writes `T` as above, or for `Err e` writes `name: e` on stderr and exits with 1 |
| raises an uncaught `Error[E]` | writes `name: e` on stderr and exits with 1 |
| calls `exit n` | exits with `n` (modulo 256) |
| traps (overflow, ...) | `fwp: trap: ...` on stderr, exit status 101 |

An `IoError` is shown by its message, as in
`wc: missing.txt: No such file or directory`. In per-line mode the program
stops at the first error. The statuses are:

| Status | Meaning |
|---|---|
| 0 | success (also for `--help` and `--version`) |
| 1 | an `Err` result or an uncaught `Error` |
| 2 | usage: unknown flag, bad value, missing flag, wrong number of arguments, unknown command |
| 3 | input on stdin that does not parse, or binary input of another type |
| 101 | a trap |

The result of an exported function is always output, so an `I32` result
is printed; only `main` returns its exit status as an `I32`. A command
that wants another status calls `exit` (after its output). With
`FWP_OUT=bin`, results are written in the binary protocol and the
program's own `print` output goes to stderr ([protocol.md](protocol.md)).

## A hand-written `main`

Programs that parse their own arguments use the same rules through the
`cli` module of the standard library ([stdlib.md](stdlib.md)).
`cli.parse defaults arguments` is `Ok (options, positional)` or
`Err message`; a field whose flag is absent keeps its value in
`defaults`, and `--help` is a flag like any other, so a program that
wants it has a `help: Bool` field. `cli.help defaults` is the help lines
of the flags, and `cli.usage-error usage message` prints both and exits
with status 2:

```fwp
Options = {
    # -n  how many lines
    lines: I64,
    # -h  show the help
    help: Bool,
}

defaults : Options
defaults = Options { lines = 10, help = False }

usage : String
usage = "usage: first [-n LINES] FILE..."

help-text : String
help-text = defaults | cli.help | flip concat (concat "\noptions:\n" usage)

# The first lines of each file.
first : (Options, List[String]) -> () ! {IO, FileIO, Error[IoError]}
first = if (.0 | .help) (const help-text | write) (
    fork each (.0 | .lines | take | compose file.read-lines | flip compose (each print)) .1
)

main =
    ()
    | args
    | cli.parse defaults
    | match
        Ok _ -> first
        Err _ -> cli.usage-error usage
```

```
$ fwp build first.fwp -o first
$ ./first --bad
unknown option `--bad`
usage: first [-n LINES] FILE...
$ ./first -h
usage: first [-n LINES] FILE...
options:
  -n, --lines <I64>  how many lines (default: 10)
  -h, --help         show the help
```

## Standard library for command-line programs

| Module | Functions |
|---|---|
| files (`FileIO`) | `file.read`, `file.read-lines`, `file.write-new`, `file.write-lines`, `file.append`, `file.read-bytes`, `file.write-bytes`, `file.copy`, `file.rename`, `file.remove`, `file.exists`, `file.is-dir`, `file.info` (size, modification time, directory) |
| directories (`FileIO`) | `dir.list` (sorted), `dir.walk` (every file below, in order), `dir.create`, `dir.create-all`, `dir.remove` |
| paths (pure) | `path.join`, `path.basename`, `path.dirname`, `path.extension`, `path.stem`, `path.normalize`, `path.is-absolute` |
| processes (`Process`) | `process.run` (capture stdout, stderr and the status), `process.run-input`, `process.output`, `process.call` (shares the terminal) |
| environment (`IO`) | `args`, `env.get`, `env.vars`, `env.cwd`, `env.home`, `exit`, `eprint`, `read-lines` |
| terminal (`IO`) | `term.is-tty`, `term.color` (a terminal and no `NO_COLOR`), `term.paint`, `ansi.bold`, `ansi.red`... |
| text | `table.lines`, `table.format` (aligned columns), `pad-left`, `pad-right`, `group-by` |

A command is a list, the program and its arguments, and runs without a
shell: `["git", "log", "-1"] | process.run`. `Process` is an effect of its
own; WebAssembly targets have no processes and reject programs that use
it at compile time, as they reject `Network` and `Async`.

## What was missing, and what was added

To find out what CLIs needed, we wrote the programs of `examples/cli`
(`wc`, `grep` with flags, `todo` with subcommands and a file, `dirstat`
walking a directory), a CSV-to-JSON converter and a command that lists
the files `git` tracks with their sizes, and tried to build them as
native executables with the language as it was.

What was missing in the language and its tools:

* **Flags.** An exported function took only positional arguments in the
  text format, so options had to be written as a record literal
  (`'{ignore-case = True, invert = False}'`). Added: flags from an
  options record, short flags from field comments, defaults
  (`f.defaults`, `defaults`), `--` and negative numbers.
* **Help and version.** A usage error printed only the parameter types.
  Added: `--help` from the signature and comments, `--version` from an
  exported `version`.
* **One program, several commands.** Each function was its own
  executable. Added: `fwp build --cli` and `fwp exec --cli`.
* **Command names.** Natural command names (`add`, `list`, `count`) are
  standard library names, which an export shadows inside its own file.
  Added: `# command: name`.
* **Variable numbers of arguments.** `wc FILE...` was impossible: a
  `List` parameter was one `[..]` argument or standard input. Added:
  `# args: FILE...`.
* **Errors.** A `Result` was printed as `Err ...` with exit status 0, an
  uncaught `IoError` was printed as `IoError {0 = ..., 1 = ...}` by the
  interpreter and as `<opaque>` by native programs (its type had no
  descriptor), and the interpreter added Rust's `(os error 2)` to I/O
  messages where C does not. Fixed: `Err` and uncaught errors print
  `name: message` and exit with 1; both backends display `IoError` the
  same way.
* **Filters.** A per-line function returning `Option` printed `Some x`
  and `None`. Now `None` writes nothing.
* **No arguments.** A command without arguments (`tracked : () -> ...`)
  had to be called as `tracked '()'`, or read `()` from standard input.
  A final `()` parameter is now implicit.
* **Strings with spaces.** A string argument lost its leading spaces
  (`--sep ' '` became empty) although the protocol says strings are
  taken verbatim; both backends now keep them.

What was missing in the standard library: listing, walking, creating and
removing directories; existence, size and time of files; appending,
renaming, copying, removing files; bytes from and to files; paths;
running another program and capturing its output; the environment as a
whole and the working directory; whether output is a terminal and colours;
column alignment; grouping. All were added as above, with primitives in
both backends where the operating system is needed (`src/sys.rs`,
`runtime/fwp_rt_sys.c`) and in fwp otherwise (`lib/fs.fwp`,
`lib/process.fwp`, `lib/cli.fwp`, `group-by`).

What remains awkward:

* Tacit code with several parameters needs `curry`, tuples and `.0 | .1`
  selectors, and a helper record is often clearer than a tuple
  (`examples/cli/grep.fwp`). This is the language's design (there are no
  local names), not something a CLI library can hide.
* An effectful step before applying a function argument makes the
  argument's effect row include that effect (`term.paint` takes
  `String -> String ! {IO | e}`).
* There are no exit statuses other than through `exit` for exported
  functions (`grep` cannot exit with 1 when nothing matched and still
  return its lines); only `main` returns its status.
* Flags have no value names beyond the type (`<I64>`), and there are no
  positional parameters with defaults or optional positionals, and no
  shell completion.
* `process.call` inherits the program's stdout even when the program
  writes the binary protocol (`FWP_OUT=bin`).
* There is no CSV reader: `split ","` handles simple files, not quoted
  fields.
