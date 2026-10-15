static V operation_tuple, operation_outputs, operation_seeds, operation_inputs, operation_parameters;
static int operation_retains, operation_fail;
static jmp_buf operation_recovered;
static int operation_recover(void) { return 1; }
static void operation_dup(V value) {
    if (value == 2 && operation_fail) fwp_trap("second weight retain control");
    if (value) operation_retains++;
}
static void operation_drop(V value) { if (value) operation_retains--; }

int main(void) {
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns=fwp_fn_table; fwp_init_consts();
    operation_tuple=fwp_record(4,(V[4]){0,0,0,0});
    operation_outputs=fwp_arr_new(1); operation_seeds=fwp_arr_new(1);
    ARR(operation_seeds)->d[0]=fwp_from_f64(1.0);
    const int64_t sizes[]={1,65,4096};
    for (size_t k=0;k<3;k++) {
        int64_t n=sizes[k];
        V base=fwp_p_ad_tape((V)n);
        fwp_tape *t=fwp_tape_of((int64_t)base>>32);
        if (t->cap || t->pa || t->pb || t->da || t->db) return 230;
        OBJ(operation_tuple)->f[0]=base; OBJ(operation_tuple)->f[1]=fwp_from_f64(2.0);
        OBJ(operation_tuple)->f[2]=base+(V)n-1; OBJ(operation_tuple)->f[3]=fwp_from_f64(3.0);
        V node=fwp_p_ad_push(operation_tuple);
        if (node!=base+(V)n) return 231;
        OBJ(operation_tuple)->f[0]=node; OBJ(operation_tuple)->f[1]=fwp_from_f64(4.0);
        OBJ(operation_tuple)->f[2]=(V)(int64_t)-1; OBJ(operation_tuple)->f[3]=fwp_from_f64(NAN);
        node=fwp_p_ad_push(operation_tuple);
        if (node!=base+(V)n+1 || t->cap!=64 || t->pa[0]!=0 || t->pa[1]!=n || t->pb[0]!=n-1) return 232;
        ARR(operation_outputs)->d[0]=node;
        V result=fwp_p_ad_backward(base,operation_outputs,operation_seeds);
        if (ARR(result)->len!=(size_t)n) return 233;
        for (int64_t i=0;i<n;i++) {
            double expected=(i==0?8.0:0.0)+(i==n-1?12.0:0.0);
            if (fwp_f64(ARR(result)->d[i])!=expected) return 234;
        }
        fwp_tape_finish();
    }
    /* Managed inputs also have no metadata. Fail the second actual retain,
     * recover with the tape still live, then successfully reuse its first slot. */
    const fwp_desc element={.kind=K_I64,.dup=operation_dup,.drop=operation_drop};
    operation_parameters=fwp_record(4,(V[4]){0,0,0,0});
    for (int i=0;i<65;i++) operation_inputs=fwp_cons(0,operation_inputs);
    V base=fwp_p_ad_tape_owned(operation_parameters,operation_inputs,&element);
    fwp_tape *t=fwp_tape_of((int64_t)base>>32);
    if (t->cap || t->pa || t->pb || t->owned->weights || t->owned->cap) return 235;
    OBJ(operation_tuple)->f[0]=base+64; OBJ(operation_tuple)->f[1]=1;
    OBJ(operation_tuple)->f[2]=base; OBJ(operation_tuple)->f[3]=2;
    operation_fail=1; fwp_trap_recover=operation_recover; fwp_trap_jb=&operation_recovered;
    fwp_trap_cleanup=fwp_cleanups;
    if (!setjmp(operation_recovered)) { fwp_p_ad_push_owned(operation_tuple,&element);return 236; }
    if (strcmp(fwp_trap_msg,"second weight retain control") || operation_retains) return 237;
    if (t->len!=65 || t->owned->len!=65 || fwp_cleanups) return 238;
    operation_fail=0;
    if (fwp_p_ad_push_owned(operation_tuple,&element)!=base+65 || operation_retains!=2) return 239;
    if (t->cap!=64 || t->owned->cap!=64 || t->owned->weights[0]!=1 || t->owned->weights[1]!=2) return 240;
    fwp_tape_retire(t); fwp_tape_finish();
    if (operation_retains || fwp_owned_tapes || fwp_cleanups) return 241;
    puts("input nodes need no operation buffers; managed weight transfer is atomic");
    return 0;
}
