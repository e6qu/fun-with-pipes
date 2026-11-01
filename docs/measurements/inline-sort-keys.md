# Keeping sort keys together

A4 is verified in [PR #220](../roadmap-history.md#temporary-record-owners-and-sort-keys-pr-220),
including all 13 allocation/count comparisons, independent artifact audits,
repeated timing and the full production/documentation/analysis gates. It extends
[the scalar-read and sort-callback batch](sort-key-ownership.md).

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

## Observed allocation and binary costs

The [complete report](inline-sort-keys-2026-10-27.json) retains source
`dfd844c1209bb75dc7829bd4fa44f2f50d93a7bb`, measured in `40510702844` and audited
in `40512399031`. The declared reductions pass exactly on both hosts: 256/4,096
fewer allocations and effective retains, and 2,032/32,752 fewer requested bytes.
Peak managed bytes and all count-metadata observations remain unchanged. Both
sizes finish with zero live managed bytes; the other 12 fixtures retain their
exact budgets. Removing short-lived keys does not reduce the program's peak,
which occurs elsewhere.

| Word-frequency binary | A3 baseline | A4 candidate |
|---|---:|---:|
| AMD64 executable | 77,128 bytes | 72,560 bytes |
| AMD64 `.text` | 39,154 bytes | 36,194 bytes |
| AMD64 `main` frame | 128 bytes | 128 bytes |
| ARM64 executable | 78,568 bytes | 78,128 bytes |
| ARM64 `.text` | 38,908 bytes | 35,596 bytes |
| ARM64 `main` frame | 160 bytes | 160 bytes |

These are actual ordinary executables and GCC frame estimates, not peak runtime
stack measurements. The initial new fixture failed before native execution
because two definitions lacked concrete signatures. Formatting and those
signatures were repaired; all six sort tests passed on both hosts in `40512388783`.
The 12 inline-key and six scalar-projection probe statuses/outputs per host were
audited, including deliberate missing-owner/free failures. Compiler/runtime code
did not change, so the passing measurements were audited rather than rerun.

## Required verification

The existing sort-callback target adds actual generated-kernel probes at GCC
O1/O2 with typed scalar arguments enabled and disabled. They check empty/singleton
inputs, integer limits, equal-key stability, live input aliases, physical storage
release, every scratch/output allocation failure and each callback entry failure.
Deliberately missing String release or buffer freeing must be rejected.
Source programs also compare raw interpretation with native output for newly
allocated key text, partial key failure and cancellation.

These controls and the complete production/documentation/analysis gates passed.
The retained allocation/count/binary observations and repeated sorting-time
results below complete this scoped A4 comparison. Preserve both kinds of evidence;
operation-count success alone is not a timing result.

## Sorting-time protocol

`inline-key-time` recompiles the retained baseline and candidate generated C with
the same native GCC O2 flags. It calls their actual word-frequency sort entries;
it does not reconstruct an allegedly equivalent implementation. The harness
builds 256 or 4,096 `(word, count)` records once, then checks exact sorted object
order against C `qsort`.

Counts have repeated values, so text breaks ties.
The timed loop performs 32,768 or 2,048 complete sorts respectively, including key
calculation, merge scratch, result-list construction and result release. Input
construction, the independent order check, process startup and printing are outside
the monotonic timer.

Physical live storage must return to its input baseline after
the loop and to its empty baseline after releasing input. This is fwp before versus
fwp after; C `qsort` is a correctness oracle and is not timed as a competing language.

Each sample is a fresh process pinned to CPU 1. Before running the candidate,
two sampling sessions each take two warmups and six alternating pairs of executions
of two byte-identical baseline binaries. The budget is `1 + 2E`, where E is the
largest absolute deviation of a baseline-copy/baseline ratio from 1.

The factor 2
allows observed noise on both sides of a comparison. A control ratio deviation
over the explicit 10% noise limit rejects the experiment; it does not widen the
budget. The budget is saved before any candidate timing is observed.

Two subsequent sessions use the same warmups and six alternating baseline/candidate
pairs. Each session's median candidate/baseline ratio must stay within the frozen
budget. A ratio below 1 means less time for the candidate; above 1 means extra time.
Retain every pair, sources, binary hashes, compiler/CPU identity and failures.
These sessions share a runner. A separate repeat on another runner allocation is
required before treating the result as a repeatable B1 budget; a single run is
only the named same-runner observation. General CPU budgets remain separate.

The [first timing session](inline-sort-key-time-initial-2026-10-27.json), run
`40513939015` at `7da1a783`, used eight times fewer sorts per sample. ARM64 passed
both sizes; AMD64 passed 4,096 keys but rejected the 256-key noise control before
running that candidate. One identical-code pair took 109.47 versus 123.40 ms, a
12.7% difference above the declared 10% limit. The revised workload lengthens
both batches eightfold; it keeps the same timer scope, inputs, sampling order and
noise limit. The rejected samples remain evidence, not a performance result.

## Repeated timing observations

The [complete timing report](inline-sort-key-time-2026-10-27.json) retains two
independent runner allocations per architecture: `40514452443` and `40516778004`.
Both passed the unchanged noise limit and frozen budgets. Independent inspection
verified the binaries, every sample pair and each budget saved before measurement.

| Runner allocation | Keys | Candidate/baseline median ratios, two sessions | Maximum control deviation |
|---|---:|---|---:|
| 40514452443 / AMD EPYC 7763 64-Core Processor | 256 | 0.5037, 0.5028 | 5.31% |
| 40514452443 / AMD EPYC 7763 64-Core Processor | 4096 | 0.5130, 0.5123 | 3.06% |
| 40514452443 / Neoverse-N2 | 256 | 0.4856, 0.4861 | 1.27% |
| 40514452443 / Neoverse-N2 | 4096 | 0.4863, 0.4846 | 1.40% |
| 40516778004 / AMD EPYC 9V45 96-Core Processor | 256 | 0.5571, 0.5571 | 4.86% |
| 40516778004 / AMD EPYC 9V45 96-Core Processor | 4096 | 0.5366, 0.5363 | 5.39% |
| 40516778004 / Neoverse-N2 | 256 | 0.4856, 0.4862 | 0.57% |
| 40516778004 / Neoverse-N2 | 4096 | 0.4858, 0.4857 | 0.90% |

The isolated sort and cleanup took about 49–56% of the previous fwp path's time
in these observations. The AMD64 allocations used different EPYC models; each
ratio compares programs on the same runner. This does not measure whole-program
speed or overhead relative to C/Rust. The initial rejected short control remains
linked above. Full platform delivery is recorded in the linked history.
