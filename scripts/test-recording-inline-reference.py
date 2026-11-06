"""Keep the checked append body identical and its counters valid in both versions."""
import difflib
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-recording-inline-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
SPEC = importlib.util.spec_from_file_location('selection', ROOT / 'scripts/check-recording-lookup-selection.py')
SELECTION = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SELECTION)
SPEC = importlib.util.spec_from_file_location('evidence', ROOT / 'scripts/check-array-list-evidence.py')
EVIDENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(EVIDENCE)


class RecordingInlineReference(unittest.TestCase):
    def test_reference_changes_only_declaration(self):
        current = {name: (ROOT / name).read_text() for name in REFERENCE.EDITS}
        result = REFERENCE.reference_sources(current)
        name = 'runtime/fwp_rt_kernel.c'
        before, after = REFERENCE.EDITS[name]
        self.assertEqual(result[name].replace(after, before), current[name])
        self.assertEqual(result[name].count(after), 1)
        self.assertIn('src/cgen.rs', REFERENCE.PRESERVED)
        self.assertIn('src/cgen/recording.rs', REFERENCE.PRESERVED)
        self.assertNotIn(name, REFERENCE.PRESERVED)
        SELECTION.check_inline_declaration(current[name], True)
        SELECTION.check_inline_declaration(result[name], False)
        for source, forced in [(current[name], False), (result[name], True), ('', True)]:
            with self.assertRaises(AssertionError):
                SELECTION.check_inline_declaration(source, forced)
        marker = '    /* Ownership observation point: before runtime teardown. */\n'
        candidate = SELECTION.instrument(current[name] + marker)
        reference = SELECTION.instrument(result[name] + marker)
        self.assertEqual(reference.replace(after, before), candidate)
        for field in ('lookups', 'parents', 'capacities', 'nodes'):
            self.assertEqual(candidate.count('recording_' + field + '++;'), 1)

    def test_complete_runtime_reference_manifest_and_corruption(self):
        revision = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
        name = 'runtime/fwp_rt_kernel.c'
        current = subprocess.check_output(['git', 'show', revision + ':' + name], cwd=ROOT, text=True)
        reference = REFERENCE.reference_sources({name: current})[name]
        differences = ''.join(difflib.unified_diff(current.splitlines(True), reference.splitlines(True),
                              fromfile='a/' + name, tofile='b/' + name))
        delta = f'diff --git a/{name} b/{name}\nindex 0000000..1111111 100644\n' + differences
        sha = lambda data: hashlib.sha256(data).hexdigest()
        manifest = dict(source=revision,
                        disabledTransformation='forced inlining of the checked F64 scalar append body',
                        candidate={name: sha(current.encode())}, reference={name: sha(reference.encode())},
                        unchanged={path: sha(subprocess.check_output(['git', 'show', revision + ':' + path], cwd=ROOT)) for path in REFERENCE.PRESERVED},
                        compilerSha256=sha(b'compiler fixture'), patchSha256=sha(delta.encode()))
        manifest['ownershipSha256'] = manifest['unchanged']['src/ownership.rs']
        with tempfile.TemporaryDirectory() as temp, patch.object(EVIDENCE, 'instruction_bytes') as inspect:
            folder = Path(temp)
            (folder / 'fwp').write_bytes(b'compiler fixture')
            (folder / 'reference.patch').write_text(delta)
            target = folder / 'source' / name
            target.parent.mkdir(parents=True)
            target.write_text(reference)
            (folder / 'manifest.json').write_text(json.dumps(manifest))
            EVIDENCE.check_reference(folder, dict(referenceCompiler=manifest), revision, 'aarch64', 'recording-inline')
            inspect.assert_called_once_with(b'compiler fixture', 'aarch64')
            for mode in ('missing-preserved-source', 'changed-body', 'changed-patch', 'extra-source', 'wrong-source-path'):
                altered = json.loads(json.dumps(manifest))
                if mode == 'missing-preserved-source':
                    del altered['unchanged']['src/cgen.rs']
                elif mode == 'changed-body':
                    target.write_text(reference + '\n/* extra edit */\n')
                    altered['reference'][name] = sha(target.read_bytes())
                elif mode == 'changed-patch':
                    (folder / 'reference.patch').write_text(delta + '\nextra edit\n')
                    altered['patchSha256'] = sha((folder / 'reference.patch').read_bytes())
                else:
                    extra = folder / 'source/src/cgen.rs'
                    extra.parent.mkdir(parents=True, exist_ok=True)
                    extra.write_text(reference)
                    if mode == 'wrong-source-path':
                        target.unlink()
                (folder / 'manifest.json').write_text(json.dumps(altered))
                with self.subTest(mode=mode), self.assertRaises(AssertionError):
                    EVIDENCE.check_reference(folder, dict(referenceCompiler=altered), revision, 'aarch64', 'recording-inline')
                (folder / 'source/src/cgen.rs').unlink(missing_ok=True)
                target.write_text(reference)
                (folder / 'reference.patch').write_text(delta)

    def test_reject_missing_duplicate_wrong_declaration(self):
        for name, (before, after) in REFERENCE.EDITS.items():
            source = (ROOT / name).read_text()
            for replacement in ['', before + before, after, before.replace('always_inline', 'noinline')]:
                with self.subTest(replacement=replacement), self.assertRaises(AssertionError):
                    REFERENCE.reference_sources({name: source.replace(before, replacement)})
        with self.assertRaises(AssertionError):
            REFERENCE.reference_sources({})

    def test_instrumentation_rejects_missing_duplicate_or_unsupported_body(self):
        source = (ROOT / 'runtime/fwp_rt_kernel.c').read_text()
        name = 'runtime/fwp_rt_kernel.c'
        before, _ = REFERENCE.EDITS[name]
        for replacement in ['', before + '\n' + before, before.replace('always_inline', 'noinline')]:
            with self.subTest(replacement=replacement), self.assertRaises(AssertionError):
                SELECTION.instrument(source.replace(before, replacement))


if __name__ == '__main__':
    unittest.main()
