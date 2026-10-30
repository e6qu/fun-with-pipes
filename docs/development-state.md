# Current work

**Next:** run and audit the complete final-head production, documentation and G2
checks for [PR #229](https://github.com/e6qu/fun-with-pipes/pull/229), then
squash-merge only after every required gate passes. The byte-search candidate now
qualifies all four measurement sessions; final platform coverage is the remaining
delivery gate. Preserve that final head while gates run and audit all failures
before any repair push. Continue PLAN.md after the verified merge.

## Latest delivery: PR #228

[PR #228](https://github.com/e6qu/fun-with-pipes/pull/228) is squash-merged as
`667e71f0`, with exactly the verified tree from `f3eb5072`. All nine production
jobs, documentation and both G2 hosts pass with complete log audits. The Intel
Mac retry repaired the upload failure without a source change. The
[delivery record](roadmap-history.md#directory-cleanup-and-current-application-costs-pr-228)
owns identities, counts and evidence; the squash message is one line with no body.
The duplicate post-merge production run `41038555626` was cancelled after checking
tree equality and no failures. Post-merge documentation `41038555557` passes.

Integration `91641947` joins main into the preparation without changing its tree,
preserving all measured ancestors. PR #229 bundles string implementation,
correctness controls, rejected experiments and reproducible measurements. Keep
it draft only until this final evidence/documentation batch is published; then
mark ready to start the complete matrix.

## Current branch

Worktree `/private/tmp/fwp-direct-string-results`, branch `direct-string-results`.
The [string report](measurements/direct-string-results.md) owns all three
protocols, fixed acceptance limits, source reasoning and retained measurements.

## Qualified byte-search candidate

Protocol `7f58e4d9` precedes implementation `afbafef8`. Frozen branch
`byte-search-measurements` retains that source. Focused GCC run `41038341027`
passes 18 integration tests, 224 library tests and 20 runner controls; full logs,
162 saved probes and 30 native headers/hashes are audited. Earlier candidate
native/WASI checks do not substitute for final coverage of this changed code.

Runs `41039113227` and `41040046127` qualify all four timing sessions. Large-input
candidate/reference is 0.835227583/0.836369481 on ARM64 and
0.811291891/0.808484225 on AMD64: 16.4–19.2% less elapsed time. C ratios remain
2.079–2.083 and 2.420–2.437; Rust ratios are 1.594–1.601. Short ARM cases do not
meet the 10% speed-claim threshold. One small AMD copy control reaches 1.049393
against 1.05; keep that limitation visible.

All sessions confirm 12,513/199,721 managed requests, 431,876/6,909,092 requested
bytes, zero temporary raw allocation, unchanged retains/peak and zero final
charge. Code grows 560/512 bytes; replacement stack changes +16/−16 bytes on
ARM64/AMD64. Largest frames and readonly data are unchanged. See the
[report and full archive](measurements/direct-string-results.md#current-result-byte-search-with-unique-storage)
for all 74,040 observations, native images, profiles, outputs and logs. Two
unmeasured 9V74 assignments were rejected before building; both remain recorded.

Guarded local checks pass: seven small Clang allocation/evidence tests, 144 exact
size/control exits at O0/O1/O2, formatting, Python syntax, workflow lint and
roadmap/whitespace checks. All 28 retained-evidence rejection tests pass for each
of the three experiments. Eight stricter allocation-budget audits pass for the
unique/byte-search archives; original counts correctly fail those budgets.
The explicit `--decision passing` audit passes all four byte-search sessions and
rejects a faithfully recorded timing failure. Documentation CI now enforces these
acceptance checks, not just record integrity. No local full build or benchmark ran.

The draft documentation run `41039452266` at `fcec91ef` passed with a complete
log audit. New final-head gates must run after this evidence batch. Their IDs and
live statuses belong in the PR while its source is frozen; record them in the
next delivery entry after merge. The primary checkout's recovery handoff also
tracks dispatched jobs without changing the PR source.

## Retained experiments and remaining gaps

| Experiment | Source | Preserved outcome |
|---|---|---|
| Direct construction | Protocol `e0fb1a09`, runtime `089465bb`, measurements `8da8f4cf` | Four rejected timing sessions; [complete archive](measurements/direct-strings-first-artifacts-2026-10-30.json) |
| Unique replacement | Protocol `ebd8f46d`, source `d7c60989` | Four rejected timing sessions despite confirmed allocation savings; [complete archive](measurements/string-reuse-artifacts-2026-10-30.json) |

Both earlier candidates pass six-host native and both-host WASI checks with
complete log audits. Sources and runs remain in the report; the [native direct](measurements/direct-strings-native-2026-10-30.json)
and [native unique](measurements/string-reuse-native-2026-10-30.json) archives retain
954/972 probe executions and 162/180 native headers respectively. These results
are evidence at those sources, not final coverage of the byte-search candidate.
Frozen branches `direct-string-measurements` (`8da8f4cf`) and
`unique-string-measurements` (`d7c60989`) preserve measured ancestry. Do not retry
unchanged timings, relax budgets or turn faithful rejected evidence into acceptance.

D2's zero-update ratio remains **1.022815765 > 1.02** in `40912773534`; N1's
small-array inclusive copy control remains **1.030786192 > 1.02** in `40951090783`.
The [timing report](measurements/timing-variation.md) preserves every observation.
Their causes are unresolved; a user merge does not waive performance requirements.
The original Intel compiler abort also remains unexplained. Preserve its
[report](measurements/compiler-abort.md) and diagnose any recurrence from source.

The primary checkout is detached at #209 with a recovery handoff and untracked
compiler-abort report; preserve both. Full builds/suites/measurements belong on
GitHub. Local checks stay serial and guarded. Require nine exact-head production
jobs, documentation and G2 before merge, with complete log audits. Squash with
one subject of at most 80 characters, an empty body and no attribution/trailers.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain F1–F3's stated call and recursion scope |
| 4 | Verified | Preserve delivered decimal cost reduction and recorded loop gap |
| 5 | In progress | Resolve D2's zero-update timing requirement |
| 6 | In progress | Resolve N1's inclusive array control; investigate computation cost |
| 7 | In progress | Broader B1/B2 comparisons |
| 8 | In progress | Deliver qualified word-frequency changes; preserve #228 directory coverage and finish V1/V2 |
