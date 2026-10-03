# 18. gRPC

[Tutorial 17](../17-rest-and-openapi/README.md) served exported functions
as REST endpoints. The same functions are gRPC methods: `fwp serve
--grpc` serves them over HTTP/2 with messages derived from their types,
reflection and health checking, and `fwp proto --grpc` prints their
`.proto` file. Their types also say which calls stream. In the other
direction, `fwp proto --import` turns any `.proto` file into typed fwp
clients and server routes. [docs/grpc.md](../../grpc.md) has every rule.

## Functions are methods

The program keeps notes. Its types are ordinary records:

```fwp
Note = { id: I64, text: String, tags: List[String] }
```

```fwp
Query = { tag: String, limit: I64 }
```

Each exported function is a method. The file would be the service
`fwp.Main`; a line `# grpc:` in its leading comment names the package and
the service instead:

```fwp
# grpc: notes.Notes
```

A function that fails with `Error[GrpcError]` answers with a gRPC status,
here `NOT_FOUND`; `grpc.fail` and the codes in `lib/grpc.fwp` build one:

```fwp
# A note by its id.
export note : I64 -> Note ! {Error[GrpcError]}
note =
    fork
        or-fail
        (make GrpcError {
            code = const grpc.not-found,
            message = show | flip concat "no note ",
        })
        (eq | compose .id | find | apply notes)
```

```
$ fwp serve --grpc main.fwp
fwp: service main listening on 127.0.0.1:50051
$ grpcurl -plaintext 127.0.0.1:50051 list
grpc.health.v1.Health
notes.Notes
$ grpcurl -plaintext -d '{"arg1": 2}' 127.0.0.1:50051 notes.Notes/Note
{
  "id": "2",
  "text": "types are contracts",
  "tags": [
    "fwp"
  ]
}
$ grpcurl -plaintext -d '{"arg1": 9}' 127.0.0.1:50051 notes.Notes/Note
ERROR:
  Code: NotFound
  Message: no note 9
```

grpcurl needs no `.proto` file: the server answers reflection requests.
`fwp build main.fwp --grpc -o notes` builds the same server as a native
executable (`./notes --listen 127.0.0.1:50051`).

## Messages from types

`fwp proto --grpc main.fwp` prints the contract. A record parameter or
result is its own message; other parameters are the fields `arg1`,
`arg2`, ... of a request message, and other results the field `value` of
a response:

```
service Notes {
  rpc Note(NoteRequest) returns (Note);
  rpc Search(Query) returns (stream Note);
  rpc Remind(RemindRequest) returns (stream RemindResponse);
  rpc CountWords(stream CountWordsRequest) returns (CountWordsResponse);
  rpc Whoami(WhoamiRequest) returns (WhoamiResponse);
}

message Note {
  sint64 id = 1;
  string text = 2;
  repeated string tags = 3;
}
```

## The type decides the stream

A function returning an `Iterator` streams its elements, computed as they
are sent:

```fwp
# The notes with a tag, at most `limit` of them, computed as they are sent.
export search : Query -> Iterator[Note]
search =
    fork iter.take .limit (.tag | has-tag | flip filter notes | iter.from-list)
```

A final `Channel` parameter streams what the function sends to it, which
suits values that come with time or from other tasks:

```fwp
# A reminder every 50 ms, n times.
export remind : I64 -> Channel[String] -> () ! {Async}
remind = curry (fork each (curry remind-step) (.0 | add 1 | range 1))
```

And an `Iterator` parameter is a stream of requests, received as the
function reads it:

```fwp
# The number of words of a stream of texts.
export count-words : Iterator[String] -> I64
count-words = iter.to-list | map (words | length) | sum
```

```
$ grpcurl -plaintext -d '{"arg1": 3}' 127.0.0.1:50051 notes.Notes/Remind
{
  "value": "reminder 1"
}
{
  "value": "reminder 2"
}
{
  "value": "reminder 3"
}
$ grpcurl -plaintext -d '{"arg1": "pipes compose"} {"arg1": "types are contracts"}' \
    127.0.0.1:50051 notes.Notes/CountWords
{
  "value": "5"
}
```

`Iterator[A] -> Iterator[B]` and `Iterator[A] -> Channel[B] -> ()` are
bidirectional.

## Metadata and deadlines

A served function reads the call's metadata (its request headers) with
`grpc.metadata` and `grpc.header`; outside a call there is none:

```fwp
# Who is calling: the `x-user` metadata of the call.
export whoami : () -> String ! {Network}
whoami = const "x-user" | grpc.header | option.unwrap-or "nobody"
```

A call's deadline (`grpc-timeout`) is the deadline of the task that serves
it: when it passes, the task is cancelled, wherever it waits.

```
$ grpcurl -plaintext -H 'x-user: ada' 127.0.0.1:50051 notes.Notes/Whoami
{
  "value": "ada"
}
$ grpcurl -plaintext -d '{"arg1": 50}' -max-time 0.1 127.0.0.1:50051 notes.Notes/Remind
{
  "value": "reminder 1"
}
ERROR:
  Code: DeadlineExceeded
  Message: context deadline exceeded
```

and the server logs `fwp: deadline exceeded (in main.remind)`. fwp
clients send their task's deadline (`task.within`, `task.deadline`), and
`grpc.with-deadline` and `grpc.with-metadata` set a deadline and metadata
for the calls of a function.

## Calling it from fwp

`fwp proto --import` makes an fwp module of any `.proto` file: a record
type and a codec per message, a client function per method (the address
first) and routes to serve the service with `grpc.serve`. Importing the
contract of this program gives a client of it:

```
$ fwp proto --grpc main.fwp -o notes.proto
$ fwp proto --import notes.proto -o notes.fwp
$ cat client.fwp
import notes

main = [
    notes.NoteRequest { arg1 = 2 } | notes.notes.note "127.0.0.1:50051" | .text | echo,
    notes.NoteRequest { arg1 = 9 } | attempt (notes.notes.note "127.0.0.1:50051") | echo,
] | ignore
$ fwp run client.fwp
types are contracts
Err (GrpcError {code = 5, message = "no note 9"})
```

The generated codecs are fwp written with `lib/protobuf.fwp`. For a
message `Note { int64 id = 1; string text = 2; repeated string tags = 3; }`
they read:

```fwp
note.encode : Note -> Bytes
note.encode = pb.encode [
    .id | pb.field 1 pb.int64,
    .text | pb.field 2 pb.string,
    .tags | pb.repeated 3 pb.string,
]
```

```fwp
note.decode : Bytes -> Note ! {Error[GrpcError]}
note.decode =
    pb.decode
    | make Note {
        id = pb.get 1 pb.int64,
        text = pb.get 2 pb.string,
        tags = pb.get-repeated 3 pb.string,
    }
```

(A program split into services with `--service`, as in
[tutorial 14](../14-services/README.md), needs none of this: its calls
stay ordinary calls.)

## The program

[`main.fwp`](main.fwp):

```fwp
# 18. gRPC
#
# Exported functions are gRPC methods: `fwp serve --grpc main.fwp` serves
# them and `fwp proto --grpc main.fwp` prints their .proto file. `main`
# calls them in-process; the README shows them served and called.
#
# grpc: notes.Notes

Note = { id: I64, text: String, tags: List[String] }

Query = { tag: String, limit: I64 }

notes : List[Note]
notes = [
    Note { id = 1, text = "pipes compose", tags = ["fwp", "style"] },
    Note { id = 2, text = "types are contracts", tags = ["fwp"] },
    Note { id = 3, text = "buy milk", tags = ["home"] },
    Note { id = 4, text = "streams are lazy", tags = ["fwp", "grpc"] },
]

# A note by its id.
export note : I64 -> Note ! {Error[GrpcError]}
note =
    fork
        or-fail
        (make GrpcError {
            code = const grpc.not-found,
            message = show | flip concat "no note ",
        })
        (eq | compose .id | find | apply notes)

has-tag : String -> Note -> Bool
has-tag = contains | compose .tags

# The notes with a tag, at most `limit` of them, computed as they are sent.
export search : Query -> Iterator[Note]
search =
    fork iter.take .limit (.tag | has-tag | flip filter notes | iter.from-list)

# A reminder every 50 ms, n times.
export remind : I64 -> Channel[String] -> () ! {Async}
remind = curry (fork each (curry remind-step) (.0 | add 1 | range 1))

remind-step : ((I64, Channel[String]), I64) -> () ! {Async}
remind-step =
    tap (const 50ms | task.sleep)
    | fork channel.send (.0 | .1) (.1 | show | flip concat "reminder ")
    | ignore

# The number of words of a stream of texts.
export count-words : Iterator[String] -> I64
count-words = iter.to-list | map (words | length) | sum

# Who is calling: the `x-user` metadata of the call.
export whoami : () -> String ! {Network}
whoami = const "x-user" | grpc.header | option.unwrap-or "nobody"

# A note as protobuf, written as `fwp proto --import` writes codecs for
# `message Note { int64 id = 1; string text = 2; repeated string tags = 3; }`.
note.encode : Note -> Bytes
note.encode = pb.encode [
    .id | pb.field 1 pb.int64,
    .text | pb.field 2 pb.string,
    .tags | pb.repeated 3 pb.string,
]

note.decode : Bytes -> Note ! {Error[GrpcError]}
note.decode =
    pb.decode
    | make Note {
        id = pb.get 1 pb.int64,
        text = pb.get 2 pb.string,
        tags = pb.get-repeated 3 pb.string,
    }

main = [
    2 | attempt note | echo,
    9 | attempt note | echo,
    Query { tag = "fwp", limit = 2 } | search | iter.to-list | map .text | echo,
    16
    | channel.make
    | tap (remind 3)
    | tap channel.close
    | channel.drain
    | echo,
    ["pipes compose", "types are contracts"]
    | iter.from-list
    | count-words
    | echo,
    () | whoami | echo,
    notes | take 1 | map (note.encode | bytes.to-list) | echo,
    notes | map (note.encode | attempt note.decode) | eq (map Ok notes) | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/18-grpc/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/18-grpc/main.fwp -o notes`. The output is
[`main.out`](main.out):

```
Ok (Note {id = 2, tags = ["fwp"], text = "types are contracts"})
Err (GrpcError {code = 5, message = "no note 9"})
["pipes compose", "types are contracts"]
["reminder 1", "reminder 2", "reminder 3"]
5
nobody
[[8, 1, 18, 13, 112, 105, 112, 101, 115, 32, 99, 111, 109, 112, 111, 115, 101, 26, 3, 102, 119, 112, 26, 5, 115, 116, 121, 108, 101]]
True
```

`main` calls the functions and the codec in-process, which is how the
output is checked; the shell sessions above show them served over gRPC.

---

Previous: [REST APIs and OpenAPI](../17-rest-and-openapi/README.md) · Next: [TLS](../19-tls/README.md) · [All tutorials](../README.md)
