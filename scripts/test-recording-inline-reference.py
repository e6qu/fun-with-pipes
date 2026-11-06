"""Keep the checked append body identical and its counters valid in both versions."""
import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location('reference', ROOT / 'scripts/prepare-recording-inline-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
SPEC = importlib.util.spec_from_file_location('selection', ROOT / 'scripts/check-recording-lookup-selection.py')
SELECTION = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SELECTION)


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
