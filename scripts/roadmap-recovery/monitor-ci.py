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
    'gc_build_diagnostics': (38161909445, '6f2ff860197831b990c2c918e25aa29871488ea3'),
    'main123_docs': (38161107226, 'b4285fc177b3ae7afaf195e5ebd7115cc77b815c'),
    'autodiff_allocations': (38159536008, '9ae50851389fbfa7c5c155fca477a4b958589c99'),
    'list_applicative': (38160607296, '4f21a9ea99c1a06a3f1ba67818936194fe43e42a'),
    'autodiff_scopes': (38159488927, 'fbc7e38087b3708c60d21302e29b9013c7d6fa2c'),
    'autodiff_tapes': (38139112950, '602e076604d3dd759c47b396c10cf848dd9dbb61'),
    'streamlined_handoff_docs': (38160936480, '6a2f51c33d5a355291f7e7a3ee258f733928eb68'),
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
