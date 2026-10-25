#!/usr/bin/env python3
"""Prevent code examples from falsely satisfying documentation anchor checks."""

import importlib.util
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location(
    "roadmap", Path(__file__).with_name("check-roadmap.py"))
ROADMAP = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(ROADMAP)


class DocumentationAnchors(unittest.TestCase):
    def test_code_comment_cannot_satisfy_a_link(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "source.md").write_text("[Contract](target.md#ownership)\n")
            (root / "target.md").write_text("# Example\n```fwp\n# Ownership\n```\n")
            with patch.object(ROADMAP, "ROOT", root):
                with self.assertRaisesRegex(AssertionError, "missing heading"):
                    ROADMAP.check_links("source.md")

    def test_example_does_not_renumber_real_duplicate_headings(self):
        with tempfile.TemporaryDirectory() as temporary:
            path = Path(temporary) / "guide.md"
            path.write_text("# Example\n```fwp\n# Example\n```\n## Example ###\n")
            self.assertEqual(ROADMAP.headings(path), {"example", "example-1"})

    def test_embedded_shorter_or_other_fence_does_not_end_example(self):
        text = "````markdown\n```fwp\n# Hidden\n```\n~~~\n# Still hidden\n````\n## Visible\n"
        self.assertEqual(list(ROADMAP.markdown_headings(text)), ["Visible"])

    def test_tilde_indented_and_unclosed_examples(self):
        text = "   ~~~fwp\n# Hidden\n   ~~~~\n   ## Visible ##\n```text\n# Unclosed\n"
        self.assertEqual(list(ROADMAP.markdown_headings(text)), ["Visible"])


if __name__ == "__main__":
    unittest.main()
