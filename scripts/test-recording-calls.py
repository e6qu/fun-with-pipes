"""Failure controls for saved-image compiler diagnostics; no native compiler run."""
import copy
import importlib.util
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location('recording_calls', Path(__file__).with_name('analyze-recording-calls.py'))
CALLS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CALLS)


class RecordingCalls(unittest.TestCase):
    def test_explicit_plan_rejects_incomplete_or_ambiguous_inputs(self):
        group = dict(name='lookup', source='a' * 40, protocol='recording-inline',
                     index='docs/measurements/fixture/index.json',
                     variants=[dict(name='candidate', suffix='', inlining='require'),
                               dict(name='reference', suffix='-reference', inlining='observe')])
        plan = dict(contractCommit='b' * 40, architectures={arch: [copy.deepcopy(group)] for arch in ('aarch64', 'x86_64')})
        self.assertEqual(CALLS.check_plan(plan, 'aarch64'), [group])
        capacity = copy.deepcopy(plan)
        for groups in capacity['architectures'].values():
            groups[0]['protocol'] = 'recording-capacity'
        self.assertEqual(CALLS.check_plan(capacity, 'x86_64'), capacity['architectures']['x86_64'])
        context = copy.deepcopy(capacity)
        for groups in context['architectures'].values():
            groups[0]['protocol'] = 'recording-context'
            for variant in groups[0]['variants']:
                variant['inlining'] = 'require'
        self.assertEqual(CALLS.check_plan(context, 'x86_64'), context['architectures']['x86_64'])
        for variant in context['architectures']['x86_64'][0]['variants']:
            if variant['name'] == 'reference':
                variant['inlining'] = 'observe'
        with self.assertRaises(AssertionError):
            CALLS.check_plan(context, 'x86_64')
        for mode in ('missing-setting', 'duplicate', 'bad-source', 'wrong-suffix', 'wrong-protocol', 'outside-index', 'missing-arch', 'missing-variant'):
            altered = copy.deepcopy(plan)
            selected = altered['architectures']['aarch64'][0]
            if mode == 'missing-setting':
                del selected['variants'][0]['inlining']
            elif mode == 'duplicate':
                selected['variants'].append(selected['variants'][0])
            elif mode == 'bad-source':
                selected['source'] = 'HEAD'
            elif mode == 'wrong-suffix':
                selected['variants'][0]['suffix'] = '-unrelated'
            elif mode == 'wrong-protocol':
                selected['protocol'] = 'recording-lookup'
            elif mode == 'missing-variant':
                selected['variants'].pop()
            elif mode == 'outside-index':
                selected['index'] = 'docs/measurements/../outside.json'
            else:
                del altered['architectures']['x86_64']
            with self.subTest(mode=mode), self.assertRaises(AssertionError):
                CALLS.check_plan(altered, 'aarch64')

    def test_reports_distinguish_final_decisions_from_early_misses(self):
        report = (
            'sample.c:10:5: missed: will not early inline: f123/4->fwp_p_ad_push/1022, growth limit\n'
            'sample.c:10:5: optimized: Inlining fwp_p_ad_push/1022 into w120/1110.\n'
            'sample.c:11:5: optimized: Inlined fwp_f64/74 into w120/1110.\n'
            'sample.c:12:5: missed: not inlinable: w120/1110 -> fwp_p_ad_push.constprop/1619, size limit\n')
        self.assertEqual(CALLS.inline_decisions(report, 'fwp_p_ad_push'), dict(inlined=1, rejected=1))
        self.assertEqual(CALLS.inline_decisions(report, 'fwp_tape_reserve'), dict(inlined=0, rejected=0))
        reserve = report.replace('fwp_p_ad_push', 'fwp_tape_reserve')
        self.assertEqual(CALLS.inline_decisions(reserve, 'fwp_tape_reserve'), dict(inlined=1, rejected=1))
        self.assertEqual(CALLS.inline_decisions(reserve.replace('fwp_tape_reserve', 'fwp_tape_reserve_other'),
                                               'fwp_tape_reserve'), dict(inlined=0, rejected=0))

    def test_recorded_command_rejects_changed_flags_duplicate_and_failure(self):
        command = CALLS.expected_command('aarch64', '3-199', 'fwp-ad')
        record = dict(command=command, status=0, stdout='', stderr='')
        self.assertEqual(CALLS.recorded_command({'commands': [record]}, 'aarch64', '3-199', 'fwp-ad'), command)
        for records in [[], [record, record], [dict(record, status=1)],
                        [dict(record, stderr='warning')], [dict(record, command=[*command, '-ffast-math'])]]:
            with self.subTest(records=records), self.assertRaises(ValueError):
                CALLS.recorded_command({'commands': records}, 'aarch64', '3-199', 'fwp-ad')

    def test_corrupt_source_is_rejected_before_compiler(self):
        with tempfile.TemporaryDirectory() as temp, patch.object(CALLS, 'execute') as execute:
            with self.assertRaisesRegex(ValueError, 'saved source'):
                CALLS.compile_one([], b'changed', {'sourceSha256': CALLS.digest(b'original')}, Path(temp) / 'out', 'fwp_tape_reserve')
            execute.assert_not_called()

    def test_compilation_never_reuses_stale_image_or_report(self):
        for mode in ['pass', 'failed', 'missing-report', 'empty-report', 'changed-image', 'warning', 'missing-stack']:
            with self.subTest(mode=mode), tempfile.TemporaryDirectory() as temp:
                root = Path(temp)
                source = root / 'sample.c'
                image = root / 'sample'
                image.write_bytes(b'original')
                image.with_suffix('.su').write_text('stale stack')
                command = CALLS.expected_command('x86_64', '3-0', 'fwp-ad')
                command[9], command[11] = str(source), str(image)
                metadata = {'sourceSha256': CALLS.digest(b'source'), 'sha256': CALLS.digest(b'original')}

                def compiler(actual):
                    self.assertFalse(image.exists())
                    self.assertFalse(image.with_suffix('.su').exists())
                    self.assertEqual(actual[:-1], command)
                    self.assertEqual(source.read_bytes(), b'source')
                    if mode != 'failed':
                        image.write_bytes(b'changed' if mode == 'changed-image' else b'original')
                    if mode != 'missing-stack':
                        image.with_suffix('.su').write_text('fresh stack')
                    if mode != 'missing-report':
                        Path(actual[-1].split('=', 1)[1]).write_text('' if mode == 'empty-report' else 'inlining decisions')
                    return subprocess.CompletedProcess(actual, int(mode == 'failed'), b'', b'warning' if mode == 'warning' else b'')

                with patch.object(CALLS, 'execute', side_effect=compiler) as execute:
                    if mode == 'pass':
                        result = CALLS.compile_one(command, b'source', metadata, root / 'out', 'fwp_tape_reserve')
                        self.assertEqual(result['imageSha256'], metadata['sha256'])
                        self.assertEqual(result['inliningTarget'], 'fwp_tape_reserve')
                    else:
                        with self.assertRaises((ValueError, FileNotFoundError)):
                            CALLS.compile_one(command, b'source', metadata, root / 'out', 'fwp_tape_reserve')
                    execute.assert_called_once()
                self.assertTrue((root / 'out/result.json').is_file())
                self.assertEqual((root / 'out/source.c').read_bytes(), b'source')

    def test_timeout_retains_partial_diagnostics(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            command = CALLS.expected_command('x86_64', '3-0', 'fwp-ad')
            command[9], command[11] = str(root / 'source.c'), str(root / 'image')
            error = subprocess.TimeoutExpired(command, 120, output=b'partial', stderr=b'diagnostic')
            with patch.object(CALLS, 'execute', side_effect=error), self.assertRaises(subprocess.TimeoutExpired):
                CALLS.compile_one(command, b'source', {'sourceSha256': CALLS.digest(b'source')}, root / 'out', 'fwp_tape_reserve')
            self.assertEqual((root / 'out/stdout').read_bytes(), b'partial')
            self.assertEqual((root / 'out/stderr').read_bytes(), b'diagnostic')


if __name__ == '__main__':
    unittest.main()
