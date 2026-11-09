# Parser allocation observer: first native failures

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
