"""Compare independently generated native binaries with the unchanged oracle."""
from pathlib import Path
import hashlib, json, os, platform, subprocess, sys
fwp, root, out = map(Path, sys.argv[1:4])
attempts = int(sys.argv[4])
cc = os.environ.get("CC", "clang")
cwd = root / "tests/run"
env = dict(os.environ, FWP_SEED="42")
want = (cwd / "effects.out").read_bytes()
reports = []
failed = False
for opt in ["-O1", "-O2"]:
    for trial in range(attempts):
        source = out / "effects.c"
        exe = out / ("effects-fresh" + opt)
        subprocess.run([str(fwp), "build", "effects.fwp", "--emit-c", "-o", str(source), opt], cwd=cwd, env=env, check=True, capture_output=True)
        subprocess.run([cc, opt, "-std=gnu11", "-ffp-contract=off", "-w", str(source), "-o", str(exe), "-lm", "-lpthread"], check=True, capture_output=True)
        result = subprocess.run([str(exe)], cwd=cwd, env=env, capture_output=True)
        rendered = result.stdout + (b"--- stderr\n" + result.stderr if result.stderr else b"")
        if result.returncode:
            rendered += f"--- exit {result.returncode if result.returncode >= 0 else -1}\n".encode()
        report = dict(opt=opt, trial=trial, sha256=hashlib.sha256(source.read_bytes()).hexdigest(), code=result.returncode, agrees=rendered == want)
        reports.append(report)
        if rendered != want:
            failed = True
            (out / "fresh-failure.stdout").write_bytes(result.stdout)
            (out / "fresh-failure.stderr").write_bytes(result.stderr)
            subprocess.run([cc, opt, "-std=gnu11", "-ffp-contract=off", "-w", "-S", str(source), "-o", str(out / "fresh-failure.s")], check=True)
            print(json.dumps(report), flush=True)
            break
    if failed:
        break
    print(opt, attempts, "independent compilations agree", flush=True)
(out / "fresh-report.json").write_text(json.dumps(dict(hardware=platform.platform(), results=reports), indent=2) + "\n")
assert not failed, "Fresh native binary disagrees; exact C and assembly preserved"
