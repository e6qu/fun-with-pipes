# Captured scalar array maps: verified delivery

[PR #271](https://github.com/e6qu/fun-with-pipes/pull/271) merged as
`b76306b20a1d7727917ef6184c9a8716967ceb89`. Tested source
`9584ae2e293529430af983b2030fc9cb43add01f` has the same tree:
`163d7093b878080d0b63592b24ab45442f6770a0`. The squash message is one line,
under 80 characters, with no body or trailers.

| Gate | Result |
|---|---|
| [Nine production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/42482501918) | Pass, attempt 1 |
| [Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/42482501764) | Pass, job `128737287761` |
| [Complete log/artifact audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42490732997) | Pass, job `128762314926` |

The [archive](audit.zip) retains all ten job audits, full logs and target/probe
records. Its SHA-256 matches [GitHub's artifact metadata](artifact.json):
`5894ebd598ac4481ca9a0d930c682dae43ca25748833df1beec3c1aef0a29fd9`.
[The audit log](audit.log.gz) records all host results. No unexpected compiler
diagnostic or failed target remains. Intel macOS took longer than the previous
run; its complete log shows continued successful target completion, not a stall.

The [measurements](../captured-map-repaired-2026-11-08/README.md) retain 84–94%
less computation on both largest applications, lower allocation/working storage,
and no qualified regression. Noisy identical-copy controls leave the combined
timing target open. Delivery does not turn those observations into a timing pass
or establish parity with Swift, C or Rust.

The superseded initial final-head runs `42482278753` and `42482278727` were
cancelled after a documentation correction: the local-gradient helper remains
an experimental fixture. Their started logs were reviewed. Missing artifact
errors followed cancellation before evidence creation; no native failure was
hidden by replacing those runs.
