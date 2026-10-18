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
print("Notebook browser checks passed: real cells, edits, dependencies, save/open, safe Markdown and responsive layout.")
