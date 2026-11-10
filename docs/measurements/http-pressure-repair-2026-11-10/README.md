# Windows HTTP backpressure repair, November 10

**The focused repair passes on native Windows ARM64 and AMD64.** Final delivery
of the combined PR still requires its exact-head production gates and log audit.
[The repair contract](../http-backpressure.md) explains the unchanged acceptance.

## Cause and repair

Both Windows production jobs at `a0261f9ccaa4a87651fbcae11966afee68208d4d`
failed while waiting for a blocked socket write. The other seven jobs passed.
All nine full logs are retained; there is no other failed target or compiler warning.

The isolated diagnostic at `9054528ba` confirms that Winsock accepted all
8,388,717 response bytes in one successful send. Requesting a 16 KiB send buffer
did not force backpressure. This was a test assumption, not a blocked runtime.

Candidate `924eb879540af7f25d861fb5d22f3e5272b79129` caps diagnostic sends at
16 KiB and sets/reads back a 256 KiB receive-buffer request on the unread Windows
client. Ordinary runtime sends and throughput settings are unchanged. The same
test still requires actual would-block events, other-client progress, exact bytes,
partial-request/disconnect cleanup and the original deadlines.

The diagnostic also panicked while holding its log mutex, then cleanup panicked
on the poisoned lock. `e58842d01` releases the lock before panicking. That correction
is in the combined source; it does not change the candidate's verified success path.

## Verification

Both focused jobs pass all 11 ordinary HTTP tests and linting. The sole ignored
test requires an explicitly supplied saved binary; it is not platform coverage.
All six large-response cohorts observe blocked writes. All eight cohorts return
to 2,096 managed bytes and one listener task; final shutdown closes 72/72 sockets
and leaves zero managed bytes and zero observer metadata.

| Windows host | RSS after first cohort (KiB) | Maximum cohort RSS (KiB) | Actual blocked writes |
|---|---:|---:|---:|
| arm64 | 26988 | 27084 | 7 |
| amd64 | 26744 | 26916 | 1012 |

RSS stays within the unchanged warm-baseline + 8 MiB budget. These are diagnostic
memory observations, not throughput or latency measurements. Scheduling changes
the number of blocked writes; that count is not a speed comparison.

- [Original nine-job matrix](https://github.com/e6qu/fun-with-pipes/actions/runs/42730888995).
- [Actual-send reproduction](https://github.com/e6qu/fun-with-pipes/actions/runs/42742448906).
- [ARM64 repair](https://github.com/e6qu/fun-with-pipes/actions/runs/42744070652)
  and [AMD64 repair](https://github.com/e6qu/fun-with-pipes/actions/runs/42744095817).
- `original/` and `repaired/` retain actual server logs, RSS and exit status;
  `analysis.json` independently checks their counts. Complete job logs use gzip.
- `audit.json` records sources, all jobs and artifact identities; `files.json`
  records retained hashes/sizes. Full C and binaries stay in the identified CI
  artifacts until their recorded expiration dates. Selected members passed ZIP CRC;
  whole-archive digests come from GitHub, not an independent local download.
