#!/usr/bin/env python3
"""Compare ordinary decimal-count algorithms with fixed CPU acceptance limits."""
import argparse
import hashlib
import importlib.util
import json
import math
import os
from pathlib import Path
import re
import statistics
import struct
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('cpu_phases', ROOT / 'scripts/cpu-phases.py')
CPU = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CPU)
ALGORITHMS = {
    'bit-length': 'a bit-length estimate and table',
    'threshold-tree': 'exact decimal-threshold comparisons',
}
BASELINE = 'c92fed4208a16627f0f420f58ce1f7729bf0f061'
KINDS = ('c', 'rs', 'baseline', 'candidate', 'identical')
COUNTING_PROGRAMS = ('strings', 'text-length')
SETTINGS = dict(samples=60, warmups=2, processes={'loop': 1, 'text-length': 32}, timeout=120, cpuPolicy='all')


def helper(source):
    begin = source.index('static inline int64_t fwp_u64_chars(')
    end = source.index('\nstatic inline int64_t fwp_i64_chars(', begin)
    return source[begin:end]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write(path, data):
    path.write_text(json.dumps(data, indent=2, allow_nan=False) + '\n')


def check_case(name, row, budget, algorithm):
    description = ALGORITHMS[algorithm]
    assert row['stdout'] == CPU.EXPECTED[name] and set(row['binaries']) == set(KINDS)
    assert row['binaries']['baseline'] == row['binaries']['identical']
    for binary in row['binaries'].values():
        assert re.fullmatch('[0-9a-f]{64}', binary['sha256']) and binary['bytes'] > 0
    observations = row['observations']
    assert len(observations) == len(KINDS) * (SETTINGS['samples'] + SETTINGS['warmups'])
    times = {kind: [] for kind in KINDS}
    for index, observation in enumerate(observations):
        round_index, position = divmod(index, len(KINDS))
        warmup = round_index < SETTINGS['warmups']
        number = round_index if warmup else round_index - SETTINGS['warmups']
        kind = KINDS[(number + position) % len(KINDS)]
        assert (observation['kind'], observation['phase'], observation['round']) == (kind, 'warmup' if warmup else 'sample', number)
        assert observation['binarySha256'] == row['binaries'][kind]['sha256']
        assert len(observation['processes']) == SETTINGS['processes'][name]
        for process in observation['processes']:
            assert process['status'] == 0 and not process['stderr'] and process['stdout'] == row['stdout']
            assert math.isfinite(process['seconds']) and process['seconds'] > 0
        assert observation['seconds'] == sum(p['seconds'] for p in observation['processes'])
        if not warmup:
            times[kind].append(observation['seconds'])
    medians = {kind: statistics.median(values) for kind, values in times.items()}
    control = max(medians['baseline'], medians['identical']) / min(medians['baseline'], medians['identical'])
    pairs = sorted(max(a, b) / min(a, b) for a, b in zip(times['baseline'], times['identical'], strict=True))
    spread = pairs[math.ceil(0.95 * SETTINGS['samples']) - 1]
    stable = control <= 1.03 and spread <= budget['maxControlPairRatio']
    ratio = medians['candidate'] / medians['baseline']
    return dict(medianBatchSeconds=medians, controlRatio=control, pairRatio95=spread,
                control='stable' if stable else 'inconclusive', candidateOverBaseline=ratio,
                withinRegression=stable and ratio <= budget['maxCandidateRatio'],
                improvement=stable and ratio < budget['maxRatioForImprovement'],
                candidateOverC=medians['candidate'] / medians['c'], candidateOverRust=medians['candidate'] / medians['rs'],
                peerScope=f'C/Rust retain grouped decimal division; candidate fwp uses {description}. These are whole-program comparisons with an algorithm difference, not pure compiler overhead.')


def sections(path, architecture):
    data = path.read_bytes()
    assert data[:6] == b'\x7fELF\x02\x01' and struct.unpack_from('<H', data, 18)[0] == {'aarch64': 183, 'x86_64': 62}[architecture]
    assert struct.unpack_from('<Q', data, 24)[0]
    offset = struct.unpack_from('<Q', data, 40)[0]
    size, count, name_index = struct.unpack_from('<HHH', data, 58)
    records = [struct.unpack_from('<IIQQQQIIQQ', data, offset + i * size) for i in range(count)]
    names = records[name_index]
    strings = data[names[4]:names[4] + names[5]]
    return {strings[r[0]:].split(b'\0', 1)[0].decode(): (r[3], data[r[4]:r[4] + r[5]]) for r in records if r[1] != 8}


def measure(args):
    report = CPU.qualification(args)
    assert report == json.loads(args.qualification.read_text())
    budgets = CPU.BOUNDS.qualify(json.loads(args.table.read_text()), report['host'], report['compilers'], report['inputs'])
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    old_runtime = subprocess.check_output(['git', 'show', BASELINE + ':runtime/fwp_rt_ops.c'], cwd=ROOT, text=True)
    new_runtime = (ROOT / 'runtime/fwp_rt_ops.c').read_text()
    old, new = helper(old_runtime), helper(new_runtime)
    assert old != new and new_runtime.replace(new, old) == old_runtime, 'isolate only the digit-count algorithm'
    inspection = json.loads(args.inspection.read_text())
    memory = json.loads((args.memory / 'report.json').read_text())
    memory_images = json.loads(args.memory_inspection.read_text())
    assert all(r['source'] == args.source and r['architecture'] == args.architecture for r in (inspection, memory, memory_images))
    assert memory['inspectionSha256'] == digest(args.inspection) and memory_images['reportSha256'] == digest(args.memory / 'report.json')
    directory, = (args.input / args.source).iterdir()
    assert digest(directory / 'report.md') == inspection['reportSha256']
    report.update(algorithm='threshold-tree', baseline=BASELINE, settings=SETTINGS, programs={}, context={}, commands=[],
                  oldHelper=old, newHelper=new, evidence=dict(inspection=digest(args.inspection), memory=digest(args.memory / 'report.json'), memoryInspection=digest(args.memory_inspection)),
                  scope='Only the decimal-count helper differs between paired generated-C images. Baseline uses the original helper in the current runtime, with no previous fwp executable dependency. Timings are ordinary process wall time; compilation, profiles and evidence writes are excluded. Candidate C is the actual compiler output. C/Rust peers retain their existing grouped-division algorithm.')
    environment = {k: v for k, v in os.environ.items() if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(FWP_LTO='0', LC_ALL='C')

    def command(argv, label):
        argv = list(map(str, argv))
        result = subprocess.run(argv, env=environment, capture_output=True, timeout=120)
        (args.output / (label + '.stdout')).write_bytes(result.stdout)
        (args.output / (label + '.stderr')).write_bytes(result.stderr)
        report['commands'].append(dict(argv=argv, status=result.returncode, stdout=label + '.stdout', stderr=label + '.stderr'))
        write(args.output / 'report.json', report)
        assert result.returncode == 0, (argv, result.stderr)
        return result

    paths_by_name = {}
    for original in inspection['programs']:
        name = original['name']
        generated = directory / (name + '-generated.c')
        assert digest(generated) == original['generatedCSha256']
        code = generated.read_text()
        assert helper(code) == new and code.count(new) == 1
        mem, = [p for p in memory['programs'] if p['name'] == name]
        paths = {language: (directory / (name + '-' + language)).resolve() for language in ('c', 'rs')}
        context = dict(stdout=original['stdout'], costs={}, samples={}, ordinaryMemory=mem)
        report['context'][name] = context
        for variant, source in [('baseline', code.replace(new, old)), ('candidate', code)]:
            cfile = args.output / (name + '-' + variant + '.c')
            binary = cfile.with_suffix('.exe')
            cfile.write_text(source)
            command([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-fstack-usage', '-w', cfile, '-o', binary, '-lm', '-lpthread'], name + '-' + variant + '-compile')
            actual_sections = sections(binary, args.architecture)
            if variant == 'candidate':
                ordinary = directory / (name + '-fwp')
                assert digest(ordinary) == original['files']['fwp']['binarySha256']
                assert actual_sections['.text'][1] == sections(ordinary, args.architecture)['.text'][1], 'same compiler-emitted C changed machine text when requesting a stack report'
            symbols = command([args.objdump, '--section-headers', '--syms', binary], name + '-' + variant + '-symbols').stdout.decode()
            command([args.objdump, '-d', binary], name + '-' + variant + '-assembly')
            assert not re.search(r'\bdecimal_powers', symbols), 'threshold tree must not retain the rejected lookup table'
            stack, = args.output.glob(name + '-' + variant + '*.su')
            context['costs'][variant] = dict(binarySha256=digest(binary), binaryBytes=binary.stat().st_size,
                                            generatedSha256=digest(cfile), textBytes=len(actual_sections['.text'][1]),
                                            textSha256=hashlib.sha256(actual_sections['.text'][1]).hexdigest(), stack=stack.read_text(), table=None,
                                            rodataBytes=len(actual_sections['.rodata'][1]), rodataSha256=hashlib.sha256(actual_sections['.rodata'][1]).hexdigest())
            paths[variant] = binary
        paths['identical'] = paths['baseline']
        paths_by_name[name] = paths
        # Preserve the other five programs as regression context. Except for
        # strings, their helper is unused: require identical machine text.
        if name not in CPU.PROGRAMS:
            if name != 'strings':
                assert context['costs']['baseline']['textSha256'] == context['costs']['candidate']['textSha256'], name
            for variant in ('baseline', 'candidate'):
                result = command([paths[variant]], name + '-' + variant + '-output')
                assert result.stdout.decode() == original['stdout'] and not result.stderr
    # The strings benchmark has the same optimized fwp calculation, while
    # its C/Rust peers still build strings. Prove both fwp images share the
    # measured instruction section instead of mislabelling those peer costs.
    for variant in ('baseline', 'candidate'):
        assert report['context']['strings']['costs'][variant]['textSha256'] == report['context']['text-length']['costs'][variant]['textSha256']
    for name in CPU.PROGRAMS:
        paths = paths_by_name[name]
        row = dict(stdout=CPU.EXPECTED[name], binaries={kind: dict(sha256=digest(paths[kind]), bytes=paths[kind].stat().st_size) for kind in KINDS}, observations=[])
        report['programs'][name] = row
        for phase, rounds in [('warmup', SETTINGS['warmups']), ('sample', SETTINGS['samples'])]:
            for number in range(rounds):
                for position in range(len(KINDS)):
                    kind = KINDS[(number + position) % len(KINDS)]
                    observation = dict(kind=kind, phase=phase, round=number, binarySha256=row['binaries'][kind]['sha256'], processes=[], seconds=0)
                    row['observations'].append(observation)
                    for process_index in range(SETTINGS['processes'][name]):
                        start = time.perf_counter()
                        try:
                            result = subprocess.run([str(paths[kind])], env=environment, capture_output=True, text=True, timeout=SETTINGS['timeout'])
                        except subprocess.TimeoutExpired:
                            write(args.output / 'report.json', report)
                            raise
                        seconds = time.perf_counter() - start
                        process = dict(seconds=seconds, status=result.returncode, stdout=result.stdout, stderr=result.stderr)
                        observation['processes'].append(process)
                        observation['seconds'] += seconds
                        if result.returncode or result.stderr or result.stdout != row['stdout']:
                            write(args.output / 'report.json', report)
                            raise AssertionError((name, kind, phase, number, process_index, process))
                    write(args.output / 'report.json', report)
        row['result'] = check_case(name, row, budgets[name], report['algorithm'])
        write(args.output / 'report.json', report)
        print(name, json.dumps(row['result'], indent=2), flush=True)
    report['qualifies'] = all(r['result']['withinRegression'] for r in report['programs'].values()) and report['programs']['text-length']['result']['improvement']
    write(args.output / 'report.json', report)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('input', 'inspection', 'memory', 'memory-inspection', 'qualification', 'table', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--architecture', choices=['aarch64', 'x86_64'], required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    parser.add_argument('--objdump', required=True)
    measure(parser.parse_args())


if __name__ == '__main__':
    main()
