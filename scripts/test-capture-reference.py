#!/usr/bin/env python3
"""Disable only eager capture binding; preserve all other current compiler code."""
import hashlib
import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('capture_reference', ROOT / 'scripts/prepare-capture-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
CURRENT = (ROOT / 'src/opt.rs').read_text()


class CaptureReference(unittest.TestCase):
    def assert_only_capture_change(self, current, restored):
        self.assertEqual(restored.count(REFERENCE.ORIGINAL_BINDING), 1)
        self.assertEqual(restored.count(REFERENCE.ORIGINAL_METHOD), 1)
        self.assertNotIn(REFERENCE.CANDIDATE_BINDING, restored)
        reconstructed = restored.replace(REFERENCE.ORIGINAL_BINDING, REFERENCE.CANDIDATE_BINDING)
        reconstructed = reconstructed.replace(REFERENCE.ORIGINAL_METHOD, '')
        self.assertEqual(reconstructed, current)

    def test_reference_changes_only_the_selected_capture_code(self):
        self.assert_only_capture_change(CURRENT, REFERENCE.reference_source(CURRENT))

    def test_historical_capture_blocks_are_unchanged(self):
        # These are the original method/binding from the frozen preparation.
        # Other optimizer code belongs to the current compiler in both builds.
        self.assertEqual(hashlib.sha256(REFERENCE.ORIGINAL_METHOD.encode()).hexdigest(),
                         '8051d7b098c288a557b4c2aa86dd07c63bab89ee1da18c39f5be3322eb55f410')
        self.assertEqual(hashlib.sha256(REFERENCE.ORIGINAL_BINDING.encode()).hexdigest(),
                         '8f077e172e10d8571f8ec79506ec27fb910ec320db049c7771dfe5cdbaece1c9')

    def test_unrelated_current_compiler_changes_are_preserved(self):
        changed = CURRENT.replace('pub(crate) fn substitute(', 'pub fn substitute(', 1)
        self.assertNotEqual(changed, CURRENT)
        self.assert_only_capture_change(changed, REFERENCE.reference_source(changed))

    def test_unrelated_reference_edits_are_rejected(self):
        restored = REFERENCE.reference_source(CURRENT)
        for old, new in [('pub(crate) fn substitute(', 'fn substitute('),
                         ('pub(crate) fn substitute(', 'pub fn substitute('),
                         ('match &s[*l as usize]', 'match &s[0]')]:
            self.assertEqual(restored.count(old), 1)
            with self.subTest(change=new), self.assertRaises(AssertionError):
                self.assert_only_capture_change(CURRENT, restored.replace(old, new, 1))

    def test_changed_or_duplicate_candidate_block_is_rejected(self):
        for changed in [CURRENT.replace(REFERENCE.CANDIDATE_BINDING, ''),
                        CURRENT.replace('let count = self.nlocals();', 'let count = 0;'),
                        CURRENT + REFERENCE.CANDIDATE_BINDING]:
            with self.subTest(changed=changed[-80:]), self.assertRaises(AssertionError):
                REFERENCE.reference_source(changed)

    def test_already_restored_or_partial_reference_is_rejected(self):
        for changed in [REFERENCE.reference_source(CURRENT),
                        CURRENT.replace('    fn fresh(', REFERENCE.ORIGINAL_METHOD + '    fn fresh(')]:
            with self.assertRaises(AssertionError):
                REFERENCE.reference_source(changed)


if __name__ == '__main__':
    unittest.main()
