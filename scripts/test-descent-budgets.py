#!/usr/bin/env python3
"""Check descent acceptance requirements using retained measurements and faults."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('descent', ROOT / 'scripts/measure-descent-peers.py')
DESCENT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(DESCENT)
BASELINE = json.loads((ROOT / 'docs/measurements/array-capture-descent-2026-10-22.json').read_text())


class DescentBudgets(unittest.TestCase):
    def recording_case(self, updates):
        row = dict(dimensions=3, updates=updates, solvesPerProcess=1,
                   medianNs={'fwp-ad-identical': 95 if updates else 100},
                   fwpProfiles={}, binaries={}, cCompilerStackUsage={})
        for label in ['fwp-ad', 'fwp-ad-history']:
            for reference in [False, True]:
                name = label + ('-reference' if reference else '')
                removed = 0 if reference else 16 * updates
                row['medianNs'][name] = 100 if reference or not updates else 95
                row['fwpProfiles'][name] = dict(
                    managed=dict(requests=1000 - removed, requestedBytes=40000 - 40 * removed,
                                 retains=100, peakChargedBytes=80, finalChargedBytes=0),
                    rawDerivativeStorage={'finalBytes': 0}, expandedRawSha256='unchanged')
                row['binaries'][name] = dict(instructionBytes=10000)
                row['cCompilerStackUsage'][name + '.su'] = dict(entries=[dict(bytes=64)])
        return row

    def test_recording_limits_accept_boundaries_without_changing_observations(self):
        rows = {str(updates): self.recording_case(updates) for updates in [0, 1]}
        rows['1']['binaries']['fwp-ad']['instructionBytes'] += 1024
        rows['1']['cCompilerStackUsage']['fwp-ad.su']['entries'][0]['bytes'] += 128
        snapshot = copy.deepcopy(rows)
        self.assertEqual(DESCENT.paired_budget_failures(rows, 'scalar-recording'), [])
        self.assertEqual(rows, snapshot)

    def test_recording_limits_report_noise_time_memory_code_and_stack_failures(self):
        row = self.recording_case(1)
        row['medianNs']['fwp-ad'] = 103
        profile = row['fwpProfiles']['fwp-ad']
        for key in profile['managed']:
            profile['managed'][key] += 1
        profile['rawDerivativeStorage']['finalBytes'] = 1
        profile['expandedRawSha256'] = 'changed'
        row['binaries']['fwp-ad']['instructionBytes'] += 1025
        row['cCompilerStackUsage']['fwp-ad.su']['entries'][0]['bytes'] += 129
        failures = DESCENT.paired_budget_failures({'case': row}, 'scalar-recording')
        self.assertEqual({failure['metric'] for failure in failures}, {
            'identical median variation', 'candidate/reference time', 'requests',
            'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes',
            'rawDerivativeStorage', 'expandedRawSha256', 'instruction bytes',
            'largest static stack frame'})
        self.assertEqual(len(failures), 11)

    def test_recording_zero_updates_still_rejects_regression(self):
        row = self.recording_case(0)
        row['medianNs']['fwp-ad-history'] = 103
        failures = DESCENT.paired_budget_failures({'zero': row}, 'scalar-recording')
        self.assertEqual([failure['metric'] for failure in failures], ['candidate/reference time'])

    def test_array_list_limits_keep_memory_savings_separate_from_noisy_timing(self):
        row = self.recording_case(1)
        for label in ['fwp-ad', 'fwp-ad-history']:
            row['medianNs'][label] = 102
            profile = row['fwpProfiles'][label]['managed']
            profile['requests'] = 997
            profile['requestedBytes'] = 40000 - 72
        row['medianNs']['fwp-ad-identical'] = 102
        self.assertEqual(DESCENT.paired_budget_failures({'one': row}, 'array-lists'), [])
        snapshot = copy.deepcopy(row)
        row['medianNs']['fwp-ad-identical'] = 99
        self.assertEqual([failure['metric'] for failure in DESCENT.paired_budget_failures(
            {'one': row}, 'array-lists')], ['identical median variation'])
        row = snapshot
        row['fwpProfiles']['fwp-ad']['managed']['requests'] += 1
        self.assertEqual([failure['metric'] for failure in DESCENT.paired_budget_failures(
            {'one': row}, 'array-lists')], ['requests'])

    def test_eager_capture_limits_accept_only_lower_updated_allocation_counts(self):
        rows = {str(updates): self.recording_case(updates) for updates in [0, 1]}
        for row in rows.values():
            for label in ['fwp-ad', 'fwp-ad-history']:
                row['fwpProfiles'][label]['managed']['requests'] = 1000 - int(row['updates'] > 0)
        snapshot = copy.deepcopy(rows)
        self.assertEqual(DESCENT.paired_budget_failures(rows, 'eager-captures'), [])
        self.assertEqual(rows, snapshot)
        for key in ['0', '1']:
            changed = copy.deepcopy(rows)
            changed[key]['fwpProfiles']['fwp-ad']['managed']['requests'] += 1
            failures = DESCENT.paired_budget_failures(changed, 'eager-captures')
            self.assertEqual([failure['metric'] for failure in failures], ['requests'])

    def test_eager_capture_failures_keep_all_time_storage_and_layout_limits(self):
        row = self.recording_case(1)
        row['medianNs']['fwp-ad'] = 103
        profile = row['fwpProfiles']['fwp-ad']
        profile['managed']['requests'] = 1000
        for key in ['retains', 'peakChargedBytes', 'finalChargedBytes']:
            profile['managed'][key] += 1
        profile['rawDerivativeStorage']['finalBytes'] = 1
        profile['expandedRawSha256'] = 'changed'
        row['binaries']['fwp-ad']['instructionBytes'] += 1025
        row['cCompilerStackUsage']['fwp-ad.su']['entries'][0]['bytes'] += 129
        failures = DESCENT.paired_budget_failures({'case': row}, 'eager-captures')
        self.assertEqual({failure['metric'] for failure in failures}, {
            'identical median variation', 'candidate/reference time', 'requests',
            'retains', 'peakChargedBytes', 'finalChargedBytes', 'rawDerivativeStorage',
            'expandedRawSha256', 'instruction bytes', 'largest static stack frame'})
        self.assertEqual(len(failures), 10)
        zero = self.recording_case(0)
        zero['medianNs']['fwp-ad-history'] = 103
        failures = DESCENT.paired_budget_failures({'zero': zero}, 'eager-captures')
        self.assertEqual([failure['metric'] for failure in failures], ['candidate/reference time'])
        with self.assertRaises(AssertionError):
            DESCENT.paired_budget_failures({}, 'undeclared')

    def test_each_recorded_input_requires_the_declared_count_and_storage_limits(self):
        for host in BASELINE['hosts']:
            for case, row in host['report']['results'].items():
                with self.subTest(host=host['host'], case=case):
                    old = row['fwpProfiles']
                    current = copy.deepcopy(old)
                    current['fwp-packed-baseline'] = copy.deepcopy(old['fwp-packed'])
                    failures = DESCENT.ownership_budget_failures(current, old)
                    self.assertEqual(old['fwp-packed']['managed']['retains'], 0)
                    self.assertEqual(failures, [])

    def test_reports_independent_failures_together_without_changing_inputs(self):
        old = BASELINE['hosts'][0]['report']['results']['129-199']['fwpProfiles']
        current = copy.deepcopy(old)
        current['fwp-packed-baseline'] = copy.deepcopy(old['fwp-packed'])
        current['fwp-ad']['managed']['retains'] += 1
        current['fwp-ad']['managed']['peakChargedBytes'] += 8
        current['fwp-explicit']['managed']['requests'] += 1
        current['fwp-explicit']['managed']['requestedBytes'] += 8
        current['fwp-packed']['managed']['retains'] += 1
        current['fwp-packed']['managed']['requestedBytes'] += 8
        current['fwp-packed']['managed']['peakChargedBytes'] += 8
        snapshot = copy.deepcopy(current)
        failures = DESCENT.ownership_budget_failures(current, old)
        self.assertEqual({(row['program'], row['metric']) for row in failures}, {
            ('fwp-ad', 'retains'), ('fwp-ad', 'peakChargedBytes'),
            ('fwp-explicit', 'requests'), ('fwp-explicit', 'requestedBytes'),
            ('fwp-packed', 'requestedBytes'), ('fwp-packed', 'peakChargedBytes'),
            ('fwp-packed', 'retains'),
        })
        self.assertEqual(len(failures), 7)
        self.assertEqual(current, snapshot)
        self.assertTrue(all('actual' in row and 'expected' in row for row in failures))

    def test_a_changed_recompiled_baseline_cannot_pass(self):
        old = BASELINE['hosts'][0]['report']['results']['129-199']['fwpProfiles']
        current = copy.deepcopy(old)
        current['fwp-packed-baseline'] = copy.deepcopy(old['fwp-packed'])
        current['fwp-packed']['managed']['retains'] = 0
        current['fwp-packed-baseline']['managed']['retains'] = 1
        failures = DESCENT.ownership_budget_failures(current, old)
        self.assertEqual([(row['program'], row['metric']) for row in failures], [
            ('fwp-packed-baseline', 'accepted profile')])


if __name__ == '__main__':
    unittest.main()
