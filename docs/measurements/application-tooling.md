# Milestone 5: applications, compiler costs and sustained load

**Milestone 5 is verified and merged in PR #274.** The
[November 10 report](application-compiler-load-2026-11-10/README.md) records all
four compiler sessions, four HTTP sessions and corrected recursion checks;
[the delivery receipt](application-final-gates-2026-11-10/README.md) records all
nine production jobs, documentation and the complete-log audit. This document
retains the frozen protocol. Original milestone 1–3 timing limits remain open.

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
notebook input edits/errors and debugger stops. [Both native Linux jobs now pass](application-workflows-2026-11-09/README.md), including all eight integer-output
checks and O0–O3 C/object inspection. AMD64 browser checks pass all three
applications, stale/error states, explicit effects and source-only save/reopen.
The receipt preserves the first failures and their repairs. These are workflow
and code-inspection checks, not compiler-cost or service-throughput measurements.

Use the existing [SDK tests](../../sdk/python/tests/test_tools.py),
[terminal checks](../../sdk/python/tests/test_repl_terminal.py) and
[browser checks](../../sdk/python/browser/check_notebook.py). Add application
coverage where it is missing; do not duplicate every protocol unit test. Native
code, interpreted debugging and notebook execution have different scopes, which
the walkthroughs must explain. None uses JIT compilation.

## Compiler phases and growth

Whole `fwp build --emit-c` time cannot identify an expensive compiler stage.
[Compiler phase reporting](../compiler-pipeline.md#observe-compiler-phases) is
implemented on the actual build worker; [native contracts pass on both hosts](compiler-http-preparation-2026-11-09/README.md). It
records nested spans without creating a second compiler pipeline.

| Measurement | Boundary to expose |
|---|---|
| Source loading and parsing | Main source, imports, bundled library and generated numeric declarations; identify bundled-library work separately |
| Macro expansion | Expansion including the nested checking/lowering/interpreting needed to execute macros |
| Declaration collection and inference | Name/type collection and final program type/effect checking |
| Specialization and lowering | Reachable concrete functions and compile-time evaluation |
| Optimization | The actual ordered optimization passes |
| Representation and ownership | Layout selection, borrowing proof, reference-operation insertion and lifetime verification |
| C emission | Producing selected program/runtime C, including on-demand helper analysis |
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

The [runner](../../scripts/measure-compiler-scaling.py) uses two explicit commands:
`fwp build --target native --emit-c -O2` and GCC with explicit O2, GNU C11,
`-ffp-contract=off`, `-fno-fast-math`, `-fno-lto` and the declared `-march`. It measures
both commands separately and checks the resulting program after every build.
The observer ratio compares the fwp commands; GCC time is a separate cost, not
part of that ratio. This is not elapsed time for the single-command native build.
GNU time supplies process high-water RSS and user/system CPU time; these are not
aggregate live memory or per-phase memory. Each observed invocation writes a new
report. Generated C must match byte-for-byte across all four treatments.

`compiler-scaling-checks` first checks all 12 sizes on both hosts, ordinary versus
observed output, and early/late type errors with matching source locations.
`compiler-scaling` then runs the two sessions per host. Every treatment gets one
warmup; eight measured rounds alternate order. Identical compiler copies have
matching SHA-256 digests. All sources, commands, failures, reports and samples
are retained. All 12 sizes now [pass on both hosts](compiler-http-checks-2026-11-09/README.md),
including the repaired 512-type case. The recursive-limit fixtures needed their
required `rec` declarations; both corrected controls now pass on both hosts.
All 48 timed case/session comparisons pass the identical-copy controls. The
[report](application-compiler-load-2026-11-10/README.md#what-compiler-time-means)
separates fwp time, GCC time, phase costs and process memory.

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
throughput/latency contract. The separate runner-side experiment uses the
existing [HTTP application checks](../../tests/support/http_application.rs).
The first workload is plain HTTP/1.1 on loopback, `GET /items/42`, with the exact
200 response body `{"id":42,"name":"item 42"}`. Use the maintained
[API example](../../examples/server/api.fwp), native GCC O2, explicit target CPU
and no LTO. Preserve full request/response bytes in the receipt. There is no TLS
or external network in this experiment. The measured source overrides
`max-requests-per-connection` to 10,000,000, explicitly supplied to the runner.
The maintained example inherits a 1,000-request limit, which would close these
long-lived connections. Keep both original and configured sources and their
hashes; this is a connection-policy change, not an endpoint optimization. No
automatic reconnection or limit increase is permitted during measurement.

Pin server and a native load generator to two distinct CPUs from the allowed
affinity mask; record guest topology and CPU usage for both. This does not prove
exclusive physical-core access on a hosted runner. Use 1, 8, 32 and 64 persistent
connections with one outstanding request per connection. This is
[closed-loop load](../terminology.md#service-latency-and-load): a connection waits
for its reply before sending again. Latency includes sending the request and consuming its complete response,
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

The [native driver](../../scripts/load/http-load.rs) and
[runner](../../scripts/measure-http-load.py) are implemented; [driver and allocation controls pass on both hosts](compiler-http-preparation-2026-11-09/README.md).
The API connection-policy repair and slow-client checks now
[pass on both hosts](compiler-http-checks-2026-11-09/README.md). `http-load-checks` verifies the driver against a controlled
server (correct/wrong/partial replies and timeout), exercises the actual API,
and runs its existing physical cleanup/socket/cancellation controls. `http-load`
is reserved for the complete timed protocol after those checks pass. Session 1
also runs the single 300-second soak per host. Each trial starts a fresh server.
All four timed sessions now pass: 34 trials, including both five-minute soaks,
with no failed requests and flat sampled server RSS. The
[results](application-compiler-load-2026-11-10/README.md#what-http-load-means)
keep the different CPU models separate and retain latency, throughput and CPU
traces. They do not establish a Swift/C/Rust throughput comparison.

The generator runs on one allowed logical CPU, the server on another. Generator
CPU saturation limits what this experiment can say about server capacity. The
retained one-second trace gives both processes' CPU time and RSS; the summary
reports sampled CPU fractions and the RSS slope, without imposing a new RSS goal.
C/C++ launchers apply the stated target flags because fwp's `CC`/`CXX` settings
take executable paths, not argument lists. Their complete source is retained.
They run only during compilation, outside request timing.

Every attempt is a 32-byte little-endian record: start/end nanoseconds from the
common generator epoch, request bytes sent, response bytes received, outcome,
and response-dictionary ID. Each worker has its own stream and exact response-byte
dictionary; `request.bin` retains the complete request. This stores repeated
responses once without discarding attempts. Streams are compressed losslessly
with gzip. The [reader](../../scripts/http_load.py) accepts an explicit compressed
setting, verifies all records and reconstructs the summary. Outcomes distinguish
success, deadline, wrong/framing response, early EOF and other IO failure.

Connection setup precedes the common clock. Every connection has one outstanding
request, and a failed connection stops without retries. Request latency includes
sending, consuming and validating the response. Recording happens afterward;
its cost is included in throughput. Warmup attempts, including any crossing into
the measured interval, remain recorded separately. Only attempts begun in the
measured interval enter its latency/error denominator; only correct responses
finished inside it contribute to throughput. Late successes remain in the
successful-response latency distribution. This is an initial fwp service baseline,
not a peer comparison with C, Rust or Swift.

The allocation diagnostic uses the same API source at native O2, separately from
timed load. Eight fresh connections each perform 1, 4, 16, 1, 16, 4, 0 and 1
requests in successive cohorts: 344 correct item responses in total. The zero
cohort instead disconnects eight incomplete POST requests. A final control
cancels seven slow handlers plus its metrics connection. These failure controls
are not included in per-item allocation estimates.

`http-traffic` rows record cumulative managed-heap allocation events, charged
bytes, reclaimed bytes and the whole-run live-slot peak after each cohort and
shutdown. An event is one physical heap-slot allocation, including reuse; these
are not libc calls or ARC operations. Charge includes slot padding, but excludes
raw C buffers, task stacks, allocator pages and metric tables. Charged minus
reclaimed bytes must match the independently checked live heap. The existing
warm-baseline + 8 MiB RSS and exact socket/task cleanup checks remain. A
separate deliberately disabled event counter must fail its own observer. These
diagnostics pass on both hosts; they establish no timing claim.

A separate diagnostic route `/pressure/:bytes` returns a runtime-sized string.
It is added only to the saved test source, not the example or timed endpoint.
The probe requests 8 MiB and sets accepted sockets' send-buffer request to 16 KiB.
The [Windows backpressure repair](http-backpressure.md) records the subsequent
native failure, diagnostic and bounded-buffer repair. Focused checks now pass
on both Windows architectures; combined final delivery gates remain pending.
It observes the TCP write's would-block branch before the ordinary wait, then
verifies another client receives its item response before consuming the large
body. This gives direct evidence of the exercised path, rather than guessing
from elapsed time or instruction listings.

Eight cohorts cover complete transfer, a split request header, a partial POST
body, reads interleaved with another client, disconnects after partial responses,
and reuse after failures. The first full large transfer warms storage before
applying the existing RSS bound. Every received body byte is checked; the same
exact heap/socket/task checks and final slow-handler cancellation apply. The
probe passes on both Linux architectures. Its buffer setting and
instrumentation must never be used for ordinary throughput results.

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

The measured source is `7a65a8bb2ac23df0554610dfb90609c5fed30ee8`, retained by
`roadmap/application-tooling-measurements-2026-11-10`. To reproduce the full
sessions on runners, use the tag rather than a moving branch:

```sh
gh workflow run numerics.yml --ref roadmap/application-tooling-measurements-2026-11-10 -f suite=compiler-scaling
gh workflow run numerics.yml --ref roadmap/application-tooling-measurements-2026-11-10 -f suite=http-load
```

The tagged reusable workflows fix both hosts, two sessions and all runner
arguments. Host CPU models and installed stable tools can change; record new
identities rather than treating a reproduction as the same experiment. Original
timings are not rerun unchanged to obtain qualification.

[PR #274](https://github.com/e6qu/fun-with-pipes/pull/274) delivered this batch on
#273's verified baseline. The final receipt preserves the Windows backpressure
repair, formatting repair and all passing gates. [The current roadmap](../../PLAN.md)
selects the next work; this completed protocol is not another task queue.
