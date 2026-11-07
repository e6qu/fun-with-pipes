#!/usr/bin/env python3
"""Reject noisy, incomplete and regressing compiler-cost samples."""
import contextlib
import copy
import hashlib
import io
import itertools
import json
import importlib.util
import os
from pathlib import Path
import runpy
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch
import zipfile

SPEC = importlib.util.spec_from_file_location('analysis', Path(__file__).with_name('measure-numeric-input-analysis.py'))
ANALYSIS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(ANALYSIS)
OWNED_SPEC = importlib.util.spec_from_file_location('owned_reference', Path(__file__).with_name('prepare-owned-numeric-reference.py'))
OWNED = importlib.util.module_from_spec(OWNED_SPEC)
OWNED_SPEC.loader.exec_module(OWNED)


def scoped_output(name, specialized):
    calls = 64 if name == 'repeated-scopes' else 1
    callbacks = (0 if specialized else 1) if name == 'repeated-scopes' else 5120
    return ('/* ---- program ---- */\nstatic V f7(V, V, V);\n'
            '/* ad.scope2 : Scope */\nstatic V f7(V a, V b, V c) {}\n'
            + ('{2, e8, "worker-known-objective", 0},\n' if specialized else '')
            + 'f7(a, b, c);\n' * calls + 'V result = fwp_apply_owned(a, 1, b);\n' * callbacks)


def consuming_output(selected):
    roots = ('mapped', 'mapped32', 'mapped64', 'update-left', 'update-right', 'mapped-produced', 'shared-first')
    source = '/* ---- program ---- */\n'
    for index, name in enumerate(roots):
        private = 'consumed-scalar-array-list-zip' if name in ('update-left', 'update-right') else 'consumed-scalar-array-map'
        if selected:
            source += f'/* {private} : T */\nstatic V f{100 + index}(V input) {{\nreturn input;\n}}\n'
        source += f'/* {name} : T */\nstatic V f{index}(V input) {{\nreturn f{100 + index}(input);\n}}\n'
    source += ('/* retained : T */\nstatic V f9(V input) {\n'
               '/* direct known scalar array map; input stays borrowed */\nreturn input;\n}\n')
    return source


class CompilerCosts(unittest.TestCase):
    def test_audit_retains_rejected_host_without_inventing_compiler_samples(self):
        for comparison in ('recording-context', 'tape-records'):
            source = '1' * 40
            expected = dict(system='Linux', machine='x86_64', processors=4,
                            cpu=['AMD EPYC 7763 64-Core Processor', 'AMD EPYC 9V74 80-Core Processor',
                                 'AMD EPYC 9V45 96-Core Processor'])
            host = dict(source=source, expected=expected, actual=expected | {'cpu': 'unapproved CPU'},
                        qualified=False, failures=["cpu: expected " + repr(expected['cpu']) + ", observed 'unapproved CPU'"])
            steps = [dict(name=f'Qualify {comparison} compiler timing host', conclusion='failure')]
            steps.extend(dict(name=name, conclusion='skipped') for name in (
                'Build candidate at production settings', 'Build and verify the selected same-source reference',
                'Measure balanced compiler commands and peak memory'))
            job = dict(id=3, name=('tape_measurements / ' if comparison == 'tape-records' else '') + 'numeric_input_analysis (ubuntu-latest)', head_sha=source,
                       run_id=1, status='completed', conclusion='failure', steps=steps)
            for change in ('none', 'built', 'timed', 'qualified', 'wrong-failure', 'extra-diagnostic',
                           'partial-samples', 'wrong-hash'):
                with self.subTest(comparison=comparison, change=change), tempfile.TemporaryDirectory() as temporary:
                    changed_job, changed_host = copy.deepcopy(job), copy.deepcopy(host)
                    if change == 'built':
                        changed_job['steps'][1]['conclusion'] = 'success'
                    elif change == 'timed':
                        changed_job['steps'][3]['conclusion'] = 'success'
                    elif change == 'qualified':
                        changed_host['qualified'] = True
                    elif change == 'wrong-failure':
                        changed_host['failures'] = ['not the recorded mismatch']
                    log = b'Host rejected before building/timing\n##[error]Process completed with exit code 1.\n'
                    if change == 'extra-diagnostic':
                        log += b'warning: unrelated issue\n'
                    host_buffer, safety_buffer = io.BytesIO(), io.BytesIO()
                    with zipfile.ZipFile(host_buffer, 'w') as archive:
                        archive.writestr('compiler-cost-host.json', json.dumps(changed_host))
                    with zipfile.ZipFile(safety_buffer, 'w') as archive:
                        archive.writestr('numeric-analysis-safety/run.json', json.dumps(dict(head_sha=source)))
                        if change == 'partial-samples':
                            archive.writestr('numeric-analysis/report.json', '{}')
                    blobs = {4: host_buffer.getvalue(), 5: safety_buffer.getvalue()}
                    artifacts = [dict(id=number, name=name, expired=False, workflow_run=dict(head_sha=source),
                                      digest='sha256:' + hashlib.sha256(blobs[number]).hexdigest())
                                 for number, name in ((4, comparison + '-analysis-host-X64'),
                                                      (5, comparison + '-analysis-X64'))]
                    if change == 'wrong-hash':
                        artifacts[0]['digest'] = 'sha256:' + '0' * 64
                    def api(command, **kwargs):
                        path = command[-1].split('?', 1)[0]
                        if path.endswith('/runs/1/jobs'):
                            return json.dumps(dict(total_count=1, jobs=[changed_job])).encode()
                        if path.endswith('/runs/1/artifacts'):
                            return json.dumps(dict(total_count=2, artifacts=artifacts)).encode()
                        if path.endswith('/jobs/3/logs'):
                            return log
                        if path.endswith('/artifacts/4/zip'):
                            return blobs[4]
                        if path.endswith('/artifacts/5/zip'):
                            return blobs[5]
                        self.fail('unexpected API request: ' + path)
                    argv = ['audit-storage-compiler-costs.py', '--comparison', comparison,
                            '--repository', 'test/repo', '--source', source, '--run', '1',
                            '--machine', 'x86_64', '--output', temporary]
                    with patch('sys.argv', argv), patch.dict(os.environ, {'GITHUB_ACTIONS': 'true'}), \
                            patch.object(sys, 'path', sys.path.copy()), \
                            patch.object(subprocess, 'check_output', side_effect=api), \
                            contextlib.redirect_stdout(io.StringIO()):
                        if change == 'none':
                            with self.assertRaises(SystemExit) as exited:
                                runpy.run_path(str(Path(__file__).with_name('audit-storage-compiler-costs.py')))
                            self.assertEqual(exited.exception.code, 0)
                            record = json.loads((Path(temporary) / 'x86_64-host-rejected.json').read_text())
                            self.assertEqual(record['decision'], 'host-rejected-before-building-or-timing')
                            self.assertFalse(record['complete'])
                            self.assertEqual(record['qualification'], host)
                        else:
                            with self.assertRaises(AssertionError):
                                runpy.run_path(str(Path(__file__).with_name('audit-storage-compiler-costs.py')))
                            self.assertFalse((Path(temporary) / 'x86_64-host-rejected.json').exists())

    def test_consuming_selection_requires_live_calls_and_retained_exclusion(self):
        roots = ('mapped', 'mapped32', 'mapped64', 'update-left', 'update-right', 'mapped-produced', 'shared-first')
        source = consuming_output(True)
        self.assertEqual(set(ANALYSIS.consuming_cost_output(source, True)), {*roots, 'retained'})
        for index in range(len(roots)):
            # Private definitions left in metadata cannot replace a live call.
            broken = source.replace(f'return f{100 + index}(input);', 'return input;')
            with self.assertRaises(AssertionError):
                ANALYSIS.consuming_cost_output(broken, True)
        borrowed = source.replace('/* direct known scalar array map; input stays borrowed */\nreturn input;',
                                  '/* direct known scalar array map; input stays borrowed */\nreturn f100(input);')
        with self.assertRaises(AssertionError):
            ANALYSIS.consuming_cost_output(borrowed, True)
        with self.assertRaises(AssertionError):
            ANALYSIS.consuming_cost_output(source, False)

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
        for comparison, fail in itertools.product(('numeric-inputs', 'scalar-map-zip', 'range-zip', 'gradient-array', 'scalar-array-map', 'scalar-array-identity', 'matched-option', 'packed-input', 'owned-numeric', 'gradient-call'), (False, True)):
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
                if comparison == 'scalar-array-identity':
                    manifest = dict(source='test-source', compilerSha256=ANALYSIS.sha(reference),
                        disabledTransformation='F64 identity array-map elimination',
                        candidateOptimizerSha256=ANALYSIS.sha(ANALYSIS.ROOT / 'src/opt.rs'),
                        ownershipSha256=ANALYSIS.sha(ANALYSIS.ROOT / 'src/ownership.rs'),
                        unchanged={path: ANALYSIS.sha(ANALYSIS.ROOT / path) for path in
                                   ('src/interp.rs', 'runtime/fwp_rt_num.c', 'src/cgen.rs')})
                if comparison == 'matched-option':
                    manifest = dict(source='test-source', compilerSha256=ANALYSIS.sha(reference),
                        disabledTransformation='direct fields for matched list last, nth and final iteration results',
                        candidate={'src/cgen.rs': ANALYSIS.sha(ANALYSIS.ROOT / 'src/cgen.rs')},
                        reference={'src/cgen.rs': 'reference-codegen-hash'},
                        ownershipSha256=ANALYSIS.sha(ANALYSIS.ROOT / 'src/ownership.rs'),
                        unchanged={path: ANALYSIS.sha(ANALYSIS.ROOT / path) for path in
                                   ('src/fuse.rs', 'src/prims_std.rs', 'src/ownership.rs', 'src/opt.rs',
                                    'runtime/fwp_rt.c', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt_task.c',
                                    'runtime/fwp_rt_heap.c', 'lib/list.fwp', 'lib/autodiff.fwp')})
                if comparison == 'packed-input':
                    manifest = dict(source='test-source', compilerSha256=ANALYSIS.sha(reference),
                        disabledTransformation='scoped objective specialization and private numeric input packing',
                        candidate={path: ANALYSIS.sha(ANALYSIS.ROOT / path) for path in ('src/mono.rs', 'src/cgen.rs')},
                        reference={path: 'reference-hash' for path in ('src/mono.rs', 'src/cgen.rs')},
                        ownershipSha256=ANALYSIS.sha(ANALYSIS.ROOT / 'src/ownership.rs'),
                        unchanged={path: ANALYSIS.sha(ANALYSIS.ROOT / path) for path in {'runtime/fwp_rt_task.c', 'src/opt.rs', 'src/ownership.rs', 'runtime/fwp_rt_kernel.c', 'src/cgen/packed_records.rs', 'runtime/fwp_rt_heap.c', 'src/cgen/packed_inputs.rs', 'src/opt/scoped.rs', 'src/cgen/numeric_parameters.rs', 'lib/autodiff.fwp', 'src/cgen/range_zip.rs', 'lib/list.fwp', 'src/fuse.rs', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt.c'}})
                if comparison == 'owned-numeric':
                    manifest = dict(source='test-source', compilerSha256=ANALYSIS.sha(reference),
                        disabledTransformation='consuming scalar array maps and exclusive coordinate-list reuse',
                        candidate={'src/cgen.rs': ANALYSIS.sha(ANALYSIS.ROOT / 'src/cgen.rs')},
                        reference={'src/cgen.rs': 'reference-hash'},
                        ownershipSha256=ANALYSIS.sha(ANALYSIS.ROOT / 'src/ownership.rs'),
                        unchanged={path: ANALYSIS.sha(ANALYSIS.ROOT / path) for path in OWNED.PRESERVED})
                if comparison == 'gradient-call':
                    manifest = dict(source='test-source', compilerSha256=ANALYSIS.sha(reference),
                        disabledTransformation='scoped input borrowing, numeric fold fields, single-root seeding and consumed array scratch',
                        candidate={path: ANALYSIS.sha(ANALYSIS.ROOT / path) for path in ANALYSIS.GRADIENT_REFERENCE.EDITS},
                        reference={path: 'reference-hash' for path in ANALYSIS.GRADIENT_REFERENCE.EDITS},
                        ownershipSha256=ANALYSIS.sha(ANALYSIS.ROOT / 'src/ownership.rs'),
                        unchanged={path: ANALYSIS.sha(ANALYSIS.ROOT / path) for path in ANALYSIS.GRADIENT_REFERENCE.PRESERVED})
                manifest_path.write_text(json.dumps(manifest))
                output = root / 'output'
                argv = ['measure', '--comparison', comparison, '--compiler', str(compiler), '--reference', str(reference),
                        '--reference-manifest', str(manifest_path), '--time', '/usr/bin/time',
                        '--machine', 'aarch64', '--source', 'test-source', '--timeout', '180',
                        '--output', str(output)]
                commands, preflight_commands = [], []

                def captured(command, **options):
                    if command[0] != '/usr/bin/time':
                        preflight_commands.append(command)
                        name = Path(command[-3]).stem
                        candidate = Path(command[0]).name.startswith('candidate')
                        text = consuming_output(candidate or comparison == 'gradient-call') if name == 'input' else scoped_output(
                            name, candidate or comparison in ('owned-numeric', 'gradient-call'))
                        Path(command[-1]).write_text(text)
                        return subprocess.CompletedProcess(command, 0, b'', b'')
                    commands.append(command)
                    if comparison in ('matched-option', 'packed-input', 'owned-numeric', 'gradient-call'):
                        self.assertEqual(options['env']['FWP_VRET'], '1')
                        self.assertEqual(options['env']['FWP_FRAME_FIELDS'], '1')
                    if comparison in ('packed-input', 'owned-numeric', 'gradient-call'):
                        for setting in ('FWP_PACKED_ARRAYS', 'FWP_STACK', 'FWP_ARRAY_FUSION'):
                            self.assertEqual(options['env'][setting], '1')
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
                if comparison in ('matched-option', 'packed-input', 'owned-numeric', 'gradient-call'):
                    self.assertEqual(report['executionOverrides']['FWP_VRET'], '1')
                    self.assertEqual(report['executionOverrides']['FWP_FRAME_FIELDS'], '1')
                self.assertEqual(len(commands), 1 if fail else 336 if comparison in ('packed-input', 'owned-numeric', 'gradient-call') else 240)
                self.assertEqual(len(preflight_commands), 6 if comparison in ('owned-numeric', 'gradient-call') else 4 if comparison == 'packed-input' else 0)
                for name, digest in report['files'].items():
                    self.assertEqual(hashlib.sha256((output / name).read_bytes()).hexdigest(), digest)
                if fail:
                    case = report['cases']['field-transfer']
                    self.assertEqual(case['samples'][0]['timeout'], 180)
                    self.assertEqual((output / 'field-transfer/-2-candidate1.stderr').read_bytes(), b'partial error')
                else:
                    self.assertEqual(len(report['cases']), 7 if comparison in ('packed-input', 'owned-numeric', 'gradient-call') else 5)
                    self.assertTrue(all(len(case['samples']) == 48 and not case['summary']['failures']
                                        for case in report['cases'].values()))

    def test_cost_inputs_require_live_calls_and_shared_large_body(self):
        for name, specialized in itertools.product(ANALYSIS.scoped_cost_inputs(), (False, True)):
            emitted = scoped_output(name, specialized)
            ANALYSIS.scoped_cost_output(name, emitted, specialized)
            damaged = [emitted.replace('f7(a, b, c);\n', '', 1),
                       emitted + 'V extra = fwp_apply_owned(a, 1, b);\n']
            if specialized:
                damaged += [emitted.replace('e8, "worker-known-objective"', '0, "worker-known-objective"'),
                            emitted + '{2, e9, "worker-known-objective", 0},\n']
            for source in damaged:
                with self.subTest(name=name, specialized=specialized), self.assertRaises(AssertionError):
                    ANALYSIS.scoped_cost_output(name, source, specialized)

    def test_preflight_retains_both_failures_and_timeout_output(self):
        for timeout in (False, True):
            with tempfile.TemporaryDirectory() as temporary:
                output = Path(temporary) / 'checks'
                error = subprocess.TimeoutExpired(['compiler'], 180, output=b'partial', stderr=b'error')
                options = dict(side_effect=error) if timeout else dict(return_value=subprocess.CompletedProcess([], 1, b'partial', b'error'))
                with patch.object(ANALYSIS, 'run_capture', **options) as run, self.assertRaises(AssertionError):
                    ANALYSIS.check_scoped_cost_inputs(Path('compiler'), output, {}, 180, True)
                self.assertEqual(run.call_count, 2)
                records = json.loads((output / 'checks.json').read_text())
                self.assertEqual(len(records), 2)
                self.assertTrue(all('failure' in row for row in records))
                for name in ANALYSIS.scoped_cost_inputs():
                    self.assertEqual((output / (name + '.stdout')).read_bytes(), b'partial')
                    self.assertEqual((output / (name + '.stderr')).read_bytes(), b'error')


if __name__ == '__main__':
    unittest.main()
