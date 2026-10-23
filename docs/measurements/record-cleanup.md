# Checking value and call cleanup without tracing

An **owner** keeps a value alive and is responsible for releasing its storage.
An **alias** is another live reference to that value. Automatic reference counting
(ARC) tracks owners when sharing is necessary. These checks verify cleanup under
ARC while preserving the older tracing-collector controls. They do not measure
execution speed or establish parity with a C/Rust application.

In the examples, `x | f` passes a value to a function; `f | g` combines two
functions in that order. `echo` prints its input. Prefix arguments come before
the data: `string.repeat 2` waits for text and repeats it twice.

## Shared test protocol

Instrumented C probes exercise generated ownership operations, including failure
partway through a call and task cancellation. Most repeat 32 rounds. After each
ARC round, the allocator's managed byte charge must return to its starting value,
with no entries for unusually large reference counts and no collections. Final
scheduler shutdown must release its own storage too.

Negative controls deliberately omit a release, retain an extra owner or corrupt
one ownership operation. Each must fail a named observation. A typical missing
final release fails with status 90. Passing output alone is insufficient: callers'
aliases must retain their values and exact counts, and integer bits resembling
addresses must remain integers.

Tracing keeps collection stress and **poisoned storage** checks: released values
remain physically allocated with recognizable invalid contents, exposing stale
reads. ARC instead checks released count metadata and storage balance; it must
not rely on permanently retained poisoned objects. Missing lifetime information
must be rejected, not silently handled by tracing.

Probe C uses explicit compiler O2, dynamic storage and C O1/O2. Stack placement
is disabled where a test needs an actual object; stack-capture tests enable it.
Complete programs compare output, errors and status with the unoptimized
interpreter. Individual exceptions and longer repetitions are described below.
Generated C, actual executables, output and exit status are saved under
`record-ownership/` for independent inspection. Inspections verify the target
architecture, instructions and absence of tracing code in ARC binaries.

The byte charge measures managed value storage. It excludes process resident
memory, allocator metadata, task stacks and ordinary C-library allocations.
Code size, stack use and elapsed time need separate measurements. See the
[benchmark guide](../benchmarks.md) for equivalent-work C/Rust comparisons.

## Records, variants and failed construction

A record groups named fields. `String` means text; `I64` is a signed 64-bit
integer. `Box -> Box` describes a function taking and returning one `Box`.
The `with` form replaces selected fields:

```fwp
Box = { name: String, code: I64 }
rename : Box -> Box
rename = with { name = "new" }
```

`rename` replaces the name and keeps the code. It may reuse storage whose sole
owner is consumed, but an independently live alias must retain the old name.
A **variant** chooses a named form, such as an empty result or a result containing
text. A **constructor** creates a record or variant. The compiler can pass fields
directly to an internal C function; a later call may need to allocate an enclosing
object. Failure during that allocation must release the completed fields.

| Tests | What they exercise |
|---|---|
| [Record updates](../../tests/record_update_ownership.rs) | Field replacement with and without aliases |
| [General copies](../../tests/general_record_update_ownership.rs) | Returning both the original and the updated record |
| [Field conversion](../../tests/record_conversion_ownership.rs) | Converting object fields to direct C arguments |
| [Variant conversion](../../tests/variant_conversion_ownership.rs) | Count overflow partway through acquiring direct fields |
| [Partial retains](../../tests/retain_unwind_ownership.rs) | Releasing earlier acquisitions when a later retain fails |
| [Nested constructors](../../tests/constructor_type_ownership.rs) | A later field fails after an earlier field creates a child |
| [Constructor allocation](../../tests/constructor_unwind_ownership.rs) | Allocation fails before fields transfer to their object |
| [Call preparation](../../tests/worker_preparation_ownership.rs) | Copying/moving fields stops partway through, or the task is cancelled |
| [Result storage](../../tests/worker_boxing_ownership.rs) | Fields return successfully but their enclosing allocation fails |

Five old fixtures incorrectly restored an artificially large reference count:
they set its separate count entry to one but left marker 255 in the inline slot.
One record-update round retained 64 bytes and four count entries. The fixtures now
use `fwp_rc_fresh` to clear that invented state and restore the actual sole owner;
a control reinstates the mistake and must fail. This was a fixture defect.

The nested-constructor fixture also substituted a function name inside its case
selector, accidentally running the variant twice. Substitution now changes only
the function placeholder. Distinct negative statuses prove both cases execute.

## Selecting fields, iteration and function values

A **reuse token** temporarily owns emptied object storage. A constructor can fill
it, or cleanup must free it; it is internal compiler bookkeeping. A **fold** applies
a callback repeatedly to an element and an accumulator; a right fold starts at
the right end. A **capture** is an argument already supplied to a function, as in
`add 1`, which waits for a number and adds one to it.

| Tests | What must survive or be released |
|---|---|
| [Field selection](../../tests/field_context_ownership.rs) | Discarded nested fields, including when the outer record is eliminated |
| [Pattern matching](../../tests/match_context_ownership.rs) | Child type information needed to release discarded variant fields |
| [Returned aliases](../../tests/variant_alias_ownership.rs) | Caller aliases and direct fields across task suspension |
| [Reusable storage](../../tests/reuse_token_ownership.rs) | Empty storage on failure, an unused branch or a tail call |
| [Partial calls](../../tests/argument_preparation_ownership.rs) | Captured values when acquiring arguments fails; unique captures move without extra retains |
| [Right folds](../../tests/fold_unwind_ownership.rs) | Accumulators and buffers after callback, allocation or cancellation failures |
| [Loop preparation](../../tests/loop_preparation_ownership.rs) | Partially prepared loop arguments |
| [Loop cancellation](../../tests/loop_unwind_ownership.rs) | Current state before or after an update |
| [Map](../../tests/map_unwind_ownership.rs), [selection](../../tests/selection_unwind_ownership.rs), [zip](../../tests/zip_unwind_ownership.rs) | Partial results, callbacks and temporary buffers; see [collection cleanup](collection-cleanup.md) |
| [Cached values](../../tests/caf_ownership.rs) | Failed/reentrant initialization, replacement and separate cache/caller owners |
| [Escaping functions](../../tests/closure_ownership.rs) | Captures retained by a returned function and released after use |
| [Temporary containers](../../tests/temporary_ownership.rs) | Discarded children while independent aliases remain live |

Two compiler controls erase a required child type: ARC must reject them before
C generation. Tracing retains its former runtime leak controls. Cached values
repeat 32 complete lifetimes, while a separate program verifies initialization
happens only once. Closure and temporary-container checks repeat 10,000 values
with collection disabled; deliberate missing cleanup must fail.

The reuse test also runs a million-step countdown at C O1/O2 in both modes and
compares a small case with raw interpretation. This verifies constant-stack
execution for that eligible pattern, not arbitrary recursion. ARC rejects settings
that disable ownership or freeing. The twelve-pattern partial-call report keeps
its existing rows and columns; each pattern now repeats 32 times.

## Task callbacks and cancellation

A task runs a callback—a supplied function—which may pause while other tasks run.
Its captures must remain alive until completion or cancellation. `task.spawn`
starts the callback; `task.await` returns `Some value` on success or `None` after
cancellation.

`curry` turns a tuple-taking body into successive single-argument calls. Tuple
positions start at zero, so `.0` selects the first field. Unit, written `()`,
carries no data. Here a task returns the length of its captured text:

```fwp
plain : String -> () -> I64
plain = curry (.0 | string.length)
main = task.spawn (plain ("input" | string.repeat 2)) | task.await | echo
```

`string.repeat 2` makes `"inputinput"`. Supplying that text leaves a function
waiting for unit. Its body receives `(text, ())`, selects the text and returns
its length. The program therefore prints `Some 10`.

| Tests | What they exercise |
|---|---|
| [Retained callbacks](../../tests/retained_thunk_ownership.rs) | Completion, cancellation before entry/after suspension, and failed task-stack allocation, scope growth or retains |
| [Timeout callbacks](../../tests/within_thunk_ownership.rs) | Caller aliases through success/timeout; release of consumed captures, results and durations |
| [Task scopes](../../tests/scope_thunk_ownership.rs) | Results, child-task arrays and error handlers across cancellation |
| [Task handles](../../tests/task_handle_ownership.rs) | Repeated awaits, scheduler/scope owners after handle discard, and failed result retains |

Generated functions carry instructions for releasing their captures. Removing
that information must trap in ARC while preserving the caller's owners. The
fixtures explicitly own injected tasks and duration records; they cannot leave
those allocations for tracing to reclaim.

Shared cases repeat 32 rounds. Internal tasks with only a scheduler owner repeat
64 rounds of completion, cancellation before entry and cancellation after
suspension. Omitting destruction or incorrectly using a counted-object release
must leave a measured charge and fail. Explicitly disabling physical release is
a retention control, not supported ARC policy. These four groups save 142 outcomes.

## State, deadlines and channel values

`State[T]` is an effect for reading or replacing a value of type `T`. `run-state`
supplies an initial value and returns `(result, final-state)`. `get` reads it;
`modify` applies a function to it. The type annotation `! {State[I64]}` declares
that state effect. `const x` ignores its input and returns `x`; here `x` is the
function `add 1`:

```fwp
increment : () -> I64 ! {State[I64]}
increment = const (add 1) | modify | get
main = () | run-state 0 increment | echo
```

`modify` replaces zero with one; `get` reads one. The program prints `(1, 1)`:
both the result and final state are one. Nested handlers have separate storage;
a task must restore its own state when it resumes.

[State tests](../../tests/typed_state_ownership.rs) repeat 32 rounds of reads,
replacement, errors, allocation failure, task switches and cancellation. Six
controls omit individual ownership operations; another omits the final fixture
owner. Whole programs cover nested handlers, arrays, functions stored in state,
and stack placement on/off. These produce 56 saved outcomes at C O1/O2.

A deadline sets the current task's time limit and passes its input through.
`42 | task.deadline 1h` returns `42` and sets a one-hour limit; an earlier existing
deadline still applies. It does not wait an hour. A **channel** is a queue for
exchanging values between tasks. Integer messages resembling addresses must not
acquire owners of the corresponding objects.

[Task value tests](../../tests/task_ownership.rs) repeat 32 deadline/channel
rounds and check complete ARC reclamation of a 10,000-value loop. Controls omit a
retain, result, channel, string or duration release, or add an extra owner. The
old tracing O1 comparison keeps collection disabled and compares counted cleanup
with deliberately uncounted sharing; it does not establish ARC support. Alias
programs compare with raw interpretation. These add 28 saved outcomes.

The balance check caught another fixture mistake: `fwp_rc_drop` lowers a shared
count but does not destroy the last owner. The fixture now frees its final string
explicitly; omitting that release fails. State fixtures also now explicitly own
their injected child tasks. No production runtime rule changes.

## Calls chosen while a program runs

A function can return another function. `Bool` has values `True` and `False`;
`if id` tests that input because `id` returns it unchanged. Each branch below
uses `const` to return a function. `apply value function` runs that function
on the supplied value:

```fwp
choose : Bool -> (I64 -> I64)
choose = if id (const (add 1)) (const (mul 2))
main = apply 3 (choose True) | echo
```

The parentheses group the chosen function as the second argument of `apply`;
its first argument is `3`. The example prints `4`; choosing `False` would print
`6`. When the choice depends on runtime input, the compiler may need runtime
dispatch rather than a direct call.

[Runtime-call tests](../../tests/runtime_call_ownership.rs) exercise failed entry,
captured aliases, pending arguments, primitive traps and cancellation. Arguments
beyond an entry's immediate arity pass to its returned function; the fixture tests
that internal convention without changing single-argument source semantics.
Borrowed calls preserve the caller's function owner while consuming their arguments.

The failed-call test repeats 10,000 calls with collection disabled. Normal calls
must retain zero bytes; omitting the consumed-function release must retain at least
160,000 bytes. Four other cases repeat 32 rounds and check ARC balance each round.
Omitted outside-alias or scalar-fixture releases must fail. These 58 outcomes use
compiler O2 and C O1/O2 with stack placement enabled to exercise stack captures.
Complete programs also compare with raw interpretation.

## Acceptance and limits

[PR #199](../roadmap-history.md#checked-native-defaults-and-arc-metadata-pr-199)
accepted the original record/allocator batch: 95 saved binaries per host and
sixty allocator observations on six native hosts. [PR #200](../roadmap-history.md#repeated-constructor-and-call-cleanup-pr-200)
accepted constructor/call cleanup with 1,050 saved binaries across six hosts.
[Collection cleanup](collection-cleanup.md) records the following loop/builder batch.

The ten field/alias/cache groups passed focused Linux and Windows checks at
`aa81e2756054e989a292313e1462af00ef4c6d42`, including 569 saved images per host.
[PR #202](../roadmap-history.md#cached-values-aliases-and-failed-calls-pr-202)
passed all final jobs and six-host binary inspection at `46c26002b5f748529a2c6ad5977891cdc1593c06`.

The combined seven-group preparation `a447d6a7e99887be5f02506669bc3b499de298f5` passed all three focused
runs and 853-image inspection on Linux AMD64 and both Windows hosts. This delivery
still requires its own nine production jobs, docs and six-host binary inspection. [The handoff](../development-state.md)
records exact sources and runs; [history](../roadmap-history.md) records delivery.
All seven PLAN areas remain open, including complete removal of tracing.

Windows now includes five formerly omitted groups: match-context, reuse-token,
ARC corpus, HTTP/2 body copies and temporary containers. Coverage controls check
selected targets against production jobs. Linux-only storage tests do not establish
Windows support; Windows has its own native storage tests. These checks strengthen
ownership evidence without changing the production compiler/runtime.
