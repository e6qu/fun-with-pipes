# An omitted protecting owner changes file lifetime

**The native fault control passes on Linux ARM64 and AMD64 at O1 and O2.**
Source `cd661ff84b88736ceec83c75e0e2ecf7e6de551d`, tag
`roadmap/nested-resource-lifetime-control-2026-11-10`.
[Run 42792514554](https://github.com/e6qu/fun-with-pipes/actions/runs/42792514554).

The program opens a file and calls a helper that discards its ordinary argument,
then tries to open the file again. Under a four-descriptor limit, the first file
must remain open until that original helper returns:

```text
three standard descriptors + first open file = limit reached
    second open → "Too many open files", exit 1
```

Generated C contains five selected inner borrows and one protecting file-parameter
hold. The negative build removes that real hold and its saved owner. The ordinary
last-use release now closes the first file too soon; the second open succeeds and
the program exits 0. The test requires that changed result. It detects a broken
lifetime, rather than merely checking for comments or a fabricated counter value.

Both compiler optimization levels reproduce these results on both architectures.
The same focused target also verifies original local disposal order and returned
aliases/handled errors. Formatting and Clippy pass; both complete logs contain
no compiler warning or failed test.

| Host | Passing job | Complete native artifact |
|---|---|---|
| ARM64 | `129749269814` | `13752924885` |
| AMD64 | `129749269413` | `13753875211` |

[ARM archive](arm-native.zip) and [AMD archive](amd-native.zip) contain generated
C, native ELF binaries, stdout/stderr and exit statuses. Complete archive sizes,
SHA-256 hashes and every CRC were verified locally; all eight binary architecture
headers and recorded ordinary/fault outcomes agree. [Summary](summary.json),
[artifact identities](artifacts.json), [run receipt](run.json),
[retained hashes](files.json), [ARM log](arm-job.log.gz) and [AMD log](amd-job.log.gz)
preserve the evidence.

This is a safety control, not a timing result. [Native operation counts](../nested-resource-counts-2026-11-10/README.md)
and the [remaining acceptance criteria](../nested-resource-owners.md) are separate.
