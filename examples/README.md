# Example applications

These programs apply the concepts taught in the [tutorials](../docs/tutorials/README.md).
Read lessons 1–5 first. `main` is a program entry; an `export` exposes a definition
to other modules or an explicitly selected interface. `--fn name` builds one
exported function; `--cli` builds the functions marked `# expose: cli` as commands.
The examples' comments give further invocations.

Run root-relative paths below from the repository root. Enter a directory when
instructed for examples that import neighboring files. The compiler needs a C
toolchain for native builds; network examples need OpenSSL 3. Commands below use
a POSIX shell. `fwp run --interp` explicitly selects the interpreter; ordinary
`fwp run` compiles and caches native code.

## Small programs

| File | What to learn | First run |
|---|---|---|
| [hello.fwp](hello.fwp) | A pipe sends a string to `print`, which adds a newline | `fwp run examples/hello.fwp` prints `hello, world` |
| [vector-lanes.fwp](vector-lanes.fwp) | Fixed-size lanes, explicit types and checked array lengths | `fwp run examples/vector-lanes.fwp` doubles four numbers and rejects a three-element input |
| [wordfreq.fwp](wordfreq.fwp) | Read text, normalize words, count occurrences, sort counts descending | `printf 'Pear pear apple\n' \| fwp run examples/wordfreq.fwp` prints `pear: 2`, then `apple: 1` |
| [shell/tools.fwp](shell/tools.fwp) | Exported functions as process filters; lesson 7 | `fwp build examples/shell/tools.fwp --fn normalize -o normalize`, then `printf ' HELLO \n' \| ./normalize` prints `hello` |

In `wordfreq`, `map` transforms each list element; `map.to-list` converts a key/value
map to pairs. They are different operations despite the shared word. `.1` selects
a pair's count, and `neg` makes the ascending sort put larger counts first.
The word (`.0`) breaks equal-count ties alphabetically. `words` splits on spaces,
tabs, line feeds and carriage returns; other characters remain in a word.
Normalization here lowercases ASCII and removes commas/full stops; it is not a
complete natural-language tokenizer.

## Terminal applications

Lesson 16 explains flags, positional arguments, defaults, help and process exit
statuses. A leading options record becomes flags. `Option` represents a missing
value, and `Outcome` combines printable data with an exit status. Use the built
program's `--help` to inspect its generated interface.

| File | Purpose and inputs | Build |
|---|---|---|
| [cli/wc.fwp](cli/wc.fwp) | Count lines, words and bytes in files or standard input | `fwp build examples/cli/wc.fwp --fn wc -o wc` |
| [cli/grep.fwp](cli/grep.fwp) | Select lines containing a literal substring; this is not a regular-expression engine | `fwp build examples/cli/grep.fwp --fn grep -o grep` |
| [cli/dirstat.fwp](cli/dirstat.fwp) | Group files by extension, total counts/bytes and sort the groups | `fwp build examples/cli/dirstat.fwp --fn dirstat -o dirstat` |
| [cli/csvtool.fwp](cli/csvtool.fwp) | Read CSV (rows of separated fields), show columns or select fields | `fwp build examples/cli/csvtool.fwp --cli -o csvtool` |
| [cli/todo.fwp](cli/todo.fwp) | Add, list and finish items stored in a local text file | `fwp build examples/cli/todo.fwp --cli -o todo` |

For example, `printf 'apple\nBanana\n' | ./grep -i an` prints `Banana`:
`-i` ignores ASCII case and `an` is the substring. `./todo add buy milk` writes
the to-do file; `./todo list` reads it. `TODO_FILE` selects another path as declared
in the source metadata. CSV examples assume you supply the named input files;
`people.csv` is an illustrative filename, not an included fixture.

## HTTP applications

HTTP exchanges requests and responses; a handler maps a request to a response.
JSON encodes structured bodies. A route selects a handler by method/path.
Read lessons 6 and 8 before the hand-written servers, lesson 17 for generated
REST interfaces, and lesson 19 for WebSocket (messages in both directions over
one connection). A URL names the server, port and path. `curl` is a terminal HTTP
client; `-F` submits form fields/files and `-H` supplies a header.

| File | What it demonstrates | How to start |
|---|---|---|
| [server/api.fwp](server/api.fwp) | Hand-written routes, JSON, authentication and errors | `fwp run examples/server/api.fwp`; request `http://127.0.0.1:8080/health` |
| [server/chat.fwp](server/chat.fwp) | A hub task forwards WebSocket messages through channels | `fwp run examples/server/chat.fwp`; open `http://127.0.0.1:8080/` in two browser tabs |
| [rest/uploads.fwp](rest/uploads.fwp) | Multipart form uploads and JSON/text/CSV responses | `fwp serve --rest examples/rest/uploads.fwp`; use the source's curl commands |
| [rest/books.fwp](rest/books.fwp) | One bookstore interface exposed as REST, CLI and MCP | `fwp serve --rest examples/rest/books.fwp`; see its comments for other builds |

The servers keep running until stopped. Use Ctrl-C in the server terminal after
the experiment. `FWP_ADDR` changes the hand-written servers' listening address;
`--listen` selects it for generated REST servers. The bookstore's bearer token is
an application-defined credential, checked by `authenticate`. The examples show
that mapping; they do not install an account system.

The bookstore catalog and quotes are example values, not a persistent inventory
database. A returned reservation/quote does not establish durable stock changes.
MCP clients must support the repository's documented protocol version; see the
[MCP guide](../docs/mcp.md).

## Clients and split services

A remote procedure call sends encoded arguments to another process and decodes
its reply. It introduces transport cost and possible connection failure even
when the function-call source looks unchanged. OpenAPI describes a REST API;
`fwp openapi --import` generates a client from the supported document subset.
gRPC carries calls between modules split by `--service`.

| Files | Role and run sequence |
|---|---|
| [rest/bookclient.fwp](rest/bookclient.fwp), [rest/client.fwp](rest/client.fwp) | The first is generated client code; the second uses it. In `examples/rest`, start `fwp serve --rest books.fwp` in one terminal, then `fwp run client.fwp` in another. Source comments show regeneration. |
| [rest/shop.fwp](rest/shop.fwp) | Calls the bookstore locally or as a gRPC service. In `examples/rest`, run `fwp run shop.fwp` locally, or follow its build/server commands for the split version. |
| [services/main.fwp](services/main.fwp) | Coordinates inventory and pricing. In `examples/services`, `fwp run main.fwp` keeps calls local. Its build command splits both modules. |
| [services/inventory.fwp](services/inventory.fwp) | A fixed catalog and stock-checking operations used by `main`; no standalone `main` entry. SKU means stock-keeping unit, the product identifier. |
| [services/pricing.fwp](services/pricing.fwp) | Integer-cent prices, discounts and quotes; calls inventory when checking an order. No standalone `main` entry. |

For the split shop, use [tutorial 14](../docs/tutorials/14-services/README.md) and
[service addresses](../docs/services.md#addresses) to start the servers and give
clients the correct addresses. Each server is a separate process that must be
running when its calls arrive. Splitting is a deployment demonstration, not a
claim that several processes are faster than one.

## What is checked

`tests/examples.rs` type-checks these application files. The tutorials also have
executed transcripts and expected outputs, while feature suites test generated
interfaces and transports. Type checking an example does not test its external
files, credentials, browser, installed device or deployment. No timing in this
guide is a performance measurement; use [benchmarks](../docs/benchmarks.md) for
baselines, overhead and limitations.
