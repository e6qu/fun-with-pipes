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
    default:return fwp_p_lines(text,console_drop_list);
    }
}
static void console_drop(int kind,V value) {
    if(kind==0) fwp_rc_free_obj(value);
    else if(kind==1 && value) {fwp_rc_free_obj(OBJ(value)->f[0]);fwp_rc_free_obj(value);}
    else if(kind>=2) console_drop_list(value);
}
int main(int argc,char **argv) {
    if(argc!=2)return 202;
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    char *arguments[]={"program","first","h\xc3\xa9llo","\xff"};
    fwp_argc=4;fwp_argv=arguments;
    V text=fwp_rc_fresh(fwp_str_new("a\r\nb\n\nlast\r",11));
    const char *setting=getenv("FWP_CONSOLE_COLLECTION");
    console_collect=setting && !strcmp(setting,"1");
    intptr_t budget=fwp_gc.budget;
    for(int kind=0;kind<5;kind++) {
        for(int i=0;i<128;i++) {
            console_events=0;
            V value=console_call(kind,argv[1],text);
            if(kind==3 && fwp_list_len(value)!=3)return 203;
            if(kind==4 && fwp_list_len(value)!=4)return 204;
            console_drop(kind,value);
            if(!console_collect && fwp_gc.budget!=budget)return 205;
            if(console_heap_live)return 211;
        }
        int count=console_events;
        fwp_trap_recover=console_recover;fwp_trap_jb=&console_failure;
        fwp_trap_cleanup=fwp_cleanups;
        for(int event=1;event<=count;event++) {
            console_events=0;console_fail_at=event;
            if(!setjmp(console_failure)) {(void)console_call(kind,argv[1],text);return 206;}
            if(fwp_cleanups!=fwp_trap_cleanup)return 207;
            if(console_heap_live)return 212;
            if(!console_collect && fwp_gc.budget!=budget)return 208;
            if(*fwp_rc_slot(text)!=1 || STR(text)->len!=11)return 209;
        }
        console_fail_at=0;fwp_trap_recover=0;fwp_trap_jb=0;fwp_trap_cleanup=0;
    }
    fwp_rc_free_obj(text);
    if(console_collect && !fwp_gc.ncollect)return 210;
    return 0;
}
