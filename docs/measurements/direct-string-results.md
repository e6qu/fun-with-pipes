# Direct construction of replacement and repeated strings

Protocol `e0fb1a09` preceded implementation `089465bb`. The reference is
`f3eb507280e5a71083190ec1e26bbbdbe555dae8`, the application-validation PR head.
It extends [the current word-frequency baseline](wordfreq-current.md); it changes
no existing derivative or numerical-kernel timing limit. The first candidate is
rejected by all four timing sessions. The second candidate reuses unique storage
under a protocol published before implementation; it also misses timing acceptance
in all four sessions. The third, byte-search candidate passes all four measurement sessions; final
production validation remains required before delivery. The sections below distinguish all three experiments.

## Current result: byte search with unique storage

Source `afbafef8` passes the predeclared timing, storage and representation limits
in four qualified sessions. This is measured qualification, not final platform
acceptance. [The complete archive](byte-search-artifacts-2026-10-30.json) retains
all 74,040 subprocess observations, source/native-image bytes, profiles and logs.

| Session | Large-input candidate/reference | Time reduction | Candidate/C | Candidate/Rust |
|---|---:|---:|---:|---:|
| ARM64 1 | 0.835228 | 16.48% | 2.0791 | 1.5944 |
| ARM64 2 | 0.836369 | 16.36% | 2.0831 | 1.6011 |
| AMD64 1 | 0.811292 | 18.87% | 2.4197 | 1.5962 |
| AMD64 2 | 0.808484 | 19.15% | 2.4366 | 1.6000 |

Each time covers process launch, reading, calculation, printing and cleanup.
The paired reference changes only the two frozen runtime function bodies; the
separate C/Rust comparison uses the same inputs and expected output. A ratio of
2.08 to C means about 108% extra elapsed time. These are complete application
comparisons with the [documented representation differences](../application-acceptance.md#word-frequency-comparison),
not isolated compiler overhead or parity with C/Rust.

Small-input candidate/reference is 0.9042/0.9216 on ARM64 and 0.8813/0.8534 on
AMD64. The ARM samples do not meet the protocol's 10% short-input speed-claim
threshold. One AMD identical-copy ratio reaches 1.049393 against a 1.05 limit;
retain that near-limit variation rather than making a general small-input claim.
All large-input copy controls stay within their 1% limit.

| Per process | 4,096 words/64 distinct | 65,536 words/1,024 distinct |
|---|---:|---:|
| Managed requests, reference → candidate | 14,153 → 12,513 | 225,937 → 199,721 |
| Managed requested bytes | 463,856 → 431,876 | 7,420,304 → 6,909,092 |
| Temporary raw allocation requests | 1,640 → 0 | 26,216 → 0 |
| Temporary raw requested bytes | 104,960 → 0 | 1,677,824 → 0 |
| Effective retains, unchanged | 4,362 | 69,642 |
| Peak managed charge, unchanged | 341,617 | 5,465,713 |
| Final managed charge | 0 | 0 |

Instrumented runs establish these counts separately from timings; they are not
C/Rust allocation comparisons. Both temporary raw peak/final bytes are zero in
the candidate. Fewer requests do not imply fewer retains or smaller peak memory.
Repetition has direct-construction correctness/storage checks, but this program
never calls it and supplies no repetition speed claim.

Instruction sections grow by 560 bytes on ARM64 and 512 on AMD64; readonly data
is unchanged. The replacement stack frame changes 144 → 160 bytes on ARM64 and
160 → 144 on AMD64. The largest frame stays 65,744/65,776 bytes respectively.
These are actual native section and compiler stack reports, not inferred register
counts or a claim that code size fell.

Runs `41039113227` and `41040046127` contain the four passing sessions. Two AMD
assignments received EPYC 9V74 and were rejected before building/timing; their
records remain archived. No measured session was retried. Full log audits and
28 evidence-rejection tests pass. Documentation CI both reconstructs the results
and explicitly requires passing timing and the stricter allocation budgets for
this archive; earlier rejected archives remain valid records of failed acceptance.

## C-library observer repair

The complete matrix at `3ddd989c` exposed two stale tests: their string observers
only recorded `fwp_str_new`, while repetition now constructs its result directly.
The input observer therefore missed one allocation; the result observer checked
an earlier string instead of the new result. Runtime behavior was unchanged by
the repair. The checks now observe direct construction too, preserve all generated
probes and include deliberate omission controls that reproduce the old failures.
Empty/nonempty inputs and zero/one/three repetitions cover both construction paths.

Source `d0ccb80f`, focused ARM Mac run `41047507000`, job `124035107898`, passes
17 tests in six summaries. Complete logs and all 26 saved probe executions/native
headers are audited; artifact `12973930046` retains the C, binaries and outputs.
The old complete matrix is still being audited and the combined repaired source
needs a new complete platform matrix. This focused result alone does not establish
GCC or other-platform acceptance.

## First candidate: direct result construction

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
This is correctness evidence, not a performance decision. Both WASI hosts in
`41023744074` pass 32 tests/four summaries with complete log audits. The paired
measurements at `8da8f4cf` reject the first candidate, as detailed below.

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

Runs `41024798466` and `41033950200` measure source `8da8f4cf`. All four sessions
have full output/profile/size/stack records and pass seven evidence-rejection tests
each. Complete logs contain no unaccounted compiler/test failures; every failed
job corresponds to its declared timing limits. The [retained archive](direct-strings-first-artifacts-2026-10-30.json)
reconstructs all 74,040 subprocess observations, source and native-image bytes,
profiles and full logs. Documentation CI rechecks the same rejected decisions.
The large-input ratios below compare the candidate with the original runtime;
at most **0.95** is required in every session. A value above 1 means slower.

| Session | Large-input candidate/reference | Decision |
|---|---:|---|
| ARM64 1 | 0.990359573 | Only 0.96% faster; misses the required 5% |
| ARM64 2 | 0.992313087 | Only 0.77% faster; misses the required 5% |
| AMD64 1 | 1.011793828 | 1.18% slower; also exceeds the 1% regression limit |
| AMD64 2 | 1.013587760 | 1.36% slower; also exceeds the 1% regression limit |

AMD64 session 1 also fails the small-input contextual identical-copy control:
1.071605080 exceeds 1.05. Its comparison cannot establish a small-input speed
claim. No failed session was retried. Three earlier CPU assignments were rejected
before building/timing: EPYC 9V45 in `41024798466`, EPYC 9V74 in `41028913571`
and Xeon 8573C in `41031097803`. All qualification records and logs are retained.
`41033950200` completed the missing session on the specified EPYC 7763 using
frozen branch `direct-string-measurements`; it does not replace a measured result.

The allocation prediction is confirmed in all four sessions: replacement
loses 1,640/26,216 temporary raw allocations, while all five managed counters
remain exactly unchanged. Raw requested bytes fall by 104,960/1,677,824;
this is cumulative allocation traffic, not peak or resident memory. Shared-input
semantics, cleanup, representation limits and the large-input copy controls pass.
The second match scan is additional work; these timings do not isolate its cost.

## Second candidate: reuse non-growing unique strings

Protocol `ebd8f46d` was published before this implementation. Native/WASI checks
pass, but all four timing sessions below reject its speed claim.
Keep the original reference bodies,
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


### Second-candidate checks

Source `d7c60989` passes all six native hosts in `41034212790`: 18 integration
tests/seven summaries per host, plus 224 library tests and 20 runner controls on
GCC AMD64. Complete logs are audited. All 972 saved probe exits/outputs and 180
native-image headers/hashes pass independent inspection in the
[retained native archive](string-reuse-native-2026-10-30.json). It stores every
source, output, status and full log; original executable images remain in the
named GitHub artifacts. Their expiry would limit later inspection of those images.

For example, `replace "," ""` removes commas: piping `"a,b,c"` through it produces
`"abc"`. If another value still owns `"a,b,c"`, that original must stay unchanged.
The tests cover both shared and unique inputs; removing the uniqueness condition
fails the alias observer with exit 233. Tests also compare interpreted and native
results for literal inputs, embedded zero bytes and UTF-8.

Both WASI hosts pass 32 tests/four summaries each with complete log audits in
`41034222459`. All four paired sessions at
`d7c60989` are complete: runs `41035137961` and `41036473750`. The
[second measurement archive](string-reuse-artifacts-2026-10-30.json) retains every
observation, source/native-image byte, profile and complete log.

| Session | Large-input candidate/reference | Decision |
|---|---:|---|
| ARM64 1 | 0.969173008 | 3.08% faster; misses 5% |
| ARM64 2 | 0.966967292 | 3.30% faster; misses 5% |
| AMD64 1 | 0.982461514 | 1.75% faster; misses 5% |
| AMD64 2 | 0.979854379 | 2.01% faster; misses 5% |

All other timing controls and code/frame limits pass. Managed requests are exactly
12,513/199,721 and requested bytes 431,876/6,909,092; raw allocation requests are
zero. Retains and peak charge stay at their original values; final charge is zero.
These savings are confirmed, but the combined acceptance rule rejects the candidate.
Complete logs and all 74,040 observations pass integrity audits, including seven
evidence-rejection tests per session. The 9V74 (`41035137961`) and 9V45
(`41036206051`) assignments were rejected before timing; both remain archived.

## Third candidate: use byte search for one-byte patterns

Protocol `7f58e4d9` was published before implementation. The one-byte search and
new high-bit/source-alias controls are implemented at `afbafef8`. Focused GCC
run `41038341027` passes 18 integration tests, 224 library tests and 20 runner
controls with a complete log audit. All 162 saved probes and 30 native image
headers/hashes pass independent inspection. Four measurements in `41039113227`
and `41040046127` qualify the frozen branch `byte-search-measurements`; the
complete final-head platform matrix remains required. Keep both earlier rejected experiments,
the original reference bodies, inputs, CPUs/toolchains, four-session schedule and
all existing timing, allocation and representation limits. Do not change the
required 5% gain or treat either earlier allocation saving as timing acceptance.

Before this candidate, `replace` called a general substring loop even for one-byte patterns.
The word-frequency application removes commas and periods: 8,192/131,072 calls
for the two inputs, confirmed by its raw operation counters. Counting only each
call's first search over the retained inputs gives 75,360/1,205,856 byte comparisons
in that source loop. This is a source-level count, not an instruction count,
profiled CPU time or proof that searching causes the whole performance gap.

When the pattern is exactly one byte, use standard C `memchr` for the first,
sizing and subsequent-match searches inside `fwp_p_replace`. Cache the pattern as
an unsigned byte after the empty-pattern return. Longer patterns keep the current
substring algorithm. This needs no public primitive, wrapper, setting or syntax.
The reference restores the old replacement body, so the changed search is part
of the paired candidate comparison; leave the general substring helper unchanged.

Preserve byte-based matching, non-overlapping replacement, embedded zero bytes,
and source/pattern/replacement aliases. Add high-bit byte and one-byte borrowed
source-alias controls. Retain the unique/shared/growing storage rules, allocation
failure and cancellation tests and all size-boundary exits. `memchr` must never
read beyond the valid remaining input, including the empty suffix after a match.

Final-head native/WASI coverage is required for the combined change. Fewer
source-loop comparisons alone are not success: all four timings must meet the
same published budgets, with code/stack and actual memory costs retained.
