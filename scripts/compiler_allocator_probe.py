"""LLDB experiment: guard heap allocations with an explicit 256 MiB stack.

This changes only a debugger argument, not the production compiler or its policy.
Load in LLDB and call run(debugger). A stopped or failed process fails the probe.
"""

import os
from pathlib import Path

import lldb

stack_requests = []


def stack_size(frame, location, internal):
    size = frame.FindRegister('rsi')
    requested = size.GetValueAsUnsigned()
    stack_requests.append(requested)
    print(f'Diagnostic stack request: {requested} -> {256 * 1024 * 1024}', flush=True)
    if requested != 4 * 1024 ** 3:
        return True
    error = lldb.SBError()
    changed = size.SetValueFromCString(str(256 * 1024 * 1024), error)
    return not changed or error.Fail()


def run(debugger):
    debugger.SetAsync(False)
    target = debugger.CreateTarget('allocation-evidence/fwp')
    assert target.IsValid() and target.GetTriple().startswith('x86_64-'), target.GetTriple()
    stack = target.BreakpointCreateByName('pthread_attr_setstacksize')
    assert stack.GetNumLocations() == 1, stack.GetNumLocations()
    stack.SetScriptCallbackFunction(__name__ + '.stack_size')
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
    print('Launch:', error, 'state:', process.GetState(), 'exit:', process.GetExitStatus())
    print('Requested stacks:', stack_requests)
    ok = (error.Success() and process.GetState() == lldb.eStateExited
          and process.GetExitStatus() == 0 and stack_requests == [4 * 1024 ** 3])
    if not ok:
        debugger.HandleCommand('thread backtrace all')
        debugger.HandleCommand('register read')
        process.Kill()
    (root / 'result.txt').write_text('pass\n' if ok else 'fail\n')
