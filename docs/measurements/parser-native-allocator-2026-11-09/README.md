# Actual C/Rust parser allocation peaks

**Both native hosts pass.** At 8,191 nodes, both parsers reach **425,984 requested
bytes** while old and replacement storage coexist, versus **327,680 bytes** at
public-operation endpoints: an extra 98,304 bytes, or 30%. Their observed owned
libc chunk peak is 434,192 bytes. Endpoint capacity alone misses the overlap.

Repair source `62775d559`, tag `roadmap/parser-native-allocator-repair-2026-11-09`,
[run 42680540810](https://github.com/e6qu/fun-with-pipes/actions/runs/42680540810):
AMD64 job `129373593731`, artifact `13703180659`; ARM64 job `129373593563`, artifact
`13701977978`. Each passes five builds, eight ordinary results, eight actual traces
and four deliberately omitted releases. Complete logs contain no warnings/errors.

Both architectures give these values, in **bytes**:

| Input | Peer | Endpoint requests | Requests including observed overlap | Owned chunk peak |
|---|---|---|---|---|
| 31 nodes | C / Rust | 1,280 | 1,280 | 1,312 |
| 511 nodes | C / Rust | 20,480 | 20,480 | 20,512 |
| 8,191 nodes | C / Rust | 327,680 | 425,984 | 434,192 |
| 127 left-nested nodes | C | 5,120 | 6,656 | 6,704 |
| 127 left-nested nodes | Rust | 5,120 | 5,120 | 5,152 |

The actual left-nested C resize moves; Rust grows in place in these executions.
Do not assume a universal resize policy from one input. No successful mapped
remap or arena-retry copy occurred here; their synthetic reader controls are
not native verification. These are owned allocation extents, **not** retained
allocator pages, whole-process RSS or maximum kernel-internal storage.

[Complete text records](files.json) retain original C/Rust sources, matched
glibc source, all events, commands, manifests and full logs. All eight observations
and four faults reconstruct per host. [Derived results](summary.json) preserve
every operation classification. Binaries remain in the named original artifacts.
[fwp's separate heap and region observer](../parser-heap-events.md) is pending.

## Retained first failures

Source `19b8b48fe2fde8e697dfdc2923303c3a3928c3b0`, tag
`roadmap/parser-native-allocator-2026-11-09`,
[run 42679061783](https://github.com/e6qu/fun-with-pipes/actions/runs/42679061783).

| Host | Job / artifact | Result |
|---|---|---|
| AMD64 | `129368372898` / `13701761890` | Five builds and eight ordinary parser results pass; all 12 observed/fault executions fail |
| ARM64 | `129368372298` / `13700918738` | Same outcome |

The observer, not the ordinary parser, failed. It lost returns through tail calls;
Rust inspection also used C expression syntax in a Rust frame and disabled
auto-loading too late. No internal parser peak is accepted from this run.

Compressed reports retain every failed command and traceback; raw first-phase
events and complete job logs remain alongside them. [File identities](files.json)
cover these records. Original binaries and journals remain in the named artifacts.
[Documentation passes](https://github.com/e6qu/fun-with-pipes/actions/runs/42679066951),
job `129368381461`.

[Observer contract and repair](../parser-native-allocator.md) ·
[Current next action](../../development-state.md)
