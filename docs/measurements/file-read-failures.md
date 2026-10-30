# File-read allocation failures

**Focused ARM64 macOS and AMD64 Linux checks pass; complete platform verification is pending.** These controls extend the
[application suite](../application-acceptance.md) beyond directory allocation
failures. They are cleanup tests, not timing measurements or C/Rust comparisons.

The fixture reads a 150,000-byte ASCII file twice. Its text form concatenates the
two strings and counts 300,000 characters. Its byte form sums the two byte counts
and also returns 300,000. Raw and optimized interpretation must agree before the
native probes run. A generated callable entry preserves the ordinary compiler's
argument owners and exceptional cleanup.

At the first or second read, inject a recoverable trap immediately before:

- The first scratch-buffer allocation, with a file handle already open.
- Buffer growth, while earlier bytes and the handle are still live.
- Final string/byte-result allocation, after the handle closes but before scratch
  storage is released.

Each case runs four times, both with and without a caller-held path alias:
48 failures per program and optimization level. Every failure must unwind the
actual generated cleanup stack, preserve the alias's bytes and count, release
scratch and partial managed values, close the handle, and allow a successful
retry. The text form also keeps its first read result across the second read.

Separate ledgers track successful opens/closes, actual scratch capacity and live
managed allocation identities. After cleanup, all must return to their initial
values. Deliberately omitted closes, scratch frees and managed frees must fail
the corresponding observer with statuses 241, 242 and 243. These controls must
fail before process teardown; a clean process exit is insufficient evidence.

Separate subprocesses exercise terminal exhaustion at the same six boundaries.
They call the production OOM handler and must exit 102 with `fwp: out of memory`.
They do not exhaust the runner or claim recovery/pre-exit cleanup for terminal OOM.

`tests/text_file_tools.rs` runs the probes with production C compilers at O1/O2.
It retains the fwp inputs, generated C, native images and every output/status
under `FWP_ARC_ARTIFACTS`. Use `suite=file-applications` for focused execution;
normal production assignments already include this test target on all six hosts.
A skip or one passing host does not establish complete platform support.

At source `f03575260a6d7a1c3508d65e934dd5847ce5b807`, the
[ARM64 macOS run](https://github.com/e6qu/fun-with-pipes/actions/runs/41049305186/job/124041117692)
passes 11 tests in three targets, including these controls. The complete log has
no compiler warnings or other failures. Artifact `12973813560` retains all
40 allocation-boundary executions: 192 recovered traps with retries, 12 deliberate
cleanup omissions and 24 terminal OOM exits. An independent audit verifies every
output/status, exact one-define changes in omission controls, and native ARM64
headers. The existing 40 application binaries and 80 saved executions also match
the report hashes.

The [AMD64 Linux GCC run](https://github.com/e6qu/fun-with-pipes/actions/runs/41049886906/job/124043037136)
also passes 11 tests/three targets at the same source. Its full log and all 40
saved boundary executions pass the same independent audit, including native
AMD64 headers and exact omitted-cleanup controls. Artifact `12973978657` retains
the evidence. The admission inventory accepts 82 programs and records its three
expected compile-time failures. Complete final-head platform coverage remains
required before delivery.
