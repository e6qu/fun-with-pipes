#!/usr/bin/env python3
"""Reject altered construction results, missing observations and lost owners."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location('construction', Path(__file__).with_name('report-array-construction.py'))
REPORT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REPORT)


class ConstructionEvidence(unittest.TestCase):
    def setUp(self):
        self.counts = patch.object(REPORT, 'COUNTS', (0, 3))
        self.counts.start()
        self.addCleanup(self.counts.stop)
        self.data = dict(cases=[dict(count=count, round=r, role=role,
            resultBits=REPORT.result_bits(count, r), requests=1, requestedBytes=8 + count * 8,
            retains=0, finalLiveBytes=0) for count in (0, 3) for r in range(8) for role in range(3)])

    def check(self, data):
        return REPORT.check_output(json.dumps(data), True)

    def test_declared_example_and_negative_zero_are_exact(self):
        self.assertEqual(REPORT.result_bits(3, 0), 'c02e000000000000')
        self.assertEqual(REPORT.result_bits(0, 0), '8000000000000000')
        self.check(self.data)

    def test_missing_duplicated_and_reordered_cases_fail(self):
        for rows in (self.data['cases'][:-1], self.data['cases'] + self.data['cases'][:1],
                     list(reversed(self.data['cases']))):
            with self.assertRaises(AssertionError):
                self.check(dict(cases=rows))

    def test_changed_bits_live_storage_and_driver_counts_fail(self):
        for field, value in (('resultBits', '0000000000000000'), ('finalLiveBytes', 8),
                             ('requests', 0), ('requestedBytes', 0), ('retains', 1)):
            changed = copy.deepcopy(self.data)
            changed['cases'][0][field] = value
            with self.assertRaises(AssertionError):
                self.check(changed)

    def test_source_counts_are_observations_not_assumed_equal_to_driver(self):
        changed = copy.deepcopy(self.data)
        changed['cases'][2]['requests'] = 0
        changed['cases'][2]['requestedBytes'] = 0
        self.check(changed)

    def test_ordinary_runs_cannot_claim_instrumented_counts(self):
        with self.assertRaises(AssertionError):
            REPORT.check_output(json.dumps(self.data), False)

    def test_source_boundaries_reject_missing_or_duplicate_matches(self):
        for text in ('', 'token token'):
            with self.assertRaises(AssertionError):
                REPORT.replace_once(text, 'token', 'replacement')
        self.assertEqual(REPORT.entry('/* work : I64 */ static V f3(V x) { return x; }', 'work'), 'f3')
        with self.assertRaises(AssertionError):
            REPORT.entry('/* work : I64 */ no function', 'work')


if __name__ == '__main__':
    unittest.main()
