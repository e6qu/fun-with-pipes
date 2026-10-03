# 9. Calling C

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
exported functions into a C library, with a generated header:

```
fwp build geom.fwp --staticlib -o libgeom.a   # also writes libgeom.h
```

[tests/c-interop](../../../tests/c-interop) has a Rust program and a C
program that use such a library.

## The program

[`main.fwp`](main.fwp):

```fwp
# 9. Calling C
#
# `foreign "C"` declares a C function with an fwp type. These come from the
# C library, so no extra linking is needed.

foreign "C" strlen : String -> USize
foreign "C" hypot : F64 -> F64 -> F64

# a struct returned by value
repr(C) DivResult = { quot: I32, rem: I32 }
foreign "C" div : I32 -> I32 -> DivResult

# a nullable pointer: NULL is None
foreign "C" getenv : String -> Option[Ptr[U8]] ! {IO}

# a callback: qsort calls back into fwp to compare two elements
foreign "C" qsort : Ptr[I32] -> USize -> USize -> (Ptr[I32] -> Ptr[I32] -> I32 ! {Unsafe}) -> () ! {Unsafe}

compare : Ptr[I32] -> Ptr[I32] -> I32 ! {Unsafe}
compare = curry (both (.0 | ptr.read) (.1 | ptr.read) | uncurry (flip sub))

# copy a list into C memory, sort it there, read it back
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
    | fork read-all .0 .1)

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
