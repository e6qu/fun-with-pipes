# Milestone 5: applications, compiler costs and sustained load

**Preparation, not results.** Keep [PR #273](https://github.com/e6qu/fun-with-pipes/pull/273)
unchanged while its final gates run. This is the next [roadmap](../../PLAN.md)
batch. Freeze its implementation source and complete measurement settings before
collecting timings. Existing unit tests establish individual features; the work
below checks complete user workflows and measures the costs still missing.

## Three applications through the tools

| Application | Existing source to reuse | Small independent result |
|---|---|---|
| Numerical minimization | `rosenbrock` and `descend` from [lesson 20](../tutorials/20-autodiff-and-devices/main.fwp) | At `[-1.2, 1.0, 0.5]`, the loss is 49.2 and its gradient is approximately `[-215.6, 112.0, -100.0]`. A step of size 0.001 gives `[-0.9844, 0.888, 0.6]`. |
| Word frequencies | [Word-count example](../../examples/wordfreq.fwp) and its [test input](../../tests/run/wordfreq.in) | Print `the: 4`, `dog: 3`, `fox: 3`, `a: 2`, `lazy: 2`, in that order. Keep the example's lowercase/punctuation and tie-order rules. |
| Queued callback service | [Verified service](../../tests/fixtures/weak_callback_service.fwp) | With 64 messages and normal delivery: 64 calls, 64 receives and checksum 39,936. Cancelling every fourth message gives 48 calls/receives and checksum 30,336. |

The loss scores the candidate values; its gradient gives the rate of change
with respect to each input. For each neighboring `(x, y)`, compute
`distance = y - x * x` and `offset = 1.0 - x`, then add
`distance * distance * 100.0 + offset * offset` to the loss. Check derivatives
independently. Compare F64 results
with a stated tolerance and retain raw values. For the service, message `i`
contains the integers `i` through `i + 15`; summing those payloads gives the
checksum independently of either queue implementation.

For each application, deliver a short walkthrough and executable checks:

1. Run the source through raw and optimized interpretation and native O1/O2.
   Match results, diagnostics and required cleanup. Keep effects and input files
   explicit; notebook/debugger protocol input is not program standard input.
2. Split definitions, inputs and one computation into notebook cells. Edit an
   input, inspect stale results, then explicitly rerun the computation. A failing
   edit must report its source and must not replay previous file/IO effects.
   Save and reopen the source-only notebook without silently running cells.
3. Run the same small computation through the REPL and Python debugger. Stop in
   a named function, inspect its input, continue and check the result. Trace only
   selected events; verify source names, values and cleanup after an error.
4. Use the [disassembler](../debugging.md) to retain emitted C and actual instructions
   at optimization levels O0/O1/O2/O3 with an explicit compiler/target. Report toolchain identity. These
   are inspection outputs, not an execution-time or whole-stack measurement.

The [walkthroughs](../application-workflows.md) and
[application tests](../../sdk/python/tests/test_applications.py) now cover the
three calculations through raw/optimized interpretation, native O1/O2, the REPL,
notebook input edits/errors and debugger stops. These new execution checks are
prepared but have not yet run on native CI. The browser checks now also exercise
all three applications, stale/error states, explicit effects and source-only
save/reopen; browser execution is pending. Retained application disassembly still
needs its application-specific checks.

Use the existing [SDK tests](../../sdk/python/tests/test_tools.py),
[terminal checks](../../sdk/python/tests/test_repl_terminal.py) and
[browser checks](../../sdk/python/browser/check_notebook.py). Add application
coverage where it is missing; do not duplicate every protocol unit test. Native
code, interpreted debugging and notebook execution have different scopes, which
the walkthroughs must explain. None uses JIT compilation.

## Compiler phases and growth

Whole `fwp emit-c` time cannot identify an expensive compiler stage. Add explicit
measurement settings to the actual compilation path; do not build a second
compiler pipeline just for this experiment.

| Measurement | Boundary to expose |
|---|---|
| Source loading and parsing | Main source, imports, bundled library and generated numeric declarations; identify bundled-library work separately |
| Macro expansion | Expansion including the nested checking/lowering/interpreting needed to execute macros |
| Declaration collection and inference | Name/type collection and final program type/effect checking |
| Specialization and lowering | Reachable concrete functions and compile-time evaluation |
| Optimization | The actual ordered optimization passes |
| Representation and ownership | Layout selection, borrowing proof, reference-operation insertion and lifetime verification |
| C emission | Formatting the selected program/runtime into C |
| C compilation and linking | The selected external toolchain, including child-process time |

Nested phases must not be added twice. Report inclusive and exclusive time where
needed, plus total wall time and any unassigned time. Clock reads and report
serialization have costs: compare observed and ordinary compilation separately,
and require identical generated C and executable results. Whole-process peak
RSS (resident process memory) is not memory attributable to an individual phase.

Use these first input families, each generated from retained source:

| Family | Sizes | What grows |
|---|---|---|
| Independent definitions | 16, 64, 256, 1,024 | Small separately named integer functions, all reached by the entry |
| Generic uses | 8, 32, 128, 512 | Distinct concrete instantiations of one explicitly typed helper, all reached |
| Expression nesting | 8, 32, 128, 512 | Nested local bindings with a fixed arithmetic result |

Use native Linux ARM64/AMD64, the production release compiler, GCC O2 without
LTO/fast math/contraction, and explicit `armv8-a`/`x86-64` targets. Each measured
child has a 120-second deadline. Record the actual toolchain versions and build
settings; do not substitute a different compiler on failure. Run two sessions,
one warmup per case, then eight interleaved rounds of ordinary/identical-copy and
observed/identical-copy compilation. Identical copies do the same work; their
disagreement measures experimental noise. Reverse the order on alternating rounds.
Keep raw samples; an identical-copy median ratio outside 0.98–1.02 makes that
session's timing inconclusive. It does not invalidate recorded correctness or
allocation facts, and is not retried unchanged.

Additional required controls:

- Independent declarations, reachable generic uses and nested expressions must
  grow separately. Count source bytes/tokens, declarations, specializations and
  emitted C bytes; input file size alone does not describe compiler work.
- Include valid inputs and errors near the beginning/end of each family. Preserve
  useful source locations and bound each measured child with an explicit deadline.
- Separate fresh-process/library startup from repeated work where the public tool
  actually supports reuse. Record warmup without claiming OS caches were flushed.
  Do not silently cache one peer or change its input.
- Retain both native Linux architectures, exact source/toolchain/settings, all
  samples, failures, peak RSS and growth ratios. Report observer overhead against
  ordinary compilation; do not subtract an estimated instrumentation cost.

This measures the chosen inputs; it does not promise linear-time inference for
all programs. Select any compiler optimization from the measured dominant costs,
then freeze its own correctness, resource and timing acceptance before editing it.

## Sustained HTTP load

The existing 12,800-request correctness check is useful coverage but has no
throughput/latency contract. Prepare a separate runner-side experiment using the
existing [HTTP application checks](../../tests/support/http_application.rs).
The first workload is plain HTTP/1.1 on loopback, `GET /items/42`, with the exact
200 response body `{"id":42,"name":"item 42"}`. Use the maintained
[API example](../../examples/server/api.fwp), native GCC O2, explicit target CPU
and no LTO. Preserve full request/response bytes in the receipt. There is no TLS
or external network in this experiment.

Pin server and a native load generator to two distinct CPUs from the allowed
affinity mask; record guest topology and CPU usage for both. This does not prove
exclusive physical-core access on a hosted runner. Use 1, 8, 32 and 64 persistent
connections with one outstanding request per connection. This is closed-loop
load: latency includes sending the request and consuming its complete response,
but not waiting for an available connection. It does not establish open-loop
arrival-rate capacity or an internet latency guarantee.

Run two sessions, each with two runs per concurrency level: 5 seconds of warmup,
30 measured seconds and a 5-second request deadline. Reverse concurrency order
in the second session. Stop initiating requests at the end of the measured
window, then record every outstanding request's terminal outcome. Throughput
counts correct responses completed inside that window divided by 30 seconds;
late completions remain visible separately. Retain every attempt's start/end,
outcome and bytes. Report successful-response percentiles and time-to-response-
or-failure percentiles separately, with failures divided by all attempts.

Use a separate 300-second, 32-connection soak with one-second CPU/RSS samples.
Separate diagnostic executions record physical ownership cleanup and allocation
traffic. The existing warmed-baseline plus 8 MiB RSS budget is retained for those
bounded cleanup controls; the ordinary soak reports its full trace and slope.
Do not turn instrumentation overhead into an ordinary throughput result.

The runnable protocol must additionally retain:

- Endpoint computation and exact request/response bytes; keep-alive and connection
  reuse; concurrency levels; generator and server placement/CPU allocation.
- Warmup, measured duration, repetitions, request and shutdown deadlines. Distinguish
  offered requests from completed requests and report errors/timeouts explicitly.
- Median, p95 and p99 latency, completed requests per second, allocation traffic,
  live storage and process RSS over time. Keep generator saturation visible.
- Separate ordinary timing from instrumentation. Explain whether latency includes
  client queueing, connection setup and response consumption. Do not mix those
  scopes or report successful responses as the denominator for all requests.
- Slow readers/writers, backpressure, disconnects, cancellation and shutdown under
  load. Check partial responses and release of owned data, sockets and workers.

Acceptance needs an explicit application load and measured starting point.
Warm pools may remain allocated; continuing live growth needs explanation and
repair. Neither an arbitrary zero-RSS-growth rule nor a universal requests-per-second
target is justified. Retain saturation, failures and inconclusive measurements.

The [queued service comparison](weak-callback-time-2026-11-09/README.md) is a
separate serial workload. Its 18.65–20.23× C time gap calls for attribution of
payload construction, queue/effect/channel work and cleanup before selecting a
shared improvement. A temporary weak-lookup result alone does not explain it.

## Delivery

Keep one active PR. Prepare this batch separately while #273 finishes; publish
the next substantial PR after its verified squash merge. Update the guides and
handoff with actual commands/results, and fix every encountered issue. Run focused
checks during development, then one complete final matrix and log audit for the
assembled batch. Keep full builds and all measurements on GitHub runners.
