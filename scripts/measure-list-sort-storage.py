#!/usr/bin/env python3
"""Measure sort scratch storage separately from timing on native Linux runners."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import subprocess

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location('iteration_profile', ROOT / 'scripts/measure-iteration.py')
profile = importlib.util.module_from_spec(spec)
spec.loader.exec_module(profile)


def separate_lanes(code, kind):
    """Restore only redundant sort lanes, retaining the repaired cleanup."""
    name = 'fwp_p_sort_copied' if kind == 'list' else 'fwp_p_array_sort_typed'
    start = code.index('static V ' + name + '(')
    end = code.index('\n}\n', start) + 3
    body = code[start:end]
    if kind == 'list':
        old = '        fwp_msort(a, a, n, elem, tk, tk);'
        new = '''        V *tv = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
        fwp_cleanup tv_cleanup; fwp_scratch_protect(&tv, &tv_cleanup);
        V *vals = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
        fwp_cleanup vals_cleanup; fwp_scratch_protect(&vals, &vals_cleanup);
        memcpy(vals, a, n * sizeof(V));
        fwp_msort(a, vals, n, elem, tk, tv);
        fwp_scratch_finish(&vals, &vals_cleanup);
        fwp_scratch_finish(&tv, &tv_cleanup);'''
    else:
        old = '    fwp_msort(keys, keys, n, elem, tk, tk);'
        new = '''    V *tv = (V *)fwp_mem_alloc((n + 1) * sizeof(V));
    fwp_cleanup tv_cleanup; fwp_scratch_protect(&tv, &tv_cleanup);
    fwp_msort(keys, keys, n, elem, tk, tv);
    fwp_scratch_finish(&tv, &tv_cleanup);'''
    assert body.count(old) == 1
    return code[:start] + body.replace(old, new) + code[end:]


def copy_array(code):
    """Force only sorting to copy its array; leave input construction unchanged."""
    start = code.index('static V fwp_p_array_sort_typed(')
    end = code.index('\n}\n', start) + 3
    body = code[start:end]
    before = 'int unique = fwp_array_is_view(a) ? 0 : fwp_rc_unique_mut(a);'
    assert body.count(before) == 1
    return code[:start] + body.replace(before, 'int unique = 0;') + code[end:]


def copy_list_elements(code):
    """Retain every element while keeping its consumed list alive through the copy."""
    start = code.index('static V fwp_p_array_from_list_typed(')
    end = code.index('\n}\n', start) + 3
    body = code[start:end]
    assert body.count('int move_prefix = 1;') == 1
    return code[:start] + body.replace('int move_prefix = 1;', 'int move_prefix = 0;') + code[end:]


def variants(code, kind):
    if kind == 'array-built':
        return [('moves', code), ('copy-control', copy_list_elements(code))]
    if kind == 'array-owned':
        return [('reuse', code), ('copy-control', copy_array(code))]
    return [('shared', code), ('separate-control', separate_lanes(code, kind))]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ['GITHUB_ACTIONS'] == 'true' and platform.system() == 'Linux'
    assert re.fullmatch('[0-9a-f]{40}', args.source)
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == args.source
    assert not args.output.exists(), 'Preserve completed evidence'
    args.output.mkdir(parents=True)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in {'GH_TOKEN', 'GITHUB_TOKEN'}}
    environment.update(FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0',
                       FWP_GC='off', FWP_LTO='0', LC_ALL='C')

    def run(command, data=None, **settings):
        result = subprocess.run(list(map(str, command)), env=dict(environment, **settings),
                                input=data, capture_output=True, timeout=120)
        assert result.returncode == 0, (command, result.returncode, result.stderr)
        return result

    def digest(path):
        return hashlib.sha256(path.read_bytes()).hexdigest()

    report = dict(source=args.source, architecture=platform.machine(),
                  cpu=run(['lscpu']).stdout.decode(), kernel=run(['uname', '-a']).stdout.decode(),
                  compiler=run([args.cc, '--version']).stdout.decode(),
                  scope='Managed requests, requested bytes, retains and sampled charged peak after '
                        'constant initialization through language cleanup. Input parsing, result '
                        'construction and output are included. Counts exclude raw runtime buffers, '
                        'allocator metadata and stacks. No timing or C/Rust comparison. The control '
                        'restores redundant scratch lanes for list/array rows. The array-owned row '
                        'forces only sorting to copy its input. The array-built row retains list '
                        'elements instead of moving them. Every control retains cleanup.', programs=[])
    for kind, expression, primitive, removed in [
        ('list', 'sort | length', 'fwp_p_sort_copied', 2),
        ('array', 'array.from-list | array.sort | array.length', 'fwp_p_array_sort_typed', 1),
        ('array-owned', 'array.from-list | array.sort | array.length', 'fwp_p_array_sort_typed', 1),
        ('array-built', 'array.from-list | array.sort | array.length', 'fwp_p_array_from_list_typed', 0),
    ]:
        source = args.output / f'{kind}.fwp'
        source.write_text(f'main = read-all () | words | {expression} | echo\n')
        generated = args.output / f'{kind}-generated.c'
        run([args.compiler.resolve(), 'build', '--gc', 'arc', '--memory', 'dynamic',
             '-O2', '--emit-c', source, '-o', generated])
        code = generated.read_text()
        assert re.search(r'(?:return|V result =) ' + primitive + r'\(l', code)
        row = dict(name=kind, languageSha256=digest(source), generatedSha256=digest(generated),
                   variants={}, observations=[])
        for variant, text in variants(code, kind):
            for optimization in ['-O1', '-O2']:
                label = f'{kind}-{variant}{optimization}'
                ordinary = args.output / (label + '.c')
                ordinary.write_text(text)
                measured = args.output / (label + '-profile.c')
                measured.write_text(profile.instrument(text))
                images = {}
                for scope, path in [('ordinary', ordinary), ('profile', measured)]:
                    binary = path.with_suffix('')
                    command = [args.cc, '-std=gnu11', optimization, '-ffp-contract=off',
                               '-fstack-usage', '-w', path, '-o', binary, '-lm', '-lpthread', '-ldl']
                    run(command)
                    sections = run(['objdump', '--syms', '--section-headers', binary]).stdout
                    assembly = run(['objdump', '-d', binary]).stdout
                    sizes = re.findall(rb'^\s*\d+\s+\.text\s+([0-9a-fA-F]+)\s', sections, re.M)
                    assert sizes and len(assembly) > 1000
                    stack = path.with_suffix('.su')
                    assert stack.exists() and stack.stat().st_size > 0
                    images[scope] = dict(binary=binary.name, command=list(map(str, command)),
                        sourceSha256=digest(path), binarySha256=digest(binary),
                        fileBytes=binary.stat().st_size, textSectionBytes=sum(int(size, 16) for size in sizes),
                        stackReport=stack.read_text(), stackSha256=digest(stack),
                        disassemblySha256=hashlib.sha256(assembly).hexdigest())
                row['variants'][variant + optimization] = images
        for count in [0, 1, 32, 4096]:
            data = (' '.join(f'word{(index * 17) % 103:03d}' for index in range(count)) + '\n').encode()
            reference = run([args.compiler.resolve(), 'run', '--interp', source], data, FWP_NO_OPT='1')
            assert reference.stdout == f'{count}\n'.encode() and not reference.stderr
            observed = dict(elements=count, inputSha256=hashlib.sha256(data).hexdigest(), variants={})
            for variant, images in row['variants'].items():
                baseline = run([args.output / images['ordinary']['binary']], data)
                assert baseline.stdout == reference.stdout and not baseline.stderr
                samples = []
                for _ in range(3):
                    actual = run([args.output / images['profile']['binary']], data)
                    assert actual.stdout == reference.stdout
                    samples.append(json.loads(actual.stderr))
                assert all(sample == samples[0] for sample in samples)
                assert samples[0]['finalChargedBytes'] == samples[0]['collections'] == 0
                observed['variants'][variant] = samples
            for optimization in ['-O1', '-O2']:
                normal, control = [name for name, _ in variants(code, kind)]
                shared = observed['variants'][normal + optimization][0]
                separate = observed['variants'][control + optimization][0]
                extra = removed if count > 1 else 0
                assert separate['requests'] - shared['requests'] == extra
                assert separate['requestedBytes'] - shared['requestedBytes'] == extra * (count + 1) * 8
                assert separate['retains'] - shared['retains'] == (count if kind == 'array-built' or (kind == 'array-owned' and count > 1) else 0)
                assert separate['peakChargedBytes'] >= shared['peakChargedBytes']
            row['observations'].append(observed)
        report['programs'].append(row)
        print(kind, row['observations'], flush=True)
    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
