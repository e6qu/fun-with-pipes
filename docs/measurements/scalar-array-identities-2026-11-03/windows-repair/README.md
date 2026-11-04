# Windows probe stream repair

Production run [41694728758](https://github.com/e6qu/fun-with-pipes/actions/runs/41694728758)
tested `9061744b324ad5b4e7c84866ca36cfcf8597d34a`. Seven production jobs and
documentation passed. Both native Windows jobs failed two `float_formats` tests;
all completed full logs and individual target logs were audited before repair.

## Cause and change

The probes supply their own C `main`, bypassing the generated program entry point.
Normal fwp programs configure Windows standard streams as binary. The two probes
omitted that setup, so the C runtime changed each printed LF into CRLF.

- Four conversion transcripts per host contain 200 rows each. Every input and
  output bit pattern agrees; only the newline bytes differ. All eight programs
  exit zero with empty stderr.
- All 16 deliberate out-of-memory controls per host exit 102 as required. Their
  diagnostic contains CRLF instead of LF.
- The AMD64 log also contains a TLS `unknown ca` diagnostic. It comes from
  `rest_with_client_certificates`, which deliberately supplies an untrusted client
  certificate and requires rejection. That test passes on both hosts.

Both custom entry points now check `_setmode` for stdout and stderr, using the
same binary-stream policy as generated programs. Configuration failure exits 253.
The exact-byte assertions remain unchanged: no output normalization or weaker
comparison is added. No compiler, runtime, library or measured algorithm changes.

## Retained evidence and verification

The `windows-arm-*` and `windows-amd-*` files retain the failed job metadata,
compressed full logs, target-artifact identities and diagnostic audits. The audit
checks all 1,600 conversion rows and 32 fatal-allocation observations. Original
target archives remain identified by GitHub artifact IDs and SHA-256 digests.

Formatting and source checks passed locally through the resource guard. Both
native Windows jobs pass at `8bf9c65b`, as do the other seven production jobs
and documentation. [All final logs and identities](../platforms/final-gates.json)
are audited. Completed performance sessions are unchanged and were not rerun.

See [the experiment](../README.md) for correctness and allocation measurements,
and [the handoff](../../../development-state.md) for current delivery status.
