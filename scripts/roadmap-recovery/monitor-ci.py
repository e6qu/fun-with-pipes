"""Collect remote CI status without running any local compiler workload."""
from datetime import datetime, timezone
from pathlib import Path
import json
import subprocess

RUNS = {
    'pr123_ci': (38128387224, 'b0ae00d5512df825271970cafcf569f52dbfc0cd'),
    'pr123_docs': (38128387231, 'b0ae00d5512df825271970cafcf569f52dbfc0cd'),
    'main122_docs': (38127751825, '68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4'),
    'resource_network_preparation': (38130008122, 'cfcb70d16044915206c2e681a72618021ba0ea97'),
}
record = {'observedAt': datetime.now(timezone.utc).isoformat(), 'runs': {}}
for label, (number, head) in RUNS.items():
    run = json.loads(subprocess.check_output([
        'gh', 'run', 'view', str(number), '--json',
        'status,conclusion,headSha,jobs,url'], text=True))
    assert run['headSha'] == head
    record['runs'][label] = dict(databaseId=number, **run)
    jobs = ', '.join(f"{j['name']}={j['conclusion'] or j['status']}"
                     for j in run['jobs'])
    print(f"{label} {number}: {run['conclusion'] or run['status']}; {jobs}", flush=True)
Path('/private/tmp/fwp-roadmap-active-ci-status.json').write_text(
    json.dumps(record, indent=2) + '\n')
