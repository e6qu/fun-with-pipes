#!/usr/bin/env python3
"""Inspect original returned-variant transfer/control binaries and layouts."""
import hashlib,json,os,platform,re,subprocess
from pathlib import Path
root=Path(os.environ['FWP_LAYOUT_CAPTURE']);cc=os.environ.get('FWP_LAYOUT_REAL_CC','clang');machine=platform.machine()
headers={'arm64':'cffaedfe0c0000010000000002000000','x86_64':'cffaedfe070000010300000002000000'}
assert machine in headers
report={'head':subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip(),'machine':machine,'hardware':subprocess.check_output(['sysctl','-n','machdep.cpu.brand_string'],text=True).strip(),'os':subprocess.check_output(['sw_vers'],text=True),'compiler':subprocess.check_output([cc,'--version'],text=True),'limits':'Original instrumented alias fixture; static instructions not dynamic execution. No production speed, allocation count, ABI, cache or frame-size guarantee.'}
folders=sorted(p for p in (root/'alias').iterdir() if p.is_dir());assert len(folders)==4
records=[]
for folder in folders:
 binary=folder/'probe';code=(folder/'probe.c').read_text();assert binary.read_bytes()[:16].hex()==headers[machine]
 a=code.index('/* holder :');b=code.index('/* concat :',a);holder=code[a:b]
 assert 'fwp_vbox' not in holder and 'fwp_vunbox' not in holder
 extra=len(re.findall(r'\bfwp_vdup[0-9]+\(',holder));assert extra in [0,1]
 assembly=subprocess.check_output(['otool','-tvV',str(binary)],text=True);(folder/'disassembly.txt').write_text(assembly)
 (folder/'symbols.txt').write_text(subprocess.check_output(['nm','-nm',str(binary)],text=True))
 lines=assembly.splitlines();functions={}
 for name in ['_main:','_f1:']:
  if name not in lines:continue
  a=lines.index(name);b=next((i for i in range(a+1,len(lines)) if re.match(r'^\S.*:$',lines[i])),len(lines));block=lines[a:b]
  (folder/(name[1:-1]+'.txt')).write_text('\n'.join(block)+'\n')
  functions[name]={'instructions':sum(bool(re.match(r'^[0-9a-f]{16}\s+',line)) for line in block),'prologue':block[1:14]}
 record=json.loads((folder/'header.json').read_text());record.update(directory=folder.name,binaryBytes=binary.stat().st_size,extraAliasRetains=extra,functions=functions);records.append(record)
for opt in ['O1','O2']:
 selected=[r for r in records if r['directory'].startswith(opt+'-')];assert len(selected)==2 and {r['extraAliasRetains'] for r in selected}=={0,1}
positive=next(r for r in records if r['directory'].startswith('O2-') and r['extraAliasRetains']==0);selected=root/'alias'/positive['directory'];code=(selected/'probe.c').read_text()
layout=root/'alias'/'layout.c';layout.write_text('#define main original_probe_main\n'+code+'\n#undef main\n#include <stddef.h>\nint main(void){printf("V=%zu align=%zu array_header=%zu array_align=%zu slot=%zu variant=%zu variant_align=%zu payload=%zu\\n",sizeof(V),_Alignof(V),sizeof(fwp_arr),_Alignof(fwp_arr),sizeof(((fwp_arr*)0)->d[0]),sizeof(fwp_u3),_Alignof(fwp_u3),offsetof(fwp_u3,f));return 0;}\n')
args=json.loads((selected/'args.json').read_text());args=[str(layout) if arg.endswith('.c') else arg for arg in args];args[args.index('-o')+1]=str(root/'alias'/'layout');subprocess.run([cc,*args],check=True)
report['binaries']=records;report['layoutSourceSha256']=hashlib.sha256(code.encode()).hexdigest();report['layout']=subprocess.check_output([str(root/'alias'/'layout')],text=True).strip()
(root/'inspection.json').write_text(json.dumps(report,indent=2)+'\n');print(machine,report['layout'])
