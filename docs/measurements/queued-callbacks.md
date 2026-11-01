# Checking queued callbacks and handled errors

Historical evidence from the recorded source below. Tracing and `--gc` were
removed in [#217](../roadmap-history.md#tracing-gc-removal-pr-217); current programs
use checked ownership. Read [the ownership guide](../ownership.md) for current
acceptance rules and tests, rather than treating the old two-mode checks as
commands for the current compiler.

These are correctness and cleanup checks, not a speed benchmark. They compare
fwp's interpreter with generated programs. They do not compare fwp with C or Rust,
measure reference-count traffic, or establish a total-process memory bound.

Automatic reference counting (ARC) keeps a count of the owners of shared storage
and releases it when the last owner finishes. Updating those counts costs work.
Tracing collection instead finds reachable objects by following references.
The checks here concern correct cleanup; they do not measure that bookkeeping cost.

A callback is a function stored for a later call. A channel can keep that function
in its queue, and the function can keep other values alive. The compiler must
prove that these owners cannot form an owning cycle. The recorded builds
selected this proof with the former `--gc arc` option.

The [socket fixture](../../tests/fixtures/queued_sockets.fwp) stores an `Event`
record with a `check` function. The function owns a shared socket and reports
whether its address is still available. After receiving the event, calling
`check` twice must return `True` both times. Closing a retained UDP alias first
must instead make it return `False`. See the [ownership contract](../ownership.md#functions-stored-in-channels)
for the admitted captures and remaining exclusions.

## What the tests measure

The fixture repeats 64 rounds. Each round creates six TCP listeners, six TCP
connections and ten UDP sockets. It covers delivery, repeated calls, undrained
and closed queues, caught errors, blocked sends, and cancellation during UDP
receive, TCP accept and TCP read.

Test-only counters inserted into generated C require at most 64 simultaneously
live socket objects and none remaining at teardown. They also check that final
release closes the operating-system descriptor. ARC must return its managed
allocator charges to the starting value and perform no tracing collections.
These counters count socket objects, not retain/release operations, and exclude
storage managed internally by libc, OpenSSL and the operating system.

To check the detectors themselves, altered programs deliberately omit a queue
release or final socket close. They must fail with exit codes 194 and 195,
respectively. Existing string/callback controls detect an omitted release with
exit code 193. Successful outputs must match raw interpretation.

## Handler inference regression

`apply ()` calls a supplied function with unit, `()`. `attempt` catches its error
and returns `Ok value` or `Err error`. Thus `attempt (apply ())` must not require
its caller to handle that same error again. Other effects, such as printing,
still need to be declared.

The [handler fixture](../../tests/fixtures/handled_callbacks.fwp) checks this
relationship for error and state handlers, aliases and returned records. Its
[expected output](../../tests/fixtures/handled_callbacks.out) includes caught
errors, successful unit and state results, and `before` printed before a failure.
Separate type checks reject undeclared IO and preserve ordinary callback rules.

The recorded native execution covered ARC/tracing at O0/O2. WASI, the WebAssembly system
interface, covers ARC at O1/O2 on Node running on Linux ARM64 and AMD64. Its
cleanup checks physical allocations, bytes and count-table entries; deliberately
omitting a free must fail with exit code 244. This is not WASI socket support.

## Reproducing and reading the evidence

Dispatch `.github/workflows/numerics.yml` with `suite=queued-sockets` and
`native_runner=all`. This runs six native jobs and two WASI jobs. Native hosts are
Linux, macOS and Windows, each on ARM64 and AMD64.
[PR #184](../roadmap-history.md#queued-socket-callbacks-and-handler-inference-pr-184)
also passed the separate final-head production and documentation gates.

The [machine-readable report](queued-sockets-2026-10-21.json) identifies the exact
source, run, jobs, artifact hashes, compilers and inspected binaries. Native
artifacts retain generated C, executables, disassembly and outputs. All 24 native
socket binaries are inspected: ARC excludes collector scan/mark/sweep routines;
tracing controls retain marking. WASI artifacts retain generated C and four
handler modules; their file format and cleanup instrumentation are checked,
without claiming an independent WASI disassembly audit.
