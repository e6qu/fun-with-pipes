#!/usr/bin/env python3
"""Verify whole-change isolation and reject incomplete or corrupted references."""
import copy
import difflib
import importlib.util
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-gradient-array-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
AUDIT_SPEC = importlib.util.spec_from_file_location('audit', ROOT / 'scripts/check-array-list-evidence.py')
AUDIT = importlib.util.module_from_spec(AUDIT_SPEC)
AUDIT_SPEC.loader.exec_module(AUDIT)
CURRENT = {name: (ROOT / name).read_bytes() for name in REFERENCE.FILES}
SELECTIONS = {
    'lib/autodiff.fwp': b'rev._backward : I64 -> List[I64] -> List[T] -> Array[T]',
    'runtime/fwp_rt_kernel.c': b'const fwp_desc *array_type)',
    'src/cgen.rs': b'fn scalar_buffer_zip(&mut self, id: FuncId,',
    'src/fuse.rs': b'array_zip::lower(prog);',
    'src/interp.rs': b'internal: array-list zip requires an array',
    'src/ir.rs': b'Zip-with borrowing one numeric array and one list.',
    'src/numerics.rs': b'Ok(Value::Array(Rc::new(adj)))',
}


class GradientArrayReference(unittest.TestCase):
    def test_protocol_runtime_frontend_and_backend_are_restored_together(self):
        restored = REFERENCE.reference_sources(CURRENT)
        self.assertIn(b'rev._backward : I64 -> List[I64] -> List[T] -> List[T]', restored['lib/autodiff.fwp'])
        self.assertIn(b'const fwp_desc *list_type)', restored['runtime/fwp_rt_kernel.c'])
        self.assertNotIn(b'array_zip::lower(prog);', restored['src/fuse.rs'])
        self.assertIn(b'Ok(Value::list(adj))', restored['src/numerics.rs'])
        self.assertNotIn(b'internal: array-list zip requires an array', restored['src/interp.rs'])
        self.assertIn(b'fn scalar_buffer_zip(&mut self, callback:', restored['src/cgen.rs'])
        self.assertIn(b'range_zip::lower(&mut numeric_program);', restored['src/cgen.rs'])
        self.assertIn(b'scalar_map_zip::lower(&mut numeric_program);', restored['src/cgen.rs'])
        self.assertIn(b'packed_inputs::lower(&mut numeric_program);', restored['src/cgen.rs'])
        self.assertIn(b'Body::PackedRecordRangeZip { .. }', restored['src/interp.rs'])
        self.assertIn(b'Body::PackedRecordPairs { .. }', restored['src/interp.rs'])

    def test_independent_audit_reconstructs_the_same_seven_sources(self):
        restored = REFERENCE.reference_sources(CURRENT)
        patch = REFERENCE.PATCH.read_bytes()
        self.assertEqual(AUDIT.recorded_gradient_reference(CURRENT, patch), restored)
        for name in REFERENCE.FILES:
            changed = dict(CURRENT)
            changed[name] = restored[name]
            with self.subTest(file=name), self.assertRaises(AssertionError):
                AUDIT.recorded_gradient_reference(changed, patch)

    def test_actual_git_diff_restores_exact_sources_without_requiring_hunk_layout(self):
        restored = REFERENCE.reference_sources(CURRENT)
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            subprocess.run(['git', 'init', '-q', str(root)], check=True)
            for name, data in CURRENT.items():
                target = root / name
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(data)
            subprocess.run(['git', 'add', '--', *sorted(CURRENT)], cwd=root, check=True)
            for name, data in restored.items():
                (root / name).write_bytes(data)
            difference = subprocess.check_output(['git', 'diff', '--no-ext-diff'], cwd=root)
            folder = root / 'saved'
            for name, data in restored.items():
                target = folder / 'source' / name
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(data)
            (folder / 'fwp').write_bytes(b'compiler')
            (folder / 'reference.patch').write_bytes(difference)
            frozen = REFERENCE.PATCH.read_bytes()
            ownership = (ROOT / 'src/ownership.rs').read_bytes()
            source = dict(CURRENT, **{'scripts/gradient-array-candidate.patch': frozen,
                                     'src/ownership.rs': ownership})
            manifest = dict(disabledTransformation='owned gradient arrays and direct array/list zip',
                candidate={name: AUDIT.digest(data) for name, data in CURRENT.items()},
                reference={name: AUDIT.digest(data) for name, data in restored.items()},
                frozenPatchSha256=AUDIT.digest(frozen), patchSha256=AUDIT.digest(difference),
                compilerSha256=AUDIT.digest(b'compiler'), ownershipSha256=AUDIT.digest(ownership))
            with patch.object(AUDIT.subprocess, 'check_output',
                              side_effect=lambda command, **kwargs: source[command[2].split(':', 1)[1]]), \
                    patch.object(AUDIT, 'instruction_bytes'):
                AUDIT.check_gradient_reference(folder, manifest, 'source', 'aarch64')
        self.assertEqual(AUDIT.recorded_gradient_reference(restored, difference), CURRENT)
        extra = (b'diff --git a/extra b/extra\nnew file mode 100644\n'
                 b'--- /dev/null\n+++ b/extra\n@@ -0,0 +1 @@\n+unrelated\n')
        with self.assertRaises(AssertionError):
            AUDIT.recorded_gradient_reference(restored, difference + extra)

    def test_saved_reference_audit_rejects_changed_hashes_sources_and_patch(self):
        candidates = {name: b'candidate\n' for name in REFERENCE.FILES}
        references = {name: b'reference\n' for name in REFERENCE.FILES}

        def difference(before, after):
            return ''.join(f'diff --git a/{name} b/{name}\nindex 1234567..2345678 100644\n' +
                ''.join(difflib.unified_diff(before[name].decode().splitlines(keepends=True),
                    after[name].decode().splitlines(keepends=True), fromfile='a/' + name, tofile='b/' + name))
                for name in sorted(before)).encode()

        frozen = difference(references, candidates)
        reverted = difference(candidates, references)
        source = dict(candidates, **{'scripts/gradient-array-candidate.patch': frozen,
                                   'src/ownership.rs': b'ownership'})
        manifest = dict(disabledTransformation='owned gradient arrays and direct array/list zip',
            candidate={name: AUDIT.digest(data) for name, data in candidates.items()},
            reference={name: AUDIT.digest(data) for name, data in references.items()},
            frozenPatchSha256=AUDIT.digest(frozen), patchSha256=AUDIT.digest(reverted),
            compilerSha256=AUDIT.digest(b'compiler'), ownershipSha256=AUDIT.digest(b'ownership'))
        with tempfile.TemporaryDirectory() as temporary:
            folder = Path(temporary)
            (folder / 'fwp').write_bytes(b'compiler')
            (folder / 'reference.patch').write_bytes(reverted)
            for name, data in references.items():
                path = folder / 'source' / name
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_bytes(data)
            with patch.object(AUDIT.subprocess, 'check_output',
                              side_effect=lambda command, **kwargs: source[command[2].split(':', 1)[1]]), \
                    patch.object(AUDIT, 'instruction_bytes') as image:
                AUDIT.check_gradient_reference(folder, manifest, 'source', 'aarch64')
                image.assert_called_once_with(b'compiler', 'aarch64')
                for field in ('frozenPatchSha256', 'patchSha256', 'compilerSha256', 'ownershipSha256',
                              'candidate', 'reference'):
                    changed = copy.deepcopy(manifest)
                    if field in ('candidate', 'reference'):
                        changed[field]['src/cgen.rs'] = 'wrong'
                    else:
                        changed[field] = 'wrong'
                    with self.subTest(field=field), self.assertRaises(AssertionError):
                        AUDIT.check_gradient_reference(folder, changed, 'source', 'aarch64')
                (folder / 'source/src/ir.rs').write_bytes(b'changed source')
                with self.assertRaises(AssertionError):
                    AUDIT.check_gradient_reference(folder, manifest, 'source', 'aarch64')

    def test_unrelated_source_edits_are_preserved(self):
        changed = dict(CURRENT)
        changed['src/cgen.rs'] += b'\n// unrelated measurement control\n'
        restored = REFERENCE.reference_sources(changed)
        self.assertTrue(restored['src/cgen.rs'].endswith(b'// unrelated measurement control\n'))

    def test_partly_restored_missing_and_corrupted_changes_are_rejected(self):
        restored = REFERENCE.reference_sources(CURRENT)
        for name in REFERENCE.FILES:
            selection = SELECTIONS[name]
            self.assertEqual(CURRENT[name].count(selection), 1, name)
            for replacement in [restored[name], b'', CURRENT[name].replace(selection, b'corrupted selection')]:
                with self.subTest(file=name, replacement=len(replacement)):
                    changed = dict(CURRENT)
                    changed[name] = replacement
                    with self.assertRaises(AssertionError):
                        REFERENCE.reference_sources(changed)
        with self.assertRaises(AssertionError):
            REFERENCE.reference_sources(restored)


if __name__ == '__main__':
    unittest.main()
