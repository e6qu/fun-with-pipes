#!/usr/bin/env python3
"""Reject broken phase boundaries and misleading complete-process comparisons."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('cpu_phases', Path(__file__).with_name('cpu-phases.py'))
PHASES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PHASES)
TABLE = json.loads((PHASES.ROOT / 'docs/measurements/cpu-budgets-2026-10-28.json').read_text())


def fixture():
    row = dict(stdout=PHASES.EXPECTED['loop'], binaries={kind: dict(sha256='a' * 64, bytes=1024) for kind in PHASES.KINDS}, observations=[])
    for phase, count in [('warmup', 2), ('sample', 72)]:
        for index in range(count):
            for position in range(9):
                kind = PHASES.KINDS[(index + position) % 9]
                seconds = 0.01 if kind.startswith('c') else 0.02
                marks = list(range(10, 18)) if kind == 'fwp-phases' else [0, 6_000_000, 7_000_000]
                process = dict(status=0, seconds=seconds, stdout=row['stdout'], stderr=json.dumps(dict(marksNs=marks)) if kind.endswith('-phases') else '')
                row['observations'].append(dict(kind=kind, phase=phase, round=index, binarySha256='a' * 64, seconds=seconds, processes=[process]))
    return row


class ExecutionPhases(unittest.TestCase):
    def setUp(self):
        self.row = fixture()
        self.budget = next(r for r in TABLE['rows'] if r['program'] == 'loop' and r['architecture'] == 'aarch64')

    def check(self, row):
        return PHASES.check_case('loop', row, PHASES.SETTINGS, self.budget)

    def test_diagnostics_stay_separate_from_ordinary_timings(self):
        result = self.check(self.row)
        self.assertEqual(result['fwpControl'], 'stable')
        self.assertEqual(result['medianPhaseNs']['c'], dict(calculation=6_000_000, output=1_000_000))
        self.assertEqual(result['medianUnaccountedWallNs']['c'], 3_000_000)
        self.assertEqual(set(result['diagnosticOverOrdinary']), {'c', 'rs', 'fwp'})
        self.assertNotIn('improvement', result)

    def test_missing_reordered_failed_and_changed_observations_fail(self):
        for defect in ['missing', 'order', 'status', 'output', 'ordinary-stderr', 'hash', 'total', 'nan']:
            row = copy.deepcopy(self.row)
            observation = row['observations'][18]
            process = observation['processes'][0]
            if defect == 'missing':
                row['observations'].pop()
            elif defect == 'order':
                row['observations'][-1], row['observations'][-2] = row['observations'][-2], row['observations'][-1]
            elif defect == 'status':
                process['status'] = 246
            elif defect == 'output':
                process['stdout'] = 'wrong\n'
            elif defect == 'ordinary-stderr':
                process['stderr'] = 'unexpected'
            elif defect == 'hash':
                observation['binarySha256'] = 'b' * 64
            elif defect == 'total':
                observation['seconds'] += 1
            else:
                process['seconds'] = float('nan')
            with self.subTest(defect=defect), self.assertRaises(AssertionError):
                self.check(row)

    def test_clock_boundary_corruptions_fail(self):
        for marks in [[0, 1], [0, 2, 1], [0, 1, 100_000_000_000], [0, 1, 2.5], [0, True, 2], [-1, 1, 2]]:
            process = dict(seconds=0.01, stderr=json.dumps(dict(marksNs=marks)))
            with self.subTest(marks=marks), self.assertRaises(AssertionError):
                PHASES.phase_durations('c', process)

    def test_noise_is_retained_as_inconclusive(self):
        for observation in self.row['observations']:
            if observation['kind'] == 'fwp-identical':
                observation['processes'][0]['seconds'] *= 1.2
                observation['seconds'] *= 1.2
        result = self.check(self.row)
        self.assertEqual(result['fwpControl'], 'inconclusive')
        self.assertGreater(result['identicalCodeControls']['fwp']['pairRatio95'], 1.1)
        self.assertEqual(result['medianPhaseNs']['c']['calculation'], 6_000_000)

    def test_wrong_identical_binary_is_not_a_noise_control(self):
        self.row['binaries']['rs-identical']['sha256'] = 'b' * 64
        with self.assertRaises(AssertionError):
            self.check(self.row)

    def test_instrumentation_requires_the_declared_source_boundaries(self):
        for name in PHASES.PROGRAMS:
            c = (PHASES.ROOT / 'bench' / name / 'main.c').read_text()
            rust = (PHASES.ROOT / 'bench' / name / 'main.rs').read_text()
            self.assertIn('phase_report(3);', PHASES.instrument_c(name, c))
            self.assertIn('"marksNs', PHASES.instrument_rust(name, rust).replace('\\"', '"'))
            with self.assertRaisesRegex(AssertionError, 'instrumentation boundary'):
                PHASES.instrument_c(name, c.replace('int main(void)', 'int entry(void)'))
            with self.assertRaisesRegex(AssertionError, 'instrumentation boundary'):
                PHASES.instrument_rust(name, rust.replace('fn main()', 'fn entry()'))
        with self.assertRaisesRegex(AssertionError, 'instrumentation boundary'):
            PHASES.instrument_fwp('changed generated representation')


if __name__ == '__main__':
    unittest.main()
