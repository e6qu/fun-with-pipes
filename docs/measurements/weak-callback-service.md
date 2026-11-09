# Callback service comparison

**Correctness fixtures prepared; native runner verification and measurements remain open.** This is the application-shaped
part of the [weak-registration comparison](ownership-peers.md#weak-registrations).
[Reference-operation timings](weak-operation-time.md) exclude queue handling and
callbacks; their results must not be presented as service throughput.

## Matched work

Use a serial, in-process service. A pending message owns an array of 16 integers
and a weak reference to its receiving target. Message `i` contains integers
`i` through `i + 15`; their sum is `16*i + 120`.

1. Create one receiving target and a FIFO queue of 64 or 4,096 pending messages.
2. Consume pending messages in order. A cancelled entry releases its payload and
   weak link without entering the callback. An expired target also rejects entry.
3. A successful callback acquires a strong owner, sums the payload, and transfers
   the payload into the target's receiving queue before releasing the acquired
   owner. That queue has room for the complete batch, so delivery never blocks.
4. After dispatch ends, drain accepted payloads and independently count/sum them.
   These results must match the callback results. Release the target and remaining
   registrations/payloads before the batch returns.

| Case | Deterministic behavior | Expected calls / received messages |
|---|---|---:|
| Successful delivery | Every target lookup succeeds | N |
| Cancellation | Cancel indexes divisible by four before callback entry | N − ceil(N/4) |
| Expired registration | Release the target before beginning dispatch; pending messages keep only weak links | 0; N expired lookups |
| Callback error | At index floor(N/2), deliver the payload, then return a handled error; discard all remaining pending messages | floor(N/2) + 1 |

Track calls, cancellations, expiration, handled errors, sent/received payloads and
both checksums independently. For the error case, with K = floor(N/2)+1, each
checksum is `8*K*(K-1) + 120*K`. Skipping an enqueue must fail the receiver check;
matching a checksum computed before delivery is insufficient.

## Representations and ownership

- fwp uses `Channel[Array[I64]]` and `WeakChannel[Array[I64]]`. Its receiving queue
  is the actual runtime channel; the pending queue is an ordinary fwp collection.
- C explicitly owns the target, weak metadata, payload arrays and queue storage.
- Rust uses `Rc`/`Weak`, ordinary owned arrays/vectors and `Result` for callback
  errors. Do not add a `Box` to make its representation resemble another peer.
- Swift uses a native class, weak fields, arrays and a thrown callback error.

Each target implements the same receive/drain work using its ordinary serial
storage. Record queue layouts and copying differences. fwp's scheduler/channel
operations and Swift's runtime synchronization are included costs, not isolated
ARC overhead. This is not a network benchmark, parallel dispatch or a promise of
identical internal algorithms.

The existing lifetime controls remain prerequisites: acquired ownership across
callbacks/reentry, outside-owner release during a callback, cancellation and
error cleanup. The new programs contain real missing-delivery controls for all
four languages and omitted-payload/registration-release controls for C.
Verify raw/optimized fwp interpretation and native
O1/O2 behavior, ordinary errors and cleanup before timing. Use separate observers
for allocations/live storage and ordinary execution for timing.

## Prepared checks

[`weak_callback_service.fwp`](../../tests/fixtures/weak_callback_service.fwp),
[C](../../tests/fixtures/weak_callback_service.c),
[Rust](../../tests/fixtures/weak_callback_service.rs) and
[Swift](../../tests/fixtures/weak_callback_service.swift) each report all eight
size/case combinations. For 64 messages, success delivers 64 payloads totaling
39,936; cancellation delivers 48; the handled-error case delivers 33 totaling
12,408. Expiration delivers none. The receiver reads the stored arrays, rather
than accepting the callback's checksum as its own result.

- [The runner](../../scripts/check-weak-callback-service.py) builds C/Rust/fwp
  at O1/O2 and Swift at `-Onone`/`-O -whole-module-optimization`.
- Each language also builds a real missing-enqueue variant. It must preserve
  callback counts while producing zero received messages and fail the ordinary
  oracle. C variants actually omit payload or registration release and must
  fail its live-allocation counters.
- fwp also runs ordinary/missing-delivery programs through raw and optimized
  interpretation. No new Cargo test target is introduced.
- The C fixture counts actual allocation/free calls. Rust checks that no other
  strong/weak registrations survive dispatch. Neither result establishes native
  allocator peak bytes or complete Swift/fwp physical release; those observers
  remain required before timing acceptance.

Local guarded O2 checks pass for Apple Clang, Rust and Swift, including every
native fault variant. These do not verify Linux GCC or the rebuilt fwp compiler.
The initial Swift Foundation import hit an installed SDK mismatch; the fixture
uses only the standard library and platform C module now, and both local Swift
variants pass. No SDK installation or resource limit was changed.

The pending collections differ: C uses a contiguous array of explicit owners,
Rust consumes a `Vec`, Swift clears consumed optional entries, and fwp folds a
list until error. C/Rust/Swift receiving queues use ordinary contiguous storage;
fwp sends through its runtime channel. Preserve these differences in cost reports.
The current C allocation counters make this a correctness build, not the final
ordinary timing executable.

## Collection, after correctness

Freeze the implemented sources and complete protocol before collecting results.
Time the whole batch—registration, both queues, callbacks, error handling and
release—plus complete-process execution. Report operations per batch and each
case separately. Do not call this an isolated weak-reference cost.

Use a retained C-only duration pilot, identical-binary copy controls and two
same-host sessions on native ARM64/AMD64, following the qualification rules of
[the operation experiment](weak-operation-time.md#frozen-collection-rules). Also
record allocations, peak/final live storage, ordinary RSS, compiler costs and
native images. Preserve failed/noisy controls; no unchanged qualification reruns.
The exact repetition cap and sampling counts must be fixed with the implemented
caller before the first timing run.
