#!/usr/bin/env python3
"""Check whole-solve allocation predictions before running any timed comparison."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import subprocess

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
SCALAR_SPEC = importlib.util.spec_from_file_location('scalar_reference', ROOT / 'scripts/prepare-scalar-constant-reference.py')
SCALAR_REFERENCE = importlib.util.module_from_spec(SCALAR_SPEC)
SCALAR_SPEC.loader.exec_module(SCALAR_REFERENCE)
RECORDING_SPEC = importlib.util.spec_from_file_location('recording_reference', ROOT / 'scripts/prepare-recording-lookup-reference.py')
RECORDING_REFERENCE = importlib.util.module_from_spec(RECORDING_SPEC)
RECORDING_SPEC.loader.exec_module(RECORDING_REFERENCE)
INLINE_SPEC = importlib.util.spec_from_file_location('inline_reference', ROOT / 'scripts/prepare-recording-inline-reference.py')
INLINE_REFERENCE = importlib.util.module_from_spec(INLINE_SPEC)
INLINE_SPEC.loader.exec_module(INLINE_REFERENCE)
CAPACITY_SPEC = importlib.util.spec_from_file_location('capacity_reference', ROOT / 'scripts/prepare-recording-capacity-reference.py')
CAPACITY_REFERENCE = importlib.util.module_from_spec(CAPACITY_SPEC)
CAPACITY_SPEC.loader.exec_module(CAPACITY_REFERENCE)
CONTEXT_SPEC = importlib.util.spec_from_file_location('context_reference', ROOT / 'scripts/prepare-recording-context-reference.py')
CONTEXT_REFERENCE = importlib.util.module_from_spec(CONTEXT_SPEC)
CONTEXT_SPEC.loader.exec_module(CONTEXT_REFERENCE)
SPEC = importlib.util.spec_from_file_location('descent', ROOT / 'scripts/measure-descent-peers.py')
DESCENT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(DESCENT)
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-owned-numeric-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
SPEC = importlib.util.spec_from_file_location('gradient_reference', ROOT / 'scripts/prepare-gradient-call-reference.py')
GRADIENT_REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(GRADIENT_REFERENCE)
SPEC = importlib.util.spec_from_file_location('pair_reference', ROOT / 'scripts/prepare-packed-pair-reference.py')
PAIR_REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PAIR_REFERENCE)
CASES = ((3, 0, 32768), (3, 1, 512), (3, 199, 32), (3, 1999, 4), (33, 199, 32), (129, 199, 8))


def compare(candidate, reference, dimensions, updates, solves, comparison):
    """Exact count prediction; additional savings also need explanation before timing."""
    cells = dimensions * max(updates - 1, 0) * solves
    maps = updates * solves
    expected = dict(requests=cells + maps, requestedBytes=24 * cells + (8 * dimensions + 8) * maps)
    if comparison == 'gradient-call':
        expected = dict(requests=7 * maps + int(updates > 0),
                        requestedBytes=(8 * dimensions + 128) * maps + 24 * int(updates > 0),
                        retains=2 * maps)
    elif comparison in ('scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'):
        expected = dict(requests=0, requestedBytes=0, retains=0)
    elif comparison == 'packed-pair':
        expected = dict(requests=maps, requestedBytes=(16 * dimensions - 8) * maps, retains=0)
    else:
        assert comparison == 'owned-numeric', comparison
    actual = {key: reference['managed'][key] - candidate['managed'][key] for key in expected}
    assert actual == expected, dict(actual=actual, expected=expected)
    for key in ('retains', 'peakChargedBytes'):
        assert candidate['managed'][key] <= reference['managed'][key], key
    assert candidate['managed']['finalChargedBytes'] == reference['managed']['finalChargedBytes'] == 0
    assert candidate['raw'] == reference['raw'], 'raw tape storage changed'
    assert candidate['raw']['finalBytes'] == 0
    if not updates:
        assert candidate == reference, 'zero-update storage changed'
    return actual


def reconcile_parent(repeated, fresh, parent_repeated, parent_fresh):
    """The same-source reference must reproduce the delivered parent's storage."""
    assert repeated['complete'] and repeated['comparison'] in ('packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context')
    assert fresh['source'] == repeated['source']
    assert fresh['machine'] == repeated['machine'] == parent_fresh['machine'] == parent_repeated['machine']
    assert parent_fresh['source'] == parent_repeated['source']
    assert parent_repeated['allDiagnosticsAudited'] and not parent_repeated['correctedComparisonFailures']
    assert len(fresh['cases']) == len(parent_fresh['cases']) == 24
    assert set(fresh['cases']) == set(parent_fresh['cases'])
    for name, case in fresh['cases'].items():
        before = parent_fresh['cases'][name]['observations']
        assert set(case['observations']) == set(before) == {'0', '1'}
        for mode, observed in case['observations'].items():
            old = before[mode]
            assert observed['totals']['managed'] == old['totals']['managed'], (name, mode, 'managed')
            assert observed['raw'] == old['raw'], (name, mode, 'raw')
            assert observed['visits'] == old['visits'], (name, mode, 'derivative work')
            assert set(observed['phases']) == set(old['phases'])
            for phase, row in observed['phases'].items():
                for key in ('requests', 'requestedBytes', 'peakChargedBytes'):
                    assert row[key] == old['phases'][phase][key], (name, mode, phase, key)
    assert len(repeated['cases']) == len(parent_repeated['cases']) == 12
    assert set(repeated['cases']) == set(parent_repeated['cases'])
    for name, row in repeated['cases'].items():
        old = parent_repeated['cases'][name]
        assert row['solves'] == old['solves'], name
        for mode in ('0', '1'):
            assert row['observations']['reference' + mode]['managed'] == old['candidate'], (name, mode)
        raw = row['observations']['reference1']['raw']
        assert raw['peakBytes'] == old['rawPeakBytes'] and raw['finalBytes'] == old['finalRawBytes'] == 0, name
    return dict(source=repeated['source'], parentSource=parent_fresh['source'],
                machine=fresh['machine'], freshCases=24, repeatedCases=12,
                compared='Exact managed counts/peaks; fresh phase allocation/peaks, raw storage and derivative work; repeated workspace-on raw peak/final bytes')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--comparison', choices=('owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'), required=True)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--reference', type=Path, required=True)
    parser.add_argument('--reference-manifest', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--machine', choices=('aarch64', 'x86_64'), required=True)
    parser.add_argument('--c-arch', choices=('armv8-a', 'x86-64'), required=True)
    parser.add_argument('--timeout', type=int, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'native builds and census belong on runners'
    assert platform.system() == 'Linux' and platform.machine() == args.machine
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.machine]
    assert args.timeout > 0
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source
    reference_module = {'owned-numeric': REFERENCE, 'gradient-call': GRADIENT_REFERENCE,
                        'packed-pair': PAIR_REFERENCE, 'scalar-constant': SCALAR_REFERENCE, 'recording-lookup': RECORDING_REFERENCE, 'recording-inline': INLINE_REFERENCE, 'recording-capacity': CAPACITY_REFERENCE, 'recording-context': CONTEXT_REFERENCE}[args.comparison]
    manifest = json.loads(args.reference_manifest.read_text())
    assert manifest['source'] == args.source
    expected_transformation = {
        'scalar-constant': 'exact immediate scalar constants and acyclic cached aliases',
        'recording-lookup': 'validated tape lookup reuse within bounded nonsuspending numeric workers',
        'recording-inline': 'forced inlining of the checked F64 scalar append body',
        'recording-capacity': 'inlined checked reserve gate with shared tape growth',
        'recording-context': 'validated recording state shared through closed numeric calls and loops',
        'packed-pair': 'reuse of the consumed private neighboring-record buffer',
        'owned-numeric': 'consuming scalar array maps and exclusive coordinate-list reuse',
        'gradient-call': 'scoped input borrowing, numeric fold fields, single-root seeding and consumed array scratch',
    }[args.comparison]
    assert manifest['disabledTransformation'] == expected_transformation
    assert set(manifest['candidate']) == set(manifest['reference']) == set(reference_module.EDITS)
    assert set(manifest['unchanged']) == set(reference_module.PRESERVED)
    for group in ('candidate', 'unchanged'):
        for name, checksum in manifest[group].items():
            assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == checksum, name
    assert manifest['ownershipSha256'] == manifest['unchanged']['src/ownership.rs']
    expected = reference_module.reference_sources({name: (ROOT / name).read_text() for name in reference_module.EDITS})
    assert manifest['reference'] == {name: hashlib.sha256(text.encode()).hexdigest() for name, text in expected.items()}
    assert hashlib.sha256((args.reference_manifest.parent / 'reference.patch').read_bytes()).hexdigest() == manifest['patchSha256']
    assert hashlib.sha256(args.reference.read_bytes()).hexdigest() == manifest['compilerSha256']
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_AD_WORKSPACE='1', FWP_LTO='0', FWP_VRET='1', FWP_FRAME_FIELDS='1',
                       FWP_PACKED_ARRAYS='1', FWP_STACK='1', FWP_ARRAY_FUSION='1', LC_ALL='C')
    report = dict(source=args.source, machine=args.machine, comparison=args.comparison, complete=False,
                  settings={key: value for key, value in environment.items() if key.startswith('FWP_')},
                  referenceManifest=manifest, commands=[], cases={},
                  compilerSha256=hashlib.sha256(args.compiler.read_bytes()).hexdigest())

    def run(command, env, stem):
        command = list(map(str, command))
        record = dict(command=command, workspace=env.get('FWP_AD_WORKSPACE'))
        report['commands'].append(record)
        try:
            result = run_capture(command, timeout=args.timeout, env=env, cwd=ROOT,
                                 input_data=None, input_stream=None, text=False,
                                 encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            record['timeout'] = args.timeout
            stem.with_suffix('.stdout').write_bytes(error.output or b'')
            stem.with_suffix('.stderr').write_bytes(error.stderr or b'')
            raise
        stem.with_suffix('.stdout').write_bytes(result.stdout)
        stem.with_suffix('.stderr').write_bytes(result.stderr)
        record['returncode'] = result.returncode
        assert result.returncode == 0, record
        return result

    try:
        for name, command in (('cc', [args.cc, '--version']),
                              ('rustc', ['rustc', '--version', '--verbose']),
                              ('cpu', ['lscpu'])):
            result = run(command, environment, output / name)
            assert result.stdout and not result.stderr
        for dimensions, updates, solves in CASES:
            for history in (False, True):
                name = f'{dimensions}-{updates}-' + ('history' if history else 'current')
                folder = output / name
                folder.mkdir()
                source = DESCENT.BASELINE.repeat_source(
                    DESCENT.AD.program(dimensions, updates + 1, history), 'fwp', solves)
                path = folder / 'input.fwp'
                path.write_text(source)
                row = dict(dimensions=dimensions, updates=updates, solves=solves, observations={})
                report['cases'][name] = row
                for kind, compiler in (('candidate', args.compiler), ('reference', args.reference)):
                    emitted = folder / (kind + '.c')
                    result = run([compiler.resolve(), 'build', '--memory', 'dynamic', '--emit-c', '-O2', path, '-o', emitted],
                                 environment, folder / (kind + '-emit'))
                    assert not result.stdout and not result.stderr
                    if args.comparison == 'recording-inline':
                        DESCENT.RECORDING_SELECTION.check_inline_declaration(emitted.read_text(), kind == 'candidate')
                    if args.comparison == 'recording-capacity':
                        DESCENT.RECORDING_SELECTION.check_capacity_gate(emitted.read_text(), kind == 'candidate')
                    if args.comparison in ("recording-lookup", "recording-inline", 'recording-capacity', 'recording-context') and updates > 0:
                        if args.comparison == 'recording-context':
                            DESCENT.CONTEXT_SELECTION.check(emitted.read_text(), kind == 'candidate')
                        else:
                            DESCENT.RECORDING_SELECTION.check(emitted.read_text(), kind == 'candidate' or args.comparison in ('recording-inline', 'recording-capacity'))
                    if args.comparison == 'scalar-constant' and updates > 0:
                        DESCENT.SCALAR_SELECTION.check(emitted.read_text(), 'literal' if kind == 'candidate' else 'cached')
                    if args.comparison in ("recording-lookup", "recording-inline", 'recording-capacity', 'recording-context'):
                        lookup_source = folder / (kind + '-lookup.c')
                        lookup_source.write_text(DESCENT.RECORDING_SELECTION.instrument(emitted.read_text()))
                        lookup_binary = folder / (kind + '-lookup')
                        observed = run([args.cc, '-O2', '-std=gnu11', '-fno-fast-math', '-ffp-contract=off',
                                        '-UFWP_NO_REUSE', '-fstack-usage', '-march=' + args.c_arch, '-w',
                                        lookup_source, '-o', lookup_binary, '-lm', '-lpthread', '-ldl'],
                                       environment, folder / (kind + '-lookup-compile'))
                        assert not observed.stdout and not observed.stderr
                        row.setdefault('lookupObservations', {})[kind] = {}
                        for workspace in ('0', '1'):
                            observed = run([lookup_binary], dict(environment, FWP_AD_WORKSPACE=workspace),
                                           folder / (kind + '-lookup-workspace' + workspace))
                            DESCENT.verify(observed.stdout, DESCENT.AD.analytic(dimensions, updates + 1), solves)
                            counts = json.loads(observed.stderr)
                            selection = DESCENT.CONTEXT_SELECTION if args.comparison == 'recording-context' else DESCENT.RECORDING_SELECTION
                            selection.check_counts(counts, dimensions, updates, solves, kind == 'candidate' or args.comparison in ('recording-inline', 'recording-capacity'))
                            row['lookupObservations'][kind][workspace] = counts
                    profiled = folder / (kind + '-profile.c')
                    profiled.write_text(DESCENT.AD.RAW.instrument(DESCENT.AD.PROFILE.instrument(emitted.read_text()), 'records'))
                    executable = folder / (kind + '-profile')
                    result = run([args.cc, '-O2', '-std=gnu11', '-fno-fast-math', '-ffp-contract=off',
                                  '-UFWP_NO_REUSE', '-fstack-usage', '-march=' + args.c_arch, '-w',
                                  profiled, '-o', executable, '-lm', '-lpthread', '-ldl'],
                                 environment, folder / (kind + '-compile'))
                    assert not result.stdout and not result.stderr
                    image = executable.read_bytes()
                    assert image[:6] == b'\x7fELF\x02\x01'
                    assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.machine]
                    row[kind + 'Sha256'] = hashlib.sha256(image).hexdigest()
                    for workspace in ('0', '1'):
                        result = run([executable], dict(environment, FWP_AD_WORKSPACE=workspace),
                                     folder / (kind + '-workspace' + workspace))
                        DESCENT.verify(result.stdout, DESCENT.AD.analytic(dimensions, updates + 1), solves)
                        managed, raw = [json.loads(line) for line in result.stderr.splitlines()]
                        raw = raw['rawDerivativeStorage']
                        DESCENT.AD.RAW.check_profile(raw, updates * solves, workspace == '1')
                        row['observations'][kind + workspace] = dict(managed=managed, raw=raw)
                row['savings'] = {workspace: compare(row['observations']['candidate' + workspace],
                    row['observations']['reference' + workspace], dimensions, updates, solves, args.comparison)
                    for workspace in ('0', '1')}
                for kind in ('candidate', 'reference'):
                    assert row['observations'][kind + '0']['managed'] == row['observations'][kind + '1']['managed']
                print(name, 'exact allocation prediction and cleanup pass', flush=True)
        report['complete'] = True
    finally:
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
