# Floating-point representation and migration

PR #134 is the accepted baseline: F16/BF16 used F32 arithmetic and F128 used
F64 arithmetic. The active PR #135 migrates these types to their actual formats
and changes the protocol version to 2. Scalar, array and foreign ABI integration
has focused runner coverage; complete ownership and six-platform acceptance remain.
Keep conversion explicit and precision independent of the host.

| Language type | Accepted PR #134 arithmetic/payload | Protocol v1 bytes | PR #135 format and v2 payload |
|---|---|---|---|
| F16 | binary32, 24 significant bits | 4, little endian | binary16: 1 sign, 5 exponent, 10 fraction bits; 2 bytes |
| BF16 | binary32, 24 significant bits | 4, little endian | bfloat16: 1 sign, 8 exponent, 7 fraction bits; 2 bytes |
| F32 | binary32 | 4, little endian | Unchanged |
| F64 | binary64 | 8, little endian | Unchanged |
| F128 | binary64, 53 significant bits | 8, little endian | binary128: 1 sign, 15 exponent, 112 fraction bits; 16 bytes |

These intended formats follow the [LLVM floating-point type definitions](https://llvm.org/docs/LangRef.html#floating-point-types).
The half and bfloat layouts are also specified in [Clang's type documentation](https://clang.llvm.org/docs/LanguageExtensions.html#half-precision-floating-point).
This is a representation decision, not a decision to replace the C backend.

## Current contract

On the working branch, interpreter values, native scalar arithmetic, text/JSON
and protocol encoding use binary16/bfloat16/binary128. Half and bfloat native
arrays use two-byte elements. F128 generic values are boxed 16-byte leaves;
arrays now store 16-byte elements at eight-byte alignment, copying into an owned
box when a scalar escapes. Half/bfloat workers use u16 bits. Closed quad workers
use direct bit-struct arithmetic, with passing four-host execution controls.
Closed flat numeric records now carry quad/wide values in C structs between
workers; their new ownership and measurement controls are pending. Generic
boundaries box once and register partially constructed results for unwind.
The C boundary maps half/bfloat to u16 bits and quad to `struct fwp_binary128`,
including record fields, callbacks and pointer access. The handoff records
which native ABI/export checks have completed.
This partial integration does not establish accepted format support. Protocol
golden-byte tests cover widths, signed zero, infinities and NaN payload transport;
the handoff links raw/native regression results and remaining acceptance gates.

The migration now has shared binary16/bfloat16/binary128 arithmetic and exact
decimal cores. Arithmetic/conversion NaNs are canonical positive quiet NaNs;
raw bit transport preserves payloads. Decimal conversion uses explicit per-call
scratch ownership, including cleanup on allocation failure. These cores do not
by themselves establish complete language support. [The handoff](development-state.md)
records actual checks and remaining integration work.

Keep `float.convert` explicit. Preserve operation order and the existing policy
against implicit reassociation or contraction. Do not silently substitute the
host C `long double`: its width, representation and ABI vary by target.

The lexer and AST retain decimal literal text until monomorphization selects
the destination format. Formatting and macro expansion preserve those digits;
`SFloat` now carries a decimal `String`, as described in the
[macro reference](reference.md#compile-time-evaluation-and-macros). This removes
early F64 rounding from syntax. Monomorphization now parses literal digits
directly into the selected format on the working branch.

Generated programs using these formats link the shared C11 arithmetic/decimal
and C++20 math cores. The object cache includes their source, compiler identities,
target options and relevant header-search environment; each link owns a private
archive copy while cache eviction proceeds. `--emit-c out.c` also emits
`out.float.c` and `out.float.cpp` when needed. Manual builds must compile and link
these companions with `-fno-fast-math -ffp-contract=off`; the C++ companion also
uses `-fno-exceptions -fno-rtti` and has no C++ runtime dependency. Ordinary
`fwp build` handles this compilation and caching. The bit-struct C ABI does not
depend on host `long double` or compiler-specific quad scalar types.

## Migration contract

The active PR must deliver and validate these together before acceptance:

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

The migration is item 5 of [the active plan](../PLAN.md). Code and docs must
continue to report the implemented precision until the migration passes the full
contract above on all six native platforms and the supported WebAssembly paths.
