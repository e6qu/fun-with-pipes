import argparse
import hashlib
import json
from pathlib import Path

from compiler_build_comparison import comparison
from nested_resource_timing import summarize
from nested_resource_analysis import decode
from weak_callback_timing import decode_output, summarize as peer_summary

parser = argparse.ArgumentParser()
parser.add_argument('--input', type=Path, required=True)
parser.add_argument('--source', required=True)
parser.add_argument('--output', type=Path, required=True)
args=parser.parse_args()
root=args.input
result=dict(source=args.source, service=[], peers=[], compiler=[], proof={})
for directory, label in (('nested-time-comparison','service'),('nested-time-peers','peers')):
    folder=root/directory
    report=json.loads((folder/'report.json').read_text())
    manifest=json.loads((folder/'manifest.json').read_text())
    assert hashlib.sha256((folder/'report.json').read_bytes()).hexdigest()==manifest['report.json']
    assert report['source']==args.source and not report['failures']
    if label=='service':
        assert report['referenceSource']=='65719f7fc2277a5b97c5a790df941fea6c5eb4d7'
    if label=='service':
        commands=[json.loads(line) for line in (folder/'commands.jsonl').read_text().splitlines()]
        assert hashlib.sha256((folder/'commands.jsonl').read_bytes()).hexdigest()==manifest['commands.jsonl']
        for index,row in enumerate(commands):
            assert row['index']==index and row['status']==0 and row['stderr']==''
    for session,cases in report['sessions'].items():
        assert len(cases)==8
        for key,case in cases.items():
            if label=='service':
                population,mode=map(int,key.split('-'))
                for sample in case['warmups']+case['samples']:
                    raw=commands[sample['command']]
                    assert raw['command'][-3:]==list(map(str,(population,mode,case['batches'])))
                    value=decode_output(raw['stdout'],population,mode,case['batches'])
                    if 'ns' in sample:
                        assert sample['ns']==dict(service=value['serviceNs'],process=raw['elapsedNs'])
            actual=summarize(case['samples'],int(key.split('-')[0])) if label=='service' else peer_summary(case['samples'])
            assert actual==case['summary']
            row=dict(session=session,case=key,summary=actual,memory=case['memory'])
            if label=='service':
                peaks={role:max(r['peakRssKiB'] for r in samples) for role,samples in case['memory'].items()}
                ratio=peaks['candidate']/peaks['reference']
                assert ratio==case['peakRssRatio'] and (ratio<=1.05)==case['rssTargetMet']
                row.update(peakRssKiB=peaks,peakRssRatio=ratio,rssTargetMet=case['rssTargetMet'])
            result[label].append(row)
for session in (1,2):
    report=json.loads((root/f'nested-compiler-session-{session}/summary.json').read_text())
    assert report['identity']['source']==args.source and report['identity']['contract']=='nested-resources'
    assert report['identity']['session']==session and not report['failures'] and len(report['cases'])==16
    for name,case in report['cases'].items():
        assert case['correct']
        actual=comparison(case['samples'],name,'nested-resources')
        for key,value in actual.items(): assert case[key]==value
        result['compiler'].append(dict(session=session,case=name,**actual))
report=json.loads((root/'nested-analysis-observations/report.json').read_text())
assert report['source']==args.source and not report['failures'] and len(report['cases'])==16
for name,case in report['cases'].items():
    proofs=decode(case['commands']['observed']['stderr'])
    assert proofs==case['proofs'] and case['commands']['ordinary']['stderr']==''
    assert all(row['status']==0 and row['stdout']=='' for row in case['commands'].values())
    totals={key:sum(p[key] for p in proofs) for key in ('freshVisits','bodyVisits','aliasVisits','selected')}
    assert totals==case['totals']
    result['proof'][name]=dict(**totals,emittedSelections=case['emittedSelections'])
args.output.write_text(json.dumps(result,indent=2)+'\n')
for kind in ('service','peers','compiler'):
    print(kind,len(result[kind]))
    if kind=='service':
        for row in result[kind]:
            t=row['summary']['service']
            print(row['session'],row['case'],'ratio',t['candidateOverReference'],'qualified',t['qualified'],'target',t['timingTargetMet'],'rss',row['peakRssRatio'])
    if kind=='compiler':
        print('unmet',[dict(case=r['case'],session=r['session'],ratio=r['candidateRatio'],qualified=r['timingQualified'],rss=r['peakRssRatio']) for r in result[kind] if not r['acceptance']])
