#!/usr/bin/env python3
"""Keep host rejection and failed validation distinct from completed measurements."""
import copy
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('retain', Path(__file__).with_name('retain-current-kernels.py'))
RETAIN = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(RETAIN)
QUALIFY = 'Qualify the kernel host before building'
BUILD = 'Build the current compiler and exact word-state reference'
CHECK = 'Reference results, aliases, failure and cancellation'
MEASURE = 'Measure both fwp variants and C/Rust with independent copy controls'


def job(outcomes):
    return dict(status='completed', conclusion='failure' if 'failure' in outcomes else 'success',
                steps=[dict(name=name, conclusion=result) for name, result in
                       zip((QUALIFY, BUILD, CHECK, MEASURE), outcomes)])


class RetainCurrentKernels(unittest.TestCase):
    def test_unqualified_host_must_not_build_or_measure(self):
        host = dict(qualified=False, failures=['different CPU'])
        rejected = job(('failure', 'skipped', 'skipped', 'skipped'))
        self.assertEqual(RETAIN.outcome(rejected, host, False), 'host-rejected-before-building-or-timing')
        with self.assertRaises(AssertionError):
            RETAIN.outcome(rejected, host, True)
        rejected['steps'][1]['conclusion'] = 'success'
        with self.assertRaises(AssertionError):
            RETAIN.outcome(rejected, host, False)

    def test_reference_validation_failure_is_retained_before_timing(self):
        host = dict(qualified=True, failures=[])
        failed = job(('success', 'success', 'failure', 'skipped'))
        self.assertEqual(RETAIN.outcome(failed, host, False), 'reference-check-failed-before-timing')
        with self.assertRaises(AssertionError):
            RETAIN.outcome(failed, host, True)

    def test_complete_performance_failure_requires_a_measurement_archive(self):
        host = dict(qualified=True, failures=[])
        for result in ('success', 'failure'):
            measured = job(('success', 'success', 'success', result))
            self.assertEqual(RETAIN.outcome(measured, host, True), 'measured')
            with self.assertRaises(AssertionError):
                RETAIN.outcome(measured, host, False)

    def test_other_failed_steps_or_running_jobs_are_not_measurement_results(self):
        host = dict(qualified=True, failures=[])
        original = job(('success', 'success', 'success', 'success'))
        failed = copy.deepcopy(original)
        failed['steps'].append(dict(name='Independent evidence audit', conclusion='failure'))
        with self.assertRaises(AssertionError):
            RETAIN.outcome(failed, host, True)
        original['status'] = 'in_progress'
        with self.assertRaises(AssertionError):
            RETAIN.outcome(original, host, True)


if __name__ == '__main__':
    unittest.main()
