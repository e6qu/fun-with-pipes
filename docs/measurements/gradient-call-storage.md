# Remove temporary storage around gradient calls

**Implementation is awaiting runner verification; measurements are pending.**
This contract precedes code;
its immutable tag is `roadmap/gradient-call-storage-protocol-2026-11-05`.
Starting source: verified squash `68115090b161f198e11fb625946259f65f781580`.
The [current allocation-site report](gradient-storage-2026-11-05/README.md)
identifies each cost. [PR #258's delivery](../roadmap-history.md#consumed-numeric-storage-pr-258)
keeps its four missed speed targets separate from this experiment.

## One group, four changes

1. Borrow the read-only gradient input through a known derivative scope.
2. Carry numeric fold seed/results in fields, with proved constant cached seeds unboxed.
3. Seed one backward root without singleton heap containers.
4. Reuse a consumed 64-bit derivative array for coordinate scratch.

Example: inputs [10,20,30] remain available while the scoped worker records its
objective. Its gradient array [2,4,6] scales to [1,2,3]. Once exclusive, that
array can temporarily hold [9,18,27] before those values enter the coordinate
list. All callbacks finish before list mutation; source values stay immutable.

## Scope borrowing

Select only a statically known, fully applied scope callback whose relevant
argument has a complete nonescaping read-only proof and an owner held by the
caller. Exclude unknown closures, exported/dynamically called workers, returned
or stored inputs, consuming uses, resource regions and recursive proof cycles.

The derivative worker currently has a word-valued signature (closure/list to
array), so it has no field ABI and is excluded by owned_entries as well as its
function-value use. Provide an explicit scoped direct calling convention; never
change an owned runtime entry into a borrower behind its argument-preparation
metadata. Remove a callee drop only together with the corresponding retain.
Borrow proofs may use explicit private-operation contracts, not the absence
of Consume (Share can retain). Keep AD admission, nested scopes, task cleanup
and tape retirement correct on normal return, callback traps and cancellation.

## Numeric fold

Only pointer-free numeric records whose selected callback already accepts and
returns direct fields qualify. Keep seed evaluation before the folded input
at its original call stage. Empty input returns the same numeric bits; callbacks
retain their count, order, tick/cancellation behavior and first trap.

A cached seed can become constants only after a bounded acyclic constant proof.
The current seed reaches concrete F64 prim.zero through nullary entries; whitelist
that scalar intrinsic explicitly alongside literal fields, preserving exact bits.
Do not execute arbitrary compile-time code or assume user-defined zero is pure.
Retain ordinary boxed behavior for other observable uses of the same cached
entry. Do not add a heap box to callers that only read the result fields.

## Explicit single-root seeding

Provide scalar-F64 and owned-weight peers under ReverseScalar, with an explicit
root and seed. Preserve F64 accumulation for F16/BF16/F32/F64 and typed F128/
nested-Rev arithmetic. Keep custom One evaluation at its existing call stage;
replace singleton construction without moving seed effects/traps.

Fixed local containers are permitted only through a proved borrowed, nonescaping
runtime call; no fabricated heap owner or runtime release of stack storage.
Scalar arrays and owned-weight list views need separate layout/aliasing proofs,
including callbacks, reentry and task suspension. Preserve inactive, mixed,
stale and out-of-range root behavior, representation/task checks, validation
before indexing, detached-tape cleanup and partial result cleanup. General
multi-root operations keep their current length and accumulation semantics.

## Consumed coordinate scratch

Require the array's last-use owner and exactly 64-bit pointer-free scalar
storage. Narrow/F128/child-owning layouts are outside this first proof. Check
ordinary-array status, runtime exclusivity and reuse policy; shared arrays and
views require independently owned scratch. Match shorter-input behavior in
both zip positions, and preserve callbacks before any list mutation.

Track the array owner separately from separately allocated scratch. Never free
an interior payload pointer. On every trap/cancellation/allocation failure,
release input array, remaining list and partial output exactly once. A shared
list ancestor excludes reuse of its complete suffix, even count-one descendants.

## Bounded selection, comparison and checks

Process original bodies once; cache selected entries by complete signature and
callback identity. Do not recursively specialize newly generated bodies or scan
every suffix for every call. Measure compiler elapsed time and RSS explicitly.

Freeze a same-source reference disabling exactly these four changes, including
the library single-root selection. Keep all previous reductions and correctness
repairs on both sides; test missing, duplicate and altered reference edits.

Before timing, require actual selection in both complete gradient forms and
exact per-site/whole-program counts for six inputs, current/history forms and
workspace reuse off/on. Initial prediction for one fresh N>=3/U>0 solve:
remove 7U+1 requests, (8N+128)U+24 requested bytes and 2U effective retains.
Zero updates remove nothing. Repeated shared-input solves need their own
reconciled formula, including cached initialization and first-list copies.

Test raw/optimized interpreters and GCC ARM64/AMD64 plus Clang ARM64 at O1/O2.
Include empty inputs, all supported float representations, exact NaN/zero bits,
seed order, effects, shared prefixes, views, overflow, failure/cancellation,
physical frees and deliberately broken observers. Check primitive inventory and
shard assignment. Bundle implementations before one focused runner group, then
allocation/compiler/runtime measurements and the final nine-platform/docs gate.

Use the [previous comparison protocol](owned-numeric-updates.md#comparison-and-acceptance):
six inputs, both result forms, workspace off/on for counts, two qualified timing
sessions per architecture, two warmups and 98 balanced rounds of seven processes
per sample. Long solves require 5% less time; no case may slow more than 2%;
identical-copy variation must be at most 2%. Keep seven compiler inputs with 48
scheduled compilations each, at most 5% compiler time/RSS growth and 128 bytes of
frame growth. Require no increased peak managed storage, unchanged raw tape
storage and zero final managed/raw storage. Report process RSS and code size.

Keep all prior misses separate. Verified reductions may ship with failed timing
goals explicitly open, under the accepted policy.
Freeze the exact reference, measurement workload, qualified hardware, flags,
schedule and predicted counts before any measurement; no unchanged reruns for
a passing result. Smaller request counts alone establish neither speed nor RSS.


## Review checkpoints

Before selecting scope borrowing, verify a direct call edge reaches the same
admission proof as `ad.scope2`; its callback must see an AD scope and its caller
must retain each borrowed owner through unwind. A word-valued worker needs an
explicit calling convention even when it has no numeric fields.

Before accepting count reductions, reconcile both fresh and repeated drivers.
For eight repeated solves, the one-time seed saving occurs once per process;
per-update savings occur eight times. Initial shared coordinates still require
the first list copy. Count existing seed conversion and output mapping separately.
The same-source reference must disable these four changes only. Test its edits
against missing, duplicate and altered source patterns before collecting timings.
