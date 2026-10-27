#!/usr/bin/env python3
"""Reject incomplete or inconsistent ownership-operation evidence."""

import copy
import importlib.util
import json
from pathlib import Path
import unittest


SPEC = importlib.util.spec_from_file_location(
    'arc_costs', Path(__file__).with_name('measure-arc-costs.py'))
ARC = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(ARC)


class Evidence(unittest.TestCase):
    def setUp(self):
        self.sites = [dict(operation='dup'), dict(operation='release_last')]
        self.managed = dict(requests=1, requestedBytes=16, retains=2,
                            peakChargedBytes=16, finalChargedBytes=0)
        self.rows = ['ownership-site\t0\t3\t2\t0', 'ownership-site\t1\t3\t3\t1']

    def evidence(self, rows, managed):
        return ('\n'.join(rows + [json.dumps(managed)]) + '\n').encode()

    def test_complete_counts(self):
        result = ARC.parse_profile(self.evidence(self.rows, self.managed), self.sites)
        self.assertEqual(result['operations']['dup'], dict(calls=3, effective=2, last=0))
        self.assertEqual(result['operations']['release_last'], dict(calls=3, effective=3, last=1))

    def test_missing_retain_site(self):
        with self.assertRaises(AssertionError):
            ARC.parse_profile(self.evidence(self.rows[1:], self.managed), self.sites)

    def test_duplicate_unknown_and_impossible_rows(self):
        for rows in (self.rows + self.rows[:1], ['ownership-site\t2\t1\t1\t0'],
                     ['ownership-site\t0\t1\t2\t0'], ['ownership-site\t0\t2\t2\t1'],
                     ['ownership-site\t0\t0\t0\t0']):
            with self.subTest(rows=rows), self.assertRaises(AssertionError):
                ARC.parse_profile(self.evidence(rows, self.managed), self.sites)

    def test_leak_and_missing_or_duplicate_summary(self):
        leaking = copy.copy(self.managed)
        leaking['finalChargedBytes'] = 16
        for raw in (self.evidence(self.rows, leaking), '\n'.join(self.rows).encode(),
                    self.evidence(self.rows + [json.dumps(self.managed)], self.managed)):
            with self.subTest(raw=raw), self.assertRaises(AssertionError):
                ARC.parse_profile(raw, self.sites)

    def test_comments_and_strings_do_not_create_calls_or_braces(self):
        code = 'static void f() { /* } fwp_rc_dup(v) */ puts("} fwp_rc_dup(v)"); }'
        masked = ARC.OWNERSHIP.mask_c(code)
        self.assertEqual(len(masked), len(code))
        self.assertNotIn('fwp_rc_dup', masked)
        self.assertEqual(ARC.OWNERSHIP.function_end(code, code.index('{')), len(code))


if __name__ == '__main__':
    unittest.main()
