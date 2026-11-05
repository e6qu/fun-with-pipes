# Reuse private neighboring-record storage

Contract frozen before implementation. Parent PR #259 remains in final CI at
`e3a2e1d34eaa9364ff22273ed10fef7afb98204e`. Require its verified merge before
publishing another PR or collecting new native measurements. No parent pass is
claimed here. See the [allocation census](gradient-call-census-2026-11-05/README.md#remaining-storage).

## Program and intended change

The derivative pipeline first records N input values as numeric (value, node-id)
records. It then maps neighboring records to N-1 numeric records and folds those
results. The current compiler allocates two buffers; the first becomes dead
immediately after the neighboring-record map.

For equal-width, pointer-free records, reuse that first buffer for pair results.
At iteration i, read original records i and i+1 completely, call the worker,
then overwrite record i. The following iteration reads original i+1 and i+2.
Finish every input callback before any pair callback, and every pair callback
before any fold callback. Preserve both pair orientations.

## Ownership and implementation boundary

- Retain the existing private-producer/single-consumer proof and its rejected
  alias, escape, nested-block, branch and resource cases.
- Change the internal pair helper to consume its sole buffer. Update ownership
  insertion and borrow analysis together; the caller must no longer release it.
  No public syntax, legacy adapter or additional wrapper is needed.
- Select in-place storage only for equal-width supported numeric fields. Keep
  the ordinary allocating representation for other supported widths and the
  existing no-reuse test policy. Do not silently support boxed/owning fields.
- Protect the input owner before callback execution. Protect newly allocated
  output separately when needed. Finish with exactly one owner transferred and
  every other owner released, including trap/cancellation/allocation failure.
- Shrink the logical length only after successful pair mapping. Physical release
  uses allocator metadata, not the shortened logical length; verify that charged
  bytes return to baseline. Empty and one-record inputs produce zero records.
- Keep stack/inlining growth and analysis work bounded; use the existing field
  layouts rather than constructing transient heap records.

## Controls before measurement

1. Both orientations, empty/one/two/many inputs, equal and different widths.
2. Signed/unsigned ordinary integers, F32/F64, signed zero and NaN bit retention;
   unsupported wide or owning fields remain outside selection.
3. Raw interpreter, optimized native, unoptimized typed IR agree on values and
   trap order. Callback logs establish full producer -> pair -> fold order.
4. Retained aliases, repeated consumers, nested calls, branches and resource
   regions must reject the private rewrite; prior source values remain unchanged.
5. Trap and cancellation after partial overwrite release the actual owner once.
   Inject allocation failure in the allocating peer and later consumer paths.
6. Reuse enabled/disabled controls establish the intended count difference;
   an intentionally disabled ownership release must fail the cleanup observer.
7. Inspect emitted C and actual native images on focused Linux AMD64/ARM64 and
   macOS ARM64, using production compilers/settings. Run all grouped controls
   before one final production matrix, not a full gate after each edit.

## Predicted counts, not observed results

For the existing N>=3 Rosenbrock cases with U positive updates, the pair result
allocation is 16N-8 bytes/update. Eliminating it predicts U fewer requests and
(16N-8)U fewer requested bytes, without changing derivative raw buffers.

For a fresh 129-coordinate/199-update solve: 727 -> 528 requests and
1,034,366 -> 625,222 requested bytes. Zero-update counts must stay identical.
Record startup costs separately and validate phase totals, repeated solves,
peak charged storage and final zero storage with workspace reuse on and off.
Do not infer process RSS or speed from traffic savings.

## Runtime and compiler measurements

Freeze source/reference construction and all settings before collecting anything.
Use the established complete-solve cases, two qualified native sessions per
architecture, identical executable-copy controls, process output and cleanup,
and explicit equivalent-work limits for comparisons against C/Rust.

Keep earlier misses open under their original reference. Review zero-update
source and driver independently: positive-update buffer reuse cannot explain its
current slowdown. Do not drop samples or rerun unchanged sessions for a pass.
Use all six complete-solve inputs, current/history forms and workspace reuse
settings from the [gradient-call protocol](gradient-call-storage.md#bounded-selection-comparison-and-checks).
Two qualified sessions per ARM64/AMD64: two warmups, 98 balanced rounds of seven
processes per sample. Require 5% faster long solves, no slowdown above 2%, and
identical-copy variation at most 2%. Use its seven compiler inputs and 48
scheduled compilations each; time/RSS growth at most 5%, frame growth at most
128 bytes. Require no increased overall peak managed storage, unchanged raw
storage and zero final managed/raw storage. Report phase peaks, RSS and code size.

Construct a same-source reference disabling only in-place pair storage through
one internal selection constant. Both sides keep the consuming helper contract,
its cleanup, previous optimizations and all correctness repairs. This measures
reuse within that contract, not a replay of the parent compiler. Require the
allocating reference's counts to match the audited parent before timing. Test
missing/duplicate/altered edits; audit older comparisons reading changed files.

The accepted policy permits verified reductions with missed timing goals left
explicitly open; it does not relax thresholds. Final delivery requires all nine
production jobs and docs, full logs audited, one-line squash subject <=80 chars
and an empty body.


## Ownership details and live-memory limits

Change the existing private helper rather than adding a wrapper/body variant.
`packed_inputs::Index::consumer` removes the accepted aliases before owner
insertion. Update `Body::PackedRecordPairs`, `rc::consumes_arg`, borrow inference
and C emission together. Protect the input before checked sizing/allocation.
Equal-width results reuse it; other widths allocate and release the consumed
input. Keep both paths covered with the explicit no-reuse policy.

The fresh, sole-use proof may eliminate a runtime uniqueness query only after
checking every emitted helper call transfers the original owner without a retain,
escape or view. Do not infer this merely from the helper being native-only.

The reused allocation physically keeps N records, while its logical result has
max(N-1,0). With two-word records, 16 extra bytes can remain live during the fold
compared with a separately allocated result. Keep that physical charge until
release; measure phase and whole-pipeline peaks. Empty/one-record cases also
retain original capacity until consumption. No claimed RSS saving from counts.

Update existing `packed_input_windows` observers together with ownership. A reused
identity is freed once; two allocated identities are freed separately. Inject
pair-allocation failure in the no-reuse/different-width path. Preserve partial
overwrite, between-stage and fold failure/cancellation, plus deliberately broken
release and extra-allocation controls checked by the independent physical ledger.

Example: produce [(10,0),(20,1),(30,2)] completely. Read entries 0/1 before
writing result 0; read still-original entries 1/2 before writing result 1.
The fold starts after both writes. Reversing callback arguments never reverses
the write loop; backward writing would corrupt an input needed next.
