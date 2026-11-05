# Instrumented reference audit repair

[Audit 42077511822](https://github.com/e6qu/fun-with-pipes/actions/runs/42077511822)
fails on the three completed sessions in runtime run `42074728167`. The samples
remain valid inputs to a corrected audit; the failed audit does not certify them.

The image inventory includes ordinary, allocation-profile and phase-timing
executables. The checker classified a name as reference only when it ended in
`-reference`, so `fwp-ad-reference-profile` was incorrectly required to contain
direct constants. The reference correctly retains its caches.

The repaired classifier recognizes the thirteen declared fwp image names:
current/history × candidate/reference × ordinary/profile/phases, plus the
identical candidate copy. It rejects unknown names. Focused controls cover all
names and malformed names; the scalar reference-edit controls also pass.

No compiler, measurement source, sample, count or acceptance limit changes.
Both original runs were [re-audited successfully](../../scalar-constant-time-2026-11-05/README.md)
with the corrected checker; timings were not repeated. The [compact failure summary](summary.zip), [full log](job.log.gz) and
[artifact identities](artifacts.json) retain all three errors and the separately
rejected AMD64 host. The summary archive digest was verified before inspection.
