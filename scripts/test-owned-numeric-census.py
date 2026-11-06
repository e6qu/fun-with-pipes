#!/usr/bin/env python3
"""Reject unexplained whole-solve counts and storage changes before timing."""
import copy
import gzip
import importlib.util
import json
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

    def test_scalar_constants_require_unchanged_counts_in_all_workloads(self):
        for protocol in ('scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity'):
            for dimensions, updates, solves in CENSUS.CASES:
                self.assertEqual(CENSUS.compare(self.current, self.current, dimensions,
                    updates, solves, protocol), dict(requests=0, requestedBytes=0, retains=0))
                for field in ('requests', 'requestedBytes', 'retains'):
                    for delta in (-1, 1):
                        changed = copy.deepcopy(self.current)
                        changed['managed'][field] += delta
                        with self.subTest(dimensions=dimensions, updates=updates, field=field, delta=delta):
                            with self.assertRaises(AssertionError):
                                CENSUS.compare(changed, self.current, dimensions, updates, solves, protocol)

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

    def test_pair_reuse_repeated_counts_and_unchanged_retains(self):
        old = copy.deepcopy(self.current)
        expected = dict(requests=1592, requestedBytes=3273152, retains=0)
        for key, saving in expected.items():
            old['managed'][key] += saving
        self.assertEqual(CENSUS.compare(self.current, old, 129, 199, 8, 'packed-pair'), expected)
        for key in expected:
            for delta in (-1, 1):
                changed = copy.deepcopy(self.current)
                changed['managed'][key] += delta
                with self.subTest(key=key, delta=delta), self.assertRaises(AssertionError):
                    CENSUS.compare(changed, old, 129, 199, 8, 'packed-pair')
        for key in ('peakChargedBytes', 'finalChargedBytes'):
            changed = copy.deepcopy(self.current)
            changed['managed'][key] += 1
            with self.assertRaises(AssertionError):
                CENSUS.compare(changed, old, 129, 199, 8, 'packed-pair')
        self.assertEqual(CENSUS.compare(self.current, self.current, 3, 0, 32768, 'packed-pair'),
                         dict(requests=0, requestedBytes=0, retains=0))

    def test_parent_reconciliation_uses_saved_counts_and_rejects_changes(self):
        parent = Path(__file__).resolve().parent.parent / 'docs/measurements/gradient-call-census-2026-11-05'
        old_fresh = json.loads(gzip.decompress((parent / 'arm-fresh-verified.json.gz').read_bytes()))
        old_repeated = json.loads((parent / 'arm-verified.json').read_text())
        fresh = copy.deepcopy(old_fresh)
        fresh['source'] = 'f' * 40
        repeated = dict(source=fresh['source'], machine='aarch64', complete=True,
                        comparison='packed-pair', cases={})
        for name, old in old_repeated['cases'].items():
            observation = dict(managed=copy.deepcopy(old['candidate']),
                               raw=dict(peakBytes=old['rawPeakBytes'], finalBytes=old['finalRawBytes']))
            repeated['cases'][name] = dict(solves=old['solves'], observations={
                'reference' + mode: copy.deepcopy(observation) for mode in ('0', '1')})
        receipt = CENSUS.reconcile_parent(repeated, fresh, old_repeated, old_fresh)
        self.assertEqual((receipt['freshCases'], receipt['repeatedCases']), (24, 12))
        name = '129-199-current-O2'
        for key in ('requests', 'requestedBytes', 'peakChargedBytes'):
            changed = copy.deepcopy(fresh)
            changed['cases'][name]['observations']['1']['phases']['forwardWithRecording'][key] += 1
            with self.subTest(key=key), self.assertRaises(AssertionError):
                CENSUS.reconcile_parent(repeated, changed, old_repeated, old_fresh)
        changed = copy.deepcopy(repeated)
        changed['cases']['129-199-current']['observations']['reference0']['managed']['requests'] += 1
        with self.assertRaises(AssertionError):
            CENSUS.reconcile_parent(changed, fresh, old_repeated, old_fresh)
        changed = copy.deepcopy(fresh)
        del changed['cases'][name]
        with self.assertRaises(AssertionError):
            CENSUS.reconcile_parent(repeated, changed, old_repeated, old_fresh)
        changed = copy.deepcopy(fresh)
        changed['source'] = 'e' * 40
        with self.assertRaises(AssertionError):
            CENSUS.reconcile_parent(repeated, changed, old_repeated, old_fresh)

    def test_scalar_reference_reproduces_delivered_pair_storage(self):
        parent = Path(__file__).resolve().parent.parent / 'docs/measurements/packed-pair-cleanup-census-2026-11-05/aarch64/audit'
        old_fresh = json.loads(gzip.decompress((parent / 'aarch64-fresh-verified.json.gz').read_bytes()))
        old_repeated = json.loads(gzip.decompress((parent / 'aarch64-verified.json.gz').read_bytes()))
        fresh = copy.deepcopy(old_fresh)
        fresh['source'] = 'f' * 40
        repeated = dict(source=fresh['source'], machine='aarch64', complete=True,
                        comparison='scalar-constant', cases={})
        for name, old in old_repeated['cases'].items():
            observation = dict(managed=copy.deepcopy(old['candidate']),
                               raw=dict(peakBytes=old['rawPeakBytes'], finalBytes=old['finalRawBytes']))
            repeated['cases'][name] = dict(solves=old['solves'], observations={
                'reference' + mode: copy.deepcopy(observation) for mode in ('0', '1')})
        receipt = CENSUS.reconcile_parent(repeated, fresh, old_repeated, old_fresh)
        self.assertEqual(receipt['parentSource'], old_fresh['source'])
        repeated['cases']['129-199-current']['observations']['reference1']['managed']['requests'] += 1
        with self.assertRaises(AssertionError):
            CENSUS.reconcile_parent(repeated, fresh, old_repeated, old_fresh)

    def test_zero_updates_require_identical_storage(self):
        self.assertEqual(CENSUS.compare(self.current, self.current, 3, 0, 32768, 'owned-numeric'),
                         dict(requests=0, requestedBytes=0))
        candidate = copy.deepcopy(self.current)
        candidate['managed']['retains'] -= 1
        with self.assertRaises(AssertionError):
            CENSUS.compare(candidate, self.current, 3, 0, 32768, 'owned-numeric')


if __name__ == '__main__':
    unittest.main()
