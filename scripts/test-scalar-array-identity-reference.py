#!/usr/bin/env python3
"""Keep the scalar correctness repair and every other optimization in the reference."""
import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-scalar-array-identity-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
CURRENT = (ROOT / 'src/opt.rs').read_text()


class ScalarArrayIdentityReference(unittest.TestCase):
    def test_only_identity_map_selection_is_disabled(self):
        restored = REFERENCE.reference_source(CURRENT)
        self.assertEqual(restored.count(REFERENCE.REFERENCE), 1)
        self.assertNotIn(REFERENCE.CANDIDATE, restored)
        self.assertEqual(restored.replace(REFERENCE.REFERENCE, REFERENCE.CANDIDATE), CURRENT)
        for preserved in ('"float.convert"', '"simd.splat"', '"show"',
                          'pub fn specialize_hofs', 'fn bind_captures('):
            self.assertIn(preserved, restored)

    def test_unrelated_optimizer_changes_are_preserved(self):
        changed = CURRENT.replace('fn bind_captures(', 'fn renamed_bind_captures(', 1)
        self.assertNotEqual(changed, CURRENT)
        restored = REFERENCE.reference_source(changed)
        self.assertEqual(restored.replace(REFERENCE.REFERENCE, REFERENCE.CANDIDATE), changed)

    def test_missing_duplicate_changed_and_already_disabled_selection_are_rejected(self):
        for changed in (CURRENT.replace(REFERENCE.CANDIDATE, ''),
                        CURRENT + REFERENCE.CANDIDATE,
                        CURRENT.replace(REFERENCE.CANDIDATE, REFERENCE.CANDIDATE.replace('array.map', 'array.fold')),
                        REFERENCE.reference_source(CURRENT)):
            with self.assertRaises(AssertionError):
                REFERENCE.reference_source(changed)


if __name__ == '__main__':
    unittest.main()
