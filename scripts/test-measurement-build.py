#!/usr/bin/env python3
"""Check build deadlines, process cleanup and failure records without a full build."""

import importlib.util
import json
import os
from pathlib import Path
import signal
import subprocess
import sys
import tempfile
import time
import unittest
from unittest.mock import patch

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

    def test_failed_compiler_stops_children_with_closed_output_pipes(self):
        source = ('import subprocess, sys\n'
                  'child = subprocess.Popen([sys.executable, "-c", "import time; time.sleep(60)"],\n'
                  '                         stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)\n'
                  'print(child.pid, flush=True)\n'
                  'sys.stderr.write("bad source\\n")\n'
                  'sys.exit(7)\n')
        with self.assertRaises(subprocess.CalledProcessError) as caught:
            OUTPUT.build([sys.executable, '-c', source], self.environment,
                         5, self.commands, self.directory)
        row, = json.loads((self.directory / 'build-commands.json').read_text())
        child = int(row['stdout'].strip())
        try:
            self.assertEqual(caught.exception.returncode, 7)
            self.assertEqual(row['returncode'], 7)
            self.assertEqual(row['stderr'], 'bad source\n')
            # A killed orphan may briefly remain as a zombie awaiting reaping.
            deadline = time.monotonic() + 1
            while True:
                status = subprocess.run(['ps', '-o', 'stat=', '-p', str(child)],
                                        capture_output=True, text=True, timeout=5)
                if not status.stdout.strip() or status.stdout.strip().startswith('Z'):
                    break
                if time.monotonic() >= deadline:
                    self.fail(f'Compiler child is still running: {status.stdout}')
                time.sleep(0.01)
            self.assertEqual(row['failure'], 'CalledProcessError')
        finally:
            # Keep the negative control safe when tested against the old code.
            try:
                os.kill(child, signal.SIGKILL)
            except ProcessLookupError:
                pass

    def test_missing_compiler_is_recorded(self):
        with self.assertRaises(FileNotFoundError):
            OUTPUT.build([self.directory / 'missing'], self.environment,
                         5, self.commands, self.directory)
        row, = json.loads((self.directory / 'build-commands.json').read_text())
        self.assertEqual(row['failure'], 'FileNotFoundError')
        self.assertIsNone(row['returncode'])

    def test_failed_workload_keeps_environment_and_source_identity(self):
        compiler = self.directory / 'failing-compiler'
        values = OUTPUT.BATCHES.PEERS.AD.analytic(33, 200)
        compiler.write_text(
            f'#!{sys.executable}\nimport sys\n'
            'if sys.argv[1] == "build":\n'
            '    sys.stderr.write("intentional build failure\\n")\n'
            '    sys.exit(7)\n'
            f'print({json.dumps(values)!r})\n')
        compiler.chmod(0o700)
        destination = self.directory / 'measurement'
        arguments = ['measure-descent-output.py', '--ar', 'ar', '--compiler', str(compiler),
                     '--output', str(destination), '--host', 'fixture-host',
                     '--cc', 'fixture-cc', '--rustc', 'fixture-rustc',
                     '--c-arch', 'armv8-a', '--objdump', 'unused-objdump',
                     '--nm', 'unused-nm', '--time', 'unused-time',
                     '--samples', '8', '--warmups', '1', '--order-seed', '1',
                     '--timeout', '5', '--build-timeout', '5',
                     '--control-max-difference', '0.02', '--case', '33:199:1']
        real_run = OUTPUT.run_capture

        def run(command, **kwargs):
            replies = {'lscpu': b'fixture CPU\n', 'fixture-cc': b'fixture C compiler\n',
                       'fixture-rustc': b'fixture Rust compiler\n'}
            if command[0] in replies:
                return subprocess.CompletedProcess(command, 0, replies[command[0]], b'')
            return real_run(command, **kwargs)

        with patch.object(sys, 'argv', arguments), \
                patch.object(OUTPUT.platform, 'system', return_value='Linux'), \
                patch.object(OUTPUT.platform, 'machine', return_value='aarch64'), \
                patch.object(OUTPUT, 'run_capture', side_effect=run):
            with self.assertRaises(subprocess.CalledProcessError) as caught:
                OUTPUT.main()
        self.assertEqual(caught.exception.returncode, 7)
        metadata = json.loads((destination / 'environment.json').read_text())
        self.assertEqual(metadata['source'], subprocess.check_output(
            ['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip())
        self.assertEqual(metadata['host'], 'fixture-host')
        self.assertEqual(metadata['cpu'], 'fixture CPU\n')
        self.assertEqual(metadata['cCompiler'], 'fixture C compiler\n')
        self.assertEqual(metadata['rustCompiler'], 'fixture Rust compiler\n')
        self.assertEqual(metadata['compilerSha256'], OUTPUT.digest(compiler.read_bytes()))
        self.assertEqual(metadata['sourceHashes']['scripts/measure-descent-output.py'],
                         OUTPUT.digest((ROOT / 'scripts/measure-descent-output.py').read_bytes()))
        self.assertEqual(metadata['configuration']['case'], ['33:199:1'])
        self.assertEqual(metadata['settings']['FWP_ARRAY_FUSION'], '1')
        row, = json.loads((destination / 'build-commands.json').read_text())
        self.assertEqual(row['returncode'], 7)
        self.assertEqual(row['stderr'], 'intentional build failure\n')
        self.assertFalse((destination / 'comparison.json').exists())

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
