#!/usr/bin/env python3
"""Inspect current array construction paths and exact results; no timing claims."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import struct
import subprocess

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
COUNTS = (0, 1, 19, 33, 65537, 262145)
PROGRAM = ROOT / 'tests/fixtures/array_construction_costs.fwp'
PROBE = ROOT / 'tests/fixtures/array_construction_costs_probe.c'


def replace_once(source, before, after):
    assert source.count(before) == 1, ('changed construction boundary', before)
    return source.replace(before, after)


def result_bits(count, round_number):
    total = -0.0
    for index in range(count):
        mapped = (((index + round_number) % 19 - 9) / 4.0) * 3.0
        total = (mapped + 1.0) + total
    return struct.pack('>d', total).hex()


def entry(source, name):
    marker = '/* ' + name + ' :'
    assert source.count(marker) == 1, name
    match = re.search(r'static V (f\d+)\(', source.split(marker)[1])
    assert match, name
    return match[1]


def probe_source(generated, profile, probe):
    source = replace_once(generated, 'typedef uint64_t V;',
        'typedef uint64_t V;\nstatic uint64_t construction_calls, construction_bytes, construction_retains;')
    if profile:
        for before, after in (
            ('static inline void *fwp_heap_alloc(size_t n, int kind) {',
             'static inline void *fwp_heap_alloc(size_t n, int kind) {\nif(kind!=0){construction_calls++;construction_bytes+=n;}'),
            ('static inline void *fwp_alloc_init(size_t n) {',
             'static inline void *fwp_alloc_init(size_t n) {\nconstruction_calls++;construction_bytes+=n;'),
            ('static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {',
             'static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {\nconstruction_retains++;'),
        ):
            source = replace_once(source, before, after)
    source = replace_once(source, 'int main(int argc, char **argv)',
                          'int original_main(int argc, char **argv)')
    harness = probe
    for marker, name in (('MAKE', 'make-input'), ('REDUCE', 'reduce64'), ('WORK', 'work')):
        harness = harness.replace('fCONSTRUCTION_' + marker, entry(generated, name))
    return source + '\n' + harness


def check_output(raw, profile):
    data = json.loads(raw)
    assert set(data) == {'cases'}
    expected_order = [(count, round_number, role) for count in COUNTS
                      for round_number in range(8) for role in range(3)]
    assert [(r['count'], r['round'], r['role']) for r in data['cases']] == expected_order
    expected_bits = {(count, r): result_bits(count, r) for count in COUNTS for r in range(8)}
    for row in data['cases']:
        assert row['resultBits'] == expected_bits[row['count'], row['round']]
        assert row['finalLiveBytes'] == 0
        for field in ('requests', 'requestedBytes', 'retains'):
            assert type(row[field]) is int and row[field] >= 0
        if not profile:
            assert row['requests'] == row['requestedBytes'] == row['retains'] == 0
        elif row['role'] == 0:
            assert (row['requests'], row['requestedBytes'], row['retains']) == (1, 8 + row['count'] * 8, 0)
    return data


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('compiler', 'cc', 'c-arch', 'objdump', 'nm'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--timeout', type=int, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[platform.machine()]
    assert args.timeout == 180
    assert os.environ['CARGO_PROFILE_DEV_OPT_LEVEL'] == '1'
    assert os.environ['CARGO_PROFILE_DEV_DEBUG_ASSERTIONS'] == os.environ['CARGO_PROFILE_DEV_OVERFLOW_CHECKS'] == 'true'
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    env = dict(os.environ, FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0')
    env.pop('FWP_NO_OPT', None)
    env.pop('FWP_NO_REUSE', None)
    compiler = Path(args.compiler).resolve()
    source_id = subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip()
    assert source_id == os.environ['GITHUB_SHA']
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], check=True)
    record = dict(source=source_id, machine=platform.machine(), cpu=Path('/proc/cpuinfo').read_text(),
                  configuration=vars(args) | {'output': str(out)},
                  compilerSha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
                  executionEnvironment={k: v for k, v in env.items() if k.startswith('FWP_')},
                  sourceHashes={str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest()
                                for p in (PROGRAM, PROBE, Path(__file__).resolve())}, results={})

    def run(command, name, status):
        command = list(map(str, command))
        try:
            result = run_capture(command, timeout=args.timeout, env=env, cwd=ROOT, input_data=None,
                                 input_stream=None, text=False, encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            (out / (name + '.stdout')).write_bytes(error.stdout or b'')
            (out / (name + '.stderr')).write_bytes(error.stderr or b'')
            raise
        (out / (name + '.stdout')).write_bytes(result.stdout)
        (out / (name + '.stderr')).write_bytes(result.stderr)
        with (out / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(dict(command=command, status=result.returncode, observation=name)) + '\n')
        assert result.returncode == status, (command, result.returncode, result.stderr.decode())
        return result

    for tool, command in (('cVersion', [args.cc, '--version']), ('rustVersion', ['rustc', '--version'])):
        record[tool] = run(command, tool, 0).stdout.decode()
    # The interpreter checks small source cases without constructing a native cache.
    for count in COUNTS[:4]:
        for round_number in (0, 7):
            for function in ('make-input', 'work'):
                r = run([compiler, 'exec', '--interp', PROGRAM, function, round_number, count],
                        f'interpreter-{function}-{count}-{round_number}', 0)
                assert not r.stderr
                raw = r.stdout
                if function == 'make-input':
                    assert raw.startswith(b'array[')
                    raw = raw[len(b'array'):]
                values = json.loads(raw)
                if function == 'make-input':
                    assert values == [((i + round_number) % 19 - 9) / 4.0 for i in range(count)]
                else:
                    assert struct.pack('>d', values).hex() == result_bits(count, round_number)
    emitted = out / 'generated.c'
    r = run([compiler, 'build', '--memory', 'dynamic', '--fn', 'work', '--emit-c', PROGRAM, '-o', emitted], 'emit', 0)
    assert not r.stderr
    generated = emitted.read_text()
    for opt in ('O1', 'O2'):
        for profile in (False, True):
            label = opt + ('-profile' if profile else '-ordinary')
            cfile, binary = out / (label + '.c'), out / (label + '.exe')
            cfile.write_text(probe_source(generated, profile, PROBE.read_text()))
            command = [args.cc, '-' + opt, '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch,
                       '-w', '-fstack-usage', '-fopt-info-vec-all=' + str(out / (label + '.vec')),
                       '-fdump-tree-optimized=' + str(out / (label + '.optimized')),
                       cfile, '-o', binary, '-lm', '-lpthread']
            assert not run(command, label + '-build', 0).stderr
            r = run([binary], label + '-run', 0)
            assert not r.stderr
            record['results'][label] = check_output(r.stdout, profile)
            for tool, command in (('sections', [args.objdump, '-h', binary]), ('symbols', [args.nm, binary])):
                result = run(command, label + '-' + tool, 0)
                assert not result.stderr
                if tool == 'symbols':
                    assert not any(s in result.stdout for s in (b'fwp_heap_scan', b'fwp_heap_mark_all', b'fwp_heap_sweep'))
            if profile:
                control = out / (label + '-missing-release.c')
                control.write_text(replace_once(cfile.read_text(),
                    'fwp_rc_free_arr(leftover); /* construction-final-release control */',
                    '/* deliberately omit the final constructed-array release */'))
                control_binary = control.with_suffix('.exe')
                assert not run([args.cc, '-' + opt, '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch,
                    '-w', control, '-o', control_binary, '-lm', '-lpthread'], label + '-control-build', 0).stderr
                r = run([control_binary], label + '-control-run', 219)
                assert r.stderr == b'construction result retained before exit\n'
    record['files'] = {p.name: dict(bytes=p.stat().st_size, sha256=hashlib.sha256(p.read_bytes()).hexdigest())
                       for p in sorted(out.iterdir()) if p.is_file()}
    (out / 'report.json').write_text(json.dumps(record, indent=2) + '\n')
    print('Construction, composed results, storage and missing-release controls pass; no timing claim')


if __name__ == '__main__':
    main()
