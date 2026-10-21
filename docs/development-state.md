# Session handoff

## Next action

Next: verify the repaired scalar test fixture in [PR #182](https://github.com/e6qu/fun-with-pipes/pull/182),
branch `investigate-native-counting-costs`. The PR remains draft. Focused run
`39531898954` at `c46a4e582a5ecc715c1238b46547d0cba29f4507` failed on both Linux
hosts: the new test used unsupported named-argument definition syntax and failed
before exercising multiplication. It now uses ordinary tacit `curry`/`uncurry`
composition. Both complete logs are audited: all five integer-output tests, the
two existing scalar tests, binary inspections, measurements, formatting and
Clippy passed. Documentation `39531903399` passed. Receipt and script:
`/private/tmp/fwp-u32-counting-audit.json` and the matching `.py` path.
Publish the fixture repair, verify both focused hosts, then require all nine
production gates and documentation on that exact final commit.

The U32 repair uses unsigned 64-bit multiplication, where all U32 products fit,
then checks U32's maximum. The former signed intermediate could overflow before
that check. New dynamic-input tests cover U8/U16/U32 boundaries, trap/effect
order, unoptimized interpretation, ARC/tracing and O0/O2/O3 native code. UBSan
checks the emitted U32 primitive at O1/O2; restoring the signed intermediate
must trigger its overflow diagnostic. Native verification of the new test is
still pending. Existing scalar tests now fail when their C compiler is missing
instead of silently skipping, and the U64 sanitizer executable has an explicit
Windows suffix. The focused workflow collects both test targets even if one fails.

Superseded production `39529772529` at `080b0ff6` was cancelled for this repair.
The benchmark and documentation `39529569466` passed. Available logs show no
test failures beyond cancellation; Linux AMD64 never received a runner. Audit:
`/private/tmp/fwp-audit-182.py`; receipt: `/private/tmp/fwp-182-acceptance.json`.
This superseded head is not accepted and must not be merged.

After acceptance, squash-merge with an explicit one-line subject of at most
80 characters and an empty body, without trailers or attribution. Verify the
merge tree and message; cancel duplicate post-merge CI only after proving it
checks the accepted tree. Standing authorization applies.

Independent next-step preparation is in `/private/tmp/fwp-integer-range-probe`,
branch `investigate-integer-range-information`, source
`7a8803762e240998605c6442afbbb33ed8157133`. Measurement-only run `39530460995`
passed on both hosts; full logs are audited clean in
`/private/tmp/fwp-range-counting-audit.json`. It adds a ninth C variant that retains multiplication's overflow
check and recomputes the safe product on its continuation, plus GCC range and
optimized-tree dumps. No compiler code changes or second PR exist. This explicitly
skips unchanged native preflight tests and cannot establish compiler acceptance.
Its artifacts are in `/private/tmp/fwp-integer-range-costs`; an independent audit
passed in 0.48s after correcting its explicit compiler-flag expectation. The
validator update is local to the preparation worktree and the audited report is
`/private/tmp/fwp-integer-range-audited.json`. Compiler code remains unchanged; preserve its source before any
later rebase onto the accepted squash merge.

Combined run `39528239204` and documentation `39528218865` pass. Both Linux jobs
pass formatting, Clippy, all five integer tests, twelve binary inspections and the
eight-way measurement. Full logs are audited clean; receipt:
`/private/tmp/fwp-matched-counting-audit.json` (audit script uses the same stem).
Artifacts: `/private/tmp/fwp-matched-counting-costs`. The guarded independent
report audit passed in 0.48s; all samples and native probes are recorded in
`docs/measurements/integer-counting-matched-2026-10-21.json`.

The selected helpers use groups and ordinary inline hints. On Xeon 8573C/N2,
child CPU time falls about 48% relative to unchanged fwp. Matched C/Rust remain
faster: fwp extra CPU is 56.7–62.5% / 18.2–22.9% on Xeon, and 142.2–142.9% /
29.5–30.1% on N2. The normal loops have no calls or stack traffic; AMD64 adds a
fixed 40-byte entry frame, and instruction sections grow 368/448 bytes. Managed
storage counts remain zero in this workload; tracing remains in the binaries.
The guide records every tradeoff and the slower unhinted Xeon control.

Next investigation after acceptance: generated C retains sign/large-value cases
for the checked `3*i` product that the C peer eliminates using the loop bounds.
Preserve checked arithmetic and trap order when testing ways to retain range
information. The cause of historical identical-binary variability is still open.
All seven roadmap areas remain open, with ownership/removal of tracing primary.

## Current implementation and evidence

The [measurement guide](measurements/integer-counting.md) explains the workload,
comparisons, timing scope and limits. The candidate counts decimal digits in
groups of 16, 8, 4, 2 and 1 instead of repeatedly dividing by ten. Signed values
use unsigned magnitude, including I64's minimum, then add the sign. No lookup
table or heap storage is added. Existing checked arithmetic and trap order remain.
Boundary inputs cover both sides of every representable power of ten, both signs,
and unsigned extremes; repaired native/interpreter and independent binary-payload
checks pass in the selected run.

| Preparation | Source | Measurement / focused checks / documentation |
|---|---|---|
| Shared counting loop, not selected | `995d3ecfd451700ec93e0fc1b326f8be0503bad5` | `39525618134` passed / `39525621027` failed: assertion and missing binaries / `39525810747` passed |
| Grouped counting, before inline hints | `5852017124334bb199ff653741b068f9b8c9f979` | `39526333980` passed / `39526336925` failed: same assertion and missing binaries / `39526267015` passed |

Both earlier measurement runs and documentation logs are audited clean. Their
failed native runs came from comparing binary output with text in the new test;
missing semantic binaries caused the following inspection failure. All other
targets passed. The assertion repair passes in the selected run. Earlier timing
results, including slower candidates, remain in the guide and raw reports.

Current artifacts: `/private/tmp/fwp-counting-costs` and
`/private/tmp/fwp-grouped-counting-costs`. Full-log receipts:
`/private/tmp/fwp-counting-preparation-audit.json` and
`/private/tmp/fwp-grouped-counting-audit.json`; audit scripts use the same stems.
The report validator is `scripts/summarize-integer-counting.py`, with explicit
`--comparison legacy` for the first experiments and `matched` for the current run.
It verifies source replacement, binary/disassembly hashes, every sample/median,
ratios, zero managed storage counts and the injected-allocation control.

Saved baseline inputs come from `62ed104504b9e9a032434223120785e3cc37a47f`, focused
run `39469883481`, tag `roadmap/revision-record-borrows-62ed1045`. The first new
experiments are preserved by `roadmap/revision-integer-loop-995d3ecf` and
`roadmap/revision-integer-groups-58520171`. The selected source is preserved by
`roadmap/revision-integer-matched-a8859db1`. All generated
source, binaries, disassembly and raw samples remain in the artifacts.

The contributor guide's obsolete claim of no third-party Rust crates is corrected
to match existing Rustyline/ctrlc dependencies. Historical benchmark reports remain
tied to their actual source and algorithm; current peers are updated together.

## Accepted base and remaining goals

[PR #181](roadmap-history.md#temporary-channel-borrows-and-failure-cleanup-pr-181)
passed all nine production gates and documentation at `2038c926`. Its squash
merge `c98da7a5b3d859fee69120cf3452dcdecc904979` has the identical tested tree
`2fc33e8e7b238402acfc30efe3aee753ac4a018c`. Receipt:
`/private/tmp/fwp-181-acceptance.json`. The one-line 59-character message has no
body or trailers. Duplicate production run `39503544541` was cancelled; duplicate
documentation `39503544342` passed.

All seven roadmap areas remain open. Default native execution still includes
tracing GC; JIT is excluded. Retained resources, persistent subscriptions,
resource-owning tail frames and mutual recursion need further proofs. Earlier
identical binaries had variable AMD64 CPU time; its cause remains unresolved.
Do not infer that a new algorithm explains that historical variation.

## Local checks and resources

Use `python3 scripts/local-guard.py` for local checks: 64 GiB free disk, target
below 2 GiB, sampled aggregate RSS below 1 GiB and 180 seconds. Full builds,
native compilation, full suites and benchmarks run on GitHub. No limits were
raised. Recent free space is about 65 GiB; recheck before downloading artifacts.

Guarded checks: U32 repair Rust formatting and whitespace passed in 0.25s; documentation/commit/link audit passed in 2.58s. Native checks are pending on
CI. Selected-run full-log audit 7.49s, artifact download 22.85s,
independent matched-report audit 0.48s and final guide link audit 2.57s. Earlier
Python syntax/helper selection/whitespace 0.13s; focused Rust
formatting 0.25s; documentation 3.31s; first/grouped report audits 0.58/0.59s;
artifact downloads 8.62/8.05/17.61s. Full-log audits took 4–7s each. The sandboxed
guard initially could not inspect `ps`; its approved invocation passed. Direct
Git launches previously hit OS process-group signal permissions; Python-supervised
Git passed under the same guard. No checks or guard limits were bypassed.

Prior authorized cleanup reclaimed 6.553 GiB of obsolete generated downloads after
verifying remote recovery artifacts. Sources, reports, logs and current evidence
were preserved. Recovery manifests: `/private/tmp/fwp-disk-cleanup-2026-10-20.json`,
`/private/tmp/fwp-disk-cleanup-second-2026-10-20.json` and
`/private/tmp/fwp-disk-cleanup-extra-generated-2026-10-20.json`.
Some older Rust artifacts are `*.codex-archive.gz`; preserve them and compare
decoded bytes explicitly when needed, without assuming raw files exist.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
