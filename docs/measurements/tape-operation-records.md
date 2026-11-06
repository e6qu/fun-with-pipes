# Experiment: store a tape operation in one record

Reference: `ef0a54a1da660fcc4c4e094e96c30c1adbe0fb5d` (#266).
This contract precedes implementation. No speed benefit is established.
The [source investigation](recording-context-next-layout.md) explains why this
is the next candidate; earlier timing misses remain open.

## Representation and ownership

For a numeric operation, store two I32 parent indices and two F64 derivative
weights in one 24-byte record, naturally aligned for F64. For example, recording
`z = x * y` stores `(x-index, y-index, y-value, x-value)`. Reverse traversal still
adds the contribution to x first, then y, even if both indices are equal.

- One numeric operation buffer replaces the parent and weight allocations.
  Growth reallocates records without moving a second column to a new offset.
- Typed F128/nested tapes use 8-byte parent pairs and retain their separately
  owned weights. They allocate no unused numeric weights. Publish capacity only
  after managed weight growth succeeds; a trapped growth preserves old records.
- The registry, scope and detached backward owner hold the actual allocation
  bases. Every return, trap, cancellation and shutdown keeps exact cleanup.
- Keep the 512 KiB numeric workspace budget, independent of registry storage.
  Reuse transfers the same ownership; caching never substitutes for reclamation.

Node IDs, input bounds, parent-validation order, scalar bits, rounding, signed
zero, NaN payload storage and backward arithmetic order remain unchanged.
Operation capacity is additionally bounded by `PTRDIFF_MAX / record-size` before
allocation or the no-growth shortcut. Numeric records use 24 bytes; typed weight
pairs use 16 bytes. Input leaves still require no operation records. Mirror the
numeric operation bound in the interpreter; native and interpreter must agree
on rejection order. Do not combine equal parents or reassociate arithmetic.

## Verification and acceptance

1. Update moving-allocation and failure probes: record size/alignment, exact bit
   preservation, partial typed growth, arithmetic order, detached cleanup,
   workspace reuse, registry reuse and actual wasm32 byte calculations.
   Negative controls must demonstrate that the checks detect broken code.
2. Run the complete affected native group once after the implementation batch,
   with production GCC/Clang and O0/O1/O2 probes as appropriate. Include typed
   and nested derivatives, cancellation, library unload and WebAssembly. Audit
   every completed target and failure, then batch any repairs.
3. Measure the same six Rosenbrock inputs and current/history forms as the
   [shared-scope comparison](recording-context-scopes.md). Freeze candidate and
   reference source hashes before timing. Preserve all earlier compiler
   transformations; vary only tape storage. Observe one rather than two raw
   numeric growth requests, unchanged numeric payload bytes per operation,
   exact zero final storage and the actual registry/stack costs.
4. Use the existing two-session ARM/approved-AMD host policy, balanced copies,
   compilers, flags and sample counts. Keep the 5% long-case speed target, 2%
   small-case regression/copy limits and 5% compiler time/RSS limits. Retain all
   misses; no unchanged reruns. Compare absolute time and process memory with
   C/Rust, explaining their handwritten derivatives. Swift remains separately
   measured, with no inferred ARC counts.
5. Verify original measured images and complete nine final-head production jobs,
   documentation and full evidence audits before squash merge. Implementation
   alone does not complete this experiment or close an older missed target.
