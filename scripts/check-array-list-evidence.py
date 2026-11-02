#!/usr/bin/env python3
"""Recompute paired derivative evidence without executing saved binaries."""
import argparse
from contextlib import ExitStack
import difflib
import hashlib
import importlib.util
import json
from pathlib import Path, PurePosixPath
import re
import struct
import subprocess
import zipfile

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('descent_groups', ROOT / 'scripts/check-descent-groups.py')
GROUPS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(GROUPS)
SPEC = importlib.util.spec_from_file_location('record_reference', ROOT / 'scripts/prepare-record-zip-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
SPEC = importlib.util.spec_from_file_location('fold_reference', ROOT / 'scripts/prepare-record-fold-reference.py')
FOLD_REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(FOLD_REFERENCE)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def instruction_bytes(binary, architecture):
    assert binary[:6] == b'\x7fELF\x02\x01'
    assert struct.unpack_from('<H', binary, 18)[0] == {'x86_64': 62, 'aarch64': 183}[architecture]
    offset = struct.unpack_from('<Q', binary, 40)[0]
    stride, count, names_index = struct.unpack_from('<HHH', binary, 58)
    assert stride == 64 and 0 < names_index < count
    sections = [struct.unpack_from('<IIQQQQIIQQ', binary, offset + index * stride) for index in range(count)]
    names = sections[names_index]
    strings = binary[names[4]:names[4] + names[5]]
    total = 0
    for section in sections:
        name = strings[section[0]:].split(b'\0', 1)[0]
        if name == b'.text' or name.startswith(b'.text.'):
            assert section[1] == 1 and section[2] & 4  # stored executable section
            assert section[4] + section[5] <= len(binary)
            total += section[5]
    assert total > 0
    return total


def check_round(record, order, output_hashes):
    assert record['complete'] and record['order'] == order
    assert [row['label'] for row in record['observations']] == order
    totals = dict.fromkeys(output_hashes, 0)
    for row in record['observations']:
        assert row['status'] == 0 and row['outputMatches']
        assert type(row['elapsedNs']) is int and row['elapsedNs'] > 0
        assert row['stdoutSha256'] == output_hashes[row['label']]
        assert row['stderrSha256'] == digest(b'')
        totals[row['label']] += row['elapsedNs']
    assert record['totalsNs'] == totals
    return totals


def check_profiles(folder, row):
    for label, profile in row['fwpProfiles'].items():
        managed, raw = [json.loads(line) for line in (folder / (label + '-profile.stderr')).read_text().splitlines()]
        raw = raw['rawDerivativeStorage']
        assert profile['managed'] == managed
        assert profile['expandedRawSha256'] == digest(json.dumps(raw, sort_keys=True).encode())
        GROUPS.DESCENT.AD.RAW.check_profile(raw, row['updates'] * row['solvesPerProcess'], True)
        checkpoints = raw.pop('afterBackward')
        assert not checkpoints or all(value == checkpoints[0] for value in checkpoints)
        raw['afterBackwardRepeated'] = dict(count=len(checkpoints), value=checkpoints[0] if checkpoints else None)
        assert profile['rawDerivativeStorage'] == raw
        managed, raw = [json.loads(line) for line in (folder / (label + '-no-workspace.stderr')).read_text().splitlines()]
        assert profile['withoutWorkspace'] == dict(managed=managed, **raw)
        GROUPS.DESCENT.AD.RAW.check_profile(raw['rawDerivativeStorage'], row['updates'] * row['solvesPerProcess'], False)
        phases = json.loads((folder / (label + '-phase-observations.json')).read_text())
        assert row['phaseObservations'][label]['observations'] == phases


def check_reference(folder, report, source, architecture, protocol):
    manifest = json.loads((folder / 'manifest.json').read_text())
    assert manifest == report['referenceCompiler'] and manifest['source'] == source
    assert protocol in ('record-zip', 'record-fold')
    if protocol == 'record-zip':
        source_path, field, saved = 'src/fuse.rs', 'Fusion', 'fusion-reference.rs'
        transform, prepare = 'flat numeric record zip/map fusion', REFERENCE
    else:
        source_path, field, saved = 'src/cgen.rs', 'Codegen', 'codegen-reference.rs'
        transform, prepare = 'direct numeric-record left folds', FOLD_REFERENCE
    assert manifest['disabledTransformation'] == transform
    compiler = (folder / 'fwp').read_bytes()
    assert digest(compiler) == manifest['compilerSha256']
    instruction_bytes(compiler, architecture)
    candidate = subprocess.check_output(['git', 'show', source + ':' + source_path], cwd=ROOT)
    ownership = subprocess.check_output(['git', 'show', source + ':src/ownership.rs'], cwd=ROOT)
    assert digest(candidate) == manifest['candidate' + field + 'Sha256']
    assert digest(ownership) == manifest['ownershipSha256']
    reference = (folder / saved).read_bytes()
    assert digest(reference) == manifest['reference' + field + 'Sha256']
    assert reference == prepare.reference_source(candidate.decode()).encode()
    patch = (folder / 'reference.patch').read_bytes()
    assert digest(patch) == manifest['patchSha256']
    check_reference_patch(patch.decode(), candidate.decode(), reference.decode(), source_path)


def check_reference_patch(patch, candidate, reference, source_path):
    lines = patch.splitlines(keepends=True)
    assert len(lines) >= 4
    assert lines[0] == f'diff --git a/{source_path} b/{source_path}\n'
    assert re.fullmatch(r'index [0-9a-f]+\.\.[0-9a-f]+ 100644\n', lines[1])
    # Git appends a function context to hunk headers; difflib does not.
    actual = [re.sub(r'^(@@ -\d+(?:,\d+)? \+\d+(?:,\d+)? @@)[^\n]*', r'\1', line)
              if line.startswith('@@ ') else line for line in lines[2:]]
    expected = list(difflib.unified_diff(candidate.splitlines(keepends=True),
                    reference.splitlines(keepends=True), fromfile='a/' + source_path, tofile='b/' + source_path))
    assert actual == expected, 'reference patch changes more than the selected eligibility block'


def file_inventory(folder):
    """Read directories or zipfile.Path trees without extracting archives."""
    files = {}
    pending = [('', folder)]
    while pending:
        prefix, directory = pending.pop()
        for child in directory.iterdir():
            name = prefix + child.name
            if child.is_dir():
                pending.append((name + '/', child))
            else:
                assert child.is_file() and name not in files
                raw = child.read_bytes()
                files[name] = dict(bytes=len(raw), sha256=digest(raw))
    return dict(sorted(files.items()))


def check_zip(archive):
    names = archive.namelist()
    assert len(names) == len(set(names)), 'duplicate archive path'
    files = {name for name in names if not name.endswith('/')}
    for name in names:
        path = PurePosixPath(name)
        assert path.parts and not path.is_absolute() and '..' not in path.parts
        assert str(path) == name.rstrip('/')
        assert all(str(parent) not in files for parent in path.parents), 'file shadows archive directory'
        if name.endswith('/'):
            assert str(path) not in files, 'file and directory share an archive path'


def check_directory(folder, source, architecture, session, protocol, reference):
    assert protocol in ('array-lists', 'record-zip', 'record-fold')
    assert (protocol in ('record-zip', 'record-fold')) == (reference is not None)
    report = json.loads((folder / 'comparison.json').read_text())
    GROUPS.check_report(report, source, protocol)
    assert report['machine'] == architecture and report['configuration']['session'] == session
    assert report['results'] == json.loads((folder / 'results.json').read_text())
    assert report['commands'] == json.loads((folder / 'build-commands.json').read_text())
    failures = GROUPS.DESCENT.paired_budget_failures(report['results'], protocol)
    assert failures == json.loads((folder / 'budget-failures.json').read_text())
    for path, checksum in report['sourceHashes'].items():
        assert digest(subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)) == checksum, path
    emitters = [command['command'] for command in report['commands'] if '--emit-c' in command['command']]
    assert len(emitters) == 24
    if protocol == 'array-lists':
        assert len({command[2] for command in emitters}) == 1
        for command in emitters:
            assert command[0] == 'env'
            source_path = next(argument for argument in command if argument.endswith('.fwp'))
            expected = '0' if Path(source_path).stem.endswith('-reference') else '1'
            assert command[1] == 'FWP_ARRAY_FUSION=' + expected
    else:
        check_reference(reference, report, source, architecture, protocol)
        candidates, references = set(), set()
        for command in emitters:
            assert command[1] == 'build'
            source_path = next(argument for argument in command if argument.endswith('.fwp'))
            selected = references if Path(source_path).stem.endswith('-reference') else candidates
            selected.add(command[0])
        assert len(candidates) == len(references) == 1 and candidates.isdisjoint(references)
    for name, row in report['results'].items():
        case = folder / name
        assert row['oracle'] == GROUPS.DESCENT.AD.analytic(row['dimensions'], row['updates'] + 1)
        saved = json.loads((case / 'samples.json').read_text())
        assert saved == {key: row[key] for key in ('orders', 'samplesNs', 'processesPerLabel')}
        for phase, count in [('warmup', 2), ('sample', report['configuration']['samples'])]:
            for index in range(count):
                record = json.loads((case / f'{phase}-{index:03d}.json').read_text())
                totals = check_round(record, row['orders'][index], row['outputSha256'])
                if phase == 'sample':
                    assert totals == {label: values[index] for label, values in row['samplesNs'].items()}
        for label, checksum in row['outputSha256'].items():
            output = (case / (label + '.stdout')).read_bytes()
            assert digest(output) == checksum
            GROUPS.DESCENT.verify(output, row['oracle'], row['solvesPerProcess'])
            rss = (case / (label + '-rss.txt')).read_text()
            match = re.search(r'Maximum resident set size \(kbytes\):\s*(\d+)', rss)
            assert match and int(match[1]) * 1024 == row['peakProcessRssBytes'][label]
        for image, metadata in row['binaries'].items():
            binary = (case / image).read_bytes()
            assert digest(binary) == metadata['sha256'] and len(binary) == metadata['bytes']
            assert instruction_bytes(binary, architecture) == metadata['instructionBytes']
            suffix = '.rs' if image == 'rust-explicit' else '.c'
            assert digest((case / (image + suffix)).read_bytes()) == metadata['sourceSha256']
            assert digest((case / (image + '.asm')).read_bytes()) == metadata['disassemblySha256']
            sections = (case / (image + '.sections')).read_text()
            count = sum(int(size, 16) for size in re.findall(r'^\s*\d+\s+\.text(?:\.[^\s]+)?\s+([0-9a-fA-F]+)', sections, re.M))
            assert count == metadata['instructionBytes']
            if image.startswith('fwp-'):
                symbols = (case / (image + '.symbols')).read_text()
                assert not any(symbol in symbols for symbol in ('fwp_heap_scan', 'fwp_heap_mark_all', 'fwp_heap_sweep'))
        for name, metadata in row['cCompilerStackUsage'].items():
            raw = (case / name).read_bytes()
            assert digest(raw) == metadata['sha256']
            entries = []
            for line in raw.decode().splitlines():
                location, size, qualifier = line.split('\t')
                entries.append(dict(location=location, bytes=int(size), qualifier=qualifier))
            assert entries == metadata['entries']
        for name, control in row['controls'].items():
            assert digest((case / (name + '.stdout')).read_bytes()) == control['stdoutSha256']
            assert (case / (name + '.stderr')).read_text() == control['stderr']
        check_profiles(case, row)
    files = file_inventory(folder)
    if protocol in ('record-zip', 'record-fold'):
        assert len(files) == 1334
    reference_files = file_inventory(reference) if reference is not None else None
    if reference_files is not None:
        saved = {'record-zip': 'fusion-reference.rs', 'record-fold': 'codegen-reference.rs'}[protocol]
        assert set(reference_files) == {'manifest.json', 'fwp', saved, 'reference.patch'}
    return dict(source=source, architecture=architecture, session=session, files=files,
                referenceFiles=reference_files,
                budgetFailures=failures, decision='not-accepted' if failures else 'accepted')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--input-format', choices=['directory', 'zip'], required=True)
    parser.add_argument('--protocol', choices=['array-lists', 'record-zip', 'record-fold'], required=True)
    parser.add_argument('--reference', type=Path)
    parser.add_argument('--source', required=True)
    parser.add_argument('--arch', choices=['x86_64', 'aarch64'], required=True)
    parser.add_argument('--session', type=int, choices=[1, 2], required=True)
    parser.add_argument('--summary', type=Path, required=True)
    args = parser.parse_args()
    with ExitStack() as stack:
        folder = args.input
        reference = args.reference
        if args.input_format == 'zip':
            archive = stack.enter_context(zipfile.ZipFile(args.input))
            check_zip(archive)
            folder = zipfile.Path(archive)
            if args.reference is not None:
                reference_archive = stack.enter_context(zipfile.ZipFile(args.reference))
                check_zip(reference_archive)
                reference = zipfile.Path(reference_archive)
        summary = check_directory(folder, args.source, args.arch, args.session, args.protocol, reference)
    args.summary.write_text(json.dumps(summary, indent=2) + '\n')
    print(f"All six cases audited; {len(summary['budgetFailures'])} original budget failures retained")
