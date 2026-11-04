#!/usr/bin/env python3
"""Reject partial references and preserve the independent correctness repairs."""
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest import mock

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-packed-input-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
CURRENT = {name: (ROOT / name).read_text() for name in REFERENCE.EDITS}


class PackedInputReference(unittest.TestCase):
    def test_both_transformations_are_disabled_and_reversible(self):
        restored = REFERENCE.reference_sources(CURRENT)
        for name, (candidate, reference) in REFERENCE.EDITS.items():
            self.assertEqual(restored[name].count(reference), 1)
            self.assertNotIn(candidate, restored[name])
            self.assertEqual(restored[name].replace(reference, candidate), CURRENT[name])
        self.assertIn('if false { crate::opt::scoped::specialize', restored['src/mono.rs'])
        self.assertIn('if false { packed_inputs::lower', restored['src/cgen.rs'])
        self.assertIn('numeric_parameters::lower(&mut numeric_program, &roots);', restored['src/cgen.rs'])

    def test_unrelated_edits_survive(self):
        changed = {name: data + ('\n// unrelated marker\n' if name.endswith('.rs') else '\n# unrelated marker\n')
                   for name, data in CURRENT.items()}
        restored = REFERENCE.reference_sources(changed)
        for name, (candidate, reference) in REFERENCE.EDITS.items():
            self.assertEqual(restored[name].replace(reference, candidate), changed[name])

    def test_missing_duplicate_changed_and_already_disabled_sources_are_rejected(self):
        for name, (candidate, reference) in REFERENCE.EDITS.items():
            for data in (
                CURRENT[name].replace(candidate, ''),
                CURRENT[name] + candidate,
                CURRENT[name].replace(candidate, candidate.replace('&mut', '&')),
                CURRENT[name].replace(candidate, reference),
            ):
                changed = dict(CURRENT)
                changed[name] = data
                with self.subTest(path=name, data=data[-80:]):
                    with self.assertRaises(AssertionError):
                        REFERENCE.reference_sources(changed)
            partial = dict(CURRENT)
            del partial[name]
            with self.assertRaises(AssertionError):
                REFERENCE.reference_sources(partial)

    def test_correctness_repairs_are_outside_the_reference_edits(self):
        self.assertTrue(set(REFERENCE.PRESERVED).isdisjoint(REFERENCE.EDITS))
        self.assertIn('iterate_count(&a[0])?', (ROOT / 'src/prims_std.rs').read_text())
        self.assertIn('fwp_value_protect(&outer, &outer_cleanup)', (ROOT / 'src/cgen.rs').read_text())
        self.assertIn('fwp_value_protect(&current, &cleanup)', (ROOT / 'runtime/fwp_rt_prims.c').read_text())

    def test_checkout_manifest_and_saved_sources_reject_corruption(self):
        # Tiny real Git checkouts exercise publication/verification without
        # building a compiler or copying the project's evidence archives.
        with tempfile.TemporaryDirectory(prefix='fwp-packed-input-reference-') as temporary:
            root = Path(temporary)
            candidate, checkout, output = (root / name for name in ('candidate', 'reference', 'output'))
            candidate.mkdir()
            for name in (*REFERENCE.EDITS, *REFERENCE.PRESERVED):
                path = candidate / name
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(REFERENCE.EDITS[name][0] if name in REFERENCE.EDITS else 'preserved source\n')
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
                self.assertEqual(set(manifest['candidate']), set(REFERENCE.EDITS))
                self.assertEqual(set(manifest['unchanged']), set(REFERENCE.PRESERVED))
                # This byte fixture checks the digest contract, not execution.
                (output / 'fwp').write_bytes(b'compiler digest fixture')
                changes = [
                    (checkout / 'src/mono.rs', REFERENCE.EDITS['src/mono.rs'][0]),
                    (checkout / 'runtime/fwp_rt_prims.c', 'changed correctness repair\n'),
                    (output / 'source/src/cgen.rs', 'wrong saved reference\n'),
                    (output / 'reference.patch', 'wrong patch\n'),
                    (output / 'manifest.json', json.dumps(dict(manifest, source='wrong revision'))),
                ]
                for path, corrupt in changes:
                    original = path.read_bytes()
                    path.write_text(corrupt)
                    try:
                        with self.subTest(path=str(path.relative_to(root))):
                            with mock.patch('sys.argv', verify), self.assertRaises(AssertionError):
                                REFERENCE.main()
                    finally:
                        path.write_bytes(original)
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
                for name, (original, _) in REFERENCE.EDITS.items():
                    self.assertEqual((candidate / name).read_text(), original)


if __name__ == '__main__':
    unittest.main()
