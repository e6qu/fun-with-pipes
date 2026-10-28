#!/usr/bin/env python3
"""Reject incomplete baselines, false comparisons and silently reset limits."""
import copy
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


SPEC = importlib.util.spec_from_file_location('cpu_baselines', Path(__file__).with_name('cpu-baselines.py'))
CPU = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CPU)
SETTINGS = dict(samples=8, warmups=2, cpuPolicy='all', timeout=120, processes={'loop': 1, 'text-length': 2}, maxControlRatio=1.03, maxPairRatio=1.10)


def report(architecture, session):
    programs = {}
    for name in CPU.PROGRAMS:
        binaries = {kind: dict(sha256='a' * 64, bytes=1024) for kind in CPU.KINDS}
        normal = dict(requests=0, requestedBytes=0, retains=0, peakChargedBytes=0, finalChargedBytes=0)
        leak = dict(requests=1, requestedBytes=16, retains=0, peakChargedBytes=16, finalChargedBytes=16)
        row = dict(stdout='42\n', binaries=binaries, inputs={k: 'b' * 64 for k in ['c', 'rs', 'fwp']},
                   textBytes={k: 128 for k in ['c', 'rs', 'fwp']}, instrumentedStack={'profile.su': 'worker 32 static\n'},
                   memory=dict(leakDetected=True,
                       managedMemory={'ordinary': {'profiles': [normal] * 3}, 'injected-leak': {'profiles': [leak] * 3}},
                       processMemory={k: dict(binarySha256='a' * 64, peakRssKiB=[1024] * 3) for k in ['c', 'rs', 'fwp']}),
                   observations=[])
        for phase, rounds in [('warmup', 2), ('sample', 8)]:
            for index in range(rounds):
                for position in range(4):
                    kind = CPU.KINDS[(index + position) % 4]
                    seconds = {'c': 0.5, 'rs': 0.8, 'fwp': 1.0, 'identical': 1.01}[kind]
                    processes = [dict(seconds=seconds, stdout='42\n', stderr='', status=0)
                                 for _ in range(SETTINGS['processes'][name])]
                    row['observations'].append(dict(kind=kind, phase=phase, round=index,
                        seconds=sum(p['seconds'] for p in processes), processes=processes,
                        binarySha256='a' * 64))
        row['result'] = CPU.check_case(name, row, SETTINGS)
        programs[name] = row
    return dict(source='c' * 40, settings=SETTINGS.copy(), architecture=architecture,
                run=123, session=session, host=dict(model=architecture, vendor='test', architecture=architecture),
                toolchains='fixed compiler versions and flags', programs=programs)


class Baselines(unittest.TestCase):
    def setUp(self):
        self.reports = [report(arch, session) for arch in ['x86_64', 'aarch64'] for session in [1, 2]]

    def test_freeze_preserves_slower_results_and_observed_limits(self):
        result = CPU.freeze(self.reports)
        self.assertEqual(len(result['rows']), 4)
        for row in result['rows']:
            self.assertAlmostEqual(row['maxCandidateRatio'], 1.02)
            self.assertAlmostEqual(row['maxRatioForImprovement'], 1 / 1.02)
            self.assertAlmostEqual(row['maxControlPairRatio'], 1.01)
            self.assertEqual(row['baseline'][0]['fwpOverC'], 2.0)
            self.assertEqual(row['baseline'][0]['fwpOverRust'], 1.25)

    def test_distinct_workflows_can_repeat_the_same_session_label(self):
        self.reports[1]['run'] = 124
        self.reports[1]['session'] = 1
        self.assertEqual(len(CPU.freeze(self.reports)['rows']), 4)

    def test_host_selection_is_deterministic_and_keeps_other_results(self):
        # The first two AMD64 jobs landed on different CPU models. The next
        # workflow repeats model B first, so model B wins regardless of timing.
        self.reports[1]['host']['model'] = 'model B'
        repeat = copy.deepcopy(self.reports[1])
        repeat.update(run=124, session=1)
        self.reports.append(repeat)
        later = copy.deepcopy(self.reports[0])
        later.update(run=124, session=2)
        self.reports.append(later)
        result = CPU.freeze(self.reports)
        rows = [row for row in result['rows'] if row['architecture'] == 'x86_64']
        self.assertTrue(all(row['host']['model'] == 'model B' for row in rows))
        self.assertEqual(len(result['additionalSessions']), 2)
        self.assertEqual(result, CPU.freeze(list(reversed(self.reports))))
        # A noisy selected pair cannot be replaced by a later stable pair.
        row = repeat['programs']['loop']
        for sample in row['observations']:
            if sample['kind'] == 'identical':
                sample['seconds'] = 1.2
                sample['processes'][0]['seconds'] = 1.2
        row['result'] = CPU.check_case('loop', row, SETTINGS)
        with self.assertRaisesRegex(AssertionError, 'inconclusive'):
            CPU.freeze(self.reports)

    def test_missing_duplicate_or_different_sessions_fail(self):
        for change in ['missing', 'duplicate', 'source', 'settings', 'host', 'compiler', 'input']:
            data = copy.deepcopy(self.reports)
            if change == 'missing':
                data.pop()
            elif change == 'duplicate':
                data[1] = data[0]
            elif change == 'source':
                data[1]['source'] = 'd' * 40
            elif change == 'settings':
                data[1]['settings']['samples'] = 12
            elif change == 'host':
                data[1]['host']['model'] = 'different'
            elif change == 'compiler':
                data[1]['toolchains'] = 'different'
            else:
                data[1]['programs']['loop']['inputs']['fwp'] = 'e' * 64
            with self.assertRaises(AssertionError, msg=change):
                CPU.freeze(data)

    def test_missing_wrong_or_fabricated_observations_fail(self):
        for change in ['missing', 'order', 'output', 'stderr', 'status', 'hash', 'statistic', 'nan', 'zero', 'batch', 'sum']:
            data = copy.deepcopy(self.reports)
            row = data[0]['programs']['loop']
            sample = row['observations'][-1]
            if change == 'missing':
                row['observations'].pop()
            elif change == 'order':
                sample['round'] = 0
            elif change == 'output':
                sample['processes'][0]['stdout'] = '41\n'
            elif change == 'stderr':
                sample['processes'][0]['stderr'] = 'warning'
            elif change == 'status':
                sample['processes'][0]['status'] = 1
            elif change == 'hash':
                sample['binarySha256'] = 'd' * 64
            elif change == 'statistic':
                row['result']['fwpOverC'] = 0.5
            elif change == 'batch':
                sample['processes'].pop()
            elif change == 'sum':
                sample['seconds'] += 1
            else:
                sample['processes'][0]['seconds'] = float('nan') if change == 'nan' else 0
            with self.assertRaises(AssertionError, msg=change):
                CPU.freeze(data)

    def test_noisy_controls_stay_inconclusive(self):
        for change in ['median', 'spread']:
            data = copy.deepcopy(self.reports)
            row = data[0]['programs']['loop']
            for item in row['observations']:
                if item['kind'] == 'identical' and item['phase'] == 'sample':
                    if change == 'median' or item['round'] == 7:
                        item['seconds'] = 1.04 if change == 'median' else 1.11
                        item['processes'][0]['seconds'] = item['seconds']
            row['result'] = CPU.check_case('loop', row, SETTINGS)
            self.assertEqual(row['result']['decision'], 'inconclusive')
            with self.assertRaisesRegex(AssertionError, 'inconclusive'):
                CPU.freeze(data)

    def test_memory_and_size_evidence_cannot_disappear(self):
        for change in ['rss', 'leak', 'retained', 'stack', 'empty-stack', 'text']:
            data = copy.deepcopy(self.reports)
            row = data[0]['programs']['loop']
            if change == 'rss':
                row['memory']['processMemory']['fwp']['peakRssKiB'] = []
            elif change == 'leak':
                row['memory']['managedMemory']['injected-leak']['profiles'][0]['finalChargedBytes'] = 0
            elif change == 'retained':
                row['memory']['managedMemory']['ordinary']['profiles'][0]['finalChargedBytes'] = 16
            elif change == 'stack':
                row['instrumentedStack'] = {}
            elif change == 'empty-stack':
                row['instrumentedStack'] = {'profile.su': ''}
            else:
                row['textBytes']['fwp'] = 0
            with self.assertRaises(AssertionError, msg=change):
                CPU.freeze(data)


    def test_cli_verifies_the_original_table_and_rejects_a_relaxed_limit(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            paths = []
            for index, value in enumerate(self.reports):
                path = root / f'session-{index}.json'
                path.write_text(json.dumps(value))
                paths.append(str(path))
            table = root / 'budgets.json'
            command = [sys.executable, str(Path(CPU.__file__))]
            result = subprocess.run(command + ['freeze', '--reports', *paths, '--output', str(table)],
                                    capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            result = subprocess.run(command + ['verify', '--reports', *paths, '--table', str(table)],
                                    capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            data = json.loads(table.read_text())
            data['rows'][0]['maxCandidateRatio'] = 1.5
            table.write_text(json.dumps(data))
            result = subprocess.run(command + ['verify', '--reports', *paths, '--table', str(table)],
                                    capture_output=True, text=True)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('frozen table differs', result.stderr)


if __name__ == '__main__':
    unittest.main()
