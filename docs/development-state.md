# Session handoff

Updated 2026-10-15. The user requested continued development after PR #139.
[PR #140](https://github.com/e6qu/fun-with-pipes/pull/140), branch
`autodiff-registry-search`, has completed focused validation and four-host
measurements at runtime revision `e0d073a7`. Publication, fixes and squash merge
after all nine exact-head production jobs plus documentation remain authorized.

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
| 8 | Verified | Operation-only AD metadata, partial weight-retain cleanup, regression controls and measured evidence |
| 9 | Verified | Geometric native AD registry growth and numeric workspace ownership |
| 10 | Implemented | Skip known unavailable AD registry slots in native and interpreter runtimes; four-host evidence and focused gates pass |

## Accepted baseline

[PR #139](https://github.com/e6qu/fun-with-pipes/pull/139) merged as `5d05cdd6`,
tree-identical to `917d28a3`. All nine [production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38690176314)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38690140952)
passed, along with its focused AD/WASM checks. The squash message is exactly one
line with no body or trailers. Prior acceptance is in [history](roadmap-history.md);
historical preparation anchors are not work to replay.

## Current implementation and evidence

Both runtimes track a cursor below which tape slots are live or permanently
generation-exhausted. Creation starts there. Numeric/managed backward and scope
retirement lower it when an earlier reusable slot is detached, before reentrant
callbacks. Native shutdown resets it; the interpreter keeps it with the slots
under the existing mutex. Native backward uses the validated token's slot rather
than reconstructing it from a byte-pointer difference. Token selection, generation
limits, scope links, gradient evaluation and trap order are preserved.

[Focused AD/evidence](https://github.com/e6qu/fun-with-pipes/actions/runs/38707923424)
passed all four Linux/macOS hosts at `e0d073a7`, including every measurement step.
[Focused WASM](https://github.com/e6qu/fun-with-pipes/actions/runs/38707931935)
passed both Linux hosts at the same revision. Runtime-head documentation
`38707841111` passed. The draft production run was skipped and is not a gate.

[Permanent measurements](measurements/ad-search-2026-10-15.json) retain hardware,
compiler/flags, raw process timings, allocation/live-memory counts, archive and
per-file hashes, and inspected machine-code addresses on all four hosts.
At 16,384 simultaneous tapes, unavailable-slot visits fall 134,209,536 to zero.
Allocation/live-memory counters match the restart control; all measured storage
is reclaimed without GC. Large batches are faster on all four measured hosts,
but small cases are mixed. No general speedup or universal constant-time search
claim is made. Actual instructions retain the cursor across creations and lower
it on release; numeric backward directly reuses token bits. Ordinary register
saves and stack frames remain.

O1/O2 ARC/tracing controls cover out-of-order holes, stale tokens, generation
exhaustion, relocation, allocation failure, scope retirement, managed release
and shutdown. Negative variants restore restart-at-zero scanning, omit numeric
or managed release updates, omit shutdown reset or permit token wraparound.
The original wraparound control initially failed because the cursor also excluded
exhausted slots; restarting its deliberately broken search at zero restored the
intended negative case without changing expected status 46. All final focused
jobs pass. Earlier native runs `38705030679` and `38706130998` were cancelled as
superseded and supply no acceptance gate; the earlier successful WASM run is
also superseded by the final runtime run above.

All local workloads used `python3 scripts/local-guard.py` with unchanged limits.
Seven interpreter tape tests passed; the final token-slot change passed both
`ad_tape_ownership` and `autodiff_capacity_bounds` targets (four tests, 51.42s).
The workspace, nested-AD and scope targets passed all 14 tests (150.79s), and
final runner validation exercises them together with the final runtime.
Formatting, final all-target clippy (17.42s), actual generated-C measurement syntax
(0.95s), workflow lint (0.26s) and roadmap/link/commit audit (2.91s) passed.
A filtered unit-test command selected zero integration tests; separate commands
supplied the native results. Four-host report/per-file hash aggregation passed
in 0.28s and final archive/inspection annotation in 0.14s. Full builds, full gates
and benchmarks ran on GitHub.

The evidence publication changes docs only; compiler/runtime sources remain
those of measured `e0d073a7`.

## Boundaries

Sequential creation no longer rescans the occupied prefix. Arbitrary holes can
still require linear scanning. The native cursor adds eight static bytes, no
heap allocation. Registry capacity, the 65,535-slot limit and the 512 KiB numeric
workspace budget remain unchanged. Existing ARC admission and ownership limits
remain as documented in [ownership](ownership.md). Managed backward has physical
regression controls; the recorded instruction review covers numeric backward.

## Next action

Next: inspect PR #140's current head, checks and merge state. If open, require all
nine exact-head production jobs and documentation, plus the focused AD/WASM runs
linked above. Fix failures and squash merge with one line of at most 80 characters
and an empty body. If PR #140 has merged with those gates, step 10 is complete;
no implementation task remains from this follow-up. Do not replay old anchors.

Full builds, suites and benchmarks run on GitHub. Local checks stay serial and
guarded: preserve 64 GiB free disk, target below 2 GiB, sampled workload RSS below
1 GiB and the 180-second deadline.
