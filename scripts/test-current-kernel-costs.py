#!/usr/bin/env python3
"""Controls for six-role schedules, both noise pairs and nonaggregated costs."""
from collections import Counter
import copy
import unittest

from current_kernel_costs import LABELS, METRICS, decisions, execution_order, summarize


def observations():
    result = []
    for phase, count in (('warmup', 2), ('sample', 18)):
        for index in range(count):
            order = execution_order(index, 4)
            rows = []
            for label in order:
                duration = 80 if label.startswith('fwp') else 100
                samples = [dict(kernelNs=duration, allocationInclusiveNs=200) for _ in range(5)]
                rows.append(dict(label=label, samples=samples))
            result.append(dict(phase=phase, round=index, complete=True, order=order, observations=rows))
    return result


def result_row():
    row = summarize(observations(), 4)
    profile = [dict(requests=8, requestedBytes=1024, retains=0, peakChargedBytes=128) for _ in range(5)]
    row['profiles'] = dict(fwp=copy.deepcopy(profile), reference=copy.deepcopy(profile))
    return row


class CurrentKernelCosts(unittest.TestCase):
    def test_every_role_and_position_balanced_for_both_work_counts(self):
        for processes in (4, 256):
            positions = Counter()
            for index in range(18):
                order = execution_order(index, processes)
                self.assertEqual(Counter(order), Counter({role: processes for role in LABELS}))
                for position, role in enumerate(order):
                    positions[position, role] += 1
            self.assertEqual(set(positions.values()), {3})
            self.assertEqual(len(positions), 36 * processes)

    def test_rejects_undeclared_rounds_and_counts(self):
        for index, processes in ((-1, 4), (18, 4), (True, 4), (0, 5), (0, True)):
            with self.subTest(index=index, processes=processes), self.assertRaises(AssertionError):
                execution_order(index, processes)

    def test_totals_exclude_warmups_and_use_all_samples(self):
        records = observations()
        records[0]['observations'][0]['samples'][0]['kernelNs'] = 999999
        row = summarize(records, 4)
        self.assertEqual(row['totals']['fwp']['kernelNs'], [1600] * 18)
        self.assertEqual(row['totals']['reference']['kernelNs'], [2000] * 18)
        self.assertEqual(row['ratios']['reference']['kernelNs'], 0.8)
        self.assertEqual(row['identicalRatios'], {
            role: {metric: 1.0 for metric in METRICS} for role in ('fwp', 'reference')})
        self.assertEqual(sum(x['count'] for x in row['withinRoundAdjacency']), 18 * 23)

    def test_partial_duplicate_or_reordered_observations_fail(self):
        for change in ('partial', 'duplicate', 'reordered', 'missing', 'phase'):
            records = observations()
            if change == 'partial':
                records[-1]['complete'] = False
            elif change == 'duplicate':
                records[-1] = records[-2]
            elif change == 'reordered':
                records[-1]['observations'].reverse()
            elif change == 'missing':
                records.pop()
            else:
                records[-1]['phase'] = 'warmup'
            with self.subTest(change=change), self.assertRaises(AssertionError):
                summarize(records, 4)

    def test_both_noise_controls_and_each_timing_scope_are_required(self):
        for role in ('fwp', 'reference'):
            for metric in METRICS:
                row = result_row()
                row['identicalRatios'][role][metric] = 1.021
                failures = decisions({'array-65537': row}, {'array-65537', 'array-262145'})
                self.assertEqual(len(failures), 1)
                self.assertEqual(failures[0]['kind'], 'copy')
                self.assertEqual(failures[0]['label'], role)
                self.assertEqual(failures[0]['metric'], metric)

    def test_speed_thresholds_and_control_cases_remain_separate(self):
        row = result_row()
        self.assertEqual(decisions({'array-65537': row}, {'array-65537', 'array-262145'}), [])
        row['ratios']['reference']['kernelNs'] = 0.96
        self.assertEqual(decisions({'array-65537': row}, {'array-65537', 'array-262145'})[0]['limit'], 0.95)
        self.assertEqual(decisions({'matrix-65-67-63': row}, {'array-65537', 'array-262145'}), [])
        row['ratios']['reference']['allocationInclusiveNs'] = 1.03
        self.assertEqual(decisions({'matrix-65-67-63': row}, {'array-65537', 'array-262145'})[0]['limit'], 1.02)

    def test_every_memory_sample_and_metric_is_checked(self):
        for metric in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes'):
            row = result_row()
            row['profiles']['fwp'][-1][metric] += 1
            failures = decisions({'array-65537': row}, {'array-65537', 'array-262145'})
            self.assertEqual(len(failures), 1)
            self.assertEqual((failures[0]['kind'], failures[0]['sample'], failures[0]['metric']),
                             ('memory', 4, metric))

    def test_matrix_speed_target_is_explicit_and_scope_specific(self):
        row = result_row()
        row['ratios']['reference']['kernelNs'] = 0.96
        self.assertEqual(decisions({'matrix-257-259-255': row}, set()), [])
        failures = decisions({'matrix-257-259-255': row}, {'matrix-257-259-255'})
        self.assertEqual([(f['kind'], f['metric'], f['limit']) for f in failures],
                         [('speed', 'kernelNs', 0.95)])
        self.assertEqual(decisions({'matrix-65-67-63': row}, {'matrix-257-259-255'}), [])
        row['ratios']['reference']['allocationInclusiveNs'] = 1.021
        self.assertEqual(decisions({'matrix-65-67-63': row}, set())[0]['limit'], 1.02)


if __name__ == '__main__':
    unittest.main()
