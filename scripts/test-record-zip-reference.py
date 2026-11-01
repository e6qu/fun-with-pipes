#!/usr/bin/env python3
"""Keep numeric zip/map fusion and all unrelated compiler code in the reference."""
import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-record-zip-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
CURRENT = (ROOT / 'src/fuse.rs').read_text()


class RecordZipReference(unittest.TestCase):
    def test_only_flat_record_selection_is_removed(self):
        restored = REFERENCE.reference_source(CURRENT)
        self.assertEqual(restored.count(REFERENCE.REFERENCE), 1)
        self.assertNotIn(REFERENCE.CANDIDATE, restored)
        self.assertEqual(restored.replace(REFERENCE.REFERENCE, REFERENCE.CANDIDATE), CURRENT)
        self.assertIn('unboxed_numeric(ty)', REFERENCE.REFERENCE)

    def test_other_current_fusion_changes_are_preserved(self):
        changed = CURRENT.replace('fn numeric_literal_list(', 'fn updated_numeric_literal_list(', 1)
        self.assertNotEqual(changed, CURRENT)
        restored = REFERENCE.reference_source(changed)
        self.assertEqual(restored.replace(REFERENCE.REFERENCE, REFERENCE.CANDIDATE), changed)

    def test_changed_duplicate_missing_and_restored_selection_are_rejected(self):
        for changed in [CURRENT.replace(REFERENCE.CANDIDATE, ''),
                        CURRENT + REFERENCE.CANDIDATE,
                        CURRENT.replace('!fields.is_empty() && ', ''),
                        REFERENCE.reference_source(CURRENT)]:
            with self.assertRaises(AssertionError):
                REFERENCE.reference_source(changed)


if __name__ == '__main__':
    unittest.main()
