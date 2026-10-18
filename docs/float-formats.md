# Floating-point representation and arithmetic

Floating-point numbers store a sign, an exponent (scale) and a fraction. More
fraction bits give more precision; more exponent bits give a wider range. The
format is part of the fwp type, independent of the host CPU. `float.convert`
explicitly changes it. See [tutorial 12](tutorials/12-numerics/README.md) for
numeric programming and [the binary protocol](protocol.md) for transport bytes.

A **payload** is the bytes representing a value inside a message. **Little
endian** puts the least significant byte first. The formats below are implemented;
PRs [#135](https://github.com/e6qu/fun-with-pipes/pull/135) and
[#136](https://github.com/e6qu/fun-with-pipes/pull/136) record integration and
platform verification.

| Language type | Arithmetic format | Protocol v2 payload |
|---|---|---|
| F16 | binary16: 1 sign, 5 exponent, 10 fraction bits | 2 bytes, little endian |
| BF16 | bfloat16: 1 sign, 8 exponent, 7 fraction bits | 2 bytes, little endian |
| F32 | binary32: 24 significant bits | 4 bytes, little endian |
| F64 | binary64: 53 significant bits | 8 bytes, little endian |
| F128 | binary128: 1 sign, 15 exponent, 112 fraction bits | 16 bytes, little endian |

Protocol v1 used wider half payloads and a narrower quad payload; version 2
rejects that incompatible wire format. Prior representation evidence remains
in [history](roadmap-history.md), not as an alternative arithmetic mode.

These formats follow the [LLVM floating-point type definitions](https://llvm.org/docs/LangRef.html#floating-point-types).
The half and bfloat layouts are also specified in [Clang's type documentation](https://clang.llvm.org/docs/LanguageExtensions.html#half-precision-floating-point).
This is a representation decision, not a decision to replace the C backend.

## Current contract

A **box** is an allocation holding one value; a **worker** is a specialized
internal function. A generic entry can box a value even when its specialized
worker passes bits directly. An ABI (application binary interface) specifies
how machine-level calls pass those arguments and results.

Interpreter values, native scalar arithmetic, text/JSON
and protocol encoding use binary16/bfloat16/binary128. Half and bfloat native
arrays use two-byte elements. F128 generic values are boxed 16-byte leaves;
arrays now store 16-byte elements at eight-byte alignment, copying into an owned
box when a scalar escapes. Half/bfloat workers use u16 bits. Closed quad workers
use direct bit-struct arithmetic, with passing four-host execution controls.
Closed flat numeric records now carry quad/wide values in C structs between
workers; four-host ownership controls and measured allocation reductions are
recorded in [the measurement artifact](measurements/wide-records-2026-10-14.json). Generic
boundaries box once and register partially constructed results for unwind.
The C boundary maps half/bfloat to u16 bits and quad to `struct fwp_binary128`,
including record fields, callbacks and pointer access. [Delivery evidence](roadmap-history.md)
records the completed native ABI/export checks.
Protocol golden-byte tests cover widths, signed zero, infinities and NaN payload
transport. Delivery evidence links the corresponding production verification.

The implementation uses shared binary16/bfloat16/binary128 arithmetic and exact
decimal cores. For these three formats (F16, BF16 and F128), arithmetic and
conversion NaNs are canonical positive quiet NaNs. F32/F64 arithmetic NaN signs
and payloads are implementation dependent. Raw bit transport preserves payloads
and signs for every format. Tests of NaN key ordering must supply the same bits
to both implementations, rather than derive keys from arithmetic such as 0/0. Decimal conversion uses explicit per-call
scratch ownership, including cleanup on allocation failure. Delivery evidence
records language integration and native verification alongside core arithmetic
checks.

Keep `float.convert` explicit. Preserve operation order and the existing policy
against implicit reassociation or contraction. Do not silently substitute the
host C `long double`: its width, representation and ABI vary by target.

The lexer and AST retain decimal literal text until monomorphization selects
the destination format. Formatting and macro expansion preserve those digits;
`SFloat` now carries a decimal `String`, as described in the
[macro reference](reference.md#compile-time-evaluation-and-macros). This removes
early F64 rounding from syntax. Monomorphization now parses literal digits
directly into the selected format.

Generated programs using these formats link the shared C11 arithmetic/decimal
and C++20 math cores. The object cache includes their source, compiler identities,
target options and relevant header-search environment; each link owns a private
archive copy while cache eviction proceeds. `--emit-c out.c` also emits
`out.float.c` and `out.float.cpp` when needed. Manual builds must compile and link
these companions with `-fno-fast-math -ffp-contract=off`; the C++ companion also
uses `-fno-exceptions -fno-rtti` and has no C++ runtime dependency. Ordinary
`fwp build` handles this compilation and caching. The bit-struct C ABI does not
depend on host `long double` or compiler-specific quad scalar types.

## Conformance requirements

A **subnormal** represents very small values with reduced precision. A **NaN**
represents a non-number result and can carry extra payload bits. “Ties to even”
chooses the nearest result with an even low bit when exactly halfway. One **ULP**
is one representable step at the result's magnitude. Reassociation changes
parentheses; contraction replaces separate operations with one fused operation.
Either can change rounding.

Implementation and tests must preserve these rules together:

- Literals, arithmetic and conversion round once to the destination format,
  using nearest, ties to even. Preserve signed zero, infinities and gradual
  underflow; do not silently flush subnormals. Narrow directly from the source
  precision, avoiding an intermediate F32/F64 rounding that changes the answer.
- Arithmetic results round at each source operation. Fused multiply-add needs
  an explicit operation and contract; it cannot replace separate multiply/add.
  Comparisons and explicit float-to-integer conversions preserve language rules.
- Addition, subtraction, multiplication, division and square root are correctly
  rounded. `exp`, `ln`, `sin`, `cos`, `tan` and `pow` use format-specific software
  math with an at-most-1-ULP accuracy contract. They preserve the declared input
  range and result precision; F128 math cannot narrow through F64. These accuracy
  bounds do not authorize reassociation, contraction or implicit widening.
- Raw binary encoding transports all bits, including NaN payloads. Arithmetic
  may quiet NaNs; specify its payload policy in matching interpreter/native
  implementations before claiming conformance. Text JSON retains its separate
  existing special-value convention and is not a NaN-payload transport.
- Native scalar workers, arrays, constants, generic boxes, ownership and alignment
  must agree. F16/BF16 payloads use 2 bytes and F128 uses 16. Natural alignment
  does not imply SIMD or cache-line alignment. Software arithmetic on targets
  lacking an instruction must implement the same format explicitly; it cannot
  substitute reduced precision.
- Change the binary protocol version and version-sensitive compatibility
  fingerprints together. Version 1 continues to mean the old 4/8-byte
  representations. Reject incompatible peers before payload decoding; do not
  guess a format from the payload or silently accept old bytes as new values.
- Validate both engines and native Linux/macOS/Windows ARM64/AMD64: midpoint ties,
  carry across exponents, normal/subnormal boundaries, signed zeros, maximum
  finite values, overflow, NaNs, explicit conversions, wire golden bytes and
  array stride/ownership. Measure allocations and native instructions before
  claiming a storage or arithmetic benefit. AD rules must state primal and
  gradient precision explicitly rather than implicitly widening them.

The intended bfloat treatment includes subnormals and nearest-even rounding;
these are concrete choices consistent with the [ratified RISC-V BF16 specification](https://docs.riscv.org/reference/isa/unpriv/bfloat16.html), not assumptions
that every device's bfloat instructions behave identically.

Preserve the declared precision and the native/WebAssembly regression tests
when changing these implementations.
Storage savings do not imply hardware arithmetic support or faster execution;
software-format operations can cost more than a native F32/F64 instruction.
