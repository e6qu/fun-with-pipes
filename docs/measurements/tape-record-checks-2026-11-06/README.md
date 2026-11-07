# Tape records: focused correctness

[Run 42290415866](https://github.com/e6qu/fun-with-pipes/actions/runs/42290415866)
tests source `b4b291e3184cae5046d7a1eba27e777c67b1884a`.

| Host | Job | Result |
|---|---|---|
| Linux AMD64, GCC | `128142085029` | Pass |
| Linux ARM64, GCC | `128142085462` | Pass, including real wasm32 allocation bounds |
| macOS ARM64, Clang | `128142085304` | Pass |

Each host passes 305 compiler tests, all ten native targets, formatting, lint
and the primitive inventory; Linux also runs the allocation/output controls. Four existing unit tests
are separate compiler measurements; their names and reasons remain in the logs.
They are not claimed as executed here. No unexpected diagnostics occur in any
complete job log. [Log hashes and source identities](logs.json) are retained
alongside the compressed logs and GitHub job records.

The complete native-artifact audit is dispatched as
[42319311816](https://github.com/e6qu/fun-with-pipes/actions/runs/42319311816).
Its result remains pending; passing job summaries alone do not complete acceptance.
