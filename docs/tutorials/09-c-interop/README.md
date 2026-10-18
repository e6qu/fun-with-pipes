# 9. Calling C

Read lessons 1–4 first. C interoperability means calling code written in C
from fwp. A **pointer** is a memory address, not a managed fwp collection.
`Ptr[I32]` addresses 32-bit signed integers; `ptr.at` moves by elements, while
`mem.alloc` takes a size in bytes. `USize` matches C's unsigned size type.
`repr(C)` requests C's field layout for a record. A **callback** is a function
passed to C so that C can call it, here to compare items while sorting.

The `Unsafe` effect makes these operations visible in the type; it does not
prove an address valid. The example allocates storage, writes the input into it,
asks C to sort it, copies the result into an fwp list and frees the storage.
The caller must also plan cleanup if adding operations that can fail.

`foreign "C" name : Type` declares a C function and the fwp type it is
called at. The C-side types follow from the fwp types:

| fwp | C |
|---|---|
| numbers | the C integer and floating-point types (`USize` is `size_t`) |
| `String` | `const char *` |
| `Ptr[T]` | a pointer |
| `Option[Ptr[T]]` | a pointer that may be NULL |
| `repr(C)` record | a struct, passed by value |
| function | a callback |

C code is unsafe in general, so the declared effects are up to you; this
program marks pointer reads and writes with `Unsafe`. Memory comes from
`mem.alloc` and is read and written with `ptr.read`, `ptr.write` and
`ptr.at`.

## Your own C code

Add C sources or libraries with `--link`. It works with the interpreter and
with native builds:

```
fwp run --link mylib.c program.fwp
fwp build program.fwp --link mylib.c --link -lm -o program
```

## fwp as a C library

The other direction works too. `--staticlib` and `--cdylib` build the
exported functions into a C library, with a generated header (here
`libgeom.h`, next to `libgeom.a`):

```
fwp build geom.fwp --staticlib -o libgeom.a
```

[tests/c-interop](../../../tests/c-interop) has a Rust program and a C
program that use such a library.

On macOS the shared-library form (`--cdylib`) uses `.dylib` and the
interpreter loads a Darwin FFI shim. Native portability and verification
are tracked in [the session handoff](../../development-state.md).

On Windows, generated libraries use LLVM-MinGW and the Universal C Runtime
(UCRT). A Rust caller must use the matching native
[`x86_64-pc-windows-gnullvm` or `aarch64-pc-windows-gnullvm` target](https://doc.rust-lang.org/rustc/platform-support/windows-gnullvm.html)
and LLVM-MinGW linker. These targets make the Rust caller and generated library
agree on the C calling convention and runtime libraries. The repository setup
script installs that Rust target for its Windows interop checks. Generated DLLs
explicitly export their declared functions and result releases, so a name also
used by the Windows runtime cannot silently disappear from the DLL interface.

## Reading the example

The first four outputs come from standard C functions: `strlen` counts the five
bytes of "hello", `hypot` computes √(3² + 4²), `div` returns quotient 3 and
remainder 2, and `getenv` returns no pointer for the deliberately absent variable.

The final example copies I32 values into a raw buffer. Each I32 uses four bytes,
so allocation multiplies the list length by four. `enumerate` supplies `(index,
value)` pairs to `write-at`. `qsort` receives the buffer, element count, element
size and comparison callback. Its subtraction comparator is suitable for these
small sample values; arbitrary I32 extremes need an overflow-safe comparator.
`read-all` copies sorted values back into a managed list. `both` evaluates that
read before `mem.free`, then `.0` keeps the list and discards the unit result of
freeing. The sorted output is therefore `[-2, 0, 3, 5, 9]`.

The `mylib.c`, `program.fwp` and `geom.fwp` commands above are usage templates;
those files are not supplied by this lesson. A static library is linked into
another executable; a shared library is loaded alongside it. A generated header
declares its callable C interface.

When an exported function returns a string, the caller owns the returned storage.
The generated header supplies a matching release function. For example,
`tests/c-interop/geom.fwp` exports `greet`, which formats its input as a greeting:

```c
const char *greeting = greet("c");
printf("%s\n", greeting);     /* prints hello, c! */
fwp_release_greet(greeting); /* releases this result's ownership */
```

Use the result before releasing it, and release it exactly once. Do not call
`free` or modify the returned string. A returned record containing strings has
one release function for the whole record; copied pointer bits are aliases,
not separately owned results. Scalar-only results need no release. Release all
results and finish all calls before unloading a shared library. Host calls and
releases must be serialized. This result-ownership extension is undergoing the
checks recorded in [the handoff](../../development-state.md).

## The program

[`main.fwp`](main.fwp):

```fwp
foreign "C" strlen : String -> USize
foreign "C" hypot : F64 -> F64 -> F64

repr(C) DivResult = { quot: I32, rem: I32 }
foreign "C" div : I32 -> I32 -> DivResult

foreign "C" getenv : String -> Option[Ptr[U8]] ! {IO}

foreign "C" qsort : Ptr[I32] -> USize -> USize -> (Ptr[I32] -> Ptr[I32] -> I32 ! {Unsafe}) -> () ! {Unsafe}

compare : Ptr[I32] -> Ptr[I32] -> I32 ! {Unsafe}
compare = curry (both (.0 | ptr.read) (.1 | ptr.read) | uncurry (flip sub))

sort-in-c : List[I32] -> List[I32] ! {Unsafe}
sort-in-c = fork sort-buffer length to-buffer

to-buffer : List[I32] -> Ptr[I32] ! {Unsafe}
to-buffer = fork write-all id (length | mul 4 | mem.alloc)

write-all : List[I32] -> Ptr[I32] -> Ptr[I32] ! {Unsafe}
write-all = curry (tap (fork each (.1 | write-at) (.0 | enumerate)) | .1)

write-at : Ptr[I32] -> (I64, I32) -> () ! {Unsafe}
write-at = curry (fork ptr.write (.1 | .1) (fork ptr.at (.1 | .0) .0))

sort-buffer : I64 -> Ptr[I32] -> List[I32] ! {Unsafe}
sort-buffer = curry (tap (both .1 (.0 | int.convert | option.unwrap-or 0usize)
        | uncurry qsort
        | apply 4usize
        | apply compare)
    | both (fork read-all .0 .1) (.1 | mem.free)
    | .0)

read-all : I64 -> Ptr[I32] -> List[I32] ! {Unsafe}
read-all =
    curry (fork map (.1 | flip ptr.at | flip compose ptr.read) (.0 | range 0))

main = [
    "hello" | strlen | echo,
    hypot 3.0 4.0 | echo,
    div 17 5 | echo,
    "NO_SUCH_VARIABLE_HERE" | getenv | option.is-none | echo,
    [5, -2, 9, 0, 3] | sort-in-c | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/09-c-interop/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/09-c-interop/main.fwp -o c-interop`. The output is
[`main.out`](main.out):

```
5
5.0
DivResult {quot = 3, rem = 2}
True
[-2, 0, 3, 5, 9]
```

`fwp run` compiles the program to native code, so foreign calls are
ordinary C calls. With `--interp`, the interpreter reaches C through a
small shim library that it compiles with the system C compiler, so it
needs `cc` too.

---

Previous: [An HTTP server](../08-http-server/README.md) · Next: [WebAssembly](../10-webassembly/README.md) · [All tutorials](../README.md)
