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
`examples/cli/` has five complete programs: `wc.fwp`, `grep.fwp`,
`todo.fwp`, `dirstat.fwp` and `csvtool.fwp`.

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

A command with optional arguments (below) never reads its last argument
from standard input.

### Optional arguments

The last positional parameters may be left out when they are `Option[T]`
or have a default:

```fwp
# A format, or none.
# args: NAME FORMAT
export pick : String -> Option[Format] -> String

export render.defaults : { dir: String }
render.defaults = { dir = "." }

# args: WORD DIR
export render : Options -> String -> String -> String
```

* An `Option[T]` argument is written as a `T` (`pick x json`) and is
  `None` when it is absent.
* A default comes from a field of `f.defaults` named like the argument in
  lower case (`dir` for `DIR`), of the parameter's type. The program's
  `defaults` are for flags only.
* Optional parameters must come after the required ones: a default for a
  parameter followed by a required one is an error. (An `Option`
  parameter followed by a required one is required, written in the text
  format as `None` or `Some 3`.)
* The arguments fill the required parameters, then the optional ones in
  order; a variadic last parameter (`FILE...`) takes the rest, or its
  default when there is none.
* The usage shows them in brackets: `usage: features render [options]
  WORD [DIR]`.

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
* `<NAME>` after the short flag (or at the start of the comment) names
  the value in the help: `-n, --count <N>` instead of `<I64>`.
* Annotations in brackets, anywhere in the comment, are taken out of the
  description:

  | Annotation | Meaning |
  |---|---|
  | `[env: VAR]` | the environment variable `VAR` gives the value when the flag is absent |
  | `[requires: a, b]` | the flag may only be given with `--a` and `--b` |
  | `[conflicts: a]` | the flag may not be given with `--a` |

  ```fwp
  Options = {
      # -f <FORMAT>  how to write the result [env: FEATURES_FORMAT]
      format: Format,
      # -o <FILE>  where to write [conflicts: quiet]
      output: Option[String],
      # -a  add to the end of the file [requires: output]
      append: Bool,
  }
  ```

  The comment may also be written after the field, on its line
  (`unique: Bool, # -u  count each word once`).
* Flags and positional arguments may be mixed; a flag given twice keeps
  the last value (a list collects them).
* Values are parsed by the field's type, like positional arguments.
* A value comes from the command line, else from the flag's environment
  variable, else from its default: flag > environment > default. An
  empty variable counts as unset, a switch's variable may also be `1` or
  `0`, and a repeatable flag's variable is one value. A variable that
  does not parse is a usage error that names it
  (``environment variable `FEATURES_COUNT`: cannot parse `many` as I64``).
* `[requires: ...]` and `[conflicts: ...]` count the flags given on the
  command line or by their environment variable, not defaults:
  ``option `--output` cannot be used with `--quiet` ``, ``option `--append`
  needs `--output` ``.
* Unknown flags, missing values and values that do not parse are usage
  errors (exit status 2), reported with the usage line:

```
$ ./grep --colour x
grep: unknown option `--colour`
usage: grep [options] PATTERN [FILE...]
```

### Choices

A type whose constructors all have no fields is an enumeration:

```fwp
Format =
    | Plain
    | Json
    | CsvLines
```

A flag or argument of such a type (or `Option`, `List` of it) takes the
constructor names in any case, with or without `-` or `_`: `json`,
`JSON`, `csv-lines`, `CsvLines` and `csv_lines` all work. The help lists
the values in kebab-case (`one of: plain, json, csv-lines`), defaults
are shown the same way, completion scripts offer them, and another value
is a usage error: ``option `--format`: `xml` is not one of plain, json,
csv-lines``. `Bool` is not a choice: it stays a switch.

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
* `f.defaults` may also give defaults to positional arguments, which
  makes them optional (see above).

Neither value is a command, and both are computed when the program starts
(they are pure values).

## Help, usage and version

`--help` and `-h` print the help on standard output and exit with status
0 (unless the options record has a field `help` or a short flag `-h`):

```
$ ./grep --help
usage: grep [options] PATTERN [FILE...]

Print the lines of the FILEs (or of standard input) that contain
PATTERN. The exit status is 1 when no line is selected.

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
  `export` (without the `# args:`, `# command:` and `# fwp:allow` lines),
  or, for a bare `export name`, above the signature or the binding of
  `name` (so a `rec name : T` signature can carry it). Its first sentence
  is the command's summary in a multi-command help.
* Comments are found through the syntax tree: signatures may span
  several lines, and the options record may be declared anywhere in the
  file or in an imported module.
* Each flag shows its value name (`<N>`, or its type), its comment, and
  notes: the choices, `required`, `repeatable`, `default: ...`,
  `requires --x`, `not with --y` and `env: VAR`.
* Positional arguments show their names (or `<Type>`), their types, the
  choices, whether they are optional (or their default) and whether they
  may come from standard input.

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
tools --completions SHELL         a completion script (bash, zsh, fish)
tools --man                       a man page
tools                             the commands, on stderr, exit status 2
```

The program's description is the comment block at the top of the file,
when a blank line separates it from the first declaration. The name of
the program is the name of the executable given with `-o` (or the file
name), and messages of a command start with `tools command:`.
`version`, `defaults` and `*.defaults` are not commands.

## Shell completion and man pages

`--completions bash`, `--completions zsh` or `--completions fish` as the
first argument prints a completion script, and `--man` a man page in
roff, generated from the same commands, flags and comments as the help.
They work the same way in multi-command programs and in single-command
executables (where they are not listed in the help, and a flag of the
same name takes precedence), with the interpreter and in both native and
WebAssembly builds:

```
$ source <(todo --completions bash)          # bash, for this shell
$ todo --completions bash > ~/.local/share/bash-completion/completions/todo
$ todo --completions zsh > ~/.zfunc/_todo    # a directory of $fpath
$ todo --completions fish > ~/.config/fish/completions/todo.fish
$ todo --man > todo.1 && man ./todo.1
```

The scripts complete:

* the commands of a multi-command program (and `help <command>`);
* the long and short flags of each command, and `--help`/`--version`;
* the values of flags and arguments whose type is an enumeration;
* file names for `String` values named `FILE`, `PATH` or ending in
  `-file`/`_path` (and for flags named `file`, `path`...), directory
  names for `DIR` or `DIRECTORY`; nothing for other values.

The man page has the sections NAME, SYNOPSIS, DESCRIPTION, COMMANDS (or
OPTIONS), ENVIRONMENT (the variables of `[env: ...]`) and EXIT STATUS.
A bash script is checked with `bash -n` and by completing command lines
in `tests/cli.rs`; zsh and fish scripts are checked when those shells are
installed. A completion script is named after the program, so a program
that is renamed after it is built needs its script generated again.

## Results, errors and exit statuses

| The function... | The program |
|---|---|
| returns a value | writes it as text (strings without quotes), then a newline |
| returns a `List[T]` | writes one line per element |
| returns `Option[T]` | writes the value, or nothing for `None` (a per-line function returning `Option` is a filter) |
| returns `()` | writes nothing |
| returns `Result[T, E]` | writes `T` as above, or for `Err e` writes `name: e` on stderr and exits with 1 |
| returns `Outcome[T]` | writes its `output` as a `T` would be written, then exits with its `status` (modulo 256) |
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
that chooses its status returns an `Outcome` (`lib/cli.fwp`):

```fwp
Outcome[T] = { output: T, status: I32 }

# The words that contain PATTERN; the exit status is 1 when there are
# none.
# args: PATTERN WORDS...
export search : String -> List[String] -> Outcome[List[String]]
search = curry (fork filter (.0 | string.contains) .1)
    | then2 id (outcome.fail-if is-empty)
```

* `outcome.of f` computes the status from the output, `outcome.exit n`
  gives a fixed one and `outcome.fail-if p` is 1 when `p` holds;
  `make Outcome { output = ..., status = ... }` builds one from anything.
* The output may be a `Result`, an `Option` or a `List` as above: an
  `Err` is still reported with status 1.
* A command that runs once per line of standard input exits with the
  highest status of its calls.
* `exit` still works, for a status before the end.

With `FWP_OUT=bin`, results are written in the binary protocol and the
program's own `print` output goes to stderr ([protocol.md](protocol.md)),
as does the output of the programs it runs with `process.call`.

## A hand-written `main`

Programs that parse their own arguments use the same rules through the
`cli` module of the standard library ([stdlib.md](stdlib.md)).
`cli.parse defaults arguments` is `Ok (options, positional)` or
`Err message`; a field whose flag is absent keeps its value in
`defaults`, and `--help` is a flag like any other, so a program that
wants it has a `help: Bool` field. Choices, value names and
`[requires: ...]`/`[conflicts: ...]` work as for executables;
environment variables do not (`cli.parse` is pure). `cli.help defaults` is the help lines
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
| environment (`IO`) | `args`, `env.get`, `env.vars`, `env.cwd`, `env.home`, `exit`, `eprint`, `ewrite` (stderr without a newline) |
| standard input (`IO`) | `read-line`, `read-lines`, `read-all`, `each-line` and `fold-lines` (line by line, in constant memory) |
| terminal (`IO`) | `term.is-tty`, `term.width` (`COLUMNS` or the terminal's), `term.color` (a terminal and no `NO_COLOR`), `term.paint`, `ansi.bold`, `ansi.red`... |
| prompts (`IO`) | `prompt.line`, `prompt.confirm` (`[y/N]`), `prompt.password` (`term.read-secret`: no echo on a terminal; WebAssembly cannot turn the echo off) |
| progress (`IO`) | `progress.show` (a status line on stderr, only on a terminal), `progress.clear`, `progress.bar` (`[####    ]  50%`) |
| exit statuses | `Outcome`, `outcome.of`, `outcome.exit`, `outcome.fail-if` |
| CSV | `csv.parse`, `csv.parse-with` (another separator), `csv.decode` and `csv.parse-records` (typed records by header name), `csv.encode`, `csv.encode-with`, `csv.format-row`, `csv.field` |
| text | `table.lines`, `table.format` (aligned columns), `table.widths`, `pad-left`, `pad-right`, `group-by` |

A command is a list, the program and its arguments, and runs without a
shell: `["git", "log", "-1"] | process.run`. `Process` is an effect of its
own; WebAssembly targets have no processes and reject programs that use
it at compile time, as they reject `Network` and `Async`.

CSV records become typed values by the names of their columns:

```fwp
Item = { name: String, qty: I64, price: Option[F64], kind: Kind }

items : String -> Result[List[Item], String]
items = csv.parse-records
```

A header `First Name` or `first_name` is the field `first-name`; cells
are parsed as command-line values (so `kind` may be `fruit` or `FRUIT`),
an `Option` field is `None` for an empty cell or a missing column, and
an error names the row and the column
(``row 2: column `qty`: cannot parse `many` as I64``).

Internal helpers of the standard library have a name part that starts
with `_` (`table._row`) and are left out of [stdlib.md](stdlib.md).

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

A second round, to make the programs complete as programs made with
clap, cobra or click are, added:

* **Choices.** Enumerations as flag and argument values, in any case,
  listed in the help and completed by the shells.
* **Environment variables.** `[env: VAR]` on a field, with flag >
  environment > default.
* **Value names.** `<N>` in a field comment, instead of the type.
* **Optional arguments.** Trailing `Option` parameters and positional
  defaults in `f.defaults`.
* **Exit statuses.** `Outcome[T]`: `grep` now exits with 1 when nothing
  matches and still returns its lines.
* **Constraints.** `[requires: ...]` and `[conflicts: ...]` between flags.
* **Shell completion and man pages.** `--completions bash|zsh|fish` and
  `--man` in every program, in both backends and in WebAssembly.
* **Doc comments from the syntax tree.** Comments were found by matching
  lines (`export name` and `Name = {`), which missed signatures on several
  lines, documentation on a `rec` signature and records declared in other
  modules or with another layout. They now come from the parser's
  declarations and the lexer's comments.
* **The binary protocol and `process.call`.** A called program wrote on
  the stdout of a program writing the binary protocol, corrupting it; it
  now writes on stderr, as the program's own output does.
* **Library.** CSV (with typed records by header), `term.width`, prompts
  (with the echo off for passwords), progress lines, streaming standard
  input (`each-line`, `fold-lines`), `ewrite`; standard library helpers
  are hidden from the generated documentation.

What remains:

* Tacit code with several parameters needs `curry`, tuples and `.0 | .1`
  selectors, and a helper record is often clearer than a tuple
  (`examples/cli/grep.fwp`). This is the language's design (there are no
  local names), not something a CLI library can hide.
* An effectful step before applying a function argument makes the
  argument's effect row include that effect (`term.paint` takes
  `String -> String ! {IO | e}`): effect rows are unified, and a pure
  function does not become an effectful one by subsumption.
* No configuration files: values come from flags, the environment and
  defaults only.
* Environment variables apply to flags, not to positional arguments,
  and `cli.parse` does not read them.
* Subcommands are one level deep (`tool command`, not `tool group
  command`).
* Completion scripts are static: they cannot complete values that depend
  on the program's state (the items of `todo`), and a short flag bundled
  with its value (`-n5`) or with other switches is not taken apart when
  counting arguments.
* A completion script and the man page carry the name the program was
  built with (`-o`); a renamed executable needs them generated again.
