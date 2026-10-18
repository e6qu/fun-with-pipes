#!/usr/bin/env python3
"""Keep incomplete or interleaved CI logs from producing misleading evidence."""
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location(
    "collection_report", Path(__file__).with_name("summarize-collection-build.py"))
REPORT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REPORT)

# Cargo emits headers on stderr and test summaries on stdout. This order occurs
# in the real Linux ARM64 log: the second header arrives before the first summary.
LOG = """Running tests/collection_construction.rs (target/debug/deps/collection)
Running tests/map_set_ownership.rs (target/debug/deps/maps)
test result: ok. 3 passed; 0 failed; 0 ignored;
test result: ok. 5 passed; 0 failed; 0 ignored;
Running tests/mapped_array_construction.rs (target/debug/deps/arrays)
test result: ok. 3 passed; 0 failed; 0 ignored;
Running tests/numeric_array_fusion.rs (target/debug/deps/fusion)
test result: ok. 2 passed; 0 failed; 0 ignored;
"""


class CollectionEvidence(unittest.TestCase):
    def test_interleaved_streams_and_windows_paths(self):
        for log in [LOG, LOG.replace("tests/", "tests\\").replace(
                "Running", "\x1b[1;32mRunning\x1b[0m")]:
            self.assertEqual(sum(REPORT.audit_tests(log).values()), 13)

    def test_missing_wrong_and_duplicate_targets(self):
        for log in [LOG.rsplit("Running tests/", 1)[0],
                    LOG.replace("collection_construction.rs", "other.rs"),
                    LOG.replace("map_set_ownership.rs", "collection_construction.rs")]:
            with self.subTest(log=log), self.assertRaises(AssertionError):
                REPORT.audit_tests(log)

    def test_failed_ignored_and_incomplete_summaries(self):
        for replacement in ["FAILED. 2 passed; 1 failed; 0 ignored;",
                            "ok. 2 passed; 0 failed; 1 ignored;",
                            "ok. 2 passed; 0 failed; 0 ignored;", ""]:
            log = LOG.replace("ok. 3 passed; 0 failed; 0 ignored;", replacement, 1)
            with self.subTest(replacement=replacement), self.assertRaises(AssertionError):
                REPORT.audit_tests(log)


if __name__ == "__main__":
    unittest.main()
