"""Keep sanitizer diagnostics separate from the unchanged program oracle."""
from pathlib import Path
import json
import os
import re
import subprocess
import sys

root, out = map(Path, sys.argv[1:])
cc = os.environ.get('CC', 'clang')
want = (root / 'tests/run/effects.out').read_bytes()
known_stack_warning = re.compile(
    rb'==[0-9]+==WARNING: ASan is ignoring requested __asan_handle_no_return: '
    rb'stack type: default top: 0x[0-9a-f]+; bottom 0x[0-9a-f]+; '
    rb'size: 0x[0-9a-f]+ \([0-9]+\)\n'
    rb'False positive error reports may follow\n'
    rb'For details see https://github.com/google/sanitizers/issues/189\n'
)
reports = []
bad = []
for opt in ['-O1', '-O2']:
    exe = out / ('effects-asan' + opt)
    subprocess.run([
        cc, opt, '-std=gnu11', '-ffp-contract=off', '-g',
        '-fsanitize=address,undefined', '-fno-omit-frame-pointer',
        str(out / 'effects.c'), '-o', str(exe), '-lm', '-lpthread',
    ], check=True)
    prefix = out / ('sanitizer-diagnostics' + opt)
    env = dict(
        os.environ, FWP_SEED='42',
        ASAN_OPTIONS=f'detect_leaks=0:detect_stack_use_after_return=0:abort_on_error=0:exitcode=1:log_path={prefix}',
        UBSAN_OPTIONS=f'halt_on_error=1:print_stacktrace=1:log_path={prefix}',
    )
    result = subprocess.run([str(exe)], cwd=root / 'tests/run', env=env, capture_output=True)
    (out / ('asan' + opt + '.stdout')).write_bytes(result.stdout)
    (out / ('asan' + opt + '.stderr')).write_bytes(result.stderr)
    rendered = result.stdout + (b'--- stderr\n' + result.stderr if result.stderr else b'')
    if result.returncode:
        rendered += f'--- exit {result.returncode if result.returncode >= 0 else -1}\n'.encode()
    logs = []
    unexpected = []
    for path in out.glob(prefix.name + '.*'):
        data = path.read_bytes()
        logs.append(dict(path=path.name, text=data.decode(errors='replace')))
        # This warning limits stack instrumentation; retain it as evidence.
        # Any other diagnostic, including every sanitizer error, fails.
        if data and not known_stack_warning.fullmatch(data):
            unexpected.append(path.name)
    report = dict(opt=opt, code=result.returncode,
                  stdout=result.stdout.decode(errors='replace'),
                  stderr=result.stderr.decode(errors='replace'),
                  instrumentation_logs=logs, unexpected_diagnostics=unexpected)
    reports.append(report)
    print(json.dumps(report), flush=True)
    if rendered != want or unexpected:
        bad.append(report)
(out / 'asan-report.json').write_text(json.dumps(reports, indent=2) + '\n')
assert not bad, bad
