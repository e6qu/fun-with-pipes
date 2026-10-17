# Session handoff

Updated 2026-10-17 UTC. This preparation is `move-unique-closure-captures`,
worktree `/private/tmp/fwp-closure-capture-moves`. PR #155 remains the only delivery;
the root worktree tracks its final gates. Preserve the seven open roadmap areas.

## Verified cache component

The cache component passed all six native hosts in `38994414068` at
`886dad3bd4c75c57c5cd53040b20a039be46437b`, tagged
`evidence/remote-cache-owners-20261017`. Report/docs commit `63728741` is included.
See [the comparison](measurements/remote-client-cache-ownership-2026-10-17.json).
It removes the original baseline's 64-byte-per-integer retained growth. Whole
connections, streams, decoder captures and repeated-call storage remain open;
remote calls still require tracing. Focused evidence is not full production
acceptance.

## Move captures from consumed unique closures

Probe `38995160889` at `e189c868` passed on Linux AMD64. It includes existing
closure, constructor, runtime-call, partial-argument and thunk ownership tests,
wide-counter failure controls, new exact capture-transfer cases, cache controls,
primitive audit and complete-client measurements. The next step is all six hosts.

A closure stores values for a later function call. The candidate transfers those
owners when consuming an exclusive closure, both for partial application and
callee entry. Shared closures still duplicate by type. It clears the consumed
closure's capture count after copying to the destination. There is no allocation,
suspension or trapping operation between transfer and the destination taking
responsibility. Callee ownership covers errors/traps after entry; runtime cleanup
still releases the empty consumed closure. No new syntax or closure fields.

The one-pass client at 16,384 integers now performs 49,154 effective retains,
down from the cache component's 81,921 (about 40% fewer). At 64/1,024/16,384,
counts are 194/3,074/49,154: roughly three per integer instead of five. Moving a
continuation's captures also avoids an artificial second owner of its position,
allowing the next read to move its saved result. Final charge remains 6,480 bytes;
peak falls from 6,832 to 6,768. All three repetitions agree. Allocations remain
five per integer; no timing or C/Rust parity claim. Retained histories still need
sharing; remaining wrapper retains and allocations are separate work.

New controls require zero capture retains for unique partial/full calls, typed
retains for shared calls, preserved aliases and pointer-looking scalar values,
normal/error/trap cleanup and no remaining managed storage. Deliberately restored
duplication and stealing shared captures fail. Generated language output agrees
with raw interpretation; collector/reuse stress passes. Earlier probe `38994754283`
found two test assumptions: concatenation order and rounded freed-byte statistics.
Both are repaired. Failed-call reclamation now checks exact zero retained bytes
after 10,000 failures rather than a rounded gap that included copied captures.

The collector's explicit `--capture-moves` option requires these controls and
retains per-case counts and binaries. Its `--baseline-report` should name the
verified cache report for the next comparison. The binary inspector also saves
dynamic application instructions. Full builds and executions remain on GitHub;
local checks use the root guard with unchanged limits. Guarded formatting passed
in 1.14s, evidence-tool syntax in 0.20s and the passing-probe download in 3.26s.
No downloaded executable ran locally.

Next: validate all six native hosts, collect the comparison against the cache
component and inspect actual binaries. After #155's verified merge, assemble one
substantial delivery from accepted main, update PLAN/history/handoff and require
all final production gates. Do not open a second PR while #155 is active.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Typed stream and external owners; remove tracing |
| 2 | In progress | Remove intermediate storage and unnecessary reference counts |
| 3 | In progress | Reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Repeated, comparable performance measurements |
| 7 | In progress | Larger representative applications |

The six-host run `38995678897` at `12c807d2` passed Linux and macOS on both
architectures. Both Windows jobs exposed identical fixture portability defects:
four C diagnostic assertions expected LF, and spawn failure injection used Unix
`mmap`. The diagnostics now normalize CRLF while retaining exact message checks;
language output comparisons remain byte-for-byte. The spawn probe injects failure
at native `CreateFiberEx` on Windows and `mmap` on Unix, verifies the injection
was reached, and retains all three deliberately broken cleanup controls.
Windows production now includes all seven closure/unwind targets from the probe.
These repairs need a fresh six-host run on a common revision before collection.
Guarded `cargo fmt --all -- --check` passed in 1.05s. No native test ran locally.
