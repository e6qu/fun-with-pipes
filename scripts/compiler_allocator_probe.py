"""Inspect the unchanged Intel compiler under Guard Malloc using LLDB.

Stop on the first allocator error or a bounded deadline and preserve its frames.
The requested stack size is an explicit debugger experiment, not a product fix.
"""

import json
import os
from pathlib import Path
import subprocess
import time

import lldb


def run(debugger, stack_mib):
    assert stack_mib in (256, 4096)
    debugger.SetAsync(True)
    target = debugger.CreateTarget('allocation-evidence/fwp')
    assert target.IsValid() and target.GetTriple().startswith('x86_64-'), target.GetTriple()
    stack = target.BreakpointCreateByName('pthread_attr_setstacksize')
    assert stack.GetNumLocations() == 1, stack.GetNumLocations()
    target.BreakpointCreateByName('malloc_error_break')
    root = Path(f'allocation-evidence/debugger-guard-{stack_mib}').resolve()
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
                print('Original stack request:', size, 'diagnostic MiB:', stack_mib, flush=True)
                if size != 4 * 1024 ** 3 or len(stacks) != 1:
                    reason = 'unexpected stack request'
                    break
                register = thread.GetFrameAtIndex(0).FindRegister('rsi')
                if stack_mib != 4096:
                    changed = register.SetValueFromCString(str(stack_mib * 1024 ** 2))
                    if not changed or register.GetValueAsUnsigned() != stack_mib * 1024 ** 2:
                        reason = 'cannot set diagnostic stack size'
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
                                                    exit=process.GetExitStatus(), stacks=stacks,
                                                    diagnosticStackMiB=stack_mib), indent=2) + '\n')
    if not ok:
        if process.GetState() == lldb.eStateStopped:
            debugger.HandleCommand('thread backtrace all')
            debugger.HandleCommand('register read')
        if process.GetState() != lldb.eStateExited:
            process.Kill()
    (root / 'result.txt').write_text('pass\n' if ok else 'fail\n')
