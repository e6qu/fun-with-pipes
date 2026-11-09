# Parser memory: remaining observer work

**[Allocator event calibration passes on both Linux hosts](parser-allocator-calibration-2026-11-09/README.md); source-display repair and parser observations remain open.** [Ordinary RSS and stopped-process mapping
snapshots now pass](parser-entry-cleanup-2026-11-09/README.md). They leave two
different questions open: temporary storage inside a resize, and the meaning of
commit accounting for this process. Neither is answered by final vector capacity.

## Storage during a resize

A moving resize can hold the old and new allocations simultaneously while copying.
The glibc 2.39 implementation has distinct ordinary-arena, mapped-allocation and
retry paths; each can allocate before freeing the old storage. In-place growth has
no second independent allocation. This follows from the actual
[glibc source](https://github.com/bminor/glibc/blob/glibc-2.39/malloc/malloc.c),
not from a disassembly guess or an assumed replacement allocator.

Implementation steps:

1. Record the runner's exact libc package, loaded image/build ID, matching debug
   information and distro source. The upstream version alone is not an identity
   for a patched distribution library.
2. Observe the actual allocator at source-defined boundaries: entry, successful
   new allocation before copy/free, old release and return. Record thread, owning
   resize, old/new sizes and whether storage moved. Do not dereference freed blocks.
3. Calibrate with native controls for in-place growth, observed moving growth,
   shrink and failed allocation preserving the old owner. A control must establish
   which path actually occurred; requesting a larger size does not prove movement.
4. Connect those internal events to the existing parser allocation ledger without
   counting the same successful resize twice. Separate requested bytes, actual
   allocator chunk extent, retained free storage and OS pages.
5. Apply the verified observer to the four existing C/Rust/fwp parser shapes on
   ARM64/AMD64. Preserve ordinary results, source identities, all events and actual
   omitted/misclassified-event controls. Diagnostic elapsed time is not a timing
   result. fwp's separately allocated region blocks need their own event mapping.

Start by checking whether matching debug information exposes the required live
variables and boundaries. If optimized code hides them, record that limitation;
do not invent addresses or substitute a wrapper's post-return estimate. Any source
instrumentation must preserve the allocator algorithm and include an ordinary
comparison build. The first deliverable is a passing calibration, before parser
peak figures are accepted.

The first [native calibration](../../scripts/check-parser-allocator-calibration.py)
now exercises 64→72-byte in-place growth, 128→8,192-byte moving growth,
8,192→4,096-byte shrink, and a rejected `SIZE_MAX` request whose original bytes
must remain intact. An ordinary execution checks data preservation and actual
movement before the debugger observes the same binary.

[The observer](../../scripts/parser_allocator_gdb.py) uses installed libc debug
arguments and return values at `__libc_realloc`, `_int_realloc`, `_int_malloc`
and `_int_free`. It requires replacement allocation before old release, records
matching libc/debug build IDs and distro source-package identities, and never
reads a freed block or changes allocator data. Missing/optimized-out debug values
fail explicitly. The [reader controls](../../scripts/test-parser-allocator-observation.py)
reject absent/reordered internal events even when final pointers agree.

It uses GDB's documented [function breakpoints](https://sourceware.org/gdb/current/onlinedocs/gdb.html/Breakpoints-In-Python.html)
and [return-value observation](https://sourceware.org/gdb/current/onlinedocs/gdb.html/Finish-Breakpoints-in-Python.html).
Breakpoint changes occur while stopped in the outer command loop, not inside
breakpoint callbacks. Run `suite=parser-allocator-calibration` with an explicit
`parser_memory_tag`; it builds only the small native control, not the fwp compiler.
This is calibration of ordinary-arena paths. Applying it to parser allocations,
mapped/retry paths, full transient peaks and commit accounting remains work.

## Commit accounting

Linux's `Committed_AS` and `CommitLimit` are **system-wide**. Overcommit policy
changes what allocation promises mean; mode 2 even ignores `MAP_NORESERVE`.
[Kernel accounting documentation](https://www.kernel.org/doc/html/latest/mm/overcommit-accounting.html).
The per-mapping `VmFlags` include `ac` (accountable) and `nr` (no swap reservation),
whose interpretation must match the kernel version.
[Kernel mapping documentation](https://www.kernel.org/doc/html/latest/filesystems/proc.html).

Next steps:

- Record kernel version, overcommit policy and complete flags at each existing
  stopped-process checkpoint. Do not change the host's policy to obtain a result.
- Calibrate reserved, writable, touched and released mappings, including an
  explicit no-reservation case. Compare flags, mapping extents and resident pages
  independently. A writable extent is not proof of resident or guaranteed memory.
- Determine whether the observed mappings support a defensible per-process
  accounting quantity. Name its exact scope; report shared/system quantities
  separately. Summing flagged extents must not silently become “committed RAM.”
- Keep the committed-memory goal open until its observer and controls establish
  the claimed boundary. This plan does not reduce it to an RSS measurement.

This continues the [process-memory protocol](parser-process-memory.md) and
[ownership milestone](ownership-peers.md#parser-workspace), without replacing
already retained observations or repeating unchanged timing controls.
