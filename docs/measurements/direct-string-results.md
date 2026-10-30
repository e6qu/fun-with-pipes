# Direct construction of replacement and repeated strings

Protocol `e0fb1a09` preceded implementation `089465bb`. The reference is
`f3eb507280e5a71083190ec1e26bbbdbe555dae8`, the application-validation PR head.
It extends [the current word-frequency baseline](wordfreq-current.md); it changes
no existing derivative or numerical-kernel timing limit. The first candidate is
rejected by the timing rules below. A second candidate is specified at the end
of this report before its implementation. Neither has timing acceptance.

## Source finding and proposed change

The reference `replace` appends unmatched bytes and replacement text to a growing
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

## Implementation and checks

`089465bb` implements direct construction without changing primitive contracts.
Focused run `41021988225` passes all six native targets at O0/O1/O2: 18 integration
tests per host, plus 224 library tests and 20 runner controls on GCC AMD64. Full
logs and 954 saved boundary/cleanup executions are audited. The
[native evidence archive](direct-strings-native-2026-10-30.json) retains every
source, output, status and complete job log. All 162 inspected probe images have
the expected native architecture headers and recorded hashes. Those headers and
identities are retained locally; full images remain in the named GitHub artifacts.
An expired artifact would limit later inspection of those original binaries.
This is correctness evidence, not a performance decision. WASI `41023744074` and
the paired measurements at `8da8f4cf` (run `41024798466`) remain outstanding.

The runner is [measure-direct-string-results.py](../../scripts/measure-direct-string-results.py).
[The source/count/acceptance checks](../../scripts/direct-string-evidence.py)
restore only the two frozen bodies and keep managed and raw profiles separate.
[The independent observation audit](../../scripts/check-direct-string-results.py)
checks all 18,510 subprocess records per completed session, including exact
commands, outputs, order, code identities and recomputed decisions. Timing failures
still produce a full report and receive integrity checks. A passing integrity
audit means the result is faithfully recorded; it does not turn a failed timing
or memory limit into an accepted optimization.

## First candidate: rejected measurements

Run `41024798466` measures source `8da8f4cf`. Three completed sessions have full
output/profile/size/stack records and pass all seven evidence-rejection tests.
The large-input ratios below compare the candidate with the original runtime;
at most **0.95** is required in every session. A value above 1 means slower.

| Session | Large-input candidate/reference | Decision |
|---|---:|---|
| ARM64 1 | 0.990359573 | Only 0.96% faster; misses the required 5% |
| ARM64 2 | 0.992313087 | Only 0.77% faster; misses the required 5% |
| AMD64 2 | 1.013587760 | 1.36% slower; also exceeds the 1% regression limit |

The AMD64 first session has not measured yet. Two assignments were rejected
before building/timing: EPYC 9V45 in `41024798466`, then EPYC 9V74 in
`41028913571`. Replacement `41031097803` retains the same source through branch
`direct-string-measurements`. These rejections are retained, not discarded samples.
The completed failures already rule out overall acceptance; the remaining
session completes the declared observation set and cannot erase them.

The allocation prediction is confirmed in these three sessions: replacement
loses 1,640/26,216 temporary raw allocations, while all five managed counters
remain exactly unchanged. Raw requested bytes fall by 104,960/1,677,824;
this is cumulative allocation traffic, not peak or resident memory. Shared-input
semantics, cleanup, representation limits and the large-input copy controls pass.
The second match scan is additional work; these timings do not isolate its cost.

## Second candidate: reuse non-growing unique strings

This specification precedes implementation. Keep the original reference bodies,
input files, qualified CPUs, settings, two sessions per architecture, timing
schedule and all existing acceptance limits. Do not retry the first candidate
unchanged, relax the 5% gain or 1% regression rules, or claim its rejected results
as acceptance for the next code.

After finding a real match, a replacement whose byte length does not exceed the
pattern's may reuse the source allocation only if the existing ownership query
proves exactly one owner. Copy unmatched spans with `memmove`, write replacement
bytes and continue forward through the unread suffix. The destination never
passes that suffix, so the loop needs no sizing scan or temporary allocation.
Set the final length and terminator and transfer the existing owner to the result.
Shared/static inputs and growing replacements keep a separately allocated result.
This extends the rule already used by ASCII case conversion; it adds no syntax,
conversion, wrapper or claim that ownership queries are free.

Borrowed patterns/replacements can equal the consumed source. A pattern equal to
the source matches its entire contents at most once. A replacement equal to the
source is either growing or is caught by the unchanged-text shortcut. Test these
cases explicitly, with and without another owner, before relying on that reasoning.
Keep the cached pattern length during the copy and never alter unread source bytes.
No surviving alias may observe a mutation. Reject a deliberately removed uniqueness
condition through an alias check, not an incidental crash.

Require no result allocation for a changed, non-growing, uniquely owned input;
require the existing result allocation for shared/static/growing cases. Preserve
all earlier raw-buffer, byte/NUL/UTF-8, overflow, allocation-failure, cancellation
and missing-owner controls. WASI currently does not select native unique reuse;
it must retain correct results and physical reclamation without claiming this
native allocation saving.

For word frequency, source analysis predicts another 1,640/26,216 **managed**
allocations removed, giving at most 12,513/199,721 requests and
431,876/6,909,092 requested bytes. Verify these separate predictions. Retains,
peak charge and final charge keep their existing limits; final charge remains
zero. Keep raw requests at zero inside both operations. Report the added
uniqueness decision and all code/frame changes. Repetition receives no new
application timing claim. Full native/WASI checks and all four timing sessions
are still required before accepting the combined change.
