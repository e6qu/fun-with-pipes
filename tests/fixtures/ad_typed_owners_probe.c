/* A typed-value ledger below language admission lets us count every transfer,
 * including callback aliases. Token identities stand for immutable values;
 * the real runtime still allocates/releases tape buffers and result arrays. */
static int typed_refs[4096], typed_values[4096], typed_next, typed_mode;
static unsigned typed_initial_retains, typed_result_retains, typed_inactive_calls;
static int typed_phase;
static fwp_task typed_task;
static int typed_recover(void) { return 1; }
static void typed_begin(int phase) {
    typed_phase=phase;
    if (phase==2 && typed_mode==7) fwp_trap("injected typed result allocation failure");
}
static void typed_dup(V value) {
    if (!value) return;
    if (value >= 4096 || typed_refs[value] <= 0) exit(187);
    if (typed_phase==2 && typed_result_retains==1) {
        if (typed_mode==6) fwp_trap("injected partial typed result failure");
        if (typed_mode==8) { fwp_cur->cancelled=1; fwp_check_cancel(); }
    }
    typed_refs[value]++;
    if (typed_phase == 1) typed_initial_retains++;
    if (typed_phase == 2) typed_result_retains++;
}
static void typed_drop(V value) {
    if (!value) return;
    if (value >= 4096 || typed_refs[value] <= 0) exit(187);
    typed_refs[value]--;
}
static V typed_new(int value) {
    if (typed_next == 4096) exit(186);
    V token = (V)typed_next++;
    typed_refs[token] = 1; typed_values[token] = value;
    return token;
}
static V typed_add(V *args) {
    if (typed_mode == 1) { typed_dup(args[1]); return args[1]; }
    if (typed_mode == 2) { typed_dup(1); return 1; }
    if (typed_mode == 3) { typed_dup(args[0]); return args[0]; }
    return typed_new(typed_values[args[0]] + typed_values[args[1]]);
}
static V typed_mul(V *args) {
    return typed_new(typed_values[args[0]] * typed_values[args[1]]);
}
static V typed_inactive(V *args) {
    typed_inactive_calls++;
    return typed_values[args[0]] == 0 ? FWP_TRUE : FWP_FALSE;
}
static const fwp_fninfo typed_entries[] = {
    {2, typed_add, "typed add", NULL},
    {2, typed_mul, "typed multiply", NULL},
    {1, typed_inactive, "typed inactive zero", NULL}
};
static fwp_clo typed_callbacks[] = {{0,0}, {1,0}, {2,0}};
static const fwp_desc typed_element = {.kind=K_I64, .dup=typed_dup, .drop=typed_drop};
static void typed_array_drop(V array) {
    for (size_t i=0;i<fwp_array_len(array);i++)
        typed_drop(fwp_array_load(array,i,&typed_element));
    fwp_rc_resource_free_arr(array);
}
static const fwp_desc typed_array = {.elem=&typed_element, .drop=typed_array_drop};
static void typed_cells_drop(V list) {
    while (list) { V next=OBJ(list)->f[1]; fwp_rc_free_obj(list); list=next; }
}
int main(void) {
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    fwp_fns=typed_entries;
    size_t baseline=fwp_heap.live;
    for (int single=0; single<2; single++)
    for (int mode=0; mode<6; mode++) {
        typed_mode=mode; typed_next=3;
        memset(typed_refs,0,sizeof typed_refs); memset(typed_values,0,sizeof typed_values);
        typed_refs[1]=typed_refs[2]=1; typed_values[2]=1;
        typed_initial_retains=typed_result_retains=typed_inactive_calls=0; typed_phase=0;
        int count=mode==4?0:3;
        fwp_tape_scope scope={-1}; fwp_cleanup scope_cleanup;
        fwp_cleanup_push(&scope_cleanup,fwp_tape_scope_release,&scope);
        /* These outer fixtures borrow tokens owned by the external ledger. */
        struct {uint32_t tag,n;V fields[4];} params={0,4,{1,PTR(&typed_callbacks[0]),PTR(&typed_callbacks[1]),PTR(&typed_callbacks[2])}};
        V inputs=0;
        for (int i=0;i<count;i++) inputs=fwp_rc_fresh(fwp_cons(0,inputs));
        V base=fwp_p_ad_tape_owned(PTR(&params),inputs,&typed_element);
        V last=base;
        if (count) {
            typed_dup(2); typed_dup(2);
            last=fwp_p_ad_push_owned(base,2,base,2,&typed_element);
            typed_dup(2); typed_dup(2);
            last=fwp_p_ad_push_owned(last,2,(V)(int64_t)-1,2,&typed_element);
        }
        V outputs=0,seeds=0;
        if (!single && count && mode!=5) {
            for (int i=0;i<2;i++) {
                outputs=fwp_rc_fresh(fwp_cons(last,outputs));
                seeds=fwp_rc_fresh(fwp_cons(2,seeds));
            }
        }
        V result=single
            ? fwp_p_ad_backward_owned_one(base, count && mode!=5 ? last : (V)(int64_t)-1, 2, &typed_array)
            : fwp_p_ad_backward_owned(base,outputs,seeds,&typed_array);
        if (typed_initial_retains || typed_result_retains!=(unsigned)(count?((mode==1||mode==2||mode==5)?3:2):0)) return 181;
        if (typed_inactive_calls!=(unsigned)(count?2:0)) return 182;
        if (fwp_array_len(result)!=(size_t)count) return 183;
        for (int i=0;i<count;i++) {
            int expected=i==0?(mode==0?(single?2:4):mode==3?1:0):0;
            if (typed_values[fwp_array_load(result,(size_t)i,&typed_element)]!=expected) return 183;
        }
        typed_array_drop(result);
        typed_cells_drop(inputs);typed_cells_drop(outputs);typed_cells_drop(seeds);
        fwp_cleanup_pop(&scope_cleanup);fwp_tape_scope_release(&scope);fwp_tape_finish();
        if (fwp_owned_tapes || fwp_cleanups || fwp_heap.live!=baseline || fwp_heap.rc_wide_len) return 184;
        for (int i=1;i<typed_next;i++) if (typed_refs[i]!=(i<3?1:0)) return 188;
        printf("typed owners: mode %d, init retains %u, result retains %u, final delta 0, process peak charged %zu\n",mode,typed_initial_retains,typed_result_retains,fwp_heap.peak);
    }
    for (int single=0; single<2; single++)
    for (volatile int mode=6; mode<9; mode++) {
        typed_mode=mode; typed_next=3;
        memset(typed_refs,0,sizeof typed_refs); memset(typed_values,0,sizeof typed_values);
        typed_refs[1]=typed_refs[2]=1; typed_values[2]=1;
        typed_initial_retains=typed_result_retains=typed_inactive_calls=0; typed_phase=0;
        jmp_buf jump;
        memset(&typed_task,0,sizeof typed_task);
        if (mode==8) { typed_task.base=&jump; fwp_cur=&typed_task; fwp_budget=1000000; }
        fwp_tape_scope scope={-1}; fwp_cleanup scope_cleanup;
        fwp_cleanup_push(&scope_cleanup,fwp_tape_scope_release,&scope);
        struct {uint32_t tag,n;V fields[4];} params={0,4,{1,PTR(&typed_callbacks[0]),PTR(&typed_callbacks[1]),PTR(&typed_callbacks[2])}};
        V inputs=0;
        for (int i=0;i<3;i++) inputs=fwp_rc_fresh(fwp_cons(0,inputs));
        V base=fwp_p_ad_tape_owned(PTR(&params),inputs,&typed_element);
        V outputs=fwp_rc_fresh(fwp_cons(base,0));
        V seeds=fwp_rc_fresh(fwp_cons(2,0));
        fwp_trap_recover=typed_recover; fwp_trap_jb=&jump; fwp_trap_cleanup=0;
        if (!setjmp(jump)) {
            if (single) (void)fwp_p_ad_backward_owned_one(base,base,2,&typed_array);
            else (void)fwp_p_ad_backward_owned(base,outputs,seeds,&typed_array);
            return 185;
        }
        fwp_cur=NULL; fwp_trap_recover=NULL; fwp_trap_jb=NULL;
        if (fwp_cleanups || (mode==8 && !typed_task.unwinding)) return 184;
        typed_cells_drop(inputs); typed_cells_drop(outputs); typed_cells_drop(seeds);
        fwp_tape_finish();
        if (fwp_owned_tapes || fwp_heap.live!=baseline || fwp_heap.rc_wide_len) return 184;
        for (int i=1;i<typed_next;i++) if (typed_refs[i]!=(i<3?1:0)) return 188;
        printf("typed result unwind: mode %d, final delta 0\n",mode);
    }
    return 0;
}
