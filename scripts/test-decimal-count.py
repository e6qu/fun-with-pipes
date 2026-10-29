#!/usr/bin/env python3
"""Check decimal algorithm proofs and reject incomplete or noisy comparisons."""
from collections import Counter
import copy
import importlib.util
import json
import re
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('decimal_count', Path(__file__).with_name('decimal-count.py'))
COUNT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COUNT)
REPEAT_SPEC = importlib.util.spec_from_file_location('decimal_repeat', Path(__file__).with_name('check-decimal-repeat.py'))
REPEAT = importlib.util.module_from_spec(REPEAT_SPEC)
REPEAT_SPEC.loader.exec_module(REPEAT)
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

    def test_threshold_tree_covers_every_decimal_interval(self):
        source = COUNT.helper((COUNT.ROOT / 'runtime/fwp_rt_ops.c').read_text())
        thresholds = [int(x) for x in re.findall(r'x < UINT64_C\((\d+)\)', source)]
        self.assertEqual(sorted(thresholds), [10 ** i for i in range(1, 20)])
        self.assertNotIn('__builtin_clz', source)
        self.assertNotIn('decimal_powers', source)
        # The emitted-C oracle checks the actual branch wiring at every edge.
        # These intervals independently cover U64 without gaps or overlap.
        low = 0
        for digits in range(1, 21):
            high = min(10 ** digits - 1, (1 << 64) - 1)
            self.assertEqual(len(str(low)), digits)
            self.assertEqual(len(str(high)), digits)
            low = high + 1
        self.assertEqual(low, 1 << 64)

    def test_counting_cases_match_real_benchmark_inputs(self):
        programs = {p.name for p in (COUNT.ROOT / 'bench').iterdir() if (p / 'main.fwp').exists()}
        self.assertEqual(programs, {'fib', 'loop', 'map', 'pipeline', 'range-set', *COUNT.COUNTING_PROGRAMS})
        bodies = []
        for name in COUNT.COUNTING_PROGRAMS:
            text = (COUNT.ROOT / 'bench' / name / 'main.fwp').read_text()
            bodies.append('\n'.join(line for line in text.splitlines() if line.strip() and not line.startswith('#')))
        self.assertEqual(bodies[0], bodies[1])

    def test_recomputes_fixed_acceptance(self):
        result = COUNT.check_case('loop', self.row, self.budget, 'threshold-tree', COUNT.SHORT_SETTINGS)
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
                COUNT.check_case('loop', row, self.budget, 'threshold-tree', COUNT.SHORT_SETTINGS)

    def test_longer_batches_keep_the_same_limits_and_require_every_process(self):
        row = copy.deepcopy(self.row)
        for observation in row['observations']:
            observation['processes'] *= COUNT.LONG_SETTINGS['processes']['loop']
            observation['seconds'] = sum(p['seconds'] for p in observation['processes'])
        result = COUNT.check_case('loop', row, self.budget, 'threshold-tree', COUNT.LONG_SETTINGS)
        self.assertTrue(result['improvement'] and result['withinRegression'])
        row['observations'][0]['processes'].pop()
        with self.assertRaises(AssertionError):
            COUNT.check_case('loop', row, self.budget, 'threshold-tree', COUNT.LONG_SETTINGS)
        with self.assertRaises(AssertionError):
            COUNT.check_case('loop', self.row, self.budget, 'threshold-tree', COUNT.LONG_SETTINGS)

    def test_interleaved_processes_require_the_exact_rotating_schedule(self):
        row = copy.deepcopy(self.row)
        count = COUNT.INTERLEAVED_SETTINGS['processes']['loop']
        for index, observation in enumerate(row['observations']):
            round_index = index // len(COUNT.KINDS)
            kind = observation['kind']
            number = observation['round']
            process = observation['processes'][0]
            observation['processes'] = [dict(process, sequence=(round_index * count + i) * len(COUNT.KINDS) + (COUNT.KINDS.index(kind) - number - i) % len(COUNT.KINDS)) for i in range(count)]
            observation['seconds'] = sum(p['seconds'] for p in observation['processes'])
        result = COUNT.check_case('loop', row, self.budget, 'threshold-tree', COUNT.INTERLEAVED_SETTINGS)
        self.assertTrue(result['improvement'] and result['withinRegression'])
        row['observations'][0]['processes'][0]['sequence'] += 1
        with self.assertRaises(AssertionError):
            COUNT.check_case('loop', row, self.budget, 'threshold-tree', COUNT.INTERLEAVED_SETTINGS)

    def test_balanced_cycle_covers_every_pair_and_rotates_every_position(self):
        cycle = COUNT.balanced_cycle()
        self.assertEqual(Counter(cycle), Counter({kind: 5 for kind in COUNT.KINDS}))
        pairs = Counter(zip(cycle, cycle[1:] + cycle[:1]))
        self.assertEqual(pairs, Counter({(a, b): 1 for a in COUNT.KINDS for b in COUNT.KINDS}))
        for name in COUNT.CPU.PROGRAMS:
            count = COUNT.BALANCED_SETTINGS['processes'][name]
            positions = [Counter() for _ in range(count * len(COUNT.KINDS))]
            previous = COUNT.KINDS[0]
            for number in range(COUNT.BALANCED_SETTINGS['samples']):
                order = COUNT.execution_order(COUNT.BALANCED_SETTINGS, name, number)
                self.assertEqual(Counter(order), Counter({kind: count for kind in COUNT.KINDS}))
                actual_pairs = Counter(zip([previous] + order[:-1], order))
                ideal_pairs = Counter({(a, b): count // len(COUNT.KINDS) for a in COUNT.KINDS for b in COUNT.KINDS})
                self.assertLessEqual(sum(abs(actual_pairs[p] - ideal_pairs[p]) for p in ideal_pairs), 2)
                previous = order[-1]
                for position, kind in zip(positions, order):
                    position[kind] += 1
            self.assertTrue(all(p == Counter({kind: 15 for kind in COUNT.KINDS}) for p in positions))

    def test_session_selection_keeps_early_failures_and_rejects_missing_jobs(self):
        entries = [dict(run=10, job=i, architecture=arch, qualifies=i > 2)
                   for arch, numbers in [('aarch64', [1, 3, 5]), ('x86_64', [2, 4, 6])]
                   for i in numbers]
        for entry in entries:
            entry['jobMetadata'] = dict(id=entry['job'], run_id=entry['run'], runner_id=entry['job'], started_at='2026-10-29T00:00:00Z', completed_at='2026-10-29T00:01:00Z')
        selected = REPEAT.select_sessions(list(reversed(entries)))
        self.assertEqual([e['job'] for e in selected], [1, 3, 2, 4])
        self.assertFalse(all(e['qualifies'] for e in selected))
        copied = copy.deepcopy(entries)
        copied[1]['jobMetadata']['runner_id'] = copied[0]['jobMetadata']['runner_id']
        for invalid in [entries + [entries[0]], entries[:3], [dict(entries[0], job=-1)] + entries[1:], copied]:
            with self.assertRaises(AssertionError):
                REPEAT.select_sessions(invalid)

    def test_noisy_or_slow_candidate_cannot_qualify(self):
        for kind in ['candidate', 'identical']:
            row = copy.deepcopy(self.row)
            for observation in row['observations']:
                if observation['kind'] == kind:
                    observation['processes'][0]['seconds'] = observation['seconds'] = 0.02
            result = COUNT.check_case('loop', row, self.budget, 'threshold-tree', COUNT.SHORT_SETTINGS)
            self.assertFalse(result['improvement'] or result['withinRegression'])
        self.row['binaries']['identical']['sha256'] = 'b' * 64
        with self.assertRaises(AssertionError):
            COUNT.check_case('loop', self.row, self.budget, 'threshold-tree', COUNT.SHORT_SETTINGS)


if __name__ == '__main__':
    unittest.main()
