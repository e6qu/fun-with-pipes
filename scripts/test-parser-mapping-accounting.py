#!/usr/bin/env python3
"""Reject flag misclassification even when size and residency are correct."""
import hashlib
import json
from pathlib import Path
import tempfile
import unittest

from parser_mapping_accounting import check_accounting
from parser_process_memory import accounting, mappings, summary


def region(start, kib, name, permissions, resident, flags):
    return (f'{start:08x}-{start + kib * 1024:08x} {permissions} 00000000 00:00 0 {name}\n'
            f'Size: {kib} kB\nRss: {resident} kB\nPss: {resident} kB\nPrivate_Clean: 0 kB\n'
            f'Private_Dirty: {resident} kB\nAnonymous: {resident} kB\nSwap: 0 kB\nVmFlags: {flags}\n')


class Accounting(unittest.TestCase):
    def exercise(self, root, policy, reservation, wrong_flag):
        result = dict(status=0, stdout='{"control":1}\n', stderr='', snapshots=[])
        nr = reservation == 'no-reserve' and policy != 2
        for phase in range(5):
            raw = region(4096, 4, '[anon:other]', 'rw-p', 4, 'rd wr ac')
            if phase in (1, 2, 3):
                flags = 'mr mw nr' if nr else ('mr mw ac' if phase >= 2 else 'mr mw')
                if wrong_flag and phase == 2:
                    flags = flags.replace('nr', 'ac') if nr else flags.replace('ac', 'nr')
                raw += region(16777216, 16384, '[anon:fwp-parser-control]',
                              '---p' if phase == 1 else 'rw-p', 16384 if phase == 3 else 0, flags)
            path = root / f'phase-{phase}.smaps'
            path.write_text(raw)
            memory = mappings(raw)
            record = dict(phase=phase, file=path.name, sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                          metrics=summary(memory), accounting=accounting(memory))
            kernel = root / f'phase-{phase}.accounting.json'
            kernel.write_text(json.dumps(dict(kernel='test', policy=dict(overcommit_memory=policy,
                overcommit_ratio=50, overcommit_kbytes=0), system=dict(CommitLimitKiB=100000, Committed_ASKiB=20000))))
            record.update(kernelAccountingFile=kernel.name, kernelAccountingSha256=hashlib.sha256(kernel.read_bytes()).hexdigest())
            result['snapshots'].append(record)
        return check_accounting(result, root, reservation)

    def test_each_policy_and_reservation(self):
        with tempfile.TemporaryDirectory() as temp:
            for policy in (0, 1, 2):
                for reservation in ('accounted', 'no-reserve'):
                    with self.subTest(policy=policy, reservation=reservation):
                        result = self.exercise(Path(temp), policy, reservation, False)
                        self.assertEqual(result['noReserveObserved'], reservation == 'no-reserve' and policy != 2)

    def test_incorrect_flags_with_correct_size_and_residency(self):
        with tempfile.TemporaryDirectory() as temp:
            for policy in (0, 1, 2):
                for reservation in ('accounted', 'no-reserve'):
                    with self.subTest(policy=policy, reservation=reservation), self.assertRaises(AssertionError):
                        self.exercise(Path(temp), policy, reservation, True)


if __name__ == '__main__':
    unittest.main()
