#!/usr/bin/env python3
"""Verify pair-storage reference isolation and reject malformed selection edits."""
import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-packed-pair-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
CURRENT = {name: (ROOT / name).read_text() for name in REFERENCE.EDITS}


class PackedPairReference(unittest.TestCase):
    def test_complete_reference_is_reversible_and_preserves_prior_work(self):
        restored = REFERENCE.reference_sources(CURRENT)
        for name, (candidate, reference) in REFERENCE.EDITS.items():
            self.assertEqual(restored[name].count(reference), 1)
            self.assertNotIn(candidate, restored[name])
            self.assertEqual(restored[name].replace(reference, candidate), CURRENT[name])
        for selection in ('owned_numeric::lower(&mut numeric_program);',
                          'packed_inputs::lower(&mut numeric_program);'):
            self.assertIn(selection, restored['src/cgen.rs'])
        self.assertIn('const GRADIENT_CALL_STORAGE: bool = true;', restored['src/cgen.rs'])
        self.assertIn('fwp_value_release(&input);', restored['src/cgen.rs'])
        self.assertIn('src/escape.rs', REFERENCE.PRESERVED)
        self.assertTrue(set(REFERENCE.PRESERVED).isdisjoint(REFERENCE.EDITS))

    def test_missing_duplicate_altered_and_partly_disabled_edits_fail(self):
        for name, (candidate, reference) in REFERENCE.EDITS.items():
            for defect in ('', candidate + candidate, candidate[1:], reference):
                changed = dict(CURRENT)
                changed[name] = changed[name].replace(candidate, defect)
                with self.subTest(path=name, defect=defect), self.assertRaises(AssertionError):
                    REFERENCE.reference_sources(changed)
            missing = dict(CURRENT)
            del missing[name]
            with self.assertRaises(AssertionError):
                REFERENCE.reference_sources(missing)

    def test_unrelated_changes_survive(self):
        for name in CURRENT:
            changed = dict(CURRENT)
            changed[name] += '\nUnrelated marker\n'
            reference = REFERENCE.reference_sources(changed)
            for path, (before, after) in REFERENCE.EDITS.items():
                self.assertEqual(reference[path].replace(after, before), changed[path])


if __name__ == '__main__':
    unittest.main()
