# Native allocator paths: mapped resize and arena retry verified

Both controls pass on Linux ARM64 and AMD64 at
`bb0add788321eb30068889b4961667d1f858d3a1`, tag
`roadmap/parser-mapped-boundary-2026-11-09`,
[run 42686754531](https://github.com/e6qu/fun-with-pipes/actions/runs/42686754531).

| Host | Job | Artifact |
|---|---|---|
| AMD64 | `129395531588` | `13704678347` |
| ARM64 | `129395531599` | `13705343913` |

Each host passes five parser builds, eight ordinary/observed result pairs, four
actual omitted releases and both allocator controls. All 35 complete command
records have successful exits and empty stderr. The retained compact records
match 36 original file hashes per host; native binaries remain in the artifacts.
Full job logs contain no outstanding warnings or errors.
[The repaired source's documentation check](https://github.com/e6qu/fun-with-pipes/actions/runs/42686761614)
also passes, job `129395546461`; its complete log is retained.
Its deliberate invalid-target, timeout and failed-test controls remain visible;
the surrounding test suite passes.

The mapped control grows 1 MiB to 4 MiB. The actual successful `__mremap` return
replaces the old mapping; the final live chunk header confirms its new extent.
Both hosts show 4,194,304 peak requested bytes and 4,198,400 owned chunk bytes.
There is no observed second live allocation to count. Original bytes survive,
and the final release leaves no caller-owned allocation.

The real two-arena retry passes on both Linux hosts. A main-arena resize fails
under this process's address-space limit, then succeeds using storage already
available in the worker's arena. The original 128 bytes remain intact. Internal
events establish replacement allocation before old release; cleanup releases
both the resized value and its 128-byte barrier allocation.

| Quantity | Bytes, both hosts |
|---|---|
| Requested peak at public-operation endpoints | 1,048,704 |
| Requested peak including old/new coexistence | 1,048,832 |
| Observed owned chunk peak | 1,048,880 |

These are controlled allocator observations, not parser inputs or timing results.
[The protocol](../parser-native-allocator.md#additional-native-path-controls)
defines the thread handoff and process-local allocation policy.

## First run and mapped-path repair

Source `5ead19840740aec3a352b982c578d2d6af7fe2a4`, tag
`roadmap/parser-allocator-paths-2026-11-09`,
[run 42684252690](https://github.com/e6qu/fun-with-pipes/actions/runs/42684252690):

| Host | Job / artifact | Outcome |
|---|---|---|
| AMD64 | `129386709132` / `13703714833` | All parser traces, omitted releases and arena retry pass; mapped observation fails |
| ARM64 | `129386709232` / `13703034930` | Same outcome |

Both original ordinary mapped executions succeeded. The observer stopped at an
inlined `mremap_chunk` call in its parent, where parameter `p` did not exist. The
verified repair observes the actual `__mremap` call and checks the returned mapping extent
against libc's final live chunk header. It retains the matching distro source
for that boundary and never reads an old mapping after a successful move.

The first mapped control also initializes libc's thread-cache metadata inside
the observation. That storage is not owned by the caller. The control now warms
the allocator before the first checkpoint, as the real parser does while reading
input, and the reader rejects unattributed internal storage. Existing accepted
parser/retry records still reconstruct under the stricter check.

Eight reader tests include remap success/failure, copy overlap, missing return,
metadata attribution and explicit thread handoff. A failed remap followed by
copy remains a synthetic case; no native execution of that path is claimed.

[Original documentation passes](https://github.com/e6qu/fun-with-pipes/actions/runs/42684257355),
job `129386712159`. [File hashes](files.json) cover original and repaired compact
records and complete logs. [The reconstructed summary](summary.json) retains every
accepted parser trace and both controls. Failed-remap copying remains unverified
by native execution; these results are not a universal allocator-internal peak.
