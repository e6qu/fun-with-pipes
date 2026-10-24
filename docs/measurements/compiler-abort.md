# Intel macOS compiler abort: investigation

The compiler aborted while checking a console program in [PR #210's original
CI run](https://github.com/e6qu/fun-with-pipes/actions/runs/40091968517/job/120866324330).
**The cause remains unknown. Passing reruns are not a repair.** This investigation
must finish before accepting that PR. See [the handoff](../development-state.md)
for the current action.

## What the crash establishes

Source `281b54d9193b432bb808b4387cc0a4dad34dacba` passed nine of ten gates.
The sole failure was `console_input_matches_raw_interpretation` on Intel macOS
15.7.9. All completed job logs were reviewed. The compiler aborted before C
generation; no generated program was running in that process.

The saved crash report identifies a system allocator abort while freeing a
56-byte boxed return type. `TypeTable::open_call` had cloned a function type to
inspect its shape; destroying that temporary reached the failing `free`.
The front-end files are unchanged from the accepted base, and the examined path
uses owned Rust values. No incorrect clone instruction has been identified.

The recovered compiler has the crash report's exact Mach-O UUID
`42cd802d-3482-3779-acce-42251ea4f37d`, SHA-256
`a1b8814ba52f50042ac946a508bd8305ff1a7334284928fcfc2bd315ae1a5736`.
It was built with Rust 1.99.1, O1, debug assertions and overflow checks.
System allocator UUID `b26a86b5-a181-367c-89ea-d1ed5545ef77` also matches.
Disassembly and preserved report flags are consistent with freeing a pointer
that the allocator does not recognize; the report does not preserve that pointer.

The report also records virtual-memory allocation failures and a 4 GiB reserved
worker stack. Reserved address space is not resident memory. These observations
do not establish stack exhaustion, out-of-memory failure, or its cause.

## Experiments and limits

| Run | Result | What remains unknown |
|---|---|---|
| [40100186269](https://github.com/e6qu/fun-with-pipes/actions/runs/40100186269) | 2,632 ordinary, 360 heap-checked and 340 sanitized compilations completed without a finding; two batches hit deadlines | Partial runs do not establish success or explain the abort |
| [40103957497](https://github.com/e6qu/fun-with-pipes/actions/runs/40103957497) | 360 ordinary and 90 nightly-ASan compilations; three original two-worker test-neighborhood runs passed | Nightly sanitizer instrumentation changes the compiler; passing runs are not a causal fix |
| [40105746847](https://github.com/e6qu/fun-with-pipes/actions/runs/40105746847) | Exact recovered compiler passes 18 ordinary compilations; Guard Malloc fails to start its worker, exit 101/EAGAIN | This startup failure precedes inference and differs from the original abort |
| [40106733779](https://github.com/e6qu/fun-with-pipes/actions/runs/40106733779) | C creates 64–4,096 MiB stacks successively in one process; debugger experiment times out | Earlier stack allocations may affect later ones; no passing guarded compilation |
| [40107961231](https://github.com/e6qu/fun-with-pipes/actions/runs/40107961231) | Asynchronous debugger confirms Guard Malloc startup failure with the unchanged 4 GiB request | No heap corruption observed; inference was not reached |
| [40113866689](https://github.com/e6qu/fun-with-pipes/actions/runs/40113866689) | Fresh C processes pass both sizes; Rust passes 256 MiB but fails 4 GiB only under Guard Malloc. The smaller-stack compiler reaches declaration collection, then hits its 120-second deadline | No invalid access was reported; inference was not reached, so this is not a passing heap check or an abort repair |
| [40114625111](https://github.com/e6qu/fun-with-pipes/actions/runs/40114625111) | Pending: ASan with production Rust 1.99.1, O1 and checking settings | Removes the earlier nightly-toolchain difference; instrumentation still changes generated instructions |

Guard Malloc places allocations beside protected pages to expose invalid memory
access. Its extra memory requirements can change startup behavior. ASan
(AddressSanitizer) instruments accesses to detect memory errors. Neither tool's
clean run proves the absence of an intermittent bug.

## Repairs made during diagnosis

macOS's allocator can suppress messages when stderr is captured. CI now requests
`MallocDebugReport=stderr`, saves crashed compiler images, and logs each named
console input. These changes improve evidence; they do not repair the abort.

That reporting exposed a separate sanitizer-test issue on both Mac architectures:
the nano allocator could not reserve address space alongside ASan. The healthy
kernel probe printed its normal result but failed its empty-stderr assertion.
This was reproduced locally. The sanitized child now explicitly selects
`MallocNanoZone=0`; error reporting remains enabled. O1/O2 healthy probes pass,
and deliberately removing either the stack bound or constant conversion still
fails. CI retains their C, binaries, stderr and exit statuses.

The diagnostic change also introduced a Clippy needless-borrow error. That is
repaired. Native tests now run even if lint fails, and Python SDK checks explicitly
build their required compiler, so an earlier failure cannot hide independent test
results. Final-head CI is still required.

## Saved evidence

GitHub artifacts are the remote originals. Local verified copies are under
`/private/tmp/fwp-list-copy-console-failure` (original report/log),
`/private/tmp/fwp-console-crash-image` (matching compiler),
`/private/tmp/fwp-console-diagnostic-v3-evidence` (completed repeated checks), and
`/private/tmp/fwp-console-allocation{,-v2,-v3,-v4}` (allocator experiments).
Their `artifact.json` files and retained ZIPs record SHA-256 verification.
Local kernel failure/fix evidence is in
`/private/tmp/fwp-kernel-malloc-report{,-fixed}`.

The historical #146 abort remains unexplained too. Five available cancelled Intel
logs gave no additional cause; three old logs were unavailable. Those results are
in `/private/tmp/fwp-historical-compiler-abort`. Do not equate the two incidents.
