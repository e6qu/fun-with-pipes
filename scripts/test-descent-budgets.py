#!/usr/bin/env python3
"""Check descent acceptance requirements using retained measurements and faults."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('descent', ROOT / 'scripts/measure-descent-peers.py')
DESCENT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(DESCENT)
BASELINE = json.loads((ROOT / 'docs/measurements/array-owner-moves-2026-10-22.json').read_text())


class DescentBudgets(unittest.TestCase):
    def test_each_recorded_input_requires_the_declared_count_and_storage_limits(self):
        for host in BASELINE['hosts']:
            for case, row in host['report']['results'].items():
                with self.subTest(host=host['host'], case=case):
                    old = row['fwpProfiles']
                    current = copy.deepcopy(old)
                    current['fwp-packed-baseline'] = copy.deepcopy(old['fwp-packed'])
                    failures = DESCENT.ownership_budget_failures(current, old, row['updates'])
                    expected = []
                    if row['updates'] >= 199:
                        expected = [dict(program='fwp-packed', metric='retains', requirement='equal',
                                         actual=old['fwp-packed']['managed']['retains'], expected=0)]
                    self.assertEqual(failures, expected)
                    current['fwp-packed']['managed']['retains'] = 0
                    self.assertEqual(DESCENT.ownership_budget_failures(current, old, row['updates']), [])

    def test_reports_independent_failures_together_without_changing_inputs(self):
        old = BASELINE['hosts'][0]['report']['results']['129-199']['fwpProfiles']
        current = copy.deepcopy(old)
        current['fwp-packed-baseline'] = copy.deepcopy(old['fwp-packed'])
        current['fwp-ad']['managed']['retains'] += 1
        current['fwp-ad']['managed']['peakChargedBytes'] += 8
        current['fwp-explicit']['managed']['requests'] += 1
        current['fwp-explicit']['managed']['requestedBytes'] += 8
        current['fwp-packed']['managed']['requestedBytes'] += 8
        current['fwp-packed']['managed']['peakChargedBytes'] += 8
        snapshot = copy.deepcopy(current)
        failures = DESCENT.ownership_budget_failures(current, old, 199)
        self.assertEqual({(row['program'], row['metric']) for row in failures}, {
            ('fwp-ad', 'retains'), ('fwp-ad', 'peakChargedBytes'),
            ('fwp-explicit', 'requests'), ('fwp-explicit', 'requestedBytes'),
            ('fwp-packed', 'requestedBytes'), ('fwp-packed', 'peakChargedBytes'),
            ('fwp-packed', 'retains'),
        })
        self.assertEqual(len(failures), 7)
        self.assertEqual(current, snapshot)
        self.assertTrue(all('actual' in row and 'expected' in row for row in failures))

    def test_a_changed_recompiled_baseline_cannot_pass(self):
        old = BASELINE['hosts'][0]['report']['results']['129-199']['fwpProfiles']
        current = copy.deepcopy(old)
        current['fwp-packed-baseline'] = copy.deepcopy(old['fwp-packed'])
        current['fwp-packed']['managed']['retains'] = 0
        current['fwp-packed-baseline']['managed']['retains'] = 0
        failures = DESCENT.ownership_budget_failures(current, old, 199)
        self.assertEqual([(row['program'], row['metric']) for row in failures], [
            ('fwp-packed-baseline', 'accepted profile'), ('fwp-packed-baseline', 'retains')])


if __name__ == '__main__':
    unittest.main()
