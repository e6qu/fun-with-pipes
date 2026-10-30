# File-read allocation failures

**Implemented, not yet verified.** These controls extend the
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
A skip or one passing host does not establish complete platform support. Record
the actual source, runs and audited outcomes here after execution.
