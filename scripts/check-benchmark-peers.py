#!/usr/bin/env python3
"""Check actual benchmark arithmetic bodies and C allocation-failure cleanup."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import resource
import subprocess

ROOT = Path(__file__).resolve().parent.parent
MIN = -(1 << 63)
MAX = (1 << 63) - 1
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--source', required=True)
parser.add_argument('--cc', required=True)
parser.add_argument('--rustc', required=True)
parser.add_argument('--arch', choices=['x86_64', 'aarch64'], required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert os.environ['GITHUB_ACTIONS'] == 'true' and platform.system() == 'Linux'
assert platform.machine() == args.arch and re.fullmatch('[0-9a-f]{40}', args.source)
assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source
assert not args.output.exists(), 'Preserve completed checks'
args.output.mkdir(parents=True)
resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
environment = {key: value for key, value in os.environ.items()
               if key not in {'GH_TOKEN', 'GITHUB_TOKEN'}}
environment.update(LC_ALL='C', RUST_BACKTRACE='0')


def expected_step(i, acc):
    if i == 0:
        return (i, acc), None
    if i - 1 < MIN:
        return None, 'subtraction'
    product = i * 3
    if not MIN <= product <= MAX:
        return None, 'multiplication'
    remainder = product % 7 if product >= 0 else -((-product) % 7)
    total = acc + remainder
    if not MIN <= total <= MAX:
        return None, 'addition'
    return (i - 1, total), None


def compile_probe(name, language, code):
    source = args.output / f'{name}.{language}'
    binary = args.output / name
    source.write_text(code)
    command = ([args.cc, '-std=c11', '-O2', '-ffp-contract=off'] if language == 'c'
               else [args.rustc, '--edition=2021', '-O', '--crate-name', 'peer_probe'])
    command += [str(source), '-o', str(binary)]
    built = subprocess.run(command, env=environment, capture_output=True, timeout=60)
    (args.output / f'{name}.build.txt').write_bytes(built.stdout + built.stderr)
    assert built.returncode == 0, (command, built.stderr)
    return binary.resolve(), dict(file=binary.name, command=command,
        sourceSha256=hashlib.sha256(code.encode()).hexdigest(),
        binarySha256=hashlib.sha256(binary.read_bytes()).hexdigest())


indices = sorted({MIN, MIN + 1, MAX, MAX - 1, MAX // 3, MAX // 3 + 1,
                  -(abs(MIN) // 3), -(abs(MIN) // 3) - 1, -8, -7, -2, -1, 0, 1, 2, 7, 8})
cases = [(i, acc) for i in indices for acc in [MIN, 0, MAX]]
records = []
for language in ['c', 'rs']:
    original = (ROOT / f'bench/loop/main.{language}').read_text()
    marker = '    while (i != 0) {\n' if language == 'c' else '    while i != 0 {\n'
    assert original.count(marker) == 1
    body = original.split(marker, 1)[1].split('\n    }\n', 1)[0]
    for removed in ['none', 'subtraction', 'multiplication', 'addition']:
        changed = body
        if removed != 'none':
            operation = {'subtraction': 'sub', 'multiplication': 'mul', 'addition': 'add'}[removed]
            if language == 'c':
                replacement = {
                    'subtraction': 'next = (int64_t)((uint64_t)i - UINT64_C(1));',
                    'multiplication': 'product = (int64_t)((uint64_t)i * UINT64_C(3));',
                    'addition': 'sum = (int64_t)((uint64_t)acc + (uint64_t)(product % 7));',
                }[removed]
                changed, count = re.subn(
                    rf'if \(__builtin_{operation}_overflow\([^\n]+\)\) \{{.*?\n        \}}',
                    replacement, body, flags=re.S)
                assert count == 1
            else:
                before, after = {
                    'subtraction': ('i.checked_sub(1).expect("subtraction overflow")', 'i.wrapping_sub(1)'),
                    'multiplication': ('i.checked_mul(3).expect("multiplication overflow")', 'i.wrapping_mul(3)'),
                    'addition': ('acc.checked_add(product % 7).expect("addition overflow")', 'acc.wrapping_add(product % 7)'),
                }[removed]
                assert body.count(before) == 1
                changed = body.replace(before, after)
        if language == 'c':
            code = original.split('int main(void) {', 1)[0] + '#include <stdlib.h>\n'
            code += '''int main(int argc, char **argv) {
    if (argc != 3) return 2;
    int64_t i = strtoimax(argv[1], NULL, 10), acc = strtoimax(argv[2], NULL, 10);
    if (i != 0) {
''' + changed + '\n    }\n    printf("%" PRId64 " %" PRId64 "\\n", i, acc);\n    return 0;\n}\n'
        else:
            code = '''fn main() {
    let values: Vec<String> = std::env::args().collect();
    assert_eq!(values.len(), 3);
    let mut i: i64 = values[1].parse().expect("input index");
    let mut acc: i64 = values[2].parse().expect("input sum");
    if i != 0 {
''' + changed + '\n    }\n    println!("{} {}", i, acc);\n}\n'
        binary, record = compile_probe(f'step-{language}-{removed}', language, code)
        record.update(language=language, removedCheck=removed,
                      benchmarkSourceSha256=hashlib.sha256(original.encode()).hexdigest(), observations=[])
        rejected = 0
        for i, acc in cases:
            expected, error = expected_step(i, acc)
            actual = subprocess.run([str(binary), str(i), str(acc)], env=environment,
                                    capture_output=True, text=True, timeout=10)
            accepted = (actual.returncode == 0 and actual.stdout == f'{expected[0]} {expected[1]}\n'
                        and not actual.stderr) if error is None else (
                        actual.returncode == (1 if language == 'c' else 101)
                        and not actual.stdout and f'{error} overflow' in actual.stderr)
            if removed == 'none' or error is None:
                assert accepted, (language, removed, i, acc, error, actual)
            if removed != 'none' and error == removed:
                assert not accepted, (language, removed, i, acc, actual)
                rejected += 1
            record['observations'].append(dict(index=i, accumulator=acc, expected=expected,
                expectedFailure=error, status=actual.returncode, stdout=actual.stdout,
                stderr=actual.stderr, matchesContract=accepted))
        assert removed == 'none' or rejected > 0
        record['detectedMissingChecks'] = rejected
        records.append(record)

allocation_records = []
for program, failure_sites in [('map', [1]), ('pipeline', [1, 2])]:
    original = (ROOT / f'bench/{program}/main.c').read_text()
    for removed in (['none'] if program == 'map' else ['none', 'partial-free']):
        changed = original.replace('int main(void)', 'int benchmark_main(void)')
        assert changed != original
        if removed != 'none':
            before = 'if (!b) { free(a); return 1; }'
            assert changed.count(before) == 1
            changed = changed.replace(before, 'if (!b) return 1;')
        changed = changed.replace('malloc(', 'probe_malloc(').replace('free(', 'probe_free(')
        headers = '\n'.join(line for line in changed.splitlines() if line.startswith('#include')) + '\n'
        changed = '\n'.join(line for line in changed.splitlines() if not line.startswith('#include'))
        code = headers + '''static unsigned calls, live_count, fail_at;
static void *slots[2];
static void *probe_malloc(size_t n) {
    calls++;
    if (calls == fail_at) return NULL;
    void *p = malloc(n);
    if (!p || live_count == 2) exit(77);
    slots[live_count++] = p;
    return p;
}
static void probe_free(void *p) {
    if (!p) return;
    for (unsigned i = 0; i < live_count; i++) {
        if (slots[i] == p) { slots[i] = slots[--live_count]; free(p); return; }
    }
    exit(78);
}
''' + changed + '''
int main(int argc, char **argv) {
    if (argc != 2) return 2;
    fail_at = (unsigned)strtoul(argv[1], NULL, 10);
    int status = benchmark_main();
    printf("status=%d calls=%u live=%u\\n", status, calls, live_count);
    return status == 1 && live_count == 0 ? 0 : 75;
}
'''
        binary, record = compile_probe(f'allocation-{program}-{removed}', 'c', code)
        record.update(program=program, removedCleanup=removed,
                      benchmarkSourceSha256=hashlib.sha256(original.encode()).hexdigest(), observations=[])
        for failure in failure_sites:
            actual = subprocess.run([str(binary), str(failure)], env=environment,
                                    capture_output=True, text=True, timeout=10)
            broken = removed == 'partial-free' and failure == 2
            assert actual.returncode == (75 if broken else 0) and not actual.stderr, actual
            assert actual.stdout == f'status=1 calls={failure} live={int(broken)}\n', actual
            record['observations'].append(dict(failedRequest=failure, status=actual.returncode,
                                               stdout=actual.stdout, stderr=actual.stderr))
        allocation_records.append(record)

report = dict(source=args.source, architecture=args.arch,
    cCompiler=subprocess.check_output([args.cc, '--version'], text=True),
    rustCompiler=subprocess.check_output([args.rustc, '-vV'], text=True),
    arithmetic=records, allocation=allocation_records,
    scope='One actual loop body with dynamic I64 inputs, including its stop condition. '
          'Checks subtraction, multiplication, addition and their failure order against '
          'an independent arbitrary-precision oracle. Three deliberately removed checks '
          'per language must be detected. C map/pipeline allocation failures and a '
          'deliberately omitted partial cleanup are checked separately. These derived '
          'control images are never timed and do not measure whole-process allocations.')
(args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
print(f'Checked {len(cases)} dynamic inputs in eight arithmetic images; six missing-check controls detected')
print('Checked three C allocation images; failed first/second requests release prior storage and missing cleanup is detected')
