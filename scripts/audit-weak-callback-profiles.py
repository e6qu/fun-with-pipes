#!/usr/bin/env python3
"""Reconstruct both complete service profile archives on a GitHub runner."""
import argparse
import gzip
import hashlib
import io
import importlib.util
import json
import os
from pathlib import Path
import re
import subprocess
import traceback
import tarfile

from weak_callback_profiles import decode_profiler_status

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('service_profiles', ROOT / 'scripts/profile-weak-callback-service.py')
PROFILES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILES)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--gh', required=True)
    parser.add_argument('--run', required=True, type=int)
    parser.add_argument('--source', required=True)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    args.output.mkdir(parents=True, exist_ok=False)
    report = dict(source=args.source, run=args.run, architectures={}, retained={}, failures=[])
    for arch in ('x86_64', 'aarch64'):
        try:
            folder = args.output / arch
            subprocess.run([args.gh, 'run', 'download', str(args.run), '--repo', 'e6qu/fun-with-pipes',
                            '--name', f'weak-callback-profiles-{arch}-1', '--dir', str(folder)],
                           check=True, timeout=180)
            evidence = folder / 'weak-callback-profiles'
            PROFILES.audit(evidence, args.source, arch)
            commands = [json.loads(line) for line in (evidence / 'commands.jsonl').read_text().splitlines()]
            evidence_report = json.loads((evidence / 'report.json').read_text())
            allocations = {row['command']: row['process']['totals']['allocations']
                           for case in evidence_report['cases'].values() for row in case['profiles']}
            diagnostics = []
            profiler_statistics = []
            for index, row in enumerate(commands):
                assert row['index'] == index
                if row['command'][:2] == [evidence_report['settings']['heaptrack'], '-o']:
                    if index not in allocations:
                        control = Path(row['command'][2]).parent.name
                        assert control in ('control-ordinary', 'control-omitted'), row['command']
                        allocations[index] = evidence_report['controls'][control.removeprefix('control-')]['totals']['allocations']
                    statistics = decode_profiler_status(row['stderr'], allocations[index])
                    profiler_statistics.append(dict(command=index, **statistics))
                elif row['stderr'] and row['stderr'] not in (
                        'service storage not released\n', 'expected population 64|4096 and mode 0|1|2|3\n'):
                    diagnostics.append(dict(index=row['index'], stderr=row['stderr']))
                if re.search(r'(?im)(^|\s)(warning:|error:|traceback)', row['stdout']):
                    diagnostics.append(dict(index=row['index'], stdout=row['stdout']))
            report['architectures'][arch] = dict(commandCount=len(commands), diagnostics=diagnostics,
                                                 profilerStatistics=profiler_statistics)
            assert len(profiler_statistics) == 82
            retained = {'commands.jsonl': (evidence / 'commands.jsonl').read_bytes()}
            buffer = io.BytesIO()
            with tarfile.open(fileobj=buffer, mode='w') as archive:
                for path in sorted(evidence.rglob('*')):
                    if path.is_file() and (path.suffix in ('.stacks', '.txt') or path.name == 'report.json'):
                        info = archive.gettarinfo(str(path), arcname=str(path.relative_to(evidence)))
                        info.mtime = 0
                        info.uid = info.gid = 0
                        info.uname = info.gname = ''
                        with path.open('rb') as stream:
                            archive.addfile(info, stream)
            retained['stacks.tar'] = buffer.getvalue()
            for name, data in retained.items():
                name = arch + '-' + name + '.gz'
                packed = gzip.compress(data, mtime=0)
                (args.output / name).write_bytes(packed)
                report['retained'][name] = dict(bytes=len(data), sha256=hashlib.sha256(data).hexdigest(),
                                                compressedSha256=hashlib.sha256(packed).hexdigest())
            assert not diagnostics, diagnostics
        except Exception as error:
            report['failures'].append(dict(architecture=arch, error=str(error), traceback=traceback.format_exc()))
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    assert not report['failures'], report['failures']
    print('Both complete archives reconstruct all 160 profiles and 32 diagnostic builds without unreviewed command diagnostics')


if __name__ == '__main__':
    main()
