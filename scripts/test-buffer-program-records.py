#!/usr/bin/env python3
"""Check code/stack report parsing without building or timing the compiler."""
import importlib.util
import json
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('buffer_programs', Path(__file__).with_name('prepare-buffer-baselines.py'))
PROGRAMS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROGRAMS)


class ProgramRecords(unittest.TestCase):
    def test_section_sizes_keep_code_data_and_metadata_distinct(self):
        text = 'program  :\nsection size addr\n.text 64 4096\n.rodata 16 8192\n.stack_sizes 9 0\nTotal 89\n'
        self.assertEqual(PROGRAMS.sections(text), {'.text': 64, '.rodata': 16, '.stack_sizes': 9})
        for damaged in [text.replace('Total 89', 'Total 90'),
                        text.replace('.text 64 4096', '.text -64 4096'),
                        text.replace('.rodata', '.text'), text.replace('.text', '.other')]:
            with self.subTest(damaged=damaged), self.assertRaises((AssertionError, KeyError)):
                PROGRAMS.sections(damaged)

    def test_rust_frames_require_exact_compiler_diagnostics(self):
        def diagnostic(level, message):
            return json.dumps(dict(message=message, level=level, code=None, spans=[],
                                   children=[], **{'$message_type': 'diagnostic'})) + '\n'
        warning = diagnostic('warning', '-C remark requires "-C debuginfo=n" to show source locations')
        leaf = diagnostic('note', "<unknown file>:0:0 prolog-epilog (analysis): 0 stack bytes in function 'leaf'")
        work = diagnostic('note', "<unknown file>:0:0 prolog-epilog (analysis): 32 stack bytes in function 'work'")
        text = warning + leaf + work
        expected = [dict(functions='leaf', bytes=0), dict(functions='work', bytes=32)]
        self.assertEqual(PROGRAMS.rust_frames(text, 'prolog-epilog'), expected)
        self.assertEqual(PROGRAMS.rust_frames(text.replace('prolog-epilog', 'prologepilog'), 'prologepilog'), expected)
        with self.assertRaises(AssertionError):
            PROGRAMS.rust_frames(text, 'prologepilog')
        for damaged in ['', warning, leaf, text.replace('32 stack', '-32 stack'),
                        text + warning, text + diagnostic('warning', 'incomplete'),
                        text.replace('prolog-epilog', 'another-pass'),
                        text.replace('"children": []', '"children": [{}]')]:
            with self.subTest(damaged=damaged), self.assertRaises(AssertionError):
                PROGRAMS.rust_frames(damaged, 'prolog-epilog')

    def test_c_frames_do_not_relabel_dynamic_frames_as_static(self):
        text = 'peer.c:1:1:work\t48\tstatic\npeer.c:9:1:other\t80\tdynamic,bounded\n'
        result = PROGRAMS.c_frames(text)
        self.assertEqual([row['kind'] for row in result], ['static', 'dynamic,bounded'])
        for damaged in ['', text.replace('48', '-48'), text.replace('static', 'unknown')]:
            with self.subTest(damaged=damaged), self.assertRaises(AssertionError):
                PROGRAMS.c_frames(damaged)


if __name__ == '__main__':
    unittest.main()
