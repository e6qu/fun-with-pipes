# Session handoff

Updated 2026-10-15. The user requested continued development after PR #137.
Branch `autodiff-operation-storage` removes input placeholders from numeric and
managed AD parent/derivative buffers. Publication, fixes and squash merge after
all final-head gates remain authorized.

## Roadmap status

| Step | Status | Delivered scope |
|---|---|---|
| 1 | Verified | Streamlined docs and session handoff |
| 2 | Verified | Expanded typed collector-free ownership |
| 3 | Verified | Array producer fusion, numeric tail loops and wide workers |
| 4 | Verified | Nested reverse AD, checkpointing and lifetime controls |
| 5 | Verified | Actual F16/BF16/F128 and protocol v2 |
| 6 | Verified | Native Windows ARM64/AMD64 and standalone packages |
| 7 | Verified | Seeded-prefix adjoint bounds and four-host memory/binary evidence; PR #137 merged with all gates |
| 8 | In progress | Operation-only AD metadata, partial weight-retain cleanup, regression controls and measured evidence |

## Accepted baseline

[PR #137](https://github.com/e6qu/fun-with-pipes/pull/137) merged as `38da1401`,
tree-identical to `37104959`. All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38604595248)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38604594927)
pass. [The prefix report](measurements/ad-prefix-2026-10-14.json) records its
specific 98,304-byte peak tape reduction and absence of a consistent speedup.
Historical preparation anchors are not work to replay.

## Current implementation and evidence

Both runtimes now index parent/weight metadata relative to the input count.
Node tokens, parent values and adjoints retain their original absolute indices.
Input-only tapes need no operation buffers; existing cached buffers remain
subject to the 512 KiB budget. Managed backward callback order is unchanged.
A related native cleanup fix protects the first retained derivative if retaining
the second fails. Tests and measurements are being extended before publication.

Guarded checks pass: formatting (0.99s), all-target clippy (15.60s), five
interpreter tape tests (12.98s), the native operation-storage and actual second
retain-failure controls including deliberate regressions (18.63s), managed
unwind/cancellation plus omitted-weight-cleanup control (16.14s), and the new
language fixture (0.76s). An initial test filter matched zero tests; the corrected
exact test above ran and passed. Initial fixture syntax/type errors were corrected.
The current formatter passes (0.27s). Runner measurements and full CI remain;
local checks alone do not establish platform acceptance.
`cargo test --test autodiff_capacity_bounds --test ad_tape_ownership -- --test-threads=1`
passes all three allocator/index/generation/unwind tests (21.04s).
Final formatting (1.13s), workflow lint (0.28s), measurement-script syntax and
roadmap/link/commit audit pass. Every local command used `scripts/local-guard.py`.

## Boundaries

Numeric prefix bounds trim an unused suffix, not holes in the active prefix.
Checked native ARC still rejects unproved cycles, mutable/retained graphs and
State/AD lifetimes. Service/remote/library/WASM executable ARC admission remains
outside the earlier bundle. Generic wide values and some lazy producers can
allocate. No universal collector-free execution or speedup is claimed.

## Next action

Next: complete input-storage and partial-retain regression controls, run focused
guarded checks, publish one draft PR and collect four-host native measurements.
Then require all nine exact-head production jobs and docs, fix any failures, and
squash merge with one line of at most 80 characters and an empty body. Keep this
follow-up in one PR; do not replay historical preparation entries.

Use `python3 scripts/local-guard.py` for focused serial local checks; preserve
64 GiB free disk, target below 2 GiB, sampled aggregate RSS below 1 GiB and the
180-second deadline. Full builds, suites and measurements belong on GitHub.
