#!/usr/bin/env python3
"""Audit retained word-frequency observations without executing benchmark programs."""
import argparse
import base64
from collections import Counter
import gzip
import hashlib
import json
from pathlib import Path, PurePosixPath
import re
import statistics
import struct
import zipfile

LABELS = ['c', 'rust', 'fwp', 'fwp-identical']
CASES = ['4096:64', '65536:1024']
# The published seed 20261030 produces this cycle; do not reuse the runner's generator.
CYCLE = ['c', 'c', 'fwp-identical', 'fwp-identical', 'c', 'fwp', 'fwp-identical',
         'fwp', 'fwp', 'rust', 'fwp-identical', 'rust', 'rust', 'fwp', 'c', 'rust']


def sha(data):
    return hashlib.sha256(data).hexdigest()


def expected_output(data):
    counts = Counter()
    for word in re.split(rb'[ \t\r\n]+', data):
        if word:
            counts[word.lower().translate(None, b',.')] += 1
    return b''.join(word + b': ' + str(count).encode() + b'\n'
                    for word, count in sorted(counts.items(), key=lambda p: (-p[1], p[0]))[:5])


def audit(files, source, machine, session):
    report = json.loads(files['comparison.json'])
    assert report['decision'] == 'baseline-only; budgets must be published before a candidate'
    assert set(files) == set(report['files']) | {'comparison.json'}
    for name, identity in report['files'].items():
        assert identity == dict(bytes=len(files[name]), sha256=sha(files[name])), name
    config = json.loads(files['configuration.json'])
    assert config == report['configuration'] and config['source'] == source
    qualification = config['qualification']
    assert qualification['source'] == source and qualification['qualified'] is True
    assert qualification['failures'] == [] and qualification['actual'] == qualification['expected']
    host = qualification['actual']
    assert host == dict(system='Linux', machine=machine, processors=4,
        cpu={'aarch64': 'Neoverse-N2', 'x86_64': 'AMD EPYC 7763 64-Core Processor'}[machine],
        cVersion={'aarch64': 'gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0',
                  'x86_64': 'gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0'}[machine],
        rustVersion='rustc 1.99.1 (58cf8f9c3 2026-10-13)')
    assert len(set(config['allowedCpus'])) == 4
    assert re.fullmatch('[0-9a-f]{64}', config['compilerSha256'])
    c_arch = {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[machine]
    rust_cpu = {'aarch64': 'generic', 'x86_64': 'x86-64'}[machine]
    assert config['arguments'] == dict(compiler='target/release/fwp', qualification='wordfreq-current-host.json',
        output='wordfreq-current', cc='gcc', rustc='rustc', c_arch=c_arch, rust_cpu=rust_cpu,
        size='size', time='/usr/bin/time', rounds=16, warmups=2, processes=64, seed=20261030,
        timeout=180, session=session, case=CASES)
    assert config['environment'] == dict(CC='gcc', LC_ALL='C', FWP_LTO='0', FWP_STACK='1',
                                       FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1')
    binaries = json.loads(files['binaries.json'])
    assert binaries == report['binaries'] and set(binaries) == set(LABELS)
    for label, binary in binaries.items():
        data = files[binary['path']]
        assert binary['sha256'] == sha(data) and binary['bytes'] == len(data)
        assert data[:6] == b'\x7fELF\x02\x01'
        assert struct.unpack_from('<H', data, 18)[0] == {'aarch64': 183, 'x86_64': 62}[machine]
        assert binary['sections'].encode() == files[label+'-sections.txt']
    assert files['program-f'] == files['program-i']
    assert len({len(b['path']) for b in binaries.values()}) == 1
    profile_image = files['fwp-profile']
    assert profile_image[:6] == b'\x7fELF\x02\x01'
    assert struct.unpack_from('<H', profile_image, 18)[0] == {'aarch64': 183, 'x86_64': 62}[machine]
    stack = {name: files[name].decode().splitlines() for name in files if name.endswith('.su')}
    assert set(stack) == {'fwp-profile.su', 'program-c-c.su', 'program-f-fwp.su'}
    for name, lines in stack.items():
        assert lines and all(re.fullmatch(r'.+\t\d+\t(?:static|dynamic|dynamic,bounded)', line) for line in lines), name
    rows = [json.loads(line) for line in files['commands.jsonl'].splitlines()]
    assert len(rows) == report['commands'] == 9270
    root = PurePosixPath(rows[0]['input']).parent
    assert root.name == 'wordfreq-current'
    compiler = str(root.parent / 'target/release/fwp')
    paths = {label: str(root / b['path']) for label, b in binaries.items()}
    assert {label: PurePosixPath(path).name for label, path in paths.items()} == dict(
        c='program-c', rust='program-r', fwp='program-f', **{'fwp-identical': 'program-i'})
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
            data = base64.b64decode(row[key+'Base64'], validate=True)
            assert sha(data) == row[key+'Sha256']
            if expected is not None:
                assert data == expected, (cursor-1, key)
            streams.append(data)
        return row, streams

    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-march='+c_arch, '-fstack-usage', '-UFWP_NO_REUSE']
    builds = [
        ('c', ['gcc', *flags, '-Wall', '-Wextra', '-Werror', root/'c.c', '-o', paths['c']]),
        ('rust', ['rustc', '--edition=2021', '-C', 'opt-level=2', '-C', 'overflow-checks=yes',
                  '-C', 'target-cpu='+rust_cpu, root/'rust.rs', '-o', paths['rust']]),
        ('frontend', [compiler, 'build', '-O2', '--emit-c', root/'wordfreq.fwp', '-o', root/'fwp.c']),
        ('fwp', ['gcc', *flags, '-w', root/'fwp.c', '-o', paths['fwp'], '-lm', '-lpthread', '-ldl']),
        ('profile', ['gcc', *flags, '-w', root/'fwp-profile.c', '-o', root/'fwp-profile', '-lm', '-lpthread', '-ldl'])]
    assert files['empty.stdin'] == b''
    for label, command in builds:
        take(dict(phase='build', label=label), command, 'empty.stdin', b'', b'')
    for label in LABELS:
        take(dict(phase='sections', label=label), ['size', '-A', paths[label]],
             'empty.stdin', files[label+'-sections.txt'], b'')
    controls = [b'', b' \t\r\n\v\f', b'a A a, b. B', b'z y x w v u', b'... , . A',
                b'one\vtwo\fone\rTWO\tthree', b'Keep-hyphens keep-hyphens!']
    for number, data in enumerate(controls):
        name = f'control-{number}.stdin'
        assert files[name] == data
        output = expected_output(data)
        take(dict(phase='control', case=number, label='raw-interpreter'),
             [compiler, 'run', '--interp', root/'wordfreq.fwp'], name, output, b'')
        for label in LABELS:
            take(dict(phase='control', case=number, label=label), [paths[label]], name, output, b'')
    results = json.loads(files['results.json'])
    assert results == report['results'] and set(results) == set(CASES)
    for case in CASES:
        result = results[case]
        tokens, vocabulary = map(int, case.split(':'))
        name = case.replace(':', '-')
        data = files[name+'.stdin']
        words = []
        for i in range(tokens):
            word = f'word{(i*7919)%vocabulary:06d}'
            word = word.upper() if i%3 == 0 else word
            words.append(','+word+'.' if i%5 == 0 else word)
        assert data == ('\n'.join(' '.join(words[i:i+16]) for i in range(0, tokens, 16))+'\n').encode()
        output = expected_output(data)
        assert files[name+'-expected.stdout'] == output
        assert (result['tokens'], result['vocabulary'], result['inputBytes']) == (tokens, vocabulary, len(data))
        assert result['inputSha256'] == sha(data) and result['expectedSha256'] == sha(output)
        totals = {label: [] for label in LABELS}
        orders = []
        for round_index in range(-2, 16):
            sums = dict.fromkeys(LABELS, 0)
            order = []
            for position in range(256):
                label = rows[cursor]['label']
                assert label in LABELS
                row, _ = take(dict(phase='warmup' if round_index < 0 else 'timing',
                    case=case, round=round_index, position=position, label=label),
                    [paths[label]], name+'.stdin', output, b'')
                sums[label] += row['elapsedNs']
                order.append(label)
            offset = round_index % 16
            assert order == (CYCLE[offset:] + CYCLE[:offset])*16
            assert Counter(order) == {label: 64 for label in LABELS}
            if round_index >= 0:
                orders.append(order)
                for label in LABELS:
                    totals[label].append(sums[label])
        for position in range(256):
            assert Counter(order[position] for order in orders) == {label: 4 for label in LABELS}
        assert Counter(pair for order in orders for pair in zip(order, order[1:])) == {
            (a, b): 255 for a in LABELS for b in LABELS}
        medians = {label: statistics.median(values) for label, values in totals.items()}
        assert result['roundTotalsNs'] == totals and result['medianRoundTotalNs'] == medians
        assert result['perProcessEquivalentNs'] == {k: v/64 for k, v in medians.items()}
        for field, label in [('fwpOverC', 'c'), ('fwpOverRust', 'rust'), ('fwpOverIdentical', 'fwp-identical')]:
            assert result[field] == medians['fwp']/medians[label]
        _, streams = take(dict(phase='profile', case=case, label='fwp'),
            [root/'fwp-profile'], name+'.stdin', output, None)
        counts = json.loads(streams[1])
        assert counts == result['managedProfile']
        assert set(counts) == {'requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'}
        assert all(type(v) is int and v >= 0 for v in counts.values())
        assert counts['requests'] > 0 and counts['finalChargedBytes'] == 0
        for label in LABELS:
            _, streams = take(dict(phase='rss', case=case, label=label),
                ['/usr/bin/time', '-v', paths[label]], name+'.stdin', output, None)
            rss = re.findall(rb'Maximum resident set size \(kbytes\):\s*(\d+)', streams[1])
            assert len(rss) == 1 and int(rss[0])*1024 == result['peakProcessRssBytes'][label]
            assert b'Exit status: 0' in streams[1] and b'Command terminated' not in streams[1]
    assert cursor == len(rows)
    return dict(source=source, machine=machine, session=session, commands=cursor, files=report['files'],
                configuration=config, results=results, binaries=binaries,
                stackReports=stack, decision='audited baseline only; no speedup accepted')


def read_files(archive, directory):
    assert (archive is None) != (directory is None)
    if directory is not None:
        assert all(path.is_file() for path in directory.iterdir())
        return {path.name: path.read_bytes() for path in directory.iterdir()}
    with zipfile.ZipFile(archive) as stream:
        assert len(stream.namelist()) == len(set(stream.namelist()))
        return {name: stream.read(name) for name in stream.namelist()}


def read_retained(index_path, machine, session):
    index = json.loads(index_path.read_text())
    label = {'aarch64': 'arm', 'x86_64': 'amd'}[machine] + '-' + str(session)
    entry = index['sessions'][label]

    def unpack(identity):
        data = gzip.decompress(index_path.with_name(identity['file']).read_bytes())
        assert len(data) == identity['bytes'] and sha(data) == identity['sha256']
        return data

    report = json.loads(unpack(entry['report']))
    texts = json.loads(unpack(index['textContents']))
    images = json.loads(unpack(index['binaryContents']))
    log = re.sub(r'\x1b\[[0-?]*[ -/]*[@-~]', '', unpack(entry['log']).decode('utf-8-sig'))
    assert re.findall(r'Ran (\d+) tests in', log) == ['7', '3']
    assert len(re.findall(r'Z OK\s*$', log, re.M)) == 2
    assert 'Finished `release` profile [optimized]' in log
    assert 'Qualified native derivative host:' in log
    assert not re.search(r'(?:^|\s)(?:warning|error)(?:\[[^]]+\])?:|##\[(?:warning|error)\]', log, re.I)
    assert not re.search(r'\bFAILED\b', log)
    assert len(index['rejections']) == 3
    for rejection in index['rejections']:
        q = rejection['qualification']
        assert q['source'] == index['source'] and q['qualified'] is False
        assert len(q['failures']) == 1 and q['failures'][0].startswith('cpu:')
        assert q['actual']['cpu'] != q['expected']['cpu']
        assert {k: v for k, v in q['actual'].items() if k != 'cpu'} == {
            k: v for k, v in q['expected'].items() if k != 'cpu'}
        rejected = unpack(rejection['log']).decode('utf-8-sig')
        assert 'Host rejected before building/timing:' in rejected
        assert rejected.count('##[error]') == 1
        assert 'Run cargo build' not in rejected and 'Run python3 scripts/measure-current-wordfreq.py' not in rejected
    files = {name: texts[key].encode() for name, key in report['textFiles'].items()}
    for name, identity in report['binaryHeaders'].items():
        data = base64.b64decode(images[identity['sha256']], validate=True)
        assert len(data) == identity['bytes'] and sha(data) == identity['sha256']
        assert data[:64].hex() == identity['elfHeaderHex']
        assert name not in files
        files[name] = data
    assert index['source'] == report['audit']['source'] == json.loads(files['configuration.json'])['source']
    assert report['audit']['configuration'] == json.loads(files['configuration.json'])
    assert report['audit']['results'] == json.loads(files['results.json'])
    assert report['audit']['binaries'] == json.loads(files['binaries.json'])
    assert report['audit']['files'] == json.loads(files['comparison.json'])['files']
    assert (report['audit']['machine'], report['audit']['session']) == (machine, session)
    return files


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    inputs = parser.add_mutually_exclusive_group(required=True)
    inputs.add_argument('--archive', type=Path)
    inputs.add_argument('--directory', type=Path)
    inputs.add_argument('--retained-index', type=Path)
    parser.add_argument('--source', required=True)
    parser.add_argument('--machine', choices=['aarch64', 'x86_64'], required=True)
    parser.add_argument('--session', type=int, choices=[1, 2], required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    files = (read_retained(args.retained_index, args.machine, args.session) if args.retained_index
             else read_files(args.archive, args.directory))
    result = audit(files, args.source, args.machine, args.session)
    args.output.write_text(json.dumps(result, indent=2)+'\n')
    print(f'{args.machine} session {args.session}: all {result["commands"]} observations audited')


if __name__ == '__main__':
    main()
