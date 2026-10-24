#!/usr/bin/env python3
"""Check build deadlines, process cleanup and failure records without a full build."""

import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('output', ROOT / 'scripts/measure-descent-output.py')
OUTPUT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(OUTPUT)


class BuildChecks(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix='fwp-build-controls-')
        self.addCleanup(self.temporary.cleanup)
        self.directory = Path(self.temporary.name)
        self.commands = []
        self.environment = dict(os.environ)

    def test_success_records_wall_time_and_explicit_deadline(self):
        OUTPUT.build([sys.executable, '-c', 'print("compiled")'], self.environment,
                     5, self.commands, self.directory)
        row, = json.loads((self.directory / 'build-commands.json').read_text())
        self.assertEqual(row, self.commands[0])
        self.assertEqual(row['stdout'], 'compiled\n')
        self.assertEqual(row['returncode'], 0)
        self.assertEqual(row['timeoutSeconds'], 5)
        self.assertGreater(row['elapsedNs'], 0)
        self.assertIsNone(row['failure'])

    def test_failed_build_keeps_diagnostics(self):
        with self.assertRaises(subprocess.CalledProcessError) as caught:
            OUTPUT.build([sys.executable, '-c', 'import sys\nsys.stderr.write("bad source\\n")\nsys.exit(7)'],
                         self.environment, 5, self.commands, self.directory)
        self.assertEqual(caught.exception.returncode, 7)
        row, = json.loads((self.directory / 'build-commands.json').read_text())
        self.assertEqual(row['returncode'], 7)
        self.assertEqual(row['stderr'], 'bad source\n')

    def test_missing_compiler_is_recorded(self):
        with self.assertRaises(FileNotFoundError):
            OUTPUT.build([self.directory / 'missing'], self.environment,
                         5, self.commands, self.directory)
        row, = json.loads((self.directory / 'build-commands.json').read_text())
        self.assertEqual(row['failure'], 'FileNotFoundError')
        self.assertIsNone(row['returncode'])

    def test_timeout_stops_compiler_children(self):
        source = ('import subprocess, sys, time\n'
                  'child = subprocess.Popen([sys.executable, "-c", "import time; time.sleep(60)"])\n'
                  'print(child.pid, flush=True)\n'
                  'time.sleep(60)\n')
        with self.assertRaises(subprocess.TimeoutExpired):
            OUTPUT.build([sys.executable, '-c', source], self.environment,
                         1, self.commands, self.directory)
        row, = json.loads((self.directory / 'build-commands.json').read_text())
        self.assertEqual(row['failure'], 'TimeoutExpired')
        self.assertLess(row['returncode'], 0)
        child = int(row['stdout'].strip())
        status = subprocess.run(['ps', '-o', 'stat=', '-p', str(child)],
                                capture_output=True, text=True, timeout=5)
        # A terminated orphan may await reaping briefly; it must not keep running.
        self.assertTrue(not status.stdout.strip() or status.stdout.strip().startswith('Z'), status)


if __name__ == '__main__':
    unittest.main()
