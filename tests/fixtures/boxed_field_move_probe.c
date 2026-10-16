static V conversion_box;
static V conversion_factory(V *args) { (void)args; return conversion_box; }
static void conversion_drop(V v) {
    if (v && fwp_rc_release_last(v)) fwp_rc_free_obj(v);
}
static void conversion_drop_box(V v) {
    if (fwp_rc_release_last(v)) {
        conversion_drop(OBJ(v)->f[0]); conversion_drop(OBJ(v)->f[1]);
        conversion_drop(OBJ(v)->f[3]); fwp_rc_free_obj(v);
    }
}
static int conversion_recover(void) { return 1; }
static jmp_buf conversion_failure;
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns=fwp_fn_table; fwp_init_consts();
    fwp_fninfo table[sizeof fwp_fn_table / sizeof *fwp_fn_table];
    memcpy(table,fwp_fn_table,sizeof table);
    fwp_owned_fninfo factory=*table[2].owned;
    factory.entry=conversion_factory; table[2].owned=&factory; table[2].entry=conversion_factory;
    fwp_fns=table;
    fwp_clo callback={2,0};
    const char *stress=getenv("FWP_GC_STRESS");
    int collecting=stress&&!strcmp(stress,"1");
    intptr_t budget=fwp_gc.budget;
    for (volatile int shared=0;shared<2;shared++)
    for (volatile int children=0;children<2;children++)
    for (volatile int fail=0;fail<2;fail++)
    for (int repeat=0;repeat<64;repeat++) {
        V first=fwp_rc_fresh(fwp_cstr("first"));
        V last=children?first:fwp_rc_fresh(fwp_cstr("last"));
        if(children) fwp_rc_dup(first);
        V wide=fwp_rc_fresh(fwp_box_i128((i128)123));
        /* The scalar's bits deliberately resemble a counted pointer. */
        V scalar=fwp_rc_fresh(fwp_cstr("scalar bits"));
        conversion_box=fwp_rc_fresh(fwp_record(4,(V[]){first,last,scalar,wide}));
        if(shared) fwp_rc_dup(conversion_box);
        conversion_retains=0;
        if(fail) {
            fwp_trap_recover=conversion_recover; fwp_trap_jb=&conversion_failure;
            fwp_trap_cleanup=fwp_cleanups;
            if(!setjmp(conversion_failure)) { (void)f5(PTR(&callback)); return 211; }
            fwp_trap_recover=0; fwp_trap_jb=0; fwp_trap_cleanup=0;
        } else {
            V result=f1(PTR(&callback));
            if(STR(result)->len!=5||memcmp(STR(result)->d,"first",5))return 212;
            if(*fwp_rc_slot(result)!=(shared?(children?3:2):1))return 213;
            conversion_drop(result);
        }
        if(conversion_retains!=(shared?3u:0u)) {
            fprintf(stderr,"shared=%d children=%d fail=%d retains=%zu\n",shared,children,fail,conversion_retains);
            return 214;
        }
        if(*fwp_rc_slot(scalar)!=1||STR(scalar)->len!=11)return 215;
        conversion_drop(scalar);
        if(shared) {
            if(*fwp_rc_slot(conversion_box)!=1||*fwp_rc_slot(first)!=(children?2:1)||*fwp_rc_slot(wide)!=1)return 216;
            conversion_drop_box(conversion_box);
        }
        conversion_box=0;
        if(fwp_cleanups)return 217;
        if(!collecting&&fwp_gc.budget!=budget)return 218;
    }
    return 0;
}
