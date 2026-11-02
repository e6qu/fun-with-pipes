#!/usr/bin/env python3
"""Keep the comparison limited to the numeric-input stage and its eligibility."""
import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-numeric-input-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
CURRENT = {path: (ROOT / path).read_text() for path in REFERENCE.CHANGES}


class NumericInputReference(unittest.TestCase):
    def test_only_the_two_selected_operations_change(self):
        reference = REFERENCE.reference_sources(CURRENT)
        for path, (candidate, replacement) in REFERENCE.CHANGES.items():
            self.assertEqual(reference[path].replace(replacement, candidate), CURRENT[path])
        self.assertIn('let packed_program = packed_records::lower(region_program.as_ref());', reference['src/cgen.rs'])
        self.assertIn('self.bind_field_transfers(l, v, body)', reference['src/cgen.rs'])
        self.assertIn('fn packed_record_map(', reference['src/cgen.rs'])

    def test_unrelated_changes_survive(self):
        changed = {path: text + '\n// unrelated change\n' for path, text in CURRENT.items()}
        reference = REFERENCE.reference_sources(changed)
        for path, (candidate, replacement) in REFERENCE.CHANGES.items():
            self.assertEqual(reference[path].replace(replacement, candidate), changed[path])

    def test_missing_duplicate_and_already_prepared_sources_are_rejected(self):
        for path, (candidate, _) in REFERENCE.CHANGES.items():
            for text in [CURRENT[path].replace(candidate, ''), CURRENT[path] + candidate,
                         REFERENCE.reference_sources(CURRENT)[path]]:
                changed = dict(CURRENT, **{path: text})
                with self.subTest(path=path), self.assertRaises(AssertionError):
                    REFERENCE.reference_sources(changed)


if __name__ == '__main__':
    unittest.main()
