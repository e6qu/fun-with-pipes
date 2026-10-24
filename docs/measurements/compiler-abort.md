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
uses owned Rust values. No source lifetime defect has been identified there.

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
| [40114625111](https://github.com/e6qu/fun-with-pipes/actions/runs/40114625111) | All 90 compilations passed with production Rust 1.99.1, O1 and checking settings; full log and verified archive have no finding | Removes the earlier nightly-toolchain difference; instrumentation still changes generated instructions |

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

## Source lifetime review

The investigation now follows source ownership and cleanup, at the user's request.
No further allocator-cookie or disassembly-led experiments are planned.

Macro invocation bypassed the interpreter entry method that joins child tasks on
success and cancels them on failure. A regression invokes two macros that spawn
printing children. The existing compiler accepts the program but prints neither
child message. The candidate routes macros through `call_root`, with their
explicit arguments, and uses the same entry method for `comptime`. The original
nine failing-test inputs do not invoke macros: this repair is not a causal
explanation of that abort. Candidate compiler validation remains pending.

The wider review found background gRPC workers excluded from child joining even
though they borrow the program and writers. The candidate now closes the pool,
cancels and joins background workers before entry return, and propagates Rust
panics only after cleanup. Blocking calls restore the scheduling turn during
unwinding. Public entry methods enforce this boundary; writers require `Send`,
and task handles cannot cross arbitrary Rust threads. Shared, locked writers
replace raw pointers. Repeated cleanup, panic
and writer-lifetime tests accompany these changes. The core cleanup
passed 232 focused checks on each of Linux AMD64 and Intel macOS in run
[40119693758](https://github.com/e6qu/fun-with-pipes/actions/runs/40119693758),
source `2f20e7fe075e2beb0fa6fae3f3950ebfc6953a9e`. The shared-writer follow-up
`6cefdf2346ade8fcd9e3130ad7bab21e38589429` passed 234 checks per host in
[40121036264](https://github.com/e6qu/fun-with-pipes/actions/runs/40121036264).
The final shutdown batch adds an abort guard for a panic during cleanup itself
and drains connections registered while shutdown waits for workers. Its focused
checks and full delivery acceptance remain pending.

For the original console inputs, source review follows `main::build` through
`driver::compile_file`, parsing, macro expansion and type checking. There are no
macro invocations, so expansion does not construct an interpreter or foreign
bridge. Decimal C conversions happen later during lowering. The reviewed parser,
environment, inference and type-table code uses owned Rust data, without unsafe
blocks or custom allocation. `open_call` and `resolve` clone and move owned types;
no source lifetime defect was found there. This narrows the review but does not
prove an allocator or compiler-toolchain fault.

## Saved evidence

GitHub artifacts are the remote originals. Local verified copies are under
`/private/tmp/fwp-list-copy-console-failure` (original report/log),
`/private/tmp/fwp-console-crash-image` (matching compiler),
`/private/tmp/fwp-console-diagnostic-v3-evidence` (completed repeated checks), and
`/private/tmp/fwp-console-allocation{,-v2,-v3,-v4}` (allocator experiments).
Their `artifact.json` files and retained ZIPs record SHA-256 verification.
Local kernel failure/fix evidence is in
`/private/tmp/fwp-kernel-malloc-report{,-fixed}`.
The production-toolchain ASan archive and completed coverage/hash receipt are
`/private/tmp/fwp-console-stable-asan.zip` and
`/private/tmp/fwp-console-stable-asan-review.json`.

The historical #146 abort remains unexplained too. Five available cancelled Intel
logs gave no additional cause; three old logs were unavailable. Those results are
in `/private/tmp/fwp-historical-compiler-abort`. Do not equate the two incidents.
