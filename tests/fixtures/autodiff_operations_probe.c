static V operation_tuple, operation_outputs, operation_seeds, operation_inputs, operation_parameters;
static int operation_owners, operation_dup_calls, operation_fail;
static jmp_buf operation_recovered;
static int operation_recover(void) { return 1; }
static void operation_point(int point) {
    if (operation_fail == point) fwp_trap("weight transfer control");
}
static V operation_weight(V number) {
    operation_owners++;
    return fwp_rc_fresh(fwp_record(1,&number));
}
static void operation_dup(V value) {
    if (value) { operation_owners++; operation_dup_calls++; fwp_rc_dup(value); }
}
static void operation_drop(V value) {
    if (value) {
        operation_owners--;
        if (fwp_rc_release_last(value)) fwp_rc_free_obj(value);
    }
}

int main(void) {
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    static int round;
    for(round=0;round<32;round++) {
    static fwp_tape_scope scope={-1};static fwp_cleanup scope_owner;
    fwp_cleanup_push(&scope_owner,fwp_tape_scope_release,&scope);
    size_t baseline=fwp_heap.live;
    operation_tuple=fwp_rc_fresh(fwp_record(4,(V[4]){0,0,0,0}));
    operation_outputs=fwp_rc_fresh(fwp_arr_new(1)); operation_seeds=fwp_rc_fresh(fwp_arr_new(1));
    ARR(operation_seeds)->d[0]=fwp_from_f64(1.0);
    const int64_t sizes[]={1,65,4096};
    for (size_t k=0;k<3;k++) {
        int64_t n=sizes[k];
        V base=fwp_p_ad_tape((V)n);
        fwp_tape *t=fwp_tape_of((int64_t)base>>32);
        if (t->cap || t->pa || t->pb || t->da || t->db) return 230;
        OBJ(operation_tuple)->f[0]=base; OBJ(operation_tuple)->f[1]=fwp_from_f64(2.0);
        OBJ(operation_tuple)->f[2]=base+(V)n-1; OBJ(operation_tuple)->f[3]=fwp_from_f64(3.0);
        V node=fwp_p_ad_push(OBJ(operation_tuple)->f[0], OBJ(operation_tuple)->f[1], OBJ(operation_tuple)->f[2], OBJ(operation_tuple)->f[3]);
        if (node!=base+(V)n) return 231;
        OBJ(operation_tuple)->f[0]=node; OBJ(operation_tuple)->f[1]=fwp_from_f64(4.0);
        OBJ(operation_tuple)->f[2]=(V)(int64_t)-1; OBJ(operation_tuple)->f[3]=fwp_from_f64(NAN);
        node=fwp_p_ad_push(OBJ(operation_tuple)->f[0], OBJ(operation_tuple)->f[1], OBJ(operation_tuple)->f[2], OBJ(operation_tuple)->f[3]);
        if (node!=base+(V)n+1 || t->cap!=64 || t->pa[0]!=0 || t->pa[1]!=n || t->pb[0]!=n-1) return 232;
        ARR(operation_outputs)->d[0]=node;
        V result=fwp_rc_fresh(fwp_p_ad_backward(base,operation_outputs,operation_seeds));
        if (ARR(result)->len!=(size_t)n) return 233;
        for (int64_t i=0;i<n;i++) {
            double expected=(i==0?8.0:0.0)+(i==n-1?12.0:0.0);
            if (fwp_f64(ARR(result)->d[i])!=expected) return 234;
        }
        fwp_rc_free_arr(result);
        if(scope.head!=-1)return 242;
        fwp_tape_finish();
    }
    /* Real heap weights transfer without retains. Inject failure before growth,
     * after growth and after storing fields but before publishing the new node. */
    static const fwp_desc element={.kind=K_I64,.dup=operation_dup,.drop=operation_drop};
    operation_parameters=fwp_rc_fresh(fwp_record(4,(V[4]){0,0,0,0}));
    for (int i=0;i<65;i++) operation_inputs=fwp_rc_fresh(fwp_cons(0,operation_inputs));
    V base=fwp_p_ad_tape_owned(operation_parameters,operation_inputs,&element);
    fwp_tape *t=fwp_tape_of((int64_t)base>>32);
    if (t->cap || t->pa || t->pb || t->owned->weights || t->owned->cap) return 235;
    fwp_trap_recover=operation_recover; fwp_trap_jb=&operation_recovered;
    fwp_trap_cleanup=fwp_cleanups;
    for (operation_fail=1;operation_fail<=3;operation_fail++) {
        if (!setjmp(operation_recovered)) {
            V left=operation_weight(1),right=operation_weight(2);
            fwp_p_ad_push_owned(base+64,left,base,right,&element);return 236;
        }
        if(operation_dup_calls)return 243;
        if (strcmp(fwp_trap_msg,"weight transfer control") || operation_owners) return 237;
        if (t->len!=65 || t->owned->len!=65 || fwp_cleanups!=&scope_owner) return 238;
    }
    operation_fail=0;
    /* Inactive and invalid calls consume their weights too. */
    if(fwp_p_ad_push_owned((V)-1,operation_weight(1),(V)-1,operation_weight(2),&element)!=(V)-1
        || operation_owners)return 244;
    if(!setjmp(operation_recovered)) {
        fwp_p_ad_push_owned(base,operation_weight(1),base+(1ULL<<32),operation_weight(2),&element);
        return 245;
    }
    if(strcmp(fwp_trap_msg,FWP_AD_MIXED)||operation_owners)return 246;
    if(!setjmp(operation_recovered)) {
        fwp_p_ad_push_owned(base+65,operation_weight(1),base,operation_weight(2),&element);
        return 245;
    }
    if(strcmp(fwp_trap_msg,FWP_AD_INVALID_NODE)||operation_owners)return 246;
    /* A retained caller alias and two equal weight arguments need three owners. */
    V shared=operation_weight(7);
    operation_dup(shared);operation_dup(shared);operation_dup_calls=0;
    if(fwp_p_ad_push_owned(base+64,shared,base+64,shared,&element)!=base+65)return 239;
    if(operation_dup_calls)return 243;
    if(operation_owners!=3 || OBJ(shared)->f[0]!=7 || t->cap!=64 || t->owned->cap!=64
        || t->owned->weights[0]!=shared || t->owned->weights[1]!=shared)return 240;
    fwp_tape_unlink_scope(t);fwp_tape_retire(t);fwp_tape_finish();
    if(operation_owners!=1 || OBJ(shared)->f[0]!=7)return 247;
    operation_drop(shared);
    if(operation_owners||fwp_owned_tapes||scope.head!=-1||fwp_cleanups!=&scope_owner)return 241;
    while(operation_inputs){V tail=OBJ(operation_inputs)->f[1];fwp_rc_free_obj(operation_inputs);operation_inputs=tail;}
    fwp_rc_free_obj(operation_parameters);fwp_rc_free_obj(operation_tuple);
    fwp_rc_free_arr(operation_outputs);fwp_rc_free_arr(operation_seeds);
    operation_parameters=operation_tuple=operation_outputs=operation_seeds=0;
    fwp_cleanup_pop(&scope_owner);fwp_tape_scope_release(&scope);
    fwp_trap_cleanup=0;fwp_trap_recover=0;fwp_trap_jb=0;
    if(fwp_heap.live!=baseline||fwp_heap.rc_wide_len)return 90;
    }
    puts("input nodes need no operation buffers; managed weight transfer is atomic");
    return 0;
}
