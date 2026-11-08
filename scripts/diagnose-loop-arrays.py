#!/usr/bin/env python3
"""Test the borrowed-array callback boundary without changing the compiler."""
import argparse
from collections import Counter
import difflib
import hashlib
import json
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
DECLARATION = re.compile(r'^static V (fwp_borrowed_array\d+\(V \*args\) \{)$', re.M)
ROLES = ('original', 'inline', 'original-copy', 'inline-copy')


def inline_callbacks(source):
    names = re.findall(r'^static[^\n]*\bfwp_borrowed_array\d+\([^\n]*\{', source, re.M)
    matches = DECLARATION.findall(source)
    assert len(names) == len(matches), 'unexpected borrowed-array declaration'
    assert len(set(matches)) == len(matches), 'duplicate borrowed-array definition'
    return DECLARATION.sub(r'static inline __attribute__((always_inline)) V \1', source), len(matches)


def order(round_number):
    offset = round_number % len(ROLES)
    return ROLES[offset:] + ROLES[:offset]


def programs():
    loop = (ROOT / 'bench/loop/main.fwp').read_text()
    assert loop.count('100000000') == 1
    for count in (0, 16, 1000000, 100000000):
        expected = 21 * (count // 7) + sum(3 * i % 7 for i in range(1, count % 7 + 1))
        yield f'loop-{count}', loop.replace('100000000', str(count)), expected, 1, count <= 16
    for count in (0, 16, 65537, 262145):
        source = '''mapped : Array[F64] -> Array[F64]
mapped = fn values ->
    array.generate (array.length values) (fn index ->
        array.get index values | match
            Some value -> value * 3.0 + 1.0
            None -> prim.trap "diagnostic input index")
'''
        source += f'main = array.generate {count} (const 2.0) | mapped | array.fold add -0.0 | echo\n'
        yield f'array-{count}', source, count * 7.0, 1, count <= 16
    for kind, fixture, function in (
        ('manual', 'descent_packed.fwp', 'packed-descend'),
        ('local', 'descent_local_ad.fwp', 'local-descend'),
    ):
        for points, updates in ((3, 0), (3, 1), (3, 199), (33, 199), (129, 199)):
            source = (ROOT / 'tests/fixtures' / fixture).read_text()
            source += f'''
solve : Array[F64] -> Array[F64]
solve = both (const {updates}) id | loop (if
    (.0 | eq 0)
    (.1 | Stop)
    (both (.0 | sub 1) (.1 | {function}) | Again))
'''
            values = ', '.join('-1.2' if i % 2 == 0 else '1.0' for i in range(points))
            source += f'main = [{values}] | array.from-list | solve | array.to-list | echo\n'
            yield f'{kind}-{points}-{updates}', source, None, 32, True


def repeat(source, count):
    assert source.count('main = ') == 1 and count > 0
    if count == 1:
        return source
    definitions, body = source.split('main = ')
    assert body.strip().startswith('[')
    return definitions + f'main = range 0 {count} | each (const ' + body.strip() + ')\n'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('compiler', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('cc', 'c-arch'):
        parser.add_argument('--' + name, required=True)
    for name in ('timeout', 'warmups', 'samples'):
        parser.add_argument('--' + name, type=int, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert (args.timeout, args.warmups, args.samples) == (180, 2, 16)
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[platform.machine()]
    out = args.output.resolve()
    out.mkdir(exist_ok=False, parents=True)
    compiler = args.compiler.resolve()
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_STACK='1', FWP_ARRAY_FUSION='1',
                       FWP_PACKED_ARRAYS='1', FWP_VRET='1', FWP_FRAME_FIELDS='1')
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math',
             '-fno-lto', '-march=' + args.c_arch, '-fstack-usage']
    identity = dict(source=os.environ['GITHUB_SHA'], machine=platform.machine(),
                    cpu=Path('/proc/cpuinfo').read_text(), flags=flags,
                    compilerSha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
                    ccVersion=subprocess.check_output([args.cc, '--version'], text=True),
                    affinity=sorted(os.sched_getaffinity(0)),
                    settings={key: value for key, value in environment.items() if key.startswith('FWP_')})
    (out / 'identity.json').write_text(json.dumps(identity, indent=2) + '\n')

    def run(command, destination, env):
        command = list(map(str, command))
        start = time.perf_counter_ns()
        timed_out = False
        try:
            result = run_capture(command, timeout=args.timeout, cwd=ROOT, env=env,
                                 input_data=None, input_stream=None, text=False,
                                 encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            timed_out = True
            result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
        elapsed = time.perf_counter_ns() - start
        destination.with_suffix('.stdout').write_bytes(result.stdout)
        destination.with_suffix('.stderr').write_bytes(result.stderr)
        with (out / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(dict(command=command, status=result.returncode,
                                     elapsedNs=elapsed, timedOut=timed_out,
                                     output=str(destination.relative_to(out)))) + '\n')
        assert result.returncode == 0 and not timed_out, (command, result.stderr.decode(errors='replace'))
        return result, elapsed

    summary = {}
    for name, source, expected, repetitions, interpret in programs():
        directory = out / name
        directory.mkdir()
        source_path = directory / 'interpreter-input.fwp'
        source_path.write_text(source)
        reference = None
        if interpret:
            raw, _ = run([compiler, 'run', '--interp', source_path], directory / 'interpreter',
                         dict(environment, FWP_NO_OPT='1'))
            assert not raw.stderr
            if expected is not None:
                assert json.loads(raw.stdout) == expected
            reference = raw.stdout * repetitions
        source_path = directory / 'input.fwp'
        source_path.write_text(repeat(source, repetitions))
        code_path = directory / 'original.c'
        run([compiler, 'build', '--emit-c', '-O2', source_path, '-o', code_path],
            directory / 'emit', environment)
        original = code_path.read_text()
        candidate, changed = inline_callbacks(original)
        if name.startswith('loop-'):
            assert changed == 0 and candidate == original
        else:
            assert changed > 0, (name, 'no borrowed callback to diagnose')
        (directory / 'inline.c').write_text(candidate)
        (directory / 'candidate.patch').write_text(''.join(difflib.unified_diff(
            original.splitlines(True), candidate.splitlines(True), fromfile='original.c', tofile='inline.c')))
        binaries = {}
        for role in ROLES[:2]:
            binary = directory / role
            run([args.cc, *flags, '-fopt-info-inline=' + str(directory / (role + '-inlining.txt')),
                 directory / (role + '.c'), '-o', binary, '-lm', '-lpthread', '-ldl'],
                directory / (role + '-build'), environment)
            actual, _ = run([binary], directory / (role + '-check'), environment)
            assert not actual.stderr
            if reference is None:
                assert expected is not None and json.loads(actual.stdout) == expected
                reference = actual.stdout
            assert actual.stdout == reference, (name, role, 'changed output')
            copied = directory / (role + '-copy')
            shutil.copy2(binary, copied)
            binaries[role], binaries[role + '-copy'] = binary, copied
        samples = {role: [] for role in ROLES}
        for round_number in range(-args.warmups, args.samples):
            for role in order(round_number):
                actual, elapsed = run([binaries[role]], directory / f'round-{round_number}-{role}', environment)
                assert actual.stdout == reference and not actual.stderr
                if round_number >= 0:
                    samples[role].append(elapsed)
        medians = {role: statistics.median(values) for role, values in samples.items()}
        copies = {role: max(medians[role], medians[role + '-copy']) /
                  min(medians[role], medians[role + '-copy']) for role in ROLES[:2]}
        summary[name] = dict(medianProcessNs=medians, copyRatios=copies,
                             qualified=all(ratio <= 1.02 for ratio in copies.values()),
                             inlineOverOriginal=medians['inline'] / medians['original'],
                             changedDeclarations=changed,
                             executables={role: hashlib.sha256(path.read_bytes()).hexdigest()
                                          for role, path in binaries.items()})
        (out / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
        print(name, json.dumps(summary[name]), flush=True)
    assert Counter(role for i in range(args.samples) for role in order(i)) == Counter({role: 16 for role in ROLES})


if __name__ == '__main__':
    main()
