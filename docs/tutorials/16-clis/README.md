# 16. Command-line programs

[Tutorial 7](../07-executables-and-pipes/README.md) turned exported
functions into executables. This one makes them command-line programs
with flags, help, subcommands and exit statuses, without writing an
argument parser. [docs/cli.md](../../cli.md) has every rule.

## Flags are a record

A first parameter that is a record is the options record: each field is a
flag. A `Bool` field is a switch, an `Option` field is optional, a `List`
field may be repeated, and any other field is required unless it has a
default. The comment above a field describes the flag; when it starts
with `-u`, the flag also has the short form `-u`, `<N>` names its value
in the help, and `[env: WORDS_TIMES]` lets an environment variable give
the value when the flag is absent:

```fwp
Options = {
    # -u  in capitals
    upper: Bool,
    # -n <N>  how many copies of each word [env: WORDS_TIMES]
    times: I64,
    # what goes between the words
    sep: String,
}
```

Defaults are ordinary values. `defaults` applies to every command that
has those fields; `say.defaults` would apply to `say` alone:

```fwp
export defaults : {times: I64, sep: String}
defaults = { times = 1, sep = " " }
```

## Comments are the help

The comments right above an `export` describe the command, and its first
sentence is its summary. A line `# args:` names the positional
arguments; `WORDS...` makes the last one, a `List`, take all the
remaining arguments:

```fwp
# Repeat words.
#
# Each word is written `--times` times.
# args: WORDS...
export say : Options -> List[String] -> String
```

`fwp build --cli` builds every exported function into one program, with
the name given by `-o`, and `export version` gives it `--version`:

```
$ fwp build main.fwp --cli -o words
$ ./words say -n 2 -u hi there
HI HI THERE THERE
$ ./words say --sep=, a b c
a,b,c
$ WORDS_TIMES=2 ./words say a b
a a b b
$ ./words help say
usage: words say [options] [WORDS...]

Repeat words.

Each word is written `--times` times.

arguments:
  WORDS...  String, any number

options:
  -u, --upper         in capitals
  -n, --times <N>     how many copies of each word (default: 1; env: WORDS_TIMES)
      --sep <String>  what goes between the words (default: " ")
  -h, --help          show this help
      --version       show the version
$ ./words --version
words 0.3.0
```

Without a command, or with `--help`, it lists the commands:

```
$ ./words --help
usage: words <command> [arguments...]

16. Command-line programs

Exported functions are command-line programs: a first parameter that is
a record becomes flags, comments become the help, and
`fwp build --cli` puts every command in one executable.

commands:
  say         Repeat words.
  divide      Divide N by D.
  non-blank   Keep the lines that are not blank.
  shout       Say a word, normally unless VOLUME says otherwise.
  containing  The words that contain TEXT; the exit status is 1 when there are none.
  help        show the help of a command

options:
  -h, --help                 show this help
      --version              show the version
      --completions <SHELL>  print a completion script for bash, zsh or fish
      --man                  print a man page

Run `words help <command>` for the arguments of a command.
```

## Errors and exit statuses

A mistake on the command line is a usage error, with exit status 2. A
command that returns `Err` (or raises an uncaught `Error`) prints the
error on stderr and exits with 1:

```fwp
# Divide N by D.
# args: N D
export divide : I64 -> I64 -> Result[I64, String]
```

```
$ ./words say --times x
words say: option `--times`: cannot parse `x` as I64
usage: words say [options] [WORDS...]
$ echo $?
2
$ ./words divide 9 2
4
$ ./words divide 9 0
words divide: cannot divide by zero
$ echo $?
1
```

As in tutorial 7, the last argument may come from standard input, one
value per line, and `--fn` builds one function on its own. A function
that returns an `Option` is a filter: `None` writes nothing.

```fwp
# Keep the lines that are not blank.
export non-blank : String -> Option[String]
non-blank = if (trim | eq "") (const None) Some
```

```
$ printf 'one\n\n  \ntwo\n' | ./words non-blank
one
two
$ fwp build main.fwp --fn divide -o divide
$ printf '10\n20\n' | ./divide 100
10
5
```

## Choices, optional arguments and exit statuses

A type whose constructors have no fields is a set of choices: its values
are written as the constructor names in any case, in kebab-case or not,
and the help lists them. A last parameter of type `Option` (or one with
a default in `shout.defaults`) may be left out:

```fwp
# How loud `shout` is.
Volume =
    | Quiet
    | Normal
    | Loud

# Say a word, normally unless VOLUME says otherwise.
# args: WORD VOLUME
export shout : String -> Option[Volume] -> String
```

```
$ ./words shout hey
hey
$ ./words shout hey LOUD
HEY!
$ ./words shout hey shouting
words shout: argument 2: `shouting` is not one of quiet, normal, loud
$ ./words help shout
usage: words shout WORD [VOLUME]
...
arguments:
  WORD    String
  VOLUME  Volume, one of: quiet, normal, loud, optional
```

A command that returns an `Outcome` chooses its exit status:
`outcome.fail-if is-empty` makes it 1 when there is no output, as `grep`
does when nothing matches:

```fwp
# The words that contain TEXT; the exit status is 1 when there are none.
# args: TEXT WORDS...
export containing : String -> List[String] -> Outcome[List[String]]
containing =
    curry (fork filter (.0 | string.contains) .1)
    | then2 id (outcome.fail-if is-empty)
```

```
$ ./words containing pp apple fig
apple
$ ./words containing pp fig || echo none
none
```

## Completion and man pages

Every program writes completion scripts for its commands, flags and
choices (files for arguments named `FILE` or `DIR`), and a man page:

```
$ source <(./words --completions bash)     # or zsh; fish: | source
$ ./words sh<TAB>          # shout
$ ./words shout hey <TAB>  # quiet normal loud
$ ./words --man > words.1 && man ./words.1
```

`fwp exec main.fwp say -n 3 ho` runs a function with the interpreter, and
`fwp exec --cli main.fwp divide 1 0` runs the file as the `--cli` program
would; both behave exactly as the native programs.

## A hand-written `main`

The `cli` module parses arguments by the same rules for a program that
reads `args ()` itself: `cli.parse` takes a record of defaults and the
arguments, and returns the options and the positional arguments, or a
message for `cli.usage-error`. The module also has `table.lines` for
columns, `term.paint` and `ansi.*` for colours, `prompt.line`,
`prompt.confirm` and `prompt.password` for questions, `progress.show`
for a status line on a terminal, and the library has `csv` for CSV files
and the `path`, `file`, `dir` and `process` functions that command-line
programs need.

## The program

[`main.fwp`](main.fwp):

```fwp
# 16. Command-line programs
#
# Exported functions are command-line programs: a first parameter that is
# a record becomes flags, comments become the help, and
# `fwp build --cli` puts every command in one executable.

export version : String
version = "0.3.0"

Options = {
    # -u  in capitals
    upper: Bool,
    # -n <N>  how many copies of each word [env: WORDS_TIMES]
    times: I64,
    # what goes between the words
    sep: String,
}

# Defaults for the flags of every command.
export defaults : {times: I64, sep: String}
defaults = { times = 1, sep = " " }

# The words, each `times` times, between copies of `sep`.
repeated : Options -> List[String] -> String
repeated = curry (both
        (.0 | .sep)
        (fork list.flat-map (.0 | .times | repeat) .1)
    | uncurry join)

# Repeat words.
#
# Each word is written `--times` times.
# args: WORDS...
export say : Options -> List[String] -> String
say = curry (both (.0 | .upper) (uncurry repeated) | if .0 (.1 | upper) .1)

# Divide N by D.
# args: N D
export divide : I64 -> I64 -> Result[I64, String]
divide = curry (match
    (_, 0) -> const (Err "cannot divide by zero")
    (_, _) -> curry (swap | uncurry div | Ok))

# Keep the lines that are not blank.
export non-blank : String -> Option[String]
non-blank = if (trim | eq "") (const None) Some

# How loud `shout` is.
Volume =
    | Quiet
    | Normal
    | Loud

# Say a word, normally unless VOLUME says otherwise.
# args: WORD VOLUME
export shout : String -> Option[Volume] -> String
shout = curry (match
    (_, Some Quiet) -> lower
    (_, Some Loud) -> upper | concat "!"
    (_, Some Normal) -> id
    (_, None) -> id)

# The words that contain TEXT; the exit status is 1 when there are none.
# args: TEXT WORDS...
export containing : String -> List[String] -> Outcome[List[String]]
containing =
    curry (fork filter (.0 | string.contains) .1)
    | then2 id (outcome.fail-if is-empty)

main = [
    ["hi", "there"]
    | say Options { upper = False, times = 2, sep = "-" }
    | print,
    divide 9 2 | echo,
    divide 9 0 | echo,
    ["a", " ", "b"] | filter-map non-blank | echo,
    shout "hey" (Some Loud) | print,
    ["apple", "fig"] | containing "pp" | echo,
    ["fig"] | containing "pp" | .status | echo,
    ["-u", "--times=2", "hi", "--", "-x"]
    | cli.parse Options { upper = False, times = 1, sep = " " }
    | echo,
    ["--times", "many"]
    | cli.parse Options { upper = False, times = 1, sep = " " }
    | echo,
    [["command", "arguments"], ["say", "WORDS..."], ["divide", "N D"]]
    | table.lines
    | each print,
    "docs/cli.md" | both path.dirname path.extension | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/16-clis/main.fwp`, or compile it with
`fwp build docs/tutorials/16-clis/main.fwp -o clis`. The output is
[`main.out`](main.out):

```
hi-hi-there-there
Ok 4
Err "cannot divide by zero"
["a", "b"]
HEY!
Outcome {output = ["apple"], status = 0}
1
Ok (Options {sep = " ", times = 2, upper = True}, ["hi", "-x"])
Err "option `--times`: cannot parse `many` as I64"
command  arguments
say      WORDS...
divide   N D
("docs", "md")
```

`main` calls the commands as ordinary functions, which is how the output
is checked; the shell sessions above show them as programs.

---

Previous: [fwp in the browser](../15-browser/README.md) · Next: [REST APIs and OpenAPI](../17-rest-and-openapi/README.md) · [All tutorials](../README.md)
