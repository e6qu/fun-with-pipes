#!/usr/bin/env python3
"""Disable only the selected record fold at its call site."""
import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-record-fold-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
CURRENT = (ROOT / 'src/cgen.rs').read_text()


class RecordFoldReference(unittest.TestCase):
    def test_only_direct_record_fold_selection_is_removed(self):
        restored = REFERENCE.reference_source(CURRENT)
        self.assertEqual(restored.count(REFERENCE.REFERENCE), 1)
        self.assertNotIn(REFERENCE.CANDIDATE, restored)
        self.assertEqual(restored.replace(REFERENCE.REFERENCE, REFERENCE.CANDIDATE), CURRENT)
        self.assertIn('fn record_fold_abi(', restored)
        self.assertIn('fn record_fold_def(', restored)

    def test_other_codegen_changes_are_preserved(self):
        changed = CURRENT.replace('fn string_length(', 'fn updated_string_length(', 1)
        self.assertNotEqual(changed, CURRENT)
        restored = REFERENCE.reference_source(changed)
        self.assertEqual(restored.replace(REFERENCE.REFERENCE, REFERENCE.CANDIDATE), changed)

    def test_changed_duplicate_missing_and_restored_selection_are_rejected(self):
        for changed in [CURRENT.replace(REFERENCE.CANDIDATE, ''),
                        CURRENT + REFERENCE.CANDIDATE,
                        CURRENT.replace('&& self.g.record_fold_abi(g).is_some()', '&& true'),
                        REFERENCE.reference_source(CURRENT)]:
            with self.assertRaises(AssertionError):
                REFERENCE.reference_source(changed)


if __name__ == '__main__':
    unittest.main()
