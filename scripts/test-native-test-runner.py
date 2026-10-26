#!/usr/bin/env python3
"""Verify full native coverage, stable Mac shards and failure propagation."""
import importlib.util
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import time
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
            self.assertEqual(args[-3:], ["--", "--skip", "golden_programs_with_counted_ownership"])
            for flag in ["--lib", "--bins", "--examples", "--benches"]:
                self.assertEqual(flag in args, shard == "regular")
            self.assertEqual([args[i + 1] for i, arg in enumerate(args) if arg == "--test"], output[2])

    def test_focused_ownership_targets_have_production_coverage(self):
        workflow = (SHARDS.ROOT / ".github/workflows/numerics.yml").read_text()
        selections = re.findall(
            r"--targets (.*?) --idle-timeout \d+ --logs native-commands-evidence/targets",
            workflow)
        self.assertEqual(len(selections), 2, "Unix and Windows focused commands")
        unix, windows = [selection.split() for selection in selections]
        self.assertEqual(unix, windows)
        self.assertEqual(len(unix), len(set(unix)), "duplicate focused target")
        list_job = re.search(r"^  list_copy:\n(.*?)(?=^  \w+:\n|\Z)",
                             workflow, re.M | re.S).group(1)
        list_targets = set(re.findall(r"--test ([a-zA-Z0-9_]+)(?=\s|$)", list_job))
        self.assertTrue({"list_copy_ownership", "list_order_ownership",
                         "sort_callback_ownership"} <= list_targets)
        schedule = SHARDS.assignment(SHARDS.SCHEDULE)
        for target in set(unix) | list_targets:
            self.assertEqual(sum(target in names for names in schedule.values()), 1,
                             f"missing or duplicated macOS assignment: {target}")

        windows_workflow = (SHARDS.ROOT / ".github/workflows/windows.yml").read_text()
        selected = set()
        # Explicit PowerShell arrays must feed the native runner in that step.
        arrays = re.findall(
            r"\$testTargets = @\((.*?)\)\s*\n\s*python scripts/run-native-tests.py --targets \$testTargets\b",
            windows_workflow, re.S)
        self.assertTrue(arrays, "missing Windows target arrays")
        for array in arrays:
            self.assertEqual(re.sub(r"'[a-zA-Z0-9_]+'|[,\s]", "", array), "",
                             "Windows target arrays must contain explicit names")
            selected.update(re.findall(r"'([a-zA-Z0-9_]+)'", array))
        for line in windows_workflow.splitlines():
            if "cargo test" in line:
                selected.update(re.findall(r"--test ([a-zA-Z0-9_]+)(?=\s|$)", line))
            inline = re.search(
                r"python(?:3)? scripts/run-native-tests.py --targets ([^$]+?) --idle-timeout",
                line)
            if inline:
                selected.update(inline.group(1).split())
        # Linux's /proc/strace suite does not establish Windows execution.
        # Windows uses its own native storage checks, not a skipped Linux test.
        required = {"windows_static_memory" if target == "static_memory" else target
                    for target in unix} | list_targets
        self.assertFalse(required - selected,
                         f"focused targets absent from Windows production: {sorted(required - selected)}")

    def test_sort_artifacts_are_inspected_on_their_production_shards(self):
        workflow = (SHARDS.ROOT / ".github/workflows/ci.yml").read_text()
        schedule = SHARDS.assignment(SHARDS.SCHEDULE)
        windows = (SHARDS.ROOT / ".github/workflows/windows.yml").read_text()
        for group, target in [("list-copy", "sort_callback_ownership"),
                              ("array-sort", "array_element_ownership"),
                              ("array-construction", "array_element_ownership")]:
            jobs = {"test"}
            jobs.update({"regular": "macos", "ownership": "macos_ownership"}[shard]
                        for shard, names in schedule.items() if target in names)
            for job in jobs:
                body = re.search(rf"^  {job}:\n(.*?)(?=^  \w+:\n|\Z)",
                                 workflow, re.M | re.S).group(1)
                self.assertIn(f"scripts/inspect-{group}.py --input ownership-evidence/arc/{group}", body)
                self.assertIn(f"--output ownership-evidence/{group}-inspection.json", body)
            self.assertIn(f"scripts/inspect-{group}.py --input ownership-evidence/arc/{group}", windows)
            self.assertIn(f"--output ownership-evidence/{group}-inspection.json", windows)
        bench = re.search(r"^  bench:\n(.*?)(?=^  \w+:\n|\Z)",
                          workflow, re.M | re.S).group(1)
        self.assertIn("scripts/measure-list-sort-storage.py --compiler target/release/fwp", bench)
        self.assertIn("scripts/inspect-list-sort-storage.py --input target/list-sort-storage", bench)
        self.assertIn("            target/list-sort-storage/", bench)
        self.assertIn("            target/list-sort-inspection.json", bench)
        self.assertIn("scripts/measure-array-sort-layout.py measure", bench)
        self.assertIn("            target/array-sort-layout/", bench)
        self.assertIn("            target/array-sort-layout-inspection.json", bench)

    def test_file_application_artifacts_follow_the_native_shards(self):
        workflow = (SHARDS.ROOT / ".github/workflows/ci.yml").read_text()
        schedule = SHARDS.assignment(SHARDS.SCHEDULE)
        targets = {"directory_report", "text_file_tools"}
        jobs = {"test"}
        jobs.update({"regular": "macos", "ownership": "macos_ownership"}[shard]
                    for shard, names in schedule.items() if targets & set(names))
        for job in jobs:
            body = re.search(rf"^  {job}:\n(.*?)(?=^  \w+:\n|\Z)",
                             workflow, re.M | re.S).group(1)
            environment, steps = body.split("    steps:", 1)
            self.assertIn("FWP_FILE_APPLICATION_ARTIFACTS: ownership-evidence/file-applications",
                          environment, job)
            self.assertIn("path: ownership-evidence/", steps, job)
        windows = (SHARDS.ROOT / ".github/workflows/windows.yml").read_text()
        environment, steps = windows.split("    steps:", 1)
        self.assertIn("FWP_FILE_APPLICATION_ARTIFACTS: ownership-evidence/file-applications",
                      environment)
        self.assertIn("ownership-evidence/", steps)

    def test_http_application_artifacts_follow_the_native_shards(self):
        workflow = (SHARDS.ROOT / ".github/workflows/ci.yml").read_text()
        schedule = SHARDS.assignment(SHARDS.SCHEDULE)
        targets = {"http_server"}
        jobs = {"test"}
        jobs.update({"regular": "macos", "ownership": "macos_ownership"}[shard]
                    for shard, names in schedule.items() if targets & set(names))
        for job in jobs:
            body = re.search(rf"^  {job}:\n(.*?)(?=^  \w+:\n|\Z)",
                             workflow, re.M | re.S).group(1)
            environment, steps = body.split("    steps:", 1)
            self.assertIn("FWP_HTTP_APPLICATION_ARTIFACTS: ownership-evidence/http-application",
                          environment, job)
            self.assertIn("path: ownership-evidence/", steps, job)
        windows = (SHARDS.ROOT / ".github/workflows/windows.yml").read_text()
        environment, steps = windows.split("    steps:", 1)
        self.assertIn("FWP_HTTP_APPLICATION_ARTIFACTS: ownership-evidence/http-application",
                      environment)
        self.assertIn("ownership-evidence/", steps)

    def test_map_failure_artifacts_follow_the_native_shards(self):
        workflow = (SHARDS.ROOT / ".github/workflows/ci.yml").read_text()
        schedule = SHARDS.assignment(SHARDS.SCHEDULE)
        targets = {"map_set_ownership"}
        jobs = {"test"}
        jobs.update({"regular": "macos", "ownership": "macos_ownership"}[shard]
                    for shard, names in schedule.items() if targets & set(names))
        for job in jobs:
            body = re.search(rf"^  {job}:\n(.*?)(?=^  \w+:\n|\Z)",
                             workflow, re.M | re.S).group(1)
            environment, steps = body.split("    steps:", 1)
            self.assertIn("FWP_MAP_FAILURE_ARTIFACTS: ownership-evidence/maps",
                          environment, job)
            self.assertIn("path: ownership-evidence/", steps, job)
        windows = (SHARDS.ROOT / ".github/workflows/windows.yml").read_text()
        environment, steps = windows.split("    steps:", 1)
        self.assertIn("FWP_MAP_FAILURE_ARTIFACTS: ownership-evidence/maps",
                      environment)
        self.assertIn("ownership-evidence/", steps)

    def test_stack_guard_artifacts_follow_the_native_shards(self):
        workflow = (SHARDS.ROOT / ".github/workflows/ci.yml").read_text()
        schedule = SHARDS.assignment(SHARDS.SCHEDULE)
        jobs = {"test"}
        jobs.update({"regular": "macos", "ownership": "macos_ownership"}[shard]
                    for shard, names in schedule.items() if "static_memory" in names)
        for job in jobs:
            body = re.search(rf"^  {job}:\n(.*?)(?=^  \w+:\n|\Z)",
                             workflow, re.M | re.S).group(1)
            environment, steps = body.split("    steps:", 1)
            self.assertIn("FWP_STATIC_GUARD_ARTIFACTS: ownership-evidence/static-guards",
                          environment, job)
            if job == "test":
                self.assertIn("FWP_TASK_CONTEXT_ARTIFACTS: ownership-evidence/task-context",
                              environment, job)
            self.assertIn("path: ownership-evidence/", steps, job)

    def test_repository_targets_are_assigned_exactly_once(self):
        value = json.loads(subprocess.check_output(
            ["cargo", "metadata", "--no-deps", "--format-version", "1"], cwd=SHARDS.ROOT))
        self.assert_coverage(value, SHARDS.assignment(SHARDS.SCHEDULE))

    def test_all_targets_preserve_unit_targets_and_golden_cases(self):
        value = metadata(["z", "a", "b"])
        schedule = {"regular": ["a", "z"], "ownership": ["b"]}
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
        before = {"regular": ["a", "z"], "ownership": ["b"]}
        after = {"regular": ["a", "z"], "ownership": ["b", "new"]}
        self.assert_coverage(metadata(["z", "a", "b"]), before)
        self.assert_coverage(metadata(["new", "z", "a", "b"]), after)
        for shard in SHARDS.SHARDS:
            old = SHARDS.command(metadata(["a", "b", "z"]), shard, before)[2]
            new = SHARDS.command(metadata(["a", "b", "z", "new"]), shard, after)[2]
            self.assertEqual(old, [name for name in new if name != "new"])

    def test_explicit_order_survives_cargo_artifact_order(self):
        value = metadata(["a", "b", "z"])
        schedule = {"regular": ["b"], "ownership": ["z", "a"]}
        args, _, selected = SHARDS.command(value, "ownership", schedule)
        self.assertEqual(selected, ["z", "a"])
        self.assertEqual([args[i + 1] for i, arg in enumerate(args) if arg == "--test"],
                         ["z", "a"])
        messages = [{"reason": "compiler-artifact", "package_id": "root",
                     "target": {"kind": ["test"], "name": name},
                     "profile": {"test": True}, "executable": f"/{name}"}
                    for name in ["a", "z"]]
        result = SHARDS.test_executables("\n".join(json.dumps(row) for row in messages),
                                        value, "ownership", selected)
        self.assertEqual([key[1] for key, _ in result], ["z", "a"])

    def test_unassigned_obsolete_duplicate_and_unknown_targets_fail(self):
        schedule = {"regular": ["a"], "ownership": ["b"]}
        invalid = metadata(["a", "b"])
        invalid["packages"][0]["targets"].append({"name": "new", "kind": ["custom"]})
        for value in [invalid, metadata(["a", "a"]), metadata([]),
                      metadata(["a"]), metadata(["a", "b", "new"])]:
            with self.assertRaises(ValueError):
                SHARDS.command(value, "regular", schedule)
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "schedule.json"
            for schedule in [{"regular": ["a"], "ownership": ["a"]},
                             {"regular": ["a"], "ownership": []}, {"regular": ["a"]}]:
                path.write_text(json.dumps(schedule))
                with self.assertRaises(ValueError):
                    SHARDS.assignment(path)

    def test_failed_test_command_is_not_reported_as_success(self):
        with patch("sys.argv", ["run-native-tests.py", "--shard", "ownership", "--logs", "/unused", "--idle-timeout", "30"]), \
             patch.object(SHARDS, "assignment", return_value={"regular": ["a"], "ownership": ["b"]}), \
             patch.object(SHARDS.subprocess, "check_output", return_value=json.dumps(metadata(["a", "b"])).encode()), \
             patch.object(SHARDS.subprocess, "run", side_effect=subprocess.CalledProcessError(1, ["cargo", "test"])):
            with self.assertRaises(subprocess.CalledProcessError):
                SHARDS.main()

    def test_focused_targets_are_explicit_and_keep_full_inventory_checks(self):
        value = metadata(["a", "b", "z"])
        schedule = {"regular": ["a", "z"], "ownership": ["b"]}
        messages = [{"reason": "compiler-artifact", "package_id": "root",
                     "target": {"kind": ["test"], "name": name},
                     "profile": {"test": True}, "executable": f"/{name}"}
                    for name in ["a", "b"]]
        built = subprocess.CompletedProcess([], 0,
                    "\n".join(json.dumps(row) for row in messages))
        with patch("sys.argv", ["run-native-tests.py", "--targets", "b", "a", "--logs", "/unused", "--idle-timeout", "30"]), \
             patch.object(SHARDS, "assignment", return_value=schedule), \
             patch.object(SHARDS.subprocess, "check_output", return_value=json.dumps(value).encode()), \
             patch.object(SHARDS.subprocess, "run", return_value=built) as build, \
             patch.object(SHARDS, "run_tests", return_value=1) as run:
            self.assertEqual(SHARDS.main(), 1)
            self.assertEqual(build.call_args.args[0], ["cargo", "test", "--no-fail-fast",
                "--test", "b", "--test", "a", "--no-run", "--message-format=json"])
            self.assertEqual(run.call_args.args[0], [(("test", "b"), ["/b"]), (("test", "a"), ["/a"])])
            self.assertEqual(run.call_args.args[1], ["--nocapture"])
            with patch.object(SHARDS, "assignment", return_value={"regular": ["a"], "ownership": ["b"]}):
                with self.assertRaises(ValueError):
                    SHARDS.main()

    def test_real_cargo_build_and_test_failure_propagation(self):
        # Exercise Cargo's actual option parser and artifact protocol. Mocked
        # subprocesses alone cannot reject an unsupported command-line option.
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory).resolve()
            (root / "tests").mkdir()
            (root / "Cargo.toml").write_text(
                '[package]\nname="runner-probe"\nversion="0.0.0"\nedition="2021"\n'
                '[workspace]\n')
            (root / "tests/a.rs").write_text(
                '#[test] fn fails() { panic!("intentional runner control"); }\n')
            (root / "tests/b.rs").write_text('#[test] fn passes() {}\n')
            schedule = root / "schedule.json"
            schedule.write_text(json.dumps({"regular": ["a"], "ownership": ["b"]}))
            logs = root / "logs"
            with patch.object(SHARDS, "ROOT", root), \
                 patch.object(SHARDS, "SCHEDULE", schedule), \
                 patch.dict(os.environ, {"CARGO_TARGET_DIR": str(root / "target"),
                                         "CARGO_NET_OFFLINE": "true"}), \
                 patch("sys.argv", ["run-native-tests.py", "--targets", "a", "b",
                                    "--logs", str(logs), "--idle-timeout", "30"]):
                self.assertEqual(SHARDS.main(), 1)
            self.assertIn("intentional runner control", (logs / "test-a.log").read_text())
            self.assertIn("test passes ... ok", (logs / "test-b.log").read_text())

    def test_focused_unknown_or_duplicate_targets_fail_before_building(self):
        for names in [["a", "a"], ["unknown"]]:
            with patch("sys.argv", ["run-native-tests.py", "--targets", *names, "--logs", "/unused", "--idle-timeout", "30"]), \
                 patch.object(SHARDS, "assignment", return_value={"regular": ["a"], "ownership": ["b"]}), \
                 patch.object(SHARDS.subprocess, "check_output", return_value=json.dumps(metadata(["a", "b"])).encode()), \
                 patch.object(SHARDS.subprocess, "run") as build:
                with self.assertRaises(SystemExit) as failure:
                    SHARDS.main()
                self.assertEqual(failure.exception.code, 2)
                build.assert_not_called()

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
                    "assert sys.argv[1:]==['--test-threads=1','--skip','golden_programs_with_counted_ownership']\n" +
                    "(root / f'started-{index}').touch()\n" +
                    "if index<2:\n" +
                    "    limit=time.monotonic()+3\n" +
                    "    while not (root / f'started-{1-index}').exists():\n" +
                    "        if time.monotonic()>limit: sys.exit(9)\n" +
                    "        time.sleep(0.01)\n" +
                    "print(f'executed {index}')\n" +
                    "sys.exit(7 if index==1 else 0)\n")
                executable.chmod(0o755)
                executables.append((("test", str(index)), [sys.executable, str(executable)]))
            code = SHARDS.run_tests(executables,
                                    ["--skip", "golden_programs_with_counted_ownership"], root / "logs", 10)
            self.assertEqual(code, 1)
            for index in range(3):
                self.assertTrue((root / f"started-{index}").exists())
                self.assertEqual((root / "logs" / f"test-{index}.log").read_text(),
                                 f"executed {index}\n")
            self.assertEqual(SHARDS.run_tests([executables[0]],
                ["--skip", "golden_programs_with_counted_ownership"], root / "passing", 10), 0)

    def test_completed_cases_allow_a_long_target_to_continue(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            executable = root / "progress"
            executable.write_text("#!/usr/bin/env python3\nimport time\n" +
                "for i in range(4):\n    time.sleep(0.8)\n    print(f'test case_{i} ... ok', flush=True)\n")
            executable.chmod(0o755)
            self.assertEqual(SHARDS.run_tests([(("test", "progress"), [sys.executable, str(executable)])],
                             [], root / "logs", 2), 0)

    def test_output_without_completed_cases_cannot_extend_deadline(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            executable = root / "noisy"
            executable.write_text("#!/usr/bin/env python3\nimport time\n" +
                "while True:\n    print('still stuck', flush=True)\n    time.sleep(0.1)\n")
            executable.chmod(0o755)
            self.assertEqual(SHARDS.run_tests([(("test", "noisy"), [sys.executable, str(executable)])],
                             [], root / "logs", 1), 1)
            self.assertIn("target timed out", (root / "logs/test-noisy.log").read_text())

    def test_timeout_kills_children_preserves_logs_and_runs_remaining_targets(self):
        with tempfile.TemporaryDirectory(prefix="fwp path ' ") as directory:
            root = Path(directory)
            marker = root / "survived"
            hung = root / "hung"
            child_code = f"import pathlib,time; time.sleep(2); pathlib.Path({str(marker)!r}).touch()"
            hung.write_text("#!/usr/bin/env python3\nimport subprocess,sys,time\n" +
                f"subprocess.Popen([sys.executable, '-c', {child_code!r}])\n" +
                "print('before hang', flush=True)\ntime.sleep(30)\n")
            hung.chmod(0o755)
            passed = root / "passed"
            passed.write_text("#!/usr/bin/env python3\nprint('finished')\n")
            passed.chmod(0o755)
            targets = [(("test", "hung"), [sys.executable, str(hung)]),
                       (("test", "second"), [sys.executable, str(passed)]),
                       (("test", "third"), [sys.executable, str(passed)])]
            self.assertEqual(SHARDS.run_tests(targets, [], root / "logs", 1), 1)
            time.sleep(2)
            self.assertFalse(marker.exists(), "timed-out child escaped termination")
            self.assertEqual((root / "logs/test-hung.log").read_text(),
                             "before hang\n\nNo completed test for 1s; target timed out\n")
            for name in ["second", "third"]:
                self.assertEqual((root / f"logs/test-{name}.log").read_text(), "finished\n")
            with self.assertRaises(ValueError):
                SHARDS.run_tests(targets, [], root / "invalid", 0)


if __name__ == "__main__":
    unittest.main()
