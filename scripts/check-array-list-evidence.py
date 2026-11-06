#!/usr/bin/env python3
"""Recompute paired derivative evidence without executing saved binaries."""
import argparse
import ast
from contextlib import ExitStack
import difflib
import hashlib
import importlib.util
import json
from pathlib import Path, PurePosixPath
import re
import struct
import subprocess
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('descent_groups', ROOT / 'scripts/check-descent-groups.py')
GROUPS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(GROUPS)


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


def recorded_reference(candidate, preparation):
    """Apply the exact literal replacement recorded with the measured source.

    Parse constants only: auditing evidence never executes its saved Python.
    """
    constants = {}
    for node in ast.parse(preparation).body:
        if isinstance(node, ast.Assign):
            for target in node.targets:
                if isinstance(target, ast.Name) and target.id in ('CANDIDATE', 'REFERENCE'):
                    assert target.id not in constants, 'duplicate reference preparation constant'
                    value = ast.literal_eval(node.value)
                    assert isinstance(value, str) and value
                    constants[target.id] = value
    assert set(constants) == {'CANDIDATE', 'REFERENCE'}
    before, after = constants['CANDIDATE'], constants['REFERENCE']
    assert candidate.count(before) == 1 and after not in candidate
    return candidate.replace(before, after)


def recorded_file_edits_reference(candidates, preparation, expected_paths):
    """Read the two literal edits without executing the measured preparer."""
    edits = []
    for node in ast.parse(preparation).body:
        if isinstance(node, ast.Assign):
            for target in node.targets:
                if isinstance(target, ast.Name) and target.id == 'EDITS':
                    edits.append(ast.literal_eval(node.value))
    assert len(edits) == 1
    changes = edits[0]
    assert set(changes) == set(candidates) == set(expected_paths)
    result = {}
    for path, (before, after) in changes.items():
        assert isinstance(before, str) and isinstance(after, str) and before and after
        assert candidates[path].count(before) == 1 and after not in candidates[path]
        result[path] = candidates[path].replace(before, after)
    return result


def recorded_matched_option_reference(candidates, preparation):
    """Read the two selections from literal data without executing saved code."""
    constants = {}
    for node in ast.parse(preparation).body:
        if isinstance(node, ast.Assign):
            for target in node.targets:
                if isinstance(target, ast.Name) and target.id in ('EDITS', 'CHANGED'):
                    assert target.id not in constants, 'duplicate preparation constant'
                    constants[target.id] = ast.literal_eval(node.value)
    assert set(constants) == {'EDITS', 'CHANGED'}
    assert constants['CHANGED'] == 'src/cgen.rs'
    assert set(candidates) == {'src/cgen.rs'}
    changes = constants['EDITS']
    assert isinstance(changes, tuple) and len(changes) == 2
    result = candidates['src/cgen.rs']
    for pair in changes:
        assert isinstance(pair, tuple) and len(pair) == 2
        before, after = pair
        assert isinstance(before, str) and isinstance(after, str) and before and after
        assert result.count(before) == 1 and after not in result
        result = result.replace(before, after)
    return {'src/cgen.rs': result}


def recorded_numeric_reference(candidates, preparation):
    """Rebuild both reference files from saved literals, never saved Python code."""
    constants = {}
    for node in ast.parse(preparation).body:
        if isinstance(node, ast.Assign):
            for target in node.targets:
                if isinstance(target, ast.Name) and target.id in ('CHANGES', 'COMPLETE_TRANSFER'):
                    assert target.id not in constants
                    constants[target.id] = ast.literal_eval(node.value)
    assert set(constants) == {'CHANGES', 'COMPLETE_TRANSFER'}
    assert set(candidates) == set(constants['CHANGES']) == {'src/cgen.rs', 'src/cgen/packed_records.rs'}
    result = {}
    for path, (before, after) in constants['CHANGES'].items():
        assert isinstance(before, str) and isinstance(after, str) and before and after
        assert candidates[path].count(before) == 1 and after not in candidates[path]
        result[path] = candidates[path].replace(before, after)
    before, after = constants['COMPLETE_TRANSFER']
    assert isinstance(before, str) and isinstance(after, str) and before and after
    assert result['src/cgen.rs'].count(before) == 1 and after not in result['src/cgen.rs']
    result['src/cgen.rs'] = result['src/cgen.rs'].replace(before, after)
    return result


def check_numeric_reference(folder, manifest, source, architecture):
    assert manifest['scope'] == 'callback-owners'
    assert manifest['disabledTransformation'] == 'complete field transfers and numeric callback input owners'
    assert set(manifest['files']) == {'src/cgen.rs', 'src/cgen/packed_records.rs'}
    assert set(manifest['unchanged']) == {'src/ownership.rs', 'src/cgen/field_transfers.rs', 'src/cgen/numeric_parameters.rs'}
    compiler = (folder / 'fwp').read_bytes()
    assert digest(compiler) == manifest['compilerSha256']
    instruction_bytes(compiler, architecture)
    candidates = {path: subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT).decode()
                  for path in manifest['files']}
    preparation = subprocess.check_output(['git', 'show', source + ':scripts/prepare-numeric-input-reference.py'],
                                          cwd=ROOT, text=True)
    expected = recorded_numeric_reference(candidates, preparation)
    patch = (folder / 'reference.patch').read_bytes()
    assert digest(patch) == manifest['patchSha256']
    patches = re.split(r'(?=^diff --git )', patch.decode(), flags=re.MULTILINE)
    assert patches[0] == '' and len(patches) == 3
    for (path, reference), difference in zip(sorted(expected.items()), patches[1:]):
        assert digest(candidates[path].encode()) == manifest['files'][path]['candidateSha256']
        saved = (folder / ('reference-' + Path(path).name)).read_bytes()
        assert saved == reference.encode() and digest(saved) == manifest['files'][path]['referenceSha256']
        check_reference_patch(difference, candidates[path], reference, path)
    for path, expected_hash in manifest['unchanged'].items():
        assert digest(subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)) == expected_hash


def recorded_gradient_reference(candidates, patch):
    """Reconstruct all seven sources from the saved patch, never saved Python."""
    assert set(candidates) == {'lib/autodiff.fwp', 'runtime/fwp_rt_kernel.c', 'src/cgen.rs', 'src/fuse.rs', 'src/interp.rs', 'src/ir.rs', 'src/numerics.rs'}
    headers = re.findall(rb'^diff --git a/([^\n ]+) b/([^\n ]+)$', patch, re.MULTILINE)
    assert headers == [(name.encode(), name.encode()) for name in sorted(candidates)]
    with tempfile.TemporaryDirectory(prefix='fwp-gradient-audit-') as directory:
        root = Path(directory)
        for name, data in candidates.items():
            path = root / name
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_bytes(data)
        patch_path = root / 'candidate.patch'
        patch_path.write_bytes(patch)
        result = subprocess.run(['git', 'apply', '--reverse', str(patch_path)],
                                cwd=root, capture_output=True)
        assert result.returncode == 0, result.stderr.decode()
        assert {str(path.relative_to(root)) for path in root.rglob('*') if path.is_file()} == set(candidates) | {'candidate.patch'}
        assert all(not (root / name).is_symlink() and not (root / name).stat().st_mode & 0o111 for name in candidates)
        restored = {name: (root / name).read_bytes() for name in candidates}
        assert all(restored[name] != candidates[name] for name in candidates)
        return restored


def check_gradient_reference(folder, manifest, source, architecture):
    assert manifest['disabledTransformation'] == 'owned gradient arrays and direct array/list zip'
    assert set(manifest['candidate']) == set(manifest['reference']) == {'lib/autodiff.fwp', 'runtime/fwp_rt_kernel.c', 'src/cgen.rs', 'src/fuse.rs', 'src/interp.rs', 'src/ir.rs', 'src/numerics.rs'}
    candidates = {name: subprocess.check_output(['git', 'show', source + ':' + name], cwd=ROOT)
                  for name in manifest['candidate']}
    frozen = subprocess.check_output(['git', 'show', source + ':scripts/gradient-array-candidate.patch'], cwd=ROOT)
    assert digest(frozen) == manifest['frozenPatchSha256']
    expected = recorded_gradient_reference(candidates, frozen)
    compiler = (folder / 'fwp').read_bytes()
    assert digest(compiler) == manifest['compilerSha256']
    instruction_bytes(compiler, architecture)
    patch = (folder / 'reference.patch').read_bytes()
    assert digest(patch) == manifest['patchSha256']
    # Git and difflib can choose different valid hunk boundaries. Verify the
    # applied source, not one textual presentation of the same change.
    assert recorded_gradient_reference(expected, patch) == candidates
    for name, reference in expected.items():
        assert digest(candidates[name]) == manifest['candidate'][name]
        saved = (folder / 'source' / name).read_bytes()
        assert saved == reference and digest(saved) == manifest['reference'][name]
    ownership = subprocess.check_output(['git', 'show', source + ':src/ownership.rs'], cwd=ROOT)
    assert digest(ownership) == manifest['ownershipSha256']


def check_reference(folder, report, source, architecture, protocol):
    reference_files = file_inventory(folder)
    if protocol == 'callback-owners':
        assert set(reference_files) == {'manifest.json', 'fwp', 'reference-cgen.rs', 'reference-packed_records.rs', 'reference.patch'}
    elif protocol == 'gradient-array':
        assert set(reference_files) == {'manifest.json', 'fwp', 'reference.patch'} | {
            'source/' + name for name in ('lib/autodiff.fwp', 'runtime/fwp_rt_kernel.c', 'src/cgen.rs', 'src/fuse.rs', 'src/interp.rs', 'src/ir.rs', 'src/numerics.rs')}
    elif protocol == 'gradient-call':
        assert set(reference_files) == {'manifest.json', 'fwp', 'reference.patch', 'source/src/cgen.rs', 'source/lib/autodiff.fwp'}
    elif protocol == 'recording-inline':
        assert set(reference_files) == {'manifest.json', 'fwp', 'reference.patch', 'source/runtime/fwp_rt_kernel.c'}
    elif protocol in ('matched-option', 'owned-numeric', 'packed-pair', 'scalar-constant', 'recording-lookup'):
        assert set(reference_files) == {'manifest.json', 'fwp', 'reference.patch', 'source/src/cgen.rs'}
    elif protocol == 'packed-input':
        assert set(reference_files) == {'manifest.json', 'fwp', 'reference.patch', 'source/src/cgen.rs', 'source/src/mono.rs'}
    elif protocol == 'final-iteration':
        assert set(reference_files) == {'manifest.json', 'fwp', 'reference.patch', 'source/lib/list.fwp', 'source/src/fuse.rs'}
    else:
        saved = {'scalar-array-identity': 'optimizer-reference.rs', 'record-zip': 'fusion-reference.rs', 'record-fold': 'codegen-reference.rs',
                 'packed-records': 'codegen-reference.rs', 'scalar-map-zip': 'codegen-reference.rs', 'range-zip': 'codegen-reference.rs', 'scalar-array-map': 'codegen-reference.rs'}[protocol]
        assert set(reference_files) == {'manifest.json', 'fwp', saved, 'reference.patch'}
    manifest = json.loads((folder / 'manifest.json').read_text())
    assert manifest == report['referenceCompiler'] and manifest['source'] == source
    if protocol == 'matched-option':
        assert manifest['disabledTransformation'] == 'direct fields for matched list last, nth and final iteration results'
        assert set(manifest['candidate']) == set(manifest['reference']) == {'src/cgen.rs'}
        assert set(manifest['unchanged']) == {'src/fuse.rs', 'src/prims_std.rs', 'src/ownership.rs', 'src/opt.rs', 'runtime/fwp_rt.c', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt_task.c', 'runtime/fwp_rt_heap.c', 'lib/list.fwp', 'lib/autodiff.fwp'}
        compiler = (folder / 'fwp').read_bytes()
        assert digest(compiler) == manifest['compilerSha256']
        instruction_bytes(compiler, architecture)
        candidates = {}
        for path, checksum in manifest['candidate'].items():
            data = subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)
            assert digest(data) == checksum, path
            candidates[path] = data.decode()
        for path, checksum in manifest['unchanged'].items():
            data = subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)
            assert digest(data) == checksum, path
        assert manifest['ownershipSha256'] == manifest['unchanged']['src/ownership.rs']
        preparation = subprocess.check_output(['git', 'show', source + ':scripts/prepare-matched-option-reference.py'], cwd=ROOT, text=True)
        expected = recorded_matched_option_reference(candidates, preparation)
        patch = (folder / 'reference.patch').read_bytes()
        assert digest(patch) == manifest['patchSha256']
        sections = re.split(r'(?=^diff --git )', patch.decode(), flags=re.M)
        assert sections[0] == '' and len(sections) == 2
        for path, section in zip(sorted(expected), sections[1:]):
            data = (folder / 'source' / path).read_bytes()
            assert data == expected[path].encode() and digest(data) == manifest['reference'][path]
            check_reference_patch(section, candidates[path], expected[path], path)
        return
    if protocol in ('owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline'):
        gradient = protocol == 'gradient-call'
        expected_paths = {'src/cgen.rs', 'lib/autodiff.fwp'} if gradient else {'src/cgen.rs'}
        expected_transformation = 'scoped input borrowing, numeric fold fields, single-root seeding and consumed array scratch' if gradient else 'consuming scalar array maps and exclusive coordinate-list reuse'
        if protocol == 'packed-pair':
            expected_transformation = 'reuse of the consumed private neighboring-record buffer'
        if protocol == 'scalar-constant':
            expected_transformation = 'exact immediate scalar constants and acyclic cached aliases'
        if protocol == 'recording-lookup':
            expected_transformation = 'validated tape lookup reuse within bounded nonsuspending numeric workers'
        if protocol == 'recording-inline':
            expected_paths = {'runtime/fwp_rt_kernel.c'}
            expected_transformation = 'forced inlining of the checked F64 scalar append body'
        assert manifest['disabledTransformation'] == expected_transformation
        assert set(manifest['candidate']) == set(manifest['reference']) == expected_paths
        expected_preserved = set(('src/ownership.rs', 'src/ir.rs', 'src/rc.rs', 'src/rc/borrows.rs', 'src/cgen/owned_numeric.rs', 'src/cgen/scoped_calls.rs', 'src/cgen/fold_fields.rs', 'src/opt/scoped.rs', 'src/cgen/packed_inputs.rs', 'src/cgen/numeric_parameters.rs', 'src/cgen/packed_records.rs', 'src/cgen/range_zip.rs', 'src/fuse.rs', 'src/opt.rs', 'runtime/fwp_rt.c', 'runtime/fwp_rt_heap.c', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt_task.c', 'runtime/fwp_rt_kernel.c', 'src/numerics.rs', 'src/interp.rs', 'lib/list.fwp')) if gradient else {'src/ir.rs', 'src/rc.rs', 'src/rc/borrows.rs', 'src/cgen/owned_numeric.rs', 'runtime/fwp_rt_task.c', 'runtime/fwp_rt_heap.c', 'src/cgen/packed_inputs.rs', 'src/cgen/numeric_parameters.rs', 'src/fuse.rs', 'runtime/fwp_rt_prims.c', 'src/ownership.rs', 'src/opt/scoped.rs', 'runtime/fwp_rt.c', 'runtime/fwp_rt_kernel.c', 'src/opt.rs', 'lib/list.fwp', 'src/cgen/range_zip.rs', 'lib/autodiff.fwp', 'src/cgen/packed_records.rs'}
        if protocol in ('packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline'):
            expected_preserved |= {'src/escape.rs', 'src/cgen/scoped_calls.rs',
                                   'src/cgen/fold_fields.rs', 'src/numerics.rs', 'src/interp.rs'}
        if protocol in ('scalar-constant', 'recording-lookup', 'recording-inline'):
            expected_preserved.add('src/cgen/constant_values.rs')
        if protocol in ('recording-lookup', 'recording-inline'):
            expected_preserved.add('src/cgen/recording.rs')
        if protocol == 'recording-inline':
            expected_preserved.remove('runtime/fwp_rt_kernel.c')
            expected_preserved.add('src/cgen.rs')
        assert set(manifest['unchanged']) == expected_preserved
        compiler = (folder / 'fwp').read_bytes()
        assert digest(compiler) == manifest['compilerSha256']
        instruction_bytes(compiler, architecture)
        candidates = {}
        for path, checksum in manifest['candidate'].items():
            data = subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)
            assert digest(data) == checksum, path
            candidates[path] = data.decode()
        for path, checksum in manifest['unchanged'].items():
            data = subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)
            assert digest(data) == checksum, path
        assert manifest['ownershipSha256'] == manifest['unchanged']['src/ownership.rs']
        preparation = subprocess.check_output(['git', 'show', source + ':scripts/prepare-' + protocol + '-reference.py'], cwd=ROOT, text=True)
        expected = recorded_file_edits_reference(candidates, preparation, expected_paths)
        patch = (folder / 'reference.patch').read_bytes()
        assert digest(patch) == manifest['patchSha256']
        sections = re.split(r'(?=^diff --git )', patch.decode(), flags=re.M)
        assert sections[0] == '' and len(sections) == len(expected_paths) + 1
        for path, section in zip(sorted(expected), sections[1:]):
            data = (folder / 'source' / path).read_bytes()
            assert data == expected[path].encode() and digest(data) == manifest['reference'][path]
            check_reference_patch(section, candidates[path], expected[path], path)
        return
    if protocol == 'packed-input':
        assert manifest['disabledTransformation'] == 'scoped objective specialization and private numeric input packing'
        assert set(manifest['candidate']) == set(manifest['reference']) == {'src/mono.rs', 'src/cgen.rs'}
        assert set(manifest['unchanged']) == {'runtime/fwp_rt_task.c', 'runtime/fwp_rt_heap.c', 'src/cgen/packed_inputs.rs', 'src/cgen/numeric_parameters.rs', 'src/fuse.rs', 'runtime/fwp_rt_prims.c', 'src/ownership.rs', 'src/opt/scoped.rs', 'runtime/fwp_rt.c', 'runtime/fwp_rt_kernel.c', 'src/opt.rs', 'lib/list.fwp', 'src/cgen/range_zip.rs', 'lib/autodiff.fwp', 'src/cgen/packed_records.rs'}
        compiler = (folder / 'fwp').read_bytes()
        assert digest(compiler) == manifest['compilerSha256']
        instruction_bytes(compiler, architecture)
        candidates = {}
        for path, checksum in manifest['candidate'].items():
            data = subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)
            assert digest(data) == checksum, path
            candidates[path] = data.decode()
        for path, checksum in manifest['unchanged'].items():
            data = subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)
            assert digest(data) == checksum, path
        assert manifest['ownershipSha256'] == manifest['unchanged']['src/ownership.rs']
        preparation = subprocess.check_output(['git', 'show', source + ':scripts/prepare-packed-input-reference.py'], cwd=ROOT, text=True)
        expected = recorded_file_edits_reference(candidates, preparation, {'src/mono.rs', 'src/cgen.rs'})
        patch = (folder / 'reference.patch').read_bytes()
        assert digest(patch) == manifest['patchSha256']
        sections = re.split(r'(?=^diff --git )', patch.decode(), flags=re.M)
        assert sections[0] == '' and len(sections) == 3
        for path, section in zip(sorted(expected), sections[1:]):
            data = (folder / 'source' / path).read_bytes()
            assert data == expected[path].encode() and digest(data) == manifest['reference'][path]
            check_reference_patch(section, candidates[path], expected[path], path)
        return
    if protocol == 'final-iteration':
        assert manifest['disabledTransformation'] == 'direct list last and unused numeric iteration history removal'
        assert set(manifest['candidate']) == set(manifest['reference']) == {'src/fuse.rs', 'lib/list.fwp'}
        assert set(manifest['unchanged']) == {'src/cgen.rs', 'src/prims_std.rs', 'src/ownership.rs', 'src/opt.rs', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt_heap.c', 'lib/autodiff.fwp'}
        compiler = (folder / 'fwp').read_bytes()
        assert digest(compiler) == manifest['compilerSha256']
        instruction_bytes(compiler, architecture)
        candidates = {}
        for path, checksum in manifest['candidate'].items():
            data = subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)
            assert digest(data) == checksum, path
            candidates[path] = data.decode()
        for path, checksum in manifest['unchanged'].items():
            data = subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)
            assert digest(data) == checksum, path
        assert manifest['ownershipSha256'] == manifest['unchanged']['src/ownership.rs']
        preparation = subprocess.check_output(['git', 'show', source + ':scripts/prepare-final-iteration-reference.py'], cwd=ROOT, text=True)
        expected = recorded_file_edits_reference(candidates, preparation, {'src/fuse.rs', 'lib/list.fwp'})
        patch = (folder / 'reference.patch').read_bytes()
        assert digest(patch) == manifest['patchSha256']
        sections = re.split(r'(?=^diff --git )', patch.decode(), flags=re.M)
        assert sections[0] == '' and len(sections) == 3
        for path, section in zip(sorted(expected), sections[1:]):
            data = (folder / 'source' / path).read_bytes()
            assert data == expected[path].encode() and digest(data) == manifest['reference'][path]
            check_reference_patch(section, candidates[path], expected[path], path)
        return
    if protocol == 'gradient-array':
        check_gradient_reference(folder, manifest, source, architecture)
        return
    if protocol == 'callback-owners':
        check_numeric_reference(folder, manifest, source, architecture)
        return
    assert protocol in ('record-zip', 'record-fold', 'packed-records', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline')
    if protocol == 'scalar-array-identity':
        source_path, field, saved = 'src/opt.rs', 'Optimizer', 'optimizer-reference.rs'
        transform = 'F64 identity array-map elimination'
        assert set(manifest['unchanged']) == {'src/interp.rs', 'runtime/fwp_rt_num.c', 'src/cgen.rs'}
        for path, checksum in manifest['unchanged'].items():
            data = subprocess.check_output(['git', 'show', source + ':' + path], cwd=ROOT)
            assert digest(data) == checksum, path
    elif protocol == 'record-zip':
        source_path, field, saved = 'src/fuse.rs', 'Fusion', 'fusion-reference.rs'
        transform = 'flat numeric record zip/map fusion'
    else:
        source_path, field, saved = 'src/cgen.rs', 'Codegen', 'codegen-reference.rs'
        transform = ('direct closed scalar array map callbacks' if protocol == 'scalar-array-map'
                     else 'private range-to-zip storage' if protocol == 'range-zip'
                        else 'scalar map-to-zip buffer storage' if protocol == 'scalar-map-zip'
                     else 'packed temporary numeric-record storage' if protocol == 'packed-records'
                     else 'direct numeric-record left folds')
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
    preparation = subprocess.check_output(
        ['git', 'show', source + ':scripts/prepare-' + protocol + '-reference.py'],
        cwd=ROOT, text=True)
    assert reference == recorded_reference(candidate.decode(), preparation).encode()
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


def scalar_image_representation(image):
    if image == 'fwp-ad-identical':
        return 'literal'
    match = re.fullmatch(r'fwp-ad(?:-history)?(-reference)?(?:-profile|-phases)?', image)
    assert match, ('unknown scalar comparison image', image)
    return 'cached' if match[1] else 'literal'


def check_directory(folder, source, architecture, session, protocol, reference):
    assert protocol in ('array-lists', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline')
    assert (protocol in ('record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline')) == (reference is not None)
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
                if protocol == 'recording-inline':
                    GROUPS.DESCENT.RECORDING_SELECTION.check_inline_declaration((case / (image + '.c')).read_text(), scalar_image_representation(image) == 'literal')
                    if row['updates'] > 0:
                        GROUPS.DESCENT.RECORDING_SELECTION.check((case / (image + '.c')).read_text(), True)
                if protocol == 'recording-lookup' and row['updates'] > 0:
                    GROUPS.DESCENT.RECORDING_SELECTION.check((case / (image + '.c')).read_text(), scalar_image_representation(image) == 'literal')
                if protocol == 'scalar-constant' and row['updates'] > 0:
                    GROUPS.DESCENT.SCALAR_SELECTION.check((case / (image + '.c')).read_text(), scalar_image_representation(image))
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
    if protocol in ('record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline'):
        assert len(files) == 1334
    reference_files = file_inventory(reference) if reference is not None else None
    return dict(source=source, architecture=architecture, session=session, files=files,
                referenceFiles=reference_files,
                budgetFailures=failures, decision='not-accepted' if failures else 'accepted')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--input-format', choices=['directory', 'zip'], required=True)
    parser.add_argument('--protocol', choices=['array-lists', 'record-zip', 'record-fold', 'packed-records', 'callback-owners', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'final-iteration', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call', 'packed-pair', 'scalar-constant', 'recording-lookup', 'recording-inline'], required=True)
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
