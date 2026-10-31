"""Reject damaged callable phase evidence and ambiguous binary accounting."""
import importlib.util
from pathlib import Path
import unittest


SPEC = importlib.util.spec_from_file_location(
    "callable_results", Path(__file__).with_name("returned-callable-results.py"))
RESULTS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(RESULTS)


def success_record():
    # A small valid ledger with the observed first-use count-table allocation.
    rows = []
    metadata = 0
    for kind in range(2):
        for n in RESULTS.COUNTS:
            rows += [f"phase {kind} {n} 0 1 16 0 0 0 0 16 16 0 16 {metadata} 4096",
                     f"phase {kind} {n} 1 0 0 0 {n} {n} {2*n} 16 16 16 16 4096 4096",
                     f"phase {kind} {n} 2 0 0 1 0 1 0 16 0 16 0 4096 4096"]
            metadata = 4096
    return "\n".join(rows) + "\n"


class CallableRecords(unittest.TestCase):
    def test_complete_phases_keep_retained_metadata_visible(self):
        rows = RESULTS.phases(success_record(), "success")
        self.assertEqual(len(rows), 24)
        self.assertEqual(rows[-1]["finalRequestedBytes"], 0)
        self.assertEqual(rows[-1]["finalCountBytes"], 4096)
        self.assertEqual(sum(row["retains"] for row in rows), 2 * (1 + 16 + 4096))

    def test_missing_reordered_negative_and_discontinuous_rows_fail(self):
        text = success_record()
        lines = text.splitlines()
        damaged = ["", "\n".join(lines[1:]), text + lines[0],
                   "\n".join([lines[1], lines[0], *lines[2:]]),
                   text.replace("0 1 16 0 0 0 0", "0 -1 16 0 0 0 0", 1),
                   text.replace("16 16 0 16 0 4096", "16 16 1 16 0 4096", 1),
                   text.replace("16 16 0 16 0 4096", "15 16 0 16 0 4096", 1),
                   text.replace("phase", "unknown", 1)]
        for value in damaged:
            with self.subTest(value=value[:80]), self.assertRaises(ValueError):
                RESULTS.phases(value, "success")

    def test_lost_release_and_hidden_invocation_fail(self):
        text = success_record()
        for old, new in (
            ("0 0 1 0 1 0 16 0 16 0", "0 0 0 0 0 0 16 16 16 16"),
            ("0 0 0 1 1 2 16 16", "0 0 0 1 0 2 16 16"),
            ("0 0 0 1 1 2 16 16", "0 0 0 1 1 0 16 16"),
            ("1 16 0 0 0 0 16 16", "0 16 0 0 0 0 16 16"),
        ):
            with self.subTest(old=old), self.assertRaises(ValueError):
                RESULTS.phases(text.replace(old, new, 1), "success")
        with self.assertRaises(ValueError):
            RESULTS.phases(text, "omit-release")

    def test_failure_and_retry_need_both_allocations_and_frees(self):
        lines = []
        metadata = 0
        for kind in range(2):
            for n in (0, 8):
                lines.append(f"phase {kind} {n} 3 2 32 2 {n+1} {n+3} {2*(n+1)} 16 0 0 0 {metadata} 4096")
                metadata = 4096
        text = "\n".join(lines)
        self.assertEqual(len(RESULTS.phases(text, "recovery")), 4)
        for old, new in (("3 2 32 2", "3 1 16 1"), ("3 2 32 2", "3 2 32 1"),
                         ("16 0 0 0", "16 16 0 16")):
            with self.subTest(old=old), self.assertRaises(ValueError):
                RESULTS.phases(text.replace(old, new, 1), "recovery")

    def test_binary_bytes_exclude_shared_runtime_from_workers(self):
        instructions = [dict(section=".text", address=hex(16 + i * 4), encoding="d65f03c0", function=name)
                        for i, name in enumerate(("_returned_make", "_returned_direct", "_w3", "_fwp_heap_alloc"))]
        code = RESULTS.code_sizes(instructions, "fwp")
        self.assertEqual(code["workerDecodedBytes"], 12)
        self.assertEqual(code["allDecodedBytes"], 16)
        for damaged in ([], instructions[1:], instructions + [instructions[0]],
                        [dict(instructions[0], encoding="?"), *instructions[1:]],
                        [dict(instructions[0], encoding="00" * 8), *instructions[1:]]):
            with self.subTest(damaged=damaged), self.assertRaises(ValueError):
                RESULTS.code_sizes(damaged, "fwp")


if __name__ == "__main__":
    unittest.main()
