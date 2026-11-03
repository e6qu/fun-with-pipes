#!/usr/bin/env python3
"""Disable only scalar map-to-zip lowering while keeping every other transformation."""
import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-scalar-map-zip-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
CURRENT = (ROOT / 'src/cgen.rs').read_text()


class ScalarMapZipReference(unittest.TestCase):
    def test_only_scalar_map_zip_selection_is_removed(self):
        restored = REFERENCE.reference_source(CURRENT)
        self.assertEqual(restored.count(REFERENCE.REFERENCE), 1)
        self.assertNotIn(REFERENCE.CANDIDATE, restored)
        self.assertEqual(restored.replace(REFERENCE.REFERENCE, REFERENCE.CANDIDATE), CURRENT)
        self.assertIn('fn record_fold_abi(', restored)
        self.assertIn('fn record_fold_def(', restored)
        self.assertIn('fn packed_record_map(', restored)
        self.assertIn('packed_records::lower(region_program.as_ref());', restored)
        self.assertIn('numeric_parameters::lower(&mut numeric_program, &roots);', restored)

    def test_other_codegen_changes_are_preserved(self):
        changed = CURRENT.replace('fn string_length(', 'fn updated_string_length(', 1)
        self.assertNotEqual(changed, CURRENT)
        restored = REFERENCE.reference_source(changed)
        self.assertEqual(restored.replace(REFERENCE.REFERENCE, REFERENCE.CANDIDATE), changed)

    def test_changed_duplicate_missing_and_restored_selection_are_rejected(self):
        for changed in [CURRENT.replace(REFERENCE.CANDIDATE, ''),
                        CURRENT + REFERENCE.CANDIDATE,
                        CURRENT.replace(REFERENCE.CANDIDATE, REFERENCE.CANDIDATE.replace(
                            '&mut numeric_program', '&mut other_program')),
                        REFERENCE.reference_source(CURRENT)]:
            with self.assertRaises(AssertionError):
                REFERENCE.reference_source(changed)


if __name__ == '__main__':
    unittest.main()
