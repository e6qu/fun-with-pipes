#!/usr/bin/env python3
"""Reconstruct retained scalar Swift closure observations from raw profiles."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('closure_profiles', ROOT / 'scripts/profile-swift-closures.py')
PROFILE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILE)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    args = parser.parse_args()
    metadata = json.loads((args.directory / 'artifacts.json').read_text())
    source = metadata['source']
    assert subprocess.check_output(['git', 'rev-parse', 'roadmap/swift-scalar-closures-2026-11-09'],
                                   cwd=ROOT, text=True).strip() == source
    assert {entry['host'] for entry in metadata['artifacts']} == {'amd', 'arm', 'arm-first'}
    prefix = 'swift-closure-evidence/'
    for entry in metadata['artifacts']:
        path = args.directory / (entry['host'] + '.zip')
        assert path.stat().st_size == entry['bytes']
        assert hashlib.sha256(path.read_bytes()).hexdigest() == entry['sha256']
        if entry['host'] == 'arm-first':
            assert entry['profiles'] is False
            continue
        assert entry['profiles'] is True
        with zipfile.ZipFile(path) as archive, tempfile.TemporaryDirectory(prefix='fwp-closure-records-') as scratch:
            names = archive.namelist()
            assert len(set(names)) == len(names), 'duplicate archive member'
            manifest = json.loads(archive.read(prefix + 'manifest.json'))
            expected = {name.removeprefix(prefix) for name in names
                        if name.startswith(prefix) and not name.endswith('/') and name != prefix + 'manifest.json'}
            assert set(manifest) == expected
            for name, checksum in manifest.items():
                assert not Path(name).is_absolute() and '..' not in Path(name).parts
                digest = hashlib.sha256()
                with archive.open(prefix + name) as member:
                    while chunk := member.read(65536):
                        digest.update(chunk)
                assert digest.hexdigest() == checksum, name
            report = json.loads(archive.read(prefix + 'report.json'))
            assert report == json.loads((args.directory / (entry['host'] + '-report.json')).read_text())
            assert report['source'] == source
            assert report['architecture'] == {'amd': 'x86_64', 'arm': 'aarch64'}[entry['host']]
            assert report['input'] == list(PROFILE.INPUT)
            PROFILE.PROFILES.check_unwinding(report['unwinding'])
            commands = [json.loads(line) for line in archive.read(prefix + 'commands.jsonl').splitlines()]
            assert commands and all(row['status'] == 0 for row in commands)
            for filename in ('returned_callable_peer.swift', 'returned_callable_time.swift',
                             'callable_phase_clock.c', 'callable_phase_clock.h'):
                original = subprocess.check_output(['git', 'show', source + ':tests/fixtures/' + filename], cwd=ROOT)
                assert archive.read(prefix + filename) == original

            def restore_stacks(name):
                folder = Path(scratch) / name
                folder.mkdir()
                for filename in ('allocations.txt', 'allocations.stacks', 'peak.stacks', 'leaked.stacks'):
                    (folder / filename).write_bytes(archive.read(prefix + name + '/' + filename))
                return folder

            controls = {}
            for variant, name in [('release', 'control-release'), ('omitted', 'control-omitted')]:
                controls[variant] = PROFILE.PROFILES.summarize(restore_stacks(name))
                assert controls[variant] == report['controls'][variant]
            PROFILE.PROFILES.check_control(controls['release'], controls['omitted'])
            assert set(report['cases']) == {f'{variant}-{kind}' for variant in ('ordinary', 'omitted') for kind in (0, 1)}
            for kind in (0, 1):
                for variant in ('ordinary', 'omitted'):
                    row = report['cases'][f'{variant}-{kind}']
                    assert hashlib.sha256(archive.read(prefix + variant)).hexdigest() == row['binarySha256']
                    assert len(row['profiles']) == 2
                    for sample, observation in enumerate(row['profiles']):
                        folder = restore_stacks(f'{variant}-{kind}-{sample}')
                        assert observation == dict(process=PROFILE.PROFILES.summarize(folder),
                                                   factory=PROFILE.factory_costs(folder))
                        assert observation['factory'] == dict(allocations=1048576,
                            peak=98304 if variant == 'ordinary' else 25165824,
                            leaked=0 if variant == 'ordinary' else 25165824)
                for sample in range(2):
                    PROFILE.check_release(report['cases'][f'ordinary-{kind}']['profiles'][sample]['factory'],
                                          report['cases'][f'omitted-{kind}']['profiles'][sample]['factory'])
    print('Both native scalar closure reports, raw stacks, manifests and release controls agree')


if __name__ == '__main__':
    main()
