#!/usr/bin/env python3
"""Reconstruct every peer result from its retained source, command and sample."""
import argparse
import hashlib
import importlib.util
import json
import math
from pathlib import Path

SPEC = importlib.util.spec_from_file_location('peers', Path(__file__).with_name('measure-loop-array-peers.py'))
PEERS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PEERS)
AUDIT = PEERS.AUDIT
COSTS = PEERS.COSTS


def audit(directory, host, source, machine):
    report = json.loads((directory / 'summary.json').read_text())
    assert report['source'] == source and report['machine'] == machine
    assert host['source'] == source and host['qualified'] and host['actual']['machine'] == machine
    original = AUDIT.audit(directory / 'original', machine, 1, report['measuredSource'])
    assert original == json.loads((directory / 'input-audit.json').read_text())
    assert report['cFlags'] == original['identity']['flags']
    assert report['ccVersion'] == original['identity']['ccVersion']
    assert report['rustFlags'] == ['--edition=2021', '-O', '-C', 'target-cpu=generic', '-C', 'lto=off']
    rows = [json.loads(line) for line in (directory / 'commands.jsonl').read_text().splitlines()]
    commands = {row['output']: row for row in rows}
    assert len(commands) == len(rows)
    consumed = set()

    def command(relative):
        row = commands[relative]
        consumed.add(relative)
        assert row['status'] == 0 and row['timedOut'] is False
        assert type(row['elapsedNs']) is int and row['elapsedNs'] > 0
        path = directory / relative
        assert not path.with_suffix('.stderr').read_bytes()
        return path.with_suffix('.stdout').read_bytes(), row

    reports = {}
    for case in COSTS.programs():
        name = case['name']
        path = directory / name
        saved = directory / 'original/array-costs' / name
        c, rust, expected = PEERS.peer_sources(case)
        assert (path / 'c.c').read_text() == c and (path / 'rust.rs').read_text() == rust
        assert (path / 'fwp.c').read_bytes() == (saved / 'candidate.c').read_bytes()
        expected_fwp = json.loads((saved / 'case.json').read_text())['expected']
        assert len(expected_fwp) == len(expected)
        assert all(math.isfinite(a) and math.isclose(a, b, abs_tol=1e-10, rel_tol=1e-10)
                   for a, b in zip(expected, expected_fwp))
        if case['kind'] in ('loop', 'array'):
            assert COSTS.words(expected, case['kind'] == 'loop') == COSTS.words(expected_fwp, case['kind'] == 'loop')
        hashes = {}
        for role in PEERS.ROLES:
            image = (path / role).read_bytes()
            assert image[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[machine]
            hashes[role] = hashlib.sha256(image).hexdigest()
        for role in PEERS.ROLES[:3]:
            assert hashes[role] == hashes[role + '-copy']
            raw, row = command(name + '/' + role + '-build')
            assert not raw
            arguments = row['command']
            flags = report['rustFlags'] if role == 'rust' else report['cFlags']
            assert arguments[1:1+len(flags)] == flags
            tail = arguments[1+len(flags):]
            if role == 'rust':
                cfg = case['kind'] if case['kind'] in ('loop', 'array') else 'descent'
                assert tail[:2] == ['--cfg', f'workload="{cfg}"']
                tail = tail[2:]
                assert len(tail) == 3 and tail[0].endswith('/' + name + '/rust.rs')
            else:
                assert len(tail) == 6 and tail[3:] == ['-lm', '-lpthread', '-ldl']
                assert tail[0].endswith('/' + name + '/' + role + '.c')
            assert tail[1] == '-o' and tail[2].endswith('/' + name + '/' + role)
        samples = [json.loads(line) for line in (path / 'samples.jsonl').read_text().splitlines()]
        checksums = {}
        for language, values in (('fwp', expected_fwp), ('peer', expected)):
            checksum = 0
            words = COSTS.words(values, case['kind'] == 'loop')
            for repetition in range(case['repeats']):
                for word in words:
                    checksum ^= (word + repetition) & ((1 << 64) - 1)
            checksums[language] = checksum
        for row in samples:
            raw, execution = command(f"{name}/round-{row['round']}-{row['role']}")
            assert len(execution['command']) == 1
            assert execution['command'][0].endswith('/' + name + '/' + row['role'])
            assert row == json.loads(raw) | dict(round=row['round'], role=row['role'], processNs=execution['elapsedNs'])
            if row['role'].startswith('fwp'):
                assert row['initialLiveBytes'] == row['finalLiveBytes']
            assert row['checksum'] == checksums['fwp' if row['role'].startswith('fwp') else 'peer']
        result = PEERS.summarize(samples)
        result.update(peerExpectedBits=COSTS.words(expected, case['kind'] == 'loop'),
                      fwpExpectedBits=COSTS.words(expected_fwp, case['kind'] == 'loop'),
                      binaryHashes=hashes)
        result['resources'] = {}
        for role in PEERS.ROLES[:3]:
            raw, row = command(name + '/' + role + '-rss')
            arguments = row['command']
            assert arguments[:3] == ['/usr/bin/time', '-v', '-o'] and len(arguments) == 5
            assert arguments[3].endswith('/' + name + '/' + role + '.resources')
            assert arguments[4].endswith('/' + name + '/' + role)
            value = json.loads(raw)
            assert value['checksum'] == checksums['fwp' if role == 'fwp' else 'peer']
            if role == 'fwp':
                original_sample = next(sample for sample in samples if sample['role'] == 'fwp')
                assert value['initialLiveBytes'] == value['finalLiveBytes'] == original_sample['initialLiveBytes']
            result['resources'][role] = AUDIT.OBSERVATIONS.resources((path / (role + '.resources')).read_text()) | dict(
                elapsedNs=row['elapsedNs'], imageBytes=(path / role).stat().st_size)
        assert result == report['cases'][name]
        reports[name] = result
    assert consumed == set(commands) and set(reports) == set(report['cases'])
    return dict(source=source, measuredSource=report['measuredSource'], host=host,
                cases=reports, commands=len(commands))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--host', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--machine', choices=('aarch64', 'x86_64'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    report = audit(args.directory, json.loads(args.host.read_text()), args.source, args.machine)
    AUDIT.save(args.output, report)
    print('Verified 18 peer cases, sources, native images, commands and all samples; timing qualification is separate.')


if __name__ == '__main__':
    main()
