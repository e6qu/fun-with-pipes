#!/usr/bin/env python3
"""Reject incomplete, corrupted and mislabelled current-kernel reports."""
import copy
import hashlib
import importlib.util
from pathlib import Path
import tempfile
import unittest
from unittest import mock

from current_kernel_costs import LABELS, decisions, execution_order, summarize

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('checker', ROOT / 'scripts/check-current-kernels.py')
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
SOURCE = 'a' * 40


def report_fixture():
    cpu, cc, c_arch, rust_cpu = CHECK.HOSTS['aarch64']
    host = dict(system='Linux', processors=4, machine='aarch64', cpu=cpu, cVersion=cc,
                rustVersion='rustc 1.99.1 (58cf8f9c3 2026-10-13)')
    result = dict(source=SOURCE, qualification=dict(source=SOURCE, qualified=True,
        failures=[], actual=host, expected=copy.deepcopy(host)),
        configuration=dict(samples=18, warmups=2, processes=4, small_matrix_processes=256,
            timeout=180, session=1, c_arch=c_arch, rust_cpu=rust_cpu, case=list(CHECK.MEASURE.CASES)),
        sourceTrees={name: '0' * 40 for name in ('src', 'runtime', 'lib', 'Cargo.toml', 'Cargo.lock', 'build.rs')},
        sourceHashes={name: '0' * 64 for name in (
            'scripts/measure-current-kernels.py', 'scripts/current_kernel_costs.py',
            'scripts/measure-kernel-baselines.py', 'scripts/numerical-baselines.py',
            'scripts/prepare-loop-state-reference.py', 'tests/fixtures/numerical_bench.c',
            'tests/fixtures/numerical_bench.rs', 'tests/fixtures/numerical_bench_native.c', 'src/cgen.rs')},
        compilerSha256={'fwp': 'b' * 64, 'reference': 'c' * 64},
        referenceManifest=dict(source=SOURCE, compilerSha256='c' * 64,
            disabledTransformation='native floating-point loop-state fields'),
        executionEnvironment=dict(FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0'),
        removedEnvironment=['FWP_NO_OPT', 'FWP_NO_REUSE'], allowedCpus=[0, 1, 2, 3], results={})
    for case, dimensions in CHECK.MEASURE.CASES.items():
        n, m, k, columns = dimensions
        values = [CHECK.MEASURE.BASELINE.matrix_result(m, k, columns, r) if case.startswith('matrix')
                  else [CHECK.MEASURE.BASELINE.array_result(n, r)] for r in range(8)]
        expected_hash = CHECK.MEASURE.BASELINE.result_hash(values)
        by_role = {}
        for label in LABELS:
            sample = dict(hash=expected_hash, kernelNs=80 if label.startswith('fwp') else 100,
                          allocationInclusiveNs=200, requests=8, requestedBytes=1024,
                          retains=0, peakChargedBytes=128)
            sample['livePayloadBytes' if label in ('c', 'rust') else 'liveChargedBytes'] = 0
            by_role[label] = [sample.copy() for _ in range(5)]
        processes = 256 if case == 'matrix-65-67-63' else 4
        records = []
        for phase, count in (('warmup', 2), ('sample', 18)):
            for index in range(count):
                order = execution_order(index, processes)
                records.append(dict(phase=phase, round=index, order=order, complete=True,
                    observations=[dict(label=label, processNs=2000, samples=by_role[label]) for label in order]))
        row = dict(dimensions=list(dimensions), resultHash=expected_hash, observations=records,
            profiles={label: copy.deepcopy(by_role[label]) for label in ('c', 'rust', 'fwp', 'reference')},
            rolePaths={label: f'role{index:04d}.exe' for index, label in enumerate(LABELS)},
            peakProcessRssBytes={label: 2048 for label in LABELS},
            binaries={f'{label}-{mode}': {} for label in ('c', 'rust', 'fwp', 'reference')
                      for mode in ('timing', 'profile', 'verify')},
            stack={'probe.su': dict(entries=[dict(location='kernel', bytes=32, qualifier='static')])},
            **summarize(records, processes))
        result['results'][case] = row
    result['failures'] = decisions(result['results'], {'array-65537', 'array-262145'})
    return result


class CurrentKernelEvidence(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.original = report_fixture()

    def setUp(self):
        self.report = copy.deepcopy(self.original)

    def check(self):
        return CHECK.check_report(self.report, SOURCE, 'aarch64', 1)

    def use_matrix_report(self):
        report = self.report
        report['results'] = {k: v for k, v in report['results'].items() if k.startswith('matrix')}
        report['configuration'].update(comparison='matrix-columns', reference_compiler=None,
            reference_manifest=None, case=list(report['results']))
        report['compilerSha256'].pop('reference')
        report['sourceHashes'].pop('scripts/prepare-loop-state-reference.py')
        report['sourceHashes'].update({'scripts/report-kernel-codegen.py': '0' * 64,
                                      'runtime/fwp_rt_kernel.c': '0' * 64})
        report['referenceManifest'] = dict(source=SOURCE, disabledTransformation='paired matrix columns',
            runtimeSha256='0' * 64, candidateLoopSha256='d' * 64, referenceLoopSha256='e' * 64)
        report['failures'] = decisions(report['results'], set())

    def test_matrix_report_requires_its_declared_cases_and_single_compiler(self):
        self.use_matrix_report()
        self.assertEqual(self.check(), [])
        self.report['compilerSha256']['reference'] = 'c' * 64
        with self.assertRaises(AssertionError):
            self.check()
        self.report['compilerSha256'].pop('reference')
        self.report['results'].pop('matrix-65-67-63')
        with self.assertRaises(AssertionError):
            self.check()

    def test_matrix_report_rejects_wrong_protocol_and_runtime(self):
        self.use_matrix_report()
        self.report['configuration']['comparison'] = 'loop-state'
        with self.assertRaises(AssertionError):
            self.check()
        self.report['configuration']['comparison'] = 'matrix-columns'
        self.report['referenceManifest']['runtimeSha256'] = 'f' * 64
        with self.assertRaises(AssertionError):
            self.check()

    def test_matrix_reference_cannot_change_unrelated_source(self):
        before, after = b'old scalar loop', b'new paired loop'
        runtime = b'prefix\n' + after + b'\nsuffix'
        preparation = ('MATRIX_COLUMNS_BEFORE = ' + repr(before) + '\nMATRIX_COLUMNS_AFTER = '
                       + repr(after) + '\nraise RuntimeError("do not execute recorded code")\n').encode()
        manifest = dict(runtimeSha256=hashlib.sha256(runtime).hexdigest(),
                        candidateLoopSha256=hashlib.sha256(after).hexdigest(),
                        referenceLoopSha256=hashlib.sha256(before).hexdigest())
        def recorded(command, **kwargs):
            return preparation if command[-1].endswith('report-kernel-codegen.py') else runtime
        with tempfile.TemporaryDirectory() as name, mock.patch.object(CHECK.subprocess, 'check_output', side_effect=recorded):
            root = Path(name)
            folder = root / 'matrix-case'
            folder.mkdir()
            for mode in ('generated', 'timing', 'profile', 'verify'):
                (folder / ('fwp-' + mode + '.c')).write_bytes(runtime)
                (folder / ('reference-' + mode + '.c')).write_bytes(runtime.replace(after, before))
            CHECK.check_matrix_reference(root, SOURCE, manifest, ['matrix-case'])
            (folder / 'reference-timing.c').write_bytes(runtime.replace(after, before) + b'changed')
            with self.assertRaises(AssertionError):
                CHECK.check_matrix_reference(root, SOURCE, manifest, ['matrix-case'])

    def test_recorded_test_changes_are_literal_and_narrow(self):
        source = (ROOT / 'scripts/prepare-loop-state-reference.py').read_text()
        changes = CHECK.recorded_test_expectations(source)
        self.assertEqual(len(changes), 2)
        self.assertEqual(CHECK.recorded_test_expectations('CANDIDATE = "before"\nREFERENCE = "after"\n'), {})
        for damaged in (source + '\nTEST_EXPECTATIONS = {}\n',
                        source.replace("'typedef struct {{ V v0; V v1; V v2; V v3; }}", "'typedef struct {{ V v0; V v1; V v2; float v3; }}"),
                        source.replace("'tests/nested_loop_boxing.rs'", "'tests/another.rs'")):
            with self.assertRaises(AssertionError):
                CHECK.recorded_test_expectations(damaged)
        hostile = source + '\nraise RuntimeError("must not execute")\n'
        self.assertEqual(CHECK.recorded_test_expectations(hostile), changes)

    def test_complete_report_passes(self):
        self.assertEqual(self.check(), [])

    def test_changed_results_fail(self):
        self.report['results']['array-65537']['observations'][2]['observations'][0]['samples'][0]['hash'] = '0' * 16
        with self.assertRaises(AssertionError):
            self.check()

    def test_nonzero_final_storage_fails(self):
        self.report['results']['array-65537']['profiles']['reference'][0]['liveChargedBytes'] = 16
        with self.assertRaises(AssertionError):
            self.check()

    def test_missing_case_and_incomplete_round_fail(self):
        self.report['results'].pop('matrix-257-259-255')
        with self.assertRaises(AssertionError):
            self.check()
        self.report = copy.deepcopy(self.original)
        self.report['results']['array-65537']['observations'][-1]['complete'] = False
        with self.assertRaises(AssertionError):
            self.check()

    def test_wrong_source_host_session_and_reference_fail(self):
        for field in ('source', 'host', 'session', 'compiler'):
            self.report = copy.deepcopy(self.original)
            if field == 'source':
                self.report['source'] = 'd' * 40
            elif field == 'host':
                self.report['qualification']['actual']['cpu'] = 'different CPU'
            elif field == 'session':
                self.report['configuration']['session'] = 2
            else:
                self.report['compilerSha256']['reference'] = 'e' * 64
            with self.subTest(field=field), self.assertRaises(AssertionError):
                self.check()

    def test_stale_totals_and_omitted_copy_fail(self):
        self.report['results']['array-65537']['totals']['fwp']['kernelNs'][0] += 1
        with self.assertRaises(AssertionError):
            self.check()
        self.report = copy.deepcopy(self.original)
        self.report['results']['array-65537']['identicalRatios'].pop('reference')
        with self.assertRaises(AssertionError):
            self.check()

    def test_performance_failure_must_be_retained(self):
        row = self.report['results']['array-65537']
        for record in row['observations']:
            for observation in record['observations']:
                if observation['label'] == 'reference-identical':
                    observation['samples'] = [dict(s, kernelNs=120) for s in observation['samples']]
        row.update(summarize(row['observations'], 4))
        self.report['failures'] = decisions(self.report['results'], {'array-65537', 'array-262145'})
        self.assertEqual(len(self.check()), 1)
        self.report['failures'] = []
        with self.assertRaises(AssertionError):
            self.check()

    def test_missing_runtime_or_oracle_identity_fails(self):
        self.report['sourceTrees'].pop('runtime')
        with self.assertRaises(AssertionError):
            self.check()
        self.report = copy.deepcopy(self.original)
        self.report['sourceHashes'].pop('scripts/numerical-baselines.py')
        with self.assertRaises(AssertionError):
            self.check()

    def test_negative_profile_counts_and_disabled_optimization_fail(self):
        self.report['results']['array-65537']['profiles']['fwp'][0]['retains'] = -1
        with self.assertRaises(AssertionError):
            self.check()
        self.report = copy.deepcopy(self.original)
        self.report['executionEnvironment']['FWP_NO_OPT'] = '0'
        with self.assertRaises(AssertionError):
            self.check()


if __name__ == '__main__':
    unittest.main()
