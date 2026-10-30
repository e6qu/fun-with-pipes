# Direct construction of replacement and repeated strings

This protocol precedes implementation. The reference is
`f3eb507280e5a71083190ec1e26bbbdbe555dae8`, the application-validation PR head.
It extends [the current word-frequency baseline](wordfreq-current.md); it changes
no existing derivative or numerical-kernel timing limit. This is a proposed
experiment, not an accepted optimization.

## Source finding and proposed change

`replace` currently appends unmatched bytes and replacement text to a growing
`fwp_buf`, then copies that buffer into the result String and frees it.
`string.repeat` likewise appends the same source repeatedly before copying.
The buffer uses libc `realloc`/`free`; the result uses fwp's managed allocator.
The current managed profiles count the latter, not the temporary raw buffer.
Do not describe removal of that buffer as fewer managed allocations or less ARC.

Determine the result's byte length with checked arithmetic, allocate its String
once and write into that allocation. `replace` first counts non-overlapping
matches, then copies the unchanged spans and replacements. `string.repeat`
computes the product and fills the result directly. Keep the empty-pattern,
unchanged-replacement, absent-match and empty-repeat shortcuts. No source value
is mutated, so borrowed patterns, replacements and shared input aliases stay
valid without an additional uniqueness query or ownership operation.

The tradeoff is a second match scan for replacement. Test it against real input;
fewer copies or malloc calls alone do not prove faster execution. Use the
existing functions and calling contracts, with no new language syntax, primitive,
wrapper or global execution switch. Do not include join/list changes: evaluating
a lazy list twice would need a separate effect/lifetime proof.

## Correctness and storage requirements

Extend the existing text-transformation and string-size targets. Compare raw and
optimized interpretation with native production GCC/Clang at O0/O1/O2, and run
the existing WASI subset. Cover:

- Empty values, absent matches, identical replacements, adjacent/non-overlapping
  matches, longer and shorter replacement text, and matches at either end.
- Embedded NUL bytes and UTF-8 bytes; replacement stays byte-based.
- Source/pattern/replacement aliases, all three arguments identical, and shared
  results that survive further calls. Originals must remain unchanged.
- Repetition counts zero/one/many, empty source with the maximum count, checked
  size boundaries, and the existing trap/cancellation cleanup controls.
- Exact raw allocation/release counts and managed owner/live-charge checks,
  including a deliberately omitted cleanup that the observer must reject.

Preserve the existing distinction between terminal buffer-size exhaustion
(diagnostic and exit 102) and the String header/terminator size check. Retain both
boundary outcomes and their order. An allocator failure remains terminal; do not
claim that this change makes OOM recoverable. Do not exhaust host memory to test it.

No temporary raw allocation may occur inside either candidate operation.
The result still needs one managed allocation when its current contract requires
one; unchanged replacement returns its existing owner. Managed requests, requested
bytes, effective retains, peak charge and final charge must remain at or below
the [current baseline limits](wordfreq-current.md#limits-for-the-next-word-frequency-candidate).
The word-frequency program does not call `string.repeat`; that function needs
separate correctness/allocation evidence and receives no application speed claim.

The input generator puts commas and periods on every fifth word. Source analysis
predicts 1,640 temporary replacement-buffer allocations at 4,096 words and 26,216
at 65,536 words in the reference. Verify those counts with separate instrumentation;
these are targets, not measured facts. Also retain raw requested/peak/live bytes,
separately from managed charge and whole-process RSS.

## Paired measurement fixed before implementation

Use the same two inputs, qualified CPUs, toolchains, flags, whole-process timing
boundary, warmups and sample counts as the current baseline: two independent
sessions per architecture, two warmup rounds and sixteen measured rounds, with
64 fresh processes per label per round. Keep seed 20261030 and the balanced
four-label cycle. Retain every complete output, exit status, command and timing.

Build one candidate compiler. Produce reference C by restoring exactly the two
original runtime function bodies in its generated C, rejecting any other changed
source. Build both versions with the same native compiler/settings. No application
build depends on a previous fwp compiler. Preserve both generated sources and
the exact reference patch.

Each session has two explicitly named comparisons:

1. Candidate versus reference: reference, reference copy, candidate, candidate
   copy occupy the existing cycle's C, Rust, fwp and fwp-copy positions respectively.
2. Context against peers: C, Rust, candidate and candidate copy occupy their
   original positions. Keep the C/Rust sources and output oracle unchanged.

The copies must be byte-identical, with equal-length executable paths. Keep all
observations from both comparisons; their clocks and medians are separate.
Do not pool them or treat repeated processes as independent host sessions.
Both reference and candidate copy controls must pass in every paired session.

Apply the already published limits: symmetric copy/regression limits of 5% for
4,096 words and 1% for 65,536; at least 5% lower large-input time in all four
paired sessions, with no small-input regression beyond its limit. A separate
small-input speed claim needs at least 10%. Failed or inconclusive results remain
visible; do not rerun unchanged measured sessions or change these thresholds.

Inspect actual native headers, image hashes and section sizes. Allow at most
4 KiB additional text and 1 KiB additional readonly data per candidate image;
these cap the cost of replacing two buffer-building functions. Report every GCC
frame change. Introduce no recursion or dynamic stack allocation; no existing
reported frame may grow by more than 256 bytes, and the largest frame must not
grow. These are representation tradeoff limits, not runtime speed evidence.

Publish the complete focused evidence, then group the change with its tests and
documentation in the next PR after application validation. Run the full final-head
matrix once the group is ready. Preserve PR #228's running head meanwhile.
