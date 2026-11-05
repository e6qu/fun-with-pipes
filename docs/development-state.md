# Current work

**Next:** run the repaired three-host focused checks, audit every target and
artifact, then execute the frozen census/compiler/runtime comparison. The prior
Linux jobs were completely reviewed before batching the repairs below. Do not run
the final matrix until the complete group is ready.

Branch: `recording-work-review`, based on verified merge `2e6e09f5`.
Worktree: `.worktrees/scalar-constant-lowering`. Active draft:
[PR #262](https://github.com/e6qu/fun-with-pipes/pull/262).
The [contract](measurements/recording-lookups.md) was committed at `bfddc31e`
before implementation. It preserves parent/capacity checks and excludes any
worker that can change tape lifetime or suspend through task/service entry ticks.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Generated source reconciles eight nodes per pair/update with the saved profiles. |
| 2 | Implemented | Closed numeric worker proof; registry changes, recovery and suspension excluded. |
| 3 | Verified | Same-source comparison and limits frozen at `bfddc31e`. |
| 4 | In progress | Implemented bounded selection and explicit local lookup state; native controls, focused CI and measurement integration still require verification. |

Compiler/runtime implementation: `99bf3adccc3380f761876e34830cb938a94dcadd`.
The next repair changes test fixtures and documentation, not production behavior.

Focused run `42125357727` completed both Linux jobs: ARM64 `127588030802`,
AMD64 `127588031265`. Each passes 24 of 25 native targets, formatting, the build,
302 compiler unit tests (four existing ignored), primitive inventory, reference
controls and real-program selection. Both complete job logs and preflight archives
`13461276666` / `13461790806` were reviewed. Two failures require this repair:

- Clippy rejects a manual counter in the new depth-limit test. Iterating the same
  IDs directly (`2..66`) removes it without changing the test.
- The new recording probe constructed an unscoped program. Admission correctly
  rejects it before C generation. The repaired fixture enters `ad.scope`; a
  separate negative control still requires rejection outside that scope.

The C probe also installed a recovery target outside its active `setjmp` frame.
Recovery hooks now exist only while that frame is active. Runtime-only Clang
O1/O2 controls pass all 20 cases after this repair, including reuse 0/1 and
three deliberately broken observers. Command:
`python3 scripts/local-guard.py python3 /tmp/fwp-recording-runtime-check.py`
(2.40 CPU seconds, 6.13 elapsed). This uses retained C and a handwritten worker;
it does not establish Rust code generation or GCC support. Scratch evidence:
`../gradient-work/recording-runtime-control/`.

macOS job `127588031206` remained queued with no runner after both Linux jobs
finished. Replace that obsolete run with the repaired source; no macOS result
has been claimed. Formatting passes after all three repairs (1.91 seconds).

[Measurement controls](measurements/recording-lookup-controls-2026-11-06/README.md)
pass: eleven suites, 97 tests, run `42123056112`, job `127580112855`, source
`895f766c`. Measurement scripts remain identical. The complete log, job metadata,
digests and audit are retained; no diagnostics remain. This includes the four
historical archive checks unavailable in the sparse local checkout.

Docs run `42126502343`, job `127591947303`, passes at `29a2d73a`.
It verifies the corrected roadmap status labels; the checker was not weakened.

The proof bounds pending expression references, parameters, visited nodes, call
depth and nested types. Signature recognition allocates no temporary vectors or
type strings. Native/compiler checks still gate the repaired group.

The new `recording-lookup-{census,analysis,time}` suites use the existing production
measurement jobs. Census must precede timing: it checks exact parent/capacity/node
counts, eight-to-three lookup reduction per pair, parent allocation reconciliation,
raw storage, cleanup and stack. Use the same passing focused run as `evidence_run`.
The corresponding `*-report` suites audit retained data. Runtime sessions must be
qualified before building and must not be repeated for a passing result.

Local measurement-tool checks passed: reference/observer controls (5 tests),
timing budgets (23), allocation budgets (9), whole-solve census (10), compiler
analysis (10), and the changed saved-reference audit (1). Actionlint passed for
both changed evidence workflows. Staged doc links passed (103 links). Full
historical archive coverage is verified by the retained CI controls above.

## Completed group

[PR #261](https://github.com/e6qu/fun-with-pipes/pull/261) merged as
`2e6e09f539bcdab965d062f0184b585b340b29d8`. [The delivery receipt](measurements/scalar-constant-delivery-2026-11-05/README.md)
retains the audited logs and confirms an identical tested/merged tree and a
50-character squash message with no body or trailers.

| Check | Passing run / audit |
|---|---|
| Nine final production jobs | `42080858908` at `80e4ee7b483d4881801eed3ff3b12c312b4ec868` |
| Final docs | `42080855434`, job `127433175116`, same source |
| Every final job and test-target log | `42096023194`, job `127486171834`; no unresolved issues |
| Three-host focused native checks | `42048215807` / `42070540044` |
| Allocation, cleanup, work and stack | `42072583890` / `42074145465` |
| Compiler costs | `42074639596` / `42076024832` |
| Four qualified runtime sessions | `42074728167` + `42075136884` / `42078637088` + `42078654369` |

Measurements use `76690b385514c58ad94c5591da3553fa48218535`; later changes repair
evidence tools/docs only. All four sessions measured once. Their 27 missed 5%
speed targets stay open under the agreed policy; all other measured limits pass.
The wrong-CPU AMD host was rejected before builds/timing. No claimed C/Rust parity.
Postmerge duplicates `42096524750` and `42096524644` are confirmed cancelled.

## Next investigation inputs

Read `lib/autodiff.fwp`, `runtime/fwp_rt_kernel.c`, saved generated objective
workers, and the [runtime reports](measurements/scalar-constant-time-2026-11-05/README.md).
Forward recording accounts for about 72% of observed derivative-phase time in
129/199; these observations do not identify a particular check as the cause.
Keep the original arithmetic order, eager callback stages and all failure controls.

The [saved phase review](measurements/recording-work-review-2026-11-05/README.md)
identifies all four input-report hashes. Local checks used
`python3 scripts/local-guard.py`: the phase review took 0.17 CPU seconds/0.56 elapsed;
audit ZIP digest/job identity and merged-tree/message checks each passed under
0.2 seconds. The saved calculation reproduces byte-for-byte (0.24 seconds).
The staged-doc link check (`../gradient-work/check-delivery-docs.py`) verifies
362 local links in ten Markdown files; plan/handoff and workflow-size checks pass.
No native tests or benchmarks were rerun locally.

About 83 GiB remains free. Keep the fixed resource guard; full builds, suites and
large evidence work run on GitHub. The previous cleanup receipt remains at
`../gradient-work/removed-verified-downloads-2026-11-05-user-cleanup.json`.
