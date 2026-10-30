# Unique buffer compared with C and Rust

This is the next B1 comparison, in preparation. No timings have been collected
and no speed or memory-parity claim is accepted by this document. The existing
[A5 result](unique-array-storage.md) establishes removed count operations, not
execution time relative to another language.

## Work that must match

Use the existing [buffer fixture](../../tests/fixtures/unique_buffer_costs.fwp).
`unique(n)` constructs the integers from zero through `n - 1`, passes the array
to a borrowing helper, reads its length again, and releases it. The helper adds
the length to the first element, or zero for an empty array. For nonnegative `n`, the result is `2*n`. Negative lengths produce an
empty array and result zero, matching `array.generate`.
`callback(n)` uses the known `read` callback and returns `max(n, 0)`. Both inputs are
runtime lengths; neither entry may return or retain the array.

Write C and Rust versions with the same sequence: allocate one integer buffer,
initialize every element, borrow it for those reads, then release it. Use checked
integer arithmetic. Empty Rust buffers may need no allocation; fwp still needs
its array representation. Report that difference. Let each production compiler
optimize its source normally. If a compiler eliminates the buffer or a read,
report that result rather than adding a hidden barrier to force allocation.

Keep the shared-array and unknown-callback ownership tests as correctness
controls. They must continue to reject the unique representation; they are not
silently substituted for the known-callback timing workload.

The initial C/Rust peers pass 192 Clang/Rust O1/O2 checks through
`scripts/check-unique-buffer-peers.py --cc clang --rustc rustc`: exact outputs,
negative/empty lengths, repeated calls, oversized allocation rejection and invalid
arguments. This is local peer correctness, not GCC or fwp cross-validation.
The harness makes each call's input and result opaque to the compiler, using C
inline assembly and Rust `black_box`; neither prevents optimization inside the
buffer operation. Their overhead belongs in the eventual timing scope.

## Implementation tasks before measurement

1. Add C/Rust peers and compare results at lengths 0, 16, 4,096 and 262,144.
   Verify raw/optimized fwp and native O1/O2 results. Check negative lengths, malformed arguments and
   allocation failure separately from timing; preserve the existing recovery,
   cancellation and physical-free controls. Save all sources and build commands.
2. Add explicit repeated-call harnesses for each language. Pass length and repeat
   count at runtime, validate every result and return an aggregate checksum.
   Keep compiler-visible work comparable; explain any barrier needed to prevent
   the harness itself from dropping calls. Use ordinary binaries for timing.
3. In separate diagnostic binaries, attribute construction, borrowed reads and
   destruction, and count payload allocations, allocator metadata and ownership
   operations. Require zero live payload after every call and after shutdown.
   Deliberately omitted frees/count operations must fail the appropriate check.
   Instrumented timings cannot stand in for production timings.
4. Record whole-process elapsed/CPU time, maximum resident memory, executable/code
   sizes, and compiler stack reports. At declared checkpoints record process
   virtual and resident storage separately from requested payload and allocator
   metadata. Do not relabel virtual size or requested bytes as committed memory.
   Identify any memory or Rust stack field the available tools cannot establish.
5. Publish the complete execution schedule, repeat counts, host/toolchain rules,
   identical-copy controls, statistic and treatment of unstable observations
   before starting the four sessions: two each on Linux ARM64 and AMD64.
   Every measured language needs its own identical-copy control. Keep all raw
   outputs, durations and failed observations, and independently reconstruct the
   report. Set later optimization budgets from these baseline results.

The next action is to implement and verify the peer programs and harness work
boundaries. This preparation does not authorize an unchanged numerical rerun,
change D2/N1 limits, or complete the other B1 comparisons.
