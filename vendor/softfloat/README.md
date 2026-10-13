# Berkeley SoftFloat 3e

This subset implements binary16/binary128 arithmetic and conversions for fwp's
float-format migration. It comes from John Hauser's
[SoftFloat 3e archive](https://www.jhauser.us/arithmetic/SoftFloat-3e.zip), released
2018-01-20. [manifest.json](manifest.json) records the archive SHA-256 and selected
files. The original [BSD three-clause license](LICENSE.txt) is compatible with
the project's MIT license and must accompany binary distributions.

Upstream C and header files are unchanged. Specialized source files and
`specialize.h` come from `source/ARM-VFPv2-defaultNaN`; other C files come from
`source/`, and common headers from `source/include/`. `platform.h` is fwp's
configuration: the portable 64-bit integer algorithm, nearest-even arithmetic,
round-to-odd available for direct narrowing, and thread-local exception state.
WebAssembly executes on one thread and does not use C thread-local storage.
Arithmetic and numeric conversions use positive canonical quiet NaNs; raw binary
transport preserves all bits. No host `long double` is used.

The subset omits extended80 and floating decimal/transcendental operations.
Those need the explicit implementations and tests required by the active format
migration; this arithmetic core alone does not establish language-level support.
