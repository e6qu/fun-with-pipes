# Returned-buffer phase checks

Phase callers and native storage checks now pass on Linux ARM64 and AMD64.
These verify the [experiment](../returned-buffer-phases.md); no peer timing
experiment has run yet. The original failures and their repairs follow below.

## Verified results

Source `ec9313228681689daa4c20c495edd8b5f9faa583`, retained as
`roadmap/returned-buffer-observers-2026-11-09`:

- [Phase run 42600727564](https://github.com/e6qu/fun-with-pipes/actions/runs/42600727564):
  each host passes 16 phase builds and 120 result/argument/backward-clock checks,
  plus the original 48 builds, 528 native and 14 interpreter checks.
- [Storage run 42600729662](https://github.com/e6qu/fun-with-pipes/actions/runs/42600729662):
  each host passes 60 profiles across 15 native builds, including actual omitted
  first/last owner releases and allocator/unwinder controls.
- Docs `42600729223`, job `129104245085`: four pilot/sample-reader tests, three
  allocation-reader tests and the complete audit pass (407 link sets).

For 65,536 arrays of 16 integers, both hosts and both repetitions find these
native storage requests per array. Bytes are derived from storage retained by the
omitted-release control, divided by the number of arrays; they exclude allocator
rounding, caller slots, runtime metadata and RSS.

| Representation | Requests per array | Requested bytes per array | Empty-array bytes |
|---|---:|---:|---:|
| C unique | 1 | 128 | 0 |
| C shared counter + elements | 1 | 136 | 8 |
| Rust `Vec` | 1 | 128 | 0 |
| Rust `Rc<Vec>` | 2 | 168 | 40 |
| Swift native `Array`, either owner mode | 1 | 160 | 0 |

Ordinary release leaves zero array-storage bytes at exit in every case. First
shared releases preserve usable elements; omitting either owner retains their
storage. Swift additionally makes 27 one-time type-metadata requests, with
256 AMD64 / 264 ARM64 bytes still present at exit. These appear separately and
in the full factory totals. fwp's managed heap is a different boundary; this
table is not a native-byte comparison with fwp or an ARC-operation count.

Both runners also verify the complete first profile ZIP hashes/manifests, all
324 AMD64 / 234 ARM64 commands and raw allocation stacks. The only failing child
commands are the five original ARM64 Rust links. Successful commands have only
heaptrack statistics on stderr. Original faulty summaries are reproduced before
the corrected interpretation; the earlier failed runs remain failed records.

[Verified archive identities](verified-artifacts.json), reports, first-archive
audit/diagnostic receipts and complete job logs are retained here. Current large
ZIPs were not downloaded locally; selected members have ZIP CRC verification.
The complete first ZIPs were independently hashed on runners. Setup's optional
manual-page and libtool relink notices are retained, with no unexpected compiler
or program diagnostic.

## First phase run

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
The verified run above checks the repair on both architectures.

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
Ordinary/control metadata requests and exit bytes must agree. The verified run
above checks these repairs with fresh profiles on both hosts.

[Profile archive identities](profile-first-artifacts.json), compressed reports,
complete job logs and selected raw stacks are retained here. The bounded local
reader refused the large raw-command member; it remains in the remote archive.
The later runner suite performs the complete archive/command audit described
above, including the original faulty observer and corrected attribution. Setup notices about
optional C++ manual pages and libtool's installation-time relinking are retained;
they do not report compiler failures.
