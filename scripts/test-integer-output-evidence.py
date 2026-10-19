#!/usr/bin/env python3
"""Incomplete or ignored output checks must not become accepted platform evidence."""
import importlib.util
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location(
    'output_report', Path(__file__).with_name('summarize-integer-output.py'))
REPORT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REPORT)

LOG = '''Running tests/exec_protocol_ownership.rs (target/debug/deps/exec)
Running tests/integer_output.rs (target/debug/deps/output)
test result: ok. 2 passed; 0 failed; 0 ignored;
test integer_output_preserves_widths_shared_strings_and_trap_order ... ok
test immediate_integer_output_does_not_allocate_a_string ... ok
test integer_print_keeps_binary_protocol_output_on_its_own_stream ... ok
Running tests/scalar_traps.rs (target/debug/deps/traps)
test result: ok. 3 passed; 0 failed; 0 ignored;
test result: ok. 2 passed; 0 failed; 0 ignored;
'''


class OutputEvidence(unittest.TestCase):
    def test_binary_tracing_policy_is_explicit(self):
        for mode, required, present, accepted in [
            ('arc', False, False, True), ('arc', False, True, False),
            ('tracing', True, True, True), ('tracing', True, False, False),
            ('tracing', False, False, True), ('tracing', False, True, True),
        ]:
            def command(tool, *arguments):
                if tool.name == 'llvm-nm':
                    names = [f'fwp_runtime_{index}' for index in range(12)]
                    if present:
                        names.append('fwp_gc_mark_all')
                    return '\n'.join('0000 t ' + name for name in names)
                if tool.name == 'llvm-objdump':
                    return 'file format elf64-x86-64\n'
                self.assertEqual(tool.name, 'llvm-size')
                return '.text 128 4096\n'

            with self.subTest(mode=mode, required=required, present=present):
                with tempfile.TemporaryDirectory() as directory:
                    binary = Path(directory) / 'sample.exe'
                    binary.write_bytes(b'binary identity fixture')
                    with patch.object(REPORT.HASH.COLLECTIONS, 'command', command):
                        if accepted:
                            observed = REPORT.HASH.COLLECTIONS.inspect(
                                binary, 'ubuntu-latest', mode, Path('/tools'),
                                require_tracing=required)
                            self.assertEqual(bool(observed['tracingSymbols']), present)
                        else:
                            with self.assertRaises(AssertionError):
                                REPORT.HASH.COLLECTIONS.inspect(
                                    binary, 'ubuntu-latest', mode, Path('/tools'),
                                    require_tracing=required)

    def test_complete_interleaved_and_windows_logs(self):
        for log in [LOG, LOG.replace('tests/', 'tests\\').replace(
                'Running', '\x1b[1;32mRunning\x1b[0m')]:
            self.assertEqual(REPORT.audit_tests(log), 7)

    def test_missing_failed_ignored_and_duplicate_results_are_rejected(self):
        for old, new in [
            ('3 passed; 0 failed; 0 ignored;', '2 passed; 1 failed; 0 ignored;'),
            ('3 passed; 0 failed; 0 ignored;', '2 passed; 0 failed; 1 ignored;'),
            ('3 passed; 0 failed; 0 ignored;', '2 passed; 0 failed; 0 ignored;'),
            ('integer_output.rs', 'unrelated.rs'),
            ('test immediate_integer_output_does_not_allocate_a_string ... ok', ''),
        ]:
            with self.subTest(old=old, new=new), self.assertRaises(AssertionError):
                REPORT.audit_tests(LOG.replace(old, new))
        with self.assertRaises(AssertionError):
            REPORT.audit_tests(LOG + LOG)


if __name__ == '__main__':
    unittest.main()
