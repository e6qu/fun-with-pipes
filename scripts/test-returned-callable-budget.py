"""Reject missing cost reductions and excessive code/frame/storage costs."""
import copy
import importlib.util
from pathlib import Path
import unittest


SPEC = importlib.util.spec_from_file_location(
    "callable_budget", Path(__file__).with_name("check-returned-callable-budget.py"))
BUDGET = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BUDGET)


class CallableBudget(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.baselines = {host: BUDGET.baseline(host) for host in BUDGET.MACHINES}

    def candidate(self, host):
        result = copy.deepcopy(self.baselines[host])
        for level in (1, 2):
            phases = result["programs"][f"fwp-O{level}-profile"]["phases"]
            for rows in phases.values():
                for row in rows:
                    if row["phase"] == 1:
                        row.update(retains=0, releases=0, applications=row["calls"])
        return result

    def test_unchanged_baseline_fails_but_required_reduction_passes(self):
        for host, reference in self.baselines.items():
            with self.subTest(host=host):
                self.assertFalse(BUDGET.compare(reference, reference)["accepted"])
                self.assertTrue(BUDGET.compare(reference, self.candidate(host))["accepted"])

    def test_reject_each_failed_budget(self):
        for host, reference in self.baselines.items():
            for damage in ("worker", "text", "largestFrame", "borrowedFrames", "counts", "storage"):
                candidate = self.candidate(host)
                program = candidate["programs"]["fwp-O2"]
                if damage == "worker":
                    program["code"]["workerDecodedBytes"] *= 2
                elif damage == "text":
                    program["sections"] = "\n.text 9999999 0\n"
                elif damage == "largestFrame":
                    program["cFrames"].append(dict(location="probe.c:1:large", bytes=999999, kind="static"))
                elif damage == "borrowedFrames":
                    program["cFrames"].append(dict(location="probe.c:1:fwp_apply_borrowed.clone", bytes=65, kind="static"))
                else:
                    row = candidate["programs"]["fwp-O2-profile"]["phases"]["success"][4]
                    row["applications" if damage == "counts" else "finalCountBytes"] += 1
                with self.subTest(host=host, damage=damage):
                    result = BUDGET.compare(reference, candidate)
                    self.assertFalse(result["accepted"])
                    self.assertFalse(result["levels"]["fwp-O2"]["checks"][damage])

    def test_missing_frames_or_phases_cannot_pass(self):
        for damage in ("frames", "phase"):
            candidate = self.candidate("linux-amd")
            if damage == "frames":
                candidate["programs"]["fwp-O2"]["cFrames"] = []
            else:
                candidate["programs"]["fwp-O2-profile"]["phases"]["success"].pop()
            with self.subTest(damage=damage), self.assertRaises((AssertionError, ValueError)):
                BUDGET.compare(self.baselines["linux-amd"], candidate)


if __name__ == "__main__":
    unittest.main()
