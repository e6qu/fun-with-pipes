#!/usr/bin/env python3
"""Require raw reconstruction to reject a forged summary with valid checksums."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('input', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('source', 'arch'):
        parser.add_argument('--' + name, required=True)
    args = parser.parse_args()
    args.output.mkdir()
    for application in ('service', 'http'):
        clone = args.output / application
        shutil.copytree(args.input, clone)
        report_path = clone / 'report.json'
        report = json.loads(report_path.read_text())
        report['cases'][f'{application}/O2/attributed/64-0']['work']['fields'][0][0] += 1
        report_path.write_text(json.dumps(report, indent=2) + '\n')
        manifest_path = clone / 'manifest.json'
        manifest = json.loads(manifest_path.read_text())
        manifest['report.json'] = hashlib.sha256(report_path.read_bytes()).hexdigest()
        manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
        result = subprocess.run(['python3', 'scripts/audit-resource-frames.py', '--input', str(clone),
                                 '--source', args.source, '--arch', args.arch], capture_output=True, text=True, check=False)
        (args.output / f'{application}.stdout').write_text(result.stdout)
        (args.output / f'{application}.stderr').write_text(result.stderr)
        assert result.returncode != 0 and 'raw output disagrees with summary' in result.stderr
        # Keep the forged reports and diagnostics, not duplicate native images.
        shutil.copy2(report_path, args.output / f'{application}-report.json')
        shutil.copy2(manifest_path, args.output / f'{application}-manifest.json')
        shutil.rmtree(clone)
    print('Both altered summaries rejected despite refreshed checksums')


if __name__ == '__main__':
    main()
