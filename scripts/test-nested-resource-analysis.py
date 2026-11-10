#!/usr/bin/env python3
"""Check exact proof instrumentation and reject inconsistent traversal reports."""
import json
from pathlib import Path
import unittest

from nested_resource_analysis import PREFIX, decode, instrument

ROOT = Path(__file__).resolve().parent.parent


class Analysis(unittest.TestCase):
    def test_current_proof_is_instrumented_once(self):
        original = (ROOT / 'src/cgen/resource_borrows.rs').read_text()
        observed = instrument(original)
        for name in ('FRESH', 'BODY', 'ALIAS'):
            self.assertEqual(observed.count(f'OBSERVED_{name}.set(OBSERVED_{name}.get() + 1);'), 1)
            self.assertEqual(observed.count(f'OBSERVED_{name}.set(0);'), 1)
        self.assertIn('observed_report(locals, 0, true);', observed)
        with self.assertRaises(AssertionError):
            instrument(observed)
        with self.assertRaises(AssertionError):
            instrument(original.replace('    scan.selected\n}', '    scan.selected.clone()\n}'))

    def test_all_reports_are_checked_and_rejected_paths_stop_after_freshness(self):
        row = dict(locals=7, selected=2, rejected=False, freshVisits=20, bodyVisits=20, aliasVisits=8)
        encode = lambda value: PREFIX + json.dumps(value) + '\n'
        self.assertEqual(decode(encode(row)), [row])
        rejected = dict(locals=7, selected=0, rejected=True, freshVisits=3, bodyVisits=0, aliasVisits=0)
        self.assertEqual(decode(encode(row) + encode(rejected)), [row, rejected])
        self.assertEqual(decode(''), [])
        for key, value in (('freshVisits', 0), ('bodyVisits', 19), ('aliasVisits', 21),
                           ('rejected', True), ('selected', True)):
            with self.subTest(key=key), self.assertRaises(AssertionError):
                decode(encode(row | {key: value}))
        with self.assertRaises(AssertionError):
            decode(encode(row) + 'unexpected compiler diagnostic\n')


if __name__ == '__main__':
    unittest.main()
