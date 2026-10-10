"""Reject actual sanitizer faults independently of program stdout/stderr/exit."""
from pathlib import Path
import json, subprocess, sys, tempfile
root, evidence = map(Path, sys.argv[1:])
out = Path(tempfile.mkdtemp(prefix='fault-control-', dir=evidence))
s = (evidence / 'effects.c').read_text()
needle = '        fprintf(stderr, "\\n");\n        exit(1);'
assert s.count(needle) == 1
injection = '        volatile char *fault = malloc(16);\n        free((void *)fault);\n        volatile char bad = fault[0];\n        (void)bad;\n'
s = s.replace(needle, '        fprintf(stderr, "\\n");\n' + injection + '        exit(1);')
(out / 'effects.c').write_text(s)
p = subprocess.run([sys.executable, str(Path(__file__).with_name('probe-effects-sanitizer.py')), str(root), str(out)], capture_output=True)
assert p.returncode != 0, 'Actual sanitizer error must fail the diagnostic'
reports = json.loads((out / 'asan-report.json').read_text())
want = (root / 'tests/run/effects.out').read_bytes()
for report in reports:
    rendered = report['stdout'].encode() + b'--- stderr\n' + report['stderr'].encode() + f"--- exit {report['code']}\n".encode()
    assert rendered == want, 'Injected fault must leave the entire original output/exit oracle unchanged'
    assert report['unexpected_diagnostics']
    assert any('ERROR: AddressSanitizer: heap-use-after-free' in log['text'] for log in report['instrumentation_logs'])
print('Real ASan use-after-free rejected at O1/O2 despite exact original stdout/stderr/exit')
print('Negative diagnostic artifacts:', out)
