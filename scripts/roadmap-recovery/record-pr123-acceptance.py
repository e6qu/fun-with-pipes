"""Record acceptance only after exact-head gates, squash proof and protected FF."""
from pathlib import Path
import json
import re
import subprocess

ROOT = Path('/Users/zardoz/projects/fun-with-pipes')
HEAD = 'b0ae00d5512df825271970cafcf569f52dbfc0cd'
BASE = '68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4'
proof = json.loads(Path('/private/tmp/fwp-pr123-merge-proof.json').read_text())
gates = json.loads(Path('/private/tmp/fwp-pr123-final-gate-proof.json').read_text())
assert proof['acceptedHead'] == HEAD and proof['parents'] == [BASE]
for gate in (gates['ci'], gates['docs']):
    assert gate['headSha'] == HEAD
    assert gate['status'] == 'completed' and gate['conclusion'] == 'success'
    assert all(j['status'] == 'completed' and j['conclusion'] == 'success'
               for j in gate['jobs'])
sha = proof['sha']
assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT,
                               text=True).strip() == sha
history = ROOT / 'docs/roadmap-history.md'
heading = '## Archived handoff after PR #123'
assert heading not in history.read_text(), 'Acceptance has already been recorded'
state = ROOT / 'docs/development-state.md'
old = state.read_text()
start = old.index('Main is `')
end = old.index('## Evidence and preservation requirements', start)
accepted_rows = [line for line in old.splitlines()
                 if re.match(r'^\| (?:5[4-9]|6[0-9]|7[0-3]) ownership-', line)]
assert len(accepted_rows) == 20
primitive = ROOT / 'docs/primitive-ownership.md'
primitive_text = primitive.read_text()
primitive_rows = [line for line in primitive_text.splitlines()
                  if re.match(r'^\| (?:5[4-9]|6[0-9]|7[0-3]) \|', line)]
assert len(primitive_rows) == 20
with history.open('a') as out:
    out.write('\n' + heading + '\n\n' + old[start:end])
    out.write('\nVerified acceptance: ' + json.dumps(proof, sort_keys=True) + '\n')
    out.write('\nAccepted bundle54–73 handoff rows:\n\n' +
              '\n'.join(accepted_rows) + '\n')
    out.write('\nAccepted primitive preparation rows54–73:\n\n' +
              '\n'.join(primitive_rows) + '\n')
current = f'''Main is `{sha}` (PR #123). Frozen head `{HEAD}`
passes all six exact-head jobs in CI38128387224 and roadmap_docs38128387231
before match-head squash at {proof['mergedAt']}. Subject `{proof['subject']}`
has {proof['characters']} characters, one line, empty body and no trailers or
attribution. One parent `{BASE}` and complete tree `{proof['tree']}` match
the tested head. All11 live docs are protected in /private/tmp/fwp-main-docs-pre123
and restored byte-for-byte. Actual-main documentation status must still be
collected; do not infer it from the PR gate.

Queue33 and35–73 are accepted; queue34 is a verified duplicate. PR123 accepts
all42 original library/OpenCL/TLS/file/resource commits and both pointer and
raw-memory repairs. Raw pointer offsets wrap at the native pointer width;
ordinary arithmetic remains checked. Nine raw-memory primitive contracts
borrow their arguments; ptr.read-string returns a counted independent managed
copy. C buffers still require mem.free. Fake OpenCL coverage does not prove
GPU hardware support, and F16/128-bit/WASI pointer widths remain unverified.

Next delivery: related resource/network items74–112. Inspect the GitHub runner
preparation at drivercfcb70d16044915206c2e681a72618021ba0ea97, preserve85
original commits and mandatory actual WASI
requirements, then rebase onto this actual squash with all11 fresh root docs.
Publish the sole next production PR after verified preparation; require six
exact-head production jobs and roadmap_docs, then complete the finite phase2
exit review. Phases2–6 remain incomplete.

'''
updated = old[:start] + current + old[end:]
updated = '\n'.join(line for line in updated.split('\n')
                    if line not in accepted_rows)
start = updated.index('PR123 branch:')
end = updated.index('## Remaining ownership deliveries', start)
updated = updated[:start] + updated[end:]
start = updated.index('A separate FFI boundary preparation, branch')
end = updated.index('After queue112 is delivered,', start)
with history.open('a') as out:
    out.write('\nCompleted pointer repair preparation evidence:\n\n' +
              updated[start:end])
updated = updated[:start] + '''The pointer-width and raw-memory contracts are accepted in PR123.
Independent Linux/ARM/Intel evidence remains in
/private/tmp/fwp-pointer-boundary-passing-proof.json and its retained artifacts.
The twelve sanitizer binaries preserve exact success0/overflow1 statuses;
F16/128-bit, WASI pointer widths and automatic raw-buffer lifetimes remain
separate requirements. Production acceptance is recorded above.

''' + updated[end:]
updated = updated.replace('Latest snapshot: /private/tmp/fwp-main-docs-pre122',
                          'Latest snapshot: /private/tmp/fwp-main-docs-pre123')
state.write_text(updated)
primitive.write_text('\n'.join(line for line in primitive_text.split('\n')
                               if line not in primitive_rows))
for name in ('docs/ownership.md', 'docs/design.md', 'docs/primitive-ownership.md'):
    path = ROOT / name
    text = path.read_text().replace('main through PR #122', 'main through PR #123')
    text = text.replace('Main through PR #122', 'Main through PR #123')
    if name == 'docs/ownership.md':
        start = text.index('The nine raw-memory declarations need a separate review:')
        end = text.index('\nAcceptance includes full exact-head', start)
        text = text[:start] + '''PR123 accepts borrowed arguments for all nine raw-memory declarations.
mem.alloc/mem.string allocate raw C buffers released explicitly by mem.free;
mem.string copies its input without changing managed input ownership.
ptr.read-string makes an independent counted managed String. Native copy,
last-owner release, omitted-sharing and omitted-fresh-owner controls pass along
with raw interpreter agreement. Pointer arithmetic wraps at the native pointer
width, with matching interpreter/native boundary checks and UBSan controls on
Linux and both macOS architectures. Ordinary arithmetic remains checked.
This acceptance does not establish F16/128-bit, WebAssembly pointer widths or
automatic raw-buffer lifetime coverage. Unsafe raw reads/writes still require
valid addresses supplied by the program.
''' + text[end:]
    elif name == 'docs/design.md':
        anchor = '## Runtime'
        addition = '''PR123 accepts library input/result/unload ownership, scoped native and
interpreter OpenCL teardown, TLS listener/cache/wire/connect cleanup and File
construction/write/error/resource-frame protections. Fake OpenCL tests verify
API lifetimes; GPU hardware coverage remains separate. Nine raw-memory primitive
contracts borrow inputs; ptr.read-string returns an independent counted String.
Unsigned pointer-width wrapping matches the interpreter and keeps ordinary
checked arithmetic unchanged. Raw C buffers still require explicit mem.free.

'''
        assert addition not in text and anchor in text
        text = text.replace(anchor, addition + anchor, 1)
    else:
        text = text.replace('Bundle54–73 also prepares raw-memory contracts:',
                            'PR123 accepts raw-memory contracts:')
        text = text.replace('candidate contracts, pending full production CI and merge.',
                            'accepted contracts after all exact-head production gates.')
    path.write_text(text)
plan = ROOT / 'PLAN.md'
text = plan.read_text()
start = text.index('Main includes #74')
end = text.index('Phase 2 remaining audits:', start)
text = text[:start] + '''Main includes #74–#123: native macOS ARM/Intel support and selected ownership,
last-owner reclamation and unwind protections. Queues33 and35–73 are accepted;
queue34 is a verified duplicate delivered in #107. Next bundle74–112 resource and
network ownership on the actual PR123 squash, then the finite phase2
exit review. [The handoff](docs/development-state.md) records exact heads,
checks and the next action. Prepared work requires final rebases and full CI.

''' + text[end:]
text = text.replace('Repair reproduced FFI pointer-offset overflow and verify raw-memory\n'
                    'boundaries.',
                    'FFI pointer-offset and raw-memory copy contracts are accepted;\n'
                    'remaining numeric widths and unsafe-buffer lifetimes stay explicit.')
plan.write_text(text)
print('Recorded verified PR123 acceptance; removed20 accepted live rows')
