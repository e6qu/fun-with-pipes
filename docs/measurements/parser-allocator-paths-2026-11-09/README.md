# Native allocator paths: retry verified, mapped observation under repair

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

Both ordinary mapped executions succeed. The observer stops at an inlined
`mremap_chunk` call in its parent, where parameter `p` does not exist. Its prepared
repair observes the actual `__mremap` call and checks the returned mapping extent
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

[Documentation passes](https://github.com/e6qu/fun-with-pipes/actions/runs/42684257355),
job `129386712159`. [File hashes](files.json) cover all compact text records and
complete native/docs logs. Original binaries remain in the named artifacts.
