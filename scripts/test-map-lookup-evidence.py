#!/usr/bin/env python3
"""Check experimental integer search against independently scanned map positions."""
import importlib.util
import os
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location('lookup', ROOT / 'scripts/measure-map-lookup.py')
lookup = importlib.util.module_from_spec(spec)
spec.loader.exec_module(lookup)
code = (ROOT / 'runtime/fwp_rt_prims.c').read_text()
start = code.index('static uint64_t fwp_map_find(')
end = code.index('\nstatic ', start + 1)
original = code[start:end]
changed = lookup.lower_bound(original + '\nstatic int boundary;').split('\nstatic int boundary;')[0]
original = original.replace('fwp_map_find(', 'original_map_find(', 1)
prefix = r'''
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
typedef uint64_t V;
typedef struct { uint64_t len; V d[128]; } fwp_map;
typedef struct { int kind; } fwp_desc;
enum { K_I8, K_I16, K_I32, K_I64, K_U8, K_U16, K_U32, K_U64, OTHER };
#define MAP(m) ((fwp_map *)(uintptr_t)(m))
static int fwp_cmp(V a,V b,const fwp_desc *d) { (void)d; return (int64_t)a < (int64_t)b ? -1 : (int64_t)a > (int64_t)b; }
static int less(V a,V b,int kind) { return kind < K_U8 || kind == OTHER ? (int64_t)a < (int64_t)b : a < b; }
'''
main = r'''
static unsigned long checks;
static void query(fwp_map *m, V key, int kind) {
 uint64_t at=0;while(at<m->len && less(m->d[2*at],key,kind))at++;
 int expected=at<m->len && m->d[2*at]==key, found=-1;
 fwp_desc desc={kind};
 uint64_t actual=fwp_map_find((V)(uintptr_t)m,key,&desc,&found);
 int original_found=-1;
 uint64_t previous=original_map_find((V)(uintptr_t)m,key,&desc,&original_found);
 if(actual!=at || found!=expected || previous!=at || original_found!=expected) {
  fprintf(stderr,"kind=%d len=%" PRIu64 " key=%" PRIu64 " expected=%" PRIu64 "/%d actual=%" PRIu64 "/%d\n",kind,m->len,key,at,expected,actual,found);exit(1);
 }
 checks++;
}
int main(void) {
 fwp_map map;
 for(int kind=0;kind<=OTHER;kind++) {
  unsigned bits=kind==OTHER?64:(8u << (kind%4));
  V mask=bits==64?UINT64_MAX:((UINT64_C(1)<<bits)-1);
  int is_signed=kind<K_U8 || kind==OTHER;
  V minimum=is_signed?(UINT64_MAX << (bits-1)):0;
  V maximum=is_signed?(mask>>1):mask;
  for(unsigned n=0;n<=64;n++) {
   map.len=n;
   for(unsigned i=0;i<n;i++)map.d[2*i]=is_signed?(V)((int64_t)i*3-96):(V)(i*3);
   if(n)map.d[0]=minimum;
   if(n>1)map.d[2*(n-1)]=maximum;
   query(&map,minimum,kind);query(&map,maximum,kind);query(&map,0,kind);
   for(unsigned i=0;i<n;i++) {
    V key=map.d[2*i];query(&map,key,kind);
    if(key!=minimum)query(&map,key-1,kind);
    if(key!=maximum)query(&map,key+1,kind);
   }
  }
 }
 printf("%lu search, hit and insertion-position checks pass\n",checks);
 return 0;
}
'''
with tempfile.TemporaryDirectory(prefix='fwp-map-search-') as directory:
    source = Path(directory) / 'probe.c'
    binary = Path(directory) / ('probe' + ('.exe' if os.name == 'nt' else ''))
    source.write_text(prefix + original + changed + main)
    subprocess.run([os.environ.get('CC', 'cc'), '-O2', '-std=gnu11', '-Wall', '-Wextra',
                    '-Werror', str(source), '-o', str(binary)], check=True)
    subprocess.run([str(binary)], check=True)
