# Four languages with matched buffer boundaries

[Both native Linux jobs pass](https://github.com/e6qu/fun-with-pipes/actions/runs/42579398196)
at source `9850a0fda` (tag `roadmap/four-language-buffers-2026-11-09`).
ARM64 job `129034306146` and AMD64 job `129034306496` use GCC 13.3, Rust 1.99.1,
Swift 6.4.2 and fwp built from that checkout. No older fwp compiler is needed.
These checks establish equivalent results and a common harness boundary, not
elapsed-time, allocation or process-memory ratios.

## Same operation and barrier

A signed length creates the integers from zero through `length - 1`; negative
lengths mean empty. The operations compute length plus the first element, that
value plus length again, or a checked sum. At length 16 their results are 16,
32 and 120. Each repeat checks the result and adds it to a checked checksum.

All four programs call the same separately compiled C function before and after
each operation. It returns the argument through an optimization barrier. This
prevents the caller from replacing repeated calls with one constant result while
allowing normal optimization within an operation. It does not force array storage.
Link-time optimization is disabled. Original and prepared source hashes are kept.

fwp's emitted entry runs through the same C argument/checksum harness. Its array
size guard rejects impossible lengths before entry; that checks harness behavior,
not equivalence of language-level allocation failures. The compiler emits the
optimized fwp program once, then GCC builds it at O1 and O2. C/Rust also use O1/O2;
Swift uses Onone/O, not invented Swift O1/O2 settings.

## Results per host

| Check | Count | Result |
|---|---:|---|
| Native outputs and argument errors | 840 | Pass with exact status/stdout/stderr |
| Raw/optimized fwp interpreter outputs | 42 | Agree with the native oracle |
| Actual wrong-barrier executables | 24 | All reject altered results with status 4 |

Lengths include the minimum signed integer, -1, 0, 1, 16, 4,096 and 262,144;
repeat counts are 1 and 3. Argument tests cover malformed integers, invalid
entry names, impossible lengths and nonpositive repeat counts. Each fault build
uses the real external barrier returning one more than its argument; wrong values
must be rejected, not silently reported as a valid measurement.

The raw commands record 21 unoptimized and 21 optimized interpreter runs and
all deliberate nonzero exits. No crash or timeout stands in for an expected error.
Complete logs show no unexpected compiler/test diagnostic. Package setup warns
about an absent optional C++ manpage; compiler builds and every check pass.

## Evidence and remaining work

The ARM/AMD reports, compressed command records and full logs are beside this
page. Selected entries were fetched with ZIP CRC checks; no local full-archive
hash check is claimed. GitHub archives retain sources, native images and the
independent parser/weak checks from the same jobs:

| Host | Artifact | Bytes | GitHub SHA-256 |
|---|---:|---:|---|
| ARM64 | 13657027723 | 23,127,218 | `679a9ae0a6f7f6264e4d31c47f24e7c33c869579e1e1fb5a9f7eab4e17010bf4` |
| AMD64 | 13656808672 | 27,458,563 | `1361a3412f3279e500ed26eb37d778e8018463d68c710bec067326a45621c67f` |

These are complete-operation checks. A separately compiled factory returning a
live buffer, unique/shared storage phases and the frozen peer timing experiment
remain in the [comparison scope](../ownership-peers.md#buffers). Earlier noisy
or failed timing targets remain unchanged.
