#!/usr/bin/env python3
"""Check that diagnostic records cannot hide allocation or invent scan phases."""
import copy
import importlib.util
import json
from pathlib import Path
import subprocess
import unittest

SPEC = importlib.util.spec_from_file_location('storage_check', Path(__file__).with_name('check-unique-buffer-storage.py'))
STORAGE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(STORAGE)
SPEC = importlib.util.spec_from_file_location('phase_check', Path(__file__).with_name('check-unique-buffer-phases.py'))
PHASES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PHASES)


class ObserverControls(unittest.TestCase):
    def test_zero_storage_rejects_each_residual_cost(self):
        counts = dict(managed=dict(requests=0, requestedBytes=0, retains=0,
                                   peakChargedBytes=0, finalChargedBytes=0),
                      operations={'dup': dict(calls=0, effective=0, last=0)},
                      metadata=dict(allocationRequests=0, requestedCountBytes=0,
                                    initialCountBytes=0, finalCountBytes=0, peakCountBytes=0))
        STORAGE.check_counts(counts, 'scan', 'elided')
        for section, keys in [('managed', counts['managed']), ('metadata', counts['metadata'])]:
            for key in keys:
                with self.subTest(section=section, key=key):
                    changed = copy.deepcopy(counts)
                    changed[section][key] = 1
                    with self.assertRaises(AssertionError):
                        STORAGE.check_counts(changed, 'scan', 'elided')
        changed = copy.deepcopy(counts)
        for key in ['initialCountBytes', 'finalCountBytes', 'peakCountBytes']:
            changed['metadata'][key] = 1
        with self.assertRaises(AssertionError):
            STORAGE.check_counts(changed, 'scan', 'elided')
        changed = copy.deepcopy(counts)
        changed['operations']['dup']['calls'] = 1
        with self.assertRaises(AssertionError):
            STORAGE.check_counts(changed, 'scan', 'elided')
        with self.assertRaises(AssertionError):
            STORAGE.check_counts(counts, 'scan', 'materialized')

    def test_fused_scan_requires_its_actual_phase(self):
        event = dict(computationNs=10)
        result = subprocess.CompletedProcess([], 0, b'18\n', (json.dumps(event) + '\n').encode() * 3)
        PHASES.validate(result, 6, 3, {'computationNs'})
        for fields in [PHASES.FIELDS, set()]:
            with self.assertRaises(AssertionError):
                PHASES.validate(result, 6, 3, fields)
        for damaged in [dict(computationNs=-1), dict(computationNs=True),
                        dict(computationNs=10, releaseNs=0)]:
            result.stderr = (json.dumps(damaged) + '\n').encode() * 3
            with self.assertRaises(AssertionError):
                PHASES.validate(result, 6, 3, {'computationNs'})


if __name__ == '__main__':
    unittest.main()
