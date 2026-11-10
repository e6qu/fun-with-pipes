#!/usr/bin/env python3
"""Verify that warmup, late responses, failed requests and malformed receipts count correctly."""
import copy
import gzip
import importlib.util
import json
from pathlib import Path
import struct
import tempfile
import threading
from types import SimpleNamespace
import unittest
from unittest.mock import patch

from http_load import BODY, REQUEST, ROW, audit, response_ok

SPEC = importlib.util.spec_from_file_location('measure_http_load', Path(__file__).with_name('measure-http-load.py'))
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)

WIRE = b'HTTP/1.1 200 OK\r\ncontent-length: ' + str(len(BODY)).encode() + b'\r\n\r\n' + BODY


class HttpLoadTests(unittest.TestCase):
    def test_sampling_failures_are_reported(self):
        stopping = threading.Event()
        stopping.set()  # One sample; no sleep or native workload.
        child = SimpleNamespace(pid=123)
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory)
            errors = []
            MEASURE.sample_processes(child, child, path / 'missing' / 'log', stopping, errors)
            self.assertEqual(len(errors), 1)
            self.assertIn('process sampling failed:', errors[0])
            for fault in (ValueError('invalid stat'), PermissionError('denied')):
                with self.subTest(fault=type(fault).__name__):
                    errors = []
                    with patch.object(MEASURE, 'process_sample', side_effect=fault):
                        MEASURE.sample_processes(child, child, path / 'log', stopping, errors)
                    self.assertTrue(errors)
            errors = []
            with patch.object(MEASURE, 'process_sample', side_effect=FileNotFoundError('exited')):
                MEASURE.sample_processes(child, child, path / 'log', stopping, errors)
            self.assertEqual(errors, [])
            row = json.loads((path / 'log').read_text())
            self.assertIsNone(row['server'])
            self.assertIsNone(row['generator'])

    def test_response_bytes(self):
        self.assertTrue(response_ok(WIRE))
        for invalid in [WIRE + b'x', WIRE[:-1], WIRE.replace(b'200', b'404'),
                        WIRE.replace(b'content-length:', b'transfer-encoding:'),
                        WIRE.replace(b'\r\n\r\n', b'\r\ncontent-length: 26\r\n\r\n')]:
            self.assertFalse(response_ok(invalid))

    def test_all_attempts_and_late_completion(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory)
            (path / 'request.bin').write_bytes(REQUEST)
            rows = [(0, 20, len(REQUEST), len(WIRE), 0, 0),
                    (100, 150, len(REQUEST), len(WIRE), 0, 0),
                    (190, 210, len(REQUEST), len(WIRE), 0, 0)]
            # A different connection fails while the last success finishes late.
            (path / 'worker-1.wire').write_bytes(struct.pack('<I', 0))
            (path / 'worker-1.bin').write_bytes(ROW.pack(160, 220, len(REQUEST), 0, 1, 0))
            (path / 'worker-0.wire').write_bytes(struct.pack('<I', len(WIRE)) + WIRE)
            raw = b''.join(ROW.pack(*row) for row in rows)
            (path / 'worker-0.bin').write_bytes(raw)
            header = dict(warmupNs=100, durationNs=100, deadlineNs=100, connections=2,
                          attempts=4, failures=1, setupErrors=0)
            report = audit(path, header, False)
            self.assertEqual((report['warmupAttempts'], report['measuredAttempts']), (1, 3))
            self.assertEqual((report['correctInWindow'], report['correctLate'], report['measuredFailures']), (1, 1, 1))
            self.assertEqual(report['failureFraction'], 1 / 3)
            self.assertEqual(report['completedPerSecond'], 1e7)
            self.assertEqual(report['timeToResponseOrFailure']['p99Ms'], 60 / 1e6)
            for worker in range(2):
                raw_path = path / f'worker-{worker}.bin'
                raw_path.with_suffix('.bin.gz').write_bytes(gzip.compress(raw_path.read_bytes()))
            self.assertEqual(audit(path, header, True), report)
            for label, changed in [('truncated', raw[:-1]),
                                   ('wrong count', raw + raw[-ROW.size:]),
                                   ('wrong wire', ROW.pack(0, 20, len(REQUEST), len(WIRE), 0, 9) + raw[ROW.size:])]:
                with self.subTest(label=label):
                    (path / 'worker-0.bin').write_bytes(changed)
                    with self.assertRaises(AssertionError):
                        audit(path, header, False)
            (path / 'worker-0.bin').write_bytes(raw)
            invalid = copy.deepcopy(header)
            invalid['attempts'] += 1
            with self.assertRaises(AssertionError):
                audit(path, invalid, False)


if __name__ == '__main__':
    unittest.main()
