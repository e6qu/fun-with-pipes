#!/usr/bin/env python3
"""Check process-order balance and explicit host rejection."""
from collections import Counter
import importlib.util
from pathlib import Path
import subprocess
from tempfile import TemporaryDirectory
import unittest
from unittest.mock import patch
import json

SPEC = importlib.util.spec_from_file_location('descent_baselines', Path(__file__).with_name('descent-baselines.py'))
BASELINE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BASELINE)
LABELS = list('abcdefg')


class Measurement(unittest.TestCase):
    def test_each_process_count_and_predecessor_are_balanced(self):
        for count in [7, 21, 42]:
            for index in range(98):
                order = BASELINE.execution_order(LABELS, count, index, 20261029)
                self.assertEqual(Counter(order), Counter({label: count for label in LABELS}))
                cyclic = Counter(zip(order, order[1:] + order[:1]))
                self.assertEqual(cyclic, Counter({(a, b): count // 7 for a in LABELS for b in LABELS}))

    def test_start_and_end_positions_rotate_evenly(self):
        orders = [BASELINE.execution_order(LABELS, 42, index, 20261029) for index in range(98)]
        self.assertEqual(Counter(order[0] for order in orders), Counter({label: 14 for label in LABELS}))
        self.assertEqual(Counter(order[-1] for order in orders), Counter({label: 14 for label in LABELS}))
        # A round boundary replaces one cyclic edge; retain it rather than
        # claiming the complete flattened schedule has perfect balance.
        actual = Counter()
        for left, right in zip(orders, orders[1:]):
            actual[(left[-1], right[0])] += 1
        self.assertEqual(sum(actual.values()), 97)

    def test_schedule_is_reproducible_and_rejects_partial_cycles(self):
        self.assertEqual(BASELINE.execution_order(LABELS, 7, 4, 20261029), BASELINE.execution_order(LABELS, 7, 4, 20261029))
        for count in [0, 1, 8]:
            with self.assertRaises(AssertionError):
                BASELINE.execution_order(LABELS, count, 0, 20261029)

    def test_round_sums_every_process_and_preserves_all_observations(self):
        with TemporaryDirectory() as temporary:
            target = Path(temporary) / 'sample.json'
            def run(command, env):
                return subprocess.CompletedProcess(command, 0, command[0].encode(), b'')
            with patch.object(BASELINE.time, 'perf_counter_ns', side_effect=[10, 15, 20, 27, 30, 39]):
                totals = BASELINE.measure_round(['a', 'b', 'a'], {'a': 'a', 'b': 'b'},
                    {'a': b'a', 'b': b'b'}, {}, run, target)
            self.assertEqual(totals, {'a': 14, 'b': 7})
            report = json.loads(target.read_text())
            self.assertTrue(report['complete'])
            self.assertEqual([row['elapsedNs'] for row in report['observations']], [5, 7, 9])
            self.assertTrue(all(row['outputMatches'] and row['status'] == 0 for row in report['observations']))

    def test_wrong_output_and_nonzero_status_remain_failed_observations(self):
        for result in [subprocess.CompletedProcess([], 0, b'wrong', b''),
                       subprocess.CompletedProcess([], 1, b'expected', b'failure')]:
            with TemporaryDirectory() as temporary:
                target = Path(temporary) / 'sample.json'
                with self.assertRaises(AssertionError):
                    BASELINE.measure_round(['a'], {'a': 'a'}, {'a': b'expected'}, {},
                                           lambda command, env: result, target)
                report = json.loads(target.read_text())
                self.assertFalse(report['complete'])
                self.assertFalse(report['observations'][0]['outputMatches'])
                self.assertEqual(target.with_suffix('.stdout').read_bytes(), result.stdout)
                self.assertEqual(target.with_suffix('.stderr').read_bytes(), result.stderr)

    def test_interrupted_round_preserves_completed_processes(self):
        with TemporaryDirectory() as temporary:
            target = Path(temporary) / 'sample.json'
            results = iter([subprocess.CompletedProcess([], 0, b'expected', b''), None])
            def run(command, env):
                result = next(results)
                if result is None:
                    raise TimeoutError('deliberate command timeout')
                return result
            with self.assertRaises(TimeoutError):
                BASELINE.measure_round(['a', 'a'], {'a': 'a'}, {'a': b'expected'}, {}, run, target)
            report = json.loads(target.read_text())
            self.assertFalse(report['complete'])
            self.assertEqual(len(report['observations']), 1)
            self.assertEqual(report['order'], ['a', 'a'])

    def test_matching_is_exact_and_reports_all_mismatches(self):
        expected = dict(cpu='Neoverse-N2', machine='aarch64', processors=4, cVersion='gcc 13', rustVersion='rustc 1.99')
        self.assertEqual(BASELINE.host_failures(expected, expected), [])
        changed = expected | dict(cpu='different host', processors=2, cVersion='gcc 15')
        failures = BASELINE.host_failures(changed, expected)
        self.assertEqual(len(failures), 3)
        for key in ['cpu:', 'processors:', 'cVersion:']:
            self.assertTrue(any(line.startswith(key) for line in failures))


if __name__ == '__main__':
    unittest.main()
