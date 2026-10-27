static int snapshot_events,snapshot_fail_at,snapshot_handles;
static jmp_buf snapshot_failure;
static int snapshot_recover(void){return 1;}
static void snapshot_event(void){
 if(++snapshot_events==snapshot_fail_at)fwp_trap("snapshot construction probe");
}
static V snapshot_lossy(const char *s,size_t n){snapshot_event();return fwp_str_lossy(s,n);}
static V snapshot_record(size_t n,const V *fields){snapshot_event();return fwp_record(n,fields);}
static V snapshot_node(V tag,size_t n,const V *fields){snapshot_event();return fwp_data(tag,n,fields);}
static void *snapshot_alloc(size_t n){snapshot_event();return fwp_mem_alloc(n);}
static void *snapshot_leaf(size_t n){snapshot_event();return fwp_alloc_leaf(n);}
static void *snapshot_resize(void *p,size_t old,size_t n){snapshot_event();return fwp_mem_realloc(p,old,n);}
#ifdef _WIN32
static V snapshot_wide(const wchar_t *s,size_t n){snapshot_event();return fwp_win_string(s,n);}
static HANDLE snapshot_find(const wchar_t *p,WIN32_FIND_DATAW *e){HANDLE h=FindFirstFileW(p,e);if(h!=INVALID_HANDLE_VALUE)snapshot_handles++;return h;}
static BOOL snapshot_find_close(HANDLE h){snapshot_handles--;return FindClose(h);}
static LPWCH snapshot_environment(void){LPWCH p=GetEnvironmentStringsW();if(p)snapshot_handles++;return p;}
static BOOL snapshot_environment_free(LPWCH p){snapshot_handles--;return FreeEnvironmentStringsW(p);}
static void snapshot_setting(const char *value){if(!SetEnvironmentVariableA("FWP_SNAPSHOT_COPY",value))exit(249);}
#else
static DIR *snapshot_open(const char *path){DIR *d=opendir(path);if(d)snapshot_handles++;return d;}
static int snapshot_close(DIR *d){snapshot_handles--;return closedir(d);}
static void snapshot_setting(const char *value){if(setenv("FWP_SNAPSHOT_COPY",value,1))exit(249);}
#endif
static void snapshot_drop_text(V v){if(v && fwp_rc_release_last(v))fwp_rc_free_obj(v);}
static void snapshot_drop_pair(V v){
 if(v && fwp_rc_release_last(v)){snapshot_drop_text(OBJ(v)->f[0]);snapshot_drop_text(OBJ(v)->f[1]);fwp_rc_free_obj(v);}
}
static void snapshot_drop_strings(V xs){
 while(xs && fwp_rc_release_last(xs)){V next=OBJ(xs)->f[1];snapshot_drop_text(OBJ(xs)->f[0]);fwp_rc_free_obj(xs);xs=next;}
}
static void snapshot_drop_pairs(V xs){
 while(xs && fwp_rc_release_last(xs)){V next=OBJ(xs)->f[1];snapshot_drop_pair(OBJ(xs)->f[0]);fwp_rc_free_obj(xs);xs=next;}
}
static V snapshot_call(int kind,V path){
 if(kind==0)return fwp_p_dir_list(path,NULL,snapshot_drop_strings);
 if(kind==1)return fwp_p_env_vars(snapshot_drop_pair,snapshot_drop_pairs);
 return fwp_p_dir_create_all(path,NULL);
}
static int snapshot_counts(V xs,int pairs){
 V previous=0;int copied=0;
 for(V rest=xs;rest;rest=OBJ(rest)->f[1]){
  V item=OBJ(rest)->f[0];if(*fwp_rc_slot(rest)!=1 || *fwp_rc_slot(item)!=1)return 243;
  if(pairs){
   if(*fwp_rc_slot(OBJ(item)->f[0])!=1 || *fwp_rc_slot(OBJ(item)->f[1])!=1)return 243;
   V key=OBJ(item)->f[0],value=OBJ(item)->f[1];
   if(STR(key)->len==17 && !memcmp(STR(key)->d,"FWP_SNAPSHOT_COPY",17)){
    if(STR(value)->len!=6 || memcmp(STR(value)->d,"copied",6))return 244;copied=1;
   }
  }
  if(previous && (pairs?fwp_cmp_env(&previous,&item):fwp_cmp_cstr(&previous,&item))>0)return 245;
  previous=item;
 }
 return pairs&&!copied?244:0;
}
static volatile V snapshot_directory,snapshot_created;
int main(int argc,char **argv){
 if(argc!=3)return 246;
 fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
 size_t initial_bytes=fwp_heap.live;
 snapshot_directory=fwp_rc_fresh(fwp_cstr(argv[1]));snapshot_created=fwp_rc_fresh(fwp_cstr(argv[2]));
 size_t live_bytes=fwp_heap.live;
 for(int kind=0;kind<3;kind++){
  V path=kind==2?snapshot_created:snapshot_directory;
  for(int repeat=0;repeat<64;repeat++){
   snapshot_setting("copied");snapshot_events=0;V value=snapshot_call(kind,path);
   if(kind<2){snapshot_setting("changed");int status=snapshot_counts(value,kind==1);if(status)return status;}
   if(kind==0 && fwp_list_len(value)!=35)return 247;
   if(kind==0)snapshot_drop_strings(value);else if(kind==1)snapshot_drop_pairs(value);
   if(snapshot_handles)return 242;
   if(fwp_heap.live!=live_bytes)return 241;
  }
  int count=snapshot_events;
  fwp_trap_recover=snapshot_recover;fwp_trap_jb=&snapshot_failure;fwp_trap_cleanup=fwp_cleanups;
  for(snapshot_fail_at=1;snapshot_fail_at<=count;snapshot_fail_at++){
   snapshot_events=0;
   if(!setjmp(snapshot_failure)){(void)snapshot_call(kind,path);return 248;}
   if(snapshot_handles || fwp_cleanups!=fwp_trap_cleanup)return 242;
   if(fwp_heap.live!=live_bytes)return 241;
   if(*fwp_rc_slot(path)!=1)return 243;
  }
  snapshot_fail_at=0;fwp_trap_recover=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
 }
 snapshot_drop_text(snapshot_directory);snapshot_drop_text(snapshot_created);
 if(fwp_heap.live!=initial_bytes)return 241;
 return 0;
}
