# Next: verify eager capture bindings while PR #226 finishes

**Next:** finish the four frozen comparison sessions, replacing only the AMD
session rejected before timing. Original run `40876515001` at `4ffeb0d2` has
three qualified sessions still measuring. AMD session 1 job `123456633821`
received EPYC 9V45 rather than the required 7763; its complete
[rejection record](measurements/eager-captures-host-rejection-2026-10-29.json)
retains hardware, job metadata and full log. No timing was produced on that host.
Use `suite=eager-capture-time`, `native_runner=ubuntu-latest` and
`comparison_session=1` for its replacement. The other jobs continue unchanged.

Focused run `40871650124` at `89d0dfa1` passes all three hosts: Linux ARM job
123439947546, AMD job 123439947499 and ARM macOS job 123439947234. Each passes
299 tests in 18 summaries, all-target lint and the interpreter corpus. All logs
are audited (`/private/tmp/fwp-captures-*-89d0.log`). Compiler, runtime and test
source is identical at `4ffeb0d2`. The comparison was published before code in
`8a495a72`; [its protocol](measurements/eager-captures.md) fixes every limit.

Worktree `/private/tmp/fwp-ad-captures`, branch `ad-eager-captures`. No second PR
is open. PR #226 remains the only active PR; watch final native run `40876750803`, docs `40876747233` and G2 `40876750730`
at final head `02e4ee21`
from `/private/tmp/fwp-ad-recording`, whose handoff owns delivery. Do not change
that branch’s production code. Merge #226 only after all final-head gates pass.

The candidate reuses `bind_captures` for once-used known partial applications.
Eager computations stay in original order; observable captures reject the whole
transformation and discard prepared locals. Unknown/saturated producers keep
their bindings. Inlining limits and runtime APIs are unchanged. Unit controls
cover direct-call exposure, unknown/saturated calls and complete rollback;
source controls cover IO order, first failure and one-time aggregate capture.
Focused CI includes existing closure/resource/AD failure and cleanup tests.

No Rust build has run locally. Guarded formatting, workflow lint and documentation
pass. Four source controls pass raw interpretation with the exact 04efac8a CI
compiler (0.29 CPU seconds, 0.61 elapsed); this verifies their expected behavior,
not the candidate. The candidate’s three focused CI jobs now pass as recorded above.

The `eager-capture-time` workflow now uses the existing six-case, four-session
comparison with an explicit reference that restores only the earlier capture
transformation. Three reference controls verify the exact prepared production
source and reject missing, changed, duplicate or partially restored transforms.
Eight budget controls and nine retained-archive controls pass locally. A report
expression syntax error was caught and repaired before publication; both affected
control suites now pass. The earlier scalar-recording archive still reports all
original timing failures. Workflow lint passes.

Incidental repair: unsupported host selections for `descent-recording` and
`descent-checks` previously skipped every job. They now fail explicitly, as the
baseline suite already did. The new comparison follows the same host rule.
The four measurements were launched only after all focused jobs passed.
Explicit `comparison_session` selection now lets one rejected host be replaced
without repeating other sessions. It has no implicit selection; missing values
fail for timing suites. This changes only workflow dispatch and documentation,
not the compiler, measurement programs, scheduling, reference patch or limits.

Preserve the scalar-recording allocation reduction and its rejected speed result.
D2 remains open. Main source observations are in the experiment document and
`/private/tmp/fwp-next-d2-notes.md`. F64 conversion elimination is excluded from
this candidate; raw/native NaN payload differences preclude a bitwise identity
claim. No compiler abort recurrence is known; retain the original open evidence.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain F1–F3's stated call/recursion scope |
| 4 | Verified | Selected decimal cost delivered; loop gap remains recorded |
| 5 | In progress | Final grouped native gates; D2 whole-program speed goal remains open |
| 6 | Pending | N1–N2 numerical kernels |
| 7 | In progress | Broader B1/B2 comparisons |
| 8 | Pending | V1–V2 application validation |
