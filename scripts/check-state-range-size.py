#!/usr/bin/env python3
"""Compare State range code and stack costs; collect no timing samples."""
import argparse
import base64
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import subprocess

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('buffer_programs', ROOT / 'scripts/prepare-buffer-baselines.py')
PROGRAMS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROGRAMS)
SYMBOL = re.compile(r'(?:[few]|fs|fwp_(?:loop(?:_fields)?|owned_entry|args))\d+(?:\..*)?')
CASES = (-3, 0, 1, 32, 128, 4096)


def worker_symbols(text, entry):
    """Count retained generated functions, including compiler-created clones."""
    symbols = {}
    for line in text.splitlines():
        fields = line.split()
        if len(fields) != 4 or fields[2] not in ('t', 'T'):
            continue
        address, size, _, name = fields
        if not SYMBOL.fullmatch(name):
            continue
        assert name not in symbols and int(size, 16) > 0, line
        symbols[name] = dict(address=int(address, 16), bytes=int(size, 16))
    assert entry in symbols, ('missing entry', entry, symbols)
    # An alias must not make the same instruction range count twice.
    ranges = sorted({(row['address'], row['address'] + row['bytes']) for row in symbols.values()})
    assert all(left[1] <= right[0] for left, right in zip(ranges, ranges[1:])), ranges
    return symbols


def worker_bytes(symbols):
    return sum(size for _, size in {(row['address'], row['bytes']) for row in symbols.values()})


def limits(reference, candidate):
    return dict(code=candidate['workerBytes'] * 100 <= reference['workerBytes'] * 105,
                stack=candidate['largestFrameBytes'] <= reference['largestFrameBytes'] + 64)


def harness(code):
    identifier, = re.findall(r'/\* sum-range : I64 -> I64 \*/\nstatic (?:int64_t w|V f)(\d+)\(', code)
    entry = 'f' + identifier
    assert re.search(r'static V ' + entry + r'\(V l0\) \{', code)
    marker = 'static void *fwp_main_thread(void *arg) {'
    assert code.count(marker) == 1
    code = code.replace(marker, f'static V (*volatile state_range_entry)(V) = {entry};\n' + marker)
    call = '    fwp_exit_code = fwp_exec(&exec_spec0, fwp_argc, fwp_argv);'
    assert code.count(call) == 1
    code = code.replace(call, '''    if (fwp_argc != 2) _Exit(240);
    char *end; errno = 0;
    long long n = strtoll(fwp_argv[1], &end, 10);
    if (errno || *end || end == fwp_argv[1] || n < -3 || n > 4096) _Exit(241);
    V result = state_range_entry((V)(int64_t)n);
    fwp_tasks_finish();
    printf("%lld\\n", (long long)(int64_t)result);''')
    boundary = '    /* Ownership observation point: before runtime teardown. */\n'
    assert code.count(boundary) == 1
    code = code.replace(boundary, boundary + '    if (fwp_heap.live || fwp_cleanups || fwp_state_len || fwp_state_owners) _Exit(239);\n')
    return code, entry


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('compiler', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('cc', 'c-arch', 'nm', 'size'):
        parser.add_argument('--' + name, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    machine = platform.machine()
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[machine]
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    compiler = args.compiler.resolve()
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    env.update(CC=args.cc, FWP_LTO='0', FWP_STACK='1', LC_ALL='C')

    def run(command, environment):
        command = list(map(str, command))
        try:
            result = subprocess.run(command, capture_output=True, env=environment, timeout=180)
        except subprocess.TimeoutExpired as error:
            row = dict(command=command, status=None, timedOut=True,
                       stdout=base64.b64encode(error.stdout or b'').decode(),
                       stderr=base64.b64encode(error.stderr or b'').decode())
        else:
            row = dict(command=command, status=result.returncode, timedOut=False,
                       stdout=base64.b64encode(result.stdout).decode(),
                       stderr=base64.b64encode(result.stderr).decode())
        row['fusion'] = environment.get('FWP_STATE_RANGE_FUSION')
        with (out / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(row) + '\n')
        assert row['status'] == 0 and not row['timedOut'], row
        assert not result.stderr, row
        return result.stdout

    source = out / 'range.fwp'
    source.write_text('export sum-range : I64 -> I64\nsum-range = range 0 | run-state 0 (each (add | modify)) | .1\n')
    report = dict(source=run(['git', 'rev-parse', 'HEAD'], env).decode().strip(),
                  compilerSha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
                  host=platform.uname()._asdict(), cases=CASES,
                  versions={name: run([getattr(args, name), '--version'], env).decode()
                            for name in ('cc', 'nm', 'size')}, programs={})
    assert report['source'] == os.environ['GITHUB_SHA']
    for label, mode in [('reference', '0'), ('candidate', '1')]:
        environment = dict(env, FWP_STATE_RANGE_FUSION=mode)
        folder = out / label
        folder.mkdir()
        original = folder / 'original.c'
        assert not run([compiler, 'build', '--fn', 'sum-range', '--memory', 'dynamic',
                        '--emit-c', '-O2', source, '-o', original], environment)
        code, entry = harness(original.read_text())
        assert ('/* range-state-consumer :' in code) == (mode == '1')
        generated = folder / 'range.c'
        generated.write_text(code)
        binary = folder / 'range'
        command = [args.cc, '-std=gnu11', '-O2', '-ffp-contract=off', '-fno-fast-math',
                   '-fno-lto', '-fstack-usage', '-march=' + args.c_arch, '-w', generated,
                   '-o', binary, '-lm', '-lpthread', '-ldl']
        assert not run(command, environment)
        image = binary.read_bytes()
        assert image[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(image[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[machine]
        for n in CASES:
            expected = f'{max(n, 0) * (max(n, 0) - 1) // 2}\n'.encode()
            call = [compiler, 'exec', '--interp', source, 'sum-range', str(n)]
            assert run(call, dict(environment, FWP_NO_OPT='1')) == expected
            assert run(call, environment) == expected
            assert run([binary, str(n)], environment) == expected
        symbol_text = run([args.nm, '-S', '--defined-only', binary], environment).decode()
        (folder / 'symbols.txt').write_text(symbol_text)
        symbols = worker_symbols(symbol_text, entry)
        section_text = run([args.size, '-A', '-d', binary], environment).decode()
        (folder / 'sections.txt').write_text(section_text)
        usage, = folder.glob('*.su')
        frames = PROGRAMS.c_frames(usage.read_text())
        report['programs'][label] = dict(binarySha256=hashlib.sha256(image).hexdigest(),
            binaryBytes=len(image), generatedSha256=hashlib.sha256(code.encode()).hexdigest(),
            entry=entry, symbols=symbols, workerBytes=worker_bytes(symbols),
            sections=PROGRAMS.sections(section_text), frames=frames,
            largestFrameBytes=max(row['bytes'] for row in frames), command=list(map(str, command)))
    report['acceptance'] = limits(report['programs']['reference'], report['programs']['candidate'])
    report['scope'] = ('Same source/compiler with State range fusion explicitly disabled/enabled. '
        'Worker bytes count retained f/w/e/fs and numbered loop/owned-entry/argument helpers, '
        'including GCC clones and inlined runtime work; shared runtime functions are excluded. '
        'All .text bytes are also reported. Stack is the largest compiler-reported component '
        'in the translation unit, not a total stack bound. Ordinary startup and cleanup remain; '
        'a volatile entry pointer prevents constant folding. No elapsed-time or C/Rust claim.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    for label, row in report['programs'].items():
        print(label, 'worker bytes', row['workerBytes'], 'all text', row['sections']['.text'],
              'largest frame', row['largestFrameBytes'])
    assert all(report['acceptance'].values()), report['acceptance']
    print('Both allocation strategies agree; code <= 105% and frame growth <= 64 bytes')


if __name__ == '__main__':
    main()
