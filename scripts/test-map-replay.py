#!/usr/bin/env python3
"""Verify evidence rejection without executing any downloaded program."""
import copy
import hashlib
import importlib.util
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('replay', Path(__file__).with_name('replay-map-storage.py'))
replay = importlib.util.module_from_spec(spec)
spec.loader.exec_module(replay)


class EvidenceValidation(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.folder = Path(self.temp.name)
        data = b'\x7fELF\x02\x01' + bytes(12) + (62).to_bytes(2, 'little')
        (self.folder / 'program').write_bytes(data)
        (self.folder / 'program.c').write_text('source')
        variant = {'binary': 'program', 'binaryBytes': len(data),
                   'binarySha256': hashlib.sha256(data).hexdigest(),
                   'generatedSha256': hashlib.sha256(b'source').hexdigest()}
        self.report = {'source': 'commit', 'cases': [
            {'work': work, 'variants': {mode + '-' + layout: copy.deepcopy(variant)
                                      for mode in ['tracing', 'arc']
                                      for layout in ['separate', 'joined']}}
            for work in ['full', 'construction']]}

    def test_complete_inputs(self):
        self.assertEqual(len(replay.validate(self.folder, self.report, 'commit', 62)), 8)

    def test_reject_wrong_source_or_architecture(self):
        for source, machine in [('wrong', 62), ('commit', 183)]:
            with self.subTest(source=source, machine=machine), self.assertRaises(AssertionError):
                replay.validate(self.folder, self.report, source, machine)

    def test_reject_changed_binary_or_generated_source(self):
        for name in ['program', 'program.c']:
            path = self.folder / name
            original = path.read_bytes()
            with self.subTest(name=name):
                path.write_bytes(original[:-1] + b'?')
                with self.assertRaises(AssertionError):
                    replay.validate(self.folder, self.report, 'commit', 62)
                path.write_bytes(original)

    def test_reject_incomplete_variants_or_external_path(self):
        variant = self.report['cases'][0]['variants'].pop('arc-joined')
        with self.assertRaises(AssertionError):
            replay.validate(self.folder, self.report, 'commit', 62)
        self.report['cases'][0]['variants']['arc-joined'] = variant
        variant['binary'] = '../program'
        with self.assertRaises(AssertionError):
            replay.validate(self.folder, self.report, 'commit', 62)


if __name__ == '__main__':
    unittest.main()
