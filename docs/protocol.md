# fwp executables and the typed process protocol

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

`fwp exec tools.fwp scale 3 14` runs the same function with the interpreter
and behaves identically.

## Arguments and input

For a function with `n` curried parameters:

* `k` command-line arguments fill the first `k` parameters. Each argument is
  parsed from the canonical text format of its type (the format `show`
  produces), except that a top-level `String` is taken verbatim.
* With all `n` arguments, the function runs once.
* With `n - 1` arguments, the last parameter comes from **stdin**:
  * a `List[T]` parameter receives all input records at once;
  * any other parameter type is applied to each record in turn, and results
    are written as they are produced (streaming).
* Any other number of arguments prints a usage line and exits with status 2,
  as does an argument that cannot be parsed.

Text input records are lines. Binary input is detected by its magic bytes.

## Output

* A `List[T]` result is written as one record per element; any other
  result is one record. `()` results produce no text records.
* Text records are the canonical text of the value followed by a newline
  (strings unquoted at the top level).
* With `FWP_OUT=bin` the output is a binary stream (below). The function's
  own `print` output then goes to **stderr**, which is reserved for
  diagnostics, so it cannot corrupt the stream.

Exit codes: 0 success, 1 an uncaught `Error` (reported as `error: ...`),
2 usage or argument errors, 3 input errors (including a type mismatch),
101 a runtime trap.

## Binary stream (`PIPE_V1`)

```
stream  := header frame* end
header  := "FWP1" version:u8
           ncaps:leb128 (len:leb128 utf8)*      capability names
           fingerprint:16 bytes
           len:leb128 utf8                      human-readable type
frame   := 0x01 len:u32le payload               one encoded value
end     := 0x00 0x00 0x00 0x00 0x00
```

* `version` is 1. The only capability currently offered is `PIPE_V1`;
  `UDS_V1`, `SHM_V1`, `GRPC_V1`, `STREAMING`, `TLS` and `ZSTD` are reserved
  names for future transports. The transport never changes the meaning of a
  program.
* The **fingerprint** is two little-endian FNV-1a 64-bit hashes, of the
  canonical structural type string and of `"fwp:"` followed by it. The
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
| `TInt[N]` | 64-bit little-endian value; `Trit` one byte |
| `String`, `Bytes` | length (LEB128) then bytes (UTF-8 for strings) |
| records, tuples | fields in canonical order (numeric labels first, then names) |
| ADTs | constructor index (LEB128, declaration order) then fields |
| `List`, `Array` | count (LEB128) then elements |
| `Map`, `Set` | count then keys (and values) in key order |

`hash` is FNV-1a 64 over the same encoding, so it is stable across runs,
backends and machines.

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

Native and interpreted stages can be mixed; they write identical bytes.
