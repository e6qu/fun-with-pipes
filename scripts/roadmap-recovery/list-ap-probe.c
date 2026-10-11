static void *ap_scratch[3];
static unsigned ap_frees[3], ap_allocations, ap_calls, ap_element_drops, ap_list_drops, ap_nodes;
static int ap_mode;
static jmp_buf ap_recovered;
static fwp_task ap_cancelled_task;
static fwp_task *ap_saved_task;
static int ap_recover(void) { return 1; }
static V *list_ap_probe_items(V xs, size_t *n) {
    V *p=fwp_map_items(xs,n);if(ap_allocations>=3) abort();ap_scratch[ap_allocations++]=p;return p;
}
static void *list_ap_probe_alloc(size_t n) {
    void *p=fwp_mem_alloc(n);if(ap_allocations>=3) abort();ap_scratch[ap_allocations++]=p;return p;
}
static void list_ap_probe_free(void *p) {
    for(unsigned i=0;i<3;i++) if(p && p==ap_scratch[i]) ap_frees[i]++;
    fwp_mem_free(p);
}
static V list_ap_probe_data(uint32_t tag,uint32_t n,const V *fields) {
    ap_nodes++;
    if(ap_mode==3 && ap_nodes==2) fwp_trap("list.ap spine control");
    return fwp_data(tag,n,fields);
}
static void ap_arguments(V *args,uint32_t offset,uint32_t n) { (void)args;(void)offset;(void)n; }
static void ap_captures(V callback,int duplicate) { (void)callback;(void)duplicate; }
static V ap_entry(V *args,char prefix) {
    ap_calls++;
    fwp_gc_collect();
    if(!fwp_gc.armed || !fwp_gc.ncollect) fwp_trap("list.ap collection absent");
    if(ap_calls==3 && ap_mode==1) fwp_trap("list.ap callback control");
    if(ap_calls==3 && ap_mode==2) fwp_check_cancel();
    char text[32];int n=snprintf(text,sizeof(text),"%c%lld",prefix,(long long)args[0]);
    return fwp_rc_fresh(fwp_str_new(text,(size_t)n));
}
static V ap_entry_a(V *args) { return ap_entry(args,'A'); }
static V ap_entry_b(V *args) { return ap_entry(args,'B'); }
static const fwp_owned_fninfo ap_owned_a={ap_entry_a,ap_captures,ap_arguments,ap_arguments};
static const fwp_owned_fninfo ap_owned_b={ap_entry_b,ap_captures,ap_arguments,ap_arguments};
static const fwp_fninfo ap_entries[]={
    {1,ap_entry_a,"ap A",&ap_owned_a},{1,ap_entry_b,"ap B",&ap_owned_b}
};
static fwp_clo ap_callback_a={0,0},ap_callback_b={1,0};
static void ap_drop_element(V value) { ap_element_drops++;DROP_STRING(value); }
static void ap_drop_list(V value) { ap_list_drops++;DROP_LIST(value); }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    V fs=fwp_cons(PTR(&ap_callback_a),fwp_cons(PTR(&ap_callback_b),0));
    V xs=fwp_cons(1,fwp_cons(2,0));
    fwp_fns=ap_entries;
    fwp_trap_recover=ap_recover;fwp_trap_jb=&ap_recovered;fwp_trap_cleanup=0;
    for(ap_mode=PROBE_FIRST_MODE;ap_mode<4;ap_mode++) {
        memset(ap_scratch,0,sizeof(ap_scratch));memset(ap_frees,0,sizeof(ap_frees));
        ap_allocations=ap_calls=ap_element_drops=ap_list_drops=ap_nodes=0;
        if(ap_mode==2) {
            ap_saved_task=fwp_cur;memset(&ap_cancelled_task,0,sizeof(ap_cancelled_task));
            ap_cancelled_task.cancelled=1;fwp_cur=&ap_cancelled_task;
            if(!setjmp(ap_cancelled_task.base)) { fwp_p_list_ap_owned(fs,xs,ap_drop_element,ap_drop_list);return 82; }
            fwp_cur=ap_saved_task;if(!ap_cancelled_task.unwinding) return 83;
        } else if(!setjmp(ap_recovered)) {
            V result=fwp_p_list_ap_owned(fs,xs,ap_drop_element,ap_drop_list);
            if(ap_mode) return 84;
            const char *expected[]={"A1","A2","B1","B2"};unsigned i=0;
            for(V node=result;node;node=OBJ(node)->f[1]) {
                if(i>=4 || !fwp_rc_slot(node) || *fwp_rc_slot(node)!=1) return 86;
                V value=OBJ(node)->f[0];
                if(!fwp_rc_slot(value) || *fwp_rc_slot(value)!=1 || strcmp(STR(value)->d,expected[i++])) return 87;
            }
            if(i!=4 || ap_calls!=4) return 87;
            DROP_LIST(result);
        } else {
            const char *expected=ap_mode==1?"list.ap callback control":"list.ap spine control";
            if(strcmp(fwp_trap_msg,expected)) return 84;
        }
        if(fwp_cleanups || ap_allocations!=3) return 85;
        for(unsigned i=0;i<3;i++) if(!ap_scratch[i] || ap_frees[i]!=1) return 81;
        if((ap_mode==1 || ap_mode==2) && ap_element_drops!=2) return 89;
        if(ap_mode==3 && (ap_element_drops!=3 || ap_list_drops!=1)) return 90;
    }
    size_t maximum=SIZE_MAX/sizeof(V)-1;
    if(fwp_list_ap_count(0,SIZE_MAX)!=0 || fwp_list_ap_count(1,maximum)!=maximum) return 88;
    const size_t too_large[][2]={{1,maximum+1},{maximum,2},{SIZE_MAX,SIZE_MAX}};
    for(unsigned i=0;i<3;i++) {
        if(!setjmp(ap_recovered)) { fwp_list_ap_count(too_large[i][0],too_large[i][1]);return 88; }
        if(strcmp(fwp_trap_msg,"list.ap too large") || fwp_cleanups) return 88;
    }
    FWP_KEEP_ALIVE(fs);FWP_KEEP_ALIVE(xs);
    printf("list.ap callback and spine ownership; real collections=%zu V=%zu cleanup=%zu\n",fwp_gc.ncollect,sizeof(V),sizeof(fwp_cleanup));
    return 0;
}
