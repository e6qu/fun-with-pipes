#!/usr/bin/env python3
"""Verify that macOS sharding preserves coverage and propagates failures."""

import importlib.util
import json
import subprocess
import unittest
from unittest.mock import patch

from pathlib import Path

SPEC = importlib.util.spec_from_file_location(
    "macos_shards", Path(__file__).with_name("run-macos-test-shard.py"))
SHARDS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SHARDS)


def metadata(names):
    return {"packages": [{"manifest_path": str(SHARDS.ROOT / "Cargo.toml"),
                          "targets": [
                              {"name": "fwp", "kind": ["lib"]},
                              {"name": "fwp", "kind": ["bin"]},
                              {"name": "demo", "kind": ["example"]},
                              {"name": "speed", "kind": ["bench"]},
                          ] + [{"name": name, "kind": ["test"]}
                               for name in names]}]}


class Coverage(unittest.TestCase):
    def test_partition_covers_odd_and_even_target_sets_once(self):
        for names in [["a", "b"], ["z", "golden_run", "a", "m", "b"]]:
            outputs = [SHARDS.command(metadata(names), shard)
                       for shard in SHARDS.SHARDS]
            selected = [set(output[2]) for output in outputs]
            self.assertFalse(selected[0] & selected[1])
            self.assertEqual(selected[0] | selected[1], set(names))
            for shard, output in zip(SHARDS.SHARDS, outputs):
                self.assertEqual(output, SHARDS.command(
                    metadata(list(reversed(names))), shard))
                args = output[0]
                self.assertIn("--no-fail-fast", args)
                self.assertEqual(args[-3:],
                                 ["--", "--skip", "golden_programs_under_gc_stress"])
                for flag in ["--lib", "--bins", "--examples", "--benches"]:
                    self.assertEqual(flag in args, shard == "regular")
                passed = [args[i + 1] for i, arg in enumerate(args) if arg == "--test"]
                self.assertEqual(passed, output[2])

    def test_unknown_or_duplicate_targets_fail_instead_of_disappearing(self):
        invalid = metadata(["a", "b"])
        invalid["packages"][0]["targets"].append({"name": "new", "kind": ["custom"]})
        for value in [invalid, metadata(["a", "a"]), metadata([])]:
            with self.assertRaises(ValueError):
                SHARDS.command(value, "regular")

    def test_failed_test_command_is_not_reported_as_success(self):
        with patch("sys.argv", ["run-macos-test-shard.py", "--shard", "gc"]), \
             patch.object(SHARDS.subprocess, "check_output",
                          return_value=json.dumps(metadata(["a", "b"])).encode()), \
             patch.object(SHARDS.subprocess, "run",
                          side_effect=subprocess.CalledProcessError(1, ["cargo", "test"])):
            with self.assertRaises(subprocess.CalledProcessError):
                SHARDS.main()


if __name__ == "__main__":
    unittest.main()
