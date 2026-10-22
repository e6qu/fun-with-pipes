# Session handoff

## Next action

Next: finish auditing [PR #192](https://github.com/e6qu/fun-with-pipes/pull/192)
at `71bde4502267a033221446a52b7bc0b5d08d4753`. Production `39701165415` has
reported a Windows ARM64 native-resource failure; Windows AMD64 reports the
same step failed; both complete uploaded logs confirm the same sole failing target. ARM64's complete uploaded
native log identifies one test: the standalone text probe prints Windows CRLF
but its assertion requires LF. A line-based diagnostic assertion is prepared in
`application-ownership/tests/text_transform_ownership.rs`. Runtime/interpreter
byte comparisons stay exact. Audit all remaining jobs and batch all repairs
before updating the delivery head; no merge is authorized on these failing gates.
Docs, benchmarks and both regular/GC ARM macOS jobs already pass, fully audited.

Use `/private/tmp/fwp-audit-192-final.py` and
`/private/tmp/fwp-read-192-failed-artifacts.py`. Archive the old acceptance receipt
when publishing a repaired head; update publication/audit and merge helpers for
that head. The existing merge helper still requires the old head and preparation
code identity, so it must not be used unchanged after test repairs. Require all
nine final-head production jobs and docs before the authorized squash merge.

Continue independent file-application preparation below; keep one delivery PR.
All seven plan areas remain open.

## Worktrees

- Primary `/Users/zardoz/projects/fun-with-pipes`: detached at verified #191 merge
  `19f3afbcbed22802a96f092d9d0ee3d7913335e3`; only this handoff is dirty.
- Active delivery: `application-ownership`, `/private/tmp/fwp-application-ownership`,
  head `71bde450`. Publication receipt:
  `/private/tmp/fwp-application-delivery-publication.json`; integration receipt:
  `/private/tmp/fwp-application-integration.json`.
- Next preparation: `file-application-lifetimes`,
  `/private/tmp/fwp-file-application-lifetimes`, based on #192's head. Its directory
  preparation `8773b7adde025fd89ba91bb9a1d8fb221a9d5ed7` is running focused
  six-host CI `39705831190`; current-compiler acceptance is pending.
  `/private/tmp/fwp-file-application-preparation.json` records the starting scope.
- `application-baselines` at `/private/tmp/fwp-application-baselines` preserves
  immutable application preparation `54b01db94079`; staged documentation was
  copied into #192. Older task/CPU worktrees and tags are evidence, not new tasks.

## Accepted delivery

[PR #191](https://github.com/e6qu/fun-with-pipes/pull/191) passed all nine production
jobs (`39688998592`), documentation (`39688998567`) and focused GCC (`39688997806`)
at `12be5afcee7c81f1b98ffed2081d698e1124b000`. All full logs were audited.
`/private/tmp/fwp-191-final-acceptance.json` verifies its squash merge `19f3afbc`,
identical tree and one-line message. Redundant same-tree push CI `39700306060`
was cancelled; post-merge docs `39700305849` pass with a full-log audit in
`/private/tmp/fwp-191-postmerge-docs.json`. Do not repeat this delivery.

It removes temporary task-result boxes, repairs State/Jacobian and raw C-buffer
cleanup, enforces explicit CPU worker contracts, removes runtime OpenCL compilation
and prepares foreign bridges before effects. Await evidence covers six native
and two WASM jobs, 204 native binaries and 64 await modules. Its fixture removes
34 requests/544 requested bytes with unchanged retains and peak storage.

## PR #192 scope and completed evidence

The batch transfers unchanged-string owners, preserves large counts/indices on
32-bit targets, checks slice/string/vector bounds, avoids empty repetition loops,
defines six application families, measures word frequencies and gradient descent,
and teaches descent without retaining its history. Its code, including runnable
tutorials, matches accepted preparation `54b01db94079`; integration changes only
Markdown and measurement JSON. Final production acceptance remains required.

| Preparation | Source / run | Result |
|---|---|---|
| Word-frequency C/Rust baseline | `74263bccf8e2` / `39690307737` | Both Linux jobs pass; eight binaries inspected. |
| Descent history versus current weights | `4815e3d16c34` / `39692176065` | Both Linux jobs pass; 24 binaries inspected. Managed peak at 129 coordinates falls 845,424 → 26,288 bytes; timing changes are modest/mixed. Raw tapes are excluded. |
| Original text owners | `67b684506bb4` / native `39694262883`, WASI `39694266236` | All four jobs pass; native comparison/control binaries inspected. |
| Repeat and stack estimates | `4ce989e5ffb9` / `39695137827` | Both jobs pass; eight rebuilt binaries have identical code bytes. |
| Expanded aliases | `a9a6ba203ec1` / `39696094960` | Both jobs pass; 24 native controls and four WASI modules inspected. |
| Bounds repairs and combined application checks | `54b01db94079` / `39699466703` | Both jobs pass: native, actual 32-bit interpreter, WASI and paired measurements; 48 native binaries and 24 WASI modules inspected. |

All complete logs are audited. Reports are committed under `docs/measurements/`;
the current report is `unchanged-text-bounds-2026-10-22.json`. Its raw artifacts
and inspection are `/private/tmp/fwp-count-verification-evidence/54b01db94079`.
Acceptance receipt: `/private/tmp/fwp-count-verification-acceptance.json`.
Do not repeat completed downloads or inspections.

The large word-frequency input removes 148,546 of 397,353 allocation requests,
with unchanged 138,250 retains and lower managed peak. Current paired ARC medians
improve about 10–17%, yet remain 2.78–3.37× C and 2.14–2.34× Rust time. The peers
combine normalization into one pass; this is not a pure compiler-overhead measure.
The small AMD64 RSS sample grows 131,072 bytes, and whole ARC binaries grow
40/32 bytes on AMD64/ARM64 despite smaller code sections. Earlier per-function
stack estimates apply to `67b684506bb4`, not the bounds-repair revision.

## Current file-application preparation

Preparation `8773b7adde025fd89ba91bb9a1d8fb221a9d5ed7`, focused run
`39705831190`, completed on all six hosts. All nine actual tests and the
14-binary/eight-series inspection passed on each host. Windows jobs passed in
full, including the #192 text diagnostic newline fix. Four Unix jobs failed
only Clippy's requirement to spell permission modes in octal. Full logs are
audited in `/private/tmp/fwp-file-application-acceptance.json`; overall acceptance
is false. The corrected `0o000` permission helper passes local Clippy and an
actual deny/restore check (`/private/tmp/fwp-check-permission-guard.py`).

Uncommitted expansion groups grep and CSV column selection with the directory
and word-count checks, so the next preparation covers four maintained programs.
The output reader now drains large reports while sampling memory, avoiding a
full stdout pipe. Compiler failures will upload their own log before independent
tests continue. A stale OpenCL-removal sentence in design-limits is corrected.
[Application acceptance](application-acceptance.md#repeated-directory-and-file-work)
specifies inputs, counters and limits; full current-compiler acceptance is pending.

Directory inputs have 64/1,024 files. Word-count and grep use two 128/4,096-line
files; CSV uses 128/4,096 data records, quoted commas/quotes and Unicode.
Independent Rust oracles check complete output alongside raw interpretation.
ARC O1/O2 observes 64 rounds per success/error phase, including missing/not-directory
paths, denied traversal after a readable subtree, failed/invalid-UTF-8 second
reads and missing CSV columns after successful parsing.

Counters separately require stable managed charge, zero open directory/read
handles and zero `file.read` C scratch bytes. Deliberate missing-release,
missing-close and missing-buffer-free controls fail. A parent/child handshake
samples RSS at rounds 0/32/63, separately from managed charge. The expanded
inspection expects 30 native binaries and sixteen memory series per host.
No timing or C/Rust-parity claim is made.

`python3 scripts/local-guard.py python3 /private/tmp/fwp-check-file-observers.py`
passes for all four small fixtures with the saved prior compiler: raw
interpretation, Clang O1, permission failures, deliberate leaks, shared Rust
observer and RSS handshake. It takes about seventeen seconds below local limits.
The old compiler predates the named teardown marker; this local probe uses its
known observation location, while committed tests require the current marker.
Next: run final formatting/docs/workflow checks and publish the complete repair
plus grep/CSV group; audit all six hosts before the next substantial delivery.

## Local limits

Run focused checks serially through the primary
`python3 scripts/local-guard.py python3 SCRIPT`. Full Rust builds, suites and
measurements stay on GitHub. Preserve 64 GiB free disk, generated target data
below 2 GiB and sampled aggregate RSS below 1 GiB; the deadline is 180 seconds.
Stop on limits rather than raising them. Do not use the fun-refactor guard here.
Every commit is one line ≤80 characters, with no body, trailers or attribution.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and prove remaining ownership boundaries. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate CPU numerical kernels; runtime compilation is removed. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
