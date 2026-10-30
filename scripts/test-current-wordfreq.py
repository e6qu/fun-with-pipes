#!/usr/bin/env python3
"""Failed or timed-out children must leave complete, auditable observations."""
import base64
import importlib.util
import json
import os
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location('current_wordfreq', Path(__file__).with_name('measure-current-wordfreq.py'))
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)


class WordFrequencyObservations(unittest.TestCase):
    def test_nonzero_exit_keeps_both_raw_streams_before_rejection(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            stdin = root / 'input'
            stdin.write_bytes(b'')
            log = root / 'commands.jsonl'
            result = MEASURE.observe([sys.executable, '-c',
                'import sys\nsys.stdout.buffer.write(bytes([255]))\nsys.stderr.write("failure")\nsys.exit(7)'],
                stdin, dict(os.environ), 10, log, dict(phase='control', sequence=0))
            row = json.loads(log.read_text())
            self.assertEqual(row['status'], 7)
            self.assertFalse(row['timedOut'])
            self.assertEqual(base64.b64decode(row['stdoutBase64']), b'\xff')
            self.assertEqual(base64.b64decode(row['stderrBase64']), b'failure')
            with self.assertRaises(AssertionError):
                MEASURE.verify_result(result, b'\xff')

    def test_failed_launch_has_a_record_without_an_invented_exit_status(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            stdin = root / 'input'
            stdin.write_bytes(b'')
            log = root / 'commands.jsonl'
            result = MEASURE.observe([root / 'absent-executable'], stdin,
                dict(os.environ), 10, log, dict(phase='control', sequence=0))
            row = json.loads(log.read_text())
            self.assertIsNone(row['status'])
            self.assertTrue(row['spawnError'])
            with self.assertRaises(AssertionError):
                MEASURE.verify_result(result, b'')

    def test_cancellation_is_recorded_before_propagation(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            stdin = root / 'input'
            stdin.write_bytes(b'')
            log = root / 'commands.jsonl'
            with patch.object(MEASURE, 'communicate', side_effect=KeyboardInterrupt), self.assertRaises(KeyboardInterrupt):
                MEASURE.observe([sys.executable, '-c', 'import time; time.sleep(60)'],
                    stdin, dict(os.environ), 5, log, dict(phase='control', sequence=0))
            row = json.loads(log.read_text())
            self.assertEqual(row['interruption'], 'KeyboardInterrupt')
            self.assertLess(row['status'], 0)
            self.assertFalse(row['timedOut'])
            row['status'] = 0
            with self.assertRaises(AssertionError):
                MEASURE.verify_result((row, b'', b''), b'')

    def test_timeout_keeps_partial_output_and_reaps_the_child(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            stdin = root / 'input'
            stdin.write_bytes(b'')
            log = root / 'commands.jsonl'
            result = MEASURE.observe([sys.executable, '-c',
                'import time\nprint("started",flush=True)\ntime.sleep(60)'],
                stdin, dict(os.environ), 1, log, dict(phase='control', sequence=0))
            row = json.loads(log.read_text())
            self.assertTrue(row['timedOut'])
            self.assertEqual(row['status'], -9)
            self.assertEqual(base64.b64decode(row['stdoutBase64']), b'started\n')
            self.assertEqual(base64.b64decode(row['stderrBase64']), b'')
            with self.assertRaises(AssertionError):
                MEASURE.verify_result(result, b'started\n')


if __name__ == '__main__':
    unittest.main()
