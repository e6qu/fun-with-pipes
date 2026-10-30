#!/usr/bin/env python3
"""Cross-check the repeated-call harness against raw and optimized fwp results."""
import argparse
import base64
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parent.parent


def harness(code, entry, peer):
    """Change only the executable's CLI call, preserving runtime startup/cleanup."""
    assert entry in ('unique', 'callback')
    match, = re.findall(r'/\* ' + entry + r' : I64 -> I64 \*/\nstatic (?:int64_t w|V f)(\d+)\(', code)
    assert re.search(r'static V f' + match + r'\(V l0\) \{', code)
    start = code.index(f'/* {entry} : I64 -> I64 */')
    end = code.index('\n}', start) + 2
    assert code[start:end].count('/* proved unique I64 array: no reference-count metadata */') == 1
    # Use the same CLI parsing, barriers, checks and checksum loop as the C peer.
    # Remove its buffer implementation; call the actual generated fwp entry.
    start = peer.index('static int64_t read_buffer(')
    end = peer.index('int main(int argc, char **argv) {', start)
    helper = peer[:start] + peer[end:]
    helper = helper.replace('int main(int argc, char **argv) {',
        'static void buffer_benchmark(void) {\n    int argc=fwp_argc; char **argv=fwp_argv;')
    call = 'int64_t result = work(input, callback);'
    assert helper.count(call) == 1
    helper = helper.replace(call, f'int64_t result = (int64_t)f{match}((V)input);')
    selection = '    int callback = strcmp(argv[1], "callback") == 0;'
    assert helper.count(selection) == 1
    helper = helper.replace(selection, f'    if (strcmp(argv[1], "{entry}")) fail("invalid entry", 2);\n' + selection)
    assert helper.count('    return 0;') == 1
    helper = helper.replace('    return 0;', '    return;')
    original = '    fwp_exit_code = fwp_exec(&exec_spec0, fwp_argc, fwp_argv);'
    assert code.count(original) == 1
    result = code.replace(original, '    buffer_benchmark();')
    marker = 'static void *fwp_main_thread(void *arg) {'
    assert result.count(marker) == 1
    return result.replace(marker, helper + '\n' + marker)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--case', type=int, action='append', required=True)
    parser.add_argument('--timeout', type=int, required=True)
    args = parser.parse_args()
    assert args.cc and args.timeout > 0
    assert len(set(args.case)) == len(args.case)
    assert all(-9223372036854775808 <= n <= 262144 for n in args.case)
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    compiler = args.compiler.resolve()
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_STACK='1', LC_ALL='C')
    source = output / 'buffer.fwp'
    source.write_bytes((ROOT / 'tests/fixtures/unique_buffer_costs.fwp').read_bytes())
    peer = (ROOT / 'tests/fixtures/unique_buffer_peer.c').read_text()
    sequence = 0

    def run(command, env):
        nonlocal sequence
        command = list(map(str, command))
        try:
            result = subprocess.run(command, capture_output=True, timeout=args.timeout, env=env)
        except subprocess.TimeoutExpired as error:
            row = dict(command=command, status=None, timedOut=True,
                       stdout=base64.b64encode(error.stdout or b'').decode(),
                       stderr=base64.b64encode(error.stderr or b'').decode())
        else:
            row = dict(command=command, status=result.returncode, timedOut=False,
                       stdout=base64.b64encode(result.stdout).decode(),
                       stderr=base64.b64encode(result.stderr).decode())
        row['sequence'] = sequence
        sequence += 1
        with (output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(row) + '\n')
        assert row['status'] == 0 and not row['timedOut'], row
        assert result.stderr == b'', row
        return result.stdout

    report = dict(source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
                  compilerSha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
                  cc=run([args.cc, '--version'], environment).decode(), cases=args.case,
                  scope='Correctness only. No performance samples collected.', entries={})
    for entry in ['unique', 'callback']:
        original = output / f'{entry}-original.c'
        assert run([compiler, 'build', '--fn', entry, '--memory', 'dynamic', '--emit-c', '-O2',
                    source, '-o', original], environment) == b''
        code = harness(original.read_text(), entry, peer)
        generated = output / f'{entry}-harness.c'
        generated.write_text(code)
        expected = {}
        for length in args.case:
            value = max(length, 0) * (2 if entry == 'unique' else 1)
            reference = f'{value}\n'.encode()
            command = [compiler, 'exec', '--interp', source, entry, str(length)]
            assert run(command, dict(environment, FWP_NO_OPT='1')) == reference
            assert run(command, environment) == reference
            expected[length] = value
        results = []
        for level in [1, 2]:
            executable = output / f'{entry}-O{level}'
            assert run([args.cc, '-std=gnu11', f'-O{level}', '-ffp-contract=off', '-fno-fast-math',
                        '-fno-lto', '-w', generated, '-o', executable, '-lm', '-lpthread', '-ldl'], environment) == b''
            for length, value in expected.items():
                for repeats in [1, 3]:
                    actual = run([executable, entry, str(length), str(repeats)], environment)
                    assert actual == f'{value * repeats}\n'.encode(), (entry, length, repeats, actual)
                    results.append(dict(level=level, length=length, repeats=repeats, checksum=value * repeats))
        report['entries'][entry] = results
    report['commands'] = sequence
    (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(f'Both entries: raw/optimized interpretation and {sum(map(len, report["entries"].values()))} native O1/O2 executions agree')


if __name__ == '__main__':
    main()
