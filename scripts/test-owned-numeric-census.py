#!/usr/bin/env python3
"""Reject unexplained whole-solve counts and storage changes before timing."""
import copy
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('census', Path(__file__).with_name('check-owned-numeric-census.py'))
CENSUS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CENSUS)


class Census(unittest.TestCase):
    def setUp(self):
        self.current = dict(managed=dict(requests=100, requestedBytes=1000, retains=10,
                                        peakChargedBytes=500, finalChargedBytes=0),
                            raw=dict(peakBytes=900, finalBytes=0))
        self.old = copy.deepcopy(self.current)
        self.old['managed'].update(requests=25741 * 8 + 100, requestedBytes=819968 * 8 + 1000)

    def test_largest_frozen_prediction(self):
        self.assertEqual(CENSUS.compare(self.current, self.old, 129, 199, 8, 'owned-numeric'),
                         dict(requests=205928, requestedBytes=6559744))

    def test_unexplained_more_or_less_saving_stops_timing(self):
        for field in ('requests', 'requestedBytes'):
            for delta in (-1, 1):
                candidate = copy.deepcopy(self.current)
                candidate['managed'][field] += delta
                with self.assertRaises(AssertionError):
                    CENSUS.compare(candidate, self.old, 129, 199, 8, 'owned-numeric')

    def test_more_retain_or_live_storage_is_rejected(self):
        for field in ('retains', 'peakChargedBytes', 'finalChargedBytes'):
            candidate = copy.deepcopy(self.current)
            candidate['managed'][field] += 1
            with self.assertRaises(AssertionError):
                CENSUS.compare(candidate, self.old, 129, 199, 8, 'owned-numeric')

    def test_raw_storage_change_or_shared_leak_is_rejected(self):
        candidate = copy.deepcopy(self.current)
        candidate['raw']['peakBytes'] += 1
        with self.assertRaises(AssertionError):
            CENSUS.compare(candidate, self.old, 129, 199, 8, 'owned-numeric')
        self.current['raw']['finalBytes'] = self.old['raw']['finalBytes'] = 1
        with self.assertRaises(AssertionError):
            CENSUS.compare(self.current, self.old, 129, 199, 8, 'owned-numeric')

    def test_gradient_call_repeated_prediction_and_retains_are_exact(self):
        old = copy.deepcopy(self.current)
        expected = dict(requests=11145, requestedBytes=1846744, retains=3184)
        for key, saving in expected.items():
            old['managed'][key] += saving
        self.assertEqual(CENSUS.compare(self.current, old, 129, 199, 8, 'gradient-call'), expected)
        for key in expected:
            for delta in (-1, 1):
                changed = copy.deepcopy(self.current)
                changed['managed'][key] += delta
                with self.subTest(key=key, delta=delta), self.assertRaises(AssertionError):
                    CENSUS.compare(changed, old, 129, 199, 8, 'gradient-call')
        self.assertEqual(CENSUS.compare(self.current, self.current, 3, 0, 32768, 'gradient-call'),
                         dict(requests=0, requestedBytes=0, retains=0))

    def test_zero_updates_require_identical_storage(self):
        self.assertEqual(CENSUS.compare(self.current, self.current, 3, 0, 32768, 'owned-numeric'),
                         dict(requests=0, requestedBytes=0))
        candidate = copy.deepcopy(self.current)
        candidate['managed']['retains'] -= 1
        with self.assertRaises(AssertionError):
            CENSUS.compare(candidate, self.current, 3, 0, 32768, 'owned-numeric')


if __name__ == '__main__':
    unittest.main()
