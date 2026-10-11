"""Collect remote CI status without running any local compiler workload."""
from datetime import datetime, timezone
from pathlib import Path
import json
import subprocess

RUNS = {
    'pr123_ci': (38138731040, '9e7d0b24610524cf54125c44b47ee07185c0b7c3'),
    'pr123_docs': (38138731036, '9e7d0b24610524cf54125c44b47ee07185c0b7c3'),
    'main122_docs': (38127751825, '68f959bbf28cfc00ed91a9f4c6dd6836020ff2a4'),
    'resource_network_preparation': (38140923130, '82c7bc7509c04b9e94004c06b02d83d665539ac6'),
    'gc_build_diagnostics': (38151169253, 'a27f8e5f78ab12e397119b76049aa6eefbf88157'),
    'autodiff_allocations': (38145198463, 'e586a4d12a477aefcc854e12f6bbf2f640299de8'),
    'list_applicative': (38152053646, '88b5e20a497e6482ea7918d26a961531588499b0'),
    'autodiff_scopes': (38141558055, '475cb242715961e5e396e4fe74026545160d2e3c'),
    'autodiff_tapes': (38139112950, '602e076604d3dd759c47b396c10cf848dd9dbb61'),
    'streamlined_handoff_docs': (38151272665, 'd4411019cdde0dfd41c17ad923d85ece6a6d87d1'),
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
