#!/usr/bin/env python3
"""Reject incomplete, wrong-source or diagnostically failing production gates."""
import importlib.util
import hashlib
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
import zipfile

from github_records import records

SPEC = importlib.util.spec_from_file_location('audit', Path(__file__).with_name('audit-production-run.py'))
AUDIT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AUDIT)
FOCUSED_SPEC = importlib.util.spec_from_file_location('focused', Path(__file__).with_name('audit-focused-storage.py'))
FOCUSED = importlib.util.module_from_spec(FOCUSED_SPEC)
FOCUSED_SPEC.loader.exec_module(FOCUSED)
SOURCE = 'a' * 40
DOC_LOG = (
    b'intentional runner control\n'
    b'error: duplicate selected test target\n'
    b'error: unknown selected test targets\n'
    b'test result: FAILED. 0 passed; 1 failed;\n'
)


class ProductionLogs(unittest.TestCase):
    def run_audit(self, output, host, *, conclusion, status, source, log):
        jobs = []
        for index, (label, (name, _, _)) in enumerate(AUDIT.CONFIG.items()):
            if label == 'docs':
                continue
            jobs.append(dict(id=index + 100, name=name, head_sha=source,
                             status=status if label == 'bench' else 'in_progress',
                             conclusion=conclusion if label == 'bench' else None,
                             steps=[]))
        docs = dict(id=200, name='roadmap_docs', head_sha=SOURCE,
                    status='completed', conclusion='success', steps=[])

        def api(path):
            if path == 'actions/runs/10/attempts/1/jobs?per_page=100&page=1':
                return json.dumps(dict(total_count=len(jobs), jobs=jobs)).encode()
            if path == 'actions/runs/10/artifacts?per_page=100&page=1':
                return b'{"total_count": 0, "artifacts": []}'
            if path == 'actions/jobs/200':
                return json.dumps(docs).encode()
            if path == 'actions/jobs/200/logs':
                return DOC_LOG
            if path == 'actions/jobs/108/logs':
                return log
            raise AssertionError(('unexpected API request', path))

        command = ['audit', '--run', '10', '--source', SOURCE, '--attempt', '1',
                   '--host', host, '--docs-job', '200', '--output', str(output)]
        # The mocked warnings/failures are test input, not repository diagnostics.
        # Keep exceptions visible while capturing this deliberately injected output.
        with patch.object(AUDIT, 'api', side_effect=api), patch('sys.argv', command), patch('sys.stdout', io.StringIO()):
            AUDIT.main()

    def test_complete_benchmark_and_documentation_controls_pass(self):
        for host in ('bench', 'docs'):
            with self.subTest(host=host), tempfile.TemporaryDirectory() as temporary:
                output = Path(temporary)
                self.run_audit(output, host, conclusion='success', status='completed',
                               source=SOURCE, log=b'normal output\n')
                report = json.loads((output / (host + '-audit.json')).read_text())
                self.assertEqual(report['source'], SOURCE)
                self.assertEqual(report['job']['conclusion'], 'success')
                self.assertEqual(json.loads((output / ('issues-' + host + '.json')).read_text()), [])

    def test_pending_failed_wrong_source_and_unexpected_diagnostics_fail(self):
        cases = [
            ('bench', 'success', 'in_progress', SOURCE, b'normal'),
            ('bench', 'failure', 'completed', SOURCE, b'normal'),
            ('bench', 'success', 'completed', 'b' * 40, b'normal'),
            ('bench', 'success', 'completed', SOURCE, b'warning: unexpected compiler diagnostic'),
            ('all', 'success', 'completed', SOURCE, b'normal'),
        ]
        for host, conclusion, status, source, log in cases:
            with self.subTest(case=(host, conclusion, status, source, log)), tempfile.TemporaryDirectory() as temporary:
                with self.assertRaises(AssertionError):
                    self.run_audit(Path(temporary), host, conclusion=conclusion,
                                   status=status, source=source, log=log)

    def test_native_image_headers_require_the_requested_architecture(self):
        for host, machine in [('arm', 183), ('amd', 62)]:
            image = bytearray(64)
            image[:6] = b'\x7fELF\x02\x01'
            image[18:20] = machine.to_bytes(2, 'little')
            self.assertTrue(FOCUSED.native_header(host, image))
            self.assertFalse(FOCUSED.native_header('amd' if host == 'arm' else 'arm', image))
            self.assertFalse(FOCUSED.native_header(host, image[:20]))
        image = bytearray(32)
        image[:4] = b'\xcf\xfa\xed\xfe'
        image[4:8] = (0x100000c).to_bytes(4, 'little')
        self.assertTrue(FOCUSED.native_header('mac', image))
        image[4:8] = (0x1000007).to_bytes(4, 'little')
        self.assertFalse(FOCUSED.native_header('mac', image))

    def test_error_warning_filter_preserves_real_errors(self):
        self.assertEqual(AUDIT.diagnostics(b'python -W error::ResourceWarning -m unittest'), [])
        self.assertEqual(len(AUDIT.diagnostics(b'error: bad\nwarning: unexpected\nTraceback')), 3)

    def test_paginated_listings_include_jobs_and_artifacts_beyond_first_page(self):
        for field in ('jobs', 'artifacts'):
            with self.subTest(field=field):
                expected = [dict(id=i) for i in range(128)]
                pages = [json.dumps(dict(total_count=128, **{field: batch})).encode()
                         for batch in (expected[:100], expected[100:])]
                with patch.object(AUDIT, 'api', side_effect=pages) as api:
                    self.assertEqual(records(AUDIT.api, 'actions/list', field), expected)
                self.assertEqual([call.args[0] for call in api.call_args_list], [
                    'actions/list?per_page=100&page=1', 'actions/list?per_page=100&page=2'])
        with patch.object(AUDIT, 'api', return_value=b'{"total_count":0,"jobs":[]}') as api:
            self.assertEqual(records(AUDIT.api, 'actions/list', 'jobs'), [])
            api.assert_called_once()

    def test_incomplete_duplicate_or_changing_listings_fail(self):
        first = dict(total_count=2, jobs=[dict(id=1)])
        for last in [
            dict(total_count=2, jobs=[]),
            dict(total_count=2, jobs=[dict(id=1)]),
            dict(total_count=3, jobs=[dict(id=2), dict(id=3)]),
            dict(total_count=2, jobs=[dict(id=2), dict(id=3)]),
        ]:
            with self.subTest(last=last), patch.object(AUDIT, 'api', side_effect=[
                json.dumps(first).encode(), json.dumps(last).encode()
            ]), self.assertRaises(AssertionError):
                records(AUDIT.api, 'actions/list', 'jobs')

    def test_focused_entry_audits_later_page_jobs_and_rejects_missing_targets(self):
        for group, target_count, defect in (('shared-storage', 25, ''), ('shared-storage', 24, ''),
                ('tape-records', 10, ''), ('tape-records', 9, ''), ('tape-records', 10, 'missing-wasm'),
                ('tape-records', 10, 'ignored-unit'), ('tape-records', 10, 'wrong-target')):
            with self.subTest(group=group, target_count=target_count, defect=defect), tempfile.TemporaryDirectory() as temporary:
                jobs = [dict(id=i, name='skipped control') for i in range(100)]
                artifacts, downloads, logs = [], {}, {}
                for index, (host, (name, runner)) in enumerate((FOCUSED.RECORD_HOSTS if group == 'tape-records' else FOCUSED.HOSTS).items()):
                    job_id, artifact_id = 200 + index, 300 + index
                    jobs.append(dict(id=job_id, name=name, head_sha=SOURCE,
                                     status='completed', conclusion='success', steps=[]))
                    image = bytearray(64)
                    if host == 'mac':
                        image[:4] = b'\xcf\xfa\xed\xfe'
                        image[4:8] = (0x100000c).to_bytes(4, 'little')
                    else:
                        image[:6] = b'\x7fELF\x02\x01'
                        image[18:20] = (183 if host == 'arm' else 62).to_bytes(2, 'little')
                    buffer = io.BytesIO()
                    with zipfile.ZipFile(buffer, 'w', zipfile.ZIP_DEFLATED) as archive:
                        archive.writestr('source.txt', SOURCE + '\n')
                        for target in range(target_count):
                            archive.writestr('targets/test-' + ('wrong' if defect == 'wrong-target' and target == 0 else FOCUSED.RECORD_TARGETS[target] if group == 'tape-records' else str(target)) + '.log',
                                            'test result: ok. 1 passed; 0 failed; 0 ignored;\n')
                        ignored = ''.join('test ' + name + ' ... ignored, separate measurement\n' for name in sorted(FOCUSED.UNIT_MEASUREMENTS))
                        archive.writestr('unit.log', ignored + 'test result: ok. 305 passed; 0 failed; ' + ('5' if defect == 'ignored-unit' else '4') + ' ignored; 0 measured; 0 filtered out; finished in 1s\n')
                        if host == 'arm' and defect != 'missing-wasm':
                            archive.writestr('wasm.log', 'test result: ok. 1 passed; 0 failed; 0 ignored;\n')
                        archive.writestr('owners/probe.exe', image)
                        archive.writestr('owners/probe.status', 'Some(0)\n')
                        archive.writestr('selection/packed-pair-selection.json', '[{}, {}, {}]')
                        archive.writestr('selection/gradient-call-selection.json', '{}')
                        archive.writestr('consuming-selection/record.json', '{}')
                    raw = buffer.getvalue()
                    artifact_name = ('tape-record-checks-' if group == 'tape-records' else 'gradient-call-checks-') + runner
                    artifacts.append(dict(id=artifact_id, name=artifact_name, expired=False,
                                          workflow_run=dict(head_sha=SOURCE),
                                          digest='sha256:' + hashlib.sha256(raw).hexdigest()))
                    downloads[f'repos/e6qu/fun-with-pipes/actions/artifacts/{artifact_id}/zip'] = raw
                    logs[f'actions/jobs/{job_id}/logs'] = (
                        f'Artifact {artifact_name} successfully finalized. Artifact ID {artifact_id}\n'.encode())

                def api(path):
                    if path.startswith('actions/runs/10/attempts/1/jobs?per_page=100&page='):
                        page = int(path.rsplit('=', 1)[1])
                        return json.dumps(dict(total_count=len(jobs), jobs=jobs[(page-1)*100:page*100])).encode()
                    if path == 'actions/runs/10/artifacts?per_page=100&page=1':
                        return json.dumps(dict(total_count=len(artifacts), artifacts=artifacts)).encode()
                    return logs[path]

                def download(command, *, stdout, check):
                    self.assertEqual(command[:3], ['gh', 'api', '--allow-escape-sequences'])
                    self.assertTrue(check)
                    stdout.write(downloads[command[3]])

                output = Path(temporary) / 'audit'
                command = ['audit', '--group', group, '--run', '10', '--source', SOURCE, '--attempt', '1',
                           '--output', str(output)]
                with patch.object(FOCUSED.PRODUCTION, 'api', side_effect=api), \
                        patch.object(FOCUSED.subprocess, 'run', side_effect=download), \
                        patch('sys.argv', command), patch('sys.stdout', io.StringIO()):
                    if target_count == (10 if group == 'tape-records' else 25) and not defect:
                        FOCUSED.main()
                    else:
                        with self.assertRaises(AssertionError):
                            FOCUSED.main()
                report = json.loads((output / 'summary.json').read_text())
                self.assertEqual(len(report['hosts']), 3)
                self.assertEqual(bool(report['issues']), target_count != (10 if group == 'tape-records' else 25) or bool(defect))
                self.assertEqual(len(json.loads((output / 'jobs.json').read_text())), 103)
                for host in FOCUSED.HOSTS:
                    with zipfile.ZipFile(output / (host + '-records.zip')) as retained:
                        self.assertEqual(retained.read('owners/probe.status'), b'Some(0)\n')
                        self.assertNotIn('owners/probe.exe', retained.namelist())


if __name__ == '__main__':
    unittest.main()
