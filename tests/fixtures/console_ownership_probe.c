static jmp_buf console_failure;
static int console_events, console_fail_at, console_collect, console_heap_live;
static int console_recover(void) { return 1; }
static void console_event(void) {
#if !FWP_ARC_ONLY
    if (console_collect) fwp_gc_collect();
#endif
    if (++console_events == console_fail_at) fwp_trap("console construction probe");
}
static void *console_heap_resize(void *p, size_t n) {
    console_event();
    int fresh=p==NULL;
    void *result=realloc(p,n);
    if(fresh && result)console_heap_live++;
    return result;
}
static void console_heap_free(void *p) {if(p)console_heap_live--;free(p);}
static V console_string(const char *s, size_t n) { console_event(); return fwp_str_new(s,n); }
static V console_lossy(const char *s, size_t n) { console_event(); return fwp_str_lossy(s,n); }
static V console_some(V v) { console_event(); return fwp_some(v); }
static V console_cons(V x, V xs) { console_event(); return fwp_cons(x,xs); }
static V console_node(V tag, size_t n, const V *fields) { console_event(); return fwp_data(tag,n,fields); }
static void *console_resize(void *p, size_t old, size_t next) { console_event(); return fwp_mem_realloc(p,old,next); }
static void console_drop_list(V xs) {
    while (xs && fwp_rc_release_last(xs)) {
        V next=OBJ(xs)->f[1];
        if (fwp_rc_release_last(OBJ(xs)->f[0])) fwp_rc_free_obj(OBJ(xs)->f[0]);
        fwp_rc_free_obj(xs); xs=next;
    }
}
static V console_call(int kind, const char *path, V text) {
    if (kind < 3 && !freopen(path,"rb",stdin)) exit(201);
    switch(kind) {
    case 0:return fwp_read_stdin_all();
    case 1:return fwp_p_read_line();
    case 2:return fwp_p_read_lines(console_drop_list);
    case 3:return fwp_p_args(console_drop_list);
    case 4:return fwp_p_lines(text,console_drop_list);
    default:return fwp_p_env_get(text);
    }
}
static void console_drop(int kind,V value) {
    if(kind==0) fwp_rc_free_obj(value);
    else if((kind==1 || kind>=5) && value) {fwp_rc_free_obj(OBJ(value)->f[0]);fwp_rc_free_obj(value);}
    else if(kind>=2 && kind<=4) console_drop_list(value);
}
static void console_set_environment(const char *value) {
#ifdef _WIN32
    if(!SetEnvironmentVariableA("FWP_ENV_COPY",value))exit(213);
#else
    if(setenv("FWP_ENV_COPY",value,1))exit(213);
#endif
}
int main(int argc,char **argv) {
    if(argc!=2)return 202;
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    char *arguments[]={"program","first","h\xc3\xa9llo","\xff"};
    fwp_argc=4;fwp_argv=arguments;
    V text=fwp_rc_fresh(fwp_str_new("a\r\nb\n\nlast\r",11));
    const char *setting=getenv("FWP_CONSOLE_COLLECTION");
    console_collect=setting && !strcmp(setting,"1");
    V key=fwp_rc_fresh(fwp_str_new("FWP_ENV_COPY",12));
    V nul_key=fwp_rc_fresh(fwp_str_new("FWP_ENV_COPY\0suffix",19));
    intptr_t budget=fwp_gc.budget;
    for(int kind=0;kind<7;kind++) {
        V argument=kind==5 ? key : kind==6 ? nul_key : text;
        for(int i=0;i<128;i++) {
            console_set_environment("copied");
            console_events=0;
            V value=console_call(kind,argv[1],argument);
            if(kind==3 && fwp_list_len(value)!=3)return 203;
            if(kind==4 && fwp_list_len(value)!=4)return 204;
            if(kind==5) {
                console_set_environment("changed");
                if(!value || STR(OBJ(value)->f[0])->len!=6 || memcmp(STR(OBJ(value)->f[0])->d,"copied",6))return 214;
            }
            if(kind==6 && value)return 215;
            console_drop(kind,value);
            if(!console_collect && fwp_gc.budget!=budget)return 205;
            if(console_heap_live)return 211;
        }
        int count=console_events;
        fwp_trap_recover=console_recover;fwp_trap_jb=&console_failure;
        fwp_trap_cleanup=fwp_cleanups;
        for(int event=1;event<=count;event++) {
            console_events=0;console_fail_at=event;
            if(!setjmp(console_failure)) {(void)console_call(kind,argv[1],argument);return 206;}
            if(fwp_cleanups!=fwp_trap_cleanup)return 207;
            if(console_heap_live)return 212;
            if(!console_collect && fwp_gc.budget!=budget)return 208;
            if(*fwp_rc_slot(text)!=1 || STR(text)->len!=11)return 209;
        }
        console_fail_at=0;fwp_trap_recover=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
    }
    fwp_rc_free_obj(text);fwp_rc_free_obj(key);fwp_rc_free_obj(nul_key);
    if(console_collect && !fwp_gc.ncollect)return 210;
    return 0;
}
