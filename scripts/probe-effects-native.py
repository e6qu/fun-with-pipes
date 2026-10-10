from pathlib import Path
import json,os,platform,subprocess,sys
fwp=Path(sys.argv[1]);root=Path(sys.argv[2]);out=Path(sys.argv[3]);attempts=int(sys.argv[4]) if len(sys.argv)>4 else 10
out.mkdir(parents=True,exist_ok=True);cwd=root/'tests/run';env=dict(os.environ,FWP_SEED='42')
def render(r):
 s=r.stdout
 if r.stderr:s+=b'--- stderr\n'+r.stderr
 if r.returncode:s+=f'--- exit {r.returncode if r.returncode>=0 else -1}\n'.encode()
 return s
want=(cwd/'effects.out').read_bytes()
r=subprocess.run([str(fwp),'run','--interp','effects.fwp'],cwd=cwd,env=dict(env,FWP_NO_OPT='1'),capture_output=True)
assert render(r)==want,('raw interpreter',r.returncode,r.stdout,r.stderr)
results=[]
for opt in ['-O1','-O2']:
 exe=out/('effects'+opt);r=subprocess.run([str(fwp),'build','effects.fwp','-o',str(exe),opt],cwd=cwd,env=env,capture_output=True);assert r.returncode==0,r.stderr
 for i in range(attempts):
  r=subprocess.run([str(exe)],cwd=cwd,env=env,capture_output=True)
  if render(r)!=want:results.append(dict(opt=opt,attempt=i,code=r.returncode,stdout=r.stdout.decode(errors='replace'),stderr=r.stderr.decode(errors='replace')))
 print(opt,attempts,'attempts; native magic',exe.read_bytes()[:16].hex(),flush=True)
r=subprocess.run([str(fwp),'build','effects.fwp','--emit-c','-o',str(out/'effects.c')],cwd=cwd,env=env,capture_output=True);assert r.returncode==0,r.stderr
report=dict(hardware=platform.platform(),machine=platform.machine(),attempts=attempts,failures=results)
(out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
assert not results,results
print('Raw oracle and native stdout/stderr/exit agree exactly',flush=True)
