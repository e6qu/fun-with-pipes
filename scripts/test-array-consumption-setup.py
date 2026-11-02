#!/usr/bin/env python3
"""Reject changed numerical code, invalid preparation and incomplete schedules."""
from collections import Counter
import copy
import json
from pathlib import Path
import unittest
from zipfile import ZipFile

import array_consumption_setup as SETUP

ROOT = Path(__file__).resolve().parent.parent


class PreparationControls(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with ZipFile(ROOT / 'docs/measurements/array-construction-2026-11-02/arm.zip') as archive:
            cls.generated = archive.read('array-construction/generated.c').decode()

    def test_runtime_and_timed_reduction_are_unchanged(self):
        for profile, verification in ((False, False), (True, False), (False, True)):
            original = SETUP.PHASES.native_source(self.generated, 'f1', 'f0',
                (65537, 65, 67, 63), 'fwp', profile, verification, False)
            actual = SETUP.source(original, 65537, 'f1')
            runtime = original.split('static uint64_t bench_clock(void){', 1)[0]
            self.assertTrue(actual.startswith('#include <sys/resource.h>\n' + runtime))
            consume = 'uint64_t before=bench_clock();V result=f1(input);bench_kernel_ns+=bench_clock()-before;'
            self.assertEqual(actual.count(consume), 1)
            self.assertEqual(actual.count('fwp_rc_free_arr(input); /* preparation-final-release control */'), 1)
            self.assertIn('fwp_rc_dup(input); /* caller retains its independent array owner */', actual)
            self.assertIn(SETUP.PHASES.DRIVER_CONSTRUCTION, actual)

    def test_missing_or_repeated_boundary_is_rejected(self):
        original = SETUP.PHASES.native_source(self.generated, 'f1', 'f0',
            (65537, 65, 67, 63), 'fwp', False, False, False)
        for changed in (original.replace('int main(void){', 'int changed(void){'),
                        original + '\nint main(void){'):
            with self.assertRaises(AssertionError):
                SETUP.source(changed, 65537, 'f1')

    def test_complete_preparation_and_sample_storage(self):
        for passes in (0, 1024):
            for profile in (False, True):
                values = [[SETUP.BASELINE.array_result(65537, r)] for r in range(8)]
                prep = dict(passes=passes, hash=SETUP.BASELINE.result_hash([[values[0][0]]] * passes),
                    wallNs=2, cpuNs=3, requests=int(profile and passes != 0),
                    requestedBytes=524304 if profile and passes else 0,
                    peakChargedBytes=524304 if profile and passes else 0,
                    liveChargedBytes=0, retains=passes if profile else 0,
                    nonlastReleases=passes if profile else 0,
                    releaseChecks=passes if profile else 0)
                sample = dict(hash=SETUP.BASELINE.result_hash(values), liveChargedBytes=0,
                    allocationNs=0, fillNs=0, constructionNs=8, kernelNs=4, kernelCpuNs=5,
                    allocationInclusiveNs=16, minorFaults=0, majorFaults=0,
                    voluntarySwitches=0, involuntarySwitches=0, requests=8 if profile else 0,
                    requestedBytes=8*524304 if profile else 0,
                    peakChargedBytes=524304 if profile else 0, releaseChecks=8 if profile else 0,
                    retains=0, nonlastReleases=0)
                output = dict(preparation=prep, samples=[dict(sample) for _ in range(5)])
                SETUP.check_output(json.dumps(output).encode(), 65537, passes, profile, False)
                for scope, key, value in [('preparation', 'liveChargedBytes', 524304),
                        ('preparation', 'hash', 'incorrect'), ('preparation', 'retains', -1),
                        ('preparation', 'releaseChecks', prep['releaseChecks'] + 1),
                        ('sample', 'liveChargedBytes', 1), ('sample', 'hash', 'incorrect'),
                        ('sample', 'kernelCpuNs', 0), ('sample', 'minorFaults', -1)]:
                    changed = copy.deepcopy(output)
                    target = changed['preparation'] if scope == 'preparation' else changed['samples'][0]
                    target[key] = value
                    with self.subTest(passes=passes, profile=profile, scope=scope, key=key), self.assertRaises(AssertionError):
                        SETUP.check_output(json.dumps(changed).encode(), 65537, passes, profile, False)
                if profile:
                    changed = copy.deepcopy(output)
                    changed['samples'][0]['requests'] = 9
                    with self.assertRaises(AssertionError):
                        SETUP.check_output(json.dumps(changed).encode(), 65537, passes, profile, False)

    def test_all_roles_are_balanced_at_each_process_position(self):
        positions = [Counter() for _ in range(32)]
        for round_index in range(16):
            order = SETUP.execution_order(round_index)
            self.assertEqual(Counter(order), Counter({role: 4 for role in SETUP.LABELS}))
            for index, role in enumerate(order):
                positions[index][role] += 1
        self.assertTrue(all(counts == Counter({role: 2 for role in SETUP.LABELS}) for counts in positions))
        for index in (-1, 16, True):
            with self.assertRaises(AssertionError):
                SETUP.execution_order(index)

    def test_summary_keeps_early_samples_and_rejects_incomplete_rounds(self):
        records = []
        metrics = ('constructionNs', 'kernelNs', 'kernelCpuNs', 'allocationInclusiveNs',
                   'minorFaults', 'majorFaults', 'voluntarySwitches', 'involuntarySwitches')
        for phase, count in (('warmup', 2), ('sample', 16)):
            for index in range(count):
                observations = []
                for program, passes in SETUP.execution_order(index):
                    scale = 2 if passes == 0 else 1
                    samples = [{key: scale * (10 - position) for key in metrics} for position in range(5)]
                    observations.append(dict(role=[program, passes], output=dict(samples=samples)))
                records.append(dict(phase=phase, round=index, complete=True, observations=observations))
        summary = SETUP.summarize(records)
        self.assertTrue(all(row['processes'] == 64 for row in summary['roles']))
        for row in summary['roles']:
            scale = 2 if row['preparationPasses'] == 0 else 1
            self.assertEqual(row['metrics']['kernelNs']['samplePositionMedians'],
                             [scale * value for value in (10, 9, 8, 7, 6)])
            self.assertEqual(row['metrics']['kernelNs']['firstMinusLastMedian'], scale * 4)
            self.assertEqual(row['metrics']['kernelNs']['roundTotals'], [scale * 160] * 16)
        self.assertTrue(all(set(row['ratios'].values()) == {1} for row in summary['identicalRatios']))
        self.assertTrue(all(set(row['preparedOverUnprepared'].values()) == {0.5}
                            for row in summary['preparationComparisons']))
        for kind in ('missing-round', 'unfinished', 'wrong-role', 'missing-process'):
            changed = copy.deepcopy(records)
            if kind == 'missing-round':
                changed.pop()
            elif kind == 'unfinished':
                changed[-1]['complete'] = False
            elif kind == 'wrong-role':
                changed[-1]['observations'][0]['role'] = ['invalid', 0]
            else:
                changed[-1]['observations'].pop()
            with self.subTest(kind=kind), self.assertRaises(AssertionError):
                SETUP.summarize(changed)


if __name__ == '__main__':
    unittest.main()
