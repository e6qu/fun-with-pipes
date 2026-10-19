#!/usr/bin/env python3
"""Keep incomplete or interleaved CI logs from producing misleading evidence."""
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location(
    "collection_report", Path(__file__).with_name("summarize-collection-build.py"))
REPORT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REPORT)

# Cargo emits headers on stderr and test summaries on stdout. This order occurs
# in the real Linux ARM64 log: the second header arrives before the first summary.
LOG = """Running tests/cached_map_borrows.rs (target/debug/deps/borrow)
test result: ok. 3 passed; 0 failed; 0 ignored;
Running tests/caf_ownership.rs (target/debug/deps/caf)
test result: ok. 3 passed; 0 failed; 0 ignored;
Running tests/collection_construction.rs (target/debug/deps/collection)
Running tests/decoder_partial.rs (target/debug/deps/decoder)
test result: ok. 3 passed; 0 failed; 0 ignored;
test result: ok. 1 passed; 0 failed; 0 ignored;
Running tests/inline_caf_ownership.rs (target/debug/deps/inline)
test result: ok. 2 passed; 0 failed; 0 ignored;
Running tests/map_set_ownership.rs (target/debug/deps/maps)
test result: ok. 6 passed; 0 failed; 0 ignored;
Running tests/mapped_array_construction.rs (target/debug/deps/arrays)
test result: ok. 3 passed; 0 failed; 0 ignored;
Running tests/numeric_array_fusion.rs (target/debug/deps/fusion)
test result: ok. 2 passed; 0 failed; 0 ignored;
Running tests/protocol.rs (target/debug/deps/protocol)
test result: ok. 9 passed; 0 failed; 0 ignored;
Running tests/range_set.rs (target/debug/deps/range_set)
test result: ok. 3 passed; 0 failed; 0 ignored;
Running tests/repl.rs (target/debug/deps/repl)
test result: ok. 8 passed; 0 failed; 0 ignored;
Running tests/static_constants.rs (target/debug/deps/constants)
test result: ok. 1 passed; 0 failed; 0 ignored;
"""


class CollectionEvidence(unittest.TestCase):
    def test_range_requests_reject_extra_allocations_and_incomplete_sizes(self):
        for direct in [False, True]:
            good = "\n".join(
                f"keys={n} requests={(1 if direct else n+3) if n else 0} "
                f"requested_bytes={(8+8*n if direct else 16+48*n) if n else 0}"
                for n in [0, 1, 7, 257, 4096]) + "\n"
            with tempfile.TemporaryDirectory() as temporary:
                path = Path(temporary) / 'requests.txt'
                path.write_text(good)
                rows = REPORT.range_requests(path, direct)
                self.assertEqual(rows[-1]['requests'], 1 if direct else 4099)
                for bad in [good.replace('keys=7', 'keys=8'), good + good,
                            good.rsplit('keys=', 1)[0], good.replace('requests=0', 'requests=1'),
                            good.replace('requested_bytes=0', 'requested_bytes=8')]:
                    path.write_text(bad)
                    with self.subTest(direct=direct, bad=bad), self.assertRaises(AssertionError):
                        REPORT.range_requests(path, direct)

    def test_set_requests_reject_waste_and_incomplete_measurements(self):
        good = "\n".join(f"keys={n} requested={8+8*n if n else 0} charged={8+8*n if n else 0}"
                         for n in [0, 1, 7, 257, 4096]) + "\n"
        with tempfile.TemporaryDirectory() as temporary:
            path = Path(temporary) / 'requests.txt'
            path.write_text(good)
            rows = REPORT.set_requests(path)
            self.assertEqual(rows[-1]['requestedBytes'], 32776)
            self.assertEqual(rows[-1]['previousLayoutRequestBytes'], 65544)
            for bad in [good.replace('requested=16 charged=16', 'requested=24 charged=24'),
                        good.replace('charged=16', 'charged=8'),
                        good.replace('keys=7', 'keys=8'), good + good,
                        good.rsplit('keys=', 1)[0], good.replace('requested=64', 'requested=-1')]:
                path.write_text(bad)
                with self.subTest(bad=bad), self.assertRaises(AssertionError):
                    REPORT.set_requests(path)

    def test_rejected_runs_preserve_metadata_without_certifying_evidence(self):
        head = 'a' * 40
        for status, conclusion in [('completed', 'failure'), ('completed', 'cancelled'),
                                   ('in_progress', '')]:
            metadata = {'headSha': head, 'status': status, 'conclusion': conclusion,
                        'jobs': [{'name': 'collection_build (macos-15-intel)',
                                  'status': status, 'conclusion': 'cancelled'}]}
            with self.subTest(status=status, conclusion=conclusion), tempfile.TemporaryDirectory() as temporary:
                folder = Path(temporary)
                arguments = ['summarize-collection-build.py', '--run', '123', '--head', head,
                             '--artifacts', str(folder / 'artifacts'), '--llvm-bin', '/unused',
                             '--output', str(folder / 'report.json')]
                with patch('sys.argv', arguments), patch.object(REPORT, 'command', return_value=json.dumps(metadata)), self.assertRaises(AssertionError):
                    REPORT.main()
                self.assertEqual(json.loads((folder / 'artifacts/run.json').read_text()), metadata)
                self.assertEqual(json.loads((folder / 'artifacts/request.json').read_text()), {'run': 123, 'head': head})
                self.assertFalse((folder / 'report.json').exists())

    def test_interleaved_streams_and_windows_paths(self):
        for log in [LOG, LOG.replace("tests/", "tests\\").replace(
                "Running", "\x1b[1;32mRunning\x1b[0m")]:
            self.assertEqual(sum(REPORT.audit_tests(log).values()), 44)

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
