#!/usr/bin/env python3
"""Protect the exact representation-only comparison reference."""
import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-loop-state-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
CURRENT = (ROOT / 'src/cgen.rs').read_text()


class LoopStateReference(unittest.TestCase):
    def test_changes_only_loop_field_types(self):
        restored = REFERENCE.reference_source(CURRENT)
        self.assertEqual(restored.count(REFERENCE.REFERENCE), 1)
        self.assertEqual(restored.replace(REFERENCE.REFERENCE, REFERENCE.CANDIDATE), CURRENT)
        for boundary in ('fn loop_def(', 'fn invariant_f64_arrays(', 'fn unpack_loop_state('):
            self.assertIn(boundary, restored)

    def test_unrelated_codegen_is_preserved(self):
        changed = CURRENT.replace('fn string_length(', 'fn updated_string_length(', 1)
        self.assertNotEqual(changed, CURRENT)
        self.assertEqual(REFERENCE.reference_source(changed).replace(
            REFERENCE.REFERENCE, REFERENCE.CANDIDATE), changed)

    def test_changed_missing_duplicate_and_already_prepared_sources_reject(self):
        for changed in (CURRENT.replace(REFERENCE.CANDIDATE, ''),
                        CURRENT + REFERENCE.CANDIDATE,
                        CURRENT.replace(REFERENCE.CANDIDATE, REFERENCE.CANDIDATE.replace(
                            'Scalar::F32 | Scalar::F64', 'Scalar::F64')),
                        REFERENCE.reference_source(CURRENT)):
            with self.subTest(source=changed[-80:]), self.assertRaises(AssertionError):
                REFERENCE.reference_source(changed)


if __name__ == '__main__':
    unittest.main()
