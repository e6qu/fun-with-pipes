#!/usr/bin/env python3
"""Reject substituted current-kernel archives and ambiguous source/session inputs."""
import copy
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
import zipfile

SPEC = importlib.util.spec_from_file_location('codegen', Path(__file__).with_name('report-kernel-codegen.py'))
CODEGEN = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CODEGEN)
SOURCE = 'a' * 40


class KernelCodegenInput(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.path = Path(self.temp.name) / 'input.zip'
        host = dict(qualified=True, failures=[], actual=dict(machine='aarch64'))
        report = dict(source=SOURCE, configuration=dict(session=2), qualification=host,
                      failures=[dict(kind='speed', ratio=1.0, limit=.95)])
        raw = (json.dumps(report) + '\n').encode()
        with zipfile.ZipFile(self.path, 'w') as archive:
            archive.writestr('comparison.json', raw)
        artifact = dict(digest='sha256:' + CODEGEN.digest(self.path.read_bytes()),
                        workflow_run=dict(head_sha=SOURCE))
        self.row = dict(source=SOURCE, machine='aarch64', session=2, job=dict(id=123),
            qualification=host, reportBytes=len(raw), reportSha256=CODEGEN.digest(raw),
            failures=report['failures'], artifacts={'current-kernels-ubuntu-24.04-arm-2': artifact})
        self.index = dict(schema=1, complete=True, auditErrors=[], jobs=[self.row], measurements=[123])

    def read(self):
        archive, report, metadata = CODEGEN.read_archive(self.path, self.index, SOURCE, 'aarch64', 2)
        archive.close()
        return report, metadata

    def test_restricted_input_patch_is_exact_and_keeps_byte_access(self):
        source = (Path(__file__).resolve().parent.parent / 'runtime/fwp_rt_kernel.c').read_bytes()
        updated = CODEGEN.restricted_inputs(source)
        self.assertEqual(updated.replace(CODEGEN.MATRIX_INPUTS_AFTER, CODEGEN.MATRIX_INPUTS_BEFORE), source)
        self.assertEqual(updated.count(b'__builtin_memcpy'), source.count(b'__builtin_memcpy'))
        for damaged in (b'', source + CODEGEN.MATRIX_INPUTS_BEFORE, updated):
            with self.assertRaises(AssertionError):
                CODEGEN.restricted_inputs(damaged)

    def test_complete_input_retains_failed_performance_decisions(self):
        report, metadata = self.read()
        self.assertEqual(report['failures'], self.row['failures'])
        self.assertEqual(metadata['workflow_run']['head_sha'], SOURCE)

    def test_paired_column_patch_changes_only_the_declared_loop(self):
        runtime = (Path(__file__).resolve().parent.parent / 'runtime/fwp_rt_kernel.c').read_bytes()
        self.assertEqual(runtime.count(CODEGEN.MATRIX_COLUMNS_AFTER), 1)
        source = runtime.replace(CODEGEN.MATRIX_COLUMNS_AFTER, CODEGEN.MATRIX_COLUMNS_BEFORE)
        updated = CODEGEN.paired_columns(source)
        self.assertEqual(updated, runtime)
        self.assertEqual(updated.replace(CODEGEN.MATRIX_COLUMNS_AFTER, CODEGEN.MATRIX_COLUMNS_BEFORE), source)
        self.assertIn(CODEGEN.MATRIX_INPUTS_BEFORE, updated)
        for damaged in (b'', source + CODEGEN.MATRIX_COLUMNS_BEFORE, updated):
            with self.assertRaises(AssertionError):
                CODEGEN.paired_columns(damaged)

    def test_archive_and_report_substitution_fail(self):
        original = self.path.read_bytes()
        self.path.write_bytes(original + b'changed')
        with self.assertRaises(AssertionError):
            self.read()
        self.path.write_bytes(original)
        self.row['reportSha256'] = '0' * 64
        with self.assertRaises(AssertionError):
            self.read()

    def test_wrong_or_duplicate_source_session_is_rejected(self):
        for key, value in (('source', 'b' * 40), ('machine', 'x86_64'), ('session', 1)):
            previous = self.row[key]
            self.row[key] = value
            with self.subTest(key=key), self.assertRaises(ValueError):
                self.read()
            self.row[key] = previous
        self.index['jobs'].append(copy.deepcopy(self.row))
        with self.assertRaises(ValueError):
            self.read()

    def test_missing_audit_and_changed_failure_record_are_rejected(self):
        self.index['complete'] = False
        with self.assertRaises(AssertionError):
            self.read()
        self.index['complete'] = True
        self.row['failures'] = []
        with self.assertRaises(AssertionError):
            self.read()


if __name__ == '__main__':
    unittest.main()
