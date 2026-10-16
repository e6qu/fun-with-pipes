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
    fwp_rc_drop(bytes);
    return 0;
}
