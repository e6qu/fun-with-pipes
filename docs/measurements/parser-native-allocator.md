# Actual parser allocator events

**[Both native hosts pass](parser-native-allocator-2026-11-09/README.md).** This connects the
[installed-libc calibration](parser-allocator-calibration-2026-11-09/README.md)
to the real C/Rust parser vectors. It does not change the allocator or measure
diagnostic execution time as performance.

## Work and observations

- Keep the existing 31/511/8,191-node balanced inputs and 127-node left-nested
  input, one parse per process. Tokens borrow input text; nodes use indices.
- Compile ordinary and diagnostic peers at production GCC/Rust O2 without LTO.
  Diagnostic builds add five external checkpoint calls and debug information.
  Ordinary and observed results must agree with the independent input oracle.
- Calibrate the exact installed libc, debug build ID and distro source first.
  Use the matching Rust source component for debugger source lookup.
- Observe public allocation/free/resize calls and internal allocation, release
  and remap boundaries between the first and last parser checkpoints. Record
  thread, operation, requested size and the live chunk's address/extent.
- Read headers only while the allocation is live. Never call inferior functions,
  write allocator data, dereference old storage after release or infer allocation
  from instruction patterns. Missing debug values/symbols or unexpected threads
  fail explicitly. Bound the trace to 4,096 events.
- Observe returns at the real caller's resume address and verify its stack and
  thread. Read pointer results from the target ABI's return register. Tail calls
  can share that return: close their nested observations in reverse entry order,
  counting each returned chunk once. No allocator data or results are changed.

## Three different storage numbers

| Quantity | Boundary |
|---|---|
| Endpoint requested peak | Requested live bytes after each public operation; must agree with the existing vector ledger |
| Requested peak with observed resize overlap | Includes the old request and its separately allocated replacement when internal events establish that both exist |
| Observed owned-chunk peak | Union of actual parser-owned libc chunk extents at allocation/release/remap boundaries, including observed replacement storage |

Nested allocator calls can return the same block. Count its address range once.
A successful mapping resize replaces the old mapping; do not invent two live
allocations merely because the returned address changed. Preserve the original
old/new distinction for actual allocate/copy/free paths, including retry paths.

These numbers exclude allocator-retained free pages, arena metadata and kernel
internals. They are not whole-process RSS or guaranteed memory. The separate
[accounting snapshots](parser-process-accounting-2026-11-09/README.md) cover those
observed process boundaries. fwp's managed heap and separately allocated region
blocks require their [own event mapping](parser-heap-events.md); this C/Rust
observer does not verify them.

## Acceptance and retained failures

Both native Linux architectures must pass eight ordinary/observed result pairs.
Their complete public allocation transitions must equal the independently
specified token/node growth ledger. Moving copies need actual replacement
allocation before old release. All parser-owned chunks must be released.

Four C fault executions actually omit tree-vector release. Their numeric results
still pass, but the allocation reader must report live parser storage. Reader
controls also reject missing/reordered internal events, wrong vector work and
duplicate counting. Synthetic mapped/retry cases verify reader logic only;
classify native occurrences from events, and do not call unobserved paths tested.

### Additional native path controls

The prepared follow-up keeps ordinary/parser checks and adds two small programs
within one control executable. Both use public libc and process-resource APIs;
the debugger never changes their data, allocation results or control flow.

- **Mapped resize:** explicitly enable mapped large allocations, allocate 1 MiB,
  resize to 4 MiB, verify preserved bytes and release it. Require an actual
  successful `mremap_chunk` return. A changed address does not count as two
  simultaneously owned allocations.
- **Arena retry:** prepare reusable storage in a worker's arena, then limit only
  this process's virtual address space to its existing size. Transfer a small
  main-arena allocation to that worker. Its 1 MiB resize must first fail in the
  original arena, then obtain existing space in the worker's arena and release
  the original allocation. Require those actual internal events; successful
  numeric output alone does not prove the intended path occurred.

The retry control explicitly permits a two-thread transfer at a checkpoint.
Each allocation operation still starts and finishes on one thread. Actual parser
traces still require a single thread throughout. The process's hard resource limit
is preserved; this control neither changes the runner's limits nor sets a new
production allocation policy. Six reader tests preserve those distinctions.

A failed mapped-remap followed by a copy is still only a synthetic reader case;
do not claim it occurred in these controls or the fixed parser inputs. Results
remain observations of owned chunks at recorded boundaries, not a universal
peak bound for all glibc internals.

The first run at `19b8b48fe` ([42679061783](https://github.com/e6qu/fun-with-pipes/actions/runs/42679061783))
passed five builds and eight ordinary results per host, but all 12 diagnostic
executions failed. The observer lost returns through libc tail calls. Its Rust
setup also evaluated a C type expression in a Rust frame and disabled auto-loading
after the executable had already been read. The repair uses caller-address return
breakpoints, debug type fields for layout and GDB's early `-iex` setting.
[Complete first-failure records](parser-native-allocator-2026-11-09/README.md).

Freeze an immutable source tag before collection. Preserve original/prepared
sources, native images, complete command journals, exact libc/source identities,
raw events, summaries and every failed observation. Diagnostic elapsed time is
not a speed result. [Remaining allocator work](parser-internal-memory.md).
