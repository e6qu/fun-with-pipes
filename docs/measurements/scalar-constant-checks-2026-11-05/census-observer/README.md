# Census observer repair

The [first census](https://github.com/e6qu/fun-with-pipes/actions/runs/42071040601)
at `26a5cbe6a1263bcbdd7f7a0ac3d973f6fe7996bb` fails on both hosts before timing.
Both complete the 12-case stack checks and two zero-update allocation cases.
The first positive-update selection check then fails; later allocation and
phase checks do not run. This is not a passing census.

The generated program contains the private pair helper. Its live call chain is:

```text
main → fwp_hof0 → fwp_borrowed_fold0 → fwp_loop_fields159 → … → f185
```

The observer omitted `fwp_borrowed_fold*` from parsed function definitions, so
it stopped before the helper. Shared reachability now recognizes both borrowed
fold and array callbacks and still requires a call from main. No compiler,
runtime, benchmark input or acceptance limit changed.

Guarded checks pass: four reachability controls, including unused callbacks and
historical rejected programs; four scalar-selection controls; all 20 saved
positive-update stack candidate/reference sources plus the original failing
repeated-solve source. All six census/timing/compiler producer and auditor
callers use the repaired observer. No timing samples were collected or discarded.

[The failing source](repeated-3-1-candidate.c.gz), full
[AMD64](amd-job.log.gz) / [ARM64](arm-job.log.gz) logs and
[original artifact identities](artifacts.json) are retained. The original AMD64
archive SHA-256 was verified before extracting the source. All completed steps
and compiler diagnostics were reviewed; both jobs fail on the same missing
reachability edge. The repaired [census and complete audit](../../scalar-constant-census-2026-11-05/README.md)
subsequently passed.
