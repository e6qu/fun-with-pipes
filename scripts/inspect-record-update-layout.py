#!/usr/bin/env python3
"""Retain real unchanged record-update fixtures and compiled owner layouts."""
import json,os,platform,re,subprocess
from pathlib import Path
root=Path(os.environ['FWP_LAYOUT_CAPTURE'])
cc=os.environ.get('FWP_LAYOUT_REAL_CC','clang')
machine=platform.machine()
headers={'arm64':'cffaedfe0c0000010000000002000000','x86_64':'cffaedfe070000010300000002000000'}
assert machine in headers,machine
report={'head':subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip(),
'machine':machine,'hardware':subprocess.check_output(['sysctl','-n','machdep.cpu.brand_string'],text=True).strip(),
'os':subprocess.check_output(['sw_vers'],text=True),'compiler':subprocess.check_output([cc,'--version'],text=True),
'limits':'Instrumented original fault/observer fixtures; static registered scopes are not simultaneous live scopes. Owner context sizes are not summed into frames. No production ABI, speed, cache or register claim.', 'fixtures':{}}
for kind,marker in [('unique-update','/* replace-old :'),('general-copy','/* keep :')]:
 folders=sorted(p for p in (root/kind).iterdir() if p.is_dir())
 assert len(folders)==10,(kind,len(folders))
 records=[]
 for folder in folders:
  binary=folder/'probe';code=(folder/'probe.c').read_text()
  assert binary.read_bytes()[:16].hex()==headers[machine]
  start=code.index(marker);end=code.index('/* other :',start)
  function=code[start:end]
  fn=re.search(r'static V f([0-9]+)\(',function).group(1)
  assert 'arm_update();' in function and 'fwp_rc_dup(OBJ(' in function
  scopes=re.findall(r'fwp_cleanup_push\(&([A-Za-z_][A-Za-z_0-9]*)',function)
  assert len(scopes)==len(set(scopes))
  assembly=subprocess.check_output(['otool','-tvV',str(binary)],text=True)
  (folder/'disassembly.txt').write_text(assembly)
  (folder/'symbols.txt').write_text(subprocess.check_output(['nm','-nm',str(binary)],text=True))
  lines=assembly.splitlines();functions={}
  for name in ['_main:','_f'+fn+':']:
   if name not in lines:continue
   a=lines.index(name);b=next((i for i in range(a+1,len(lines)) if re.match(r'^\S.*:$',lines[i])),len(lines))
   block=lines[a:b]
   (folder/(name[1:-1]+'.txt')).write_text('\n'.join(block)+'\n')
   functions[name]={'instructions':sum(bool(re.match(r'^[0-9a-f]{16}\s+',line)) for line in block),'prologue':block[1:14]}
  record=json.loads((folder/'header.json').read_text())
  record.update(directory=folder.name,binaryBytes=binary.stat().st_size,functions=functions,updateFunction='f'+fn,registeredScopes=scopes,uniqueReplacedFieldDrop=any('(OBJ(l0)->f[2]);' in line for line in function.splitlines()))
  records.append(record)
 maximum=max(len(record['registeredScopes']) for record in records)
 assert maximum>=3
 positive=next(record for record in records if len(record['registeredScopes'])==maximum and (kind!='unique-update' or record['uniqueReplacedFieldDrop']))
 original=set(positive['registeredScopes'])
 for opt in ['O1','O2']:
  selected=[r for r in records if r['directory'].startswith(opt+'-')]
  assert len(selected)==5
  assert sum(len(r['registeredScopes'])==maximum for r in selected)==(2 if kind=='unique-update' else 1)
  if kind=='unique-update':assert {r['uniqueReplacedFieldDrop'] for r in selected if len(r['registeredScopes'])==maximum}=={True,False}
  assert all(set(r['registeredScopes'])<=original and len(r['registeredScopes']) in [maximum,maximum-1] for r in selected)
 selected=next(root/kind/r['directory'] for r in records if r['directory'].startswith('O2-') and len(r['registeredScopes'])==maximum and (kind!='unique-update' or r['uniqueReplacedFieldDrop']))
 code=(selected/'probe.c').read_text();start=code.index(marker);end=code.index('/* other :',start)
 contexts=sorted(set(re.findall(r'\b(fwp_owner_ctx[0-9]+)\b',code[start:end])),key=lambda n:int(n.removeprefix('fwp_owner_ctx')))
 assert contexts
 printing='printf("V=%zu align=%zu object_header=%zu payload=%zu cleanup=%zu wide_entry=%zu wide_count=%zu\\n",sizeof(V),_Alignof(V),sizeof(fwp_obj),offsetof(fwp_obj,f),sizeof(fwp_cleanup),sizeof(gc_rc_wide),offsetof(gc_rc_wide,count));'
 for context in contexts:printing+='printf("'+context+'=%zu align=%zu\\n",sizeof('+context+'),_Alignof('+context+'));'
 layout=root/kind/'layout.c'
 layout.write_text('#define main original_probe_main\n'+code+'\n#undef main\n#include <stddef.h>\nint main(void){'+printing+'return 0;}\n')
 args=json.loads((selected/'args.json').read_text());args=[str(layout) if arg.endswith('.c') else arg for arg in args]
 args[args.index('-o')+1]=str(root/kind/'layout')
 subprocess.run([cc,*args],check=True)
 output=subprocess.check_output([str(root/kind/'layout')],text=True).strip()
 report['fixtures'][kind]={'binaries':records,'ownerContexts':contexts,'layout':output,'layoutSourceSha256':__import__('hashlib').sha256(code.encode()).hexdigest()}
 print(kind,machine,output)
(root/'inspection.json').write_text(json.dumps(report,indent=2)+'\n')
