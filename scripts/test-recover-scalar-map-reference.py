#!/usr/bin/env python3
"""A reconstructed reference must match the original manifest and every file."""
import copy
import difflib
import hashlib
import importlib.util
import json
from pathlib import Path
import struct
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('recover', ROOT / 'scripts/recover-scalar-map-reference.py')
RECOVER = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(RECOVER)


class Recovery(unittest.TestCase):
    def test_recorded_manifest_and_reconstructed_files_must_all_match(self):
        source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
        candidate = subprocess.check_output(['git', 'show', source + ':src/cgen.rs'], cwd=ROOT)
        preparation = subprocess.check_output(['git', 'show', source + ':scripts/prepare-scalar-array-map-reference.py'], cwd=ROOT, text=True)
        reference = RECOVER.RETAIN.CHECK.recorded_reference(candidate.decode(), preparation).encode()
        ownership = subprocess.check_output(['git', 'show', source + ':src/ownership.rs'], cwd=ROOT)
        patch = ''.join(difflib.unified_diff(candidate.decode().splitlines(keepends=True),
            reference.decode().splitlines(keepends=True), fromfile='a/src/cgen.rs', tofile='b/src/cgen.rs')).encode()
        patch = b'diff --git a/src/cgen.rs b/src/cgen.rs\nindex 1234567..2345678 100644\n' + patch
        # Minimal ELF section fixture, inspected as data and never executed.
        compiler = bytearray(272)
        compiler[:6] = b'\x7fELF\x02\x01'
        struct.pack_into('<H', compiler, 18, 183)
        struct.pack_into('<Q', compiler, 40, 64)
        struct.pack_into('<HHH', compiler, 58, 64, 3, 1)
        struct.pack_into('<IIQQQQIIQQ', compiler, 128, 0, 3, 0, 0, 256, 7, 0, 0, 1, 0)
        struct.pack_into('<IIQQQQIIQQ', compiler, 192, 1, 1, 4, 0, 264, 8, 0, 0, 1, 0)
        compiler[256:263] = b'\0.text\0'
        digest = lambda value: hashlib.sha256(value).hexdigest()
        manifest = dict(source=source, disabledTransformation='direct closed scalar array map callbacks',
            candidateCodegenSha256=digest(candidate), referenceCodegenSha256=digest(reference),
            ownershipSha256=digest(ownership), patchSha256=digest(patch), compilerSha256=digest(compiler))
        report = dict(referenceCompiler=manifest)
        contents = {'manifest.json': json.dumps(manifest).encode(), 'fwp': bytes(compiler),
                    'codegen-reference.rs': reference, 'reference.patch': patch}
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for name, value in contents.items():
                (root / name).write_bytes(value)
            RECOVER.verify_recovered_reference(root, report, source, 'aarch64')
            for name in ('fwp', 'codegen-reference.rs', 'reference.patch'):
                with self.subTest(file=name):
                    (root / name).write_bytes(contents[name] + b'changed')
                    with self.assertRaises(AssertionError):
                        RECOVER.verify_recovered_reference(root, report, source, 'aarch64')
                    (root / name).write_bytes(contents[name])
            for field in manifest:
                changed = copy.deepcopy(manifest)
                changed[field] += 'changed'
                (root / 'manifest.json').write_text(json.dumps(changed))
                with self.subTest(field=field), self.assertRaises(AssertionError):
                    RECOVER.verify_recovered_reference(root, report, source, 'aarch64')
            (root / 'manifest.json').write_bytes(contents['manifest.json'])
            with self.assertRaises(AssertionError):
                RECOVER.verify_recovered_reference(root, report, source, 'x86_64')
            with self.assertRaises(AssertionError):
                RECOVER.verify_recovered_reference(root, report, '0' * 40, 'aarch64')

    def test_reference_upload_tracks_the_selected_directory(self):
        workflow = (ROOT / '.github/workflows/numerics.yml').read_text()
        step = workflow.split('      - name: Preserve reference source and compiler identities\n', 1)[1].split('      - uses:', 1)[0]
        self.assertIn("hashFiles(format('{0}-reference/**', env.REFERENCE_KIND))", step)
        self.assertIn('path: ${{ env.REFERENCE_KIND }}-reference/', step)
        self.assertIn('if-no-files-found: error', step)


if __name__ == '__main__':
    unittest.main()
