#!/usr/bin/env python3
"""Reconstruct captured-map results from sources, commands and every raw sample."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import struct
import subprocess

from borrowed_array_reference import captured_reference_source
from captured_map_costs import ROOT, cases, driver, expected, program, raw_program

SPEC = importlib.util.spec_from_file_location('measure', ROOT / 'scripts/measure-captured-maps.py')
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)


def native_hash(path, machine):
    data = path.read_bytes()
    assert len(data) >= 64 and data[:6] == b'\x7fELF\x02\x01'
    assert int.from_bytes(data[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[machine]
    return hashlib.sha256(data).hexdigest()


def checksum(case):
    result = 0
    words = expected(case['kind'], case['count'], case['updates'])
    for repetition in range(case['repeats']):
        for word in words:
            result ^= (word + repetition) & ((1 << 64) - 1)
    return result


def audit(directory, reference, source, machine, session):
    identity = json.loads((directory / 'identity.json').read_text())
    assert identity['source'] == source and identity['machine'] == machine and identity['session'] == session
    host = identity['host']
    assert host['qualified'] and host['source'] == source and host['actual']['machine'] == machine
    candidate = subprocess.check_output(['git', 'show', source + ':src/cgen/owned_numeric.rs'], cwd=ROOT)
    isolated = captured_reference_source(candidate.decode()).encode()
    manifest = json.loads((reference / 'manifest.json').read_text())
    assert manifest == identity['reference'] and manifest['source'] == source
    assert manifest['disabled'] == 'captured-maps'
    assert manifest['candidateSha256'] == hashlib.sha256(candidate).hexdigest()
    assert manifest['referenceSha256'] == hashlib.sha256(isolated).hexdigest()
    assert (reference / 'cgen-reference.rs').read_bytes() == isolated
    patch = (reference / 'reference.patch').read_bytes()
    assert manifest['patchSha256'] == hashlib.sha256(patch).hexdigest()
    assert (reference / 'built.patch').read_bytes() == patch
    assert patch.count(b'diff --git ') == 1 and patch.startswith(
        b'diff --git a/src/cgen/owned_numeric.rs b/src/cgen/owned_numeric.rs\n')
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fno-lto',
             '-march=' + {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[machine], '-fstack-usage']
    assert identity['flags'] == flags
    assert identity['ccVersion'].splitlines()[0] == host['actual']['cVersion']
    assert len(identity['affinity']) == host['actual']['processors']
    assert identity['settings'] == dict(FWP_LTO='0', FWP_STACK='1', FWP_ARRAY_FUSION='1',
        FWP_PACKED_ARRAYS='1', FWP_VRET='1', FWP_FRAME_FIELDS='1')
    rows = [json.loads(line) for line in (directory / 'commands.jsonl').read_text().splitlines()]
    commands = {row['output']: row for row in rows}
    assert len(commands) == len(rows)
    consumed = set()

    def command(relative, arguments, observed=False):
        row = commands[relative]
        consumed.add(relative)
        assert row['status'] == 0 and row['timedOut'] is False
        assert type(row['elapsedNs']) is int and row['elapsedNs'] > 0
        path = directory / relative
        actual = row['command']
        cost = dict(elapsedNs=row['elapsedNs'])
        if observed:
            assert actual[:3] == ['/usr/bin/time', '-v', '-o']
            assert actual[3] == str(path.with_suffix('.resources'))
            actual = actual[4:]
            cost.update(MEASURE.OBS.resources(path.with_suffix('.resources').read_text()))
            assert all(value >= 0 for value in cost.values())
        assert actual == list(map(str, arguments)), (relative, actual, arguments)
        assert not path.with_suffix('.stderr').read_bytes()
        return path.with_suffix('.stdout').read_bytes(), cost

    def value(raw, wanted, baseline):
        result = json.loads(raw)
        assert result['checksum'] == wanted
        assert result['initialLiveBytes'] == result['finalLiveBytes'] == baseline
        return result

    # The measurement and audit run in the same checkout. Paths are explicit,
    # and compiler identities must match the actual images used by all commands.
    compilers = dict(candidate=ROOT / 'target/debug/fwp', reference=reference / 'fwp')
    assert {role: native_hash(path, machine) for role, path in compilers.items()} == identity['compilerHashes']
    summary, observations = {}, {}
    for case in cases():
        name = case['name']; path = directory / name
        assert json.loads((path / 'case.json').read_text()) == case
        assert (path / 'program.fwp').read_text() == program(case['kind'])
        wanted = checksum(case)
        if case['count'] <= 16 and case['sharing'] == 0:
            assert (path / 'raw.fwp').read_text() == raw_program(case)
            raw, _ = command(name + '/interpreter', [compilers['candidate'], 'run', '--interp', path / 'raw.fwp'])
            values = json.loads(raw)
            words = [struct.unpack('>Q', struct.pack('>d', item))[0] for item in values] if case['kind'] == 'sensor' else values
            assert words == expected(case['kind'], case['count'], case['updates'])
        hashes = {role: native_hash(path / role, machine) for role in MEASURE.COSTS.ROLES}
        baseline = None
        for role, compiler in compilers.items():
            prefix = name + '/' + role
            assert hashes[role] == hashes[role + '-copy']
            emitted = path / (role + '-generated.c')
            raw, _ = command(prefix + '-emit', [compiler, 'build', '--fn', 'measure', '--emit-c', '-O2',
                path / 'program.fwp', '-o', emitted])
            assert not raw
            generated = emitted.read_text()
            assert ('/* consumed-scalar-array-map :' in generated) == (role == 'candidate')
            assert (path / (role + '.c')).read_text() == driver(generated, case)
            raw, _ = command(prefix + '-build', ['gcc', *flags, path / (role + '.c'), '-o', path / role, '-lm', '-lpthread', '-ldl'])
            assert not raw
            raw, _ = command(prefix + '-check', [path / role])
            if baseline is None:
                baseline = json.loads(raw)['initialLiveBytes']
            value(raw, wanted, baseline)
        samples = [json.loads(line) for line in (path / 'samples.jsonl').read_text().splitlines()]
        assert [(row['round'], row['role']) for row in samples] == [
            (number, role) for number in range(-2, 24) for role in MEASURE.COSTS.order(number)]
        for row in samples:
            raw, cost = command(f"{name}/round-{row['round']}-{row['role']}", [path / row['role']])
            assert row == value(raw, wanted, baseline) | dict(round=row['round'], role=row['role'], processNs=cost['elapsedNs'])
        summary[name] = MEASURE.COSTS.summarize(samples) | dict(binaryHashes=hashes)
        if session == 1:
            reports = {}
            for role, compiler in compilers.items():
                prefix = name + '/' + role
                raw, rss = command(prefix + '-rss', [path / role], True)
                value(raw, wanted, baseline)
                emitted = path / (role + '-observed-generated.c')
                raw, emitter = command(prefix + '-compiler-cost', [compiler, 'build', '--fn', 'measure', '--emit-c', '-O2',
                    path / 'program.fwp', '-o', emitted], True)
                assert not raw and emitted.read_bytes() == (path / (role + '-generated.c')).read_bytes()
                raw, c_compiler = command(prefix + '-c-cost', ['gcc', *flags, path / (role + '.c'),
                    '-o', path / (role + '-rebuilt'), '-lm', '-lpthread', '-ldl'], True)
                assert not raw
                raw, _ = command(prefix + '-rebuilt-check', [path / (role + '-rebuilt')])
                value(raw, wanted, baseline)
                profile = path / (role + '-memory.c')
                assert profile.read_text() == MEASURE.OBS.memory_source((path / (role + '.c')).read_text())
                raw, _ = command(prefix + '-memory-build', ['gcc', *flags, profile,
                    '-o', path / (role + '-memory'), '-lm', '-lpthread', '-ldl'])
                assert not raw
                for suffix in ('-rebuilt', '-memory'):
                    native_hash(path / (role + suffix), machine)
                raw, _ = command(prefix + '-memory-run', [path / (role + '-memory')])
                timing, counts = raw.splitlines()
                value(timing, wanted, baseline)
                memory = json.loads(counts)
                assert memory['initialLiveBytes'] == memory['finalLiveBytes'] == baseline
                assert memory['peakLiveBytes'] >= baseline
                assert all(type(item) is int and item >= 0 for item in memory.values())
                reports[role] = dict(memory=memory, process=rss, compiler=emitter,
                    cCompiler=c_compiler, imageBytes=(path / role).stat().st_size)
            assert reports['candidate']['memory']['requests'] <= reports['reference']['memory']['requests']
            if case['sharing'] == 0:
                assert reports['candidate']['memory']['requests'] < reports['reference']['memory']['requests']
            assert reports['candidate']['memory']['peakLiveBytes'] <= reports['reference']['memory']['peakLiveBytes']
            observations[name] = reports
        assert list(path.glob('*.su')), 'missing C stack-usage output'
    assert summary == json.loads((directory / 'summary.json').read_text())
    if session == 1:
        assert observations == json.loads((directory / 'observations.json').read_text())
    assert consumed == set(commands), 'unexamined commands'
    return dict(source=source, machine=machine, session=session, cases=len(summary),
        commands=len(commands), timingQualification={name: row['computationQualified'] for name, row in summary.items()})


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--reference', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--machine', choices=('aarch64', 'x86_64'), required=True)
    parser.add_argument('--session', type=int, choices=(1, 2), required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    report = audit(args.directory.resolve(), args.reference.resolve(), args.source, args.machine, args.session)
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print('Verified all 48 captured-map cases and raw commands; timing qualification is separate.')


if __name__ == '__main__':
    main()
