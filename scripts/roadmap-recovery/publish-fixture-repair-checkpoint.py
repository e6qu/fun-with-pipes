"""Retain current docs and reviewed recovery drafts outside production ancestry."""
from pathlib import Path
import hashlib
import json
import subprocess

ROOT = Path('/Users/zardoz/projects/fun-with-pipes')
REPO = 'repos/e6qu/fun-with-pipes'
BRANCH = 'roadmap/handoff-pr123-20261011'
OLD = '1992c95d376c343b00a6ca662ac5f9b5f1c28888'
SUBJECT = 'Record passing tape evidence and repair runtime control fixtures'
DOCS = ['CONTRIBUTING.md', 'PLAN.md', 'docs/design.md',
        'docs/development-state.md', 'docs/ownership.md',
        'docs/primitive-ownership.md', 'docs/roadmap-queue.md',
        'docs/roadmap-history.md', 'docs/reference.md',
        'docs/concurrency.md', 'docs/numerics.md']
HELPERS = {
    'scripts/roadmap-recovery/restore-roadmap-recovery.py': '/private/tmp/fwp-restore-roadmap-recovery.py',
    'scripts/roadmap-recovery/recovery-restoration.json': '/private/tmp/fwp-recovery-restoration.json',
    'scripts/roadmap-recovery/publish-declared-trap-controls.py': '/private/tmp/fwp-publish-declared-trap-controls.py',
    'scripts/roadmap-recovery/ad-scope-trap-publication.json': '/private/tmp/fwp-ad-scope-trap-publication.json',
    'scripts/roadmap-recovery/ad-allocation-trap-publication.json': '/private/tmp/fwp-ad-allocation-trap-publication.json',
    'scripts/roadmap-recovery/list-ap-trap-publication.json': '/private/tmp/fwp-list-ap-trap-publication.json',
    'scripts/roadmap-recovery/ad-scope-475-failed.log': '/private/tmp/fwp-ad-scope-475-failed.log',
    'scripts/roadmap-recovery/list-e03-arm-failed.log': '/private/tmp/fwp-list-e03-arm-failed.log',
    'scripts/roadmap-recovery/publish-state-probe-range.py': '/private/tmp/fwp-publish-state-probe-range.py',
    'scripts/roadmap-recovery/state-probe-range-publication.json': '/private/tmp/fwp-state-probe-range-publication.json',
    'scripts/roadmap-recovery/publish-list-probe-fixes.py': '/private/tmp/fwp-publish-list-probe-fixes.py',
    'scripts/roadmap-recovery/list-probe-fixes-publication.json': '/private/tmp/fwp-list-probe-fixes-publication.json',
    'scripts/roadmap-recovery/publish-fixture-repair-checkpoint.py': '/private/tmp/fwp-publish-fixture-repair-checkpoint.py',
    'scripts/roadmap-recovery/preparation-publication.json': '/private/tmp/fwp-resource-network-verified-export/publication.json',
    'scripts/roadmap-recovery/preparation-export-manifest.json': '/private/tmp/fwp-resource-network-verified-export/preparation.json',
    'scripts/roadmap-recovery/state-slot-probe.c': '/private/tmp/fwp-state-slot-probe.c',
    'scripts/roadmap-recovery/state-slot-list-publication.json': '/private/tmp/fwp-state-slot-list-publication.json',
    'scripts/roadmap-recovery/state-slot-clearing-preparation.json': '/private/tmp/fwp-state-slot-clearing-preparation.json',
    'scripts/roadmap-recovery/prepare-state-slot-clearing.py': '/private/tmp/fwp-prepare-state-slot-clearing.py',
    'scripts/roadmap-recovery/publish-state-slot-list-evidence.py': '/private/tmp/fwp-publish-state-slot-list-evidence.py',
    'scripts/roadmap-recovery/publish-state-slot-checkpoint.py': '/private/tmp/fwp-publish-state-slot-checkpoint.py',
    'scripts/roadmap-recovery/primitive-inventory-baseline.json': '/private/tmp/fwp-primitive-inventory-baseline.json',
    'scripts/roadmap-recovery/closure-drop-probe.c': '/private/tmp/fwp-closure-drop-probe.c',
    'scripts/roadmap-recovery/closure-drop-list-publication.json': '/private/tmp/fwp-closure-drop-list-publication.json',
    'scripts/roadmap-recovery/publish-closure-drop-list-evidence.py': '/private/tmp/fwp-publish-closure-drop-list-evidence.py',
    'scripts/roadmap-recovery/formatted-compiler-diagnostics-publication.json': '/private/tmp/fwp-formatted-compiler-diagnostics-publication.json',
    'scripts/roadmap-recovery/publish-formatted-compiler-diagnostics.py': '/private/tmp/fwp-publish-formatted-compiler-diagnostics.py',
    'scripts/roadmap-recovery/measure-list-callback-allocations.py': '/private/tmp/fwp-measure-list-callback-allocations.py',
    'scripts/roadmap-recovery/list-ap-ownership-patch.json': '/private/tmp/fwp-list-ap-ownership-patch.json',
    'scripts/roadmap-recovery/list-ap-test.rs': '/private/tmp/fwp-list-ap-test.rs',
    'scripts/roadmap-recovery/list-ap-probe.c': '/private/tmp/fwp-list-ap-probe.c',
    'scripts/roadmap-recovery/list-ap-evidence.yml': '/private/tmp/fwp-list-ap-evidence.yml',
    'scripts/roadmap-recovery/list-ap-publication.json': '/private/tmp/fwp-list-ap-publication.json',
    'scripts/roadmap-recovery/measure-ad-scope-allocations.py': '/private/tmp/fwp-measure-ad-scope-allocations.py',
    'scripts/roadmap-recovery/ad-scope-allocation.yml': '/private/tmp/fwp-ad-scope-allocation.yml',
    'scripts/roadmap-recovery/ad-allocation-publication.json': '/private/tmp/fwp-ad-allocation-publication.json',
    'scripts/roadmap-recovery/ad-scope-patch.json': '/private/tmp/fwp-ad-scope-patch.json',
    'scripts/roadmap-recovery/ad-scope-test.rs': '/private/tmp/fwp-ad-scope-test.rs',
    'scripts/roadmap-recovery/ad-scope-probe.c': '/private/tmp/fwp-ad-scope-probe.c',
    'scripts/roadmap-recovery/ad-scope-evidence.yml': '/private/tmp/fwp-ad-scope-evidence.yml',
    'scripts/roadmap-recovery/ad-scope-publication.json': '/private/tmp/fwp-ad-scope-publication.json',
    'scripts/roadmap-recovery/export_prepared_commits.py': '/private/tmp/fwp-export-prepared-commits.py',
    'scripts/roadmap-recovery/publish-exported-history.py': '/private/tmp/fwp-publish-exported-history.py',
    'scripts/roadmap-recovery/prepare-resource-network.py': '/private/tmp/fwp-resource-network-runner-script.py',
    'scripts/roadmap-recovery/preparation-export.yml': '/private/tmp/fwp-resource-network-runner-workflow.yml',
    'scripts/roadmap-recovery/preparation-export-driver.json': '/private/tmp/fwp-preparation-export-driver.json',
    'scripts/roadmap-recovery/ad-ownership-patch.json': '/private/tmp/fwp-ad-ownership-patch.json',
    'scripts/roadmap-recovery/ad-ownership-test.rs': '/private/tmp/fwp-ad-ownership-test.rs',
    'scripts/roadmap-recovery/ad-unwind-probe.c': '/private/tmp/fwp-ad-unwind-probe.c',
    'scripts/roadmap-recovery/ad-ownership-evidence.yml': '/private/tmp/fwp-ad-ownership-evidence.yml',
    'scripts/roadmap-recovery/ad-publication.json': '/private/tmp/fwp-ad-publication.json',
    'scripts/roadmap-recovery/pr123-stdlib-repair.json': '/private/tmp/fwp-pr123-stdlib-repair.json',
    'scripts/roadmap-recovery/cache-lifetime-test.rs': '/private/tmp/fwp-cache-lifetime-test.rs',
    'scripts/roadmap-recovery/compiler-diagnostics-patch.json': '/private/tmp/fwp-compiler-diagnostics-patch.json',
    'scripts/roadmap-recovery/compiler-diagnostics-test.rs': '/private/tmp/fwp-compiler-diagnostics-test.rs',
    'scripts/roadmap-recovery/finalize-resource-network.py': '/private/tmp/fwp-finalize-resource-network-on-runner.py',
    'scripts/roadmap-recovery/finalize-resource-network.yml': '/private/tmp/fwp-finalize-resource-network-on-runner.yml',
    '.github/workflows/handoff-audit.yml': '/private/tmp/fwp-streamlined-handoff-audit.yml',
    'scripts/roadmap-recovery/merge-pr123.py': '/private/tmp/fwp-merge-pr123.py',
    'scripts/roadmap-recovery/protect-main-after123.py': '/private/tmp/fwp-protect-main-after123.py',
    'scripts/roadmap-recovery/record-pr123-acceptance.py': '/private/tmp/fwp-record-pr123-acceptance.py',
    'scripts/roadmap-recovery/monitor-ci.py': '/private/tmp/fwp-monitor-roadmap-ci.py',
    'scripts/roadmap-recovery/check-primitive-inventory.py': '/private/tmp/fwp-check-primitive-inventory-exit.py',
    'scripts/roadmap-recovery/primitive-inventory.rs': '/private/tmp/fwp-primitive-inventory-exit.rs',
    'scripts/roadmap-recovery/gc-strict-build-draft.rs': '/private/tmp/fwp-gc-strict-build-draft.rs',
    'scripts/roadmap-recovery/gc-diagnostics-ci-draft.yml': '/private/tmp/fwp-gc-diagnostics-ci-draft.yml',
    'scripts/roadmap-recovery/gc-build-diagnostics-evidence.yml': '/private/tmp/fwp-gc-build-diagnostics-evidence.yml',
}

def api(endpoint, payload=None, method='POST'):
    args = ['gh', 'api', REPO + endpoint]
    if payload is not None:
        path = Path('/private/tmp/fwp-recovery-helper-api-input.json')
        path.write_text(json.dumps(payload))
        args += ['--method', method, '--input', str(path)]
    return json.loads(subprocess.check_output(args, text=True))

old_audit = api('/actions/runs/38156304805')
assert old_audit['head_sha'] == OLD
if old_audit['status'] == 'queued':
    jobs = api('/actions/runs/38156304805/jobs')['jobs']
    assert all(job['status'] == 'queued' for job in jobs)
    subprocess.run(['gh', 'run', 'cancel', '38156304805'], check=True)
else:
    assert old_audit['status'] == 'completed', 'Retain any running audit until it completes'
assert len(SUBJECT) <= 80 and '\n' not in SUBJECT
assert api('/git/ref/heads/' + BRANCH)['object']['sha'] == OLD
base = api('/git/commits/' + OLD)
data = {name: (ROOT / name).read_bytes() for name in DOCS}
data.update({name: Path(source).read_bytes() for name, source in HELPERS.items()})
tree = api('/git/trees', dict(base_tree=base['tree']['sha'], tree=[
    dict(path=name, mode='100644', type='blob', content=content.decode())
    for name, content in data.items()]))
commit = api('/git/commits', dict(message=SUBJECT, tree=tree['sha'], parents=[OLD]))
assert commit['message'] == SUBJECT and len(commit['parents']) == 1
assert commit['parents'][0]['sha'] == OLD
files = api('/git/trees/' + tree['sha'] + '?recursive=1')
assert not files['truncated']
hashes = {entry['path']: entry['sha'] for entry in files['tree']}
for name, content in data.items():
    assert hashes[name] == hashlib.sha1(
        b'blob ' + str(len(content)).encode() + b'\0' + content).hexdigest(), name
ref = api('/git/refs/heads/' + BRANCH, dict(sha=commit['sha'], force=False), method='PATCH')
assert ref['object']['sha'] == commit['sha']
Path('/private/tmp/fwp-fixture-repair-checkpoint.json').write_text(json.dumps(
    dict(head=commit['sha'], previous=OLD, branch=BRANCH,
         sourceHashes={name: hashlib.sha256(content).hexdigest()
                       for name, content in data.items()},
         stage='Recovery drafts retained; no native workload or new audit executed'),
    indent=2) + '\n')
print(commit['sha'])
