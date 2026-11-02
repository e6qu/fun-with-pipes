#!/usr/bin/env python3
"""Check declared phase boundaries against retained generated C and peer source."""
import json
from pathlib import Path
import unittest
from zipfile import ZipFile

import array_construction_phases as PHASES
from current_kernel_costs import summarize

ROOT = Path(__file__).resolve().parent.parent


class PhaseBoundaries(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with ZipFile(ROOT / 'docs/measurements/array-construction-2026-11-02/arm.zip') as archive:
            cls.generated = archive.read('array-construction/generated.c').decode()
        cls.dimensions = (65537, 65, 67, 63)

    def test_source_and_driver_change_only_the_declared_construction(self):
        for profile, verification in ((False, False), (True, False), (False, True)):
            source = PHASES.native_source(self.generated, 'f1', 'f0', self.dimensions, 'fwp', profile, verification, False)
            driver = PHASES.native_source(self.generated, 'f1', 'f0', self.dimensions, 'reference', profile, verification, False)
            self.assertEqual(source.replace('V input=f0(round,elements);', PHASES.DRIVER_CONSTRUCTION), driver)
            self.assertIn('bench_construction_ns+=bench_clock()-construction_started;', source)
            self.assertIn('V result=f1(input);bench_kernel_ns+=bench_clock()-before;', source)

    def test_phase_builds_keep_both_cleanup_guards_and_live_observer(self):
        for role in ('fwp', 'reference'):
            source = PHASES.native_source(self.generated, 'f1', 'f0', self.dimensions, role, True, False, True)
            self.assertIn('bench_allocation_ns+=bench_clock()-allocation_started;', source)
            self.assertIn('bench_fill_ns+=bench_clock()-fill_started;', source)
            self.assertIn('fwp_array_builder_protect(&result, &cleanup);', source)
            self.assertIn('return fwp_array_builder_finish(&result, &cleanup);', source)
            self.assertIn('if(fwp_heap.live!=bench_initial_charge)', source)

    def test_peer_timers_keep_materialization_and_consumption(self):
        for language, extension in (('c', 'c'), ('rust', 'rs')):
            original = (ROOT / ('tests/fixtures/numerical_bench.' + extension)).read_text()
            source = PHASES.peer_source(original, language, self.dimensions, False)
            self.assertIn('construction_started', source)
            self.assertIn('consume_array(', source)
            self.assertIn('constructionNs', source)
            self.assertIn('allocationInclusiveNs', source)

    def test_missing_constructor_or_phase_boundary_is_rejected(self):
        changed = self.generated.replace('static V fwp_p_array_generate_typed(', 'static V changed_generate(')
        with self.assertRaises(ValueError):
            PHASES.native_source(changed, 'f1', 'f0', self.dimensions, 'fwp', True, False, True)

    def test_phase_times_cannot_exceed_constructor_or_inclusive_time(self):
        sample = dict(hash='result', kernelNs=100, constructionNs=200, allocationInclusiveNs=350,
                      allocationNs=50, fillNs=100, liveChargedBytes=0, requests=8, requestedBytes=16)
        PHASES.check_samples(json.dumps(dict(samples=[sample] * 5)), 'result', 'fwp', True, True)
        for field, value in (('constructionNs', 251), ('fillNs', 151), ('allocationNs', -1), ('fillNs', 0)):
            damaged = sample | {field: value}
            with self.assertRaises(AssertionError):
                PHASES.check_samples(json.dumps(dict(samples=[damaged] * 5)), 'result', 'fwp', True, True)

    def test_declared_metrics_must_be_distinct(self):
        with self.assertRaises(AssertionError):
            summarize([], 4, ('constructionNs', 'constructionNs'))


if __name__ == '__main__':
    unittest.main()
