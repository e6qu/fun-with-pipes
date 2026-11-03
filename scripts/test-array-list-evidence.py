#!/usr/bin/env python3
"""Reject altered numeric observations and preserve failed acceptance limits."""
import copy
import difflib
import gzip
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import subprocess
import tarfile
import tempfile
import unittest
import warnings
import zipfile

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('array_evidence', ROOT / 'scripts/check-array-list-evidence.py')
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
SPEC = importlib.util.spec_from_file_location('zip_reference', ROOT / 'scripts/prepare-record-zip-reference.py')
ZIP_REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(ZIP_REFERENCE)
SPEC = importlib.util.spec_from_file_location('fold_reference', ROOT / 'scripts/prepare-record-fold-reference.py')
FOLD_REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(FOLD_REFERENCE)
SPEC = importlib.util.spec_from_file_location('packed_reference', ROOT / 'scripts/prepare-packed-records-reference.py')
PACKED_REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PACKED_REFERENCE)
SPEC = importlib.util.spec_from_file_location('numeric_reference', ROOT / 'scripts/prepare-numeric-input-reference.py')
NUMERIC_REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(NUMERIC_REFERENCE)
SOURCE = 'dc0a6407b5e5aa23517a86db71a3221a418cc7d6'
REPORT = json.loads(gzip.decompress((ROOT / 'docs/measurements/array-list-first-2026-10-31-amd-2.json.gz').read_bytes()))


class Evidence(unittest.TestCase):
    def test_zip_inventory_matches_directory_without_extraction(self):
        contents = {'report.json': b'{"complete": true}', 'case/image': b'ELF fixture',
                    'case/logs/stdout': b'1\n'}
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            stream = io.BytesIO()
            with zipfile.ZipFile(stream, 'w') as archive:
                for name, raw in contents.items():
                    archive.writestr(name, raw)
                    path = root / name
                    path.parent.mkdir(parents=True, exist_ok=True)
                    path.write_bytes(raw)
            with zipfile.ZipFile(stream) as archive:
                CHECK.check_zip(archive)
                self.assertEqual(CHECK.file_inventory(zipfile.Path(archive)), CHECK.file_inventory(root))

    def test_zip_paths_cannot_escape_repeat_or_change_spelling(self):
        for name in ['/absolute', '../parent', 'nested/../parent', './local', 'a//b',
                     'file', 'file/', 'file/child', '.', './']:
            stream = io.BytesIO()
            with warnings.catch_warnings():
                warnings.simplefilter('ignore', UserWarning)
                with zipfile.ZipFile(stream, 'w') as archive:
                    archive.writestr('file', b'original')
                    archive.writestr(name, b'changed')
            with zipfile.ZipFile(stream) as archive, self.subTest(name=name), self.assertRaises(AssertionError):
                CHECK.check_zip(archive)

    def test_reference_patch_is_exact_and_preserves_other_source(self):
        candidate = (ROOT / 'src/fuse.rs').read_text()
        reference = ZIP_REFERENCE.reference_source(candidate)
        header = 'diff --git a/src/fuse.rs b/src/fuse.rs\nindex 1234567..2345678 100644\n'
        body = ''.join(difflib.unified_diff(candidate.splitlines(keepends=True),
                       reference.splitlines(keepends=True), fromfile='a/src/fuse.rs', tofile='b/src/fuse.rs'))
        patch = header + body
        CHECK.check_reference_patch(patch, candidate, reference, 'src/fuse.rs')
        for changed in [patch.replace('a/src/fuse.rs', 'a/src/opt.rs'),
                        patch.replace('+fn zip_map_element(', '+fn broken('),
                        patch + header + body,
                        patch.replace('-fn zip_map_element(', '-fn broken(')]:
            self.assertNotEqual(changed, patch)
            with self.assertRaises(AssertionError):
                CHECK.check_reference_patch(changed, candidate, reference, 'src/fuse.rs')

    def test_fold_reference_patch_changes_only_the_selected_call(self):
        candidate = (ROOT / 'src/cgen.rs').read_text()
        reference = FOLD_REFERENCE.reference_source(candidate)
        header = 'diff --git a/src/cgen.rs b/src/cgen.rs\nindex 1234567..2345678 100644\n'
        patch = header + ''.join(difflib.unified_diff(candidate.splitlines(keepends=True),
                    reference.splitlines(keepends=True), fromfile='a/src/cgen.rs', tofile='b/src/cgen.rs'))
        CHECK.check_reference_patch(patch, candidate, reference, 'src/cgen.rs')
        for changed in [patch.replace('a/src/cgen.rs', 'a/src/fuse.rs'), patch + header,
                        patch.replace('direct record folds disabled', 'other change')]:
            self.assertNotEqual(changed, patch)
            with self.assertRaises(AssertionError):
                CHECK.check_reference_patch(changed, candidate, reference, 'src/cgen.rs')

    def test_combined_reference_is_reconstructed_without_executing_saved_code(self):
        candidates = {path: (ROOT / path).read_text() for path in NUMERIC_REFERENCE.CHANGES}
        preparation = (ROOT / 'scripts/prepare-numeric-input-reference.py').read_text()
        expected = NUMERIC_REFERENCE.reference_sources(candidates, 'callback-owners')
        self.assertEqual(CHECK.recorded_numeric_reference(candidates, preparation), expected)
        self.assertEqual(CHECK.recorded_numeric_reference(candidates,
            'raise RuntimeError("must never run")\n' + preparation), expected)
        for name, (before, _) in NUMERIC_REFERENCE.CHANGES.items():
            changed = dict(candidates)
            changed[name] = changed[name].replace(before, '')
            with self.assertRaises(AssertionError):
                CHECK.recorded_numeric_reference(changed, preparation)
        for changed in (preparation + '\nCHANGES = {}\n',
                        preparation.replace('COMPLETE_TRANSFER =', 'OTHER ='),
                        preparation.replace('CHANGES = {', 'CHANGES = call({').replace('\nCOMPLETE_TRANSFER', ')\nCOMPLETE_TRANSFER', 1)):
            with self.assertRaises((AssertionError, ValueError, SyntaxError)):
                CHECK.recorded_numeric_reference(candidates, changed)
        for path, reference in expected.items():
            candidate = candidates[path]
            header = f'diff --git a/{path} b/{path}\nindex 1234567..2345678 100644\n'
            patch = header + ''.join(difflib.unified_diff(candidate.splitlines(keepends=True),
                    reference.splitlines(keepends=True), fromfile='a/' + path, tofile='b/' + path))
            CHECK.check_reference_patch(patch, candidate, reference, path)

    def test_packed_reference_patch_and_recorded_preparation_are_exact(self):
        candidate = (ROOT / 'src/cgen.rs').read_text()
        preparation = (ROOT / 'scripts/prepare-packed-records-reference.py').read_text()
        reference = PACKED_REFERENCE.reference_source(candidate)
        self.assertEqual(CHECK.recorded_reference(candidate, preparation), reference)
        header = 'diff --git a/src/cgen.rs b/src/cgen.rs\nindex 1234567..2345678 100644\n'
        patch = header + ''.join(difflib.unified_diff(candidate.splitlines(keepends=True),
                    reference.splitlines(keepends=True), fromfile='a/src/cgen.rs', tofile='b/src/cgen.rs'))
        CHECK.check_reference_patch(patch, candidate, reference, 'src/cgen.rs')
        with self.assertRaises(AssertionError):
            CHECK.check_reference_patch(patch.replace('+    let packed_program = if false',
                '+    let packed_program = if true'), candidate, reference, 'src/cgen.rs')

    def test_scalar_map_reference_reconstruction_preserves_other_transformations(self):
        candidate = (ROOT / 'src/cgen.rs').read_text()
        preparation = (ROOT / 'scripts/prepare-scalar-map-zip-reference.py').read_text()
        reference = CHECK.recorded_reference(candidate, preparation)
        self.assertEqual(reference, candidate.replace(
            '    scalar_map_zip::lower(&mut numeric_program);\n',
            '    if false { scalar_map_zip::lower(&mut numeric_program); }\n'))
        self.assertNotEqual(candidate, reference)
        self.assertEqual(CHECK.recorded_reference(candidate,
            'raise RuntimeError("must not execute saved code")\n' + preparation), reference)
        header = 'diff --git a/src/cgen.rs b/src/cgen.rs\nindex 1234567..2345678 100644\n'
        patch = header + ''.join(difflib.unified_diff(candidate.splitlines(keepends=True),
                    reference.splitlines(keepends=True), fromfile='a/src/cgen.rs', tofile='b/src/cgen.rs'))
        CHECK.check_reference_patch(patch, candidate, reference, 'src/cgen.rs')
        with self.assertRaises(AssertionError):
            CHECK.check_reference_patch(patch.replace('+    if false', '+    if true'),
                                        candidate, reference, 'src/cgen.rs')

    def test_range_reference_reconstruction_preserves_other_transformations(self):
        candidate = (ROOT / 'src/cgen.rs').read_text()
        preparation = (ROOT / 'scripts/prepare-range-zip-reference.py').read_text()
        reference = CHECK.recorded_reference(candidate, preparation)
        self.assertEqual(reference, candidate.replace(
            '    range_zip::lower(&mut numeric_program);\n',
            '    if false { range_zip::lower(&mut numeric_program); }\n'))
        self.assertNotEqual(candidate, reference)
        self.assertEqual(CHECK.recorded_reference(candidate,
            'raise RuntimeError("must not execute saved code")\n' + preparation), reference)
        header = 'diff --git a/src/cgen.rs b/src/cgen.rs\nindex 1234567..2345678 100644\n'
        patch = header + ''.join(difflib.unified_diff(candidate.splitlines(keepends=True),
                    reference.splitlines(keepends=True), fromfile='a/src/cgen.rs', tofile='b/src/cgen.rs'))
        CHECK.check_reference_patch(patch, candidate, reference, 'src/cgen.rs')
        with self.assertRaises(AssertionError):
            CHECK.check_reference_patch(patch.replace('+    if false', '+    if true'),
                                        candidate, reference, 'src/cgen.rs')

    def test_direct_array_map_reference_uses_actual_git_patch_and_preserves_storage(self):
        candidate = (ROOT / 'src/cgen.rs').read_text()
        preparation = (ROOT / 'scripts/prepare-scalar-array-map-reference.py').read_text()
        reference = CHECK.recorded_reference(candidate, preparation)
        selected = '        if matches!(&self.g.prog.funcs[id].body, Body::Prim(s) if s == "array.map") {\n'
        self.assertEqual(reference, candidate.replace(selected, selected.replace('if matches!', 'if false && matches!')))
        self.assertNotEqual(candidate, reference)
        self.assertEqual(CHECK.recorded_reference(candidate,
            'raise RuntimeError("must not execute saved code")\n' + preparation), reference)
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            (root / 'src').mkdir()
            path = root / 'src/cgen.rs'
            path.write_text(candidate)
            subprocess.run(['git', '-c', 'init.defaultBranch=main', 'init', '-q'], cwd=root, check=True)
            subprocess.run(['git', 'add', 'src/cgen.rs'], cwd=root, check=True)
            path.write_text(reference)
            patch = subprocess.check_output(['git', 'diff', '--', 'src/cgen.rs'], cwd=root, text=True)
        CHECK.check_reference_patch(patch, candidate, reference, 'src/cgen.rs')
        with self.assertRaises(AssertionError):
            CHECK.check_reference_patch(patch.replace('if false && matches!', 'if true && matches!'),
                                        candidate, reference, 'src/cgen.rs')

    def test_identity_map_reference_preserves_scalar_fix_and_uses_actual_patch(self):
        candidate = (ROOT / 'src/opt.rs').read_text()
        preparation = (ROOT / 'scripts/prepare-scalar-array-identity-reference.py').read_text()
        reference = CHECK.recorded_reference(candidate, preparation)
        selected = '        if callee.arity == 2 && matches!(&callee.body, Body::Prim(symbol) if symbol == "array.map")\n'
        self.assertEqual(reference, candidate.replace(selected, selected.replace('if callee.arity', 'if false && callee.arity')))
        self.assertNotEqual(candidate, reference)
        self.assertEqual(CHECK.recorded_reference(candidate,
            'raise RuntimeError("must not execute saved code")\n' + preparation), reference)
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            (root / 'src').mkdir()
            path = root / 'src/opt.rs'
            path.write_text(candidate)
            subprocess.run(['git', '-c', 'init.defaultBranch=main', 'init', '-q'], cwd=root, check=True)
            subprocess.run(['git', 'add', 'src/opt.rs'], cwd=root, check=True)
            path.write_text(reference)
            patch = subprocess.check_output(['git', 'diff', '--', 'src/opt.rs'], cwd=root, text=True)
        CHECK.check_reference_patch(patch, candidate, reference, 'src/opt.rs')
        with self.assertRaises(AssertionError):
            CHECK.check_reference_patch(patch.replace('if false && callee.arity', 'if true && callee.arity'),
                                        candidate, reference, 'src/opt.rs')

    def test_recorded_fold_preparation_is_independent_of_current_codegen(self):
        revision = '55d46cd57425fe9f5bb65a1b83a7d12821445711'
        old = subprocess.check_output(['git', 'show', revision + ':src/cgen.rs'],
                                      cwd=ROOT, text=True)
        prepared = subprocess.check_output(
            ['git', 'show', revision + ':scripts/prepare-record-fold-reference.py'],
            cwd=ROOT, text=True)
        current = (ROOT / 'src/cgen.rs').read_text()
        current_preparation = (ROOT / 'scripts/prepare-record-fold-reference.py').read_text()
        self.assertNotEqual(prepared, current_preparation)
        restored = CHECK.recorded_reference(old, prepared)
        self.assertIn('direct record folds disabled', restored)
        self.assertNotIn('return Some(format!("fwp_record_fold{g}({z}, {xs})"));', restored)
        self.assertEqual(CHECK.recorded_reference(current, current_preparation),
                         FOLD_REFERENCE.reference_source(current))
        with self.assertRaises(AssertionError):
            CHECK.recorded_reference(old, current_preparation)
        with self.assertRaises(AssertionError):
            CHECK.recorded_reference(current, prepared)
        # Saved code is read as data, never imported or executed.
        self.assertEqual(CHECK.recorded_reference(old, 'raise RuntimeError("not executed")\n' + prepared), restored)
        for damaged in (prepared + '\nCANDIDATE = "duplicate"\n',
                        prepared.replace('REFERENCE = ', 'OTHER = ', 1)):
            with self.assertRaises(AssertionError):
                CHECK.recorded_reference(old, damaged)

    def test_retained_reports_preserve_both_failed_and_repaired_decisions(self):
        archives = [
            ('dc0a6407', SOURCE, 'array-lists-first',
             {('x86_64', 2): 20, ('aarch64', 2): 20},
             '0fb471b4743980b3c5a886513fa273cd9e8042d40282e62e80715b24a493a293'),
            ('9a2e954e', '9a2e954e1526b510f11025aa256dda74692cac53', 'array-lists-repaired',
             {('x86_64', 2): 0, ('aarch64', 2): 0},
             'a83aa024e11318cb2f65af151ec70271089b0449226f8093408ae0761e22c607'),
            ('9d47a5fc', '9d47a5fcfb5c9342d9fca9da2a8c162f5ac1d38c', 'swift-allocations',
             {('x86_64', 1): 1, ('x86_64', 2): 0, ('aarch64', 1): 0, ('aarch64', 2): 0},
             '095c3ff58d5901c31cd94f26ac3309eaa1c05c652d063460689793d866ce884c'),
            ('f7f5309c', 'f7f5309c2de142149adc47e35da081c90c1adcc6', 'array-lists-pure-constructors',
             {('x86_64', 1): 0, ('x86_64', 2): 1, ('aarch64', 1): 0, ('aarch64', 2): 0},
             'fe662ed86f19b06476c1806ba47c0843aaf4463dcc8fcea9dc59f626769e087d'),
        ]
        for short, source, tag, expected, checksum in archives:
            with self.subTest(source=source):
                path = ROOT / f'docs/measurements/array-lists-{short}.tar.xz'
                self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(), checksum)
                self.assertEqual(subprocess.check_output(
                    ['git', 'rev-parse', f'roadmap/{tag}-2026-11-01'],
                    cwd=ROOT, text=True).strip(), source)
                audits, reports = {}, {}
                with tarfile.open(path, 'r|xz') as archive:
                    for member in archive:
                        relative = Path(member.name)
                        self.assertFalse(relative.is_absolute() or '..' in relative.parts)
                        if not member.isfile():
                            self.assertTrue(member.isdir())
                            continue
                        if relative.name.startswith('audit-') and relative.suffix == '.json':
                            record = json.load(archive.extractfile(member))
                            audits[(record['architecture'], record['session'])] = record
                        elif relative.name == 'comparison.json':
                            raw = archive.extractfile(member).read()
                            report = json.loads(raw)
                            reports[(report['machine'], report['configuration']['session'])] = (report, CHECK.digest(raw))
                self.assertEqual(set(reports), set(expected))
                self.assertEqual(set(audits), set(reports))
                for key, (report, raw_hash) in reports.items():
                    CHECK.GROUPS.check_report(report, source, 'array-lists')
                    decision = CHECK.GROUPS.DESCENT.paired_budget_failures(report['results'], 'array-lists')
                    audit = audits[key]
                    self.assertEqual((audit['source'], audit['session']), (source, key[1]))
                    self.assertEqual(audit['files']['comparison.json']['sha256'], raw_hash)
                    self.assertEqual(audit['budgetFailures'], decision)
                    self.assertEqual(len(decision), expected[key])
                    self.assertEqual(audit['decision'], 'not-accepted' if expected[key] else 'accepted')

    def test_original_rejected_report_is_auditable_without_claiming_acceptance(self):
        CHECK.GROUPS.check_report(REPORT, SOURCE, 'array-lists')
        failures = CHECK.GROUPS.DESCENT.paired_budget_failures(REPORT['results'], 'array-lists')
        self.assertEqual(len(failures), 20)
        self.assertEqual({row['metric'] for row in failures}, {'requests', 'requestedBytes'})
        self.assertEqual({row['case'] for row in failures}, {'3-1', '3-199', '3-1999', '33-199', '129-199'})

    def test_missing_round_changed_median_or_relabeled_host_cannot_pass(self):
        for changed in ('round', 'median', 'host', 'protocol'):
            report = copy.deepcopy(REPORT)
            if changed == 'round':
                report['results']['3-1']['orders'].pop()
            elif changed == 'median':
                report['results']['3-1']['medianNs']['fwp-ad'] = 1
            elif changed == 'host':
                report['qualification']['actual']['cpu'] = 'replacement'
                report['qualification']['expected']['cpu'] = 'replacement'
            else:
                report['configuration']['comparison'] = 'scalar-recording'
            with self.subTest(changed=changed), self.assertRaises(AssertionError):
                CHECK.GROUPS.check_report(report, SOURCE, 'array-lists')

    def test_repeated_outputs_match_the_analytic_oracle(self):
        expected = REPORT['results']['3-1']['oracle']
        output = (json.dumps(expected) + '\n').encode() * 2
        CHECK.GROUPS.DESCENT.verify(output, expected, 2)
        wrong = [expected[0] + 1, *expected[1:]]
        for changed in (b'', output[:-1].splitlines()[0],
                        (json.dumps(wrong) + '\n').encode() * 2,
                        b'[NaN, 0, 0]\n' * 2):
            with self.subTest(changed=changed), self.assertRaises(AssertionError):
                CHECK.GROUPS.DESCENT.verify(changed, expected, 2)

    def test_round_recomputes_totals_and_rejects_bad_process_observations(self):
        record = dict(complete=True, order=['a', 'b', 'a'], totalsNs=dict(a=8, b=4), observations=[
            dict(label=label, elapsedNs=4, status=0, stdoutSha256=label,
                 stderrSha256=CHECK.digest(b''), outputMatches=True) for label in ['a', 'b', 'a']])
        self.assertEqual(CHECK.check_round(record, record['order'], dict(a='a', b='b')), dict(a=8, b=4))
        for key, value in [('status', 1), ('elapsedNs', 0), ('stdoutSha256', 'wrong'), ('outputMatches', False)]:
            damaged = copy.deepcopy(record)
            damaged['observations'][0][key] = value
            with self.subTest(key=key), self.assertRaises(AssertionError):
                CHECK.check_round(damaged, record['order'], dict(a='a', b='b'))
        record['totalsNs']['a'] = 4
        with self.assertRaises(AssertionError):
            CHECK.check_round(record, record['order'], dict(a='a', b='b'))


if __name__ == '__main__':
    unittest.main()
