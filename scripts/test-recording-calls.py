"""Failure controls for saved-image compiler diagnostics; no native compiler run."""
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
                CALLS.compile_one([], b'changed', {'sourceSha256': CALLS.digest(b'original')}, Path(temp) / 'out')
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
                        result = CALLS.compile_one(command, b'source', metadata, root / 'out')
                        self.assertEqual(result['imageSha256'], metadata['sha256'])
                    else:
                        with self.assertRaises((ValueError, FileNotFoundError)):
                            CALLS.compile_one(command, b'source', metadata, root / 'out')
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
                CALLS.compile_one(command, b'source', {'sourceSha256': CALLS.digest(b'source')}, root / 'out')
            self.assertEqual((root / 'out/stdout').read_bytes(), b'partial')
            self.assertEqual((root / 'out/stderr').read_bytes(), b'diagnostic')


if __name__ == '__main__':
    unittest.main()
