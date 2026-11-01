#!/usr/bin/env python3
"""Audit both native archives and retain phase counts with their actual C callers."""
import argparse
from bisect import bisect_right
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path, PurePosixPath
import re
import zipfile

SPEC = importlib.util.spec_from_file_location('measure', Path(__file__).with_name('measure-derivative-forward-costs.py'))
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)
PROFILE = MEASURE.PROFILE
CALLERS = PROFILE.ARC.module('summarize-arc-costs')
IMAGES = PROFILE.ARC.module('check-array-list-evidence')


def verify_manifest(archive, report):
    names = [entry.filename for entry in archive.infolist() if not entry.is_dir()]
    assert len(names) == len(set(names)), 'duplicate archive names'
    assert set(names) == set(report['files']) | {'report.json'}
    for name, expected in report['files'].items():
        path = PurePosixPath(name)
        assert not path.is_absolute() and '..' not in path.parts and str(path) == name
        actual = hashlib.sha256(archive.read(name)).hexdigest()
        assert actual == expected, name


def attributed_sites(archive, root, sites, profiles):
    result = {}
    for key, filename in [('allocations', 'allocation-base.c'), ('ownership', 'ownership-base.c')]:
        code = archive.read(root + filename).decode()
        lines = code.splitlines()
        functions = CALLERS.caller_lines(code)
        starts = [row[0] for row in functions]
        owner_types = {function: owner for owner, function in re.findall(
            r'/\* ([^\n]*?) \*/\nstatic void (fwp_drop\d+)\(V v\) \{', code)}
        owner_types.update(fwp_closure_drop='Function', fwp_channel_drop='Channel',
                           fwp_cli_text_drop='String')
        active = {row['site'] for profile in profiles.values() for row in profile[key]}
        selected = []
        for index, site in enumerate(sites[key]):
            assert site['id'] == index and site['source'] == lines[site['line'] - 1].strip()
            if index in active:
                position = bisect_right(starts, site['line']) - 1
                caller = (functions[position][2] if position >= 0
                          and site['line'] <= functions[position][1] else None)
                selected.append(dict(site, caller=caller, ownerType=owner_types.get(caller)))
        result[key] = selected
    return result


def audit(path, source, machine):
    with zipfile.ZipFile(path) as archive:
        report = json.loads(archive.read('report.json'))
        assert report['source'] == source and report['machine'] == machine
        assert report.get('complete') is True
        verify_manifest(archive, report)
        expected_cases = {f'{dimensions}-{updates}-{form}-{opt}'
            for dimensions, updates in MEASURE.CASES
            for form in ('current', 'history') for opt in ('O1', 'O2')}
        assert set(report['cases']) == expected_cases
        assert set(report['controls']) == {'O1', 'O2'}
        compilations = [row['command'] for row in report['commands']
                        if '-std=gnu11' in row['command']]
        assert len(compilations) == 82  # 10 controls + 24 cases times three images
        for command in compilations:
            assert Path(command[0]).name == 'gcc'
            assert {'-ffp-contract=off', '-fno-fast-math', '-fno-lto', '-Werror',
                    '-fstack-usage', '-march=' + {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[machine]} <= set(command)
            outputs = [Path(value).name for value in command if value.endswith('.exe')]
            assert len(outputs) == 1
            cfile, = [Path(value) for value in command if value.endswith('.c')]
            opt = cfile.parent.name.rsplit('-', 1)[1]
            assert opt in ('O1', 'O2') and '-' + opt in command
        for row in report['commands']:
            assert 'timeout' not in row
            assert row['returncode'] == (233 if Path(row['command'][0]).name == 'unfinished.exe' else 0)
        for opt, controls in report['controls'].items():
            assert set(controls) == {'complete', 'missing-allocation', 'missing-retain', 'wrong-phase', 'unfinished'}
            root = 'control-' + opt + '/'
            sites = json.loads(archive.read(root + 'sites.json'))
            parsed = PROFILE.parse(archive.read(root + 'complete.stderr'), sites, 2, 1, False)
            assert parsed == controls['complete']
            MEASURE.check_control(parsed)
            for label in ('missing-allocation', 'missing-retain', 'wrong-phase'):
                try:
                    MEASURE.check_control(PROFILE.parse(archive.read(root + label + '.stderr'), sites, 2, 1, False))
                except AssertionError:
                    pass
                else:
                    raise AssertionError('broken observer accepted: ' + label)
            assert b'incomplete or unsupported phase sequence' in archive.read(root + 'unfinished.stderr')
        cases = {}
        for dimensions, updates in MEASURE.CASES:
            expected = MEASURE.AD.analytic(dimensions, updates + 1)
            for form in ('current', 'history'):
                for opt in ('O1', 'O2'):
                    name = f'{dimensions}-{updates}-{form}-{opt}'
                    root = name + '/'
                    assert archive.read(root + 'program.fwp').decode() == MEASURE.AD.program(dimensions, updates + 1, form == 'history')
                    assert not archive.read(root + 'raw.stderr')
                    PROFILE.ARC.DESCENT.verify(archive.read(root + 'raw.stdout'), expected, 1)
                    sites = json.loads(archive.read(root + 'sites.json'))
                    observations = report['cases'][name]
                    assert set(observations) == {'0', '1'}
                    for workspace in (0, 1):
                        suffix = f'-workspace{workspace}'
                        ordinary = archive.read(root + 'ordinary' + suffix + '.stdout')
                        assert not archive.read(root + 'ordinary' + suffix + '.stderr')
                        PROFILE.ARC.DESCENT.verify(ordinary, expected, 1)
                        for label in ('totals', 'detailed'):
                            assert archive.read(root + label + suffix + '.stdout') == ordinary
                        parsed = PROFILE.parse(archive.read(root + 'detailed' + suffix + '.stderr'),
                                               sites, dimensions, updates, bool(workspace))
                        assert parsed == observations[str(workspace)]
                        managed, raw = MEASURE.parse_totals(archive.read(root + 'totals' + suffix + '.stderr'))
                        assert managed == parsed['totals']['managed'] and raw == parsed['raw']
                    active_sites = attributed_sites(archive, root, sites, observations)
                    ordinary = archive.read(root + 'ordinary.exe')
                    # Use the existing section/header reader; never execute saved images.
                    text_bytes = IMAGES.instruction_bytes(ordinary, machine)
                    frames = [name for name in archive.namelist()
                              if name.startswith(root + 'ordinary') and name.endswith('.su')]
                    assert len(frames) == 1, (root, frames)
                    for label in ('totals', 'detailed'):
                        IMAGES.instruction_bytes(archive.read(root + label + '.exe'), machine)
                    cases[name] = dict(observations=observations, sites=active_sites,
                        binaryBytes=len(ordinary), textBytes=text_bytes,
                        frames=archive.read(frames[0]).decode(),
                        binarySha256=report['files'][root + 'ordinary.exe'])
        return dict(source=source, machine=machine, cpu=report['cpu'], cc=report['cc'],
                    compilerSha256=report['compilerSha256'], cases=cases, controls=report['controls'],
                    files=report['files'], archiveSha256=PROFILE.ARC.digest(path),
                    reportSha256=hashlib.sha256(archive.read('report.json')).hexdigest())


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--arm64', required=True, type=Path)
    parser.add_argument('--amd64', required=True, type=Path)
    parser.add_argument('--source', required=True)
    parser.add_argument('--run', required=True)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert re.fullmatch('[0-9a-f]{40}', args.source) and args.run.isdigit()
    hosts = {machine: audit(path, args.source, machine)
             for machine, path in [('aarch64', args.arm64), ('x86_64', args.amd64)]}
    result = dict(source=args.source, run=args.run, hosts=hosts,
        scope='All six inputs, both forms, GCC O1/O2 and workspace modes. '
        'Recomputed from archived observations; all archived files hash-checked. '
        'Source sites identify C callers, not complete fwp stacks. '
        'Peaks are maxima and static frames are not total call-stack use. No timing claim.')
    args.output.write_bytes(gzip.compress((json.dumps(result, indent=2) + '\n').encode(), mtime=0))
    for machine, host in hosts.items():
        print(f'{machine}: {len(host["cases"])} cases, both workspace modes and all controls verified')


if __name__ == '__main__':
    main()
