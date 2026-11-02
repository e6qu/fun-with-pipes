#!/usr/bin/env python3
"""Runner-only phase/source counts for the six frozen scalar derivative cases."""
import argparse
import gzip
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import subprocess

from process_wait import run_capture

SPEC = importlib.util.spec_from_file_location('profile', Path(__file__).with_name('derivative-ownership-profile.py'))
PROFILE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILE)
ARC = PROFILE.ARC
AD = ARC.module('measure-ad-application')
CASES = ((3, 0), (3, 1), (3, 199), (3, 1999), (33, 199), (129, 199))
CONTROL_OPERATIONS = dict(fresh=(3, 2, 0), dup=(302, 301, 0), drop=(301, 300, 0),
    release_last=(3, 2, 1), unique=(3, 1, 0), unique_mut=(3, 1, 0),
    last=(5, 3, 0), free_obj=(1, 1, 0), free_arr=(1, 1, 0))


def control_source(source):
    chunks = []
    for phase in range(7):
        if phase:
            chunks.append(f'    descent_phase_step({phase - 1});\n')
        chunks.append(f'    for (int repeat=0; repeat<{phase + 1}; repeat++) {{\n'
                      + ARC.CONTROL + '\n    }\n')
    chunks.append('    descent_inputs=2; descent_nodes=8;\n'
                  '    descent_phase_step(DESCENT_PHASES);\n'
                  '    ad_raw_sample(0,0);\n')
    marker = '    /* Ownership observation point: before runtime teardown. */\n'
    return PROFILE.RAW.replace_once(source, marker, ''.join(chunks) + marker)


def check_control(profile):
    """The known workload differs in each phase, so relabelling cannot pass."""
    for phase, name in enumerate(PROFILE.PHASES):
        row = profile['phases'][name]
        repeat = phase + 1
        assert row['requests'] == 2 * repeat, (name, row)
        assert row['requestedBytes'] == 40 * repeat, (name, row)
        assert row['peakChargedBytes'] == 32, (name, row)
        for operation, counts in CONTROL_OPERATIONS.items():
            expected = dict(zip(('calls', 'effective', 'last'), (n * repeat for n in counts)))
            assert row['operations'][operation] == expected, (name, operation, row, expected)


def parse_totals(stderr):
    rows = [json.loads(line) for line in stderr.decode().splitlines()]
    assert len(rows) == 2
    managed = [row for row in rows if 'requests' in row]
    raw = [row['rawDerivativeStorage'] for row in rows if 'rawDerivativeStorage' in row]
    assert len(managed) == len(raw) == 1
    return managed[0], raw[0]


def comparison_failures(report, baseline, policy):
    """Apply the selected frozen count limits to every case and storage mode."""
    assert policy in ('record-zip', 'record-fold')
    old = baseline['hosts'][report['machine']]['cases']
    assert set(report['cases']) == set(old)
    failures = []
    for name, observations in report['cases'].items():
        dimensions, updates = map(int, name.split('-')[:2])
        pairs = (dimensions - 1) * updates
        removed = 2 * pairs if policy == 'record-zip' else max(dimensions - 2, 0) * updates
        retains = 3 * pairs if policy == 'record-zip' else pairs
        assert set(observations) == {'0', '1'}
        for mode, actual in observations.items():
            previous = old[name]['observations'][mode]
            current = actual['totals']['managed']
            before = previous['totals']['managed']
            label = name + '/workspace' + mode
            if not updates:
                if current != before or actual['phases'] != previous['phases']:
                    failures.append(label + ': zero-update counts changed')
            else:
                for field, saving in [('requests', removed), ('requestedBytes', 24 * removed),
                                      ('retains', retains)]:
                    if current[field] > before[field] - saving:
                        failures.append(f'{label}: {field} saving {before[field] - current[field]} < {saving}')
                if current['peakChargedBytes'] > before['peakChargedBytes']:
                    failures.append(label + ': peak managed charge grew')
            if current['finalChargedBytes']:
                failures.append(label + ': managed storage remains live')
            if actual['visits'] != previous['visits']:
                failures.append(label + ': derivative work changed')
            if actual['raw'] != previous['raw']:
                failures.append(label + ': raw tape/workspace storage changed')
    return failures


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', required=True, type=Path)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--machine', required=True, choices=('aarch64', 'x86_64'))
    parser.add_argument('--c-arch', required=True, choices=('armv8-a', 'x86-64'))
    parser.add_argument('--source', required=True)
    parser.add_argument('--timeout', required=True, type=int)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--comparison', required=True, choices=('baseline', 'record-zip', 'record-fold'))
    parser.add_argument('--baseline', type=Path)
    args = parser.parse_args()
    assert (args.comparison != 'baseline') == (args.baseline is not None)
    baseline = json.loads(gzip.decompress(args.baseline.read_bytes())) if args.baseline else None
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert platform.machine() == args.machine and args.timeout > 0
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.machine]
    assert re.fullmatch('[0-9a-f]{40}', args.source)
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    compiler = args.compiler.resolve()
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_AD_WORKSPACE='0')
    report = dict(source=args.source, machine=args.machine, platform=platform.platform(),
                  compilerSha256=ARC.digest(compiler), commands=[], controls={}, cases={},
                  scope='One complete solve, counts only; no elapsed-time claim. '
                  'Managed charge excludes allocator metadata, raw buffers and stacks. '
                  'Allocation sites name runtime allocator callers, not fwp call stacks. '
                  'Ownership sites name generated-C calls. Both retain their exact input C.')
    report['comparison'] = dict(policy=args.comparison,
                                baselineSource=baseline['source'] if baseline else None)

    def run(command, directory, label, env):
        command = list(map(str, command))
        row = dict(command=command, workspace=env['FWP_AD_WORKSPACE'],
                   raw=env.get('FWP_NO_OPT') == '1')
        report['commands'].append(row)
        try:
            result = run_capture(command, env=env, cwd=ARC.ROOT, input_data=None,
                                 input_stream=None, text=False, encoding='utf-8',
                                 timeout=args.timeout, check=False)
        except subprocess.TimeoutExpired as error:
            (directory / (label + '.stdout')).write_bytes(error.output or b'')
            (directory / (label + '.stderr')).write_bytes(error.stderr or b'')
            row['timeout'] = True
            raise
        (directory / (label + '.stdout')).write_bytes(result.stdout)
        (directory / (label + '.stderr')).write_bytes(result.stderr)
        row['returncode'] = result.returncode
        return result

    def success(command, directory, label, env):
        result = run(command, directory, label, env)
        assert result.returncode == 0, (command, result.stderr.decode(errors='replace'))
        return result

    def compile_c(directory, label, code, opt):
        path = directory / (label + '.c')
        path.write_text(code)
        binary = directory / (label + '.exe')
        command = [args.cc, '-' + opt, '-std=gnu11', '-ffp-contract=off', '-fno-fast-math',
                   '-fno-lto', '-march=' + args.c_arch, '-fstack-usage', '-Werror',
                   path, '-o', binary, '-lm', '-lpthread', '-ldl']
        success(command, directory, label + '-compile', environment)
        header = binary.read_bytes()[:20]
        assert header[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(header[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[args.machine]
        return binary

    def generated(directory, program, opt):
        source = directory / 'program.fwp'
        source.write_text(program)
        path = directory / 'ordinary.c'
        success([compiler, 'build', '--emit-c', '-' + opt, source, '-o', path],
                directory, 'emit', environment)
        return source, path.read_text()

    def save_sites(directory, sites, bases):
        (directory / 'sites.json').write_text(json.dumps(sites, indent=2) + '\n')
        for filename, text in bases.items():
            (directory / filename).write_text(text)

    try:
        actual = success(['git', 'rev-parse', 'HEAD'], out, 'source', environment).stdout.decode().strip()
        assert actual == args.source
        report['cpu'] = success(['lscpu'], out, 'cpu', environment).stdout.decode()
        report['cc'] = success([args.cc, '--version'], out, 'cc', environment).stdout.decode()
        for opt in ('O1', 'O2'):
            directory = out / ('control-' + opt)
            directory.mkdir()
            _, source = generated(directory, 'main = ()\n', opt)
            code, sites, bases = PROFILE.instrument(control_source(source))
            save_sites(directory, sites, bases)
            changes = {
                'complete': code,
                'missing-allocation': PROFILE.RAW.replace_once(code,
                    'derivative_allocations[derivative_phase][site][0]++;', ''),
                'missing-retain': PROFILE.RAW.replace_once(code,
                    'derivative_ownership[derivative_phase][site][field]++;',
                    'if(field!=1)derivative_ownership[derivative_phase][site][field]++;'),
                'wrong-phase': PROFILE.RAW.replace_once(code,
                    'derivative_phase = (size_t)next + 1;', 'derivative_phase = 0;'),
                'unfinished': PROFILE.RAW.replace_once(code,
                    '    descent_phase_step(DESCENT_PHASES);\n    ad_raw_sample(0,0);',
                    '    ad_raw_sample(0,0);'),
            }
            outcomes = report['controls'][opt] = {}
            for label, text in changes.items():
                binary = compile_c(directory, label, text, opt)
                result = run([binary], directory, label, environment)
                assert not result.stdout
                if label == 'unfinished':
                    assert result.returncode == 233, result.stderr
                    outcomes[label] = 'rejected incomplete sequence'
                    continue
                assert result.returncode == 0, result.stderr
                if label == 'complete':
                    actual = PROFILE.parse(result.stderr, sites, 2, 1, False)
                    check_control(actual)
                    outcomes[label] = actual
                else:
                    try:
                        check_control(PROFILE.parse(result.stderr, sites, 2, 1, False))
                    except AssertionError:
                        outcomes[label] = 'rejected inconsistent counts or phase attribution'
                    else:
                        raise AssertionError('broken observer passed: ' + label)
        for dimensions, updates in CASES:
            expected = AD.analytic(dimensions, updates + 1)
            for form in ('current', 'history'):
                for opt in ('O1', 'O2'):
                    name = f'{dimensions}-{updates}-{form}-{opt}'
                    directory = out / name
                    directory.mkdir()
                    source, code = generated(directory, AD.program(dimensions, updates + 1, form == 'history'), opt)
                    raw = success([compiler, 'run', '--interp', source], directory, 'raw',
                                  dict(environment, FWP_NO_OPT='1'))
                    assert not raw.stderr
                    ARC.DESCENT.verify(raw.stdout, expected, 1)
                    detailed, sites, bases = PROFILE.instrument(code)
                    save_sites(directory, sites, bases)
                    binaries = {label: compile_c(directory, label, text, opt) for label, text in (
                        ('ordinary', code), ('totals', PROFILE.RAW.instrument(ARC.PROFILE.instrument(code))),
                        ('detailed', detailed))}
                    observations = report['cases'][name] = {}
                    for workspace in (0, 1):
                        env = dict(environment, FWP_AD_WORKSPACE=str(workspace))
                        outputs = {label: success([binary], directory, f'{label}-workspace{workspace}', env)
                                   for label, binary in binaries.items()}
                        assert not outputs['ordinary'].stderr
                        for result in outputs.values():
                            assert result.stdout == outputs['ordinary'].stdout
                            ARC.DESCENT.verify(result.stdout, expected, 1)
                        actual = PROFILE.parse(outputs['detailed'].stderr, sites, dimensions, updates, bool(workspace))
                        totals, raw_totals = parse_totals(outputs['totals'].stderr)
                        assert totals == actual['totals']['managed'] and raw_totals == actual['raw']
                        observations[str(workspace)] = actual
                    print(name + ': ordinary, totals and phase/site observations agree', flush=True)
        report['complete'] = True
        if baseline is not None:
            report['comparisonFailures'] = comparison_failures(report, baseline, args.comparison)
            assert not report['comparisonFailures'], '\n'.join(report['comparisonFailures'])
    finally:
        report['files'] = {str(path.relative_to(out)): ARC.digest(path)
                           for path in sorted(out.rglob('*')) if path.is_file() and path.name != 'report.json'}
        (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
