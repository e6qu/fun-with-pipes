#!/usr/bin/env python3
"""Check process-order balance and explicit host rejection."""
from collections import Counter
import copy
import importlib.util
import json
from pathlib import Path
import subprocess
from tempfile import TemporaryDirectory
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location('descent_baselines', Path(__file__).with_name('descent-baselines.py'))
BASELINE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BASELINE)
SPEC = importlib.util.spec_from_file_location('descent_groups', Path(__file__).with_name('check-descent-groups.py'))
GROUPS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(GROUPS)
LABELS = list('abcdefg')
CPUS = ['AMD EPYC 7763 64-Core Processor', 'AMD EPYC 9V74 80-Core Processor',
        'AMD EPYC 9V45 96-Core Processor']


class Measurement(unittest.TestCase):
    def test_each_process_count_and_predecessor_are_balanced(self):
        for count in [7, 21, 42]:
            for index in range(98):
                order = BASELINE.execution_order(LABELS, count, index, 20261029)
                self.assertEqual(Counter(order), Counter({label: count for label in LABELS}))
                cyclic = Counter(zip(order, order[1:] + order[:1]))
                self.assertEqual(cyclic, Counter({(a, b): count // 7 for a in LABELS for b in LABELS}))

    def test_start_and_end_positions_rotate_evenly(self):
        orders = [BASELINE.execution_order(LABELS, 42, index, 20261029) for index in range(98)]
        self.assertEqual(Counter(order[0] for order in orders), Counter({label: 14 for label in LABELS}))
        self.assertEqual(Counter(order[-1] for order in orders), Counter({label: 14 for label in LABELS}))
        # A round boundary replaces one cyclic edge; retain it rather than
        # claiming the complete flattened schedule has perfect balance.
        actual = Counter()
        for left, right in zip(orders, orders[1:]):
            actual[(left[-1], right[0])] += 1
        self.assertEqual(sum(actual.values()), 97)

    def test_schedule_is_reproducible_and_rejects_partial_cycles(self):
        self.assertEqual(BASELINE.execution_order(LABELS, 7, 4, 20261029), BASELINE.execution_order(LABELS, 7, 4, 20261029))
        for count in [0, 1, 8]:
            with self.assertRaises(AssertionError):
                BASELINE.execution_order(LABELS, count, 0, 20261029)

    def test_round_sums_every_process_and_preserves_all_observations(self):
        with TemporaryDirectory() as temporary:
            target = Path(temporary) / 'sample.json'
            def run(command, env):
                return subprocess.CompletedProcess(command, 0, command[0].encode(), b'')
            with patch.object(BASELINE.time, 'perf_counter_ns', side_effect=[10, 15, 20, 27, 30, 39]):
                totals = BASELINE.measure_round(['a', 'b', 'a'], {'a': 'a', 'b': 'b'},
                    {'a': b'a', 'b': b'b'}, {}, run, target)
            self.assertEqual(totals, {'a': 14, 'b': 7})
            report = json.loads(target.read_text())
            self.assertTrue(report['complete'])
            self.assertEqual([row['elapsedNs'] for row in report['observations']], [5, 7, 9])
            self.assertTrue(all(row['outputMatches'] and row['status'] == 0 for row in report['observations']))

    def test_wrong_output_and_nonzero_status_remain_failed_observations(self):
        for result in [subprocess.CompletedProcess([], 0, b'wrong', b''),
                       subprocess.CompletedProcess([], 1, b'expected', b'failure')]:
            with TemporaryDirectory() as temporary:
                target = Path(temporary) / 'sample.json'
                with self.assertRaises(AssertionError):
                    BASELINE.measure_round(['a'], {'a': 'a'}, {'a': b'expected'}, {},
                                           lambda command, env: result, target)
                report = json.loads(target.read_text())
                self.assertFalse(report['complete'])
                self.assertFalse(report['observations'][0]['outputMatches'])
                self.assertEqual(target.with_suffix('.stdout').read_bytes(), result.stdout)
                self.assertEqual(target.with_suffix('.stderr').read_bytes(), result.stderr)

    def test_interrupted_round_preserves_completed_processes(self):
        with TemporaryDirectory() as temporary:
            target = Path(temporary) / 'sample.json'
            results = iter([subprocess.CompletedProcess([], 0, b'expected', b''), None])
            def run(command, env):
                result = next(results)
                if result is None:
                    raise TimeoutError('deliberate command timeout')
                return result
            with self.assertRaises(TimeoutError):
                BASELINE.measure_round(['a', 'a'], {'a': 'a'}, {'a': b'expected'}, {}, run, target)
            report = json.loads(target.read_text())
            self.assertFalse(report['complete'])
            self.assertEqual(len(report['observations']), 1)
            self.assertEqual(report['order'], ['a', 'a'])

    def test_matching_is_exact_and_reports_all_mismatches(self):
        expected = dict(cpu='Neoverse-N2', machine='aarch64', processors=4, cVersion='gcc 13', rustVersion='rustc 1.99')
        self.assertEqual(BASELINE.host_failures(expected, expected), [])
        changed = expected | dict(cpu='different host', processors=2, cVersion='gcc 15')
        failures = BASELINE.host_failures(changed, expected)
        self.assertEqual(len(failures), 3)
        for key in ['cpu:', 'processors:', 'cVersion:']:
            self.assertTrue(any(line.startswith(key) for line in failures))

    def test_cpu_set_cli_preserves_actual_host_and_rejection(self):
        source = '1' * 40
        for cpu in [*CPUS, 'unapproved CPU']:
            with self.subTest(cpu=cpu), TemporaryDirectory() as temporary:
                output = Path(temporary) / 'host.json'
                actual = dict(system='Linux', machine='x86_64', cpu=cpu, processors=4,
                              cVersion='gcc test', rustVersion='rustc test')
                argv = ['descent-baselines.py', '--machine', 'x86_64', '--cc', 'gcc',
                        '--rustc', 'rustc', '--c-version', 'gcc test', '--rust-version',
                        'rustc test', '--source', source, '--processors', '4', '--output', str(output)]
                for allowed in CPUS:
                    argv.extend(['--cpu', allowed])
                with patch('sys.argv', argv), patch.dict(BASELINE.os.environ, {'GITHUB_ACTIONS': 'true'}), \
                        patch.object(BASELINE.platform, 'system', return_value='Linux'), \
                        patch.object(BASELINE.subprocess, 'check_output', return_value=source), \
                        patch.object(BASELINE, 'host_details', return_value=(actual, 'Model name: ' + cpu)):
                    if cpu in CPUS:
                        BASELINE.main()
                    else:
                        with self.assertRaisesRegex(SystemExit, 'Host rejected before building/timing'):
                            BASELINE.main()
                report = json.loads(output.read_text())
                self.assertEqual(report['actual'], actual)
                self.assertEqual(report['expected']['cpu'], CPUS)
                self.assertEqual(report['qualified'], cpu in CPUS)
                self.assertEqual(len(report['failures']), int(cpu not in CPUS))
                # A second allowed model cannot replace the selected host inside
                # a session; timing rechecks the recorded actual host exactly.
                if cpu in CPUS:
                    other = actual | {'cpu': CPUS[(CPUS.index(cpu) + 1) % len(CPUS)]}
                    self.assertEqual(len(BASELINE.host_failures(other, report['actual'])), 1)

    def test_reader_checks_approved_models_and_all_other_host_requirements(self):
        frozen = dict(system='Linux', machine='x86_64', processors=4,
                      cVersion='gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0',
                      rustVersion='rustc 1.99.1 (58cf8f9c3 2026-10-13)')
        for cpu in CPUS:
            report = dict(machine='x86_64', qualification=dict(
                actual=frozen | {'cpu': cpu}, expected=frozen | {'cpu': CPUS}))
            GROUPS.check_frozen_host(report, 'recording-context')
            for key, wrong in [('cpu', 'unknown CPU'), ('processors', 2),
                               ('cVersion', 'gcc other'), ('rustVersion', 'rustc other'),
                               ('system', 'Darwin'), ('machine', 'aarch64')]:
                changed = copy.deepcopy(report)
                for field in ('actual', 'expected'):
                    changed['qualification'][field][key] = wrong
                with self.subTest(cpu=cpu, field=key), self.assertRaises(AssertionError):
                    GROUPS.check_frozen_host(changed, 'recording-context')
            changed = copy.deepcopy(report)
            changed['qualification']['expected']['cpu'].append('unknown CPU')
            with self.assertRaises(AssertionError):
                GROUPS.check_frozen_host(changed, 'recording-context')
            with self.assertRaises(AssertionError):
                GROUPS.check_frozen_host(report, 'recording-capacity')
            if cpu != CPUS[0]:
                changed = copy.deepcopy(report)
                changed['qualification']['expected']['cpu'] = CPUS[0]
                with self.assertRaises(AssertionError):
                    GROUPS.check_frozen_host(changed, 'recording-context')
        original = frozen | {'cpu': CPUS[0]}
        historical = dict(machine='x86_64', qualification=dict(actual=original, expected=original))
        GROUPS.check_frozen_host(historical, 'recording-context')
        GROUPS.check_frozen_host(historical, 'recording-capacity')


if __name__ == '__main__':
    unittest.main()
