#!/usr/bin/env python3
"""Reject noisy, incomplete and regressing compiler-cost samples."""
import contextlib
import copy
import hashlib
import io
import itertools
import json
import importlib.util
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location('analysis', Path(__file__).with_name('measure-numeric-input-analysis.py'))
ANALYSIS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(ANALYSIS)


class CompilerCosts(unittest.TestCase):
    def setUp(self):
        self.rows = [dict(copy=name, round=number, seconds=1.0, peakCommandKiB=1000)
                     for number in range(-2, 10) for name in ANALYSIS.ORDERS[number % 2]]

    def test_balanced_equivalent_copies_pass(self):
        result = ANALYSIS.summarize(self.rows)
        self.assertEqual(result['failures'], [])
        self.assertEqual(result['candidateReferenceSeconds'], 1.0)

    def test_noisy_copies_and_slow_candidate_are_distinct_failures(self):
        for names, value, expected in [(('candidate1',), 1.03, 'identical-copy'),
                                       (('reference2',), 1.03, 'identical-copy'),
                                       (('candidate1', 'candidate2'), 1.06, 'elapsed median')]:
            rows = copy.deepcopy(self.rows)
            for row in rows:
                if row['copy'] in names:
                    row['seconds'] = value
            with self.subTest(names=names):
                self.assertTrue(any(expected in failure for failure in ANALYSIS.summarize(rows)['failures']))

    def test_peak_memory_is_not_a_median(self):
        row = next(row for row in self.rows if row['round'] == 9 and row['copy'] == 'candidate1')
        row['peakCommandKiB'] = 1051
        self.assertTrue(any('peak RSS' in failure for failure in ANALYSIS.summarize(self.rows)['failures']))

    def test_missing_duplicate_and_reordered_rounds_fail(self):
        for rows in [self.rows[1:], self.rows[:-1], self.rows + [self.rows[-1]],
                     self.rows[:-2] + self.rows[-2:][::-1]]:
            with self.assertRaises(AssertionError):
                ANALYSIS.summarize(rows)

    def test_warmups_do_not_enter_elapsed_medians_but_do_enter_peak_memory(self):
        for row in self.rows:
            if row['round'] < 0:
                row.update(seconds=1000)
        self.assertEqual(ANALYSIS.summarize(self.rows)['failures'], [])
        self.rows[0]['peakCommandKiB'] = 1051
        self.assertTrue(any('peak RSS' in failure for failure in ANALYSIS.summarize(self.rows)['failures']))

    def test_nonfinite_nonpositive_and_invalid_memory_samples_fail(self):
        for field, value in [('seconds', float('nan')), ('seconds', float('inf')),
                             ('seconds', 0), ('peakCommandKiB', 0), ('peakCommandKiB', True)]:
            rows = copy.deepcopy(self.rows)
            rows[0][field] = value
            with self.subTest(field=field, value=value), self.assertRaises(AssertionError):
                ANALYSIS.summarize(rows)

    def test_complete_schedule_and_timeout_keep_reviewable_evidence(self):
        for comparison, fail in itertools.product(('numeric-inputs', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map'), (False, True)):
            with self.subTest(comparison=comparison, timeout=fail), tempfile.TemporaryDirectory() as temporary:
                root = Path(temporary)
                compiler, reference = root / 'candidate', root / 'reference'
                compiler.write_bytes(b'candidate image')
                reference.write_bytes(b'reference image')
                manifest = dict(scope='numeric-inputs', source='test-source',
                    compilerSha256=ANALYSIS.sha(reference),
                    disabledTransformation='numeric internal parameters and numeric packed-map input preparation',
                    files={path: dict(candidateSha256=ANALYSIS.sha(ANALYSIS.ROOT / path))
                           for path in ('src/cgen.rs', 'src/cgen/packed_records.rs')},
                    unchanged={path: ANALYSIS.sha(ANALYSIS.ROOT / path) for path in
                               ('src/ownership.rs', 'src/cgen/field_transfers.rs', 'src/cgen/numeric_parameters.rs')})
                manifest_path = root / 'manifest.json'
                if comparison in ('scalar-map-zip', 'range-zip', 'scalar-array-map'):
                    manifest = dict(source='test-source', compilerSha256=ANALYSIS.sha(reference),
                        disabledTransformation=('direct closed scalar array map callbacks' if comparison == 'scalar-array-map'
                            else 'private range-to-zip storage' if comparison == 'range-zip' else 'scalar map-to-zip buffer storage'),
                        candidateCodegenSha256=ANALYSIS.sha(ANALYSIS.ROOT / 'src/cgen.rs'),
                        ownershipSha256=ANALYSIS.sha(ANALYSIS.ROOT / 'src/ownership.rs'))
                if comparison == 'gradient-array':
                    manifest = dict(source='test-source', compilerSha256=ANALYSIS.sha(reference),
                        disabledTransformation='owned gradient arrays and direct array/list zip',
                        candidate={path: ANALYSIS.sha(ANALYSIS.ROOT / path) for path in ('lib/autodiff.fwp', 'runtime/fwp_rt_kernel.c', 'src/cgen.rs', 'src/fuse.rs', 'src/interp.rs', 'src/ir.rs', 'src/numerics.rs')},
                        ownershipSha256=ANALYSIS.sha(ANALYSIS.ROOT / 'src/ownership.rs'),
                        frozenPatchSha256=ANALYSIS.sha(ANALYSIS.ROOT / 'scripts/gradient-array-candidate.patch'))
                manifest_path.write_text(json.dumps(manifest))
                output = root / 'output'
                argv = ['measure', '--comparison', comparison, '--compiler', str(compiler), '--reference', str(reference),
                        '--reference-manifest', str(manifest_path), '--time', '/usr/bin/time',
                        '--machine', 'aarch64', '--source', 'test-source', '--timeout', '180',
                        '--output', str(output)]
                commands = []

                def captured(command, **options):
                    commands.append(command)
                    self.assertEqual(command[5:10], ['build', '--memory', 'dynamic', '--emit-c', '-O2'])
                    if fail:
                        raise subprocess.TimeoutExpired(command, 180, output=b'partial out', stderr=b'partial error')
                    Path(command[3]).write_text('Maximum resident set size (kbytes): 1000\n')
                    Path(command[-1]).write_text('/* emitted source */\n')
                    return subprocess.CompletedProcess(command, 0, b'', b'')

                original_read = Path.read_text

                def read(path, *args, **kwargs):
                    return 'test CPU' if str(path) == '/proc/cpuinfo' else original_read(path, *args, **kwargs)

                environment = dict(GITHUB_ACTIONS='true', CARGO_PROFILE_DEV_OPT_LEVEL='1',
                    CARGO_PROFILE_DEV_DEBUG_ASSERTIONS='true', CARGO_PROFILE_DEV_OVERFLOW_CHECKS='true', FWP_LTO='0')
                with patch('sys.argv', argv), patch.dict(ANALYSIS.os.environ, environment), \
                        patch.object(ANALYSIS.platform, 'system', return_value='Linux'), \
                        patch.object(ANALYSIS.platform, 'machine', return_value='aarch64'), \
                        patch.object(ANALYSIS.subprocess, 'check_output', return_value='test-source\n'), \
                        patch.object(ANALYSIS.subprocess, 'run', return_value=subprocess.CompletedProcess([], 0, 'tool', '')), \
                        patch.object(ANALYSIS, 'run_capture', side_effect=captured), \
                        patch.object(ANALYSIS.time, 'perf_counter', side_effect=itertools.count()), \
                        patch.object(Path, 'read_text', read), contextlib.redirect_stdout(io.StringIO()):
                    if fail:
                        with self.assertRaises(subprocess.TimeoutExpired):
                            ANALYSIS.main()
                    else:
                        ANALYSIS.main()
                report = json.loads((output / 'report.json').read_text())
                self.assertEqual(report['complete'], not fail)
                self.assertEqual(len(commands), 1 if fail else 240)
                for name, digest in report['files'].items():
                    self.assertEqual(hashlib.sha256((output / name).read_bytes()).hexdigest(), digest)
                if fail:
                    case = report['cases']['field-transfer']
                    self.assertEqual(case['samples'][0]['timeout'], 180)
                    self.assertEqual((output / 'field-transfer/-2-candidate1.stderr').read_bytes(), b'partial error')
                else:
                    self.assertEqual(len(report['cases']), 5)
                    self.assertTrue(all(len(case['samples']) == 48 and not case['summary']['failures']
                                        for case in report['cases'].values()))


if __name__ == '__main__':
    unittest.main()
