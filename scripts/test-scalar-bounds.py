#!/usr/bin/env python3
"""Reject misleading candidate timings before using them to select compiler code."""
import copy
import importlib.util
import json
from pathlib import Path
import re
import unittest

SPEC = importlib.util.spec_from_file_location('scalar_bounds', Path(__file__).with_name('scalar-bounds.py'))
BOUNDS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BOUNDS)
TABLE = json.loads((BOUNDS.ROOT / 'docs/measurements/cpu-budgets-2026-10-28.json').read_text())
SETTINGS = dict(samples=56, warmups=2, processes={'loop': 1, 'text-length': 32}, timeout=120, cpuPolicy='all')


def fixture(name):
    row = dict(stdout={'loop': '300000003\n', 'text-length': '28518516\n'}[name],
               binaries={kind: dict(sha256='a' * 64, bytes=1024) for kind in BOUNDS.KINDS}, observations=[])
    for phase, count in [('warmup', 2), ('sample', 56)]:
        for index in range(count):
            for position in range(7):
                kind = BOUNDS.KINDS[(index + position) % 7]
                elapsed = {'c': 0.5, 'rs': 0.7, 'baseline': 1, 'index': 0.8, 'length': 1.2, 'both': 0.79, 'identical': 1.001}[kind]
                processes = [dict(seconds=elapsed, stdout=row['stdout'], stderr='', status=0) for _ in range(SETTINGS['processes'][name])]
                row['observations'].append(dict(kind=kind, phase=phase, round=index, binarySha256='a' * 64,
                                               processes=processes, seconds=sum(p['seconds'] for p in processes)))
    return row


class ScalarBounds(unittest.TestCase):
    def setUp(self):
        self.budget = next(r for r in TABLE['rows'] if r['program'] == 'text-length' and r['architecture'] == 'aarch64')
        self.row = fixture('text-length')

    def check(self, row):
        return BOUNDS.check_case('text-length', row, SETTINGS, self.budget)

    def test_slower_changes_remain_visible(self):
        result = self.check(self.row)
        self.assertEqual(result['control'], 'stable')
        self.assertTrue(result['improvement']['index'])
        self.assertTrue(result['improvement']['both'])
        self.assertFalse(result['withinRegression']['length'])
        self.assertAlmostEqual(result['candidateOverBaseline']['length'], 1.2)

    def test_incomplete_reordered_changed_or_failed_observations_fail(self):
        for defect in ['missing', 'order', 'phase', 'count', 'status', 'stdout', 'stderr', 'sum', 'hash', 'nan']:
            row = copy.deepcopy(self.row)
            observation = row['observations'][-1]
            if defect == 'missing':
                row['observations'].pop()
            elif defect == 'order':
                row['observations'][-1], row['observations'][-2] = row['observations'][-2], row['observations'][-1]
            elif defect == 'phase':
                observation['phase'] = 'warmup'
            elif defect == 'count':
                observation['processes'].pop()
            elif defect == 'status':
                observation['processes'][0]['status'] = 1
            elif defect in ('stdout', 'stderr'):
                observation['processes'][0][defect] = 'wrong\n'
            elif defect == 'sum':
                observation['seconds'] += 1
            elif defect == 'hash':
                observation['binarySha256'] = 'b' * 64
            else:
                observation['processes'][0]['seconds'] = float('nan')
            with self.subTest(defect=defect), self.assertRaises(AssertionError):
                self.check(row)

    def test_changed_noise_binary_is_not_a_control(self):
        self.row['binaries']['identical']['sha256'] = 'b' * 64
        with self.assertRaises(AssertionError):
            self.check(self.row)

    def test_unstable_control_cannot_select_fast_candidate(self):
        for observation in self.row['observations']:
            if observation['kind'] == 'identical':
                for process in observation['processes']:
                    process['seconds'] *= 1.2
                observation['seconds'] = sum(p['seconds'] for p in observation['processes'])
        result = self.check(self.row)
        self.assertEqual(result['control'], 'inconclusive')
        self.assertFalse(any(result['improvement'].values()))
        self.assertFalse(any(result['withinRegression'].values()))

    def test_unknown_host_compiler_and_input_require_new_baseline(self):
        host = self.budget['host']
        compilers = re.findall(r'```text\n(.*?)\n```', self.budget['toolchains'], re.S)
        inputs = {r['program']: r['inputs'] for r in TABLE['rows'] if r['host'] == host}
        self.assertEqual(set(BOUNDS.qualify(TABLE, host, compilers, inputs)), set(BOUNDS.PROGRAMS))
        for defect in ['host', 'cpu-count', 'compiler', 'inputs', 'baseline']:
            table, h, c, i = [copy.deepcopy(value) for value in (TABLE, host, compilers, inputs)]
            if defect == 'host':
                h['model'] = 'another CPU'
            elif defect == 'cpu-count':
                h['allowedCpuCount'] += 1
            elif defect == 'compiler':
                c[0] += 'changed'
            elif defect == 'inputs':
                i['loop']['fwp'] = 'b' * 64
            else:
                table['source'] = 'b' * 40
            with self.subTest(defect=defect), self.assertRaises(AssertionError):
                BOUNDS.qualify(table, h, c, i)

    def test_selection_requires_both_programs_and_recomputes_decisions(self):
        host = self.budget['host']
        compilers = re.findall(r'```text\n(.*?)\n```', self.budget['toolchains'], re.S)
        budgets = {r['program']: r for r in TABLE['rows'] if r['host'] == host}
        report = dict(baseline=BOUNDS.BASELINE, candidate='b' * 40, host=host, compilers=compilers,
                      inputs={n: r['inputs'] for n, r in budgets.items()}, settings=SETTINGS, programs={})
        for name in BOUNDS.PROGRAMS:
            row = fixture(name)
            row['result'] = BOUNDS.check_case(name, row, SETTINGS, budgets[name])
            report['programs'][name] = row
        self.assertEqual(BOUNDS.check_report(report, TABLE), ['index', 'both'])
        # A tempting text win does not excuse a loop regression.
        loop = report['programs']['loop']
        for observation in loop['observations']:
            if observation['kind'] == 'index':
                observation['processes'][0]['seconds'] = 1.2
                observation['seconds'] = 1.2
        loop['result'] = BOUNDS.check_case('loop', loop, SETTINGS, budgets['loop'])
        self.assertEqual(BOUNDS.check_report(report, TABLE), ['both'])
        loop['result']['withinRegression']['index'] = True
        with self.assertRaisesRegex(AssertionError, 'stored decision differs'):
            BOUNDS.check_report(report, TABLE)


class RetainedExperiment(unittest.TestCase):
    def test_original_records_and_corrupted_artifacts(self):
        directory = BOUNDS.ROOT / 'docs/measurements'
        table_path = directory / 'cpu-budgets-2026-10-28.json'
        reports = [json.loads((directory / f'scalar-bounds-2026-10-29-{arch}.json').read_text()) for arch in ('arm', 'amd')]
        rejected = json.loads((directory / 'scalar-bounds-2026-10-29-unqualified.json').read_text())
        artifacts = json.loads((directory / 'scalar-bounds-artifacts-2026-10-29.json').read_text())
        BOUNDS.verify(reports, rejected, TABLE, BOUNDS.digest(table_path), artifacts)
        changed = copy.deepcopy(artifacts)
        changed['aarch64']['variants']['index']['memory'] += ' '
        with self.assertRaisesRegex(AssertionError, 'archived artifact differs'):
            BOUNDS.verify(reports, rejected, TABLE, BOUNDS.digest(table_path), changed)
        changed_reports = copy.deepcopy(reports)
        changed_reports[0]['variants']['index']['sources']['src/fuse.rs'] = 'b' * 64
        with self.assertRaisesRegex(AssertionError, 'wrong compiler source'):
            BOUNDS.verify(changed_reports, rejected, TABLE, BOUNDS.digest(table_path), artifacts)
        executed = copy.deepcopy(rejected)
        executed['variants']['both'] = {}
        with self.assertRaisesRegex(AssertionError, 'unqualified host executed'):
            BOUNDS.verify(reports, executed, TABLE, BOUNDS.digest(table_path), artifacts)


if __name__ == '__main__':
    unittest.main()
