#!/usr/bin/env python3
"""Decode retained compiler recordings without rebuilding or sampling again."""
import argparse
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import traceback

from compiler_sample_stacks import attribute
from cpu_samples import decode, histogram
from compiler_scaling import APPLICATIONS, ROOT, digest


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--recordings', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--run', required=True)
    parser.add_argument('--perf', type=Path, required=True)
    parser.add_argument('--demangler', type=Path, required=True)
    parser.add_argument('--addr2line-timeout-ms', type=int, required=True)
    parser.add_argument('--deadline', type=float, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert 0 < args.deadline <= 120
    assert 0 < args.addr2line_timeout_ms <= args.deadline * 1000
    source = args.recordings.resolve()/'compiler-sampling'
    identity = json.loads((source/'identity.json').read_text())
    assert identity['source'] == args.source and digest(source/'fwp') == identity['compilerSha256']
    assert (args.recordings/'compiler-source.txt').read_text().strip() == args.source
    compiler = ROOT/'target/release/fwp'
    compiler.parent.mkdir(parents=True, exist_ok=True)
    assert not compiler.exists(), 'do not replace a built compiler'
    shutil.copyfile(source/'fwp', compiler)
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    config = output/'perf.config'
    config.write_text(f'[core]\naddr2line-timeout = {args.addr2line_timeout_ms}\n')
    environment = dict(os.environ, LC_ALL='C', DEBUGINFOD_URLS='', PERF_CONFIG=str(config))
    summary = dict(recordingRun=args.run, recordingIdentity=identity,
        addr2lineTimeoutMs=args.addr2line_timeout_ms, perfConfigSha256=digest(config),
        decoderSource=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
        perfVersion=subprocess.check_output([str(args.perf), '--version'], text=True),
        applications={}, failures=[])
    for name in APPLICATIONS:
        directory = output/name
        directory.mkdir()
        row = dict(correct=False, commands=[])
        summary['applications'][name] = row
        try:
            recording = source/name
            assert (recording/'ordinary.c').read_bytes() == (recording/'sampled.c').read_bytes()
            flat = histogram((recording/'all-symbols.tsv').read_text(), False)
            row['checking-callers'] = decode(recording/'perf.data', directory, perf=args.perf,
                symbol_command=[args.demangler, '--no-strip-underscore', '--format=rust'],
                environment=environment, deadline=args.deadline, flat=flat, commands=row['commands'],
                attribution=attribute, cwd=ROOT)
            row['correct'] = True
        except Exception:
            row['failure'] = traceback.format_exc()
            summary['failures'].append(name)
        (output/'summary.json').write_text(json.dumps(summary, indent=2)+'\n')
        print(f'{name}: {"pass" if row["correct"] else row["failure"]}', flush=True)
    assert not summary['failures'], summary['failures']


if __name__ == '__main__':
    main()
