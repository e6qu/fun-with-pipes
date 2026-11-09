#!/usr/bin/env python3
"""Check mapping units/structure and cleanup of failed checkpoint children."""
import importlib.util
import json
import os
from pathlib import Path
import sys
import tempfile
import unittest

from parser_process_memory import accounting, check_kernel_accounting, checkpoint_process, mappings, summary

SPEC = importlib.util.spec_from_file_location('parser_memory_collector', Path(__file__).with_name('measure-parser-process-memory.py'))
COLLECTOR = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COLLECTOR)

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
    def test_kernel_policy_and_system_quantities(self):
        record = dict(kernel='test', policy=dict(overcommit_memory=0, overcommit_ratio=50,
            overcommit_kbytes=0), system=dict(CommitLimitKiB=1000, Committed_ASKiB=2000))
        # System commitments may exceed the limit in the host's existing policy.
        check_kernel_accounting(record)
        for key, value in (('overcommit_memory', 9), ('overcommit_memory', True),
                           ('overcommit_ratio', -1), ('overcommit_kbytes', '0')):
            with self.subTest(key=key, value=value), self.assertRaises(AssertionError):
                check_kernel_accounting(record | {'policy': record['policy'] | {key: value}})
        for value in (-1, False, 1.5, '1000'):
            with self.subTest(value=value), self.assertRaises(AssertionError):
                check_kernel_accounting(record | {'system': record['system'] | {'CommitLimitKiB': value}})

    def test_reservation_is_not_residency(self):
        self.assertEqual(summary(mappings(SNAPSHOT)), dict(mappedKiB=12, residentKiB=4,
            proportionalKiB=4, privateKiB=4, anonymousKiB=4, swapKiB=0, noAccessKiB=8))

    def test_accounting_is_separate_from_residency(self):
        self.assertEqual(accounting(mappings(SNAPSHOT)), dict(accountableMappingKiB=4, noReserveMappingKiB=0))
        no_reserve = SNAPSHOT.replace('me ac sd', 'me nr sd')
        self.assertEqual(accounting(mappings(no_reserve)), dict(accountableMappingKiB=0, noReserveMappingKiB=4))

    def test_malformed_or_incomplete_snapshot(self):
        for source in ('', SNAPSHOT.replace('VmFlags: mr mw me sd\n', ''),
                       SNAPSHOT.replace('VmFlags: mr mw me sd', 'VmFlags: mr mw me sd\nVmFlags: mr'),
                       SNAPSHOT.replace('me ac sd', 'me ac ac sd'), SNAPSHOT.replace('Rss: 4 kB', 'Rss: 4 MB'),
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

    def test_missing_first_checkpoint_times_out_and_reaps_child(self):
        self.check_child('time.sleep(10)\n', TimeoutError)

    @unittest.skipUnless(sys.platform == 'linux', 'actual stopped-process snapshots require Linux /proc')
    def test_missing_next_checkpoint_times_out_and_reaps_child(self):
        self.check_child('os.write(1, b"0\\n")\nos.kill(os.getpid(), signal.SIGSTOP)\nos.read(0, 1)\ntime.sleep(10)\n', TimeoutError)


class ParserResults(unittest.TestCase):
    def test_exact_integer_result(self):
        row = dict(status=0, stderr='', stdout='{"result":1,"rounds":1,"observedNodes":1}\n')
        COLLECTOR.result_value(row, 'fwp', 1, 1, True)

    def test_bad_counts_and_duplicate_keys_are_rejected(self):
        outputs = ('{"result":true,"rounds":1,"observedNodes":1}\n',
                   '{"result":1,"rounds":1,"observedNodes":true}\n',
                   '{"result":0,"result":1,"rounds":1,"observedNodes":1}\n',
                   '{"result":1,"rounds":1,"observedNodes":2}\n',
                   '{"result":1,"rounds":1}\n', 'null\n',
                   '["result","rounds","observedNodes"]\n')
        for output in outputs:
            with self.subTest(output=output), self.assertRaises(ValueError):
                COLLECTOR.result_value(dict(status=0, stderr='', stdout=output), 'fwp', 1, 1, True)

    def test_native_duration_totals_must_agree(self):
        value = dict(rounds=1, result=-1, nodes=1, tokenizeNs=10, constructNs=20,
                     walkAndReleaseNs=30, releaseNs=5, totalNs=60,
                     nodeCapacityBytes=192, tokenCapacityBytes=128, allocations=2, nodeSize=24)
        def check(record):
            COLLECTOR.result_value(dict(status=0, stderr='', stdout=json.dumps(record, separators=(',', ':')) + '\n'),
                                   'c', -1, 1, False)
        check(value)
        for changes in ({'totalNs': 61}, {'releaseNs': 31}, {'nodeCapacityBytes': -1}):
            with self.subTest(changes=changes), self.assertRaises(ValueError):
                check(value | changes)


if __name__ == '__main__':
    unittest.main()
