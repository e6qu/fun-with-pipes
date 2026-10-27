#!/usr/bin/env python3
"""Reject missing timings, altered budgets and unreported timing failures."""

import copy
import importlib.util
from pathlib import Path
import unittest


SPEC = importlib.util.spec_from_file_location('sort_time_reader', Path(__file__).with_name('inspect-inline-sort-time.py'))
READER = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(READER)


class TimingEvidence(unittest.TestCase):
    def setUp(self):
        self.settings = dict(samples=6, small_rounds=32768, large_rounds=2048, max_control_ratio=1.10)
        controls, candidate = [], []
        for session in range(2):
            control_pairs, candidate_pairs = [], []
            for i in range(6):
                control = [('baseline', 100_000_000), ('baseline-copy', 102_000_000)]
                pair = [('baseline', 100_000_000), ('candidate', 60_000_000)]
                control_pairs.append(dict(control if i % 2 == 0 else reversed(control)))
                candidate_pairs.append(dict(pair if i % 2 == 0 else reversed(pair)))
            controls.append(dict(session=session, pairs=control_pairs))
            candidate.append(dict(session=session, pairs=candidate_pairs, medianRatio=0.6))
        noise = abs(1.02 - 1)
        self.row = dict(elements=256, rounds=32768, control=controls, candidate=candidate,
                        controlEnvelope=noise, allowedCandidateRatio=1 + 2 * noise)

    def test_complete_samples(self):
        self.assertEqual(READER.check_case(self.row, self.settings), [])

    def test_missing_sample_and_changed_budget(self):
        for target in ('control', 'candidate'):
            row = copy.deepcopy(self.row)
            row[target][0]['pairs'].pop()
            with self.assertRaises(AssertionError):
                READER.check_case(row, self.settings)
        row = copy.deepcopy(self.row)
        row['allowedCandidateRatio'] = 2
        with self.assertRaises(AssertionError):
            READER.check_case(row, self.settings)

    def test_noise_rejects_candidate_and_does_not_hide_failure(self):
        row = copy.deepcopy(self.row)
        for session in row['control']:
            for pair in session['pairs']:
                pair['baseline-copy'] = 120_000_000
        row['controlEnvelope'] = abs(1.2 - 1)
        row['allowedCandidateRatio'] = 1 + 2 * row['controlEnvelope']
        with self.assertRaises(AssertionError):
            READER.check_case(row, self.settings)
        row['candidate'] = []
        self.assertEqual(READER.check_case(row, self.settings),
                         ['256: identical-code control exceeds explicit noise limit'])

    def test_slow_candidate_is_reported(self):
        row = copy.deepcopy(self.row)
        for session in row['candidate']:
            for pair in session['pairs']:
                pair['candidate'] = 130_000_000
            session['medianRatio'] = 1.3
        self.assertEqual(len(READER.check_case(row, self.settings)), 2)


if __name__ == '__main__':
    unittest.main()
