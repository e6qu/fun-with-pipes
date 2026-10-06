# 14. Services

A program in fwp can be deployed two ways without changing its source:

- as **one executable**, where a module's exported functions are ordinary
  function calls;
- as **separate executables** that talk gRPC: each module you name becomes
  a server of its exported functions, and every call to them from other
  modules becomes a remote call.

The module is the unit of deployment and its `export`ed functions are its
interface: all of them are served, with no `# expose:` line (that line is
for the interfaces that clients outside the program use: command lines,
REST and MCP). gRPC is only the transport between the parts of a split
program. This tutorial builds the same program both ways; the
details are in [Services](../../services.md).

To follow along, go to this directory (`cd docs/tutorials/14-services`).
The sessions below run exactly as shown: the test suite runs them.

## A service interface

A function can be served when it is

- exported, with a monomorphic type (no type variables);
- a function, not a constant (constants are computed locally);
- made of types that can be encoded: numbers, `Bool`, `String`, `Bytes`,
  records, tuples, variants, lists, arrays, maps, sets and options. Not
  functions, files or sockets.

An `Error[E]` effect is part of the interface: the error value travels
back to the caller, where `attempt` catches it as usual. In
[`library.fwp`](library.fwp):

```fwp
export book : String -> Option[Book]
book = eq | compose .isbn | find | apply shelf
```

```fwp
export borrow : String -> Loan ! {Error[NotAvailable]}
borrow = fork or-fail unknown book | lend
```

`shelf`, `unknown` and `lend` are not exported. They are implementation
details, compiled into whichever executable needs them.

## One executable

[`main.fwp`](main.fwp) imports the module and calls it:

```fwp
import library

main = [
    "978-0" | library.book | echo,
    "978-9" | library.book | echo,
    "978-0" | attempt library.borrow | echo,
    "978-1" | attempt library.borrow | echo,
    "978-9" | attempt library.borrow | echo,
] | ignore
```

Built normally, this is one executable, and `library.borrow` is a function
call:

```console
$ fwp build main.fwp -o shop
$ ./shop
Some (library.Book {copies = 2, isbn = "978-0", title = "Pipes"})
None
Ok (library.Loan {isbn = "978-0", left = 1})
Err (library.NotAvailable {isbn = "978-1", reason = "all copies are out"})
Err (library.NotAvailable {isbn = "978-9", reason = "no such book"})
```

## Split into services

With `--service library`, the same source becomes two executables in the
directory `-o` names: a gRPC server of the module, and the main program,
whose calls to the module are remote. `FWP_SERVICE_LIBRARY` (or the
`--service library=host:port` of the build) tells it where the service is:

```console
$ fwp build main.fwp --service library -o out
$ ls out
library
main
$ ./out/library --listen 127.0.0.1:7014 &
fwp: service library listening on 127.0.0.1:7014
$ FWP_SERVICE_LIBRARY=127.0.0.1:7014 ./out/main
Some (library.Book {copies = 2, isbn = "978-0", title = "Pipes"})
None
Ok (library.Loan {isbn = "978-0", left = 1})
Err (library.NotAvailable {isbn = "978-1", reason = "all copies are out"})
Err (library.NotAvailable {isbn = "978-9", reason = "no such book"})
```

The output is the same as the single executable's. The interpreter does
the same: `fwp serve main.fwp library` serves the module, and
`fwp run --service library main.fwp` runs `main` against it. Native and
interpreted servers and clients mix freely.

## The wire format

The parts talk gRPC over HTTP/2, with protobuf messages derived from the
types, and check a fingerprint of the types on every call, so that parts
built from different sources refuse to talk. `fwp proto main.fwp --service
library` prints the messages, to look at what goes over the wire:

```console
$ fwp proto main.fwp --service library | grep -A3 '^service'
service Library {
  rpc Book(BookRequest) returns (BookResponse);
  rpc Borrow(BorrowRequest) returns (BorrowResponse);
}
```

Record fields are numbered in declaration order; the arguments of a
function are the fields `arg1`, `arg2`, ... of its request.

## What changes

Results and errors do not change, but some things do:

- **Latency and failure.** A remote call takes a network round trip. If
  the service cannot be reached, the call traps with a message naming the
  service and its address.
- **Effects.** A served function runs in the service's process: its
  `print` output appears there, not in the caller's.
- **Traps.** A trap in the service (an overflow, say) is reported to the
  caller, which traps with the same message; the service keeps running.

The shop in [`examples/services`](../../../examples/services/main.fwp)
splits into two services, one of which calls the other.

## The module

[`library.fwp`](library.fwp):

```fwp
# A lending library: the interface of a service.

Book = { isbn: String, title: String, copies: I64 }

Loan = { isbn: String, left: I64 }

NotAvailable = { isbn: String, reason: String }

shelf : List[Book]
shelf = [
    Book { isbn = "978-0", title = "Pipes", copies = 2 },
    Book { isbn = "978-1", title = "Types", copies = 0 },
]

export book : String -> Option[Book]
book = eq | compose .isbn | find | apply shelf

unknown : String -> NotAvailable
unknown = make NotAvailable { isbn = id, reason = const "no such book" }

lend : Book -> Loan ! {Error[NotAvailable]}
lend =
    if
        (.copies | gt 0)
        (make Loan { isbn = .isbn, left = .copies | sub 1 })
        (make NotAvailable { isbn = .isbn, reason = const "all copies are out" }
            | fail)

export borrow : String -> Loan ! {Error[NotAvailable]}
borrow = fork or-fail unknown book | lend
```

`fwp run main.fwp` prints [`main.out`](main.out):

```
Some (library.Book {copies = 2, isbn = "978-0", title = "Pipes"})
None
Ok (library.Loan {isbn = "978-0", left = 1})
Err (library.NotAvailable {isbn = "978-1", reason = "all copies are out"})
Err (library.NotAvailable {isbn = "978-9", reason = "no such book"})
```

---

Previous: [Tooling](../13-tooling/README.md) · Next: [fwp in the browser](../15-browser/README.md) · [All tutorials](../README.md)
