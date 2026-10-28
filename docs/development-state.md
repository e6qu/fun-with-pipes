# Current work

**Next:** verify compact ownership origins and single capture-dependency reads
on both G2 hosts. PR #221 remains draft; all nine production jobs, docs and G2
must pass on the final head before squash merge and then F1–F3.

Run `40683252110` at `dd91cc9c4f8ba7306d1848542b3a63f60817fee1` passes every Intel
macOS gate. Both hosts pass 212 units, all-target Clippy, exact fact sets and REST
budgets. Small fixtures need nine waves (limit 16). Linux fails only the N=64
separate/merged ratio: 2.008451/1.320981 ms = 1.5204, limit 1.5. All logs audited;
no other diagnostics. Docs `40683195261` passed and its complete log was audited.
Artifacts: `/private/tmp/fwp-221-dd91-analysis`.

The repair stores capture counts in the IR's existing `u32` range, with checked
conversion, and registers saturated-call capture dependencies once rather than
twice. A guarded extracted Rust O1 probe measures origin size 48 → 40 bytes on
local ARM64 and passes conversion bounds. This is not a full compiler test or
peak-memory measurement. Run:
`python3 scripts/local-guard.py python3 /private/tmp/check-fwp-origin-layout.py`.

[Every attempt](measurements/ownership-worklist-2026-10-28.json) retains its samples
and source: original Intel timeout, first worklist's 19-wave failure and current
Linux ratio failure. Keep all budgets unchanged. Earlier/self readers wait for
the next ordered wave; later readers can use new facts in the same wave. The
128-call regression tests both ID orders against a test-only full scan.

The PR, parser guides and fixture comments distinguish quoted benchmark input
from fwp syntax. fwp uses infix arithmetic (`2 + 3 * 4`); the toy parser consumes
its own text format. No language grammar or benchmark calculation changed.

Superseded production `40674858299`, `40676851764` and old docs `40676851675` are
cancelled. Draft production is skipped, not verified. Inspect failed steps while
jobs run; audit all targets before batching repairs. Never merge a skipped gate.

[PR #221](https://github.com/e6qu/fun-with-pipes/pull/221) uses
`/private/tmp/fwp-parser-workspace`, branch `scoped-parser-workspace`, based on
verified #220 squash `56d5aac63a9963ae6b16574f10d6dc3087a08d8a`.
A6 is implemented and measured; complete platform acceptance is pending.
[The lifetime contract](parser-workspace.md) and
[the measured comparison](measurements/parser-workspace.md) define its limits.

## Source and completed checks

- Parser representation/runtime source is `ca56023eb362259cf2099c9c9d477b20b3cf6793`.
  Published later changes add measurement diagnostics, docs and test-only repairs.
  The new analysis scheduling changes compiler performance and needs fresh G2
  evidence. Existing parser measurements retain their original source IDs.
- Native Linux ARM64/AMD64 run `40650396700` passed: 211 units, six allocator
  tests, six parser tests, two record tests, Clippy and actual WASI O1/O2 checks.
  All logs and 26 native/WASI probes per host were independently audited for
  outputs, statuses, physical cleanup, deliberate mutations and binary targets.
- Measurements at `35250b3a5ecdaa8f3e02ddb7af9664c84068f186` passed twice per
  architecture: AMD64 `40656341807`, ARM64 `40657569359`. All logs and artifacts
  passed independent audit: samples, budgets, allocation/cleanup, actual binary
  headers and text sizes, compiler scale and GCC stack observations.
- [The retained data](measurements/parser-workspace-2026-10-28.json) includes
  every current sample and prior measurement attempt. Three earlier identical-
  binary controls failed at 10.08%, 10.44% and 10.47%; their candidate timings are
  absent. Longer samples did not eliminate failures. Added CPU/scheduling data
  does not establish their cause. Preserve the unchanged 10% limit and reject
  future unstable controls; never discard failed samples or reset budgets.
- Eleven measurement evidence controls, actionlint and the documentation audit
  passed locally under the guard; docs CI `40656331725` passed. The consolidated
  final report audit passes 169 link sets, 106 preparation pairs and eight steps.
- No full local build, suite or benchmark ran. Earlier guarded Clang O1/O2
  checks cover allocation boundaries, oversized nodes, growth, nested owners,
  every allocation failure and missing cleanup. GCC results come from CI.

## Result and limits

One invocation owns aligned 256-to-4,096-byte blocks. Admitted recursive nodes
contain only integers and internal links; the links have no counts. Allocation
helpers receive context explicitly; readers need none. Recursive public calls
start new owners. Escaping/cached trees, unknown/captured uses, managed node
fields and self-tail roots keep ordinary ownership. Strings/tokens retain theirs.
Completed helper clones obey actual code-growth limits. Cancellation is observed
after a tree exists; omitted cleanup must fail the physical-storage check.

The four fixed trees parse in 18–28% less time than previous fwp, but take
5.7–9.4× C and 5.2–8.6× Rust time. The peers borrow tokens; fwp owns them.
Allocations decrease while total allocated slot bytes rise 4–14%; peak live
slots match previous fwp. Report these tradeoffs, individual stack frames and
compiler RSS, not only removed counts. This is one workspace, not general regions.

## Repairs and complete gate audit

The passing Linux G2 log exposed `const_item_mutation` in the test-only `prove`
helper: it borrowed a mutable temporary from `usize::MAX`. Use an explicit local
budget instead. This does not change compiler/runtime behavior or measurements.
The focused parser lint step now checks all targets, including the unit-test
harness that its prior selection omitted. Full CI now uploads failed native/WASI
Clippy diagnostics before long tests, so failures can be diagnosed immediately.
All four failed Clippy logs at `dbf1c0ba` contain only that test-helper error.
All four Clippy steps pass at `45f9e81013fdf3b9e07aa0d4222c87bcde289e2d`
in intermediate production run `40674858299`.
The complete old run `40659395283` passed these audited targets:

- Each regular macOS shard: 131 targets, 608 tests.
- Each macOS ownership shard: 125 targets, 353 tests.
- Each Windows host: 150 retained targets, 408 tests, plus the direct unit,
  library, SDK, protocol, golden and package steps in the complete job log.
- Linux ARM64: 256 targets, 966 tests, including all six parser tests and all
  21 WebAssembly ownership tests.
- Linux AMD64: 965 tests passed; only `tls::streams` failed, as described below.
  All 256 targets finished, with no other failed target or compiler diagnostic.

The TLS fixture deliberately connects to a plain-text server. Ubuntu's OpenSSL
`3.5.5-1ubuntu3.7` reported `record layer failure` instead of the snapshot's
`wrong version number`. Both backends use OpenSSL's reason text, whose spelling
is not a stable language contract. The snapshot accepts those two reasons only
on this complete client line. Other messages, certificate failures and successful
connections remain distinct; production TLS behavior is unchanged.
The actual snapshot code, compiled at Rust O1 with assertions/overflow checks,
passes replay of the complete CI output and the new rejection controls. The old
code fails both controls (exit 101). Full interpreter/native TLS execution remains
required on the final head; this local replay is not a full TLS test.

All 20 saved parser probes on each macOS/Windows architecture pass independent
output, failure-code, physical-storage and Mach-O/PE architecture checks.
The retained ARM crash report is the deliberate
`cleanup_panic_aborts_before_borrowed_tasks_escape` control, confirmed from its
source stack and passing unit test. Require every final-head gate again.
The lint/TLS repairs do not change production behavior. The subsequent analysis
repair is separate and still needs verification.
The repair batch also corrects guides that still called GC-removal validation
pending. Standalone comparisons without refreshed measurements remain explicitly
unmeasured; historical sources, modes and numbers are unchanged.

Guarded local checks passed: `cargo fmt --all -- --check`, actionlint for both
changed workflows, and `python3 scripts/check-roadmap.py` (169 link sets,
106 preparation pairs, eight roadmap steps). `git diff --check` passes;
`AGENTS.md` remains 99 lines. TLS replay command:
`python3 scripts/local-guard.py python3 /private/tmp/check-fwp-tls-snapshot.py`.
Full builds, suites and measurements stayed on CI.

## Repairs and artifacts

This PR also fixes guard tests that depended on host disk capacity and Linux
WASI jobs that mixed Clang 21 with LLVM 18 libraries. Production guard limits
remain unchanged; the shared WASI setup pins and preflights matching tools.
Measurement repairs recognize the previous unboxed worker/public bridge and
require actual exported roots in compiler-scale output. Invalid earlier compiler
rows are retained and labeled in the report.

Current artifacts: `/private/tmp/fwp-221-ca560-checks`,
`/private/tmp/fwp-221-35250-measurements` and
`/private/tmp/fwp-221-dbf1-{macos,windows}-{arm,amd}-parser` (native probe audits).
Earlier artifacts and audits remain in
`/private/tmp/fwp-221-{a55,ec36,ca560,a51}-measurements`; do not remove evidence
needed to reproduce the published record. No detached merger runs.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | In progress | A6 final platform acceptance |
| 3 | Pending | Functional calls and recursion fixtures/optimizations |
| 4 | Pending | Close named CPU performance gaps |
| 5 | Pending | Derivative storage, timing and precision |
| 6 | Pending | CPU numerical kernels |
| 7 | In progress | Extend fixed comparison budgets and audit controls |
| 8 | Pending | Larger-program correctness, cleanup and scale matrix |

## Recovery

GC removal is verified in #217; A1–A5 through #220. A6 needs final platform gates;
steps 3–8 remain open. [History](roadmap-history.md) owns completed delivery IDs;
[PLAN.md](../PLAN.md) owns tasks. The original intermittent Intel compiler abort
remains unexplained; preserve evidence and investigate source/input on recurrence.

The primary checkout is detached at #209 with a recovery pointer and an untracked
compiler-abort report; preserve both. Disk is about 74 GiB free. Keep the fixed
64 GiB/2 GiB/1 GiB/180-second limits and use `local-guard.py` for local checks.

Publication and squash merge are authorized after all final-head gates pass:
one line <=80 characters, empty body, no trailers/attribution. Verify the merged
tree and message, then continue the next substantial PR.
