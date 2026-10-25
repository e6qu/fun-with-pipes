# C callbacks that outlive their creating call

A callback is a function that another component calls later. A bare C function
pointer contains an address, but no captured arguments. fwp's ordinary `foreign
"C"` callbacks use the current foreign call's context and expire when that call
returns. C must not save those pointers for later use.

The current G3 preparation adds an explicit registration API for selected library
exports. A **registration** owns copied leading arguments and identifies the
function to call. C supplies its final argument on each invocation. This uses a
normal compiled function and a context pointer, with no generated executable
trampoline. Integrated compiler and platform validation is still pending; see
[the handoff](development-state.md).

## Register, call and release

Here `const` keeps its first argument and ignores its second. `keep "hello"` is
therefore a function that returns `"hello"` whenever passed `()`:

```fwp
export keep : String -> () -> String
keep = const
```

Save this as `callback.fwp`. On macOS or Linux, generate a static library with:

```sh
fwp build callback.fwp --gc arc --staticlib --c-callback keep -O2 -o callback.a
```

`--c-callback` names the C export symbol; repeat it to select more exports. The
compiler maps hyphens in source export names to underscores in C. Registration
copies all arguments except the last. The generated `callback.h` declares:

```c
struct fwp_callback_keep;
struct fwp_callback_keep *fwp_register_keep(const char *);
int fwp_invoke_keep(struct fwp_callback_keep *, const char **);
void fwp_close_keep(struct fwp_callback_keep *);
void fwp_release_callback_keep(struct fwp_callback_keep *);
void fwp_release_keep(const char *);
```

The unit argument `()` has no C parameter. The output pointer receives the owned
result only when `invoke` returns 1. A closed registration returns 0 and leaves
that pointer unchanged. A complete C call sequence is:

```c
#include "callback.h"
#include <stdio.h>

int main(void) {
    struct fwp_callback_keep *callback = fwp_register_keep("hello");
    const char *result = NULL;
    int called = fwp_invoke_keep(callback, &result);
    fwp_close_keep(callback);
    fwp_release_callback_keep(callback);
    if (called) {
        puts(result);                    /* prints hello */
        fwp_release_keep(result);
    }
    return 0;
}
```

The result has its own owner, so it survives releasing the registration. Never
use `free` on it or release copies of its pointer. Use the generated release
function once per successful owned result. Scalar results need no release.
A function whose result is `()` has no output-pointer parameter.

For `String -> I64 -> I64`, registration takes the string; invocation takes the
registration, an integer and a pointer to the integer result. For a unary
function such as `I64 -> I64`, registration has no captured arguments. Constants
with no final function argument cannot be registered.

## Closing during a call

C owns exactly one registration. `close` is idempotent and prevents new calls.
`release_callback` closes and consumes that owner. Do not use the registration
again after release, including to close or release it a second time.

An active call borrows the captured owners. Closing or releasing during reentry
marks the registration closed immediately, but destruction waits until its last
active call returns or unwinds. Neither operation blocks: waiting inside a call
for that same call would deadlock. Language errors and task cancellation run the
same active-call cleanup. Invocation is not an error handler; unhandled failures
follow the ordinary library export policy.

Before releasing a registration, the C host must stop any source of future
callback delivery. Before unloading the library, it must also finish active
calls and release every registration and owned result. A registration is a
unique host-owned object plus an active-call count, not a reference-counted
function wrapper. Captured values use their existing ownership rules; a call
borrows them where proved and adds an owner only when its callee consumes one.

## Thread and pointer rules

All calls into a callback-enabled library, including ordinary exports and result
releases, must use the OS thread of its first call. Nested calls on that thread
are allowed. Another thread must arrange delivery on the owning thread; the
runtime rejects direct entry from a different thread. It does not run cleanup
on another thread's stack. Initial calls must also be serialized by the host.

Strings and supported flat `repr(C)` records copy into the registration. Copying
a raw pointer copies only its address: its pointee's lifetime, synchronization
and cleanup remain the C caller's responsibility. The compiler cannot infer
those obligations from an arbitrary external library.

This API selects a known export and captures its leading C arguments. It does
not export an arbitrary runtime-created fwp closure, admit function fields in
`repr(C)` records, or extend the lifetime of ordinary scoped callbacks. Native
checked-ARC libraries support this path; tracing and WebAssembly library builds
are rejected. Existing restrictions on owning cycles still apply.

## Checks

[The source fixture](../tests/fixtures/retained_callbacks.fwp) covers strings,
records, scalar and unit arguments/results, and multiple captures.
[The native test](../tests/retained_callbacks.rs) builds a separate C host against
the generated header at O1/O2. Eight and 1,024 rounds check result survival,
closed entry and reclamation. It also checks nested release, caught errors,
cancellation, partial construction, wrong-thread entry and unfinished unload. A separate
[loader host](../tests/fixtures/retained_callbacks_host.c) opens and closes the
shared library three times, checking cleanup at each actual unload.

The [C probe](../tests/fixtures/retained_callbacks_probe.c) checks physical bytes
and live allocation identities before teardown. Deliberately omitted capture or
context destruction must fail with status 241; premature destruction with 242;
missing active-call completion with 243. Omitting the library scheduler root
release must fail its final allocation check with 205. On Linux, a separate
control omits release of idle descriptor-wait metadata belonging to the library;
the host can keep the descriptor itself open. Identity is checked before reading a
possibly freed capture. These tests are prepared, not yet a passing six-platform
support claim. [G4's diagnostic guide](ownership-diagnostics.md) records the other
boundaries needed before removing tracing.
