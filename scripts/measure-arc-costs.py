#!/usr/bin/env python3
"""Measure remaining ARC operations using the current compiler, without timing."""

import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import subprocess


ROOT = Path(__file__).resolve().parent.parent


def module(name):
    spec = importlib.util.spec_from_file_location(name, ROOT / 'scripts' / (name + '.py'))
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


PROFILE = module('measure-iteration')
OWNERSHIP = module('ownership-profile')
WORDS = module('measure-wordfreq')
DESCENT = module('measure-descent-peers')

CONTROL = '''
    V observed = fwp_rc_fresh((V)(uintptr_t)fwp_alloc_leaf(24));
    for (int i=0; i<300; i++) fwp_rc_dup(observed);
    void (*retainer)(V) = fwp_rc_dup;
    retainer(observed);
    if (fwp_rc_unique(observed) || fwp_rc_unique_mut(observed) || fwp_rc_last(observed)) exit(91);
    for (int i=0; i<300; i++) fwp_rc_drop(observed);
    if (fwp_rc_release_last(observed)) exit(92);
    if (!fwp_rc_unique(observed) || !fwp_rc_unique_mut(observed) || !fwp_rc_last(observed)) exit(93);
    if (!fwp_rc_release_last(observed)) exit(94);
    fwp_rc_free_obj(observed);
    V array = fwp_rc_fresh((V)(uintptr_t)fwp_alloc_leaf(16));
    void (*free_array)(V) = fwp_rc_free_arr;
    free_array(array);
    fwp_rc_dup(0); fwp_rc_drop(0); fwp_rc_fresh(0);
    if (fwp_rc_release_last(0) || fwp_rc_unique(0) || fwp_rc_unique_mut(0) || fwp_rc_last(0)) exit(95);
'''


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def parse_profile(stderr, sites):
    rows, managed = {}, None
    for line in stderr.decode().splitlines():
        if line.startswith('ownership-site\t'):
            fields = line.split('\t')
            assert len(fields) == 5, line
            number, calls, effective, last = map(int, fields[1:])
            assert 0 <= number < len(sites) and number not in rows, line
            assert calls > 0 and 0 <= last <= effective <= calls, line
            assert last == 0 or sites[number]['operation'] == 'release_last', line
            rows[number] = dict(calls=calls, effective=effective, last=last)
        else:
            assert managed is None, line
            managed = json.loads(line)
    assert managed is not None
    assert set(managed) == {'requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'}
    assert all(type(value) is int and value >= 0 for value in managed.values()), managed
    assert managed['finalChargedBytes'] == 0, managed
    totals = {operation: dict(calls=0, effective=0, last=0) for operation in OWNERSHIP.OPERATIONS}
    for number, counts in rows.items():
        for field, count in counts.items():
            totals[sites[number]['operation']][field] += count
    assert totals['dup']['effective'] == managed['retains'], (totals, managed)
    decrements = (totals['drop']['effective'] + totals['release_last']['effective']
                  - totals['release_last']['last'])
    assert decrements == managed['retains'], (decrements, managed)
    return dict(managed=managed, operations=totals,
                sites=[dict(site=number, **counts) for number, counts in sorted(rows.items())])


def cases():
    yield 'observer-control', 'main = ()\n', None, [('', b'')]
    for name in ('text', 'function', 'shared_text', 'shared_function', 'closed'):
        source = (ROOT / f'tests/fixtures/channel_transfer_{name}.fwp').read_text()
        yield 'channel-' + name, source, 'work', [(str(n), b'') for n in (0, 16, 1024)]
    yield 'cached-map', (ROOT / 'bench/map/main.fwp').read_text(), None, [('', b'')]
    yield 'wordfreq', (ROOT / 'examples/wordfreq.fwp').read_text(), None, [
        (f'{tokens}-{vocabulary}', WORDS.make_input(tokens, vocabulary))
        for tokens, vocabulary in ((4096, 256), (65536, 4096))]
    for points, updates in ((3, 7), (129, 199)):
        yield f'packed-descent-{points}-{updates}', DESCENT.packed_program(points, updates), None, [('', b'')]
    source = (ROOT / 'tests/fixtures/unique_buffer_costs.fwp').read_text()
    for entry in ('unique', 'shared', 'callback'):
        yield 'buffer-' + entry, source, entry, [(str(n), b'') for n in (0, 16, 4096)]


def comparison_failures(report, baseline):
    """Check the declared no-capture callback saving without hiding other costs."""
    old = baseline['hosts'][report['machine']]['cases']
    assert set(report['cases']) == set(old)
    failures = []
    for name, case in report['cases'].items():
        previous = old[name]
        if case['sourceSha256'] != previous['sourceSha256']:
            failures.append(f'{name}: program differs from the measured baseline')
        assert set(case['inputs']) == set(previous['inputs'])
        for label, samples in case['inputs'].items():
            actual, expected = samples[0], previous['inputs'][label]
            if actual['managed'] != expected['managed']:
                failures.append(f'{name}/{label}: allocation/retain/live-byte totals changed')
            for operation, counts in expected['operations'].items():
                target = dict(counts)
                if name.startswith('buffer-') and operation in ('dup', 'release_last'):
                    target['calls'] -= int(label)
                if actual['operations'][operation] != target:
                    failures.append(f'{name}/{label}/{operation}: '
                                    f'{actual["operations"][operation]} != {target}')
    return failures


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', required=True, type=Path)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--objdump', required=True)
    parser.add_argument('--nm', required=True)
    parser.add_argument('--samples', required=True, type=int)
    parser.add_argument('--timeout', required=True, type=int)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--comparison', required=True, choices=('record', 'compare'))
    parser.add_argument('--baseline', type=Path)
    args = parser.parse_args()
    if (args.comparison == 'compare') != (args.baseline is not None):
        parser.error('compare requires --baseline; record does not accept one')
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full measurements run on GitHub'
    assert platform.system() == 'Linux' and args.samples >= 2 and args.timeout > 0
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    compiler = args.compiler.resolve()
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0')
    commands = []

    def run(command, data, raw):
        command = list(map(str, command))
        commands.append(command)
        env = dict(environment, FWP_NO_OPT='1') if raw else environment
        actual = subprocess.run(command, input=data, capture_output=True, env=env,
                                cwd=ROOT, timeout=args.timeout)
        if actual.returncode:
            raise RuntimeError(f'{command}: {actual.returncode}\n{actual.stderr.decode(errors="replace")}')
        return actual

    report = dict(source=run(['git', 'rev-parse', 'HEAD'], b'', False).stdout.decode().strip(),
                  machine=platform.machine(), platform=platform.platform(),
                  cpu=run(['lscpu'], b'', False).stdout.decode(),
                  cc=run([args.cc, '--version'], b'', False).stdout.decode(),
                  compilerSha256=digest(compiler), commands=commands, cases={},
                  scope='Current-compiler operation counts, not timing or a C/Rust comparison. '
                        'Measurement begins after constant initialization and ends after entry and '
                        'cached-value cleanup, before runtime shutdown. Managed charge excludes '
                        'allocator metadata, raw buffers and stacks. Each site refers to profile-base.c. '
                        'Calls include no-ops; effective events satisfy the runtime ownership condition. '
                        'Last-owner releases and physical free calls are separate events, not additional '
                        'decrements. Ordinary binary size and static frame estimates exclude instrumentation.')
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fno-lto', '-fstack-usage', '-w']
    for name, program, entry, inputs in cases():
        directory = output / name
        directory.mkdir()
        source = directory / 'program.fwp'
        source.write_text(program)
        cfile = directory / 'ordinary.c'
        selection = ['--fn', entry] if entry else []
        run([compiler, 'build', '--emit-c', '-O2', *selection, source, '-o', cfile], b'', False)
        base = PROFILE.instrument(cfile.read_text())
        if name == 'observer-control':
            marker = 'iteration_start_charge=iteration_charge();iteration_active=1;'
            assert base.count(marker) == 1
            base = base.replace(marker, marker + CONTROL)
        (directory / 'profile-base.c').write_text(base)
        measured, sites = OWNERSHIP.instrument(base)
        (directory / 'profile-sites.c').write_text(measured)
        (directory / 'sites.json').write_text(json.dumps(sites, indent=2) + '\n')
        binaries = {}
        for label in ('ordinary', 'profile-base', 'profile-sites'):
            binary = directory / (label + '.exe')
            run([args.cc, *flags, directory / (label + '.c'), '-o', binary, '-lm', '-lpthread', '-ldl'], b'', False)
            binaries[label] = binary
        ordinary = binaries['ordinary']
        header = ordinary.read_bytes()[:20]
        assert header[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(header[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[platform.machine()]
        symbols = run([args.nm, ordinary], b'', False).stdout
        assert not any(symbol in symbols for symbol in (b'fwp_heap_scan', b'fwp_heap_sweep', b'fwp_heap_mark_all'))
        (directory / 'ordinary.symbols').write_bytes(symbols)
        (directory / 'ordinary.asm').write_bytes(run([args.objdump, '-d', ordinary], b'', False).stdout)
        (directory / 'ordinary.sections').write_bytes(run([args.objdump, '-h', ordinary], b'', False).stdout)
        result = dict(sourceSha256=digest(source), binarySha256=digest(ordinary),
                      binaryBytes=ordinary.stat().st_size, inputs={})
        report['cases'][name] = result
        for label, data in inputs:
            arguments = [label] if entry else []
            reference_command = [compiler, 'exec', '--interp', source, entry, label] if entry else [compiler, 'run', '--interp', source]
            reference = run(reference_command, data, True)
            assert not reference.stderr, reference.stderr
            if name == 'wordfreq':
                assert reference.stdout == WORDS.oracle(data)
            ordinary_result = run([ordinary, *arguments], data, False)
            assert ordinary_result.stdout == reference.stdout and not ordinary_result.stderr
            baseline = run([binaries['profile-base'], *arguments], data, False)
            assert baseline.stdout == reference.stdout
            base_counts = json.loads(baseline.stderr)
            previous = None
            profiles = []
            for sample in range(args.samples):
                measured_result = run([binaries['profile-sites'], *arguments], data, False)
                assert measured_result.stdout == reference.stdout
                parsed = parse_profile(measured_result.stderr, sites)
                assert parsed['managed'] == base_counts, (name, label, parsed, base_counts)
                if name == 'observer-control':
                    expected = {'fresh': (3, 2, 0), 'dup': (302, 301, 0),
                                'drop': (301, 300, 0), 'release_last': (3, 2, 1),
                                'unique': (3, 1, 0), 'unique_mut': (3, 1, 0),
                                'last': (5, 3, 0), 'free_obj': (1, 1, 0),
                                'free_arr': (1, 1, 0)}
                    assert parsed['operations'] == {
                        operation: dict(zip(('calls', 'effective', 'last'), counts))
                        for operation, counts in expected.items()}, parsed
                    assert base_counts == dict(requests=2, requestedBytes=40, retains=301,
                                               peakChargedBytes=32, finalChargedBytes=0), base_counts
                if previous is not None:
                    assert parsed == previous, (name, label, 'unstable counts')
                previous = parsed
                profiles.append(parsed)
                (directory / f'{label or "main"}-{sample}.stderr').write_bytes(measured_result.stderr)
            (directory / f'{label or "main"}.stdin').write_bytes(data)
            (directory / f'{label or "main"}.stdout').write_bytes(reference.stdout)
            result['inputs'][label or 'main'] = profiles
        if name == 'observer-control':
            start = measured.index('static inline void fwp_rc_dup_profile(')
            opening = measured.index('{', start)
            end = OWNERSHIP.function_end(measured, opening)
            body = measured[start:end]
            marker = 'ownership_hit(profile_site, 1);'
            assert body.count(marker) == 1
            broken = measured[:start] + body.replace(marker, '', 1) + measured[end:]
            broken_source = directory / 'missing-retain-observation.c'
            broken_source.write_text(broken)
            broken_binary = directory / 'missing-retain-observation.exe'
            run([args.cc, *flags, broken_source, '-o', broken_binary, '-lm', '-lpthread', '-ldl'], b'', False)
            broken_result = run([broken_binary], b'', False)
            assert broken_result.stdout == reference.stdout
            (directory / 'missing-retain-observation.stderr').write_bytes(broken_result.stderr)
            try:
                parse_profile(broken_result.stderr, sites)
            except AssertionError:
                result['missingRetainObservationRejected'] = True
            else:
                raise AssertionError('omitted retain observer was accepted')
        result['files'] = {path.name: digest(path) for path in sorted(directory.iterdir()) if path.is_file()}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        print(name + ': outputs, baseline counts, site totals and repetitions agree', flush=True)
    if args.comparison == 'compare':
        baseline = json.loads(args.baseline.read_text())
        failures = comparison_failures(report, baseline)
        report['comparison'] = dict(baselineSource=baseline['source'],
                                    baselineSha256=digest(args.baseline), failures=failures)
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        assert not failures, '\n'.join(failures)


if __name__ == '__main__':
    main()
