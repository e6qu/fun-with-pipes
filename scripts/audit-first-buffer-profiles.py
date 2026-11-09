#!/usr/bin/env python3
"""Audit the complete first profile archives on runners, preserving their failures."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import subprocess
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('buffer_profiles', ROOT / 'scripts/profile-returned-buffers.py')
PROFILE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILE)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--arch', choices=('x86_64', 'aarch64'), required=True)
    parser.add_argument('--gh', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    metadata = json.loads((ROOT / 'docs/measurements/returned-buffer-phases-2026-11-09/profile-first-artifacts.json').read_text())
    host = {'x86_64': 'amd', 'aarch64': 'arm'}[args.arch]
    entry, = [row for row in metadata['artifacts'] if row['host'] == host]
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    path = output / 'first.zip'
    with path.open('wb') as stream:
        subprocess.run([args.gh, 'api', f'repos/e6qu/fun-with-pipes/actions/artifacts/{entry["id"]}/zip'],
                       stdout=stream, check=True, timeout=180)
    assert path.stat().st_size == entry['bytes']
    assert hashlib.sha256(path.read_bytes()).hexdigest() == entry['sha256']
    prefix = 'returned-buffer-profiles/'
    with zipfile.ZipFile(path) as archive, tempfile.TemporaryDirectory(prefix='buffer-profile-audit-') as scratch:
        names = archive.namelist()
        assert len(names) == len(set(names))
        manifest = json.loads(archive.read(prefix + 'manifest.json'))
        assert set(manifest) == {name.removeprefix(prefix) for name in names if name.startswith(prefix)
                                 and not name.endswith('/') and name != prefix + 'manifest.json'}
        for name, checksum in manifest.items():
            assert not Path(name).is_absolute() and '..' not in Path(name).parts
            digest = hashlib.sha256()
            with archive.open(prefix + name) as stream:
                while chunk := stream.read(65536):
                    digest.update(chunk)
            assert digest.hexdigest() == checksum, name
        report = json.loads(archive.read(prefix + 'report.json'))
        assert (report['source'], report['architecture']) == (metadata['source'], args.arch)
        PROFILE.PROFILES.check_unwinding(report['unwinding'])
        PROFILE.PROFILES.check_control(report['controls']['ordinary'], report['controls']['omitted'])
        commands = [json.loads(line) for line in archive.read(prefix + 'commands.jsonl').splitlines()]
        failures = [row for row in commands if row['status']]
        assert len(failures) == (5 if host == 'arm' else 0)
        for row in failures:
            assert row['command'][0] == 'rustc' and row['status'] == 1
            assert '__stack_chk_guard@@GLIBC_2.17' in row['stderr'] and 'DSO missing from command line' in row['stderr']
        diagnostics = [dict(command=row['command'], status=row['status'], stderr=row['stderr'])
                       for row in commands if row['stderr']]
        (output / 'diagnostics.json').write_text(json.dumps(diagnostics, indent=2) + '\n')
        for row in commands:
            if row['status'] == 0:
                assert not re.search(r'\b(error|warning|failed|fatal)\b', row['stderr'], re.I), row
        revised = {}
        for label, case in report['cases'].items():
            language = label.split('-', 1)[0]
            profiles = revised[label] = []
            for row in case['profiles']:
                relative = f'{label}/profile-{row["length"]}-{row["sample"]}'
                directory = Path(scratch) / relative
                directory.mkdir(parents=True)
                for filename in ('allocations.txt', 'allocations.stacks', 'peak.stacks', 'leaked.stacks'):
                    (directory / filename).write_bytes(archive.read(prefix + relative + '/' + filename))
                assert PROFILE.PROFILES.summarize(directory) == row['process']
                # Check the original, faulty observer too; do not rewrite its result.
                symbol = {'c': 'returned_buffer_make', 'rs': 'returned_buffer::make', 'swift': 'bufferMake'}[language]
                original = {cost: sum(value for stack, value in PROFILE.PROFILES.stacks(
                    (directory / (cost + '.stacks')).read_text()) if symbol in stack) for cost in PROFILE.PROFILES.COSTS}
                assert original == row['factory']
                profiles.append(dict(length=row['length'], sample=row['sample'], factory=PROFILE.factory_costs(directory, language)))
        expected_languages = ('c', 'swift') if host == 'arm' else ('c', 'rs', 'swift')
        assert set(revised) == {f'{language}-{shared}-{variant}' for language in expected_languages for shared in (0, 1)
                               for variant in (('ordinary', 'omit-first', 'omit-last') if shared else ('ordinary', 'omit-first'))}
        for language in expected_languages:
            for shared in (0, 1):
                ordinary = revised[f'{language}-{shared}-ordinary']
                assert len(ordinary) == 4
                for variant in (('omit-first', 'omit-last') if shared else ('omit-first',)):
                    omitted = revised[f'{language}-{shared}-{variant}']
                    assert len(omitted) == 4
                    for before, after in zip(ordinary, omitted):
                        assert (before['length'], before['sample']) == (after['length'], after['sample'])
                        PROFILE.check_release(before['factory']['storage'], after['factory']['storage'], before['length'], 4096, 16)
                        for cost in ('allocations', 'leaked'):
                            assert before['factory']['metadata'][cost] == after['factory']['metadata'][cost]
        result = dict(source=metadata['source'], architecture=args.arch, artifact=entry, commands=len(commands),
                      linkFailures=len(failures), originalFailures=report['failures'], revisedAttribution=revised,
                      scope='Reinterpretation of retained raw stacks, not new profiles or a passing original run')
        (output / 'audit.json').write_text(json.dumps(result, indent=2) + '\n')
    print('Complete first archive, command diagnostics and original/revised allocation attribution audited')


if __name__ == '__main__':
    main()
