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
    def test_storage_predictions_keep_exact_counts_and_all_timing_limits(self):
        cases = {
            'scalar-constant': tuple((n, u, 0, 0, 0) for n, u in
                ((3, 0), (3, 1), (3, 199), (3, 1999), (33, 199), (129, 199))),
            'gradient-call': ((3, 0, 0, 0, 0), (3, 1, 57, 1240, 16),
                (3, 199, 11145, 242008, 3184), (3, 1999, 111945, 2430808, 31984),
                (33, 199, 11145, 624088, 3184), (129, 199, 11145, 1846744, 3184)),
            'packed-pair': ((3, 0, 0, 0, 0), (3, 1, 8, 320, 0),
                (3, 199, 1592, 63680, 0), (3, 1999, 15992, 639680, 0),
                (33, 199, 1592, 827840, 0), (129, 199, 1592, 3273152, 0)),
        }
        cases['recording-lookup'] = cases['scalar-constant']
        for protocol, predictions in cases.items():
            for dimensions, updates, requests, byte_count, retains in predictions:
                row = self.recording_case(updates)
                row.update(dimensions=dimensions, solvesPerProcess=8)
                elapsed = 95 if updates >= 199 else 100
                row['medianNs']['fwp-ad-identical'] = elapsed
                for label in ('fwp-ad', 'fwp-ad-history'):
                    row['medianNs'][label] = elapsed
                    old = row['fwpProfiles'][label + '-reference']['managed']
                    old.update(requests=requests + 100, requestedBytes=byte_count + 1000, retains=retains + 10)
                    row['fwpProfiles'][label]['managed'] = dict(old, requests=100, requestedBytes=1000, retains=10)
                    row['binaries'][label]['instructionBytes'] += 10000
                self.assertEqual(DESCENT.paired_budget_failures({'case': row}, protocol), [])
                for label in ('fwp-ad', 'fwp-ad-history'):
                    for metric in ('requests', 'requestedBytes', 'retains'):
                        for delta in (-1, 1):
                            changed = copy.deepcopy(row)
                            changed['fwpProfiles'][label]['managed'][metric] += delta
                            self.assertIn(metric, [failure['metric'] for failure in
                                DESCENT.paired_budget_failures({'case': changed}, protocol)])
                    for metric in ('peakChargedBytes', 'finalChargedBytes'):
                        changed = copy.deepcopy(row)
                        changed['fwpProfiles'][label]['managed'][metric] += 1
                        self.assertIn(metric, [failure['metric'] for failure in
                            DESCENT.paired_budget_failures({'case': changed}, protocol)])
                    changed = copy.deepcopy(row)
                    changed['medianNs'][label] = 96 if updates >= 199 else 103
                    if label == 'fwp-ad':
                        changed['medianNs']['fwp-ad-identical'] = changed['medianNs'][label]
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, protocol)], ['candidate/reference time'])
                    changed = copy.deepcopy(row)
                    changed['cCompilerStackUsage'][label + '.su']['entries'][0]['bytes'] = 193
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, protocol)], ['largest static stack frame'])
                    changed = copy.deepcopy(row)
                    changed['fwpProfiles'][label]['rawDerivativeStorage']['peakBytes'] = 999999
                    self.assertIn('rawDerivativeStorage', [failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, protocol)])
                changed = copy.deepcopy(row)
                changed['medianNs']['fwp-ad-identical'] = elapsed * 1.03
                self.assertEqual([failure['metric'] for failure in
                    DESCENT.paired_budget_failures({'case': changed}, protocol)], ['identical median variation'])

    def test_consumed_storage_keeps_first_shared_coordinates_and_every_limit(self):
        # Frozen per-solve predictions: first coordinates are shared; later
        # exclusive cells and every fresh gradient-map buffer can be reused.
        cases = ((3, 0, 0, 0), (3, 1, 1, 32), (3, 199, 793, 20624),
                 (3, 1999, 7993, 207824), (33, 199, 6733, 210944),
                 (129, 199, 25741, 819968))
        for dimensions, updates, requests, requested_bytes in cases:
            row = self.recording_case(updates)
            row.update(dimensions=dimensions, solvesPerProcess=8)
            elapsed = 95 if updates >= 199 else 100
            row['medianNs']['fwp-ad-identical'] = elapsed
            for label in ('fwp-ad', 'fwp-ad-history'):
                row['medianNs'][label] = elapsed
                old = row['fwpProfiles'][label + '-reference']['managed']
                old.update(requests=requests * 8 + 100, requestedBytes=requested_bytes * 8 + 1000)
                row['fwpProfiles'][label]['managed'] = dict(old, requests=100, requestedBytes=1000)
                row['binaries'][label]['instructionBytes'] += 10000
            self.assertEqual(DESCENT.paired_budget_failures({'case': row}, 'owned-numeric'), [])
            for label in ('fwp-ad', 'fwp-ad-history'):
                for metric in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'):
                    changed = copy.deepcopy(row)
                    changed['fwpProfiles'][label]['managed'][metric] += 1
                    failures = DESCENT.paired_budget_failures({'case': changed}, 'owned-numeric')
                    self.assertIn(metric, [failure['metric'] for failure in failures])
                for metric, value in (('finalBytes', 1), ('peakBytes', 999999)):
                    changed = copy.deepcopy(row)
                    changed['fwpProfiles'][label]['rawDerivativeStorage'][metric] = value
                    self.assertIn('rawDerivativeStorage', [failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'owned-numeric')])
                changed = copy.deepcopy(row)
                changed['medianNs'][label] = 96 if updates >= 199 else 103
                if label == 'fwp-ad':
                    changed['medianNs']['fwp-ad-identical'] = changed['medianNs'][label]
                self.assertEqual([failure['metric'] for failure in
                    DESCENT.paired_budget_failures({'case': changed}, 'owned-numeric')], ['candidate/reference time'])
                changed = copy.deepcopy(row)
                changed['cCompilerStackUsage'][label + '.su']['entries'][0]['bytes'] = 193
                self.assertEqual([failure['metric'] for failure in
                    DESCENT.paired_budget_failures({'case': changed}, 'owned-numeric')], ['largest static stack frame'])
            changed = copy.deepcopy(row)
            changed['medianNs']['fwp-ad-identical'] = elapsed * 1.03
            self.assertEqual([failure['metric'] for failure in
                DESCENT.paired_budget_failures({'case': changed}, 'owned-numeric')], ['identical median variation'])

    def test_packed_inputs_require_count_reductions_speed_and_unchanged_raw_storage(self):
        for dimensions in (3, 33, 129):
            for updates in (0, 1, 199, 1999):
                row = self.recording_case(updates)
                row.update(dimensions=dimensions, solvesPerProcess=8)
                inputs = dimensions * updates * 8
                elapsed = 95 if updates >= 199 else 100
                row['medianNs']['fwp-ad-identical'] = elapsed
                for label in ('fwp-ad', 'fwp-ad-history'):
                    row['medianNs'][label] = elapsed
                    old = row['fwpProfiles'][label + '-reference']['managed']
                    old.update(requests=2 * inputs + 100, requestedBytes=40 * inputs + 1000)
                    row['fwpProfiles'][label]['managed'] = dict(old, requests=100, requestedBytes=1000)
                    # Text size is reported, with no invented acceptance limit.
                    row['binaries'][label]['instructionBytes'] += 10000
                self.assertEqual(DESCENT.paired_budget_failures({'case': row}, 'packed-input'), [])
                for label in ('fwp-ad', 'fwp-ad-history'):
                    for metric in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'):
                        changed = copy.deepcopy(row)
                        changed['fwpProfiles'][label]['managed'][metric] += 1
                        failures = DESCENT.paired_budget_failures({'case': changed}, 'packed-input')
                        self.assertIn(metric, [failure['metric'] for failure in failures])
                    changed = copy.deepcopy(row)
                    changed['fwpProfiles'][label]['rawDerivativeStorage']['finalBytes'] = 1
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'packed-input')], ['rawDerivativeStorage'])
                    changed = copy.deepcopy(row)
                    changed['medianNs'][label] = 96 if updates >= 199 else 103
                    if label == 'fwp-ad':
                        changed['medianNs']['fwp-ad-identical'] = changed['medianNs'][label]
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'packed-input')], ['candidate/reference time'])
                    changed = copy.deepcopy(row)
                    changed['cCompilerStackUsage'][label + '.su']['entries'][0]['bytes'] = 193
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'packed-input')], ['largest static stack frame'])
                changed = copy.deepcopy(row)
                changed['medianNs']['fwp-ad-identical'] = elapsed * 1.03
                self.assertEqual([failure['metric'] for failure in
                    DESCENT.paired_budget_failures({'case': changed}, 'packed-input')], ['identical median variation'])

    def test_matched_optional_fields_keep_all_regression_and_cleanup_limits(self):
        for updates in (0, 1, 199, 1999):
            row = self.recording_case(updates)
            for label in ('fwp-ad', 'fwp-ad-history'):
                row['medianNs'][label] = row['medianNs'][label + '-reference'] = 100
                row['fwpProfiles'][label]['managed'] = dict(row['fwpProfiles'][label + '-reference']['managed'])
            row['medianNs']['fwp-ad-identical'] = 100
            # No 5% speedup or code-size goal belongs to this one-wrapper change.
            row['binaries']['fwp-ad-history']['instructionBytes'] += 4096
            self.assertEqual(DESCENT.paired_budget_failures({'case': row}, 'matched-option'), [])
            for label in ('fwp-ad', 'fwp-ad-history'):
                for metric in ('requests', 'requestedBytes', 'retains', 'finalChargedBytes'):
                    changed = copy.deepcopy(row)
                    changed['fwpProfiles'][label]['managed'][metric] += 1
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'matched-option')], [metric])
                changed = copy.deepcopy(row)
                changed['medianNs'][label] = 103
                if label == 'fwp-ad':
                    changed['medianNs']['fwp-ad-identical'] = 103
                self.assertEqual([failure['metric'] for failure in
                    DESCENT.paired_budget_failures({'case': changed}, 'matched-option')], ['candidate/reference time'])
                changed = copy.deepcopy(row)
                changed['fwpProfiles'][label]['rawDerivativeStorage']['finalBytes'] = 1
                self.assertEqual([failure['metric'] for failure in
                    DESCENT.paired_budget_failures({'case': changed}, 'matched-option')], ['final raw bytes'])
                changed = copy.deepcopy(row)
                reference_frame = max(entry['bytes'] for entry in changed['cCompilerStackUsage'][label + '-reference.su']['entries'])
                changed['cCompilerStackUsage'][label + '.su']['entries'][0]['bytes'] = reference_frame + 129
                self.assertEqual([failure['metric'] for failure in
                    DESCENT.paired_budget_failures({'case': changed}, 'matched-option')], ['largest static stack frame'])
            changed = copy.deepcopy(row)
            changed['medianNs']['fwp-ad-identical'] = 103
            self.assertEqual([failure['metric'] for failure in
                DESCENT.paired_budget_failures({'case': changed}, 'matched-option')], ['identical median variation'])

    def test_final_iteration_keeps_distinct_current_and_history_limits(self):
        for dimensions in (3, 33, 129):
            for updates in (0, 1, 199, 1999):
                row = self.recording_case(updates)
                row.update(dimensions=dimensions, solvesPerProcess=8)
                row['medianNs']['fwp-ad'] = row['medianNs']['fwp-ad-identical'] = 100
                row['medianNs']['fwp-ad-history'] = 95 if updates >= 199 else 100
                for label in ('fwp-ad', 'fwp-ad-history'):
                    old = row['fwpProfiles'][label + '-reference']['managed']
                    old.update(requests=10000, requestedBytes=100000, retains=10000, peakChargedBytes=1000)
                    row['fwpProfiles'][label]['managed'] = dict(old)
                    row['binaries'][label]['instructionBytes'] += 4096
                large = (dimensions, updates) == (129, 199)
                row['fwpProfiles']['fwp-ad-history']['managed']['peakChargedBytes'] = 200 if large else 800
                # Different reported raw peaks are allowed; both must clean up.
                row['fwpProfiles']['fwp-ad-history']['rawDerivativeStorage']['peakBytes'] = 128
                self.assertEqual(DESCENT.paired_budget_failures({'case': row}, 'final-iteration'), [])
                for metric in ('requests', 'requestedBytes', 'retains'):
                    changed = copy.deepcopy(row)
                    changed['fwpProfiles']['fwp-ad']['managed'][metric] += 1
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'final-iteration')], [metric])
                for metric, mutate in (
                    ('candidate/reference time', lambda item: item['medianNs'].update({'fwp-ad': 103, 'fwp-ad-identical': 103})),
                    ('candidate/reference time', lambda item: item['medianNs'].update({'fwp-ad-history': 96 if updates >= 199 else 103})),
                    ('identical median variation', lambda item: item['medianNs'].update({'fwp-ad-identical': 103})),
                    ('finalChargedBytes', lambda item: item['fwpProfiles']['fwp-ad-history']['managed'].update(finalChargedBytes=1)),
                    ('final raw bytes', lambda item: item['fwpProfiles']['fwp-ad']['rawDerivativeStorage'].update(finalBytes=1)),
                    ('largest static stack frame', lambda item: item['cCompilerStackUsage']['fwp-ad-history.su']['entries'][0].update(bytes=193)),
                ):
                    changed = copy.deepcopy(row)
                    mutate(changed)
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'final-iteration')], [metric])
                if large:
                    changed = copy.deepcopy(row)
                    changed['fwpProfiles']['fwp-ad-history']['managed']['peakChargedBytes'] = 201
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'final-iteration')], ['peakChargedBytes'])

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

    def test_callback_owner_limits_require_combined_savings_and_original_timing(self):
        for updates in (0, 1, 199):
            row = self.recording_case(updates)
            row['medianNs']['fwp-ad-identical'] = 95 if updates >= 199 else 100
            for label in ('fwp-ad', 'fwp-ad-history'):
                row['medianNs'][label] = 95 if updates >= 199 else 100
                candidate = row['fwpProfiles'][label]['managed']
                reference = row['fwpProfiles'][label + '-reference']['managed']
                reference.update(retains=10000, requests=10000, requestedBytes=400000)
                candidate.update(reference, retains=10000 - 6 * updates)
            self.assertEqual(DESCENT.paired_budget_failures({'case': row}, 'callback-owners'), [])
            changed = copy.deepcopy(row)
            changed['fwpProfiles']['fwp-ad']['managed']['retains'] += 1
            self.assertIn('retains', [failure['metric'] for failure in
                DESCENT.paired_budget_failures({'case': changed}, 'callback-owners')])
            changed = copy.deepcopy(row)
            changed['medianNs']['fwp-ad-history'] = 96 if updates >= 199 else 103
            self.assertEqual([failure['metric'] for failure in
                DESCENT.paired_budget_failures({'case': changed}, 'callback-owners')], ['candidate/reference time'])

    def test_scalar_map_zip_requires_exact_counts_and_preserves_timing_limits(self):
        for dimensions in (3, 33, 129):
            for updates in (0, 1, 199, 1999):
                row = self.recording_case(updates)
                row.update(dimensions=dimensions, solvesPerProcess=8)
                row['medianNs']['fwp-ad-identical'] = 95 if updates >= 199 else 100
                for label in ('fwp-ad', 'fwp-ad-history'):
                    row['medianNs'][label] = 95 if updates >= 199 else 100
                    reference = row['fwpProfiles'][label + '-reference']['managed']
                    candidate = row['fwpProfiles'][label]['managed']
                    reference.update(requests=10000000, requestedBytes=400000000, retains=10000000)
                    candidate.update(reference)
                    candidate['requests'] -= (dimensions + 1) * updates * 8
                    candidate['requestedBytes'] -= (32 * dimensions + 8) * updates * 8
                    row['binaries'][label]['instructionBytes'] += 4096
                self.assertEqual(DESCENT.paired_budget_failures({'case': row}, 'scalar-map-zip'), [])
                for metric in ('requests', 'requestedBytes', 'retains'):
                    for delta in (-1, 1):
                        changed = copy.deepcopy(row)
                        changed['fwpProfiles']['fwp-ad']['managed'][metric] += delta
                        self.assertIn(metric, [failure['metric'] for failure in
                            DESCENT.paired_budget_failures({'case': changed}, 'scalar-map-zip')])
                for metric, mutate in (
                    ('candidate/reference time', lambda item: item['medianNs'].update(
                        {'fwp-ad-history': 96 if updates >= 199 else 103})),
                    ('identical median variation', lambda item: item['medianNs'].update(
                        {'fwp-ad-identical': item['medianNs']['fwp-ad'] * 1.03})),
                    ('largest static stack frame', lambda item: item['cCompilerStackUsage'][
                        'fwp-ad.su']['entries'][0].update(bytes=193)),
                ):
                    changed = copy.deepcopy(row)
                    mutate(changed)
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'scalar-map-zip')], [metric])

    def test_range_zip_requires_exact_counts_and_preserves_timing_limits(self):
        for dimensions in (3, 33, 129):
            for updates in (0, 1, 199, 1999):
                row = self.recording_case(updates)
                row.update(dimensions=dimensions, solvesPerProcess=8)
                row['medianNs']['fwp-ad-identical'] = 95 if updates >= 199 else 100
                for label in ('fwp-ad', 'fwp-ad-history'):
                    row['medianNs'][label] = 95 if updates >= 199 else 100
                    reference = row['fwpProfiles'][label + '-reference']['managed']
                    candidate = row['fwpProfiles'][label]['managed']
                    reference.update(requests=10000000, requestedBytes=400000000, retains=10000000)
                    candidate.update(reference)
                    candidate['requests'] -= (dimensions + 1) * updates * 8
                    candidate['requestedBytes'] -= (32 * dimensions + 8) * updates * 8
                    row['binaries'][label]['instructionBytes'] += 4096
                self.assertEqual(DESCENT.paired_budget_failures({'case': row}, 'range-zip'), [])
                for metric in ('requests', 'requestedBytes', 'retains'):
                    for delta in (-1, 1):
                        changed = copy.deepcopy(row)
                        changed['fwpProfiles']['fwp-ad']['managed'][metric] += delta
                        self.assertIn(metric, [failure['metric'] for failure in
                            DESCENT.paired_budget_failures({'case': changed}, 'range-zip')])
                for metric, mutate in (
                    ('candidate/reference time', lambda item: item['medianNs'].update(
                        {'fwp-ad-history': 96 if updates >= 199 else 103})),
                    ('identical median variation', lambda item: item['medianNs'].update(
                        {'fwp-ad-identical': item['medianNs']['fwp-ad'] * 1.03})),
                    ('largest static stack frame', lambda item: item['cCompilerStackUsage'][
                        'fwp-ad.su']['entries'][0].update(bytes=193)),
                ):
                    changed = copy.deepcopy(row)
                    mutate(changed)
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'range-zip')], [metric])

    def test_identity_maps_require_one_removed_array_per_update_and_keep_limits(self):
        for dimensions in (3, 33, 129):
            for updates in (0, 1, 199, 1999):
                row = self.recording_case(updates)
                row.update(dimensions=dimensions, solvesPerProcess=8)
                row['medianNs']['fwp-ad-identical'] = 95 if updates >= 199 else 100
                for label in ('fwp-ad', 'fwp-ad-history'):
                    row['medianNs'][label] = 95 if updates >= 199 else 100
                    reference = row['fwpProfiles'][label + '-reference']['managed']
                    reference.update(requests=1000000, requestedBytes=100000000)
                    current = row['fwpProfiles'][label]['managed'] = dict(reference)
                    current['requests'] -= updates * 8
                    current['requestedBytes'] -= (8 * dimensions + 8) * updates * 8
                    row['binaries'][label]['instructionBytes'] += 4096
                self.assertEqual(DESCENT.paired_budget_failures({'case': row}, 'scalar-array-identity'), [])
                for metric in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'):
                    changed = copy.deepcopy(row)
                    changed['fwpProfiles']['fwp-ad']['managed'][metric] += 1
                    self.assertIn(metric, [failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'scalar-array-identity')])
                for metric, mutate in (
                    ('candidate/reference time', lambda item: item['medianNs'].update(
                        {'fwp-ad-history': 96 if updates >= 199 else 103})),
                    ('identical median variation', lambda item: item['medianNs'].update(
                        {'fwp-ad-identical': item['medianNs']['fwp-ad'] * 1.03})),
                    ('largest static stack frame', lambda item: item['cCompilerStackUsage']['fwp-ad.su']['entries'][0].update(bytes=193)),
                    ('rawDerivativeStorage', lambda item: item['fwpProfiles']['fwp-ad'].update(rawDerivativeStorage={'changed': 1})),
                ):
                    changed = copy.deepcopy(row)
                    mutate(changed)
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'scalar-array-identity')], [metric])

    def test_direct_array_map_calls_require_no_memory_growth_and_keep_speed_limits(self):
        for dimensions in (3, 33, 129):
            for updates in (0, 1, 199, 1999):
                row = self.recording_case(updates)
                row.update(dimensions=dimensions, solvesPerProcess=8)
                row['medianNs']['fwp-ad-identical'] = 95 if updates >= 199 else 100
                for label in ('fwp-ad', 'fwp-ad-history'):
                    row['medianNs'][label] = 95 if updates >= 199 else 100
                    reference = row['fwpProfiles'][label + '-reference']['managed']
                    row['fwpProfiles'][label]['managed'] = dict(reference)
                    row['binaries'][label]['instructionBytes'] += 4096
                self.assertEqual(DESCENT.paired_budget_failures({'case': row}, 'scalar-array-map'), [])
                for metric in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'):
                    changed = copy.deepcopy(row)
                    changed['fwpProfiles']['fwp-ad']['managed'][metric] += 1
                    self.assertIn(metric, [failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'scalar-array-map')])
                for metric, mutate in (
                    ('candidate/reference time', lambda item: item['medianNs'].update(
                        {'fwp-ad-history': 96 if updates >= 199 else 103})),
                    ('identical median variation', lambda item: item['medianNs'].update(
                        {'fwp-ad-identical': item['medianNs']['fwp-ad'] * 1.03})),
                    ('largest static stack frame', lambda item: item['cCompilerStackUsage'][
                        'fwp-ad.su']['entries'][0].update(bytes=193)),
                ):
                    changed = copy.deepcopy(row)
                    mutate(changed)
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'scalar-array-map')], [metric])

    def test_gradient_arrays_require_net_savings_and_preserve_timing_limits(self):
        for dimensions in (3, 33, 129):
            for updates in (0, 1, 199, 1999):
                row = self.recording_case(updates)
                row.update(dimensions=dimensions, solvesPerProcess=8)
                row['medianNs']['fwp-ad-identical'] = 95 if updates >= 199 else 100
                for label in ('fwp-ad', 'fwp-ad-history'):
                    row['medianNs'][label] = 95 if updates >= 199 else 100
                    reference = row['fwpProfiles'][label + '-reference']['managed']
                    candidate = row['fwpProfiles'][label]['managed']
                    reference.update(requests=10000000, requestedBytes=400000000, retains=10000000)
                    candidate.update(reference)
                    candidate['requests'] -= (dimensions - 1) * updates * 8
                    candidate['requestedBytes'] -= (16 * dimensions - 8) * updates * 8
                    row['binaries'][label]['instructionBytes'] += 4096
                self.assertEqual(DESCENT.paired_budget_failures({'case': row}, 'gradient-array'), [])
                for metric in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'):
                    for delta in (1,):
                        changed = copy.deepcopy(row)
                        changed['fwpProfiles']['fwp-ad']['managed'][metric] += delta
                        self.assertIn(metric, [failure['metric'] for failure in
                            DESCENT.paired_budget_failures({'case': changed}, 'gradient-array')])
                for metric, mutate in (
                    ('candidate/reference time', lambda item: item['medianNs'].update(
                        {'fwp-ad-history': 96 if updates >= 199 else 103})),
                    ('identical median variation', lambda item: item['medianNs'].update(
                        {'fwp-ad-identical': item['medianNs']['fwp-ad'] * 1.03})),
                    ('largest static stack frame', lambda item: item['cCompilerStackUsage'][
                        'fwp-ad.su']['entries'][0].update(bytes=193)),
                ):
                    changed = copy.deepcopy(row)
                    mutate(changed)
                    self.assertEqual([failure['metric'] for failure in
                        DESCENT.paired_budget_failures({'case': changed}, 'gradient-array')], [metric])

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

    def test_packed_records_keep_frozen_timing_and_storage_limits(self):
        rows = {str(updates): self.recording_case(updates) for updates in [0, 1, 199, 1999]}
        for row in rows.values():
            updates = row['updates']
            row['medianNs']['fwp-ad-identical'] = 100 if updates < 199 else 95
            for label in ['fwp-ad', 'fwp-ad-history']:
                row['medianNs'][label] = 100 if updates < 199 else 95
                old = row['fwpProfiles'][label + '-reference']['managed']
                current = row['fwpProfiles'][label]['managed']
                old.update(requests=100000, requestedBytes=4000000, retains=100000)
                current.update(requests=100000-3*updates, requestedBytes=4000000-56*updates,
                               retains=100000)
                # Code size is reported; this protocol freezes no text-size cap.
                row['binaries'][label]['instructionBytes'] += 4096
        self.assertEqual(DESCENT.paired_budget_failures(rows, 'packed-records'), [])
        for name, limit in [('0', 102), ('1', 102), ('199', 95), ('1999', 95)]:
            changed = copy.deepcopy(rows)
            changed[name]['medianNs']['fwp-ad-history'] = limit + 0.01
            self.assertEqual([f['metric'] for f in DESCENT.paired_budget_failures(
                changed, 'packed-records')], ['candidate/reference time'])
        for name in rows:
            for field in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'):
                changed = copy.deepcopy(rows)
                changed[name]['fwpProfiles']['fwp-ad']['managed'][field] += 1
                self.assertTrue(DESCENT.paired_budget_failures(changed, 'packed-records'))
        for field in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes'):
            changed = copy.deepcopy(rows)
            changed['0']['fwpProfiles']['fwp-ad']['managed'][field] -= 1
            self.assertEqual([f['metric'] for f in DESCENT.paired_budget_failures(
                changed, 'packed-records')], ['zero-update counts'])
        changed = copy.deepcopy(rows)
        changed['1']['medianNs']['fwp-ad-identical'] = 97
        self.assertEqual([f['metric'] for f in DESCENT.paired_budget_failures(
            changed, 'packed-records')], ['identical median variation'])
        changed = copy.deepcopy(rows)
        changed['1']['cCompilerStackUsage']['fwp-ad.su']['entries'][0]['bytes'] += 129
        self.assertEqual([f['metric'] for f in DESCENT.paired_budget_failures(
            changed, 'packed-records')], ['largest static stack frame'])
        for field, value in [('rawDerivativeStorage', {'finalBytes': 1}), ('expandedRawSha256', 'changed')]:
            changed = copy.deepcopy(rows)
            changed['1']['fwpProfiles']['fwp-ad'][field] = value
            self.assertEqual([f['metric'] for f in DESCENT.paired_budget_failures(
                changed, 'packed-records')], [field])

    def test_record_fold_limits_separate_short_and_long_solve_timing(self):
        rows = {str(updates): self.recording_case(updates) for updates in [0, 1, 199, 1999]}
        for row in rows.values():
            updates = row['updates']
            row['medianNs']['fwp-ad-identical'] = 100 if updates < 199 else 95
            for label in ['fwp-ad', 'fwp-ad-history']:
                row['medianNs'][label] = 100 if updates < 199 else 95
                old = row['fwpProfiles'][label + '-reference']['managed']
                current = row['fwpProfiles'][label]['managed']
                old.update(requests=100000, requestedBytes=4000000, retains=100000)
                current.update(requests=100000-updates, requestedBytes=4000000-24*updates,
                               retains=100000-2*updates)
        self.assertEqual(DESCENT.paired_budget_failures(rows, 'record-fold'), [])
        for name, limit in [('0', 102), ('1', 102), ('199', 95), ('1999', 95)]:
            changed = copy.deepcopy(rows)
            changed[name]['medianNs']['fwp-ad-history'] = limit + 0.01
            failures = DESCENT.paired_budget_failures(changed, 'record-fold')
            self.assertEqual([f['metric'] for f in failures], ['candidate/reference time'])
        for name in rows:
            for field in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'):
                changed = copy.deepcopy(rows)
                changed[name]['fwpProfiles']['fwp-ad']['managed'][field] += 1
                self.assertTrue(DESCENT.paired_budget_failures(changed, 'record-fold'))
        # Keeping the new short-case rule must not rewrite the previous protocol.
        self.assertTrue(any(f['metric'] == 'candidate/reference time'
                            for f in DESCENT.paired_budget_failures(rows, 'record-zip')))

    def test_record_zip_limits_cover_savings_noise_storage_and_layout(self):
        rows = {str(updates): self.recording_case(updates) for updates in [0, 1]}
        for row in rows.values():
            pairs = (row['dimensions'] - 1) * row['updates'] * row['solvesPerProcess']
            for label in ['fwp-ad', 'fwp-ad-history']:
                current = row['fwpProfiles'][label]['managed']
                old = row['fwpProfiles'][label + '-reference']['managed']
                for field, factor in [('requests', 2), ('requestedBytes', 48), ('retains', 3)]:
                    current[field] = old[field] - factor * pairs
        self.assertEqual(DESCENT.paired_budget_failures(rows, 'record-zip'), [])
        for field in ['requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes']:
            changed = copy.deepcopy(rows)
            changed['1']['fwpProfiles']['fwp-ad']['managed'][field] += 1
            failures = DESCENT.paired_budget_failures(changed, 'record-zip')
            self.assertEqual([failure['metric'] for failure in failures], [field])
        for field in ['requests', 'requestedBytes', 'retains', 'peakChargedBytes']:
            changed = copy.deepcopy(rows)
            changed['0']['fwpProfiles']['fwp-ad']['managed'][field] -= 1
            failures = DESCENT.paired_budget_failures(changed, 'record-zip')
            self.assertEqual([failure['metric'] for failure in failures], ['zero-update counts'])
        changed = copy.deepcopy(rows)
        changed['1']['medianNs']['fwp-ad'] = 103
        changed['1']['fwpProfiles']['fwp-ad']['rawDerivativeStorage']['finalBytes'] = 1
        changed['1']['fwpProfiles']['fwp-ad']['expandedRawSha256'] = 'changed'
        changed['1']['binaries']['fwp-ad']['instructionBytes'] += 1025
        changed['1']['cCompilerStackUsage']['fwp-ad.su']['entries'][0]['bytes'] += 129
        failures = DESCENT.paired_budget_failures(changed, 'record-zip')
        self.assertEqual({failure['metric'] for failure in failures}, {
            'identical median variation', 'candidate/reference time', 'rawDerivativeStorage',
            'expandedRawSha256', 'instruction bytes', 'largest static stack frame'})

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
