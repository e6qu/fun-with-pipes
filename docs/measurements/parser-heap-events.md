# fwp parser allocation events

**[Both native hosts pass at O1/O2](parser-heap-events-2026-11-09/README.md).** Extend the
[verified C/Rust parser observations](parser-native-allocator-2026-11-09/README.md)
to fwp's actual heap and region blocks. Keep the ordinary parser, its owning
function entry, worker thread and cleanup behavior.

## What is recorded

Run the existing 31-, 511-, 8,191- and 127-node inputs at GCC O1 and O2.
Generate C with the current compiler. Diagnostic copies add events at the existing
allocation and release sites; they do not replace the allocator with a wrapper.

| Event | Observation |
|---|---|
| Allocation / release | Actual address, request size, charged size and runtime live-byte counter |
| Resize | Old/new addresses before allocation, before copy and after old release |
| Region block | Separate heap allocation, 24-byte owner header and available payload |
| Region node | Address, size and offset within its still-live block |
| Region release | Logical block cleanup followed by its actual physical free |
| Five parser checkpoints | Input/runtime baseline, independent live/peak counters and node count |

For example, a 256-byte region allocation contains a 24-byte header and 232 bytes
of node space. Three nodes occupying 16 + 16 + 24 bytes leave 176 unused payload
bytes. Report the full 256-byte allocation and the 56-byte node content separately;
adding both would count the nodes twice.

An independent address ledger reconstructs every live allocation and peak, then
checks the runtime counters. A resize's old and new storage must coexist at the
copy event. Each node must fit at the next aligned position in its block. Every
parser allocation must be physically released; the caller's input remains alive.

## Scope and controls

- Exclude input/runtime storage already live at the first checkpoint, recording
  that baseline explicitly. Report requested bytes and charged bytes separately:
  fwp charges size-class slots for small allocations and request sizes for large
  ones. Neither quantity measures unused heap pages, metadata or reserved space.
- Region blocks are heap allocations. Their nodes are subdivisions, with no
  per-node owning count; region storage is not stack storage.
- Compare all eight diagnostic results with ordinary execution and the independent
  input oracle. Reject eight deliberately wrong expected results.
- At both optimization levels, actually omit region freeing, omit allocation
  events or misreport slot size. All 24 controls must fail their intended check;
  a logical cleanup event alone cannot prove storage was released.
- Five reader tests cover balance, missing events, wrong charges, invalid region
  addresses and releasing resize storage before copying.
- Preserve complete compressed command output, source/binary hashes and failures.
  Bound each trace to 131,072 events. Diagnostic time and RSS are not performance
  measurements; ordinary [process measurements](parser-process-accounting-2026-11-09/README.md)
  retain those separate scopes.

Run `suite=parser-heap-events` with an explicit immutable `parser_memory_tag`.
Builds and native executions run on Linux ARM64/AMD64 runners. This adds evidence
to [milestone 4](../../PLAN.md#current-work-ownership-comparisons); final native
production gates still cover all supported systems.
