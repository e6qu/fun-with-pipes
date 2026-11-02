#!/usr/bin/env python3
"""Keep host rejection and failed validation distinct from completed measurements."""
import copy
import importlib.util
from pathlib import Path
import unittest
from unittest import mock

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
    def test_matrix_job_uses_its_own_measurement_and_prerequisite_steps(self):
        host = dict(qualified=True, failures=[])
        measured = job(('success', 'success', 'success', 'failure'))
        measured['steps'][1]['name'] = 'Build the current compiler'
        measured['steps'][2]['name'] = 'Require matching native matrix safety checks'
        measured['steps'][3]['name'] = 'Measure paired and scalar matrix columns with C/Rust peers'
        self.assertEqual(RETAIN.outcome(measured, host, True, 'matrix-columns'), 'measured')
        measured['steps'][2]['conclusion'] = 'failure'
        measured['steps'][3]['conclusion'] = 'skipped'
        self.assertEqual(RETAIN.outcome(measured, host, False, 'matrix-columns'),
                         'reference-check-failed-before-timing')
        with self.assertRaises(AssertionError):
            RETAIN.outcome(measured, host, True, 'matrix-columns')

    def test_matrix_prerequisite_requires_all_hosts_and_matching_sources(self):
        source, tree = 'a' * 40, 'b' * 40
        paths = ('src', 'runtime', 'lib', 'Cargo.toml', 'Cargo.lock', 'build.rs',
            'tests/blocked_matrix.rs', 'tests/fixtures/matrix_allocation_probe.c',
            'tests/fixtures/matrix_unwind_probe.c', 'tests/fixtures/blocked_matrix.fwp')
        value = dict(run=dict(head_sha=source, conclusion='success'),
            jobs=[dict(name=name, head_sha=source, conclusion='success') for name in
                  ('matrix_checks (ubuntu-latest, gcc)', 'matrix_checks (ubuntu-24.04-arm, gcc)', 'matrix_checks (macos-15, clang)')],
            trees={name: tree for name in paths})
        with mock.patch.object(RETAIN.subprocess, 'check_output', return_value=tree + '\n'):
            RETAIN.check_prerequisite(value, dict(source='c' * 40))
            value['trees']['runtime'] = 'd' * 40
            with self.assertRaises(AssertionError):
                RETAIN.check_prerequisite(value, dict(source='c' * 40))
            value['trees']['runtime'] = tree
            value['jobs'].pop()
            with self.assertRaises(AssertionError):
                RETAIN.check_prerequisite(value, dict(source='c' * 40))

    def test_unqualified_host_must_not_build_or_measure(self):
        host = dict(qualified=False, failures=['different CPU'])
        rejected = job(('failure', 'skipped', 'skipped', 'skipped'))
        self.assertEqual(RETAIN.outcome(rejected, host, False, 'loop-state'), 'host-rejected-before-building-or-timing')
        with self.assertRaises(AssertionError):
            RETAIN.outcome(rejected, host, True, 'loop-state')
        rejected['steps'][1]['conclusion'] = 'success'
        with self.assertRaises(AssertionError):
            RETAIN.outcome(rejected, host, False, 'loop-state')

    def test_reference_validation_failure_is_retained_before_timing(self):
        host = dict(qualified=True, failures=[])
        failed = job(('success', 'success', 'failure', 'skipped'))
        self.assertEqual(RETAIN.outcome(failed, host, False, 'loop-state'), 'reference-check-failed-before-timing')
        with self.assertRaises(AssertionError):
            RETAIN.outcome(failed, host, True, 'loop-state')

    def test_complete_performance_failure_requires_a_measurement_archive(self):
        host = dict(qualified=True, failures=[])
        for result in ('success', 'failure'):
            measured = job(('success', 'success', 'success', result))
            self.assertEqual(RETAIN.outcome(measured, host, True, 'loop-state'), 'measured')
            with self.assertRaises(AssertionError):
                RETAIN.outcome(measured, host, False, 'loop-state')

    def test_other_failed_steps_or_running_jobs_are_not_measurement_results(self):
        host = dict(qualified=True, failures=[])
        original = job(('success', 'success', 'success', 'success'))
        failed = copy.deepcopy(original)
        failed['steps'].append(dict(name='Independent evidence audit', conclusion='failure'))
        with self.assertRaises(AssertionError):
            RETAIN.outcome(failed, host, True, 'loop-state')
        original['status'] = 'in_progress'
        with self.assertRaises(AssertionError):
            RETAIN.outcome(original, host, True, 'loop-state')


if __name__ == '__main__':
    unittest.main()
