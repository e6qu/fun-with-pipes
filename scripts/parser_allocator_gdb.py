"""GDB script: observe installed libc resize boundaries without changing data."""
import hashlib
import json
import os
from pathlib import Path
import traceback

import gdb

OUTPUT = Path(os.environ['FWP_ALLOCATOR_OBSERVATION'])
REPORT = dict(events=[], errors=[], objects=[], sourceLocations=[])
ACTIVE = None
LAST_STOP = []
EXIT_CODE = None


def save():
    OUTPUT.write_text(json.dumps(REPORT, indent=2) + '\n')


def stopped(event):
    global LAST_STOP
    LAST_STOP = list(event.breakpoints) if isinstance(event, gdb.BreakpointEvent) else []


def exited(event):
    global EXIT_CODE
    EXIT_CODE = event.exit_code if hasattr(event, 'exit_code') else -1


def argument(frame, name):
    value = frame.read_var(name)
    if value.is_optimized_out:
        raise RuntimeError('unavailable debug argument: ' + name)
    return int(value)


def record(kind, **values):
    REPORT['events'].append(dict(kind=kind, case=ACTIVE['case'],
                                 thread=list(gdb.selected_thread().ptid), **values))


class ReturnPoint(gdb.FinishBreakpoint):
    def __init__(self, frame, kind):
        super().__init__(frame, internal=True)
        self.kind = kind

    def out_of_scope(self):
        REPORT['errors'].append('unexpected unwind at ' + self.kind)


def observe():
    global ACTIVE, LAST_STOP
    gdb.events.stop.connect(stopped)
    gdb.events.exited.connect(exited)
    gdb.execute('set pagination off')
    gdb.execute('set confirm off')
    gdb.execute('set debuginfod enabled off')
    gdb.execute('set disable-randomization off')
    gdb.execute('start')
    for obj in gdb.objfiles():
        path = Path(obj.filename)
        if path.is_file():
            REPORT['objects'].append(dict(path=str(path), buildId=obj.build_id,
                                          debugOwner=obj.owner.filename if obj.owner else None,
                                          sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    names = ('__libc_realloc', '_int_realloc', '_int_malloc', '_int_free')
    points = {gdb.Breakpoint(name, internal=True): name for name in names}
    for point, name in points.items():
        if point.pending:
            raise RuntimeError('missing installed-libc debug symbol: ' + name)
    while EXIT_CODE is None:
        LAST_STOP = []
        gdb.execute('continue')
        if EXIT_CODE is not None:
            break
        if len(LAST_STOP) != 1:
            raise RuntimeError('unexpected debugger stop: ' + gdb.execute('info program', to_string=True))
        point = LAST_STOP[0]
        frame = gdb.newest_frame()
        if isinstance(point, ReturnPoint):
            if point.return_value is None or point.return_value.is_optimized_out:
                raise RuntimeError('unavailable return value: ' + point.kind)
            result = int(point.return_value)
            record(point.kind, pointer=result)
            if point.kind == 'resize-return':
                ACTIVE = None
            continue
        name = points[point]
        if name == '__libc_realloc':
            mode = int(gdb.parse_and_eval('parser_probe_case'))
            if not mode:
                continue
            if ACTIVE is not None:
                raise RuntimeError('unexpected nested realloc')
            ACTIVE = dict(case=mode, old=argument(frame, 'oldmem'), chunk=None)
            record('resize-enter', pointer=ACTIVE['old'], requested=argument(frame, 'bytes'))
            ReturnPoint(frame, 'resize-return')
        elif ACTIVE is not None:
            if name == '_int_realloc':
                ACTIVE['chunk'] = argument(frame, 'oldp')
                record('arena-resize-enter', oldChunk=ACTIVE['chunk'], oldChunkBytes=argument(frame, 'oldsize'),
                       adjustedNewBytes=argument(frame, 'nb'))
            elif name == '_int_malloc':
                record('internal-allocation-enter', requested=argument(frame, 'bytes'))
                ReturnPoint(frame, 'internal-allocation-return')
            else:
                pointer = argument(frame, 'p')
                record('internal-free-enter', chunk=pointer, releasesOld=pointer == ACTIVE['chunk'])
        if ACTIVE is not None:
            location = frame.find_sal()
            REPORT['sourceLocations'].append(dict(function=name, line=location.line,
                                                  file=location.symtab.fullname() if location.symtab else None))
        save()
    REPORT['exitCode'] = EXIT_CODE
    if EXIT_CODE != 0 or ACTIVE is not None or REPORT['errors']:
        raise RuntimeError('incomplete allocator execution')


try:
    observe()
except Exception as error:
    REPORT['errors'].append(dict(error=str(error), traceback=traceback.format_exc()))
    save()
    gdb.execute('quit 1')
else:
    save()
    gdb.execute('quit 0')
