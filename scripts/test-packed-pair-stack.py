#!/usr/bin/env python3
"""Reject incomplete, altered or over-budget saved stack evidence."""
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('stack', Path(__file__).with_name('check-packed-pair-stack.py'))
STACK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(STACK)
SOURCE = 'a' * 40
HASHES = dict(candidate='b' * 64, reference='c' * 64)


class StackEvidence(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.files = {}
        cls.report = dict(source=SOURCE, machine='x86_64', complete=True, failures=[],
                          compilerHashes=HASHES, commands=[], cases={}, environment=dict(
                              FWP_LTO='0', FWP_AD_WORKSPACE='1', FWP_VRET='1',
                              FWP_FRAME_FIELDS='1', FWP_PACKED_ARRAYS='1',
                              FWP_STACK='1', FWP_ARRAY_FUSION='1'))
        for n, u, solves in STACK.CASES:
            for form in ('current', 'history'):
                name = f'{n}-{u}-{form}'
                cls.files[name + '.fwp'] = STACK.PEERS.BASELINE.repeat_source(
                    STACK.PEERS.AD.program(n, u + 1, form == 'history'), 'fwp', solves).encode()
                cls.report['cases'][name] = {}
                output = ((json.dumps(STACK.PEERS.AD.analytic(n, u + 1)) + '\n') * solves).encode()
                for kind, size in (('candidate', 848), ('reference', 720)):
                    label = name + '-' + kind
                    cls.files[label] = b'\x7fELF\x02\x01' + bytes(12) + b'\x3e\x00'
                    cls.files[label + '.c'] = b'int main(void) { return 0; }\n'
                    cls.files[label + '.su'] = f'case.c:1:1:main\t{size}\tstatic\n'.encode()
                    cls.report['cases'][name][kind] = dict(maximumBytes=size, entries=[
                        dict(location='case.c:1:1:main', bytes=size, qualifier='static')])
                    commands = dict(
                        emit=['/' + kind + '/fwp', 'build', '--memory', 'dynamic', '--emit-c', '-O2',
                              '/saved/' + name + '.fwp', '-o', '/saved/' + label + '.c'],
                        compile=['gcc', '-O2', '-std=gnu11', '-fno-fast-math', '-ffp-contract=off',
                                 '-UFWP_NO_REUSE', '-fstack-usage', '-march=x86-64', '-w',
                                 '/saved/' + label + '.c', '-o', '/saved/' + label, '-lm', '-lpthread', '-ldl'],
                        run=['/saved/' + label])
                    for stage, command in commands.items():
                        cls.report['commands'].append(dict(command=command, label=label + '-' + stage, status=0))
                        cls.files[label + '-' + stage + '.stdout'] = output if stage == 'run' else b''
                        cls.files[label + '-' + stage + '.stderr'] = b''

    def check(self, files, report):
        report['files'] = {name: hashlib.sha256(data).hexdigest() for name, data in files.items()}
        files['report.json'] = json.dumps(report).encode()
        return STACK.audit(files, SOURCE, 'x86_64', HASHES)

    def test_complete_evidence_and_exact_boundary(self):
        result = self.check(dict(self.files), copy.deepcopy(self.report))
        self.assertEqual(len(result), 12)
        self.assertEqual(result['33-199-current'], dict(candidate=848, reference=720))

    def test_invalid_reports_are_rejected(self):
        for field, value in [('source', 'd' * 40), ('complete', False), ('failures', ['failure']),
                             ('machine', 'aarch64'), ('compilerHashes', dict(candidate='d' * 64, reference=HASHES['reference']))]:
            report = copy.deepcopy(self.report)
            report[field] = value
            with self.subTest(field=field), self.assertRaises(AssertionError):
                self.check(dict(self.files), report)

    def test_commands_and_summary_cannot_hide_failure(self):
        for change in ('duplicate', 'missing', 'failed', 'flags', 'memory', 'summary'):
            report = copy.deepcopy(self.report)
            if change == 'duplicate':
                report['commands'].append(report['commands'][0])
            elif change == 'missing':
                report['commands'].pop()
            elif change == 'failed':
                report['commands'][0]['status'] = 1
            elif change == 'flags':
                report['commands'][1]['command'][1] = '-O1'
            elif change == 'memory':
                report['commands'][0]['command'][3] = 'static'
            else:
                report['cases']['3-0-current']['candidate']['maximumBytes'] = 1
            with self.subTest(change=change), self.assertRaises(AssertionError):
                self.check(dict(self.files), report)

    def test_saved_outputs_images_and_frames_are_checked(self):
        for suffix, data in [('.su', b'case.c:1:1:main\t848\tdynamic\n'),
                             ('', b'not an executable'), ('-run.stdout', b'[]\n'),
                             ('-run.stderr', b'unexpected diagnostic'), ('.c', b'')]:
            files = dict(self.files)
            files['3-0-current-candidate' + suffix] = data
            with self.subTest(suffix=suffix), self.assertRaises(AssertionError):
                self.check(files, copy.deepcopy(self.report))

    def test_consistent_over_budget_evidence_is_rejected(self):
        files = dict(self.files)
        report = copy.deepcopy(self.report)
        files['33-199-current-candidate.su'] = b'case.c:1:1:main\t849\tstatic\n'
        row = report['cases']['33-199-current']['candidate']
        row['maximumBytes'] = row['entries'][0]['bytes'] = 849
        with self.assertRaises(AssertionError):
            self.check(files, report)

    def test_bytes_missing_from_inventory_are_rejected(self):
        files = dict(self.files)
        self.check(files, copy.deepcopy(self.report))
        files['unrecorded.stdout'] = b''
        with self.assertRaises(AssertionError):
            STACK.audit(files, SOURCE, 'x86_64', HASHES)
        del files['unrecorded.stdout']
        files['3-0-current-candidate.c'] += b'changed'
        with self.assertRaises(AssertionError):
            STACK.audit(files, SOURCE, 'x86_64', HASHES)


if __name__ == '__main__':
    unittest.main()
