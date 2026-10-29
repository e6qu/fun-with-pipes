#!/usr/bin/env python3
"""Reject unsafe observation placement and corrupted diagnostic outputs."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('timing_diagnostic', Path(__file__).with_name('diagnose-timing-variation.py'))
DIAGNOSTIC = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(DIAGNOSTIC)


class TimingDiagnostic(unittest.TestCase):
    def test_inputs_are_observed_before_transfer_and_output_before_release(self):
        harness = (DIAGNOSTIC.ROOT / 'tests/fixtures/numerical_bench_native.c').read_text()
        source = 'typedef uint64_t V;\n' + harness
        observed = DIAGNOSTIC.layout_source(source)
        call = observed.index('V result=fBENCH_ENTRY(b,a);')
        self.assertLess(observed.index('diag_left=(uintptr_t)fwp_array_data(left)'), call)
        self.assertLess(observed.index('diag_right=(uintptr_t)fwp_array_data(right)'), call)
        self.assertNotIn('fwp_array_data(left)', observed[call:])
        self.assertNotIn('fwp_array_data(right)', observed[call:])
        self.assertLess(call, observed.index('fwp_array_data(result)'))
        self.assertLess(observed.index('fwp_array_data(result)'), observed.index('fwp_rc_free_arr(result)'))
        self.assertEqual(observed.count('#include <sched.h>'), 1)

    def test_changed_or_duplicated_boundaries_are_rejected(self):
        declaration = 'typedef uint64_t V;\n'
        call = '__asm__ volatile("" : "+r"(a), "+r"(b) :: "memory");V result=entry(b,a);'
        for source in [call, declaration * 2 + call, declaration, declaration + call * 2]:
            with self.subTest(source=source), self.assertRaises(AssertionError):
                DIAGNOSTIC.layout_source(source)

    def test_wrong_values_live_owners_and_invalid_durations_are_rejected(self):
        for label, live in [('c', 'livePayloadBytes'), ('fwp', 'liveChargedBytes')]:
            good = {'samples': [dict(hash='abcd', kernelNs=10, allocationInclusiveNs=20, **{live: 0})] * 5}
            self.assertEqual(len(DIAGNOSTIC.validate_kernel(json.dumps(good), 'abcd', label)), 5)
            for field, value in [('hash', 'wrong'), (live, 1), ('kernelNs', 0),
                                 ('kernelNs', True), ('kernelNs', 0.5), ('allocationInclusiveNs', 9)]:
                bad = copy.deepcopy(good)
                bad['samples'][0][field] = value
                with self.subTest(label=label, field=field, value=value), self.assertRaises(AssertionError):
                    DIAGNOSTIC.validate_kernel(json.dumps(bad), 'abcd', label)
            with self.assertRaises(AssertionError):
                DIAGNOSTIC.validate_kernel(json.dumps({'samples': good['samples'][:4]}), 'abcd', label)
            with self.assertRaises(KeyError):
                DIAGNOSTIC.validate_kernel(json.dumps(good), 'abcd', 'fwp' if label == 'c' else 'c')


if __name__ == '__main__':
    unittest.main()
