# Current work

**Next:** publish the corrected resource-owner fixture and complete all focused
native checks before the frozen candidate/baseline comparison. The compiler
repair is `f243db4bba63fdeb41f38d4a42d73664e6e69c59`; its test fixture failed on
all three hosts. Keep implementation, measurements and tutorials in one
substantial normal PR; no PR is open yet.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | #270 delivered docs and fresh F64 stores; original AMD timing acceptance stays open. |
| 2 | In progress | #271 delivered captured maps and empty-owner transfer; noisy timing acceptance stays open. |
| 3 | In progress | Measure neighboring, independent and dense gradients; select and verify a reusable improvement. |
| 4 | Pending | Swift/C/Rust ownership comparisons with separate time and memory boundaries. |
| 5 | Pending | Three application/tooling paths, compiler phase/scaling costs and demonstrated usability repairs. |

## Verified base

Branch `structured-autodiff-comparison`, worktree `.worktrees/recording-capacity-gate`.
Preserve unrelated root-worktree changes. Base `b76306b20a1d7727917ef6184c9a8716967ceb89`
is the verified squash merge of [#271](https://github.com/e6qu/fun-with-pipes/pull/271).
Its one-line message has no body/trailers. Tested head
`9584ae2e293529430af983b2030fc9cb43add01f` and merge share tree
`163d7093b878080d0b63592b24ab45442f6770a0`.

All nine production jobs (`42482501918`), docs (`42482501764`, job `128737287761`)
and full audit (`42490732997`, job `128762314926`) pass. All logs were reviewed.
[Retained delivery archive](measurements/captured-map-delivery-2026-11-08/README.md).
The [original timing limits](measurements/captured-map-repaired-2026-11-08/README.md)
remain: both largest applications improve 84–94%, but copy noise leaves combined
acceptance open. Do not repeat unchanged sessions to obtain a pass.

The duplicate merge-triggered production run `42491141406` used that exact tree
and was cancelled to free runners. Its benchmark and docs (`42491141374`) pass.
All nine duplicate-run logs were reviewed: only cancellation and consequent
missing-evidence errors occurred. Required original gates remain successful.

## Current batch and checks

[The frozen contract](measurements/structured-autodiff.md) specifies 41 complete
gradient comparisons, two sessions per native architecture, settings and noise
limits. Preparation source: `fe374a246332e44d312c4c90bb6aaf7a7c714f71`.
Measurement source: `04ddc0ac5d296ec895364236c4120341d7328e41`.
All four sessions and their audits pass. Original timing qualifications remain
mixed; [retained reports and archives](measurements/structured-gradient-methods-2026-11-08/README.md)
record every outcome. Selected change and new paired acceptance are frozen in
[the contract](measurements/structured-autodiff.md#selected-change-known-array-callbacks),
before compiler edits. Published tags
`roadmap/structured-gradient-baseline-2026-11-08` and
`roadmap/structured-gradient-acceptance-2026-11-08` preserve both sources after
squash merge. No new public gradient operation is planned.

- Thirty-two exact results now cover empty/singleton values, repeated tensor leaves,
  dense matrices, two neighboring formulas and unchanged caller values.
- All three focused jobs in `42491926962` pass: AMD GCC `128765967628`, ARM GCC
  `128765967846`, macOS Clang `128765967795`. Full logs are clean. These verify
  numeric proofs, mixed ownership and original/new O1/O2 semantics, **not the
  newer measurement driver**. Docs `42491928737` / `128765970978` also pass;
  reviewed diagnostics are deliberate negative controls.
- The driver checks every gradient coordinate and caller alias. Managed and
  raw-tape observers cover workspace reuse on/off. Four native controls, five
  rejected faults and known-work observer controls pass locally with Clang.
- The first dense driver control mistook a cached zero `Dual` constant (`caf68`)
  for a 32-byte leak. The corrected boundary preserves normal constant lifetime,
  reports retained bytes, rejects growth and requires exact reclamation after
  actual constant shutdown. Missing constant cleanup is a rejected control.
- New driver checks pass on all three hosts in `42495076166`: AMD `128775588266`,
  ARM `128775588591`, macOS `128775588512`; all complete logs reviewed clean.
  Docs `42495078259` / `128775593155` pass with expected negative controls only.
- Measurement `42500492246` uses those passing safety gates. Job IDs: ARM session
  1 `128791969735`, session 2 `128791969927`; AMD session 1 `128791970017`, session
  2 `128791969912`. All four pass, including evidence-rejection controls; complete
  logs are clean and original archive digests match. Managed storage returns to
  baseline and raw buffers reach zero with workspace reuse on/off.
- Seven analytic/statistical controls pass. Python syntax and all five changed
  workflow files parse; workflow sizes remain below 512,000 bytes. PyYAML is
  absent locally; the installed Ruby YAML parser passes instead.
- `numerics.yml` moves two unchanged regression jobs to `numerical-regressions.yml`
  to stay below GitHub's size limit. `structured-ad.yml` requires a passing
  three-host run that includes the new driver controls. Its audit reconstructs
  every command, sample, summary, native image and storage report; deliberate
  evidence mutations must be rejected and restored before upload.

General `grad`, nested AD and F128 stay required. Tensor AD currently supports
only elementwise objectives; all repeated-leaf contributions must be combined.
Independent losses already use `array.map (derivative loss)`. The local pair
helper remains experimental until correctness, lifetime and benefit are verified.

## Candidate implementation and validation

Acceptance was frozen in `412b50b52`. First candidate
`b0a2becabf7acc474a410002df6a8f88d2c1ddb4` adds array primitives to small-callback
specialization. All three jobs in `42501889779` fail the same allocation limit:
neighbor-local `n=3` makes 768 requests over 32 calls; limit 256. Final storage
is zero. Outputs, order, unknown callbacks, unwinding, F128 and nested AD pass.
All completed tests and diagnostics were reviewed. [Logs/source evidence](measurements/structured-array-callback-first-2026-11-08/README.md).

Published repair `f243db4bb` extends `opt::scoped`'s existing known-function worker copy to
arrays. The 40-node inlining limit prevented the first candidate from exposing
the known edge inside the larger coordinate worker. The repair substitutes that
closed function and omits only its effect-free, owner-free argument for arrays;
other arguments/resource identities remain in place. The first candidate's
forwarding-only array wrappers are removed; native array lowering already calls
these workers directly. Existing body/expansion budgets stay unchanged. New proof tests cover ordering, reuse and exclusions.
Focused run `42503655664`: ARM GCC `128801543946`, AMD GCC `128801544219`,
macOS Clang `128801544211` all fail one new proof fixture: it incorrectly marks
an I64 parameter as a resource owner. All seven other proof tests pass; later
native targets were skipped. Complete logs were reviewed. The corrected fixture
uses a real File parameter and checks valid IR before and after specialization.
The focused workflow now completes independent targets after an earlier failure,
retaining a failing overall result. No safety or allocation limit is relaxed.
Docs `42503658149` / `128801548679` pass; reviewed diagnostics are deliberate
negative controls. Local Rust formatting, workflow YAML and 395 Markdown links
pass. Native repair remains unverified until the next focused run passes.

The paired measurement runner/auditor now implements the frozen 14-case,
256-gradient experiment and builds baseline/current compilers from source.
Seven analytic/statistical controls and Python/YAML syntax pass locally.
Repaired-source logs: `/tmp/fwp-array-callback-repair-{arm,amd,mac,docs}.log`.
The XOR result checksum could cancel across even repeats; it is replaced with
a rolling bit checksum and a native one-bit-change rejection control (2.44 s,
1.12 CPU). Full per-coordinate checks in the original study remain valid.
No candidate timing session has run. The driver now collects all allocation
misses before failing, so one missed budget does not hide later controls.

## Tutorial changes awaiting the same PR

Lesson 20 now computes one independent-loss gradient by reverse, whole-objective
forward, per-element forward and tensor AD. It explains all four tensor leaf
contributions, neighboring/dense limits and the local derivative's `-0.0` versus
other methods' `0.0`. Full output agrees in raw interpretation and Clang O2
(3.29 seconds, 1.46 CPU); initial expected-output mismatch was corrected to
preserve signed zero. Numerics and terminology cross-link the worked examples.
These new tutorial changes still need final native CI coverage.

## Reproduce and resume

Use `python3 scripts/local-guard.py` for serial focused checks. No full local build
or benchmark. Full production/docs/audit gates follow the completed milestone.
The exact-base compiler at `/tmp/fwp-pr271-compiler/fwp-macos-arm64/fwp` came from
artifact `13620145916`; archive/binary hashes match the final-head manifest.
This is a local check tool, not a build dependency.

Guarded checks:

- `python3 scripts/test-structured-ad-costs.py`: six pass (0.13 seconds).
- `python3 scripts/check-structured-ad-driver.py --compiler /tmp/fwp-pr271-compiler/fwp-macos-arm64/fwp --cc clang --c-arch armv8-a --platform darwin --output /tmp/fwp-structured-driver-final-controls`: pass (19.55 seconds, 9.67 CPU).
- Earlier fixture interpretation, formatting and 30 Clang O1/O2 outputs pass
  (5.37 seconds); `/tmp/fwp-structured-ad-preparation/boundary-native-results.json`.

Driver failure/repair evidence is in
`/tmp/fwp-structured-ad-preparation/driver-controls/` (`dense-diagnostic.c` and
`.log` retain the original error). Focused CI logs:
`/tmp/fwp-structured-checks-{amd,arm,mac}.log`, `/tmp/fwp-structured-docs.log`.
New driver/docs logs: `/tmp/fwp-structured-driver-{amd,arm,mac,docs}.log`.
Tutorial commands/results: `/tmp/fwp-structured-tutorial/checks.json`.

Disk fluctuated from 75 to 49 GiB; the guard refused below the 64 GiB reserve.
Checks resumed only after recovery to 74 GiB. Keep all guard limits unchanged;
move builds and measurement to runners.
