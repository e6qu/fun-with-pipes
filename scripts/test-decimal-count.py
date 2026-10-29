#!/usr/bin/env python3
"""Check decimal algorithm proofs and reject incomplete or noisy comparisons."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('decimal_count', Path(__file__).with_name('decimal-count.py'))
COUNT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COUNT)
TABLE = json.loads((COUNT.ROOT / 'docs/measurements/cpu-budgets-2026-10-28.json').read_text())


def fixture():
    row = dict(stdout=COUNT.CPU.EXPECTED['loop'], binaries={k: dict(sha256='a' * 64, bytes=2048) for k in COUNT.KINDS}, observations=[])
    for phase, rounds in [('warmup', 2), ('sample', 60)]:
        for number in range(rounds):
            for position in range(5):
                kind = COUNT.KINDS[(number + position) % 5]
                seconds = 0.008 if kind == 'candidate' else 0.01
                process = dict(seconds=seconds, status=0, stdout=row['stdout'], stderr='')
                row['observations'].append(dict(kind=kind, phase=phase, round=number, binarySha256='a' * 64, seconds=seconds, processes=[process]))
    return row


class DecimalCount(unittest.TestCase):
    def setUp(self):
        self.row = fixture()
        self.budget = next(r for r in TABLE['rows'] if r['program'] == 'loop' and r['architecture'] == 'aarch64')

    def test_exact_bit_interval_proof_and_low_bit_preserve_decimal_width(self):
        for bits in range(1, 65):
            estimate = bits * 1233 >> 12
            self.assertLessEqual(estimate, 19)
            for x in [1 << (bits - 1), (1 << bits) - 1]:
                self.assertIn(len(str(x)), [estimate, estimate + 1])
        values = [0, (1 << 64) - 1]
        for exponent in range(20):
            power = 10 ** exponent
            values.extend([power - 1, power, power + 1])
        for bits in range(64):
            power = 1 << bits
            values.extend([power - 1, power, power + 1])
        for value in values:
            x = value | 1
            self.assertEqual(len(str(value)), len(str(x)))
            estimate = x.bit_length() * 1233 >> 12
            self.assertEqual(1 + estimate - (x < 10 ** estimate), len(str(value)))

    def test_counting_cases_match_real_benchmark_inputs(self):
        programs = {p.name for p in (COUNT.ROOT / 'bench').iterdir() if (p / 'main.fwp').exists()}
        self.assertEqual(programs, {'fib', 'loop', 'map', 'pipeline', 'range-set', *COUNT.COUNTING_PROGRAMS})
        bodies = []
        for name in COUNT.COUNTING_PROGRAMS:
            text = (COUNT.ROOT / 'bench' / name / 'main.fwp').read_text()
            bodies.append('\n'.join(line for line in text.splitlines() if line.strip() and not line.startswith('#')))
        self.assertEqual(bodies[0], bodies[1])

    def test_recomputes_fixed_acceptance(self):
        result = COUNT.check_case('loop', self.row, self.budget)
        self.assertTrue(result['improvement'] and result['withinRegression'])
        self.assertEqual(result['candidateOverBaseline'], 0.8)
        self.assertIn('algorithm difference', result['peerScope'])

    def test_missing_reordered_changed_or_failed_samples_are_invalid(self):
        for defect in ['missing', 'order', 'output', 'status', 'hash', 'total', 'nan']:
            row = copy.deepcopy(self.row)
            observation = row['observations'][10]
            process = observation['processes'][0]
            if defect == 'missing': row['observations'].pop()
            elif defect == 'order': row['observations'][-1], row['observations'][-2] = row['observations'][-2], row['observations'][-1]
            elif defect == 'output': process['stdout'] = 'wrong'
            elif defect == 'status': process['status'] = 1
            elif defect == 'hash': observation['binarySha256'] = 'b' * 64
            elif defect == 'total': observation['seconds'] = 2
            else: process['seconds'] = float('nan')
            with self.subTest(defect=defect), self.assertRaises(AssertionError):
                COUNT.check_case('loop', row, self.budget)

    def test_noisy_or_slow_candidate_cannot_qualify(self):
        for kind in ['candidate', 'identical']:
            row = copy.deepcopy(self.row)
            for observation in row['observations']:
                if observation['kind'] == kind:
                    observation['processes'][0]['seconds'] = observation['seconds'] = 0.02
            result = COUNT.check_case('loop', row, self.budget)
            self.assertFalse(result['improvement'] or result['withinRegression'])
        self.row['binaries']['identical']['sha256'] = 'b' * 64
        with self.assertRaises(AssertionError):
            COUNT.check_case('loop', self.row, self.budget)


if __name__ == '__main__':
    unittest.main()
