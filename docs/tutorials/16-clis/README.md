# 16. Command-line programs

This tutorial builds a real command-line program from ordinary
functions: flags, help, subcommands, exit statuses, shell completion and
a man page, with no argument parser to write. You build it with `fwp build
--cli` and run it from your shell. [docs/cli.md](../../cli.md) has every
rule.

To follow along, go to this directory (`cd docs/tutorials/16-clis`).
Every session below runs exactly as shown: the test suite runs them.

## Exposing functions as commands

An exported function is not a command until you say so. The line
`# expose: cli` in the file's leading comment exposes every exported
function of [`words.fwp`](words.fwp) as a command. A line above one
`export` would expose only that function:

```fwp
# Play with words: repeat them, shout them, find them, and divide
# numbers.
#
# expose: cli
```

`fwp build --cli` builds every exposed function into one program, named
by `-o`. Its first argument picks the command:

```console
$ fwp build words.fwp --cli -o words
$ ./words say hello world
hello world
```

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

```console
$ ./words say -n 2 -u hi there
HI HI THERE THERE
$ ./words say --sep=, a b c
a,b,c
$ WORDS_TIMES=2 ./words say a b
a a b b
```

## The help is generated

`help say` (or `say --help`) shows the help of a command, from its
comments and types, and `export version` gives the program `--version`:

```console
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

```console
$ ./words --help
usage: words <command> [arguments...]

Play with words: repeat them, shout them, find them, and divide
numbers.

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

```console
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

## Standard input

The last argument may come from standard input, one value per line. A
function that returns an `Option` is a filter: `None` writes nothing.

```fwp
# Keep the lines that are not blank.
export non-blank : String -> Option[String]
non-blank = if (trim | eq "") (const None) Some
```

```console
$ printf 'one\n\n  \ntwo\n' | ./words non-blank
one
two
```

`--fn` builds one exported function on its own, as a program of its
own (it needs no `# expose:` line: naming the function exposes it):

```console
$ fwp build words.fwp --fn divide -o divide
$ printf '10\n20\n' | ./divide 100
10
5
```

## Choices and optional arguments

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

```console
$ ./words shout hey
hey
$ ./words shout hey LOUD
HEY!
$ ./words shout hey shouting
words shout: argument 2: `shouting` is not one of quiet, normal, loud
$ ./words help shout
usage: words shout WORD [VOLUME]

Say a word, normally unless VOLUME says otherwise.

arguments:
  WORD    String
  VOLUME  Volume, one of: quiet, normal, loud, optional

options:
  -h, --help     show this help
      --version  show the version
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

```console
$ ./words containing pp apple fig
apple
$ ./words containing pp fig || echo none
none
```

## Completion and man pages

Every program writes completion scripts for its commands, flags and
choices (files for arguments named `FILE` or `DIR`), and a man page:

```console
$ ./words --completions bash > words.bash
$ ./words --man > words.1
$ ls words.1 words.bash
words.1
words.bash
```

In an interactive shell, `source words.bash` (or `source <(./words
--completions bash)`) loads it: `./words sh` TAB completes to `shout`, and
TAB after `./words shout hey` offers `quiet normal loud`. `--completions
zsh` and `fish` work the same way; `man ./words.1` shows the man page.

## Without building

`fwp exec --cli` runs the file as the `--cli` program would, compiled and
cached, and `fwp exec` runs one exported function:

```console
$ fwp exec --cli words.fwp divide 10 4
2
$ fwp exec words.fwp say -n 3 ho
ho ho ho
```

## A hand-written `main`

A program can also read its arguments itself. The `cli` module parses
them by the same rules: `cli.parse` takes a record of defaults and the
arguments, and returns the options and the positional arguments, or a
message for `cli.usage-error`. [`greet.fwp`](greet.fwp):

```fwp
# Greet people, parsing the command line by hand.

Flags = {
    # -l  shout the greeting
    loud: Bool,
}

greeting : Flags -> List[String] -> String
greeting = curry (both (.0 | .loud) (.1 | join " " | flip concat "hello, ")
    | if .0 (.1 | upper) .1)

main = () | args | cli.parse Flags { loud = False } | match
    Ok _ -> uncurry greeting | print
    Err _ -> cli.usage-error "usage: greet [-l] NAME..."
```

```console
$ fwp build greet.fwp -o greet
$ ./greet -l ada lovelace
HELLO, ADA LOVELACE
$ ./greet --quiet ada
unknown option `--quiet`
usage: greet [-l] NAME...
```

The `cli` module also has `table.lines` for columns, `term.paint` and
`ansi.*` for colours, `prompt.line`, `prompt.confirm` and
`prompt.password` for questions, and `progress.show` for a status line on
a terminal; the library has `csv` for CSV files and the `path`, `file`,
`dir` and `process` functions that command-line programs need.

## The program

[`words.fwp`](words.fwp):

```fwp
# Play with words: repeat them, shout them, find them, and divide
# numbers.
#
# expose: cli

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
```

---

Previous: [fwp in the browser](../15-browser/README.md) · Next: [REST APIs and OpenAPI](../17-rest-and-openapi/README.md) · [All tutorials](../README.md)
