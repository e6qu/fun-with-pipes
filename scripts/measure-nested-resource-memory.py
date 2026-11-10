#!/usr/bin/env python3
"""Explain fast RSS readings with stopped-process page walks of saved binaries."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import traceback

from nested_resource_memory import observe
from nested_resource_timing import order
from parser_process_memory import checkpoint_process, validate_mapping_control
from weak_callback_timing import CASES, decode_output

ROOT = Path(__file__).resolve().parent.parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('input', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('source', 'arch', 'cc', 'c-arch', 'image'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--rounds', type=int, required=True)
    parser.add_argument('--interval-ms', type=int, required=True)
    parser.add_argument('--deadline', type=int, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert platform.machine() == args.arch and args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert (args.rounds, args.interval_ms, args.deadline) == (4, 50, 30)
    assert args.image == 'swift@sha256:bca121f6eb59fd80340d1296887b2698ed8f3eb9eca7d80c181f8af769dc7ee0'
    libc_package = subprocess.check_output(['dpkg-query', '-W', '-f=${Version}', 'libc6'], text=True)
    assert libc_package == '2.39-0ubuntu8.9'
    original = args.input.resolve()
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    comparison = json.loads((original / 'nested-time-comparison/report.json').read_text())
    peers = json.loads((original / 'nested-time-peers/report.json').read_text())
    assert comparison['source'] == peers['source'] == args.source == 'd80357c8c81d206c9d9934b141b5a5fafe97c430'
    assert comparison['architecture'] == peers['architecture'] == args.arch
    assert not comparison['failures'] and not peers['failures']
    for directory in ('nested-time-comparison', 'nested-time-peers'):
        part = original / directory
        manifest = json.loads((part / 'manifest.json').read_text())
        for name, value in manifest.items():
            path = part / name
            assert path.resolve().is_relative_to(part) and digest(path) == value
    images = {}
    for role, binary in comparison['binaries'].items():
        for label, field in ((role, 'path'), (role + '-copy', 'copyPath')):
            path = original / 'nested-time-comparison' / binary[field]
            assert digest(path) == binary['sha256'] and path.stat().st_size == binary['bytes']
            image = path.read_bytes()
            assert image[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
            path.chmod(0o755)
            images[label] = path
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', FWP_LTO='0', FWP_STACK='1')
    report = dict(observerSource=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
        binarySource=args.source, architecture=args.arch, kernel=platform.release(), pageBytes=os.sysconf('SC_PAGE_SIZE'),
        cpu=subprocess.check_output(['lscpu'], text=True), image=args.image, libcPackage=libc_package,
        wait4Scope='Whole child lifetime, including pre-exec memory inherited from the observer; not fwp-only RSS.',
        settings=vars(args) | dict(input=str(original), output=str(folder)),
        binaries={label: dict(path=str(path), sha256=digest(path)) for label, path in images.items()},
        scope='Stopped snapshots of unchanged ordinary binaries. Not timing or exact transient peak acceptance. Original RSS misses remain recorded.',
        controls={}, cases={}, failures=[])

    identity = {key: value for key, value in report.items() if key not in ('controls', 'cases', 'failures')}
    (folder / 'identity.json').write_text(json.dumps(identity, indent=2) + '\n')

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    control = folder / 'mapping-control'
    command = [args.cc, '-std=gnu11', '-O2', '-Wall', '-Wextra', '-Werror', '-fno-lto',
               '-march=' + args.c_arch, ROOT / 'tests/fixtures/parser_memory_control.c',
               ROOT / 'tests/fixtures/parser_memory_checkpoint.c', '-o', control]
    subprocess.run(list(map(str, command)), check=True, env=env)
    for variant, expected in (('ordinary', None), ('omit-touch', 'touch-control-missing'), ('omit-unmap', 'unmap-control-missing')):
        part = folder / ('control-' + variant)
        row = checkpoint_process([control, variant], env, part, 5, args.deadline)
        observed = None
        try:
            validate_mapping_control(row, part)
        except ValueError as error:
            observed = str(error)
        report['controls'][variant] = dict(result=row, expectedError=expected, observedError=observed)
        save()
        assert observed == expected, (variant, observed)
    for population, mode in CASES:
        key = f'{population}-{mode}'
        batches = peers['pilots'][key]['batches']
        rows = report['cases'][key] = []
        for round_number in range(args.rounds):
            for label in order(round_number):
                part = folder / key / f'{round_number}-{label}'
                try:
                    row = observe([images[label], population, mode, batches], env, part,
                                  args.interval_ms / 1000, args.deadline, 600)
                    assert row['status'] == 0 and not row['stderr']
                    decode_output(row['stdout'], population, mode, batches)
                    row.update(label=label, round=round_number, folder=str(part.relative_to(folder)),
                               observedResidentPeakKiB=max(s['metrics']['residentKiB'] for s in row['snapshots']),
                               observedAnonymousPeakKiB=max(s['metrics']['anonymousKiB'] for s in row['snapshots']))
                    rows.append(row)
                except Exception:
                    report['failures'].append(dict(case=key, label=label, round=round_number, error=traceback.format_exc()))
                save()
        print(key, [(r['label'], r['wait4PeakRssKiB'], r['observedResidentPeakKiB']) for r in rows], flush=True)
    assert not report['failures'], report['failures']
    (folder / 'manifest.json').write_text(json.dumps({str(p.relative_to(folder)): digest(p)
        for p in sorted(folder.rglob('*')) if p.is_file()}, indent=2) + '\n')


if __name__ == '__main__':
    main()
