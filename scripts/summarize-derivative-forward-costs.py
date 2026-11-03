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


def field_owner_sites(code, sites, observations, pairs):
    """Check the removed projection and unchanged input preparation separately."""
    maps = re.findall(r'/\* Eager packed numeric records:[\s\S]*?fwp_args(\d+)\(arguments, 0, 2\);', code)
    assert len(maps) == 1, maps
    callback = 'fwp_args' + maps[0]
    workers = re.findall(r'/\* fn : \(Rev\[F64\], Rev\[F64\]\) -> Rev\[F64\] \*/\nstatic fwp_wr(\d+) w\1\(V l0_0, V l0_1\) \{([\s\S]*?)\n}', code)
    selected = [(number, body) for number, body in workers
                if '/* move complete separated field owners */' in body]
    assert len(selected) == 1, selected
    number, body = selected[0]
    assert 'fwp_rc_dup(' not in body, body
    assert not re.search(r'fwp_drop\d+\(l0_[01]\)', body), body
    mapped = {site['id'] for site in sites['ownership']
              if site['operation'] == 'dup' and site['caller'] == callback}
    counts = {}
    for mode, observation in observations.items():
        total = 0
        for row in observation['ownership']:
            if row['site'] in mapped:
                assert row['phase'] == 'forwardWithRecording', row
                assert row['calls'] == row['effective'] and row['last'] == 0, row
                total += row['effective']
        assert total == 2 * pairs, (mode, total, pairs)
        counts[mode] = dict(mapperInputs=total, separatedFieldTransfer=0)
    return dict(callback=callback, projection='w' + number, counts=counts)


def numeric_input_sites(code, sites, observations, previous, pairs):
    """Follow map -> forwarding worker -> numeric callee; check removed owners."""
    marker = '/* Eager packed numeric records: finish mapping before folding. */'
    assert code.count(marker) == 1
    start = code.index(marker)
    end = code.index('\n}\n', start)
    mapping = code[start:end]
    assert 'fwp_args' not in mapping and 'fwp_rc_dup(' not in mapping
    reads = re.findall(r'OBJ\(arguments\[([01])\]\)->f\[([01])\]', mapping)
    assert reads == [('0', '0'), ('0', '1'), ('1', '0'), ('1', '1')], reads
    callback, = re.findall(r'fwp_wr(\d+) mapped = w\1\(', mapping)
    signature = r'double al0_0, int64_t al0_1, double al1_0, int64_t al1_1'
    forward, = re.findall(r'static fwp_wr' + callback + r' w' + callback
                         + r'\(' + signature + r'\) \{([\s\S]*?)\n}', code)
    workers = re.findall(r'/\* fn : \(F64, I64, F64, I64\) -> Rev\[F64\] \*/\n'
                         r'static fwp_wr(\d+) w\1\(double al0_0, int64_t al0_1, '
                         r'double al0_2, int64_t al0_3\) \{([\s\S]*?)\n}', code)
    selected_workers = [(number, body) for number, body in workers
                        if re.search(r'\bw' + number + r'\(', forward)]
    assert len(selected_workers) == 1, selected_workers
    number, body = selected_workers[0]
    for text in (forward, body):
        assert 'fwp_rc_dup(' not in text and 'fwp_args' not in text
        assert not re.search(r'fwp_drop\d+\(', text)
    line = code[:start].count('\n') + 1
    mapper, = [name for first, last, name in CALLERS.caller_lines(code) if first <= line <= last]
    selected = {mapper, 'w' + callback, 'w' + number}
    assert not [site for site in sites['ownership']
                if site['operation'] == 'dup' and site['caller'] in selected]
    assert set(previous['counts']) == set(observations)
    counts = {}
    for mode in observations:
        assert previous['counts'][mode] == dict(mapperInputs=2 * pairs, separatedFieldTransfer=0)
        counts[mode] = dict(mapperInputs=0, separatedFieldTransfer=0, removedMapperInputs=2 * pairs)
    return dict(mapper=mapper, callback='w' + callback, callee='w' + number, counts=counts)


def audit(path, source, machine, comparison, baseline):
    with zipfile.ZipFile(path) as archive:
        report = json.loads(archive.read('report.json'))
        assert report['source'] == source and report['machine'] == machine
        assert report.get('complete') is True
        if comparison in ('record-zip', 'record-fold', 'packed-records', 'field-owners', 'numeric-inputs'):
            assert report['comparison'] == dict(policy=comparison, baselineSource=baseline['source'])
            assert report['cc'] == baseline['hosts'][machine]['cc']
        else:
            assert comparison == 'baseline' and baseline is None
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
                    if comparison == 'field-owners':
                        cases[name]['fieldOwners'] = field_owner_sites(
                            archive.read(root + 'ownership-base.c').decode(), active_sites,
                            observations, (dimensions - 1) * updates)
                    if comparison == 'numeric-inputs':
                        cases[name]['numericInputs'] = numeric_input_sites(
                            archive.read(root + 'ownership-base.c').decode(), active_sites,
                            observations, baseline['hosts'][machine]['cases'][name]['fieldOwners'],
                            (dimensions - 1) * updates)
                    if comparison in ('field-owners', 'numeric-inputs'):
                        factor = 1 if comparison == 'field-owners' else 2
                        for mode, observation in observations.items():
                            previous = baseline['hosts'][machine]['cases'][name]['observations'][mode]
                            removed = previous['totals']['managed']['retains'] - observation['totals']['managed']['retains']
                            assert removed == factor * (dimensions - 1) * updates, (
                                name, mode, 'retain changes outside the attributed sites', removed)
        failures = []
        if baseline is not None:
            failures = MEASURE.comparison_failures(report, baseline, comparison)
            assert failures == report['comparisonFailures']
            for name, actual in cases.items():
                previous = baseline['hosts'][machine]['cases'][name]
                if comparison in ('record-zip', 'record-fold') and actual['textBytes'] > previous['textBytes'] + 1024:
                    failures.append(name + ': instruction section grew by more than 1024 bytes')
                def largest_frame(frames):
                    return max(int(line.split('\t')[1]) for line in frames.splitlines())
                if largest_frame(actual['frames']) > largest_frame(previous['frames']) + 128:
                    failures.append(name + ': largest static frame grew by more than 128 bytes')
        return dict(source=source, machine=machine, cpu=report['cpu'], cc=report['cc'],
                    compilerSha256=report['compilerSha256'], cases=cases, controls=report['controls'],
                    comparisonFailures=failures,
                    files=report['files'], archiveSha256=PROFILE.ARC.digest(path),
                    reportSha256=hashlib.sha256(archive.read('report.json')).hexdigest())


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--arm64', required=True, type=Path)
    parser.add_argument('--amd64', required=True, type=Path)
    parser.add_argument('--source', required=True)
    parser.add_argument('--run', required=True)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--comparison', required=True, choices=('baseline', 'record-zip', 'record-fold', 'packed-records', 'field-owners', 'numeric-inputs'))
    parser.add_argument('--baseline', type=Path)
    args = parser.parse_args()
    assert re.fullmatch('[0-9a-f]{40}', args.source) and args.run.isdigit()
    assert (args.comparison != 'baseline') == (args.baseline is not None)
    baseline = json.loads(gzip.decompress(args.baseline.read_bytes())) if args.baseline else None
    hosts = {machine: audit(path, args.source, machine, args.comparison, baseline)
             for machine, path in [('aarch64', args.arm64), ('x86_64', args.amd64)]}
    result = dict(source=args.source, run=args.run, hosts=hosts,
        scope='All six inputs, both forms, GCC O1/O2 and workspace modes. '
        'Recomputed from archived observations; all archived files hash-checked. '
        'Source sites identify C callers, not complete fwp stacks. '
        'Peaks are maxima and static frames are not total call-stack use. No timing claim.')
    args.output.write_bytes(gzip.compress((json.dumps(result, indent=2) + '\n').encode(), mtime=0))
    for machine, host in hosts.items():
        print(f'{machine}: {len(host["cases"])} cases, both workspace modes and all controls verified')
    failures = {machine: host['comparisonFailures'] for machine, host in hosts.items()
                if host['comparisonFailures']}
    assert not failures, json.dumps(failures, indent=2)


if __name__ == '__main__':
    main()
