# Keeping loop state in local fields

The channel experiment found that each iteration allocated a tuple containing
its channel and counters. The values were needed, but the tuple object was not:
the loop only read individual fields and constructed the next state from them.
This candidate lets the existing loop generator recognize that pattern after
an action or branch. Focused cleanup checks pass on all six native platforms
and both WebAssembly hosts. All nine production gates and documentation also
pass; [PR #176 history](../roadmap-history.md#loop-state-and-known-function-calls-pr-176) records the exact head.

## What changes

`loop step` repeatedly calls `step` with its current state. `Again value` supplies
the next state; `Stop value` ends the loop with a result. `tap action` runs the
action and passes its original input onward. Tuple fields start at `.0`.
`make { 0 = f, 1 = g }` builds a tuple by applying both field functions to
the input. `sub 1` subtracts one; `concat "!"` appends an exclamation mark.
`! {IO}` in the signature permits printing. For example:

```fwp
step : (I64, String) -> Step[(I64, String), String] ! {IO}
step = if (.0 | eq 0) (.1 | Stop)
    (tap (.1 | echo)
        | make { 0 = .0 | sub 1, 1 = .1 | concat "!" }
        | Again)
main = (2, "hello") | loop step | echo
```

The state contains a remaining count and a string. This prints `hello`, then
`hello!`, then the final result `hello!!`. The action still runs before computing
the next state. The strings require storage; an extra tuple for every iteration
does not. The regression also keeps an alias of the initial tuple and checks
that it is unchanged, chooses records in different branches, and catches a
failure after an action.

Internally, an action leaves a match around the record passed to `Again`.
The compiler moves only the `Again` constructor through that match, preserving
its scrutinee and patterns. Every arm must end in a known record; existing shape
and ownership checks decide whether its fields can stay in local values.
Whole-value consumers and unproved resource lifetimes keep their existing
representation. This introduces no new syntax or runtime helper.

## Measured counts

[Run 39363807189](https://github.com/e6qu/fun-with-pipes/actions/runs/39363807189)
at `16adc74bc668312a60169a0c84f030fdac19ba49` passes on native Linux AMD64 and
ARM64. [The audited report](channel-loop-counts-2026-10-20.json) records 180
samples and 20 ordinary binaries with C and disassembly hashes. It uses the
[same five programs and measurement boundaries](channel-transfer-protocol.md)
as [the integrated PR #175 baseline](channel-count-integrated-2026-10-20.json)
at `f3c6f8d9`, run `39362629293`: GCC O2, LTO disabled, raw interpreter/native
output comparison, inputs 0/16/1024 and three fresh profiles. Hosts are AMD EPYC 7763 and Neoverse-N2, with GCC 13.3.0 on both revisions.
Both revisions include the preprocessing repair that excludes tracing code from ARC binaries.
The integrated baseline reproduces the previous `tap` allocation/retain/memory
counts; its executable sizes differ, so the size comparisons below use this
integrated build rather than mixing revisions.

Both architectures give these ARC counts per additional message, computed from
the difference between 16 and 1024 messages:

| Program | Allocation requests, before → after | Retains, before → after |
|---|---:|---:|
| Fresh text | 3 → 2 | 3 → 2 |
| Fresh function | 6 → 5 | 4 → 3 |
| Shared text | 2 → 1 | 6 → 4 |
| Shared function | 4 → 3 | 9 → 7 |
| Closed function | 3 → 2 | 2 → 1 |

At 1024 messages, peak managed charge drops by 32 bytes for fresh/closed cases
and 48 bytes for shared cases. Every ARC profile ends with zero charged storage
and no collections. Managed charge excludes raw buffers, allocator metadata,
stacks and total process memory. Input/output values and other allocations remain.
These are operation counts, not timing results or a comparison with C/Rust.

Ordinary ARC executable file sizes change by +48/+40/+32/−48/+4136 bytes on AMD64
and −96/−64/−80/−88/−32 bytes on ARM64, in table order. All five executable code
sections shrink: AMD64 `.text` changes by −432/−352/−1472/−832/−624 bytes;
ARM64 changes by −336/−208/−880/−256/−304 bytes. The AMD64 closed-function file
increase comes with 152 more bytes of unwind metadata (`.eh_frame`), pushing the
next data segment onto another 4096-byte file page. Its code section shrinks by
624 bytes. File size is therefore not just code size, and neither measures speed.

In the fresh-text binary, the executing loop moves from `work` (`w0`) into
`fwp_loop_fields7.constprop.0`; `work` tail-jumps to it after releasing its own
frame. The loop's own frame is 296 bytes on AMD64 (248 local bytes plus six
saved registers), down from 504, and 288 bytes on ARM64 including saved registers,
down from 464. The exchange worker remains 376/368 bytes on AMD64/ARM64.
AMD64 counts exclude the return address; ARM64 counts include the saved link
register. These are individual frames, excluding callees and total task-stack peaks.
Generated C now uses three state slots and has no state-record allocation in
the executing loop. Focused ownership run `39364385408` passes 47 integration
tests plus all compiler units on each native host, and 18 checks on each WASI
host, with none ignored or filtered. Separate Linux resource-field runs
`39365324259`/`39365327202` each pass 37 tests. Final production acceptance passed in PR #176.

## Calling known functions directly

After receiving a string, `option.map string.length` turns `Some text` into
`Some length` and leaves `None` unchanged. For this queue, a blocking receive
returns `None` when the channel is closed and empty.
The fresh-text program used generic function dispatch for that known length
function. An internal local alias hid its target from the optimizer. Propagating
a capture-free function reference exposes the direct call. Constant expressions
that evaluate or trap remain at their original evaluation point.

[Run 39366501786](https://github.com/e6qu/fun-with-pipes/actions/runs/39366501786)
at `75da96b81e76a2c77f42af3cec3ded1fe6f643bd` repeats the same protocol on both
Linux architectures. [Its audited 180 samples](channel-alias-counts-2026-10-20.json)
have exactly the same allocation, retain and managed-memory counts as the
loop-only revision above, at every input in both ARC and tracing modes.
The alias change removes dispatch, not another allocation or retain.

In ordinary ARC fresh-text binaries, the generated C calls the length function
directly. The actual exchange worker no longer calls `fwp_apply_owned`; GCC
inlines the UTF-8 character-count loop. Its own frame shrinks from 376 to 328
bytes on AMD64 and from 368 to 320 on ARM64, using the same frame accounting
as above. The enclosing loop frames remain 296/288 bytes. The fresh-text `.text`
section shrinks by 624/208 bytes, and the whole executable by 384/312 bytes,
on AMD64/ARM64 respectively. The other four cases have unchanged file and
section sizes. Neither code size nor frame size establishes a timing improvement.
The combined candidate passes focused ownership run `39366497033`: 62
integration tests plus all compiler units on each of six native hosts, and 18
checks on each WASI host, none ignored or filtered. Final production acceptance passed in PR #176.
