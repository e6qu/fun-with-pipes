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

from compiler_sample_stacks import decode
from compiler_sampling import histogram
from compiler_scaling import APPLICATIONS, ROOT, digest


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--recordings', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--run', required=True)
    parser.add_argument('--perf', type=Path, required=True)
    parser.add_argument('--demangler', type=Path, required=True)
    parser.add_argument('--deadline', type=float, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert 0 < args.deadline <= 120
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
    environment = dict(os.environ, LC_ALL='C', DEBUGINFOD_URLS='')
    summary = dict(recordingRun=args.run, recordingIdentity=identity,
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
            row['checking-callers'] = decode(recording/'perf.data', directory, args.perf,
                args.demangler, environment, args.deadline, flat, row['commands'])
            row['correct'] = True
        except Exception:
            row['failure'] = traceback.format_exc()
            summary['failures'].append(name)
        (output/'summary.json').write_text(json.dumps(summary, indent=2)+'\n')
        print(f'{name}: {"pass" if row["correct"] else row["failure"]}', flush=True)
    assert not summary['failures'], summary['failures']


if __name__ == '__main__':
    main()
