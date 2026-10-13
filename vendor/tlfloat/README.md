# TLFloat transcendental core

Selected headers from [TLFloat 1.15.0](https://github.com/shibatch/tlfloat/tree/v1.15.0),
under the [Boost Software License](LICENSE.txt). [The manifest](manifest.json)
records the release archive and every upstream header's SHA-256 hash.
`tlfloatconfig.hpp` is fwp's configuration, not an upstream modification.
[The patch](fwp.patch) records an upstream division correction: after handling
NaNs, infinities and zero denominators, a zero numerator returns signed zero
before normalization can shift by the integer's full width. The half/bfloat
`ln(1)` sanitizer control exercises this path.

The C ABI in `runtime/fwp_float_math.cpp` instantiates only half, bfloat and
quad `exp`, `ln`, `sin`, `cos`, `tan` and `pow`. Upstream specifies at most
1 ULP error for these functions across the input range; this is distinct from
the correctly rounded SoftFloat arithmetic and square root. Results use the
declared format, including binary128 range and precision, and canonical positive
quiet NaNs. No conversion through host `double` or `long double` is used.

The configuration explicitly selects compiler 128-bit integer arithmetic and
leading-zero builtins on Clang/GCC. The C++20 templates use fixed-size integer
storage and disable stream/string interfaces (`TLFLOAT_NO_LIBSTDCXX`). C++
headers are needed to build the core; its object is linked with the C runtime
without libstdc++, allocation, exceptions or RTTI. Platform validation and
language integration status live in [the handoff](../../docs/development-state.md).
