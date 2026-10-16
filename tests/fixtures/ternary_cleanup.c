static int ternary_remaining;
static jmp_buf ternary_jump;
static int ternary_recover(void) { return 1; }
static V ternary_cons(V value, V tail) {
    if (!--ternary_remaining) fwp_trap("injected ternary allocation failure");
    return fwp_cons(value, tail);
}
static void ternary_drop(V value) {
    while(value && fwp_rc_release_last(value)) {
        V next=OBJ(value)->f[1];
        fwp_rc_resource_free_obj(value);
        value=next;
    }
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns=fwp_fn_table; fwp_init_consts();
    intptr_t initial_budget=fwp_gc.budget;
    V bytes=fwp_rc_fresh(fwp_str_new("abc",3));
    for(int which=0;which<2;which++) for(int repeat=0;repeat<32;repeat++) {
        intptr_t budget=fwp_gc.budget;
        ternary_remaining=4;
        fwp_trap_recover=ternary_recover; fwp_trap_jb=&ternary_jump;
        fwp_trap_cleanup=fwp_cleanups;
        if(!setjmp(ternary_jump)) {
            if(which==0) (void)fwp_p_tint_trits((V)(int64_t)-23,40,ternary_drop);
            else (void)fwp_p_trits_unpack(15,bytes,ternary_drop);
            return 247;
        }
        fwp_trap_recover=NULL; fwp_trap_jb=NULL;
        if(fwp_cleanups || fwp_gc.budget!=budget) return 248;
        if(!fwp_rc_last(bytes)) return 249;
    }
    intptr_t budget=fwp_gc.budget;
    ternary_remaining=-1;
    V digits=fwp_p_tint_trits((V)(int64_t)-23,40,ternary_drop);
    ternary_count_active=1; ternary_allocations=0;
    V packed=fwp_rc_fresh(fwp_p_trits_pack(digits));
    ternary_count_active=0;
    if(ternary_allocations!=1) return 250;
    printf("pack 40 trits: %zu allocation request\n",ternary_allocations);
    ternary_count_active=1; ternary_allocations=0;
    V converted=fwp_rc_fresh(fwp_p_tint_from_trits(digits,40));
    ternary_count_active=0;
    if(ternary_allocations!=1) return 251;
    printf("convert 40 trits: %zu allocation request\n",ternary_allocations);
    if(fwp_rc_release_last(converted)) fwp_rc_resource_free_obj(converted);
    if(fwp_rc_release_last(packed)) fwp_rc_resource_free_obj(packed);
    ternary_drop(digits);
    if(fwp_gc.budget!=budget) return 248;
    if(fwp_rc_release_last(bytes)) fwp_rc_resource_free_obj(bytes);
    if(fwp_gc.budget!=initial_budget) return 248;
    return 0;
}
