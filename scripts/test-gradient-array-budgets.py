#!/usr/bin/env python3
"""Reject missing gradient savings, changed work and incorrect attribution."""
import copy
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('costs', Path(__file__).with_name('measure-derivative-forward-costs.py'))
COSTS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COSTS)


class GradientArrayBudgets(unittest.TestCase):
    def example(self, updates):
        name = f'3-{updates}-current-O1'
        observation = dict(totals={'managed': dict(requests=100, requestedBytes=1000,
            retains=10, peakChargedBytes=80, finalChargedBytes=0)},
            phases={'outside': 1}, visits={'nodes': 8}, raw={'finalBytes': 0})
        constructor = dict(phase='outside', site=1, tag=1, fields=2,
                           requests=3 + 3 * updates, requestedBytes=72 + 72 * updates)
        previous = dict(observations={mode: copy.deepcopy(observation) for mode in ('0', '1')},
                        constructors={'counts': {mode: [copy.deepcopy(constructor)] for mode in ('0', '1')}})
        report = dict(machine='aarch64', cases={name: copy.deepcopy(previous['observations'])},
                      constructors={'cases': {name: copy.deepcopy(previous['constructors']['counts'])}})
        for mode in ('0', '1'):
            managed = report['cases'][name][mode]['totals']['managed']
            managed['requests'] -= 2 * updates
            managed['requestedBytes'] -= 40 * updates
            report['constructors']['cases'][name][mode][0].update(requests=3, requestedBytes=72)
        baseline = {'hosts': {'aarch64': {'cases': {name: previous}}}}
        return report, baseline, name

    def test_exact_constructor_removal_and_net_array_cost_pass(self):
        for updates in (0, 2):
            report, baseline, _ = self.example(updates)
            snapshot = copy.deepcopy(report)
            self.assertEqual(COSTS.comparison_failures(report, baseline, 'gradient-array'), [])
            self.assertEqual(report, snapshot)

    def test_every_count_and_work_limit_is_enforced(self):
        for updates in (0, 2):
            report, baseline, name = self.example(updates)
            for field in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'):
                for mode in ('0', '1'):
                    changed = copy.deepcopy(report)
                    changed['cases'][name][mode]['totals']['managed'][field] += 1
                    self.assertTrue(COSTS.comparison_failures(changed, baseline, 'gradient-array'), field)
            for field in ('visits', 'raw'):
                changed = copy.deepcopy(report)
                changed['cases'][name]['0'][field] = {'changed': 1}
                self.assertTrue(COSTS.comparison_failures(changed, baseline, 'gradient-array'), field)

    def test_total_savings_cannot_hide_wrong_constructor_counts_or_phase(self):
        report, baseline, name = self.example(2)
        for field, values in [('requests', (2, 4)), ('requestedBytes', (71, 73)), ('phase', ('backward',))]:
            for value in values:
                changed = copy.deepcopy(report)
                changed['constructors']['cases'][name]['0'][0][field] = value
                failures = COSTS.comparison_failures(changed, baseline, 'gradient-array')
                self.assertEqual(failures, [name + '/workspace0: constructor groups differ from exact gradient-list removal'])


class GradientCallBudgets(unittest.TestCase):
    def example(self, dimensions, updates, savings, phase_bytes):
        row = dict(requests=100, requestedBytes=1000,
                   operations={'dup': {'effective': 10}})
        observation = dict(totals={'managed': dict(requests=700, requestedBytes=7000,
            retains=70, peakChargedBytes=80, finalChargedBytes=0)},
            phases={phase: copy.deepcopy(row) for phase in COSTS.PROFILE.PHASES},
            visits={'nodes': 8}, raw={'finalBytes': 0})
        name = f'{dimensions}-{updates}-current-O2'
        previous = copy.deepcopy(observation)
        for key, saving in zip(('requests', 'requestedBytes', 'retains'), savings):
            previous['totals']['managed'][key] += saving
        outside = previous['phases']['outside']
        outside['requests'] += updates
        outside['requestedBytes'] += phase_bytes[0]
        outside['operations']['dup']['effective'] += updates
        forward = previous['phases']['forwardWithRecording']
        forward['requests'] += savings[0] - updates
        forward['requestedBytes'] += phase_bytes[1]
        forward['operations']['dup']['effective'] += updates
        report = dict(machine='aarch64', cases={name: {mode: copy.deepcopy(observation) for mode in ('0', '1')}})
        baseline = {'hosts': {'aarch64': {'cases': {name: {'observations':
            {mode: copy.deepcopy(previous) for mode in ('0', '1')}}}}}}
        return report, baseline, name

    def test_all_six_fresh_solve_predictions(self):
        # Literal whole-program and phase predictions do not repeat the checker formula.
        for dimensions, updates, savings, phase_bytes in (
            (3, 0, (0, 0, 0), (0, 0)), (3, 1, (8, 176, 2), (32, 144)),
            (3, 199, (1394, 30272, 398), (6368, 23904)),
            (3, 1999, (13994, 303872, 3998), (63968, 239904)),
            (33, 199, (1394, 78032, 398), (54128, 23904)),
            (129, 199, (1394, 230864, 398), (206960, 23904)),
        ):
            report, baseline, _ = self.example(dimensions, updates, savings, phase_bytes)
            self.assertEqual(COSTS.comparison_failures(report, baseline, 'gradient-call'), [])

    def test_extra_or_missing_savings_and_changed_memory_are_rejected(self):
        report, baseline, name = self.example(129, 199, (1394, 230864, 398), (206960, 23904))
        for key in ('requests', 'requestedBytes', 'retains'):
            for delta in (-1, 1):
                changed = copy.deepcopy(report)
                changed['cases'][name]['0']['totals']['managed'][key] += delta
                self.assertTrue(COSTS.comparison_failures(changed, baseline, 'gradient-call'))
        for key in ('peakChargedBytes', 'finalChargedBytes'):
            changed = copy.deepcopy(report)
            changed['cases'][name]['1']['totals']['managed'][key] += 1
            self.assertTrue(COSTS.comparison_failures(changed, baseline, 'gradient-call'))
        for key in ('raw', 'visits'):
            changed = copy.deepcopy(report)
            changed['cases'][name]['0'][key] = {'changed': 1}
            self.assertTrue(COSTS.comparison_failures(changed, baseline, 'gradient-call'))

    def test_correct_totals_cannot_hide_wrong_phase_attribution(self):
        report, baseline, name = self.example(129, 199, (1394, 230864, 398), (206960, 23904))
        for mode in ('0', '1'):
            changed = copy.deepcopy(report)
            phases = changed['cases'][name][mode]['phases']
            phases['outside']['requests'] += 1
            phases['forwardWithRecording']['requests'] -= 1
            failures = COSTS.comparison_failures(changed, baseline, 'gradient-call')
            self.assertEqual(len(failures), 2)
            self.assertTrue(all('expected' in failure for failure in failures))
        # Moving the reserved scratch word to the forward phase preserves totals
        # but must fail both phase checks (the original checker defect).
        changed = copy.deepcopy(report)
        phases = changed['cases'][name]['0']['phases']
        phases['outside']['requestedBytes'] += 8 * 199
        phases['forwardWithRecording']['requestedBytes'] -= 8 * 199
        failures = COSTS.comparison_failures(changed, baseline, 'gradient-call')
        self.assertEqual(len(failures), 2)
        changed = copy.deepcopy(report)
        del changed['cases'][name]['0']['phases']['outside']
        with self.assertRaises(AssertionError):
            COSTS.comparison_failures(changed, baseline, 'gradient-call')


class PackedPairBudgets(unittest.TestCase):
    def example(self, dimensions, updates, byte_saving):
        report, baseline, name = GradientCallBudgets().example(
            dimensions, 0, (0, 0, 0), (0, 0))
        old_name = name
        name = f'{dimensions}-{updates}-current-O2'
        report['cases'][name] = report['cases'].pop(old_name)
        cases = baseline['hosts']['aarch64']['cases']
        cases[name] = cases.pop(old_name)
        for mode in ('0', '1'):
            old = cases[name]['observations'][mode]
            for row in (old['totals']['managed'], old['phases']['forwardWithRecording']):
                row['requests'] += updates
                row['requestedBytes'] += byte_saving
        return report, baseline, name

    def test_six_literal_predictions(self):
        for dimensions, updates, byte_saving in (
            (3, 0, 0), (3, 1, 40), (3, 199, 7960), (3, 1999, 79960),
            (33, 199, 103480), (129, 199, 409144),
        ):
            report, baseline, _ = self.example(dimensions, updates, byte_saving)
            self.assertEqual(COSTS.comparison_failures(report, baseline, 'packed-pair'), [])

    def test_wrong_totals_phase_and_retains_reject(self):
        report, baseline, name = self.example(129, 199, 409144)
        for mode in ('0', '1'):
            for key in ('requests', 'requestedBytes', 'retains'):
                for delta in (-1, 1):
                    changed = copy.deepcopy(report)
                    changed['cases'][name][mode]['totals']['managed'][key] += delta
                    self.assertTrue(COSTS.comparison_failures(changed, baseline, 'packed-pair'))
            changed = copy.deepcopy(report)
            phases = changed['cases'][name][mode]['phases']
            phases['outside']['requests'] += 1
            phases['forwardWithRecording']['requests'] -= 1
            self.assertEqual(len(COSTS.comparison_failures(changed, baseline, 'packed-pair')), 2)
            changed = copy.deepcopy(report)
            changed['cases'][name][mode]['phases']['forwardWithRecording']['operations']['dup']['effective'] += 1
            self.assertTrue(COSTS.comparison_failures(changed, baseline, 'packed-pair'))


class ScalarConstantBudgets(unittest.TestCase):
    def test_fresh_work_and_every_phase_must_remain_unchanged(self):
        for protocol in ('scalar-constant', 'recording-lookup', 'recording-inline', 'recording-capacity', 'recording-context'):
            for dimensions, updates in ((3, 0), (3, 1), (3, 199), (3, 1999), (33, 199), (129, 199)):
                report, baseline, name = GradientCallBudgets().example(dimensions, updates, (0, 0, 0), (0, 0))
                baseline['hosts']['aarch64']['cases'][name]['observations'] = copy.deepcopy(report['cases'][name])
                self.assertEqual(COSTS.comparison_failures(report, baseline, protocol), [])
                for mode in ('0', '1'):
                    for field in ('requests', 'requestedBytes', 'retains'):
                        for delta in (-1, 1):
                            changed = copy.deepcopy(report)
                            changed['cases'][name][mode]['totals']['managed'][field] += delta
                            self.assertTrue(COSTS.comparison_failures(changed, baseline, protocol))
                    changed = copy.deepcopy(report)
                    changed['cases'][name][mode]['phases']['forwardWithRecording']['requests'] += 1
                    self.assertTrue(COSTS.comparison_failures(changed, baseline, protocol))
                    for field in ('visits', 'raw'):
                        changed = copy.deepcopy(report)
                        changed['cases'][name][mode][field] = {'changed': 1}
                        self.assertTrue(COSTS.comparison_failures(changed, baseline, protocol))


if __name__ == '__main__':
    unittest.main()
