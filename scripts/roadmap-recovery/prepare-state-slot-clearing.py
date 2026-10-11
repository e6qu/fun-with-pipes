"""Prepare exact-base State root clearing without running local compilers."""
from pathlib import Path
import base64,json,subprocess
REPO='repos/e6qu/fun-with-pipes'
BASE='9e7d0b24610524cf54125c44b47ee07185c0b7c3'
CURRENT='88b5e20a497e6482ea7918d26a961531588499b0'
PREPARED='b45e93a71d400ae3872142c70b29aa8128793e07'
def source(head,name):
 d=json.loads(subprocess.check_output(['gh','api',REPO+'/contents/'+name+'?ref='+head],text=True))
 assert d['encoding']=='base64';return base64.b64decode(d['content']).decode()
recipe=json.loads(Path('/private/tmp/fwp-list-ap-ownership-patch.json').read_text())
helpers='''/* Unused State slots must not remain conservative roots in this buffer. */
static void fwp_state_restore(size_t depth) {
    while (fwp_state_len > depth) fwp_state[--fwp_state_len] = 0;
    fwp_state_len = depth;
}

static V fwp_state_pop(void) {
    V value = fwp_state[fwp_state_len - 1];
    fwp_state[fwp_state_len - 1] = 0;
    fwp_state_len--;
    return value;
}

'''
replacements={
 'runtime/fwp_rt.c': [('static void fwp_state_push(V s) {',helpers+'static void fwp_state_push(V s) {')],
 'runtime/fwp_rt_prims.c': [
  ('fwp_state_len = h.state_depth;', 'fwp_state_restore(h.state_depth);'),
  ('V st = fwp_state[--fwp_state_len];','V st = fwp_state_pop();')],
 'runtime/fwp_rt_grpc.c': [('fwp_state_len = h.state_depth;','fwp_state_restore(h.state_depth);')],
 'runtime/fwp_rt_task.c': [
  ('        fwp_state_len = 0;', '        fwp_state_restore(0);'),
  ('    t->unwinding = 1;\n    fwp_handlers = 0;\n    fwp_join_children();',
   '    t->unwinding = 1;\n    fwp_handlers = 0;\n    fwp_state_restore(0);\n    fwp_join_children();'),
  ('fwp_state_len = h.state_depth;','fwp_state_restore(h.state_depth);')],
 'src/cgen.rs': [('fwp_state_len = h.state_depth;','fwp_state_restore(h.state_depth);')],
}
counts={}
for name,edits in replacements.items():
 original=source(BASE,name);candidate=source(CURRENT,name);prepared=source(PREPARED,name)
 replay=original
 for edit in recipe.get(name,[]):
  assert replay.count(edit['old'])==1,(name,edit['old'])
  replay=replay.replace(edit['old'],edit['new'])
 assert replay==candidate,('Existing recipe must reproduce the current evidence',name)
 counts[name]=[]
 for old,new in edits:
  count=candidate.count(old);prepared_count=prepared.count(old)
  assert count>0 and prepared_count>0,(name,old,count,prepared_count)
  candidate=candidate.replace(old,new);prepared=prepared.replace(old,new)
  recipe.setdefault(name,[]).append(dict(old=old,new=new,count=count,preparedCount=prepared_count))
  counts[name].append(dict(old=old,baselineCount=count,preparedCount=prepared_count))
 path=Path('/private/tmp')/('fwp-state-cleared-'+name.replace('/','-'))
 path.write_text(candidate)
Path('/private/tmp/fwp-state-list-ownership-patch.json').write_text(json.dumps(recipe,indent=2)+'\n')
Path('/private/tmp/fwp-state-slot-clearing-preparation.json').write_text(json.dumps(
 dict(base=BASE,current=CURRENT,prepared=PREPARED,counts=counts,
      stage='Exact source transforms prepared; no compiler or native test executed'),indent=2)+'\n')
print(json.dumps(counts,indent=2))
