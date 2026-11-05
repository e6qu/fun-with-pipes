#!/usr/bin/env python3
"""Reject incomplete, wrong-source or diagnostically failing production gates."""
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location('audit', Path(__file__).with_name('audit-production-run.py'))
AUDIT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AUDIT)
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
            if path == 'actions/runs/10/attempts/1/jobs?per_page=100':
                return json.dumps(dict(jobs=jobs)).encode()
            if path == 'actions/runs/10/artifacts?per_page=100':
                return b'{"artifacts": []}'
            if path == 'actions/jobs/200':
                return json.dumps(docs).encode()
            if path == 'actions/jobs/200/logs':
                return DOC_LOG
            if path == 'actions/jobs/108/logs':
                return log
            raise AssertionError(('unexpected API request', path))

        command = ['audit', '--run', '10', '--source', SOURCE, '--attempt', '1',
                   '--host', host, '--docs-job', '200', '--output', str(output)]
        with patch.object(AUDIT, 'api', side_effect=api), patch('sys.argv', command):
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

    def test_error_warning_filter_preserves_real_errors(self):
        self.assertEqual(AUDIT.diagnostics(b'python -W error::ResourceWarning -m unittest'), [])
        self.assertEqual(len(AUDIT.diagnostics(b'error: bad\nwarning: unexpected\nTraceback')), 3)


if __name__ == '__main__':
    unittest.main()
