#!/usr/bin/env python3
"""Recompute a complete session, including rejected timing decisions, from raw evidence."""
import argparse
import base64
import importlib.util
import json
from pathlib import Path, PurePosixPath
import re
import struct

ROOT = Path(__file__).resolve().parent.parent
BASE_SPEC = importlib.util.spec_from_file_location('wordfreq_audit', ROOT / 'scripts/check-current-wordfreq.py')
BASE = importlib.util.module_from_spec(BASE_SPEC)
BASE_SPEC.loader.exec_module(BASE)
CHECK_SPEC = importlib.util.spec_from_file_location('direct_strings', ROOT / 'scripts/direct-string-evidence.py')
CHECK = importlib.util.module_from_spec(CHECK_SPEC)
CHECK_SPEC.loader.exec_module(CHECK)
PROFILE_SPEC = importlib.util.spec_from_file_location('iteration_profile', ROOT / 'scripts/measure-iteration.py')
PROFILE = importlib.util.module_from_spec(PROFILE_SPEC)
PROFILE_SPEC.loader.exec_module(PROFILE)
LABELS = ['c', 'rust', 'candidate', 'candidate-copy', 'reference', 'reference-copy']


def audit(files, source, machine, session):
    report = json.loads(files['comparison.json'])
    assert set(files) == set(report['files']) | {'comparison.json'}
    for name, identity in report['files'].items():
        assert identity == dict(bytes=len(files[name]), sha256=BASE.sha(files[name])), name
    config = json.loads(files['configuration.json'])
    assert config == report['configuration'] and config['source'] == source
    assert config['reference'] == CHECK.REFERENCE
    qualification = config['qualification']
    assert qualification['source'] == source and qualification['qualified'] is True
    assert qualification['failures'] == [] and qualification['actual'] == qualification['expected']
    assert qualification['actual'] == dict(system='Linux', machine=machine, processors=4,
        cpu={'aarch64': 'Neoverse-N2', 'x86_64': 'AMD EPYC 7763 64-Core Processor'}[machine],
        cVersion={'aarch64': 'gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0',
                  'x86_64': 'gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0'}[machine],
        rustVersion='rustc 1.99.1 (58cf8f9c3 2026-10-13)')
    assert len(set(config['allowedCpus'])) == 4
    assert re.fullmatch('[0-9a-f]{64}', config['compilerSha256'])
    c_arch = {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[machine]
    rust_cpu = {'aarch64': 'generic', 'x86_64': 'x86-64'}[machine]
    assert config['arguments'] == dict(compiler='target/release/fwp', qualification='direct-strings-host.json',
        output='direct-strings', cc='gcc', rustc='rustc', c_arch=c_arch, rust_cpu=rust_cpu,
        size='size', time='/usr/bin/time', rounds=16, warmups=2, processes=64, seed=20261030,
        timeout=180, session=session, case=BASE.CASES)
    assert config['environment'] == dict(CC='gcc', LC_ALL='C', FWP_LTO='0', FWP_STACK='1',
                                       FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1')
    frozen = json.loads((ROOT / 'tests/fixtures/direct-string-reference.json').read_text())
    assert json.loads(files['reference-functions.json']) == frozen
    reference, patch = CHECK.reference_source(files['candidate.c'].decode(), files['runtime-primitives.c'].decode(), frozen)
    assert reference.encode() == files['reference.c'] and patch == json.loads(files['reference-patch.json'])
    for label in ['candidate', 'reference']:
        assert files[label + '-profile.c'].decode() == CHECK.instrument_raw(PROFILE.instrument(files[label + '.c'].decode()))
    for saved, current in [('wordfreq.fwp', 'examples/wordfreq.fwp'), ('c.c', 'tests/fixtures/wordfreq_bench.c'),
                           ('rust.rs', 'tests/fixtures/wordfreq_bench.rs')]:
        assert files[saved] == (ROOT / current).read_bytes(), saved
    binaries = json.loads(files['binaries.json'])
    assert binaries == report['binaries'] and set(binaries) == set(LABELS)
    for label, binary in binaries.items():
        data = files[binary['path']]
        assert binary['sha256'] == BASE.sha(data) and binary['bytes'] == len(data)
        assert data[:6] == b'\x7fELF\x02\x01'
        assert struct.unpack_from('<H', data, 18)[0] == {'aarch64': 183, 'x86_64': 62}[machine]
        assert binary['sections'].encode() == files[label + '-sections.txt']
    assert files['program-f'] == files['program-i'] and files['program-a'] == files['program-b']
    for label in ['candidate', 'reference']:
        data = files[label + '-profile']
        assert data[:6] == b'\x7fELF\x02\x01'
        assert struct.unpack_from('<H', data, 18)[0] == {'aarch64': 183, 'x86_64': 62}[machine]
    stack = {name: files[name].decode() for name in files if name.endswith('.su')}
    assert set(stack) == {'candidate-profile.su', 'reference-profile.su', 'program-c-c.su',
                          'program-f-candidate.su', 'program-a-reference.su'}
    for text in stack.values():
        CHECK.stack_frames(text)
    representation = CHECK.representation_decision(binaries['reference']['sections'], binaries['candidate']['sections'],
        stack['program-a-reference.su'], stack['program-f-candidate.su'])
    assert representation == report['representation'] == json.loads(files['representation.json'])
    failures = list(representation['failures'])
    rows = [json.loads(line) for line in files['commands.jsonl'].splitlines()]
    assert len(rows) == report['commands'] == 18510
    root = PurePosixPath(rows[0]['input']).parent
    assert root.name == 'direct-strings'
    compiler = str(root.parent / 'target/release/fwp')
    paths = {label: str(root / binary['path']) for label, binary in binaries.items()}
    assert {label: PurePosixPath(path).name for label, path in paths.items()} == dict(zip(LABELS,
        ['program-c', 'program-r', 'program-f', 'program-i', 'program-a', 'program-b']))
    cursor = 0

    def take(metadata, command, input_name, stdout, stderr):
        nonlocal cursor
        row = rows[cursor]
        extra = {'command', 'input', 'status', 'timedOut', 'spawnError', 'elapsedNs',
                 'stdoutBase64', 'stderrBase64', 'stdoutSha256', 'stderrSha256'}
        assert {k: v for k, v in row.items() if k not in extra} == dict(metadata, sequence=cursor)
        cursor += 1
        assert row['command'] == list(map(str, command)) and row['input'] == str(root / input_name)
        assert type(row['status']) is int and row['status'] == 0 and row['timedOut'] is False and row['spawnError'] is None
        assert type(row['elapsedNs']) is int and row['elapsedNs'] > 0
        streams = []
        for key, expected in [('stdout', stdout), ('stderr', stderr)]:
            data = base64.b64decode(row[key + 'Base64'], validate=True)
            assert BASE.sha(data) == row[key + 'Sha256']
            if expected is not None:
                assert data == expected, (cursor - 1, key)
            streams.append(data)
        return row, streams

    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + c_arch, '-fstack-usage', '-UFWP_NO_REUSE']
    builds = [
        ('c', ['gcc', *flags, '-Wall', '-Wextra', '-Werror', root / 'c.c', '-o', paths['c']]),
        ('rust', ['rustc', '--edition=2021', '-C', 'opt-level=2', '-C', 'overflow-checks=yes',
                  '-C', 'target-cpu=' + rust_cpu, root / 'rust.rs', '-o', paths['rust']]),
        ('frontend', [compiler, 'build', '-O2', '--emit-c', root / 'wordfreq.fwp', '-o', root / 'candidate.c'])]
    for label in ['candidate', 'reference']:
        builds.append((label, ['gcc', *flags, '-w', root / (label + '.c'), '-o', paths[label], '-lm', '-lpthread', '-ldl']))
        builds.append((label + '-profile', ['gcc', *flags, '-w', root / (label + '-profile.c'), '-o', root / (label + '-profile'), '-lm', '-lpthread', '-ldl']))
    assert files['empty.stdin'] == b''
    for label, command in builds:
        take(dict(phase='build', label=label), command, 'empty.stdin', b'', b'')
    for label in LABELS:
        take(dict(phase='sections', label=label), ['size', '-A', paths[label]], 'empty.stdin', files[label + '-sections.txt'], b'')
    controls = [b'', b' \t\r\n\v\f', b'a A a, b. B', b'z y x w v u', b'... , . A',
                b'one\vtwo\fone\rTWO\tthree', b'Keep-hyphens keep-hyphens!']
    for number, data in enumerate(controls):
        name = f'control-{number}.stdin'
        assert files[name] == data
        expected = BASE.expected_output(data)
        take(dict(phase='control', case=number, label='raw-interpreter'),
             [compiler, 'run', '--interp', root / 'wordfreq.fwp'], name, expected, b'')
        for label in LABELS:
            take(dict(phase='control', case=number, label=label), [paths[label]], name, expected, b'')
    results = json.loads(files['results.json'])
    assert results == report['results'] and set(results) == set(BASE.CASES)
    for case in BASE.CASES:
        result = results[case]
        tokens, vocabulary = map(int, case.split(':'))
        name = case.replace(':', '-')
        data = files[name + '.stdin']
        words = []
        for i in range(tokens):
            word = f'word{(i * 7919) % vocabulary:06d}'
            word = word.upper() if i % 3 == 0 else word
            words.append(',' + word + '.' if i % 5 == 0 else word)
        assert data == ('\n'.join(' '.join(words[i:i+16]) for i in range(0, tokens, 16)) + '\n').encode()
        expected = BASE.expected_output(data)
        assert files[name + '-expected.stdout'] == expected
        assert (result['tokens'], result['vocabulary'], result['inputBytes']) == (tokens, vocabulary, len(data))
        assert result['inputSha256'] == BASE.sha(data) and result['expectedSha256'] == BASE.sha(expected)
        totals = {}
        for comparison, roles in [('paired', ['reference', 'reference-copy', 'candidate', 'candidate-copy']),
                                  ('context', ['c', 'rust', 'candidate', 'candidate-copy'])]:
            cycle = [dict(zip(BASE.LABELS, roles))[slot] for slot in BASE.CYCLE]
            totals[comparison] = {label: [] for label in roles}
            for round_index in range(-2, 16):
                sums = dict.fromkeys(roles, 0)
                offset = round_index % 16
                for position, label in enumerate((cycle[offset:] + cycle[:offset]) * 16):
                    row, _ = take(dict(phase='warmup' if round_index < 0 else 'timing', comparison=comparison,
                        case=case, round=round_index, position=position, label=label),
                        [paths[label]], name + '.stdin', expected, b'')
                    sums[label] += row['elapsedNs']
                if round_index >= 0:
                    for label in roles:
                        totals[comparison][label].append(sums[label])
        assert totals == result['roundTotalsNs']
        decision = CHECK.timing_decision(case, totals['paired'], totals['context'])
        assert decision == result['decision']
        for label in ['candidate', 'reference']:
            _, streams = take(dict(phase='profile', case=case, label=label), [root / (label + '-profile')], name + '.stdin', expected, None)
            raw, managed = map(json.loads, streams[1].splitlines())
            assert result['profiles'][label] == dict(raw=raw, managed=managed)
            failures.extend(CHECK.profile_failures(case, label, managed, raw))
        for label in LABELS:
            _, streams = take(dict(phase='rss', case=case, label=label), ['/usr/bin/time', '-v', paths[label]], name + '.stdin', expected, None)
            rss = re.findall(rb'Maximum resident set size \(kbytes\):\s*(\d+)', streams[1])
            assert len(rss) == 1 and int(rss[0]) * 1024 == result['peakProcessRssBytes'][label]
            assert b'Exit status: 0' in streams[1] and b'Command terminated' not in streams[1]
        failures.extend(decision['failures'])
    assert cursor == len(rows) and failures == report['failures']
    assert report['decision'] == ('session-rejected' if failures else 'session-passes; all four sessions still required')
    return dict(source=source, machine=machine, session=session, commands=cursor,
                failures=failures, decision=report['decision'], results=results)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--directory', type=Path)
    group.add_argument('--archive', type=Path)
    parser.add_argument('--source', required=True)
    parser.add_argument('--machine', choices=['aarch64', 'x86_64'], required=True)
    parser.add_argument('--session', type=int, choices=[1, 2], required=True)
    args = parser.parse_args()
    result = audit(BASE.read_files(args.archive, args.directory), args.source, args.machine, args.session)
    print(json.dumps(result, indent=2))
