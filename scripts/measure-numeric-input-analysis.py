#!/usr/bin/env python3
"""Measure an explicitly selected compiler pass on native Linux runners."""
import argparse
import hashlib
import importlib.util
import json
import math
import os
from pathlib import Path
import platform
import re
import shutil
import statistics
import subprocess
import time

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('costs', ROOT / 'scripts/measure-derivative-forward-costs.py')
COSTS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COSTS)
COPIES = ('candidate1', 'reference1', 'reference2', 'candidate2')
ORDERS = (COPIES, ('reference2', 'candidate2', 'candidate1', 'reference1'))


def summarize(rows):
    assert len(rows) == 48
    assert all(type(row['round']) is int and math.isfinite(row['seconds']) and row['seconds'] > 0
               and type(row['peakCommandKiB']) is int and row['peakCommandKiB'] > 0 for row in rows)
    for number in range(-2, 10):
        assert tuple(row['copy'] for row in rows if row['round'] == number) == ORDERS[number % 2]
    samples = {name: [row for row in rows if row['copy'] == name and row['round'] >= 0]
               for name in COPIES}
    assert all(len(values) == 10 and {row['round'] for row in values} == set(range(10))
               for values in samples.values())
    medians = {name: statistics.median(row['seconds'] for row in values)
               for name, values in samples.items()}
    assert all(value > 0 for value in medians.values())
    copy_ratios = {kind: max(medians[kind + '1'], medians[kind + '2']) /
                  min(medians[kind + '1'], medians[kind + '2']) for kind in ('candidate', 'reference')}
    seconds = {kind: statistics.median(row['seconds'] for row in rows
                                      if row['round'] >= 0 and row['copy'].startswith(kind))
               for kind in ('candidate', 'reference')}
    peaks = {kind: max(row['peakCommandKiB'] for row in rows
                      if row['copy'].startswith(kind))
             for kind in ('candidate', 'reference')}
    assert all(value > 0 for value in peaks.values())
    ratio = seconds['candidate'] / seconds['reference']
    memory_ratio = peaks['candidate'] / peaks['reference']
    failures = [kind + ': identical-copy median difference exceeds 2%'
                for kind, value in copy_ratios.items() if value > 1.02]
    if ratio > 1.05:
        failures.append('candidate/reference elapsed median exceeds 1.05')
    if memory_ratio > 1.05:
        failures.append('candidate/reference maximum peak RSS exceeds 1.05')
    return dict(copyMediansSeconds=medians, copyRatios=copy_ratios, medianSeconds=seconds,
                candidateReferenceSeconds=ratio, maxPeakCommandKiB=peaks,
                candidateReferencePeakRSS=memory_ratio, failures=failures)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def scoped_cost_inputs():
    """Share a known worker and retain a large dynamic callee without copying it."""
    repeated = 'next : I64 -> I64\nnext = add 1\nworker : (I64 -> I64) -> I64 -> I64\nworker = fn step -> fn value -> step value\n'
    repeated += ''.join(f'export scope{i} : I64 -> I64\nscope{i} = fn value -> ad.scope2 worker next value\n' for i in range(64))
    term = 'value' + ' | step' * 20
    large = 'next : I64 -> I64\nnext = add 1\nworker : (I64 -> I64) -> I64 -> I64\nworker = fn step -> fn value -> [\n'
    large += ',\n'.join('    (' + term + ')' for _ in range(256)) + '\n] | sum\n'
    large += 'export scoped : I64 -> I64\nscoped = fn value -> ad.scope2 worker next value\n'
    # Executable builds root main, not every export. Reach every call explicitly
    # and keep the input typed/dynamic at the specialization boundary.
    repeated += 'main =\n    let value = read-lines () | length\n    in [\n'
    repeated += ',\n'.join(f'        scope{i} value' for i in range(64)) + '\n    ] | sum | echo\n'
    large += 'main = read-lines () | length | scoped | echo\n'
    return {'repeated-scopes': repeated, 'large-scoped-worker': large}


def scoped_cost_output(name, emitted, specialized):
    """Check live generated work, not names left in unused function metadata."""
    program = emitted.split('/* ---- program ---- */', 1)[1]
    scope, = re.findall(r'/\* ad\.scope2 : [^\n]+\*/\nstatic V f(\d+)\(', program)
    # One prototype and one definition are not calls.
    calls = len(re.findall(r'\bf' + scope + r'\(', program)) - 2
    live_workers = len(re.findall(r'\{2, e\d+, "worker-known-objective",', program))
    callbacks = len(re.findall(r' = fwp_apply_owned\(', program))
    assert name in ('repeated-scopes', 'large-scoped-worker'), name
    expected_calls = 64 if name == 'repeated-scopes' else 1
    expected_callbacks = (0 if specialized else 1) if name == 'repeated-scopes' else 5120
    assert (calls, live_workers, callbacks) == (expected_calls, int(specialized), expected_callbacks), (name, calls, live_workers, callbacks)
    return dict(scopeCalls=calls, liveSpecializations=live_workers, dynamicCallbackCalls=callbacks)


def check_scoped_cost_inputs(compiler, output, environment, timeout, specialized):
    """Compile and inspect both cost fixtures before any timed commands."""
    output.mkdir(parents=True, exist_ok=False)
    records = []
    for name, source in scoped_cost_inputs().items():
        path = output / (name + '.fwp')
        path.write_text(source)
        emitted = output / (name + '.c')
        command = [str(compiler), 'build', '--memory', 'dynamic', '--emit-c', '-O2',
                   str(path), '-o', str(emitted)]
        record = dict(name=name, command=command)
        try:
            result = run_capture(command, timeout=timeout, env=environment, cwd=str(ROOT),
                                 input_data=None, input_stream=None, text=False,
                                 encoding='utf-8', check=False)
            (output / (name + '.stdout')).write_bytes(result.stdout)
            (output / (name + '.stderr')).write_bytes(result.stderr)
            (output / (name + '.status')).write_text(str(result.returncode) + '\n')
            record['returncode'] = result.returncode
            assert result.returncode == 0 and not result.stdout and not result.stderr, name
            record['observed'] = scoped_cost_output(name, emitted.read_text(), specialized)
        except subprocess.TimeoutExpired as error:
            (output / (name + '.stdout')).write_bytes(error.output or b'')
            (output / (name + '.stderr')).write_bytes(error.stderr or b'')
            record.update(failure=str(error), timeout=timeout)
        except (AssertionError, IndexError, ValueError) as error:
            record['failure'] = str(error)
        records.append(record)
        (output / 'checks.json').write_text(json.dumps(records, indent=2) + '\n')
    assert not any('failure' in record for record in records), records
    return records


def consuming_cost_output(emitted, selected):
    """Require calls from each exported fixture, not unused private metadata."""
    program = emitted.split('/* ---- program ---- */', 1)[1]
    definitions = list(re.finditer(
        r'/\* ([-a-z0-9]+) : [^\n]*\*/\nstatic [^\n]*? ([fw]\d+)\([^\n]*\) \{', program))
    bodies = {}
    private = set()
    for match in definitions:
        end = program.index('\n}\n', match.end()) + 3
        body = program[match.end():end]
        if match[1] in ('consumed-scalar-array-map', 'consumed-scalar-array-list-zip'):
            private.add(match[2])
        else:
            bodies[match[1]] = body
    expected = ('mapped', 'mapped32', 'mapped64', 'update-left', 'update-right', 'mapped-produced', 'shared-first')
    observed = {}
    for name in (*expected, 'retained'):
        calls = set(re.findall(r'\b(f\d+)\(', bodies[name])) & private
        assert len(calls) == int(selected and name != 'retained'), (name, calls, selected)
        observed[name] = sorted(calls)
    assert 'direct known scalar array map; input stays borrowed' in bodies['retained']
    assert bool(private) == selected
    return observed


def check_consuming_cost_input(compiler, output, environment, timeout, selected):
    """Check live owning calls and a retained-input exclusion before timing."""
    output.mkdir(parents=True, exist_ok=False)
    source = (ROOT / 'tests/fixtures/owned_numeric_updates.fwp').read_text()
    source += '\nexport retained : Array[I64] -> (Array[I64], List[I64]) ! {Async}\n'
    source += ('retained = fn input ->\n    let changed = array.map increment input\n'
               '    in (changed, array.to-list input)\n')
    path = output / 'input.fwp'
    path.write_text(source)
    emitted = output / 'input.c'
    command = [str(compiler), 'build', '--fn', 'mapped', '--memory', 'dynamic',
               '--emit-c', '-O2', str(path), '-o', str(emitted)]
    record = dict(command=command, sourceSha256=sha(path))
    try:
        result = run_capture(command, timeout=timeout, env=environment, cwd=str(ROOT),
                             input_data=None, input_stream=None, text=False,
                             encoding='utf-8', check=False)
        (output / 'stdout').write_bytes(result.stdout)
        (output / 'stderr').write_bytes(result.stderr)
        record['returncode'] = result.returncode
        assert result.returncode == 0 and not result.stdout and not result.stderr, record
        record['observed'] = consuming_cost_output(emitted.read_text(), selected)
        record['cSha256'] = sha(emitted)
    except subprocess.TimeoutExpired as error:
        record['timeout'] = timeout
        (output / 'stdout').write_bytes(error.output or b'')
        (output / 'stderr').write_bytes(error.stderr or b'')
        raise
    finally:
        (output / 'record.json').write_text(json.dumps(record, indent=2) + '\n')
    return record


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', required=True, type=Path)
    parser.add_argument('--reference', required=True, type=Path)
    parser.add_argument('--reference-manifest', required=True, type=Path)
    parser.add_argument('--comparison', required=True, choices=('numeric-inputs', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric'))
    parser.add_argument('--time', required=True, type=Path)
    parser.add_argument('--machine', required=True, choices=('aarch64', 'x86_64'))
    parser.add_argument('--source', required=True)
    parser.add_argument('--timeout', required=True, type=int)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'measure on GitHub runners'
    assert platform.system() == 'Linux' and platform.machine() == args.machine
    assert args.timeout > 0
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source
    reference_manifest = json.loads(args.reference_manifest.read_text())
    assert reference_manifest['source'] == args.source
    assert reference_manifest['compilerSha256'] == sha(args.reference)
    if args.comparison == 'numeric-inputs':
        assert set(reference_manifest['files']) == {'src/cgen.rs', 'src/cgen/packed_records.rs'}
        assert set(reference_manifest['unchanged']) == {'src/ownership.rs', 'src/cgen/field_transfers.rs', 'src/cgen/numeric_parameters.rs'}
        assert reference_manifest['scope'] == 'numeric-inputs'
        assert reference_manifest['disabledTransformation'] == 'numeric internal parameters and numeric packed-map input preparation'
        for path, hashes in reference_manifest['files'].items():
            assert sha(ROOT / path) == hashes['candidateSha256'], path
        for path, digest in reference_manifest['unchanged'].items():
            assert sha(ROOT / path) == digest, path
    elif args.comparison == 'owned-numeric':
        assert reference_manifest['disabledTransformation'] == 'consuming scalar array maps and exclusive coordinate-list reuse'
        assert set(reference_manifest['candidate']) == set(reference_manifest['reference']) == {'src/cgen.rs'}
        assert set(reference_manifest['unchanged']) == {
            'src/ownership.rs', 'src/ir.rs', 'src/rc.rs', 'src/rc/borrows.rs',
            'src/cgen/owned_numeric.rs', 'src/opt/scoped.rs', 'src/cgen/packed_inputs.rs',
            'src/cgen/numeric_parameters.rs', 'src/cgen/packed_records.rs',
            'src/cgen/range_zip.rs', 'src/fuse.rs', 'src/opt.rs',
            'runtime/fwp_rt.c', 'runtime/fwp_rt_heap.c', 'runtime/fwp_rt_prims.c',
            'runtime/fwp_rt_task.c', 'runtime/fwp_rt_kernel.c', 'lib/autodiff.fwp', 'lib/list.fwp',
        }
        for group in ('candidate', 'unchanged'):
            for path, checksum in reference_manifest[group].items():
                assert sha(ROOT / path) == checksum, path
        assert reference_manifest['ownershipSha256'] == sha(ROOT / 'src/ownership.rs')
    elif args.comparison == 'packed-input':
        assert reference_manifest['disabledTransformation'] == 'scoped objective specialization and private numeric input packing'
        assert set(reference_manifest['candidate']) == set(reference_manifest['reference']) == {'src/mono.rs', 'src/cgen.rs'}
        assert set(reference_manifest['unchanged']) == {'runtime/fwp_rt_task.c', 'src/opt.rs', 'src/ownership.rs', 'runtime/fwp_rt_kernel.c', 'src/cgen/packed_records.rs', 'runtime/fwp_rt_heap.c', 'src/cgen/packed_inputs.rs', 'src/opt/scoped.rs', 'src/cgen/numeric_parameters.rs', 'lib/autodiff.fwp', 'src/cgen/range_zip.rs', 'lib/list.fwp', 'src/fuse.rs', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt.c'}
        for group in ('candidate', 'unchanged'):
            for path, checksum in reference_manifest[group].items():
                assert sha(ROOT / path) == checksum, path
        assert reference_manifest['ownershipSha256'] == sha(ROOT / 'src/ownership.rs')
    elif args.comparison == 'matched-option':
        assert reference_manifest['disabledTransformation'] == 'direct fields for matched list last, nth and final iteration results'
        assert set(reference_manifest['candidate']) == set(reference_manifest['reference']) == {'src/cgen.rs'}
        assert set(reference_manifest['unchanged']) == {'src/fuse.rs', 'src/prims_std.rs', 'src/ownership.rs', 'src/opt.rs', 'runtime/fwp_rt.c', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt_task.c', 'runtime/fwp_rt_heap.c', 'lib/list.fwp', 'lib/autodiff.fwp'}
        for group in ('candidate', 'unchanged'):
            for path, checksum in reference_manifest[group].items():
                assert sha(ROOT / path) == checksum, path
        assert reference_manifest['ownershipSha256'] == sha(ROOT / 'src/ownership.rs')
    elif args.comparison == 'final-iteration':
        assert reference_manifest['disabledTransformation'] == 'direct list last and unused numeric iteration history removal'
        assert set(reference_manifest['candidate']) == set(reference_manifest['reference']) == {'src/fuse.rs', 'lib/list.fwp'}
        assert set(reference_manifest['unchanged']) == {'src/cgen.rs', 'src/prims_std.rs', 'src/ownership.rs', 'src/opt.rs', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt_heap.c', 'lib/autodiff.fwp'}
        for group in ('candidate', 'unchanged'):
            for path, checksum in reference_manifest[group].items():
                assert sha(ROOT / path) == checksum, path
        assert reference_manifest['ownershipSha256'] == sha(ROOT / 'src/ownership.rs')
    elif args.comparison == 'scalar-array-identity':
        assert reference_manifest['disabledTransformation'] == 'F64 identity array-map elimination'
        assert reference_manifest['candidateOptimizerSha256'] == sha(ROOT / 'src/opt.rs')
        assert reference_manifest['ownershipSha256'] == sha(ROOT / 'src/ownership.rs')
        assert set(reference_manifest['unchanged']) == {'src/interp.rs', 'runtime/fwp_rt_num.c', 'src/cgen.rs'}
        for path, checksum in reference_manifest['unchanged'].items():
            assert sha(ROOT / path) == checksum, path
    elif args.comparison == 'gradient-array':
        assert reference_manifest['disabledTransformation'] == 'owned gradient arrays and direct array/list zip'
        assert set(reference_manifest['candidate']) == {'lib/autodiff.fwp', 'runtime/fwp_rt_kernel.c', 'src/cgen.rs', 'src/fuse.rs', 'src/interp.rs', 'src/ir.rs', 'src/numerics.rs'}
        for path, checksum in reference_manifest['candidate'].items():
            assert sha(ROOT / path) == checksum, path
        assert reference_manifest['ownershipSha256'] == sha(ROOT / 'src/ownership.rs')
        assert reference_manifest['frozenPatchSha256'] == sha(ROOT / 'scripts/gradient-array-candidate.patch')
    else:
        assert args.comparison in ('scalar-map-zip', 'range-zip', 'scalar-array-map')
        expected = {'scalar-map-zip': 'scalar map-to-zip buffer storage',
                    'range-zip': 'private range-to-zip storage',
                    'scalar-array-map': 'direct closed scalar array map callbacks'}[args.comparison]
        assert reference_manifest['disabledTransformation'] == expected
        assert reference_manifest['candidateCodegenSha256'] == sha(ROOT / 'src/cgen.rs')
        assert reference_manifest['ownershipSha256'] == sha(ROOT / 'src/ownership.rs')
    for key, expected in [('CARGO_PROFILE_DEV_OPT_LEVEL', '1'),
                          ('CARGO_PROFILE_DEV_DEBUG_ASSERTIONS', 'true'),
                          ('CARGO_PROFILE_DEV_OVERFLOW_CHECKS', 'true'), ('FWP_LTO', '0')]:
        assert os.environ.get(key) == expected, key
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items() if not key.startswith('FWP_')}
    environment.update(FWP_LTO='0', LC_ALL='C')
    if args.comparison in ('matched-option', 'packed-input', 'owned-numeric'):
        environment.update(FWP_VRET='1', FWP_FRAME_FIELDS='1')
    if args.comparison in ('packed-input', 'owned-numeric'):
        environment.update(FWP_PACKED_ARRAYS='1', FWP_STACK='1', FWP_ARRAY_FUSION='1')
    report = dict(source=args.source, machine=args.machine, complete=False, comparison=args.comparison,
                  scope='Entire compiler command through C emission: startup, parsing, typing, '
                        'optimization, ownership and emission. No generated-program execution. '
                        'GNU time -v reports process peak RSS across scheduled commands, including warmups; '
                        'untimed fixture checks are excluded from the ratios. '
                        'this is not isolated analysis heap use.',
                  compilerHashes=dict(candidate=sha(args.compiler), reference=sha(args.reference)),
                  referenceManifest=reference_manifest,
                  buildEnvironment={key: value for key, value in os.environ.items()
                                    if key.startswith(('CARGO_PROFILE_', 'FWP_'))
                                    or key in ('CC', 'CXX', 'RUSTFLAGS', 'CARGO_BUILD_JOBS')},
                  executionOverrides={**{key: value for key, value in environment.items()
                                         if key.startswith('FWP_') or key == 'LC_ALL'},
                                      'otherFWPSettings': 'removed'},
                  inputs={}, cases={}, commands=[])
    try:
        for name in COPIES:
            source = args.compiler if name.startswith('candidate') else args.reference
            destination = output / name
            shutil.copy2(source, destination)
            assert sha(destination) == sha(source)
        for command in (['rustc', '-vV'], ['gcc', '--version'], [str(args.time), '--version'], ['uname', '-a']):
            result = subprocess.run(command, check=True, capture_output=True, text=True)
            report['commands'].append(dict(command=command, stdout=result.stdout, stderr=result.stderr))
        report['cpu'] = Path('/proc/cpuinfo').read_text()
        programs = {name: (ROOT / path).read_text() for name, path in [
            ('field-transfer', 'tests/fixtures/field_owner_transfer.fwp'),
            ('autodiff-tutorial', 'docs/tutorials/20-autodiff-and-devices/main.fwp')]}
        programs.update({f'derivative-{dimensions}-{updates}': COSTS.AD.program(dimensions, updates + 1, False)
                         for dimensions, updates in ((3, 0), (33, 199), (129, 199))})
        if args.comparison in ('packed-input', 'owned-numeric'):
            programs.update(scoped_cost_inputs())
            report['preflight'] = {}
            for kind, specialized in [('candidate', True), ('reference', args.comparison == 'owned-numeric')]:
                try:
                    report['preflight'][kind] = check_scoped_cost_inputs(
                        output / (kind + '1'), output / ('preflight-' + kind),
                        environment, args.timeout, specialized)
                except AssertionError as error:
                    report['preflight'][kind] = dict(failure=str(error))
            assert all(isinstance(rows, list) for rows in report['preflight'].values()), report['preflight']
        if args.comparison == 'owned-numeric':
            report['consumingPreflight'] = {}
            for kind in ('candidate', 'reference'):
                try:
                    report['consumingPreflight'][kind] = check_consuming_cost_input(
                        output / (kind + '1'), output / ('consuming-' + kind),
                        environment, args.timeout, kind == 'candidate')
                except AssertionError as error:
                    report['consumingPreflight'][kind] = dict(failure=str(error))
            assert all('observed' in row for row in report['consumingPreflight'].values()), report['consumingPreflight']
        for name, source in programs.items():
            directory = output / name
            directory.mkdir()
            path = directory / 'program.fwp'
            path.write_text(source)
            report['inputs'][name] = dict(sha256=sha(path), bytes=path.stat().st_size)
            rows = []
            report['cases'][name] = dict(samples=rows)
            generated_hashes = {}
            # Two warmups per identical copy, then ten fixed balanced rounds.
            for round_number in range(-2, 10):
                for copy in ORDERS[round_number % 2]:
                    label = f'{round_number}-{copy}'
                    resources = directory / (label + '.resources.txt')
                    cfile = directory / (copy + '.c')
                    command = [str(args.time), '-v', '-o', str(resources), str(output / copy),
                               'build', '--memory', 'dynamic', '--emit-c', '-O2', str(path), '-o', str(cfile)]
                    row = dict(copy=copy, round=round_number, command=command)
                    rows.append(row)
                    start = time.perf_counter()
                    try:
                        result = run_capture(command, timeout=args.timeout, env=environment,
                                             cwd=str(ROOT), input_data=None, input_stream=None,
                                             text=False, encoding='utf-8', check=False)
                    except subprocess.TimeoutExpired as error:
                        row.update(timeout=args.timeout, seconds=time.perf_counter() - start)
                        (directory / (label + '.stdout')).write_bytes(error.output or b'')
                        (directory / (label + '.stderr')).write_bytes(error.stderr or b'')
                        raise
                    elapsed = time.perf_counter() - start
                    (directory / (label + '.stdout')).write_bytes(result.stdout)
                    (directory / (label + '.stderr')).write_bytes(result.stderr)
                    row.update(seconds=elapsed, returncode=result.returncode)
                    assert result.returncode == 0 and not result.stdout and not result.stderr, row
                    peak, = re.findall(r'Maximum resident set size \(kbytes\): (\d+)', resources.read_text())
                    row['peakCommandKiB'] = int(peak)
                    kind = 'candidate' if copy.startswith('candidate') else 'reference'
                    digest = sha(cfile)
                    assert generated_hashes.setdefault(kind, digest) == digest, (name, copy)
            report['cases'][name]['generatedCHashes'] = generated_hashes
            report['cases'][name]['summary'] = summarize(rows)
            print(name, report['cases'][name]['summary'], flush=True)
        report['complete'] = True
    finally:
        report['files'] = {str(path.relative_to(output)): sha(path)
                           for path in sorted(output.rglob('*')) if path.is_file()}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    failures = {name: case['summary']['failures'] for name, case in report['cases'].items()
                if case['summary']['failures']}
    assert not failures, failures


if __name__ == '__main__':
    main()
