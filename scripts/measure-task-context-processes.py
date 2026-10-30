#!/usr/bin/env python3
"""Compare complete native processes using the two tested task-record layouts."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import statistics
import struct
import subprocess
import time

from process_wait import run_capture


ROOT = Path(__file__).resolve().parent.parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--repetitions', required=True, type=int)
    parser.add_argument('--timeout', required=True, type=int)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'native measurements run on GitHub'
    assert platform.system() == 'Linux'
    assert args.repetitions > 1 and args.timeout > 0
    assert not args.output.exists(), 'preserve the existing report'
    directory = args.input.resolve()
    machine = {'x86_64': 62, 'aarch64': 183}[platform.machine()]
    samples = []
    binaries = []
    summaries = []
    for opt in ['O0', 'O2']:
        paths = {}
        for layout in ['heap', 'stack']:
            binary = directory / 'counted' / f'{layout}-{opt}.exe'
            data = binary.read_bytes()
            code = binary.with_suffix('.c').read_bytes()
            for check in [b'_Exit(193)', b'_Exit(195)', b'_Exit(196)']:
                assert check not in code, 'layout-specific verification must not affect timing'
            assert data[:6] == b'\x7fELF\x02\x01'
            assert struct.unpack_from('<H', data, 18)[0] == machine
            paths[layout] = binary
            binaries.append(dict(optimization=opt, layout=layout,
                sha256=hashlib.sha256(data).hexdigest(), bytes=len(data),
                c_sha256=hashlib.sha256(code).hexdigest()))
        for repetition in range(args.repetitions):
            order = ['heap', 'stack'] if repetition % 2 == 0 else ['stack', 'heap']
            for layout in order:
                started = time.perf_counter_ns()
                result = run_capture([str(paths[layout])], timeout=args.timeout,
                             env=dict(os.environ), cwd=ROOT, input_data=None, input_stream=None,
                             text=True, encoding='utf-8', check=True)
                elapsed = time.perf_counter_ns() - started
                assert result.stdout == '528\n', result.stdout
                rows = {key: list(map(int, fields.split('\t'))) for key, fields in
                        (line.split('\t', 1) for line in result.stderr.splitlines())}
                assert set(rows) == {'client-memory', 'task-layout', 'process-peak-kib'}
                counts = dict(zip(['allocation_requests', 'requested_bytes', 'effective_retains',
                                   'peak_charged_bytes', 'final_charged_bytes'],
                                  rows['client-memory'], strict=True))
                assert counts['final_charged_bytes'] == 0
                peak, = rows['process-peak-kib']
                assert peak > 0, 'whole-process peak resident memory is unavailable'
                samples.append(dict(optimization=opt, layout=layout,
                    repetition=repetition, order=len(samples), elapsed_ns=elapsed,
                    process_peak_kib=peak, counters=counts, task_layout=rows['task-layout']))
        comparison = dict(optimization=opt, layouts={})
        for layout in ['heap', 'stack']:
            selected = [row for row in samples if row['optimization'] == opt and row['layout'] == layout]
            peaks = [row['process_peak_kib'] for row in selected]
            elapsed = [row['elapsed_ns'] for row in selected]
            assert all(row['counters'] == selected[0]['counters'] for row in selected)
            comparison['layouts'][layout] = dict(counters=selected[0]['counters'],
                task_layout=selected[0]['task_layout'],
                process_peak_kib=dict(min=min(peaks), median=statistics.median(peaks), max=max(peaks)),
                elapsed_ns=dict(min=min(elapsed), median=statistics.median(elapsed), max=max(elapsed)))
        old, new = (comparison['layouts'][layout] for layout in ['heap', 'stack'])
        comparison['median_process_peak_ratio_stack_over_heap'] = new['process_peak_kib']['median'] / old['process_peak_kib']['median']
        comparison['median_elapsed_ratio_stack_over_heap'] = new['elapsed_ns']['median'] / old['elapsed_ns']['median']
        summaries.append(comparison)
        print(json.dumps(comparison), flush=True)
    report = dict(source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
        comparison='Same generated fwp program, with either the preceding heap-embedded task context or the candidate stack-owned context. This is not a C/Rust comparison.',
        workload='32 tasks each yield once and add one to inputs 0 through 31. Await every result, sum them, print 528 and tear down the runtime. Each repetition starts a new process.',
        memory_scope='Linux VmHWM from /proc/self/status at the post-task-teardown checkpoint, before final allocator/process exit. This is the peak resident memory observed up to that point, including startup, runtime, code, shared library mappings and stacks; not private physical memory or a guarantee about later exit work. Allocator counters and sizeof layouts are separate. The observation opens /proc after the counted region.',
        time_scope='Parent monotonic elapsed time around spawning and waiting for each complete child, including startup, output capture and teardown. These short processes do not isolate context-switch latency; ratios are observations for this workload, not a general speed claim.',
        ratio='Candidate divided by preceding layout: 1 means equal, below 1 means less, above 1 means more. Raw samples and ranges preserve variability; no significance claim.',
        flags='fwp emission at O1; generated C at the named O0/O2, -std=gnu11 -ffp-contract=off -w and normal runtime links. Counted ownership releases storage at the last use; no tracing mode is selected.',
        instrumentation='Both variants use the same allocation-counting and final reporting hooks. Candidate-specific stack bounds, cleared pointers and root-image assertions execute in separate verification binaries, excluded from these measurements.',
        task_layout_fields=['task_record_bytes', 'task_record_alignment', 'saved_context_bytes', 'root_static_context_bytes'],
        repetitions=args.repetitions, timeout_seconds=args.timeout, binary_records=binaries,
        samples=samples, comparisons=summaries)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
