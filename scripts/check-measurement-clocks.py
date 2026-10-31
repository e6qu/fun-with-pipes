#!/usr/bin/env python3
"""Compile actual timer helpers and reject failed clocks before using timestamps."""
import argparse
from pathlib import Path
import re
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent.parent
HELPERS = [
    ('tests/fixtures/callable_phase_clock.c', 'callable_now'),
    ('tests/fixtures/numerical_bench_native.c', 'bench_clock'),
    ('tests/fixtures/numerical_bench.c', 'now_ns'),
    ('scripts/measure-map-phases.py', 'map_probe_now'),
    ('scripts/measure-map-storage-phases.py', 'map_work_now'),
    ('tests/pipe_ownership.rs', 'fwp_now_ns'),
    ('scripts/unique-buffer-phases.py', 'buffer_phase_now'),
]
PREFIX = r'''
#define _POSIX_C_SOURCE 200809L
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
static int probe_mode;
static int probe_clock(clockid_t clock, struct timespec *value) {
    if (clock != CLOCK_MONOTONIC) exit(90);
    if (probe_mode != 2) { value->tv_sec = 5; value->tv_nsec = 123; }
    return probe_mode ? -1 : 0;
}
#define clock_gettime probe_clock
'''


def function(source, name):
    matches = list(re.finditer(r'static (?:u?int64_t) ' + name + r'\(void\)\s*\{', source))
    assert len(matches) == 1, (name, len(matches))
    start = matches[0].start()
    depth = 1
    for end in range(matches[0].end(), len(source)):
        depth += (source[end] == '{') - (source[end] == '}')
        if depth == 0:
            return source[start:end + 1]
    raise AssertionError(f'unclosed timer helper: {name}')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cc', required=True)
    args = parser.parse_args()
    if not args.cc:
        parser.error("--cc must name an explicit C compiler")
    executions = 0
    with tempfile.TemporaryDirectory(prefix='fwp-clock-controls-') as scratch:
        folder = Path(scratch)
        for source_path, name in HELPERS:
            original = function((ROOT / source_path).read_text(), name)
            guard = re.compile(r'if \((clock_gettime\(CLOCK_MONOTONIC, &[a-z]+\)) != 0\) \{\s*fputs\("clock_gettime failed\\n", stderr\);\s*exit\(1\);\s*\}')
            assert len(guard.findall(original)) == 1, source_path
            broken = guard.sub(r'\1;', original)
            for opt in ['-O1', '-O2']:
                for variant, body in [('checked', original), ('omitted-check', broken)]:
                    prefix = PREFIX if variant == 'checked' else PREFIX.replace('if (probe_mode != 2) ', '')
                    code = prefix + body + '\n#undef clock_gettime\n' + (
                        'int main(int argc, char **argv) {\n'
                        ' if (argc != 2) return 91;\n probe_mode = atoi(argv[1]);\n'
                        ' if (probe_mode < 0 || probe_mode > 2) return 92;\n'
                        f' printf("%llu\\n", (unsigned long long){name}()); return 0;\n}}\n')
                    cfile, executable = folder / 'probe.c', folder / 'probe.exe'
                    cfile.write_text(code)
                    built = subprocess.run([args.cc, '-std=c11', opt, '-ffp-contract=off',
                                            '-Wall', '-Wextra', '-Werror', str(cfile), '-o', str(executable)],
                                           capture_output=True, timeout=30)
                    assert built.returncode == 0, (source_path, opt, variant, built.stderr)
                    assert not built.stdout and not built.stderr, (source_path, built)
                    # The broken control receives an initialized timestamp even
                    # for every input, including failure; no path reads unset data.
                    modes = [0, 1, 2] if variant == 'checked' else [1]
                    for mode in modes:
                        out = subprocess.run([str(executable), str(mode)], capture_output=True, timeout=10)
                        expected = (1, b'', b'clock_gettime failed\n') if mode and variant == 'checked' else (
                            0, b'5000000123\n', b'')
                        assert (out.returncode, out.stdout, out.stderr) == expected, (
                            source_path, opt, variant, mode, out, expected)
                        executions += 1
    assert executions == 8 * len(HELPERS)
    print(f'{len(HELPERS)} timer helpers: {executions} O1/O2 success, failed-clock and omitted-check executions pass')


if __name__ == '__main__':
    main()
