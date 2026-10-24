# Keeping known callback captures in local variables

A callback is a function passed to another function. A capture is a value already
supplied to a partially applied function, such as the array in `read-index array`.
If every use is a known `array.generate`, `fold` or `fold-right` callback, the
compiler can keep those captures in local variables without constructing a
function record. Capture expressions still run at their original binding.

For example, `read-index : Array[F64] -> I64 -> F64` can capture one array and
read a coordinate each time a generator supplies an index. Generation still
allocates its result array. Removing the callback record does not eliminate
necessary data storage. The [runnable boundary example](../../tests/fixtures/callback_capture_boundaries.fwp)
also reuses callbacks, stores one in a record, applies one normally and folds
empty lists. Those other uses retain the representation their lifetimes require.

Typed child-owner cleanup and lifetime barriers keep the captures alive through
allocating calls and release them during normal or exceptional cleanup. Aliases,
escapes, ordinary applications, resource scopes and recursive tail frames keep
their existing representation. This introduces no syntax or implicit conversion.
Disabling stack representations also disables this change.

## Numerical results

[Run 39816519529](https://github.com/e6qu/fun-with-pipes/actions/runs/39816519529)
passes on both Linux architectures at compiler source
`927c6b1852a69748ae613291d89774bb8ae31121`. All 132 native executable images
were independently inspected. The [raw record](callback-locals-2026-10-22.json)
contains samples, commands, profiles, sources, binary inspection and frame records.
The [adapter-only report](direct-call-entries.md) explains the preceding change.
This run includes both changes and compares against #197's borrowed-capture code.

The seven entries and six input cases use the same short-process protocol:
two warmups, 56 balanced samples, complete computation/output/startup/teardown,
and separate untimed memory observations. AMD64 used EPYC 9V74; ARM64 used
Neoverse N2. GCC 13.3.0 and Rust 1.99.1 use O2, baseline CPU settings, checked
integer arithmetic, no fast-math or floating contraction, and no Rust LTO.
The [original comparison](descent-peers.md) explains the objective and inputs;
[repeated-work results](descent-batches.md) explain differences in residual
computation, buffers, checked accesses and formatting. Ratios are complete
implementation costs, not isolated compiler overhead.

In the largest packed program, generated code has two flattened capture
bindings and one remaining generic entry (`loop-fn`). The adapter-only compiler
kept two entries. Text-section bytes fall further, from 34,418 to 33,570 on AMD64
and from 32,508 to 31,612 on ARM64. The table compares with the earlier #197
baseline. These sizes measure the ELF `.text` section, including padding; they
are not decoded instruction counts. Smaller code is the demonstrated improvement;
timings remain noisy.

The generator loop's static stack frame falls from 96 to 48 bytes on both
architectures. Saved prologues confirm GCC's frame records: AMD64 saves four
registers and reserves eight more bytes (plus its return address); ARM64 reserves
48 bytes. The program-entry frame remains 2,192 bytes on AMD64 and 2,224 on
ARM64. These are individual function frames, not total peak stack usage.

| Host | Coordinates-updates | Old text bytes | New text bytes | New / old | New / identical | New / C | New / Rust |
|---|---|---:|---:|---:|---:|---:|---:|
| x86_64 | 3-0 | 30418 | 22450 | 1.0429 | 0.9991 | 1.364 | 1.151 |
| x86_64 | 3-1 | 30498 | 22498 | 0.9632 | 1.0304 | 1.397 | 1.093 |
| x86_64 | 3-199 | 30498 | 22498 | 1.0810 | 1.0720 | 1.467 | 1.161 |
| x86_64 | 3-1999 | 30498 | 22498 | 1.0050 | 1.0132 | 1.379 | 1.159 |
| x86_64 | 33-199 | 35394 | 28066 | 0.9589 | 1.0087 | 1.633 | 1.351 |
| x86_64 | 129-199 | 41778 | 33570 | 1.3209 | 1.1746 | 2.929 | 2.394 |
| aarch64 | 3-0 | 30844 | 22476 | 1.0099 | 1.0063 | 1.362 | 1.128 |
| aarch64 | 3-1 | 30892 | 22524 | 1.0022 | 0.9894 | 1.372 | 1.126 |
| aarch64 | 3-199 | 30892 | 22524 | 0.9948 | 1.0074 | 1.389 | 1.132 |
| aarch64 | 3-1999 | 30892 | 22524 | 1.0140 | 1.0027 | 1.450 | 1.225 |
| aarch64 | 33-199 | 35292 | 27612 | 1.0187 | 1.0202 | 1.697 | 1.394 |
| aarch64 | 129-199 | 40172 | 31612 | 0.9962 | 1.0175 | 2.380 | 2.037 |

The largest managed profile remains 459 requests, 216,925 requested bytes,
zero retains and a 7,200-byte peak. Every packed case has zero retains and zero
final managed/raw storage. AD and list peers preserve allocation/request and
raw-storage profiles. No tracing collections occur in these ARC-only programs.

AMD64's largest new/old time is 1.3209, while byte-identical new copies differ by
17.5%. That slowdown cannot be attributed to the compiler from this run.
ARM64's largest case is 0.9962 of the baseline; its 33-coordinate identical
control differs by just over 2%. Preserve both slowdowns and failed controls;
no general speed improvement or C/Rust parity is established.

## Correctness acceptance

The array and fold checks compare interpreter/native output, assert the chosen
capture representation and retain stress, error/cancellation/order and deliberate
broken-cleanup controls. The new boundary fixture covers repeated/stored callbacks,
ordinary calls and empty input at O0/O2 with stack representations on/off in both
memory modes. The initial expanded native job exposed two invalid ARC test settings and a
right-fold probe that expected a now-removed adapter. The repair instruments the
actual borrowed body and preserves all cleanup assertions. The repaired change
shipped in [PR #198](../roadmap-history.md#local-callback-captures-and-repeated-numerical-work-pr-198)
after all nine production jobs and documentation passed. Final-head inspection
covered 480 native binaries and 816 execution observations; preparation failures
remain historical evidence, not passing checks.
