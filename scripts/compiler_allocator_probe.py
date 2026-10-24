"""Inspect the unchanged Intel compiler under Guard Malloc using LLDB.

Stop on the first allocator error or a bounded deadline and preserve its frames.
No compiler argument, register, stack policy or generated instruction is changed.
"""

import json
import os
from pathlib import Path
import subprocess
import time

import lldb


def run(debugger):
    debugger.SetAsync(True)
    target = debugger.CreateTarget('allocation-evidence/fwp')
    assert target.IsValid() and target.GetTriple().startswith('x86_64-'), target.GetTriple()
    stack = target.BreakpointCreateByName('pthread_attr_setstacksize')
    assert stack.GetNumLocations() == 1, stack.GetNumLocations()
    target.BreakpointCreateByName('malloc_error_break')
    root = Path('allocation-evidence/debugger-guard').resolve()
    root.mkdir()
    source = root / 'all.fwp'
    source.write_text('main = read-all () | echo\n')
    launch = lldb.SBLaunchInfo(['build', '--gc', 'tracing', '--emit-c', str(source),
                              '-o', str(root / 'all.c')])
    launch.SetWorkingDirectory(os.getcwd())
    launch.SetEnvironmentEntries(['MallocDebugReport=stderr',
                                 'DYLD_INSERT_LIBRARIES=/usr/lib/libgmalloc.dylib'], True)
    launch.AddOpenFileAction(1, str(root / 'stdout.log'), False, True)
    launch.AddOpenFileAction(2, str(root / 'stderr.log'), False, True)
    error = lldb.SBError()
    process = target.Launch(launch, error)
    print('Launch:', error, 'pid:', process.GetProcessID(), flush=True)
    deadline = time.monotonic() + 120
    next_sample = 0
    stacks = []
    reason = 'launch failed'
    with (root / 'samples.jsonl').open('w') as samples:
        while error.Success():
            state = process.GetState()
            if state == lldb.eStateExited:
                reason = 'exited'
                break
            if state == lldb.eStateStopped:
                thread = process.GetSelectedThread()
                is_stack = (thread.GetStopReason() == lldb.eStopReasonBreakpoint
                            and thread.GetStopReasonDataAtIndex(0) == stack.GetID())
                if not is_stack:
                    reason = 'debugger stop'
                    break
                size = thread.GetFrameAtIndex(0).FindRegister('rsi').GetValueAsUnsigned()
                stacks.append(size)
                print('Unchanged stack request:', size, flush=True)
                if size != 4 * 1024 ** 3 or len(stacks) != 1:
                    reason = 'unexpected stack request'
                    break
                target.BreakpointDelete(stack.GetID())
                resumed = process.Continue()
                if resumed.Fail():
                    reason = str(resumed)
                    break
            if time.monotonic() >= deadline:
                reason = '120 second diagnostic deadline'
                process.Stop()
                break
            if time.monotonic() >= next_sample:
                status = subprocess.run(['ps', '-p', str(process.GetProcessID()),
                                         '-o', 'pid=,rss=,vsz=,time='], text=True, capture_output=True)
                samples.write(json.dumps(dict(state=state, process=status.stdout.strip(),
                                              sampleStatus=status.returncode)) + '\n')
                samples.flush()
                next_sample = time.monotonic() + 5
            time.sleep(0.05)
    ok = (reason == 'exited' and process.GetExitStatus() == 0
          and stacks == [4 * 1024 ** 3])
    print('Result:', reason, 'state:', process.GetState(), 'exit:', process.GetExitStatus(), flush=True)
    (root / 'result.json').write_text(json.dumps(dict(reason=reason, state=process.GetState(),
                                                    exit=process.GetExitStatus(), stacks=stacks), indent=2) + '\n')
    if not ok:
        debugger.HandleCommand('thread backtrace all')
        debugger.HandleCommand('register read')
        if process.GetState() != lldb.eStateExited:
            process.Kill()
    (root / 'result.txt').write_text('pass\n' if ok else 'fail\n')
