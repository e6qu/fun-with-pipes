#!/usr/bin/env python3
"""Check the six-label schedule's counts, positions and preceding processes."""
import base64
from collections import Counter
import copy
import hashlib
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('unique_buffer_baselines', Path(__file__).with_name('unique-buffer-baselines.py'))
BASELINE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BASELINE)


class BufferSchedule(unittest.TestCase):
    def test_each_language_and_its_copy_get_equal_positions_and_predecessors(self):
        orders = [BASELINE.execution_order(i, BASELINE.SEED, BASELINE.PROCESSES)
                  for i in range(BASELINE.ROUNDS)]
        for order in orders:
            self.assertEqual(len(order), 72)
            self.assertEqual(Counter(order), {label: 12 for label in BASELINE.LABELS})
        for position in range(72):
            self.assertEqual(Counter(order[position] for order in orders),
                             {label: 6 for label in BASELINE.LABELS})
        pairs = Counter(pair for order in orders for pair in zip(order, order[1:]))
        self.assertEqual(pairs, {(a, b): 71 for a in BASELINE.LABELS for b in BASELINE.LABELS})
        # Between-round transitions are retained in evidence but not balanced.
        self.assertEqual(sum(pairs.values()), 36 * 71)

    def test_changed_counts_and_incomplete_rotation_range_are_rejected(self):
        for count in [0, 1, 6, 18, 24]:
            with self.subTest(count=count), self.assertRaises(AssertionError):
                BASELINE.execution_order(0, BASELINE.SEED, count)
        for index in [-1, 36, 72]:
            with self.subTest(index=index), self.assertRaises(AssertionError):
                BASELINE.execution_order(index, BASELINE.SEED, BASELINE.PROCESSES)


class BufferEvidence(unittest.TestCase):
    def observations(self):
        output = BASELINE.expected_output('scan', 16, 65536)
        rows = []
        for warmup, rounds in [(True, BASELINE.WARMUPS), (False, BASELINE.ROUNDS)]:
            for index in range(rounds):
                for position, label in enumerate(BASELINE.execution_order(index, BASELINE.SEED, BASELINE.PROCESSES)):
                    duration = {'c': 100, 'rust': 125, 'fwp': 200}[label.removesuffix('-identical')]
                    rows.append(dict(entry='scan', length=16, calls=65536, warmup=warmup,
                        round=index, position=position, label=label, status=0, timedOut=False,
                        spawnError=None, elapsedNs=duration * (100 if warmup else 1), userNs=duration,
                        systemNs=0, stdoutBase64=base64.b64encode(output).decode(), stderrBase64='',
                        stdoutSha256=hashlib.sha256(output).hexdigest(), stderrSha256=hashlib.sha256(b'').hexdigest()))
        return rows

    def test_reconstruct_complete_rounds_without_counting_warmups(self):
        result = BASELINE.summarize_case(self.observations(), 'scan', 16, 65536)
        self.assertEqual(result['identicalElapsedRatios'], dict(c=1, rust=1, fwp=1))
        self.assertEqual(result['fwpPeerElapsedRatios'], dict(c=2, rust=1.6))
        self.assertEqual(result['medianRoundElapsedNs']['fwp'], 2400)
        self.assertEqual(len(result['roundElapsedNs']['fwp']), 36)
        self.assertIn('no optimization accepted', result['decision'])

    def test_missing_duplicate_reordered_or_failed_observations_are_rejected(self):
        original = self.observations()
        changed = [original[1:], original + [original[-1]], [original[1], original[0], *original[2:]]]
        for field, value in [('entry', 'unique'), ('length', 4096), ('calls', 1), ('warmup', 1),
                             ('round', 1), ('position', 1), ('label', 'other'), ('status', 1),
                             ('timedOut', True), ('spawnError', 'cannot start'), ('elapsedNs', 0),
                             ('userNs', -1), ('systemNs', 0.5), ('stdoutBase64', 'MAo='),
                             ('stderrBase64', 'eAo='), ('stdoutSha256', '0' * 64), ('stderrSha256', '0' * 64)]:
            rows = copy.deepcopy(original)
            rows[0][field] = value
            changed.append(rows)
        for index, rows in enumerate(changed):
            with self.subTest(index=index), self.assertRaises(AssertionError):
                BASELINE.summarize_case(rows, 'scan', 16, 65536)

    def test_only_declared_workloads_and_checked_checksums(self):
        for entry in BASELINE.ENTRIES:
            for length, calls in BASELINE.CASES:
                output = BASELINE.expected_output(entry, length, calls)
                self.assertGreaterEqual(int(output), 0)
                self.assertLessEqual(int(output), 2**63 - 1)
        with self.assertRaises(AssertionError):
            BASELINE.expected_output('scan', 16, 1)


if __name__ == '__main__':
    unittest.main()
