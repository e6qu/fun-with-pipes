# fwp executables and the typed process protocol

Read [lesson 7](tutorials/07-executables-and-pipes/README.md) for the terminal
workflow. A process protocol defines the bytes two running programs exchange.
A typed stream carries the expected type as well as values so mismatched programs
can reject each other before interpreting data. This page includes the actual
binary layout for implementers, not just command-line examples.

Run the opening commands from `examples/shell`. `printf` supplies newline-separated
input; the shell pipe connects it to the executable. The function `scale` takes
the multiplier first, so `./scale 10` multiplies each input line by ten.

Every exported function can be compiled into a standalone executable.
The examples on this page use `examples/shell/tools.fwp`, which contains:

```
export scale : I64 -> I64 -> I64
scale = mul

export total : List[I64] -> I64
total = sum
```

```
$ fwp build tools.fwp --fn scale -o scale
$ ./scale 3 14
42
$ printf '1\n2\n3\n' | ./scale 10
10
20
30
```

`fwp exec tools.fwp scale 3 14` compiles and runs the same function (with
`--interp`, the interpreter) and behaves identically. This page describes the arguments, input and
output of such executables, and the binary protocol between them;
[cli.md](cli.md) describes how they work as command-line programs: flags
from a record parameter, `--help`, `--version`, `# args:` names,
multi-command executables (`--cli`) and exit statuses.

## Arguments and input

For a function with `n` curried parameters:

* `k` command-line arguments fill the first `k` parameters (after the
  flags of an options record, see [cli.md](cli.md); a final `()`
  parameter is given implicitly). Each argument is
  parsed from the canonical text format of its type (the format `show`
  produces), except that a top-level `String` is taken verbatim.
  A top-level `Bool` may also be written `true` or `false` (in exactly
  that case). A `Duration` is an integer and a unit (`ns`, `us`, `ms`,
  `s`, `min`, `h`) whose nanoseconds fit in an `I64`; larger durations
  are rejected.
* With all `n` arguments, the function runs once.
* With `n - 1` arguments, the last parameter comes from **stdin**:
  * a `List[T]` parameter receives all input records at once;
  * any other parameter type is applied to each record in turn, and results
    are written as they are produced (streaming).
* Any other number of arguments prints a usage line and exits with status 2,
  as does an argument that cannot be parsed.

Text input records are lines; invalid UTF-8 in them (and in arguments)
becomes U+FFFD, as for all text read by a program. Binary input is
detected by its magic bytes.

## Output

* A `Result[T, E]` result writes `T`, or reports the error and exits with
  1; an `Option[T]` result writes the value or nothing (the records are
  then `T`s); a `List[T]` result is written as one record per element;
  any other result is one record. `()` results produce no text records.
* Text records are the canonical text of the value followed by a newline
  (strings unquoted at the top level).
* With `FWP_OUT=bin` the output is a binary stream (below). The function's
  own `print` output then goes to **stderr**, which is reserved for
  diagnostics, so it cannot corrupt the stream.

Exit codes: 0 success, 1 an `Err` result or an uncaught `Error` (reported
on stderr as `name: error`, an `IoError` by its message), 2 usage or
argument errors, 3 input errors (including a type mismatch), 101 a
runtime trap.

## Binary stream (`PIPE_V1`)

The stream has a header, zero or more value frames and an end marker. A frame
contains a kind and length, so the reader knows where its payload ends. In the
notation below, `u8` is one unsigned byte, `u32le` is a four-byte unsigned integer
in least-significant-byte-first order, and LEB128 is a variable-length integer
encoding with seven value bits per byte. `utf8` is Unicode text encoded as bytes.
The fingerprint is a compact identity of the type description, not an encryption
or authentication check. `PIPE_V1` names the transport family; `version = 2`
names the current value encoding.

```
stream  := header frame* end
header  := "FWP1" version:u8
           ncaps:leb128 (len:leb128 utf8)*      capability names
           fingerprint:16 bytes
           len:leb128 utf8                      human-readable type
frame   := 0x01 len:u32le payload               one encoded value
         | 0x02 0x01 0x00 0x00 0x00 transport:u8  the rest is elsewhere
end     := 0x00 0x00 0x00 0x00 0x00
```

* `version` is 2. Version 1 peers are rejected immediately after the version
  byte, before decoding capabilities or payloads. The `FWP1` magic identifies
  the stream family; capability versions identify transports independently.
  The capabilities offered are `PIPE_V1` and the
  [transports](#transports) `UDS_V1` and `SHM_V1`; `GRPC_V1`,
  `STREAMING`, `TLS` and `ZSTD` are reserved names. A reader ignores
  capabilities it does not know. The transport never changes the meaning
  of a program. (Calls between [services](services.md) use gRPC instead,
  with the same value encoding and fingerprints underneath.)
* The **fingerprint** is two little-endian FNV-1a 64-bit hashes, of the
  `"fwp:2:"` followed by the canonical structural type string, and of
  `"fwp:2:type:"` followed by that string. The
  canonical string includes module-qualified names *and the structure* of
  nominal types (fields and variants), so programs agree only when their
  types really are the same. A consumer whose expected input type has a
  different fingerprint rejects the stream with
  `input type mismatch: expected `T`, got `U`` (exit 3). There is no
  runtime cast.

### Value encoding

The payload encoding is deterministic, little-endian and
architecture-independent:

| Type | Encoding |
|---|---|
| `I8`..`I128`, `U8`..`U128` | fixed width little-endian (`ISize`/`USize` as 64 bits) |
| `F32`, `F64` | IEEE 754 bits, little-endian |
| `F16`, `BF16`, `F128` | binary16, bfloat16 and binary128 bits: 2, 2 and 16 bytes, little-endian |
| `TInt[N]` | 64-bit little-endian value; `Trit` one byte |
| `String`, `Bytes` | length (LEB128) then bytes (UTF-8 for strings) |
| records, tuples | fields in canonical order (numeric labels first, then names) |
| variants (algebraic data types) | constructor index (LEB128, declaration order) then fields |
| `List`, `Array` | count (LEB128) then elements |
| `Map`, `Set` | count then keys (and values) in key order |

`hash` is FNV-1a 64 over the same encoding, so it is stable across runs,
backends and machines.

Version 2 changes the half/bfloat/quad payloads and every type fingerprint.
Version 1 used binary32 for F16/BF16 and binary64 for F128. There is no implicit
wire upgrade; rebuild both peers together. Raw encoding preserves signed zeros
and NaN payload bits; arithmetic has a separate canonical-NaN contract. See the
[format migration status](float-formats.md) for the unfinished integration gates.

Decoding is strict, and fails the same way in both backends (exit 3):

* a header whose capability or type name is longer than 1 MiB, or whose
  LEB128 numbers do not fit in 64 bits, is a `bad header`; a header cut
  short is a `truncated header`;
* a frame cut short is a `truncated frame`;
* a payload that does not decode (a length or count beyond the payload,
  an over-long LEB128 number, a string that is not UTF-8, an unknown
  constructor) is a `malformed value`.

## Transports

A transport is the mechanism moving the same typed values. An ordinary pipe
passes bytes through the operating system; a Unix-domain socket (UDS) connects
local processes; shared memory (SHM) lets them access an agreed memory region.
The latter two are Linux-specific here. Negotiating a transport does not change
the language value encoding or relax type checking.

Between two fwp executables on Linux, the stream can leave the pipe after
its header, for a Unix domain socket (`UDS_V1`) or a ring buffer in shared
memory (`SHM_V1`). The bytes are the same (the frames after the header and
the end frame); only the way they travel changes, so results are
identical, and each side falls back to the pipe whenever the other cannot
follow.

1. A producer whose stdout is a pipe listens on the abstract Unix socket
   `fwp.pipe.<dev>.<inode>`, named after that pipe, and writes its header
   (which lists `UDS_V1` and `SHM_V1`) on the pipe.
2. A consumer that reads such a header from a pipe connects to the socket
   of the same pipe, so no name travels in the stream, and asks for a
   transport: `FWPT` and one byte, 2 for `SHM_V1` (the default), 1 for
   `UDS_V1` (`FWP_TRANSPORT=uds`), or 0 to decline
   (`FWP_TRANSPORT=stdio`). It keeps reading frames from the pipe.
3. At its next frame boundary, the producer accepts a connection from a
   process of the same user. For `SHM_V1` it creates the ring in a
   `memfd` and passes the descriptor over the socket (`SCM_RIGHTS`); if
   that fails, it uses the socket itself. It then writes a switch frame
   (`0x02`, length 1, the transport chosen) on the pipe and writes the
   rest of the stream to the socket or the ring.
4. A consumer that reads the switch frame continues on that transport. A
   switch frame that it did not ask for is a `bad switch frame` (exit 3).

A ring buffer reuses a fixed memory region as read/write positions advance.
A futex is a Linux wait/wake mechanism used when spinning would waste CPU.
The ring has one producer and one consumer without locks: a 4096-byte
header (the `FWPS` magic, version 1, the capacity of 1 MiB, the bytes
written and read so far on separate cache lines, and a futex word with a
waiting flag for each direction) followed by the data. A side that finds
the ring empty (or full) spins for up to 50 µs (yielding the processor
now and then, in case the other side waits for it), then sleeps on the futex;
the other side wakes it only when it is sleeping, so a busy stream needs
no system calls. Each side notices from the socket when the other one
exited.

Producers check for a consumer at most once a millisecond (when they
flush, and every 64 frames), and stop offering after 5 seconds, so a
stream that a consumer does not ask to move stays on the pipe. The probing
still has a cost; this is not a measured zero-overhead guarantee.
With `FWP_TRANSPORT_WAIT=ms` the producer waits that long after its
header for the consumer to ask, so that the whole stream moves; `fwp pipe`
sets it, since all its stages are fwp programs. Other readers of the pipe
(`xxd`, a file, an older fwp) get the stream unchanged on the pipe:
nobody connects. A producer also enlarges its stdout pipe to 1 MiB where
the system allows. Elsewhere than on Linux, and on WebAssembly, streams
stay on the pipe.

Measured between two native executables (`-O2`, 4 cores), the throughput
of a stream of 200,000 strings of 4 KiB (820 MB, written as one list and
read one record at a time) and of 1,000,000 strings of 100 bytes written
one at a time (each flushed, as streaming results are):

| transport | 820 MB in large records | 1M small records, each flushed |
|---|---|---|
| pipe (`FWP_TRANSPORT=stdio`) | 1.6 s | 2.2–4.3 s |
| `UDS_V1` | 0.80 s | 3.5–4.0 s |
| `SHM_V1` | 0.66 s | 1.3–1.4 s |

(Best of five runs on a shared machine; with three other processes
spinning on the four cores, `SHM_V1` took 0.85 s and 1.2 s.)

The interpreter (`fwp exec --interp`) implements the same transports, so
interpreted and native stages switch with each other.

## Pipelines

`fwp pipe` starts each stage as a process and connects them with the binary
protocol; the last stage writes text:

```
$ printf '1\n2\n3\n' | fwp pipe 'tools.fwp:scale 10 | tools.fwp:total'
60
```

Native executables compose the same way in any shell:

```
$ printf '1\n2\n3\n' | FWP_OUT=bin ./scale 10 | ./total
60
```

Between them, the stream may move to a faster [transport](#transports).

Native and interpreted stages can be mixed; they write identical bytes.
