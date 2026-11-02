#!/usr/bin/env python3
"""Keep the observation-only driver free of preparation and reject missing data."""
from collections import Counter
import copy
import json
from pathlib import Path
import unittest
from zipfile import ZipFile

import array_observation_boundaries as BOUNDARIES

ROOT = Path(__file__).resolve().parent.parent


class ObservationControls(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with ZipFile(ROOT / 'docs/measurements/array-construction-2026-11-02/arm.zip') as archive:
            cls.generated = archive.read('array-construction/generated.c').decode()

    def test_only_observers_change_the_original_driver(self):
        for profile, verification in ((False, False), (True, False), (False, True)):
            original = BOUNDARIES.PREPARATION.PHASES.native_source(self.generated, 'f1', 'f0',
                (65537, 65, 67, 63), 'fwp', profile, verification, False)
            observed = BOUNDARIES.observed_source(original, 65537, 'f1')
            prefix = original.split('static uint64_t bench_clock(void){', 1)[0]
            self.assertTrue(observed.startswith('#include <sys/resource.h>\n' + prefix))
            main = observed.split('int main(void){', 1)[1]
            self.assertNotIn('prepare_', main)
            self.assertNotIn('argv', main)
            self.assertNotIn('V prepared=', main)
            self.assertIn('puts("{\\"samples\\":[");', main)
            self.assertEqual(main.count('V result=f1(input);'), 1)
            self.assertIn('bench_setup_cpu_clock()', main)
            self.assertIn('bench_setup_usage(&usage_before)', main)
            for source in (original, observed):
                broken = BOUNDARIES.missing_array_release(source)
                self.assertIn('deliberate missing array destruction', broken)
                broken_clock = BOUNDARIES.failed_clock(source, 'wall')
                self.assertNotEqual(source, broken_clock)
                self.assertEqual(source.split('static uint64_t bench_clock(void){', 1)[0],
                                 broken_clock.split('static uint64_t bench_clock(void){', 1)[0])
            with self.assertRaises(AssertionError):
                BOUNDARIES.failed_clock(original, 'cpu')
            self.assertNotEqual(observed, BOUNDARIES.failed_clock(observed, 'cpu'))

    def test_no_missing_observation_is_treated_as_zero(self):
        for version in ('original', 'observed'):
            for profile in (False, True):
                values = [[BOUNDARIES.BASELINE.array_result(65537, r)] for r in range(8)]
                sample = dict(hash=BOUNDARIES.BASELINE.result_hash(values), liveChargedBytes=0,
                    allocationNs=0, fillNs=0, constructionNs=8, kernelNs=4, allocationInclusiveNs=16,
                    requests=8 if profile else 0, requestedBytes=8*524304 if profile else 0,
                    peakChargedBytes=524304 if profile else 0, releaseChecks=8 if profile else 0,
                    retains=0, nonlastReleases=0)
                if version == 'observed':
                    sample.update(kernelCpuNs=5, minorFaults=0, majorFaults=0, voluntarySwitches=0, involuntarySwitches=0)
                output = dict(samples=[dict(sample) for _ in range(5)])
                BOUNDARIES.check_output(json.dumps(output).encode(), 65537, version, profile, False)
                changed = copy.deepcopy(output)
                if version == 'observed':
                    del changed['samples'][0]['kernelCpuNs']
                else:
                    changed['samples'][0]['kernelCpuNs'] = 0
                with self.assertRaises((AssertionError, KeyError)):
                    BOUNDARIES.check_output(json.dumps(changed).encode(), 65537, version, profile, False)
                for key, value in (('liveChargedBytes', 1), ('hash', 'incorrect'), ('retains', 1)):
                    changed = copy.deepcopy(output);changed['samples'][0][key] = value
                    with self.subTest(version=version, profile=profile, key=key), self.assertRaises(AssertionError):
                        BOUNDARIES.check_output(json.dumps(changed).encode(), 65537, version, profile, False)

    def test_schedule_and_summary_preserve_every_role_and_sample(self):
        positions = [Counter() for _ in range(48)]
        records = []
        for phase, count in (('warmup', 2), ('sample', 24)):
            for index in range(count):
                order = BOUNDARIES.execution_order(index)
                self.assertEqual(Counter(order), Counter({role: 4 for role in BOUNDARIES.LABELS}))
                observations = []
                for position, role in enumerate(order):
                    if phase == 'sample':
                        positions[position][role] += 1
                    metrics = BOUNDARIES.WALL_METRICS + (() if role[1] == 'original' else BOUNDARIES.OBSERVATIONS)
                    samples = [{key: 10 - i for key in metrics} for i in range(5)]
                    observations.append(dict(role=list(role), output=dict(samples=samples)))
                records.append(dict(phase=phase, round=index, complete=True, observations=observations))
        self.assertTrue(all(counts == Counter({role: 2 for role in BOUNDARIES.LABELS}) for counts in positions))
        summary = BOUNDARIES.summarize(records)
        self.assertFalse(summary['failedCopyLimits'])
        self.assertTrue(all(row['processes'] == 96 for row in summary['roles']))
        for row in summary['roles']:
            self.assertEqual(row['metrics']['kernelNs']['samplePositionMedians'], [10, 9, 8, 7, 6])
            self.assertEqual(row['metrics']['kernelNs']['roundTotals'], [160] * 24)
        self.assertTrue(all(set(row['ratios'].values()) == {1} for row in summary['versionComparisons']))
        broken = copy.deepcopy(records);broken[-1]['observations'].pop()
        with self.assertRaises(AssertionError):
            BOUNDARIES.summarize(broken)
        for index in (-1, 24, True):
            with self.assertRaises(AssertionError):
                BOUNDARIES.execution_order(index)


if __name__ == '__main__':
    unittest.main()
