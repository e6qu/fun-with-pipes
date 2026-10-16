#!/usr/bin/env python3
"""Runner-only numeric zip/map comparison with allocation and binary evidence."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import statistics
import sys
import time

ROOT = Path(__file__).resolve().parent.parent
sys.dont_write_bytecode = True
spec = importlib.util.spec_from_file_location('metadata', ROOT / 'scripts/measure-ad-metadata.py')
metadata = importlib.util.module_from_spec(spec)
spec.loader.exec_module(metadata)
run = metadata.run
CASES = {
    'direct': ('work : List[F64] -> List[F64]\n'
               'work = both id (map (add 1.0)) | uncurry zip | map (uncurry mul)\n'
               'main = range 0 128 | map (const (range 0 4096 | map int.to-float)) | '
               'map work | map sum | sum | echo\n', None),
    'derivative': metadata.CASES['sustained-map'],
    'nested': metadata.CASES['nested'],
}


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full measurements run on GitHub'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve(); out.mkdir(parents=True, exist_ok=True)
    compiler = ROOT / 'target/release/fwp'
    environment = dict(os.environ, FWP_ARRAY_FUSION='1', FWP_MAP_ARRAY='1', FWP_AD_WORKSPACE='1',
                       FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_NO_OPT', None)
    cc = os.environ.get('CC', 'cc')
    results = {}
    for name, (program, expected) in CASES.items():
        source = out / (name + '.fwp'); source.write_text(program)
        raw = run([compiler, 'run', '--interp', source], dict(environment, FWP_NO_OPT='1'))
        assert not raw.stderr and raw.stdout
        if expected is not None:
            assert raw.stdout == expected
        else:
            assert float(raw.stdout) == 128 * 4096 * 4095 * 4097 / 3
        modes = {}
        for memory in ['tracing', 'arc']:
            variants = {}; binaries = {}
            for enabled in ['0', '1']:
                stem = f'{name}-{memory}-{enabled}'
                cfile = out / (stem + '.c')
                before = time.perf_counter_ns()
                run([compiler, 'build', '--gc', memory, '--emit-c', source, '-o', cfile],
                    dict(environment, FWP_ZIP_MAP=enabled))
                emit_ns = time.perf_counter_ns() - before
                code = cfile.read_text()
                fused_calls = code.count('/* fused-zip-map :')
                if enabled == '0': assert fused_calls == 0
                if enabled == '1' and name != 'nested': assert fused_calls > 0, name
                binary = out / stem
                command = [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w', cfile, '-o', binary, '-lm', '-lpthread']
                before = time.perf_counter_ns(); run(command, environment)
                compile_ns = time.perf_counter_ns() - before
                warm = run([binary], environment); assert warm.stdout == raw.stdout and not warm.stderr
                profile_source = out / (stem + '-profile.c')
                profile_source.write_text(metadata.checkpoint.instrument(code))
                profile_binary = out / (stem + '-profile')
                run([cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w', profile_source, '-o', profile_binary, '-lm', '-lpthread'], environment)
                profile = run([profile_binary], dict(environment, FWP_GC='off') if memory == 'tracing' else environment)
                assert profile.stdout == raw.stdout
                tape, managed = map(json.loads, profile.stderr.splitlines())
                assert tape['finalTapeBytes'] == managed['finalChargedBytes'] == managed['collections'] == 0
                assembly = run(['otool', '-tvV', binary] if platform.system() == 'Darwin' else ['objdump', '-d', binary]).stdout
                (out / (stem + '.asm')).write_text(assembly)
                variants[enabled] = dict(generatedSha256=hashlib.sha256(cfile.read_bytes()).hexdigest(),
                    binarySha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
                    assemblySha256=hashlib.sha256(assembly.encode()).hexdigest(),
                    generatedBytes=cfile.stat().st_size, binaryBytes=binary.stat().st_size,
                    emitWallNs=emit_ns, compileWallNs=compile_ns, command=list(map(str, command)),
                    fusedCallbackBodies=fused_calls, tape=tape, managed=managed, processWallNs=[])
                binaries[enabled] = binary
            for sample in range(8):
                for enabled in (['0', '1'] if sample % 2 == 0 else ['1', '0']):
                    before = time.perf_counter_ns(); measured = run([binaries[enabled]], environment)
                    elapsed = time.perf_counter_ns() - before
                    assert measured.stdout == raw.stdout and not measured.stderr
                    variants[enabled]['processWallNs'].append(elapsed)
            for data in variants.values(): data['medianProcessWallNs'] = statistics.median(data['processWallNs'])
            assert variants['1']['managed']['requests'] <= variants['0']['managed']['requests'], (name, memory)
            if name != 'nested':
                assert variants['1']['managed']['requests'] < variants['0']['managed']['requests'], (name, memory)
                assert variants['1']['managed']['retains'] < variants['0']['managed']['retains'], (name, memory)
            modes[memory] = dict(variants=variants,
                enabledOverDisabled=variants['1']['medianProcessWallNs'] / variants['0']['medianProcessWallNs'])
        results[name] = dict(source=program, expected=raw.stdout, modes=modes)
    report = dict(head=run(['git', 'rev-parse', 'HEAD']).stdout.strip(), results=results,
        hardware=platform.uname()._asdict(),
        cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
        compiler=run([cc, '--version']).stdout,
        scope='Same compiler, source, inputs, native flags and memory mode; only FWP_ZIP_MAP changes. '
              'Other array fusion, mapped-array construction and derivative workspace reuse enabled. One warmup and eight alternating '
              'process samples include startup, input construction, computation and output. Compilation and '
              'allocation profiling are separate. Profile constants excluded and collection disabled to '
              'check count-based cleanup. Timed tracing uses its normal collector. No C/Rust parity claim.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({name: {memory: row['enabledOverDisabled'] for memory, row in data['modes'].items()} for name, data in results.items()}, indent=2))


if __name__ == '__main__':
    main()
