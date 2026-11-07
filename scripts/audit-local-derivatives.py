"""Audit complete saved local-derivative observations; never rerun timings."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

SPEC = importlib.util.spec_from_file_location('groups', Path(__file__).with_name('check-descent-groups.py'))
GROUPS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(GROUPS)
ROOT = Path(__file__).resolve().parents[1]
LABELS = ['fwp-local', 'fwp-ad', 'fwp-explicit', 'fwp-packed', 'c-explicit', 'rust-explicit', 'fwp-ad-identical']


def digest(data):
    return hashlib.sha256(data).hexdigest()


def audit(directory, source, architecture):
    assert re.fullmatch('[0-9a-f]{40}', source)
    report = json.loads((directory / 'comparison.json').read_text())
    GROUPS.check_report(report, source, 'local-derivatives')
    assert report['machine'] == architecture
    assert report['configuration']['timeout'] == 180
    assert report['configuration']['session'] in (1, 2)
    assert report['configuration']['cc'] == 'gcc' and report['configuration']['rustc'] == 'rustc'
    march = {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[architecture]
    assert report['configuration']['c_arch'] == march
    for path, checksum in report['sourceHashes'].items():
        content = subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)
        assert digest(content) == checksum, path
    failures = GROUPS.DESCENT.local_budget_failures(report['results'])
    assert json.loads((directory / 'budget-failures.json').read_text()) == failures
    assert json.loads((directory / 'build-commands.json').read_text()) == report['commands']
    for name, row in report['results'].items():
        case = directory / name
        for label, checksum in row['outputSha256'].items():
            output = (case / (label + '.stdout')).read_bytes()
            assert digest(output) == checksum
            GROUPS.DESCENT.verify(output, row['oracle'], row['solvesPerProcess'])
        assert row['oracle'] == GROUPS.DESCENT.AD.analytic(row['dimensions'], row['updates'] + 1)
        for label, image in row['binaries'].items():
            raw = (case / label).read_bytes()
            assert len(raw) == image['bytes'] and digest(raw) == image['sha256']
            assert raw[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(raw[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[architecture]
            extension = '.rs' if label == 'rust-explicit' else '.c'
            assert digest((case / (label + extension)).read_bytes()) == image['sourceSha256']
            assert digest((case / (label + '.asm')).read_bytes()) == image['disassemblySha256']
            if label != 'fwp-ad-identical':
                commands = [entry['command'] for entry in report['commands']
                            if '-o' in entry['command']
                            and Path(entry['command'][entry['command'].index('-o') + 1]).parts[-2:] == (name, label)]
                assert len(commands) == 1, (name, label, commands)
                prefix = (['rustc', '--crate-name', 'descent_explicit', '--edition=2021', '-D', 'warnings',
                           '-C', 'opt-level=2', '-C', 'overflow-checks=yes', '-C', 'codegen-units=1',
                           '-C', 'target-cpu=generic', '-C', 'lto=off'] if label == 'rust-explicit' else
                          ['gcc', '-O2', '-std=gnu11', '-fno-fast-math', '-ffp-contract=off',
                           '-UFWP_NO_REUSE', '-fstack-usage', '-march=' + march])
                assert commands[0][:len(prefix)] == prefix
        program = (case / 'fwp-local.c').read_text().split('/* ---- program ---- */', 1)[1]
        assert not re.search(r'\bfwp_(?:p_ad_|tape_)\w*\s*\(', program)
        for filename, stack in row['cCompilerStackUsage'].items():
            raw = (case / filename).read_bytes()
            assert digest(raw) == stack['sha256']
            entries = []
            for line in raw.decode().splitlines():
                location, size, qualifier = line.split('\t')
                entries.append(dict(location=location, bytes=int(size), qualifier=qualifier))
            assert entries == stack['entries']
        for phase, count in [('warmup', 2), ('sample', 98)]:
            for index in range(count):
                record = json.loads((case / f'{phase}-{index:03d}.json').read_text())
                order = GROUPS.SCHEDULE.execution_order(LABELS, 7, index, 20261029)
                assert record['complete'] and record['order'] == order
                assert [item['label'] for item in record['observations']] == order
                totals = dict.fromkeys(order, 0)
                for item in record['observations']:
                    assert item['status'] == 0 and item['outputMatches']
                    assert item['stdoutSha256'] == row['outputSha256'][item['label']]
                    assert item['stderrSha256'] == digest(b'')
                    assert type(item['elapsedNs']) is int and item['elapsedNs'] > 0
                    totals[item['label']] += item['elapsedNs']
                assert record['totalsNs'] == totals
                if phase == 'sample':
                    assert all(row['samplesNs'][label][index] == value for label, value in totals.items())
        for label, profile in row['fwpProfiles'].items():
            managed, raw = [json.loads(line) for line in (case / (label + '-profile.stderr')).read_text().splitlines()]
            assert managed == profile['managed']
            raw = raw['rawDerivativeStorage']
            assert digest(json.dumps(raw, sort_keys=True).encode()) == profile['expandedRawSha256']
            checkpoints = raw.pop('afterBackward')
            raw['afterBackwardRepeated'] = dict(count=len(checkpoints), value=checkpoints[0] if checkpoints else None)
            assert raw == profile['rawDerivativeStorage']
            if label == 'fwp-ad':
                unmanaged, uncached = [json.loads(line) for line in (case / (label + '-no-workspace.stderr')).read_text().splitlines()]
                assert dict(managed=unmanaged, **uncached) == profile['withoutWorkspace']
        for label, control in row['controls'].items():
            assert digest((case / (label + '.stdout')).read_bytes()) == control['stdoutSha256']
            assert (case / (label + '.stderr')).read_text() == control['stderr']
        for label, observations in row['phaseObservations'].items():
            assert json.loads((case / (label + '-phase-observations.json')).read_text()) == observations['observations']
        for label, size in row['peakProcessRssBytes'].items():
            text = (case / (label + '-rss.txt')).read_bytes()
            match = re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', text)
            assert match and int(match[1]) * 1024 == size
    files = {str(path.relative_to(directory)): dict(bytes=path.stat().st_size, sha256=digest(path.read_bytes()))
             for path in sorted(directory.rglob('*')) if path.is_file() and path.name != 'audit.json'}
    result = dict(source=source, architecture=architecture, files=files, budgetFailures=failures)
    (directory / 'audit.json').write_text(json.dumps(result, indent=2) + '\n')
    print(f'{architecture}: all six complete cases verified; {len(failures)} timing misses retained')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--architecture', choices=['aarch64', 'x86_64'], required=True)
    args = parser.parse_args()
    audit(args.directory, args.source, args.architecture)
