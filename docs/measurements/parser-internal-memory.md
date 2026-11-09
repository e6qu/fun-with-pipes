# Parser memory: remaining observer work

**[Actual C/Rust owned-chunk peaks now pass](parser-native-allocator-2026-11-09/README.md);
[fwp's heap/region events](parser-heap-events.md) remain in preparation.** [Resize calibration](parser-allocator-calibration-2026-11-09/README.md)
and [actual parser RSS/mapping accounting](parser-process-accounting-2026-11-09/README.md)
pass on both Linux hosts. Neither final vector capacity nor stopped-process
snapshots establish temporary storage inside a resize.

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

The calibration now establishes the required live debug variables and boundaries.
For parser and additional allocator paths, missing/optimized-out values must still
fail explicitly; do not invent addresses or substitute a wrapper's post-return
estimate. Any source instrumentation must preserve the allocator algorithm and
include an ordinary comparison build.

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
This is calibration of ordinary-arena paths. The actual parser observer now uses
real caller-address breakpoints to follow libc tail calls and verifies both native
architectures. Mapped-remap/retry paths were not exercised by those parser inputs;
do not broaden that evidence into a full allocator-internal memory guarantee.

## Commit accounting

Linux's `Committed_AS` and `CommitLimit` are **system-wide**. Overcommit policy
changes what allocation promises mean; mode 2 even ignores `MAP_NORESERVE`.
[Kernel accounting documentation](https://www.kernel.org/doc/html/latest/mm/overcommit-accounting.html).
The per-mapping `VmFlags` include `ac` (accountable) and `nr` (no swap reservation),
whose interpretation must match the kernel version.
[Kernel mapping documentation](https://www.kernel.org/doc/html/latest/filesystems/proc.html).

The [actual parser accounting observations](parser-process-accounting-2026-11-09/README.md)
now pass on both hosts:

- Record kernel version, overcommit policy and complete flags at each existing
  stopped-process checkpoint. Do not change the host's policy to obtain a result.
- Calibrate reserved, writable, touched and released mappings, including an
  explicit no-reservation case. Compare flags, mapping extents and resident pages
  independently. A writable extent is not proof of resident or guaranteed memory.
- Sum the observed `ac`/`nr` extents and report shared/system quantities
  separately. These flagged extents are not “committed RAM.”
- Report accountable mapping extents under the captured kernel policy. A stronger
  per-process guaranteed-memory figure is not established by these interfaces;
  keep that limitation explicit rather than relabeling RSS.

This continues the [process-memory protocol](parser-process-memory.md) and
[ownership milestone](ownership-peers.md#parser-workspace), without replacing
already retained observations or repeating unchanged timing controls.

### Verified mapping-accounting calibration

The `parser-mapping-accounting` suite builds only a small native C control at
GCC O1/O2. It records five stopped-process snapshots: before reservation, after a
16 MiB inaccessible reservation, after enabling writes, after touching every page,
and after unmapping. Both ordinary mappings and explicit `MAP_NORESERVE` mappings
run with the host's existing policy. Actual omitted-touch and omitted-unmap
variants must fail the corresponding observation checks.

Each snapshot preserves `VmFlags`, the kernel version and all three overcommit
settings. The report separates:

| Quantity | Meaning |
|---|---|
| Accountable mapping extent | Sum of mapping sizes carrying the kernel's `ac` flag |
| No-reservation mapping extent | Sum carrying `nr`; mode 2 ignores the requested no-reservation flag |
| Resident pages | Actual `Rss` from the stopped process's mappings |
| `CommitLimit`, `Committed_AS` | System-wide values sampled separately; other processes can change them |

The first two quantities are **not guaranteed RAM**, and system-wide differences
cannot be assigned to this parser on a shared runner. Reader controls reject
misclassified flags even when sizes and RSS agree. [Native controls pass on both hosts](parser-mapping-accounting-2026-11-09/README.md)
at O1/O2. The actual parser checkpoints now retain the same accounting fields and
reject invalid or changing kernel policy, with complete raw-record reconstruction.
