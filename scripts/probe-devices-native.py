from pathlib import Path
import hashlib, json, os, platform, signal, subprocess, sys

fwp, root, out = map(Path, sys.argv[1:4])
out.mkdir(parents=True, exist_ok=True)
env = dict(os.environ, FWP_SEED='42')
cwd = root / 'tests/run'
reports = []
failed = False
def rendered(r):
    data = r.stdout + (b'--- stderr\n' + r.stderr if r.stderr else b'')
    if r.returncode:
        data += f'--- exit {r.returncode if r.returncode >= 0 else -1}\n'.encode()
    return data
def capture(args, name):
    r = subprocess.run(args, capture_output=True)
    (out / name).write_bytes(r.stdout + r.stderr)
    return r.returncode
capture(['uname', '-a'], 'uname.txt')
capture([os.environ.get('CC', 'clang'), '--version'], 'compiler.txt')
if sys.platform == 'darwin':
    capture(['sysctl', 'hw.model', 'hw.memsize', 'machdep.cpu.brand_string'], 'hardware.txt')
for stem in ['devices', 'effects']:
    want = (cwd / (stem + '.out')).read_bytes()
    stdin = cwd / (stem + '.in')
    data = stdin.read_bytes() if stdin.exists() else b''
    raw = subprocess.run([str(fwp), 'run', '--interp', stem + '.fwp'], cwd=cwd,
                         env=dict(env, FWP_NO_OPT='1'), input=data, capture_output=True)
    assert rendered(raw) == want, ('raw interpreter', stem, raw.returncode)
    for opt in ['-O1', '-O2']:
        source = out / (stem + opt + '.c')
        build = [str(fwp), 'build', stem + '.fwp', opt]
        subprocess.run(build + ['--emit-c', '-o', str(source)], cwd=cwd,
                       env=env, capture_output=True, check=True)
        # Fresh builds exercise the same compiler/linker and executable path as
        # the golden harness. Retain every executable until diagnostics finish.
        for trial in range(10):
            exe = out / f'{stem}{opt}-fresh-{trial}'
            command = build + ['-o', str(exe)]
            subprocess.run(command, cwd=cwd, env=env, capture_output=True, check=True)
            capture(['file', str(exe)], exe.name + '.file.txt')
            if sys.platform == 'darwin':
                capture(['codesign', '-dv', '--verbose=4', str(exe)], exe.name + '.codesign.txt')
                capture(['otool', '-hv', str(exe)], exe.name + '.header.txt')
                capture(['otool', '-tv', str(exe)], exe.name + '.assembly.txt')
            for repeat in range(10):
                r = subprocess.run([str(exe)], cwd=cwd, env=env, input=data, capture_output=True)
                agrees = rendered(r) == want
                entry = dict(program=stem, opt=opt, trial=trial, repeat=repeat,
                             code=r.returncode, signal=(signal.Signals(-r.returncode).name
                             if r.returncode < 0 else None), agrees=agrees,
                             binary=exe.name, sha256=hashlib.sha256(exe.read_bytes()).hexdigest())
                reports.append(entry)
                if not agrees:
                    failed = True
                    print(json.dumps(entry), flush=True)
                    (out / (exe.name + f'-{repeat}.stdout')).write_bytes(r.stdout)
                    (out / (exe.name + f'-{repeat}.stderr')).write_bytes(r.stderr)
            print(stem, opt, 'fresh', trial, 'completed', flush=True)
report = dict(source_head=subprocess.check_output(['git','rev-parse','HEAD'], cwd=root, text=True).strip(),
              platform=platform.platform(), machine=platform.machine(), results=reports)
(out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
assert not failed, 'Native failures preserved with actual signals and unchanged golden oracle'
print('Both raw interpreters and all 400 native executions agree exactly', flush=True)
