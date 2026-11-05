#!/usr/bin/env python3
"""Check complete-program stack frames before timing private pair-buffer reuse."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import subprocess

from process_wait import run_capture

SPEC = importlib.util.spec_from_file_location('peers', Path(__file__).with_name('measure-descent-peers.py'))
PEERS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PEERS)
CASES = ((3, 0, 32768), (3, 1, 512), (3, 199, 32), (3, 1999, 4),
         (33, 199, 32), (129, 199, 8))


def audit(files, source, machine, compiler_hashes):
    """Recompute saved frame limits and verify every command without executing images."""
    report = json.loads(files['report.json'])
    assert report['source'] == source and report['machine'] == machine
    assert report['complete'] and report['failures'] == []
    assert report['compilerHashes'] == compiler_hashes
    assert report['environment'] == dict(FWP_LTO='0', FWP_AD_WORKSPACE='1', FWP_VRET='1',
                                       FWP_FRAME_FIELDS='1', FWP_PACKED_ARRAYS='1',
                                       FWP_STACK='1', FWP_ARRAY_FUSION='1')
    assert set(report['files']) == set(files) - {'report.json'}
    for name, checksum in report['files'].items():
        assert hashlib.sha256(files[name]).hexdigest() == checksum, name
    names = {f'{n}-{u}-{form}' for n, u, _ in CASES for form in ('current', 'history')}
    assert set(report['cases']) == names
    commands = {row['label']: row for row in report['commands']}
    labels = {name + '-' + kind + '-' + stage for name in names
              for kind in ('candidate', 'reference') for stage in ('emit', 'compile', 'run')}
    assert len(commands) == len(report['commands']) == 72 and set(commands) == labels
    flags = ['-O2', '-std=gnu11', '-fno-fast-math', '-ffp-contract=off',
             '-UFWP_NO_REUSE', '-fstack-usage',
             '-march=' + {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[machine]]
    elf = {'aarch64': 183, 'x86_64': 62}[machine]
    summaries = {}
    for n, u, solves in CASES:
        for form in ('current', 'history'):
            name = f'{n}-{u}-{form}'
            assert files[name + '.fwp'].decode() == PEERS.BASELINE.repeat_source(
                PEERS.AD.program(n, u + 1, form == 'history'), 'fwp', solves)
            maxima = {}
            dynamic = {}
            for kind in ('candidate', 'reference'):
                label = name + '-' + kind
                emit = commands[label + '-emit']['command']
                root = Path(emit[-1]).parent
                code, binary = str(root / (label + '.c')), str(root / label)
                assert Path(emit[0]).name == 'fwp'
                assert emit[1:] == ['build', '--memory', 'dynamic', '--emit-c', '-O2',
                                    str(root / (name + '.fwp')), '-o', code]
                assert commands[label + '-compile']['command'] == [
                    'gcc', *flags, '-w', code, '-o', binary, '-lm', '-lpthread', '-ldl']
                assert commands[label + '-run']['command'] == [binary]
                for stage in ('emit', 'compile', 'run'):
                    command = commands[label + '-' + stage]
                    assert set(command) == {'command', 'label', 'status'} and command['status'] == 0
                    assert not files[label + '-' + stage + '.stderr']
                    if stage != 'run':
                        assert not files[label + '-' + stage + '.stdout']
                assert files[label + '.c']
                image = files[label]
                assert image[:6] == b'\x7fELF\x02\x01' and int.from_bytes(image[18:20], 'little') == elf
                PEERS.verify(files[label + '-run.stdout'], PEERS.AD.analytic(n, u + 1), solves)
                entries = []
                for line in files[label + '.su'].decode().splitlines():
                    location, size, qualifier = line.split('\t')
                    assert int(size) >= 0 and qualifier in ('static', 'dynamic,bounded', 'dynamic'), line
                    entries.append(dict(location=location, bytes=int(size), qualifier=qualifier))
                assert entries
                maximum = max(row['bytes'] for row in entries)
                assert report['cases'][name][kind] == dict(maximumBytes=maximum, entries=entries)
                maxima[kind] = maximum
                dynamic[kind] = [row for row in entries if row['qualifier'] == 'dynamic']
            assert files[name + '-candidate-run.stdout'] == files[name + '-reference-run.stdout']
            assert maxima['candidate'] <= maxima['reference'] + 128, (name, maxima)
            # A plain "dynamic" row reports only its known portion. Preserve
            # these rows separately; this comparison is not a total stack bound.
            summaries[name] = dict(reportedFrameBytes=maxima, dynamicEntries=dynamic)
    return summaries


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--reference', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--machine', choices=('aarch64', 'x86_64'), required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--timeout', type=int, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.machine
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == args.source
    assert args.timeout > 0
    root = args.output.resolve()
    root.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_AD_WORKSPACE='1', FWP_VRET='1',
                       FWP_FRAME_FIELDS='1', FWP_PACKED_ARRAYS='1', FWP_STACK='1', FWP_ARRAY_FUSION='1')
    architecture = {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.machine]
    flags = ['-O2', '-std=gnu11', '-fno-fast-math', '-ffp-contract=off',
             '-UFWP_NO_REUSE', '-fstack-usage', '-march=' + architecture]
    report = dict(source=args.source, machine=args.machine, complete=False,
                  compilerHashes={kind: hashlib.sha256(path.read_bytes()).hexdigest()
                                  for kind, path in [('candidate', args.compiler), ('reference', args.reference)]},
                  environment={key: value for key, value in environment.items() if key.startswith('FWP_')},
                  commands=[], cases={}, failures=[])

    def save():
        (root / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def run(command, label):
        try:
            result = run_capture(list(map(str, command)), cwd=PEERS.ROOT,
                                 env=environment, timeout=args.timeout, input_data=None,
                                 input_stream=subprocess.DEVNULL, text=False, encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            (root / (label + '.stdout')).write_bytes(error.output or b'')
            (root / (label + '.stderr')).write_bytes(error.stderr or b'')
            report['commands'].append(dict(command=list(map(str, command)), label=label,
                                           timeoutSeconds=args.timeout))
            save()
            raise
        (root / (label + '.stdout')).write_bytes(result.stdout)
        (root / (label + '.stderr')).write_bytes(result.stderr)
        report['commands'].append(dict(command=list(map(str, command)), label=label,
                                       status=result.returncode))
        save()
        assert result.returncode == 0 and not result.stderr, (label, result.returncode, result.stderr)
        return result.stdout

    for points, updates, solves in CASES:
        for history in (False, True):
            name = f'{points}-{updates}-' + ('history' if history else 'current')
            source = PEERS.BASELINE.repeat_source(PEERS.AD.program(points, updates + 1, history), 'fwp', solves)
            program = root / (name + '.fwp')
            program.write_text(source)
            frames = {}
            outputs = {}
            for kind, compiler in [('candidate', args.compiler), ('reference', args.reference)]:
                label = name + '-' + kind
                code = root / (label + '.c')
                binary = root / label
                run([compiler.resolve(), 'build', '--memory', 'dynamic', '--emit-c', '-O2', program, '-o', code], label + '-emit')
                run([args.cc, *flags, '-w', code, '-o', binary, '-lm', '-lpthread', '-ldl'], label + '-compile')
                outputs[kind] = run([binary], label + '-run')
                PEERS.verify(outputs[kind], PEERS.AD.analytic(points, updates + 1), solves)
                entries = []
                for line in (root / (label + '.su')).read_text().splitlines():
                    location, size, qualifier = line.split('\t')
                    entries.append(dict(location=location, bytes=int(size), qualifier=qualifier))
                assert entries
                frames[kind] = dict(maximumBytes=max(row['bytes'] for row in entries), entries=entries)
            assert outputs['candidate'] == outputs['reference'], name
            limit = frames['reference']['maximumBytes'] + 128
            report['cases'][name] = frames
            if frames['candidate']['maximumBytes'] > limit:
                report['failures'].append(dict(case=name, actual=frames['candidate']['maximumBytes'], limit=limit))
            print(name, 'candidate', frames['candidate']['maximumBytes'],
                  'reference', frames['reference']['maximumBytes'], 'limit', limit, flush=True)
            save()
    report['complete'] = True
    report['files'] = {path.name: hashlib.sha256(path.read_bytes()).hexdigest()
                       for path in sorted(root.iterdir()) if path.name != 'report.json'}
    save()
    assert not report['failures'], report['failures']


if __name__ == '__main__':
    main()
