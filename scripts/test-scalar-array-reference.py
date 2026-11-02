#!/usr/bin/env python3
"""Check that the paired compiler differs only in the declared selection rule."""
import importlib.util
from pathlib import Path
import subprocess
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('scalar_reference', ROOT / 'scripts/prepare-scalar-array-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)


class SelectionReference(unittest.TestCase):
    def test_disabled_selection_matches_the_verified_baseline(self):
        candidate = (ROOT / 'src/cgen.rs').read_text()
        baseline = subprocess.check_output(['git', 'show',
            'roadmap/array-construction-phase-runner-2026-11-02:src/cgen.rs'], cwd=ROOT, text=True)
        self.assertEqual(REFERENCE.reference_source(candidate), baseline)

    def test_missing_repeated_or_already_reverted_rule_is_rejected(self):
        for source in ('', REFERENCE.CANDIDATE * 2, REFERENCE.REFERENCE):
            with self.subTest(source=source), self.assertRaises(AssertionError):
                REFERENCE.reference_source(source)


if __name__ == '__main__':
    unittest.main()
