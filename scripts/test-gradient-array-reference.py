#!/usr/bin/env python3
"""Verify whole-change isolation and reject incomplete or corrupted references."""
import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-gradient-array-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
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
