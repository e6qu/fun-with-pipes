#!/usr/bin/env python3
"""Reject changed capture references and preserve the prepared production code."""
import hashlib
import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('capture_reference', ROOT / 'scripts/prepare-capture-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
CURRENT = (ROOT / 'src/opt.rs').read_text()


class CaptureReference(unittest.TestCase):
    def test_reference_restores_exact_preparation_production_code(self):
        restored = REFERENCE.reference_source(CURRENT)
        production = restored.split('#[cfg(test)]', 1)[0].rstrip() + '\n'
        self.assertEqual(hashlib.sha256(production.encode()).hexdigest(), 'dd3320de417633e5af3a9745e17c510b53dcfb29a50aa4397d67eeafe2325860')
        self.assertEqual(restored.split('#[cfg(test)]', 1)[1], CURRENT.split('#[cfg(test)]', 1)[1])

    def test_changed_or_duplicate_candidate_block_is_rejected(self):
        for changed in [CURRENT.replace(REFERENCE.CANDIDATE_BINDING, ''),
                        CURRENT.replace('let count = self.nlocals();', 'let count = 0;'),
                        CURRENT + REFERENCE.CANDIDATE_BINDING]:
            with self.subTest(changed=changed[-80:]), self.assertRaises(AssertionError):
                REFERENCE.reference_source(changed)

    def test_already_restored_or_partial_reference_is_rejected(self):
        for changed in [REFERENCE.reference_source(CURRENT),
                        CURRENT.replace('    fn fresh(', REFERENCE.ORIGINAL_METHOD + '    fn fresh(')]:
            with self.assertRaises(AssertionError):
                REFERENCE.reference_source(changed)


if __name__ == '__main__':
    unittest.main()
