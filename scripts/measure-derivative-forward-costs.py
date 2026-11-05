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
CONSTRUCTOR = ARC.module('constructor-profile')
CASES = ((3, 0), (3, 1), (3, 199), (3, 1999), (33, 199), (129, 199))
CONTROL_OPERATIONS = dict(fresh=(3, 2, 0), dup=(302, 301, 0), drop=(301, 300, 0),
    release_last=(3, 2, 1), unique=(3, 1, 0), unique_mut=(3, 1, 0),
    last=(5, 3, 0), free_obj=(1, 1, 0), free_arr=(1, 1, 0))


def control_source(source, operations):
    chunks = []
    for phase in range(7):
        if phase:
            chunks.append(f'    descent_phase_step({phase - 1});\n')
        chunks.append(f'    for (int repeat=0; repeat<{phase + 1}; repeat++) {{\n'
                      + operations + '\n    }\n')
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
    assert policy in ('record-zip', 'record-fold', 'packed-records', 'field-owners', 'numeric-inputs', 'constructor-census', 'scalar-map-zip', 'range-zip', 'gradient-array', 'gradient-call')
    old = baseline['hosts'][report['machine']]['cases']
    assert set(report['cases']) == set(old)
    failures = []
    for name, observations in report['cases'].items():
        dimensions, updates = map(int, name.split('-')[:2])
        pairs = (dimensions - 1) * updates
        removed = 2 * pairs if policy == 'record-zip' else max(dimensions - 2, 0) * updates
        retains = 3 * pairs if policy == 'record-zip' else pairs
        bytes_removed = 24 * removed
        if policy == 'packed-records':
            removed = 2 * pairs - updates
            bytes_removed = 32 * pairs - 8 * updates
            retains = 0
        elif policy in ('field-owners', 'numeric-inputs'):
            removed = bytes_removed = 0
            retains = pairs * (2 if policy == 'numeric-inputs' else 1)
        elif policy in ('scalar-map-zip', 'range-zip'):
            removed = (dimensions + 1) * updates
            bytes_removed = (32 * dimensions + 8) * updates
            retains = 0
        elif policy == 'gradient-array':
            removed = (dimensions - 1) * updates
            bytes_removed = (16 * dimensions - 8) * updates
            retains = 0
        elif policy == 'gradient-call':
            removed = 7 * updates + int(updates > 0)
            bytes_removed = (8 * dimensions + 128) * updates + 24 * int(updates > 0)
            retains = 2 * updates
        assert set(observations) == {'0', '1'}
        for mode, actual in observations.items():
            previous = old[name]['observations'][mode]
            if policy == 'constructor-census':
                for field in ('totals', 'phases', 'visits', 'raw'):
                    if actual[field] != previous[field]:
                        failures.append(f'{name}/workspace{mode}: {field} changed during census')
                continue
            current = actual['totals']['managed']
            before = previous['totals']['managed']
            label = name + '/workspace' + mode
            if not updates:
                if current != before or actual['phases'] != previous['phases']:
                    failures.append(label + ': zero-update counts changed')
            else:
                for field, saving in [('requests', removed), ('requestedBytes', bytes_removed),
                                      ('retains', retains)]:
                    if (current[field] != before[field] - saving if policy in ('scalar-map-zip', 'range-zip', 'gradient-call')
                            else current[field] > before[field] - saving):
                        requirement = 'exactly' if policy in ('scalar-map-zip', 'range-zip', 'gradient-call') else 'at least'
                        failures.append(f'{label}: {field} saving {before[field] - current[field]}, expected {requirement} {saving}')
                if current['peakChargedBytes'] > before['peakChargedBytes']:
                    failures.append(label + ': peak managed charge grew')
            if policy == 'gradient-call':
                # Scratch reserves N+1 words. The six forward objects total
                # 120 bytes; the separate cached seed contributes 24 once.
                # Keep phase attribution independent of the net byte saving.
                assert set(actual['phases']) == set(previous['phases']) == set(PROFILE.PHASES)
                for phase, row in actual['phases'].items():
                    prior = previous['phases'][phase]
                    expected = (0, 0, 0)
                    if phase == 'outside':
                        expected = (updates, (8 * dimensions + 8) * updates, updates)
                    elif phase == 'forwardWithRecording':
                        expected = (6 * updates + int(updates > 0),
                                    120 * updates + 24 * int(updates > 0), updates)
                    observed = (prior['requests'] - row['requests'],
                                prior['requestedBytes'] - row['requestedBytes'],
                                prior['operations']['dup']['effective'] - row['operations']['dup']['effective'])
                    if observed != expected:
                        failures.append(f'{label}/{phase}: saving {observed}, expected {expected}')
            if current['finalChargedBytes']:
                failures.append(label + ': managed storage remains live')
            if actual['visits'] != previous['visits']:
                failures.append(label + ': derivative work changed')
            if actual['raw'] != previous['raw']:
                failures.append(label + ': raw tape/workspace storage changed')
            if policy == 'gradient-array':
                def totals(rows):
                    groups = {}
                    for row in rows:
                        key = (row['phase'], row['tag'], row['fields'])
                        requests, size = groups.get(key, (0, 0))
                        groups[key] = (requests + row['requests'], size + row['requestedBytes'])
                    return groups
                expected = totals(old[name]['constructors']['counts'][mode])
                if updates:
                    key = ('outside', 1, 2)
                    requests, size = expected[key]
                    expected[key] = (requests - dimensions * updates,
                                     size - 24 * dimensions * updates)
                    assert min(expected[key]) >= 0
                    if expected[key] == (0, 0):
                        del expected[key]
                observed = totals(report['constructors']['cases'][name][mode])
                if observed != expected:
                    failures.append(label + ': constructor groups differ from exact gradient-list removal')
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
    parser.add_argument('--comparison', required=True, choices=('baseline', 'record-zip', 'record-fold', 'packed-records', 'field-owners', 'numeric-inputs', 'constructor-census', 'scalar-map-zip', 'range-zip', 'gradient-array', 'gradient-call'))
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
    census = args.comparison in ('constructor-census', 'scalar-map-zip', 'range-zip', 'gradient-array')
    if census:
        report['constructors'] = dict(controls={}, cases={})

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
            code, sites, bases = PROFILE.instrument(control_source(source, ARC.CONTROL))
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
            if census:
                directory = out / ('constructor-control-' + opt)
                directory.mkdir()
                (directory / 'ordinary.c').write_text(source)
                detailed, sites, bases = PROFILE.instrument(control_source(source, CONSTRUCTOR.CONTROL))
                save_sites(directory, sites, bases)
                (directory / 'detailed.c').write_text(detailed)
                instrumented, constructors = CONSTRUCTOR.instrument(detailed)
                (directory / 'constructor-sites.json').write_text(json.dumps(constructors, indent=2) + '\n')
                allocators = CONSTRUCTOR.data_allocator_sites(bases['allocation-base.c'], sites['allocations'])
                outcomes = report['constructors']['controls'][opt] = {}
                for label, text in CONSTRUCTOR.control_variants(instrumented, constructors).items():
                    binary = compile_c(directory, label, text, opt)
                    result = run([binary], directory, label, environment)
                    assert not result.stdout
                    if label in ('unknown-site', 'mixed-shape'):
                        assert result.returncode == 234, result.stderr
                        outcomes[label] = 'rejected invalid constructor attribution'
                        continue
                    assert result.returncode == 0, result.stderr
                    try:
                        actual, rows = CONSTRUCTOR.parse(result.stderr, constructors, allocators,
                                                        sites, 2, 1, False)
                        CONSTRUCTOR.check_control(actual, rows, constructors)
                    except AssertionError:
                        assert label != 'complete'
                        outcomes[label] = 'rejected inconsistent counts or cleanup'
                    else:
                        assert label == 'complete', ('broken constructor control passed', label)
                        outcomes[label] = dict(profile=actual, rows=rows)
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
                    if census:
                        instrumented, constructors = CONSTRUCTOR.instrument(detailed)
                        (directory / 'constructor-sites.json').write_text(json.dumps(constructors, indent=2) + '\n')
                        allocators = CONSTRUCTOR.data_allocator_sites(bases['allocation-base.c'], sites['allocations'])
                        binaries['constructors'] = compile_c(directory, 'constructors', instrumented, opt)
                        constructor_rows = report['constructors']['cases'][name] = {}
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
                        if census:
                            observed, rows = CONSTRUCTOR.parse(outputs['constructors'].stderr,
                                constructors, allocators, sites, dimensions, updates, bool(workspace))
                            assert observed == actual, 'constructor observer changed execution counts'
                            constructor_rows[str(workspace)] = rows
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
