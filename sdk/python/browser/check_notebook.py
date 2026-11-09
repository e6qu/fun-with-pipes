"""Exercise the real notebook UI and interpreter; retain desktop/mobile images."""
import json
import os
from pathlib import Path
import re
import signal
import subprocess
import sys
import tempfile
from playwright.sync_api import sync_playwright, expect

output = Path(os.environ.get("FWP_NOTEBOOK_EVIDENCE", "notebook-evidence"))
output.mkdir(parents=True, exist_ok=True)
with tempfile.TemporaryDirectory() as directory, (output / "server.log").open("w+") as log:
    server = subprocess.Popen([os.environ["FWP_TEST_BIN"], "notebook", "--python", sys.executable, "--directory", directory, "--port", "0"],
        stdout=subprocess.PIPE, stderr=log, text=True, encoding="utf-8")
    try:
        first_line = server.stdout.readline()
        match = re.search(r"http://127\.0\.0\.1:\d+", first_line)
        assert match, first_line
        with sync_playwright() as playwright:
            browser = playwright.chromium.launch()
            page = browser.new_page(viewport={"width": 1440, "height": 1000})
            errors = []
            page.on("pageerror", lambda error: errors.append(str(error)))
            page.goto(match.group())
            expect(page.get_by_role("heading", name="Follow the calculation.")).to_be_visible()
            page.locator("#run-all").click()
            expect(page.locator("#status")).to_have_text("Finished", timeout=60000)
            expect(page.locator(".cell").nth(2).locator(".value")).to_have_text("5.0")
            expect(page.locator(".cell").nth(4).locator(".value")).to_have_text("True")
            page.screenshot(path=str(output / "desktop.png"), full_page=True)
            page.set_viewport_size({"width": 390, "height": 844})
            assert page.evaluate("document.documentElement.scrollWidth <= innerWidth")
            page.screenshot(path=str(output / "mobile.png"), full_page=True)
            page.set_viewport_size({"width": 1440, "height": 1000})
            page.locator(".cell").nth(1).locator("textarea").fill("x = 6.0\ny = 8.0")
            expect(page.locator(".cell").nth(2).locator(".badge")).to_have_text("stale")
            expression = page.locator(".cell").nth(2)
            expression.locator("textarea").press("Control+Enter")
            expect(expression.locator(".value")).to_have_text("10.0", timeout=60000)
            expect(expression.locator(".dependencies")).to_contain_text("2")
            expression.locator("textarea").fill("60s | task.sleep")
            expression.locator("textarea").press("Control+Enter")
            expect(page.locator("#status")).to_have_text("Running…")
            page.locator("#stop").click()
            expect(page.locator("#status")).to_have_text("Stopped · run a cell to restart", timeout=15000)
            expect(page.locator("#run-all")).to_be_enabled()
            expression.locator("textarea").fill("x | hypot y")
            expression.locator("textarea").press("Control+Enter")
            expect(expression.locator(".value")).to_have_text("10.0", timeout=60000)
            response = page.request.post(match.group() + "/run", data={"document": [], "cells": []})
            assert response.status == 400, response.text()
            response = page.request.post(match.group() + "/interrupt", data={}, headers={"Origin": "https://example.com"})
            assert response.status == 403, response.text()
            with page.expect_download() as saved:
                page.locator("#save").click()
            notebook_path = Path(directory) / "saved.fwpnb"
            saved.value.save_as(notebook_path)
            document = json.loads(notebook_path.read_text())
            assert document["format"] == "fwp-notebook" and "results" not in document
            document["cells"][0]["source"] = '<script>window.untrusted = true</script>\n# Safe text'
            notebook_path.write_text(json.dumps(document))
            page.locator("#file").set_input_files(notebook_path)
            expect(page.get_by_role("heading", name="Safe text")).to_be_visible()
            assert page.evaluate("window.untrusted") is None
            expect(page.locator(".cell").nth(2).locator(".badge")).to_have_text("not run")
            root = Path(__file__).resolve().parents[3]
            applications = [
                ("words", (root / "examples/wordfreq.fwp").read_text(encoding="utf-8").split("\nmain =", 1)[0],
                 'text = "hello Hello."', "text | count-words", '[("hello", 2)]',
                 'text = "apple Hello."', '[("apple", 1), ("hello", 1)]', "text = 7"),
                ("numerical", (root / "docs/tutorials/20-autodiff-and-devices/main.fwp").read_text(encoding="utf-8").split("\nloss :", 1)[0],
                 "start : List[F64]\nstart = [1.0, 1.0, 1.0]", "start | rosenbrock | round", "0.0",
                 "start : List[F64]\nstart = [-1.2, 1.0, 0.5]", "49.0", "start = 7"),
                ("callbacks", (root / "tests/fixtures/weak_callback_service.fwp").read_text(encoding="utf-8").split("\nmain =", 1)[0],
                 "configuration = (64, 0)", "configuration | service | .received", "64",
                 "configuration = (64, 1)", "48", 'configuration = "wrong type"'),
            ]
            for name, definitions, inputs, computation, initial, edited, changed, invalid in applications:
                application = {"format": "fwp-notebook", "version": 1, "title": name, "cells": [
                    {"kind": "code", "source": definitions},
                    {"kind": "code", "source": inputs},
                    {"kind": "code", "source": computation},
                    {"kind": "code", "source": '"explicit effect" | print'},
                ]}
                application_path = Path(directory) / f"{name}.fwpnb"
                application_path.write_text(json.dumps(application), encoding="utf-8")
                page.locator("#file").set_input_files(application_path)
                expression = page.locator(".cell").nth(2)
                effect = page.locator(".cell").nth(3)
                expect(expression.locator(".badge")).to_have_text("not run")
                expect(effect.locator(".badge")).to_have_text("not run")
                expression.locator("textarea").press("Control+Enter")
                expect(expression.locator(".value")).to_have_text(initial, timeout=60000)
                expect(effect.locator(".stdout")).to_have_count(0)
                effect.locator("textarea").press("Control+Enter")
                expect(effect.locator(".stdout")).to_have_text("explicit effect", timeout=60000)
                page.locator(".cell").nth(1).locator("textarea").fill(edited)
                expect(expression.locator(".badge")).to_have_text("stale")
                expression.locator("textarea").press("Control+Enter")
                expect(expression.locator(".value")).to_have_text(changed, timeout=60000)
                expect(effect.locator(".badge")).to_have_text("stale")
                page.locator(".cell").nth(1).locator("textarea").fill(invalid)
                expression.locator("textarea").press("Control+Enter")
                expect(expression.locator(".badge")).to_have_text("error", timeout=60000)
                expect(expression.locator("pre.error")).not_to_be_empty()
                expect(expression.locator(".stdout")).to_have_count(0)
                page.locator(".cell").nth(1).locator("textarea").fill(edited)
                expression.locator("textarea").press("Control+Enter")
                expect(expression.locator(".value")).to_have_text(changed, timeout=60000)
                page.screenshot(path=str(output / f"{name}.png"), full_page=True)
                with page.expect_download() as saved:
                    page.locator("#save").click()
                saved.value.save_as(application_path)
                restored = json.loads(application_path.read_text(encoding="utf-8"))
                assert all(set(cell) == {"id", "kind", "source"} for cell in restored["cells"]), restored
                assert restored["cells"][1]["source"] == edited
                page.locator("#file").set_input_files(application_path)
                expect(page.locator(".value, .stdout, .error")).to_have_count(0)
                expect(page.locator(".cell .badge")).to_have_text(["not run"] * 4)
            assert not errors, errors
            browser.close()
    finally:
        server.send_signal(signal.SIGINT)
        try:
            server.wait(timeout=10)
        except subprocess.TimeoutExpired:
            server.kill()
            server.wait()
        server.stdout.close()
print("Notebook browser checks passed: real cells, edits, dependencies, source-only save/open, safe Markdown, responsive layout and three applications.")
