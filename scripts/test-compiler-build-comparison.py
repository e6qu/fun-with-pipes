#!/usr/bin/env python3
"""Reject incomplete schedules, noisy controls and hidden memory regressions."""
from contextlib import ExitStack, redirect_stdout
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

import compiler_build_comparison

from compiler_build_comparison import comparison


class CompilerComparisonTests(unittest.TestCase):
    def test_all_inputs_and_diagnostics_continue_after_changed_c(self):
        for contract, changed in (('compiler-types', False), ('compiler-types', True), ('nested-resources', True)):
            with self.subTest(contract=contract, changed=changed), tempfile.TemporaryDirectory() as temporary:
                root = Path(temporary)
                for role in ('reference', 'candidate'):
                    (root/role).write_bytes(role.encode())
                def child(command, **settings):
                    usage, compiler, source, destination = map(Path, (command[3], command[4], command[-3], command[-1]))
                    usage.write_text('Maximum resident set size (kbytes): 1000\nUser time (seconds): 0.10\nSystem time (seconds): 0.01\n')
                    text = source.read_text()
                    if source.name in ('early.fwp', 'late.fwp'):
                        line = text.splitlines().index('broken = "wrong"')+1
                        return subprocess.CompletedProcess(command, 1, b'', f'{source}:{line}: error: wrong\n'.encode())
                    bad = changed and compiler.name == 'candidate' and destination.parent.name == 'words'
                    destination.write_bytes(b'changed C' if bad else b'int main(void) { return 0; }\n')
                    return subprocess.CompletedProcess(command, 0, b'', b'')
                arguments = ['compiler_build_comparison.py', '--reference', str(root/'reference'),
                    '--candidate', str(root/'candidate'), '--reference-source', '0'*40,
                    '--contract', contract, '--phase', 'check', '--session', '0', '--time', '/time', '--cc', 'gcc',
                    '--cpu', '0', '--deadline', '120', '--output', str(root/'results')]
                with ExitStack() as stack:
                    stack.enter_context(patch.dict(os.environ, GITHUB_ACTIONS='true', CARGO_PROFILE_RELEASE_DEBUG='false'))
                    stack.enter_context(patch.object(sys, 'argv', arguments))
                    stack.enter_context(patch.object(compiler_build_comparison.platform, 'system', return_value='Linux'))
                    stack.enter_context(patch.object(compiler_build_comparison.platform, 'platform', return_value='test kernel'))
                    stack.enter_context(patch.object(os, 'sched_getaffinity', return_value={0}, create=True))
                    stack.enter_context(patch.object(os, 'sched_setaffinity', create=True))
                    stack.enter_context(patch.object(subprocess, 'check_output', return_value='test identity\n'))
                    stack.enter_context(patch.object(compiler_build_comparison, 'run_capture', side_effect=child))
                    stack.enter_context(redirect_stdout(io.StringIO()))
                    if changed and contract == 'compiler-types':
                        with self.assertRaises(AssertionError):
                            compiler_build_comparison.main()
                    else:
                        compiler_build_comparison.main()
                report = json.loads((root/'results/summary.json').read_text())
                self.assertEqual(len(report['cases']), 16)
                self.assertEqual(report['failures'], ['words'] if changed and contract == 'compiler-types' else [])
                self.assertTrue(report['cases']['nesting-512']['correct'])

    def samples(self, candidate_time, candidate_rss):
        return [dict(role=role, round=round_index,
                     elapsedNs=(1000000 if round_index == -1 else candidate_time if role.startswith('candidate') else 1000),
                     maxRssKiB=(1000000 if round_index == -1 else candidate_rss if role.startswith('candidate') else 1000))
                for round_index in range(-1, 8)
                for role in ('reference', 'reference-copy', 'candidate', 'candidate-copy')]

    def test_warmups_are_excluded_and_targets_are_distinct(self):
        self.assertTrue(comparison(self.samples(900, 900), 'words', 'compiler-types')['acceptance'])
        self.assertFalse(comparison(self.samples(960, 900), 'words', 'compiler-types')['acceptance'])
        self.assertTrue(comparison(self.samples(960, 900), 'http', 'compiler-types')['acceptance'])
        self.assertFalse(comparison(self.samples(1021, 900), 'http', 'compiler-types')['acceptance'])
        self.assertFalse(comparison(self.samples(900, 1051), 'callbacks', 'compiler-types')['acceptance'])

    def test_copy_noise_cannot_be_reported_as_a_speedup(self):
        samples = self.samples(800, 900)
        for row in samples:
            if row['round'] >= 0 and row['role'] == 'candidate-copy':
                row['elapsedNs'] = 820
        result = comparison(samples, 'words', 'compiler-types')
        self.assertLess(result['candidateRatio'], .95)
        self.assertFalse(result['timingQualified'])
        self.assertFalse(result['acceptance'])

    def test_runtime_optimization_has_its_own_compiler_cost_limit(self):
        for name in ('words', 'callbacks', 'http', 'generic-512'):
            self.assertTrue(comparison(self.samples(1010, 1000), name, 'nested-resources')['acceptance'])
            self.assertFalse(comparison(self.samples(1021, 1000), name, 'nested-resources')['acceptance'])
            self.assertFalse(comparison(self.samples(1000, 1051), name, 'nested-resources')['acceptance'])

    def test_missing_duplicate_or_invalid_measurements_fail(self):
        valid = self.samples(900, 900)
        for invalid in (valid[:-1], valid+[valid[-1]], valid[:-1]+[valid[-2]],
                        [dict(row, elapsedNs=0) for row in valid]):
            with self.assertRaises(AssertionError):
                comparison(invalid, 'words', 'compiler-types')


if __name__ == '__main__':
    unittest.main()
