#!/usr/bin/env python3
"""Run one focused fwp workload within the local interactivity limits.

Full builds, full test gates, benchmarks and large regeneration belong on CI.
The fixed limits here are not command-line options: stop rather than raise them.
Use the repository's shared target even when checking a prepared worktree.
"""
import os,signal,subprocess,sys,time,shutil,fcntl
from pathlib import Path
root=Path(__file__).resolve().parent.parent
limit=1024*1024
started=time.monotonic()
child=None
tracked=set()
seen_cpu={}
paused=False
last_disk=0

def stats():
    result=subprocess.run(['ps','-axo','pid=,ppid=,pgid=,rss=,time='],capture_output=True,text=True,check=True,timeout=2)
    rows={}
    for line in result.stdout.splitlines():
        pid,ppid,pgid,rss,cpu=line.split()
        days,_,clock=cpu.rpartition('-')
        total=0.0
        for part in clock.split(':'): total=total*60+float(part)
        total+=int(days or 0)*86400
        rows[int(pid)]=(int(ppid),int(pgid),int(rss),total)
    return rows

def stop(sig):
    if child and child.poll() is not None and not (tracked - {child.pid}):
        return
    if child:
        try: os.killpg(child.pid,sig)
        except ProcessLookupError: pass
        except PermissionError:
            if child.poll() is None: raise
    for pid in tracked:
        if child and pid == child.pid and child.poll() is not None: continue
        try: os.kill(pid,sig)
        except ProcessLookupError: pass

def interrupted(signum,frame): raise RuntimeError('interrupted')

try:
    (root/"target").mkdir(exist_ok=True)
    lock=(root/"target/.local-check.lock").open("a")
    fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
    stats()
    os.nice(15)
    signal.signal(signal.SIGTERM,interrupted)
    signal.signal(signal.SIGINT,interrupted)
    if shutil.disk_usage(root).free < 64*1024**3: raise RuntimeError('less than 64 GiB free disk')
    env=dict(os.environ,CARGO_BUILD_JOBS='1',CARGO_INCREMENTAL='0',CARGO_PROFILE_DEV_DEBUG='0',CARGO_PROFILE_TEST_DEBUG='0',CARGO_TARGET_DIR=str(root/'target'),RAYON_NUM_THREADS='1',RUST_TEST_THREADS='1')
    child=subprocess.Popen(sys.argv[1:],env=env,start_new_session=True)
    tracked.add(child.pid)
    while True:
        now=time.monotonic()
        rows=stats()
        active={pid for pid in tracked if pid in rows}
        if child.pid in rows: active.add(child.pid)
        while True:
            new=active|{pid for pid,r in rows.items() if r[0] in active or r[1]==child.pid}
            if new==active: break
            active=new
        tracked=active
        for pid in active: seen_cpu[pid]=max(seen_cpu.get(pid,0),rows[pid][3])
        if sum(rows[p][2] for p in active)>limit: raise RuntimeError('aggregate RSS exceeded 1 GiB')
        if now-started>180: raise RuntimeError('180 second wall-time limit')
        if now-last_disk>2:
            size=int(subprocess.check_output(['du','-sk',str(root/'target')],text=True).split()[0])
            if size>2*1024**2: raise RuntimeError('target exceeded 2 GiB')
            if shutil.disk_usage(root).free<64*1024**3: raise RuntimeError('free disk below 64 GiB')
            last_disk=now
        code=child.poll()
        if code is not None:
            print('local-guard: CPU %.2fs, elapsed %.2fs, exit %s'%(sum(seen_cpu.values()),now-started,code),file=sys.stderr)
            sys.exit(code)
        should_pause=sum(seen_cpu.values())>0.5*(now-started)+0.1
        if should_pause!=paused:
            stop(signal.SIGSTOP if should_pause else signal.SIGCONT)
            paused=should_pause
        code=child.poll()
        if code is not None:
            print('local-guard: CPU %.2fs, elapsed %.2fs, exit %s'%(sum(seen_cpu.values()),now-started,code),file=sys.stderr)
            sys.exit(code)
        time.sleep(0.1)
except (Exception,KeyboardInterrupt) as error:
    print('local-guard: stopped:',error,file=sys.stderr)
    sys.exit(1)
finally:
    if child:
        stop(signal.SIGKILL)
        child.wait()
