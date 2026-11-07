# Original tape-layout executables verified

[Run 42389849116](https://github.com/e6qu/fun-with-pipes/actions/runs/42389849116)
passes on native ARM64 and AMD64. It rebuilt the saved C from the original timing
sessions with their original GCC versions and flags. All **48 executables match
byte for byte**; scalar append calls remain inlined in both layouts. No timings
were repeated.

| Architecture | Job | Original images | Result |
|---|---|---:|---|
| ARM64 | 128454949013 | 24 | All hashes and inlining checks pass |
| AMD64 | 128454948857 | 24 | All hashes and inlining checks pass |

Verifier source: `de895a714a99b397710b902105b47815b93f1616`.
Measured source: `621653b6394f49dc229a2956b6b61476c82c9aac`.
[Inputs](../tape-record-image-inputs.json) select session 1 on each architecture:
six workloads, current/history forms, original/reference layouts.

Each `*-records.zip` retains generated C, executable bytes, compiler command,
stack report, inlining report and result for every image. `*-summary.json` lists
all comparisons. `*-artifact.json` retains GitHub's artifact identity and digest;
`*-job.log.gz` retains the complete job log. [verified.json](verified.json) records
archive/log hashes and an inventory of all 392 retained files. A guarded local
check verified these against both summaries and original-image hashes (0.25 s).

This establishes reproducibility and the claimed inlining. It does not turn the
[32 missed speed targets](../tape-record-results.md) into passing measurements.
