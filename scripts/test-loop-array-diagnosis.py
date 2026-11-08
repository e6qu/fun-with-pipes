#!/usr/bin/env python3
"""Check source isolation and schedule controls before runner diagnostics."""
from collections import Counter
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('diagnosis', Path(__file__).with_name('diagnose-loop-arrays.py'))
DIAGNOSIS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(DIAGNOSIS)


class Diagnosis(unittest.TestCase):
    def test_only_callback_declarations_change(self):
        source = 'static V ordinary(V *args) {\nreturn 1;\n}\nstatic V fwp_borrowed_array2(V *args) {\nreturn ordinary(args);\n}\n'
        candidate, count = DIAGNOSIS.inline_callbacks(source)
        self.assertEqual(count, 1)
        self.assertEqual(candidate.replace('inline __attribute__((always_inline)) ', ''), source)
        self.assertIn('static V ordinary(V *args)', candidate)

    def test_changed_or_duplicate_declaration_is_rejected(self):
        for source in ('static inline V fwp_borrowed_array2(V *args) {',
                       'static V fwp_borrowed_array2(V *args) {\n' * 2,
                       'static V fwp_borrowed_array2(V args) {'):
            with self.subTest(source=source), self.assertRaises(AssertionError):
                DIAGNOSIS.inline_callbacks(source)

    def test_unaffected_program_is_unchanged(self):
        self.assertEqual(DIAGNOSIS.inline_callbacks('static V loop(V x) { return x; }'),
                         ('static V loop(V x) { return x; }', 0))

    def test_every_role_has_equal_position_counts(self):
        for position in range(4):
            self.assertEqual(Counter(DIAGNOSIS.order(i)[position] for i in range(16)),
                             Counter({role: 4 for role in DIAGNOSIS.ROLES}))

    def test_repeated_work_keeps_source_body(self):
        source = 'solve = id\nmain = [1.0] | solve | echo\n'
        self.assertEqual(DIAGNOSIS.repeat(source, 1), source)
        self.assertIn('range 0 32 | each (const [1.0] | solve | echo)', DIAGNOSIS.repeat(source, 32))


if __name__ == '__main__':
    unittest.main()
