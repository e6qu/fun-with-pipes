# Floating-point representation and migration

The current implementation keeps its existing precision and protocol bytes.
`F16`, `BF16` and `F128` are distinct language types, but their names do not yet
promise the corresponding physical format. The active bundle implements the
migration specified below. Until its acceptance checks pass, these remain the
implemented representations. Keep conversion
explicit and precision independent of the host.

| Language type | Implemented arithmetic/payload | Protocol v1 bytes | Intended format after a coordinated migration |
|---|---|---|---|
| F16 | binary32, 24 significant bits | 4, little endian | binary16: 1 sign, 5 exponent, 10 fraction bits |
| BF16 | binary32, 24 significant bits | 4, little endian | bfloat16: 1 sign, 8 exponent, 7 fraction bits |
| F32 | binary32 | 4, little endian | Unchanged |
| F64 | binary64 | 8, little endian | Unchanged |
| F128 | binary64, 53 significant bits | 8, little endian | binary128: 1 sign, 15 exponent, 112 fraction bits |

These intended formats follow the [LLVM floating-point type definitions](https://llvm.org/docs/LangRef.html#floating-point-types).
The half and bfloat layouts are also specified in [Clang's type documentation](https://clang.llvm.org/docs/LanguageExtensions.html#half-precision-floating-point).
This is a representation decision, not a decision to replace the C backend.

## Current contract

Interpreter values, native descriptors, array payloads and protocol v1 agree on
the implemented column above. Float conversion to F16/BF16 currently rounds to
F32; conversion to F128 currently has F64 precision. A half-typed array therefore
does not save space over F32, and F128 does not supply extra precision over F64.
Protocol golden-byte tests lock down widths, signed zero, infinities and NaN
payload transport. Arithmetic regression fixtures distinguish today's precision
from the intended formats. Neither test establishes native half/quad support.

The migration now has shared binary16/bfloat16/binary128 arithmetic and exact
decimal cores. Arithmetic/conversion NaNs are canonical positive quiet NaNs;
raw bit transport preserves payloads. Decimal conversion uses explicit per-call
scratch ownership, including cleanup on allocation failure. These cores do not
yet change the language representations above. [The handoff](development-state.md)
records their actual native/WASM validation and remaining integration work.

Keep `float.convert` explicit. Preserve operation order and the existing policy
against implicit reassociation or contraction. Do not silently substitute the
host C `long double`: its width, representation and ABI vary by target.

## Migration contract

The active implementation must deliver these together before changing representations:

- Literals, arithmetic and conversion round once to the destination format,
  using nearest, ties to even. Preserve signed zero, infinities and gradual
  underflow; do not silently flush subnormals. Narrow directly from the source
  precision, avoiding an intermediate F32/F64 rounding that changes the answer.
- Arithmetic results round at each source operation. Fused multiply-add needs
  an explicit operation and contract; it cannot replace separate multiply/add.
  Comparisons and explicit float-to-integer conversions preserve language rules.
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
  fingerprints together. Version 1 continues to mean the current 4/8-byte
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
