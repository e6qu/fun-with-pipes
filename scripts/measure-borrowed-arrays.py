#!/usr/bin/env python3
"""Compare borrowed-array metadata with its isolated reference on native runners."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import shutil
import statistics
import struct
import subprocess
import time

from borrowed_array_reference import reference_source
from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
ROLES = ('candidate', 'reference', 'candidate-copy', 'reference-copy')


def order(round_number):
    position = round_number % len(ROLES)
    return ROLES[position:] + ROLES[:position]


def programs():
    loop = (ROOT / 'bench/loop/main.fwp').read_text().split('main = ')[0]
    loop += 'export measure : I64 -> I64\nmeasure = fn count -> (count, 0) | loop step\n'
    for count, repeats in ((0, 4096), (16, 4096), (1000000, 16), (100000000, 1)):
        expected = 21 * (count // 7) + sum(3 * i % 7 for i in range(1, count % 7 + 1))
        yield dict(name=f'loop-{count}', source=loop, count=count, repeats=repeats,
                   input=str(count), expected=[expected], kind='loop', updates=0)
    array = '''mapped : Array[F64] -> Array[F64]
mapped = fn values ->
    array.generate (array.length values) (fn index ->
        array.get index values | match
            Some value -> value * 3.0 + 1.0
            None -> prim.trap "measurement input index")
export measure : Array[F64] -> F64
measure = mapped | array.fold add -0.0
'''
    for count, repeats in ((0, 4096), (16, 4096), (65537, 16), (262145, 4)):
        # Empty folding preserves its negative-zero initializer.
        expected = -0.0 if count == 0 else count * 7.0
        yield dict(name=f'array-{count}', source=array, count=count, repeats=repeats,
                   input=f'array.generate {count} (const 2.0)', expected=[expected], kind='array', updates=0)
    for kind, fixture, function in (
        ('manual', 'descent_packed.fwp', 'packed-descend'),
        ('local', 'descent_local_ad.fwp', 'local-descend'),
    ):
        for count, updates, repeats in ((3, 0, 4096), (3, 1, 1024), (3, 199, 32),
                                        (33, 199, 32), (129, 199, 8)):
            source = (ROOT / 'tests/fixtures' / fixture).read_text()
            source += f'''
export measure : Array[F64] -> Array[F64]
measure = both (const {updates}) id | loop (if
    (.0 | eq 0)
    (.1 | Stop)
    (both (.0 | sub 1) (.1 | {function}) | Again))
'''
            values = ', '.join('-1.2' if i % 2 == 0 else '1.0' for i in range(count))
            yield dict(name=f'{kind}-{count}-{updates}', source=source, count=count,
                       repeats=repeats, input=f'[{values}] | array.from-list',
                       expected=None, kind=kind, updates=updates)


def words(values, integer):
    return values if integer else [struct.unpack('>Q', struct.pack('>d', value))[0] for value in values]


def driver(generated, case, expected):
    marker = '/* measure :'
    assert generated.count(marker) == 1
    entry = re.search(r'static V (f\d+)\(', generated.split(marker)[1])
    assert entry
    main = 'int main(int argc, char **argv)'
    assert generated.count(main) == 1
    source = generated.replace(main, 'int original_main(int argc, char **argv)')
    harness = (ROOT / 'tests/fixtures/borrowed_array_timing.c').read_text()
    substitutions = dict(INPUT_COUNT=str(case['count']), REPEAT_COUNT=str(case['repeats']),
        INPUT_LOOP=str(int(case['kind'] == 'loop')),
        OUTPUT_ARRAY=str(int(case['kind'] in ('manual', 'local'))),
        INPUT_VALUE='2.0' if case['kind'] == 'array' else '(index % 2 == 0 ? -1.2 : 1.0)',
        EXPECTED_WORDS=', '.join(f'UINT64_C({value})' for value in words(expected, case['kind'] == 'loop')),
        MEASURE_ENTRY=entry[1])
    for name, value in substitutions.items():
        assert name in harness, name
        harness = harness.replace(name, value)
    return source + '\n' + harness


def summarize(observations):
    measured = [row for row in observations if row['round'] >= 0]
    assert [(row['round'], row['role']) for row in measured] == [
        (number, role) for number in range(24) for role in order(number)]
    for row in observations:
        assert type(row['round']) is int and row['role'] in ROLES
        assert all(type(row[key]) is int and row[key] > 0 for key in
                   ('constructionNs', 'computationNs', 'releaseNs', 'loopNs', 'processNs'))
        assert row['constructionNs'] + row['computationNs'] + row['releaseNs'] <= row['loopNs']
    samples = {role: [row for row in observations if row['round'] >= 0 and row['role'] == role]
               for role in ROLES}
    assert all(len(rows) == 24 for rows in samples.values())
    medians = {metric: {role: statistics.median(row[metric] for row in rows)
                       for role, rows in samples.items()}
               for metric in ('constructionNs', 'computationNs', 'releaseNs', 'loopNs', 'processNs')}
    copy_ratios = {metric: {role: max(values[role], values[role + '-copy']) /
                           min(values[role], values[role + '-copy'])
                           for role in ROLES[:2]} for metric, values in medians.items()}
    return dict(medians=medians, copyRatios=copy_ratios,
                ratios={metric: values['candidate'] / values['reference'] for metric, values in medians.items()},
                computationQualified=all(value <= 1.02 for value in copy_ratios['computationNs'].values()),
                processQualified=all(value <= 1.02 for value in copy_ratios['processNs'].values()))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('compiler', 'reference', 'reference-manifest', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('cc', 'c-arch'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--session', type=int, choices=(1, 2), required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[platform.machine()]
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=ROOT, check=True)
    source_id = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    manifest = json.loads(args.reference_manifest.read_text())
    candidate = (ROOT / 'src/cgen.rs').read_text()
    assert manifest['source'] == source_id
    assert manifest['candidateSha256'] == hashlib.sha256(candidate.encode()).hexdigest()
    assert manifest['referenceSha256'] == hashlib.sha256(reference_source(candidate).encode()).hexdigest()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_STACK='1', FWP_ARRAY_FUSION='1',
                       FWP_PACKED_ARRAYS='1', FWP_VRET='1', FWP_FRAME_FIELDS='1')
    compilers = dict(candidate=args.compiler.resolve(), reference=args.reference.resolve())
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fno-lto',
             '-march=' + args.c_arch, '-fstack-usage']
    identity = dict(source=source_id, session=args.session, machine=platform.machine(),
                    cpu=Path('/proc/cpuinfo').read_text(), affinity=sorted(os.sched_getaffinity(0)),
                    flags=flags, ccVersion=subprocess.check_output([args.cc, '--version'], text=True),
                    compilerHashes={role: hashlib.sha256(path.read_bytes()).hexdigest() for role, path in compilers.items()},
                    reference=manifest,
                    settings={key: value for key, value in environment.items() if key.startswith('FWP_')})
    (output / 'identity.json').write_text(json.dumps(identity, indent=2) + '\n')

    def run(command, destination, env):
        command = list(map(str, command))
        start = time.perf_counter_ns()
        timed_out = False
        try:
            result = run_capture(command, timeout=180, cwd=ROOT, env=env, input_data=None,
                                 input_stream=None, text=False, encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            timed_out = True
            result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
        elapsed = time.perf_counter_ns() - start
        destination.with_suffix('.stdout').write_bytes(result.stdout)
        destination.with_suffix('.stderr').write_bytes(result.stderr)
        with (output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(dict(command=command, status=result.returncode, elapsedNs=elapsed,
                                     timedOut=timed_out, output=str(destination.relative_to(output)))) + '\n')
        assert result.returncode == 0 and not timed_out and not result.stderr, (command, result.stderr.decode(errors='replace'))
        return result.stdout, elapsed

    summary = {}
    for case in programs():
        directory = output / case['name']
        directory.mkdir()
        program = directory / 'program.fwp'
        program.write_text(case['source'])
        expected = case['expected']
        if expected is None or case['count'] <= 16:
            raw_source = directory / 'interpreter.fwp'
            conversion = ' | array.to-list' if case['kind'] in ('manual', 'local') else ''
            raw_source.write_text(case['source'] + f"main = ({case['input']}) | measure{conversion} | echo\n")
            raw, _ = run([compilers['candidate'], 'run', '--interp', raw_source],
                         directory / 'interpreter-check', dict(environment, FWP_NO_OPT='1'))
            values = json.loads(raw)
            values = values if isinstance(values, list) else [values]
            if expected is not None:
                assert words(values, case['kind'] == 'loop') == words(expected, case['kind'] == 'loop')
            expected = values
        (directory / 'case.json').write_text(json.dumps(case | dict(expected=expected), indent=2) + '\n')
        binaries, generated = {}, {}
        for role, compiler in compilers.items():
            emitted = directory / (role + '-generated.c')
            run([compiler, 'build', '--fn', 'measure', '--emit-c', '-O2', program, '-o', emitted],
                directory / (role + '-emit'), environment)
            generated[role] = emitted.read_text()
            code = driver(generated[role], case, expected)
            cfile = directory / (role + '.c')
            cfile.write_text(code)
            binary = directory / role
            run([args.cc, *flags, cfile, '-o', binary, '-lm', '-lpthread', '-ldl'],
                directory / (role + '-build'), environment)
            raw, _ = run([binary], directory / (role + '-check'), environment)
            check = json.loads(raw)
            assert check['initialLiveBytes'] == check['finalLiveBytes']
            copied = directory / (role + '-copy')
            shutil.copy2(binary, copied)
            binaries[role], binaries[role + '-copy'] = binary, copied
        if case['kind'] == 'loop':
            assert generated['candidate'] == generated['reference'], 'unchanged loop differs'
        elif case['updates'] > 0 or case['kind'] == 'array':
            assert re.search(r'static V fwp_borrowed_array\d+\(V \*args, const unsigned char', generated['candidate'])
            assert not re.search(r'static V fwp_borrowed_array\d+\(V \*args, const unsigned char', generated['reference'])
        rows = []
        for number in range(-2, 24):
            for role in order(number):
                raw, elapsed = run([binaries[role]], directory / f'round-{number}-{role}', environment)
                row = json.loads(raw)
                assert row['initialLiveBytes'] == row['finalLiveBytes']
                assert all(type(row[key]) is int and row[key] > 0 for key in
                           ('constructionNs', 'computationNs', 'releaseNs', 'loopNs'))
                assert row['constructionNs'] + row['computationNs'] + row['releaseNs'] <= row['loopNs']
                rows.append(row | dict(round=number, role=role, processNs=elapsed))
                with (directory / 'samples.jsonl').open('a') as log:
                    log.write(json.dumps(rows[-1]) + '\n')
        summary[case['name']] = summarize(rows)
        summary[case['name']]['binaryHashes'] = {role: hashlib.sha256(path.read_bytes()).hexdigest() for role, path in binaries.items()}
        (output / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
        print(case['name'], json.dumps(summary[case['name']]), flush=True)


if __name__ == '__main__':
    main()
