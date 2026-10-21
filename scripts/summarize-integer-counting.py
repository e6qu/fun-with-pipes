#!/usr/bin/env python3
"""Verify saved counter experiments and preserve every per-CPU timing sample."""
import argparse
import importlib.util
import json
from pathlib import Path
import re
import statistics
import subprocess

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location('scalar_audit', ROOT / 'scripts/summarize-scalar-text.py')
audit = importlib.util.module_from_spec(spec)
spec.loader.exec_module(audit)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--comparison', choices=['legacy', 'matched', 'range', 'compiled-range'], required=True)
    parser.add_argument('--artifacts', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert re.fullmatch('[0-9a-f]{40}', args.source)
    candidate_runtime = subprocess.check_output(
        ['git', 'show', args.source + ':runtime/fwp_rt_ops.c'], text=True)
    hosts = []
    labels = ('c', 'rs', 'saved-fwp', 'rebuilt-fwp', 'candidate-fwp')
    if args.comparison != 'legacy':
        labels += ('matched-c', 'matched-rs', 'grouped-unhinted')
    if args.comparison in ('range', 'compiled-range'):
        labels += ('recomputed-product',)
    for host, (machine, _) in audit.HOSTS.items():
        root = args.artifacts / ('integer-counting-' + host)
        report = json.loads((root / 'report.json').read_text())
        assert report['measurementSource'] == args.source and report['measurementRun'] == args.run
        assert report['host'] == host and report['affinityPolicy'] == 'each-allowed'
        assert report['rounds'] > 0 and report['rounds'] % (2 * len(labels)) == 0 and report['warmups'] > 0
        source = report['programSource']
        source_report = audit.host_report(root / 'input', host, source)
        assert json.loads((root / 'source-audit.json').read_text()) == source_report
        assert source_report['cCompiler'] == report['cCompiler']
        directory, = (root / 'input' / ('scalar-text-bench-' + host)
                      / 'bench-evidence' / source).iterdir()
        original = (directory / 'text-length-generated.c').read_text()
        rebuilt = (root / 'rebuilt-fwp.c').read_text()
        candidate = (root / 'candidate-fwp.c').read_text()
        old, new = report['oldHelper'], report['candidateHelper']
        assert old != new and original.count(old) == 1 and candidate_runtime.count(new) == 1
        assert rebuilt == original and candidate == original.replace(old, new)
        for label, kind in [('c', 'c'), ('rs', 'rs'), ('saved-fwp', 'fwp'),
                            ('rebuilt-fwp', None), ('candidate-fwp', None)]:
            binary = directory / ('text-length-' + kind) if kind else root / label
            expected = {**audit.binary(binary, machine),
                        'assemblySha256': audit.digest(root / (label + '.asm'))}
            assert report['binaries'][label] == expected
            if kind is None:
                assert report['builds'][label]['sourceSha256'] == audit.digest(root / (label + '.c'))
                command = report['builds'][label]['command']
                assert command[:5] == ['gcc', '-O2', '-std=gnu11', '-ffp-contract=off', '-w']
                libraries = command[-5:-2] if args.comparison in ('range', 'compiled-range') else command[-3:]
                assert libraries == ['-lm', '-lpthread', '-ldl']
        if args.comparison != 'legacy':
            label = 'grouped-unhinted'
            assert (root / (label + '.c')).read_text() == candidate.replace(
                new, new.replace('static inline ', 'static '))
            assert report['builds'][label]['sourceSha256'] == audit.digest(root / (label + '.c'))
            assert report['binaries'][label] == {
                **audit.binary(root / label, machine),
                'assemblySha256': audit.digest(root / (label + '.asm'))}
            for kind, compiler, flags in [('c', 'gcc', ['-O2']), ('rs', 'rustc', ['-O'])]:
                label = 'matched-' + kind
                source_path = root / (label + '.' + kind)
                expected_source = subprocess.check_output(
                    ['git', 'show', args.source + ':bench/text-length/main.' + kind])
                assert source_path.read_bytes() == expected_source
                assert report['builds'][label]['sourceSha256'] == audit.digest(source_path)
                assert report['builds'][label]['command'][:2] == [compiler, *flags]
                assert report['binaries'][label] == {
                    **audit.binary(root / label, machine),
                    'assemblySha256': audit.digest(root / (label + '.asm'))}
            assert report['rustCompiler'].startswith('rustc ')
            if args.comparison in ('matched', 'compiled-range'):
                probes = args.artifacts / ('integer-counting-semantics-' + host)
                expected = {f'semantics-{mode}{opt}' for mode in ('arc', 'tracing')
                            for opt in ('-O0', '-O2')}
                expected.update(f'allocation-check-{mode}{opt}-exit-{status}'
                                for mode in ('arc', 'tracing') for opt in ('-O0', '-O2')
                                for status in (0, 247))
                assert {path.stem for path in probes.glob('*.exe')} == expected
                checked = []
                for label in sorted(expected):
                    code = probes / (label + '.c')
                    assembly = probes / (label + '.asm')
                    assert new in code.read_text() and assembly.stat().st_size > 0
                    if label.startswith('allocation-check-'):
                        assert (probes / (label + '.stdout')).read_bytes() == b'40240\n'
                        assert (probes / (label + '.stderr')).read_bytes() == b''
                        injected = '(void)fwp_alloc_leaf(16); return (V)fwp_i64_chars((int64_t)l0);'
                        assert (injected in code.read_text()) == label.endswith('-exit-247')
                    checked.append({'name': label, **audit.binary(probes / (label + '.exe'), machine),
                                    'sourceSha256': audit.digest(code), 'assemblySha256': audit.digest(assembly)})
                report['semanticProbes'] = checked
        if args.comparison in ('range', 'compiled-range'):
            experiment = report['arithmeticExperiment']
            assert experiment['compilerChanged'] is False
            old_multiply, new_multiply = experiment['originalMultiply'], experiment['recomputedMultiply']
            assert old_multiply.count('return (V)r;') == 1
            assert old_multiply.count('__builtin_mul_overflow(x, y, &r)') == 1
            assert new_multiply == old_multiply.replace('return (V)r;', 'return (V)(x * y);')
            assert candidate.count(old_multiply) == 1
            label = 'recomputed-product'
            assert (root / (label + '.c')).read_text() == candidate.replace(old_multiply, new_multiply)
            assert report['builds'][label]['sourceSha256'] == audit.digest(root / (label + '.c'))
            command = report['builds'][label]['command']
            assert command[:5] == ['gcc', '-O2', '-std=gnu11', '-ffp-contract=off', '-w']
            assert command[-5:-2] == ['-lm', '-lpthread', '-ldl']
            assert report['binaries'][label] == {
                **audit.binary(root / label, machine),
                'assemblySha256': audit.digest(root / (label + '.asm'))}
            report['compilerDumps'] = {}
            for label in ('rebuilt-fwp', 'candidate-fwp', 'grouped-unhinted', 'recomputed-product', 'matched-c'):
                for suffix in ('optimized', 'ranges'):
                    path = root / (label + '.' + suffix)
                    assert path.stat().st_size > 0
                    report['compilerDumps'][path.name] = audit.digest(path)
        if args.comparison == 'compiled-range':
            actual_c = root / 'compiler-produced.c'
            assert actual_c.read_bytes() == (root / 'recomputed-product.c').read_bytes()
            actual = audit.binary(root / 'compiler-produced', machine)
            assert actual['textSectionSha256'] == report['binaries']['recomputed-product']['textSectionSha256']
            assert (root / 'compiler-produced.stdout').read_bytes() == b'28518516\n'
            assert (root / 'compiler-produced.stderr').read_bytes() == b''
            assembly = root / 'compiler-produced.asm'
            assert assembly.stat().st_size > 0
            report['compilerProduced'] = {
                **actual, 'sourceSha256': audit.digest(actual_c),
                'assemblySha256': audit.digest(assembly)}
        assert [item['cpu'] for item in report['measurements']] == report['allowedCpus']
        assert report['allowedCpus'] == sorted(set(report['allowedCpus'])) and report['allowedCpus']
        for result in report['measurements']:
            timing = result['timing']
            assert set(timing) == set(labels)
            for label in labels:
                samples = timing[label]['samples']
                assert len(samples) == report['rounds']
                for number, sample in enumerate(samples):
                    offset = number % len(labels)
                    order = labels[offset:] + labels[:offset]
                    if number // len(labels) % 2:
                        order = order[::-1]
                    assert sample['round'] == number and sample['order'] == list(order)
                    assert sample['wallNs'] > 0 and sample['childCpuNs'] > 0
                assert timing[label]['medianWallNs'] == statistics.median(s['wallNs'] for s in samples)
                assert timing[label]['medianChildCpuNs'] == statistics.median(s['childCpuNs'] for s in samples)
            for peer, ratios in result['candidateOverPeer'].items():
                assert peer in labels and peer != 'candidate-fwp'
                for metric in ('medianWallNs', 'medianChildCpuNs'):
                    assert ratios[metric] == timing['candidate-fwp'][metric] / timing[peer][metric]
            assert set(result['candidateOverPeer']) == set(labels) - {'candidate-fwp'}
        for label in ('rebuilt-fwp', 'candidate-fwp') + (('grouped-unhinted',) if args.comparison != 'legacy' else ()) + (('recomputed-product',) if args.comparison in ('range', 'compiled-range') else ()):
            counts = report['managedMemory'][label]
            assert all(counts[key] == 0 for key in ('requests', 'requestedBytes', 'retains',
                       'peakChargedBytes', 'finalChargedBytes', 'collections'))
        control = report['managedMemory']['injected-allocation']
        assert control['requests'] == 1 and control['requestedBytes'] == 16
        assert control['peakChargedBytes'] > 0
        hosts.append(report)
        cpu_model, = re.findall(r'^Model name:\s*(.+)$', report['cpuInfo'], re.M)
        print(host, cpu_model, flush=True)
        for item in report['measurements']:
            print('CPU', item['cpu'], 'candidate/peer', item['candidateOverPeer'], flush=True)
    args.output.write_text(json.dumps({'run': args.run, 'source': args.source, 'hosts': hosts}, indent=2) + '\n')


if __name__ == '__main__':
    main()
