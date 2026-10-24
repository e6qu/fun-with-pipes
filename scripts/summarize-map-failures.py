#!/usr/bin/env python3
"""Inspect saved map failure evidence without executing downloaded programs."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess


SPEC = importlib.util.spec_from_file_location(
    'collection_report', Path(__file__).with_name('summarize-collection-build.py'))
COLLECTION = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COLLECTION)


HOSTS = {
    'ubuntu-latest': 'elf64-x86-64',
    'ubuntu-24.04-arm': 'elf64-littleaarch64',
    'macos-15': 'mach-o arm64',
    'macos-15-intel': 'mach-o 64-bit x86-64',
    'windows-2025': 'coff-x86-64',
    'windows-11-arm': 'coff-arm64',
}


def inspect(binary, mode, kind, file_format, llvm):
    names = subprocess.check_output([str(llvm / 'llvm-nm'), str(binary)], text=True)
    symbols = {line.split()[-1].removeprefix('_')
               for line in names.splitlines() if line.split()}
    runtime = sorted(name for name in symbols if name.startswith('fwp_'))
    assert len(runtime) > 10, (binary, 'missing internal runtime names')
    tracing = sorted(symbols.intersection({'fwp_gc_scan', 'fwp_gc_mark_all', 'fwp_gc_sweep'}))
    assert bool(tracing) == (mode == 'tracing'), (binary, tracing)
    assembly = subprocess.check_output(
        [str(llvm / 'llvm-objdump'), '-d', '--no-show-raw-insn', str(binary)], text=True)
    assert 'file format ' + file_format in assembly, binary
    binary.with_suffix('.disassembly.txt').write_text(assembly)
    raw = binary.read_bytes()
    if kind == 'callbacks' and mode == 'arc':
        assert b'map callback storage leaked:' in raw, binary
    return {'file': binary.name, 'sha256': hashlib.sha256(raw).hexdigest(),
            'bytes': len(raw), 'format': file_format,
            'internal_runtime_symbols': len(runtime), 'tracing_symbols': tracing}


def sort_observation(directory, label, kind, late):
    limit = 65544 if kind == 'map' else 32776
    peak = limit + (65536 if kind == 'map' else 32768) if late else limit
    expected = f'{kind} peak={peak} limit={limit} final=0'
    assert (directory / f'{label}-{kind}.txt').read_text().strip() == expected
    status = int((directory / f'{label}-{kind}.status').read_text())
    assert status == (241 if late else 0), (label, kind, status)
    return {'kind': kind, 'peakChargedBytes': peak, 'limit': limit,
            'finalChargedBytes': 0, 'exitStatus': status}


def sort_storage(directory, file_format, llvm, runtime):
    runs = []
    for mode in ['arc', 'tracing']:
        ordinary = (directory / f'sort-storage-{mode}-ordinary.c').read_text()
        start = ordinary.index('static V fwp_map_build_typed(')
        end = start + ordinary[start:].index('\n}\n') + 3
        body = ordinary[start:end]
        runtime_start = runtime.index('static V fwp_map_build_typed(')
        runtime_end = runtime_start + runtime[runtime_start:].index('\n}\n') + 3
        assert body == runtime[runtime_start:runtime_end], 'Saved builder differs from recorded source'
        release = '    fwp_scratch_finish(&tk, &tk_cleanup);\n'
        finish = '    fwp_value_finish(&owner, &cleanup);\n'
        assert body.count(release) == body.count(finish) == 1
        late_body = body.replace(release, '').replace(finish, finish + release)
        late_source = (directory / f'sort-storage-{mode}-late-release.c').read_text()
        assert late_source == ordinary[:start] + late_body + ordinary[end:]
        for label in ['ordinary', 'late-release']:
            source = directory / f'sort-storage-{mode}-{label}.c'
            for opt in ['-O1', '-O2']:
                name = f'sort-storage-{mode}-{label}{opt}'
                runs.append({'mode': mode, 'optimization': opt, 'control': label,
                    'sourceSha256': hashlib.sha256(source.read_bytes()).hexdigest(),
                    'binary': inspect(directory / f'{name}.bin', mode, 'sort-storage', file_format, llvm),
                    'observations': [sort_observation(directory, name, kind, label == 'late-release')
                                     for kind in ['map', 'set']]})
    return runs


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--artifacts', type=Path, required=True)
    parser.add_argument('--audit', type=Path, required=True)
    parser.add_argument('--llvm-bin', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--head', required=True)
    args = parser.parse_args()
    audit = json.loads(args.audit.read_text())
    assert audit['head'] == args.head
    assert audit['status'] == 'completed' and len(audit['jobs']) == 6
    runtime = subprocess.check_output(
        ['git', 'show', args.head + ':runtime/fwp_rt_prims.c'], text=True)
    rows = []
    for host, file_format in HOSTS.items():
        jobs = [job for job in audit['jobs'] if job['name'] == f'map_storage ({host})']
        assert len(jobs) == 1, host
        job = jobs[0]
        assert job['conclusion'] == 'success' and job['passed'] == 13
        assert not any(job[key] for key in
                       ['failed', 'ignored', 'failed_steps', 'panic_lines'])
        directory = args.artifacts / f'map-storage-{host}'
        assert (directory / 'source.txt').read_text().strip() == audit['head']
        reference = (directory / 'interpreter.txt').read_bytes()
        assert reference.count(b'Err "expected"\n') == 4
        runs, binaries = [], []
        for mode in ['arc', 'tracing']:
            for opt in ['-O1', '-O2']:
                for poison in (['0'] if mode == 'arc' else ['0', '1']):
                    line = (directory / f'faults-{mode}{opt}-reuse-{poison}.txt').read_text().strip()
                    count = 138 if poison == '1' else 136
                    assert line == (f'22 map/set operations: {count} injected failures cleaned; '
                                    'aliases preserved'), line
                    runs.append({'mode': mode, 'optimization': opt,
                                 'reuse_verification': poison == '1',
                                 'injected_failures': count})
                assert (directory / f'callbacks-{mode}{opt}.txt').read_bytes() == reference
                assert not (directory / f'callbacks-{mode}{opt}.stderr').read_bytes()
                for kind in ['faults', 'callbacks']:
                    binaries.append(inspect(directory / f'{kind}-{mode}{opt}.bin',
                                            mode, kind, file_format, args.llvm_bin))
        fault_source = (directory / 'faults-arc.c').read_text()
        for name, function, before, after in [
            ('missing-result-owner', 'fwp_map_typed_copy',
             'fwp_value_owner owner = {result, ops->drop_map};',
             'fwp_value_owner owner = {result, NULL};'),
            ('missing-scratch-owner', 'fwp_map_build_typed',
             'fwp_scratch_protect(&tk, &tk_cleanup);',
             'fwp_cleanup_push(&tk_cleanup, map_test_no_release, &tk);')]:
            start = fault_source.index(f'static V {function}(')
            end = start + fault_source[start:].index('\n}\n') + 3
            body = fault_source[start:end]
            assert body.count(before) == 1
            assert (directory / f'{name}.c').read_text() == (
                fault_source[:start] + body.replace(before, after) + fault_source[end:])
        compact_source = (directory / 'compact-arc-O0.c').read_text()
        allocation = 'fwp_alloc(sizeof(fwp_map) + columns * len * sizeof(V))'
        assert compact_source.count(allocation) == 1
        assert (directory / 'compact-wasted-slot-control.c').read_text() == compact_source.replace(
            allocation, 'fwp_alloc(sizeof(fwp_map) + (columns + 1) * len * sizeof(V))')
        controls = {name: (directory / f'{name}.txt').read_text().strip()
                    for name in ['missing-result-owner', 'missing-scratch-owner']}
        assert all(value.endswith(': 213') for value in controls.values())
        controls['compact-wasted-slot-control'] = (directory / 'compact-wasted-slot-control.txt').read_text().strip()
        for name, status in [('missing-result-owner', 213), ('missing-scratch-owner', 213),
                             ('compact-wasted-slot-control', 211)]:
            assert int((directory / f'{name}.status').read_text()) == status
            assert (directory / f'{name}.c').stat().st_size
            binaries.append(inspect(directory / f'{name}.bin', 'arc', name, file_format, args.llvm_bin))
        compact = COLLECTION.compact_sets(directory, host, args.llvm_bin)
        storage = sort_storage(directory, file_format, args.llvm_bin, runtime)
        rows.append({'host': host, 'job': job['job'],
                     'settings': (directory / 'settings.txt').read_text().splitlines(),
                     'compiler': (directory / 'c.txt').read_text().strip(),
                     'rustc': (directory / 'rustc.txt').read_text().strip(),
                     'runs': runs, 'controls': controls, 'binaries': binaries,
                     'compactSets': compact, 'sortStorage': storage,
                     'callback_outputs_match_interpreter': True,
                     'arc_shutdown_counted_bytes': 0})
        print(host, '23 binaries, 6 fault configurations, 4 callbacks, 16 peaks, 3 cleanup/layout controls verified')
    args.output.write_text(json.dumps({
        'source': audit['head'], 'run': audit['run'], 'complete_native_matrix': True,
        'scope': 'Failure cleanup and typed ownership, not a timing or code-size comparison. '
                 'Instrumented programs execute on native CI hosts; this collector only reads '
                 'their files. ARC counted bytes exclude allocator capacity and process RSS. '
                 'Tracing retains collector code and deliberately poisons released objects '
                 'under reuse verification.',
        'hosts': rows,
    }, indent=2) + '\n')


if __name__ == '__main__':
    main()
