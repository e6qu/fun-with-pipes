from pathlib import Path
import json, os, subprocess, sys
root=Path(sys.argv[1]);out=Path(sys.argv[2]);cc=os.environ.get('CC','clang');want=(root/'tests/run/effects.out').read_bytes();bad=[];reports=[]
for opt in ['-O1','-O2']:
 exe=out/('effects-asan'+opt)
 subprocess.run([cc,opt,'-std=gnu11','-ffp-contract=off','-g','-fsanitize=address,undefined','-fno-omit-frame-pointer',str(out/'effects.c'),'-o',str(exe),'-lm','-lpthread'],check=True)
 env=dict(os.environ,FWP_SEED='42',ASAN_OPTIONS='detect_leaks=0:detect_stack_use_after_return=0')
 p=subprocess.run([str(exe)],cwd=root/'tests/run',env=env,capture_output=True)
 (out/('asan'+opt+'.stdout')).write_bytes(p.stdout);(out/('asan'+opt+'.stderr')).write_bytes(p.stderr)
 rendered=p.stdout+(b'--- stderr\n'+p.stderr if p.stderr else b'')+(f'--- exit {p.returncode if p.returncode>=0 else -1}\n'.encode() if p.returncode else b'')
 report=dict(opt=opt,code=p.returncode,stdout=p.stdout.decode(errors='replace'),stderr=p.stderr.decode(errors='replace'));reports.append(report);print(json.dumps(report),flush=True)
 if rendered!=want:bad.append(report)
(out/'asan-report.json').write_text(json.dumps(reports,indent=2)+'\n')
assert not bad,bad
