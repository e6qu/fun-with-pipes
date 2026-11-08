#!/usr/bin/env python3
"""Audit saved-image CPU-placement observations without executing binaries."""
import argparse
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import zipfile

spec=importlib.util.spec_from_file_location('affinity',Path(__file__).with_name('diagnose-array-affinity.py'))
affinity=importlib.util.module_from_spec(spec);spec.loader.exec_module(affinity)
def main():
    parser=argparse.ArgumentParser(description=__doc__)
    for name in ('archive','receipt','baseline','log','output'):
        parser.add_argument('--'+name,type=Path,required=True)
    args=parser.parse_args()
    receipt=json.loads(args.receipt.read_text())
    path=args.archive
    assert receipt['digest']=='sha256:'+hashlib.sha256(path.read_bytes()).hexdigest()
    verified=json.loads(gzip.decompress(args.baseline.read_bytes()))['x86_64-2']
    root=args.output;root.mkdir(parents=True,exist_ok=False)
    with zipfile.ZipFile(path) as archive:
        assert archive.testzip() is None
        report=json.loads(archive.read('summary.json'))
        host=json.loads(archive.read('host.json'))
        assert host['source']==report['source']==receipt['workflow_run']['head_sha']
        assert report['measuredSource']==verified['identity']['source']
        assert host['qualified'] and host['failures']==[]
        assert affinity.host_failures(set(host['models']),host['assignedProcessors'],host['allowedModels'],host['processorIndex'])==[]
        assert report['processors']==host['assignedProcessors']
        processors=report['processors']
        assert report['placements']==dict(all=','.join(map(str,processors)),
            one=str(processors[host['processorIndex']]))
        original=json.loads(archive.read('input-audit.json'))
        assert original=={key:verified[key] for key in ('identity','cases','commands','qualification')}
        commands=[json.loads(line) for line in archive.read('commands.jsonl').splitlines()]
        by_output={row['output']:row for row in commands};assert len(by_output)==len(commands)==416
        consumed=set(); results={}
        for case in affinity.CASES:
            expected=json.loads(archive.read(f'original/array-costs/{case}/round-0-candidate.stdout'))
            digest=verified['cases'][case]['binaryHashes']['candidate']
            for role in affinity.ROLES:
                image=archive.read(case+'/'+role)
                assert hashlib.sha256(image).hexdigest()==digest
                assert image[:6]==b'\x7fELF\x02\x01' and int.from_bytes(image[18:20],'little')==62
            rows=[json.loads(line) for line in archive.read(case+'/samples.jsonl').splitlines()]
            for row in rows:
                relative=f"{case}/round-{row['round']}-{row['role']}"
                execution=by_output[relative];consumed.add(relative)
                assert execution['status']==0 and execution['timedOut'] is False and execution['elapsedNs']>0
                argv=execution['command'];assert len(argv)==8 and argv[:3]==['/usr/bin/time','-v','-o']
                assert argv[3].endswith('/'+relative+'.resources')
                assert argv[4:6]==['/usr/bin/taskset','--cpu-list']
                assert argv[6]==report['placements'][row['role'].split('-')[0]]
                assert argv[7].endswith('/'+case+'/'+row['role'])
                assert not archive.read(relative+'.stderr')
                value=json.loads(archive.read(relative+'.stdout'))
                assert value['checksum']==expected['checksum']
                assert value['initialLiveBytes']==value['finalLiveBytes']==expected['initialLiveBytes']
                resources=affinity.AUDIT.OBSERVATIONS.resources(archive.read(relative+'.resources').decode())
                assert row==value|dict(round=row['round'],role=row['role'],processNs=execution['elapsedNs'],processResources=resources)
            result=affinity.summarize(rows)|dict(binarySha256=digest)
            assert result==report['cases'][case];results[case]=result
        assert consumed==set(by_output) and set(results)==set(report['cases'])
        with zipfile.ZipFile(root/'observations.zip','w',zipfile.ZIP_DEFLATED) as retained:
            for name in archive.namelist():
                if not name.endswith('/') and not name.startswith('original/'):
                    retained.writestr(name,archive.read(name))
    (root/'summary.json').write_text(json.dumps(report,indent=2)+'\n')
    (root/'artifact.json').write_text(json.dumps(receipt,indent=2)+'\n')
    (root/'audit.json').write_text(json.dumps(dict(source=report['source'],originalSource=report['measuredSource'],cases=len(results),commands=len(commands),verified=True,auditorSha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest()),indent=2)+'\n')
    (root/'job.log.gz').write_bytes(gzip.compress(args.log.read_bytes(),mtime=0))
    print('Verified four cases, 16 identical/native images and all 416 commands/samples')


if __name__ == '__main__':
    main()
