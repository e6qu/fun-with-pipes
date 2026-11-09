# Weak-reference operations: phase preparation

**Prepared, not verified; no timing result.** This is part of the
[ownership comparison](ownership-peers.md#weak-registrations). It measures a
successful or expired lookup separately from queue handling and callbacks.
For example, create one target, keep a weak reference, look it up 16 times, drop
the target owner, then try another 16 lookups. The expected counts are 16 live
results and zero live results after expiration.

## Work and representations

Each batch performs these six phases in order:

| Phase | Work |
|---|---|
| Target creation | Create the entire population of targets, with one owner each |
| Weak creation | Create one weak reference to each target |
| Live lookup | Visit every weak reference 1, 16 or 64 times; acquire/release any successful result inside the called function |
| Owner release | Release every original target owner, keeping weak references |
| Expired lookup | Repeat the same visits; all results must be absent |
| Weak release | Release every weak reference |

Caller slots are allocated once, outside the phases, and reused for each batch.
C/fwp use native handle arrays; Rust uses capacity-reserved `Vec` slots; Swift
uses initialized/moved pointer slots. Every phase includes its loop and separate
function calls. These are not isolated nanosecond costs of a runtime instruction.

| Implementation | Target and weak storage |
|---|---|
| C | A counted target; the first downgrade allocates separate weak metadata |
| Rust | Ordinary `Rc<Target>` and `Weak<Target>`; no extra `Box` |
| Swift | Native class and a native weak field in a struct |
| fwp | An actual empty `Channel[I64]` of capacity one and `WeakChannel[I64]` |

fwp currently has weak channels, not general weak boxes. Its target has channel
state, unlike the other targets; creation/release ratios therefore include that
representation difference. No queue message is sent. The fwp scheduler root is
initialized before phase clocks; that initialization remains in process time.
Rust retains the target's backing allocation after value destruction until the
last weak reference is released. C/fwp have separate metadata. Keep those costs
separate rather than adding a wrapper to make their layouts look alike.

The fwp adapter calls current generated owned entries. It retains a caller's
channel or weak owner before passing an owner into a consuming exported entry.
The other languages borrow those inputs. That entry cost belongs in the result;
the adapter does not replace the generated lookup with a C implementation.
Whether the generated `Some` result actually allocates remains a measurement
question. Source code alone does not establish its optimized cost.

## Correctness gate

[Native operations](../../tests/fixtures/weak_operation_peer.fwp),
[the entry adapter](../../scripts/weak_operation_source.py) and
[the checker](../../scripts/check-weak-operation-phases.py) prepare separately
compiled factories and callers without LTO. Native C/Rust use O1/O2; Swift uses
Onone/O. fwp emits O2 C, then uses the same native GCC levels as C. Every binary's
ELF architecture and hash are retained.

On each native Linux ARM64/AMD64 host:

- Check populations 1, 64 and 4,096, with 1/16/64 lookups and 1/16 batches.
- Check live and expired counts independently, so wrong results cannot cancel.
- Build actual inverted lookups and a backwards clock; require the specific
  result/clock diagnostic, not an arbitrary failure or crash.
- Reject malformed and out-of-range experiment arguments before allocating slots.
- For C/fwp, separately observe cleanup and deliberately omit the owner or weak
  release. Require the cleanup diagnostic. C tracks its logical target/metadata
  ledger; fwp compares managed live storage with its initialized-runtime baseline.
  Neither observer measures native allocator backing storage or process RSS.
- Compare the fwp source's live/expired result in raw and optimized interpretation.
- Repeat the existing queued cancellation/error checks and original-assertion
  Swift diagnosis in the same batch; retain every failed independent group.

The expected batch has 36 separate-module builds, 252 native checks and two
interpreter checks. Native Rust/Swift allocation release still needs the verified
allocator observer; a successful expired lookup test proves no such byte count.
ARC-operation counts remain unmeasured.

## Before timing

This batch verifies the caller; it is not a timing collection. Freeze the final
protocol and source only after these checks pass. The timing collector must keep
ordinary builds, a retained C-only duration pilot, two same-host sessions,
interleaved identical-binary copies, phase duration/noise qualification and every
failed observation. Report complete-process time, compilation time/RSS, native
images and frame evidence alongside phases. Do not subtract an estimated loop or
runtime overhead, or rerun unchanged samples to seek a favorable ratio.

Callback-service work is a separate program: owned queue payloads, cancellation,
callback errors and cleanup belong in its measured work. The existing
[queued lifetime checks](weak-queued-cleanup-2026-11-09/README.md) establish those
correctness obligations, but their assertion-heavy execution is not a service
performance benchmark. Address-reuse evidence and native storage observations
remain explicit requirements in the parent comparison.
