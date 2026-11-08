# Current work

**Next:** publish the structured-gradient measurement batch, run its focused
three-host safety checks, then dispatch the frozen comparison. Choose an
improvement from those results before changing the compiler or public library.
Keep the whole milestone in one substantial normal PR; no PR is open yet.

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
No benchmark session has run; no public operation or compiler change is selected.

- Thirty exact results cover empty/singleton values, repeated tensor leaves,
  dense matrices, two neighboring formulas and unchanged caller values.
- All three focused jobs in `42491926962` pass: AMD GCC `128765967628`, ARM GCC
  `128765967846`, macOS Clang `128765967795`. Full logs are clean. These verify
  numeric proofs, mixed ownership and original/new O1/O2 semantics, **not the
  newer measurement driver**. Docs `42491928737` / `128765970978` also pass;
  reviewed diagnostics are deliberate negative controls.
- The new driver checks every gradient coordinate and caller alias. Managed and
  raw-tape observers cover workspace reuse on/off. Four native controls, five
  rejected faults and known-work observer controls pass locally with Clang.
- The first dense driver control mistook a cached zero `Dual` constant (`caf68`)
  for a 32-byte leak. The corrected boundary preserves normal constant lifetime,
  reports retained bytes, rejects growth and requires exact reclamation after
  actual constant shutdown. Missing constant cleanup is a rejected control.
- Six analytic/statistical controls pass. Python syntax and all five changed
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

Disk fluctuated from 75 to 49 GiB; the guard refused below the 64 GiB reserve.
Checks resumed only after recovery to 74 GiB. Keep all guard limits unchanged;
move builds and measurement to runners.
