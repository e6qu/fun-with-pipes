#!/usr/bin/env python3
"""Reject incomplete hash test runs instead of reporting unearned support."""
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location(
    'hash_report', Path(__file__).with_name('summarize-hashing.py'))
REPORT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REPORT)

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
