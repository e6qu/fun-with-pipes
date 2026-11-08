#!/usr/bin/env python3
"""Reject changed real evidence, restoring every byte before artifact retention."""
import argparse
import importlib.util
import json
from pathlib import Path

SPEC = importlib.util.spec_from_file_location('structured_audit', Path(__file__).with_name('audit-structured-ad.py'))
AUDIT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AUDIT)


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory',type=Path,required=True)
    parser.add_argument('--compiler',type=Path,required=True)
    parser.add_argument('--cc',required=True)
    parser.add_argument('--source',required=True)
    parser.add_argument('--machine',choices=('aarch64','x86_64'),required=True)
    parser.add_argument('--session',type=int,choices=(1,2),required=True)
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    directory=args.directory.resolve()
    positive=json.loads((directory/'audit.json').read_text())
    assert positive['source']==args.source and positive['methodCases']==41 and positive['session']==args.session
    rejected=[]

    def check(label,path,changed):
        original=path.read_bytes()
        assert original!=changed
        try:
            path.write_bytes(changed)
            try:
                AUDIT.audit(directory,args.compiler.resolve(),args.cc,args.source,args.machine,args.session)
            except AssertionError:
                rejected.append(label)
            else:
                raise RuntimeError('auditor accepted '+label)
        finally:
            path.write_bytes(original)
        assert path.read_bytes()==original
        print(label,'rejected; original evidence restored',flush=True)

    samples=directory/'neighbors-0/samples.jsonl'
    check('missing timing observation',samples,b'\n'.join(samples.read_bytes().splitlines()[:-1])+b'\n')
    commands=directory/'commands.jsonl'
    rows=[json.loads(line) for line in commands.read_text().splitlines()]
    row=next(row for row in rows if '-fno-fast-math' in row['command'])
    row['command'][row['command'].index('-fno-fast-math')]='-ffast-math'
    check('changed arithmetic policy',commands,(''.join(json.dumps(row)+'\n' for row in rows)).encode())
    binary=directory/'neighbors-0/reverse'
    data=bytearray(binary.read_bytes()); data[18:20]=(0).to_bytes(2,'little')
    check('wrong native architecture',binary,bytes(data))
    summary=directory/'summary.json'
    report=json.loads(summary.read_text()); report['neighbors-0']['vsReverse']['forward']['ratio']=0.001
    check('invented speed ratio',summary,(json.dumps(report,indent=2)+'\n').encode())
    if args.session==1:
        path=directory/'neighbors-0/reverse-memory-1.stderr'
        managed,raw=[json.loads(line) for line in path.read_text().splitlines()]
        managed['finalChargedBytes']=1
        check('unreleased managed storage',path,(json.dumps(managed)+'\n'+json.dumps(raw)+'\n').encode())
    args.output.write_text(json.dumps(dict(source=args.source,session=args.session,rejected=rejected,
        restored=True),indent=2)+'\n')


if __name__=='__main__':
    main()
