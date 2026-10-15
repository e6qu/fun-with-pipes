# Scoped gdtoa decimal conversion

Decimal conversion reads a text number into a binary floating-point value or
prints a value back to text. Exact conversion means rounding directly to the
selected format, without an intermediate lower-precision result. Scratch storage
is temporary memory used by a conversion; an arena serves small allocations from
one block, and overflow blocks handle larger requests.

Selected generic conversion routines from David M. Gay's [Netlib gdtoa archive](https://www.netlib.org/fp/gdtoa.tgz).
[The manifest](manifest.json) records archive and upstream-file SHA-256 hashes;
[the patch](fwp.patch) records every modification to upstream files.
The [Lucent permissive license](LICENSE.txt) must accompany distributions.

`arith.h` configures the accepted little-endian IEEE binary64 hosts, 32-bit
integer limbs, decimal input, gradual underflow and explicit nearest-even
rounding. `symbols.h` prefixes public and internal conversion symbols.
The generic routines need no target-specific NaN table; fwp supplies that policy.

The existing context plumbing now receives one explicit conversion scope. It
has no thread registry, shared caches, lazy initialization or retained memory.
A 4 KiB stack arena handles small conversions; individually linked overflow
blocks belong to that call and are released on success or failure. Temporary
bigints reuse storage within the call. Allocation failure unwinds to the owning
conversion, which returns an error after releasing every overflow block.

Three arithmetic changes are recorded in the patch: the parser's quick path
cannot round a subnormal twice; decrementing a power-of-two approximation uses
its normalized exponent; exponent-bit construction uses an unsigned shift. Tests cover the direct decimal midpoint that exceeds binary128 precision,
all non-NaN binary16/bfloat16 round-trips, binary128 boundaries, concurrency,
allocation failure and sanitizers. The [format contract](../../docs/float-formats.md) describes the completed
language integration; these core tests specifically validate conversion behavior.
