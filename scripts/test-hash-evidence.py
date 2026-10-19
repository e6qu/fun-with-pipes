#!/usr/bin/env python3
"""Reject incomplete hash test runs instead of reporting unearned support."""
import contextlib
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import platform
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location(
    'hash_report', Path(__file__).with_name('summarize-hashing.py'))
REPORT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REPORT)
REPEAT_SPEC = importlib.util.spec_from_file_location(
    'hash_repeat', Path(__file__).with_name('repeat-hash-specialization.py'))
REPEAT = importlib.util.module_from_spec(REPEAT_SPEC)
REPEAT_SPEC.loader.exec_module(REPEAT)

LOG = '''test result: ok. 38 passed; 0 failed; 0 ignored;
test result: ok. 7 passed; 0 failed; 0 ignored;
test result: ok. 2 passed; 0 failed; 0 ignored;
Running tests/arc_execution.rs (target/debug/deps/arc)
test result: ok. 4 passed; 0 failed; 0 ignored;
Running tests/hash_ownership.rs (target/debug/deps/hash)
test numeric_hash_loops_preserve_widths_slices_and_shared_values ... ok
test numeric_hash_loops_allocate_nothing_and_do_not_adjust_reference_counts ... ok
Running tests/protocol.rs (target/debug/deps/protocol)
test result: ok. 6 passed; 0 failed; 0 ignored;
test result: ok. 9 passed; 0 failed; 0 ignored;
Running tests/range_array.rs (target/debug/deps/range)
test result: ok. 3 passed; 0 failed; 0 ignored;
'''


class HashEvidence(unittest.TestCase):
    def test_repeat_verifies_saved_files_before_execution_and_balances_samples(self):
        for tamper in [False, True]:
            with self.subTest(tamper=tamper), tempfile.TemporaryDirectory() as temporary:
                out = Path(temporary)
                original = out / 'original'
                case = original / 'small'
                case.mkdir(parents=True)
                source = 'main = 1 | hash | echo\n'
                (case / 'hash.fwp').write_text(source)
                variants = {}
                for label in REPEAT.LABELS:
                    paths = {'binarySha256': case / label,
                             'sourceSha256': case / ('reference.rs' if label == 'rust' else label + '.c'),
                             'assemblySha256': case / (label + '.asm')}
                    for key, file in paths.items():
                        file.write_text(label + key)
                    variants[label] = {key: hashlib.sha256(file.read_bytes()).hexdigest() for key, file in paths.items()}
                    variants[label]['profile'] = [dict(requests=2)]
                (original / 'report.json').write_text(json.dumps(dict(
                    head='a'*40, hardware=dict(system=platform.system(), machine=platform.machine()),
                    results=dict(small=dict(source=source, expected='ok\n', variants=variants)))))
                if tamper:
                    (case / 'c').write_text('changed binary')
                executed = []

                def command(arguments, environment):
                    if list(arguments[:3]) == ['gh', 'run', 'view']:
                        metadata = dict(headSha='a'*40, status='completed', conclusion='success',
                            jobs=[dict(name='ad_metadata (macos-15)', conclusion='success')])
                        return SimpleNamespace(stdout=json.dumps(metadata))
                    if len(arguments) == 1:
                        executed.append(Path(arguments[0]).name)
                        return SimpleNamespace(stdout='ok\n', stderr='')
                    return SimpleNamespace(stdout='metadata\n', stderr='')

                arguments = ['repeat', '--run', '123', '--source', 'a'*40, '--host', 'macos-15',
                             '--samples', '24', '--warmups', '2', '--output', str(out)]
                cpu = [SimpleNamespace(ru_utime=i/1000, ru_stime=0) for i in range(1000)]
                with patch('sys.argv', arguments), patch.dict('os.environ', {'GITHUB_ACTIONS': 'true'}), \
                        patch.object(REPEAT, 'run', side_effect=command), \
                        patch.object(REPEAT.resource, 'getrusage', side_effect=cpu), \
                        contextlib.redirect_stdout(io.StringIO()):
                    if tamper:
                        with self.assertRaises(AssertionError):
                            REPEAT.main()
                        self.assertNotIn('c', executed)
                        self.assertFalse((out / 'report.json').exists())
                    else:
                        REPEAT.main()
                        report = json.loads((out / 'report.json').read_text())
                        for label, variant in report['results']['small']['variants'].items():
                            self.assertEqual(executed.count(label), 26)
                            self.assertEqual(len(variant['samples']), 24)
                            self.assertEqual(sorted(s['order'].index(label) for s in variant['samples']), sorted(list(range(4))*6))

    def test_complete_interleaved_and_colored_windows_logs(self):
        for log in [LOG, LOG.replace('tests/', 'tests\\').replace(
                'Running', '\x1b[1;32mRunning\x1b[0m')]:
            self.assertEqual(REPORT.audit_tests(log), 69)

    def test_missing_failed_or_ignored_cases_are_rejected(self):
        for old, new in [
            ('6 passed; 0 failed; 0 ignored;', '5 passed; 1 failed; 0 ignored;'),
            ('6 passed; 0 failed; 0 ignored;', '5 passed; 0 failed; 1 ignored;'),
            ('6 passed; 0 failed; 0 ignored;', '5 passed; 0 failed; 0 ignored;'),
            ('hash_ownership.rs', 'other.rs'),
            ('test numeric_hash_loops_preserve_widths_slices_and_shared_values ... ok', ''),
        ]:
            with self.subTest(old=old, new=new), self.assertRaises(AssertionError):
                REPORT.audit_tests(LOG.replace(old, new))
        with self.assertRaises(AssertionError):
            REPORT.audit_tests(LOG + LOG)

    def test_rejected_run_state_is_retained(self):
        head = 'a' * 40
        valid = dict(headSha=head, status='completed', conclusion='success', jobs=[
            dict(name='paths (ubuntu-latest)', status='completed', conclusion='success', steps=[])])
        cases = [dict(status='in_progress'), dict(conclusion='failure'),
                 dict(conclusion='cancelled'), dict(headSha='b'*40), dict(jobs=[])]
        for change in cases:
            metadata = dict(valid, **change)
            with self.subTest(change=change), tempfile.TemporaryDirectory() as temporary:
                folder = Path(temporary)
                with patch.object(REPORT, 'command', return_value=json.dumps(metadata)), self.assertRaises(AssertionError):
                    REPORT.completed_run(123, head, folder, 'paths', ['ubuntu-latest'])
                self.assertEqual(json.loads((folder / 'run-123.json').read_text()), metadata)


if __name__ == '__main__':
    unittest.main()
