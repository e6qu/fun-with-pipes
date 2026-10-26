# Which programs can run without tracing?

This is the execution and rejection checklist for [plan G1](../PLAN.md#1-remove-tracing-gc).
**Admission** means the compiler accepts an ownership relationship. It is separate
from executing the program, checking its output and proving cleanup. The
[ownership guide](ownership.md) explains owners, borrows and cycles.

Native builds select checked ARC by default. The entries below also accept
explicit `--gc arc`. Explicit tracing remains available; deleting it requires
implementing the [accepted ownership direction](gc-removal-design.md) for the
remaining lifetime cases, not just deleting a command-line option.
Neither a successful C emission nor an interpreter run proves native cleanup.

## Entry points and their checks

These rows name maintained entry forms, not every possible program. Test function
names are given so a reader can find the assertion rather than infer coverage
from a filename. Native tests require the six actual OS/architecture hosts;
WebAssembly tests require their declared runtime and toolchain.

| Entry | What owns inputs and results | Existing execution and rejection checks |
|---|---|---|
| Executable: `build`, cached `run` | Entry owns constants and result; typed owners release values before runtime teardown | [arc_execution](../tests/arc_execution.rs), `arc_programs_match_raw_interpreter_and_reclaim_escaped_values`, compares dynamic/selected static storage at C O0/O1/O2 and checks the allocation balance. [arc_corpus](../tests/arc_corpus.rs) checks every golden program and rejects new unexpected exclusions. |
| Function command: `exec`, `build --fn` | Parsed arguments and returned values belong to one invocation | [aot](../tests/aot.rs), `exec_runs_exported_functions_natively`; [exec_protocol_ownership](../tests/exec_protocol_ownership.rs), `arc_commands_reclaim_arguments_frames_defaults_and_errors`, checks arguments, protocol frames, errors and physical reclamation. |
| Command collection: `exec --cli`, `build --cli` | Each selected command owns parsed flags/defaults, arguments and result | The same protocol test compares interpretation with repeated ARC calls. `arc_checks_each_exported_entry_for_unscoped_effects` rejects a bad export even when another export is valid. |
| Typed command pipeline: `pipe` | Each process owns its decoded inputs; bytes cross the process boundary | [aot](../tests/aot.rs), `pipe_runs_native_stages` and `native_ownership_modes_are_explicit_and_part_of_the_cache`; protocol-owner checks cover frame cleanup. |
| Source tests: `test`, `test --std` | Test invocation owns failures and output buffers; child failures terminate the test process | [aot](../tests/aot.rs), `failed_native_tests_release_errors_and_print_buffers` and `child_task_failures_still_terminate_test_processes`; [std_tests](../tests/std_tests.rs), `std_tests_pass_with_checked_ownership`. A test outside its State scope is rejected before another test runs. |
| Static/shared C library: `build --staticlib`, `build --cdylib` | C strings copy into fwp; owned returned strings/records need the generated release function before unload | [arc_library](../tests/arc_library.rs) executes both library kinds at O1/O2, including result owners and failures; `library_checks_every_export_and_rejects_escaping_storage` checks every export. [library_input_ownership](../tests/library_input_ownership.rs) checks partial input copies; [library_unload](../tests/library_unload.rs) checks tasks, signals and regions at unload. |
| Foreign C call from fwp | Input storage and callback captures stay owned through the synchronous call; converted results get their documented owners | [foreign_callback_ownership](../tests/foreign_callback_ownership.rs), `scoped_foreign_graphs_reclaim_after_callbacks_suspend_or_fail`, covers nested calls, copied strings, suspension, cancellation and failure. Managed callback results have a rejection fixture below. C retaining a scoped callback is a host-contract violation, not a reliably detectable compile error. |
| HTTP server: `http2.serve` | Listener, accepted connection, handler, stream context and response have distinct owners | [http_server](../tests/http_server.rs), `native_server`; [http2_server_ownership](../tests/http2_server_ownership.rs), plus the [request/shutdown measurements](measurements/http-application-memory.md). Queuing an `H2Stream` is separately rejected. |
| gRPC client/server: `--service`, `serve` | Encoded messages carry data; connection, cursor, sender and handler own their runtime state | [grpc](../tests/grpc.rs), `arc_remote_calls_exclude_tracing_and_preserve_behavior`, executes maintained call shapes. [queued_functions](../tests/queued_functions.rs), `queued_remote_iterators_reject_hidden_stream_owners`, rejects unproved stream capture. Repeated cleanup checks are indexed in [application acceptance](application-acceptance.md). |
| Generated REST: `build --rest`, `serve --rest` | Server owns registered handlers; request scope owns decoded inputs and reply | [rest](../tests/rest.rs), `checked_arc_rest_preserves_api_authentication_and_form_results`; [server_entry_ownership](../tests/server_entry_ownership.rs), `generated_http_entries_preserve_results_and_disconnected_handler_owners`. Its entry-admission test rejects a callback capturing its queue. |
| Generated MCP: `build --mcp`, `serve --mcp` | Invocation owns decoded arguments, result/error and response text; server owns handlers | [server_entry_ownership](../tests/server_entry_ownership.rs), `mcp_stdio_aliases_errors_and_notifications_match_raw_interpreter` and the HTTP-entry test. `generated_entries_accept_proved_functions_and_reject_channel_captures` executes the accepted queued-function tool and checks both interfaces' rejection. |
| Synchronous WASI executable | Module uses typed owners and a releasable external count table | [wasm_arc](../tests/wasm_arc.rs), `synchronous_wasi_programs_match_interpretation_and_free_physical_storage`, runs actual modules under Node WASI; allocator controls check physical frees and missing frees. Native library flags on this target are rejected. |
| WASI function/CLI entry | One invocation owns parsed inputs, converted results and its count-table entries | [wasm_arc](../tests/wasm_arc.rs), `wasi_function_and_cli_entries_reclaim_inputs_and_results`, executes both forms at O1/O2 and compares interpretation. |
| Asynchronous WASI | Scheduler/task stacks own suspended work; queue and task results have typed owners | [wasm_arc](../tests/wasm_arc.rs), `wasi_tasks_release_captures_channels_stacks_and_scheduler`, runs JSPI and Asyncify variants, with repeated tasks, queued functions/data and handles. Missing required tools fail production coverage. |
| Browser-target loader | Each loader invocation owns a separate module instance; host output receives copied strings | [wasm_arc](../tests/wasm_arc.rs), `browser_entries_isolate_outputs_reentrant_calls_and_host_errors`, runs sequential/concurrent/reentrant calls and throwing sinks under Node. This is loader execution evidence, not coverage of every browser engine. `wasm_entries_keep_cycle_checks_for_browser_and_wasi` checks both targets' queue-capture rejection. |

The interpreter uses Rust-owned values rather than generated C counts. This G5
batch adds the same queue, State and autodiff lifetime admission to its public
entry calls, including REPL/notebook and compile-time execution. It checks only
functions reachable from the selected entry; unused definitions cannot reject
an unrelated calculation. Interpreter gRPC handlers are checked before listening.
Native representation and foreign ABI checks remain native-specific. See
[the handoff](development-state.md) for verification of this change.

## Named rejection fixtures

[The admission test](../tests/arc_execution.rs) checks these source files with
both raw and optimized IR, the compiler's internal program representation.
Tracing must emit C, establishing that the case is not
a syntax/type error; ARC must return status 1 with the listed diagnostic and emit
no C. It deliberately does **not** execute invalid scope examples in tracing mode.

| Source | Required diagnostic fragment | Missing contract or invalid behavior | Accepted direction |
|---|---|---|---|
| [custom-native](../tests/fixtures/arc-admission/custom-native.fwp) | `no checked ownership signature` | An arbitrary runtime declaration has no argument/result ownership contract. A familiar primitive name does not supply one. | Keep rejected; a new runtime primitive needs a reviewed contract and cleanup tests. |
| [foreign-callback](../tests/fixtures/arc-admission/foreign-callback.fwp) | `foreign boundary has no checked ownership contract` | A callback returns managed `String` storage to C; no host owner/release protocol is supplied. | Keep bare managed-result callbacks rejected: their signature supplies no release protocol. Use the separate [retained export API](retained-callbacks.md), whose owned results have generated release functions. |
| [http-stream-channel](../tests/fixtures/arc-admission/http-stream-channel.fwp) | `channel payloads cannot contain` | An HTTP stream can hide a handler/continuation that owns the queue. | Keep streams out of queues until their independent lifetime is proved. Queue request data or IDs while a task scope owns the stream. |
| [wrapped-http-stream-channel](../tests/fixtures/arc-admission/wrapped-http-stream-channel.fwp) | `channel payloads cannot contain` | Wrapping the same handle in a list does not remove that possible back-reference. | Keep the same restriction through containers; wrapping a stream cannot remove its hidden owners. |
| [cyclic-channel](../tests/fixtures/arc-admission/cyclic-channel.fwp) | `a queue can lead back to channel type` | The recursive payload type permits an owning cycle, even though this particular program only creates/closes an empty queue. | Keep this conservative rejection. Use an explicit weak back-edge or graph ID; the recursive `WeakLink` fixture exercises the weak form. |
| [mutual-channel](../tests/fixtures/arc-admission/mutual-channel.fwp) | `a queue can lead back to channel type` | Two type definitions hide the same possible back-reference. | Keep the transitive owning-edge check; replace a back-edge with a weak reference or graph ID. |
| [unscoped-tape](../tests/fixtures/arc-admission/unscoped-tape.fwp) | `tracing-free lifetime policy` | A raw derivative tape is created without a bounded autodiff scope. | Keep rejected; it is not a feature to recover by deleting GC. |

For example, this type can describe a cycle because its queue may contain another
`Node` that holds the same queue:

```fwp
Link = | Node (Channel[Link])
```

The diagnostic says the compiler lacks a cycle-freedom proof. It does not claim
that every `Link` value is cyclic. [Lesson 23](tutorials/23-ownership-scopes/README.md)
shows a graph whose edges are integer IDs: a logical cycle without owning cycles.

## Remaining relationships with explicit controls

| Relationship | Smallest maintained control | Current rule and required follow-up |
|---|---|---|
| A queued callback owns its receiver | `self` in [queued_functions](../tests/queued_functions.rs), `queued_functions_reject_channel_captures_including_returned_and_nested_values` | Rejects `queued function` / `captured` / `Channel`; returned/nested/caught callbacks and two queues cannot hide the owner. [Lesson 24](tutorials/24-subscriptions/README.md) supplies the independent task-owned form; its queue holds data. |
| A queued task owns its queue through computation or result | `computation` and `result` in `direct_task_messages_reject_computation_and_result_queue_owners` in the same test file | Both engines reject the captured task/function-bearing channel before execution, with optimization on and off. Keep unproved owning cycles rejected. An independent task scope can own the task and queue; queue data/results or a callback holding a weak link. |
| A task's cached result owns the task itself | `task_results_reject_a_cached_self_owner_without_a_channel` in the same file | Rejects failure to prove an `acyclic task result`, even without a channel. Follow both computation and returned captures. |
| Unknown function, task or external queue producer | Typed IR controls in [arc_scope](../src/arc_scope.rs): `joining_a_known_target_does_not_hide_an_unknown_function`, `queued_task_captures_follow_the_computation_and_unknown_inputs`, `runtime_function_producers_and_external_queues_need_known_sources` | Unknown is not an empty set of captures. These tests construct internal IR; they are not claims that every such internal primitive is available in source. Admission needs a producer/lifetime model. |
| A received function uses the sender's expired State/AD handler | `queued_autodiff_functions_require_the_receivers_scope` in [queued_functions](../tests/queued_functions.rs); [arc_extensions](../tests/arc_extensions.rs), `raw_ad_cannot_escape_scope_proof_through_callbacks_or_arguments` | Calling must install the required handler in the receiving task. Keep invalid scope use rejected. |
| An inter-task derivative escapes its scope | [ad_task_reuse](../tests/fixtures/ad_task_reuse.fwp), checked by [autodiff_nested](../tests/autodiff_nested.rs) | Expected `outside an autodiff scope` rejection. The corpus fails any new unexpected ARC rejection; it does not just count excluded programs. |
| Closing a cyclic channel | [channel_cycle_ownership](../tests/channel_cycle_ownership.rs), `closed_channel_cycles_keep_values_until_drain_and_then_release` | Close preserves queued messages. The tracing-only control drains explicitly and checks reclamation. Removing tracing must not quietly change close to discard messages or pretend this is current ARC admission. |
| C stores a callback after returning | Foreign declaration permits only a scoped callback; the C body is outside the ownership proof | No compiler diagnostic is promised for a C implementation violating that contract. The [retained API](retained-callbacks.md) supplies a separate context-bearing registration for selected exports, with active-call ownership and explicit release. Verified in #215; scoped callback pointers still cannot be retained. |

`Ptr[T]` is a manually managed address, not a managed owner. Keeping its storage
valid and using the matching release operation are `Unsafe` obligations. Passing
an address through C does not prove that C can retain fwp-owned storage. See
[C interop](tutorials/09-c-interop/README.md).

## Contract work before collector deletion

G1's entry matrix passed in #212; G3/G4's weak links, retained callbacks and
cleanup controls passed in #215. [Delivery history](roadmap-history.md) records
exact tested sources and runs. A passing entry does not prove arbitrary user
programs safe; each rejection above still applies.

G5 must apply the lifetime rules to all execution entries and delete collector
code without losing the output, alias, failure, cancellation and memory checks.
[The diagnostic deletion table](ownership-diagnostics.md#collector-specific-tests-and-retained-assertions)
identifies what retires with tracing and what must remain. The runtime must not
silently switch an unproved program to tracing or permanent retention.
