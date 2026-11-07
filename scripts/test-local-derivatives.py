"""Reject false speed claims in the structured derivative experiment."""
import copy
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('peers', Path(__file__).with_name('measure-descent-peers.py'))
PEERS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PEERS)


class Acceptance(unittest.TestCase):
    def setUp(self):
        self.rows = {
            '3-0': dict(updates=0, medianNs={'fwp-ad': 100, 'fwp-ad-identical': 100, 'fwp-local': 100}),
            '129-199': dict(updates=199, medianNs={'fwp-ad': 100, 'fwp-ad-identical': 100, 'fwp-local': 75}),
        }

    def test_fast_candidate_does_not_hide_noisy_reference(self):
        self.assertEqual(PEERS.local_budget_failures(self.rows), [])
        for identical in [97, 103]:
            rows = copy.deepcopy(self.rows)
            rows['129-199']['medianNs']['fwp-ad-identical'] = identical
            failures = PEERS.local_budget_failures(rows)
            self.assertEqual(len(failures), 1)
            self.assertEqual(failures[0]['metric'], 'identical copy variation')

    def test_small_regression_and_insufficient_gain_are_both_reported(self):
        self.rows['3-0']['medianNs']['fwp-local'] = 103
        self.rows['129-199']['medianNs']['fwp-local'] = 81
        failures = PEERS.local_budget_failures(self.rows)
        self.assertEqual({row['case'] for row in failures}, {'3-0', '129-199'})
        self.assertEqual({row['limit'] for row in failures}, {1.02, .80})

    def test_exact_declared_noise_limit_is_not_rounded_into_failure(self):
        self.rows['129-199']['medianNs']['fwp-ad-identical'] = 102
        self.assertEqual(PEERS.local_budget_failures(self.rows), [])

    def test_local_program_uses_automatic_edge_and_common_packed_driver(self):
        source = PEERS.local_program(33, 199)
        self.assertIn('local-gradient-at local-edge values index', source)
        self.assertNotIn('previous-contribution', source)
        self.assertNotIn('packed-descend', source)
        self.assertIn('both (const 199) id | loop', source)
        self.assertIn('array.from-list | solve | array.to-list | echo', source)


if __name__ == '__main__':
    unittest.main()
