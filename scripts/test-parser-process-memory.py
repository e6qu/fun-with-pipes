#!/usr/bin/env python3
"""Check mapping units/structure and cleanup of failed checkpoint children."""
import os
from pathlib import Path
import sys
import tempfile
import unittest

from parser_process_memory import checkpoint_process, mappings, summary

SNAPSHOT = '''00001000-00002000 rw-p 00000000 00:00 0 [anon:sample]
Size: 4 kB
Rss: 4 kB
Pss: 4 kB
Private_Clean: 0 kB
Private_Dirty: 4 kB
Anonymous: 4 kB
Swap: 0 kB
VmFlags: rd wr mr mw me ac sd
00004000-00006000 ---p 00000000 00:00 0
Size: 8 kB
Rss: 0 kB
Pss: 0 kB
Private_Clean: 0 kB
Private_Dirty: 0 kB
Anonymous: 0 kB
Swap: 0 kB
VmFlags: mr mw me sd
'''


class MappingReader(unittest.TestCase):
    def test_reservation_is_not_residency(self):
        self.assertEqual(summary(mappings(SNAPSHOT)), dict(mappedKiB=12, residentKiB=4,
            proportionalKiB=4, privateKiB=4, anonymousKiB=4, swapKiB=0, noAccessKiB=8))

    def test_malformed_or_incomplete_snapshot(self):
        for source in ('', SNAPSHOT.replace('Rss: 4 kB', 'Rss: 4 MB'),
                       SNAPSHOT.replace('Size: 4 kB', 'Size: 5 kB'),
                       SNAPSHOT.replace('Swap: 0 kB\n', '', 1),
                       SNAPSHOT.replace('Rss: 4 kB', 'Rss: 4 kB\nRss: 4 kB'),
                       SNAPSHOT.replace('00004000-00006000', '00001000-00003000')):
            with self.subTest(source=source):
                with self.assertRaises(ValueError):
                    mappings(source)

    def check_child(self, body, exception):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            pid_file = root / 'pid.txt'
            source = ('import os\nimport signal\nimport sys\nimport time\n'
                      'from pathlib import Path\n'
                      'Path(sys.argv[1]).write_text(str(os.getpid()))\n' + body)
            with self.assertRaises(exception):
                checkpoint_process([sys.executable, '-c', source, str(pid_file)],
                                   dict(os.environ), root / 'observation', 5, 2)
            pid = int(pid_file.read_text())
            with self.assertRaises(ChildProcessError):
                os.waitpid(pid, os.WNOHANG)

    def test_wrong_checkpoint_reaps_stopped_child(self):
        self.check_child('os.write(1, b"1\\n")\nos.kill(os.getpid(), signal.SIGSTOP)\ntime.sleep(10)\n', ValueError)

    def test_premature_exit_is_not_a_snapshot(self):
        self.check_child('sys.exit(7)\n', ValueError)

    def test_missing_next_checkpoint_times_out_and_reaps_child(self):
        self.check_child('os.write(1, b"0\\n")\nos.kill(os.getpid(), signal.SIGSTOP)\nos.read(0, 1)\ntime.sleep(10)\n', TimeoutError)


if __name__ == '__main__':
    unittest.main()
