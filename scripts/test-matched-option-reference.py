#!/usr/bin/env python3
"""Keep the optional-field comparison isolated from prior ownership changes."""
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest import mock

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-matched-option-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
CURRENT = (ROOT / REFERENCE.CHANGED).read_text()


class MatchedOptionReference(unittest.TestCase):
    def test_all_three_selections_are_disabled_without_changing_other_code(self):
        restored = REFERENCE.reference_source(CURRENT)
        reversed_source = restored
        for candidate, reference in REFERENCE.EDITS:
            self.assertEqual(restored.count(reference), 1)
            self.assertNotIn(candidate, restored)
            reversed_source = reversed_source.replace(reference, candidate)
        self.assertEqual(reversed_source, CURRENT)
        self.assertIn('false && matches!(symbol.as_str(), "last" | "nth")', restored)
        self.assertIn('false && symbol == "list._iterate-last"', restored)
        self.assertIn('fwp_value_protect(&outer, &outer_cleanup)', restored)
        self.assertIn('fwp_p_iterate_last(l0, l1, l2, {drop})', restored)
        changed = CURRENT + '\n// unrelated change\n'
        self.assertTrue(REFERENCE.reference_source(changed).endswith('// unrelated change\n'))

    def test_missing_duplicate_changed_and_partial_selections_are_rejected(self):
        for candidate, reference in REFERENCE.EDITS:
            for changed in (CURRENT.replace(candidate, ''), CURRENT + candidate,
                            CURRENT.replace(candidate, candidate.replace('last', 'first')),
                            CURRENT.replace(candidate, reference)):
                with self.subTest(candidate=candidate):
                    with self.assertRaises(AssertionError):
                        REFERENCE.reference_source(changed)

    def test_source_manifest_and_reference_patch_reject_corruption(self):
        with tempfile.TemporaryDirectory(prefix='fwp-option-reference-') as temporary:
            root = Path(temporary)
            candidate, checkout, output = (root / name for name in ('candidate', 'reference', 'output'))
            candidate.mkdir()
            original = ''.join(before for before, _ in REFERENCE.EDITS)
            for name in (REFERENCE.CHANGED, *REFERENCE.PRESERVED):
                path = candidate / name
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(original if name == REFERENCE.CHANGED else 'preserved source\n')
            subprocess.run(['git', 'init', '--quiet', str(candidate)], check=True)
            subprocess.run(['git', 'add', '.'], cwd=candidate, check=True)
            subprocess.run(['git', '-c', 'user.name=Reference Test', '-c', 'user.email=test@example.invalid',
                            '-c', 'commit.gpgsign=false', 'commit', '--quiet', '-m', 'Reference fixture'],
                           cwd=candidate, check=True)
            subprocess.run(['git', 'clone', '--quiet', '--no-hardlinks', str(candidate), str(checkout)], check=True)
            with mock.patch.object(REFERENCE, 'ROOT', candidate):
                prepare = ['prepare-reference', '--checkout', str(checkout), '--output', str(output)]
                verify = ['prepare-reference', '--verify', str(checkout), '--output', str(output)]
                with mock.patch('sys.argv', prepare):
                    REFERENCE.main()
                manifest = json.loads((output / 'manifest.json').read_text())
                self.assertEqual(set(manifest['candidate']), {REFERENCE.CHANGED})
                self.assertEqual(set(manifest['unchanged']), set(REFERENCE.PRESERVED))
                (output / 'fwp').write_bytes(b'compiler digest fixture')
                changes = [
                    (checkout / REFERENCE.CHANGED, original),
                    (checkout / 'runtime/fwp_rt_prims.c', 'changed iteration algorithm\n'),
                    (output / 'source' / REFERENCE.CHANGED, 'wrong saved source\n'),
                    (output / 'reference.patch', 'wrong patch\n'),
                    (output / 'manifest.json', json.dumps(dict(manifest, source='wrong source'))),
                ]
                for path, corrupt in changes:
                    previous = path.read_bytes()
                    path.write_text(corrupt)
                    try:
                        with self.subTest(path=str(path.relative_to(root))):
                            with mock.patch('sys.argv', verify), self.assertRaises(AssertionError):
                                REFERENCE.main()
                    finally:
                        path.write_bytes(previous)
                with mock.patch('sys.argv', verify):
                    REFERENCE.main()
                with mock.patch('sys.argv', verify):
                    REFERENCE.main()
                (output / 'fwp').write_bytes(b'changed compiler')
                with mock.patch('sys.argv', verify), self.assertRaises(AssertionError):
                    REFERENCE.main()
                (output / 'fwp').write_bytes(b'compiler digest fixture')
                final = json.loads((output / 'manifest.json').read_text())
                self.assertEqual(final.pop('compilerSha256'), REFERENCE.digest(b'compiler digest fixture'))
                self.assertEqual(final, manifest)
                self.assertEqual((candidate / REFERENCE.CHANGED).read_text(), original)


if __name__ == '__main__':
    unittest.main()
