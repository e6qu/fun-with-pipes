# Direct scalar array callbacks: verification

The [contract](../direct-array-callbacks.md) compares direct calls with the same
compiler using generic callback application. Timing has not started.

## First focused run

Run [41638033527](https://github.com/e6qu/fun-with-pipes/actions/runs/41638033527)
failed on Linux ARM64/AMD64 and macOS ARM64 at `8537e7a9`. All three complete job
logs and metadata are retained here; [the audit](first-audit.json) records hashes
and failed steps. No native test target ran.

- **Compiler error:** the generated C initializer's closing brace was not escaped
  in Rust's format string. Escape the brace; this changes no ownership policy.
- **Evidence error:** an early compiler failure left no artifact directory. Record
  source/host/compiler identity before checks and retain formatting, lint and build
  logs. Run native checks independently when the compiler builds, even if lint
  fails; each failure still fails the job.

The repaired source still needs native verification. No performance or memory
improvement is claimed yet.
