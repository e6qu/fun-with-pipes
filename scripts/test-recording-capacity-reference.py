"""Keep reserve reconstruction exact and preserve recording observers."""
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-recording-capacity-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
SPEC = importlib.util.spec_from_file_location('selection', ROOT / 'scripts/check-recording-lookup-selection.py')
SELECTION = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SELECTION)
SPEC = importlib.util.spec_from_file_location('evidence', ROOT / 'scripts/check-array-list-evidence.py')
EVIDENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(EVIDENCE)


class RecordingCapacityReference(unittest.TestCase):
    def test_growth_body_and_recording_observers_are_unchanged(self):
        name = 'runtime/fwp_rt_kernel.c'
        source = (ROOT / name).read_text()
        reference = REFERENCE.reference_sources({name: source})[name]
        (growth, checked), (gate, empty) = REFERENCE.EDITS[name]
        self.assertEqual(empty, '')
        self.assertEqual(source.replace(gate, '').replace(growth, checked), reference)
        self.assertEqual(source.split(growth, 1)[1].split('\n}\n', 1)[0],
                         reference.split(checked, 1)[1].split('\n}\n', 1)[0])
        marker = '    /* Ownership observation point: before runtime teardown. */\n'
        candidate_observed = SELECTION.instrument(source + marker)
        reference_observed = SELECTION.instrument(reference + marker)
        self.assertEqual(REFERENCE.reference_sources({name: candidate_observed})[name], reference_observed)
        for counter in ('lookups', 'parents', 'capacities', 'nodes'):
            self.assertEqual(candidate_observed.count('recording_' + counter + '++;'), 1)
        SELECTION.check_inline_declaration(source, True)
        SELECTION.check_inline_declaration(reference, True)
        SELECTION.check_capacity_gate(source, True)
        SELECTION.check_capacity_gate(reference, False)
        for text, split in ((source, False), (reference, True), ('', True)):
            with self.assertRaises(AssertionError):
                SELECTION.check_capacity_gate(text, split)

    def test_saved_literals_are_checked_without_executing_saved_code(self):
        current = {name: (ROOT / name).read_text() for name in REFERENCE.EDITS}
        preparation = (ROOT / 'scripts/prepare-recording-capacity-reference.py').read_text()
        expected = REFERENCE.reference_sources(current)
        paths = set(current)
        self.assertEqual(EVIDENCE.recorded_capacity_reference(current, preparation, paths), expected)
        self.assertEqual(EVIDENCE.recorded_capacity_reference(
            current, preparation + '\nraise RuntimeError("never run saved code")\n', paths), expected)
        for bad in (preparation.replace('EDITS =', 'MISSING =', 1),
                    preparation + '\nEDITS = {}\n',
                    preparation.replace("'runtime/fwp_rt_kernel.c':", "'wrong/file':", 1)):
            with self.subTest(source=bad), self.assertRaises(AssertionError):
                EVIDENCE.recorded_capacity_reference(current, bad, paths)
        for bad in ({}, expected, {name: text + text for name, text in current.items()}):
            with self.assertRaises(AssertionError):
                EVIDENCE.recorded_capacity_reference(bad, preparation, paths)

    def test_record_bound_cannot_be_mistaken_for_historical_column_gate(self):
        source = (ROOT / 'runtime/fwp_rt_kernel.c').read_text()
        bound = '''    size_t stride = t->owned ? 2 * sizeof(V) : sizeof(fwp_tape_op);
    size_t records = (size_t)PTRDIFF_MAX / stride;
    if ((uint64_t)limit > records) limit = (int64_t)records;
'''
        self.assertEqual(source.count(bound), 1)
        SELECTION.check_capacity_gate(source, True)
        for broken in (source.replace(bound, ''),
                       source.replace('PTRDIFF_MAX / stride', 'SIZE_MAX / stride'),
                       source.replace(bound, '').replace('    if (n <= t->cap) return;\n',
                                                          '    if (n <= t->cap) return;\n' + bound)):
            with self.assertRaises(AssertionError):
                SELECTION.check_capacity_gate(broken, True)

    def test_complete_runtime_reference_manifest_and_corruption(self):
        revision = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
        name = 'runtime/fwp_rt_kernel.c'
        current = subprocess.check_output(['git', 'show', revision + ':' + name], cwd=ROOT, text=True)
        reference = REFERENCE.reference_sources({name: current})[name]
        # Use the producer's actual diff implementation. Git and difflib align
        # the repeated closing braces differently in this runtime change.
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'candidate').write_text(current)
            (root / 'reference').write_text(reference)
            result = subprocess.run(['git', 'diff', '--no-index', '--', 'candidate', 'reference'],
                                    cwd=root, text=True, capture_output=True)
            self.assertEqual(result.returncode, 1, result.stderr)
            lines = result.stdout.splitlines(keepends=True)
            delta = (f'diff --git a/{name} b/{name}\n' + lines[1]
                     + f'--- a/{name}\n+++ b/{name}\n' + ''.join(lines[4:]))
        sha = lambda data: hashlib.sha256(data).hexdigest()
        manifest = dict(source=revision,
                        disabledTransformation='inlined checked reserve gate with shared tape growth',
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
            EVIDENCE.check_reference(folder, dict(referenceCompiler=manifest), revision, 'aarch64', 'recording-capacity')
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
                    EVIDENCE.check_reference(folder, dict(referenceCompiler=altered), revision, 'aarch64', 'recording-capacity')
                (folder / 'source/src/cgen.rs').unlink(missing_ok=True)
                target.write_text(reference)
                (folder / 'reference.patch').write_text(delta)

    def test_missing_duplicate_or_changed_gate_is_rejected(self):
        name = 'runtime/fwp_rt_kernel.c'
        source = (ROOT / name).read_text()
        for before, _ in REFERENCE.EDITS[name]:
            for replacement in ('', before + before, before.replace('fwp_tape_', 'wrong_tape_')):
                with self.subTest(replacement=replacement), self.assertRaises(AssertionError):
                    REFERENCE.reference_sources({name: source.replace(before, replacement)})
        bound = '    if (n < 0 || n > limit) fwp_trap("autodiff: the tape is full");\n'
        shortcut = '    if (n <= t->cap) return;\n'
        for replacement in ('', shortcut + bound):
            original = bound if not replacement else bound + shortcut
            with self.subTest(replacement=replacement), self.assertRaises(AssertionError):
                REFERENCE.reference_sources({name: source.replace(original, replacement)})
            with self.assertRaises(AssertionError):
                SELECTION.check_capacity_gate(source.replace(original, replacement), True)
        with self.assertRaises(AssertionError):
            REFERENCE.reference_sources({})
        reference = REFERENCE.reference_sources({name: source})
        with self.assertRaises(AssertionError):
            REFERENCE.reference_sources(reference)


if __name__ == '__main__':
    unittest.main()
