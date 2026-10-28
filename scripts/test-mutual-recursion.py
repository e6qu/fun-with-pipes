#!/usr/bin/env python3
"""Reject broken measurement controls and exceeded prototype budgets."""
import copy
from pathlib import Path
import runpy
import unittest


ASSESS = runpy.run_path(str(Path(__file__).with_name("measure-mutual-recursion.py")))["assess"]
BUDGETS = {"controlRatio": 1.10, "groupedOverExplicit": 1.25,
           "managedRequests": 0, "extraStackRangeBytes": 1024, "extraTextBytes": 1024}


class Decisions(unittest.TestCase):
    def setUp(self):
        variant = {"seconds": [1.0] * 8, "textBytes": 1000,
                   "profiles": [{"allocations": 0, "stackRange": 64},
                                {"allocations": 0, "stackRange": 64}]}
        self.case = {"level": "O0", "controls": [[1.0, 1.0]] * 8,
                     "variants": {name: copy.deepcopy(variant) for name in ["ordinary", "grouped", "explicit"]}}
        self.case["variants"]["ordinary"]["profiles"][1]["stackRange"] = 4096

    def test_passing_comparison(self):
        self.assertEqual(ASSESS(self.case, BUDGETS)["decision"], "accept")

    def test_noise_and_missing_stack_control_are_inconclusive(self):
        for mutation in ["noise", "stack"]:
            case = copy.deepcopy(self.case)
            if mutation == "noise":
                case["controls"] = [[1.0, 1.11]] * 8
            else:
                case["variants"]["ordinary"]["profiles"][1]["stackRange"] = 64
            self.assertEqual(ASSESS(case, BUDGETS)["decision"], "inconclusive")

    def test_each_budget_rejects_its_own_failure(self):
        for metric in ["timing", "codeSize", "allocation", "stack"]:
            case = copy.deepcopy(self.case)
            grouped = case["variants"]["grouped"]
            if metric == "timing":
                grouped["seconds"] = [1.251] * 8
            elif metric == "codeSize":
                grouped["textBytes"] = 2025
            elif metric == "allocation":
                grouped["profiles"][1]["allocations"] = 1
            else:
                grouped["profiles"][1]["stackRange"] = 1089
            result = ASSESS(case, BUDGETS)
            self.assertEqual(result["decision"], "reject", metric)
            self.assertFalse(result["checks"][metric])

    def test_nonfinite_and_nonpositive_samples_are_invalid(self):
        for value in [float("nan"), float("inf"), 0, -1]:
            case = copy.deepcopy(self.case)
            case["variants"]["grouped"]["seconds"][0] = value
            with self.assertRaisesRegex(ValueError, "finite and positive"):
                ASSESS(case, BUDGETS)


if __name__ == "__main__":
    unittest.main()
