#!/usr/bin/env python3
"""Verify full native coverage, stable Mac shards and failure propagation."""
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

SPEC = importlib.util.spec_from_file_location(
    "macos_shards", Path(__file__).with_name("run-native-tests.py"))
SHARDS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SHARDS)


def metadata(names):
    return {"packages": [{"manifest_path": str(SHARDS.ROOT / "Cargo.toml"),
                          "id": "root",
                          "targets": [
                              {"name": "fwp", "kind": ["lib"]},
                              {"name": "fwp", "kind": ["bin"]},
                              {"name": "demo", "kind": ["example"]},
                              {"name": "speed", "kind": ["bench"]},
                              {"name": "build-script-build", "kind": ["custom-build"]},
                          ] + [{"name": name, "kind": ["test"]} for name in names]}]}


class Coverage(unittest.TestCase):
    def assert_coverage(self, value, schedule):
        outputs = [SHARDS.command(value, shard, schedule) for shard in SHARDS.SHARDS]
        selected = [set(output[2]) for output in outputs]
        expected = {target['name'] for target in value['packages'][0]['targets']
                    if target['kind'] == ['test']}
        self.assertFalse(selected[0] & selected[1])
        self.assertEqual(selected[0] | selected[1], expected)
        for shard, output in zip(SHARDS.SHARDS, outputs):
            args = output[0]
            self.assertNotIn("build-script-build", args)
            self.assertIn("--no-fail-fast", args)
            self.assertEqual(args[-3:], ["--", "--skip", "golden_programs_under_gc_stress"])
            for flag in ["--lib", "--bins", "--examples", "--benches"]:
                self.assertEqual(flag in args, shard == "regular")
            self.assertEqual([args[i + 1] for i, arg in enumerate(args) if arg == "--test"], output[2])

    def test_repository_targets_are_assigned_exactly_once(self):
        value = json.loads(subprocess.check_output(
            ["cargo", "metadata", "--no-deps", "--format-version", "1"], cwd=SHARDS.ROOT))
        self.assert_coverage(value, SHARDS.assignment(SHARDS.SCHEDULE))

    def test_all_targets_preserve_unit_targets_and_stress_cases(self):
        value = metadata(["z", "a", "b"])
        schedule = {"regular": ["a", "z"], "gc": ["b"]}
        args, available, selected = SHARDS.command(value, "all", schedule)
        self.assertEqual(args, ["cargo", "test", "--no-fail-fast", "--all-targets", "--"])
        self.assertEqual(available, ["a", "b", "z"])
        self.assertEqual(selected, available)
        keys = [("lib", "fwp"), ("bin", "fwp"), ("example", "demo"),
                ("bench", "speed"), *[("test", name) for name in available]]
        messages = [{"reason": "compiler-artifact", "package_id": "root",
                     "target": {"kind": [kind], "name": name},
                     "profile": {"test": True}, "executable": f"/{kind}-{name}"}
                    for kind, name in keys]
        encode = lambda rows: "\n".join(json.dumps(row) for row in rows)
        result = SHARDS.test_executables(encode(messages), value, "all", selected)
        self.assertEqual({key for key, _ in result}, set(keys))
        for missing in range(len(messages)):
            with self.assertRaises(ValueError):
                SHARDS.test_executables(encode(messages[:missing] + messages[missing + 1:]),
                                       value, "all", selected)
        with self.assertRaises(ValueError):
            SHARDS.command(metadata(["a", "b", "z", "new"]), "all", schedule)

    def test_new_targets_do_not_move_existing_work(self):
        before = {"regular": ["a", "z"], "gc": ["b"]}
        after = {"regular": ["a", "z"], "gc": ["b", "new"]}
        self.assert_coverage(metadata(["z", "a", "b"]), before)
        self.assert_coverage(metadata(["new", "z", "a", "b"]), after)
        for shard in SHARDS.SHARDS:
            old = SHARDS.command(metadata(["a", "b", "z"]), shard, before)[2]
            new = SHARDS.command(metadata(["a", "b", "z", "new"]), shard, after)[2]
            self.assertEqual(old, [name for name in new if name != "new"])

    def test_explicit_order_survives_cargo_artifact_order(self):
        value = metadata(["a", "b", "z"])
        schedule = {"regular": ["b"], "gc": ["z", "a"]}
        args, _, selected = SHARDS.command(value, "gc", schedule)
        self.assertEqual(selected, ["z", "a"])
        self.assertEqual([args[i + 1] for i, arg in enumerate(args) if arg == "--test"],
                         ["z", "a"])
        messages = [{"reason": "compiler-artifact", "package_id": "root",
                     "target": {"kind": ["test"], "name": name},
                     "profile": {"test": True}, "executable": f"/{name}"}
                    for name in ["a", "z"]]
        result = SHARDS.test_executables("\n".join(json.dumps(row) for row in messages),
                                        value, "gc", selected)
        self.assertEqual([key[1] for key, _ in result], ["z", "a"])

    def test_unassigned_obsolete_duplicate_and_unknown_targets_fail(self):
        schedule = {"regular": ["a"], "gc": ["b"]}
        invalid = metadata(["a", "b"])
        invalid["packages"][0]["targets"].append({"name": "new", "kind": ["custom"]})
        for value in [invalid, metadata(["a", "a"]), metadata([]),
                      metadata(["a"]), metadata(["a", "b", "new"])]:
            with self.assertRaises(ValueError):
                SHARDS.command(value, "regular", schedule)
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "schedule.json"
            for schedule in [{"regular": ["a"], "gc": ["a"]},
                             {"regular": ["a"], "gc": []}, {"regular": ["a"]}]:
                path.write_text(json.dumps(schedule))
                with self.assertRaises(ValueError):
                    SHARDS.assignment(path)

    def test_failed_test_command_is_not_reported_as_success(self):
        with patch("sys.argv", ["run-native-tests.py", "--shard", "gc", "--logs", "/unused"]), \
             patch.object(SHARDS, "assignment", return_value={"regular": ["a"], "gc": ["b"]}), \
             patch.object(SHARDS.subprocess, "check_output", return_value=json.dumps(metadata(["a", "b"])).encode()), \
             patch.object(SHARDS.subprocess, "run", side_effect=subprocess.CalledProcessError(1, ["cargo", "test"])):
            with self.assertRaises(subprocess.CalledProcessError):
                SHARDS.main()

    def test_artifact_coverage_includes_units_and_rejects_missing_or_duplicate(self):
        value = metadata(["a", "b"])
        keys = [("lib", "fwp"), ("bin", "fwp"), ("example", "demo"),
                ("bench", "speed"), ("test", "a")]
        messages = [{"reason": "compiler-artifact", "package_id": "root",
                     "target": {"kind": [kind], "name": name},
                     "profile": {"test": True}, "executable": f"/{kind}-{name}"}
                    for kind, name in keys]
        encode = lambda rows: "\n".join(json.dumps(row) for row in rows)
        unrelated = dict(messages[0], package_id="dependency")
        ordinary_build = dict(messages[0], profile={"test": False})
        result = SHARDS.test_executables(encode([unrelated, ordinary_build, *messages]),
                                        value, "regular", ["a"])
        self.assertEqual({key for key, _ in result}, set(keys))
        for rows in [messages[:-1], messages + [messages[0]],
                     messages + [dict(messages[-1], target={"kind": ["test"], "name": "b"})]]:
            with self.assertRaises(ValueError):
                SHARDS.test_executables(encode(rows), value, "regular", ["a"])
        shared = [dict(message, executable="/same") for message in messages]
        with self.assertRaises(ValueError):
            SHARDS.test_executables(encode(shared), value, "regular", ["a"])

    def test_two_executables_overlap_and_failures_do_not_skip_other_targets(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            executables = []
            for index in range(3):
                executable = root / f"probe-{index}"
                executable.write_text("#!/usr/bin/env python3\n" +
                    "import pathlib,sys,time\n" +
                    f"root=pathlib.Path({str(root)!r}); index={index}\n" +
                    "assert sys.argv[1:]==['--test-threads=1','--skip','golden_programs_under_gc_stress']\n" +
                    "(root / f'started-{index}').touch()\n" +
                    "if index<2:\n" +
                    "    limit=time.monotonic()+3\n" +
                    "    while not (root / f'started-{1-index}').exists():\n" +
                    "        if time.monotonic()>limit: sys.exit(9)\n" +
                    "        time.sleep(0.01)\n" +
                    "print(f'executed {index}')\n" +
                    "sys.exit(7 if index==1 else 0)\n")
                executable.chmod(0o755)
                executables.append((("test", str(index)), str(executable)))
            code = SHARDS.run_tests(executables,
                                    ["--skip", "golden_programs_under_gc_stress"], root / "logs")
            self.assertEqual(code, 1)
            for index in range(3):
                self.assertTrue((root / f"started-{index}").exists())
                self.assertEqual((root / "logs" / f"test-{index}.log").read_text(),
                                 f"executed {index}\n")
            with patch.object(SHARDS.subprocess, "run", return_value=subprocess.CompletedProcess([], 0)):
                self.assertEqual(SHARDS.run_tests(executables, [], root / "passing"), 0)


if __name__ == "__main__":
    unittest.main()
