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


if __name__ == '__main__':
    unittest.main()
