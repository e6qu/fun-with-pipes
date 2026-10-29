#!/usr/bin/env python3
"""Create and verify an evidence ZIP before uploading its bytes unchanged."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import stat
import subprocess
import zipfile


def package(root, output, manifest, source, compression):
    root, output, manifest = root.resolve(), output.resolve(), manifest.resolve()
    assert root.is_dir() and not output.is_relative_to(root) and not manifest.is_relative_to(root)
    assert re.fullmatch('[0-9a-f]{40}', source) and 0 <= compression <= 9
    assert not output.exists(), 'refuse to replace an evidence archive'
    report = dict(source=source, files={}, complete=False)
    partial = output.with_name(output.name + '.partial')
    output.parent.mkdir(parents=True, exist_ok=True)
    manifest.parent.mkdir(parents=True, exist_ok=True)
    current = None
    try:
        with zipfile.ZipFile(partial, 'x', zipfile.ZIP_DEFLATED, compresslevel=compression) as archive:
            for path in sorted(root.rglob('*')):
                current = path.relative_to(root).as_posix()
                before = path.lstat()
                if stat.S_ISDIR(before.st_mode):
                    continue
                if not stat.S_ISREG(before.st_mode):
                    raise ValueError(f'non-regular evidence file: {current}')
                checksum = hashlib.sha256()
                size = 0
                with path.open('rb') as stream, archive.open(current, 'w', force_zip64=True) as member:
                    while chunk := stream.read(1024 * 1024):
                        checksum.update(chunk)
                        size += len(chunk)
                        member.write(chunk)
                archive.getinfo(current).external_attr = before.st_mode << 16
                after = path.lstat()
                identity = lambda value: (value.st_dev, value.st_ino, value.st_size, value.st_mtime_ns)
                if identity(before) != identity(after) or size != before.st_size:
                    raise ValueError(f'evidence changed while reading: {current}')
                report['files'][current] = dict(bytes=size, sha256=checksum.hexdigest())
            if not report['files']:
                raise ValueError('no evidence files')
        # Check actual archived bytes, not just the source files or ZIP headers.
        with zipfile.ZipFile(partial) as archive:
            assert set(archive.namelist()) == set(report['files'])
            for current, expected in report['files'].items():
                checksum = hashlib.sha256()
                size = 0
                with archive.open(current) as member:
                    while chunk := member.read(1024 * 1024):
                        checksum.update(chunk)
                        size += len(chunk)
                assert dict(bytes=size, sha256=checksum.hexdigest()) == expected, current
        partial.rename(output)
        report['complete'] = True
    except BaseException as error:
        report['failure'] = dict(file=current, type=type(error).__name__, message=str(error))
        raise
    finally:
        manifest.write_text(json.dumps(report, indent=2) + '\n')
    print(f'Verified {len(report["files"])} evidence files in {output.name}')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--manifest', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--compression', type=int, choices=range(10), required=True)
    args = parser.parse_args()
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == args.source
    package(args.input, args.output, args.manifest, args.source, args.compression)


if __name__ == '__main__':
    main()
