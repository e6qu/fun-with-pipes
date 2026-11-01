#!/usr/bin/env python3
"""Recompute numeric array comparison evidence without executing saved binaries."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import struct
import subprocess

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('descent_groups', ROOT / 'scripts/check-descent-groups.py')
GROUPS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(GROUPS)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def instruction_bytes(binary, architecture):
    assert binary[:6] == b'\x7fELF\x02\x01'
    assert struct.unpack_from('<H', binary, 18)[0] == {'x86_64': 62, 'aarch64': 183}[architecture]
    offset = struct.unpack_from('<Q', binary, 40)[0]
    stride, count, names_index = struct.unpack_from('<HHH', binary, 58)
    assert stride == 64 and 0 < names_index < count
    sections = [struct.unpack_from('<IIQQQQIIQQ', binary, offset + index * stride) for index in range(count)]
    names = sections[names_index]
    strings = binary[names[4]:names[4] + names[5]]
    total = 0
    for section in sections:
        name = strings[section[0]:].split(b'\0', 1)[0]
        if name == b'.text' or name.startswith(b'.text.'):
            assert section[1] == 1 and section[2] & 4  # stored executable section
            assert section[4] + section[5] <= len(binary)
            total += section[5]
    assert total > 0
    return total


def check_round(record, order, output_hashes):
    assert record['complete'] and record['order'] == order
    assert [row['label'] for row in record['observations']] == order
    totals = dict.fromkeys(output_hashes, 0)
    for row in record['observations']:
        assert row['status'] == 0 and row['outputMatches']
        assert type(row['elapsedNs']) is int and row['elapsedNs'] > 0
        assert row['stdoutSha256'] == output_hashes[row['label']]
        assert row['stderrSha256'] == digest(b'')
        totals[row['label']] += row['elapsedNs']
    assert record['totalsNs'] == totals
    return totals


def check_profiles(folder, row):
    for label, profile in row['fwpProfiles'].items():
        managed, raw = [json.loads(line) for line in (folder / (label + '-profile.stderr')).read_text().splitlines()]
        raw = raw['rawDerivativeStorage']
        assert profile['managed'] == managed
        assert profile['expandedRawSha256'] == digest(json.dumps(raw, sort_keys=True).encode())
        GROUPS.DESCENT.AD.RAW.check_profile(raw, row['updates'] * row['solvesPerProcess'], True)
        checkpoints = raw.pop('afterBackward')
        assert not checkpoints or all(value == checkpoints[0] for value in checkpoints)
        raw['afterBackwardRepeated'] = dict(count=len(checkpoints), value=checkpoints[0] if checkpoints else None)
        assert profile['rawDerivativeStorage'] == raw
        managed, raw = [json.loads(line) for line in (folder / (label + '-no-workspace.stderr')).read_text().splitlines()]
        assert profile['withoutWorkspace'] == dict(managed=managed, **raw)
        GROUPS.DESCENT.AD.RAW.check_profile(raw['rawDerivativeStorage'], row['updates'] * row['solvesPerProcess'], False)
        phases = json.loads((folder / (label + '-phase-observations.json')).read_text())
        assert row['phaseObservations'][label]['observations'] == phases


def check_directory(folder, source, architecture, session):
    report = json.loads((folder / 'comparison.json').read_text())
    GROUPS.check_report(report, source, 'array-lists')
    assert report['machine'] == architecture and report['configuration']['session'] == session
    assert report['results'] == json.loads((folder / 'results.json').read_text())
    assert report['commands'] == json.loads((folder / 'build-commands.json').read_text())
    failures = GROUPS.DESCENT.paired_budget_failures(report['results'], 'array-lists')
    assert failures == json.loads((folder / 'budget-failures.json').read_text())
    for path, checksum in report['sourceHashes'].items():
        assert digest(subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)) == checksum, path
    emitters = [command['command'] for command in report['commands'] if '--emit-c' in command['command']]
    assert len(emitters) == 24
    assert len({command[2] for command in emitters}) == 1
    for command in emitters:
        assert command[0] == 'env'
        source_path = next(argument for argument in command if argument.endswith('.fwp'))
        expected = '0' if Path(source_path).stem.endswith('-reference') else '1'
        assert command[1] == 'FWP_ARRAY_FUSION=' + expected
    for name, row in report['results'].items():
        case = folder / name
        assert row['oracle'] == GROUPS.DESCENT.AD.analytic(row['dimensions'], row['updates'] + 1)
        saved = json.loads((case / 'samples.json').read_text())
        assert saved == {key: row[key] for key in ('orders', 'samplesNs', 'processesPerLabel')}
        for phase, count in [('warmup', 2), ('sample', 49)]:
            for index in range(count):
                record = json.loads((case / f'{phase}-{index:03d}.json').read_text())
                totals = check_round(record, row['orders'][index], row['outputSha256'])
                if phase == 'sample':
                    assert totals == {label: values[index] for label, values in row['samplesNs'].items()}
        for label, checksum in row['outputSha256'].items():
            output = (case / (label + '.stdout')).read_bytes()
            assert digest(output) == checksum
            GROUPS.DESCENT.verify(output, row['oracle'], row['solvesPerProcess'])
            rss = (case / (label + '-rss.txt')).read_text()
            match = re.search(r'Maximum resident set size \(kbytes\):\s*(\d+)', rss)
            assert match and int(match[1]) * 1024 == row['peakProcessRssBytes'][label]
        for image, metadata in row['binaries'].items():
            binary = (case / image).read_bytes()
            assert digest(binary) == metadata['sha256'] and len(binary) == metadata['bytes']
            assert instruction_bytes(binary, architecture) == metadata['instructionBytes']
            suffix = '.rs' if image == 'rust-explicit' else '.c'
            assert digest((case / (image + suffix)).read_bytes()) == metadata['sourceSha256']
            assert digest((case / (image + '.asm')).read_bytes()) == metadata['disassemblySha256']
            sections = (case / (image + '.sections')).read_text()
            count = sum(int(size, 16) for size in re.findall(r'^\s*\d+\s+\.text(?:\.[^\s]+)?\s+([0-9a-fA-F]+)', sections, re.M))
            assert count == metadata['instructionBytes']
            if image.startswith('fwp-'):
                symbols = (case / (image + '.symbols')).read_text()
                assert not any(symbol in symbols for symbol in ('fwp_heap_scan', 'fwp_heap_mark_all', 'fwp_heap_sweep'))
        for name, metadata in row['cCompilerStackUsage'].items():
            raw = (case / name).read_bytes()
            assert digest(raw) == metadata['sha256']
            entries = []
            for line in raw.decode().splitlines():
                location, size, qualifier = line.split('\t')
                entries.append(dict(location=location, bytes=int(size), qualifier=qualifier))
            assert entries == metadata['entries']
        for name, control in row['controls'].items():
            assert digest((case / (name + '.stdout')).read_bytes()) == control['stdoutSha256']
            assert (case / (name + '.stderr')).read_text() == control['stderr']
        check_profiles(case, row)
    files = {str(path.relative_to(folder)): dict(bytes=path.stat().st_size, sha256=digest(path.read_bytes()))
             for path in sorted(folder.rglob('*')) if path.is_file()}
    return dict(source=source, architecture=architecture, session=session, files=files,
                budgetFailures=failures, decision='not-accepted' if failures else 'accepted')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--arch', choices=['x86_64', 'aarch64'], required=True)
    parser.add_argument('--session', type=int, choices=[1, 2], required=True)
    parser.add_argument('--summary', type=Path, required=True)
    args = parser.parse_args()
    summary = check_directory(args.input, args.source, args.arch, args.session)
    args.summary.write_text(json.dumps(summary, indent=2) + '\n')
    print(f"All six cases audited; {len(summary['budgetFailures'])} original budget failures retained")
