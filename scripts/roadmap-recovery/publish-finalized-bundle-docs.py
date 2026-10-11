"""Publish current authoritative docs on the verified integrated source tree."""
from pathlib import Path
import hashlib, json, subprocess

ROOT = Path('/Users/zardoz/projects/fun-with-pipes')
REPO = 'repos/e6qu/fun-with-pipes'
BRANCH = 'ownership-resource-network-bundle'
SUBJECT = 'Focus the handoff on verified ownership progress and remaining gates'
DOCS = ['CONTRIBUTING.md', 'PLAN.md', 'docs/design.md', 'docs/development-state.md',
        'docs/ownership.md', 'docs/primitive-ownership.md', 'docs/roadmap-queue.md',
        'docs/roadmap-history.md', 'docs/reference.md', 'docs/concurrency.md', 'docs/numerics.md']
OUT = Path('/private/tmp/fwp-resource-network-finalized-export')
RECEIPT = Path('/private/tmp/fwp-finalized-bundle-doc-publication.json')

def api(endpoint, payload=None, graphql=False):
    argv = ['gh', 'api', 'graphql' if graphql else REPO + endpoint]
    if payload is not None:
        path = Path('/private/tmp/fwp-finalized-docs-api-input.json')
        path.write_text(json.dumps(payload))
        argv += ['--method', 'POST', '--input', str(path)]
    return json.loads(subprocess.check_output(argv, text=True))

assert not RECEIPT.exists(), 'Completed publication must not be repeated'
publication = json.loads((OUT / 'publication.json').read_text())
OLD = publication['head']
assert api('/git/ref/heads/' + BRANCH)['object']['sha'] == OLD
assert api('/git/ref/heads/main')['object']['sha'] == 'b4285fc177b3ae7afaf195e5ebd7115cc77b815c'
assert len(SUBJECT) <= 80 and '\n' not in SUBJECT
parent = api('/git/commits/' + OLD)
assert parent['tree']['sha'] == publication['tree']
data = {name: (ROOT / name).read_bytes() for name in DOCS}
state = data['docs/development-state.md'].decode()
state = state.replace('Next: publish the integrated export with an exact066b4970 lease, update docs,\nopen the sole production PR and require all six exact-head jobs plus roadmap_docs.',
    'Integrated history is published at' + OLD + ' with tree\n' + publication['tree'] + '. All87 commits and155 source blobs match\nrunner snapshots. This documentation commit preserves that native source. Next:\nopen the sole production PR and require all six exact-head jobs plus roadmap_docs.')
state = state.replace('Current prepared branch066b497040ff7b7f59fec6ff3337c63428f83d77 is not yet the\nintegrated production head.',
    'The verified integrated branch head is' + OLD + '. Its exact-head\nproduction gates remain pending; do not substitute the focused passes.')
data['docs/development-state.md'] = state.encode()
(ROOT / 'docs/development-state.md').write_bytes(data['docs/development-state.md'])
tree = api('/git/trees', dict(base_tree=parent['tree']['sha'], tree=[
    dict(path=name, mode='100644', type='blob', content=content.decode())
    for name, content in data.items()]))
before = api('/git/trees/' + parent['tree']['sha'] + '?recursive=1')
after = api('/git/trees/' + tree['sha'] + '?recursive=1')
assert not before['truncated'] and not after['truncated']
def entries(result):
    return {x['path']: (x['sha'], x['mode'], x['type']) for x in result['tree'] if x['type'] != 'tree'}
b, a = entries(before), entries(after)
assert set(b) == set(a)
assert {name for name in a if a[name] != b[name]} <= set(DOCS)
for name, content in data.items():
    assert a[name][0] == hashlib.sha1(b'blob ' + str(len(content)).encode() + b'\0' + content).hexdigest()
commit = api('/git/commits', dict(message=SUBJECT, tree=tree['sha'], parents=[OLD]))
assert commit['message'] == SUBJECT and [x['sha'] for x in commit['parents']] == [OLD]
repository = api('')['node_id']
result = api('', dict(query='mutation($repo:ID!,$updates:[RefUpdate!]!){updateRefs(input:{repositoryId:$repo,refUpdates:$updates}){clientMutationId}}',
    variables=dict(repo=repository, updates=[dict(name='refs/heads/' + BRANCH, beforeOid=OLD, afterOid=commit['sha'], force=False)])), graphql=True)
assert not result.get('errors'), result
assert api('/git/ref/heads/' + BRANCH)['object']['sha'] == commit['sha']
RECEIPT.write_text(json.dumps(dict(head=commit['sha'], previous=OLD, tree=tree['sha'], branch=BRANCH,
    sourceHashes={name: hashlib.sha256(content).hexdigest() for name, content in data.items()},
    stage='Authoritative docs published; exact production gates pending'), indent=2) + '\n')
print(commit['sha'], flush=True)
