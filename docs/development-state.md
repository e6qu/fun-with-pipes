# Session handoff

Updated 2026-10-16. Independent preparation in `/private/tmp/fwp-wasi-arc`,
branch `checked-wasi-ownership`, anchored at `e5e05748`. Transfer only changes
after that anchor; its parents belong to the preceding zip/list/text delivery.
Do not replay them.

[PR #149](https://github.com/e6qu/fun-with-pipes/pull/149) is accepted and merged as
`58ed740c`. The only open delivery is now
[PR #150](https://github.com/e6qu/fun-with-pipes/pull/150), at
`7a7b40e1878ea062f64eceded6ae029b4124f976`. It combines zip elimination, list cleanup
and text-file ownership. Both Windows fixture repairs pass in `38850334050`,
alongside the earlier four Unix and two actual-WASI focused checks. Final production
[38851567232](https://github.com/e6qu/fun-with-pipes/actions/runs/38851567232) and
[docs 38851565415](https://github.com/e6qu/fun-with-pipes/actions/runs/38851565415)
are pending. The root worktree owns that handoff. This WASI preparation has no PR.

Standing authorization covers fixes, publication and squash merge after all nine
production jobs plus documentation pass for the exact final head. Commit subjects
are one line, at most 80 characters, with empty body and no trailers/attribution.
JIT is excluded. Local checks use `python3 scripts/local-guard.py COMMAND...`
without raising limits; full builds/gates and measurements run on GitHub.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion. None of its seven whole areas is done.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Prove checked ownership for synchronous WASI entries |
| 2 | In progress | Accept preceding zip/list allocation and cleanup changes |
| 3 | In progress | Preserve preceding native instruction and count evidence |
| 4 | In progress | Accept reduced derivative intermediates; broader costs remain |
| 5 | Pending | Broaden CPU kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Retain comparable timing and physical storage evidence |
| 7 | In progress | Extend maintained-program checks across deployment boundaries |

Next: validate physical storage after ordinary shutdown on both actual WASI hosts.
The current observer repair includes controls for missing object frees and omitted
autodiff shutdown. Fix any failures before describing WASI ARC as supported.
Monitor #150 concurrently; only one delivery PR may be active.

## Scope and acceptance before implementation

WASI is a WebAssembly environment that supplies standard streams and file access.
The current compiler rejects `--gc arc` for every WebAssembly target, although
its runtime already uses typed destruction and an out-of-line count table there.
Unlike native tracing, WebAssembly cannot scan engine-held locals. Unproved
shared values therefore remain retained today; removing the rejection alone
would not establish checked ownership.

The candidate must use the existing compiler ownership checks, reject a counted
owner escaping to permanent shared retention, and distinguish removal of count
metadata during legitimate last-owner destruction from sharing. Startup must
reject requests for tracing/stress/reuse-retention just as native ARC does.
No new surface notation, fallback memory mode, JIT or backend is proposed.

Initially reject browser entry points and asynchronous host fibers until their
retained callbacks and re-entry lifetimes have evidence. Native behavior must
stay covered. Also reject native-library build flags combined with a WebAssembly
target: the current library branch ignores that target instead of producing a
WebAssembly library. No new library ABI is in scope.

Acceptance needs actual WASI O1/O2 execution, raw-interpreter agreement for
collections, closures, text files and scoped derivatives, repeated main/function
and CLI workloads, and both live-count and actual malloc/free evidence. Counts
alone do not prove physical reclamation. Include deliberately missing free/share
guards, overflow and unwinding controls, invalid mode options, and required
toolchain assertions rather than skips. Inspect emitted modules for absent
tracing. Native six-platform regressions and the final nine-job gate still apply.

The prototype separates count removal from rejected sharing, applies the same
ARC environment checks to both allocators, allows synchronous WASI targets,
and rejects browser/service/host-fiber entry and WebAssembly library flags.
The actual-WASI suite is required on both Linux production hosts; focused suite
`wasi-arc` runs it alongside native ARC and existing WebAssembly resource checks.

Local checks use the guard and remain supplemental. The accepted #148 compiler
plus edited runtime passes O1/O2 physical frees, rejected sharing, overflow and
invalid-option controls (2.60 s). Missing free and share-guard controls fail with
237 and 239. Formatting passes (1.09 s). The standalone test harness compiles
(0.37 s); an initial invocation omitted Cargo environment metadata and was
corrected. The repeated list fixture prints 2560 with accepted interpretation
(0.25 s). These do not establish actual WASI or changed-compiler support.

The new test-only libc ledger tracks live allocation addresses and byte sizes
independently of reference-count metadata. Candidate programs cover repeated
list/state construction, retained closures, UTF-8 reads and scoped derivatives.
At O1/O2 they must match raw interpretation, return physical storage and counts
to their entry baseline, and reject deliberately omitted object frees. The
small allocator fixture also exercises 300 aliases, real 64-bit count overflow,
rejected permanent sharing and startup option rejection. All runner checks are
pending; do not describe this prototype as supported WASI ARC yet.

Next: dispatch focused actual-WASI checks, fix all failures, add function/CLI
entry coverage and inspect the produced modules for absence of tracing. Only
then update supported-target documentation. The accepted #148 compiler at
`/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp` remains available for small
edited-C mechanism probes. No full compiler build was run locally.

Focused prototype run `38850138218` at `9d50a67` passes the allocator and rejection
checks on Linux AMD64; the whole-program test stops at an instrumentation
assertion because three cleanup calls exist across different entry paths. The
observer now targets only `fwp_main_thread`. Actual full-program evidence remains
pending, not waived. New function and CLI fixtures use explicit `# expose: cli`;
accepted-compiler raw invocations pass after repairing the initially missing
annotation. The entry tests inspect actual module symbols with `wasm-objdump`,
requiring `_start` and absence of tracing scan/mark/sweep functions.

Guarded edited-C checks pass list, single-function and CLI physical ledgers and
missing-free controls (3.50 s). Formatting passes (1.11 s). These run the host's
non-tracing path using accepted #148 plus the candidate runtime; the actual
32-bit WASI checks must still pass. The standalone harness also compiles (0.26 s).

Both Linux hosts in `38850138218` reproduce only the same whole-program observer
assertion; native ARC, allocator/rejection and existing WASI resource controls
pass on both. Revision `0c2fd3a6` fixes its scope and adds executable-entry/module
checks. Its queued rerun `38850647488` is superseded before acceptance by this
expanded fixture set: caught file/callback errors and nested derivatives also
need physical storage and semantic agreement. Preserve failed-run evidence;
never treat the earlier partial checks as whole-program acceptance.

Run `38850844450` at `a4869b99` passes allocator/rejection, function/CLI entries and
module symbol checks on both actual WASI architectures. Repeated lists, closures,
UTF-8 reads and caught file/callback errors pass their physical ledgers before the
nested-derivative case reports four live allocations / 2,248 bytes and zero
counts. The observer ran before the existing `atexit(fwp_tape_finish)` hook,
which releases the bounded cache and registry. That result is not evidence of a
persistent leak; the test must measure the actual declared shutdown boundary.

The observer is now registered before program work so subsequent runtime shutdown
hooks run first, without test-forced cleanup. A new negative control omits tape
shutdown and must fail. Local accepted-compiler edited-C nested derivatives pass
at O1/O2; missing object free and missing tape shutdown both fail with 244 (5.00 s).
Formatting passes (1.09 s), harness compilation passes (0.37 s). Actual WASI
acceptance of this correction is pending. Superseded `38850647488` is confirmed
canceled. No full compiler build ran locally.

## Additional scope before implementation: structural hashing

The current native `hash` first allocates a buffer containing the complete typed
binary encoding, then computes FNV-1a over those bytes and frees the buffer. This
is a confirmed avoidable allocation, and the missing borrowed-input contract
currently excludes `hash` from checked ARC. The next candidate streams precisely
the same bytes directly into the hash state; the interpreter's buffered encoding
remains an independent reference. No new syntax or alternate runtime mode is
needed.

Acceptance must cover integer widths, floating bit patterns, packed arrays/views,
strings/bytes, records, variants, maps/sets and nested values, plus aliases and
traps in surrounding computations. Compare raw interpretation and native O1/O2
tracing/ARC on all six hosts and actual WASI. Count all libc/managed allocations
inside hash calls, verify that the old buffered path does allocate, and inspect
actual generated functions. Preserve canonical byte order and wrapping FNV
arithmetic. Lower allocation counts alone do not establish a timing improvement.

Corrected synchronous WASI suite `38851711201` passes on both actual Linux hosts
at `4a28443a`, including physical shutdown and negative controls, caught errors,
nested derivatives, function/CLI entries and module inspection. Hashing is a new
addition after that tested revision and requires its own combined checks.

The hash candidate streams the canonical encoding directly into FNV-1a, retaining
integer width, byte order, float bits and container order. The borrowed-input,
immediate-result contract raises the inventory to 262 contracts and reduces
remaining review symbols to 81 (guarded inventory passes, 0.99 s). A local edited-C
probe passes canonical bytes, unchanged input counts and zero libc/managed
requests at O1/O2 in both native modes; the old buffered path fails with 247
(3.42 s). An initial probe incorrectly represented boxed I128 arrays as inline
values; its fixture now follows actual runtime layout. F128 arrays are inline and
have separate coverage. The accepted interpreter fixture passes (0.26 s) after
correcting the Unicode escape and explicit empty-list type. Harnesses compile
(0.50/0.26 s); formatting passes (1.08 s). These are supplemental checks.

Next focused gates: `hash` on all six native hosts (including protocol/reference
agreement and native ARC), plus `wasi-arc` on both actual WASI architectures with
hash semantics and no-allocation controls added. Neither is final acceptance of
the upcoming delivery. Keep #150's production head unchanged while it runs.
