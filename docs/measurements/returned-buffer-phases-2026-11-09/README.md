# Returned-buffer phase checks

These check the [phase experiment](../returned-buffer-phases.md); they are not
performance samples. The first run found an ARM64 linking error, so the experiment
is not yet verified on both architectures.

Source `c0f187899` in run
[42596304052](https://github.com/e6qu/fun-with-pipes/actions/runs/42596304052):

| Check | AMD64 | ARM64 |
|---|---|---|
| Factory/caller correctness | 48 builds, 528 native and 14 interpreter checks pass | Same coverage passes |
| Phase callers | 16 builds and 120 result/error/clock checks pass | C/Swift/fwp: 12 builds and 90 checks pass; four Rust links fail |
| Actual timer failure controls | 64 checks pass | 64 checks pass |

All four Rust failures have the same cause. The clock object was passed through
`-C link-arg`, after Rust's system-library arguments. ARM64's stack-protection
symbol `__stack_chk_guard` was then unresolved. The repair declares the clock as
a [native static library](https://doc.rust-lang.org/rustc/command-line-arguments.html#-l-link-the-generated-crate-to-a-native-library),
placing it in the normal library link order. Stack protection stays enabled.
The backward-clock control also selects an actual replacement native library.
The shared builder applies this repair to phase checks, profiles and timings.
Repair verification remains pending.

All raw commands, failed groups and completed groups were reviewed. Apart from
the four link errors, diagnostics are the specified bad-argument, wrong-result,
backward-clock and omitted-release controls. Setup reports an absent optional
C++ manual page; no compiler warning is hidden by that notice.

Both documentation runs pass: `42596307425` at `c0f187899` and `42597991838` at
`8caeaa606`. Their complete logs include intentional failing-child/test-runner
controls, with no unexpected failure. Each checks 406 link sets and 106 immutable
preparation pairs. These runs do not verify later timing-reader changes.

[Artifact metadata](first-artifacts.json) records full source IDs and archive
identities. Compressed reports, commands and complete job logs are retained here.
Small archive members were fetched by HTTP range and checked against their ZIP
CRC; the full archives were not downloaded or independently hashed.

## First native allocation run

[42597991401](https://github.com/e6qu/fun-with-pipes/actions/runs/42597991401)
at `8caeaa60612b40b04900550e07c493178300d8d7` fails on both architectures:

- **ARM64 Rust:** all five links have the same clock-order error described above.
  C and Swift still complete their 40 profiles. Missing Rust groups remain failures.
- **AMD64 Rust:** all 20 profiles run, but attribution misses the factory because
  heaptrack keeps rustc's v0 symbol, such as `_RNvCs…_15returned_buffer4make`.
  The original zero attribution is a failed observer, not allocation-free Rust.
- **Swift on both:** all 20 profiles run. The factory subtree includes 27 one-time
  generic-metadata requests and 256 AMD64 / 264 ARM64 metadata bytes at exit.
  Raw stacks identify concrete-type initialization and runtime metadata caches.
  The actual contiguous-array allocation path shows zero bytes at ordinary exit;
  deliberately omitted destruction retains array storage.

The repair recognizes the recorded Rust factory symbol and separates Swift
array-storage stacks from type-initialization stacks. It retains both, plus the
unfiltered factory total, and rejects unfamiliar Swift factory paths. Zero live
array storage remains required; native runtime metadata is reported explicitly.
Ordinary/control metadata requests and exit bytes must agree. These repairs have
not yet passed the new native run.

[Profile archive identities](profile-first-artifacts.json), compressed reports,
complete job logs and selected raw stacks are retained here. The bounded local
reader refused the large raw-command member; it remains in the remote archive.
No full-archive hash or complete raw-command audit is claimed for this first run.
The next runner suite performs that complete audit, including reconstruction of
the original faulty observer and the corrected attribution. Setup notices about
optional C++ manual pages and libtool's installation-time relinking are retained;
they do not report compiler failures.
