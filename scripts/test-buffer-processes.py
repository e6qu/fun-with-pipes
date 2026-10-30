#!/usr/bin/env python3
"""Exercise real child failures and retained-file damage without benchmarking."""
import base64
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location('buffer_runner', Path(__file__).with_name('measure-buffer-baselines.py'))
RUNNER = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(RUNNER)
SPEC = importlib.util.spec_from_file_location('buffer_check', Path(__file__).with_name('check-buffer-baselines.py'))
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)


class BufferProcesses(unittest.TestCase):
    def test_success_and_explicit_failure_preserve_both_streams(self):
        for code in [0, 7]:
            row = RUNNER.measure_process([sys.executable, '-c',
                f'import sys; print("out"); print("err", file=sys.stderr); sys.exit({code})'],
                dict(PATH=os.defpath), 5)
            self.assertEqual(row['status'], code)
            self.assertFalse(row['timedOut'])
            self.assertIsNone(row['spawnError'])
            self.assertEqual(base64.b64decode(row['stdoutBase64']), b'out\n')
            self.assertEqual(base64.b64decode(row['stderrBase64']), b'err\n')
            self.assertEqual(row['stdoutSha256'], hashlib.sha256(b'out\n').hexdigest())
            self.assertGreater(row['elapsedNs'], 0)
            self.assertGreaterEqual(row['userNs'] + row['systemNs'], 0)

    def test_timeout_retains_partial_output_and_reaps_child(self):
        row = RUNNER.measure_process([sys.executable, '-c',
            'import time; print("started", flush=True); time.sleep(60)'], dict(PATH=os.defpath), 0.5)
        self.assertTrue(row['timedOut'])
        self.assertLess(row['status'], 0)
        self.assertEqual(base64.b64decode(row['stdoutBase64']), b'started\n')
        self.assertLess(row['elapsedNs'], 5_000_000_000)

    def test_cancellation_reaps_child_and_returns_an_unsuccessful_record(self):
        communicate = RUNNER.subprocess.Popen.communicate
        calls = 0

        def interrupted_once(child, *args, **kwargs):
            nonlocal calls
            calls += 1
            if calls == 1:
                raise KeyboardInterrupt
            return communicate(child, *args, **kwargs)

        with patch.object(RUNNER.subprocess.Popen, 'communicate', interrupted_once):
            row = RUNNER.measure_process([sys.executable, '-c', 'import time; time.sleep(60)'],
                                         dict(PATH=os.defpath), 5)
        self.assertTrue(row['interrupted'])
        self.assertFalse(row['timedOut'])
        self.assertLess(row['status'], 0)
        self.assertEqual(calls, 2)

    def test_spawn_failure_is_retained_not_a_zero_time_success(self):
        with tempfile.TemporaryDirectory() as directory:
            row = RUNNER.measure_process([str(Path(directory) / 'absent')], dict(PATH=os.defpath), 5)
        self.assertIsNone(row['status'])
        self.assertIsNotNone(row['spawnError'])
        self.assertFalse(row['timedOut'])
        self.assertGreater(row['elapsedNs'], 0)

    def test_missing_changed_extra_and_symlink_evidence_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = root / 'observation'
            path.write_bytes(b'retained')
            manifest = dict(observation=dict(bytes=8, sha256=hashlib.sha256(b'retained').hexdigest()))
            (root / 'manifest.json').write_text(json.dumps(manifest))
            CHECK.check_manifest(root)
            path.write_bytes(b'changed!')
            with self.assertRaises(AssertionError):
                CHECK.check_manifest(root)
            path.unlink()
            with self.assertRaises(AssertionError):
                CHECK.check_manifest(root)
            path.write_bytes(b'retained')
            extra = root / 'extra'
            extra.write_bytes(b'')
            with self.assertRaises(AssertionError):
                CHECK.check_manifest(root)
            extra.unlink()
            extra.symlink_to(path)
            with self.assertRaises(AssertionError):
                CHECK.check_manifest(root)


if __name__ == '__main__':
    unittest.main()
