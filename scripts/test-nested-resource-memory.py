#!/usr/bin/env python3
"""Check counter units and classification without claiming a sampled peak is exact."""
import json
import os
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch

from nested_resource_memory import categories, fast_counters, observe

STATUS = 'VmHWM: 16 kB\nVmRSS: 12 kB\nRssAnon: 4 kB\nRssFile: 8 kB\nRssShmem: 0 kB\n'


class Memory(unittest.TestCase):
    def test_fast_counter_units_and_missing_or_duplicate_fields(self):
        result = fast_counters(STATUS, '20 3 2 1 0 4 0', 4096)
        self.assertEqual(result['statmResidentKiB'], 12)
        self.assertEqual(result['VmHWMKiB'], 16)
        for text in (STATUS + 'VmRSS: 12 kB\n', STATUS.replace('RssAnon: 4 kB\n', ''), STATUS.replace('12 kB', '12 MB')):
            with self.assertRaises(AssertionError):
                fast_counters(text, '20 3 2 1 0 4 0', 4096)

    def test_empty_categories_keep_zero_totals(self):
        groups = categories([], Path('/program'))
        self.assertEqual(set(groups), {'heap', 'stack', 'executable', 'otherFiles', 'otherMappings'})
        self.assertTrue(all(value['residentKiB'] == 0 for value in groups.values()))

    @unittest.skipUnless(sys.platform == 'linux', 'stopped snapshots require Linux /proc')
    def test_snapshot_failure_reaps_stopped_child(self):
        with tempfile.TemporaryDirectory() as name:
            root = Path(name)
            with patch('nested_resource_memory.mappings', side_effect=ValueError('bad snapshot')):
                with self.assertRaisesRegex(ValueError, 'bad snapshot'):
                    observe([sys.executable, '-c', 'import time\ntime.sleep(10)\n'],
                            dict(os.environ), root / 'result', .05, 30, 600)
            record = json.loads((root / 'result/observation.json').read_text())
            self.assertIsNotNone(record['failure'])
            with self.assertRaises(ChildProcessError):
                os.waitpid(record['pid'], os.WNOHANG)

    @unittest.skipUnless(sys.platform == 'linux', 'stopped snapshots require Linux /proc')
    def test_actual_child_is_resumed_and_reaped(self):
        with tempfile.TemporaryDirectory() as name:
            row = observe([sys.executable, '-c', 'import time\ntime.sleep(.3)\nprint("done")\n'],
                          dict(os.environ), Path(name) / 'result', .05, 30, 600)
            self.assertEqual((row['status'], row['stdout'], row['stderr']), (0, 'done\n', ''))
            self.assertGreaterEqual(len(row['snapshots']), 2)
            self.assertTrue(all(s['metrics']['residentKiB'] > 0 for s in row['snapshots']))


if __name__ == '__main__':
    unittest.main()
