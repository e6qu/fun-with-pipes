/* Inject failures after partial vector construction and accumulation. */
static int vector_fail_allocation, vector_fail_arithmetic;
static jmp_buf vector_jump;
static int vector_recover(void) { return 1; }
static void vector_tick(int *left) {
    if (*left && !--*left) fwp_trap("injected vector failure");
}
static V vector_record(size_t n, V *fields) {
    vector_tick(&vector_fail_allocation); return fwp_record(n, fields);
}
static V vector_some(V value) {
    vector_tick(&vector_fail_allocation); return fwp_some(value);
}
static V vector_wrapping(int kind, int op, V x, V y) {
    vector_tick(&vector_fail_arithmetic); return fwp_wrapping(kind, op, x, y);
}
static void vector_box_drop(V value) {
    if (fwp_rc_release_last(value)) fwp_rc_resource_free_obj(value);
}
static const fwp_desc vector_element = {.kind=K_I128, .dup=fwp_rc_dup, .drop=vector_box_drop};
static void vector_array_drop(V value) {
    if (!fwp_rc_release_last(value)) return;
    for(size_t i=0;i<fwp_array_len(value);i++) vector_box_drop(fwp_array_load(value,i,&vector_element));
    fwp_rc_resource_free_arr(value);
}
static void vector_drop(V value) {
    if (!fwp_rc_release_last(value)) return;
    vector_array_drop(OBJ(value)->f[0]); fwp_rc_resource_free_obj(value);
}
int main(void) {
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    V x=fwp_rc_fresh(fwp_from_i128(K_I128,3,"I128",128));
    V vector=fwp_p_simd_splat(x,4,&vector_element);
    V array=OBJ(vector)->f[0];
    for (int trial=0;trial<5;trial++) for(int repeat=0;repeat<32;repeat++) {
        size_t live_bytes=fwp_heap.live;
        vector_fail_allocation=trial<3 ? (trial==2 ? 2 : 1) : 0;
        vector_fail_arithmetic=trial>=3 ? 3 : 0;
        fwp_trap_recover=vector_recover; fwp_trap_jb=&vector_jump;
        fwp_trap_cleanup=fwp_cleanups;
        if (!setjmp(vector_jump)) {
            if(trial==0) (void)fwp_p_simd_splat(x,4,&vector_element);
            else if(trial<3) (void)fwp_p_simd_from_array(array,4,vector_array_drop,vector_drop);
            else if(trial==3) (void)fwp_p_simd_op(K_I128,OP_ADD,vector,vector,"I128",128,&vector_element);
            else (void)fwp_p_simd_sum(K_I128,vector,"I128",128,&vector_element);
            return 247;
        }
        fwp_trap_recover=NULL; fwp_trap_jb=NULL;
        if(fwp_cleanups || fwp_heap.live!=live_bytes) return 248;
        if(!fwp_rc_last(vector) || !fwp_rc_last(array)) return 249;
    }
    vector_drop(vector); vector_box_drop(x);
    return 0;
}
