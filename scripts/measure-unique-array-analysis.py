#!/usr/bin/env python3
"""Measure complete C emission for 16, 32 and 64 local-array candidates."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import statistics
import subprocess
import time

from process_wait import run_capture


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', required=True, type=Path)
    parser.add_argument('--samples', required=True, type=int)
    parser.add_argument('--timeout', required=True, type=int)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'compiler measurements run on GitHub'
    assert platform.system() == 'Linux' and args.samples >= 3 and args.timeout > 0
    compiler = args.compiler.resolve()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    report = dict(
        source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
        machine=platform.machine(), compilerSha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
        scope='Whole compiler command through C emission, including startup, parsing, typing, '
              'optimization and ownership; not isolated proof time or generated-program time. '
              'Child peak RSS is from Linux time -v, not proof heap usage. '
              'One warmup precedes alternating measured sizes. No before/after speedup claim.',
        samples=args.samples, rows={}, commands=[])
    for count in (16, 32, 64):
        body = 'local'
        for _ in range(count - 1):
            body = f'both local (add 1 | ({body})) | uncurry add'
        program = ('read : Array[I64] -> I64\n'
                   'read = both array.length (array.get 0 | option.unwrap-or 0) | uncurry add\n'
                   'local : I64 -> I64\n'
                   'local = flip array.generate id | both read array.length | uncurry add\n'
                   'export work : I64 -> I64\nwork = ' + body + '\n')
        path = output / str(count)
        path.mkdir()
        (path / 'program.fwp').write_text(program)
        report['rows'][str(count)] = dict(seconds=[], peakCommandKiB=[])
    for sample in range(-1, args.samples):
        sizes = (16, 32, 64) if sample % 2 else (64, 32, 16)
        for count in sizes:
            path = output / str(count)
            command = ['/usr/bin/time', '-v', '-o', str(path / 'resources.txt'),
                       str(compiler), 'build', '--fn', 'work', '--emit-c', '-O2',
                       str(path / 'program.fwp'), '-o', str(path / 'program.c')]
            report['commands'].append(command)
            start = time.perf_counter()
            result = run_capture(command, timeout=args.timeout,
                         env=environment, cwd=None, input_data=None, input_stream=None,
                         text=False, encoding='utf-8', check=False)
            elapsed = time.perf_counter() - start
            assert result.returncode == 0 and not result.stdout and not result.stderr, result
            code = (path / 'program.c').read_text()
            # Inlining may split larger inputs into helpers. Record the actual
            # selected sites instead of assuming all source calls share one body.
            entry = code.split('/* work :', 1)[1].split('\n/* ', 1)[0]
            marker = '/* proved unique I64 array: no reference-count metadata */'
            selected = dict(workEntrySites=entry.count(marker), emittedSites=code.count(marker))
            assert selected['workEntrySites'] > 0 and selected['emittedSites'] >= selected['workEntrySites']
            row = report['rows'][str(count)]
            if 'selection' in row:
                assert row['selection'] == selected
            row['selection'] = selected
            resources = (path / 'resources.txt').read_text()
            peak, = [int(line.split(':', 1)[1]) for line in resources.splitlines()
                     if 'Maximum resident set size (kbytes):' in line]
            (path / f'{sample}-resources.txt').write_text(resources)
            if sample >= 0:
                report['rows'][str(count)]['seconds'].append(elapsed)
                report['rows'][str(count)]['peakCommandKiB'].append(peak)
    for count, row in report['rows'].items():
        row['medianSeconds'] = statistics.median(row['seconds'])
        row['maxPeakCommandKiB'] = max(row['peakCommandKiB'])
        row['generatedCBytes'] = (output / count / 'program.c').stat().st_size
        print(count, row, flush=True)
    (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
