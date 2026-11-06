"""Reject lost scopes, changed tape checks and incomplete comparison evidence."""
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location('context_reference', ROOT / 'scripts/prepare-recording-context-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
SPEC = importlib.util.spec_from_file_location('context_selection', ROOT / 'scripts/check-recording-context-selection.py')
SELECTION = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SELECTION)
SPEC = importlib.util.spec_from_file_location('context_evidence', ROOT / 'scripts/check-array-list-evidence.py')
EVIDENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(EVIDENCE)


class RecordingContextReference(unittest.TestCase):
    def test_reference_disables_only_new_scopes(self):
        current = {'src/cgen.rs': (ROOT / 'src/cgen.rs').read_text()}
        reference = REFERENCE.reference_sources(current)
        before, after = REFERENCE.EDITS['src/cgen.rs']
        self.assertEqual(reference['src/cgen.rs'].replace(after, before), current['src/cgen.rs'])
        for setting in ('AD_RECORDING_LOOKUPS', 'SCALAR_CONSTANT_VALUES', 'PACKED_PAIR_REUSE', 'GRADIENT_CALL_STORAGE'):
            self.assertIn(f'const {setting}: bool = true;', reference['src/cgen.rs'])
        for changed in ('', before + before, after):
            with self.assertRaises(AssertionError):
                REFERENCE.reference_sources({'src/cgen.rs': current['src/cgen.rs'].replace(before, changed)})
        with self.assertRaises(AssertionError):
            REFERENCE.reference_sources({})

    def test_all_cases_keep_node_parent_and_capacity_work(self):
        for dimensions, updates, solves in ((3, 0, 32768), (3, 1, 512), (3, 199, 32),
                                           (3, 1999, 4), (33, 199, 32), (129, 199, 8)):
            pairs = (dimensions - 1) * updates * solves
            for enabled in (False, True):
                counts = dict(lookups=2 * updates * solves if enabled else 3 * pairs,
                              parents=8 * pairs, capacities=8 * pairs, nodes=8 * pairs)
                SELECTION.check_counts(counts, dimensions, updates, solves, enabled)
                for field in counts:
                    for delta in (-1, 1):
                        with self.subTest(field=field), self.assertRaises(AssertionError):
                            SELECTION.check_counts(dict(counts, **{field: counts[field] + delta}), dimensions, updates, solves, enabled)

    def test_live_scope_graph_rejects_lost_state_and_incomplete_recording(self):
        state = SELECTION.STATE
        push = 'fwp_p_ad_push(a, b, c, d, recording);\n'
        bodies = {
            'f1': '/* Consume private overlapping windows; */\n' + state + '\n    for (size_t i=0; i<n; i++) {\n        w2(a, &recording);\n    }',
            'f2': '/* Fold after the complete packed map; */\n' + state + '\n    for (size_t i=0; i<n; i++) {\n        w3(a, &recording);\n    }',
            'w2': push * 6 + 'w3(a, recording);',
            'w3': push,
        }
        source = '\n'.join(f'static V {name}(V x, fwp_ad_recording *recording) {{\n{bodies[name]}\n}}' for name in ('w2', 'w3'))
        with patch.object(SELECTION.LOOKUP, 'check_capacity_gate'), patch.object(SELECTION.LOOKUP.SCALAR, 'check', return_value={}):
            with patch.object(SELECTION.LOOKUP.SCALAR.PAIR.STORAGE, 'reachable_bodies', return_value=(bodies, set(bodies))):
                self.assertTrue(SELECTION.check(source, True)['enabled'])
            for name, before, after in (
                    ('f1', state, ''), ('f2', state, state.replace('-1', '0')),
                    ('f1', '&recording', '&(fwp_ad_recording){-1, NULL}'),
                    ('w2', 'd, recording', 'd, NULL'),
                    ('w2', 'w3(a, recording)', 'w3(a, &(fwp_ad_recording){-1, NULL})'),
                    ('w2', 'w3(a, recording)', 'w99(a, recording)')):
                changed = dict(bodies)
                changed[name] = changed[name].replace(before, after)
                with self.subTest(name=name, after=after), patch.object(
                        SELECTION.LOOKUP.SCALAR.PAIR.STORAGE, 'reachable_bodies', return_value=(changed, set(changed))), self.assertRaises(AssertionError):
                    SELECTION.check(source, True)

    def test_saved_reference_is_data_not_executable_code(self):
        current = {'src/cgen.rs': (ROOT / 'src/cgen.rs').read_text()}
        preparation = (ROOT / 'scripts/prepare-recording-context-reference.py').read_text()
        expected = REFERENCE.reference_sources(current)
        self.assertEqual(EVIDENCE.recorded_file_edits_reference(current, preparation + '\nraise RuntimeError("not code")\n', set(current)), expected)
        for changed in (preparation.replace('EDITS =', 'MISSING =', 1), preparation + '\nEDITS = {}\n'):
            with self.assertRaises(AssertionError):
                EVIDENCE.recorded_file_edits_reference(current, changed, set(current))

    def test_complete_context_reference_manifest_and_corruption(self):
        revision = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
        name = 'src/cgen.rs'
        current = subprocess.check_output(['git', 'show', revision + ':' + name], cwd=ROOT, text=True)
        reference = REFERENCE.reference_sources({name: current})[name]
        # Use the actual producer diff; validate its exact input and output.
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
                        disabledTransformation='validated recording state shared through closed numeric calls and loops',
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
            EVIDENCE.check_reference(folder, dict(referenceCompiler=manifest), revision, 'aarch64', 'recording-context')
            inspect.assert_called_once_with(b'compiler fixture', 'aarch64')
            for mode in ('missing-preserved-source', 'changed-body', 'changed-patch', 'extra-source', 'wrong-source-path'):
                altered = json.loads(json.dumps(manifest))
                if mode == 'missing-preserved-source':
                    del altered['unchanged']['src/cgen/recording.rs']
                elif mode == 'changed-body':
                    target.write_text(reference + '\n/* extra edit */\n')
                    altered['reference'][name] = sha(target.read_bytes())
                elif mode == 'changed-patch':
                    (folder / 'reference.patch').write_text(delta + '\nextra edit\n')
                    altered['patchSha256'] = sha((folder / 'reference.patch').read_bytes())
                else:
                    extra = folder / 'source/runtime/fwp_rt_kernel.c'
                    extra.parent.mkdir(parents=True, exist_ok=True)
                    extra.write_text(reference)
                    if mode == 'wrong-source-path':
                        target.unlink()
                (folder / 'manifest.json').write_text(json.dumps(altered))
                with self.subTest(mode=mode), self.assertRaises(AssertionError):
                    EVIDENCE.check_reference(folder, dict(referenceCompiler=altered), revision, 'aarch64', 'recording-context')
                (folder / 'source/runtime/fwp_rt_kernel.c').unlink(missing_ok=True)
                target.write_text(reference)
                (folder / 'reference.patch').write_text(delta)


if __name__ == '__main__':
    unittest.main()
