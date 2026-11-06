# Native scalar append inlining verification

All **48 saved executables reproduce byte for byte** on native Linux ARM64 and
AMD64. GCC reports the candidate's scalar append body inlined, with no final
inlining rejection. Reference append calls remain out of line. This verifies the
native transformation used by the [original runtime sessions](../recording-inline-time-2026-11-06/README.md);
it adds no timing samples and changes no performance limit.

## Method and result

[Run 42165452140](https://github.com/e6qu/fun-with-pipes/actions/runs/42165452140),
source `48c2ae70ab58813bc04ab7bda4b8d7845ccef852`, uses the
[explicit input plan](../recording-inline-call-inputs.json). Per architecture:

- Six coordinate/update cases, two result forms and two versions: 24 images.
- Original saved C, workspace paths, full GCC version and command flags.
- Add only `-fopt-info-inline-optimized-missed=FILE`; require the rebuilt
  executable's SHA-256 to equal the original measured image.
- Preserve each command, exit status, stdout/stderr, C source, native image,
  stack report and complete inlining report. No native program executes.
- Positive-update candidates must report append inlining and no final rejection.
  Zero-update programs still undergo exact image/hash/report checks.

For 129 coordinates and 199 updates, each result form reports seven static append
inlining instances in the candidate, versus seven rejected instances and zero
inlined in the reference, on both architectures. These are compiler call-site
reports, not executed node counts. Runtime work counts remain unchanged.

## Retained evidence

| Architecture | Job | Full bundle | Summary |
|---|---|---|---|
| ARM64 | `127720749935` | [ZIP](aarch64.zip) | [records](aarch64-summary.json) |
| AMD64 | `127720750219` | [ZIP](x86_64.zip) | [records](x86_64-summary.json) |

Each bundle contains `plan.json`, the audited input session/report and every
source/image/stack/inlining record. Adjacent `*-artifact.json`, `*-job.json` and
`*-job.log.gz` retain artifact digests and complete job identity/logs. A guarded
local check verified every nested record hash and every image equality, plus
both downloaded archive digests and all job diagnostics (0.13s).

These diagnostics confirm GCC's native output. The final nine-job platform gate
and complete production/doc audit are still required before merge. The 19 missed
runtime speed targets and one inconclusive compiler control remain open.

[Contract](../recording-inline.md) · [Handoff](../../development-state.md)
