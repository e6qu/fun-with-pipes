"""Retain failed decisions and reject damaged State-range measurements."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('state_range_evidence', Path(__file__).with_name('check-state-range-evidence.py'))
EVIDENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(EVIDENCE)
ROOT = Path(__file__).resolve().parent.parent
SOURCES = {'focused': 'ea0f300b2c553b519a1a9ae266b7b974c388bdd7',
           'rejected': 'f82016d9bc1a020a1714cc2876c9036ae3b718f3'}
RECORDS = {outcome: json.loads((ROOT / f'docs/measurements/state-range-{outcome}-2026-10-31.json').read_text())
           for outcome in SOURCES}


class StateRangeEvidenceTests(unittest.TestCase):
    def test_both_original_decisions_recompute(self):
        for outcome, record in RECORDS.items():
            with self.subTest(outcome=outcome):
                EVIDENCE.check(record, SOURCES[outcome], outcome)

    def test_failed_observations_cannot_be_relabelled_as_passing(self):
        changed = copy.deepcopy(RECORDS['rejected'])
        changed['native'][0]['report']['acceptance']['code'] = True
        with self.assertRaises(AssertionError):
            EVIDENCE.check(changed, SOURCES['rejected'], 'rejected')
        changed = copy.deepcopy(RECORDS['rejected'])
        changed['analysis'][1]['controls'][1]['identicalCopy'] = True
        with self.assertRaises(AssertionError):
            EVIDENCE.check(changed, SOURCES['rejected'], 'rejected')

    def test_missing_or_changed_observations_fail(self):
        for damage in ['source', 'host', 'commands', 'output', 'flags', 'symbols',
                       'code', 'frames', 'costs', 'allocation', 'samples', 'median', 'budget', 'startup', 'orders']:
            with self.subTest(damage=damage):
                changed = copy.deepcopy(RECORDS['focused'])
                native, analysis = changed['native'][0], changed['analysis'][0]
                program = native['report']['programs']['candidate']
                observation = analysis['observations'][0]
                if damage == 'source':
                    changed['source'] = '0' * 40
                elif damage == 'host':
                    changed['native'].pop()
                elif damage == 'commands':
                    native['commands'].pop()
                elif damage == 'output':
                    native['commands'][6]['stdout'] = 'MQo='
                elif damage == 'flags':
                    program['command'].remove('-fno-fast-math')
                elif damage == 'symbols':
                    program['symbols'].pop(program['entry'])
                elif damage == 'code':
                    program['workerBytes'] -= 1
                elif damage == 'frames':
                    program['largestFrameBytes'] -= 1
                elif damage == 'costs':
                    native['functionalCosts'].pop()
                elif damage == 'allocation':
                    selected, = [item for item in native['functionalCosts'][0]['rows']
                                 if item[:2] == ['each-count', 'known']]
                    selected[3] = '3'
                elif damage == 'samples':
                    observation['samplesNs'][0].pop()
                elif damage == 'median':
                    observation['fields']['median_batch_ns'] -= 1
                elif damage == 'budget':
                    observation['fields']['visits'] = 1000000
                elif damage == 'startup':
                    analysis['startupLog'] = analysis['startupLog'].replace('analysis_limit_seconds=10', 'analysis_limit_seconds=11')
                elif damage == 'orders':
                    analysis['orders'].reverse()
                with self.assertRaises(AssertionError):
                    EVIDENCE.check(changed, SOURCES['focused'], 'focused')


if __name__ == '__main__':
    unittest.main()
