# Keeping sort keys together

This is the A4 implementation and its declared acceptance protocol. Validation
is pending; [the handoff](../development-state.md) tracks the active source.
It extends [the scalar-read and sort-callback batch](sort-key-ownership.md) before
that batch's full production validation.

The word-frequency program sorts `(word, count)` records using `(-count, word)`
keys. The previous path allocated one 24-byte key record for every distinct word.
The new path saves the two fields directly in a contiguous buffer. Each entry
is 16 bytes with 8-byte alignment. The sort still owns the saved String; removing
its owner would let the input or callback release text that comparisons need.

## Selection and lifetime

The compiler selects a known, uncaptured single-argument callback whose input
fields are `(String, I64)` and result fields are `(I64, String)`. Both must already
have the field-based calling convention, and the callback must consume its input.
Unknown callbacks, captures, different layouts and borrowed-worker conventions
keep the existing sort path. This adds no language syntax or runtime promotion.

The input list stays alive throughout sorting. Before calling the existing worker,
the kernel retains the input String field. The worker consumes that owner, including
when its entry tick interrupts execution. Each fully returned key transfers its
String to the initialized prefix of the key buffer. Failure releases only that
prefix and every allocated scratch buffer. Output-list construction starts after
all keys and merge scratch have been released.

Stable merge compares signed integers without subtraction, then compares Strings.
Equal keys retain source order. Scratch copies borrow the main buffer's owners;
these comparisons neither call user code nor suspend. No scratch address escapes.

## Declared cost budget

Compare all 13 fixtures against [the retained A3 measurements](sort-key-ownership-2026-10-27.json),
source `a44ed18ee72301fd9363ef934596064b55eb751f`. Keep the same programs, inputs,
native Linux AMD64/ARM64 hosts, GCC flags, three observations, output oracle and
independent allocation/site observers. This protocol measures generated programs;
it does not build with an older fwp compiler.

For D distinct words, require D fewer allocations and D fewer effective retains.
Removing D 24-byte boxes while widening two scratch lanes by 8(D+1) bytes changes
requested bytes by exactly `16 - 8D`. Require no increase in peak managed bytes
or requested/peak/final count metadata, and zero final managed bytes. Metadata
layout and initial state must remain unchanged. The saved String owners remain.

Compared with A3, require these operation reductions:

| Operation | Attempts removed | Effective operations removed | Last-owner results removed |
|---|---:|---:|---:|
| Initialize count | D | D | 0 |
| Retain | 2D | D | 0 |
| Release | 3D | 2D | D |
| Test last owner | 2D | D | 0 |
| Free record | D | D | 0 |

Other operation totals are unchanged. All other fixtures retain their exact
operation/memory budgets. Record binary size, executable section size and each
function's stack-frame estimate separately; fewer counts do not imply smaller
code, less stack or faster execution.

## Required verification

The existing sort-callback target adds actual generated-kernel probes at GCC
O1/O2 with typed scalar arguments enabled and disabled. They check empty/singleton
inputs, integer limits, equal-key stability, live input aliases, physical storage
release, every scratch/output allocation failure and each callback entry failure.
Deliberately missing String release or buffer freeing must be rejected.
Source programs also compare raw interpretation with native output for newly
allocated key text, partial key failure and cancellation.

Before A4 is complete, retain the observed allocation/count/binary results, measure
sorting time against the same-host A3 implementation with an identical-code noise
control, and pass the full production, documentation and analysis gates. Timing
needs the B1 protocol; operation-count success alone is not a timing result.
