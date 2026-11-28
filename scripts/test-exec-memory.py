#!/usr/bin/env python3
"""Exercise actual tracees, transient pages, exec accounting and failure cleanup."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from exec_memory import observe

ROOT = Path(__file__).resolve().parent.parent


class ExecMemory(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temporary = tempfile.TemporaryDirectory()
        cls.root = Path(cls.temporary.name)
        cls.launcher = cls.root / 'launcher'
        cls.control = cls.root / 'control'
        for source, output in (('exec_memory_launch.c', cls.launcher), ('exec_memory_control.c', cls.control)):
            subprocess.run(['gcc', '-std=gnu11', '-O2', '-Wall', '-Wextra', '-Werror',
                            str(ROOT / 'tests/fixtures' / source), '-o', str(output)], check=True)

    @classmethod
    def tearDownClass(cls):
        cls.temporary.cleanup()

    def run_control(self, mode, *, timeout=5):
        folder = self.root / self.id().split('.')[-1]
        rss = folder.with_suffix('.rss')
        record = observe(self.launcher, ['/usr/bin/time', '-f', '%M', '-o', rss, self.control, mode],
                         dict(os.environ), folder, timeout)
        return record, int(rss.read_text()), folder

    def target_exit(self, row):
        event, = [event for event in row['events'] if event['pid'] == row['target'] and event['kind'] == 'exit-stop']
        return event['snapshot']

    def test_transient_peak_survives_unmap(self):
        row, rss, folder = self.run_control('transient')
        final = self.target_exit(row)
        self.assertGreater(final['fast']['VmHWMKiB'], 30 * 1024)
        self.assertLess(final['metrics']['residentKiB'], 8 * 1024)
        self.assertGreater(rss, 30 * 1024)
        self.assertEqual(rss, [event for event in row['events']
                              if event['pid'] == row['target'] and event['kind'] == 'reaped'][0]['wait4PeakRssKiB'])
        self.assertTrue((folder / 'stdout.txt').read_text().startswith('control-peak-kib\t'))

    def test_untouched_reservation_is_not_resident(self):
        row, rss, _ = self.run_control('untouched')
        self.assertLess(self.target_exit(row)['fast']['VmHWMKiB'], 8 * 1024)
        self.assertLess(rss, 8 * 1024)

    def test_exec_replaces_mm_but_keeps_whole_child_usage(self):
        row, rss, _ = self.run_control('exec')
        final = self.target_exit(row)
        self.assertLess(final['fast']['VmHWMKiB'], 8 * 1024)
        self.assertGreater(rss, 30 * 1024)
        execs = [event for event in row['events'] if event['pid'] == row['target'] and event['kind'] == 'exec']
        self.assertEqual(len(execs), 2)
        self.assertEqual(Path(execs[-1]['snapshot']['executable']).name, 'true')

    def assert_reaped(self, folder):
        row = json.loads((folder / 'observation.json').read_text())
        self.assertTrue(row['failure'])
        self.assertFalse(row.get('unreaped'))
        for pid in row['known']:
            with self.assertRaises(ChildProcessError):
                os.waitpid(pid, os.WNOHANG)

    def test_deadline_kills_and_reaps(self):
        with self.assertRaisesRegex(AssertionError, 'exec memory deadline'):
            self.run_control('sleep', timeout=.2)
        self.assert_reaped(self.root / self.id().split('.')[-1])

    def test_extra_process_is_rejected_and_reaped(self):
        with self.assertRaisesRegex(AssertionError, 'unexpected process or thread'):
            self.run_control('fork')
        self.assert_reaped(self.root / self.id().split('.')[-1])

    def test_signals_are_delivered_and_failure_is_rejected(self):
        with self.assertRaisesRegex(AssertionError, 'launcher or timed process failed'):
            self.run_control('signal')
        self.assert_reaped(self.root / self.id().split('.')[-1])

    def test_snapshot_failure_reaps_stopped_process(self):
        with patch('exec_memory.snapshot', side_effect=ValueError('damaged snapshot')):
            with self.assertRaisesRegex(ValueError, 'damaged snapshot'):
                self.run_control('sleep')
        self.assert_reaped(self.root / self.id().split('.')[-1])


if __name__ == '__main__':
    unittest.main()
