# Owning strings received by C callbacks

A callback is a function passed to another function to be called later. Here,
“later” must still be during the receiving C call, on the same fwp task. C may
call it repeatedly or reenter fwp; it may not save it after that call returns.

Checked ARC now accepts string arguments supplied by C to these synchronous
callbacks. It copies each valid, NUL-terminated UTF-8 string into owned fwp
storage before calling the callback. A retained fwp string therefore survives
changes to the C buffer. The [C tutorial](../tutorials/09-c-interop/README.md)
introduces foreign calls and shows this contract in code.

For example, C calls a callback with `"callback text"`, changes its stack buffer
to `"XXXXXXXXXXXXX"`, calls again, then fills the buffer with `Y`. The fwp
callback returns each string's length and saves the latest string in state.
The result is `(26, "XXXXXXXXXXXXX")`: two lengths of 13, and an independent
copy of the second input. Keeping C's pointer instead would incorrectly expose
the later `Y` bytes or dead stack storage.

This does not add retained foreign callbacks. Returning a managed C-string
address from a callback remains rejected in checked ARC because its post-call
lifetime is unproved. Struct-valued callback arguments remain unsupported.
A raw `Ptr[T]` still copies an address without owning its pointee; valid foreign
addresses remain the caller's responsibility.

## Cleanup and failure cases

[The callback test](../../tests/foreign_callback_ownership.rs) compares native
output against the unoptimized interpreter. It covers copied inputs, multiple
strings saved in an fwp record, 65 repeated calls, nesting, caught errors,
suspension and cancellation. Building an internal record does not pass a C struct.

Input conversion can fail before the callback begins. A second C argument that
is NULL or invalid UTF-8 must release the already copied first argument. Native
test recovery then continues to the following test. These controls run at O0/O2
in ARC and tracing; tracing also runs collection stress and verification.
Deliberately omitting the first input's owner must exit with observer code 197.
Ordinary protected cases produce two passing and two intentionally failing tests.

The broader suite preserves raw-buffer, wide-integer, library unload and callback
result/task-context controls. Four C interop tests now require a working C compiler;
missing tools fail rather than silently passing skipped native checks. The focused
workflow deliberately supplies a missing compiler and verifies each diagnostic.

## Evidence and reproduction

Source `6d8ef30bb428e1c0743de4a28fba62b7f3149b36`, tag
`roadmap/revision-callback-inputs-6d8ef30bb428`, passes all six native hosts and
the 32-bit job in
[run 39758960569](https://github.com/e6qu/fun-with-pipes/actions/runs/39758960569).
Select `pointer-ownership` with `native_runner=all` in the **Numerical and ownership
evidence** workflow. Linux uses production GCC, macOS Clang and Windows LLVM-MinGW.

Each native host passes 24 integration test functions; AMD64 Linux also passes
176 compiler unit tests. The corpus executes 82 programs, checks three intended
compile errors and preserves rejection of the invalid inter-task derivative
lifetime. The 32-bit job executes three Rust interpreter tests and one generated
WASI integration test in Node. This is real 32-bit execution, not native-platform
evidence.

[The retained data](callback-inputs-2026-10-22.json) includes complete-log hashes,
source/run IDs, exact outputs and independent inspection of **186 native images
and 12 WASI modules**. Each native host contributes 27 executables and four
static/shared libraries, with generated C, architecture, code-size and disassembly
hashes. Checks verify tracing exclusion in ARC, cleanup failures and unload
ledgers. WASI checks cover actual code, pointer width, wide integer bits and
oversized allocation traps.

These are correctness and ownership checks, not benchmarks. They do not show
zero allocations, universal cycle freedom or C/Rust speed parity. Full production
and documentation acceptance is recorded in
[PR #196's delivery history](../roadmap-history.md#array-owner-moves-and-copied-callback-strings-pr-196).
