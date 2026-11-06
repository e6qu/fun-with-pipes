#!/usr/bin/env python3
"""Reject corrupted downloads and distinguish host rejection from a measured failure."""
import copy
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
import zipfile

SPEC = importlib.util.spec_from_file_location('retain', Path(__file__).with_name('retain-derivative-evidence.py'))
RETAIN = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(RETAIN)


class RetainedEvidence(unittest.TestCase):
    def test_declared_layout_jobs_retain_rejections_before_any_measurement(self):
        source = '1' * 40
        host = dict(source=source, actual=dict(machine='x86_64'), qualified=False,
                    failures=['CPU differs from the frozen protocol'])
        stream = io.BytesIO()
        with zipfile.ZipFile(stream, 'w') as archive:
            archive.writestr('descent-host.json', json.dumps(host))
        blob = stream.getvalue()
        artifacts = [dict(id=4, name='descent-host-ubuntu-latest-1', expired=False,
                          workflow_run=dict(head_sha=source),
                          digest='sha256:' + hashlib.sha256(blob).hexdigest())]
        for protocol, name in [('recording-context', 'descent_peers (1, ubuntu-latest)'),
                               ('tape-records', 'tape_measurements / descent_peers (1, ubuntu-latest)')]:
            job = dict(id=3, name=name, status='completed', conclusion='failure', head_sha=source,
                       run_id=1, steps=[dict(name='Qualify the native host before building', conclusion='failure')])
            with tempfile.TemporaryDirectory() as directory, patch.object(RETAIN, 'api', side_effect=[b'host rejected\n', blob]) as api:
                root = Path(directory)
                summary = root / 'summary'
                summary.mkdir()
                label, record = RETAIN.retain_session('repos/test/repo', 1, source, job, artifacts, root, summary, protocol)
                self.assertEqual(label, 'x86_64-1')
                self.assertEqual(record['decision'], 'host-rejected-before-building-or-timing')
                self.assertEqual(api.call_count, 2)
                with self.assertRaises(AssertionError):
                    RETAIN.retain_session('repos/test/repo', 1, source, dict(job, name='unrelated job'), artifacts, root, summary, protocol)

    def test_download_digest_is_checked_before_extraction(self):
        stream = io.BytesIO()
        with zipfile.ZipFile(stream, 'w') as archive:
            archive.writestr('result/output', b'123\n')
        data = stream.getvalue()
        metadata = dict(digest='sha256:' + hashlib.sha256(data).hexdigest())
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            RETAIN.unpack(data, metadata, root / 'valid')
            self.assertEqual((root / 'valid/result/output').read_bytes(), b'123\n')
            with self.assertRaises(AssertionError):
                RETAIN.unpack(data + b'changed', metadata, root / 'invalid')
            self.assertFalse((root / 'invalid').exists())

    def test_a_valid_digest_does_not_allow_an_escaping_path(self):
        stream = io.BytesIO()
        with zipfile.ZipFile(stream, 'w') as archive:
            archive.writestr('../outside', b'not evidence')
        data = stream.getvalue()
        with tempfile.TemporaryDirectory() as directory, self.assertRaises(AssertionError):
            RETAIN.unpack(data, dict(digest='sha256:' + hashlib.sha256(data).hexdigest()), Path(directory))

    def test_rejected_host_must_stop_before_building_and_measurement(self):
        host = dict(qualified=False, failures=['CPU differs from the frozen protocol'])
        job = dict(conclusion='failure', steps=[
            dict(name='Qualify the native host before building', conclusion='failure'),
            dict(name='Run cargo build --locked --release --bin fwp', conclusion='skipped'),
            dict(name='Compare the candidate with its same-source reference', conclusion='skipped')])
        RETAIN.rejected_host(job, host)
        for index in (1, 2):
            changed = copy.deepcopy(job)
            changed['steps'][index]['conclusion'] = 'success'
            with self.assertRaises(AssertionError):
                RETAIN.rejected_host(changed, host)
        for field, value in [('qualified', True), ('failures', [])]:
            changed = dict(host, **{field: value})
            with self.assertRaises(AssertionError):
                RETAIN.rejected_host(job, changed)
        changed = copy.deepcopy(job)
        changed['steps'][0]['name'] = 'A different failure'
        with self.assertRaises(AssertionError):
            RETAIN.rejected_host(changed, host)


if __name__ == '__main__':
    unittest.main()
