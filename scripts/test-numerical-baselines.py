#!/usr/bin/env python3
"""Check kernel oracles against simple loops and reject unbalanced evidence."""
from collections import Counter
import copy
import importlib.util
import json
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('numerical_baselines', Path(__file__).with_name('numerical-baselines.py'))
BASELINE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BASELINE)
SPEC = importlib.util.spec_from_file_location('kernel_measurement', Path(__file__).with_name('measure-kernel-baselines.py'))
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)


class NumericalBaselines(unittest.TestCase):
    def test_larger_sample_preserves_counts_positions_and_predecessors(self):
        orders = [BASELINE.execution_order(i, 20261029, 256) for i in range(16)]
        for order in orders:
            self.assertEqual(Counter(order), {label: 256 for label in BASELINE.LABELS})
            self.assertEqual(len(order), 1024)
        for position in range(1024):
            self.assertEqual(Counter(order[position] for order in orders),
                             {label: 4 for label in BASELINE.LABELS})
        pairs = Counter(pair for order in orders for pair in zip(order, order[1:]))
        self.assertEqual(pairs, {(a, b): 1023 for a in BASELINE.LABELS for b in BASELINE.LABELS})
        for count in [0, 1, 5, 128, 512]:
            with self.subTest(count=count), self.assertRaises(AssertionError):
                BASELINE.execution_order(0, 20261029, count)

    def test_every_label_and_predecessor_occupies_each_position(self):
        orders = [BASELINE.execution_order(i, 20261029, 4) for i in range(16)]
        for order in orders:
            self.assertEqual(Counter(order), {label: 4 for label in BASELINE.LABELS})
            self.assertEqual(Counter(zip(order, order[1:] + order[:1])),
                             {(a, b): 1 for a in BASELINE.LABELS for b in BASELINE.LABELS})
        for position in range(16):
            self.assertEqual(Counter(order[position] for order in orders),
                             {label: 4 for label in BASELINE.LABELS})
        # Every within-round predecessor pair occurs fifteen times. Edges
        # between rounds are retained too, but are not claimed to be balanced.
        pairs = Counter(pair for order in orders for pair in zip(order, order[1:]))
        self.assertEqual(pairs, {(a, b): 15 for a in BASELINE.LABELS for b in BASELINE.LABELS})
        with self.assertRaises(AssertionError):
            BASELINE.execution_order(-1, 20261029, 4)

    def test_array_integer_oracle_matches_ordered_float_operations(self):
        for n in [0, 1, 7, 18, 19, 20, 38, 131]:
            for r in range(8):
                result = -0.0
                for i in range(n):
                    x = ((i + r) % 19 - 9) / 4
                    mapped = x * 3
                    mapped = mapped + 1
                    result = mapped + result
                self.assertEqual(BASELINE.array_result(n, r), BASELINE.bits(result))
        self.assertEqual(BASELINE.array_result(0, 0), 1 << 63)
        with self.assertRaises(AssertionError):
            BASELINE.array_result(262146, 0)

    def test_matrix_integer_oracle_matches_simple_float_multiplication(self):
        for m, k, n in [(1, 1, 1), (2, 3, 5), (3, 20, 13), (2, 248, 7), (1, 259, 3)]:
            for r in [0, 3, 7]:
                expected = []
                for i in range(m):
                    for j in range(n):
                        total = 0.0
                        for q in range(k):
                            a = ((i*k + q + r) % 19 - 9) / 4
                            b = ((q*n + j + r) % 13 - 6) / 8
                            total = a*b + total
                        expected.append(BASELINE.bits(total))
                self.assertEqual(BASELINE.matrix_result(m, k, n, r), expected)
        with self.assertRaises(AssertionError):
            BASELINE.matrix_result(1, 260, 1, 0)

    def test_complete_output_distinguishes_positions_and_signed_zero(self):
        rounds = [[BASELINE.bits(1.0), BASELINE.bits(-0.0)], [BASELINE.bits(0.0)]]
        self.assertEqual(BASELINE.verification_output(rounds),
                         b'0:0:3ff0000000000000\n0:1:8000000000000000\n1:0:0000000000000000\n')
        self.assertNotEqual(BASELINE.result_hash(rounds), BASELINE.result_hash([rounds[0][::-1], rounds[1]]))
        with self.assertRaises(AssertionError):
            BASELINE.result_hash([[-1]])

    def test_missing_samples_wrong_results_and_live_storage_cannot_pass(self):
        for label, live in [('c', 'livePayloadBytes'), ('fwp', 'liveChargedBytes')]:
            sample = dict(hash='1234', kernelNs=10, allocationInclusiveNs=20,
                          requests=8, requestedBytes=64, **{live: 0})
            good = {'samples': [sample] * 5}
            self.assertEqual(len(MEASURE.check_samples(json.dumps(good), '1234', label, True)), 5)
            for field, value in [('hash', 'wrong'), ('kernelNs', 0), ('allocationInclusiveNs', 9),
                                 ('requests', 0), ('requestedBytes', -1), (live, 8)]:
                bad = copy.deepcopy(good)
                bad['samples'][0][field] = value
                with self.subTest(label=label, field=field), self.assertRaises(AssertionError):
                    MEASURE.check_samples(json.dumps(bad), '1234', label, True)
            with self.assertRaises(AssertionError):
                MEASURE.check_samples(json.dumps({'samples': good['samples'][:-1]}), '1234', label, True)

    def test_changed_or_duplicate_instrumentation_boundary_is_rejected(self):
        for source in ['beforebefore', 'changed']:
            with self.assertRaises(AssertionError):
                MEASURE.replace_once(source, 'before', 'after')


if __name__ == '__main__':
    unittest.main()
